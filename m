Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 02:14:59 +0100 (CET)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35099 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013282AbaKKBOyx-wH9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 02:14:54 +0100
Received: by mail-ie0-f177.google.com with SMTP id tp5so10057875ieb.8
        for <multiple recipients>; Mon, 10 Nov 2014 17:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2ztfVivgQCgQAeF3F+zZ3rnwK/fUgFJu2zb23aypBk4=;
        b=GoqHUQUUqo0PcN5fEjKGYcrZ0gwOqoiw/8QrbGzVrQE9vq5qX2klJIUPzkDa4Xm+Gg
         AdWTFASDuoalxgZjzVRfnDVRQD/3CdR/VF8H88M2k05b0915Cd6jqG1Hgw4A5Dq4SdIu
         0XJf2cRrtIxHCGmcQjspQP0CfNrSDHmNaoeB183bgIDANX3Pxya28IMaxYPb3XcGhlh6
         fCy/ttb3C5KL8hCZRHL+CN9GfZQTwKeFwtL6tELZS7wqEvWt/14YMdOhtbu/yITnk2kp
         pU8TSVCmMUL1OlZFsPSSDJaTcBNg6gwoRi1XSHlXvojjcoFUHdZZjUF/Uzf3B3LzQliL
         SQ+Q==
MIME-Version: 1.0
X-Received: by 10.43.75.194 with SMTP id zb2mr40246472icb.53.1415668488705;
 Mon, 10 Nov 2014 17:14:48 -0800 (PST)
Received: by 10.64.176.211 with HTTP; Mon, 10 Nov 2014 17:14:48 -0800 (PST)
In-Reply-To: <20141110165907.GA11091@linux-mips.org>
References: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
        <1415081610-25639-3-git-send-email-chenhc@lemote.com>
        <20141110165907.GA11091@linux-mips.org>
Date:   Tue, 11 Nov 2014 09:14:48 +0800
X-Google-Sender-Auth: 0WQWYZIE3e0djNcAkU-GUw3JxOE
Message-ID: <CAAhV-H6zvHpGMvizbXOZU-E1aoxryU+L8Q1TSZoubB+72KM2AQ@mail.gmail.com>
Subject: Re: [PATCH V2 02/12] MIPS: Loongson: set Loongson-3's ISA level to MIPS64R1
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Ralf,

In original code, both Loongson-2 and Loongson-3 are MIPS-III, after
my patch, Loongson-2 is still MIPS-III and Loongson-3 is upgraded to
MIPS64R1, so I think this is not "heavyhanded". Moreover, we need more
tests to assure whether Loongson-3 is compatible with MIPS64R2 (except
EI/DI), so set to MIPS64R1 is a safe way.

Huacai

On Tue, Nov 11, 2014 at 12:59 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Nov 04, 2014 at 02:13:23PM +0800, Huacai Chen wrote:
>
>> In CPU manual Loongson-3 is MIPS64R2 compatible, but during tests we
>> found that its EI/DI instructions have problems. So we just set the ISA
>> level to MIPS64R1.
>
> That's a bit a heavyhanded move - it will disable ALL R2 optimizations
> and feature support - try running git grep -w cpu_has_mips_r2 arch/mips.
> Also it will cause the kernel to missreport the CPU has R1 or as in
> case of the Loongson 2 with this patch even as MIPS III which in turn
> will mean certain programs will fail to detect and exploit the full
> capabilities of the CPU.
>
> Was this really intended?  I doubt it.
>
> I suggest a bit of a less heavy-handed approach as illustrated in below
> incomplete patch.
>
> Would that work for you?
>
>   Ralf
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>
>  arch/mips/include/asm/asmmacro.h          | 3 ++-
>  arch/mips/include/asm/irqflags.h          | 7 ++++---
>  arch/mips/include/asm/mach-ip22/war.h     | 1 +
>  arch/mips/include/asm/mach-loongson/war.h | 1 +
>  arch/mips/include/asm/war.h               | 7 +++++++
>  5 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
> index 6caf876..d477c34 100644
> --- a/arch/mips/include/asm/asmmacro.h
> +++ b/arch/mips/include/asm/asmmacro.h
> @@ -11,6 +11,7 @@
>  #include <asm/hazards.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/msa.h>
> +#include <asm/war.h>
>
>  #ifdef CONFIG_32BIT
>  #include <asm/asmmacro-32.h>
> @@ -19,7 +20,7 @@
>  #include <asm/asmmacro-64.h>
>  #endif
>
> -#ifdef CONFIG_CPU_MIPSR2
> +#if defined(CONFIG_CPU_MIPSR2) && !LOONGSON3_EI_DI_WAR
>         .macro  local_irq_enable reg=t0
>         ei
>         irq_enable_hazard
> diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
> index 0fa5fdc..fcfd371 100644
> --- a/arch/mips/include/asm/irqflags.h
> +++ b/arch/mips/include/asm/irqflags.h
> @@ -16,6 +16,7 @@
>  #include <linux/compiler.h>
>  #include <linux/stringify.h>
>  #include <asm/hazards.h>
> +#include <asm/war.h>
>
>  #ifdef CONFIG_CPU_MIPSR2
>
> @@ -59,7 +60,7 @@ static inline void arch_local_irq_restore(unsigned long flags)
>         "       .set    push                                            \n"
>         "       .set    noreorder                                       \n"
>         "       .set    noat                                            \n"
> -#if defined(CONFIG_IRQ_CPU)
> +#if defined(CONFIG_IRQ_CPU) && !LOONGSON3_EI_DI_WAR
>         /*
>          * Slow, but doesn't suffer from a relatively unlikely race
>          * condition we're having since days 1.
> @@ -89,7 +90,7 @@ static inline void __arch_local_irq_restore(unsigned long flags)
>         "       .set    push                                            \n"
>         "       .set    noreorder                                       \n"
>         "       .set    noat                                            \n"
> -#if defined(CONFIG_IRQ_CPU)
> +#if defined(CONFIG_IRQ_CPU) && !LOONGSON3_EI_DI_WAR
>         /*
>          * Slow, but doesn't suffer from a relatively unlikely race
>          * condition we're having since days 1.
> @@ -126,7 +127,7 @@ static inline void arch_local_irq_enable(void)
>         "       .set    push                                            \n"
>         "       .set    reorder                                         \n"
>         "       .set    noat                                            \n"
> -#if   defined(CONFIG_CPU_MIPSR2)
> +#if defined(CONFIG_CPU_MIPSR2) && !LOONGSON3_EI_DI_WAR
>         "       ei                                                      \n"
>  #else
>         "       mfc0    $1,$12                                          \n"
> diff --git a/arch/mips/include/asm/mach-ip22/war.h b/arch/mips/include/asm/mach-ip22/war.h
> index fba6405..3520b0a 100644
> --- a/arch/mips/include/asm/mach-ip22/war.h
> +++ b/arch/mips/include/asm/mach-ip22/war.h
> @@ -18,6 +18,7 @@
>  #define R5432_CP0_INTERRUPT_WAR                0
>  #define BCM1250_M3_WAR                 0
>  #define SIBYTE_1956_WAR                        0
> +#define LOONGSON3_EI_DI_WAR            0
>  #define MIPS4K_ICACHE_REFILL_WAR       0
>  #define MIPS_CACHE_SYNC_WAR            0
>  #define TX49XX_ICACHE_INDEX_INV_WAR    0
> diff --git a/arch/mips/include/asm/mach-loongson/war.h b/arch/mips/include/asm/mach-loongson/war.h
> index f2570df..cf5385f 100644
> --- a/arch/mips/include/asm/mach-loongson/war.h
> +++ b/arch/mips/include/asm/mach-loongson/war.h
> @@ -14,6 +14,7 @@
>  #define R5432_CP0_INTERRUPT_WAR                0
>  #define BCM1250_M3_WAR                 0
>  #define SIBYTE_1956_WAR                        0
> +#define LOONGSON3_EI_DI_WAR            1
>  #define MIPS4K_ICACHE_REFILL_WAR       0
>  #define MIPS_CACHE_SYNC_WAR            0
>  #define TX49XX_ICACHE_INDEX_INV_WAR    0
> diff --git a/arch/mips/include/asm/war.h b/arch/mips/include/asm/war.h
> index 9344e24..ceb9030 100644
> --- a/arch/mips/include/asm/war.h
> +++ b/arch/mips/include/asm/war.h
> @@ -233,4 +233,11 @@
>  #error Check setting of MIPS34K_MISSED_ITLB_WAR for your platform
>  #endif
>
> +/*
> + * On certain Loongson 3 cores DI/EI don't work properly.
> + */
> +#ifndef LOONGSON3_EI_DI_WAR
> +#error Check setting of LOONGSON3_EI_DI_WAR for your platform
> +#endif
> +
>  #endif /* _ASM_WAR_H */
>
