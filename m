Return-Path: <SRS0=CBLp=R6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB3BC43381
	for <linux-mips@archiver.kernel.org>; Wed, 27 Mar 2019 23:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584782075C
	for <linux-mips@archiver.kernel.org>; Wed, 27 Mar 2019 23:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="xkfLfe2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfC0XRH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:17:07 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:58490 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfC0XRG (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 27 Mar 2019 19:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553728623; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=62MRtFz3VGnltzlL3cw4x9QcGk35sgJovfzSKaxeKBc=;
        b=xkfLfe2+4fSCE9ITBAjNqGc5xRbeMi0fpdBCTpzTyxtEwnE4S1n0JBnNsHvH0b/Olk3H1O
        9BzrntnALOj040Oy1I+qm6zDiqMz8Uy5bISYJuTxF3kbb6MbFOrAuHJHyONmIGbCZYVVmd
        GPcw2Ycai6rHVS3Xg5X3GbIN0rtalm0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v11 04/27] clocksource: Add a new timer-ingenic driver
Date:   Thu, 28 Mar 2019 00:16:08 +0100
Message-Id: <20190327231631.15708-5-paul@crapouillou.net>
In-Reply-To: <20190327231631.15708-1-paul@crapouillou.net>
References: <20190327231631.15708-1-paul@crapouillou.net>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This driver handles the TCU (Timer Counter Unit) present on the Ingenic
JZ47xx SoCs, and provides the kernel with a system timer, and optionally
with a clocksource and a sched_clock.

It also provides clocks and interrupt handling to client drivers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/clocksource/Kconfig         |  10 +
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/ingenic-timer.c | 920 ++++++++++++++++++++++++++++++++++++
 drivers/clocksource/ingenic-timer.h |  15 +
 include/linux/mfd/ingenic-tcu.h     |   4 +
 5 files changed, 950 insertions(+)
 create mode 100644 drivers/clocksource/ingenic-timer.c
 create mode 100644 drivers/clocksource/ingenic-timer.h

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 171502a356aa..c6fb17233ff2 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -645,6 +645,16 @@ config GX6605S_TIMER
 	help
 	  This option enables support for gx6605s SOC's timer.
 
+config INGENIC_TIMER
+	bool "Clocksource/timer using the TCU in Ingenic JZ SoCs"
+	depends on MIPS || COMPILE_TEST
+	depends on COMMON_CLK
+	select TIMER_OF
+	select IRQ_DOMAIN
+	select REGMAP
+	help
+	  Support for the timer/counter unit of the Ingenic JZ SoCs.
+
 config MILBEAUT_TIMER
 	bool "Milbeaut timer driver" if COMPILE_TEST
 	depends on OF
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index be6e0fbc7489..0e360da7b74d 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
 obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
 obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
+obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingenic-timer.c
new file mode 100644
index 000000000000..dc446f280fd3
--- /dev/null
+++ b/drivers/clocksource/ingenic-timer.c
@@ -0,0 +1,920 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * JZ47xx SoCs TCU IRQ driver
+ * Copyright (C) 2019 Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/mfd/ingenic-tcu.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/sched_clock.h>
+
+#include <dt-bindings/clock/ingenic,tcu.h>
+
+#include "ingenic-timer.h"
+
+/* 8 channels max + watchdog + OST */
+#define TCU_CLK_COUNT	10
+
+enum tcu_clk_parent {
+	TCU_PARENT_PCLK,
+	TCU_PARENT_RTC,
+	TCU_PARENT_EXT,
+};
+
+struct ingenic_soc_info {
+	unsigned char num_channels;
+	bool has_ost;
+};
+
+struct ingenic_tcu_clk_info {
+	struct clk_init_data init_data;
+	u8 gate_bit;
+	u8 tcsr_reg;
+};
+
+struct ingenic_tcu_clk {
+	struct clk_hw hw;
+
+	struct regmap *map;
+	const struct ingenic_tcu_clk_info *info;
+
+	unsigned int idx;
+};
+
+struct ingenic_tcu {
+	const struct ingenic_soc_info *soc_info;
+	struct regmap *map;
+	struct clk *clk, *timer_clk, *cs_clk;
+
+	struct irq_domain *domain;
+	unsigned int nb_parent_irqs;
+	u32 parent_irqs[3];
+
+	struct clk_hw_onecell_data *clocks;
+
+	unsigned int timer_channel, cs_channel;
+	struct clock_event_device cevt;
+	struct clocksource cs;
+	char name[4];
+
+	unsigned long pwm_channels_mask;
+};
+
+static struct ingenic_tcu *ingenic_tcu;
+
+void __iomem *ingenic_tcu_base;
+EXPORT_SYMBOL_GPL(ingenic_tcu_base);
+
+static inline struct ingenic_tcu_clk *to_tcu_clk(struct clk_hw *hw)
+{
+	return container_of(hw, struct ingenic_tcu_clk, hw);
+}
+
+static int ingenic_tcu_enable(struct clk_hw *hw)
+{
+	struct ingenic_tcu_clk *tcu_clk = to_tcu_clk(hw);
+	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
+
+	regmap_write(tcu_clk->map, TCU_REG_TSCR, BIT(info->gate_bit));
+
+	return 0;
+}
+
+static void ingenic_tcu_disable(struct clk_hw *hw)
+{
+	struct ingenic_tcu_clk *tcu_clk = to_tcu_clk(hw);
+	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
+
+	regmap_write(tcu_clk->map, TCU_REG_TSSR, BIT(info->gate_bit));
+}
+
+static int ingenic_tcu_is_enabled(struct clk_hw *hw)
+{
+	struct ingenic_tcu_clk *tcu_clk = to_tcu_clk(hw);
+	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
+	unsigned int value;
+
+	regmap_read(tcu_clk->map, TCU_REG_TSR, &value);
+
+	return !(value & BIT(info->gate_bit));
+}
+
+static u8 ingenic_tcu_get_parent(struct clk_hw *hw)
+{
+	struct ingenic_tcu_clk *tcu_clk = to_tcu_clk(hw);
+	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
+	unsigned int val = 0;
+	int ret;
+
+	ret = regmap_read(tcu_clk->map, info->tcsr_reg, &val);
+	WARN_ONCE(ret < 0, "Unable to read TCSR %i", tcu_clk->idx);
+
+	return ffs(val & TCU_TCSR_PARENT_CLOCK_MASK) - 1;
+}
+
+static int ingenic_tcu_set_parent(struct clk_hw *hw, u8 idx)
+{
+	struct ingenic_tcu_clk *tcu_clk = to_tcu_clk(hw);
+	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
+	int ret, enabled;
+
+	/*
+	 * To be able to access TCSR we must ungate the clock supply and we gate
+	 * it again when done.
+	 */
+	enabled = ingenic_tcu_is_enabled(hw);
+	ingenic_tcu_enable(hw);
+
+	ret = regmap_update_bits(tcu_clk->map, info->tcsr_reg,
+				 TCU_TCSR_PARENT_CLOCK_MASK, BIT(idx));
+	WARN_ONCE(ret < 0, "Unable to update TCSR %i", tcu_clk->idx);
+
+	if (!enabled)
+		ingenic_tcu_disable(hw);
+
+	return 0;
+}
+
+static unsigned long ingenic_tcu_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct ingenic_tcu_clk *tcu_clk = to_tcu_clk(hw);
+	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
+	unsigned int prescale;
+	int ret;
+
+	ret = regmap_read(tcu_clk->map, info->tcsr_reg, &prescale);
+	WARN_ONCE(ret < 0, "Unable to read TCSR %i", tcu_clk->idx);
+
+	prescale = (prescale & TCU_TCSR_PRESCALE_MASK) >> TCU_TCSR_PRESCALE_LSB;
+
+	return parent_rate >> (prescale * 2);
+}
+
+static u8 ingenic_tcu_get_prescale(unsigned long rate, unsigned long req_rate)
+{
+	u8 prescale;
+
+	for (prescale = 0; prescale < 5; prescale++)
+		if ((rate >> (prescale * 2)) <= req_rate)
+			return prescale;
+
+	return 5; /* /1024 divider */
+}
+
+static long ingenic_tcu_round_rate(struct clk_hw *hw, unsigned long req_rate,
+		unsigned long *parent_rate)
+{
+	unsigned long rate = *parent_rate;
+	u8 prescale;
+
+	if (req_rate > rate)
+		return -EINVAL;
+
+	prescale = ingenic_tcu_get_prescale(rate, req_rate);
+
+	return rate >> (prescale * 2);
+}
+
+static int ingenic_tcu_set_rate(struct clk_hw *hw, unsigned long req_rate,
+		unsigned long parent_rate)
+{
+	struct ingenic_tcu_clk *tcu_clk = to_tcu_clk(hw);
+	const struct ingenic_tcu_clk_info *info = tcu_clk->info;
+	struct regmap *map = tcu_clk->map;
+	u8 prescale = ingenic_tcu_get_prescale(parent_rate, req_rate);
+	int ret;
+
+	ret = regmap_update_bits(map, info->tcsr_reg,
+				 TCU_TCSR_PRESCALE_MASK,
+				 prescale << TCU_TCSR_PRESCALE_LSB);
+	WARN_ONCE(ret < 0, "Unable to update TCSR %i", tcu_clk->idx);
+
+	return 0;
+}
+
+static const struct clk_ops ingenic_tcu_clk_ops = {
+	.get_parent	= ingenic_tcu_get_parent,
+	.set_parent	= ingenic_tcu_set_parent,
+
+	.recalc_rate	= ingenic_tcu_recalc_rate,
+	.round_rate	= ingenic_tcu_round_rate,
+	.set_rate	= ingenic_tcu_set_rate,
+
+	.enable		= ingenic_tcu_enable,
+	.disable	= ingenic_tcu_disable,
+	.is_enabled	= ingenic_tcu_is_enabled,
+};
+
+static const char * const ingenic_tcu_timer_parents[] = {
+	[TCU_PARENT_PCLK] = "pclk",
+	[TCU_PARENT_RTC]  = "rtc",
+	[TCU_PARENT_EXT]  = "ext",
+};
+
+#define DEF_TIMER(_name, _gate_bit, _tcsr)				\
+	{								\
+		.init_data = {						\
+			.name = _name,					\
+			.parent_names = ingenic_tcu_timer_parents,	\
+			.num_parents = ARRAY_SIZE(ingenic_tcu_timer_parents),\
+			.ops = &ingenic_tcu_clk_ops,			\
+			.flags = CLK_SET_RATE_UNGATE,			\
+		},							\
+		.gate_bit = _gate_bit,					\
+		.tcsr_reg = _tcsr,					\
+	}
+static const struct ingenic_tcu_clk_info ingenic_tcu_clk_info[] = {
+	[TCU_CLK_TIMER0] = DEF_TIMER("timer0", 0, TCU_REG_TCSRc(0)),
+	[TCU_CLK_TIMER1] = DEF_TIMER("timer1", 1, TCU_REG_TCSRc(1)),
+	[TCU_CLK_TIMER2] = DEF_TIMER("timer2", 2, TCU_REG_TCSRc(2)),
+	[TCU_CLK_TIMER3] = DEF_TIMER("timer3", 3, TCU_REG_TCSRc(3)),
+	[TCU_CLK_TIMER4] = DEF_TIMER("timer4", 4, TCU_REG_TCSRc(4)),
+	[TCU_CLK_TIMER5] = DEF_TIMER("timer5", 5, TCU_REG_TCSRc(5)),
+	[TCU_CLK_TIMER6] = DEF_TIMER("timer6", 6, TCU_REG_TCSRc(6)),
+	[TCU_CLK_TIMER7] = DEF_TIMER("timer7", 7, TCU_REG_TCSRc(7)),
+};
+
+static const struct ingenic_tcu_clk_info ingenic_tcu_watchdog_clk_info =
+					 DEF_TIMER("wdt", 16, TCU_REG_WDT_TCSR);
+static const struct ingenic_tcu_clk_info ingenic_tcu_ost_clk_info =
+					 DEF_TIMER("ost", 15, TCU_REG_OST_TCSR);
+#undef DEF_TIMER
+
+static void ingenic_tcu_intc_cascade(struct irq_desc *desc)
+{
+	struct irq_chip *irq_chip = irq_data_get_irq_chip(&desc->irq_data);
+	struct irq_domain *domain = irq_desc_get_handler_data(desc);
+	struct irq_chip_generic *gc = irq_get_domain_generic_chip(domain, 0);
+	struct regmap *map = gc->private;
+	uint32_t irq_reg, irq_mask;
+	unsigned int i;
+
+	regmap_read(map, TCU_REG_TFR, &irq_reg);
+	regmap_read(map, TCU_REG_TMR, &irq_mask);
+
+	chained_irq_enter(irq_chip, desc);
+
+	irq_reg &= ~irq_mask;
+
+	for_each_set_bit(i, (unsigned long *)&irq_reg, 32)
+		generic_handle_irq(irq_linear_revmap(domain, i));
+
+	chained_irq_exit(irq_chip, desc);
+}
+
+static void ingenic_tcu_gc_unmask_enable_reg(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	struct regmap *map = gc->private;
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	regmap_write(map, ct->regs.ack, mask);
+	regmap_write(map, ct->regs.enable, mask);
+	*ct->mask_cache |= mask;
+	irq_gc_unlock(gc);
+}
+
+static void ingenic_tcu_gc_mask_disable_reg(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	struct regmap *map = gc->private;
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	regmap_write(map, ct->regs.disable, mask);
+	*ct->mask_cache &= ~mask;
+	irq_gc_unlock(gc);
+}
+
+static void ingenic_tcu_gc_mask_disable_reg_and_ack(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	struct regmap *map = gc->private;
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	regmap_write(map, ct->regs.ack, mask);
+	regmap_write(map, ct->regs.disable, mask);
+	irq_gc_unlock(gc);
+}
+
+static inline struct ingenic_tcu *cs_to_ingenic_tcu(struct clocksource *cs)
+{
+	return container_of(cs, struct ingenic_tcu, cs);
+}
+
+static inline struct ingenic_tcu *to_ingenic_tcu(struct clock_event_device *evt)
+{
+	return container_of(evt, struct ingenic_tcu, cevt);
+}
+
+static int ingenic_tcu_cevt_set_state_shutdown(struct clock_event_device *evt)
+{
+	struct ingenic_tcu *tcu = to_ingenic_tcu(evt);
+
+	regmap_write(tcu->map, TCU_REG_TECR, BIT(tcu->timer_channel));
+
+	return 0;
+}
+
+static u64 notrace ingenic_tcu_timer_read(void)
+{
+	unsigned int channel = ingenic_tcu->cs_channel;
+	u16 count;
+
+	/* Bypass the regmap here as we must return as soon as possible */
+	count = readw(ingenic_tcu_base + TCU_REG_TCNTc(channel));
+
+	return count;
+}
+
+static u64 notrace ingenic_tcu_timer_cs_read(struct clocksource *cs)
+{
+	struct ingenic_tcu *tcu = cs_to_ingenic_tcu(cs);
+	unsigned int val;
+
+	regmap_read(tcu->map, TCU_REG_TCNTc(tcu->cs_channel), &val);
+
+	return val;
+}
+
+static int ingenic_tcu_cevt_set_next(unsigned long next,
+				     struct clock_event_device *evt)
+{
+	struct ingenic_tcu *tcu = to_ingenic_tcu(evt);
+
+	if (next > 0xffff)
+		return -EINVAL;
+
+	regmap_write(tcu->map, TCU_REG_TDFRc(tcu->timer_channel), next);
+	regmap_write(tcu->map, TCU_REG_TCNTc(tcu->timer_channel), 0);
+	regmap_write(tcu->map, TCU_REG_TESR, BIT(tcu->timer_channel));
+
+	return 0;
+}
+
+static irqreturn_t ingenic_tcu_cevt_cb(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	struct ingenic_tcu *tcu = to_ingenic_tcu(evt);
+
+	regmap_write(tcu->map, TCU_REG_TECR, BIT(tcu->timer_channel));
+
+	if (evt->event_handler)
+		evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init ingenic_tcu_register_clock(struct ingenic_tcu *tcu,
+			unsigned int idx, enum tcu_clk_parent parent,
+			const struct ingenic_tcu_clk_info *info,
+			struct clk_hw_onecell_data *clocks)
+{
+	struct ingenic_tcu_clk *tcu_clk;
+	int err;
+
+	tcu_clk = kzalloc(sizeof(*tcu_clk), GFP_KERNEL);
+	if (!tcu_clk)
+		return -ENOMEM;
+
+	tcu_clk->hw.init = &info->init_data;
+	tcu_clk->idx = idx;
+	tcu_clk->info = info;
+	tcu_clk->map = tcu->map;
+
+	/* Reset channel and clock divider, set default parent */
+	ingenic_tcu_enable(&tcu_clk->hw);
+	regmap_update_bits(tcu->map, info->tcsr_reg, 0xffff, BIT(parent));
+	ingenic_tcu_disable(&tcu_clk->hw);
+
+	err = clk_hw_register(NULL, &tcu_clk->hw);
+	if (err)
+		goto err_free_tcu_clk;
+
+	err = clk_hw_register_clkdev(&tcu_clk->hw, info->init_data.name, NULL);
+	if (err)
+		goto err_clk_unregister;
+
+	clocks->hws[idx] = &tcu_clk->hw;
+
+	return 0;
+
+err_clk_unregister:
+	clk_hw_unregister(&tcu_clk->hw);
+err_free_tcu_clk:
+	kfree(tcu_clk);
+	return err;
+}
+
+static int __init ingenic_tcu_clk_init(struct ingenic_tcu *tcu,
+				       struct device_node *np)
+{
+	size_t i;
+	int ret;
+
+	tcu->clocks = kzalloc(sizeof(*tcu->clocks) +
+			      sizeof(*tcu->clocks->hws) * TCU_CLK_COUNT,
+			      GFP_KERNEL);
+	if (!tcu->clocks)
+		return -ENOMEM;
+
+	tcu->clocks->num = TCU_CLK_COUNT;
+
+	for (i = 0; i < tcu->soc_info->num_channels; i++) {
+		ret = ingenic_tcu_register_clock(tcu, i, TCU_PARENT_EXT,
+						 &ingenic_tcu_clk_info[i],
+						 tcu->clocks);
+		if (ret) {
+			pr_crit("ingenic-timer: cannot register clock timer%zu\n", i);
+			goto err_unregister_timer_clocks;
+		}
+	}
+
+	/*
+	 * We set EXT as the default parent clock for all the TCU clocks
+	 * except for the watchdog one, where we set the RTC clock as the
+	 * parent. Since the EXT and PCLK are much faster than the RTC clock,
+	 * the watchdog would kick after a maximum time of 5s, and we might
+	 * want a slower kicking time.
+	 */
+	ret = ingenic_tcu_register_clock(tcu, TCU_CLK_WDT, TCU_PARENT_RTC,
+					 &ingenic_tcu_watchdog_clk_info,
+					 tcu->clocks);
+	if (ret) {
+		pr_crit("ingenic-timer: cannot register watchdog clock\n");
+		goto err_unregister_timer_clocks;
+	}
+
+	if (tcu->soc_info->has_ost) {
+		ret = ingenic_tcu_register_clock(tcu, TCU_CLK_OST,
+						 TCU_PARENT_EXT,
+						 &ingenic_tcu_ost_clk_info,
+						 tcu->clocks);
+		if (ret) {
+			pr_crit("ingenic-timer: cannot register ost clock\n");
+			goto err_unregister_watchdog_clock;
+		}
+	}
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, tcu->clocks);
+	if (ret) {
+		pr_crit("ingenic-timer: cannot add OF clock provider\n");
+		goto err_unregister_ost_clock;
+	}
+
+	return 0;
+
+err_unregister_ost_clock:
+	if (tcu->soc_info->has_ost)
+		clk_hw_unregister(tcu->clocks->hws[i + 1]);
+err_unregister_watchdog_clock:
+	clk_hw_unregister(tcu->clocks->hws[i]);
+err_unregister_timer_clocks:
+	for (i = 0; i < tcu->clocks->num; i++)
+		if (tcu->clocks->hws[i])
+			clk_hw_unregister(tcu->clocks->hws[i]);
+	kfree(tcu->clocks);
+	return ret;
+}
+
+static void __init ingenic_tcu_clk_cleanup(struct ingenic_tcu *tcu,
+					   struct device_node *np)
+{
+	unsigned int i;
+
+	of_clk_del_provider(np);
+
+	for (i = 0; i < tcu->clocks->num; i++)
+		clk_hw_unregister(tcu->clocks->hws[i]);
+	kfree(tcu->clocks);
+}
+
+static int __init ingenic_tcu_intc_init(struct ingenic_tcu *tcu,
+					struct device_node *np)
+{
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	int err, i, irqs;
+
+	irqs = of_property_count_elems_of_size(np, "interrupts", sizeof(u32));
+	if (irqs < 0 || irqs > ARRAY_SIZE(tcu->parent_irqs))
+		return -EINVAL;
+
+	tcu->nb_parent_irqs = irqs;
+
+	tcu->domain = irq_domain_add_linear(np, 32, &irq_generic_chip_ops,
+					    NULL);
+	if (!tcu->domain)
+		return -ENOMEM;
+
+	err = irq_alloc_domain_generic_chips(tcu->domain, 32, 1, "TCU",
+					     handle_level_irq, 0,
+					     IRQ_NOPROBE | IRQ_LEVEL, 0);
+	if (err)
+		goto out_domain_remove;
+
+	gc = irq_get_domain_generic_chip(tcu->domain, 0);
+	ct = gc->chip_types;
+
+	gc->wake_enabled = IRQ_MSK(32);
+	gc->private = tcu->map;
+
+	ct->regs.disable = TCU_REG_TMSR;
+	ct->regs.enable = TCU_REG_TMCR;
+	ct->regs.ack = TCU_REG_TFCR;
+	ct->chip.irq_unmask = ingenic_tcu_gc_unmask_enable_reg;
+	ct->chip.irq_mask = ingenic_tcu_gc_mask_disable_reg;
+	ct->chip.irq_mask_ack = ingenic_tcu_gc_mask_disable_reg_and_ack;
+	ct->chip.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
+
+	/* Mask all IRQs by default */
+	regmap_write(tcu->map, TCU_REG_TMSR, IRQ_MSK(32));
+
+	/*
+	 * On JZ4740, timer 0 and timer 1 have their own interrupt line;
+	 * timers 2-7 share one interrupt.
+	 * On SoCs >= JZ4770, timer 5 has its own interrupt line;
+	 * timers 0-4 and 6-7 share one single interrupt.
+	 *
+	 * To keep things simple, we just register the same handler to
+	 * all parent interrupts. The handler will properly detect which
+	 * channel fired the interrupt.
+	 */
+	for (i = 0; i < irqs; i++) {
+		tcu->parent_irqs[i] = irq_of_parse_and_map(np, i);
+		if (!tcu->parent_irqs[i]) {
+			err = -EINVAL;
+			goto out_unmap_irqs;
+		}
+
+		irq_set_chained_handler_and_data(tcu->parent_irqs[i],
+						 ingenic_tcu_intc_cascade,
+						 tcu->domain);
+	}
+
+	return 0;
+
+out_unmap_irqs:
+	for (; i > 0; i--)
+		irq_dispose_mapping(tcu->parent_irqs[i - 1]);
+out_domain_remove:
+	irq_domain_remove(tcu->domain);
+	return err;
+}
+
+static void __init ingenic_tcu_intc_cleanup(struct ingenic_tcu *tcu)
+{
+	unsigned int i;
+
+	for (i = 0; i < tcu->nb_parent_irqs; i++)
+		irq_dispose_mapping(tcu->parent_irqs[i]);
+
+	irq_domain_remove(tcu->domain);
+}
+
+static int __init ingenic_tcu_timer_init(struct ingenic_tcu *tcu)
+{
+	unsigned int timer_virq;
+	unsigned long rate;
+	int err;
+
+	tcu->timer_clk = tcu->clocks->hws[tcu->timer_channel]->clk;
+
+	err = clk_prepare_enable(tcu->timer_clk);
+	if (err)
+		return err;
+
+	rate = clk_get_rate(tcu->timer_clk);
+	if (!rate) {
+		err = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	timer_virq = irq_create_mapping(tcu->domain, tcu->timer_channel);
+	if (!timer_virq) {
+		err = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	snprintf(tcu->name, sizeof(tcu->name), "TCU");
+
+	err = request_irq(timer_virq, ingenic_tcu_cevt_cb, IRQF_TIMER,
+			  tcu->name, &tcu->cevt);
+	if (err)
+		goto err_irq_dispose_mapping;
+
+	tcu->cevt.cpumask = cpumask_of(smp_processor_id());
+	tcu->cevt.features = CLOCK_EVT_FEAT_ONESHOT;
+	tcu->cevt.name = tcu->name;
+	tcu->cevt.rating = 200;
+	tcu->cevt.set_state_shutdown = ingenic_tcu_cevt_set_state_shutdown;
+	tcu->cevt.set_next_event = ingenic_tcu_cevt_set_next;
+
+	clockevents_config_and_register(&tcu->cevt, rate, 10, 0xffff);
+
+	return 0;
+
+err_irq_dispose_mapping:
+	irq_dispose_mapping(timer_virq);
+err_clk_disable:
+	clk_disable_unprepare(tcu->timer_clk);
+	return err;
+}
+
+static int __init ingenic_tcu_clocksource_init(struct ingenic_tcu *tcu)
+{
+	unsigned int channel = tcu->cs_channel;
+	struct clocksource *cs = &tcu->cs;
+	unsigned long rate;
+	int err;
+
+	tcu->cs_clk = tcu->clocks->hws[channel]->clk;
+
+	err = clk_prepare_enable(tcu->cs_clk);
+	if (err)
+		return err;
+
+	rate = clk_get_rate(tcu->cs_clk);
+	if (!rate) {
+		err = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	/* Reset channel */
+	regmap_update_bits(tcu->map, TCU_REG_TCSRc(channel),
+			   0xffff & ~TCU_TCSR_RESERVED_BITS, 0);
+
+	/* Reset counter */
+	regmap_write(tcu->map, TCU_REG_TDFRc(channel), 0xffff);
+	regmap_write(tcu->map, TCU_REG_TCNTc(channel), 0);
+
+	/* Enable channel */
+	regmap_write(tcu->map, TCU_REG_TESR, BIT(channel));
+
+	cs->name = "ingenic-timer";
+	cs->rating = 200;
+	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	cs->mask = CLOCKSOURCE_MASK(16);
+	cs->read = ingenic_tcu_timer_cs_read;
+
+	err = clocksource_register_hz(cs, rate);
+	if (err)
+		goto err_clk_disable;
+
+	return 0;
+
+err_clk_disable:
+	clk_disable_unprepare(tcu->cs_clk);
+	return err;
+}
+
+static void __init ingenic_tcu_clocksource_cleanup(struct ingenic_tcu *tcu)
+{
+	clocksource_unregister(&tcu->cs);
+	clk_disable_unprepare(tcu->cs_clk);
+}
+
+static const struct regmap_config ingenic_tcu_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static const struct ingenic_soc_info jz4740_soc_info = {
+	.num_channels = 8,
+	.has_ost = false,
+};
+
+static const struct ingenic_soc_info jz4725b_soc_info = {
+	.num_channels = 6,
+	.has_ost = true,
+};
+
+static const struct ingenic_soc_info jz4770_soc_info = {
+	.num_channels = 8,
+	.has_ost = true,
+};
+
+static const struct of_device_id ingenic_tcu_of_match[] = {
+	{ .compatible = "ingenic,jz4740-tcu", .data = &jz4740_soc_info, },
+	{ .compatible = "ingenic,jz4725b-tcu", .data = &jz4725b_soc_info, },
+	{ .compatible = "ingenic,jz4770-tcu", .data = &jz4770_soc_info, },
+	{ }
+};
+
+static int __init ingenic_tcu_init(struct device_node *np)
+{
+	const struct of_device_id *id = of_match_node(ingenic_tcu_of_match, np);
+	const struct ingenic_soc_info *soc_info = id->data;
+	struct ingenic_tcu *tcu;
+	struct resource res;
+	void __iomem *base;
+	long rate;
+	int ret;
+
+	of_node_clear_flag(np, OF_POPULATED);
+
+	tcu = kzalloc(sizeof(*tcu), GFP_KERNEL);
+	if (!tcu)
+		return -ENOMEM;
+
+	/*
+	 * Enable all TCU channels for PWM use by default except channel 0
+	 * and channel 1.
+	 */
+	tcu->pwm_channels_mask = GENMASK(soc_info->num_channels - 1, 2);
+	of_property_read_u32(np, "ingenic,pwm-channels-mask",
+			     (u32 *)&tcu->pwm_channels_mask);
+
+	/* Verify that we have at least two free channels */
+	if (hweight8(tcu->pwm_channels_mask) > soc_info->num_channels - 2) {
+		pr_crit("ingenic-tcu: Invalid PWM channel mask: 0x%02lx\n",
+			tcu->pwm_channels_mask);
+		return -EINVAL;
+	}
+
+	tcu->soc_info = soc_info;
+	ingenic_tcu = tcu;
+
+	tcu->timer_channel = find_first_zero_bit(&tcu->pwm_channels_mask,
+						 soc_info->num_channels);
+	tcu->cs_channel = find_next_zero_bit(&tcu->pwm_channels_mask,
+					     soc_info->num_channels,
+					     tcu->timer_channel + 1);
+
+	base = of_io_request_and_map(np, 0, NULL);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto err_free_ingenic_tcu;
+	}
+
+	of_address_to_resource(np, 0, &res);
+
+	ingenic_tcu_base = base;
+
+	tcu->map = regmap_init_mmio(NULL, base, &ingenic_tcu_regmap_config);
+	if (IS_ERR(tcu->map)) {
+		ret = PTR_ERR(tcu->map);
+		goto err_iounmap;
+	}
+
+	tcu->clk = of_clk_get_by_name(np, "tcu");
+	if (IS_ERR(tcu->clk)) {
+		ret = PTR_ERR(tcu->clk);
+		pr_crit("ingenic-tcu: Unable to find TCU clock: %i\n", ret);
+		goto err_free_regmap;
+	}
+
+	ret = clk_prepare_enable(tcu->clk);
+	if (ret) {
+		pr_crit("ingenic-tcu: Unable to enable TCU clock: %i\n", ret);
+		goto err_clk_put;
+	}
+
+	ret = ingenic_tcu_intc_init(tcu, np);
+	if (ret)
+		goto err_clk_disable;
+
+	ret = ingenic_tcu_clk_init(tcu, np);
+	if (ret)
+		goto err_tcu_intc_cleanup;
+
+	ret = ingenic_tcu_clocksource_init(tcu);
+	if (ret)
+		goto err_tcu_clk_cleanup;
+
+	ret = ingenic_tcu_timer_init(tcu);
+	if (ret)
+		goto err_tcu_clocksource_cleanup;
+
+	/* Register the sched_clock at the end as there's no way to undo it */
+	rate = clk_get_rate(tcu->cs_clk);
+	sched_clock_register(ingenic_tcu_timer_read, 16, rate);
+
+	return 0;
+
+err_tcu_clocksource_cleanup:
+	ingenic_tcu_clocksource_cleanup(tcu);
+err_tcu_clk_cleanup:
+	ingenic_tcu_clk_cleanup(tcu, np);
+err_tcu_intc_cleanup:
+	ingenic_tcu_intc_cleanup(tcu);
+err_clk_disable:
+	clk_disable_unprepare(tcu->clk);
+err_clk_put:
+	clk_put(tcu->clk);
+err_free_regmap:
+	regmap_exit(tcu->map);
+err_iounmap:
+	iounmap(base);
+	release_mem_region(res.start, resource_size(&res));
+err_free_ingenic_tcu:
+	kfree(tcu);
+	return ret;
+}
+
+TIMER_OF_DECLARE(jz4740_tcu_intc,  "ingenic,jz4740-tcu",  ingenic_tcu_init);
+TIMER_OF_DECLARE(jz4725b_tcu_intc, "ingenic,jz4725b-tcu", ingenic_tcu_init);
+TIMER_OF_DECLARE(jz4770_tcu_intc,  "ingenic,jz4770-tcu",  ingenic_tcu_init);
+
+
+static int __init ingenic_tcu_probe(struct platform_device *pdev)
+{
+	platform_set_drvdata(pdev, ingenic_tcu);
+
+	regmap_attach_dev(&pdev->dev, ingenic_tcu->map,
+			  &ingenic_tcu_regmap_config);
+
+	return devm_of_platform_populate(&pdev->dev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ingenic_tcu_suspend(struct device *dev)
+{
+	struct ingenic_tcu *tcu = dev_get_drvdata(dev);
+
+	clk_disable(tcu->cs_clk);
+	clk_disable(tcu->timer_clk);
+	clk_disable(tcu->clk);
+	return 0;
+}
+
+static int ingenic_tcu_resume(struct device *dev)
+{
+	struct ingenic_tcu *tcu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_enable(tcu->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(tcu->timer_clk);
+	if (ret)
+		goto err_tcu_clk_disable;
+
+	ret = clk_enable(tcu->cs_clk);
+	if (ret)
+		goto err_tcu_timer_clk_disable;
+
+	return 0;
+
+err_tcu_timer_clk_disable:
+	clk_disable(tcu->timer_clk);
+err_tcu_clk_disable:
+	clk_disable(tcu->clk);
+	return ret;
+}
+
+static const struct dev_pm_ops ingenic_tcu_pm_ops = {
+	/* _noirq: We want the TCU clock to be gated last / ungated first */
+	.suspend_noirq = ingenic_tcu_suspend,
+	.resume_noirq  = ingenic_tcu_resume,
+};
+#define INGENIC_TCU_PM_OPS (&ingenic_tcu_pm_ops)
+
+#else
+#define INGENIC_TCU_PM_OPS NULL
+#endif /* CONFIG_PM_SUSPEND */
+
+static struct platform_driver ingenic_tcu_driver = {
+	.driver = {
+		.name	= "ingenic-tcu",
+		.pm	= INGENIC_TCU_PM_OPS,
+		.of_match_table = ingenic_tcu_of_match,
+	},
+};
+
+static int __init ingenic_tcu_platform_init(void)
+{
+	return platform_driver_probe(&ingenic_tcu_driver,
+				     ingenic_tcu_probe);
+}
+subsys_initcall(ingenic_tcu_platform_init);
+
+bool ingenic_tcu_pwm_can_use_chn(struct device *dev, unsigned int channel)
+{
+	struct ingenic_tcu *tcu = dev_get_drvdata(dev->parent);
+
+	return !!(tcu->pwm_channels_mask & BIT(channel));
+}
+EXPORT_SYMBOL_GPL(ingenic_tcu_pwm_can_use_chn);
diff --git a/drivers/clocksource/ingenic-timer.h b/drivers/clocksource/ingenic-timer.h
new file mode 100644
index 000000000000..fa43da836ab6
--- /dev/null
+++ b/drivers/clocksource/ingenic-timer.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DRIVERS_CLOCKSOURCE_INGENIC_TIMER_H__
+#define __DRIVERS_CLOCKSOURCE_INGENIC_TIMER_H__
+
+#include <linux/compiler_types.h>
+
+/*
+ * README: For use *ONLY* by the ingenic-ost driver.
+ * Regular drivers which want to access the TCU registers
+ * must have ingenic-timer as parent and retrieve the regmap
+ * doing dev_get_regmap(pdev->dev.parent);
+ */
+extern void __iomem *ingenic_tcu_base;
+
+#endif /* __DRIVERS_CLOCKSOURCE_INGENIC_TIMER_H__ */
diff --git a/include/linux/mfd/ingenic-tcu.h b/include/linux/mfd/ingenic-tcu.h
index 2083fa20821d..7518a137ab40 100644
--- a/include/linux/mfd/ingenic-tcu.h
+++ b/include/linux/mfd/ingenic-tcu.h
@@ -7,6 +7,8 @@
 
 #include <linux/bitops.h>
 
+struct device;
+
 #define TCU_REG_WDT_TDR		0x00
 #define TCU_REG_WDT_TCER	0x04
 #define TCU_REG_WDT_TCNT	0x08
@@ -53,4 +55,6 @@
 #define TCU_REG_TCNTc(c)	(TCU_REG_TCNT0 + ((c) * TCU_CHANNEL_STRIDE))
 #define TCU_REG_TCSRc(c)	(TCU_REG_TCSR0 + ((c) * TCU_CHANNEL_STRIDE))
 
+bool ingenic_tcu_pwm_can_use_chn(struct device *dev, unsigned int channel);
+
 #endif /* __LINUX_MFD_INGENIC_TCU_H_ */
-- 
2.11.0

