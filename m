Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 13:25:21 +0100 (CET)
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34358 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011791AbcBKMZTp5ir8 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Feb 2016 13:25:19 +0100
Received: by mail-lf0-f45.google.com with SMTP id j78so30423764lfb.1
        for <linux-mips@linux-mips.org>; Thu, 11 Feb 2016 04:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VtcLQtqX7z1eVmzkF0N7/LIZSOjN8FUnTbs9zJhAs8k=;
        b=kuEGNkVr1YUwWfkErynaJn6hOWRhY3uxOIGiAean24fTp0yJsydufeAWIyCVXyQxnE
         NDMAf3kUy0nCCQ8TlDHyTsJsORJ6ZebwbAlsSH4WhVgpFUsYPFEDHqjEExkEdxwXTXZH
         NXVhqbXNjLqdrCzDpzrUifnsoIv2wUHAz0OetRPONkEUJtsfjRtlVEMsS99IOuSGJBBU
         5hpDSFNyu/uF05n7upMfBidIcdtV/OxxRtPDHAgV7ZC5CXe2sg02mwXRhYWRR4LnHd1m
         5sVf6tv968wxGwffkuEti0Mik7Au22Cqsf62LNm6DUacAeaCXMtxVoOT10qDajZBdCVW
         OMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=VtcLQtqX7z1eVmzkF0N7/LIZSOjN8FUnTbs9zJhAs8k=;
        b=FMli+MWffppbdaV71nA9wIh1oUOIbv3Jxjjcf4L5jmbjt/Sqa/CSQtJ3xXL/UGc4lh
         CoHFCmalXGp/EKVL0C2J3J2qL+SvjmHzpJt2yyDgJzVvKqnUXgUqY8r6KAwidUekGsQ8
         ofklpHZBiqoiz1V3cttXcEvdZ7Hqha/NKtRWIqPIspcB3bm35CVuTNu12UFN3mZk8n8s
         2GLHrvg9T89yQT7ZwNJ0PdXkDBby5KMa3hSGSmMSYxkuQFrZH1za7S2m3XKSUy4I1D9f
         WnCR0dsF4IEavbz99K0G35fYo1w1vWGY7l2TGnCXLbSqfMLNlhGV+Uw4qq4RxBMvi3c3
         2z3A==
X-Gm-Message-State: AG10YOTpVkNbXIkiL5RLH0FV8SQy6amJdlq45jYzocg8fURYVMEw30h/4lhNTF0Lkdc0Pg==
X-Received: by 10.25.31.80 with SMTP id f77mr3903322lff.18.1455193514321;
        Thu, 11 Feb 2016 04:25:14 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id 36sm1236083lfx.19.2016.02.11.04.25.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Feb 2016 04:25:13 -0800 (PST)
Date:   Thu, 11 Feb 2016 15:50:51 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Marek Vasut <marex@denx.de>,
        Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC v5 01/15] WIP: clk: add Atheros AR933X SoCs clock driver
Message-Id: <20160211155051.d6378434246fe94ad4ed2760@gmail.com>
In-Reply-To: <20160209225134.2bb6b67c@tock>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
        <1455005641-7079-2-git-send-email-antonynpavlov@gmail.com>
        <20160209225134.2bb6b67c@tock>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51998
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

On Tue, 9 Feb 2016 22:51:34 +0100
Alban <albeu@free.fr> wrote:

> On Tue,  9 Feb 2016 11:13:47 +0300
> Antony Pavlov <antonynpavlov@gmail.com> wrote:
> 
> > This driver can be easely upgraded for other Atheros
> > SoCs (e.g. AR724X/AR913X) support.
> > 
> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > Cc: Alban Bedel <albeu@free.fr>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Paul Burton <paul.burton@imgtec.com>
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-mips@linux-mips.org
> > Cc: devicetree@vger.kernel.org
> > ---
> >  drivers/clk/Makefile                  |   1 +
> >  drivers/clk/clk-ath79.c               | 354 ++++++++++++++++++++++++++++++++++
> >  include/dt-bindings/clock/ath79-clk.h |  22 +++
> >  3 files changed, 377 insertions(+)
> > 
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index b038e36..d7ad50e 100644
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
> > index 0000000..e899d31
> > --- /dev/null
> > +++ b/drivers/clk/clk-ath79.c
> > @@ -0,0 +1,354 @@
> > +/*
> > + * Clock driver for Atheros AR933X SoCs
> > + *
> > + * Copyright (C) 2016 Antony Pavlov <antonynpavlov@gmail.com>
> > + *
> > + * This driver is based on Ingenic CGU linux driver by Paul Burton
> > + * and AR9331 barebox driver by Antony Pavlov.
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
> > +
> > +#include <dt-bindings/clock/ath79-clk.h>
> > +
> > +#include "asm/mach-ath79/ar71xx_regs.h"
> 
> This header shouldn't be used in new code, just defines the few
> registers needed here. Not using this header allow the driver
> to be built in compile test which increase test coverage.

ok.

> > +struct ath79_pll_info {
> > +	u32 div_shift;
> > +	u32 div_mask;
> > +};
> > +
> > +struct ath79_cblk;
> > +
> > +/**
> > + * struct ath79_clk_info - information about a clock
> > + * @name: name of the clock
> > + * @type: a bitmask formed from ATH79_CLK_* values
> > + * @parents: an index of parent of this clock
> > + *           within the clock_info array, or -1
> > + *           which correspond to no valid parent
> > + * @pll: information valid if type includes ATH79_CLK_PLL
> > + */
> > +struct ath79_clk_info {
> > +	const char *name;
> > +
> > +	enum {
> > +		ATH79_CLK_NONE		= 0,
> > +		ATH79_CLK_EXT		= 1,
> > +		ATH79_CLK_PLL		= 2,
> > +		ATH79_CLK_ALIAS		= 3,
> > +	} type;
> > +
> > +	struct ath79_cblk *cblk;
> > +	int parent;
> > +
> > +	struct ath79_pll_info pll;
> > +};
> > +
> > +struct ath79_cblk {
> > +	struct device_node *np;
> > +	void __iomem *base;
> > +
> > +	const struct ath79_clk_info *clock_info;
> > +	struct clk_onecell_data clocks;
> > +};
> > +
> > +/**
> > + * struct ath79_clk - private data for a clock
> > + * @hw: see Documentation/clk.txt
> > + * @cblk: a pointer to the cblk data
> > + * @idx: the index of this clock cblk->clock_info
> > + * @pll: information valid if type includes ATH79_CLK_PLL
> > + */
> > +struct ath79_clk {
> > +	struct clk_hw hw;
> > +	struct ath79_cblk *cblk;
> > +	unsigned idx;
> > +};
> > +
> > +#define to_ath79_clk(_hw) container_of(_hw, struct ath79_clk, hw)
> > +
> > +static const struct ath79_clk_info ar9331_clocks[] = {
> > +
> > +	/* External clock */
> > +	[ATH79_CLK_REF] = { "ref", ATH79_CLK_EXT },
> > +
> > +	[ATH79_CLK_CPU] = {
> > +		"cpu", ATH79_CLK_PLL,
> > +		.parent = ATH79_CLK_REF,
> > +		.pll = {
> > +			.div_shift = AR933X_PLL_CLOCK_CTRL_CPU_DIV_SHIFT,
> > +			.div_mask = AR933X_PLL_CLOCK_CTRL_CPU_DIV_MASK,
> > +		},
> > +	},
> > +
> > +	[ATH79_CLK_DDR] = {
> > +		"ddr", ATH79_CLK_PLL,
> > +		.parent = ATH79_CLK_REF,
> > +		.pll = {
> > +			.div_shift = AR933X_PLL_CLOCK_CTRL_DDR_DIV_SHIFT,
> > +			.div_mask = AR933X_PLL_CLOCK_CTRL_DDR_DIV_MASK,
> > +		},
> > +	},
> > +
> > +	[ATH79_CLK_AHB] = {
> > +		"ahb", ATH79_CLK_PLL,
> > +		.parent = ATH79_CLK_REF,
> > +		.pll = {
> > +			.div_shift = AR933X_PLL_CLOCK_CTRL_AHB_DIV_SHIFT,
> > +			.div_mask = AR933X_PLL_CLOCK_CTRL_AHB_DIV_MASK,
> > +		},
> > +	},
> > +
> > +	[ATH79_CLK_WDT] = {
> > +		"wdt", ATH79_CLK_ALIAS,
> > +		.parent = ATH79_CLK_AHB,
> > +	},
> > +
> > +	[ATH79_CLK_UART] = {
> > +		"uart", ATH79_CLK_ALIAS,
> > +		.parent = ATH79_CLK_REF,
> > +	},
> > +};
> > +
> > +struct ath79_cblk *
> > +ath79_cblk_new(const struct ath79_clk_info *clock_info,
> > +		unsigned num_clocks, struct device_node *np)
> > +{
> > +	struct ath79_cblk *cblk;
> > +
> > +	cblk = kzalloc(sizeof(*cblk), GFP_KERNEL);
> > +	if (!cblk)
> > +		goto err_out;
> > +
> > +	cblk->base = of_iomap(np, 0);
> > +	if (!cblk->base) {
> > +		pr_err("%s: failed to map clock block registers\n", __func__);
> > +		goto err_out_free;
> > +	}
> > +
> > +	cblk->np = np;
> > +	cblk->clock_info = clock_info;
> > +	cblk->clocks.clk_num = num_clocks;
> > +
> > +	return cblk;
> > +
> > +err_out_free:
> > +	kfree(cblk);
> > +
> > +err_out:
> > +	return NULL;
> > +}
> > +
> > +static unsigned long
> > +ath79_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> > +{
> > +	struct ath79_clk *ath79_clk = to_ath79_clk(hw);
> > +	struct ath79_cblk *cblk = ath79_clk->cblk;
> > +	const struct ath79_clk_info *clk_info = &cblk->clock_info[ath79_clk->idx];
> > +	const struct ath79_pll_info *pll_info;
> > +	unsigned long rate;
> > +	unsigned long freq;
> > +	u32 clock_ctrl;
> > +	u32 cpu_config;
> > +	u32 t;
> > +
> > +	BUG_ON(clk_info->type != ATH79_CLK_PLL);
> 
> It's probably debatable if such a BUG_ON() is really needed.

In simple RFC v5 driver version this check is redundant.
I suppose it's reasonable for more advanced version of the driver.
 
> > +	clock_ctrl = __raw_readl(cblk->base + AR933X_PLL_CLOCK_CTRL_REG);
> > +
> > +	if (clock_ctrl & AR933X_PLL_CLOCK_CTRL_BYPASS) {
> > +		return parent_rate;
> > +	}
> 
> Those brace should goes away.

Ok.

> > +	cpu_config = __raw_readl(cblk->base + AR933X_PLL_CPU_CONFIG_REG);
> > +
> > +	t = (cpu_config >> AR933X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
> > +	    AR933X_PLL_CPU_CONFIG_REFDIV_MASK;
> > +	freq = parent_rate / t;
> > +
> > +	t = (cpu_config >> AR933X_PLL_CPU_CONFIG_NINT_SHIFT) &
> > +	    AR933X_PLL_CPU_CONFIG_NINT_MASK;
> > +	freq *= t;
> > +
> > +	t = (cpu_config >> AR933X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
> > +	    AR933X_PLL_CPU_CONFIG_OUTDIV_MASK;
> > +	if (t == 0)
> > +		t = 1;
> > +
> > +	freq >>= t;
> > +
> > +	pll_info = &clk_info->pll;
> > +
> > +	t = ((clock_ctrl >> pll_info->div_shift) & pll_info->div_mask) + 1;
> > +	rate = freq / t;
> 
> If we just compute a fixed rate we could as well use
> clk_register_fixed_factor() and drop 80% of the code of this driver.

80% is an overstatement.

> > +	return rate;
> > +}
> > +
> > +static const struct clk_ops ath79_pll_clk_ops = {
> > +	.recalc_rate = ath79_pll_recalc_rate,
> > +};
> > +
> > +static int ath79_register_clock(struct ath79_cblk *cblk, unsigned idx)
> > +{
> > +	const struct ath79_clk_info *clk_info = &cblk->clock_info[idx];
> > +	const struct ath79_clk_info *parent_clk_info;
> > +	struct clk_init_data clk_init;
> > +	struct ath79_clk *ath79_clk = NULL;
> > +	struct clk *clk;
> > +	int err = -EINVAL;
> > +
> > +	if (clk_info->type == ATH79_CLK_EXT) {
> > +		clk = of_clk_get_by_name(cblk->np, clk_info->name);
> > +		if (IS_ERR(clk)) {
> > +			pr_err("%s: no external clock '%s' provided\n",
> > +			       __func__, clk_info->name);
> > +			err = -ENODEV;
> > +			goto out;
> > +		}
> > +
> > +		err = clk_register_clkdev(clk, clk_info->name, NULL);
> > +		if (err) {
> > +			clk_put(clk);
> > +			goto out;
> > +		}
> 
> clk_register_clkdev() and naming providers is not needed on OF
> platforms. This should only be used on legacy platforms.

I can't drop these clk_register_clkdev() just now without patching legacy code.

If I just drop clk_register_clkdev() then I get

    Kernel panic - not syncing: unable to get cpu clock, err=-2

on start.


> > +		cblk->clocks.clks[idx] = clk;
> > +
> > +		return 0;
> > +	}
> > +
> > +	parent_clk_info = &cblk->clock_info[clk_info->parent];
> > +
> > +	if (clk_info->type == ATH79_CLK_ALIAS) {
> > +		clk = clk_register_fixed_factor(NULL, clk_info->name,
> > +						parent_clk_info->name, 0, 1, 1);
> > +		if (IS_ERR(clk)) {
> > +			pr_err("%s: failed to register clock '%s'\n", __func__,
> > +			       clk_info->name);
> > +			err = PTR_ERR(clk);
> > +			goto out;
> > +		}
> > +
> > +		cblk->clocks.clks[idx] = clk;
> > +
> > +		return 0;
> > +	}
> 
> I really don't get why you keep insisting on having those useless alias
> clocks. Alias are only needed on legacy platforms to form connections
> between clock providers and consumers. On OF platforms these
> connections are nicely represented in the DT, so it is just not
> needed at all.

I have droppped these aliases in RFC v6 series.

-- 
Best regards,
  Antony Pavlov
