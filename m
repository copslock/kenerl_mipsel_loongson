Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Aug 2012 20:25:07 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:57867 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903289Ab2HaSZA convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 31 Aug 2012 20:25:00 +0200
Received: by pbbrq8 with SMTP id rq8so5547314pbb.36
        for <linux-mips@linux-mips.org>; Fri, 31 Aug 2012 11:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=content-type:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date
         :x-gm-message-state;
        bh=EvfLHmdAsyOkzZPWGLxEMI30MMSzbq300PNFeLOAlr4=;
        b=iRfZ9gFKrVM3n7JU2+ysQMxY9J9bkXdQPoh5VTDKJLo3H4QezMXEImta+Z76BQdv44
         BC9UOV8S36IbDamJLIP7XOXnXY6QkIaO2IiCZmAChVym/rL0L+XBy7QulG63sMmwrhnj
         d3J69ptZ3Wf/cARhtr8ge9MICVL2kdytQaASpZAKHIFpReL29+61WOBmRdTK6zJ6kOEl
         GEW/UoizmRhHh3sLO2PTQkg54h5EpHRr6ogxBGHfQdBpvest6NlR24ygGqfvj+ux1UqL
         nfHEDqWpUMlinhahBop/PhWb4B0Lam+rr2zzL4N/atGQ8OjadN/Yu34AI4T2gOYhZzka
         CS+Q==
Received: by 10.66.73.132 with SMTP id l4mr16742955pav.30.1346437493618;
        Fri, 31 Aug 2012 11:24:53 -0700 (PDT)
Received: from localhost (nsc-e-gw.nsc.com. [12.238.8.30])
        by mx.google.com with ESMTPS id tq4sm3925555pbc.11.2012.08.31.11.24.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2012 11:24:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Kelvin Cheung <keguang.zhang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1345457135-12737-1-git-send-email-keguang.zhang@gmail.com>
Cc:     linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        Kelvin Cheung <keguang.zhang@gmail.com>
References: <1345457135-12737-1-git-send-email-keguang.zhang@gmail.com>
Message-ID: <20120831182437.26807.56140@nucleus>
User-Agent: alot/0.3.2+
Subject: Re: [PATCH v3] clk: add Loongson1B clock support
Date:   Fri, 31 Aug 2012 11:24:37 -0700
X-Gm-Message-State: ALoCoQmuaVzkr+pRst/QE3sIoF0XZ8FLztinLomJYYgbqfs1JGklp60xFyGcttwDNfJkOx+Ozy6d
X-archive-position: 34392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@linaro.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Quoting Kelvin Cheung (2012-08-20 03:05:35)
> This adds clock support to Loongson1B SoC using the common clock
> infrastructure.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

Looks good.  I've taken this into clk-next.

Thanks,
Mike

> ---
>  drivers/clk/Makefile   |    1 +
>  drivers/clk/clk-ls1x.c |  111 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/clk/clk-ls1x.c
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 5869ea3..018ec57 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_ARCH_SOCFPGA)    += socfpga/
>  obj-$(CONFIG_PLAT_SPEAR)       += spear/
>  obj-$(CONFIG_ARCH_U300)                += clk-u300.o
>  obj-$(CONFIG_ARCH_INTEGRATOR)  += versatile/
> +obj-$(CONFIG_MACH_LOONGSON1)   += clk-ls1x.o
>  
>  # Chip specific
>  obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
> diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
> new file mode 100644
> index 0000000..f20b750
> --- /dev/null
> +++ b/drivers/clk/clk-ls1x.c
> @@ -0,0 +1,111 @@
> +/*
> + * Copyright (c) 2012 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +
> +#include <loongson1.h>
> +
> +#define OSC    33
> +
> +static DEFINE_SPINLOCK(_lock);
> +
> +static int ls1x_pll_clk_enable(struct clk_hw *hw)
> +{
> +       return 0;
> +}
> +
> +static void ls1x_pll_clk_disable(struct clk_hw *hw)
> +{
> +}
> +
> +static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
> +                                            unsigned long parent_rate)
> +{
> +       u32 pll, rate;
> +
> +       pll = __raw_readl(LS1X_CLK_PLL_FREQ);
> +       rate = ((12 + (pll & 0x3f)) * 1000000) +
> +               ((((pll >> 8) & 0x3ff) * 1000000) >> 10);
> +       rate *= OSC;
> +       rate >>= 1;
> +
> +       return rate;
> +}
> +
> +static const struct clk_ops ls1x_pll_clk_ops = {
> +       .enable = ls1x_pll_clk_enable,
> +       .disable = ls1x_pll_clk_disable,
> +       .recalc_rate = ls1x_pll_recalc_rate,
> +};
> +
> +static struct clk * __init clk_register_pll(struct device *dev,
> +        const char *name, const char *parent_name, unsigned long flags)
> +{
> +       struct clk_hw *hw;
> +       struct clk *clk;
> +       struct clk_init_data init;
> +
> +       /* allocate the divider */
> +       hw = kzalloc(sizeof(struct clk_hw), GFP_KERNEL);
> +       if (!hw) {
> +               pr_err("%s: could not allocate clk_hw\n", __func__);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       init.name = name;
> +       init.ops = &ls1x_pll_clk_ops;
> +       init.flags = flags | CLK_IS_BASIC;
> +       init.parent_names = (parent_name ? &parent_name : NULL);
> +       init.num_parents = (parent_name ? 1 : 0);
> +       hw->init = &init;
> +
> +       /* register the clock */
> +       clk = clk_register(dev, hw);
> +
> +       if (IS_ERR(clk))
> +               kfree(hw);
> +
> +       return clk;
> +}
> +
> +void __init ls1x_clk_init(void)
> +{
> +       struct clk *clk;
> +
> +       clk = clk_register_pll(NULL, "pll_clk", NULL, CLK_IS_ROOT);
> +       clk_prepare_enable(clk);
> +
> +       clk = clk_register_divider(NULL, "cpu_clk", "pll_clk",
> +                       CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_CPU_SHIFT,
> +                       DIV_CPU_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
> +       clk_prepare_enable(clk);
> +       clk_register_clkdev(clk, "cpu", NULL);
> +
> +       clk = clk_register_divider(NULL, "dc_clk", "pll_clk",
> +                       CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
> +                       DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
> +       clk_prepare_enable(clk);
> +       clk_register_clkdev(clk, "dc", NULL);
> +
> +       clk = clk_register_divider(NULL, "ahb_clk", "pll_clk",
> +                       CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
> +                       DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
> +       clk_prepare_enable(clk);
> +       clk_register_clkdev(clk, "ahb", NULL);
> +       clk_register_clkdev(clk, "stmmaceth", NULL);
> +
> +       clk = clk_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1, 2);
> +       clk_prepare_enable(clk);
> +       clk_register_clkdev(clk, "apb", NULL);
> +       clk_register_clkdev(clk, "serial8250", NULL);
> +}
> -- 
> 1.7.1
