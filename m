Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2015 01:02:31 +0200 (CEST)
Received: from utopia.booyaka.com ([74.50.51.50]:50271 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008122AbbFDXC3KtuZw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jun 2015 01:02:29 +0200
Received: (qmail 21415 invoked by uid 1019); 4 Jun 2015 23:02:25 -0000
Date:   Thu, 4 Jun 2015 23:02:25 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
cc:     Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        ascha Hauer <kernel@pengutronix.de>,
        David Brown <davidb@codeaurora.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Viresh Kumar <viresh.linux@gmail.com>,
        =?ISO-8859-15?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>,
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
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mips@linux-mips.org, patches@opensource.wolfsonmicro.com,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, spear-devel@list.st.com,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH v2 1/2] clk: change clk_ops' ->round_rate() prototype
In-Reply-To: <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <alpine.DEB.2.02.1506042258530.12316@utopia.booyaka.com>
References: <1430407809-31147-1-git-send-email-boris.brezillon@free-electrons.com> <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Return-Path: <paul@pwsan.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@pwsan.com
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

Hi folks

just a brief comment on this one:

On Thu, 30 Apr 2015, Boris Brezillon wrote:

> Clock rates are stored in an unsigned long field, but ->round_rate()
> (which returns a rounded rate from a requested one) returns a long
> value (errors are reported using negative error codes), which can lead
> to long overflow if the clock rate exceed 2Ghz.
> 
> Change ->round_rate() prototype to return 0 or an error code, and pass the
> requested rate as a pointer so that it can be adjusted depending on
> hardware capabilities.

...

> diff --git a/Documentation/clk.txt b/Documentation/clk.txt
> index 0e4f90a..fca8b7a 100644
> --- a/Documentation/clk.txt
> +++ b/Documentation/clk.txt
> @@ -68,8 +68,8 @@ the operations defined in clk.h:
>  		int		(*is_enabled)(struct clk_hw *hw);
>  		unsigned long	(*recalc_rate)(struct clk_hw *hw,
>  						unsigned long parent_rate);
> -		long		(*round_rate)(struct clk_hw *hw,
> -						unsigned long rate,
> +		int		(*round_rate)(struct clk_hw *hw,
> +						unsigned long *rate,
>  						unsigned long *parent_rate);
>  		long		(*determine_rate)(struct clk_hw *hw,
>  						unsigned long rate,

I'd suggest that we should probably go straight to 64-bit rates.  There 
are already plenty of clock sources that can generate rates higher than 
4GiHz.


- Paul
