Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2016 21:16:42 +0100 (CET)
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35976 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011382AbcAaUQip0D93 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 Jan 2016 21:16:38 +0100
Received: by mail-lf0-f44.google.com with SMTP id 78so35774771lfy.3
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 12:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8NAwd4t5/VaO8ukAyJ/Lr4CsgeYtF0W3ciFamXgRzDQ=;
        b=FXAW3+uBZHSle+HbHfA6Btvtxy8aXCzlSHoci26joTzaOBsHfqEfATTvbr9NsIUBf/
         5xEfSu/x8MFU6PpWVFcacxE7lL9rCg2U763j32G4mVW1IZJsc7bSN05J1mipXBX6sTCo
         79TlIFDCV3b+6KMQC6MsxnMeyOyW1avE5r08lAZsnThAaeH9a0qjbdeVn88GpX9VpiuI
         k9EbeaiF66/4PnVtW/q9ljicpc7iyMmt3L6900H1D5PAFwfsRMTm+KWu2pZhx7jzEwnC
         WUBl5VgyPHmqJJS7pH/KVlJhtGAqN2+ynBF5NwVFKrZXafQe8t1cZlfA3qsHBZNicP7a
         4baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=8NAwd4t5/VaO8ukAyJ/Lr4CsgeYtF0W3ciFamXgRzDQ=;
        b=kz7H0E8sLJTj7lR0At6H8nqwfuBsYa63C3EWyDBJMrsRYOdysyp3i+F6iRANaCNMjo
         rP3Lde0GrK3GT7KdPnC5T7N83MWxUCo96Nw7t/yGZqBrrYsI0zj6u2/avEzJ9tTFS8Yo
         tY0yQWGNKEDhGuu/1t2oU5YdWjSWdhLlC5tLp1JbLTi3CPIyQCDIQWFmGJAOSfOsKChT
         W9pOdyp9XrHplPGOEBAlewnlga7lyiWCFOdj1TNmJY4JOYVaJcO96NFE1kdSP20WpoWV
         vhEuuPZus9X7ilwQ/22OAnqk5saF/DNi1zdGnQr5u0vU7xeJi7V/GGYWlQ3GmCjbZZhG
         hLjQ==
X-Gm-Message-State: AG10YOR/5eU1rMXpUQ38AZh8H9pP2nbxQQyouieOGBHJrAzxNQ8ZcKyX+KWNjB961yDjwg==
X-Received: by 10.25.41.203 with SMTP id p194mr7212165lfp.135.1454271393386;
        Sun, 31 Jan 2016 12:16:33 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id ug1sm3560890lbb.43.2016.01.31.12.16.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jan 2016 12:16:32 -0800 (PST)
Date:   Sun, 31 Jan 2016 23:41:55 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC v3 01/14] WIP: clk: add Atheros AR724X/AR913X/AR933X SoCs
 clock driver
Message-Id: <20160131234155.eee918745880878963c044aa@gmail.com>
In-Reply-To: <20160125232156.35c0ce3f@tock>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
        <1453580251-2341-2-git-send-email-antonynpavlov@gmail.com>
        <20160125232156.35c0ce3f@tock>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Mon, 25 Jan 2016 23:21:56 +0100
Alban <albeu@free.fr> wrote:

> On Sat, 23 Jan 2016 23:17:18 +0300
> Antony Pavlov <antonynpavlov@gmail.com> wrote:
> 
> > TODO: get pll registers base address from devicetree node
> > 
> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > Cc: Alban Bedel <albeu@free.fr>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-mips@linux-mips.org
> > Cc: devicetree@vger.kernel.org
> > ---
> >  drivers/clk/Makefile                  |   1 +
> >  drivers/clk/clk-ath79.c               | 193 ++++++++++++++++++++++++++++++++++
> >  include/dt-bindings/clock/ath79-clk.h |  22 ++++
> >  3 files changed, 216 insertions(+)
> > 
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index 820714c..5101763 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -18,6 +18,7 @@ endif
> >  # hardware specific clock types
> >  # please keep this section sorted lexicographically by file/directory path name
> >  obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
> > +obj-$(CONFIG_ATH79)			+= clk-ath79.o
> >  obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
> >  obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
> >  obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
> > diff --git a/drivers/clk/clk-ath79.c b/drivers/clk/clk-ath79.c
> > new file mode 100644
> > index 0000000..75338a7
> > --- /dev/null
> > +++ b/drivers/clk/clk-ath79.c
> > @@ -0,0 +1,193 @@
> > +/*
> > + * Clock driver for Atheros AR724X/AR913X/AR933X SoCs
> > + *
> > + * Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
> > + * Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
> > + * Copyright (C) 2015 Alban Bedel <albeu@free.fr>
> > + * Copyright (C) 2016 Antony Pavlov <antonynpavlov@gmail.com>
> > + *
> > + * Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/clkdev.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include "clk.h"
> > +
> > +#include <dt-bindings/clock/ath79-clk.h>
> > +
> > +#include "asm/mach-ath79/ar71xx_regs.h"
> > +#include "asm/mach-ath79/ath79.h"
> > +
> > +#define MHZ (1000 * 1000)
> > +
> > +#define AR724X_BASE_FREQ	(40 * MHZ)
> > +
> > +static struct clk *ath79_clks[ATH79_CLK_END];
> > +
> > +static struct clk_onecell_data clk_data = {
> > +	.clks = ath79_clks,
> > +	.clk_num = ARRAY_SIZE(ath79_clks),
> > +};
> > +
> > +static struct clk *__init ath79_add_sys_clkdev(
> > +	const char *id, unsigned long rate)
> > +{
> > +	struct clk *clk;
> > +	int err;
> > +
> > +	clk = clk_register_fixed_rate(NULL, id, NULL, CLK_IS_ROOT, rate);
> > +	if (!clk)
> > +		panic("failed to allocate %s clock structure", id);
> > +
> > +	err = clk_register_clkdev(clk, id, NULL);
> > +	if (err)
> > +		panic("unable to register %s clock device", id);
> > +
> > +	return clk;
> > +}
> >
> > +static void __init ar724x_clk_init(struct device_node *np)
> > +{
> > +	struct clk *ref_clk;
> > +	unsigned long of_ref_rate;
> > +	unsigned long ref_rate;
> > +	unsigned long cpu_rate;
> > +	unsigned long ddr_rate;
> > +	unsigned long ahb_rate;
> > +	u32 pll;
> > +	u32 freq;
> > +	u32 div;
> > +
> > +	ref_clk = of_clk_get(np, 0);
> > +	if (IS_ERR(ref_clk)) {
> > +		pr_err("%s: of_clk_get failed\n", np->full_name);
> > +		return;
> > +	}
> 
> It would be better to have this function take the ref clock as
> argument, to allow using it for both OF and legacy platforms.

I'll try to use this idea in v5 patch version.

> > +	of_ref_rate = clk_get_rate(ref_clk);
> > +
> > +	ref_rate = AR724X_BASE_FREQ;
> > +
> > +	if (of_ref_rate != ref_rate) {
> > +		pr_err("ref_rate != of_ref_rate\n");
> > +		ref_rate = of_ref_rate;
> > +	}
> 
> I don't think that this test is really useful.

Yes, I can make this check optional.

> > +	pll = ath79_pll_rr(AR724X_PLL_REG_CPU_CONFIG);
> > +
> > +	div = ((pll >> AR724X_PLL_FB_SHIFT) & AR724X_PLL_FB_MASK);
> > +	freq = div * ref_rate;
> > +
> > +	div = ((pll >> AR724X_PLL_REF_DIV_SHIFT) & AR724X_PLL_REF_DIV_MASK) * 2;
> > +	freq /= div;
> > +
> > +	cpu_rate = freq;
> > +
> > +	div = ((pll >> AR724X_DDR_DIV_SHIFT) & AR724X_DDR_DIV_MASK) + 1;
> > +	ddr_rate = freq / div;
> > +
> > +	div = (((pll >> AR724X_AHB_DIV_SHIFT) & AR724X_AHB_DIV_MASK) + 1) * 2;
> > +	ahb_rate = cpu_rate / div;
> 
> For a new driver it would make sense to use clk_register_divider() and
> similar generic building blocks.
> 
> > +	ath79_clks[ATH79_CLK_REF] = ath79_add_sys_clkdev("ref", ref_rate);
> > +	ath79_clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
> > +	ath79_clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
> > +	ath79_clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
> > +	ath79_clks[ATH79_CLK_WDT] = ath79_add_sys_clkdev("wdt", ahb_rate);
> > +	ath79_clks[ATH79_CLK_UART] = ath79_add_sys_clkdev("uart", ahb_rate);
> 
> You shouldn't add ref, wdt and uart, they are not needed and make the
> driver incompatible with the current DT bindings.

Please describe the situation then this incompatibility does matter.

Current ath79 dt support is very preliminary and the only dt user
is 5-years old TP-Link WR1043ND so it's near impossible to break somethink.

Anyway current ath79 dt binding is somewhat broken (see __your__ message 'Re: [RFC 1/4] WIP: MIPS: ath79: make ar933x clks more devicetree-friendly' from 'Thu, 21 Jan 2016 12:03:20 +0100').


-- 
Best regards,
  Antony Pavlov
