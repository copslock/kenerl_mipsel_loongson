Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 01:00:24 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.11.231]:58206 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011645AbbATAAWkfYjR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 01:00:22 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7428B13EC78;
        Tue, 20 Jan 2015 00:00:20 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 6140413EDCB; Tue, 20 Jan 2015 00:00:20 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07E9013EC78;
        Tue, 20 Jan 2015 00:00:19 +0000 (UTC)
Date:   Mon, 19 Jan 2015 16:00:19 -0800
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Mike Turquette <mturquette@linaro.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Tero Kristo <t-kristo@ti.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Matt Porter <mporter@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Bintian Wang <bintian.wang@huawei.com>,
        Chao Xie <chao.xie@marvell.com>, linux-doc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v9 3/3] clk: Add floor and ceiling constraints to clock
 rates
Message-ID: <20150120000019.GD27202@codeaurora.org>
References: <1421688067-24426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421688067-24426-4-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1421688067-24426-4-git-send-email-tomeu.vizoso@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45339
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

On 01/19, Tomeu Vizoso wrote:
> Adds a way for clock consumers to set maximum and minimum rates. This can be
> used for thermal drivers to set ceiling rates, or by misc. drivers to set
> floor rates to assure a minimum performance level.
> 
> Changes the signature of the determine_rate callback by adding the
> parameters floor_rate and ceiling_rate.

Commit text needs the s/floor/min and s/ceiling/max treatment
too.

> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index f2a1ff3..55b3124 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1026,6 +1051,28 @@ static unsigned long clk_core_round_rate_nolock(struct clk_core *clk,
>  	else
>  		return clk->rate;
>  }
> +unsigned long __clk_determine_rate(struct clk_hw *hw,
> +				   unsigned long rate,
> +				   unsigned long min_rate,
> +				   unsigned long max_rate)
> +{
> +	unsigned long parent_rate = 0;
> +	struct clk_core *core = hw->core;
> +	struct clk_hw *parent_hw;
> +
> +	if (!core->ops->determine_rate)
> +		return 0;
> +
> +	if (core->parent) {
> +		parent_rate = core->parent->rate;
> +		parent_hw = core->parent->hw;
> +	}
> +
> +	return core->ops->determine_rate(core->hw, rate,
> +					min_rate, max_rate,
> +					&parent_rate, &parent_hw);
> +}
> +EXPORT_SYMBOL_GPL(__clk_determine_rate);

Maybe I misled you with the API name. I was thinking more along
the lines of clk_round_rate() and this new function ending up
calling clk_core_round_rate(), but clk_round_rate() would call it
with whatever range the clock is constrained to while this new
function would allow driver authors to specify the range. It
should be easy enough to add min/max to clk_core_round_rate()
given that it's a private API in this file.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
