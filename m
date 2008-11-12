Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2008 07:43:47 +0000 (GMT)
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:45027
	"EHLO QMTA03.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S23628533AbYKLHni (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2008 07:43:38 +0000
Received: from OMTA08.westchester.pa.mail.comcast.net ([76.96.62.12])
	by QMTA03.westchester.pa.mail.comcast.net with comcast
	id e7hG1a0010Fqzac537imXb; Wed, 12 Nov 2008 07:42:46 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA08.westchester.pa.mail.comcast.net with comcast
	id e7jW1a00558Be2l3U7jW01; Wed, 12 Nov 2008 07:43:31 +0000
X-Authority-Analysis: v=1.0 c=1 a=se7utVhDntQA:10 a=sj6Exy8oVBoA:10
 a=WPyIoOwQAAAA:8 a=QIHjKqQ_4HL_ek7RakMA:9 a=go86DtDi8H-htgtFu1wA:7
 a=IeaKFkrs1-R-pXT54JTbs6iwj1wA:4 a=w6-myHctKckA:10 a=aclI5Qez4f4A:10
 a=WeOa-AV5lc8A:10 a=4iXfik_MsjQA:10 a=hd5ZDugPuapMM0Cr4_kA:9
 a=ccaTfJmyXdJaTbwfyVgA:7 a=CAMrh00p4NudUoEp8BEBBHFo7BoA:4 a=mylFLmerCdIA:10
 a=vhuCkwUcEWQA:10 a=NfA2RSpTaHsA:10
Message-ID: <491A88E8.3050108@gentoo.org>
Date:	Wed, 12 Nov 2008 02:42:32 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	gcc-patches@gcc.gnu.org
CC:	Linux MIPS List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org>	<87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org>	<87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org>	<87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org>	<87myggilk2.fsf@firetop.home> <490FF63A.7010900@gentoo.org>	<8763mypnhf.fsf@firetop.home> <4917D01B.8080508@gentoo.org> <87y6zphn5b.fsf@firetop.home>
In-Reply-To: <87y6zphn5b.fsf@firetop.home>
Content-Type: multipart/mixed;
 boundary="------------020103000405010503040500"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020103000405010503040500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Richard Sandiford wrote:
> 
> The first version looks good, except for a couple of formatting
> issues.  The second version doesn't work: those static mips_branch_likely
> variables are local to insn-output.c, so mips.c:print_operand will never
> see them.

Yeah, I'm going to drop the second patch now that I know the genautomata thing 
is a regression of some sort.


> Nitlet, but "to see" is redundant.  Maybe:
> 
>   /* Make sure that branch-likely instructions available when using
>      -mfix-r10000.  The instructions are not available if either:
> 
> 	1. -mno-branch-likely was passed.
> 	2. The selected ISA does not support branch-likely and
> 	   the command line does not include -mbranch-likely.  */
> 

Fixed.


> Should just be:
> 
>   if (TARGET_FIX_R10000
>       && ((target_flags_explicit & MASK_BRANCHLIKELY) == 0
>           ? !ISA_HAS_BRANCHLIKELY
>           : !TARGET_BRANCHLIKEL))
>     sorry ("branch-likely instructions not available");
> 
> And the check should go after...

Fixed & Done.


> (Which I suppose raises the question: should
> 
>   -march=r10000 -mno-branch-likely
> 
> be an error, or should it silently disable -mfix-r10000?  My vote is
> for "error".  You can always write -march=r10000 -mno-branch-likely
> -mno-fix-r10000 is that's really what you mean.
> 
> The suggested change -- swapping these two blocks around -- should do that.)

Well, the check I moved around is only calling sorry(), stating that 
branch-likely isn't available.  Would additional checking be needed to 
specifically look for -march=r10000 -mno-branch-likely (and not 
-mno-fix-r10000), and then raise error() instead, warning the user about the 
invalid flag combinations (and listing them, so they don't scratch their heads 
wondering why, should such logic be buried deep in a Makefile)?  Or should the 
sorry message be made more verbose? (It looks like it completes part of a 
sentence, so I mimed the grammar I saw in other uses of it).

Also, what about cases where -march=r12000 is passed?  GCC right now has no 
technical difference between r10k through r16k (they all map to r10k for 
scheduling, per my scheduling patch), but r12k and up should have this problem 
fixed, and thus not need it.  Do we need to go that far in addressing obscure 
combinations of the flags?

Perhaps:

if ((mips_matching_cpu_name_p (mips_arch_info->name, "r12000") ||
      mips_matching_cpu_name_p (mips_arch_info->name, "r14000") ||
      mips_matching_cpu_name_p (mips_arch_info->name, "r16000"))
     && TARGET_FIX_R10000)
{
   sorry ("R10000 Errata fix not necessary on R12000 and greater CPUs");
}


> Break lines longer than 80 chars.  Here and elsewhere, it's probably
> best to use:
> 
>   return (mips_output_sync_insn
>           (...stuff...));

Done.  I used parenthesis on all the return statements, even if they stayed on 
one line, for consistency.  Any qualms with that?  Some of the lines are just 
shy of the 80-char limit by 2-4 chars, so having the parans there I suppose can 
preempt any future changes that might necessitate a newline + indentation being 
added.


> Looks good otherwise, thanks.  We just need to sort out the build
> problem.

I added to that bug you mentioned (in another mail), as I determined that the 
problem flag is -foptimize-sibling-calls combined with -O1.  With -O0, it will 
run just fine, so there's another one or more flags enabled by -O1 that are 
causing the fluke.  No idea if it's genautomata itself, since I peeked into SVN 
and that source file hasn't seen any activity in two months.  I figure it must 
be one of the other files that get linked in.

I'm running a build now on my x86 box to see if I hit the same error there, or 
if this is limited only to mips (the bugs suggests it might, but one never knows).


Also, what about a test case?  This is pretty dangerous on Rev 2.5 R10Ks, 
potentially locking them up, so I don't know if a testcase would be necessary. 
No idea if there is a "safer" way to check for this flaw and recover from it. 
The below link is the snippet of code that reliably hung an IP28 machine:

http://www.linux-mips.org/archives/linux-mips/2008-01/msg00186.html


Thanks!

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

--------------020103000405010503040500
Content-Type: text/plain;
 name="gcc-4.4-trunk-fixr10k-z3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gcc-4.4-trunk-fixr10k-z3.patch"

diff -Naurp -x .svn gcc.orig/gcc/config/mips/mips.c gcc/gcc/config/mips/mips.c
--- gcc.orig/gcc/config/mips/mips.c	2008-11-06 00:35:19.000000000 -0500
+++ gcc/gcc/config/mips/mips.c	2008-11-11 22:44:27.000000000 -0500
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
 
@@ -13971,6 +13988,23 @@ mips_override_options (void)
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
+	1. -mno-branch-likely was passed.
+	2. The selected ISA does not support branch-likely and
+	   the command line does not include -mbranch-likely  */
+  if (TARGET_FIX_R10000
+      && ((target_flags_explicit & MASK_BRANCHLIKELY) == 0
+          ? !ISA_HAS_BRANCHLIKELY
+          : !TARGET_BRANCHLIKEL))
+    sorry ("branch-likely instructions not available");
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
+++ gcc/gcc/config/mips/sync.md	2008-11-11 22:58:06.000000000 -0500
@@ -43,9 +43,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_COMPARE_AND_SWAP ("<d>", "li");
+    return (mips_output_sync_insn (MIPS_COMPARE_AND_SWAP ("<d>", "li")));
   else
-    return MIPS_COMPARE_AND_SWAP ("<d>", "move");
+    return (mips_output_sync_insn (MIPS_COMPARE_AND_SWAP ("<d>", "move")));
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
+    return (mips_output_sync_insn (MIPS_SYNC_OP ("<d>", "<d>addiu")));
   else
-    return MIPS_SYNC_OP ("<d>", "<d>addu");	
+    return (mips_output_sync_insn (MIPS_SYNC_OP ("<d>", "<d>addu")));
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
+  return (mips_output_sync_insn (MIPS_SYNC_OP ("<d>", "<d>subu")));
 }
   [(set_attr "length" "28")])
 
@@ -334,9 +342,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_OLD_OP ("<d>", "<d>addiu");	
+    return (mips_output_sync_insn (MIPS_SYNC_OLD_OP ("<d>", "<d>addiu")));
   else
-    return MIPS_SYNC_OLD_OP ("<d>", "<d>addu");	
+    return (mips_output_sync_insn (MIPS_SYNC_OLD_OP ("<d>", "<d>addu")));
 }
   [(set_attr "length" "28")])
 
@@ -350,7 +358,7 @@
 	 UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
-  return MIPS_SYNC_OLD_OP ("<d>", "<d>subu");	
+  return (mips_output_sync_insn (MIPS_SYNC_OLD_OP ("<d>", "<d>subu")));
 }
   [(set_attr "length" "28")])
 
@@ -365,9 +373,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_NEW_OP ("<d>", "<d>addiu");	
+    return (mips_output_sync_insn (MIPS_SYNC_NEW_OP ("<d>", "<d>addiu")));
   else
-    return MIPS_SYNC_NEW_OP ("<d>", "<d>addu");	
+    return (mips_output_sync_insn (MIPS_SYNC_NEW_OP ("<d>", "<d>addu")));
 }
   [(set_attr "length" "28")])
 
@@ -381,7 +389,7 @@
 	 UNSPEC_SYNC_NEW_OP))]
   "GENERATE_LL_SC"
 {
-  return MIPS_SYNC_NEW_OP ("<d>", "<d>subu");	
+  return (mips_output_sync_insn (MIPS_SYNC_NEW_OP ("<d>", "<d>subu")));
 }
   [(set_attr "length" "28")])
 
@@ -394,9 +402,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_OP ("<d>", "<immediate_insn>");	
+    return (mips_output_sync_insn (MIPS_SYNC_OP ("<d>", "<immediate_insn>")));
   else
-    return MIPS_SYNC_OP ("<d>", "<insn>");	
+    return (mips_output_sync_insn (MIPS_SYNC_OP ("<d>", "<insn>")));
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
+    return (mips_output_sync_insn (MIPS_SYNC_NAND ("<d>", "andi")));
   else
-    return MIPS_SYNC_NAND ("<d>", "and");	
+    return (mips_output_sync_insn (MIPS_SYNC_NAND ("<d>", "and")));
 }
   [(set_attr "length" "32")])
 
@@ -456,9 +468,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_OLD_NAND ("<d>", "andi");	
+    return (mips_output_sync_insn (MIPS_SYNC_OLD_NAND ("<d>", "andi")));
   else
-    return MIPS_SYNC_OLD_NAND ("<d>", "and");	
+    return (mips_output_sync_insn (MIPS_SYNC_OLD_NAND ("<d>", "and")));
 }
   [(set_attr "length" "32")])
 
@@ -471,9 +483,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_NEW_NAND ("<d>", "andi");	
+    return (mips_output_sync_insn (MIPS_SYNC_NEW_NAND ("<d>", "andi")));
   else
-    return MIPS_SYNC_NEW_NAND ("<d>", "and");	
+    return (mips_output_sync_insn (MIPS_SYNC_NEW_NAND ("<d>", "and")));
 }
   [(set_attr "length" "32")])
 
@@ -486,9 +498,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_EXCHANGE ("<d>", "li");
+    return (mips_output_sync_insn (MIPS_SYNC_EXCHANGE ("<d>", "li")));
   else
-    return MIPS_SYNC_EXCHANGE ("<d>", "move");
+    return (mips_output_sync_insn (MIPS_SYNC_EXCHANGE ("<d>", "move")));
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
+++ gcc/gcc/doc/invoke.texi	2008-11-11 22:38:37.000000000 -0500
@@ -666,7 +666,7 @@ Objective-C and Objective-C++ Dialects}.
 -mdivide-traps  -mdivide-breaks @gol
 -mmemcpy  -mno-memcpy  -mlong-calls  -mno-long-calls @gol
 -mmad  -mno-mad  -mfused-madd  -mno-fused-madd  -nocpp @gol
--mfix-r4000  -mno-fix-r4000  -mfix-r4400  -mno-fix-r4400 @gol
+-mfix-r4000  -mno-fix-r4000  -mfix-r4400  -mno-fix-r4400 -mfix-r10000 -mno-fix-r10000 @gol
 -mfix-vr4120  -mno-fix-vr4120  -mfix-vr4130  -mno-fix-vr4130 @gol
 -mfix-sb1  -mno-fix-sb1 @gol
 -mflush-func=@var{func}  -mno-flush-func @gol

--------------020103000405010503040500--
