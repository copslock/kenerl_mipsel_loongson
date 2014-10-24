Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2014 14:50:05 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:42493 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010120AbaJXMuDuEYuj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2014 14:50:03 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1XheJW-0002gV-W2; Fri, 24 Oct 2014 14:49:55 +0200
Date:   Fri, 24 Oct 2014 14:49:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qiaowei Ren <qiaowei.ren@intel.com>
cc:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v9 10/12] x86, mpx: add prctl commands PR_MPX_ENABLE_MANAGEMENT,
 PR_MPX_DISABLE_MANAGEMENT
In-Reply-To: <1413088915-13428-11-git-send-email-qiaowei.ren@intel.com>
Message-ID: <alpine.DEB.2.11.1410241436560.5308@nanos>
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-11-git-send-email-qiaowei.ren@intel.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sun, 12 Oct 2014, Qiaowei Ren wrote:
> +int mpx_enable_management(struct task_struct *tsk)
> +{
> +	struct mm_struct *mm = tsk->mm;
> +	void __user *bd_base = MPX_INVALID_BOUNDS_DIR;

What's the point of initializing bd_base here. I had to look twice to
figure out that it gets overwritten by task_get_bounds_dir()

> @@ -285,6 +285,7 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
>  	struct xsave_struct *xsave_buf;
>  	struct task_struct *tsk = current;
>  	siginfo_t info;
> +	int ret = 0;
>  
>  	prev_state = exception_enter();
>  	if (notify_die(DIE_TRAP, "bounds", regs, error_code,
> @@ -312,8 +313,35 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
>  	 */
>  	switch (status & MPX_BNDSTA_ERROR_CODE) {
>  	case 2: /* Bound directory has invalid entry. */
> -		if (do_mpx_bt_fault(xsave_buf))
> +		down_write(&current->mm->mmap_sem);

The handling of mm->mmap_sem here is horrible. The only reason why you
want to hold mmap_sem write locked in the first place is that you want
to cover the allocation and the mm->bd_addr check.

I think it's wrong to tie this to mmap_sem in the first place. If MPX
is enabled then you should have mm->bd_addr and an explicit mutex to
protect it.

So the logic would look like this:

   mutex_lock(&mm->bd_mutex);
   if (!kernel_managed(mm))
      do_trap();
   else if (do_mpx_bt_fault())
      force_sig();
   mutex_unlock(&mm->bd_mutex);
   
No tricks with mmap_sem, no special return value handling. Straight
forward code instead of a convoluted and error prone mess.

Hmm?

Thanks,

	tglx
