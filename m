Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2015 02:57:08 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.11.231]:38292 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007866AbbAQB5GXurTg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jan 2015 02:57:06 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 30C80140EF1;
        Sat, 17 Jan 2015 01:57:03 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 1E1CB140EF5; Sat, 17 Jan 2015 01:57:03 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 832F1140EF1;
        Sat, 17 Jan 2015 01:57:02 +0000 (UTC)
Date:   Fri, 16 Jan 2015 17:57:01 -0800
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
        Tim Kryger <tim.kryger@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Bintian Wang <bintian.wang@huawei.com>,
        Chao Xie <chao.xie@marvell.com>, linux-doc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH RESEND v8 2/2] clk: Add floor and ceiling constraints to
 clock rates
Message-ID: <20150117015701.GB27202@codeaurora.org>
References: <1421071809-17402-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421071809-17402-3-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1421071809-17402-3-git-send-email-tomeu.vizoso@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45240
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

On 01/12, Tomeu Vizoso wrote:
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 7eddfd8..2793bd7 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1013,8 +1015,8 @@ static unsigned long clk_core_round_rate_nolock(struct clk_core *clk,
>  
>  	if (clk->ops->determine_rate) {
>  		parent_hw = parent ? parent->hw : NULL;
> -		return clk->ops->determine_rate(clk->hw, rate, &parent_rate,
> -						&parent_hw);
> +		return clk->ops->determine_rate(clk->hw, rate, 0, ULONG_MAX,
> +						&parent_rate, &parent_hw);
>  	} else if (clk->ops->round_rate)
>  		return clk->ops->round_rate(clk->hw, rate, &parent_rate);
>  	else if (clk->flags & CLK_SET_RATE_PARENT)
> @@ -1453,8 +1458,20 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *clk,
>  
>  	/* find the closest rate and parent clk/rate */
>  	if (clk->ops->determine_rate) {
> +		hlist_for_each_entry(clk_user, &clk->clks, child_node) {
> +			floor_rate = max(floor_rate,
> +					 clk_user->floor_constraint);
> +		}
> +
> +		hlist_for_each_entry(clk_user, &clk->clks, child_node) {
> +			ceiling_rate = min(ceiling_rate,
> +					   clk_user->ceiling_constraint);
> +		}

I would think we need to do this in the clk_round_rate() path as
well. We can't just pass 0 and ULONG_MAX there or we'll determine
one rate here and another rate in round_rate(), violating the
contract between set_rate() and round_rate().

> +
>  		parent_hw = parent ? parent->hw : NULL;
>  		new_rate = clk->ops->determine_rate(clk->hw, rate,
> +						    floor_rate,
> +						    ceiling_rate,
>  						    &best_parent_rate,
>  						    &parent_hw);
>  		parent = parent_hw ? parent_hw->core : NULL;

We should enforce a constraint if the clk is using the
round_rate() op too. If the .round_rate() op returns some rate
within range it should be ok.  Otherwise we can fail the rate
change because it's out of range.

We'll also need to introduce some sort of
clk_core_determine_rate(core, rate, min, max) so that clock
providers can ask parent clocks to find a rate within some range
that they can tolerate. If we update __clk_mux_determine_rate()
we can see how that would work out.

> @@ -1660,13 +1657,92 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
[...]
> + */
> +int clk_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	return clk_core_set_rate(clk->core, rate);

clk could be NULL.

> +}
>  EXPORT_SYMBOL_GPL(clk_set_rate);
>  
> +int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max)
> +{
> +	int ret = 0;

Check for NULL clk.

> +
> +/**
> + * clk_set_floor_rate - set a minimum clock rate for a clock source
> + * @clk: clock source
> + * @rate: desired minimum clock rate in Hz
> + *
> + * Returns success (0) or negative errno.
> + */
> +int clk_set_floor_rate(struct clk *clk, unsigned long rate)
> +{
> +	return clk_set_rate_range(clk, rate, clk->ceiling_constraint);

clk could be NULL.

> +}
> +EXPORT_SYMBOL_GPL(clk_set_floor_rate);
> +
> +/**
> + * clk_set_ceiling_rate - set a maximum clock rate for a clock source
> + * @clk: clock source
> + * @rate: desired maximum clock rate in Hz
> + *
> + * Returns success (0) or negative errno.
> + */
> +int clk_set_ceiling_rate(struct clk *clk, unsigned long rate)
> +{
> +	return clk_set_rate_range(clk, clk->floor_constraint, rate);

clk could be NULL.

> +}
> +EXPORT_SYMBOL_GPL(clk_set_ceiling_rate);
> +
>  static struct clk_core *clk_core_get_parent(struct clk_core *core)
>  {
>  	struct clk_core *parent;
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 2e65419..ae5c800 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -175,9 +175,12 @@ struct clk_ops {
>  					unsigned long parent_rate);
>  	long		(*round_rate)(struct clk_hw *hw, unsigned long rate,
>  					unsigned long *parent_rate);
> -	long		(*determine_rate)(struct clk_hw *hw, unsigned long rate,
> -					unsigned long *best_parent_rate,
> -					struct clk_hw **best_parent_hw);
> +	long		(*determine_rate)(struct clk_hw *hw,
> +					  unsigned long rate,
> +					  unsigned long floor_rate,
> +					  unsigned long ceiling_rate,

I wonder if we should call this min_rate and max_rate?

> +					  unsigned long *best_parent_rate,
> +					  struct clk_hw **best_parent_hw);
>  	int		(*set_parent)(struct clk_hw *hw, u8 index);
>  	u8		(*get_parent)(struct clk_hw *hw);
>  	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index c7f258a..f99ae67 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -302,6 +302,34 @@ long clk_round_rate(struct clk *clk, unsigned long rate);
>  int clk_set_rate(struct clk *clk, unsigned long rate);
>  
>  /**
> + * clk_set_rate_range - set a rate range for a clock source
> + * @clk: clock source
> + * @min: desired minimum clock rate in Hz
> + * @max: desired maximum clock rate in Hz
> + *
> + * Returns success (0) or negative errno.
> + */
> +int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max);
> +
> +/**
> + * clk_set_floor_rate - set a minimum clock rate for a clock source
> + * @clk: clock source
> + * @rate: desired minimum clock rate in Hz
> + *
> + * Returns success (0) or negative errno.
> + */
> +int clk_set_floor_rate(struct clk *clk, unsigned long rate);

And this called clk_set_max_rate()?

> +
> +/**
> + * clk_set_ceiling_rate - set a maximum clock rate for a clock source
> + * @clk: clock source
> + * @rate: desired maximum clock rate in Hz
> + *
> + * Returns success (0) or negative errno.
> + */
> +int clk_set_ceiling_rate(struct clk *clk, unsigned long rate);

And this called clk_set_min_rate()?

> +
> +/**
>   * clk_set_parent - set the parent clock source for this clock
>   * @clk: clock source
>   * @parent: parent clock source

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
