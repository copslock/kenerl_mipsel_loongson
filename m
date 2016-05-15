Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 May 2016 09:03:23 +0200 (CEST)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35168 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27028323AbcEOHDT31Qtn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 May 2016 09:03:19 +0200
Received: by mail-pa0-f67.google.com with SMTP id zy2so13961116pac.2
        for <linux-mips@linux-mips.org>; Sun, 15 May 2016 00:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mz+n4RjgY0FpbZYaAhEqF4pQNj8MbujB1awoD9brABQ=;
        b=sv5Y5edlXgRMoPR3sSupHdFK3g3Ufj/Xq5xDusPSiFUMmZX6xc7SdejA88KFmevjPj
         4dA4EsVjM1MEw7GvEklf3h7tSDmob9pgcqS0LJIWtY6wZFeIlXK9RCXtf1hUcsaHfhh4
         OWaMNWZxDejCXcSHsYHTqAKUDcx8j1sUmAjSwB3QyKomlolBttIh0pGVAOzBybDmjuJc
         8f2qYbAtPae88bwMx3+OASwQeXdqIxh5Nj29TFgFpLkaySQrv6Z6/aZeO/JrQZrg2GqP
         UIataN/+1RL1D3WyHOXkRV8duj+1OCELhHSVioll9kC1rCdHIBvJJmrpoWcYhhrafJSP
         91bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mz+n4RjgY0FpbZYaAhEqF4pQNj8MbujB1awoD9brABQ=;
        b=EfLMkdISONQ9LHVXCWDqq81zQ2rg1G94zHgOlRmPvzzzbL/auB0ON/ZpOK6+nLGMnE
         FfBwRri/+DlGP83n3TlwwLS7riagt5J7sQjud7H134FUo1XKiCVwBix+Z2iE2bwgZe0V
         oWyEdSrfTXD18cvbls3oIGjKYYoO/HtvvS24QDVa37GnF1wQEiUTGPtloMoEsGhfMMw4
         AYSe1HICO8xuZKO77K4hytVfvgmVhKLMNsJBbw36sT4WKmk4K1Pp9mICA6wmTRGt/GiM
         klXWKe762HTtmLa7criOkQLo5ahSmpacGeraj+AY1Mcd7hDWN05N5OHc7hus/XSWtqUk
         5hgQ==
X-Gm-Message-State: AOPr4FUxg/ofHq1YewEBJ6HWcEf/1Um3ndvuluTYt2mZfvBN/mQzA0wosl762pjRUFONzQ==
X-Received: by 10.66.183.168 with SMTP id en8mr27732424pac.64.1463295793174;
        Sun, 15 May 2016 00:03:13 -0700 (PDT)
Received: from ubuntu (li759-126.members.linode.com. [106.185.46.126])
        by smtp.gmail.com with ESMTPSA id b140sm38651988pfb.19.2016.05.15.00.03.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 15 May 2016 00:03:11 -0700 (PDT)
From:   Yang Ling <gnaygnil@gmail.com>
X-Google-Original-From: Yang Ling <gnaygnail@gmail.com>
Date:   Sun, 15 May 2016 15:03:04 +0800
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/4] clk: add Loongson1C clock support
Message-ID: <20160515070302.GA99380@ubuntu>
References: <1463043564-21559-1-git-send-email-gnaygnil@gmail.com>
 <CAJhJPsV9HN=sgkg59ZvKiQ73ZmwRdZwQGvhwwf38jBzW7zUh+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhJPsV9HN=sgkg59ZvKiQ73ZmwRdZwQGvhwwf38jBzW7zUh+g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

On Thu, May 12, 2016 at 06:01:57PM +0800, Kelvin Cheung wrote:
> Hi Ling,
> The file clk-ls1x.c will be renamed to clk-loongson1.c.
> You'd better rebase your changes base on the following patch.
> https://patchwork.linux-mips.org/patch/13035/
> 
> 2016-05-12 16:59 GMT+08:00 Yang Ling <gnaygnil@gmail.com>:
> 
> > This adds clock support to Loongson1C SoC using the common clock
> > infrastructure.
> >
> > Signed-off-by: Yang Ling <gnaygnil@gmail.com>
> > ---
> >  arch/mips/include/asm/mach-loongson32/regs-clk.h | 33 ++++++++++++
> >  drivers/clk/clk-ls1x.c                           | 69
> > +++++++++++++++++++++---
> >  2 files changed, 95 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/mips/include/asm/mach-loongson32/regs-clk.h
> > b/arch/mips/include/asm/mach-loongson32/regs-clk.h
> > index 1f5a715..2cef0e2 100644
> > --- a/arch/mips/include/asm/mach-loongson32/regs-clk.h
> > +++ b/arch/mips/include/asm/mach-loongson32/regs-clk.h
> > @@ -1,5 +1,7 @@
> >  /*
> >   * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
> > + * Copyright (c) 2015 Tang Haifeng <tanghaifeng-gz@loongson.cn>
> > + * Copyright (c) 2016 Ling Yang <gnaygnil@gmail.com>
> >   *
> >   * Loongson 1 Clock Register Definitions.
> >   *
> > @@ -19,6 +21,7 @@
> >  #define LS1X_CLK_PLL_DIV               LS1X_CLK_REG(0x4)
> >
> >  /* Clock PLL Divisor Register Bits */
> > +#if defined(CONFIG_LOONGSON1_LS1B)
> >  #define DIV_DC_EN                      (0x1 << 31)
> >  #define DIV_DC_RST                     (0x1 << 30)
> >  #define DIV_CPU_EN                     (0x1 << 25)
> > @@ -48,4 +51,34 @@
> >  #define BYPASS_DDR_WIDTH               1
> >  #define BYPASS_CPU_WIDTH               1
> >
> > +#elif defined(CONFIG_LOONGSON1_LS1C)
> > +
> > +#define PLL_VALID                      (0x1 << 31)
> > +#define FRAC_N                         (0xff << 16)
> > +#define RST_TIME                       (0x3 << 2)
> > +#define SDRAM_DIV                      (0x3 << 0)
> > +
> > +#define DIV_DC_EN                      (0x1 << 31)
> > +#define DIV_DC                         (0x7f << 24)
> > +#define DIV_CAM_EN                     (0x1 << 23)
> > +#define DIV_CAM                                (0x7f << 16)
> > +#define DIV_CPU_EN                     (0x1 << 15)
> > +#define DIV_CPU                                (0x7f << 8)
> > +#define DIV_DC_SEL_EN                  (0x1 << 5)
> > +#define DIV_DC_SEL                     (0x1 << 4)
> > +#define DIV_CAM_SEL_EN                 (0x1 << 3)
> > +#define DIV_CAM_SEL                    (0x1 << 2)
> > +#define DIV_CPU_SEL_EN                 (0x1 << 1)
> > +#define DIV_CPU_SEL                    (0x1 << 0)
> > +
> > +#define DIV_DC_SHIFT                    24
> > +#define DIV_CAM_SHIFT                   16
> > +#define DIV_CPU_SHIFT                   8
> > +
> > +#define DIV_DC_WIDTH                    7
> > +#define DIV_CPU_WIDTH                   7
> > +#define DIV_DDR_WIDTH                   7
> > +
> > +#endif
> > +
> >  #endif /* __ASM_MACH_LOONGSON32_REGS_CLK_H */
> > diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
> > index d4c6198..746e653 100644
> > --- a/drivers/clk/clk-ls1x.c
> > +++ b/drivers/clk/clk-ls1x.c
> > @@ -1,5 +1,7 @@
> >  /*
> >   * Copyright (c) 2012 Zhang, Keguang <keguang.zhang@gmail.com>
> > + * Copyright (c) 2015 Tang Haifeng <tanghaifeng-gz@loongson.cn>
> > + * Copyright (c) 2016 Ling Yang <gnaygnil@gmail.com>
> >   *
> >   * This program is free software; you can redistribute  it and/or modify
> > it
> >   * under  the terms of  the GNU General  Public License as published by
> > the
> > @@ -15,8 +17,13 @@
> >
> >  #include <loongson1.h>
> >
> > +#if defined(CONFIG_LOONGSON1_LS1B)
> >  #define OSC            (33 * 1000000)
> >  #define DIV_APB                2
> > +#elif defined(CONFIG_LOONGSON1_LS1C)
> > +#define OSC            (24 * 1000000)
> > +#define DIV_APB                1
> > +#endif
> >
> >  static DEFINE_SPINLOCK(_lock);
> >
> > @@ -35,9 +42,15 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw
> > *hw,
> >         u32 pll, rate;
> >
> >         pll = __raw_readl(LS1X_CLK_PLL_FREQ);
> > +#if defined(CONFIG_LOONGSON1_LS1B)
> >         rate = 12 + (pll & 0x3f) + (((pll >> 8) & 0x3ff) >> 10);
> >         rate *= OSC;
> >         rate >>= 1;
> > +#elif defined(CONFIG_LOONGSON1_LS1C)
> > +       rate = ((pll >> 8) & 0xff) + ((pll >> 16) & 0xff);
> > +       rate *= OSC;
> > +       rate >>= 2;
> > +#endif
> >
> >         return rate;
> >  }
> > @@ -80,22 +93,25 @@ static struct clk *__init clk_register_pll(struct
> > device *dev,
> >         return clk;
> >  }
> >
> > -static const char * const cpu_parents[] = { "cpu_clk_div", "osc_33m_clk",
> > };
> > -static const char * const ahb_parents[] = { "ahb_clk_div", "osc_33m_clk",
> > };
> > -static const char * const dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
> > +static const char * const cpu_parents[] = { "cpu_clk_div", "osc_clk", };
> > +static const char * const ahb_parents[] = { "ahb_clk_div", "osc_clk", };
> > +static const char * const dc_parents[] = { "dc_clk_div", "osc_clk", };
> >
> >  void __init ls1x_clk_init(void)
> >  {
> >         struct clk *clk;
> > +       u32 reg;
> > +       u32 div;
> >
> > -       clk = clk_register_fixed_rate(NULL, "osc_33m_clk", NULL,
> > CLK_IS_ROOT,
> > +       clk = clk_register_fixed_rate(NULL, "osc_clk", NULL, CLK_IS_ROOT,
> >                                       OSC);
> > -       clk_register_clkdev(clk, "osc_33m_clk", NULL);
> > +       clk_register_clkdev(clk, "osc_clk", NULL);
> >
> > -       /* clock derived from 33 MHz OSC clk */
> > -       clk = clk_register_pll(NULL, "pll_clk", "osc_33m_clk", 0);
> > +       /* clock derived from OSC clk */
> > +       clk = clk_register_pll(NULL, "pll_clk", "osc_clk", 0);
> >         clk_register_clkdev(clk, "pll_clk", NULL);
> >
> > +#if defined(CONFIG_LOONGSON1_LS1B)
> >         /* clock derived from PLL clk */
> >         /*                                 _____
> >          *         _______________________|     |
> > @@ -114,7 +130,23 @@ void __init ls1x_clk_init(void)
> >                                CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
> >                                BYPASS_CPU_SHIFT, BYPASS_CPU_WIDTH, 0,
> > &_lock);
> >         clk_register_clkdev(clk, "cpu_clk", NULL);
> > +#elif defined(CONFIG_LOONGSON1_LS1C)
> > +       reg = __raw_readl(LS1X_CLK_PLL_DIV);
> > +       if (reg & DIV_CPU_SEL) {
> > +               if (reg & DIV_CPU_EN) {
> > +                       clk = clk_register_divider(NULL, "cpu_clk",
> > "pll_clk",
> > +                                       CLK_SET_RATE_PARENT,
> > LS1X_CLK_PLL_DIV,
> > +                                       DIV_CPU_SHIFT, DIV_CPU_WIDTH,
> > +                                       CLK_DIVIDER_ONE_BASED, &_lock);
> > +               } else {
> > +                       clk = clk_register_fixed_factor(NULL, "cpu_clk",
> > +                                                       "pll_clk", 0, 1,
> > 2);
> > +               }
> > +       }
> > +       clk_register_clkdev(clk, "cpu_clk", NULL);
> > +#endif
> >
> > +#if defined(CONFIG_LOONGSON1_LS1B)
> >         /*                                 _____
> >          *         _______________________|     |
> >          * OSC ___/                       | MUX |___ DC  CLK
> > @@ -130,7 +162,14 @@ void __init ls1x_clk_init(void)
> >                                CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
> >                                BYPASS_DC_SHIFT, BYPASS_DC_WIDTH, 0,
> > &_lock);
> >         clk_register_clkdev(clk, "dc_clk", NULL);
> > +#elif defined(CONFIG_LOONGSON1_LS1C)
> > +       clk = clk_register_divider(NULL, "dc_clk", "pll_clk",
> > +                       CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV,
> > DIV_DC_SHIFT,
> > +                       DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
> > +       clk_register_clkdev(clk, "dc_clk", NULL);
> > +#endif
> >
> > +#if defined(CONFIG_LOONGSON1_LS1B)
> >         /*                                 _____
> >          *         _______________________|     |
> >          * OSC ___/                       | MUX |___ DDR CLK
> > @@ -146,6 +185,22 @@ void __init ls1x_clk_init(void)
> >                                ARRAY_SIZE(ahb_parents),
> >                                CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
> >                                BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0,
> > &_lock);
> > +#elif defined(CONFIG_LOONGSON1_LS1C)
> > +       reg = __raw_readl(LS1X_CLK_PLL_FREQ) & SDRAM_DIV;
> > +       switch (reg) {
> > +       case 0:
> > +               div = 2;
> > +               break;
> > +       case 1:
> > +               div = 4;
> > +               break;
> > +       case 2:
> > +       case 3:
> > +               div = 3;
> > +               break;
> > +       }
> > +       clk = clk_register_fixed_factor(NULL, "ahb_clk", "cpu_clk", 0, 1,
> > div);
> > +#endif
> >         clk_register_clkdev(clk, "ahb_clk", NULL);
> >         clk_register_clkdev(clk, "stmmaceth", NULL);
> >
> > --
> > 1.9.1
> >
> >
> >
> 
> 
> -- 
> Best regards,
> 
> Kelvin Cheung

Well, I will apply the latest patchs in the next version.
Thanks, Cheung.
