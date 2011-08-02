Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 18:07:58 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:47874 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491177Ab1HBQHv convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Aug 2011 18:07:51 +0200
Received: by wwi18 with SMTP id 18so5816574wwi.24
        for <multiple recipients>; Tue, 02 Aug 2011 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LOUNS+qtfOaNJvLn65M19TCzLhF5cHLuIKY6uRF4ego=;
        b=xtzqoO/uK6iVz1LImduXoUtRdhsEaNm6rDmAmaDkZK9YwTJNDN7kd8I6WIvdYNMTV+
         9wGuQI6VE7neSrjHFKD51mnlI+6IY0F13pvOW+DUV/nuUpoqsHe7oZPwa6imSAozPS1M
         hEr0KHShgDGZZ9RCzxMz5ecq5In6NVPKEHUH4=
MIME-Version: 1.0
Received: by 10.216.90.19 with SMTP id d19mr777981wef.35.1312301257532; Tue,
 02 Aug 2011 09:07:37 -0700 (PDT)
Received: by 10.216.16.149 with HTTP; Tue, 2 Aug 2011 09:07:37 -0700 (PDT)
In-Reply-To: <1312194382-3706-2-git-send-email-florian@openwrt.org>
References: <1312194382-3706-1-git-send-email-florian@openwrt.org>
        <1312194382-3706-2-git-send-email-florian@openwrt.org>
Date:   Wed, 3 Aug 2011 00:07:37 +0800
Message-ID: <CAD+V5YLOBXWtEo1EN1STLisMk+Ti4pvtpMXep1Vw0afjzUVTUA@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: introduce CPU_R4K_FPU
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1540

On Mon, Aug 1, 2011 at 6:26 PM, Florian Fainelli <florian@openwrt.org> wrote:
> R4K-style CPUs have this boolean defined by default. Allows us
> to remove some lines in arch/mips/kernel/Makefile
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/mips/Kconfig         |    4 ++++
>  arch/mips/kernel/Makefile |   17 +----------------
>  2 files changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 9f4ade4..44eebc7 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1807,6 +1807,10 @@ config CPU_GENERIC_DUMP_TLB
>        bool
>        default y if !(CPU_R3000 || CPU_R6000 || CPU_R8000 || CPU_TX39XX)
>
> +config CPU_R4K_FPU
> +       bool
> +       default y if !(CPU_R3000 || CPU_R6000 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
> +
>  choice
>        prompt "MIPS MT options"
>
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 83bba33..eeb942d 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -32,25 +32,10 @@ obj-$(CONFIG_MODULES)               += mips_ksyms.o module.o
>
>  obj-$(CONFIG_FUNCTION_TRACER)  += mcount.o ftrace.o
>
> -obj-$(CONFIG_CPU_LOONGSON2)    += r4k_fpu.o r4k_switch.o
> -obj-$(CONFIG_CPU_MIPS32)       += r4k_fpu.o r4k_switch.o
> -obj-$(CONFIG_CPU_MIPS64)       += r4k_fpu.o r4k_switch.o
> +obj-$(CONFIG_CPU_R4K_FPU)      += r4k_fpu.o r4k_switch.o
>  obj-$(CONFIG_CPU_R3000)                += r2300_fpu.o r2300_switch.o
> -obj-$(CONFIG_CPU_R4300)                += r4k_fpu.o r4k_switch.o
> -obj-$(CONFIG_CPU_R4X00)                += r4k_fpu.o r4k_switch.o
> -obj-$(CONFIG_CPU_R5000)                += r4k_fpu.o r4k_switch.o
>  obj-$(CONFIG_CPU_R6000)                += r6000_fpu.o r4k_switch.o
> -obj-$(CONFIG_CPU_R5432)                += r4k_fpu.o r4k_switch.o
> -obj-$(CONFIG_CPU_R5500)                += r4k_fpu.o r4k_switch.o
> -obj-$(CONFIG_CPU_R8000)                += r4k_fpu.o r4k_switch.o
> -obj-$(CONFIG_CPU_RM7000)       += r4k_fpu.o r4k_switch.o
> -obj-$(CONFIG_CPU_RM9000)       += r4k_fpu.o r4k_switch.o
> -obj-$(CONFIG_CPU_NEVADA)       += r4k_fpu.o r4k_switch.o
> -obj-$(CONFIG_CPU_R10000)       += r4k_fpu.o r4k_switch.o
> -obj-$(CONFIG_CPU_SB1)          += r4k_fpu.o r4k_switch.o
>  obj-$(CONFIG_CPU_TX39XX)       += r2300_fpu.o r2300_switch.o
> -obj-$(CONFIG_CPU_TX49XX)       += r4k_fpu.o r4k_switch.o
> -obj-$(CONFIG_CPU_VR41XX)       += r4k_fpu.o r4k_switch.o
>  obj-$(CONFIG_CPU_CAVIUM_OCTEON)        += octeon_switch.o
>  obj-$(CONFIG_CPU_XLR)          += r4k_fpu.o r4k_switch.o

Seems the above line can be removed too, this may remove them automatically:

$ sed -i -e '/r4k_fpu.o\s*r4k_switch/d' -e '/r4k_switch.o\s*r4k_fpu/d'
 arch/mips/kernel/Makefile

Best Regards,
Wu Zhangjin

>
> --
> 1.7.4.1
>
>
>
