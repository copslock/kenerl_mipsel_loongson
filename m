Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 11:22:09 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:42219 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20032015AbXKTLWH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Nov 2007 11:22:07 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAKBLHGo012079;
	Tue, 20 Nov 2007 11:21:17 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAKBL3VI012023;
	Tue, 20 Nov 2007 11:21:03 GMT
Date:	Tue, 20 Nov 2007 11:21:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: futex_wake_op deadlock?
Message-ID: <20071120112051.GB30675@linux-mips.org>
References: <20071119184837.GA12287@linux-mips.org> <DDFD17CC94A9BD49A82147DDF7D545C54DCDE2@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C54DCDE2@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 19, 2007 at 01:27:37PM -0800, Kaz Kylheku wrote:

> >> From time to time, on 2.6.17.7, I see a deadlock situation go off.
> >> The soft lockup tick occurs in the middle of do_futex, which is
> >> heavily inlined.  The system is actually hosed; it's not one of those
> >> recoverable CPU busy situations that can sometimes trigger the lockup
> >> detector.
> > 
> > Can you reproduce thing hang also if you're not running in a
> > binary compat
> > mode, that is either running o32 binaries on a 32-bit kernel or
> > 64-bit binaries on a 64-bit kernel? 
> 
> I have hacked up little a test program which hosed my board within
> seconds.
> The system is not completely hung. However:

Cute.  So looking again at the futex code this morning it was quite
obvious what happened.  The ll/sc loops in __futex_atomic_op() had the
usual fixups necessary for memory acccesses to userspace from kernel
space installed:

        __asm__ __volatile__(
        "       .set    push                            \n"
        "       .set    noat                            \n"
        "       .set    mips3                           \n"
        "1:     ll      %1, %4  # __futex_atomic_op     \n"
        "       .set    mips0                           \n"
        "       " insn  "                               \n"
        "       .set    mips3                           \n"
        "2:     sc      $1, %2                          \n"
        "       beqz    $1, 1b                          \n"
        __WEAK_LLSC_MB
        "3:                                             \n"
        "       .set    pop                             \n"
        "       .set    mips0                           \n"
        "       .section .fixup,\"ax\"                  \n"
        "4:     li      %0, %6                          \n"
        "       j       2b                              \n"	<-----
        "       .previous                               \n"
        "       .section __ex_table,\"a\"               \n"
        "       "__UA_ADDR "\t1b, 4b                    \n"
        "       "__UA_ADDR "\t2b, 4b                    \n"
        "       .previous                               \n"
        : "=r" (ret), "=&r" (oldval), "=R" (*uaddr)
        : "0" (0), "R" (*uaddr), "Jr" (oparg), "i" (-EFAULT)
        : "memory");

Notice the branch at the end of the fixup code, it goes back to the
SC instruction.  The SC instruction took an exception so it will not have
changed $1 so the loop will continue endless unless by coincidence the
value to be stored from $1 happened to be zero.

Obviously this one was MIPS specific and may hit all supported ABIs.  So
my initial suspicion this might be the issue David Miller recently
discovered in the binary compat code isn't true.  And it's a local DoS
probably for all of 2.6.16 and up.

Patch below.  It fixes your test case on a 32-bit kernel for me.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/asm-mips/futex.h b/include/asm-mips/futex.h
index 3e7e30d..17f082c 100644
--- a/include/asm-mips/futex.h
+++ b/include/asm-mips/futex.h
@@ -35,7 +35,7 @@
 		"	.set	mips0				\n"	\
 		"	.section .fixup,\"ax\"			\n"	\
 		"4:	li	%0, %6				\n"	\
-		"	j	2b				\n"	\
+		"	j	3b				\n"	\
 		"	.previous				\n"	\
 		"	.section __ex_table,\"a\"		\n"	\
 		"	"__UA_ADDR "\t1b, 4b			\n"	\
@@ -61,7 +61,7 @@
 		"	.set	mips0				\n"	\
 		"	.section .fixup,\"ax\"			\n"	\
 		"4:	li	%0, %6				\n"	\
-		"	j	2b				\n"	\
+		"	j	3b				\n"	\
 		"	.previous				\n"	\
 		"	.section __ex_table,\"a\"		\n"	\
 		"	"__UA_ADDR "\t1b, 4b			\n"	\
