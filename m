Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 15:47:47 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:56974 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835012Ab3DJNrpH9-dg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Apr 2013 15:47:45 +0200
Received: from mail-ve0-f175.google.com (mail-ve0-f175.google.com [209.85.128.175])
        by mail.nanl.de (Postfix) with ESMTPSA id 608A44031C;
        Wed, 10 Apr 2013 13:47:34 +0000 (UTC)
Received: by mail-ve0-f175.google.com with SMTP id pb11so408439veb.6
        for <multiple recipients>; Wed, 10 Apr 2013 06:47:39 -0700 (PDT)
X-Received: by 10.52.91.212 with SMTP id cg20mr1334619vdb.63.1365601659889;
 Wed, 10 Apr 2013 06:47:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.31.73 with HTTP; Wed, 10 Apr 2013 06:47:18 -0700 (PDT)
In-Reply-To: <1365594447-13068-3-git-send-email-blogic@openwrt.org>
References: <1365594447-13068-1-git-send-email-blogic@openwrt.org> <1365594447-13068-3-git-send-email-blogic@openwrt.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 10 Apr 2013 15:47:18 +0200
Message-ID: <CAOiHx=mTg2Af2r1YF3ge1J+=tdOCwGmGDbZNvnjP6Z5q_wZ+=A@mail.gmail.com>
Subject: Re: [PATCH 02/18] MIPS: ralink: fix RT305x clock setup
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36058
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

On 10 April 2013 13:47, John Crispin <blogic@openwrt.org> wrote:
> Add a few missing clocks and remove the unused sys clock.

You are not removing anything here, only adding ;-)

>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/ralink/rt305x.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
> index 0a4bbdc..856ebff 100644
> --- a/arch/mips/ralink/rt305x.c
> +++ b/arch/mips/ralink/rt305x.c
> @@ -125,6 +125,7 @@ void __init ralink_clk_init(void)
>  {
>         unsigned long cpu_rate, sys_rate, wdt_rate, uart_rate;
>         u32 t = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG);
> +       int wmac_20mhz = 0;
>
>         if (soc_is_rt305x() || soc_is_rt3350()) {
>                 t = (t >> RT305X_SYSCFG_CPUCLK_SHIFT) &
> @@ -176,11 +177,24 @@ void __init ralink_clk_init(void)
>                 BUG();
>         }
>
> +       if (soc_is_rt3352() || soc_is_rt5350()) {
> +               u32 val = rt_sysc_r32(RT3352_SYSC_REG_SYSCFG0);

Empty line missing.

> +               if ((val & RT3352_CLKCFG0_XTAL_SEL) == 0)
> +                       wmac_20mhz = 1;

Why not just call it wmac_rate, default to 40000000, and set it to
20000000 here?

> +       }
> +
>         ralink_clk_add("cpu", cpu_rate);
>         ralink_clk_add("10000b00.spi", sys_rate);
>         ralink_clk_add("10000100.timer", wdt_rate);
> +       ralink_clk_add("10000120.watchdog", wdt_rate);
>         ralink_clk_add("10000500.uart", uart_rate);
>         ralink_clk_add("10000c00.uartlite", uart_rate);
> +       ralink_clk_add("10100000.ethernet", sys_rate);
> +
> +       if (wmac_20mhz)
> +               ralink_clk_add("wmac@10180000", 20000000);
> +       else
> +               ralink_clk_add("wmac@10180000", 40000000);
>  }

Then you wouldn't need the conditional here.


Jonas
