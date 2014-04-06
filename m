Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Apr 2014 13:09:30 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:49035 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816417AbaDFLJ2A8j3a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Apr 2014 13:09:28 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 41AC27E2E;
        Sun,  6 Apr 2014 13:09:27 +0200 (CEST)
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 38FSOtIHUCLs; Sun,  6 Apr 2014 13:09:23 +0200 (CEST)
Received: from [134.102.119.37] (eduroam-pool7-1829.wlan.uni-bremen.de [134.102.119.37])
        by hauke-m.de (Postfix) with ESMTPSA id 145BB7E23;
        Sun,  6 Apr 2014 13:09:23 +0200 (CEST)
Message-ID: <534135E2.3000501@hauke-m.de>
Date:   Sun, 06 Apr 2014 13:09:22 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH v2] MIPS: make FPU emulator optional
References: <1396781508-622215-1-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1396781508-622215-1-git-send-email-manuel.lauss@gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 04/06/2014 12:51 PM, Manuel Lauss wrote:
> This small patch makes the MIPS FPU emulator optional. The kernel
> kills float-users on systems without a hardware FPU by sending a SIGILL.
> 
> The Emulator can't be turned off on systems which support microMIPS
> because parts of the microMIPS support code live in the emu code.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> v2: incorporated changes suggested by Hauke Mehrtens,
>     force the fpu emulator on for micromips: relocating the parts
>     of the mmips code in the emulator to other areas would be a
>     much larger change; I went the cheap route instead with this.

Did I suggest anything? I was planing to point you to the patch in
OpenWrt, but Jonas already did so.

> Disabling the emulator saves about 54kBytes (32bit, optimizing for size).

What about putting this number into the commit message or into the help
text.

>  arch/mips/Kbuild                     |  2 +-
>  arch/mips/Kconfig                    | 15 +++++++++++++++
>  arch/mips/include/asm/fpu.h          |  5 +++--
>  arch/mips/include/asm/fpu_emulator.h | 27 ++++++++++++++++++++++++++-
>  4 files changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
> index d2cfe45..426c264 100644
> --- a/arch/mips/Kbuild
> +++ b/arch/mips/Kbuild
> @@ -16,7 +16,7 @@ obj- := $(platform-)
>  
>  obj-y += kernel/
>  obj-y += mm/
> -obj-y += math-emu/
> +obj-$(CONFIG_MIPS_FPU_EMULATOR) += math-emu/
>  
>  ifdef CONFIG_KVM
>  obj-y += kvm/
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 9b53358..e9dd80e 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2208,6 +2208,7 @@ config SYS_SUPPORTS_SMARTMIPS
>  
>  config SYS_SUPPORTS_MICROMIPS
>  	bool
> +	select MIPS_FPU_EMULATOR	# houses tiny parts of the mmips code
>  
>  config CPU_SUPPORTS_MSA
>  	bool
> @@ -2482,6 +2483,20 @@ config MIPS_O32_FP64_SUPPORT
>  
>  	  If unsure, say N.
>  
> +config MIPS_FPU_EMULATOR
> +	bool "MIPS FPU Emulator"
> +	default y
> +	help
> +	  This option lets you disable the built-in MIPS FPU (Coprocessor 1)
> +	  emulator, which handles floating-point instructions on processors
> +	  without a hardware FPU.  It is generally a good idea to keep the
> +	  emulator built-in, unless you are perfectly sure you have a
> +	  complete soft-float environment.  With the emulator disabled, all
> +	  users of float operations will be killed with an illegal instr-
> +	  uction exception.
> +
> +	  Say Y, please.
> +
>  config USE_OF
>  	bool
>  	select OF
> diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
> index 4d86b72..c5203bb 100644
> --- a/arch/mips/include/asm/fpu.h
> +++ b/arch/mips/include/asm/fpu.h
> @@ -160,9 +160,10 @@ static inline int init_fpu(void)
>  		ret = __own_fpu();
>  		if (!ret)
>  			_init_fpu();
> -	} else {
> +	} else if (IS_ENABLED(CONFIG_MIPS_FPU_EMULATOR))
>  		fpu_emulator_init_fpu();
> -	}
> +	else
> +		ret = SIGILL;
>  
>  	preempt_enable();
>  	return ret;
> diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
> index 2abb587..26a71ba 100644
> --- a/arch/mips/include/asm/fpu_emulator.h
> +++ b/arch/mips/include/asm/fpu_emulator.h
> @@ -27,6 +27,7 @@
>  #include <asm/inst.h>
>  #include <asm/local.h>
>  
> +#ifdef CONFIG_MIPS_FPU_EMULATOR
>  #ifdef CONFIG_DEBUG_FS
>  
>  struct mips_fpu_emulator_stats {
> @@ -57,9 +58,33 @@ extern int do_dsemulret(struct pt_regs *xcp);
>  extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
>  				    struct mips_fpu_struct *ctx, int has_fpu,
>  				    void *__user *fault_addr);
> -int process_fpemu_return(int sig, void __user *fault_addr);
>  int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>  		     unsigned long *contpc);
> +#else	/* no CONFIG_MIPS_FPU_EMULATOR */
> +static inline int do_dsemulret(struct pt_regs *xcp)
> +{
> +	return 0;	/* 0 means error, should never get here anyway */
> +}
> +
> +static inline int fpu_emulator_cop1Handler(struct pt_regs *xcp,
> +				struct mips_fpu_struct *ctx, int has_fpu,
> +				void *__user *fault_addr)
> +{
> +	return SIGILL;	/* we don't speak MIPS FPU */
> +}
> +
> +static inline int mm_isBranchInstr(struct pt_regs *regs,
> +				   struct mm_decoded_insn dec_insn,
> +				   unsigned long *contpc)
> +{
> +	BUG();		/* should never ever get here */
> +	return 0;
> +}
> +#endif	/* CONFIG_MIPS_FPU_EMULATOR */
> +
> +
> +int process_fpemu_return(int sig, void __user *fault_addr);
> +
>  
>  /*
>   * Instruction inserted following the badinst to further tag the sequence
> 
