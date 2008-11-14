Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2008 08:16:19 +0000 (GMT)
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:37564 "EHLO
	QMTA08.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S23674097AbYKNIQP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Nov 2008 08:16:15 +0000
Received: from OMTA06.emeryville.ca.mail.comcast.net ([76.96.30.51])
	by QMTA08.emeryville.ca.mail.comcast.net with comcast
	id ewBf1a00D16AWCUA8wG6X7; Fri, 14 Nov 2008 08:16:06 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA06.emeryville.ca.mail.comcast.net with comcast
	id ewG31a00658Be2l8SwG54C; Fri, 14 Nov 2008 08:16:06 +0000
X-Authority-Analysis: v=1.0 c=1 a=se7utVhDntQA:10 a=sj6Exy8oVBoA:10
 a=tr2ZlaadyKdc7YLPuT8A:9 a=zDDlqrZuHCEs-4Eu3P0A:7
 a=qSta9S8fvQYOBxk7x0F_1HtsnYQA:4 a=w6-myHctKckA:10 a=WeOa-AV5lc8A:10
 a=4iXfik_MsjQA:10 a=mRwflF6Szu-te2OPP48A:9 a=dN5CkMbmHc1DDLBN8CQA:7
 a=r0EG5nBz7Uv91FLCH0P02Gd01AEA:4 a=mylFLmerCdIA:10 a=aclI5Qez4f4A:10
 a=vhuCkwUcEWQA:10 a=NfA2RSpTaHsA:10
Message-ID: <491D3381.4050505@gentoo.org>
Date:	Fri, 14 Nov 2008 03:14:57 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	gcc-patches@gcc.gnu.org
CC:	Linux MIPS List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org>	<87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org>	<87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org>	<87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org>	<87myggilk2.fsf@firetop.home> <490FF63A.7010900@gentoo.org>	<8763mypnhf.fsf@firetop.home> <4917D01B.8080508@gentoo.org>	<87y6zphn5b.fsf@firetop.home> <491A88E8.3050108@gentoo.org> <873ahvgr39.fsf@firetop.home>
In-Reply-To: <873ahvgr39.fsf@firetop.home>
Content-Type: multipart/mixed;
 boundary="------------090502080603080804000600"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090502080603080804000600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Richard Sandiford wrote:
> 
> Well, I suppose the current sorry() is too terse even for an
> explicit -mfix-r10000.  How about:
> 
>   sorry ("%qs requires branch-likely instructions\n", "-mfix-r10000");
> 
> (Done that way so that we can reuse any translations in cases where
> we need branch-likely instructions for some other option.)  I think
> that's OK even for "-march=r10000 -mno-branch-likely"; the documentation
> should make it clear that -mfix-r10000 is the default for -march=r10000.

Done.


>> Perhaps:
>>
>> if ((mips_matching_cpu_name_p (mips_arch_info->name, "r12000") ||
>>       mips_matching_cpu_name_p (mips_arch_info->name, "r14000") ||
>>       mips_matching_cpu_name_p (mips_arch_info->name, "r16000"))
>>      && TARGET_FIX_R10000)
>> {
>>    sorry ("R10000 Errata fix not necessary on R12000 and greater CPUs");
>> }
> 
> No, there's no need for anything like this.

Gotcha.  I guess any such combination, if used, will have to be dealt with by 
the CPU.  All the binaries on my Octane, running an R14000 are -march=r10000 
anyways, so when 4.4 final comes out and I start rebuilding stuff, I'll notice 
pretty fast if something is amiss.


> 'Fraid so. ;)  You had those right the first time.

Fixed!


> Thanks.  Haven't had time to look at the PR yet.  Will be the weekend
> at the earliest now.

Yeah, it's an odd one.  It forced me to use the early xgcc compiler to test my 
testcases, since I can't fully build the compiler just yet until this PR gets 
addressed.


> A testcase would be nice, yes.  It helps people who are testing on
> non-R10K hardware.  It doesn't need to be an execution test though:
> just write a scan-assembler test to make sure that all __sync_*()
> builtins use branch-likely instructions.  See other gcc.target/mips
> tests for inspiration.

Okay, I think I got these right.  There's 16 of them, fix-r10000-1.c through 
fix-r10000-16.c.  Each file tests a single __sync_* function, and has the 
scan-assembler look for the 'beql' instruction in the output.  I test compiled 
all of them by hand and checked their output with both -mno-fix-r10000 and 
-mfix-r10000, and a diff shows that exact instruction changing, so I think these 
all pass.

I couldn't tell which __sync_* function outputs the asm code found in 
MIPS_SYNC_NEW_OP and MIPS_SYNC_NEW_NAND, but other than that, the output all 
looked good.

I may not need fix-r10000-15.c, since that calls __sync_synchronize(), which 
doesn't output any branch-likely instructions at all.  Wasn't sure where it's 
proper to call that function from (or if it even needs testing).


> Minor nit, but I think the comment is easier to read if we keep the
> suggested blank line here.
> 
[snip]
> You lost the "." at the end of the comment (coding conventions require it).

Fixed.


> This is preformatted text, so the new line is too long.  Push it onto the
> next, and push the -m{no-,}-fix-vr4130 options down to the following line.
> 
> You need to document what -mfix-r10000 does as well. ;)  See the other
> -mfix-* options for the general idea.

Fixed, and added the documentation.  If this looks good, then I'll cut a final 
w/ the changelog notations.

Thanks!

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

--------------090502080603080804000600
Content-Type: text/plain;
 name="gcc-4.4-trunk-fixr10k-z4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gcc-4.4-trunk-fixr10k-z4.patch"

diff -Naurp -x .svn gcc.orig/gcc/config/mips/mips.c gcc/gcc/config/mips/mips.c
--- gcc.orig/gcc/config/mips/mips.c	2008-11-06 00:35:19.000000000 -0500
+++ gcc/gcc/config/mips/mips.c	2008-11-13 20:42:45.000000000 -0500
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
 
+/* Return a template for the __sync_* functions after setting mips_branch_likely
+   to the value of TARGET_FIX_R10000 to enable a proper workaround of R10000
+   errata.  */
+
+const char *
+mips_output_sync_insn (const char *template)
+{
+  mips_branch_likely = TARGET_FIX_R10000;
+  return template;
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
+          : !TARGET_BRANCHLIKEL))
+    sorry ("%qs requires branch-likely instructions\n", "-mfix-r10000");
+
   /* Save base state of options.  */
   mips_base_target_flags = target_flags;
   mips_base_delayed_branch = flag_delayed_branch;
diff -Naurp -x .svn gcc.orig/gcc/config/mips/mips.h gcc/gcc/config/mips/mips.h
--- gcc.orig/gcc/config/mips/mips.h	2008-11-11 22:33:57.000000000 -0500
+++ gcc/gcc/config/mips/mips.h	2008-11-11 22:38:37.000000000 -0500
@@ -3089,7 +3089,7 @@ while (0)
   "\tbne\t%0,%z2,2f\n"				\
   "\t" OP "\t%@,%3\n"				\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)\n"				\
   "2:\n"
@@ -3114,7 +3114,7 @@ while (0)
   "\tand\t%@,%0,%3\n"				\
   OPS						\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)\n"				\
   "2:\n"
@@ -3134,7 +3134,7 @@ while (0)
   "1:\tll" SUFFIX "\t%@,%0\n"			\
   "\t" INSN "\t%@,%@,%1\n"			\
   "\tsc" SUFFIX "\t%@,%0\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3159,7 +3159,7 @@ while (0)
   "\tand\t%4,%4,%1\n"				\
   "\tor\t%@,%@,%4\n"				\
   "\tsc\t%@,%0\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3192,7 +3192,7 @@ while (0)
   "\tand\t%5,%5,%2\n"				\
   "\tor\t%@,%@,%5\n"				\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3222,7 +3222,7 @@ while (0)
   "\tand\t%0,%0,%2\n"				\
   "\tor\t%@,%@,%0\n"				\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3242,7 +3242,7 @@ while (0)
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3259,7 +3259,7 @@ while (0)
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b%~\n"			\
   "\t" INSN "\t%0,%0,%2\n"			\
   "\tsync%-%]%>%)"
 
@@ -3276,7 +3276,7 @@ while (0)
   "\tnor\t%@,%@,%.\n"				\
   "\t" INSN "\t%@,%@,%1\n"			\
   "\tsc" SUFFIX "\t%@,%0\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3295,7 +3295,7 @@ while (0)
   "\tnor\t%@,%0,%.\n"				\
   "\t" INSN "\t%@,%@,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3314,7 +3314,7 @@ while (0)
   "\tnor\t%0,%0,%.\n"				\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b%~\n"			\
   "\t" INSN "\t%0,%0,%2\n"			\
   "\tsync%-%]%>%)"
 
@@ -3332,7 +3332,7 @@ while (0)
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" OP "\t%@,%2\n"				\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3356,7 +3356,7 @@ while (0)
   "\tand\t%@,%0,%3\n"				\
   OPS						\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
diff -Naurp -x .svn gcc.orig/gcc/config/mips/mips.opt gcc/gcc/config/mips/mips.opt
--- gcc.orig/gcc/config/mips/mips.opt	2008-10-30 22:20:27.000000000 -0400
+++ gcc/gcc/config/mips/mips.opt	2008-11-11 22:38:37.000000000 -0500
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
diff -Naurp -x .svn gcc.orig/gcc/config/mips/sync.md gcc/gcc/config/mips/sync.md
--- gcc.orig/gcc/config/mips/sync.md	2008-10-30 22:20:27.000000000 -0400
+++ gcc/gcc/config/mips/sync.md	2008-11-13 20:44:20.000000000 -0500
@@ -43,9 +43,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_COMPARE_AND_SWAP ("<d>", "li");
+    return mips_output_sync_insn (MIPS_COMPARE_AND_SWAP ("<d>", "li"));
   else
-    return MIPS_COMPARE_AND_SWAP ("<d>", "move");
+    return mips_output_sync_insn (MIPS_COMPARE_AND_SWAP ("<d>", "move"));
 }
   [(set_attr "length" "32")])
 
@@ -76,9 +76,11 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_NONZERO_OP);
+    return (mips_output_sync_insn
+	    (MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_NONZERO_OP)));
   else
-    return MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_ZERO_OP);
+    return (mips_output_sync_insn
+	    (MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_ZERO_OP)));
 }
   [(set_attr "length" "40,36")])
 
@@ -91,9 +93,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_OP ("<d>", "<d>addiu");	
+    return mips_output_sync_insn (MIPS_SYNC_OP ("<d>", "<d>addiu"));
   else
-    return MIPS_SYNC_OP ("<d>", "<d>addu");	
+    return mips_output_sync_insn (MIPS_SYNC_OP ("<d>", "<d>addu"));
 }
   [(set_attr "length" "28")])
 
@@ -124,7 +126,8 @@
    (clobber (match_scratch:SI 4 "=&d"))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_OP_12 ("<insn>", MIPS_SYNC_OP_12_NOT_NOP);	
+    return (mips_output_sync_insn
+	    (MIPS_SYNC_OP_12 ("<insn>", MIPS_SYNC_OP_12_NOT_NOP)));
 }
   [(set_attr "length" "40")])
 
@@ -160,8 +163,9 @@
    (clobber (match_scratch:SI 5 "=&d"))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_OLD_OP_12 ("<insn>", MIPS_SYNC_OLD_OP_12_NOT_NOP,
-				MIPS_SYNC_OLD_OP_12_NOT_NOP_REG);	
+    return (mips_output_sync_insn
+	    (MIPS_SYNC_OLD_OP_12 ("<insn>", MIPS_SYNC_OLD_OP_12_NOT_NOP,
+	     MIPS_SYNC_OLD_OP_12_NOT_NOP_REG)));
 }
   [(set_attr "length" "40")])
 
@@ -202,7 +206,8 @@
 	   (match_dup 4)] UNSPEC_SYNC_NEW_OP_12))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_NEW_OP_12 ("<insn>", MIPS_SYNC_NEW_OP_12_NOT_NOP);
+    return (mips_output_sync_insn
+	    (MIPS_SYNC_NEW_OP_12 ("<insn>", MIPS_SYNC_NEW_OP_12_NOT_NOP)));
 }
   [(set_attr "length" "40")])
 
@@ -233,7 +238,8 @@
    (clobber (match_scratch:SI 4 "=&d"))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_OP_12 ("and", MIPS_SYNC_OP_12_NOT_NOT);	
+    return (mips_output_sync_insn
+	    (MIPS_SYNC_OP_12 ("and", MIPS_SYNC_OP_12_NOT_NOT)));
 }
   [(set_attr "length" "44")])
 
@@ -267,8 +273,9 @@
    (clobber (match_scratch:SI 5 "=&d"))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_OLD_OP_12 ("and", MIPS_SYNC_OLD_OP_12_NOT_NOT,
-				MIPS_SYNC_OLD_OP_12_NOT_NOT_REG);	
+    return (mips_output_sync_insn
+	    (MIPS_SYNC_OLD_OP_12 ("and", MIPS_SYNC_OLD_OP_12_NOT_NOT,
+	     MIPS_SYNC_OLD_OP_12_NOT_NOT_REG)));
 }
   [(set_attr "length" "44")])
 
@@ -307,7 +314,8 @@
 	   (match_dup 4)] UNSPEC_SYNC_NEW_OP_12))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_NEW_OP_12 ("and", MIPS_SYNC_NEW_OP_12_NOT_NOT);
+    return (mips_output_sync_insn
+	    (MIPS_SYNC_NEW_OP_12 ("and", MIPS_SYNC_NEW_OP_12_NOT_NOT)));
 }
   [(set_attr "length" "40")])
 
@@ -319,7 +327,7 @@
 	 UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
-  return MIPS_SYNC_OP ("<d>", "<d>subu");	
+  return mips_output_sync_insn (MIPS_SYNC_OP ("<d>", "<d>subu"));
 }
   [(set_attr "length" "28")])
 
@@ -334,9 +342,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_OLD_OP ("<d>", "<d>addiu");	
+    return mips_output_sync_insn (MIPS_SYNC_OLD_OP ("<d>", "<d>addiu"));
   else
-    return MIPS_SYNC_OLD_OP ("<d>", "<d>addu");	
+    return mips_output_sync_insn (MIPS_SYNC_OLD_OP ("<d>", "<d>addu"));
 }
   [(set_attr "length" "28")])
 
@@ -350,7 +358,7 @@
 	 UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
-  return MIPS_SYNC_OLD_OP ("<d>", "<d>subu");	
+  return mips_output_sync_insn (MIPS_SYNC_OLD_OP ("<d>", "<d>subu"));
 }
   [(set_attr "length" "28")])
 
@@ -365,9 +373,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_NEW_OP ("<d>", "<d>addiu");	
+    return mips_output_sync_insn (MIPS_SYNC_NEW_OP ("<d>", "<d>addiu"));
   else
-    return MIPS_SYNC_NEW_OP ("<d>", "<d>addu");	
+    return mips_output_sync_insn (MIPS_SYNC_NEW_OP ("<d>", "<d>addu"));
 }
   [(set_attr "length" "28")])
 
@@ -381,7 +389,7 @@
 	 UNSPEC_SYNC_NEW_OP))]
   "GENERATE_LL_SC"
 {
-  return MIPS_SYNC_NEW_OP ("<d>", "<d>subu");	
+  return mips_output_sync_insn (MIPS_SYNC_NEW_OP ("<d>", "<d>subu"));
 }
   [(set_attr "length" "28")])
 
@@ -394,9 +402,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_OP ("<d>", "<immediate_insn>");	
+    return mips_output_sync_insn (MIPS_SYNC_OP ("<d>", "<immediate_insn>"));
   else
-    return MIPS_SYNC_OP ("<d>", "<insn>");	
+    return mips_output_sync_insn (MIPS_SYNC_OP ("<d>", "<insn>"));
 }
   [(set_attr "length" "28")])
 
@@ -411,9 +419,11 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_OLD_OP ("<d>", "<immediate_insn>");	
+    return (mips_output_sync_insn
+	    (MIPS_SYNC_OLD_OP ("<d>", "<immediate_insn>")));
   else
-    return MIPS_SYNC_OLD_OP ("<d>", "<insn>");	
+    return (mips_output_sync_insn
+	    (MIPS_SYNC_OLD_OP ("<d>", "<insn>")));
 }
   [(set_attr "length" "28")])
 
@@ -428,9 +438,11 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_NEW_OP ("<d>", "<immediate_insn>");	
+    return (mips_output_sync_insn
+	    (MIPS_SYNC_NEW_OP ("<d>", "<immediate_insn>")));
   else
-    return MIPS_SYNC_NEW_OP ("<d>", "<insn>");	
+    return (mips_output_sync_insn
+	    (MIPS_SYNC_NEW_OP ("<d>", "<insn>")));
 }
   [(set_attr "length" "28")])
 
@@ -441,9 +453,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_NAND ("<d>", "andi");	
+    return mips_output_sync_insn (MIPS_SYNC_NAND ("<d>", "andi"));
   else
-    return MIPS_SYNC_NAND ("<d>", "and");	
+    return mips_output_sync_insn (MIPS_SYNC_NAND ("<d>", "and"));
 }
   [(set_attr "length" "32")])
 
@@ -456,9 +468,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_OLD_NAND ("<d>", "andi");	
+    return mips_output_sync_insn (MIPS_SYNC_OLD_NAND ("<d>", "andi"));
   else
-    return MIPS_SYNC_OLD_NAND ("<d>", "and");	
+    return mips_output_sync_insn (MIPS_SYNC_OLD_NAND ("<d>", "and"));
 }
   [(set_attr "length" "32")])
 
@@ -471,9 +483,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_NEW_NAND ("<d>", "andi");	
+    return mips_output_sync_insn (MIPS_SYNC_NEW_NAND ("<d>", "andi"));
   else
-    return MIPS_SYNC_NEW_NAND ("<d>", "and");	
+    return mips_output_sync_insn (MIPS_SYNC_NEW_NAND ("<d>", "and"));
 }
   [(set_attr "length" "32")])
 
@@ -486,9 +498,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_EXCHANGE ("<d>", "li");
+    return mips_output_sync_insn (MIPS_SYNC_EXCHANGE ("<d>", "li"));
   else
-    return MIPS_SYNC_EXCHANGE ("<d>", "move");
+    return mips_output_sync_insn (MIPS_SYNC_EXCHANGE ("<d>", "move"));
 }
   [(set_attr "length" "24")])
 
@@ -516,8 +528,10 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_EXCHANGE_12 (MIPS_SYNC_EXCHANGE_12_NONZERO_OP);
+    return (mips_output_sync_insn
+	    (MIPS_SYNC_EXCHANGE_12 (MIPS_SYNC_EXCHANGE_12_NONZERO_OP)));
   else
-    return MIPS_SYNC_EXCHANGE_12 (MIPS_SYNC_EXCHANGE_12_ZERO_OP);
+    return (mips_output_sync_insn
+	    (MIPS_SYNC_EXCHANGE_12 (MIPS_SYNC_EXCHANGE_12_ZERO_OP)));
 }
   [(set_attr "length" "28,24")])
diff -Naurp -x .svn gcc.orig/gcc/doc/invoke.texi gcc/gcc/doc/invoke.texi
--- gcc.orig/gcc/doc/invoke.texi	2008-10-30 22:14:29.000000000 -0400
+++ gcc/gcc/doc/invoke.texi	2008-11-14 02:20:06.000000000 -0500
@@ -666,8 +666,9 @@ Objective-C and Objective-C++ Dialects}.
 -mdivide-traps  -mdivide-breaks @gol
 -mmemcpy  -mno-memcpy  -mlong-calls  -mno-long-calls @gol
 -mmad  -mno-mad  -mfused-madd  -mno-fused-madd  -nocpp @gol
--mfix-r4000  -mno-fix-r4000  -mfix-r4400  -mno-fix-r4400 @gol
--mfix-vr4120  -mno-fix-vr4120  -mfix-vr4130  -mno-fix-vr4130 @gol
+-mfix-r4000  -mno-fix-r4000  -mfix-r4400  -mno-fix-r4400
+-mfix-r10000 -mno-fix-r10000 @gol
+-mfix-vr4120  -mno-fix-vr4120 -mfix-vr4130  -mno-fix-vr4130 @gol
 -mfix-sb1  -mno-fix-sb1 @gol
 -mflush-func=@var{func}  -mno-flush-func @gol
 -mbranch-cost=@var{num}  -mbranch-likely  -mno-branch-likely @gol
@@ -12827,6 +12828,20 @@ A double-word or a variable shift may gi
 immediately after starting an integer division.
 @end itemize
 
+@item -mfix-r10000
+@itemx -mno-fix-r10000
+@opindex mfix-r10000
+@opindex mno-fix-r10000
+LL/SC workaround for R10000 errata in specific revisions of the CPU
+silicon.  Revs before 3.0 will misbehave on atomic operations, and revs
+2.6 and below will deadlock due to other conflicting errata.
+
+This workaround only works for MIPS-II and above binaries due to the
+use of branch-likely instructions (@code{beql}, @code{beqzl}).  Although
+a workaround exists for MIPS-I, it is not implemented by this flag.
+
+This flag is enabled by default when @code{-march=r10000} is used.
+
 @item -mfix-vr4120
 @itemx -mno-fix-vr4120
 @opindex mfix-vr4120
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-1.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-1.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-1.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-1.c	2008-11-14 02:31:54.000000000 -0500
@@ -0,0 +1,11 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_fetch_and_add (&z, 42);
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-10.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-10.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-10.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-10.c	2008-11-14 02:34:02.000000000 -0500
@@ -0,0 +1,11 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_and_and_fetch (&z, 42);
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-11.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-11.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-11.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-11.c	2008-11-14 02:34:07.000000000 -0500
@@ -0,0 +1,11 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_xor_and_fetch (&z, 42);
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-12.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-12.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-12.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-12.c	2008-11-14 02:34:12.000000000 -0500
@@ -0,0 +1,11 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_nand_and_fetch (&z, 42);
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-13.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-13.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-13.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-13.c	2008-11-14 02:34:18.000000000 -0500
@@ -0,0 +1,11 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_bool_compare_and_swap (&z, 0, 42);
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-14.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-14.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-14.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-14.c	2008-11-14 02:34:24.000000000 -0500
@@ -0,0 +1,11 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_val_compare_and_swap (&z, 0, 42);
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-15.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-15.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-15.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-15.c	2008-11-14 02:34:31.000000000 -0500
@@ -0,0 +1,9 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  __sync_synchronize ();
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-16.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-16.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-16.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-16.c	2008-11-14 02:34:37.000000000 -0500
@@ -0,0 +1,12 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_lock_test_and_set (&z, 42);
+  __sync_lock_release (&z);
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-2.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-2.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-2.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-2.c	2008-11-14 02:33:10.000000000 -0500
@@ -0,0 +1,11 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_fetch_and_sub (&z, 42);
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-3.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-3.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-3.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-3.c	2008-11-14 02:33:17.000000000 -0500
@@ -0,0 +1,11 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_fetch_and_or (&z, 42);
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-4.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-4.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-4.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-4.c	2008-11-14 02:33:23.000000000 -0500
@@ -0,0 +1,11 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_fetch_and_and (&z, 42);
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-5.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-5.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-5.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-5.c	2008-11-14 02:33:30.000000000 -0500
@@ -0,0 +1,11 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_fetch_and_xor (&z, 42);
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-6.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-6.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-6.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-6.c	2008-11-14 02:33:37.000000000 -0500
@@ -0,0 +1,11 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_fetch_and_nand (&z, 42);
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-7.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-7.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-7.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-7.c	2008-11-14 02:33:42.000000000 -0500
@@ -0,0 +1,11 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_add_and_fetch (&z, 42);
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-8.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-8.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-8.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-8.c	2008-11-14 02:33:49.000000000 -0500
@@ -0,0 +1,11 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_sub_and_fetch (&z, 42);
+}
diff -Naurp -x .svn gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-9.c gcc/gcc/testsuite/gcc.target/mips/fix-r10000-9.c
--- gcc.orig/gcc/testsuite/gcc.target/mips/fix-r10000-9.c	1969-12-31 19:00:00.000000000 -0500
+++ gcc/gcc/testsuite/gcc.target/mips/fix-r10000-9.c	2008-11-14 02:33:55.000000000 -0500
@@ -0,0 +1,11 @@
+/* { dg-do compile } */
+/* { dg-mips-options "-O2 -march=mips4 -mfix-r10000" } */
+/* { dg-final { scan-assembler "beql" } } */
+
+NOMIPS16 void
+foo(void)
+{
+  unsigned z = 0;
+
+  __sync_or_and_fetch (&z, 42);
+}

--------------090502080603080804000600--
