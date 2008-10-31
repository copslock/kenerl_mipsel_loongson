Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 08:41:33 +0000 (GMT)
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:46474 "EHLO
	QMTA02.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S22783552AbYJaFBM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2008 05:01:12 +0000
Received: from OMTA11.emeryville.ca.mail.comcast.net ([76.96.30.36])
	by QMTA02.emeryville.ca.mail.comcast.net with comcast
	id ZG681a0050mlR8UA2H14a3; Fri, 31 Oct 2008 05:01:04 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA11.emeryville.ca.mail.comcast.net with comcast
	id ZH111a00E58Be2l8XH13W1; Fri, 31 Oct 2008 05:01:04 +0000
X-Authority-Analysis: v=1.0 c=1 a=kIlm2E0NotEA:10 a=SCsKgWfUi10A:10
 a=xNf9USuDAAAA:8 a=kscuehHA11SQMdwU_CwA:9 a=lUjIwfqd4l88oPzia6IA:7
 a=pm4RV5u5HEUkb8DIF-GGA0m9Vz0A:4 a=WeOa-AV5lc8A:10 a=XF7b4UCPwd8A:10
 a=EhbOeVjh6S3bR_U7vB4A:9 a=isNctzbV_A_efyrJeEUA:7
 a=TmD9UR22mFqeckMLfZ8fL__L1-MA:4 a=NfA2RSpTaHsA:10
Message-ID: <490A90F4.6040601@gentoo.org>
Date:	Fri, 31 Oct 2008 01:00:36 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	gcc-patches@gcc.gnu.org
CC:	Richard Sandiford <rdsandiford@googlemail.com>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
Content-Type: multipart/mixed;
 boundary="------------010601030401080103080902"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010601030401080103080902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch adds a workaround to have gcc emit branch likely instructions 
(beqzl) in atomic operations for R10000 CPUs.  This is because revisions of this 
CPU before 3.0 misbehave, while revisions 2.6 and earlier will deadlock.  This 
issue has been noted on SGI IP28 (Indigo2 Impact R10000) systems and SGI IP27 
Origin systems.

After creating a patch to glibc based off of Debian Bug #462112 
(http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=462112), it was suggested by 
David Daney that a similar patch be created for GCC.

Feedback would be welcome on any suggestions for improving this patch (please 
CC, as I'm not subscribed to the ML).

Thanks!

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

--------------010601030401080103080902
Content-Type: text/plain;
 name="gcc-trunk-r10k-beqzl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gcc-trunk-r10k-beqzl.patch"

diff -Naurp gcc.orig/gcc/config/mips/mips.h gcc/gcc/config/mips/mips.h
--- gcc.orig/gcc/config/mips/mips.h	2008-10-30 22:20:27.000000000 -0400
+++ gcc/gcc/config/mips/mips.h	2008-10-30 23:12:11.000000000 -0400
@@ -3066,6 +3066,31 @@ while (0)
 #ifndef HAVE_AS_TLS
 #define HAVE_AS_TLS 0
 #endif
+
+/* Certain revisions of the R10000 Processor need an LL/SC Workaround
+   enabled.  Revisions before 3.0 misbehave on atomic operations, and
+   Revs 2.6 and lower deadlock after several seconds due to other errata.
+
+   To quote the R10K Errata:
+     Workaround: The basic idea is to inhibit the four instructions
+     from simultaneously becoming active in R10000. Padding all
+     ll/sc sequences with nops or changing the looping branch in the
+     routines to a branch likely (which is always predicted taken
+     by R10000) will work. The nops should go after the loop, and the
+     number of them should be 28. This number could be decremented for
+     each additional instruction in the ll/sc loop such as the lock
+     modifier(s) between the ll and sc, the looping branch and its
+     delay slot. For typical short routines with one ll/sc loop, any
+     instructions after the loop could also count as a decrement. The
+     nop workaround pollutes the cache more but would be a few cycles
+     faster if all the code is in the cache and the looping branch
+     is predicted not taken.  */
+
+#ifndef (_MIPS_ARCH_R10000)
+#define R10K_BEQZ_INSN "\tbeq\t%@,%.,1b\n"
+#else
+#define R10K_BEQZ_INSN "\tbeqzl\t%@,1b\n"
+#endif
 
 /* Return an asm string that atomically:
 
@@ -3083,7 +3108,7 @@ while (0)
   "\tbne\t%0,%z2,2f\n"				\
   "\t" OP "\t%@,%3\n"				\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  R10K_BEQZ_INSN				\
   "\tnop\n"					\
   "\tsync%-%]%>%)\n"				\
   "2:\n"
@@ -3108,7 +3133,7 @@ while (0)
   "\tand\t%@,%0,%3\n"				\
   OPS						\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  R10K_BEQZ_INSN				\
   "\tnop\n"					\
   "\tsync%-%]%>%)\n"				\
   "2:\n"
@@ -3128,7 +3153,7 @@ while (0)
   "1:\tll" SUFFIX "\t%@,%0\n"			\
   "\t" INSN "\t%@,%@,%1\n"			\
   "\tsc" SUFFIX "\t%@,%0\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  R10K_BEQZ_INSN				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3153,7 +3178,7 @@ while (0)
   "\tand\t%4,%4,%1\n"				\
   "\tor\t%@,%@,%4\n"				\
   "\tsc\t%@,%0\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  R10K_BEQZ_INSN				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3186,7 +3211,7 @@ while (0)
   "\tand\t%5,%5,%2\n"				\
   "\tor\t%@,%@,%5\n"				\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  R10K_BEQZ_INSN				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3216,7 +3241,7 @@ while (0)
   "\tand\t%0,%0,%2\n"				\
   "\tor\t%@,%@,%0\n"				\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  R10K_BEQZ_INSN				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3236,7 +3261,7 @@ while (0)
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  R10K_BEQZ_INSN				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3253,7 +3278,7 @@ while (0)
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  R10K_BEQZ_INSN				\
   "\t" INSN "\t%0,%0,%2\n"			\
   "\tsync%-%]%>%)"
 
@@ -3270,7 +3295,7 @@ while (0)
   "\tnor\t%@,%@,%.\n"				\
   "\t" INSN "\t%@,%@,%1\n"			\
   "\tsc" SUFFIX "\t%@,%0\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  R10K_BEQZ_INSN				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3289,7 +3314,7 @@ while (0)
   "\tnor\t%@,%0,%.\n"				\
   "\t" INSN "\t%@,%@,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  R10K_BEQZ_INSN				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3308,7 +3333,7 @@ while (0)
   "\tnor\t%0,%0,%.\n"				\
   "\t" INSN "\t%@,%0,%2\n"			\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  R10K_BEQZ_INSN				\
   "\t" INSN "\t%0,%0,%2\n"			\
   "\tsync%-%]%>%)"
 
@@ -3326,7 +3351,7 @@ while (0)
   "1:\tll" SUFFIX "\t%0,%1\n"			\
   "\t" OP "\t%@,%2\n"				\
   "\tsc" SUFFIX "\t%@,%1\n"			\
-  "\tbeq\t%@,%.,1b\n"				\
+  R10K_BEQZ_INSN				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 
@@ -3350,7 +3375,7 @@ while (0)
   "\tand\t%@,%0,%3\n"				\
   OPS						\
   "\tsc\t%@,%1\n"				\
-  "\tbeq\t%@,%.,1b\n"				\
+  R10K_BEQZ_INSN				\
   "\tnop\n"					\
   "\tsync%-%]%>%)"
 

--------------010601030401080103080902--
