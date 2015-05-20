Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2015 01:16:46 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:57834 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013082AbbETXQpIcZpv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 May 2015 01:16:45 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 32E0914183E;
        Wed, 20 May 2015 23:16:46 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 1CBA9141840; Wed, 20 May 2015 23:16:46 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98D4D14183E;
        Wed, 20 May 2015 23:16:45 +0000 (UTC)
Date:   Wed, 20 May 2015 16:16:44 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Lars-Peter Clausen <lars@metafoo.de>,
        Mike Turquette <mturquette@linaro.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 25/37] clk: ingenic: add driver for Ingenic SoC CGU
 clocks
Message-ID: <20150520231644.GZ31753@codeaurora.org>
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
 <1429881457-16016-26-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1429881457-16016-26-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47504
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

On 04/24, Paul Burton wrote:
> +
> +static unsigned long
> +ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
> +	struct ingenic_cgu *cgu = ingenic_clk->cgu;
> +	const struct ingenic_cgu_clk_info *clk_info;
> +	const struct ingenic_cgu_pll_info *pll_info;
> +	unsigned m, n, od_enc, od;
> +	bool bypass, enable;
> +	unsigned long flags;
> +	u32 ctl;
> +
> +	clk_info = &cgu->clock_info[ingenic_clk->idx];
> +	BUG_ON(clk_info->type != CGU_CLK_PLL);
> +	pll_info = &clk_info->pll;
> +
> +	spin_lock_irqsave(&cgu->lock, flags);
> +	ctl = readl(cgu->base + pll_info->reg);
> +	spin_unlock_irqrestore(&cgu->lock, flags);
> +
> +	m = ((ctl >> pll_info->m_shift) & GENMASK(pll_info->m_bits - 1, 0));
> +	m += pll_info->m_offset;
> +	n = ((ctl >> pll_info->n_shift) & GENMASK(pll_info->n_bits - 1, 0));

Nitpick: Some unnecessary () here.

> +	n += pll_info->n_offset;
> +	od_enc = ctl >> pll_info->od_shift;
> +	od_enc &= GENMASK(pll_info->od_bits - 1, 0);
> +	bypass = !!(ctl & BIT(pll_info->bypass_bit));
> +	enable = !!(ctl & BIT(pll_info->enable_bit));
> +
> +	if (bypass)
> +		return parent_rate;
> +
> +	if (!enable)
> +		return 0;
> +
> +	for (od = 0; od < pll_info->od_max; od++) {
> +		if (pll_info->od_encoding[od] == od_enc)
> +			break;
> +	}
> +	BUG_ON(od == pll_info->od_max);
> +	od++;
> +
> +	return div_u64((u64)parent_rate * m, n * od);
> +
[...]
> +
> +/*
> + * Setup functions.
> + */
> +
> +static int register_clock(struct ingenic_cgu *cgu, unsigned idx)

Please namespace this. It's too generic. igenic_register_clk()?

> +{
> +	const struct ingenic_cgu_clk_info *clk_info = &cgu->clock_info[idx];
> +	struct clk_init_data clk_init;
> +	struct ingenic_clk *ingenic_clk = NULL;
[...]
> +
> +
> +/**
> + * ingenic_cgu_register_clocks() - Registers the clocks
> + * @cgu: pointer to cgu data
> + *
> + * Register the clocks described by the CGU with the common clock framework.
> + *
> + * Return: 1 on success or -errno if unsuccesful.

It looks like it returns 0 instead of 1 on success? 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
