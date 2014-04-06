Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Apr 2014 07:08:54 +0200 (CEST)
Received: from 0.mx.nanl.de ([217.115.11.12]:49730 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816019AbaDFFIv3nuQS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 6 Apr 2014 07:08:51 +0200
Received: from mail-qa0-f54.google.com (mail-qa0-f54.google.com [209.85.216.54])
        by mail.nanl.de (Postfix) with ESMTPSA id C4902460CF
        for <linux-mips@linux-mips.org>; Sun,  6 Apr 2014 05:08:13 +0000 (UTC)
Received: by mail-qa0-f54.google.com with SMTP id w8so4746485qac.27
        for <linux-mips@linux-mips.org>; Sat, 05 Apr 2014 22:08:45 -0700 (PDT)
X-Received: by 10.140.47.86 with SMTP id l80mr23986325qga.9.1396760925600;
 Sat, 05 Apr 2014 22:08:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.109.97 with HTTP; Sat, 5 Apr 2014 22:08:25 -0700 (PDT)
In-Reply-To: <1396738335-475011-1-git-send-email-manuel.lauss@gmail.com>
References: <1396738335-475011-1-git-send-email-manuel.lauss@gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sun, 6 Apr 2014 07:08:25 +0200
Message-ID: <CAOiHx=m-DJHgVKOGNMwePqCZMe8YnCnqjk7X-8VegUoHmXSExA@mail.gmail.com>
Subject: Re: [RFC PATCH] MIPS: make FPU emulator optional
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Sun, Apr 6, 2014 at 12:52 AM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
> Add a config option to disable the FPU emulator.
> Saves around 56kB on 32bit, and kills FPU users with SIGILL.

Looks similar to what we do in OpenWrt[1]. Main differences are we
also stub out process_fpemu_return and emit a notice into the kernel
log that the FPU emulator is disabled.

> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
>  arch/mips/Kbuild                     |  2 ++
>  arch/mips/Kconfig                    | 14 ++++++++++++++
>  arch/mips/include/asm/fpu.h          |  2 ++
>  arch/mips/include/asm/fpu_emulator.h | 24 +++++++++++++++++++++++-
>  4 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
> index d2cfe45..da76dc0 100644
> --- a/arch/mips/Kbuild
> +++ b/arch/mips/Kbuild
> @@ -16,7 +16,9 @@ obj- := $(platform-)
>
>  obj-y += kernel/
>  obj-y += mm/
> +ifdef CONFIG_MIPS_FPU_EMULATOR
>  obj-y += math-emu/
> +endif

You can write this as obj-$(CONFIG_MIPS_FPU_EMULATOR) += math-emu/

>
>  ifdef CONFIG_KVM
>  obj-y += kvm/
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 9b53358..9a8d7ed 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2482,6 +2482,20 @@ config MIPS_O32_FP64_SUPPORT
>
>           If unsure, say N.
>
> +config MIPS_FPU_EMULATOR
> +       bool "Support for MIPS FPU Emulator"
> +       default y
> +       help
> +         This option lets you disable the built-in MIPS FPU (Cop1)
> +         Emulator.  This emulator executes floating-point instructions on
> +         processors which don't have a built-in floating point unit.
> +         It is generally a very good idea to keep this support built in,
> +         only disable it if you have a complete soft-float userland.
> +         Any use of floating point operations in userspace will result in
> +         the process being killed with an illegal instruction exception.
> +
> +         Say Y, please.
> +
>  config USE_OF
>         bool
>         select OF
> diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
> index 4d86b72..d6c3d97 100644
> --- a/arch/mips/include/asm/fpu.h
> +++ b/arch/mips/include/asm/fpu.h
> @@ -161,7 +161,9 @@ static inline int init_fpu(void)
>                 if (!ret)
>                         _init_fpu();
>         } else {
> +#ifdef CONFIG_MIPS_FPU_EMULATOR
>                 fpu_emulator_init_fpu();
> +#endif

Maybe do something like

        } else if (IS_ENABLED(CONFIG_MIPS_FPU_EMULATOR)) {
               fpu_emulator_init_fpu();

which kooks a bit nicer IMHO.

>         }
>
>         preempt_enable();
> diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
> index 2abb587..b2c1524 100644
> --- a/arch/mips/include/asm/fpu_emulator.h
> +++ b/arch/mips/include/asm/fpu_emulator.h
> @@ -53,13 +53,35 @@ do {                                                                        \
>
>  extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
>         unsigned long cpc);
> +int process_fpemu_return(int sig, void __user *fault_addr);
> +
> +#ifdef CONFIG_MIPS_FPU_EMULATOR
>  extern int do_dsemulret(struct pt_regs *xcp);
>  extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
>                                     struct mips_fpu_struct *ctx, int has_fpu,
>                                     void *__user *fault_addr);
> -int process_fpemu_return(int sig, void __user *fault_addr);
>  int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
>                      unsigned long *contpc);
> +#else  /* no CONFIG_MIPS_FPU_EMULATOR */
> +static inline int do_dsemulret(struct pt_regs *xcp)
> +{
> +       return 0;       /* 0 means error, should never get here anyway */
> +}
> +
> +static inline int fpu_emulator_cop1Handler(struct pt_regs *xcp,
> +                               struct mips_fpu_struct *ctx, int has_fpu,
> +                               void *__user *fault_addr)
> +{
> +       return SIGILL;  /* we don't speak MIPS FPU */
> +}
> +
> +static inline int mm_isBranchInstr(struct pt_regs *regs,
> +                                  struct mm_decoded_insn dec_insn,
> +                                  unsigned long *contpc)
> +{
> +       return 0;
> +}

Won't this break micromips support? mm_isBranchInstr is called from a
few other places outside the FPU emulator.


Regards
Jonas

[1] http://git.openwrt.org/?p=openwrt.git;a=blob;f=target/linux/generic/patches-3.14/304-mips_disable_fpu.patch;h=4536ce6dae80710e530dd7c67c8c8728f95ee3e6;hb=HEAD
