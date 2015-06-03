Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 01:37:37 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:44831 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008094AbbFCXhc0c94H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 01:37:32 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E23D1141761;
        Wed,  3 Jun 2015 23:37:29 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id D0A38141770; Wed,  3 Jun 2015 23:37:29 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06F39141761;
        Wed,  3 Jun 2015 23:37:28 +0000 (UTC)
Date:   Wed, 3 Jun 2015 16:37:28 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     Mike Turquette <mturquette@linaro.org>, linux-clk@vger.kernel.org,
        Mikko Perttunen <mikko.perttunen@kapsi.fi>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Tony Lindgren <tony@atomide.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Emilio L??pez <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Tero Kristo <t-kristo@ti.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v3] clk: change clk_ops' ->determine_rate() prototype
Message-ID: <20150603233728.GA490@codeaurora.org>
References: <1432138345-19044-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1432138345-19044-1-git-send-email-boris.brezillon@free-electrons.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47834
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

On 05/20, Boris Brezillon wrote:
> Clock rates are stored in an unsigned long field, but ->determine_rate()
> (which returns a rounded rate from a requested one) returns a long
> value (errors are reported using negative error codes), which can lead
> to long overflow if the clock rate exceed 2Ghz.
> 
> Change ->determine_rate() prototype to return 0 or an error code, and pass
> a pointer to a clk_rate_request structure containing the expected target
> rate and the rate constraints imposed by clk users.
> 
> The clk_rate_request structure might be extended in the future to contain
> other kind of constraints like the rounding policy, the maximum clock
> inaccuracy or other things that are not yet supported by the CCF
> (power consumption constraints ?).
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> CC: Jonathan Corbet <corbet@lwn.net>
> CC: Tony Lindgren <tony@atomide.com>
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: "Emilio López" <emilio@elopez.com.ar>
> CC: Maxime Ripard <maxime.ripard@free-electrons.com>
> CC: Tero Kristo <t-kristo@ti.com>
> CC: linux-doc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-omap@vger.kernel.org
> CC: linux-mips@linux-mips.org
> ---
> 
> Hi Stephen,
> 
> This patch is based on clk-next and contains the changes you suggested
> in your previous review.
> 
> It was tested on sama5d4 and compile tested on several ARM platforms
> (those enabled in multi_v7_defconfig).
> 

Thanks. I think we should wait until the next -rc1 drops to apply the
patch for the next merge window. That will make it least likely to conflict
with other trees, and we can provide it on a stable branch should there
be clock providers going through other trees somewhere. Please
remind me if I forget.

> @@ -1186,15 +1191,21 @@ EXPORT_SYMBOL_GPL(__clk_determine_rate);
>   */
>  unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
>  {
> -	unsigned long min_rate;
> -	unsigned long max_rate;
> +
> +	struct clk_rate_request req;
> +	int ret;
>  
>  	if (!clk)
>  		return 0;
>  
> -	clk_core_get_boundaries(clk->core, &min_rate, &max_rate);
> +	clk_core_get_boundaries(clk->core, &req.min_rate, &req.max_rate);
> +	req.rate = rate;
> +
> +	ret = clk_core_round_rate_nolock(clk->core, &req);
> +	if (ret)
> +		return ret;

This returns a negative int for unsigned long. Is that intentional?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
