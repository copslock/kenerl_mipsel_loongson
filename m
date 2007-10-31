Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 16:13:54 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:35968 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28575983AbXJaQNw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Oct 2007 16:13:52 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9VGDY6P023052;
	Wed, 31 Oct 2007 16:13:34 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9VGDXlU023051;
	Wed, 31 Oct 2007 16:13:33 GMT
Date:	Wed, 31 Oct 2007 16:13:33 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: WAIT vs. tickless kernel
Message-ID: <20071031161333.GA22871@linux-mips.org>
References: <20071101.004906.106263529.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071101.004906.106263529.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 01, 2007 at 12:49:06AM +0900, Atsushi Nemoto wrote:

> On some CPUs, there is a small window in the idle task which might
> cause a large latency to wakeup a process.
> 
> http://www.linux-mips.org/archives/linux-mips/2005-11/msg00114.html
> 
> This can be avoided on some CPUs which can use xxx_wait_irqoff(), but
> still there are many CPUs out of luck.
> 
> And now we have dyntick/tickless kernel.  On tickless kernel the
> problem might become more serious.  We cannot know the worst latency
> time.  Theoretically a task can lose wakeup-event forever.
> 
> Of course "nowait" kernel option will help, but are there any other
> good solutions?
> 
> Just an idea: If we put an WAIT in hazard area of the MTC0 which
> enables interrupts, can we accomplish something like
> atomic-test-and-wait operation?
> 
> void r4k_wait_bulletproof(void)
> {
> 	local_irq_disable();
> 	if (!need_resched())
> 		__asm__(
> 		"	.set	push		\n"
> 		"	.set	mips3		\n"
> 		"	.set	noat		\n"
> 		"	.align	4		\n" /* avoid stall on wait */
> 		"	mfc0	$1, $12		\n"
> 		"	ori	$1, 1		\n"
> 		"	mtc0	$1, $12		\n"
> 		"	wait			\n"
> 		"	xori	$1, 1		\n"
> 		"	mtc0	$1, $12		\n"
> 		"	.set	pop		\n");
> 	local_irq_enable();
> }
> 
> If this work as expected?  Comments from pipeline gurus are welcome ;)

This one is definately playing with the fire.  Or alternatively requires
detailed knowledge of the pipeline and pipelines tend to change.  MIPS
Technologies does regular maintenance releases of its cores which also
add features and may change the pipelines in subtle way that may break
something like this.

The only safe but ugly workaround is to change the return from exception
code to detect if the EPC is in the range startin from the condition
check in the idle loop to including the WAIT instruction and if so to
patch the EPC to resume execution at the condition check or the
instruction following the WAIT.

  Ralf
