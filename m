Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 15:47:20 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:36584 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20025680AbXJaPrL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2007 15:47:11 +0000
Received: from localhost (p7013-ipad26funabasi.chiba.ocn.ne.jp [220.104.93.13])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 9F11A9F50
	for <linux-mips@linux-mips.org>; Thu,  1 Nov 2007 00:47:06 +0900 (JST)
Date:	Thu, 01 Nov 2007 00:49:06 +0900 (JST)
Message-Id: <20071101.004906.106263529.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: WAIT vs. tickless kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On some CPUs, there is a small window in the idle task which might
cause a large latency to wakeup a process.

http://www.linux-mips.org/archives/linux-mips/2005-11/msg00114.html

This can be avoided on some CPUs which can use xxx_wait_irqoff(), but
still there are many CPUs out of luck.

And now we have dyntick/tickless kernel.  On tickless kernel the
problem might become more serious.  We cannot know the worst latency
time.  Theoretically a task can lose wakeup-event forever.

Of course "nowait" kernel option will help, but are there any other
good solutions?

Just an idea: If we put an WAIT in hazard area of the MTC0 which
enables interrupts, can we accomplish something like
atomic-test-and-wait operation?

void r4k_wait_bulletproof(void)
{
	local_irq_disable();
	if (!need_resched())
		__asm__(
		"	.set	push		\n"
		"	.set	mips3		\n"
		"	.set	noat		\n"
		"	.align	4		\n" /* avoid stall on wait */
		"	mfc0	$1, $12		\n"
		"	ori	$1, 1		\n"
		"	mtc0	$1, $12		\n"
		"	wait			\n"
		"	xori	$1, 1		\n"
		"	mtc0	$1, $12		\n"
		"	.set	pop		\n");
	local_irq_enable();
}

If this work as expected?  Comments from pipeline gurus are welcome ;)

---
Atsushi Nemoto
