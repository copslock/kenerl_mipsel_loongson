Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2011 05:21:46 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:39004 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490977Ab1HZDVl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2011 05:21:41 +0200
Received: by gwb1 with SMTP id 1so2784816gwb.36
        for <linux-mips@linux-mips.org>; Thu, 25 Aug 2011 20:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=O3L5T+FO4hhjBisDb0JWrlNJ4pcMlK2rtx7Az+3QNzY=;
        b=TvpUWxxTmhDlTGzx/1PLyJo3qGeFWrxFi1b6F87k0Hdt2qquOQI6PeJ+WyYdevNp5i
         TfUYd6WEclSTicffMoGoOWetuFb7UXWKGACxsxL/03Ey82Bv6iVSoPNfH/rCH3JYY5K1
         l1cMqiVjzPPgtR6aNonKx9nmSJDkHCByXAUns=
MIME-Version: 1.0
Received: by 10.42.168.3 with SMTP id u3mr300945icy.213.1314328895583; Thu, 25
 Aug 2011 20:21:35 -0700 (PDT)
Received: by 10.42.19.131 with HTTP; Thu, 25 Aug 2011 20:21:35 -0700 (PDT)
In-Reply-To: <20110825080054.GA10459@mails.so.argh.org>
References: <20110821010513.GZ2657@mails.so.argh.org>
        <20110825080054.GA10459@mails.so.argh.org>
Date:   Fri, 26 Aug 2011 11:21:35 +0800
Message-ID: <CAD+V5Y+0JujdTz9ET1LAurCMP6D1nvC1tkoYg+gHXXJ=VL9mMQ@mail.gmail.com>
Subject: Re: [PATCH] mips/loongson: unify compiler flags and load location for
 Loongson 2E and 2F
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Andreas Barth <aba@not.so.argh.org>, linux-mips@linux-mips.org,
        debian-mips@lists.debian.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 30994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19575

Hi, Andreas

Thanks very much for your effort on merging the support for 2E and 2F.

but only this patch is not enough, we may also need to take care of
the following parts:

1. About processors

$ grep LOONGSON2E -ur arch/mips/
arch/mips/kernel/cpu-probe.c:		case PRID_REV_LOONGSON2E:
arch/mips/include/asm/mach-loongson/mem.h:#ifdef CONFIG_CPU_LOONGSON2E
arch/mips/include/asm/mach-loongson/mem.h:#ifdef CONFIG_CPU_LOONGSON2E
arch/mips/include/asm/cpu.h:#define PRID_REV_LOONGSON2E	0x0002
arch/mips/Kconfig:config CPU_LOONGSON2E
arch/mips/Kconfig:	depends on SYS_HAS_CPU_LOONGSON2E
arch/mips/Kconfig:config SYS_HAS_CPU_LOONGSON2E
arch/mips/loongson/Platform:cflags-$(CONFIG_CPU_LOONGSON2E) += \
arch/mips/loongson/Kconfig:	select SYS_HAS_CPU_LOONGSON2E
arch/mips/loongson/common/bonito-irq.c:#ifdef CONFIG_CPU_LOONGSON2E
arch/mips/loongson/common/env.c:		case PRID_REV_LOONGSON2E:

$ grep LOONGSON2F -ur arch/mips/
arch/mips/kernel/cpu-probe.c:		case PRID_REV_LOONGSON2F:
arch/mips/include/asm/mach-loongson/dma-coherence.h:#if
defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
arch/mips/include/asm/stackframe.h:#endif /* CONFIG_CPU_LOONGSON2F */
arch/mips/include/asm/cpu.h:#define PRID_REV_LOONGSON2F	0x0003
arch/mips/Kconfig:config CPU_LOONGSON2F
arch/mips/Kconfig:	depends on SYS_HAS_CPU_LOONGSON2F
arch/mips/Kconfig:if CPU_LOONGSON2F
arch/mips/Kconfig:config CPU_LOONGSON2F_WORKAROUNDS
arch/mips/Kconfig:endif # CPU_LOONGSON2F
arch/mips/Kconfig:config SYS_HAS_CPU_LOONGSON2F
arch/mips/loongson/Platform:cflags-$(CONFIG_CPU_LOONGSON2F) += \
arch/mips/loongson/Platform:ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
arch/mips/loongson/Kconfig:	select SYS_HAS_CPU_LOONGSON2F
arch/mips/loongson/common/env.c:		case PRID_REV_LOONGSON2F:
arch/mips/loongson/common/platform.c:	if ((c->processor_id &
PRID_REV_MASK) >= PRID_REV_LOONGSON2F)

2. About machines

$ grep LEMOTE_FULOONG2E -ur arch/mips/
arch/mips/include/asm/mach-loongson/machine.h:#ifdef CONFIG_LEMOTE_FULOONG2E
arch/mips/pci/Makefile:obj-$(CONFIG_LEMOTE_FULOONG2E)	+=
fixup-fuloong2e.o ops-loongson2.o
arch/mips/loongson/Platform:load-$(CONFIG_LEMOTE_FULOONG2E) +=
0xffffffff80100000
arch/mips/loongson/Kconfig:config LEMOTE_FULOONG2E
arch/mips/loongson/Makefile:obj-$(CONFIG_LEMOTE_FULOONG2E)  += fuloong-2e/

$ grep LEMOTE_MACH2F -ur arch/mips/
arch/mips/include/asm/mach-loongson/machine.h:/* use fuloong2f as the
default machine of LEMOTE_MACH2F */
arch/mips/include/asm/mach-loongson/machine.h:#ifdef CONFIG_LEMOTE_MACH2F
arch/mips/configs/lemote2f_defconfig:CONFIG_LEMOTE_MACH2F=y
arch/mips/pci/Makefile:obj-$(CONFIG_LEMOTE_MACH2F)	+= fixup-lemote2f.o
ops-loongson2.o
arch/mips/loongson/Platform:load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
arch/mips/loongson/Kconfig:config LEMOTE_MACH2F
arch/mips/loongson/Makefile:obj-$(CONFIG_LEMOTE_MACH2F)  += lemote-2f/

Best Regards,
Wu Zhangjin

On 8/25/11, Andreas Barth <aba@not.so.argh.org> wrote:
> This patch starts to merge the Loongson 2E and 2F code together with the
> goal to produce a binary kernel image that can run on both machines. As
> code compiled for 2E cannot run on 2F and vice versa, the usage of cpu
> dependend code is optionally now (and old behaviour is default).
>
> The load address is unified as well, and the 2F workarounds can be enabled
> while compiling on a 2E machine (disabled there by default).
>
> Signed-off-by: Andreas Barth <aba@not.so.argh.org>
> ---
>  arch/mips/Kconfig           |   22 +++++++++++++++++++---
>  arch/mips/loongson/Platform |   15 +++++++++++----
>  2 files changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b122adc..b7b65fb 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1481,7 +1481,7 @@ config CPU_XLR
>  	  Netlogic Microsystems XLR/XLS processors.
>  endchoice
>
> -if CPU_LOONGSON2F
> +if CPU_LOONGSON2
>  config CPU_NOP_WORKAROUNDS
>  	bool
>
> @@ -1490,7 +1490,7 @@ config CPU_JUMP_WORKAROUNDS
>
>  config CPU_LOONGSON2F_WORKAROUNDS
>  	bool "Loongson 2F Workarounds"
> -	default y
> +	default y if !CPU_LOONGSON2E
>  	select CPU_NOP_WORKAROUNDS
>  	select CPU_JUMP_WORKAROUNDS
>  	help
> @@ -1506,7 +1506,23 @@ config CPU_LOONGSON2F_WORKAROUNDS
>  	  systems.
>
>  	  If unsure, please say Y.
> -endif # CPU_LOONGSON2F
> +
> +config CPU_LOONGSON2E_CODE
> +	bool "Loongson 2E-only code"
> +        default y
> +	depends on SYS_HAS_CPU_LOONGSON2E
> +        help
> +          Compile with Loongson 2E specific compiler options. This prevents
> +          the kernel to run on other cpus.
> +
> +config CPU_LOONGSON2F_CODE
> +	bool "Loongson 2F-only code"
> +        default y
> +	depends on SYS_HAS_CPU_LOONGSON2F
> +        help
> +          Compile with Loongson 2F specific compiler options. This prevents
> +          the kernel to run on other cpus.
> +endif # CPU_LOONGSON2
>
>  config SYS_SUPPORTS_ZBOOT
>  	bool
> diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
> index 29692e5..df52393 100644
> --- a/arch/mips/loongson/Platform
> +++ b/arch/mips/loongson/Platform
> @@ -4,10 +4,18 @@
>
>  # Only gcc >= 4.4 have Loongson specific support
>  cflags-$(CONFIG_CPU_LOONGSON2)	+= -Wa,--trap
> -cflags-$(CONFIG_CPU_LOONGSON2E) += \
> +ifdef CONFIG_CPU_LOONGSON2E_CODE
> +    cflags-$(CONFIG_CPU_LOONGSON2) += \
>  	$(call cc-option,-march=loongson2e,-march=r4600)
> -cflags-$(CONFIG_CPU_LOONGSON2F) += \
> +else
> +  ifdef CONFIG_CPU_LOONGSON2F_CODE
> +    cflags-$(CONFIG_CPU_LOONGSON2) += \
>  	$(call cc-option,-march=loongson2f,-march=r4600)
> +  else
> +    cflags-$(CONFIG_CPU_LOONGSON2) += \
> +	$(call cc-option,-march=r4600)
> +  endif
> +endif
>  # Enable the workarounds for Loongson2f
>  ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
>    ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-nop,),)
> @@ -28,5 +36,4 @@ endif
>
>  platform-$(CONFIG_MACH_LOONGSON) += loongson/
>  cflags-$(CONFIG_MACH_LOONGSON) +=
> -I$(srctree)/arch/mips/include/asm/mach-loongson -mno-branch-likely
> -load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
> -load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
> +load-$(CONFIG_MACH_LOONGSON) += 0xffffffff80200000
> --
> 1.5.6.5
>
>
>
