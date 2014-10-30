Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 23:38:26 +0100 (CET)
Received: from mga03.intel.com ([134.134.136.65]:22857 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012329AbaJ3WiZKUDic (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Oct 2014 23:38:25 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 30 Oct 2014 15:36:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,289,1413270000"; 
   d="scan'208";a="628645501"
Received: from smoffitt-mobl.ger.corp.intel.com (HELO [10.255.13.116]) ([10.255.13.116])
  by orsmga002.jf.intel.com with ESMTP; 30 Oct 2014 15:38:17 -0700
Message-ID: <5452BDD8.2080605@intel.com>
Date:   Thu, 30 Oct 2014 15:38:16 -0700
From:   Dave Hansen <dave.hansen@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
MIME-Version: 1.0
To:     Qiaowei Ren <qiaowei.ren@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
CC:     x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v9 09/12] x86, mpx: decode MPX instruction to get bound
 violation information
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-10-git-send-email-qiaowei.ren@intel.com>
In-Reply-To: <1413088915-13428-10-git-send-email-qiaowei.ren@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <dave.hansen@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave.hansen@intel.com
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

> +void do_mpx_bounds(struct pt_regs *regs, siginfo_t *info,
> +		struct xsave_struct *xsave_buf)
> +{
> +	struct mpx_insn insn;
> +	uint8_t bndregno;
> +	unsigned long addr_vio;
> +
> +	addr_vio = mpx_insn_decode(&insn, regs);
> +
> +	bndregno = X86_MODRM_REG(insn.modrm.value);
> +	if (bndregno > 3)
> +		return;
> +
> +	/* Note: the upper 32 bits are ignored in 32-bit mode. */
> +	info->si_lower = (void __user *)(unsigned long)
> +		(xsave_buf->bndregs.bndregs[2*bndregno]);
> +	info->si_upper = (void __user *)(unsigned long)
> +		(~xsave_buf->bndregs.bndregs[2*bndregno+1]);
> +	info->si_addr_lsb = 0;
> +	info->si_signo = SIGSEGV;
> +	info->si_errno = 0;
> +	info->si_code = SEGV_BNDERR;
> +	info->si_addr = (void __user *)addr_vio;
> +}
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 611b6ec..b2a916b 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -284,6 +284,7 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
>  	unsigned long status;
>  	struct xsave_struct *xsave_buf;
>  	struct task_struct *tsk = current;
> +	siginfo_t info;
>  
>  	prev_state = exception_enter();
>  	if (notify_die(DIE_TRAP, "bounds", regs, error_code,
> @@ -316,6 +317,11 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
>  		break;
>  
>  	case 1: /* Bound violation. */
> +		do_mpx_bounds(regs, &info, xsave_buf);
> +		do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs,
> +				error_code, &info);
> +		break;
> +
>  	case 0: /* No exception caused by Intel MPX operations. */
>  		do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, NULL);
>  		break;
> 

So, siginfo is stack-allocarted here.  do_mpx_bounds() can error out if
it sees an invalid bndregno.  We still send the signal with the &info
whether or not we filled the 'info' in do_mpx_bounds().

Can't this leak some kernel stack out in the 'info'?
