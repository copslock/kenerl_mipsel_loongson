Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Nov 2008 14:29:11 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.187]:60587 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S23696386AbYKOO3E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 15 Nov 2008 14:29:04 +0000
Received: by nf-out-0910.google.com with SMTP id h3so962501nfh.14
        for <linux-mips@linux-mips.org>; Sat, 15 Nov 2008 06:29:03 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:mail-followup-to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=oeG4HLk/z7TuypuX7I6fLmRG7plpoODBNAoPZdSWpQU=;
        b=jSQ6KSoIzCFYSD19uXuqjQXacEPq+qsNakLjgM/ADITWx5pzvFKtw7fInn/xCRyXpA
         lJvgYGv7lHvtpxinKSTCWb/KldEL1mV0yciJk3wZRDDiap/u6MKF6bTQLFazjJdXOl4Y
         HWXMk6HX2HTXqcoJ7faev0wUyvu2m0kmXO16A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=fl4m9cdTnuBmFHxsq2s2geC1FD6KF9Cmq+Ms78w+u2Y5sJw4NwcYWPk0YEhSkFQaMG
         3hv0lJlhaoOTtvk5JvKyrhFO3cAIIpVea2R3M80MAISkPcy2vkVTIBZrVbXcvdcmbBeg
         eWPHj85mfS5vZejp8fXwL1VS0tRxtK82BNsUE=
Received: by 10.210.119.5 with SMTP id r5mr2187061ebc.89.1226759343451;
        Sat, 15 Nov 2008 06:29:03 -0800 (PST)
Received: from localhost (79-67-45-8.dynamic.dsl.as9105.com [79.67.45.8])
        by mx.google.com with ESMTPS id d23sm6634092nfh.11.2008.11.15.06.29.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Nov 2008 06:29:01 -0800 (PST)
From:	Richard Sandiford <rdsandiford@googlemail.com>
To:	Kumba <kumba@gentoo.org>
Mail-Followup-To: Kumba <kumba@gentoo.org>,gcc-patches@gcc.gnu.org,  Linux MIPS List <linux-mips@linux-mips.org>, rdsandiford@googlemail.com
Cc:	gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org>
	<87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org>
	<87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org>
	<87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org>
	<87myggilk2.fsf@firetop.home> <490FF63A.7010900@gentoo.org>
	<8763mypnhf.fsf@firetop.home> <4917D01B.8080508@gentoo.org>
	<87y6zphn5b.fsf@firetop.home> <491A88E8.3050108@gentoo.org>
	<873ahvgr39.fsf@firetop.home> <491D3381.4050505@gentoo.org>
Date:	Sat, 15 Nov 2008 14:28:58 +0000
In-Reply-To: <491D3381.4050505@gentoo.org> (kumba@gentoo.org's message of
	"Fri\, 14 Nov 2008 03\:14\:57 -0500")
Message-ID: <87vduprrkl.fsf@firetop.home>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi,

Thanks for the patch.

Kumba <kumba@gentoo.org> writes:
>> A testcase would be nice, yes.  It helps people who are testing on
>> non-R10K hardware.  It doesn't need to be an execution test though:
>> just write a scan-assembler test to make sure that all __sync_*()
>> builtins use branch-likely instructions.  See other gcc.target/mips
>> tests for inspiration.
>
> Okay, I think I got these right.  There's 16 of them, fix-r10000-1.c
> through fix-r10000-16.c.  Each file tests a single __sync_* function,
> and has the scan-assembler look for the 'beql' instruction in the
> output.  I test compiled all of them by hand and checked their output
> with both -mno-fix-r10000 and -mfix-r10000, and a diff shows that
> exact instruction changing, so I think these all pass.
>
> I couldn't tell which __sync_* function outputs the asm code found in 
> MIPS_SYNC_NEW_OP and MIPS_SYNC_NEW_NAND, but other than that, the output all 
> looked good.

__sync_<op>_and_fetch uses MIPS_SYNC_NEW_OP while __sync_fetch_and_<op>
uses MIPS_SYNC_OLD_OP.  So your tests did cover the necessary functions.
The problem was that the tests ignored the return value, so
__sync_<op>_and_fetch reduced to __sync_fetch_and_<op>.

> I may not need fix-r10000-15.c, since that calls __sync_synchronize(), which 
> doesn't output any branch-likely instructions at all.  Wasn't sure where it's 
> proper to call that function from (or if it even needs testing).

Yeah, that test is wrong.  __sync_synchronize isn't a loop (and isn't
meant to be a loop) so the test rightly fails.

> Fixed, and added the documentation.  If this looks good, then I'll cut
> a final w/ the changelog notations.

Yeah, it looks generally good.  I think we've got to the point where
it's easier for me to make changes directly rather than ask you to
follow a tortuous list of vaguely-described requests, so:

  - I added a missing @gol after "-mfix-r4400".

  - I tweaked the documentation so that it was more consistent with the
    other -mfix-* options.  Let me know if you spot a problem with the
    new version, or if you aren't happy with it.

  - I changed the name of the helper function from mips_output_sync_insn
    (my original suggestion) to mips_output_sync_loop, which seems a
    bit more descriptive.  Sorry for going back on myself.  Related...

  - ...I changed the name of the parameter from TEMPLATE to LOOP to
    avoid a bootstrap-breaking warning about using a C++ identifier.
    (Again my fault.  I'd used TEMPLATE when suggesting the function,
    but it was a completely untested suggestion.)

  - I added a prototype to mips-protos.h, again to avoid a bootstrap-
    breaking warning.

  - I removed the "\n" from the sorry message (my fault again).

  - I fixed a typo: s/!TARGET_BRANCHLIKEL/!TARGET_BRANCHLIKELY/.
    GCC wouldn't build without this, so perhaps the posted patch
    wasn't the final one.

  - I made the tests check for "\tbeql\t", which is a bit more
    robust than plain "beql".  (OK, it's not likely to make a
    difference for this particular example, but it seems like
    good practice.)

  - I changed the tests to operate on caller-provided memory.
    The old versions operated on automatic variables that obviously
    couldn't escape, sp I was worried they might be optimised in future.

  - I made the subtraction tests take the subtrahend as an argument,
    because subtracting 42 reduces to adding -42.

  - I added "short" and "char" versions of each test function.

  - I made the test functions return the result of the __sync_* builtin,
    for the reasons given above.

  - As discussed above, I removed the original test 15 and
    renamed 16 to 15.

  - I tweaked the formatting in a couple of places, but nothing major.

Applied with those changes.  I've attached the final changelog and
patch below.  Thanks for the contribution, and for your patience.

Richard


gcc/
2008-11-15  Joshua Kinard  <kumba@gentoo.org>

	* doc/invoke.texi (-mfix-r10000): Document.
	* config/mips/mips.opt (mfix-r10000): New option.
	* config/mips/mips-protos.h (mips_output_sync_loop): Declare.
	* config/mips/mips.h (MIPS_COMPARE_AND_SWAP): Use %?.
	(MIPS_COMPARE_AND_SWAP_12): Likewise.
	(MIPS_SYNC_OP): Likewise.
	(MIPS_SYNC_OP_12): Likewise.
	(MIPS_SYNC_OLD_OP_12): Likewise.
	(MIPS_SYNC_NEW_OP_12): Likewise.
	(MIPS_SYNC_OLD_OP): Likewise.
	(MIPS_SYNC_NAND): Likewise.
	(MIPS_SYNC_OLD_NAND): Likewise.
	(MIPS_SYNC_EXCHANGE): Likewise.
	(MIPS_SYNC_EXCHANGE_12): Likewise.
	(MIPS_SYNC_NEW_OP): Likewise, using %~ to fill branch-likely
	delay slots.
	(MIPS_SYNC_NEW_NAND): Likewise.
	* config/mips/mips.c (mips_print_operand_punctuation): Handle '~'.
	(mips_init_print_operand_punct): Treat '~' as a punctuation character.
	(mips_output_sync_loop): New function.
	(mips_override_options): Make -march=r10000 imply -mfix-r10000.
	Make -mfix-r10000 require branch-likely instructions.
	* config/mips/sync.md (sync_compare_and_swap<mode>): Use
	mips_output_sync_loop.
	(compare_and_swap_12): Likewise.
	(sync_add<mode>): Likewise.
	(sync_<optab>_12): Likewise.
	(sync_old_<optab>_12): Likewise.
	(sync_new_<optab>_12): Likewise.
	(sync_nand_12): Likewise.
	(sync_old_nand_12): Likewise.
	(sync_new_nand_12): Likewise.
	(sync_sub<mode>): Likewise.
	(sync_old_add<mode>): Likewise.
	(sync_old_sub<mode>): Likewise.
	(sync_new_add<mode>): Likewise.
	(sync_new_sub<mode>): Likewise.
	(sync_<optab><mode>): Likewise.
	(sync_old_<optab><mode>): Likewise.
	(sync_new_<optab><mode>): Likewise.
	(sync_nand<mode>): Likewise.
	(sync_old_nand<mode>): Likewise.
	(sync_new_nand<mode>): Likewise.
	(sync_lock_test_and_set<mode>): Likewise.
	(test_and_set_12): Likewise.

gcc/testsuite/
2008-11-15  Joshua Kinard  <kumba@gentoo.org>
	    Richard Sandiford  <rdsandiford@goolemail.com>

	* gcc.target/mips/fix-r10000-1.c: New test.
	* gcc.target/mips/fix-r10000-2.c: Likewise.
	* gcc.target/mips/fix-r10000-3.c: Likewise.
	* gcc.target/mips/fix-r10000-4.c: Likewise.
	* gcc.target/mips/fix-r10000-5.c: Likewise.
	* gcc.target/mips/fix-r10000-6.c: Likewise.
	* gcc.target/mips/fix-r10000-7.c: Likewise.
	* gcc.target/mips/fix-r10000-8.c: Likewise.
	* gcc.target/mips/fix-r10000-9.c: Likewise.
	* gcc.target/mips/fix-r10000-10.c: Likewise.
	* gcc.target/mips/fix-r10000-11.c: Likewise.
	* gcc.target/mips/fix-r10000-12.c: Likewise.
	* gcc.target/mips/fix-r10000-13.c: Likewise.
	* gcc.target/mips/fix-r10000-14.c: Likewise.
	* gcc.target/mips/fix-r10000-15.c: Likewise.

Index: gcc/doc/invoke.texi
===================================================================
--- gcc/doc/invoke.texi	2008-11-15 14:19:02.000000000 +0000
+++ gcc/doc/invoke.texi	2008-11-15 14:21:38.000000000 +0000
@@ -668,8 +668,8 @@ Objective-C and Objective-C++ Dialects}.
 -mmemcpy  -mno-memcpy  -mlong-calls  -mno-long-calls @gol
 -mmad  -mno-mad  -mfused-madd  -mno-fused-madd  -nocpp @gol
 -mfix-r4000  -mno-fix-r4000  -mfix-r4400  -mno-fix-r4400 @gol
--mfix-vr4120  -mno-fix-vr4120  -mfix-vr4130  -mno-fix-vr4130 @gol
--mfix-sb1  -mno-fix-sb1 @gol
+-mfix-r10000 -mno-fix-r10000  -mfix-vr4120  -mno-fix-vr4120 @gol
+-mfix-vr4130  -mno-fix-vr4130  -mfix-sb1  -mno-fix-sb1 @gol
 -mflush-func=@var{func}  -mno-flush-func @gol
 -mbranch-cost=@var{num}  -mbranch-likely  -mno-branch-likely @gol
 -mfp-exceptions -mno-fp-exceptions @gol
@@ -12833,6 +12833,22 @@ A double-word or a variable shift may gi
 immediately after starting an integer division.
 @end itemize
 
+@item -mfix-r10000
+@itemx -mno-fix-r10000
+@opindex mfix-r10000
+@opindex mno-fix-r10000
+Work around certain R10000 errata:
+@itemize @minus
+@item
+@code{ll}/@code{sc} sequences may not behave atomically on revisions
+prior to 3.0.  They may deadlock on revisions 2.6 and earlier.
+@end itemize
+
+This option can only be used if the target architecture supports
+branch-likely instructions.  @option{-mfix-r10000} is the default when
+@option{-march=r10000} is used; @option{-mno-fix-r10000} is the default
+otherwise.
+
 @item -mfix-vr4120
 @itemx -mno-fix-vr4120
 @opindex mfix-vr4120
Index: gcc/config/mips/mips.opt
===================================================================
--- gcc/config/mips/mips.opt	2008-11-15 14:19:02.000000000 +0000
+++ gcc/config/mips/mips.opt	2008-11-15 14:21:08.000000000 +0000
@@ -112,6 +112,10 @@ mfix-r4400
 Target Report Mask(FIX_R4400)
 Work around certain R4400 errata
 
+mfix-r10000
+Target Report Mask(FIX_R10000)
+Work around certain R10000 errata
+
 mfix-sb1
 Target Report Var(TARGET_FIX_SB1)
 Work around errata for early SB-1 revision 2 cores
Index: gcc/config/mips/mips-protos.h
===================================================================
--- gcc/config/mips/mips-protos.h	2008-11-15 14:19:02.000000000 +0000
+++ gcc/config/mips/mips-protos.h	2008-11-15 14:21:08.000000000 +0000
@@ -300,6 +300,7 @@ extern const char *mips_output_load_labe
 extern const char *mips_output_conditional_branch (rtx, rtx *, const char *,
 						   const char *);
 extern const char *mips_output_order_conditional_branch (rtx, rtx *, bool);
+extern const char *mips_output_sync_loop (const char *);
 extern const char *mips_output_division (const char *, rtx *);
 extern unsigned int mips_hard_regno_nregs (int, enum machine_mode);
 extern bool mips_linked_madd_p (rtx, rtx);
Index: gcc/config/mips/mips.h
===================================================================
--- gcc/config/mips/mips.h	2008-11-15 14:19:02.000000000 +0000
+++ gcc/config/mips/mips.h	2008-11-15 14:21:08.000000000 +0000
@@ -3090,7 +3090,7 @@ #define MIPS_COMPARE_AND_SWAP(SUFFIX, OP
   "\tbne\t%0,%z2,2f\n"				\
   "\t" OP "\t%@,%3\n"				\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)\n"				\
   "2:\n"
@@ -3115,7 +3115,7 @@ #define MIPS_COMPARE_AND_SWAP_12(OPS)		\
   "\tand\t%@,%0,%3\n"				\
   OPS						\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)\n"				\
   "2:\n"
@@ -3135,7 +3135,7 @@ #define MIPS_SYNC_OP(SUFFIX, INSN)		\
   "1:\tll" SUFFIX "\t%@,%0\n"			\
   "\t" INSN "\t%@,%@,%1\n"			\
   "\tsc" SUFFIX "\t%@,%0\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3160,7 +3160,7 @@ #define MIPS_SYNC_OP_12(INSN, NOT_OP)		\
   "\tand\t%4,%4,%1\n"				\
   "\tor\t%@,%@,%4\n"				\
   "\tsc\t%@,%0\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3193,7 +3193,7 @@ #define MIPS_SYNC_OLD_OP_12(INSN, NOT_OP
   "\tand\t%5,%5,%2\n"				\
   "\tor\t%@,%@,%5\n"				\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3223,7 +3223,7 @@ #define MIPS_SYNC_NEW_OP_12(INSN, NOT_OP
   "\tand\t%0,%0,%2\n"				\
   "\tor\t%@,%@,%0\n"				\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3243,7 +3243,7 @@ #define MIPS_SYNC_OLD_OP(SUFFIX, INSN)		
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3260,7 +3260,7 @@ #define MIPS_SYNC_NEW_OP(SUFFIX, INSN)		
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b%~\n"			\
   "\t" INSN "\t%0,%0,%2\n"			\
   "\tsync%-%]%>%)"
 
@@ -3277,7 +3277,7 @@ #define MIPS_SYNC_NAND(SUFFIX, INSN)		\
   "\tnor\t%@,%@,%.\n"				\
   "\t" INSN "\t%@,%@,%1\n"			\
   "\tsc" SUFFIX "\t%@,%0\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3296,7 +3296,7 @@ #define MIPS_SYNC_OLD_NAND(SUFFIX, INSN)
   "\tnor\t%@,%0,%.\n"				\
   "\t" INSN "\t%@,%@,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3315,7 +3315,7 @@ #define MIPS_SYNC_NEW_NAND(SUFFIX, INSN)
   "\tnor\t%0,%0,%.\n"				\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b%~\n"			\
   "\t" INSN "\t%0,%0,%2\n"			\
   "\tsync%-%]%>%)"
 
@@ -3333,7 +3333,7 @@ #define MIPS_SYNC_EXCHANGE(SUFFIX, OP)		
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" OP "\t%@,%2\n"				\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3357,7 +3357,7 @@ #define MIPS_SYNC_EXCHANGE_12(OPS)      
   "\tand\t%@,%0,%3\n"				\
   OPS						\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
Index: gcc/config/mips/mips.c
===================================================================
--- gcc/config/mips/mips.c	2008-11-15 14:19:02.000000000 +0000
+++ gcc/config/mips/mips.c	2008-11-15 14:21:08.000000000 +0000
@@ -6909,6 +6909,7 @@ mips_print_operand_reloc (FILE *file, rt
    '#'	Print a nop if in a ".set noreorder" block.
    '/'	Like '#', but do nothing within a delayed-branch sequence.
    '?'	Print "l" if mips_branch_likely is true
+   '~'	Print a nop if mips_branch_likely is true
    '.'	Print the name of the register with a hard-wired zero (zero or $0).
    '@'	Print the name of the assembler temporary register (at or $1).
    '^'	Print the name of the pic call-through register (t9 or $25).
@@ -6983,6 +6984,11 @@ mips_print_operand_punctuation (FILE *fi
 	putc ('l', file);
       break;
 
+    case '~':
+      if (mips_branch_likely)
+	fputs ("\n\tnop", file);
+      break;
+
     case '.':
       fputs (reg_names[GP_REG_FIRST + 0], file);
       break;
@@ -7026,7 +7032,7 @@ mips_init_print_operand_punct (void)
 {
   const char *p;
 
-  for (p = "()[]<>*#/?.@^+$|-"; *p; p++)
+  for (p = "()[]<>*#/?~.@^+$|-"; *p; p++)
     mips_print_operand_punct[(unsigned char) *p] = true;
 }
 
@@ -10250,6 +10256,17 @@ mips_output_order_conditional_branch (rt
   return mips_output_conditional_branch (insn, operands, branch[1], branch[0]);
 }
 
+/* Return the assembly code for __sync_*() loop LOOP.  The loop should support
+   both normal and likely branches, using %? and %~ where appropriate.  */
+
+const char *
+mips_output_sync_loop (const char *loop)
+{
+  /* Use branch-likely instructions to work around the LL/SC R10000 errata.  */
+  mips_branch_likely = TARGET_FIX_R10000;
+  return loop;
+}
+
 /* Return the assembly code for DIV or DDIV instruction DIVISION, which has
    the operands given by OPERANDS.  Add in a divide-by-zero check if needed.
 
@@ -13971,6 +13988,24 @@ mips_override_options (void)
       && mips_matching_cpu_name_p (mips_arch_info->name, "r4400"))
     target_flags |= MASK_FIX_R4400;
 
+  /* Default to working around R10000 errata only if the processor
+     was selected explicitly.  */
+  if ((target_flags_explicit & MASK_FIX_R10000) == 0
+      && mips_matching_cpu_name_p (mips_arch_info->name, "r10000"))
+    target_flags |= MASK_FIX_R10000;
+
+  /* Make sure that branch-likely instructions available when using
+     -mfix-r10000.  The instructions are not available if either:
+
+	1. -mno-branch-likely was passed.
+	2. The selected ISA does not support branch-likely and
+	   the command line does not include -mbranch-likely.  */
+  if (TARGET_FIX_R10000
+      && ((target_flags_explicit & MASK_BRANCHLIKELY) == 0
+          ? !ISA_HAS_BRANCHLIKELY
+          : !TARGET_BRANCHLIKELY))
+    sorry ("%qs requires branch-likely instructions", "-mfix-r10000");
+
   /* Save base state of options.  */
   mips_base_target_flags = target_flags;
   mips_base_delayed_branch = flag_delayed_branch;
Index: gcc/config/mips/sync.md
===================================================================
--- gcc/config/mips/sync.md	2008-11-15 14:19:02.000000000 +0000
+++ gcc/config/mips/sync.md	2008-11-15 14:21:08.000000000 +0000
@@ -43,9 +43,9 @@ (define_insn "sync_compare_and_swap<mode
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_COMPARE_AND_SWAP ("<d>", "li");
+    return mips_output_sync_loop (MIPS_COMPARE_AND_SWAP ("<d>", "li"));
   else
-    return MIPS_COMPARE_AND_SWAP ("<d>", "move");
+    return mips_output_sync_loop (MIPS_COMPARE_AND_SWAP ("<d>", "move"));
 }
   [(set_attr "length" "32")])
 
@@ -76,9 +76,11 @@ (define_insn "compare_and_swap_12"
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_NONZERO_OP);
+    return (mips_output_sync_loop
+	    (MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_NONZERO_OP)));
   else
-    return MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_ZERO_OP);
+    return (mips_output_sync_loop
+	    (MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_ZERO_OP)));
 }
   [(set_attr "length" "40,36")])
 
@@ -91,9 +93,9 @@ (define_insn "sync_add<mode>"
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_OP ("<d>", "<d>addiu");	
+    return mips_output_sync_loop (MIPS_SYNC_OP ("<d>", "<d>addiu"));
   else
-    return MIPS_SYNC_OP ("<d>", "<d>addu");	
+    return mips_output_sync_loop (MIPS_SYNC_OP ("<d>", "<d>addu"));
 }
   [(set_attr "length" "28")])
 
@@ -124,7 +126,8 @@ (define_insn "sync_<optab>_12"
    (clobber (match_scratch:SI 4 "=&d"))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_OP_12 ("<insn>", MIPS_SYNC_OP_12_NOT_NOP);	
+    return (mips_output_sync_loop
+	    (MIPS_SYNC_OP_12 ("<insn>", MIPS_SYNC_OP_12_NOT_NOP)));
 }
   [(set_attr "length" "40")])
 
@@ -160,8 +163,9 @@ (define_insn "sync_old_<optab>_12"
    (clobber (match_scratch:SI 5 "=&d"))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_OLD_OP_12 ("<insn>", MIPS_SYNC_OLD_OP_12_NOT_NOP,
-				MIPS_SYNC_OLD_OP_12_NOT_NOP_REG);	
+    return (mips_output_sync_loop
+	    (MIPS_SYNC_OLD_OP_12 ("<insn>", MIPS_SYNC_OLD_OP_12_NOT_NOP,
+	    			  MIPS_SYNC_OLD_OP_12_NOT_NOP_REG)));
 }
   [(set_attr "length" "40")])
 
@@ -202,7 +206,8 @@ (define_insn "sync_new_<optab>_12"
 	   (match_dup 4)] UNSPEC_SYNC_NEW_OP_12))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_NEW_OP_12 ("<insn>", MIPS_SYNC_NEW_OP_12_NOT_NOP);
+    return (mips_output_sync_loop
+	    (MIPS_SYNC_NEW_OP_12 ("<insn>", MIPS_SYNC_NEW_OP_12_NOT_NOP)));
 }
   [(set_attr "length" "40")])
 
@@ -233,7 +238,8 @@ (define_insn "sync_nand_12"
    (clobber (match_scratch:SI 4 "=&d"))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_OP_12 ("and", MIPS_SYNC_OP_12_NOT_NOT);	
+    return (mips_output_sync_loop
+	    (MIPS_SYNC_OP_12 ("and", MIPS_SYNC_OP_12_NOT_NOT)));
 }
   [(set_attr "length" "44")])
 
@@ -267,8 +273,9 @@ (define_insn "sync_old_nand_12"
    (clobber (match_scratch:SI 5 "=&d"))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_OLD_OP_12 ("and", MIPS_SYNC_OLD_OP_12_NOT_NOT,
-				MIPS_SYNC_OLD_OP_12_NOT_NOT_REG);	
+    return (mips_output_sync_loop
+	    (MIPS_SYNC_OLD_OP_12 ("and", MIPS_SYNC_OLD_OP_12_NOT_NOT,
+				  MIPS_SYNC_OLD_OP_12_NOT_NOT_REG)));
 }
   [(set_attr "length" "44")])
 
@@ -307,7 +314,8 @@ (define_insn "sync_new_nand_12"
 	   (match_dup 4)] UNSPEC_SYNC_NEW_OP_12))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_NEW_OP_12 ("and", MIPS_SYNC_NEW_OP_12_NOT_NOT);
+    return (mips_output_sync_loop
+	    (MIPS_SYNC_NEW_OP_12 ("and", MIPS_SYNC_NEW_OP_12_NOT_NOT)));
 }
   [(set_attr "length" "40")])
 
@@ -319,7 +327,7 @@ (define_insn "sync_sub<mode>"
 	 UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
-  return MIPS_SYNC_OP ("<d>", "<d>subu");	
+  return mips_output_sync_loop (MIPS_SYNC_OP ("<d>", "<d>subu"));
 }
   [(set_attr "length" "28")])
 
@@ -334,9 +342,9 @@ (define_insn "sync_old_add<mode>"
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_OLD_OP ("<d>", "<d>addiu");	
+    return mips_output_sync_loop (MIPS_SYNC_OLD_OP ("<d>", "<d>addiu"));
   else
-    return MIPS_SYNC_OLD_OP ("<d>", "<d>addu");	
+    return mips_output_sync_loop (MIPS_SYNC_OLD_OP ("<d>", "<d>addu"));
 }
   [(set_attr "length" "28")])
 
@@ -350,7 +358,7 @@ (define_insn "sync_old_sub<mode>"
 	 UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
-  return MIPS_SYNC_OLD_OP ("<d>", "<d>subu");	
+  return mips_output_sync_loop (MIPS_SYNC_OLD_OP ("<d>", "<d>subu"));
 }
   [(set_attr "length" "28")])
 
@@ -365,9 +373,9 @@ (define_insn "sync_new_add<mode>"
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_NEW_OP ("<d>", "<d>addiu");	
+    return mips_output_sync_loop (MIPS_SYNC_NEW_OP ("<d>", "<d>addiu"));
   else
-    return MIPS_SYNC_NEW_OP ("<d>", "<d>addu");	
+    return mips_output_sync_loop (MIPS_SYNC_NEW_OP ("<d>", "<d>addu"));
 }
   [(set_attr "length" "28")])
 
@@ -381,7 +389,7 @@ (define_insn "sync_new_sub<mode>"
 	 UNSPEC_SYNC_NEW_OP))]
   "GENERATE_LL_SC"
 {
-  return MIPS_SYNC_NEW_OP ("<d>", "<d>subu");	
+  return mips_output_sync_loop (MIPS_SYNC_NEW_OP ("<d>", "<d>subu"));
 }
   [(set_attr "length" "28")])
 
@@ -394,9 +402,9 @@ (define_insn "sync_<optab><mode>"
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_OP ("<d>", "<immediate_insn>");	
+    return mips_output_sync_loop (MIPS_SYNC_OP ("<d>", "<immediate_insn>"));
   else
-    return MIPS_SYNC_OP ("<d>", "<insn>");	
+    return mips_output_sync_loop (MIPS_SYNC_OP ("<d>", "<insn>"));
 }
   [(set_attr "length" "28")])
 
@@ -411,9 +419,10 @@ (define_insn "sync_old_<optab><mode>"
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_OLD_OP ("<d>", "<immediate_insn>");	
+    return (mips_output_sync_loop
+	    (MIPS_SYNC_OLD_OP ("<d>", "<immediate_insn>")));
   else
-    return MIPS_SYNC_OLD_OP ("<d>", "<insn>");	
+    return mips_output_sync_loop (MIPS_SYNC_OLD_OP ("<d>", "<insn>"));
 }
   [(set_attr "length" "28")])
 
@@ -428,9 +437,10 @@ (define_insn "sync_new_<optab><mode>"
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_NEW_OP ("<d>", "<immediate_insn>");	
+    return (mips_output_sync_loop
+	    (MIPS_SYNC_NEW_OP ("<d>", "<immediate_insn>")));
   else
-    return MIPS_SYNC_NEW_OP ("<d>", "<insn>");	
+    return mips_output_sync_loop (MIPS_SYNC_NEW_OP ("<d>", "<insn>"));
 }
   [(set_attr "length" "28")])
 
@@ -441,9 +451,9 @@ (define_insn "sync_nand<mode>"
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_NAND ("<d>", "andi");	
+    return mips_output_sync_loop (MIPS_SYNC_NAND ("<d>", "andi"));
   else
-    return MIPS_SYNC_NAND ("<d>", "and");	
+    return mips_output_sync_loop (MIPS_SYNC_NAND ("<d>", "and"));
 }
   [(set_attr "length" "32")])
 
@@ -456,9 +466,9 @@ (define_insn "sync_old_nand<mode>"
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_OLD_NAND ("<d>", "andi");	
+    return mips_output_sync_loop (MIPS_SYNC_OLD_NAND ("<d>", "andi"));
   else
-    return MIPS_SYNC_OLD_NAND ("<d>", "and");	
+    return mips_output_sync_loop (MIPS_SYNC_OLD_NAND ("<d>", "and"));
 }
   [(set_attr "length" "32")])
 
@@ -471,9 +481,9 @@ (define_insn "sync_new_nand<mode>"
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_NEW_NAND ("<d>", "andi");	
+    return mips_output_sync_loop (MIPS_SYNC_NEW_NAND ("<d>", "andi"));
   else
-    return MIPS_SYNC_NEW_NAND ("<d>", "and");	
+    return mips_output_sync_loop (MIPS_SYNC_NEW_NAND ("<d>", "and"));
 }
   [(set_attr "length" "32")])
 
@@ -486,9 +496,9 @@ (define_insn "sync_lock_test_and_set<mod
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_EXCHANGE ("<d>", "li");
+    return mips_output_sync_loop (MIPS_SYNC_EXCHANGE ("<d>", "li"));
   else
-    return MIPS_SYNC_EXCHANGE ("<d>", "move");
+    return mips_output_sync_loop (MIPS_SYNC_EXCHANGE ("<d>", "move"));
 }
   [(set_attr "length" "24")])
 
@@ -516,8 +526,10 @@ (define_insn "test_and_set_12"
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_EXCHANGE_12 (MIPS_SYNC_EXCHANGE_12_NONZERO_OP);
+    return (mips_output_sync_loop
+	    (MIPS_SYNC_EXCHANGE_12 (MIPS_SYNC_EXCHANGE_12_NONZERO_OP)));
   else
-    return MIPS_SYNC_EXCHANGE_12 (MIPS_SYNC_EXCHANGE_12_ZERO_OP);
+    return (mips_output_sync_loop
+	    (MIPS_SYNC_EXCHANGE_12 (MIPS_SYNC_EXCHANGE_12_ZERO_OP)));
 }
   [(set_attr "length" "28,24")])
Index: gcc/testsuite/gcc.target/mips/fix-r10000-1.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-1.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,21 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z)
+{
+  return __sync_fetch_and_add (z, 42);
+}
+
+NOMIPS16 short
+f2 (short *z)
+{
+  return __sync_fetch_and_add (z, 42);
+}
+
+NOMIPS16 char
+f3 (char *z)
+{
+  return __sync_fetch_and_add (z, 42);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r10000-2.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-2.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,21 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z, int amt)
+{
+  return __sync_fetch_and_sub (z, amt);
+}
+
+NOMIPS16 short
+f2 (short *z, short amt)
+{
+  return __sync_fetch_and_sub (z, amt);
+}
+
+NOMIPS16 char
+f3 (char *z, char amt)
+{
+  return __sync_fetch_and_sub (z, amt);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r10000-3.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-3.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,21 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z)
+{
+  return __sync_fetch_and_or (z, 42);
+}
+
+NOMIPS16 short
+f2 (short *z)
+{
+  return __sync_fetch_and_or (z, 42);
+}
+
+NOMIPS16 char
+f3 (char *z)
+{
+  return __sync_fetch_and_or (z, 42);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r10000-4.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-4.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,21 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z)
+{
+  return __sync_fetch_and_and (z, 42);
+}
+
+NOMIPS16 short
+f2 (short *z)
+{
+  return __sync_fetch_and_and (z, 42);
+}
+
+NOMIPS16 char
+f3 (char *z)
+{
+  return __sync_fetch_and_and (z, 42);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r10000-5.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-5.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,21 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z)
+{
+  return __sync_fetch_and_xor (z, 42);
+}
+
+NOMIPS16 short
+f2 (short *z)
+{
+  return __sync_fetch_and_xor (z, 42);
+}
+
+NOMIPS16 char
+f3 (char *z)
+{
+  return __sync_fetch_and_xor (z, 42);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r10000-6.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-6.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,21 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z)
+{
+  return __sync_fetch_and_nand (z, 42);
+}
+
+NOMIPS16 short
+f2 (short *z)
+{
+  return __sync_fetch_and_nand (z, 42);
+}
+
+NOMIPS16 char
+f3 (char *z)
+{
+  return __sync_fetch_and_nand (z, 42);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r10000-7.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-7.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,21 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z)
+{
+  return __sync_add_and_fetch (z, 42);
+}
+
+NOMIPS16 short
+f2 (short *z)
+{
+  return __sync_add_and_fetch (z, 42);
+}
+
+NOMIPS16 char
+f3 (char *z)
+{
+  return __sync_add_and_fetch (z, 42);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r10000-8.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-8.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,21 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z, int amt)
+{
+  return __sync_sub_and_fetch (z, amt);
+}
+
+NOMIPS16 short
+f2 (short *z, short amt)
+{
+  return __sync_sub_and_fetch (z, amt);
+}
+
+NOMIPS16 char
+f3 (char *z, char amt)
+{
+  return __sync_sub_and_fetch (z, amt);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r10000-9.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-9.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,21 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z)
+{
+  return __sync_or_and_fetch (z, 42);
+}
+
+NOMIPS16 short
+f2 (short *z)
+{
+  return __sync_or_and_fetch (z, 42);
+}
+
+NOMIPS16 char
+f3 (char *z)
+{
+  return __sync_or_and_fetch (z, 42);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r10000-10.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-10.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,21 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z)
+{
+  return __sync_and_and_fetch (z, 42);
+}
+
+NOMIPS16 short
+f2 (short *z)
+{
+  return __sync_and_and_fetch (z, 42);
+}
+
+NOMIPS16 char
+f3 (char *z)
+{
+  return __sync_and_and_fetch (z, 42);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r10000-11.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-11.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,21 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z)
+{
+  return __sync_xor_and_fetch (z, 42);
+}
+
+NOMIPS16 short
+f2 (short *z)
+{
+  return __sync_xor_and_fetch (z, 42);
+}
+
+NOMIPS16 char
+f3 (char *z)
+{
+  return __sync_xor_and_fetch (z, 42);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r10000-12.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-12.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,21 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z)
+{
+  return __sync_nand_and_fetch (z, 42);
+}
+
+NOMIPS16 short
+f2 (short *z)
+{
+  return __sync_nand_and_fetch (z, 42);
+}
+
+NOMIPS16 char
+f3 (char *z)
+{
+  return __sync_nand_and_fetch (z, 42);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r10000-13.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-13.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,21 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z)
+{
+  return __sync_bool_compare_and_swap (z, 0, 42);
+}
+
+NOMIPS16 short
+f2 (short *z)
+{
+  return __sync_bool_compare_and_swap (z, 0, 42);
+}
+
+NOMIPS16 char
+f3 (char *z)
+{
+  return __sync_bool_compare_and_swap (z, 0, 42);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r10000-14.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-14.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,21 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z)
+{
+  return __sync_val_compare_and_swap (z, 0, 42);
+}
+
+NOMIPS16 short
+f2 (short *z)
+{
+  return __sync_val_compare_and_swap (z, 0, 42);
+}
+
+NOMIPS16 char
+f3 (char *z)
+{
+  return __sync_val_compare_and_swap (z, 0, 42);
+}
Index: gcc/testsuite/gcc.target/mips/fix-r10000-15.c
===================================================================
--- /dev/null	2008-11-15 08:55:59.576098500 +0000
+++ gcc/testsuite/gcc.target/mips/fix-r10000-15.c	2008-11-15 14:21:08.000000000 +0000
@@ -0,0 +1,33 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler-times "\tbeql\t" 3 } } */
+
+NOMIPS16 int
+f1 (int *z)
+{
+  int result;
+
+  result = __sync_lock_test_and_set (z, 42);
+  __sync_lock_release (z);
+  return result;
+}
+
+NOMIPS16 short
+f2 (short *z)
+{
+  short result;
+
+  result = __sync_lock_test_and_set (z, 42);
+  __sync_lock_release (z);
+  return result;
+}
+
+NOMIPS16 char
+f3 (char *z)
+{
+  char result;
+
+  result = __sync_lock_test_and_set (z, 42);
+  __sync_lock_release (z);
+  return result;
+}
