Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 17:56:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56774 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860040AbaGKP4kqSr-e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 17:56:40 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 32C6F71893F25;
        Fri, 11 Jul 2014 16:56:31 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 11 Jul 2014 16:56:33 +0100
Received: from localhost (192.168.79.172) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:56:31 +0100
Date:   Fri, 11 Jul 2014 16:56:31 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     chenj <chenj@lemote.com>
CC:     <linux-mips@linux-mips.org>, <chenhc@lemote.com>,
        <ralf@linux-mips.org>, <wangr@lemote.com>
Subject: Re: [PATCH] Not preempt in CP1 exception handling
Message-ID: <20140711155631.GE8187@pburton-laptop>
References: <1405047990-12519-1-git-send-email-chenhc@lemote.com>
 <1405048453-12633-1-git-send-email-chenj@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1405048453-12633-1-git-send-email-chenj@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.79.172]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Fri, Jul 11, 2014 at 11:14:13AM +0800, chenj wrote:
> do_ade may be invoked with preempt enabled. do_cpu will be invoked with
> preempt enabled. When it's preempted(in do_ade/do_cpu), TIF_USEDFPU will be
> cleared, when it returns to do_ade/do_cpu, the fpu is actually disabled.
> 
> e.g.
> In do_ade()
>   emulate_load_store_insn():
>     BUG_ON(!is_fpu_owner()); <-- This assertion may be breaked.
> 
> In do_cpu()
>   enable_restore_fp_context():
>     was_fpu_owner = is_fpu_owner();

Preemption should indeed be disabled around the assignment & use of the
was_fpu_owner variable, but note that you can only hit the problem if
using MSA. One of the MSA fixes I just submitted also fixes this along
with another instance of the problem:

  http://patchwork.linux-mips.org/patch/7307/

I prefer my patch to this since it disables preemption for less time,
in addition to fixing the !used_math() case.

In emulate_load_store_insn I believe the correct fix is simply to remove
that BUG_ON. The code is about to give up FPU ownership anyway, so it's
not like there is any requirement being violated if it was already lost.

Thanks,
    Paul

> This patch simply disables interrupts in related handlers, and
> disable preempt/enable interrupts in do_ade/do_cpu.
> ---
>  arch/mips/kernel/genex.S | 4 ++--
>  arch/mips/kernel/traps.c | 4 ++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index ac35e12..a5c6931 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -370,7 +370,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
>  	.macro	__build_clear_ade
>  	MFC0	t0, CP0_BADVADDR
>  	PTR_S	t0, PT_BVADDR(sp)
> -	KMODE
> +	CLI
>  	.endm
>  
>  	.macro	__BUILD_silent exception
> @@ -422,7 +422,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
>  	BUILD_HANDLER dbe be cli silent			/* #7  */
>  	BUILD_HANDLER bp bp sti silent			/* #9  */
>  	BUILD_HANDLER ri ri sti silent			/* #10 */
> -	BUILD_HANDLER cpu cpu sti silent		/* #11 */
> +	BUILD_HANDLER cpu cpu cli silent		/* #11 */
>  	BUILD_HANDLER ov ov sti silent			/* #12 */
>  	BUILD_HANDLER tr tr sti silent			/* #13 */
>  	BUILD_HANDLER msa_fpe msa_fpe sti silent	/* #14 */
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 51706d6..0e0f7de 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1166,6 +1166,9 @@ asmlinkage void do_cpu(struct pt_regs *regs)
>  	int status, err;
>  	unsigned long __maybe_unused flags;
>  
> +	preempt_disable();
> +	local_irq_enable();
> +
>  	prev_state = exception_enter();
>  	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
>  
> @@ -1258,6 +1261,7 @@ asmlinkage void do_cpu(struct pt_regs *regs)
>  
>  out:
>  	exception_exit(prev_state);
> +	preempt_enable();
>  }
>  
>  asmlinkage void do_msa_fpe(struct pt_regs *regs)
> -- 
> 1.9.0
> 
> 
