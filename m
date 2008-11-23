Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Nov 2008 04:17:25 +0000 (GMT)
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:21171 "EHLO
	QMTA01.emeryville.ca.mail.comcast.net") by ftp.linux-mips.org
	with ESMTP id S23681975AbYKWERP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 23 Nov 2008 04:17:15 +0000
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60])
	by QMTA01.emeryville.ca.mail.comcast.net with comcast
	id iRh21a00i1HpZEsA1UH89C; Sun, 23 Nov 2008 04:17:08 +0000
Received: from [192.168.1.13] ([69.140.18.238])
	by OMTA14.emeryville.ca.mail.comcast.net with comcast
	id iUH41a00958Be2l8aUH6ug; Sun, 23 Nov 2008 04:17:07 +0000
X-Authority-Analysis: v=1.0 c=1 a=se7utVhDntQA:10 a=sj6Exy8oVBoA:10
 a=b2f5WdeKCdRazmL-gmkA:9 a=p9nuOHdj3vFgq1UAJ_QA:7
 a=3ShYX1PyqleEjHzar-jirKrSD4wA:4 a=WeOa-AV5lc8A:10 a=Mz_smNXqyOQA:10
Message-ID: <4928D912.4050103@gentoo.org>
Date:	Sat, 22 Nov 2008 23:16:18 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To:	libc-ports@sources.redhat.com
CC:	Daniel Jacobowitz <drow@false.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Glibc
References: <490A912A.8030901@gentoo.org> <490C907A.40005@loowit.net>
In-Reply-To: <490C907A.40005@loowit.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

James Perkins wrote:
>       "move	%1,%3\n\t"		      \
>       "sc	%1,%4\n\t"		      \
> -     "beqz	%1,1b\n"		      \
> +     R10K_BEQZ_INSN			      \
>       acq	"\n\t"			      \
>       ".set	pop\n"			      \
> 
> Is it possible to leave the parameters in the inline code and
> remove them from the macro definition? I feel the code is more
> readable without having to refer to the macro definition if
> the parameters are left in place.

Here's try #2.  The gcc-side is already sent in and accepted.  If I'm still 
missing anything, please let me know!

Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org


2008-11-22  Joshua Kinard  <kumba@gentoo.org>

         * ports/sysdeps/mips/bits/atomic.h
	(R10K_BEQZ_INSN, R10K_NOPS_INSN): Define depending on ISA.
         (__arch_compare_and_exchange_xxx_32_int): Replace 'beqz' insn with
	R10K_BEQZ_INSN and add R10K_NOPS_INSN.
         (__arch_compare_and_exchange_xxx_64_int): Likewise
         (__arch_exchange_xxx_32_int): Likewise
	(__arch_exchange_xxx_64_int): Likewise
         (__arch_exchange_and_add_32_int): Likewise
	(__arch_exchange_and_add_64_int): Likewise

Index: ports/sysdeps/mips/bits/atomic.h
===================================================================
RCS file: /cvs/glibc/ports/sysdeps/mips/bits/atomic.h,v
retrieving revision 1.1
diff -u -p -r1.1 atomic.h
--- ports/sysdeps/mips/bits/atomic.h	28 Mar 2005 09:14:59 -0000	1.1
+++ ports/sysdeps/mips/bits/atomic.h	23 Nov 2008 03:22:53 -0000
@@ -49,6 +49,61 @@ typedef uintmax_t uatomic_max_t;
  # define MIPS_SYNC	sync
  #endif

+/* Certain revisions of the R10000 Processor need an LL/SC Workaround
+   enabled.  Revisions before 3.0 misbehave on atomic operations, and
+   Revs 2.6 and lower deadlock after several seconds due to other errata.
+
+   To quote the R10K Errata:
+      Workaround: The basic idea is to inhibit the four instructions
+      from simultaneously becoming active in R10000. Padding all
+      ll/sc sequences with nops or changing the looping branch in the
+      routines to a branch likely (which is always predicted taken
+      by R10000) will work. The nops should go after the loop, and the
+      number of them should be 28. This number could be decremented for
+      each additional instruction in the ll/sc loop such as the lock
+      modifier(s) between the ll and sc, the looping branch and its
+      delay slot. For typical short routines with one ll/sc loop, any
+      instructions after the loop could also count as a decrement. The
+      nop workaround pollutes the cache more but would be a few cycles
+      faster if all the code is in the cache and the looping branch
+      is predicted not taken.  */
+
+#if (defined(_MIPS_ARCH_MIPS2) || defined(_MIPS_ARCH_MIPS3) || \
+     defined(_MIPS_ARCH_MIPS4))
+#define R10K_BEQZ_INSN "beqzl"
+#define R10K_NOPS_INSN ""
+#else
+#define R10K_BEQZ_INSN "beqz"
+#define R10K_NOPS_INSN "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"	\
+		       "\tnop\n"
+#endif
+
  #define MIPS_SYNC_STR_2(X) #X
  #define MIPS_SYNC_STR_1(X) MIPS_SYNC_STR_2(X)
  #define MIPS_SYNC_STR MIPS_SYNC_STR_1(MIPS_SYNC)
@@ -74,7 +129,8 @@ typedef uintmax_t uatomic_max_t;
       "bne	%0,%2,2f\n\t"						      \
       "move	%1,%3\n\t"						      \
       "sc	%1,%4\n\t"						      \
-     "beqz	%1,1b\n"						      \
+     R10K_BEQZ_INSN "	%1,1b\n"					      \
+     R10K_NOPS_INSN							      \
       acq	"\n\t"							      \
       ".set	pop\n"							      \
       "2:\n\t"								      \
@@ -98,7 +154,8 @@ typedef uintmax_t uatomic_max_t;
       "bne	%0,%2,2f\n\t"						      \
       "move	%1,%3\n\t"						      \
       "scd	%1,%4\n\t"						      \
-     "beqz	%1,1b\n"						      \
+     R10K_BEQZ_INSN "	%1,1b\n"					      \
+     R10K_NOPS_INSN							      \
       acq	"\n\t"							      \
       ".set	pop\n"							      \
       "2:\n\t"								      \
@@ -192,7 +249,8 @@ typedef uintmax_t uatomic_max_t;
       "ll	%0,%3\n\t"						      \
       "move	%1,%2\n\t"						      \
       "sc	%1,%3\n\t"						      \
-     "beqz	%1,1b\n"						      \
+     R10K_BEQZ_INSN "	%1,1b\n"					      \
+     R10K_NOPS_INSN							      \
       acq	"\n\t"							      \
       ".set	pop\n"							      \
       "2:\n\t"								      \
@@ -216,7 +274,8 @@ typedef uintmax_t uatomic_max_t;
       "lld	%0,%3\n\t"						      \
       "move	%1,%2\n\t"						      \
       "scd	%1,%3\n\t"						      \
-     "beqz	%1,1b\n"						      \
+     R10K_BEQZ_INSN "	%1,1b\n"					      \
+     R10K_NOPS_INSN							      \
       acq	"\n\t"							      \
       ".set	pop\n"							      \
       "2:\n\t"								      \
@@ -251,7 +310,8 @@ typedef uintmax_t uatomic_max_t;
       "ll	%0,%3\n\t"						      \
       "addu	%1,%0,%2\n\t"						      \
       "sc	%1,%3\n\t"						      \
-     "beqz	%1,1b\n"						      \
+     R10K_BEQZ_INSN "	%1,1b\n"					      \
+     R10K_NOPS_INSN							      \
       acq	"\n\t"							      \
       ".set	pop\n"							      \
       "2:\n\t"								      \
@@ -275,7 +335,8 @@ typedef uintmax_t uatomic_max_t;
       "lld	%0,%3\n\t"						      \
       "daddu	%1,%0,%2\n\t"						      \
       "scd	%1,%3\n\t"						      \
-     "beqz	%1,1b\n"						      \
+     R10K_BEQZ_INSN "	%1,1b\n"					      \
+     R10K_NOPS_INSN							      \
       acq	"\n\t"							      \
       ".set	pop\n"							      \
       "2:\n\t"								      \
