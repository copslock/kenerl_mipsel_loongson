Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 22:44:43 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.11.231]:36305 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011000AbaJIUoljJOUs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 22:44:41 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A46B613F969;
        Thu,  9 Oct 2014 20:44:34 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 88CCE13F972; Thu,  9 Oct 2014 20:44:34 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1127A13F969;
        Thu,  9 Oct 2014 20:44:34 +0000 (UTC)
Date:   Thu, 9 Oct 2014 13:44:33 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Mike Turquette <mturquette@linaro.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Jiri Kosina <jkosina@suse.cz>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Matt Porter <mporter@linaro.org>,
        Tim Kryger <tim.kryger@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/8] clk: Change clk_ops->determine_rate to return a
 clk_hw as the best parent
Message-ID: <20141009204433.GE5493@codeaurora.org>
References: <1412866903-6970-1-git-send-email-tomeu.vizoso@collabora.com>
 <1412866903-6970-7-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412866903-6970-7-git-send-email-tomeu.vizoso@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43167
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

On 10/09, Tomeu Vizoso wrote:
> @@ -946,6 +946,7 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
>  {
>  	unsigned long parent_rate = 0;
>  	struct clk *parent;
> +	struct clk_hw *parent_hw;
>  
>  	if (!clk)
>  		return 0;
> @@ -956,7 +957,7 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
>  
>  	if (clk->ops->determine_rate)
>  		return clk->ops->determine_rate(clk->hw, rate, &parent_rate,
> -						&parent);
> +						&parent_hw);

We should assign the value of parent_hw somewhere here so that
drivers don't need to if they want the current parent. This would
match the current behavior where parent is already assigned the
current parent.

>  	else if (clk->ops->round_rate)
>  		return clk->ops->round_rate(clk->hw, rate, &parent_rate);
>  	else if (clk->flags & CLK_SET_RATE_PARENT)
> @@ -1345,6 +1346,7 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
>  {
>  	struct clk *top = clk;
>  	struct clk *old_parent, *parent;
> +	struct clk_hw *parent_hw;
>  	unsigned long best_parent_rate = 0;
>  	unsigned long new_rate;
>  	int p_index = 0;
> @@ -1362,7 +1364,8 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
>  	if (clk->ops->determine_rate) {
>  		new_rate = clk->ops->determine_rate(clk->hw, rate,
>  						    &best_parent_rate,
> -						    &parent);
> +						    &parent_hw);
> +		parent = parent_hw->clk;

Same comment here.

>  	} else if (clk->ops->round_rate) {
>  		new_rate = clk->ops->round_rate(clk->hw, rate,
>  						&best_parent_rate);
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
