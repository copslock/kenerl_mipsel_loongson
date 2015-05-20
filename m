Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2015 01:07:54 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:57427 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013082AbbETXHw3Q9qm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 May 2015 01:07:52 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E767B1417C6;
        Wed, 20 May 2015 23:07:52 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id D46011417C9; Wed, 20 May 2015 23:07:52 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B4931417C6;
        Wed, 20 May 2015 23:07:52 +0000 (UTC)
Date:   Wed, 20 May 2015 16:07:51 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Lars-Peter Clausen <lars@metafoo.de>,
        Mike Turquette <mturquette@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 30/37] clk: ingenic: add JZ4780 CGU support
Message-ID: <20150520230751.GY31753@codeaurora.org>
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com>
 <1429881457-16016-31-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1429881457-16016-31-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47503
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
> diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
> new file mode 100644
> index 0000000..950616a
> --- /dev/null
> +++ b/drivers/clk/ingenic/jz4780-cgu.c
> @@ -0,0 +1,736 @@
> +
> +struct clk_ops jz4780_otg_phy_ops = {

static?

> +	.get_parent = jz4780_otg_phy_get_parent,
> +	.set_parent = jz4780_otg_phy_set_parent,
> +
> +	.recalc_rate = jz4780_otg_phy_recalc_rate,
> +	.round_rate = jz4780_otg_phy_round_rate,
> +	.set_rate = jz4780_otg_phy_set_rate,
> +};
[...]
> +
> +static void __init jz4780_cgu_init(struct device_node *np)
> +{
> +	int retval;
> +
> +	cgu = ingenic_cgu_new(jz4780_cgu_clocks,
> +			      ARRAY_SIZE(jz4780_cgu_clocks), np);
> +	if (!cgu) {
> +		pr_err("%s: failed to initialise CGU\n", __func__);
> +		return;
> +	}
> +
> +	retval = ingenic_cgu_register_clocks(cgu);
> +	if (retval) {
> +		pr_err("%s: failed to register CGU Clocks\n", __func__);
> +		return;
> +	}
> +
> +	clk_set_parent(cgu->clocks.clks[JZ4780_CLK_UHC],
> +		       cgu->clocks.clks[JZ4780_CLK_MPLL]);

Can you do this via assigned- parents?

> +}
> +CLK_OF_DECLARE(jz4780_cgu, "ingenic,jz4780-cgu", jz4780_cgu_init);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
