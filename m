Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Nov 2006 14:24:49 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:63208 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038418AbWKROYm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 18 Nov 2006 14:24:42 +0000
Received: from localhost (p8201-ipad202funabasi.chiba.ocn.ne.jp [222.146.79.201])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 93DE8B700; Sat, 18 Nov 2006 23:24:37 +0900 (JST)
Date:	Sat, 18 Nov 2006 23:27:17 +0900 (JST)
Message-Id: <20061118.232717.07456069.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] rewrite restore_fp_context/save_fp_context
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061116.001725.75185058.anemo@mba.ocn.ne.jp>
References: <20060829.225631.41630441.anemo@mba.ocn.ne.jp>
	<20061114174608.GA5740@linux-mips.org>
	<20061116.001725.75185058.anemo@mba.ocn.ne.jp>
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
X-archive-position: 13216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 16 Nov 2006 00:17:25 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > So with this patch applied the context will be copied around twice, first
> > save the fp registers to memory then copied from memory to userspace and
> > as the result the non-preemptible kernel will suffer from fixing the
> > preemptible ...
> 
> Yes, it is true if the signaled process owned FPU at the time.  I
> thought in many case the signaled process does not own FPU, but I
> might be too optimistic indeed.

Correction: This problem is not only preemptible kernel.
save_fp_context() might sleep on access to user stack, so it might
lose fpu ownership.  Then subsequent FP instruction cause CpU
exception in kernel code.

> > To me it looks like the real problem that setup_sigcontext and
> > restore_sigcontext need to disable preemption.  And the reason for that
> > is probably that 87d54649f67d8ffe0a8d8176de8c210a6c4bb4a7 around 2.6.9
> > took the wrong.  The better fix would probably have been to allow
> > at least some fp instructions from kernel mode.  The sole reason for
> > the die_if_kernel() call is to tell people attempting to put FPU code
> > into the kernel that they're screwing up.
> 
> Hmm.  Two yeas ago I tried this approach to fix fpu-emulator issues
> and gave up :) It was a bit complex more than it looked.  Here is
> excerption:
> ...
> 
> But it might be a good time to try again.  Do you think modifying
> resume() etc. is OK?

It still a bit complex more than it looked :)

Allowing CpU exception for CP1 in kernel can fix some problem, but it
is somewhat fragile I think.  For example, I first thought the last
part of setup_sigcontext() would become something like this:

	err |= __put_user(!!used_math(), &sc->sc_used_math);

	/*
	 * Save FPU state to signal context.  Signal handler will "inherit"
	 * current FPU state.
	 */
	if (used_math())
		err |= save_fp_context(sc);
	return err;

If save_fp_context cause CpU exception, kernel will handle it
correctly and take fpu owner ship.  Very simple.

BUT it would _not_ work!

In kernel we can not assume C0_STATUS.CU1==0 if is_fpu_owner()==0.
This is because we might lose fpu ownership in middle of
C0_STATUS manipulation such as local_irq_disable(), etc.

local_irq_disable:
	mfc0	$1,$12
	ori	$1,0x1f
	xori	$1,0x1f
	mtc0	$1,$12

If the task was preempted on the ORI instruction, the task's
TIF_USEDFPU flag and CU1 bit in saved user stack will be cleared.
When the task restart from ORI instruction, C0_STATUS.CU1 bit will
have been cleared too, but $1 register still hold old C0_STATUS value.
Then the MTC0 instruction will set C0_STATUS.CU1 without restoring
real FPU context.

So, we still should very careful to using fp instruction in kernel
even if the instruction did not change the fpu state.  The last part
of setup_sigcontext() should become something like this:

	err |= __put_user(!!used_math(), &sc->sc_used_math);

	/*
	 * Save FPU state to signal context.  Signal handler will "inherit"
	 * current FPU state.
	 */
	if (used_math()) {
		preempt_disable();
		if (!is_fpu_owner()) {
			own_fpu();
			restore_fp(current);
		}
		preempt_enable();
		err |= save_fp_context(sc);
	}
	return err;

Still somewhat ugly but the original problem (calling save_fp_context
in atomic context) seems fixed.

I still investigating and for now I think allowing CpU exception for
CP1 in kernel _unconditionally_ is very fragile.  Maybe something like
TIF_ALLOW_FP_IN_KERNEL flag to enable/disable that feature might be
worth to consider.

---
Atsushi Nemoto
