Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2016 01:27:42 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:58578 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009366AbcA3A1jWygGr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2016 01:27:39 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2F44D60248;
        Sat, 30 Jan 2016 00:27:37 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2130B60498; Sat, 30 Jan 2016 00:27:37 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F48160248;
        Sat, 30 Jan 2016 00:27:35 +0000 (UTC)
Date:   Fri, 29 Jan 2016 16:27:34 -0800
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     linux-mips@linux-mips.org, Alban Bedel <albeu@free.fr>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC v3 01/14] WIP: clk: add Atheros AR724X/AR913X/AR933X SoCs
 clock driver
Message-ID: <20160130002734.GX12841@codeaurora.org>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
 <1453580251-2341-2-git-send-email-antonynpavlov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453580251-2341-2-git-send-email-antonynpavlov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

On 01/23, Antony Pavlov wrote:
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

Is there a binding document for this?

>  drivers/clk/Makefile                  |   1 +
>  drivers/clk/clk-ath79.c               | 193 ++++++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/ath79-clk.h |  22 ++++
>  3 files changed, 216 insertions(+)
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 820714c..5101763 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> diff --git a/drivers/clk/clk-ath79.c b/drivers/clk/clk-ath79.c
> new file mode 100644
> index 0000000..75338a7
> --- /dev/null
> +++ b/drivers/clk/clk-ath79.c
> @@ -0,0 +1,193 @@
> +/*
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include "clk.h"

Don't include this header.

> +
> +#include <dt-bindings/clock/ath79-clk.h>
> +
> +#include "asm/mach-ath79/ar71xx_regs.h"
> +#include "asm/mach-ath79/ath79.h"

Can we get away without including these headers?

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

Why are we using clkdev? Can't we use DT lookups?

> +	if (err)
> +		panic("unable to register %s clock device", id);
> +
> +	return clk;
> +}
> +
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
> +
> +	of_ref_rate = clk_get_rate(ref_clk);
> +
> +	ref_rate = AR724X_BASE_FREQ;
> +
> +	if (of_ref_rate != ref_rate) {
> +		pr_err("ref_rate != of_ref_rate\n");
> +		ref_rate = of_ref_rate;
> +	}
> +
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
> +
> +	ath79_clks[ATH79_CLK_REF] = ath79_add_sys_clkdev("ref", ref_rate);
> +	ath79_clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
> +	ath79_clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
> +	ath79_clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
> +	ath79_clks[ATH79_CLK_WDT] = ath79_add_sys_clkdev("wdt", ahb_rate);
> +	ath79_clks[ATH79_CLK_UART] = ath79_add_sys_clkdev("uart", ahb_rate);
> +
> +	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);

What if this fails?

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

Does this happen? I'd prefer we find a way to avoid calling
of_clk_get() and clk_get_rate() in this driver.

> +		pr_err("ref_rate != of_ref_rate\n");
> +		ref_rate = of_ref_rate;
> +	}
> +
> +	clock_ctrl = ath79_pll_rr(AR933X_PLL_CLOCK_CTRL_REG);
> +	if (clock_ctrl & AR933X_PLL_CLOCK_CTRL_BYPASS) {
> +		cpu_rate = ref_rate;
> +		ahb_rate = ref_rate;
> +		ddr_rate = ref_rate;

So if it's in bypass, why not register fixed factor clocks of
1/1 and set the parent to ref_clk?

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

These look like something we could implement as real clocks with
clk_ops. The parent still looks like ref_clk, but we would be
reading hardware in recalc_rate to figure out what the rate is.

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

Is there a reason this isn't a platform driver?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
