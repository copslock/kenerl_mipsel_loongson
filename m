Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 12:24:13 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.9]:41143 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011628AbcBILXiesLts (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 12:23:38 +0100
Received: from mail.nefkom.net (unknown [192.168.8.184])
        by mail-out.m-online.net (Postfix) with ESMTP id 3q020T04Knz3hj6W;
        Tue,  9 Feb 2016 12:23:36 +0100 (CET)
X-Auth-Info: Ml1wtJFbR969RUgFvSB7xbRYb1BBAMUzgZPDb+fOw1Y=
Received: from chi.localnet (unknown [195.140.253.167])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 3q020S3b1yzvdWV;
        Tue,  9 Feb 2016 12:23:36 +0100 (CET)
From:   Marek Vasut <marex@denx.de>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Subject: Re: [RFC v5 01/15] WIP: clk: add Atheros AR933X SoCs clock driver
Date:   Tue, 9 Feb 2016 12:05:36 +0100
User-Agent: KMail/1.13.7 (Linux/3.14-2-amd64; KDE/4.13.1; x86_64; ; )
Cc:     linux-mips@linux-mips.org, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com> <1455005641-7079-2-git-send-email-antonynpavlov@gmail.com>
In-Reply-To: <1455005641-7079-2-git-send-email-antonynpavlov@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201602091205.36276.marex@denx.de>
Return-Path: <marex@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marex@denx.de
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

On Tuesday, February 09, 2016 at 09:13:47 AM, Antony Pavlov wrote:
> This driver can be easely upgraded for other Atheros
> SoCs (e.g. AR724X/AR913X) support.
> 

Hi!

[...]

> +static unsigned long
> +ath79_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct ath79_clk *ath79_clk = to_ath79_clk(hw);
> +	struct ath79_cblk *cblk = ath79_clk->cblk;
> +	const struct ath79_clk_info *clk_info =
> &cblk->clock_info[ath79_clk->idx]; +	const struct ath79_pll_info
> *pll_info;
> +	unsigned long rate;
> +	unsigned long freq;
> +	u32 clock_ctrl;
> +	u32 cpu_config;
> +	u32 t;
> +
> +	BUG_ON(clk_info->type != ATH79_CLK_PLL);
> +
> +	clock_ctrl = __raw_readl(cblk->base + AR933X_PLL_CLOCK_CTRL_REG);
> +
> +	if (clock_ctrl & AR933X_PLL_CLOCK_CTRL_BYPASS) {
> +		return parent_rate;
> +	}

You can drop the {} here.

> +	cpu_config = __raw_readl(cblk->base + AR933X_PLL_CPU_CONFIG_REG);
> +
> +	t = (cpu_config >> AR933X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
> +	    AR933X_PLL_CPU_CONFIG_REFDIV_MASK;
> +	freq = parent_rate / t;
> +
> +	t = (cpu_config >> AR933X_PLL_CPU_CONFIG_NINT_SHIFT) &
> +	    AR933X_PLL_CPU_CONFIG_NINT_MASK;
> +	freq *= t;
> +
> +	t = (cpu_config >> AR933X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
> +	    AR933X_PLL_CPU_CONFIG_OUTDIV_MASK;
> +	if (t == 0)
> +		t = 1;
> +
> +	freq >>= t;
> +
> +	pll_info = &clk_info->pll;
> +
> +	t = ((clock_ctrl >> pll_info->div_shift) & pll_info->div_mask) + 1;
> +	rate = freq / t;
> +
> +	return rate;
> +}

[...]

> +static void __init ar9130_init(struct device_node *np)
> +{
> +	int retval;
> +	struct ath79_cblk *cblk;
> +
> +	cblk = ath79_cblk_new(ar9331_clocks, ARRAY_SIZE(ar9331_clocks), np);
> +	if (!cblk) {
> +		pr_err("%s: failed to initialise clk block\n", __func__);
> +		return;
> +	}
> +
> +	retval = ath79_cblk_register_clocks(cblk);
> +	if (retval)
> +		pr_err("%s: failed to register clocks\n", __func__);
> +}
> +CLK_OF_DECLARE(ar933x_clk, "qca,ar9330-pll", ar9130_init);

Is that ar9130_init name correct? Shouldn't it be ar9330_init ?

Looks good otherwise, thanks!
