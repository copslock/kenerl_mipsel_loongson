Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 18:01:16 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:40950 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994629AbdFNQBJhvCxx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Jun 2017 18:01:09 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D38C2609C6; Wed, 14 Jun 2017 16:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497456067;
        bh=hRaUY3VRHX0DonlCYvIP05XiujI8e2pgQQQJUD+EhIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFKWxZ5mJiMHp1aU9SvaJ6p1oAnjF4HivWyaMKaGQAqLRU2UjEiZqNktCPpzHnjpT
         PJteu0c8U8znHhiqEuxcbgVVcq5Y8ctA4cAJ1khslGHmL68+jRXNfVvGjz8qC/gvzV
         lJuASHAElEWgW385gVt3pJu3aASB5/wqbFjjk3Fo=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA94F60219;
        Wed, 14 Jun 2017 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497456066;
        bh=hRaUY3VRHX0DonlCYvIP05XiujI8e2pgQQQJUD+EhIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3nFBy/BWWchkDJRia5kiIXLxxDrItzf2+3jmjBrxAmstRfrZ1S4y8PgIqokLxo+3
         rD5ieYR0YqalcKXwwQ+mViEaHoElJCSfEtQ/Vkqo5StKDdIf2UryTlePY8OIn5G1q/
         P1Hse6mW/V2O1J/2EwQz4js3vgqGE2+VjPv1vCXo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA94F60219
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Wed, 14 Jun 2017 09:01:06 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 2/4] clk: boston: Add a driver for MIPS Boston board
 clocks
Message-ID: <20170614160106.GY20170@codeaurora.org>
References: <20170602182003.16269-1-paul.burton@imgtec.com>
 <20170602182003.16269-3-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170602182003.16269-3-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58453
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

On 06/02, Paul Burton wrote:
> diff --git a/drivers/clk/imgtec/Kconfig b/drivers/clk/imgtec/Kconfig
> new file mode 100644
> index 000000000000..c2ea745928e4
> --- /dev/null
> +++ b/drivers/clk/imgtec/Kconfig
> @@ -0,0 +1,10 @@
> +config COMMON_CLK_BOSTON
> +	bool "Clock driver for MIPS Boston boards"
> +	depends on MIPS || COMPILE_TEST
> +	depends on OF

What's the OF build dependency?

> +	select MFD_SYSCON
> +	---help---
> +	  Enable this to support the system & CPU clocks on the MIPS Boston
> +	  development board from Imagination Technologies. These are simple
> +	  fixed rate clocks whose rate is determined by reading a platform
> +	  provided register.
> diff --git a/drivers/clk/imgtec/Makefile b/drivers/clk/imgtec/Makefile
> new file mode 100644
> index 000000000000..ac779b8c22f2
> --- /dev/null
> +++ b/drivers/clk/imgtec/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_COMMON_CLK_BOSTON)		+= clk-boston.o
> diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
> new file mode 100644
> index 000000000000..98bb0b764d15
> --- /dev/null
> +++ b/drivers/clk/imgtec/clk-boston.c
> @@ -0,0 +1,101 @@
> +/*
> + * Copyright (C) 2016-2017 Imagination Technologies
> + * Author: Paul Burton <paul.burton@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/syscon.h>
> +
> +#include <dt-bindings/clock/boston-clock.h>
> +
> +#define BOSTON_PLAT_MMCMDIV		0x30
> +# define BOSTON_PLAT_MMCMDIV_CLK0DIV	(0xff << 0)
> +# define BOSTON_PLAT_MMCMDIV_INPUT	(0xff << 8)
> +# define BOSTON_PLAT_MMCMDIV_MUL	(0xff << 16)
> +# define BOSTON_PLAT_MMCMDIV_CLK1DIV	(0xff << 24)
> +
> +#define BOSTON_CLK_COUNT 3
> +
> +struct clk_boston_state {
> +	struct clk *clks[BOSTON_CLK_COUNT];
> +	struct clk_onecell_data onecell_data;
> +};
> +
> +static u32 ext_field(u32 val, u32 mask)
> +{
> +	return (val & mask) >> (ffs(mask) - 1);
> +}
> +
> +static void __init clk_boston_setup(struct device_node *np)
> +{
> +	unsigned long in_freq, cpu_freq, sys_freq;
> +	uint mmcmdiv, mul, cpu_div, sys_div;
> +	struct clk_boston_state *state;
> +	struct regmap *regmap;
> +	struct clk *clk;
> +	int err;
> +
> +	regmap = syscon_node_to_regmap(np->parent);
> +	if (IS_ERR(regmap)) {
> +		pr_err("failed to find regmap\n");
> +		return;
> +	}
> +
> +	err = regmap_read(regmap, BOSTON_PLAT_MMCMDIV, &mmcmdiv);
> +	if (err) {
> +		pr_err("failed to read mmcm_div register: %d\n", err);
> +		return;
> +	}
> +
> +	in_freq = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_INPUT) * 1000000;
> +	mul = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_MUL);
> +
> +	sys_div = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_CLK0DIV);
> +	sys_freq = mult_frac(in_freq, mul, sys_div);
> +
> +	cpu_div = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_CLK1DIV);
> +	cpu_freq = mult_frac(in_freq, mul, cpu_div);
> +
> +	state = kzalloc(sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return;
> +
> +	clk = clk_register_fixed_rate(NULL, "input", NULL, 0, in_freq);

Please use the clk_hw_register_*() APIs instead so that this
driver only deals in clk_hw pointers.

> +	if (IS_ERR(clk)) {
> +		pr_err("failed to register input clock: %ld\n", PTR_ERR(clk));
> +		return;
> +	}
> +	state->clks[BOSTON_CLK_INPUT] = clk;
> +
> +	clk = clk_register_fixed_rate(NULL, "sys", "input", 0, sys_freq);
> +	if (IS_ERR(clk)) {
> +		pr_err("failed to register sys clock: %ld\n", PTR_ERR(clk));
> +		return;
> +	}
> +	state->clks[BOSTON_CLK_SYS] = clk;
> +
> +	clk = clk_register_fixed_rate(NULL, "cpu", "input", 0, cpu_freq);
> +	if (IS_ERR(clk)) {
> +		pr_err("failed to register cpu clock: %ld\n", PTR_ERR(clk));
> +		return;
> +	}
> +	state->clks[BOSTON_CLK_CPU] = clk;
> +
> +	state->onecell_data.clks = state->clks;
> +	state->onecell_data.clk_num = BOSTON_CLK_COUNT;
> +
> +	err = of_clk_add_provider(np, of_clk_src_onecell_get,
> +				  &state->onecell_data);

Same for here, of_clk_add_hw_provider()

> +	if (err)
> +		pr_err("failed to add DT provider: %d\n", err);
> +}
> +CLK_OF_DECLARE(clk_boston, "img,boston-clock", clk_boston_setup);

Can this be a platform driver? The syscon mfd can populate child
nodes and this could be a driver that binds to the clock child
node.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
