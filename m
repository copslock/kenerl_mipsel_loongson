Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:22:12 +0100 (CET)
Received: from smtp6-g21.free.fr ([212.27.42.6]:32753 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011469AbcAYWWKjlojQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:22:10 +0100
Received: from tock (unknown [80.171.100.146])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 9F3888228C;
        Mon, 25 Jan 2016 23:20:31 +0100 (CET)
Date:   Mon, 25 Jan 2016 23:21:56 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC v3 01/14] WIP: clk: add Atheros AR724X/AR913X/AR933X SoCs
 clock driver
Message-ID: <20160125232156.35c0ce3f@tock>
In-Reply-To: <1453580251-2341-2-git-send-email-antonynpavlov@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
        <1453580251-2341-2-git-send-email-antonynpavlov@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Sat, 23 Jan 2016 23:17:18 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> TODO: get pll registers base address from devicetree node
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---
>  drivers/clk/Makefile                  |   1 +
>  drivers/clk/clk-ath79.c               | 193 ++++++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/ath79-clk.h |  22 ++++
>  3 files changed, 216 insertions(+)
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 820714c..5101763 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -18,6 +18,7 @@ endif
>  # hardware specific clock types
>  # please keep this section sorted lexicographically by file/directory path name
>  obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
> +obj-$(CONFIG_ATH79)			+= clk-ath79.o
>  obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
>  obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
>  obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
> diff --git a/drivers/clk/clk-ath79.c b/drivers/clk/clk-ath79.c
> new file mode 100644
> index 0000000..75338a7
> --- /dev/null
> +++ b/drivers/clk/clk-ath79.c
> @@ -0,0 +1,193 @@
> +/*
> + * Clock driver for Atheros AR724X/AR913X/AR933X SoCs
> + *
> + * Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
> + * Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
> + * Copyright (C) 2015 Alban Bedel <albeu@free.fr>
> + * Copyright (C) 2016 Antony Pavlov <antonynpavlov@gmail.com>
> + *
> + * Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include "clk.h"
> +
> +#include <dt-bindings/clock/ath79-clk.h>
> +
> +#include "asm/mach-ath79/ar71xx_regs.h"
> +#include "asm/mach-ath79/ath79.h"
> +
> +#define MHZ (1000 * 1000)
> +
> +#define AR724X_BASE_FREQ	(40 * MHZ)
> +
> +static struct clk *ath79_clks[ATH79_CLK_END];
> +
> +static struct clk_onecell_data clk_data = {
> +	.clks = ath79_clks,
> +	.clk_num = ARRAY_SIZE(ath79_clks),
> +};
> +
> +static struct clk *__init ath79_add_sys_clkdev(
> +	const char *id, unsigned long rate)
> +{
> +	struct clk *clk;
> +	int err;
> +
> +	clk = clk_register_fixed_rate(NULL, id, NULL, CLK_IS_ROOT, rate);
> +	if (!clk)
> +		panic("failed to allocate %s clock structure", id);
> +
> +	err = clk_register_clkdev(clk, id, NULL);
> +	if (err)
> +		panic("unable to register %s clock device", id);
> +
> +	return clk;
> +}
>
> +static void __init ar724x_clk_init(struct device_node *np)
> +{
> +	struct clk *ref_clk;
> +	unsigned long of_ref_rate;
> +	unsigned long ref_rate;
> +	unsigned long cpu_rate;
> +	unsigned long ddr_rate;
> +	unsigned long ahb_rate;
> +	u32 pll;
> +	u32 freq;
> +	u32 div;
> +
> +	ref_clk = of_clk_get(np, 0);
> +	if (IS_ERR(ref_clk)) {
> +		pr_err("%s: of_clk_get failed\n", np->full_name);
> +		return;
> +	}

It would be better to have this function take the ref clock as
argument, to allow using it for both OF and legacy platforms.

> +	of_ref_rate = clk_get_rate(ref_clk);
> +
> +	ref_rate = AR724X_BASE_FREQ;
> +
> +	if (of_ref_rate != ref_rate) {
> +		pr_err("ref_rate != of_ref_rate\n");
> +		ref_rate = of_ref_rate;
> +	}

I don't think that this test is really useful.

> +	pll = ath79_pll_rr(AR724X_PLL_REG_CPU_CONFIG);
> +
> +	div = ((pll >> AR724X_PLL_FB_SHIFT) & AR724X_PLL_FB_MASK);
> +	freq = div * ref_rate;
> +
> +	div = ((pll >> AR724X_PLL_REF_DIV_SHIFT) & AR724X_PLL_REF_DIV_MASK) * 2;
> +	freq /= div;
> +
> +	cpu_rate = freq;
> +
> +	div = ((pll >> AR724X_DDR_DIV_SHIFT) & AR724X_DDR_DIV_MASK) + 1;
> +	ddr_rate = freq / div;
> +
> +	div = (((pll >> AR724X_AHB_DIV_SHIFT) & AR724X_AHB_DIV_MASK) + 1) * 2;
> +	ahb_rate = cpu_rate / div;

For a new driver it would make sense to use clk_register_divider() and
similar generic building blocks.

> +	ath79_clks[ATH79_CLK_REF] = ath79_add_sys_clkdev("ref", ref_rate);
> +	ath79_clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
> +	ath79_clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
> +	ath79_clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
> +	ath79_clks[ATH79_CLK_WDT] = ath79_add_sys_clkdev("wdt", ahb_rate);
> +	ath79_clks[ATH79_CLK_UART] = ath79_add_sys_clkdev("uart", ahb_rate);

You shouldn't add ref, wdt and uart, they are not needed and make the
driver incompatible with the current DT bindings.

> +	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +}
> +
> +static void __init ar933x_clk_init(struct device_node *np)
> +{
> +	struct clk *ref_clk;
> +	unsigned long of_ref_rate;
> +	unsigned long ref_rate;
> +	unsigned long cpu_rate;
> +	unsigned long ddr_rate;
> +	unsigned long ahb_rate;
> +	u32 clock_ctrl;
> +	u32 cpu_config;
> +	u32 freq;
> +	u32 t;
> +
> +	ref_clk = of_clk_get(np, 0);
> +	if (IS_ERR(ref_clk)) {
> +		pr_err("%s: of_clk_get failed\n", np->full_name);
> +		return;
> +	}
> +
> +	of_ref_rate = clk_get_rate(ref_clk);
> +
> +	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
> +	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
> +		ref_rate = 40 * MHZ;
> +	else
> +		ref_rate = 25 * MHZ;
> +
> +	if (ref_rate != of_ref_rate) {
> +		pr_err("ref_rate != of_ref_rate\n");
> +		ref_rate = of_ref_rate;
> +	}
> +
> +	clock_ctrl = ath79_pll_rr(AR933X_PLL_CLOCK_CTRL_REG);
> +	if (clock_ctrl & AR933X_PLL_CLOCK_CTRL_BYPASS) {
> +		cpu_rate = ref_rate;
> +		ahb_rate = ref_rate;
> +		ddr_rate = ref_rate;
> +	} else {
> +		cpu_config = ath79_pll_rr(AR933X_PLL_CPU_CONFIG_REG);
> +
> +		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
> +		    AR933X_PLL_CPU_CONFIG_REFDIV_MASK;
> +		freq = ref_rate / t;
> +
> +		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_NINT_SHIFT) &
> +		    AR933X_PLL_CPU_CONFIG_NINT_MASK;
> +		freq *= t;
> +
> +		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
> +		    AR933X_PLL_CPU_CONFIG_OUTDIV_MASK;
> +		if (t == 0)
> +			t = 1;
> +
> +		freq >>= t;
> +
> +		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_CPU_DIV_SHIFT) &
> +		     AR933X_PLL_CLOCK_CTRL_CPU_DIV_MASK) + 1;
> +		cpu_rate = freq / t;
> +
> +		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_DDR_DIV_SHIFT) &
> +		      AR933X_PLL_CLOCK_CTRL_DDR_DIV_MASK) + 1;
> +		ddr_rate = freq / t;
> +
> +		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_AHB_DIV_SHIFT) &
> +		     AR933X_PLL_CLOCK_CTRL_AHB_DIV_MASK) + 1;
> +		ahb_rate = freq / t;
> +	}
> +
> +	ath79_clks[ATH79_CLK_REF] = ath79_add_sys_clkdev("ref", ref_rate);
> +	ath79_clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
> +	ath79_clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
> +	ath79_clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
> +	ath79_clks[ATH79_CLK_WDT] = ath79_add_sys_clkdev("wdt", ahb_rate);
> +	ath79_clks[ATH79_CLK_UART] = ath79_add_sys_clkdev("uart", ref_rate);
> +
> +	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +}
> +CLK_OF_DECLARE(ar9130_clk, "qca,ar9130-pll", ar724x_clk_init);
> +CLK_OF_DECLARE(ar933x_clk, "qca,ar9330-pll", ar933x_clk_init);
> diff --git a/include/dt-bindings/clock/ath79-clk.h b/include/dt-bindings/clock/ath79-clk.h
> new file mode 100644
> index 0000000..1c6fb04
> --- /dev/null
> +++ b/include/dt-bindings/clock/ath79-clk.h
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2014, 2016 Antony Pavlov <antonynpavlov@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __DT_BINDINGS_ATH79_CLK_H
> +#define __DT_BINDINGS_ATH79_CLK_H
> +
> +#define ATH79_CLK_REF		0
> +#define ATH79_CLK_CPU		1
> +#define ATH79_CLK_DDR		2
> +#define ATH79_CLK_AHB		3
> +#define ATH79_CLK_WDT		4
> +#define ATH79_CLK_UART		5
> +
> +#define ATH79_CLK_END		6
> +
> +#endif /* __DT_BINDINGS_ATH79_CLK_H */
