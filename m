Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jun 2013 00:31:43 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44489 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827443Ab3F1WblI1Cn9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 29 Jun 2013 00:31:41 +0200
Received: from mail-vb0-x22a.google.com (mail-vb0-x22a.google.com [IPv6:2607:f8b0:400c:c02::22a])
        by mail.nanl.de (Postfix) with ESMTPSA id DD14945FC3;
        Fri, 28 Jun 2013 22:31:30 +0000 (UTC)
Received: by mail-vb0-f42.google.com with SMTP id i3so2200884vbh.1
        for <multiple recipients>; Fri, 28 Jun 2013 15:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=K+2oNsDCI8waFpkoX9d0HNmc2JvDeOlh3BvxlsxID/Y=;
        b=TSFBZezegHhIxgbJKoYIlm1JpOONFsthCO50UsqB1l0eNpcoCzVQl+Jqg85lGR5pJ0
         O0fGBXPmxG8GmJRYN5DyxX/0X+cV4KYPNzz448SzgBaxUxYQ/aPyrYzrNtEFiNjU54iz
         EslQDp/k54NHOfhXyvmBgrzV1P0DANNID4ud+M4Y3t2gjXKAaE/hFr6EBNCOtlhE0rmU
         NH0etxa4a2rPoaFWCvwYuCi2C3CfNUhTIYdzykLLScVtot3vtswZzmlNUnX7CYMVxNCV
         vs6t2iGPtMDdUYKuHMUtxjcJv+jvhG8vuluZtvEXVmMG1I1Z5Vy91vJ6iIg237hiUfcb
         GE6Q==
X-Received: by 10.58.118.8 with SMTP id ki8mr6153908veb.84.1372458695720; Fri,
 28 Jun 2013 15:31:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.177.193 with HTTP; Fri, 28 Jun 2013 15:31:15 -0700 (PDT)
In-Reply-To: <1372454107-7784-1-git-send-email-Steven.Hill@imgtec.com>
References: <1372454107-7784-1-git-send-email-Steven.Hill@imgtec.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sat, 29 Jun 2013 00:31:15 +0200
Message-ID: <CAOiHx==kc6qJT=LmnG_MZBDPUzPKwuArpf6oXAMoKkWd5WjgVg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Reduce kernel binary size.
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W . Rozycki" <macro@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37216
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

On Fri, Jun 28, 2013 at 11:15 PM, Steven J. Hill <Steven.Hill@imgtec.com> wrote:
> From: Ralf Baechle <ralf@linux-mips.org>
>
> Original idea from <http://patchwork.linux-mips.org/patch/4701/>.
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
>  arch/mips/cavium-octeon/csrc-octeon.c |    1 +
>  arch/mips/include/asm/cpu-features.h  |    4 -
>  arch/mips/include/asm/cpu-type.h      |  196 +++++++++++++++++++++++++++++++++
>  arch/mips/kernel/cpu-probe.c          |    3 +-
>  arch/mips/kernel/idle.c               |    3 +-
>  arch/mips/kernel/time.c               |    1 +
>  arch/mips/kernel/traps.c              |    3 +-
>  arch/mips/mm/c-octeon.c               |    6 +-
>  arch/mips/mm/c-r4k.c                  |   14 +--
>  arch/mips/mm/dma-default.c            |    8 ++
>  arch/mips/mm/page.c                   |    1 +
>  arch/mips/mm/sc-mips.c                |    3 +-
>  arch/mips/mm/tlb-r4k.c                |    1 +
>  arch/mips/mm/tlbex.c                  |    1 +
>  arch/mips/oprofile/common.c           |    1 +
>  arch/mips/oprofile/op_model_mipsxx.c  |    1 +
>  16 files changed, 230 insertions(+), 17 deletions(-)
>  create mode 100644 arch/mips/include/asm/cpu-type.h
>
> diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
> index 0219395..b752c4e 100644
> --- a/arch/mips/cavium-octeon/csrc-octeon.c
> +++ b/arch/mips/cavium-octeon/csrc-octeon.c
> @@ -12,6 +12,7 @@
>  #include <linux/smp.h>
>
>  #include <asm/cpu-info.h>
> +#include <asm/cpu-type.h>
>  #include <asm/time.h>
>
>  #include <asm/octeon/octeon.h>
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index 1dc0860..51680d1 100644
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -13,10 +13,6 @@
>  #include <asm/cpu-info.h>
>  #include <cpu-feature-overrides.h>
>
> -#ifndef current_cpu_type
> -#define current_cpu_type()     current_cpu_data.cputype
> -#endif
> -
>  /*
>   * SMP assumption: Options of CPU 0 are a superset of all processors.
>   * This is true for all known MIPS systems.
> diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
> new file mode 100644
> index 0000000..143610e
> --- /dev/null
> +++ b/arch/mips/include/asm/cpu-type.h
> @@ -0,0 +1,196 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2003, 2004 Ralf Baechle
> + * Copyright (C) 2004  Maciej W. Rozycki
> + */
> +#ifndef __ASM_CPU_TYPE_H
> +#define __ASM_CPU_TYPE_H
> +
> +#include <linux/compiler.h>
> +
> +static inline int __pure current_cpu_type(void)
> +{
> +       const int cpu_type = current_cpu_data.cputype;
> +
> +       switch (cpu_type) {
> +#if defined(CONFIG_SYS_HAS_CPU_LOONGSON2E) || \
> +    defined(CONFIG_SYS_HAS_CPU_LOONGSON2F)
> +       case CPU_LOONGSON2:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_LOONGSON1B
> +       case CPU_LOONGSON1:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_MIPS32_R1
> +       case CPU_4KC:
> +       case CPU_ALCHEMY:
> +       case CPU_PR4450:
> +       case CPU_BMIPS32:
> +       case CPU_JZRISC:
> +#endif
> +
> +#if defined(CONFIG_SYS_HAS_CPU_MIPS32_R1) || \
> +    defined(CONFIG_SYS_HAS_CPU_MIPS32_R2)
> +       case CPU_4KEC:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_MIPS32_R2
> +       case CPU_4KSC:
> +       case CPU_24K:
> +       case CPU_34K:
> +       case CPU_1004K:
> +       case CPU_74K:
> +       case CPU_M14KC:
> +       case CPU_M14KEC:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_MIPS64_R1
> +       case CPU_5KC:
> +       case CPU_5KE:
> +       case CPU_20KC:
> +       case CPU_25KF:
> +       case CPU_SB1:
> +       case CPU_SB1A:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_MIPS64_R2
> +       /*
> +        * All MIPS64 R2 processors have their own special symbols.  That is,
> +        * there currently is no pure R2 core
> +        */
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_R3000
> +       case CPU_R2000:
> +       case CPU_R3000:
> +       case CPU_R3000A:
> +       case CPU_R3041:
> +       case CPU_R3051:
> +       case CPU_R3052:
> +       case CPU_R3081:
> +       case CPU_R3081E:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_TX39XX
> +       case CPU_TX3912:
> +       case CPU_TX3922:
> +       case CPU_TX3927:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_VR41XX
> +       case CPU_VR41XX:
> +       case CPU_VR4111:
> +       case CPU_VR4121:
> +       case CPU_VR4122:
> +       case CPU_VR4131:
> +       case CPU_VR4133:
> +       case CPU_VR4181:
> +       case CPU_VR4181A:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_R4300
> +       case CPU_R4300:
> +       case CPU_R4310:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_R4X00
> +       case CPU_R4000PC:
> +       case CPU_R4000SC:
> +       case CPU_R4000MC:
> +       case CPU_R4200:
> +       case CPU_R4400PC:
> +       case CPU_R4400SC:
> +       case CPU_R4400MC:
> +       case CPU_R4600:
> +       case CPU_R4700:
> +       case CPU_R4640:
> +       case CPU_R4650:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_TX49XX
> +       case CPU_TX49XX:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_R5000
> +       case CPU_R5000:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_R5432
> +       case CPU_R5432:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_R5500
> +       case CPU_R5500:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_R6000
> +       case CPU_R6000:
> +       case CPU_R6000A:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_NEVADA
> +       case CPU_NEVADA:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_R8000
> +       case CPU_R8000:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_R10000
> +       case CPU_R10000:
> +       case CPU_R12000:
> +       case CPU_R14000:
> +#endif
> +#ifdef CONFIG_SYS_HAS_CPU_RM7000
> +       case CPU_RM7000:
> +       case CPU_SR71000:
> +#endif
> +#ifdef CONFIG_SYS_HAS_CPU_RM9000
> +       case CPU_RM9000:
> +#endif
> +#ifdef CONFIG_SYS_HAS_CPU_SB1
> +       case CPU_SB1:
> +       case CPU_SB1A:
> +#endif
> +#ifdef CONFIG_SYS_HAS_CPU_CAVIUM_OCTEON
> +       case CPU_CAVIUM_OCTEON:
> +       case CPU_CAVIUM_OCTEON_PLUS:
> +       case CPU_CAVIUM_OCTEON2:
> +#endif
> +
> +#ifdef CONFIG_SYS_HAS_CPU_BMIPS3300
> +       case CPU_BMIPS3300:
> +#endif

This will break SSB based BCM47XX systems and older BCM63XX, as
neither currently select SYS_HAS_CPU_BMIPS3300, but do have BMIPS3300
CPUs (for BCM63XX I am working on a patchset that cleans up the BMIPS
code and fixes this, but it isn't finished yet).



Jonas
