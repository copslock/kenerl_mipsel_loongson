Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Mar 2013 15:27:53 +0100 (CET)
Received: from mail.nanl.de ([217.115.11.12]:36509 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827532Ab3CEM4RjMPe5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Mar 2013 13:56:17 +0100
Received: from mail-ia0-f171.google.com (mail-ia0-f171.google.com [209.85.210.171])
        by mail.nanl.de (Postfix) with ESMTPSA id 0714E4022F;
        Tue,  5 Mar 2013 12:56:07 +0000 (UTC)
Received: by mail-ia0-f171.google.com with SMTP id z13so6036414iaz.16
        for <multiple recipients>; Tue, 05 Mar 2013 04:56:11 -0800 (PST)
X-Received: by 10.50.192.201 with SMTP id hi9mr5976301igc.48.1362488171316;
 Tue, 05 Mar 2013 04:56:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.142.193 with HTTP; Tue, 5 Mar 2013 04:55:51 -0800 (PST)
In-Reply-To: <1362486020.16460.73.camel@x61.thuisdomein>
References: <1362477800.16460.69.camel@x61.thuisdomein> <CAOiHx=nzNVatEp0nyfZKU2p35+1kjrw6VsvZTP+QPJykWF3JAg@mail.gmail.com>
 <1362486020.16460.73.camel@x61.thuisdomein>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 5 Mar 2013 13:55:51 +0100
Message-ID: <CAOiHx=nvH-Q+3HCkukM9ZDZXLm=w0bO9LPyosQS7UHOmOvQYOQ@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Get rid of CONFIG_CPU_HAS_LLSC again
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35882
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

On 5 March 2013 13:20, Paul Bolle <pebolle@tiscali.nl> wrote:
> Commit f7ade3c168e4f437c11f57be012992bbb0e3075c ("MIPS: Get rid of
> CONFIG_CPU_HAS_LLSC") did what it promised to do. But since then that
> macro and its Kconfig symbol popped up again. Get rid of those again.

Now let's do a review of the contents.

> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) This version fixes an embarrassing dangling "#endif" spotted by
> Jonas. Thanks for that! Still untested.
>
> 1) The related commits are 1c773ea4dceff889c2f872343609a87ae0cfbf56
> ("MIPS: Netlogic: Add XLP makefiles and config") and
> 3070033a16edcc21688d5ea8967c89522f833862 ("MIPS: Add core files for MIPS
> SEAD-3 development platform.").
>
>  arch/mips/Kconfig                                        | 1 -
>  arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h | 4 ----
>  2 files changed, 5 deletions(-)
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
> index d9c8284..b40f37f 100644
> --- a/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
> +++ b/arch/mips/include/asm/mach-sead3/cpu-feature-overrides.h
> @@ -28,11 +28,7 @@
>  /* #define cpu_has_prefetch    ? */
>  #define cpu_has_mcheck         1
>  /* #define cpu_has_ejtag       ? */
> -#ifdef CONFIG_CPU_HAS_LLSC
> -#define cpu_has_llsc           1
> -#else
>  #define cpu_has_llsc           0
> -#endif

Hm, shouldn't you leave cpu_has_llsc set to 1? At least the "old" path
SEAD3 => CPU_MIPS32_R1/R2/64_R1 => select CPU_HAS_LLSC for all three
would have always caused this to be 1.

>  /* #define cpu_has_vtag_icache ? */
>  /* #define cpu_has_dc_aliases  ? */
>  /* #define cpu_has_ic_fills_f_dc ? */
> --
> 1.7.11.7
>
>
