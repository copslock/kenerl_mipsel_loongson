Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 08:20:00 +0000 (GMT)
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:23274 "EHLO
	QMTA03.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S22783588AbYJaFCG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2008 05:02:06 +0000
Received: from OMTA11.emeryville.ca.mail.comcast.net ([76.96.30.36])
	by QMTA03.emeryville.ca.mail.comcast.net with comcast
	id ZEpW1a00F0mlR8UA3H1zBg; Fri, 31 Oct 2008 05:01:59 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA11.emeryville.ca.mail.comcast.net with comcast
	id ZH1v1a00258Be2l8XH1weg; Fri, 31 Oct 2008 05:01:57 +0000
X-Authority-Analysis: v=1.0 c=1 a=kIlm2E0NotEA:10 a=SCsKgWfUi10A:10
 a=xNf9USuDAAAA:8 a=SVGbZonO5hFbUcMDE-IA:9 a=PzzOTLDUO664q09MNtAA:7
 a=Smumbny_icKJZdKbs_W64S7RabEA:4 a=WeOa-AV5lc8A:10 a=uVawpVqKyvgA:10
 a=LnGxEkVVx1SQnmjCPzUA:9 a=BWmtDHnANUKbgaC4nfMA:7
 a=cVqo9mW4FAXU5nLubo9XDxYi1LkA:4 a=NfA2RSpTaHsA:10
Message-ID: <490A912A.8030901@gentoo.org>
Date:	Fri, 31 Oct 2008 01:01:30 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	libc-ports@sources.redhat.com
CC:	Daniel Jacobowitz <drow@false.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH]: R10000 Needs LL/SC Workaround in Glibc
Content-Type: multipart/mixed;
 boundary="------------010606030803010409040608"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010606030803010409040608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


The attached patch adds a workaround for R10000 CPUs to use the branch likely 
(beqzl) instruction in atomic operations, because revisions of the CPU before 
3.0 misbehave, while revisions 2.6 and earlier will deadlock.  This issue has 
been noted on SGI IP28 (Indigo2 Impact R10000) systems and SGI IP27 Origin systems.

I drafted it after some discussion with several people in the Linux/MIPS IRC 
Channel after discovering glibc didn't work quite right on my IP28 machine.  The 
patch is based on Debian bug #462112, viewable here:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=462112

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

--------------010606030803010409040608
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
+#ifndef (_MIPS_ARCH_R10000)
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

--------------010606030803010409040608--
