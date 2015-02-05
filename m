Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2015 22:19:25 +0100 (CET)
Received: from pegasus3.altlinux.org ([194.107.17.103]:44737 "EHLO
        pegasus3.altlinux.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012657AbbBEVTWIgx5m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Feb 2015 22:19:22 +0100
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by pegasus3.altlinux.org (Postfix) with ESMTP id AF68980A7D;
        Fri,  6 Feb 2015 00:19:16 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id A16ECAC5BD8; Fri,  6 Feb 2015 00:19:16 +0300 (MSK)
Date:   Fri, 6 Feb 2015 00:19:16 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v5 3/5] x86: Split syscall_trace_enter into two phases
Message-ID: <20150205211916.GA31367@altlinux.org>
References: <cover.1409954077.git.luto@amacapital.net> <2df320a600020fda055fccf2b668145729dd0c04.1409954077.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2df320a600020fda055fccf2b668145729dd0c04.1409954077.git.luto@amacapital.net>
Return-Path: <ldv@altlinux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ldv@altlinux.org
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

Hi,

On Fri, Sep 05, 2014 at 03:13:54PM -0700, Andy Lutomirski wrote:
> This splits syscall_trace_enter into syscall_trace_enter_phase1 and
> syscall_trace_enter_phase2.  Only phase 2 has full pt_regs, and only
> phase 2 is permitted to modify any of pt_regs except for orig_ax.

This breaks ptrace, see below.

> The intent is that phase 1 can be called from the syscall fast path.
> 
> In this implementation, phase1 can handle any combination of
> TIF_NOHZ (RCU context tracking), TIF_SECCOMP, and TIF_SYSCALL_AUDIT,
> unless seccomp requests a ptrace event, in which case phase2 is
> forced.
> 
> In principle, this could yield a big speedup for TIF_NOHZ as well as
> for TIF_SECCOMP if syscall exit work were similarly split up.
> 
> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> ---
>  arch/x86/include/asm/ptrace.h |   5 ++
>  arch/x86/kernel/ptrace.c      | 157 +++++++++++++++++++++++++++++++++++-------
>  2 files changed, 138 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
> index 6205f0c434db..86fc2bb82287 100644
> --- a/arch/x86/include/asm/ptrace.h
> +++ b/arch/x86/include/asm/ptrace.h
> @@ -75,6 +75,11 @@ convert_ip_to_linear(struct task_struct *child, struct pt_regs *regs);
>  extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
>  			 int error_code, int si_code);
>  
> +
> +extern unsigned long syscall_trace_enter_phase1(struct pt_regs *, u32 arch);
> +extern long syscall_trace_enter_phase2(struct pt_regs *, u32 arch,
> +				       unsigned long phase1_result);
> +
>  extern long syscall_trace_enter(struct pt_regs *);
>  extern void syscall_trace_leave(struct pt_regs *);
>  
> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> index bbf338a04a5d..29576c244699 100644
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c
> @@ -1441,20 +1441,126 @@ void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
>  	force_sig_info(SIGTRAP, &info, tsk);
>  }
>  
> +static void do_audit_syscall_entry(struct pt_regs *regs, u32 arch)
> +{
> +#ifdef CONFIG_X86_64
> +	if (arch == AUDIT_ARCH_X86_64) {
> +		audit_syscall_entry(arch, regs->orig_ax, regs->di,
> +				    regs->si, regs->dx, regs->r10);
> +	} else
> +#endif
> +	{
> +		audit_syscall_entry(arch, regs->orig_ax, regs->bx,
> +				    regs->cx, regs->dx, regs->si);
> +	}
> +}
> +
>  /*
> - * We must return the syscall number to actually look up in the table.
> - * This can be -1L to skip running any syscall at all.
> + * We can return 0 to resume the syscall or anything else to go to phase
> + * 2.  If we resume the syscall, we need to put something appropriate in
> + * regs->orig_ax.
> + *
> + * NB: We don't have full pt_regs here, but regs->orig_ax and regs->ax
> + * are fully functional.
> + *
> + * For phase 2's benefit, our return value is:
> + * 0:			resume the syscall
> + * 1:			go to phase 2; no seccomp phase 2 needed
> + * anything else:	go to phase 2; pass return value to seccomp
>   */
> -long syscall_trace_enter(struct pt_regs *regs)
> +unsigned long syscall_trace_enter_phase1(struct pt_regs *regs, u32 arch)
>  {
> -	long ret = 0;
> +	unsigned long ret = 0;
> +	u32 work;
> +
> +	BUG_ON(regs != task_pt_regs(current));
> +
> +	work = ACCESS_ONCE(current_thread_info()->flags) &
> +		_TIF_WORK_SYSCALL_ENTRY;
>  
>  	/*
>  	 * If TIF_NOHZ is set, we are required to call user_exit() before
>  	 * doing anything that could touch RCU.
>  	 */
> -	if (test_thread_flag(TIF_NOHZ))
> +	if (work & _TIF_NOHZ) {
>  		user_exit();
> +		work &= ~TIF_NOHZ;
> +	}
> +
> +#ifdef CONFIG_SECCOMP
> +	/*
> +	 * Do seccomp first -- it should minimize exposure of other
> +	 * code, and keeping seccomp fast is probably more valuable
> +	 * than the rest of this.
> +	 */
> +	if (work & _TIF_SECCOMP) {
> +		struct seccomp_data sd;
> +
> +		sd.arch = arch;
> +		sd.nr = regs->orig_ax;
> +		sd.instruction_pointer = regs->ip;
> +#ifdef CONFIG_X86_64
> +		if (arch == AUDIT_ARCH_X86_64) {
> +			sd.args[0] = regs->di;
> +			sd.args[1] = regs->si;
> +			sd.args[2] = regs->dx;
> +			sd.args[3] = regs->r10;
> +			sd.args[4] = regs->r8;
> +			sd.args[5] = regs->r9;
> +		} else
> +#endif
> +		{
> +			sd.args[0] = regs->bx;
> +			sd.args[1] = regs->cx;
> +			sd.args[2] = regs->dx;
> +			sd.args[3] = regs->si;
> +			sd.args[4] = regs->di;
> +			sd.args[5] = regs->bp;
> +		}
> +
> +		BUILD_BUG_ON(SECCOMP_PHASE1_OK != 0);
> +		BUILD_BUG_ON(SECCOMP_PHASE1_SKIP != 1);
> +
> +		ret = seccomp_phase1(&sd);
> +		if (ret == SECCOMP_PHASE1_SKIP) {
> +			regs->orig_ax = -1;

How the tracer is expected to get the correct syscall number after that?


-- 
ldv
