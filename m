Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56G2MJ02842
	for linux-mips-outgoing; Wed, 6 Jun 2001 09:02:22 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56G2Lh02837
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 09:02:21 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 408EE125BC; Wed,  6 Jun 2001 09:02:20 -0700 (PDT)
Date: Wed, 6 Jun 2001 09:02:20 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: binutils@sourceware.cygnus.com
Cc: ulfc@calypso.engr.sgi.com, linux-mips@oss.sgi.com
Subject: An ELF patch for mips gas
Message-ID: <20010606090220.A21351@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Who is the current maintainer for mips? Ulf Carlsson
<ulfc@calypso.engr.sgi.com> has not been responding for quite a while.
I am working on toolchain for Linux/mips. I have quite a few patches
and questions. Here is the first patch. It is needed to allow override
global symbols in DSOs.  Any objections?

Thanks.


H.J.
----
2001-06-06  H.J. Lu  <hjl@gnu.org>

	* config/tc-mips.c (md_apply_fix): Don't adjust common
	extern/weak symbols for ELF.
	(md_estimate_size_before_relax): Treat weak like extern for
	ELF.
	(mips_fix_adjustable): Don't adjust extern/weak symbols for
	ELF.

Index: config/tc-mips.c
===================================================================
RCS file: /work/cvs/gnu/binutils/gas/config/tc-mips.c,v
retrieving revision 1.37
diff -u -p -r1.37 tc-mips.c
--- config/tc-mips.c	2001/05/23 18:36:05	1.37
+++ config/tc-mips.c	2001/06/06 15:52:59
@@ -9525,7 +9525,9 @@ md_apply_fix (fixP, valueP)
   if (fixP->fx_addsy != NULL && OUTPUT_FLAVOR == bfd_target_elf_flavour)
     {
     if (S_GET_OTHER (fixP->fx_addsy) == STO_MIPS16
-        || S_IS_WEAK (fixP->fx_addsy)
+	|| ((S_IS_WEAK (fixP->fx_addsy)
+	     || S_IS_EXTERN (fixP->fx_addsy))
+	    && !S_IS_COMMON (fixP->fx_addsy))
         || (symbol_used_in_reloc_p (fixP->fx_addsy)
             && (((bfd_get_section_flags (stdoutput,
                                          S_GET_SEGMENT (fixP->fx_addsy))
@@ -11032,8 +11034,8 @@ md_estimate_size_before_relax (fragp, se
 		&& ! bfd_is_com_section (symsec)
 		&& !linkonce
 #ifdef OBJ_ELF
-		/* A weak symbol is treated as external.  */
-		&& ! S_IS_WEAK (sym)
+		/* A global or weak symbol is treated as external.  */
+		&& ! (S_IS_EXTERN (sym) || S_IS_WEAK (sym))
 #endif
 		);
     }
@@ -11071,6 +11073,11 @@ int
 mips_fix_adjustable (fixp)
      fixS *fixp;
 {
+#ifdef OBJ_ELF
+  /* Prevent all adjustments to global symbols.  */
+  if (S_IS_EXTERN (fixp->fx_addsy) || S_IS_WEAK (fixp->fx_addsy))
+    return 0;
+#endif
   if (fixp->fx_r_type == BFD_RELOC_MIPS16_JMP)
     return 0;
   if (fixp->fx_r_type == BFD_RELOC_VTABLE_INHERIT


2001-06-06  H.J. Lu  <hjl@gnu.org>

	* gas/testsuite/gas/mips/elf-jal.d: New file.

	* gas/testsuite/gas/mips/mips.exp: Run "elf-jal" instead of
	"jal" for ELF.

Index: testsuite/gas/mips/mips.exp
===================================================================
RCS file: /work/cvs/gnu/binutils/gas/testsuite/gas/mips/mips.exp,v
retrieving revision 1.1.1.8
diff -u -p -r1.1.1.8 mips.exp
--- testsuite/gas/mips/mips.exp	2001/05/25 19:07:01	1.1.1.8
+++ testsuite/gas/mips/mips.exp	2001/06/06 15:52:59
@@ -28,7 +28,11 @@ if { [istarget mips*-*-*] } then {
     run_dump_test "bltu"
     if !$ilocks { run_dump_test "div" } else { run_dump_test "div-ilocks" }
     run_dump_test "dli"
-    run_dump_test "jal"
+    if $svr4pic {
+	run_dump_test "elf-jal"
+    } else {
+	run_dump_test "jal"
+    }
     if $svr4pic { run_dump_test "jal-svr4pic" }
     if $svr4pic { run_dump_test "jal-xgot" }
     if $empic { run_dump_test "jal-empic" }
--- /dev/null	Fri Mar 23 20:37:44 2001
+++ testsuite/gas/mips/elf-jal.d	Wed Jun  6 08:52:59 2001
@@ -0,0 +1,25 @@
+#objdump: -dr --prefix-addresses -mmips:4000
+#name: MIPS jal
+#source: jal.s
+
+# Test the jal macro.
+
+.*: +file format .*mips.*
+
+Disassembly of section .text:
+0+0000 <[^>]*> jalr	t9
+0+0004 <[^>]*> nop
+0+0008 <[^>]*> jalr	a0,t9
+0+000c <[^>]*> nop
+0+0010 <[^>]*> jal	0+ <text_label>
+[ 	]*10: (MIPS_JMP|MIPS_JMP|JMPADDR|R_MIPS_26)	text_label
+0+0014 <[^>]*> nop
+0+0018 <[^>]*> jal	0+ <text_label>
+[ 	]*18: (MIPS_JMP|JMPADDR|R_MIPS_26)	external_text_label
+0+001c <[^>]*> nop
+0+0020 <[^>]*> j	0+ <text_label>
+[ 	]*20: (MIPS_JMP|JMPADDR|R_MIPS_26)	text_label
+0+0024 <[^>]*> nop
+0+0028 <[^>]*> j	0+ <text_label>
+[ 	]*28: (MIPS_JMP|JMPADDR|R_MIPS_26)	external_text_label
+0+002c <[^>]*> nop
