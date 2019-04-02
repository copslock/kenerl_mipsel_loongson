Return-Path: <SRS0=6JhV=SE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BABC4360F
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 20:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579F32084B
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 20:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554236323;
	bh=qrOExcPHziIvwO5yYyjeq/0e8T0i356QG01XTuGB7TQ=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=U7QtJQWigmW6i2fe/nnjdvTKz3kGpD8330NsD5mq4OGxZJnOri5GYbVFQ1/cSxrKj
	 n6T24WAa55fG2uA1NvmV0sRG//5tctoUj3LgmqlSk9kOraV2YEii5HsGQQq6yDFDB6
	 Cb4mSKtBHti1ChnQhPzNTKYvwftRdFU1Aqg98rvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfDBUSn (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfDBUSm (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 2 Apr 2019 16:18:42 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17E162070D;
        Tue,  2 Apr 2019 20:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554236321;
        bh=qrOExcPHziIvwO5yYyjeq/0e8T0i356QG01XTuGB7TQ=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=Blk8ngXOWiFtbu/GuwuqVzNDY5pp0yD3uvHW+FXUJgwzVQt4JLcQLESkMHyncr+hj
         dfhmSgBWH5Cf6J1T+F8Z29sEa8s7A+9FouRfgE+iH4bCKw8MOKbja7dnhhhVzsNUxb
         dNcgKqzc96m+L1MptEn+0EzSNjoop1QciRv25F9w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190330123317.16821-4-drvlabo@gmail.com>
References: <20190330123317.16821-1-drvlabo@gmail.com> <20190330123317.16821-4-drvlabo@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC 3/5] mips: ralink: mt7620/76x8 use clk framework and rt2880-clock driver
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Message-ID: <155423632032.20095.18223259779000835679@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 02 Apr 2019 13:18:40 -0700
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Quoting NOGUCHI Hiroshi (2019-03-30 05:33:15)
> diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
> index 49c22ddd9c41..13301de113bb 100644
> --- a/arch/mips/ralink/Kconfig
> +++ b/arch/mips/ralink/Kconfig
> @@ -18,6 +18,10 @@ config IRQ_INTC
>         default y
>         depends on !SOC_MT7621
> =20
> +config RT2880_CLK
> +       bool
> +       default n

We don't need the default line here, it's n already.

> +
>  choice
>         prompt "Ralink SoC selection"
>         default SOC_RT305X
> diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
> index 1b7df115eb60..8715a44ebc4c 100644
> --- a/arch/mips/ralink/clk.c
> +++ b/arch/mips/ralink/clk.c
> @@ -15,8 +15,15 @@
> =20
>  #include <asm/time.h>
> =20
> +#ifdef CONFIG_COMMON_CLK

Does something go wrong if it's included when CONFIG_COMMON_CLK=3Dn?
Hopefully not, so that this isn't a problem.

> +#include <linux/clk-provider.h>
> +#endif
> +
>  #include "common.h"
> =20
> +
> +#ifndef CONFIG_COMMON_CLK
> +
>  struct clk {
>         struct clk_lookup cl;
>         unsigned long rate;
> @@ -72,6 +79,26 @@ long clk_round_rate(struct clk *clk, unsigned long rat=
e)
>  }
>  EXPORT_SYMBOL_GPL(clk_round_rate);
> =20
> +#else  /* CONFIG_COMMON_CLK */
> +
> +struct clk * __init add_sys_clkdev(const char *id, unsigned long rate)
> +{
> +       struct clk *clk;
> +       int err;
> +
> +       clk =3D clk_register_fixed_rate(NULL, id, NULL, 0, rate);
> +       if (IS_ERR(clk))
> +               panic("failed to allocate %s clock structure", id);
> +
> +       err =3D clk_register_clkdev(clk, NULL, id);
> +       if (err)
> +               panic("unable to register %s clock device", id);

Why do we need to panic?

> +
> +       return clk;
> +}
> +
> +#endif /* CONFIG_COMMON_CLK */
> +
>  void __init plat_time_init(void)
>  {
>         struct clk *clk;
> @@ -79,6 +106,9 @@ void __init plat_time_init(void)
>         ralink_of_remap();
> =20
>         ralink_clk_init();
> +#ifdef CONFIG_COMMON_CLK

if (IS_ENABLED(CONFIG_COMMON_CLK)) {

perhaps?

> +       of_clk_init(NULL);
> +#endif
>         clk =3D clk_get_sys("cpu", NULL);
>         if (IS_ERR(clk))
>                 panic("unable to get CPU clock, err=3D%ld", PTR_ERR(clk));
> diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
> index b8245d0940d6..9f26ca96c411 100644
> --- a/arch/mips/ralink/common.h
> +++ b/arch/mips/ralink/common.h
> @@ -26,6 +26,9 @@ extern void ralink_of_remap(void);
> =20
>  extern void ralink_clk_init(void);
>  extern void ralink_clk_add(const char *dev, unsigned long rate);
> +#ifdef CONFIG_COMMON_CLK
> +extern struct clk *add_sys_clkdev(const char *id, unsigned long rate);
> +#endif
> =20
>  extern void ralink_rst_init(void);
> =20
> diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
> index c1ce6f43642b..65dd8f7b7b9a 100644
> --- a/arch/mips/ralink/mt7620.c
> +++ b/arch/mips/ralink/mt7620.c
> @@ -12,7 +12,13 @@
> =20
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/jiffies.h>

Is this used?

> +#include <linux/clk.h>

Is this used?

> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <dt-bindings/clock/mt7620-clk.h>
>  #include <linux/bug.h>
> +#include <linux/of.h>
> =20
>  #include <asm/mipsregs.h>
>  #include <asm/mach-ralink/ralink_regs.h>
> @@ -20,6 +26,7 @@
>  #include <asm/mach-ralink/pinmux.h>
> =20
>  #include "common.h"
> +#include "rt2880-clk_internal.h"
> =20
>  /* analog */
>  #define PMU0_CFG               0x88
> @@ -504,6 +511,17 @@ mt7620_get_sys_rate(unsigned long cpu_rate)
>         return cpu_rate / div;
>  }
> =20
> +static struct clk *clks[MT7620_CLK_MAX];
> +
> +static struct clk_onecell_data clk_data =3D {

Please use clk_hw based APIs instead of clk based ones.

> +       .clks   =3D clks,
> +       .clk_num =3D ARRAY_SIZE(clks),
> +};
> +
> +#define RFMT(label)    label ":%lu.%03luMHz "
> +#define RINT(x)                ((x) / 1000000)
> +#define RFRAC(x)       (((x) / 1000) % 1000)
> +
>  void __init ralink_clk_init(void)
>  {
>         unsigned long xtal_rate;
> @@ -517,10 +535,6 @@ void __init ralink_clk_init(void)
> =20
>         xtal_rate =3D mt7620_get_xtal_rate();
> =20
> -#define RFMT(label)    label ":%lu.%03luMHz "
> -#define RINT(x)                ((x) / 1000000)
> -#define RFRAC(x)       (((x) / 1000) % 1000)
> -
>         if (is_mt76x8()) {
>                 if (xtal_rate =3D=3D MHZ(40))
>                         cpu_rate =3D MHZ(580);
> @@ -529,9 +543,6 @@ void __init ralink_clk_init(void)
>                 dram_rate =3D sys_rate =3D cpu_rate / 3;
>                 periph_rate =3D MHZ(40);
>                 pcmi2s_rate =3D MHZ(480);
> -
> -               ralink_clk_add("10000d00.uartlite", periph_rate);
> -               ralink_clk_add("10000e00.uartlite", periph_rate);
>         } else {
>                 cpu_pll_rate =3D mt7620_get_cpu_pll_rate(xtal_rate);
>                 pll_rate =3D mt7620_get_pll_rate(xtal_rate, cpu_pll_rate);
> @@ -547,7 +558,6 @@ void __init ralink_clk_init(void)
>                          RINT(cpu_pll_rate), RFRAC(cpu_pll_rate),
>                          RINT(pll_rate), RFRAC(pll_rate));
> =20
> -               ralink_clk_add("10000500.uart", periph_rate);
>         }
> =20
>         pr_debug(RFMT("CPU") RFMT("DRAM") RFMT("SYS") RFMT("PERIPH"),
> @@ -555,21 +565,19 @@ void __init ralink_clk_init(void)
>                  RINT(dram_rate), RFRAC(dram_rate),
>                  RINT(sys_rate), RFRAC(sys_rate),
>                  RINT(periph_rate), RFRAC(periph_rate));
> -#undef RFRAC
> -#undef RINT
> -#undef RFMT
> =20
> -       ralink_clk_add("cpu", cpu_rate);
> -       ralink_clk_add("10000100.timer", periph_rate);
> -       ralink_clk_add("10000120.watchdog", periph_rate);
> -       ralink_clk_add("10000900.i2c", periph_rate);
> -       ralink_clk_add("10000a00.i2s", pcmi2s_rate);
> -       ralink_clk_add("10000b00.spi", sys_rate);
> -       ralink_clk_add("10000b40.spi", sys_rate);
> -       ralink_clk_add("10000c00.uartlite", periph_rate);
> -       ralink_clk_add("10000d00.uart1", periph_rate);
> -       ralink_clk_add("10000e00.uart2", periph_rate);
> -       ralink_clk_add("10180000.wmac", xtal_rate);
> +       /* system global */
> +       clks[MT7620_CLK_CPU] =3D add_sys_clkdev("cpu", cpu_rate);
> +
> +       /* parent reference clocks */
> +       clks[MT7620_CLK_SYS] =3D
> +               clk_register_fixed_rate(NULL, "sys", NULL, 0, sys_rate);
> +       clks[MT7620_CLK_PERIPH] =3D
> +               clk_register_fixed_rate(NULL, "periph", NULL, 0, periph_r=
ate);
> +       clks[MT7620_CLK_PCMI2S] =3D
> +               clk_register_fixed_rate(NULL, "pcmi2s", NULL, 0, pcmi2s_r=
ate);
> +       clks[MT7620_CLK_XTAL] =3D
> +               clk_register_fixed_rate(NULL, "xtal", NULL, 0, xtal_rate);
> =20
>         if (IS_ENABLED(CONFIG_USB) && !is_mt76x8()) {
>                 /*
> @@ -586,6 +594,86 @@ void __init ralink_clk_init(void)
>         }
>  }
> =20
> +#undef RFRAC
> +#undef RINT
> +#undef RFMT
> +
> +static void __init mt7620_clk_init_dt(struct device_node *np)
> +{
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +}
> +CLK_OF_DECLARE(mt7620, "mediatek,mt7620-pll", mt7620_clk_init_dt);

Same question, why not platform driver?

> +
> +
> +/*
> + * resources for rt2880-clock
> + */
> +
> +static const struct gate_clk_desc clk_mt7620[GATE_CLK_NUM] __initconst =
=3D {
> +       [12] =3D { .name =3D "uart", .parent_name =3D "periph" },
> +       [16] =3D { .name =3D "i2c", .parent_name =3D "periph" },
> +       [17] =3D { .name =3D "i2s", .parent_name =3D "pcmi2s" },
> +       [18] =3D { .name =3D "spi", .parent_name =3D "sys" },
> +       [19] =3D { .name =3D "uartl", .parent_name =3D "periph" },
> +       /*
> +        * Now we exclude to avoid that clk framework disables no used cl=
ocks.
> +        * After implementing clk API calls in peripheral drivers,
> +        * we can activate their entries.
> +        */
> +#if 0

Why can't we just add them later? I'd rather not add dead code.

> +       [6] =3D { .name =3D "ge1" },
> +       [7] =3D { .name =3D "ge2" },
> +       [8] =3D { .name =3D "timer", .parent_name =3D "periph" },
> +       [9] =3D { .name =3D "intc" },
> +       [10] =3D { .name =3D "mc" },
> +       [11] =3D { .name =3D "pcm" },
[...]
> +
> +const struct of_device_id of_match_rt2880_clk[] __initconst =3D {

static?

> +       {
> +               .compatible =3D "mediatek,mt7620-clock",
> +               .data =3D clk_mt7620 },
> +       {
> +               .compatible =3D "mediatek,mt7628-clock",
> +               .data =3D clk_mt76x8 },
> +       {       /* sentinel */  },
> +};
> +
> +
>  void __init ralink_of_remap(void)
>  {
>         rt_sysc_membase =3D plat_of_remap_node("ralink,mt7620a-sysc");
> diff --git a/include/dt-bindings/clock/mt7620-clk.h b/include/dt-bindings=
/clock/mt7620-clk.h
> new file mode 100644
> index 000000000000..2e70e7df2ed2
> --- /dev/null
> +++ b/include/dt-bindings/clock/mt7620-clk.h
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 NOGUCHI Hiroshi <drvlabo@gmail.com>
> + */
> +
> +#ifndef __DT_BINDINGS_MT7620_CLK_H
> +#define __DT_BINDINGS_MT7620_CLK_H
> +
> +#define MT7620_CLK_CPU         0
> +#define        MT7620_CLK_SYS          1
> +#define        MT7620_CLK_PERIPH       2
> +#define        MT7620_CLK_PCMI2S       3
> +#define        MT7620_CLK_XTAL         4
> +
> +#define MT7620_CLK_MAX         5
> +
> +#endif /* __DT_BINDINGS_MT7620_CLK_H */

Can this file change go into the binding patch?

