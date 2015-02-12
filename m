Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2015 15:26:43 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8695 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013309AbbBLO0lKqwmZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Feb 2015 15:26:41 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5BDFE28C8F825;
        Thu, 12 Feb 2015 14:26:32 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 12 Feb 2015 14:26:35 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 12 Feb
 2015 14:26:33 +0000
Message-ID: <54DCB819.3000406@imgtec.com>
Date:   Thu, 12 Feb 2015 14:26:33 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Lars Persson <lars.persson@axis.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>
CC:     Lars Persson <larper@axis.com>
Subject: Re: [PATCH] MIPS: Fix syscall_get_nr for the syscall exit tracing.
References: <1422979697-1509-1-git-send-email-larper@axis.com>
In-Reply-To: <1422979697-1509-1-git-send-email-larper@axis.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 02/03/2015 04:08 PM, Lars Persson wrote:
> Register 2 is alredy overwritten by the return value when
> syscall_trace_leave() is called.
> 
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>  arch/mips/include/asm/syscall.h     |    8 +-------
>  arch/mips/include/asm/thread_info.h |    1 +
>  arch/mips/kernel/ptrace.c           |    2 ++
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
> index bb79637..6499d93 100644
> --- a/arch/mips/include/asm/syscall.h
> +++ b/arch/mips/include/asm/syscall.h
> @@ -29,13 +29,7 @@
>  static inline long syscall_get_nr(struct task_struct *task,
>  				  struct pt_regs *regs)
>  {
> -	/* O32 ABI syscall() - Either 64-bit with O32 or 32-bit */
> -	if ((config_enabled(CONFIG_32BIT) ||
> -	    test_tsk_thread_flag(task, TIF_32BIT_REGS)) &&
> -	    (regs->regs[2] == __NR_syscall))
> -		return regs->regs[4];
> -	else
> -		return regs->regs[2];
> +	return current_thread_info()->syscall;
>  }
>  
>  static inline unsigned long mips_get_syscall_arg(unsigned long *arg,
> diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
> index 99eea59..e4440f9 100644
> --- a/arch/mips/include/asm/thread_info.h
> +++ b/arch/mips/include/asm/thread_info.h
> @@ -36,6 +36,7 @@ struct thread_info {
>  						 */
>  	struct restart_block	restart_block;
>  	struct pt_regs		*regs;
> +	long			syscall;	/* syscall number */
>  };
>  
>  /*
> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> index 9d1487d..5104528 100644
> --- a/arch/mips/kernel/ptrace.c
> +++ b/arch/mips/kernel/ptrace.c
> @@ -770,6 +770,8 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
>  	long ret = 0;
>  	user_exit();
>  
> +	current_thread_info()->syscall = syscall;
> +
>  	if (secure_computing() == -1)
>  		return -1;
>  
> 

Hi,

This is now in mainline but parts of it can apply to stable as well?
Would you be willing to send a backported version for the stable trees?
Thanks a lot

-- 
markos
