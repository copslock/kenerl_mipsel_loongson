Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 21:44:29 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:54288 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008237AbbFDTo000vAJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 21:44:26 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 376441416AE;
        Thu,  4 Jun 2015 19:44:24 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 2897F1417FF; Thu,  4 Jun 2015 19:44:24 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B43941416AE;
        Thu,  4 Jun 2015 19:44:23 +0000 (UTC)
Date:   Thu, 4 Jun 2015 12:44:22 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Mike Turquette <mturquette@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>, cernekee@chromium.org,
        Govindraj.Raja@imgtec.com, Damien.Horsley@imgtec.com
Subject: Re: [PATCH 1/3] clk: pistachio: Add a pll_lock() helper for clarity
Message-ID: <20150604194422.GF676@codeaurora.org>
References: <1432677669-29581-1-git-send-email-ezequiel.garcia@imgtec.com>
 <1432677669-29581-2-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432677669-29581-2-git-send-email-ezequiel.garcia@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47865
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
> This commit adds a pll_lock() helper making the code more readable.
> Cosmetic change only, no functionality changes.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---

Applied to clk-next.

>  drivers/clk/pistachio/clk-pll.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/pistachio/clk-pll.c b/drivers/clk/pistachio/clk-pll.c
> index de53756..9ce1be7 100644
> --- a/drivers/clk/pistachio/clk-pll.c
> +++ b/drivers/clk/pistachio/clk-pll.c
> @@ -67,6 +67,12 @@ static inline void pll_writel(struct pistachio_clk_pll *pll, u32 val, u32 reg)
>  	writel(val, pll->base + reg);
>  }
>  
> +static inline void pll_lock(struct pistachio_clk_pll *pll)
> +{
> +	while (!(pll_readl(pll, PLL_STATUS) & PLL_STATUS_LOCK))
> +		cpu_relax();

The patch is fine, but I wonder if we shouldn't have a timeout
here in case the PLL fails to lock.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
