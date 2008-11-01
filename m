Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 08:43:45 +0000 (GMT)
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:15497
	"EHLO QMTA09.westchester.pa.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S22891282AbYKAHeH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 1 Nov 2008 07:34:07 +0000
Received: from OMTA11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by QMTA09.westchester.pa.mail.comcast.net with comcast
	id Zja41a00E0mv7h059ja4Bt; Sat, 01 Nov 2008 07:34:04 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA11.westchester.pa.mail.comcast.net with comcast
	id Zja31a00558Be2l3Xja3Ue; Sat, 01 Nov 2008 07:34:04 +0000
X-Authority-Analysis: v=1.0 c=1 a=se7utVhDntQA:10 a=sj6Exy8oVBoA:10
 a=xNf9USuDAAAA:8 a=gFAdnJIcoiDrYu1BwxkA:9 a=-DerC_v2bUE-YDrXG6wA:7
 a=iIDqZqvJKRywlecbve_9YRMtabAA:4 a=WeOa-AV5lc8A:10 a=-wnwXlR73-0A:10
 a=LnGxEkVVx1SQnmjCPzUA:9 a=BWmtDHnANUKbgaC4nfMA:7
 a=8zrQWeAtf2yb5Q317LtfULTvebgA:4 a=NfA2RSpTaHsA:10
Message-ID: <490C064D.8050409@gentoo.org>
Date:	Sat, 01 Nov 2008 03:33:33 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	libc-ports@sources.redhat.com
CC:	Daniel Jacobowitz <drow@false.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Glibc
References: <490A912A.8030901@gentoo.org>
In-Reply-To: <490A912A.8030901@gentoo.org>
Content-Type: multipart/mixed;
 boundary="------------050005090408080502020007"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050005090408080502020007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kumba wrote:
> 
> The attached patch adds a workaround for R10000 CPUs to use the branch 
> likely (beqzl) instruction in atomic operations, because revisions of 
> the CPU before 3.0 misbehave, while revisions 2.6 and earlier will 
> deadlock.  This issue has been noted on SGI IP28 (Indigo2 Impact R10000) 
> systems and SGI IP27 Origin systems.
> 
> I drafted it after some discussion with several people in the Linux/MIPS 
> IRC Channel after discovering glibc didn't work quite right on my IP28 
> machine.  The patch is based on Debian bug #462112, viewable here:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=462112
> 
> Feedback would be welcome on any suggestions for improving this patch 
> (please CC, as I'm not subscribed to the ML).

Had a typo in my original patch w/ some stray parenthesis.  A fixed patch is 
attached.

I've wondered this on the equivalent patch on the gcc-patches ML as well, on 
whether this check should be strictly limited to when -march=r10000 is passed to 
the compiler.  I think -march=mips4 is probably better, but would having beqzl 
used even when -march=mips2, which is the ISA level that added branch likely, be 
even better?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org

"The past tempts us, the present confuses us, the future frightens us.  And our 
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

--------------050005090408080502020007
Content-Type: text/plain;
 name="glibc-trunk-r10k-beqzl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="glibc-trunk-r10k-beqzl.patch"

diff -Naurp libc.orig/ports/sysdeps/mips/bits/atomic.h libc/ports/sysdeps/mips/bits/atomic.h
--- libc.orig/ports/sysdeps/mips/bits/atomic.h	2005-03-28 04:14:59.000000000 -0500
+++ libc/ports/sysdeps/mips/bits/atomic.h	2008-10-30 23:39:37.000000000 -0400
@@ -53,6 +53,31 @@ typedef uintmax_t uatomic_max_t;
 #define MIPS_SYNC_STR_1(X) MIPS_SYNC_STR_2(X)
 #define MIPS_SYNC_STR MIPS_SYNC_STR_1(MIPS_SYNC)
 
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
+#ifndef _MIPS_ARCH_R10000
+#define R10K_BEQZ_INSN "beqz	%1,1b\n"
+#else
+#define R10K_BEQZ_INSN "beqzl	%1,1b\n"
+#endif
+
 /* Compare and exchange.  For all of the "xxx" routines, we expect a
    "__prev" and a "__cmp" variable to be provided by the enclosing scope,
    in which values are returned.  */
@@ -74,7 +99,7 @@ typedef uintmax_t uatomic_max_t;
      "bne	%0,%2,2f\n\t"						      \
      "move	%1,%3\n\t"						      \
      "sc	%1,%4\n\t"						      \
-     "beqz	%1,1b\n"						      \
+     R10K_BEQZ_INSN							      \
      acq	"\n\t"							      \
      ".set	pop\n"							      \
      "2:\n\t"								      \
@@ -98,7 +123,7 @@ typedef uintmax_t uatomic_max_t;
      "bne	%0,%2,2f\n\t"						      \
      "move	%1,%3\n\t"						      \
      "scd	%1,%4\n\t"						      \
-     "beqz	%1,1b\n"						      \
+     R10K_BEQZ_INSN							      \
      acq	"\n\t"							      \
      ".set	pop\n"							      \
      "2:\n\t"								      \
@@ -192,7 +217,7 @@ typedef uintmax_t uatomic_max_t;
      "ll	%0,%3\n\t"						      \
      "move	%1,%2\n\t"						      \
      "sc	%1,%3\n\t"						      \
-     "beqz	%1,1b\n"						      \
+     R10K_BEQZ_INSN							      \
      acq	"\n\t"							      \
      ".set	pop\n"							      \
      "2:\n\t"								      \
@@ -216,7 +241,7 @@ typedef uintmax_t uatomic_max_t;
      "lld	%0,%3\n\t"						      \
      "move	%1,%2\n\t"						      \
      "scd	%1,%3\n\t"						      \
-     "beqz	%1,1b\n"						      \
+     R10K_BEQZ_INSN							      \
      acq	"\n\t"							      \
      ".set	pop\n"							      \
      "2:\n\t"								      \
@@ -251,7 +276,7 @@ typedef uintmax_t uatomic_max_t;
      "ll	%0,%3\n\t"						      \
      "addu	%1,%0,%2\n\t"						      \
      "sc	%1,%3\n\t"						      \
-     "beqz	%1,1b\n"						      \
+     R10K_BEQZ_INSN							      \
      acq	"\n\t"							      \
      ".set	pop\n"							      \
      "2:\n\t"								      \
@@ -275,7 +300,7 @@ typedef uintmax_t uatomic_max_t;
      "lld	%0,%3\n\t"						      \
      "daddu	%1,%0,%2\n\t"						      \
      "scd	%1,%3\n\t"						      \
-     "beqz	%1,1b\n"						      \
+     R10K_BEQZ_INSN							      \
      acq	"\n\t"							      \
      ".set	pop\n"							      \
      "2:\n\t"								      \

--------------050005090408080502020007--
