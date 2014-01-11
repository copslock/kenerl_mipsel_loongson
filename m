Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Jan 2014 11:47:31 +0100 (CET)
Received: from 0.mx.nanl.de ([217.115.11.12]:50010 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825378AbaAKKr3Q-GFw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 11 Jan 2014 11:47:29 +0100
Received: from mail-qc0-f170.google.com (mail-qc0-f170.google.com [209.85.216.170])
        by mail.nanl.de (Postfix) with ESMTPSA id E0AE845E5F;
        Sat, 11 Jan 2014 10:45:57 +0000 (UTC)
Received: by mail-qc0-f170.google.com with SMTP id e9so4831773qcy.1
        for <multiple recipients>; Sat, 11 Jan 2014 02:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=//qIaQt2RwjJ4wZjPgiURFWTZvxnFWxwsOFA4oMUDWw=;
        b=Utb5HyOFKNQ7Cw7CEpILd88IpOIXNqCgTvR7Dng+nv3enJhXMmfe1RdjfPXGO4T2Ig
         i/F2PP+c4oU2HwQ9LRfphrRsn5HZJ1//htpp7UvXe18TVNabwC22GjNSnv0WGesdqn/7
         x1AYjRYF1Ih8OZOMROUAmRBDGsM98KUCNCWnuPLUGbYhD3vKBS76QCDp5lI9kkwbUVzg
         QpHSB3c3IozHxtABW1YeLFhUwu3BNRwvRNYdCSekrXhgZbzb/+sIWtqIDZwrvFuIklAb
         tyYNMYi5WY1t5+2rZNoPJDyoOvt+9lBjHlc/FSNihN019dhT2COox7tovRJ9c+BjpmxG
         Edew==
X-Received: by 10.49.127.205 with SMTP id ni13mr17742881qeb.40.1389437245891;
 Sat, 11 Jan 2014 02:47:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.27.117 with HTTP; Sat, 11 Jan 2014 02:47:05 -0800 (PST)
In-Reply-To: <1389386114-31834-3-git-send-email-florian@openwrt.org>
References: <1389386114-31834-1-git-send-email-florian@openwrt.org> <1389386114-31834-3-git-send-email-florian@openwrt.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sat, 11 Jan 2014 11:47:05 +0100
Message-ID: <CAOiHx=mE1F1hMUdFtowrBNTBZFgLgE9aOgV6Jy=0t-qfS=jG9A@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: update MIPS_L1_CACHE_SHIFT based on MIPS_L1_CACHE_SHIFT_<N>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>,
        "Daniel G.C." <dgcbueu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38933
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

On Fri, Jan 10, 2014 at 9:35 PM, Florian Fainelli <florian@openwrt.org> wrote:
> All platforms that require a special MIPS_L1_CACHE_SHIFT value have been
> updated, such that we can now make MIPS_L1_CACHE_SHIFT default to the
> appropriate integer value based on the select MIPS_L1_CACHE_SHIFT_<N>
> variable.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/mips/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 753c5a3..123f7c0 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1106,10 +1106,10 @@ config MIPS_L1_CACHE_SHIFT_7
>
>  config MIPS_L1_CACHE_SHIFT
>         int
> -       default "4" if MACH_DECSTATION || MIKROTIK_RB532 || PMC_MSP4200_EVAL || SOC_RT288X
> -       default "6" if MIPS_CPU_SCACHE
> -       default "7" if SGI_IP22 || SGI_IP27 || SGI_IP28 || SNI_RM || CPU_CAVIUM_OCTEON
> -       default "5"
> +       default "4" if MIPS_L1_CACHE_SHIFT_4
> +       default "6" if MIPS_L1_CACHE_SHIFT_6
> +       default "7" if MIPS_L1_CACHE_SHIFT_7
> +       default "5" if MIPS_L1_CACHE_SHIFT_5

Having MIPS_L1_CACHE_SHIFT_5 default n and a last default "5" without
any condition to allows this to be ordered, which looks IMHO a lot
nicer ;-)


Jonas
