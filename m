Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Apr 2016 01:14:39 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:41103 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027291AbcDVXOg06C0z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Apr 2016 01:14:36 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 489CC612F2;
        Fri, 22 Apr 2016 23:14:34 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 35452612ED; Fri, 22 Apr 2016 23:14:34 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89E2A60CF5;
        Fri, 22 Apr 2016 23:14:33 +0000 (UTC)
Date:   Fri, 22 Apr 2016 16:14:32 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Binbin Zhou <zhoubb@lemote.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Chunbo Cui <cuicb@lemote.com>, Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH v3 5/8] MIPS: Loongson-1A: Workaround for pll register
 can't be read
Message-ID: <20160422231432.GE13149@codeaurora.org>
References: <1456793296-17120-1-git-send-email-zhoubb@lemote.com>
 <1456793296-17120-6-git-send-email-zhoubb@lemote.com>
 <20160404072925.GD13706@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160404072925.GD13706@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53221
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

On 04/04, Ralf Baechle wrote:
> On Tue, Mar 01, 2016 at 08:48:13AM +0800, Binbin Zhou wrote:
> > diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
> > index 97d8c01..a5bb1eb 100644
> > --- a/arch/mips/loongson32/common/platform.c
> > +++ b/arch/mips/loongson32/common/platform.c
> > @@ -63,9 +63,14 @@ struct platform_device ls1x_uart_pdev = {
> >  
> >  void __init ls1x_serial_setup(struct platform_device *pdev)
> >  {
> > -	struct clk *clk;
> >  	struct plat_serial8250_port *p;
> >  
> > +#ifdef CONFIG_CPU_LOONGSON1A
> > +	for (p = pdev->dev.platform_data; p->flags != 0; ++p)
> > +		p->uartclk = ls1a_osc_clk * 2;
> > +#else
> > +	struct clk *clk;
> > +
> >  	clk = clk_get(&pdev->dev, pdev->name);
> >  	if (IS_ERR(clk)) {
> >  		pr_err("unable to get %s clock, err=%ld",
> > @@ -76,6 +81,7 @@ void __init ls1x_serial_setup(struct platform_device *pdev)
> >  
> >  	for (p = pdev->dev.platform_data; p->flags != 0; ++p)
> >  		p->uartclk = clk_get_rate(clk);
> > +#endif

I don't understand this change. Does the framework not work well
enough to tell us the uart clk rate?

> >  }
> >  
> >  /* CPUFreq */
> > diff --git a/arch/mips/loongson32/common/time.c b/arch/mips/loongson32/common/time.c
> > index 0996b02..bba1c84 100644
> > --- a/arch/mips/loongson32/common/time.c
> > +++ b/arch/mips/loongson32/common/time.c
> > @@ -235,3 +235,19 @@ void __init plat_time_init(void)
> >  	mips_hpt_frequency = clk_get_rate(clk) / 2;
> >  #endif /* CONFIG_CEVT_CSRC_LS1X */
> >  }
> > +
> > +#ifdef CONFIG_CPU_LOONGSON1A
> > +unsigned int ls1a_osc_clk = 0, ls1a_cpu_mul = 0;
> > +
> > +static int __init get_cpu_clk(char *string)

Maybe name this function loongson_get_cpu_clk()?

> > diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
> > index d4c6198..18326fb 100644
> > --- a/drivers/clk/clk-ls1x.c
> > +++ b/drivers/clk/clk-ls1x.c
> > @@ -32,6 +32,14 @@ static void ls1x_pll_clk_disable(struct clk_hw *hw)
> >  static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
> >  					  unsigned long parent_rate)
> >  {
> > +#ifdef CONFIG_CPU_LOONGSON1A
> > +	/* workaround, loongson 1A pll register can't be read,
> > +	 * on gateway board, multi is set to 11 */
> > +	if (ls1a_osc_clk != 0 && ls1a_cpu_mul != 0)
> > +		return ls1a_osc_clk * ls1a_cpu_mul;
> > +	else
> > +		return 33333333 * 8;
> > +#else
> >  	u32 pll, rate;
> >  
> >  	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
> > @@ -40,6 +48,7 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
> >  	rate >>= 1;
> >  
> >  	return rate;
> > +#endif
> >  }
> >  
> >  static const struct clk_ops ls1x_pll_clk_ops = {
> > @@ -107,7 +116,8 @@ void __init ls1x_clk_init(void)

Any reason we can't pass the rates to this function?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
