Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2016 22:24:39 +0100 (CET)
Received: from mail-io0-f175.google.com ([209.85.223.175]:32823 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011109AbcA2VYh2p5g0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2016 22:24:37 +0100
Received: by mail-io0-f175.google.com with SMTP id f81so102264467iof.0;
        Fri, 29 Jan 2016 13:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+eJ4VrRbkvzr4J2aiYtfk5Mv9W/UkKpmDZzL1Wyf+qA=;
        b=vB7DSHXcevqxmpRhrkDIHl2mNn/t5WgPU/sAuBRWBNRpT/hI33OEVunIg9wmLoXUdz
         Q6Kq2lL8M3BfWXNoXqxBiueStTZGwFY6etmd1TbOc5U8PGGh/x6Cd2ECk7PQuZccsraS
         dAzr9LIi6o0b/ez/EeMTt/aA1CN1cTS5/hJIVXNqFgZqFOvaD8USuKhi/3DolqyTetsx
         nvcB32j+dEJ5pxsToKvnV1H/JywIZ3xJ1rxIlv5HbOy6t3lNP3oykP7gO5d19AgN91v4
         eL/RJxgQTxhTfg37Pk6bExlzneMxfm07V2SSPVn+FH/OxeaKG/6vyJlnuqTtXsVC/Nec
         sSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+eJ4VrRbkvzr4J2aiYtfk5Mv9W/UkKpmDZzL1Wyf+qA=;
        b=YH8YVj1jEqqXIURgq/8nMhJptSJ8KKly4ToZLPCoKtxqzKMYuHxMForPf+rEuEXi2G
         D9GGDqbSsgZKBDycYr5/8VnC3E2PodWY6tq4MOMOYbBw+XW0bf5HgQTuNoGrz73wMTmp
         23UZ7Yirq3G+zciq3AtZTVbewPXPRdNwlo0CguT1AzJkpz25htNY8Z89y5Q+dnaMJQHP
         u2nJN/Kx8PfKGSEZNT6tIRPlqdRjFvs6s3Lo9OuT7plXW0FVP6L8JAGkgKaYNygWqn/N
         4rGOxCVR6rpBxasoZRJJQDNVPwWekF8lnz31NBT5EcthKSyX/AQTUhikfvQcp2lX8t/p
         xAeQ==
X-Gm-Message-State: AG10YOSFgERY8jIq6ICZneYV2Ipgw67pJ9suBW9abt17HI+TiTPbZFR+LwHIEFFxbZsJS2ocQ4CpHSQjWHNFzA==
MIME-Version: 1.0
X-Received: by 10.107.154.147 with SMTP id c141mr12083817ioe.151.1454102671561;
 Fri, 29 Jan 2016 13:24:31 -0800 (PST)
Received: by 10.107.9.97 with HTTP; Fri, 29 Jan 2016 13:24:31 -0800 (PST)
In-Reply-To: <19656457.qoKNGRmV4Q@wuerfel>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
        <7619136.niuXthzi6R@wuerfel>
        <CAMuHMdX33SQe8n7SRda0TjQV05yP1zbuw129Jqjknt8=CY=LjA@mail.gmail.com>
        <19656457.qoKNGRmV4Q@wuerfel>
Date:   Fri, 29 Jan 2016 22:24:31 +0100
X-Google-Sender-Auth: 40A1kfcGk5-JtwKAj2Frh7tIvSs
Message-ID: <CAMuHMdW1_of2Dw29=8VdhD0hstgvTh-CfATdLAiu5ZrwRRP77Q@mail.gmail.com>
Subject: Re: [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Marek <mmarek@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Arnd,

On Fri, Jan 29, 2016 at 9:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index c6b6175d0203..6cc09cf8618f 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1526,6 +1526,7 @@ config DEBUG_UART_PHYS
>         default 0xfffb9800 if DEBUG_OMAP1UART3 || DEBUG_OMAP7XXUART3
>         default 0xfffe8600 if DEBUG_BCM63XX_UART
>         default 0xfffff700 if ARCH_IOP33X
> +       default 0xdeadbeef if DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || DEBUG_LL_UART_EFM32
>         depends on ARCH_EP93XX || \
>                 DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
>                 DEBUG_LL_UART_EFM32 || \
> @@ -1628,6 +1629,7 @@ config DEBUG_UART_VIRT
>         default 0xff003000 if DEBUG_U300_UART
>         default 0xffd01000 if DEBUG_HIP01_UART
>         default DEBUG_UART_PHYS if !MMU
> +       default 0xdeadbeef if DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || DEBUG_LL_UART_EFM32
>         depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
>                 DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
>                 DEBUG_NETX_UART || \
> diff --git a/arch/arm/include/debug/8250.S b/arch/arm/include/debug/8250.S
> index 7f7446f6f806..1191b1458586 100644
> --- a/arch/arm/include/debug/8250.S
> +++ b/arch/arm/include/debug/8250.S
> @@ -9,6 +9,9 @@
>   */
>  #include <linux/serial_reg.h>
>
> +#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xe0000000

Any special reason for 0xe0000000 vs ...

> --- a/arch/arm/include/debug/efm32.S
> +++ b/arch/arm/include/debug/efm32.S
> @@ -6,6 +6,9 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> +#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xf0000000

0xf0000000?

> --- a/arch/arm/include/debug/pl01x.S
> +++ b/arch/arm/include/debug/pl01x.S
> @@ -10,6 +10,9 @@
>   * published by the Free Software Foundation.
>   *
>  */
> +#if CONFIG_DEBUG_UART_PHYS == 0xdeadbeef || CONFIG_DEBUG_UART_VIRT < 0xf0000000

Likewise.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
