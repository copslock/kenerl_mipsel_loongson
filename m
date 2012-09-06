Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2012 19:13:15 +0200 (CEST)
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:50171 "EHLO
        na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903465Ab2IFRNK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2012 19:13:10 +0200
Received: from mail-ie0-f177.google.com ([209.85.223.177]) (using TLSv1) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
        ID DSNKUEjZpAWQbsLU9J3fv3n28hA5U6YwOcwd@postini.com; Thu, 06 Sep 2012 10:13:09 PDT
Received: by ieje10 with SMTP id e10so3590755iej.36
        for <linux-mips@linux-mips.org>; Thu, 06 Sep 2012 10:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=5ClK+hX6l1HeNUgLO+VPyPp9s7jRkbXGdBmmBY3h6Ls=;
        b=hpAY6jgMKeVPVeETHwCuqiVL7j2ENpbclvtr5NRhJS7IMinfjuvuegH00HCLO87QRa
         0vwUWQmpJ1KmrHvpTptA5l9jPqNAERlZD9e+tCcBvx4dFVCFspVcsbSkH8lH6eKld4z8
         ijoLGcpm8hvEvN8wTerPl4jBbSb2jGXVlTDgdJDx4SfefS9v6xePxw0QPnUPGMTcqciw
         h2ZytGCG9DVSEme0MgidS2LzMaEjctwMkRj996OSS03VZWFTJ5YFPez8Nz8FfLCmrMeK
         8RTJK6AW+Mqo0RF4h6LNLYRi2a1WfjcCASCKkYrOPEcYG4rN4E/YM4pgd775ESwGesfx
         IJ4w==
Received: by 10.42.39.197 with SMTP id i5mr3292039ice.27.1346951587596; Thu,
 06 Sep 2012 10:13:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.220.163 with HTTP; Thu, 6 Sep 2012 10:12:47 -0700 (PDT)
In-Reply-To: <CAJhJPsVd_XM2QJnU7teQc4JCEPzp3e-YU5vTvW4Twzs9d--0FA@mail.gmail.com>
References: <1345287301-18165-1-git-send-email-keguang.zhang@gmail.com>
 <CAAfyv36-wwvSFJGXN9bmDy8pdDOT_h0b7sy78+7f4kCW57AxuA@mail.gmail.com> <CAJhJPsVd_XM2QJnU7teQc4JCEPzp3e-YU5vTvW4Twzs9d--0FA@mail.gmail.com>
From:   "Turquette, Mike" <mturquette@ti.com>
Date:   Thu, 6 Sep 2012 10:12:47 -0700
Message-ID: <CAJOA=zMtjwgyEtz_P_LAFnGkDCd7dUD9e2PxZFtuqme9D5w0fQ@mail.gmail.com>
Subject: Re: [PATCH] clk: add Loongson1B clock support
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     Belisko Marek <marek.belisko@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQmau7qU8/bzdgxPN0dlVN9BDxpbigeEI+x0qKU7sTFJkZw7/PTpbEeu+3TYX6soeEPMYxA+
X-archive-position: 34439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@ti.com
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

On Sat, Aug 18, 2012 at 4:54 AM, Kelvin Cheung <keguang.zhang@gmail.com> wrote:
>
> 2012/8/18 Belisko Marek <marek.belisko@gmail.com>
>>
>> On Sat, Aug 18, 2012 at 12:55 PM, Kelvin Cheung <keguang.zhang@gmail.com> wrote:
>> > This adds clock support to Loongson1B SoC using the common clock
>> > infrastructure.
>> >
>> > Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
>> > ---
>> >  drivers/clk/Makefile   |    1 +
>> >  drivers/clk/clk-ls1x.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++
>> >  2 files changed, 109 insertions(+), 0 deletions(-)
>> >  create mode 100644 drivers/clk/clk-ls1x.c
>> >
>> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>> > index 5869ea3..018ec57 100644
>> > --- a/drivers/clk/Makefile
>> > +++ b/drivers/clk/Makefile
>> > @@ -10,6 +10,7 @@ obj-$(CONFIG_ARCH_SOCFPGA)    += socfpga/
>> >  obj-$(CONFIG_PLAT_SPEAR)       += spear/
>> >  obj-$(CONFIG_ARCH_U300)                += clk-u300.o
>> >  obj-$(CONFIG_ARCH_INTEGRATOR)  += versatile/
>> > +obj-$(CONFIG_MACH_LOONGSON1)   += clk-ls1x.o
>> >
>> >  # Chip specific
>> >  obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
>> > diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
>> > new file mode 100644
>> > index 0000000..0aadf9d
>> > --- /dev/null
>> > +++ b/drivers/clk/clk-ls1x.c
>> > @@ -0,0 +1,108 @@
>> > +/*
>> > + * Copyright (c) 2012 Zhang, Keguang <keguang.zhang@gmail.com>
>> > + *
>> > + * This program is free software; you can redistribute  it and/or modify it
>> > + * under  the terms of  the GNU General  Public License as published by the
>> > + * Free Software Foundation;  either version 2 of the  License, or (at your
>> > + * option) any later version.
>> > + */
>> > +
>> > +#include <linux/clkdev.h>
>> > +#include <linux/clk-provider.h>
>> > +#include <linux/io.h>
>> > +#include <linux/slab.h>
>> > +#include <linux/err.h>
>> > +#include <asm/mach-loongson1/loongson1.h>
>> > +
>> > +#include <loongson1.h>
>> > +
>> > +#define OSC    33
>> > +
>> > +static DEFINE_SPINLOCK(_lock);
>> > +
>> > +int ls1x_pll_clk_enable(struct clk_hw *hw)
>> ^^^^static
>
>
> OK, will do.
> Thanks!
>

Hi Kelvin,

I've already taken the above patch for loongson1b common clk support
into clk-next.  Can you submit a fixup patch and I'll just apply the
fix to the tip of the branch.  I'm trying to avoid rebases this late
in the cycle.

Thanks,
Mike

>>
>> > +{
>> > +       return 0;
>> > +}
>> > +
>> > +void ls1x_pll_clk_disable(struct clk_hw *hw)
>> ^^^^ also static
>> > +{
>> > +}
>> > +
>> > +static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
>> > +                                            unsigned long parent_rate)
>> > +{
>> > +       u32 pll, rate;
>> > +
>> > +       pll = __raw_readl(LS1X_CLK_PLL_FREQ);
>> > +       rate = ((12 + (pll & 0x3f)) * 1000000) +
>> > +               ((((pll >> 8) & 0x3ff) * 1000000) >> 10);
>> > +       rate *= OSC;
>> > +       rate >>= 1;
>> > +
>> > +       return rate;
>> > +}
>> > +
>> > +static const struct clk_ops ls1x_pll_clk_ops = {
>> > +       .enable = ls1x_pll_clk_enable,
>> > +       .disable = ls1x_pll_clk_disable,
>> > +       .recalc_rate = ls1x_pll_recalc_rate,
>> > +};
>> > +
>> > +static struct clk * __init clk_register_pll(struct device *dev,
>> > +        const char *name, const char *parent_name, unsigned long flags)
>> > +{
>> > +       struct clk_hw *hw;
>> > +       struct clk *clk;
>> > +       struct clk_init_data init;
>> > +
>> > +       /* allocate the divider */
>> > +       hw = kzalloc(sizeof(struct clk_hw), GFP_KERNEL);
>> > +       if (!hw) {
>> > +               pr_err("%s: could not allocate clk_hw\n", __func__);
>> > +               return ERR_PTR(-ENOMEM);
>> > +       }
>> > +
>> > +       init.name = name;
>> > +       init.ops = &ls1x_pll_clk_ops;
>> > +       init.flags = flags | CLK_IS_BASIC;
>> > +       init.parent_names = (parent_name ? &parent_name : NULL);
>> > +       init.num_parents = (parent_name ? 1 : 0);
>> > +       hw->init = &init;
>> > +
>> > +       /* register the clock */
>> > +       clk = clk_register(dev, hw);
>> > +
>> > +       if (IS_ERR(clk))
>> > +               kfree(hw);
>> > +
>> > +       return clk;
>> > +}
>> > +
>> > +void __init ls1x_clk_init(void)
>> > +{
>> > +       struct clk *clk;
>> > +
>> > +       clk = clk_register_pll(NULL, "pll_clk", NULL, CLK_IS_ROOT);
>> > +       clk_prepare_enable(clk);
>> > +
>> > +       clk = clk_register_divider(NULL, "cpu_clk", "pll_clk",
>> > +                       CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_CPU_SHIFT,
>> > +                       DIV_CPU_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
>> > +       clk_prepare_enable(clk);
>> > +       clk_register_clkdev(clk, "cpu", NULL);
>> > +
>> > +       clk = clk_register_divider(NULL, "ddr_clk", "pll_clk",
>> > +                       CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
>> > +                       DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
>> > +       clk_prepare_enable(clk);
>> > +       clk_register_clkdev(clk, "ddr", NULL);
>> > +       clk_register_clkdev(clk, "stmmaceth", NULL);
>> > +
>> > +       clk = clk_register_divider(NULL, "dc_clk", "pll_clk",
>> > +                       CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
>> > +                       DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
>> > +       clk_prepare_enable(clk);
>> > +       clk_register_clkdev(clk, "dc", NULL);
>> > +       clk_register_clkdev(clk, "serial8250", NULL);
>> > +}
>> > --
>> > 1.7.1
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > Please read the FAQ at  http://www.tux.org/lkml/
>>
>> cheers,
>>
>> marek
>>
>> --
>> as simple and primitive as possible
>> -------------------------------------------------
>> Marek Belisko - OPEN-NANDRA
>> Freelance Developer
>>
>> Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
>> Tel: +421 915 052 184
>> skype: marekwhite
>> twitter: #opennandra
>> web: http://open-nandra.com
>
>
>
>
> --
> Best Regards!
> Kelvin
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
