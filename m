Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2007 18:17:09 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:47083 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022007AbXDMRRH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2007 18:17:07 +0100
Received: from localhost (p6152-ipad02funabasi.chiba.ocn.ne.jp [61.214.24.152])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8C5B4B486; Sat, 14 Apr 2007 02:15:45 +0900 (JST)
Date:	Sat, 14 Apr 2007 02:15:45 +0900 (JST)
Message-Id: <20070414.021545.79071827.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Allow CpU exception in kernel partially
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070310.012811.108982622.anemo@mba.ocn.ne.jp>
References: <20070310.012811.108982622.anemo@mba.ocn.ne.jp>
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
X-archive-position: 14834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 10 Mar 2007 01:28:11 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> The save_fp_context()/restore_fp_context() might sleep on accessing
> user stack and therefore might lose FPU ownership in middle of them.
> Also we should not disable preempt around these functions.  This patch
> files this problem by allowing CpU exception in kernel partially.
> 
> * Introduce TIF_ALLOW_FP_IN_KERNEL thread flag.  If the flag was set,
>   CpU exception handler enables CU1 bit in interrupted kernel context
>   and returns without enabling interrupt (preempt) to make sure keep
>   FPU ownership until resume.
> * Introduce enable_fp_in_kernel() and disable_fp_in_kernel().  While
>   we might lost FPU ownership in middle of CP0_STATUS manipulation
>   (for example local_irq_disable()), we can not assume CU1 bit always
>   reflects TIF_USEDFPU.  Therefore enable_fp_in_kernel() must drop CU1
>   bit if TIF_USEDFPU was cleared.
> * The resume() function must drop CU1 bit in CP0_STATUS which are to
>   be saved.

Unfortunately this is broken.

> +static inline void disable_fp_in_kernel(void)
> +{
> +	BUG_ON(!__is_fpu_owner() && __fpu_enabled());
> +	clear_thread_flag(TIF_ALLOW_FP_IN_KERNEL);
> +}

This BUG_ON hits me sometimes when I run debian installer.

I tracked down the problem and understand why.  If kernel preempted in
middle of save_fp_context() and resumed, the CU1 bit will be enabled
without TIF_USEDFPU flag.

1. Task A calls a system call.  CP0_STATUS is saved on top of kernel stack.
2. setup_sigcontext() is called.
3. Task A own FPU.  CP0_STATUS.CU1 in top of kernel stack is set.
4. save_fp_context() is called.
5. A timer interrupt happens.  CP0_STATUS is saved on next kernel stack.
6. Task A is preempted by Task B.  Both CP0_STATUS.CU1 in top of
   kernel stack and CP0_STATUS.CU1 in task_struct are both cleared.
7. Task A is resumed.  On returning from resume(), CP0_STATUS.CU1 is 0.
8. On returning to save_fp_context(), RESUME_SOME() restores
   CP0_STATUS saved at (5).  The CU1 bit in this value is 1.
9. Now CU1 is enabled without TIF_USEDFPU.

This problem might be fixed by dropping CU1 on RESUME_SOME() if
TIF_USEDFPU was cleared.  But this adds some codes to critical path.

So I'd like to revert this patch.  I will send some patches in a few
days:

* a patch to revert this patch
* updated "first way" patch (rewrites restore_fp_context/save_fp_context)
* "third way" patch

The "third way" I'm thinking of is something like this:

static int protected_save_fp_context(struct sigcontext __user *sc)
{
	int err;
	while (1) {
		preempt_disable();
		own_fpu(1);
		err = save_fp_context(sc); /* this might fail */
		preempt_enable();
		if (likely(!err))
			break;
		/* touch the sigcontext and try again */
		err = __put_user(0, &sc->sc_fpregs[0]) |
			__put_user(0, &sc->sc_fpregs[31]) |
			__put_user(0, &sc->sc_fpc_csr);
		if (err)
			break;	/* really bad sigcontext */
	}
	return err;
}

The save_fp_context intentionally is called in atomic context, and if
it failed, touch the sigcontext in nonatomic context (this might lose
FPU ownership), and try again.  I'll try some tests with this and send
a patch if it worked fine.

---
Atsushi Nemoto
