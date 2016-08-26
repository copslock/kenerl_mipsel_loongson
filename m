Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 19:41:56 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:60909 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992492AbcHZRlroNFrJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 19:41:47 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 99DA161B1D; Fri, 26 Aug 2016 17:41:45 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBAA361ACE;
        Fri, 26 Aug 2016 17:41:44 +0000 (UTC)
Date:   Fri, 26 Aug 2016 10:41:44 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 25/26] clk: boston: Add a driver for MIPS Boston board
 clocks
Message-ID: <20160826174144.GW19826@codeaurora.org>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
 <20160826153725.11629-26-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160826153725.11629-26-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54813
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

On 08/26, Paul Burton wrote:
> 
>  drivers/clk/Kconfig      |   9 ++++
>  drivers/clk/Makefile     |   1 +
>  drivers/clk/clk-boston.c | 131 +++++++++++++++++++++++++++++++++++++++++++++++

Maybe a vendor subdirectory is appropriate? imgtec?

> +
> +struct clk_boston_state {
> +	struct clk *clk[BOSTON_CLK_COUNT];
> +	struct clk_boston clk_boston[BOSTON_CLK_COUNT];
> +	struct clk_onecell_data onecell_data[BOSTON_CLK_COUNT];
> +};
> +
> +static const char *clk_names[BOSTON_CLK_COUNT] = {

const char * const?

> +	[BOSTON_CLK_SYS] = "sys",
> +	[BOSTON_CLK_CPU] = "cpu",
> +};
> +
> +#define BOSTON_PLAT_MMCMDIV		0x30
> +# define BOSTON_PLAT_MMCMDIV_CLK0DIV	(0xff << 0)
> +# define BOSTON_PLAT_MMCMDIV_INPUT	(0xff << 8)
> +# define BOSTON_PLAT_MMCMDIV_MUL	(0xff << 16)
> +# define BOSTON_PLAT_MMCMDIV_CLK1DIV	(0xff << 24)
> +
> +static struct clk_boston *to_clk_boston(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct clk_boston, hw);
> +}
> +
> +static uint32_t ext_field(uint32_t val, uint32_t mask)

Please use u32 instead of uint32_t in drivers.

> +{
> +	return (val & mask) >> (ffs(mask) - 1);
> +}
> +
> +static unsigned long clk_boston_recalc_rate(struct clk_hw *hw,
> +					    unsigned long parent_rate)
> +{
> +	struct clk_boston *state = to_clk_boston(hw);
> +	uint32_t in_rate, mul, div;
> +	uint mmcmdiv;

unsigned int?

> +	int err;
> +
> +	err = regmap_read(state->regmap, BOSTON_PLAT_MMCMDIV, &mmcmdiv);
> +	if (err)
> +		return 0;
> +
> +	in_rate = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_INPUT);

This sounds like a parent rate? Should there be another clk
created for that so that parent_rate in this function is useful?

> +	mul = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_MUL);
> +
> +	switch (state->id) {
> +	case BOSTON_CLK_SYS:
> +		div = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_CLK0DIV);
> +		break;
> +	case BOSTON_CLK_CPU:
> +		div = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_CLK1DIV);

Why not put the CLK0DIV or CLK1DIV offset in state->id instead?
That way this function just read in_rate, mul, and div and then
does the math?

> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	return (in_rate * mul * 1000000) / div;

Is this always fixed at boot? It may be easier to populate fixed
rate clks during probe with the rate calculated there. Then there
aren't any clk_ops to implement.

> +}
> +
> +static const struct clk_ops clk_boston_ops = {
> +	.recalc_rate = clk_boston_recalc_rate,
> +};
> +
> +static void __init clk_boston_setup(struct device_node *np)
> +{
> +	struct clk_boston_state *state;
> +	struct clk_init_data init;
> +	struct regmap *regmap;
> +	int i, err;
> +
> +	state = kzalloc(sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return;
> +
> +	regmap = syscon_regmap_lookup_by_phandle(np, "regmap");
> +	if (IS_ERR(regmap)) {
> +		pr_err("failed to find regmap\n");
> +		return;
> +	}
> +
> +	for (i = 0; i < BOSTON_CLK_COUNT; i++) {
> +		memset(&init, 0, sizeof(init));
> +		init.flags = CLK_IS_BASIC;

Please drop this flag unless you really need it for something. As
far as I know CLK_IS_BASIC is just for OMAP code.

> +		init.name = clk_names[i];
> +		init.ops = &clk_boston_ops;
> +
> +		state->clk_boston[i].hw.init = &init;
> +		state->clk_boston[i].id = i;
> +		state->clk_boston[i].regmap = regmap;
> +
> +		state->clk[i] = clk_register(NULL, &state->clk_boston[i].hw);

Please use clk_hw_register() instead.

> +		if (IS_ERR(state->clk[i])) {
> +			pr_err("failed to register clock: %ld\n",
> +			       PTR_ERR(state->clk[i]));
> +			return;
> +		}
> +	}
> +
> +	state->onecell_data->clks = state->clk;
> +	state->onecell_data->clk_num = BOSTON_CLK_COUNT;
> +
> +	err = of_clk_add_provider(np, of_clk_src_onecell_get,
> +				  state->onecell_data);

Please use of_clk_add_hw_provider() instead.

> +	if (err)
> +		pr_err("failed to add DT provider: %d\n", err);
> +}
> +CLK_OF_DECLARE(clk_boston, "img,boston-clock", clk_boston_setup);

Please make this into a platform driver.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
