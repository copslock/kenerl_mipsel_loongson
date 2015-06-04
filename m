Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 21:47:43 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:54381 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008237AbbFDTrkxcVhJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 21:47:40 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6D000141810;
        Thu,  4 Jun 2015 19:47:38 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 5C46714181B; Thu,  4 Jun 2015 19:47:38 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17016141810;
        Thu,  4 Jun 2015 19:47:36 +0000 (UTC)
Date:   Thu, 4 Jun 2015 12:47:36 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Mike Turquette <mturquette@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>, cernekee@chromium.org,
        Govindraj.Raja@imgtec.com, Damien.Horsley@imgtec.com
Subject: Re: [PATCH 2/3] clk: pistachio: Lock the PLL when enabled upon rate
 change
Message-ID: <20150604194736.GG676@codeaurora.org>
References: <1432677669-29581-1-git-send-email-ezequiel.garcia@imgtec.com>
 <1432677669-29581-3-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432677669-29581-3-git-send-email-ezequiel.garcia@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47866
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

On 05/26, Ezequiel Garcia wrote:
> Currently, when the rate is changed, the driver makes sure the
> PLL is enabled before doing so. This is done because the PLL
> cannot be locked while disabled. Once locked, the drivers
> returns the PLL to its previous enable/disable state.
> 
> This is a bit cumbersome, and can be simplified.
> 
> This commit reworks the .set_rate() functions for the integer
> and fractional PLLs. Upon rate change, the PLL is now locked
> only if it's already enabled.
> 
> Also, the driver locks the PLL on .enable(). This makes sure
> the PLL is locked when enabled, and not locked when disabled.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---
>  drivers/clk/pistachio/clk-pll.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/clk/pistachio/clk-pll.c b/drivers/clk/pistachio/clk-pll.c
> index 9ce1be7..f12d520 100644
> --- a/drivers/clk/pistachio/clk-pll.c
> +++ b/drivers/clk/pistachio/clk-pll.c
> @@ -130,6 +130,8 @@ static int pll_gf40lp_frac_enable(struct clk_hw *hw)
>  	val &= ~PLL_FRAC_CTRL4_BYPASS;
>  	pll_writel(pll, val, PLL_CTRL4);
>  
> +	pll_lock(pll);
> +
>  	return 0;
>  }
>  
> @@ -155,17 +157,13 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
>  {
>  	struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
>  	struct pistachio_pll_rate_table *params;
> -	bool was_enabled;
> +	int enabled = pll_gf40lp_frac_is_enabled(hw);

Is there any sort of spinlock here so that we protect the
sleeping set_rate() path against the non-sleeping enable/disable
path?  There should be a spinlock of some kind to prevent that,
or the enable/disable for the PLL should move to
prepare/unprepare so that we can't disable the PLL in the middle
of a rate switch.

This is an existing problem though, so I applied this to clk-next
anyway.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
