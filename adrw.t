/* coderw.t - REPLICATION-WRITE TRIGGER FOR ad_mstr TABLE                */
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

TRIGGER PROCEDURE FOR REPLICATION-WRITE OF ad_mstr
   OLD BUFFER OLD_ad_mstr.

   /* RECORD OUTBOUND EVENT. */
   /* By placing quotes around the values passed to the include files, */
   /* we allow for the possibility of sending the value of a variable  */
   /* instead of a literal, something that might be useful in the      */
   /* future.  If instead, we had placed the quotes around the vars,   */
   /* then we could only pass in a literal value.                      */
   
   /* ss - 140723.1 - b */
   /*output to "/home/mfg/arno/adrw.txt".
   put unformat ad_mstr.ad_domain skip.
   output close.*/
   
   def var v_rowid as rowid.
   def var v_oid as char.
   def var v_domain as char.
   def var v_userid as char.
	   v_rowid = rowid(ad_mstr).
	   v_oid = string(ad_mstr.oid_ad_mstr).
	   v_domain = ad_mstr.ad_domain.
	   v_userid = ad_mstr.ad_userid.
   /* ss - 140723.1 - e */
   
/*   {qxotrig.i
      &TABLE-NAME = 'ad_mstr'
      &ROW-ID = string(rowid(ad_mstr))
      &OID = string(ad_mstr.oid_ad_mstr)
      &TRIGGER-TYPE = 'WRITE'}*/

	/* ss - 140723.1 - b */
/*   {mfdeclre.i}
   {gprun.i ""xxqxotrig.p""
		"(input 'ad_mstr',
			input v_rowid,
		  input v_oid,
		  input v_domain,
		  input 'WRITE'
		  )"
   }*/
   def var v_procname as char.
   find first code_mstr where code_domain = v_domain
   	   and code_fldname = "xrcpath"
   	   and code_value = "xrcpath"
   	   no-lock no-error.
   if not avail code_mstr then do:
   		message "Need defind xrcpath in 36.2.13".
   		return.
   	end.
   	
   	v_procname = code_cmmt + "/xxqxotrig01.p".
    run value(v_procname)
    	(input 'ad_mstr',
			 input v_rowid,
		   input v_oid,
		   input v_domain,
		   input v_userid,
		   input 'WRITE'
		   ).
		   
   /* ss - 140723.1 - e */

