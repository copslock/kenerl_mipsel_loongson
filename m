Return-Path: <SRS0=DhUk=RA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A00C43381
	for <linux-mips@archiver.kernel.org>; Mon, 25 Feb 2019 15:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A3320684
	for <linux-mips@archiver.kernel.org>; Mon, 25 Feb 2019 15:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GuUgUppa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfBYPzW (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:55:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52989 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfBYPzP (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 25 Feb 2019 10:55:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so8633548wml.2
        for <linux-mips@vger.kernel.org>; Mon, 25 Feb 2019 07:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OzH4NWvbRRfS1t1Zb9u9VK8/4LjXIxI7975XgapU40M=;
        b=GuUgUppaf5xdPeWieOi/NhepRqmQCS0i4Hyg5Em+opBkdaKaZH/FANoUCFdKzf5dt0
         6x/qw3XNHG/w8GOPXwdT40XBXElZ92alyo+DwRy5+nKXhfrDtlh7XiFD/26896EnharO
         lbBC8IUHe4qCtk1ImokNMoKL3CcxG1UV5XZTJy+wmwsE21aDDF6FjDmyEp5Hq+eYmg/9
         1yW9KIsO5NnbiUIkIFeCPDPKBl6CKZFgIiZw3QCzrvvFHAsKN6+JAJaPx3ihFBj55fuh
         mxNU4SoDqAGz0h6cICKegTEHQdfQD5K1eqsViWl070/3C9y2cqssN4ktWYEL1iBFt8JO
         CKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OzH4NWvbRRfS1t1Zb9u9VK8/4LjXIxI7975XgapU40M=;
        b=Y9bVM7saoWY5vKWH9hhfNU2p8ICjxirU2v8vOx6TXs8gglyU1eEWbZvah1SvNf4cHV
         v8EbJLWIxenLldFpOsQrc7igAFayq2JR4+Ikhctf5nFRvqmfI1uuZzIGN/g20bvn5epD
         SP3enTU9tTgXyg/sO9YFupt+oiZvsnE5wK639Xaa5GUJldd4C7KXyJZ/ppnbdk4wUQmu
         pPKoqW4KlFTXW2bNp1F9tIw1va0YBItPL2PHUGdItX/3Xbbq4Td64bswth17iGCLLaJu
         Jzuc7Mlay8w9JPRC1yvdqxOK2H8ws/EtLVIp1s9k6RFmuadqA7FH/w16mGrGbZMNJxzs
         CyvQ==
X-Gm-Message-State: AHQUAubQvTcR8Hdybt292kKHuDfkS778XVyk2ptJS4JM2BXTxouyCEFc
        wvJOL5cMpmpULP9xTeEjgK9frA==
X-Google-Smtp-Source: AHgI3IZpq43qnzquQHrAU7jKiOrCXKeZnUoy1RA9GcVZD0SF82QZYOcKyNJP2SORSMnjXwgLH4dZaA==
X-Received: by 2002:a1c:4e09:: with SMTP id g9mr10468157wmh.56.1551110111245;
        Mon, 25 Feb 2019 07:55:11 -0800 (PST)
Received: from [192.168.0.41] (5.22.136.77.rev.sfr.net. [77.136.22.5])
        by smtp.googlemail.com with ESMTPSA id h13sm8284631wrs.42.2019.02.25.07.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 07:55:10 -0800 (PST)
Subject: Re: [PATCH v9 04/27] clocksource: Add a new timer-ingenic driver
To:     Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20181227181319.31095-1-paul@crapouillou.net>
 <20181227181319.31095-5-paul@crapouillou.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e50dc1da-6c19-392c-fcb6-0067b9632c00@linaro.org>
Date:   Mon, 25 Feb 2019 16:55:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181227181319.31095-5-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Paul,

sorry for the delay but this driver requires a bit more of attention.

Overall I disagree the driver because of its complexity. We should not
see that for this driver.

Did you check if using node alias to specify the clocksource and the
clockevent can fit your need.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/timer-integrator-ap.c#n199

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/integratorap.dts#n49


On 27/12/2018 19:12, Paul Cercueil wrote:
> This driver handles the TCU (Timer Counter Unit) present on the Ingenic
> JZ47xx SoCs, and provides the kernel with a system timer, and optionally
> with a clocksource and a sched_clock.
> 
> It also provides clocks and interrupt handling to client drivers.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>      v2: Use SPDX identifier for the license
>     
>      v3: - Move documentation to its own patch
>          - Search the devicetree for PWM clients, and use all the TCU
>     	   channels that won't be used for PWM
>     
>      v4: - Add documentation about why we search for PWM clients
>          - Verify that the PWM clients are for the TCU PWM driver
>     
>      v5: Major overhaul. Too many changes to list. Consider it's a new
>          patch.
>     
>      v6: - Add two API functions ingenic_tcu_request_channel and
>            ingenic_tcu_release_channel. To be used by the PWM driver to
>            request the use of a TCU channel. The driver will now dynamically
>            move away the system timer or clocksource to a new TCU channel.
>          - The system timer now defaults to channel 0, the clocksource now
>            defaults to channel 1 and is no more optional. The
>            ingenic,timer-channel and ingenic,clocksource-channel devicetree
>            properties are now gone.
>          - Fix round_rate / set_rate not calculating the prescale divider
>            the same way. This caused problems when (parent_rate / div) would
>            give a non-integer result. The behaviour is correct now.
>          - The clocksource clock is turned off on suspend now.
>     
>      v7: Fix section mismatch by using builtin_platform_driver_probe()
> 
>      v8: - Removed ingenic_tcu_[request,release]_channel, and the mechanism
>            to dynamically change the TCU channel of the system timer or
> 	   the clocksource.
> 	 - The driver's devicetree node can now have two more children
> 	   nodes, that correspond to the system timer and clocksource.
> 	   For these two, the driver will use the TCU timer that
> 	   correspond to the memory resource supplied in their
> 	   respective node.
> 
>      v9: - Removed support for clocksource / timer children devicetree
>            nodes. Now, we use a property "ingenic,pwm-channels-mask" to
> 	   know which PWM channels are reserved for PWM use and should
> 	   not be used as OS timers.
> 
>  drivers/clocksource/Kconfig         |  10 +
>  drivers/clocksource/Makefile        |   1 +
>  drivers/clocksource/ingenic-timer.c | 901 ++++++++++++++++++++++++++++++++++++
>  drivers/clocksource/ingenic-timer.h |  15 +
>  include/linux/mfd/ingenic-tcu.h     |   2 +
>  5 files changed, 929 insertions(+)
>  create mode 100644 drivers/clocksource/ingenic-timer.c
>  create mode 100644 drivers/clocksource/ingenic-timer.h
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 55c77e44bb2d..4e69af15c3e7 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -638,4 +638,14 @@ config GX6605S_TIMER
>  	help
>  	  This option enables support for gx6605s SOC's timer.
>  
> +config INGENIC_TIMER
> +	bool "Clocksource/timer using the TCU in Ingenic JZ SoCs"
> +	depends on MIPS || COMPILE_TEST
> +	depends on COMMON_CLK
> +	select TIMER_OF
> +	select IRQ_DOMAIN
> +	select REGMAP
> +	help
> +	  Support for the timer/counter unit of the Ingenic JZ SoCs.
> +
>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index dd9138104568..7c8f790dcf67 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
>  obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
>  obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
>  obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
> +obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
>  obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
>  obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
> diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingenic-timer.c
> new file mode 100644
> index 000000000000..81faa120cfee
> --- /dev/null
> +++ b/drivers/clocksource/ingenic-timer.c
> @@ -0,0 +1,901 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * JZ47xx SoCs TCU IRQ driver
> + * Copyright (C) 2018 Paul Cercueil <paul@crapouillou.net>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/mfd/ingenic-tcu.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/sched_clock.h>
> +
> +#include <dt-bindings/clock/ingenic,tcu.h>
> +
> +#include "ingenic-timer.h"
> +
> +/* 8 channels max + watchdog + OST */
> +#define TCU_CLK_COUNT	10
> +
> +enum tcu_clk_parent {
> +	TCU_PARENT_PCLK,
> +	TCU_PARENT_RTC,
> +	TCU_PARENT_EXT,
> +};
> +
> +struct ingenic_soc_info {
> +	unsigned char num_channels;
> +	bool has_ost;
> +};
> +
> +struct ingenic_tcu_clk_info {
> +	struct clk_init_data init_data;
> +	u8 gate_bit;
> +	u8 tcsr_reg;
> +};
> +
> +struct ingenic_tcu_clk {
> +	struct clk_hw hw;
> +
> +	struct regmap *map;
> +	const struct ingenic_tcu_clk_info *info;
> +
> +	unsigned int idx;
> +};
> +
> +#define to_tcu_clk(_hw) container_of(_hw, struct ingenic_tcu_clk, hw)
> +
> +struct ingenic_tcu {
> +	const struct ingenic_soc_info *soc_info;
> +	struct regmap *map;
> +	struct clk *clk, *timer_clk, *cs_clk;
> +
> +	struct irq_domain *domain;
> +	unsigned int nb_parent_irqs;
> +	u32 parent_irqs[3];
> +
> +	struct clk_hw_onecell_data *clocks;
> +
> +	unsigned int timer_channel, cs_channel;
> +	struct clock_event_device cevt;
> +	struct clocksource cs;
> +	char name[4];
> +
> +	unsigned long pwm_channels_mask;
> +};
> +
> +static struct ingenic_tcu *ingenic_tcu;
> +
> +void __iomem *ingenic_tcu_base;
> +EXPORT_SYMBOL_GPL(ingenic_tcu_base);
> +
> +static int ingenic_tcu_enable(struct clk_hw *hw)
> +{
> +	struct ingenic_tcu_clk *tcu_clk = to_tcu_clk(hw);
> +	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
> +
> +	regmap_write(tcu_clk->map, TCU_REG_TSCR, BIT(info->gate_bit));
> +	return 0;
> +}
> +
> +static void ingenic_tcu_disable(struct clk_hw *hw)
> +{
> +	struct ingenic_tcu_clk *tcu_clk = to_tcu_clk(hw);
> +	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
> +
> +	regmap_write(tcu_clk->map, TCU_REG_TSSR, BIT(info->gate_bit));
> +}
> +
> +static int ingenic_tcu_is_enabled(struct clk_hw *hw)
> +{
> +	struct ingenic_tcu_clk *tcu_clk = to_tcu_clk(hw);
> +	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
> +	unsigned int value;
> +
> +	regmap_read(tcu_clk->map, TCU_REG_TSR, &value);
> +
> +	return !(value & BIT(info->gate_bit));
> +}
> +
> +static u8 ingenic_tcu_get_parent(struct clk_hw *hw)
> +{
> +	struct ingenic_tcu_clk *tcu_clk = to_tcu_clk(hw);
> +	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
> +	unsigned int val = 0;
> +	int ret;
> +
> +	ret = regmap_read(tcu_clk->map, info->tcsr_reg, &val);
> +	WARN_ONCE(ret < 0, "Unable to read TCSR %i", tcu_clk->idx);
> +
> +	return ffs(val & TCU_TCSR_PARENT_CLOCK_MASK) - 1;
> +}
> +
> +static int ingenic_tcu_set_parent(struct clk_hw *hw, u8 idx)
> +{
> +	struct ingenic_tcu_clk *tcu_clk = to_tcu_clk(hw);
> +	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
> +	struct regmap *map = tcu_clk->map;
> +	int ret;
> +
> +	/*
> +	 * Our clock provider has the CLK_SET_PARENT_GATE flag set, so we know
> +	 * that the clk is in unprepared state. To be able to access TCSR
> +	 * we must ungate the clock supply and we gate it again when done.
> +	 */
> +
> +	regmap_write(map, TCU_REG_TSCR, BIT(info->gate_bit));
> +
> +	ret = regmap_update_bits(map, info->tcsr_reg,
> +				TCU_TCSR_PARENT_CLOCK_MASK, BIT(idx));
> +	WARN_ONCE(ret < 0, "Unable to update TCSR %i", tcu_clk->idx);
> +
> +	regmap_write(map, TCU_REG_TSSR, BIT(info->gate_bit));
> +
> +	return 0;
> +}
> +
> +static unsigned long ingenic_tcu_recalc_rate(struct clk_hw *hw,
> +		unsigned long parent_rate)
> +{
> +	struct ingenic_tcu_clk *tcu_clk = to_tcu_clk(hw);
> +	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
> +	unsigned int prescale;
> +	int ret;
> +
> +	ret = regmap_read(tcu_clk->map, info->tcsr_reg, &prescale);
> +	WARN_ONCE(ret < 0, "Unable to read TCSR %i", tcu_clk->idx);
> +
> +	prescale = (prescale & TCU_TCSR_PRESCALE_MASK) >> TCU_TCSR_PRESCALE_LSB;
> +
> +	return parent_rate >> (prescale * 2);
> +}
> +
> +static u8 ingenic_tcu_get_prescale(unsigned long rate, unsigned long req_rate)
> +{
> +	u8 prescale;
> +
> +	for (prescale = 0; prescale < 5; prescale++)
> +		if ((rate >> (prescale * 2)) <= req_rate)
> +			return prescale;
> +
> +	return 5; /* /1024 divider */
> +}
> +
> +static long ingenic_tcu_round_rate(struct clk_hw *hw, unsigned long req_rate,
> +		unsigned long *parent_rate)
> +{
> +	unsigned long rate = *parent_rate;
> +	u8 prescale;
> +
> +	if (req_rate > rate)
> +		return -EINVAL;
> +
> +	prescale = ingenic_tcu_get_prescale(rate, req_rate);
> +	return rate >> (prescale * 2);
> +}
> +
> +static int ingenic_tcu_set_rate(struct clk_hw *hw, unsigned long req_rate,
> +		unsigned long parent_rate)
> +{
> +	struct ingenic_tcu_clk *tcu_clk = to_tcu_clk(hw);
> +	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
> +	struct regmap *map = tcu_clk->map;
> +	u8 prescale = ingenic_tcu_get_prescale(parent_rate, req_rate);
> +	int ret;
> +
> +	/*
> +	 * Our clock provider has the CLK_SET_RATE_GATE flag set, so we know
> +	 * that the clk is in unprepared state. To be able to access TCSR
> +	 * we must ungate the clock supply and we gate it again when done.
> +	 */
> +
> +	regmap_write(map, TCU_REG_TSCR, BIT(info->gate_bit));
> +
> +	ret = regmap_update_bits(map, info->tcsr_reg,
> +				TCU_TCSR_PRESCALE_MASK,
> +				prescale << TCU_TCSR_PRESCALE_LSB);
> +	WARN_ONCE(ret < 0, "Unable to update TCSR %i", tcu_clk->idx);
> +
> +	regmap_write(map, TCU_REG_TSSR, BIT(info->gate_bit));
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops ingenic_tcu_clk_ops = {
> +	.get_parent	= ingenic_tcu_get_parent,
> +	.set_parent	= ingenic_tcu_set_parent,
> +
> +	.recalc_rate	= ingenic_tcu_recalc_rate,
> +	.round_rate	= ingenic_tcu_round_rate,
> +	.set_rate	= ingenic_tcu_set_rate,
> +
> +	.enable		= ingenic_tcu_enable,
> +	.disable	= ingenic_tcu_disable,
> +	.is_enabled	= ingenic_tcu_is_enabled,
> +};
> +
> +static const char * const ingenic_tcu_timer_parents[] = {
> +	[TCU_PARENT_PCLK] = "pclk",
> +	[TCU_PARENT_RTC]  = "rtc",
> +	[TCU_PARENT_EXT]  = "ext",
> +};
> +
> +#define DEF_TIMER(_name, _gate_bit, _tcsr)				\
> +	{								\
> +		.init_data = {						\
> +			.name = _name,					\
> +			.parent_names = ingenic_tcu_timer_parents,	\
> +			.num_parents = ARRAY_SIZE(ingenic_tcu_timer_parents),\
> +			.ops = &ingenic_tcu_clk_ops,			\
> +			.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE,\
> +		},							\
> +		.gate_bit = _gate_bit,					\
> +		.tcsr_reg = _tcsr,					\
> +	}
> +static const struct ingenic_tcu_clk_info ingenic_tcu_clk_info[] = {
> +	[TCU_CLK_TIMER0] = DEF_TIMER("timer0", 0, TCU_REG_TCSRc(0)),
> +	[TCU_CLK_TIMER1] = DEF_TIMER("timer1", 1, TCU_REG_TCSRc(1)),
> +	[TCU_CLK_TIMER2] = DEF_TIMER("timer2", 2, TCU_REG_TCSRc(2)),
> +	[TCU_CLK_TIMER3] = DEF_TIMER("timer3", 3, TCU_REG_TCSRc(3)),
> +	[TCU_CLK_TIMER4] = DEF_TIMER("timer4", 4, TCU_REG_TCSRc(4)),
> +	[TCU_CLK_TIMER5] = DEF_TIMER("timer5", 5, TCU_REG_TCSRc(5)),
> +	[TCU_CLK_TIMER6] = DEF_TIMER("timer6", 6, TCU_REG_TCSRc(6)),
> +	[TCU_CLK_TIMER7] = DEF_TIMER("timer7", 7, TCU_REG_TCSRc(7)),
> +};
> +
> +static const struct ingenic_tcu_clk_info ingenic_tcu_watchdog_clk_info =
> +				DEF_TIMER("wdt", 16, TCU_REG_WDT_TCSR);
> +static const struct ingenic_tcu_clk_info ingenic_tcu_ost_clk_info =
> +				DEF_TIMER("ost", 15, TCU_REG_OST_TCSR);
> +#undef DEF_TIMER
> +
> +static void ingenic_tcu_intc_cascade(struct irq_desc *desc)
> +{
> +	struct irq_chip *irq_chip = irq_data_get_irq_chip(&desc->irq_data);
> +	struct irq_domain *domain = irq_desc_get_handler_data(desc);
> +	struct irq_chip_generic *gc = irq_get_domain_generic_chip(domain, 0);
> +	struct regmap *map = gc->private;
> +	uint32_t irq_reg, irq_mask;
> +	unsigned int i;
> +
> +	regmap_read(map, TCU_REG_TFR, &irq_reg);
> +	regmap_read(map, TCU_REG_TMR, &irq_mask);
> +
> +	chained_irq_enter(irq_chip, desc);
> +
> +	irq_reg &= ~irq_mask;
> +
> +	for_each_set_bit(i, (unsigned long *)&irq_reg, 32)
> +		generic_handle_irq(irq_linear_revmap(domain, i));
> +
> +	chained_irq_exit(irq_chip, desc);
> +}
> +
> +static void ingenic_tcu_gc_unmask_enable_reg(struct irq_data *d)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	struct irq_chip_type *ct = irq_data_get_chip_type(d);
> +	struct regmap *map = gc->private;
> +	u32 mask = d->mask;
> +
> +	irq_gc_lock(gc);
> +	regmap_write(map, ct->regs.ack, mask);
> +	regmap_write(map, ct->regs.enable, mask);
> +	*ct->mask_cache |= mask;
> +	irq_gc_unlock(gc);
> +}
> +
> +static void ingenic_tcu_gc_mask_disable_reg(struct irq_data *d)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	struct irq_chip_type *ct = irq_data_get_chip_type(d);
> +	struct regmap *map = gc->private;
> +	u32 mask = d->mask;
> +
> +	irq_gc_lock(gc);
> +	regmap_write(map, ct->regs.disable, mask);
> +	*ct->mask_cache &= ~mask;
> +	irq_gc_unlock(gc);
> +}
> +
> +static void ingenic_tcu_gc_mask_disable_reg_and_ack(struct irq_data *d)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	struct irq_chip_type *ct = irq_data_get_chip_type(d);
> +	struct regmap *map = gc->private;
> +	u32 mask = d->mask;
> +
> +	irq_gc_lock(gc);
> +	regmap_write(map, ct->regs.ack, mask);
> +	regmap_write(map, ct->regs.disable, mask);
> +	irq_gc_unlock(gc);
> +}
> +
> +static u64 notrace ingenic_tcu_timer_read(void)
> +{
> +	unsigned int channel = ingenic_tcu->cs_channel;
> +	u16 count;
> +
> +	count = readw(ingenic_tcu_base + TCU_REG_TCNTc(channel));
> +
> +	return count;
> +}
> +
> +static inline struct ingenic_tcu *to_ingenic_tcu(struct clock_event_device *evt)
> +{
> +	return container_of(evt, struct ingenic_tcu, cevt);
> +}
> +
> +static int ingenic_tcu_cevt_set_state_shutdown(struct clock_event_device *evt)
> +{
> +	struct ingenic_tcu *tcu = to_ingenic_tcu(evt);
> +
> +	regmap_write(tcu->map, TCU_REG_TECR, BIT(tcu->timer_channel));
> +	return 0;
> +}
> +
> +static int ingenic_tcu_cevt_set_next(unsigned long next,
> +				     struct clock_event_device *evt)
> +{
> +	struct ingenic_tcu *tcu = to_ingenic_tcu(evt);
> +
> +	if (next > 0xffff)
> +		return -EINVAL;
> +
> +	regmap_write(tcu->map, TCU_REG_TDFRc(tcu->timer_channel), next);
> +	regmap_write(tcu->map, TCU_REG_TCNTc(tcu->timer_channel), 0);
> +	regmap_write(tcu->map, TCU_REG_TESR, BIT(tcu->timer_channel));
> +
> +	return 0;
> +}
> +
> +static irqreturn_t ingenic_tcu_cevt_cb(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = dev_id;
> +	struct ingenic_tcu *tcu = to_ingenic_tcu(evt);
> +
> +	regmap_write(tcu->map, TCU_REG_TECR, BIT(tcu->timer_channel));
> +
> +	if (evt->event_handler)
> +		evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init ingenic_tcu_register_clock(struct ingenic_tcu *tcu,
> +			unsigned int idx, enum tcu_clk_parent parent,
> +			const struct ingenic_tcu_clk_info *info,
> +			struct clk_hw_onecell_data *clocks)
> +{
> +	struct ingenic_tcu_clk *tcu_clk;
> +	int err;
> +
> +	tcu_clk = kzalloc(sizeof(*tcu_clk), GFP_KERNEL);
> +	if (!tcu_clk)
> +		return -ENOMEM;
> +
> +	tcu_clk->hw.init = &info->init_data;
> +	tcu_clk->idx = idx;
> +	tcu_clk->info = info;
> +	tcu_clk->map = tcu->map;
> +
> +	/* Reset channel and clock divider, set default parent */
> +	ingenic_tcu_enable(&tcu_clk->hw);
> +	regmap_update_bits(tcu->map, info->tcsr_reg, 0xffff, BIT(parent));
> +	ingenic_tcu_disable(&tcu_clk->hw);
> +
> +	err = clk_hw_register(NULL, &tcu_clk->hw);
> +	if (err)
> +		goto err_free_tcu_clk;
> +
> +	err = clk_hw_register_clkdev(&tcu_clk->hw, info->init_data.name, NULL);
> +	if (err)
> +		goto err_clk_unregister;
> +
> +	clocks->hws[idx] = &tcu_clk->hw;
> +	return 0;
> +
> +err_clk_unregister:
> +	clk_hw_unregister(&tcu_clk->hw);
> +err_free_tcu_clk:
> +	kfree(tcu_clk);
> +	return err;
> +}
> +
> +static int __init ingenic_tcu_clk_init(struct ingenic_tcu *tcu,
> +				       struct device_node *np)
> +{
> +	size_t i;
> +	int ret;
> +
> +	tcu->clocks = kzalloc(sizeof(*tcu->clocks) +
> +			 sizeof(*tcu->clocks->hws) * TCU_CLK_COUNT,
> +			 GFP_KERNEL);
> +	if (!tcu->clocks)
> +		return -ENOMEM;
> +
> +	tcu->clocks->num = TCU_CLK_COUNT;
> +
> +	for (i = 0; i < tcu->soc_info->num_channels; i++) {
> +		ret = ingenic_tcu_register_clock(tcu, i, TCU_PARENT_EXT,
> +				&ingenic_tcu_clk_info[i], tcu->clocks);
> +		if (ret) {
> +			pr_err("ingenic-timer: cannot register clock %i\n", i);
> +			goto err_unregister_timer_clocks;
> +		}
> +	}
> +
> +	/*
> +	 * We set EXT as the default parent clock for all the TCU clocks
> +	 * except for the watchdog one, where we set the RTC clock as the
> +	 * parent. Since the EXT and PCLK are much faster than the RTC clock,
> +	 * the watchdog would kick after a maximum time of 5s, and we might
> +	 * want a slower kicking time.
> +	 */
> +	ret = ingenic_tcu_register_clock(tcu, TCU_CLK_WDT, TCU_PARENT_RTC,
> +				&ingenic_tcu_watchdog_clk_info, tcu->clocks);
> +	if (ret) {
> +		pr_err("ingenic-timer: cannot register watchdog clock\n");
> +		goto err_unregister_timer_clocks;
> +	}
> +
> +	if (tcu->soc_info->has_ost) {
> +		ret = ingenic_tcu_register_clock(tcu, TCU_CLK_OST,
> +					TCU_PARENT_EXT,
> +					&ingenic_tcu_ost_clk_info,
> +					tcu->clocks);
> +		if (ret) {
> +			pr_err("ingenic-timer: cannot register ost clock\n");
> +			goto err_unregister_watchdog_clock;
> +		}
> +	}
> +
> +	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, tcu->clocks);
> +	if (ret) {
> +		pr_err("ingenic-timer: cannot add OF clock provider\n");
> +		goto err_unregister_ost_clock;
> +	}
> +
> +	return 0;
> +
> +err_unregister_ost_clock:
> +	if (tcu->soc_info->has_ost)
> +		clk_hw_unregister(tcu->clocks->hws[i + 1]);
> +err_unregister_watchdog_clock:
> +	clk_hw_unregister(tcu->clocks->hws[i]);
> +err_unregister_timer_clocks:
> +	for (i = 0; i < tcu->clocks->num; i++)
> +		if (tcu->clocks->hws[i])
> +			clk_hw_unregister(tcu->clocks->hws[i]);
> +	kfree(tcu->clocks);
> +	return ret;
> +}
> +
> +static void __init ingenic_tcu_clk_cleanup(struct ingenic_tcu *tcu,
> +					   struct device_node *np)
> +{
> +	unsigned int i;
> +
> +	of_clk_del_provider(np);
> +
> +	for (i = 0; i < tcu->clocks->num; i++)
> +		clk_hw_unregister(tcu->clocks->hws[i]);
> +	kfree(tcu->clocks);
> +}
> +
> +static int __init ingenic_tcu_intc_init(struct ingenic_tcu *tcu,
> +					struct device_node *np)
> +{
> +	struct irq_chip_generic *gc;
> +	struct irq_chip_type *ct;
> +	int err, i, irqs;
> +
> +	irqs = of_property_count_elems_of_size(np, "interrupts", sizeof(u32));
> +	if (irqs < 0 || irqs > ARRAY_SIZE(tcu->parent_irqs))
> +		return -EINVAL;
> +
> +	tcu->nb_parent_irqs = irqs;
> +
> +	tcu->domain = irq_domain_add_linear(np, 32,
> +			&irq_generic_chip_ops, NULL);
> +	if (!tcu->domain)
> +		return -ENOMEM;
> +
> +	err = irq_alloc_domain_generic_chips(tcu->domain, 32, 1, "TCU",
> +			handle_level_irq, 0, IRQ_NOPROBE | IRQ_LEVEL, 0);
> +	if (err)
> +		goto out_domain_remove;
> +
> +	gc = irq_get_domain_generic_chip(tcu->domain, 0);
> +	ct = gc->chip_types;
> +
> +	gc->wake_enabled = IRQ_MSK(32);
> +	gc->private = tcu->map;
> +
> +	ct->regs.disable = TCU_REG_TMSR;
> +	ct->regs.enable = TCU_REG_TMCR;
> +	ct->regs.ack = TCU_REG_TFCR;
> +	ct->chip.irq_unmask = ingenic_tcu_gc_unmask_enable_reg;
> +	ct->chip.irq_mask = ingenic_tcu_gc_mask_disable_reg;
> +	ct->chip.irq_mask_ack = ingenic_tcu_gc_mask_disable_reg_and_ack;
> +	ct->chip.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
> +
> +	/* Mask all IRQs by default */
> +	regmap_write(tcu->map, TCU_REG_TMSR, IRQ_MSK(32));
> +
> +	/* On JZ4740, timer 0 and timer 1 have their own interrupt line;
> +	 * timers 2-7 share one interrupt.
> +	 * On SoCs >= JZ4770, timer 5 has its own interrupt line;
> +	 * timers 0-4 and 6-7 share one single interrupt.
> +	 *
> +	 * To keep things simple, we just register the same handler to
> +	 * all parent interrupts. The handler will properly detect which
> +	 * channel fired the interrupt.
> +	 */
> +	for (i = 0; i < irqs; i++) {
> +		tcu->parent_irqs[i] = irq_of_parse_and_map(np, i);
> +		if (!tcu->parent_irqs[i]) {
> +			err = -EINVAL;
> +			goto out_unmap_irqs;
> +		}
> +
> +		irq_set_chained_handler_and_data(tcu->parent_irqs[i],
> +				ingenic_tcu_intc_cascade, tcu->domain);
> +	}
> +
> +	return 0;
> +
> +out_unmap_irqs:
> +	for (; i > 0; i--)
> +		irq_dispose_mapping(tcu->parent_irqs[i - 1]);
> +out_domain_remove:
> +	irq_domain_remove(tcu->domain);
> +	return err;
> +}
> +
> +static void __init ingenic_tcu_intc_cleanup(struct ingenic_tcu *tcu)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < tcu->nb_parent_irqs; i++)
> +		irq_dispose_mapping(tcu->parent_irqs[i]);
> +
> +	irq_domain_remove(tcu->domain);
> +}
> +
> +static int __init ingenic_tcu_timer_init(struct ingenic_tcu *tcu)
> +{
> +	unsigned int timer_virq;
> +	unsigned long rate;
> +	int err;
> +
> +	tcu->timer_clk = tcu->clocks->hws[tcu->timer_channel]->clk;
> +
> +	err = clk_prepare_enable(tcu->timer_clk);
> +	if (err)
> +		return err;
> +
> +	rate = clk_get_rate(tcu->timer_clk);
> +	if (!rate) {
> +		err = -EINVAL;
> +		goto err_clk_disable;
> +	}
> +
> +	timer_virq = irq_create_mapping(tcu->domain, tcu->timer_channel);
> +	if (!timer_virq) {
> +		err = -EINVAL;
> +		goto err_clk_disable;
> +	}
> +
> +	snprintf(tcu->name, sizeof(tcu->name), "TCU");
> +
> +	err = request_irq(timer_virq, ingenic_tcu_cevt_cb, IRQF_TIMER,
> +			  tcu->name, &tcu->cevt);
> +	if (err)
> +		goto err_irq_dispose_mapping;
> +
> +	tcu->cevt.cpumask = cpumask_of(smp_processor_id());
> +	tcu->cevt.features = CLOCK_EVT_FEAT_ONESHOT;
> +	tcu->cevt.name = tcu->name;
> +	tcu->cevt.rating = 200;
> +	tcu->cevt.set_state_shutdown = ingenic_tcu_cevt_set_state_shutdown;
> +	tcu->cevt.set_next_event = ingenic_tcu_cevt_set_next;
> +
> +	clockevents_config_and_register(&tcu->cevt, rate, 10, 0xffff);
> +
> +	return 0;
> +
> +err_irq_dispose_mapping:
> +	irq_dispose_mapping(timer_virq);
> +err_clk_disable:
> +	clk_disable_unprepare(tcu->timer_clk);
> +	return err;
> +}
> +
> +static int __init ingenic_tcu_clocksource_init(struct ingenic_tcu *tcu)
> +{
> +	unsigned int channel = tcu->cs_channel;
> +	struct clocksource *cs = &tcu->cs;
> +	unsigned long rate;
> +	int err;
> +
> +	tcu->cs_clk = tcu->clocks->hws[channel]->clk;
> +
> +	err = clk_prepare_enable(tcu->cs_clk);
> +	if (err)
> +		return err;
> +
> +	rate = clk_get_rate(tcu->cs_clk);
> +	if (!rate) {
> +		err = -EINVAL;
> +		goto err_clk_disable;
> +	}
> +
> +	/* Reset channel */
> +	regmap_update_bits(tcu->map, TCU_REG_TCSRc(channel),
> +			   0xffff & ~TCU_TCSR_RESERVED_BITS, 0);
> +
> +	/* Reset counter */
> +	regmap_write(tcu->map, TCU_REG_TDFRc(channel), 0xffff);
> +	regmap_write(tcu->map, TCU_REG_TCNTc(channel), 0);
> +
> +	/* Enable channel */
> +	regmap_write(tcu->map, TCU_REG_TESR, BIT(channel));
> +
> +	cs->name = "ingenic-timer";
> +	cs->rating = 200;
> +	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
> +	cs->mask = CLOCKSOURCE_MASK(16);
> +	cs->read = (u64 (*)(struct clocksource *))ingenic_tcu_timer_read;
> +
> +	err = clocksource_register_hz(cs, rate);
> +	if (err)
> +		goto err_clk_disable;
> +
> +	sched_clock_register(ingenic_tcu_timer_read, 16, rate);
> +
> +	return 0;
> +
> +err_clk_disable:
> +	clk_disable_unprepare(tcu->cs_clk);
> +	return err;
> +}
> +
> +static void __init ingenic_tcu_clocksource_cleanup(struct ingenic_tcu *tcu)
> +{
> +	clocksource_unregister(&tcu->cs);
> +	clk_disable_unprepare(tcu->cs_clk);
> +}
> +
> +static const struct regmap_config ingenic_tcu_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static const struct ingenic_soc_info jz4740_soc_info = {
> +	.num_channels = 8,
> +	.has_ost = false,
> +};
> +
> +static const struct ingenic_soc_info jz4725b_soc_info = {
> +	.num_channels = 6,
> +	.has_ost = true,
> +};
> +
> +static const struct ingenic_soc_info jz4770_soc_info = {
> +	.num_channels = 8,
> +	.has_ost = true,
> +};
> +
> +static const struct of_device_id ingenic_tcu_of_match[] = {
> +	{ .compatible = "ingenic,jz4740-tcu",  .data = &jz4740_soc_info, },
> +	{ .compatible = "ingenic,jz4725b-tcu", .data = &jz4725b_soc_info, },
> +	{ .compatible = "ingenic,jz4770-tcu",  .data = &jz4770_soc_info, },
> +	{ }
> +};
> +
> +static int __init ingenic_tcu_init(struct device_node *np)
> +{
> +	const struct of_device_id *id = of_match_node(ingenic_tcu_of_match, np);
> +	const struct ingenic_soc_info *soc_info = id->data;
> +	unsigned int max_pwm_num;
> +	struct ingenic_tcu *tcu;
> +	struct resource res;
> +	void __iomem *base;
> +	int ret;
> +
> +	of_node_clear_flag(np, OF_POPULATED);
> +
> +	tcu = kzalloc(sizeof(*tcu), GFP_KERNEL);
> +	if (!tcu)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Enable all TCU channels for PWM use by default except channel 0
> +	 * and, if the OS Timer is present, channel 1.
> +	 */
> +	tcu->pwm_channels_mask = GENMASK(soc_info->num_channels - 1,
> +					 2 - !!soc_info->has_ost);
> +	of_property_read_u32(np, "ingenic,pwm-channels-mask",
> +			     (u32 *)&tcu->pwm_channels_mask);
> +
> +	max_pwm_num = soc_info->num_channels - !soc_info->has_ost - 1;
> +
> +	if (hweight8(tcu->pwm_channels_mask) > max_pwm_num) {
> +		pr_crit("ingenic-tcu: Invalid PWM channel mask: 0x%02lx\n",
> +					tcu->pwm_channels_mask);
> +		return -EINVAL;
> +	}
> +
> +	tcu->soc_info = soc_info;
> +	ingenic_tcu = tcu;
> +
> +	tcu->timer_channel = find_first_zero_bit(&tcu->pwm_channels_mask,
> +						 soc_info->num_channels);
> +	if (soc_info->has_ost) {
> +		tcu->cs_channel = find_next_zero_bit(&tcu->pwm_channels_mask,
> +						     soc_info->num_channels,
> +						     tcu->timer_channel + 1);
> +	}
> +
> +	base = of_io_request_and_map(np, 0, NULL);
> +	if (IS_ERR(base)) {
> +		ret = PTR_ERR(base);
> +		goto err_free_ingenic_tcu;
> +	}
> +
> +	of_address_to_resource(np, 0, &res);
> +
> +	ingenic_tcu_base = base;
> +
> +	tcu->map = regmap_init_mmio(NULL, base, &ingenic_tcu_regmap_config);
> +	if (IS_ERR(tcu->map)) {
> +		ret = PTR_ERR(tcu->map);
> +		goto err_iounmap;
> +	}
> +
> +	tcu->clk = of_clk_get_by_name(np, "tcu");
> +	if (IS_ERR(tcu->clk)) {
> +		ret = PTR_ERR(tcu->clk);
> +		pr_crit("ingenic-tcu: Unable to find TCU clock: %i\n", ret);
> +		goto err_free_regmap;
> +	}
> +
> +	ret = clk_prepare_enable(tcu->clk);
> +	if (ret) {
> +		pr_crit("ingenic-tcu: Unable to enable TCU clock: %i\n", ret);
> +		goto err_clk_put;
> +	}
> +
> +	ret = ingenic_tcu_intc_init(tcu, np);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	ret = ingenic_tcu_clk_init(tcu, np);
> +	if (ret)
> +		goto err_tcu_intc_cleanup;
> +
> +	if (!soc_info->has_ost) {
> +		ret = ingenic_tcu_clocksource_init(tcu);
> +		if (ret)
> +			goto err_tcu_clk_cleanup;
> +	}
> +
> +	ret = ingenic_tcu_timer_init(tcu);
> +	if (ret)
> +		goto err_tcu_clocksource_cleanup;
> +
> +
> +	return 0;
> +
> +err_tcu_clocksource_cleanup:
> +	if (!soc_info->has_ost)
> +		ingenic_tcu_clocksource_cleanup(tcu);
> +err_tcu_clk_cleanup:
> +	ingenic_tcu_clk_cleanup(tcu, np);
> +err_tcu_intc_cleanup:
> +	ingenic_tcu_intc_cleanup(tcu);
> +err_clk_disable:
> +	clk_disable_unprepare(tcu->clk);
> +err_clk_put:
> +	clk_put(tcu->clk);
> +err_free_regmap:
> +	regmap_exit(tcu->map);
> +err_iounmap:
> +	iounmap(base);
> +	release_mem_region(res.start, resource_size(&res));
> +err_free_ingenic_tcu:
> +	kfree(tcu);
> +	return ret;
> +}
> +
> +TIMER_OF_DECLARE(jz4740_tcu_intc,  "ingenic,jz4740-tcu",  ingenic_tcu_init);
> +TIMER_OF_DECLARE(jz4725b_tcu_intc, "ingenic,jz4725b-tcu", ingenic_tcu_init);
> +TIMER_OF_DECLARE(jz4770_tcu_intc,  "ingenic,jz4770-tcu",  ingenic_tcu_init);
> +
> +
> +static int __init ingenic_tcu_probe(struct platform_device *pdev)
> +{
> +	platform_set_drvdata(pdev, ingenic_tcu);
> +
> +	regmap_attach_dev(&pdev->dev, ingenic_tcu->map,
> +			  &ingenic_tcu_regmap_config);
> +
> +	return devm_of_platform_populate(&pdev->dev);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ingenic_tcu_suspend(struct device *dev)
> +{
> +	struct ingenic_tcu *tcu = dev_get_drvdata(dev);
> +
> +	clk_disable(tcu->cs_clk);
> +	clk_disable(tcu->timer_clk);
> +	clk_disable(tcu->clk);
> +	return 0;
> +}
> +
> +static int ingenic_tcu_resume(struct device *dev)
> +{
> +	struct ingenic_tcu *tcu = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_enable(tcu->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_enable(tcu->timer_clk);
> +	if (ret)
> +		goto err_tcu_clk_disable;
> +
> +	ret = clk_enable(tcu->cs_clk);
> +	if (ret)
> +		goto err_tcu_timer_clk_disable;
> +
> +	return 0;
> +
> +err_tcu_timer_clk_disable:
> +	clk_disable(tcu->timer_clk);
> +err_tcu_clk_disable:
> +	clk_disable(tcu->clk);
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops ingenic_tcu_pm_ops = {
> +	/* _noirq: We want the TCU clock to be gated last / ungated first */
> +	.suspend_noirq = ingenic_tcu_suspend,
> +	.resume_noirq  = ingenic_tcu_resume,
> +};
> +#define INGENIC_TCU_PM_OPS (&ingenic_tcu_pm_ops)
> +
> +#else
> +#define INGENIC_TCU_PM_OPS NULL
> +#endif /* CONFIG_PM_SUSPEND */
> +
> +static struct platform_driver ingenic_tcu_driver = {
> +	.driver = {
> +		.name	= "ingenic-tcu",
> +		.pm	= INGENIC_TCU_PM_OPS,
> +		.of_match_table = ingenic_tcu_of_match,
> +	},
> +};
> +builtin_platform_driver_probe(ingenic_tcu_driver, ingenic_tcu_probe);
> +
> +bool ingenic_tcu_pwm_can_use_chn(unsigned int channel)
> +{
> +	return !!(ingenic_tcu->pwm_channels_mask & BIT(channel));
> +}
> +EXPORT_SYMBOL_GPL(ingenic_tcu_pwm_can_use_chn);
> diff --git a/drivers/clocksource/ingenic-timer.h b/drivers/clocksource/ingenic-timer.h
> new file mode 100644
> index 000000000000..fa43da836ab6
> --- /dev/null
> +++ b/drivers/clocksource/ingenic-timer.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __DRIVERS_CLOCKSOURCE_INGENIC_TIMER_H__
> +#define __DRIVERS_CLOCKSOURCE_INGENIC_TIMER_H__
> +
> +#include <linux/compiler_types.h>
> +
> +/*
> + * README: For use *ONLY* by the ingenic-ost driver.
> + * Regular drivers which want to access the TCU registers
> + * must have ingenic-timer as parent and retrieve the regmap
> + * doing dev_get_regmap(pdev->dev.parent);
> + */
> +extern void __iomem *ingenic_tcu_base;
> +
> +#endif /* __DRIVERS_CLOCKSOURCE_INGENIC_TIMER_H__ */
> diff --git a/include/linux/mfd/ingenic-tcu.h b/include/linux/mfd/ingenic-tcu.h
> index ab16ad283def..dac3fac35c1e 100644
> --- a/include/linux/mfd/ingenic-tcu.h
> +++ b/include/linux/mfd/ingenic-tcu.h
> @@ -53,4 +53,6 @@
>  #define TCU_REG_TCNTc(c)	(TCU_REG_TCNT0 + ((c) * TCU_CHANNEL_STRIDE))
>  #define TCU_REG_TCSRc(c)	(TCU_REG_TCSR0 + ((c) * TCU_CHANNEL_STRIDE))
>  
> +bool ingenic_tcu_pwm_can_use_chn(unsigned int channel);
> +
>  #endif /* __LINUX_MFD_INGENIC_TCU_H_ */
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

