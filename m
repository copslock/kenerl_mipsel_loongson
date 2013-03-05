Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Mar 2013 15:27:37 +0100 (CET)
Received: from mail.nanl.de ([217.115.11.12]:36502 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820514Ab3CELw12cLLV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Mar 2013 12:52:27 +0100
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com [209.85.223.181])
        by mail.nanl.de (Postfix) with ESMTPSA id B353040260;
        Tue,  5 Mar 2013 11:52:13 +0000 (UTC)
Received: by mail-ie0-f181.google.com with SMTP id 17so7541367iea.26
        for <multiple recipients>; Tue, 05 Mar 2013 03:52:16 -0800 (PST)
X-Received: by 10.42.30.132 with SMTP id v4mr26623190icc.34.1362484336078;
 Tue, 05 Mar 2013 03:52:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.142.193 with HTTP; Tue, 5 Mar 2013 03:51:56 -0800 (PST)
In-Reply-To: <1362477800.16460.69.camel@x61.thuisdomein>
References: <1362477800.16460.69.camel@x61.thuisdomein>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 5 Mar 2013 12:51:56 +0100
Message-ID: <CAOiHx=nzNVatEp0nyfZKU2p35+1kjrw6VsvZTP+QPJykWF3JAg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Get rid of CONFIG_CPU_HAS_LLSC again
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35881
X-Approved-By: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 5 March 2013 11:03, Paul Bolle <pebolle@tiscali.nl> wrote:
> Commit f7ade3c168e4f437c11f57be012992bbb0e3075c ("MIPS: Get rid of
> CONFIG_CPU_HAS_LLSC") did what it promised to do. But since then that
> macro and its Kconfig symbol popped up again. Get rid of those again.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Untested.

Obviously :p.

> 1) The related commits are 1c773ea4dceff889c2f872343609a87ae0cfbf56
> ("MIPS: Netlogic: Add XLP makefiles and config") and
> 3070033a16edcc21688d5ea8967c89522f833862 ("MIPS: Add core files for MIPS
> SEAD-3 development platform.").
>
>  arch/mips/Kconfig                                        | 1 -
>  arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h | 3 ---
>  2 files changed, 4 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index ae9c716..310f1e6 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1493,7 +1493,6 @@ config CPU_XLP
>         select CPU_SUPPORTS_32BIT_KERNEL
>         select CPU_SUPPORTS_64BIT_KERNEL
>         select CPU_SUPPORTS_HIGHMEM
> -       select CPU_HAS_LLSC
>         select WEAK_ORDERING
>         select WEAK_REORDERING_BEYOND_LLSC
>         select CPU_HAS_PREFETCH
> diff --git a/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h b/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
> index d9c8284..2a945b4 100644
> --- a/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
> +++ b/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
> @@ -28,9 +28,6 @@
>  /* #define cpu_has_prefetch    ? */
>  #define cpu_has_mcheck         1
>  /* #define cpu_has_ejtag       ? */
> -#ifdef CONFIG_CPU_HAS_LLSC
> -#define cpu_has_llsc           1
> -#else
>  #define cpu_has_llsc           0
>  #endif

You need to remove these two lines, too, else you have an #endif without an #if.

>  /* #define cpu_has_vtag_icache ? */
> --
> 1.7.11.7
>
>
