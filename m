Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 19:11:12 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4658 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493511AbZJ2SLF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2009 19:11:05 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ae9dab50000>; Thu, 29 Oct 2009 11:11:01 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 29 Oct 2009 11:11:02 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 29 Oct 2009 11:11:02 -0700
Message-ID: <4AE9DAB6.4090307@caviumnetworks.com>
Date:	Thu, 29 Oct 2009 11:11:02 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>,
	GCC Patches <gcc-patches@gcc.gnu.org>,
	linux-mips@linux-mips.org, wuzhangjin@gmail.com,
	Adam Nemet <anemet@caviumnetworks.com>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH] MIPS: Add option to pass return address location to _mcount.
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com> 	<2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com> 	<3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com> 	<ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com> 	<1256138686.18347.3039.camel@gandalf.stny.rr.com> 	<1256233679.23653.7.camel@falcon> 	<4AE0A5BE.8000601@caviumnetworks.com> <87y6n36plp.fsf@firetop.home> 	<4AE232AD.4050308@caviumnetworks.com> <87my3htau1.fsf@firetop.home> 	<4AE5F392.5020405@caviumnetworks.com> <87ljiwr0t9.fsf@firetop.home>
In-Reply-To: <87ljiwr0t9.fsf@firetop.home>
Content-Type: multipart/mixed;
 boundary="------------010202040909000307020004"
X-OriginalArrivalTime: 29 Oct 2009 18:11:02.0441 (UTC) FILETIME=[2CA5C990:01CA58C3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010202040909000307020004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Richard Sandiford wrote:
> David Daney <ddaney@caviumnetworks.com> writes:
>>> Looks good otherwise, but I'd be interested in other suggestions for
>>> the option name.  I kept misreading "raloc" as a typo for "reloc".
>> Well how about raaddr?  (Return-Address Address)
> 
> Taking Wu Zhangjin's suggestion of an extra dash, how about
> -mmcount-ra-address?
> 

Right.


>> +@option{-mmcount-raaddr} can be used in conjunction with @option{-pg}
>> +and a specially coded @code{_mcount} function to record function exit
> 
> Doc conventions require "specially-coded", I think.  We should
> mention the $12 register too, and the treatment of leaf functions.
> How about:
> 
> --------------------------
> Allow (do not allow) @code{_mcount} to modify the calling function's
> return address.  When enabled, this option extends the usual @code{_mcount}
> interface with a new @var{ra-address} parameter, which has type
> @code{intptr_t *} and is passed in register @code{$12}.  @code{_mcount}
> can then modify the return address by doing both of the following:
> @itemize
> @item
> Returning the new address in register @code{$31}.
> @item
> Storing the new address in @code{*@var{ra-address}},
> if @var{ra-address} is nonnull.
> @end @itemize
> 
> The default is @option{-mno-mcount-ra-address}.
> --------------------------

Ok.  I took a couple of liberties, but used essentially what you suggest.

> 
>> +/* { dg-do compile } */
>> +/* { dg-options "-O2 -pg -mmcount-raaddr -march=mips64 -mabi=64 -mno-abicalls -msym32" } */
> 
> This is a general feature, so I'd rather test with as few special options
> as possible.  Just "-O2 -pg" if we can.  Same with the other tests.
> 

As discussed in the other branch of the thread, I now use "-O2 -pg 
-mmcount-raaddr -mabi=64"


> Sorry to ask, but while you're here, would you mind fixing a couple
> of pre-existing formatting problems too?  Namely:
> 
>> +      /*  For TARGET_LONG_CALLS use $3 for the address of _mcount.  */
> 
> Only one space for "For" and
> 
>> +  if (!TARGET_NEWABI)
>> +    {
>> +      fprintf (file,
>> +	       "\t%s\t%s,%s,%d\t\t# _mcount pops 2 words from  stack\n",
>> +	       TARGET_64BIT ? "dsubu" : "subu",
>> +	       reg_names[STACK_POINTER_REGNUM],
>> +	       reg_names[STACK_POINTER_REGNUM],
>> +	       Pmode == DImode ? 16 : 8);
>> +    }
> 
> No braces here.

OK.

> 
> As far as the new bits are concerned:
> 
>> +      /* If TARGET_MCOUNT_RAADDR load $12 with the address of the ra save
>> +	 location.  */
>> +      if (cfun->machine->frame.ra_fp_offset == 0)
>> +	/* ra not saved, pass zero.  */
>> +	fprintf (file, "\tmove\t%s,%s\t\t# address of ra\n",
>> +		 reg_names[12], reg_names[0]);
> 
> Let's drop the "# address of ra" comment.  We don't add comments to
> the other bits.
> 

OK.

> Everything in the following block:
> 
>> +      else if (SMALL_OPERAND (cfun->machine->frame.ra_fp_offset))
>> +	fprintf (file,
>> +		 "\t%s\t%s,%s," HOST_WIDE_INT_PRINT_DEC "\t\t# address of ra\n",
>> +		 Pmode == DImode ? "daddiu" : "addiu",
>> +		 reg_names[12], reg_names[STACK_POINTER_REGNUM],
>> +		 cfun->machine->frame.ra_fp_offset);
>> +      else
>> +	{
>> +	  fprintf (file,
>> +		   "\t%s\t%s," HOST_WIDE_INT_PRINT_DEC "\n",
>> +		   Pmode == DImode ? "dli" : "li",
>> +		   reg_names[12],
>> +		   cfun->machine->frame.ra_fp_offset);
>> +	  fprintf (file, "\t%s\t%s,%s,%s\t\t# address of ra\n",
>> +		   Pmode == DImode ? "daddu" : "addu",
>> +		   reg_names[12], reg_names[12],
>> +		   reg_names[STACK_POINTER_REGNUM]);
>> +	}
> 
> reduces to:
> 
>       else
> 	fprintf (file, "\t%s\t%s," HOST_WIDE_INT_PRINT_DEC "(%s)",
> 		 Pmode == DImode ? "dla" : "la", reg_names[12],
> 		 cfun->machine->frame.ra_fp_offset,
> 		 reg_names[STACK_POINTER_REGNUM]);
> 

Right.  I had not realized the the assembler was so 'smart'.


> OK with those changes, thanks, if it passing testing, and if
> Ralf is happy with the linux side.
> 

No regressions, and discussed with Ralf.2009-10-29  David Daney 
<ddaney@caviumnetworks.com>

	* doc/invoke.texi (mmcount-ra-address): Document new command line
	option.
	* config/mips/mips.opt (mmcount-ra-address): New option.
	* config/mips/mips-protos.h (mips_function_profiler): Declare new
	function.
	* config/mips/mips.c (struct mips_frame_info): Add ra_fp_offset
	member.
	(mips_for_each_saved_gpr_and_fpr): Set ra_fp_offset.
	(mips_function_profiler): Moved from FUNCTION_PROFILER, and
	rewritten.
	* config/mips/mips.h (FUNCTION_PROFILER): Body of macro moved to
	mips_function_profiler.

2009-10-29  David Daney  <ddaney@caviumnetworks.com>

	* gcc.target/mips/mips.exp (mips_option_groups): Add
	mcount-ra-address.
	* gcc.target/mips/mmcount-ra-address-1.c: New test.
	* gcc.target/mips/mmcount-ra-address-2.c: New test.
	* gcc.target/mips/mmcount-ra-address-3.c: New test.


FWIW, this is the version I committed:



--------------010202040909000307020004
Content-Type: text/plain;
 name="mcount.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mcount.patch"

Index: gcc/doc/invoke.texi
===================================================================
--- gcc/doc/invoke.texi	(revision 153716)
+++ gcc/doc/invoke.texi	(working copy)
@@ -709,7 +709,7 @@ Objective-C and Objective-C++ Dialects}.
 -mbranch-cost=@var{num}  -mbranch-likely  -mno-branch-likely @gol
 -mfp-exceptions -mno-fp-exceptions @gol
 -mvr4130-align -mno-vr4130-align -msynci -mno-synci @gol
--mrelax-pic-calls -mno-relax-pic-calls}
+-mrelax-pic-calls -mno-relax-pic-calls -mmcount-ra-address}
 
 @emph{MMIX Options}
 @gccoptlist{-mlibfuncs  -mno-libfuncs  -mepsilon  -mno-epsilon  -mabi=gnu @gol
@@ -14208,6 +14208,27 @@ an assembler and a linker that supports 
 directive and @code{-mexplicit-relocs} is in effect.  With
 @code{-mno-explicit-relocs}, this optimization can be performed by the
 assembler and the linker alone without help from the compiler.
+
+@item -mmcount-ra-address
+@itemx -mno-mcount-ra-address
+@opindex mmcount-ra-address
+@opindex mno-mcount-ra-address
+Emit (do not emit) code that allows @code{_mcount} to modify the
+colling function's return address.  When enabled, this option extends
+the usual @code{_mcount} interface with a new @var{ra-address}
+parameter, which has type @code{intptr_t *} and is passed in register
+@code{$12}.  @code{_mcount} can then modify the return address by
+doing both of the following:
+@itemize
+@item
+Returning the new address in register @code{$31}.
+@item
+Storing the new address in @code{*@var{ra-address}},
+if @var{ra-address} is nonnull.
+@end itemize
+
+The default is @option{-mno-mcount-ra-address}.
+
 @end table
 
 @node MMIX Options
Index: gcc/testsuite/gcc.target/mips/mips.exp
===================================================================
--- gcc/testsuite/gcc.target/mips/mips.exp	(revision 153716)
+++ gcc/testsuite/gcc.target/mips/mips.exp	(working copy)
@@ -263,6 +263,7 @@ foreach option {
     sym32
     synci
     relax-pic-calls
+    mcount-ra-address
 } {
     lappend mips_option_groups $option "-m(no-|)$option"
 }
Index: gcc/testsuite/gcc.target/mips/mmcount-ra-address-1.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mmcount-ra-address-1.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mmcount-ra-address-1.c	(revision 0)
@@ -0,0 +1,7 @@
+/* { dg-do compile } */
+/* { dg-options "-O2 -pg -mmcount-ra-address -mabi=64" } */
+/* { dg-final { scan-assembler "\tmove\t\\\$12,\\\$0" } } */
+int bazl(int i)
+{
+  return i + 2;
+}
Index: gcc/testsuite/gcc.target/mips/mmcount-ra-address-2.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mmcount-ra-address-2.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mmcount-ra-address-2.c	(revision 0)
@@ -0,0 +1,8 @@
+/* { dg-do compile } */
+/* { dg-options "-O2 -pg -mmcount-ra-address -mabi=64" } */
+/* { dg-final { scan-assembler "\tdla\t\\\$12,8\\(\\\$sp\\)" } } */
+int foo (int);
+int bar (int i)
+{
+  return foo (i) + 2;
+}
Index: gcc/testsuite/gcc.target/mips/mmcount-ra-address-3.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mmcount-ra-address-3.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mmcount-ra-address-3.c	(revision 0)
@@ -0,0 +1,9 @@
+/* { dg-do compile } */
+/* { dg-options "-O2 -pg -mmcount-ra-address -mabi=64" } */
+/* { dg-final { scan-assembler "\tdla\t\\\$12,200008\\(\\\$sp\\)" } } */
+int foo (int *);
+int bar(int i)
+{
+  int big[50000];
+  return foo (big) + 2;
+}
Index: gcc/config/mips/mips.opt
===================================================================
--- gcc/config/mips/mips.opt	(revision 153716)
+++ gcc/config/mips/mips.opt	(working copy)
@@ -208,6 +208,10 @@ mlong64
 Target Report RejectNegative Mask(LONG64)
 Use a 64-bit long type
 
+mmcount-ra-address
+Target Report Var(TARGET_MCOUNT_RA_ADDRESS)
+Pass the address of the ra save location to _mcount in $12
+
 mmemcpy
 Target Report Mask(MEMCPY)
 Don't optimize block moves
Index: gcc/config/mips/mips-protos.h
===================================================================
--- gcc/config/mips/mips-protos.h	(revision 153716)
+++ gcc/config/mips/mips-protos.h	(working copy)
@@ -344,5 +344,6 @@ extern bool mips_eh_uses (unsigned int);
 extern bool mips_epilogue_uses (unsigned int);
 extern void mips_final_prescan_insn (rtx, rtx *, int);
 extern int mips_trampoline_code_size (void);
+extern void mips_function_profiler (FILE *);
 
 #endif /* ! GCC_MIPS_PROTOS_H */
Index: gcc/config/mips/mips.c
===================================================================
--- gcc/config/mips/mips.c	(revision 153716)
+++ gcc/config/mips/mips.c	(working copy)
@@ -319,6 +319,9 @@ struct GTY(())  mips_frame_info {
   HOST_WIDE_INT acc_sp_offset;
   HOST_WIDE_INT cop0_sp_offset;
 
+  /* Similar, but the value passed to _mcount.  */
+  HOST_WIDE_INT ra_fp_offset;
+
   /* The offset of arg_pointer_rtx from the bottom of the frame.  */
   HOST_WIDE_INT arg_pointer_offset;
 
@@ -9666,6 +9669,9 @@ mips_for_each_saved_gpr_and_fpr (HOST_WI
   for (regno = GP_REG_LAST; regno >= GP_REG_FIRST; regno--)
     if (BITSET_P (cfun->machine->frame.mask, regno - GP_REG_FIRST))
       {
+	/* Record the ra offset for use by mips_function_profiler.  */
+	if (regno == RETURN_ADDR_REGNUM)
+	  cfun->machine->frame.ra_fp_offset = offset + sp_offset;
 	mips_save_restore_reg (word_mode, regno, offset, fn);
 	offset -= UNITS_PER_WORD;
       }
@@ -16138,6 +16144,59 @@ mips_trampoline_init (rtx m_tramp, tree 
   emit_insn (gen_add3_insn (end_addr, addr, GEN_INT (TRAMPOLINE_SIZE)));
   emit_insn (gen_clear_cache (addr, end_addr));
 }
+
+/* Implement FUNCTION_PROFILER.  */
+
+void mips_function_profiler (FILE *file)
+{
+  if (TARGET_MIPS16)
+    sorry ("mips16 function profiling");
+  if (TARGET_LONG_CALLS)
+    {
+      /* For TARGET_LONG_CALLS use $3 for the address of _mcount.  */
+      if (Pmode == DImode)
+	fprintf (file, "\tdla\t%s,_mcount\n", reg_names[3]);
+      else
+	fprintf (file, "\tla\t%s,_mcount\n", reg_names[3]);
+    }
+  mips_push_asm_switch (&mips_noat);
+  fprintf (file, "\tmove\t%s,%s\t\t# save current return address\n",
+	   reg_names[AT_REGNUM], reg_names[RETURN_ADDR_REGNUM]);
+  /* _mcount treats $2 as the static chain register.  */
+  if (cfun->static_chain_decl != NULL)
+    fprintf (file, "\tmove\t%s,%s\n", reg_names[2],
+	     reg_names[STATIC_CHAIN_REGNUM]);
+  if (TARGET_MCOUNT_RA_ADDRESS)
+    {
+      /* If TARGET_MCOUNT_RA_ADDRESS load $12 with the address of the
+	 ra save location.  */
+      if (cfun->machine->frame.ra_fp_offset == 0)
+	/* ra not saved, pass zero.  */
+	fprintf (file, "\tmove\t%s,%s\n", reg_names[12], reg_names[0]);
+      else
+	fprintf (file, "\t%s\t%s," HOST_WIDE_INT_PRINT_DEC "(%s)\n",
+		 Pmode == DImode ? "dla" : "la", reg_names[12],
+		 cfun->machine->frame.ra_fp_offset,
+		 reg_names[STACK_POINTER_REGNUM]);
+    }
+  if (!TARGET_NEWABI)
+    fprintf (file,
+	     "\t%s\t%s,%s,%d\t\t# _mcount pops 2 words from  stack\n",
+	     TARGET_64BIT ? "dsubu" : "subu",
+	     reg_names[STACK_POINTER_REGNUM],
+	     reg_names[STACK_POINTER_REGNUM],
+	     Pmode == DImode ? 16 : 8);
+
+  if (TARGET_LONG_CALLS)
+    fprintf (file, "\tjalr\t%s\n", reg_names[3]);
+  else
+    fprintf (file, "\tjal\t_mcount\n");
+  mips_pop_asm_switch (&mips_noat);
+  /* _mcount treats $2 as the static chain register.  */
+  if (cfun->static_chain_decl != NULL)
+    fprintf (file, "\tmove\t%s,%s\n", reg_names[STATIC_CHAIN_REGNUM],
+	     reg_names[2]);
+}
 
 /* Initialize the GCC target structure.  */
 #undef TARGET_ASM_ALIGNED_HI_OP
Index: gcc/config/mips/mips.h
===================================================================
--- gcc/config/mips/mips.h	(revision 153716)
+++ gcc/config/mips/mips.h	(working copy)
@@ -2372,44 +2372,7 @@ typedef struct mips_args {
 /* Output assembler code to FILE to increment profiler label # LABELNO
    for profiling a function entry.  */
 
-#define FUNCTION_PROFILER(FILE, LABELNO)				\
-{									\
-  if (TARGET_MIPS16)							\
-    sorry ("mips16 function profiling");				\
-  if (TARGET_LONG_CALLS)						\
-    {									\
-      /*  For TARGET_LONG_CALLS use $3 for the address of _mcount.  */	\
-      if (Pmode == DImode)						\
-	fprintf (FILE, "\tdla\t%s,_mcount\n", reg_names[GP_REG_FIRST + 3]); \
-      else								\
-	fprintf (FILE, "\tla\t%s,_mcount\n", reg_names[GP_REG_FIRST + 3]); \
-    }									\
-  mips_push_asm_switch (&mips_noat);					\
-  fprintf (FILE, "\tmove\t%s,%s\t\t# save current return address\n",	\
-	   reg_names[AT_REGNUM], reg_names[RETURN_ADDR_REGNUM]);	\
-  /* _mcount treats $2 as the static chain register.  */		\
-  if (cfun->static_chain_decl != NULL)					\
-    fprintf (FILE, "\tmove\t%s,%s\n", reg_names[2],			\
-	     reg_names[STATIC_CHAIN_REGNUM]);				\
-  if (!TARGET_NEWABI)							\
-    {									\
-      fprintf (FILE,							\
-	       "\t%s\t%s,%s,%d\t\t# _mcount pops 2 words from  stack\n", \
-	       TARGET_64BIT ? "dsubu" : "subu",				\
-	       reg_names[STACK_POINTER_REGNUM],				\
-	       reg_names[STACK_POINTER_REGNUM],				\
-	       Pmode == DImode ? 16 : 8);				\
-    }									\
-  if (TARGET_LONG_CALLS)						\
-    fprintf (FILE, "\tjalr\t%s\n", reg_names[GP_REG_FIRST + 3]);	\
-  else									\
-    fprintf (FILE, "\tjal\t_mcount\n");					\
-  mips_pop_asm_switch (&mips_noat);					\
-  /* _mcount treats $2 as the static chain register.  */		\
-  if (cfun->static_chain_decl != NULL)					\
-    fprintf (FILE, "\tmove\t%s,%s\n", reg_names[STATIC_CHAIN_REGNUM],	\
-	     reg_names[2]);						\
-}
+#define FUNCTION_PROFILER(FILE, LABELNO) mips_function_profiler ((FILE))
 
 /* The profiler preserves all interesting registers, including $31.  */
 #define MIPS_SAVE_REG_FOR_PROFILING_P(REGNO) false

--------------010202040909000307020004--
