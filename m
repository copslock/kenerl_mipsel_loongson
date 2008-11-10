Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2008 06:10:31 +0000 (GMT)
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:25581
	"EHLO QMTA01.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S23487377AbYKJGK0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2008 06:10:26 +0000
Received: from OMTA08.westchester.pa.mail.comcast.net ([76.96.62.12])
	by QMTA01.westchester.pa.mail.comcast.net with comcast
	id dJ7r1a0030Fqzac51JAK6E; Mon, 10 Nov 2008 06:10:19 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA08.westchester.pa.mail.comcast.net with comcast
	id dJAJ1a00358Be2l3UJAJAK; Mon, 10 Nov 2008 06:10:19 +0000
X-Authority-Analysis: v=1.0 c=1 a=se7utVhDntQA:10 a=sj6Exy8oVBoA:10
 a=TM4QF-CV3ApqrFGkac4A:9 a=HEpt_0ue3Z8Fyi2k6IEA:7
 a=M3L59knwdKb3tAer_KIkpBVTAOUA:4 a=w6-myHctKckA:10 a=WeOa-AV5lc8A:10
 a=4iXfik_MsjQA:10 a=hd5ZDugPuapMM0Cr4_kA:9 a=3BcQn6lpcM_tRnhoCAoA:7
 a=noIq93Pr2dnfIYHfnrsaEeU7z90A:4 a=oVP8SKXuTwoA:10 a=tFnb6wovh8EA:10
 a=mylFLmerCdIA:10 a=vhuCkwUcEWQA:10 a=NfA2RSpTaHsA:10
 a=jAUcCuUMnAv2-L_zwfMA:9 a=cVP2Ca7bBscggBpVWIoA:7
 a=ADDSMoQASUuom2_ylhlQlov6kjwA:4
Message-ID: <4917D01B.8080508@gentoo.org>
Date:	Mon, 10 Nov 2008 01:09:31 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	gcc-patches@gcc.gnu.org
CC:	Linux MIPS List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org>	<87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org>	<87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org>	<87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org>	<87myggilk2.fsf@firetop.home> <490FF63A.7010900@gentoo.org> <8763mypnhf.fsf@firetop.home>
In-Reply-To: <8763mypnhf.fsf@firetop.home>
Content-Type: multipart/mixed;
 boundary="------------090103070700080004080404"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090103070700080004080404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Richard Sandiford wrote:
> 
> I'm not sure I have the statistical knowledge either.  I've tended
> to work in embedded environments where -march=<my cpu> is almost always
> the right option to use.  But like Maciej, I suspect it isn't worth
> supporting the combination.  So my preference is for option #1.
> 
> You make a convincing case that the combination isn't useful for current
> Linux distributions.  And it isn't useful for IRIX 6 either: the o32
> system libraries are -mips2 rather than -mips1, and both GCC and
> MIPSpro default to -mips2 for o32.

Yeah, trying to handle MIPS-I stuff looks like it'll be above my head for now, 
so I'm going to aim at the second option after all.

FYI, I explain about the two different patches attached to this below.  They're 
not final by any means, but I'm doing something wrong somewhere in both them.


> Also, I believe the glibc patch doesn't cope with -mips1 -mllsc either.
> Is that right?  If so, that's another reason not to worry about it
> for GCC.

It doesn't as I coded it.  I plan on addressing that patch after the gcc-side of 
things.  Ralf suggested in that patch on libc-ports that I handle the MIPS-I 
case there, though, but if we're not going to support it in the gcc patch, then 
it probably isn't needed in the glibc patch either.  We'll see, though!


> mips_branch_likely only applies to the _current_ insn, so it needs
> to go before any call the macro templates.  Please use a helper
> function such as:
> 
> const char *
> mips_output_sync_insn (const char *template)
> {
>   mips_branch_likely = TARGET_FIX_R10000;
>   return template;
> }
> 

Done.  This is referenced in the first patch (gcc-4.4-trunk-fixr10k-z1.patch). 
The second patch (gcc-4.4-trunk-fixr10k-z2.patch) contains a form whereby I just 
re-declared mips_branch_likely and set it once-per template.  More on this below.


> Yeah, looks good.  I'm a bit worried about running of % characters,
> but like I say, we could always replace the templates with individual
> output_asm_insns at some point in the future.

Yeah, ~ is one of the last characters that doesn't seem to be completely used up 
and looks good.  That still leaves !, &, {, }, and a comma.  But those could 
look confusing with surrounding characters.




So about the two patches.  Both of these appears to accomplish the job, and 
allow gcc to begin compiling, but at one point about two hours into the build, 
genautomata will segfault when attempting to output tmp-automata.c.  I don't 
know which stage this is in...it's one of the early stages, and it's using xgcc 
at this point.

I tried running gdb on that particular invocation of genautomata, but it there's 
not much data I could gather, since the -O2 optimization removes some of the 
useful debugging info.  It segfaults at an fprintf() invocation, and 
tmp-automata.c is 0 bytes.

Here's the last few lines I get:

/usr/cvsroot/gcc/host-mips-unknown-linux-gnu/prev-gcc/xgcc 
-B/usr/cvsroot/gcc/host-mips-unknown-linux-gnu/prev-gcc/ 
-B/usr//mips-unknown-linux-gnu/bin/  -g -O2 -DIN_GCC   -W -Wall -Wwrite-strings 
-Wstrict-prototypes -Wmissing-prototypes -Wcast-qual -Wold-style-definition 
-Wc++-compat -Wmissing-format-attribute -pedantic -Wno-long-long 
-Wno-variadic-macros -Wno-overlength-strings   -DHAVE_CONFIG_H -DGENERATOR_FILE 
  -o build/genautomata \
             build/genautomata.o build/rtl.o build/read-rtl.o build/ggc-none.o 
build/vec.o build/min-insn-modes.o build/gensupport.o build/print-rtl.o 
build/errors.o ../../host-mips-unknown-linux-gnu/libiberty/libiberty.a -lm
build/genautomata ../.././gcc/config/mips/mips.md \
           insn-conditions.md > tmp-automata.c
/bin/sh: line 1: 28620 Segmentation fault      build/genautomata 
../.././gcc/config/mips/mips.md insn-conditions.md > tmp-automata.c
make[3]: *** [s-automata] Error 139
make[3]: Leaving directory `/usr/cvsroot/gcc/host-mips-unknown-linux-gnu/gcc'
make[2]: *** [all-stage2-gcc] Error 2
make[2]: Leaving directory `/usr/cvsroot/gcc'
make[1]: *** [stage2-bubble] Error 2
make[1]: Leaving directory `/usr/cvsroot/gcc'
make: *** [all] Error 2


I thought at first, it was the use of the helper function, so I backed that out 
and went with the form seen in the second patch, but that didn't help things 
either.  So I'm assuming this is related to the changes to the atomic macro 
templates, and xgcc must have something inside itself that's a little wonky. 
Not real sure how to approach this.

However, there's more.  If I rebuild genautomata by hand (using args from the 
command line), and I drop the optimization down a notch to -O1, then I can run 
the command to create tmp-automata.c, and it'll complete successfully (and the 
output in that file looks good).  So I'm a bit baffled.  I assume the issue is 
caused by my patch, unless I'm running into a regression in trunk that my patch 
simply exposes.

Is there another way to maybe extract some info on what's causing this?


Thanks!

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

--------------090103070700080004080404
Content-Type: text/plain;
 name="gcc-4.4-trunk-fixr10k-z1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gcc-4.4-trunk-fixr10k-z1.patch"

diff -Naurp -x .svn gcc.orig/gcc/config/mips/mips.c gcc/gcc/config/mips/mips.c
--- gcc.orig/gcc/config/mips/mips.c	2008-11-06 00:35:19.000000000 -0500
+++ gcc/gcc/config/mips/mips.c	2008-11-09 02:10:40.000000000 -0500
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
 
@@ -13824,6 +13841,17 @@ mips_override_options (void)
     warning (0, "the %qs architecture does not support branch-likely"
 	     " instructions", mips_arch_info->name);
 
+  /* Check to see whether branch-likely instructions are not available
+     when using -mfix-r10000.  This will be true if:
+	1. -mno-branch-likely was passed.
+	2. The selected ISA does not support branch-likely and
+	   the command line does not include -mbranch-likely  */
+  if ((TARGET_FIX_R10000
+       && (target_flags_explicit & MASK_BRANCHLIKELY) == 0)
+          ? !ISA_HAS_BRANCHLIKELY
+          ? !TARGET_BRANCHLIKELY : false : false)
+    sorry ("branch-likely instructions not available");
+
   /* The effect of -mabicalls isn't defined for the EABI.  */
   if (mips_abi == ABI_EABI && TARGET_ABICALLS)
     {
@@ -13971,6 +13999,12 @@ mips_override_options (void)
       && mips_matching_cpu_name_p (mips_arch_info->name, "r4400"))
     target_flags |= MASK_FIX_R4400;
 
+  /* Default to working around R10000 errata only if the processor
+     was selected explicitly.  */
+  if ((target_flags_explicit & MASK_FIX_R10000) == 0
+      && mips_matching_cpu_name_p (mips_arch_info->name, "r10000"))
+    target_flags |= MASK_FIX_R10000;
+
   /* Save base state of options.  */
   mips_base_target_flags = target_flags;
   mips_base_delayed_branch = flag_delayed_branch;
diff -Naurp -x .svn gcc.orig/gcc/config/mips/mips.h gcc/gcc/config/mips/mips.h
--- gcc.orig/gcc/config/mips/mips.h	2008-11-01 13:21:41.000000000 -0400
+++ gcc/gcc/config/mips/mips.h	2008-11-09 02:10:40.000000000 -0500
@@ -3083,7 +3083,7 @@ while (0)
   "\tbne\t%0,%z2,2f\n"				\
   "\t" OP "\t%@,%3\n"				\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)\n"				\
   "2:\n"
@@ -3108,7 +3108,7 @@ while (0)
   "\tand\t%@,%0,%3\n"				\
   OPS						\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)\n"				\
   "2:\n"
@@ -3128,7 +3128,7 @@ while (0)
   "1:\tll" SUFFIX "\t%@,%0\n"			\
   "\t" INSN "\t%@,%@,%1\n"			\
   "\tsc" SUFFIX "\t%@,%0\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3153,7 +3153,7 @@ while (0)
   "\tand\t%4,%4,%1\n"				\
   "\tor\t%@,%@,%4\n"				\
   "\tsc\t%@,%0\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3186,7 +3186,7 @@ while (0)
   "\tand\t%5,%5,%2\n"				\
   "\tor\t%@,%@,%5\n"				\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3216,7 +3216,7 @@ while (0)
   "\tand\t%0,%0,%2\n"				\
   "\tor\t%@,%@,%0\n"				\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3236,7 +3236,7 @@ while (0)
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3253,7 +3253,7 @@ while (0)
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b%~\n"			\
   "\t" INSN "\t%0,%0,%2\n"			\
   "\tsync%-%]%>%)"
 
@@ -3270,7 +3270,7 @@ while (0)
   "\tnor\t%@,%@,%.\n"				\
   "\t" INSN "\t%@,%@,%1\n"			\
   "\tsc" SUFFIX "\t%@,%0\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3289,7 +3289,7 @@ while (0)
   "\tnor\t%@,%0,%.\n"				\
   "\t" INSN "\t%@,%@,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3308,7 +3308,7 @@ while (0)
   "\tnor\t%0,%0,%.\n"				\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b%~\n"			\
   "\t" INSN "\t%0,%0,%2\n"			\
   "\tsync%-%]%>%)"
 
@@ -3326,7 +3326,7 @@ while (0)
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" OP "\t%@,%2\n"				\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3350,7 +3350,7 @@ while (0)
   "\tand\t%@,%0,%3\n"				\
   OPS						\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
diff -Naurp -x .svn gcc.orig/gcc/config/mips/mips.opt gcc/gcc/config/mips/mips.opt
--- gcc.orig/gcc/config/mips/mips.opt	2008-10-30 22:20:27.000000000 -0400
+++ gcc/gcc/config/mips/mips.opt	2008-11-09 02:10:40.000000000 -0500
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
+++ gcc/gcc/config/mips/sync.md	2008-11-09 02:10:40.000000000 -0500
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
 
@@ -76,9 +76,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_NONZERO_OP);
+    return mips_output_sync_insn (MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_NONZERO_OP));
   else
-    return MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_ZERO_OP);
+    return mips_output_sync_insn (MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_ZERO_OP));
 }
   [(set_attr "length" "40,36")])
 
@@ -91,9 +91,9 @@
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
 
@@ -124,7 +124,7 @@
    (clobber (match_scratch:SI 4 "=&d"))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_OP_12 ("<insn>", MIPS_SYNC_OP_12_NOT_NOP);	
+    return mips_output_sync_insn (MIPS_SYNC_OP_12 ("<insn>", MIPS_SYNC_OP_12_NOT_NOP));
 }
   [(set_attr "length" "40")])
 
@@ -160,8 +160,9 @@
    (clobber (match_scratch:SI 5 "=&d"))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_OLD_OP_12 ("<insn>", MIPS_SYNC_OLD_OP_12_NOT_NOP,
-				MIPS_SYNC_OLD_OP_12_NOT_NOP_REG);	
+    return mips_output_sync_insn (MIPS_SYNC_OLD_OP_12 ("<insn>",
+				    MIPS_SYNC_OLD_OP_12_NOT_NOP,
+				    MIPS_SYNC_OLD_OP_12_NOT_NOP_REG));	
 }
   [(set_attr "length" "40")])
 
@@ -202,7 +203,8 @@
 	   (match_dup 4)] UNSPEC_SYNC_NEW_OP_12))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_NEW_OP_12 ("<insn>", MIPS_SYNC_NEW_OP_12_NOT_NOP);
+    return mips_output_sync_insn (MIPS_SYNC_NEW_OP_12 ("<insn>",
+				    MIPS_SYNC_NEW_OP_12_NOT_NOP));
 }
   [(set_attr "length" "40")])
 
@@ -233,7 +235,8 @@
    (clobber (match_scratch:SI 4 "=&d"))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_OP_12 ("and", MIPS_SYNC_OP_12_NOT_NOT);	
+    return mips_output_sync_insn (MIPS_SYNC_OP_12 ("and",
+				    MIPS_SYNC_OP_12_NOT_NOT));	
 }
   [(set_attr "length" "44")])
 
@@ -267,8 +270,9 @@
    (clobber (match_scratch:SI 5 "=&d"))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_OLD_OP_12 ("and", MIPS_SYNC_OLD_OP_12_NOT_NOT,
-				MIPS_SYNC_OLD_OP_12_NOT_NOT_REG);	
+    return mips_output_sync_insn (MIPS_SYNC_OLD_OP_12 ("and",
+				    MIPS_SYNC_OLD_OP_12_NOT_NOT,
+				    MIPS_SYNC_OLD_OP_12_NOT_NOT_REG));	
 }
   [(set_attr "length" "44")])
 
@@ -307,7 +311,8 @@
 	   (match_dup 4)] UNSPEC_SYNC_NEW_OP_12))]
   "GENERATE_LL_SC"
 {
-    return MIPS_SYNC_NEW_OP_12 ("and", MIPS_SYNC_NEW_OP_12_NOT_NOT);
+    return mips_output_sync_insn (MIPS_SYNC_NEW_OP_12 ("and",
+				    MIPS_SYNC_NEW_OP_12_NOT_NOT));
 }
   [(set_attr "length" "40")])
 
@@ -319,7 +324,7 @@
 	 UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
-  return MIPS_SYNC_OP ("<d>", "<d>subu");	
+  return mips_output_sync_insn (MIPS_SYNC_OP ("<d>", "<d>subu"));	
 }
   [(set_attr "length" "28")])
 
@@ -334,9 +339,9 @@
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
 
@@ -350,7 +355,7 @@
 	 UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
-  return MIPS_SYNC_OLD_OP ("<d>", "<d>subu");	
+  return mips_output_sync_insn (MIPS_SYNC_OLD_OP ("<d>", "<d>subu"));	
 }
   [(set_attr "length" "28")])
 
@@ -365,9 +370,9 @@
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
 
@@ -381,7 +386,7 @@
 	 UNSPEC_SYNC_NEW_OP))]
   "GENERATE_LL_SC"
 {
-  return MIPS_SYNC_NEW_OP ("<d>", "<d>subu");	
+  return mips_output_sync_insn (MIPS_SYNC_NEW_OP ("<d>", "<d>subu"));	
 }
   [(set_attr "length" "28")])
 
@@ -394,9 +399,9 @@
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
 
@@ -411,9 +416,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_OLD_OP ("<d>", "<immediate_insn>");	
+    return mips_output_sync_insn (MIPS_SYNC_OLD_OP ("<d>", "<immediate_insn>"));	
   else
-    return MIPS_SYNC_OLD_OP ("<d>", "<insn>");	
+    return mips_output_sync_insn (MIPS_SYNC_OLD_OP ("<d>", "<insn>"));	
 }
   [(set_attr "length" "28")])
 
@@ -428,9 +433,9 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_NEW_OP ("<d>", "<immediate_insn>");	
+    return mips_output_sync_insn (MIPS_SYNC_NEW_OP ("<d>", "<immediate_insn>"));	
   else
-    return MIPS_SYNC_NEW_OP ("<d>", "<insn>");	
+    return mips_output_sync_insn (MIPS_SYNC_NEW_OP ("<d>", "<insn>"));	
 }
   [(set_attr "length" "28")])
 
@@ -441,9 +446,9 @@
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
 
@@ -456,9 +461,9 @@
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
 
@@ -471,9 +476,9 @@
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
 
@@ -486,9 +491,9 @@
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
 
@@ -516,8 +521,8 @@
   "GENERATE_LL_SC"
 {
   if (which_alternative == 0)
-    return MIPS_SYNC_EXCHANGE_12 (MIPS_SYNC_EXCHANGE_12_NONZERO_OP);
+    return mips_output_sync_insn (MIPS_SYNC_EXCHANGE_12 (MIPS_SYNC_EXCHANGE_12_NONZERO_OP));
   else
-    return MIPS_SYNC_EXCHANGE_12 (MIPS_SYNC_EXCHANGE_12_ZERO_OP);
+    return mips_output_sync_insn (MIPS_SYNC_EXCHANGE_12 (MIPS_SYNC_EXCHANGE_12_ZERO_OP));
 }
   [(set_attr "length" "28,24")])
diff -Naurp -x .svn gcc.orig/gcc/doc/invoke.texi gcc/gcc/doc/invoke.texi
--- gcc.orig/gcc/doc/invoke.texi	2008-10-30 22:14:29.000000000 -0400
+++ gcc/gcc/doc/invoke.texi	2008-11-03 02:15:16.000000000 -0500
@@ -666,7 +666,7 @@ Objective-C and Objective-C++ Dialects}.
 -mdivide-traps  -mdivide-breaks @gol
 -mmemcpy  -mno-memcpy  -mlong-calls  -mno-long-calls @gol
 -mmad  -mno-mad  -mfused-madd  -mno-fused-madd  -nocpp @gol
--mfix-r4000  -mno-fix-r4000  -mfix-r4400  -mno-fix-r4400 @gol
+-mfix-r4000  -mno-fix-r4000  -mfix-r4400  -mno-fix-r4400 -mfix-r10000 -mno-fix-r10000 @gol
 -mfix-vr4120  -mno-fix-vr4120  -mfix-vr4130  -mno-fix-vr4130 @gol
 -mfix-sb1  -mno-fix-sb1 @gol
 -mflush-func=@var{func}  -mno-flush-func @gol

--------------090103070700080004080404
Content-Type: text/plain;
 name="gcc-4.4-trunk-fixr10k-z2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gcc-4.4-trunk-fixr10k-z2.patch"

diff -Naurp -x .svn gcc.orig/gcc/config/mips/mips.c gcc/gcc/config/mips/mips.c
--- gcc.orig/gcc/config/mips/mips.c	2008-11-06 00:35:19.000000000 -0500
+++ gcc/gcc/config/mips/mips.c	2008-11-09 23:05:02.000000000 -0500
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
 
@@ -13824,6 +13830,17 @@ mips_override_options (void)
     warning (0, "the %qs architecture does not support branch-likely"
 	     " instructions", mips_arch_info->name);
 
+  /* Check to see whether branch-likely instructions are not available
+     when using -mfix-r10000.  This will be true if:
+	1. -mno-branch-likely was passed.
+	2. The selected ISA does not support branch-likely and
+	   the command line does not include -mbranch-likely  */
+  if ((TARGET_FIX_R10000
+       && (target_flags_explicit & MASK_BRANCHLIKELY) == 0)
+          ? !ISA_HAS_BRANCHLIKELY
+          ? !TARGET_BRANCHLIKELY : false : false)
+    sorry ("branch-likely instructions not available");
+
   /* The effect of -mabicalls isn't defined for the EABI.  */
   if (mips_abi == ABI_EABI && TARGET_ABICALLS)
     {
@@ -13971,6 +13988,12 @@ mips_override_options (void)
       && mips_matching_cpu_name_p (mips_arch_info->name, "r4400"))
     target_flags |= MASK_FIX_R4400;
 
+  /* Default to working around R10000 errata only if the processor
+     was selected explicitly.  */
+  if ((target_flags_explicit & MASK_FIX_R10000) == 0
+      && mips_matching_cpu_name_p (mips_arch_info->name, "r10000"))
+    target_flags |= MASK_FIX_R10000;
+
   /* Save base state of options.  */
   mips_base_target_flags = target_flags;
   mips_base_delayed_branch = flag_delayed_branch;
diff -Naurp -x .svn gcc.orig/gcc/config/mips/mips.h gcc/gcc/config/mips/mips.h
--- gcc.orig/gcc/config/mips/mips.h	2008-11-01 13:21:41.000000000 -0400
+++ gcc/gcc/config/mips/mips.h	2008-11-09 23:05:02.000000000 -0500
@@ -3083,7 +3083,7 @@ while (0)
   "\tbne\t%0,%z2,2f\n"				\
   "\t" OP "\t%@,%3\n"				\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)\n"				\
   "2:\n"
@@ -3108,7 +3108,7 @@ while (0)
   "\tand\t%@,%0,%3\n"				\
   OPS						\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)\n"				\
   "2:\n"
@@ -3128,7 +3128,7 @@ while (0)
   "1:\tll" SUFFIX "\t%@,%0\n"			\
   "\t" INSN "\t%@,%@,%1\n"			\
   "\tsc" SUFFIX "\t%@,%0\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3153,7 +3153,7 @@ while (0)
   "\tand\t%4,%4,%1\n"				\
   "\tor\t%@,%@,%4\n"				\
   "\tsc\t%@,%0\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3186,7 +3186,7 @@ while (0)
   "\tand\t%5,%5,%2\n"				\
   "\tor\t%@,%@,%5\n"				\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3216,7 +3216,7 @@ while (0)
   "\tand\t%0,%0,%2\n"				\
   "\tor\t%@,%@,%0\n"				\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3236,7 +3236,7 @@ while (0)
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3253,7 +3253,7 @@ while (0)
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b%~\n"			\
   "\t" INSN "\t%0,%0,%2\n"			\
   "\tsync%-%]%>%)"
 
@@ -3270,7 +3270,7 @@ while (0)
   "\tnor\t%@,%@,%.\n"				\
   "\t" INSN "\t%@,%@,%1\n"			\
   "\tsc" SUFFIX "\t%@,%0\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3289,7 +3289,7 @@ while (0)
   "\tnor\t%@,%0,%.\n"				\
   "\t" INSN "\t%@,%@,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3308,7 +3308,7 @@ while (0)
   "\tnor\t%0,%0,%.\n"				\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b%~\n"			\
   "\t" INSN "\t%0,%0,%2\n"			\
   "\tsync%-%]%>%)"
 
@@ -3326,7 +3326,7 @@ while (0)
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" OP "\t%@,%2\n"				\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3350,7 +3350,7 @@ while (0)
   "\tand\t%@,%0,%3\n"				\
   OPS						\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  "\tbeq%?\t%@,%.,1b\n"				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
diff -Naurp -x .svn gcc.orig/gcc/config/mips/mips.opt gcc/gcc/config/mips/mips.opt
--- gcc.orig/gcc/config/mips/mips.opt	2008-10-30 22:20:27.000000000 -0400
+++ gcc/gcc/config/mips/mips.opt	2008-11-09 23:05:02.000000000 -0500
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
+++ gcc/gcc/config/mips/sync.md	2008-11-09 23:05:19.000000000 -0500
@@ -42,6 +42,8 @@
 	 UNSPEC_COMPARE_AND_SWAP))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   if (which_alternative == 0)
     return MIPS_COMPARE_AND_SWAP ("<d>", "li");
   else
@@ -75,6 +77,8 @@
 			    UNSPEC_COMPARE_AND_SWAP_12))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   if (which_alternative == 0)
     return MIPS_COMPARE_AND_SWAP_12 (MIPS_COMPARE_AND_SWAP_12_NONZERO_OP);
   else
@@ -90,6 +94,8 @@
 	  UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   if (which_alternative == 0)
     return MIPS_SYNC_OP ("<d>", "<d>addiu");	
   else
@@ -124,6 +130,8 @@
    (clobber (match_scratch:SI 4 "=&d"))]
   "GENERATE_LL_SC"
 {
+    static bool mips_branch_likely;
+    mips_branch_likely = TARGET_FIX_R10000;
     return MIPS_SYNC_OP_12 ("<insn>", MIPS_SYNC_OP_12_NOT_NOP);	
 }
   [(set_attr "length" "40")])
@@ -160,6 +168,8 @@
    (clobber (match_scratch:SI 5 "=&d"))]
   "GENERATE_LL_SC"
 {
+    static bool mips_branch_likely;
+    mips_branch_likely = TARGET_FIX_R10000;
     return MIPS_SYNC_OLD_OP_12 ("<insn>", MIPS_SYNC_OLD_OP_12_NOT_NOP,
 				MIPS_SYNC_OLD_OP_12_NOT_NOP_REG);	
 }
@@ -202,6 +212,8 @@
 	   (match_dup 4)] UNSPEC_SYNC_NEW_OP_12))]
   "GENERATE_LL_SC"
 {
+    static bool mips_branch_likely;
+    mips_branch_likely = TARGET_FIX_R10000;
     return MIPS_SYNC_NEW_OP_12 ("<insn>", MIPS_SYNC_NEW_OP_12_NOT_NOP);
 }
   [(set_attr "length" "40")])
@@ -233,6 +245,8 @@
    (clobber (match_scratch:SI 4 "=&d"))]
   "GENERATE_LL_SC"
 {
+    static bool mips_branch_likely;
+    mips_branch_likely = TARGET_FIX_R10000;
     return MIPS_SYNC_OP_12 ("and", MIPS_SYNC_OP_12_NOT_NOT);	
 }
   [(set_attr "length" "44")])
@@ -267,6 +281,8 @@
    (clobber (match_scratch:SI 5 "=&d"))]
   "GENERATE_LL_SC"
 {
+    static bool mips_branch_likely;
+    mips_branch_likely = TARGET_FIX_R10000;
     return MIPS_SYNC_OLD_OP_12 ("and", MIPS_SYNC_OLD_OP_12_NOT_NOT,
 				MIPS_SYNC_OLD_OP_12_NOT_NOT_REG);	
 }
@@ -307,6 +323,8 @@
 	   (match_dup 4)] UNSPEC_SYNC_NEW_OP_12))]
   "GENERATE_LL_SC"
 {
+    static bool mips_branch_likely;
+    mips_branch_likely = TARGET_FIX_R10000;
     return MIPS_SYNC_NEW_OP_12 ("and", MIPS_SYNC_NEW_OP_12_NOT_NOT);
 }
   [(set_attr "length" "40")])
@@ -319,6 +337,8 @@
 	 UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   return MIPS_SYNC_OP ("<d>", "<d>subu");	
 }
   [(set_attr "length" "28")])
@@ -333,6 +353,8 @@
 	 UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   if (which_alternative == 0)
     return MIPS_SYNC_OLD_OP ("<d>", "<d>addiu");	
   else
@@ -350,6 +372,8 @@
 	 UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   return MIPS_SYNC_OLD_OP ("<d>", "<d>subu");	
 }
   [(set_attr "length" "28")])
@@ -364,6 +388,8 @@
 	 UNSPEC_SYNC_NEW_OP))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   if (which_alternative == 0)
     return MIPS_SYNC_NEW_OP ("<d>", "<d>addiu");	
   else
@@ -381,6 +407,8 @@
 	 UNSPEC_SYNC_NEW_OP))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   return MIPS_SYNC_NEW_OP ("<d>", "<d>subu");	
 }
   [(set_attr "length" "28")])
@@ -393,6 +421,8 @@
 	 UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   if (which_alternative == 0)
     return MIPS_SYNC_OP ("<d>", "<immediate_insn>");	
   else
@@ -410,6 +440,8 @@
 	 UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   if (which_alternative == 0)
     return MIPS_SYNC_OLD_OP ("<d>", "<immediate_insn>");	
   else
@@ -427,6 +459,8 @@
 	 UNSPEC_SYNC_NEW_OP))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   if (which_alternative == 0)
     return MIPS_SYNC_NEW_OP ("<d>", "<immediate_insn>");	
   else
@@ -440,6 +474,8 @@
 	 UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   if (which_alternative == 0)
     return MIPS_SYNC_NAND ("<d>", "andi");	
   else
@@ -455,6 +491,8 @@
 	 UNSPEC_SYNC_OLD_OP))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   if (which_alternative == 0)
     return MIPS_SYNC_OLD_NAND ("<d>", "andi");	
   else
@@ -470,6 +508,8 @@
 	 UNSPEC_SYNC_NEW_OP))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   if (which_alternative == 0)
     return MIPS_SYNC_NEW_NAND ("<d>", "andi");	
   else
@@ -485,6 +525,8 @@
 	 UNSPEC_SYNC_EXCHANGE))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   if (which_alternative == 0)
     return MIPS_SYNC_EXCHANGE ("<d>", "li");
   else
@@ -515,6 +557,8 @@
 	  UNSPEC_SYNC_EXCHANGE_12))]
   "GENERATE_LL_SC"
 {
+  static bool mips_branch_likely;
+  mips_branch_likely = TARGET_FIX_R10000;
   if (which_alternative == 0)
     return MIPS_SYNC_EXCHANGE_12 (MIPS_SYNC_EXCHANGE_12_NONZERO_OP);
   else
diff -Naurp -x .svn gcc.orig/gcc/doc/invoke.texi gcc/gcc/doc/invoke.texi
--- gcc.orig/gcc/doc/invoke.texi	2008-10-30 22:14:29.000000000 -0400
+++ gcc/gcc/doc/invoke.texi	2008-11-09 23:05:03.000000000 -0500
@@ -666,7 +666,7 @@ Objective-C and Objective-C++ Dialects}.
 -mdivide-traps  -mdivide-breaks @gol
 -mmemcpy  -mno-memcpy  -mlong-calls  -mno-long-calls @gol
 -mmad  -mno-mad  -mfused-madd  -mno-fused-madd  -nocpp @gol
--mfix-r4000  -mno-fix-r4000  -mfix-r4400  -mno-fix-r4400 @gol
+-mfix-r4000  -mno-fix-r4000  -mfix-r4400  -mno-fix-r4400 -mfix-r10000 -mno-fix-r10000 @gol
 -mfix-vr4120  -mno-fix-vr4120  -mfix-vr4130  -mno-fix-vr4130 @gol
 -mfix-sb1  -mno-fix-sb1 @gol
 -mflush-func=@var{func}  -mno-flush-func @gol

--------------090103070700080004080404--
