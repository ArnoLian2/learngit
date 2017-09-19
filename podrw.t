/* podrw.t - REPLICATION-WRITE TRIGGER FOR pod_det TABLE                   */
/* Copyright 2004 QAD Inc. All rights reserved.                               */
/* $Revision: 1.5 $                                                        */
/*                                                                         */
/* This trigger code is executed on replication-write event for the table. */
/*                                                                         */
/* Revision: 1.4  BY: Auto Generated (lwp) DATE: 11/27/03 ECO: *Q04J*      */
/* Revision: 1.5  BY: Ken Casey DATE: 02/22/05 ECO: *P38T*                   */
/* $Revision$     BY: Chi Liu              DATE: 10/26/07 ECO: *P6BR*      */
/*-Revision end------------------------------------------------------------*/


/*V8:ConvertMode=NoConvert*/

TRIGGER PROCEDURE FOR REPLICATION-WRITE OF pod_det
   OLD BUFFER OLD_pod_det.
  
   /* ss - 140723.1 - b */
   def var v_rowid as rowid.
   def var v_oid as char.
   def var v_domain as char.
	   v_rowid = rowid(pod_det).
	   v_oid = string(pod_det.oid_pod_det).
	   v_domain = pod_det.pod_domain.
   /* ss - 140723.1 - e */

   /* RECORD OUTBOUND EVENT. */
   /* By placing quotes around the values passed to the include files, */
   /* we allow for the possibility of sending the value of a variable  */
   /* instead of a literal, something that might be useful in the      */
   /* future.  If instead, we had placed the quotes around the vars,   */
   /* then we could only pass in a literal value.                      */
   {qxotrig.i
      &TABLE-NAME = 'pod_det'
      &ROW-ID = string(rowid(pod_det))
      &OID = string(pod_det.oid_pod_det)
      &TRIGGER-TYPE = 'WRITE'}

   /* ss - 140723.1 - b */
   /*just sync the pod_cum_qty to srm in real time*/
   {mfdeclre.i}
	
   /*if the old pod_cum_qty is not eqaul to new pod_cum_qty, sync the value to srm*/
   if(pod_det.pod_cum_qty[1] <> OLD_pod_det.pod_cum_qty[1]) then do:
	   {gprun.i ""xxqxotrig.p""
			"(input 'pod_det',
			  input v_rowid,
			  input v_oid,
			  input v_domain,
			  input 'WRITE'
			  )"
	   }
   end.
   /* ss - 140723.1 - e */
