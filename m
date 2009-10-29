Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 09:14:37 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:43614 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492055AbZJ2IOa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2009 09:14:30 +0100
Received: by pzk32 with SMTP id 32so1131343pzk.21
        for <multiple recipients>; Thu, 29 Oct 2009 01:14:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9pE0yQdqI4Z2cJxmAx4kGzZohPONxqf4cRcmnj0ybmY=;
        b=op/+SsoNrdHnmnNdPxqrhSDN4BYgixjEDcEfi2lCAs5LABX+v8eGkiLcnIrBTrikN8
         CNokCCZxiRbTxQRc8e6yNhfFLu9BMYcNV2rnpDzXRoZaBvLVb61TXkWC5H5PH2Ff5dYp
         enIoXIbJ+kJsvUC4XsHfUn3g5iVJqCqE9A1cI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=HsDkgGboqhuubRySa3awCmcqka+zZME9mLzUXMf7tGsnZHjyXJH3sQdq0rjFuAR991
         QRCl+sJlSBU/gPwDidn8qa+MfCcADEPiSvqa162dtONWY/VsDxdB7d/XVq4X/oswF04A
         W7+z7s/uQnCSzqm5jecGjPlkuQu8+SKXh8IYo=
Received: by 10.114.2.19 with SMTP id 19mr14638080wab.26.1256804062535;
        Thu, 29 Oct 2009 01:14:22 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm444579pxi.1.2009.10.29.01.14.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 01:14:21 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	GCC Patches <gcc-patches@gcc.gnu.org>
Cc:	linux-mips@linux-mips.org, Adam Nemet <anemet@caviumnetworks.com>,
	rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Add option to pass return address location to _mcount
Date:	Thu, 29 Oct 2009 16:14:05 +0800
Message-Id: <1256804045-31158-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

When we pass -pg -mmcount-ra-address, the address of the return address
relative to sp is passed in $12 to _mcount.  If the return address is not
saved, $12 will be zero. this will work as registers are never saved with an
offset of zero.  $12 is a temporary register that is not part of the ABI.

$12 is also used by libffi closure support, but its use there will not
interfere with _mcount.

2009-10-23  David Daney  <ddaney@caviumnetworks.com>

        * doc/invoke.texi (mmcount-ra-address): Document new command line option.
        * config/mips/mips.opt (config/mips/mips.opt): New option.
        * config/mips/mips-protos.h (mips_function_profiler): Declare new
        function.
        * config/mips/mips.c (struct mips_frame_info): Add ra_fp_offset member.
        (mips_for_each_saved_gpr_and_fpr): Set ra_fp_offset.
        (mips_function_profiler): Moved from FUNCTION_PROFILER, and rewritten.
        * config/mips/mips.h (FUNCTION_PROFILER): Body of macro moved to
        mips_function_profiler.

Tested-by: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 gcc/config/mips/mips-protos.h                      |    1 +
 gcc/config/mips/mips.c                             |   67 +++++++++++++++++++-
 gcc/config/mips/mips.h                             |   39 +-----------
 gcc/config/mips/mips.opt                           |    4 +
 gcc/doc/invoke.texi                                |   22 ++++++-
 gcc/testsuite/gcc.target/mips/mips.exp             |    1 +
 .../gcc.target/mips/mmcount-ra-address-1.c         |    7 ++
 .../gcc.target/mips/mmcount-ra-address-2.c         |    8 +++
 .../gcc.target/mips/mmcount-ra-address-3.c         |   10 +++
 9 files changed, 119 insertions(+), 40 deletions(-)
 create mode 100644 gcc/testsuite/gcc.target/mips/mmcount-ra-address-1.c
 create mode 100644 gcc/testsuite/gcc.target/mips/mmcount-ra-address-2.c
 create mode 100644 gcc/testsuite/gcc.target/mips/mmcount-ra-address-3.c

diff --git a/gcc/config/mips/mips-protos.h b/gcc/config/mips/mips-protos.h
index 429a621..716b7ac 100644
--- a/gcc/config/mips/mips-protos.h
+++ b/gcc/config/mips/mips-protos.h
@@ -344,5 +344,6 @@ extern bool mips_eh_uses (unsigned int);
 extern bool mips_epilogue_uses (unsigned int);
 extern void mips_final_prescan_insn (rtx, rtx *, int);
 extern int mips_trampoline_code_size (void);
+extern void mips_function_profiler (FILE *);
 
 #endif /* ! GCC_MIPS_PROTOS_H */
diff --git a/gcc/config/mips/mips.c b/gcc/config/mips/mips.c
index f82091a..a1229be 100644
--- a/gcc/config/mips/mips.c
+++ b/gcc/config/mips/mips.c
@@ -319,6 +319,9 @@ struct GTY(())  mips_frame_info {
   HOST_WIDE_INT acc_sp_offset;
   HOST_WIDE_INT cop0_sp_offset;
 
+  /* Similar, but the value passed to _mcount.  */
+  HOST_WIDE_INT ra_fp_offset;
+
   /* The offset of arg_pointer_rtx from the bottom of the frame.  */
   HOST_WIDE_INT arg_pointer_offset;
 
@@ -9619,6 +9622,9 @@ mips_for_each_saved_gpr_and_fpr (HOST_WIDE_INT sp_offset,
   for (regno = GP_REG_LAST; regno >= GP_REG_FIRST; regno--)
     if (BITSET_P (cfun->machine->frame.mask, regno - GP_REG_FIRST))
       {
+	/* Record the ra offset for use by mips_function_profiler.  */
+	if (crtl->profile && regno == RETURN_ADDR_REGNUM)
+	  cfun->machine->frame.ra_fp_offset = offset + sp_offset;
 	mips_save_restore_reg (word_mode, regno, offset, fn);
 	offset -= UNITS_PER_WORD;
       }
@@ -16091,7 +16097,66 @@ mips_trampoline_init (rtx m_tramp, tree fndecl, rtx chain_value)
   emit_insn (gen_add3_insn (end_addr, addr, GEN_INT (TRAMPOLINE_SIZE)));
   emit_insn (gen_clear_cache (addr, end_addr));
 }
-
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
+      /* If TARGET_MCOUNT_RA_ADDRESS load $12 with the address of the ra
+       * save location.  */
+      if (cfun->machine->frame.ra_fp_offset == 0)
+	/* ra not saved, pass zero.  */
+	fprintf (file, "\tmove\t%s,%s\n",
+		 reg_names[12], reg_names[0]);
+      else if (SMALL_OPERAND (cfun->machine->frame.ra_fp_offset))
+	fprintf (file,
+		 "\t%s\t%s,%s," HOST_WIDE_INT_PRINT_DEC "\n",
+		 Pmode == DImode ? "daddiu" : "addiu", reg_names[12],
+		 reg_names[STACK_POINTER_REGNUM],
+		 cfun->machine->frame.ra_fp_offset);
+      else
+	fprintf (file, "\t%s\t%s," HOST_WIDE_INT_PRINT_DEC "(%s)",
+                 Pmode == DImode ? "dla" : "la", reg_names[12],
+                 cfun->machine->frame.ra_fp_offset,
+                 reg_names[STACK_POINTER_REGNUM]);
+    }
+  if (!TARGET_NEWABI)
+      fprintf (file,
+	       "\t%s\t%s,%s,%d\t\t# _mcount pops 2 words from  stack\n",
+	       TARGET_64BIT ? "dsubu" : "subu",
+	       reg_names[STACK_POINTER_REGNUM],
+	       reg_names[STACK_POINTER_REGNUM],
+	       Pmode == DImode ? 16 : 8);
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
+
 /* Initialize the GCC target structure.  */
 #undef TARGET_ASM_ALIGNED_HI_OP
 #define TARGET_ASM_ALIGNED_HI_OP "\t.half\t"
diff --git a/gcc/config/mips/mips.h b/gcc/config/mips/mips.h
index 50bc4ea..2829708 100644
--- a/gcc/config/mips/mips.h
+++ b/gcc/config/mips/mips.h
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
diff --git a/gcc/config/mips/mips.opt b/gcc/config/mips/mips.opt
index 8462e46..188d5e1 100644
--- a/gcc/config/mips/mips.opt
+++ b/gcc/config/mips/mips.opt
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
diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
index 4a9ffbf..0e1490e 100644
--- a/gcc/doc/invoke.texi
+++ b/gcc/doc/invoke.texi
@@ -709,7 +709,7 @@ Objective-C and Objective-C++ Dialects}.
 -mbranch-cost=@var{num}  -mbranch-likely  -mno-branch-likely @gol
 -mfp-exceptions -mno-fp-exceptions @gol
 -mvr4130-align -mno-vr4130-align -msynci -mno-synci @gol
--mrelax-pic-calls -mno-relax-pic-calls}
+-mrelax-pic-calls -mno-relax-pic-calls -mmcount-ra-address}
 
 @emph{MMIX Options}
 @gccoptlist{-mlibfuncs  -mno-libfuncs  -mepsilon  -mno-epsilon  -mabi=gnu @gol
@@ -14207,6 +14207,26 @@ an assembler and a linker that supports the @code{.reloc} assembly
 directive and @code{-mexplicit-relocs} is in effect.  With
 @code{-mno-explicit-relocs}, this optimization can be performed by the
 assembler and the linker alone without help from the compiler.
+
+@item -mmcount-ra-address
+@itemx -mno-mcount-ra-address
+@opindex mmcount-ra-address
+@opindex mno-mcount-ra-address
+Allow (do not allow) @code{_mcount} to modify the calling function's
+return address.  When enabled, this option extends the usual @code{_mcount}
+interface with a new @var{ra-address} parameter, which has type
+@code{intptr_t *} and is passed in register @code{$12}.  @code{_mcount}
+can then modify the return address by doing both of the following:
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
diff --git a/gcc/testsuite/gcc.target/mips/mips.exp b/gcc/testsuite/gcc.target/mips/mips.exp
index aef473f..02e031c 100644
--- a/gcc/testsuite/gcc.target/mips/mips.exp
+++ b/gcc/testsuite/gcc.target/mips/mips.exp
@@ -263,6 +263,7 @@ foreach option {
     sym32
     synci
     relax-pic-calls
+    mcount-ra-address
 } {
     lappend mips_option_groups $option "-m(no-|)$option"
 }
diff --git a/gcc/testsuite/gcc.target/mips/mmcount-ra-address-1.c b/gcc/testsuite/gcc.target/mips/mmcount-ra-address-1.c
new file mode 100644
index 0000000..2af802d
--- /dev/null
+++ b/gcc/testsuite/gcc.target/mips/mmcount-ra-address-1.c
@@ -0,0 +1,7 @@
+/* { dg-do compile } */
+/* { dg-options "-O2 -pg -mmcount-ra-address -march=mips64 -mabi=64 -mno-abicalls -msym32" } */
+/* { dg-final { scan-assembler "\tmove\t\\\$12,\\\$0" } } */
+int bazl(int i)
+{
+  return i + 2;
+}
diff --git a/gcc/testsuite/gcc.target/mips/mmcount-ra-address-2.c b/gcc/testsuite/gcc.target/mips/mmcount-ra-address-2.c
new file mode 100644
index 0000000..d1935c8
--- /dev/null
+++ b/gcc/testsuite/gcc.target/mips/mmcount-ra-address-2.c
@@ -0,0 +1,8 @@
+/* { dg-do compile } */
+/* { dg-options "-O2 -pg -mmcount-ra-address -march=mips64 -mabi=64 -mno-abicalls -msym32" } */
+/* { dg-final { scan-assembler "\tdaddiu\t\\\$12,\\\$sp,8" } } */
+int foo (int);
+int bar (int i)
+{
+  return foo (i) + 2;
+}
diff --git a/gcc/testsuite/gcc.target/mips/mmcount-ra-address-3.c b/gcc/testsuite/gcc.target/mips/mmcount-ra-address-3.c
new file mode 100644
index 0000000..0798e04
--- /dev/null
+++ b/gcc/testsuite/gcc.target/mips/mmcount-ra-address-3.c
@@ -0,0 +1,10 @@
+/* { dg-do compile } */
+/* { dg-options "-O2 -pg -mmcount-ra-address -march=mips64 -mabi=64 -mno-abicalls -msym32" } */
+/* { dg-final { scan-assembler "\tdli\t\\\$12,200008" } } */
+/* { dg-final { scan-assembler "\tdaddu\t\\\$12,\\\$12,\\\$sp" } } */
+int foo (int *);
+int bar(int i)
+{
+  int big[50000];
+  return foo (big) + 2;
+}
-- 
1.6.2.1
