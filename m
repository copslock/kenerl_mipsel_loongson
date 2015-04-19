Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2015 14:13:38 +0200 (CEST)
Received: from gloria.sntech.de ([95.129.55.99]:34996 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007043AbbDSMNhC0mGT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Apr 2015 14:13:37 +0200
Received: from ip92344031.dynamic.kabel-deutschland.de ([146.52.64.49] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1Yjo5x-0004OA-H0; Sun, 19 Apr 2015 14:13:05 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     Mike Turquette <mturquette@linaro.org>,
        Mikko Perttunen <mikko.perttunen@kapsi.fi>,
        Jonathan Corbet <corbet@lwn.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        ascha Hauer <kernel@pengutronix.de>,
        David Brown <davidb@codeaurora.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Paul Walmsley <paul@pwsan.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Viresh Kumar <viresh.linux@gmail.com>,
        Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Tero Kristo <t-kristo@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mips@linux-mips.org, patches@opensource.wolfsonmicro.com,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, spear-devel@list.st.com,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH 1/2] clk: change clk_ops' ->round_rate() prototype
Date:   Sun, 19 Apr 2015 14:13:04 +0200
Message-ID: <7408975.lBcgZIN9hf@diego>
User-Agent: KMail/4.14.1 (Linux/3.16.0-4-amd64; KDE/4.14.2; x86_64; ; )
In-Reply-To: <1429255769-13639-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1429255769-13639-1-git-send-email-boris.brezillon@free-electrons.com> <1429255769-13639-2-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <heiko@sntech.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: heiko@sntech.de
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

Hi Boris,

Am Freitag, 17. April 2015, 09:29:28 schrieb Boris Brezillon:
> Clock rates are stored in an unsigned long field, but ->round_rate()
> (which returns a rounded rate from a requested one) returns a long
> value (errors are reported using negative error codes), which can lead
> to long overflow if the clock rate exceed 2Ghz.
> 
> Change ->round_rate() prototype to return 0 or an error code, and pass the
> requested rate as a pointer so that it can be adjusted depending on
> hardware capabilities.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---

On a rk3288-veyron-pinky with the fix described below:
Tested-by: Heiko Stuebner <heiko@sntech.de>


> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index fa5a00e..1462ddc 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1640,8 +1643,10 @@ static struct clk_core *clk_calc_new_rates(struct
> clk_core *clk, &parent_hw);
>  		parent = parent_hw ? parent_hw->core : NULL;
>  	} else if (clk->ops->round_rate) {
> -		new_rate = clk->ops->round_rate(clk->hw, rate,
> -						&best_parent_rate);
> +		if (clk->ops->round_rate(clk->hw, &new_rate,
> +					 &best_parent_rate))
> +			return NULL;
> +
>  		if (new_rate < min_rate || new_rate > max_rate)
>  			return NULL;
>  	} else if (!parent || !(clk->flags & CLK_SET_RATE_PARENT)) {

This is using new_rate uninitialized when calling into the round_rate
callback. Which in turn pushed my PLLs up to 2.2GHz :-)

I guess you'll need something like the following:

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index db4e4b2..afc7733 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1605,6 +1605,7 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *clk,
 						    &parent_hw);
 		parent = parent_hw ? parent_hw->core : NULL;
 	} else if (clk->ops->round_rate) {
+		new_rate = rate;
 		if (clk->ops->round_rate(clk->hw, &new_rate,
 					 &best_parent_rate))
 			return NULL;




> diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
> index f8d3baf..bd408ef 100644
> --- a/drivers/clk/rockchip/clk-pll.c
> +++ b/drivers/clk/rockchip/clk-pll.c
> @@ -63,8 +63,8 @@ static const struct rockchip_pll_rate_table
> *rockchip_get_pll_settings( return NULL;
>  }
> 
> -static long rockchip_pll_round_rate(struct clk_hw *hw,
> -			    unsigned long drate, unsigned long *prate)
> +static int rockchip_pll_round_rate(struct clk_hw *hw,
> +			    unsigned long *drate, unsigned long *prate)
>  {
>  	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
>  	const struct rockchip_pll_rate_table *rate_table = pll->rate_table;
> @@ -72,12 +72,15 @@ static long rockchip_pll_round_rate(struct clk_hw *hw,
> 
>  	/* Assumming rate_table is in descending order */
>  	for (i = 0; i < pll->rate_count; i++) {
> -		if (drate >= rate_table[i].rate)
> -			return rate_table[i].rate;
> +		if (*drate >= rate_table[i].rate) {
> +			*drate = rate_table[i].rate;
> +			return 0;
> +		}
>  	}
> 
>  	/* return minimum supported value */
> -	return rate_table[i - 1].rate;
> +	*drate = rate_table[i - 1].rate;
> +	return 0;
>  }
> 
>  /*

The rockchip-part:
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


And as I've stumbled onto this recently too, the clock-maintainership has
expanded to Stephen Boyd and linux-clk@vger.kernel.org .


Heiko
