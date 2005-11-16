Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2005 16:18:15 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:28640 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8134064AbVKPQR4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2005 16:17:56 +0000
Received: from localhost (p3230-ipad208funabasi.chiba.ocn.ne.jp [60.43.104.230])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id CB423A131
	for <linux-mips@linux-mips.org>; Thu, 17 Nov 2005 01:19:58 +0900 (JST)
Date:	Thu, 17 Nov 2005 01:19:06 +0900 (JST)
Message-Id: <20051117.011906.25910026.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: cpu_idle and cpu_wait
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Looking at recent change in cpu_idle(), I find an another potential
problem with cpu_wait (WAIT instruction).

    48	ATTRIB_NORET void cpu_idle(void)
    49	{
    50		/* endless idle loop with no priority at all */
    51		while (1) {
    52			while (!need_resched())
    53				if (cpu_wait)
    54					(*cpu_wait)();
    55			preempt_enable_no_resched();
    56			schedule();
    57			preempt_disable();
    58		}
    59	}

If an interrupt raised on line 53 and the interrupt handler woke a
sleeping thread up, the thread becomes runnable and current thread
(idle thread) is marked as NEED_RESCHED.

Since preemption is disabled, the interrupt handler just return to
current thread (idle thread) without rescheduling.  The idle thread
then call cpu_wait() and execute WAIT instruction (or something
similer).  The CPU will stops until next interrupt.  Then the idle
task checks need_resched() and finally calls schedule().  Therefore,
wakeup-resume latency will be nearly one TICK on worst case!

If this analysis was correct, how to fix this?

Removing above preempt_enable_no_resched/preempt_disable pair would
fix it for preemptive kernel, but no point for non-preemptive kernel.
Replacing them with local_irq_enable/local_irq_disable would fix it
for both kernel, but there is an question:

	The CPU can surely exit from the WAIT instruction by interrupt
	even if interrupts disabled?

I know the answer is yes on TX49.  Any external (or counter) interrupt
SIGNAL can break the WAIT instruction.  How about others?

---
Atsushi Nemoto
