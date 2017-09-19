/* coderw.t - REPLICATION-WRITE TRIGGER FOR code_mstr TABLE                */
/* Copyright 2004 QAD Inc. All rights reserved.                               */
/* $Revision: 1.10 $                                                        */
/*                                                                         */
/* This trigger code is executed on replication-write event for the table. */
/*                                                                         */
/* Revision: 1.8  BY: Phil Dunn (SB) DATE: 06/30/03 ECO: *M1D6* */
/* Revision: 1.8  BY: Phil Dunn (SB) DATE: 06/30/03 ECO: *Q008* */
/* Revision: 1.9  BY: Auto Generated (lwp) DATE: 11/27/03 ECO: *Q04J*      */
/* Revision: 1.10  BY: Ken Casey DATE: 02/22/05 ECO: *P38T*                   */
/* $Revision$     BY: Chi Liu              DATE: 10/26/07 ECO: *P6BR*      */
/*-Revision end------------------------------------------------------------*/


/*V8:ConvertMode=NoConvert*/

TRIGGER PROCEDURE FOR REPLICATION-WRITE OF code_mstr
   OLD BUFFER OLD_code_mstr.

   /* RECORD OUTBOUND EVENT. */
   /* By placing quotes around the values passed to the include files, */
   /* we allow for the possibility of sending the value of a variable  */
   /* instead of a literal, something that might be useful in the      */
   /* future.  If instead, we had placed the quotes around the vars,   */
   /* then we could only pass in a literal value.                      */
   
   /* ss - 140723.1 - b */
   def var v_rowid as rowid.
   def var v_oid as char.
   def var v_domain as char.
	   v_rowid = rowid(code_mstr).
	   v_oid = string(code_mstr.oid_code_mstr).
	   v_domain = code_mstr.code_domain.
   /* ss - 140723.1 - e */
   
   {qxotrig.i
      &TABLE-NAME = 'code_mstr'
      &ROW-ID = string(rowid(code_mstr))
      &OID = string(code_mstr.oid_code_mstr)
      &TRIGGER-TYPE = 'WRITE'}

	/* ss - 140723.1 - b */
   {mfdeclre.i}
   {gprun.i ""xxqxotrig.p""
		"(input 'code_mstr',
			input v_rowid,
		  input v_oid,
		  input v_domain,
		  input 'WRITE'
		  )"
   }
   /* ss - 140723.1 - e */

