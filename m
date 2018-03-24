Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2018 07:26:45 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:33822
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeCXG0d65T8E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Mar 2018 07:26:33 +0100
Received: by mail-wm0-x243.google.com with SMTP id a20so9576604wmd.1
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2018 23:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EHNZmwRGnRbgz7vB+GgMkna+qWDmDJBAggMpg6UKKCk=;
        b=MDFcVk9vr5i5co1VefY45Rdzak0bjSyBztGEptI3LzBF55M5X13+kbgbJjwWL8Fg1o
         5H9S5xIH+SJHuqQa0PIx6FhGDh2y7n/22Rc1j7vNWtllw6xfgGP1lB0II3V2wAU2DK3z
         7B/YFlMfh3LjPM2PEYQ0VODPusU54yfVHG3VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EHNZmwRGnRbgz7vB+GgMkna+qWDmDJBAggMpg6UKKCk=;
        b=ZuXuGt7gASKwIgNc4HMpzSB30Zgdp134Ki9kfYZLm1XrfJ62ilgr0c5lguXPtg8rHo
         76dLRR3ixlcvuNEkDRB4cZVQGHAekvZNF2fE12p9zIYhy9oI1W/XCB5nTZqz/sBMoy9C
         1V/wyWQoPInJTajKsI8cofyeHVyXiFboXGkexH+migbNs/HcMmrD7aAdbBlbVkzbAR6i
         25DV2UR6i6117kGk7frK8IlwDCKXkAFnhnpqdQF0UDC/rI8HCWWlCDDOtKu7lg86FamN
         OrWgr+UiZKje3xf1txhuYGFdiTpqMxQfD1xiXevebeuR6I/o0Ppe1mvVH6WWK8KgvETN
         wRkQ==
X-Gm-Message-State: AElRT7EKLiy4tQkxzgOVQhvTrgGqh5txZ5tiMS+oDfsbCMhAER5yZaPC
        yHnbvErOKv1fmpYbJBpOAwthQA==
X-Google-Smtp-Source: AG47ELtQQJf3Fy9PfcvSkihOsLrkskzpjnYgwX1jGWOIA6jxIG0rYQjFsJWHVpyKR9rcNkE2DFmTqA==
X-Received: by 10.80.191.4 with SMTP id f4mr32232185edk.224.1521872788319;
        Fri, 23 Mar 2018 23:26:28 -0700 (PDT)
Received: from [10.54.151.96] ([88.128.80.160])
        by smtp.googlemail.com with ESMTPSA id y14sm7482635ede.18.2018.03.23.23.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 23:26:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 7/8] clocksource: Add a new timer-ingenic driver
To:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
 <20180317232901.14129-8-paul@crapouillou.net>
Message-ID: <a8d28b2b-4e40-83b9-d65e-beecbd36ad33@linaro.org>
Date:   Sat, 24 Mar 2018 07:26:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180317232901.14129-8-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 18/03/2018 00:29, Paul Cercueil wrote:
> This driver will use the TCU (Timer Counter Unit) present on the Ingenic
> JZ47xx SoCs to provide the kernel with a clocksource and timers.

Please provide a more detailed description about the timer.

Where is the clocksource ?

I don't see the point of using channel idx and pwm checking here.

There is one clockevent, why create multiple channels ? Can't you stick
to the usual init routine for a timer.

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/clocksource/Kconfig         |   8 ++
>  drivers/clocksource/Makefile        |   1 +
>  drivers/clocksource/timer-ingenic.c | 278 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 287 insertions(+)
>  create mode 100644 drivers/clocksource/timer-ingenic.c
> 
>  v2: Use SPDX identifier for the license
>  v3: - Move documentation to its own patch
>      - Search the devicetree for PWM clients, and use all the TCU
> 	   channels that won't be used for PWM
>  v4: - Add documentation about why we search for PWM clients
>      - Verify that the PWM clients are for the TCU PWM driver
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index d2e5382821a4..481422145fb4 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -592,4 +592,12 @@ config CLKSRC_ST_LPC
>  	  Enable this option to use the Low Power controller timer
>  	  as clocksource.
>  
> +config INGENIC_TIMER
> +	bool "Clocksource/timer using the TCU in Ingenic JZ SoCs"
> +	depends on MACH_INGENIC || COMPILE_TEST

bool "Clocksource/timer using the TCU in Ingenic JZ SoCs" if COMPILE_TEST

Remove the depends MACH_INGENIC.

> +	select CLKSRC_OF
> +	default y

No default, Kconfig platform selects the timer.

> +	help
> +	  Support for the timer/counter unit of the Ingenic JZ SoCs.
> +
>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index d6dec4489d66..98691e8999fe 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -74,5 +74,6 @@ obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
>  obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
>  obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
>  obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
> +obj-$(CONFIG_INGENIC_TIMER)		+= timer-ingenic.o
>  obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
> diff --git a/drivers/clocksource/timer-ingenic.c b/drivers/clocksource/timer-ingenic.c
> new file mode 100644
> index 000000000000..8c777c0c0023
> --- /dev/null
> +++ b/drivers/clocksource/timer-ingenic.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Ingenic JZ47xx SoC TCU clocksource driver
> + * Copyright (C) 2018 Paul Cercueil <paul@crapouillou.net>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/ingenic-tcu.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define NUM_CHANNELS	8
> +
> +struct ingenic_tcu;
> +
> +struct ingenic_tcu_channel {
> +	unsigned int idx;
> +	struct clk *clk;
> +};
> +
> +struct ingenic_tcu {
> +	struct ingenic_tcu_channel channels[NUM_CHANNELS];
> +	unsigned long requested;
> +	struct regmap *map;
> +};
> +
> +struct ingenic_clock_event_device {
> +	struct clock_event_device cevt;
> +	struct ingenic_tcu_channel *channel;
> +	char name[32];
> +};
> +
> +#define ingenic_cevt(_evt) \
> +	container_of(_evt, struct ingenic_clock_event_device, cevt)
> +
> +static inline struct ingenic_tcu *to_ingenic_tcu(struct ingenic_tcu_channel *ch)
> +{
> +	return container_of(ch, struct ingenic_tcu, channels[ch->idx]);
> +}
> +
> +static int ingenic_tcu_cevt_set_state_shutdown(struct clock_event_device *evt)
> +{
> +	struct ingenic_clock_event_device *jzcevt = ingenic_cevt(evt);
> +	struct ingenic_tcu_channel *channel = jzcevt->channel;
> +	struct ingenic_tcu *tcu = to_ingenic_tcu(channel);
> +	unsigned int idx = channel->idx;
> +
> +	regmap_write(tcu->map, TCU_REG_TECR, BIT(idx));
> +	return 0;
> +}
> +
> +static int ingenic_tcu_cevt_set_next(unsigned long next,
> +		struct clock_event_device *evt)
> +{
> +	struct ingenic_clock_event_device *jzcevt = ingenic_cevt(evt);
> +	struct ingenic_tcu_channel *channel = jzcevt->channel;
> +	struct ingenic_tcu *tcu = to_ingenic_tcu(channel);
> +	unsigned int idx = channel->idx;
> +
> +	if (next > 0xffff)
> +		return -EINVAL;
> +
> +	regmap_write(tcu->map, TCU_REG_TDFRc(idx), (unsigned int) next);
> +	regmap_write(tcu->map, TCU_REG_TCNTc(idx), 0);
> +	regmap_write(tcu->map, TCU_REG_TESR, BIT(idx));
> +
> +	return 0;
> +}
> +
> +static irqreturn_t ingenic_tcu_cevt_cb(int irq, void *dev_id)
> +{
> +	struct clock_event_device *cevt = dev_id;
> +	struct ingenic_clock_event_device *jzcevt = ingenic_cevt(cevt);
> +	struct ingenic_tcu_channel *channel = jzcevt->channel;
> +	struct ingenic_tcu *tcu = to_ingenic_tcu(channel);
> +	unsigned int idx = channel->idx;
> +
> +	regmap_write(tcu->map, TCU_REG_TECR, BIT(idx));
> +
> +	if (cevt->event_handler)
> +		cevt->event_handler(cevt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init ingenic_tcu_req_channel(struct ingenic_tcu_channel *channel)
> +{
> +	struct ingenic_tcu *tcu = to_ingenic_tcu(channel);
> +	char buf[16];
> +	int err;
> +
> +	if (test_and_set_bit(channel->idx, &tcu->requested))
> +		return -EBUSY;
> +
> +	snprintf(buf, sizeof(buf), "timer%u", channel->idx);
> +	channel->clk = clk_get(NULL, buf);
> +	if (IS_ERR(channel->clk)) {
> +		err = PTR_ERR(channel->clk);
> +		goto out_release;
> +	}
> +
> +	err = clk_prepare_enable(channel->clk);
> +	if (err)
> +		goto out_clk_put;
> +
> +	return 0;
> +
> +out_clk_put:
> +	clk_put(channel->clk);
> +out_release:
> +	clear_bit(channel->idx, &tcu->requested);
> +	return err;
> +}
> +
> +static int __init ingenic_tcu_reset_channel(struct device_node *np,
> +		struct ingenic_tcu_channel *channel)
> +{
> +	struct ingenic_tcu *tcu = to_ingenic_tcu(channel);
> +
> +	return regmap_update_bits(tcu->map, TCU_REG_TCSRc(channel->idx),
> +				0xffff & ~TCU_TCSR_RESERVED_BITS, 0);
> +}
> +
> +static void __init ingenic_tcu_free_channel(struct ingenic_tcu_channel *channel)
> +{
> +	struct ingenic_tcu *tcu = to_ingenic_tcu(channel);
> +
> +	clk_disable_unprepare(channel->clk);
> +	clk_put(channel->clk);
> +	clear_bit(channel->idx, &tcu->requested);
> +}
> +
> +static const char * const ingenic_tcu_timer_names[] = {
> +	"TCU0", "TCU1", "TCU2", "TCU3", "TCU4", "TCU5", "TCU6", "TCU7",
> +};
> +
> +static int __init ingenic_tcu_setup_cevt(struct device_node *np,
> +		struct ingenic_tcu *tcu, unsigned int idx)
> +{
> +	struct ingenic_tcu_channel *channel = &tcu->channels[idx];
> +	struct ingenic_clock_event_device *jzcevt;
> +	unsigned long rate;
> +	int err, virq;
> +
> +	err = ingenic_tcu_req_channel(channel);
> +	if (err)
> +		return err;
> +
> +	err = ingenic_tcu_reset_channel(np, channel);
> +	if (err)
> +		goto err_out_free_channel;
> +
> +	rate = clk_get_rate(channel->clk);
> +	if (!rate) {
> +		err = -EINVAL;
> +		goto err_out_free_channel;
> +	}
> +
> +	jzcevt = kzalloc(sizeof(*jzcevt), GFP_KERNEL);
> +	if (!jzcevt) {
> +		err = -ENOMEM;
> +		goto err_out_free_channel;
> +	}
> +
> +	virq = irq_of_parse_and_map(np, idx);
> +	if (!virq) {
> +		err = -EINVAL;
> +		goto err_out_kfree_jzcevt;
> +	}
> +
> +	err = request_irq(virq, ingenic_tcu_cevt_cb, IRQF_TIMER,
> +			ingenic_tcu_timer_names[idx], &jzcevt->cevt);
> +	if (err)
> +		goto err_out_irq_dispose_mapping;
> +
> +	jzcevt->channel = channel;
> +	snprintf(jzcevt->name, sizeof(jzcevt->name), "ingenic-tcu-chan%u",
> +		 channel->idx);
> +
> +	jzcevt->cevt.cpumask = cpumask_of(smp_processor_id());
> +	jzcevt->cevt.features = CLOCK_EVT_FEAT_ONESHOT;
> +	jzcevt->cevt.name = jzcevt->name;
> +	jzcevt->cevt.rating = 200;
> +	jzcevt->cevt.set_state_shutdown = ingenic_tcu_cevt_set_state_shutdown;
> +	jzcevt->cevt.set_next_event = ingenic_tcu_cevt_set_next;
> +
> +	clockevents_config_and_register(&jzcevt->cevt, rate, 10, (1 << 16) - 1);
> +
> +	return 0;
> +
> +err_out_irq_dispose_mapping:
> +	irq_dispose_mapping(virq);
> +err_out_kfree_jzcevt:
> +	kfree(jzcevt);
> +err_out_free_channel:
> +	ingenic_tcu_free_channel(channel);
> +	return err;
> +}
> +
> +static int __init ingenic_tcu_init(struct device_node *np)
> +{
> +	unsigned long available_channels = GENMASK(NUM_CHANNELS - 1, 0);
> +	struct device_node *node, *pwm_driver_node;
> +	struct ingenic_tcu *tcu;
> +	unsigned int i, channel;
> +	int err;
> +	u32 val;
> +
> +	/* Parse the devicetree for clients of the TCU PWM driver;
> +	 * every TCU channel not requested for PWM will be used as
> +	 * a timer.
> +	 */



> +	for_each_node_with_property(node, "pwms") {
> +		/* Get the PWM channel ID (field 1 of the "pwms" node) */
> +		err = of_property_read_u32_index(node, "pwms", 1, &val);
> +		if (!err && val >= NUM_CHANNELS)
> +			err = -EINVAL;
> +		if (err) {
> +			pr_err("timer-ingenic: Unable to parse PWM nodes!");
> +			break;
> +		}
> +
> +		/* Get the PWM driver node (field 0 of the "pwms" node) */
> +		pwm_driver_node = of_parse_phandle(node, "pwms", 0);
> +		if (!pwm_driver_node) {
> +			pr_err("timer-ingenic: Unable to find PWM driver node");
> +			break;
> +		}
> +
> +		/* Verify that the node we found is for the TCU PWM driver,
> +		 * by checking that this driver and the PWM driver passed
> +		 * as phandle share the same parent (the "ingenic,tcu"
> +		 * compatible MFD/syscon node).
> +		 */
> +		if (pwm_driver_node->parent != np->parent)
> +			continue;
> +
> +		pr_info("timer-ingenic: Reserving channel %u for PWM", val);
> +		available_channels &= ~BIT(val);
> +	}
> +
> +	tcu = kzalloc(sizeof(*tcu), GFP_KERNEL);
> +	if (!tcu)
> +		return -ENOMEM;
> +
> +	tcu->map = syscon_node_to_regmap(np->parent);
> +	if (IS_ERR(tcu->map)) {
> +		err = PTR_ERR(tcu->map);
> +		kfree(tcu);
> +		return err;
> +	}
> +
> +	for (i = 0; i < NUM_CHANNELS; i++)
> +		tcu->channels[i].idx = i;

I'm pretty sure you can do better thaningenic_tcu_setup that :)

> +	for_each_set_bit(channel, &available_channels, NUM_CHANNELS) {
> +		err = _cevt(np, tcu, channel);
> +		if (err) {
> +			pr_warn("timer-ingenic: Unable to init TCU channel %u: %i",
> +					channel, err);
> +			continue;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/* We only probe via devicetree, no need for a platform driver */
> +CLOCKSOURCE_OF_DECLARE(jz4740_tcu, "ingenic,jz4740-tcu", ingenic_tcu_init);
> +CLOCKSOURCE_OF_DECLARE(jz4770_tcu, "ingenic,jz4770-tcu", ingenic_tcu_init);
> +CLOCKSOURCE_OF_DECLARE(jz4780_tcu, "ingenic,jz4780-tcu", ingenic_tcu_init);

s/CLOCKSOURCE_OF_DECLARE/TIMER_OF_DECLARE/

> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
