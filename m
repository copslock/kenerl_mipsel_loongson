Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2007 19:34:28 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:40159 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023430AbXJ1Te0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 Oct 2007 19:34:26 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9SJYMTU008605;
	Sun, 28 Oct 2007 19:34:22 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9SJYLUf008604;
	Sun, 28 Oct 2007 19:34:21 GMT
Date:	Sun, 28 Oct 2007 19:34:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Daniel Jacobowitz <dan@debian.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] store sign-extend register values for PTRACE_GETREGS
Message-ID: <20071028193421.GC7661@linux-mips.org>
References: <20070304.024152.96687132.anemo@mba.ocn.ne.jp> <20071026.005302.25909293.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071026.005302.25909293.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 26, 2007 at 12:53:02AM +0900, Atsushi Nemoto wrote:

Daniel, do you see any debugger compatibility issues with this patch?

> From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Date: Fri, 26 Oct 2007 00:53:02 +0900 (JST)
> To: linux-mips@linux-mips.org
> Cc: ralf@linux-mips.org
> Subject: Re: [PATCH] store sign-extend register values for PTRACE_GETREGS
> Content-Type: Text/Plain; charset=us-ascii
> 
> On Sun, 04 Mar 2007 02:41:52 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > A comment on ptrace_getregs() states "Registers are sign extended to
> > fill the available space." but it is not true.  Fix code to match the
> > comment.  Also fix casts on each caller to get rid of some warnings.
> 
> Revised for current git tree.
> 
> ------------------------------------------------------
> Subject: [PATCH] store sign-extend register values for PTRACE_GETREGS
> From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> A comment on ptrace_getregs() states "Registers are sign extended to
> fill the available space." but it is not true.  Fix code to match the
> comment.  Also fix casts on each caller to get rid of some warnings.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
>  arch/mips/kernel/ptrace.c   |   18 +++++++++---------
>  arch/mips/kernel/ptrace32.c |    4 ++--
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> index 999f785..35234b9 100644
> --- a/arch/mips/kernel/ptrace.c
> +++ b/arch/mips/kernel/ptrace.c
> @@ -65,13 +65,13 @@ int ptrace_getregs(struct task_struct *child, __s64 __user *data)
>  	regs = task_pt_regs(child);
>  
>  	for (i = 0; i < 32; i++)
> -		__put_user(regs->regs[i], data + i);
> -	__put_user(regs->lo, data + EF_LO - EF_R0);
> -	__put_user(regs->hi, data + EF_HI - EF_R0);
> -	__put_user(regs->cp0_epc, data + EF_CP0_EPC - EF_R0);
> -	__put_user(regs->cp0_badvaddr, data + EF_CP0_BADVADDR - EF_R0);
> -	__put_user(regs->cp0_status, data + EF_CP0_STATUS - EF_R0);
> -	__put_user(regs->cp0_cause, data + EF_CP0_CAUSE - EF_R0);
> +		__put_user((long)regs->regs[i], data + i);
> +	__put_user((long)regs->lo, data + EF_LO - EF_R0);
> +	__put_user((long)regs->hi, data + EF_HI - EF_R0);
> +	__put_user((long)regs->cp0_epc, data + EF_CP0_EPC - EF_R0);
> +	__put_user((long)regs->cp0_badvaddr, data + EF_CP0_BADVADDR - EF_R0);
> +	__put_user((long)regs->cp0_status, data + EF_CP0_STATUS - EF_R0);
> +	__put_user((long)regs->cp0_cause, data + EF_CP0_CAUSE - EF_R0);
>  
>  	return 0;
>  }
> @@ -390,11 +390,11 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
>  		}
>  
>  	case PTRACE_GETREGS:
> -		ret = ptrace_getregs(child, (__u64 __user *) data);
> +		ret = ptrace_getregs(child, (__s64 __user *) data);
>  		break;
>  
>  	case PTRACE_SETREGS:
> -		ret = ptrace_setregs(child, (__u64 __user *) data);
> +		ret = ptrace_setregs(child, (__s64 __user *) data);
>  		break;
>  
>  	case PTRACE_GETFPREGS:
> diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
> index f2bffed..76818be 100644
> --- a/arch/mips/kernel/ptrace32.c
> +++ b/arch/mips/kernel/ptrace32.c
> @@ -346,11 +346,11 @@ asmlinkage int sys32_ptrace(int request, int pid, int addr, int data)
>  		}
>  
>  	case PTRACE_GETREGS:
> -		ret = ptrace_getregs(child, (__u64 __user *) (__u64) data);
> +		ret = ptrace_getregs(child, (__s64 __user *) (__u64) data);
>  		break;
>  
>  	case PTRACE_SETREGS:
> -		ret = ptrace_setregs(child, (__u64 __user *) (__u64) data);
> +		ret = ptrace_setregs(child, (__s64 __user *) (__u64) data);
>  		break;
>  
>  	case PTRACE_GETFPREGS:

  Ralf
