Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2G2ZZB24715
	for linux-mips-outgoing; Thu, 15 Mar 2001 18:35:35 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.225])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2G2ZIM24710
	for <linux-mips@oss.sgi.com>; Thu, 15 Mar 2001 18:35:33 -0800
Received: from drow by nevyn.them.org with local (Exim 3.22 #1 (Debian))
	id 14dk4u-0001sQ-00
	for <linux-mips@oss.sgi.com>; Thu, 15 Mar 2001 21:34:56 -0500
Date: Thu, 15 Mar 2001 21:34:56 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-mips@oss.sgi.com
Subject: -mmad patches for binutils/gcc
Message-ID: <20010315213456.A7042@nevyn.them.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Before I try to submit these to the FSF, I thought I'd post them here for
comments.

These patches change one small thing in gcc (%{mmad:-m4650} becomes %{mmad}
in the invocation of GAS; we no longer lie about what the processor is) and
add a -mmad flag to binutils.

I was able to build an IVR kernel with these changes; ext2_statfs,
get_pci_port, and vc_resize got one piddling mad instruction each, and
nfs_xdr_statfsres got half a dozen.  Nothing to write home about, but it's
the principal of the thing.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
Monta Vista Software                              Debian Security Team
                         "I am croutons!"

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="binutils-mips-mad.patch"

diff -uNr binutils-2.10.91.0.2.orig/gas/ChangeLog binutils-2.10.91.0.2/gas/ChangeLog
--- binutils-2.10.91.0.2.orig/gas/ChangeLog	Wed Feb 14 02:22:36 2001
+++ binutils-2.10.91.0.2/gas/ChangeLog	Thu Mar 15 18:18:32 2001
@@ -1,3 +1,12 @@
+2001-03-15  Daniel Jacobowitz <djacobowitz@mvista.com>
+
+	* config/tc-mips.c (struct mips_set_options): Add mad4650 member.
+	(mips_opts): Initialize it.
+	(macro_build): Add mad4650 argument to OPCODE_IS_MEMBER.
+	(mips_ip): Likewise.
+	(md_longopts[]): Add -mmad option.
+	(md_parse_option): Handle -mmad option.
+
 2001-02-13  Jim Wilson  <wilson@redhat.com>
 
 	* config/tc-ia64.c (operand_match, case TAG13): Make a BFD_RELOC_UNUSED
diff -uNr binutils-2.10.91.0.2.orig/gas/config/tc-mips.c binutils-2.10.91.0.2/gas/config/tc-mips.c
--- binutils-2.10.91.0.2.orig/gas/config/tc-mips.c	Sun Feb 11 19:48:25 2001
+++ binutils-2.10.91.0.2/gas/config/tc-mips.c	Thu Mar 15 18:31:41 2001
@@ -185,15 +185,17 @@
   /* Non-zero if we should not autoextend mips16 instructions.
      Changed by `.set autoextend' and `.set noautoextend'.  */
   int noautoextend;
+  /* Non-zero if we should allow 4650-style mad instructions. */
+  int mad4650;
 };
 
 /* This is the struct we use to hold the current set of options.  Note
-   that we must set the isa field to ISA_UNKNOWN and the mips16 field to
-   -1 to indicate that they have not been initialized.  */
+   that we must set the isa field to ISA_UNKNOWN and the mips16 and
+   mad4650 fields to -1 to indicate that they have not been initialized.  */
 
 static struct mips_set_options mips_opts =
 {
-  ISA_UNKNOWN, -1, 0, 0, 0, 0, 0, 0
+  ISA_UNKNOWN, -1, 0, 0, 0, 0, 0, 0, -1
 };
 
 /* These variables are filled in with the masks of registers used.
@@ -994,6 +996,14 @@
       a = NULL;
     }
 
+  if (mips_opts.mad4650 == -1)
+    {
+      if (mips_cpu == CPU_R4650)
+        mips_opts.mad4650 = 1;
+      else
+        mips_opts.mad4650 = 0;
+    }
+
   if (mips_opts.isa == ISA_MIPS1 && mips_trap)
     as_bad (_("trap exception not supported at ISA 1"));
 
@@ -2482,7 +2492,7 @@
       if (strcmp (fmt, insn.insn_mo->args) == 0
 	  && insn.insn_mo->pinfo != INSN_MACRO
 	  && OPCODE_IS_MEMBER (insn.insn_mo, mips_opts.isa, mips_cpu,
-			       mips_gp32)
+			       mips_gp32, mips_opts.mad4650)
 	  && (mips_cpu != CPU_R4650 || (insn.insn_mo->pinfo & FP_D) == 0))
 	break;
 
@@ -7065,7 +7075,8 @@
 
       assert (strcmp (insn->name, str) == 0);
 
-      if (OPCODE_IS_MEMBER (insn, mips_opts.isa, mips_cpu, mips_gp32))
+      if (OPCODE_IS_MEMBER (insn, mips_opts.isa, mips_cpu, mips_gp32,
+			    mips_opts.mad4650))
 	ok = true;
       else
 	ok = false;
@@ -8912,6 +8923,10 @@
   {"mips5", no_argument, NULL, OPTION_MIPS5},
 #define OPTION_MIPS64 (OPTION_MD_BASE + 30)
   {"mips64", no_argument, NULL, OPTION_MIPS64},
+#define OPTION_MMAD (OPTION_MD_BASE + 31)
+  {"mmad", no_argument, NULL, OPTION_MMAD},
+#define OPTION_NO_MMAD (OPTION_MD_BASE + 32)
+  {"no-mmad", no_argument, NULL, OPTION_NO_MMAD},
 #ifdef OBJ_ELF
 #define OPTION_ELF_BASE    (OPTION_MD_BASE + 35)
 #define OPTION_CALL_SHARED (OPTION_ELF_BASE + 0)
@@ -9032,6 +9047,14 @@
       break;
 
     case OPTION_NO_M4650:
+      break;
+
+    case OPTION_MMAD:
+      mips_opts.mad4650 = 1;
+      break;
+
+    case OPTION_NO_MMAD:
+      mips_opts.mad4650 = 0;
       break;
 
     case OPTION_M4010:
diff -uNr binutils-2.10.91.0.2.orig/gas/doc/c-mips.texi binutils-2.10.91.0.2/gas/doc/c-mips.texi
--- binutils-2.10.91.0.2.orig/gas/doc/c-mips.texi	Thu Dec 21 19:35:13 2000
+++ binutils-2.10.91.0.2/gas/doc/c-mips.texi	Thu Mar 15 18:27:27 2001
@@ -108,9 +108,16 @@
 @item -m4650
 @itemx -no-m4650
 Generate code for the MIPS @sc{r4650} chip.  This tells the assembler to accept
-the @samp{mad} and @samp{madu} instruction, and to not schedule @samp{nop}
-instructions around accesses to the @samp{HI} and @samp{LO} registers.
-@samp{-no-m4650} turns off this option.
+the @samp{mad} and @samp{madu} instructions, to not allow double-precision
+float instructions, and to not schedule @samp{nop} instructions around accesses
+to the @samp{HI} and @samp{LO} registers.  @samp{-no-m4650} turns off this
+option.
+
+@item -mmad
+@itemx -no-mad
+Generate code for the MIPS @sc{r4650} @samp{mad} and @samp{madu}
+instructions, without the other restrictions of the @sc{r4650}.
+@samp{-no-mmad} turns off support for these instructions.
 
 @itemx -m3900
 @itemx -no-m3900
diff -uNr binutils-2.10.91.0.2.orig/include/opcode/ChangeLog binutils-2.10.91.0.2/include/opcode/ChangeLog
--- binutils-2.10.91.0.2.orig/include/opcode/ChangeLog	Mon Feb 12 18:47:34 2001
+++ binutils-2.10.91.0.2/include/opcode/ChangeLog	Thu Mar 15 18:14:24 2001
@@ -1,3 +1,7 @@
+Thu Mar 15 18:13:01 EST 2001  Daniel Jacobowitz <djacobowitz@mvista.com>
+
+	* mips.h (OPCODE_IS_MEMBER): Add mad4650 argument.
+
 Mon Feb 12 17:40:54 CET 2001  Jan Hubicka  <jh@suse.cz>
 
 	* i386.h (i386_optab): SSE integer converison instructions have
diff -uNr binutils-2.10.91.0.2.orig/include/opcode/mips.h binutils-2.10.91.0.2/include/opcode/mips.h
--- binutils-2.10.91.0.2.orig/include/opcode/mips.h	Sat Feb 10 18:37:00 2001
+++ binutils-2.10.91.0.2/include/opcode/mips.h	Thu Mar 15 18:13:06 2001
@@ -369,12 +369,13 @@
    to test, or zero if no CPU specific ISA test is desired.
    The gp32 arg is set when you need to force 32-bit register usage on
    a machine with 64-bit registers; see the documentation under -mgp32
-   in the MIPS gas docs.  */
+   in the MIPS gas docs.
+   The mad4650 option is set if the 4650's MAD extensions are available. */
 
-#define OPCODE_IS_MEMBER(insn, isa, cpu, gp32)				\
+#define OPCODE_IS_MEMBER(insn, isa, cpu, gp32, mad4650)			\
     ((((insn)->membership & isa) != 0                           	\
       && ((insn)->membership & INSN_GP32 ? gp32 : 1)			\
      )									\
-     || (cpu == CPU_R4650 && ((insn)->membership & INSN_4650) != 0)	\
+     || (mad4650 && ((insn)->membership & INSN_4650) != 0)		\
      || (cpu == CPU_R4010 && ((insn)->membership & INSN_4010) != 0)	\
      || ((cpu == CPU_VR4100 || cpu == CPU_R4111)			\
diff -uNr binutils-2.10.91.0.2.orig/opcodes/ChangeLog binutils-2.10.91.0.2/opcodes/ChangeLog
--- binutils-2.10.91.0.2.orig/opcodes/ChangeLog	Thu Feb 15 01:28:01 2001
+++ binutils-2.10.91.0.2/opcodes/ChangeLog	Thu Mar 15 18:19:54 2001
@@ -1,3 +1,7 @@
+2001-03-15  Daniel Jacobowitz <djacobowitz@mvista.com>
+
+	* mips-dis.c: Add mad4650 option to OPCODE_IS_MEMBER call.
+
 2001-02-14  Jim Wilson  <wilson@redhat.com>
 
 	* ia64-ic.tbl: Update from Intel.  Add setf to fr-writers.
diff -uNr binutils-2.10.91.0.2.orig/opcodes/mips-dis.c binutils-2.10.91.0.2/opcodes/mips-dis.c
--- binutils-2.10.91.0.2.orig/opcodes/mips-dis.c	Sun Feb 11 19:44:12 2001
+++ binutils-2.10.91.0.2/opcodes/mips-dis.c	Thu Mar 15 18:19:13 2001
@@ -446,7 +446,7 @@
 	    {
 	      register const char *d;
 
-	      if (! OPCODE_IS_MEMBER (op, mips_isa, target_processor, 0))
+	      if (! OPCODE_IS_MEMBER (op, mips_isa, target_processor, 0, 1))
 		continue;
 
 	      (*info->fprintf_func) (info->stream, "%s", op->name);

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gcc-mips-mad.patch"

--- gcc-2.95.3/gcc/config/mips/mips.h.orig	Thu Mar 15 19:39:16 2001
+++ gcc-2.95.3/gcc/config/mips/mips.h	Thu Mar 15 19:39:53 2001
@@ -821,7 +821,7 @@
 /* GAS_ASM_SPEC is passed when using gas, rather than the MIPS
    assembler.  */
 
-#define GAS_ASM_SPEC "%{mcpu=*} %{m4650} %{mmad:-m4650} %{m3900} %{v}"
+#define GAS_ASM_SPEC "%{mcpu=*} %{m4650} %{mmad} %{m3900} %{v}"
 
 /* TARGET_ASM_SPEC is used to select either MIPS_AS_ASM_SPEC or
    GAS_ASM_SPEC as the default, depending upon the value of

--8t9RHnE3ZwKMSgU+--
