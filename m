Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 00:31:16 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:33174 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994680AbeCQX35BA8Gh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 00:29:57 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 7/8] clocksource: Add a new timer-ingenic driver
Date:   Sun, 18 Mar 2018 00:29:00 +0100
Message-Id: <20180317232901.14129-8-paul@crapouillou.net>
In-Reply-To: <20180317232901.14129-1-paul@crapouillou.net>
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1521329396; bh=+rg/1fIYM4cBM8UMGHF+LbFdFaOZBZwiIWCY4UGlHmY=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=q6pJizCex5u+4S5ABM7s/qgrH3f657UNKSIfz+HKRocZWbJRxR4VrOHLrREZRGWkCGWPjUq9vABTRjGxF0GKkQpXrp0aaBGRLHpsOhElTW4wdgyiCAY2q9MtPj2rqyYdciLR0jm6P5pTzGgE/9blyIW+fDgh7q2ou1Pkk/GfS10=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

This driver will use the TCU (Timer Counter Unit) present on the Ingenic
JZ47xx SoCs to provide the kernel with a clocksource and timers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clocksource/Kconfig         |   8 ++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-ingenic.c | 278 ++++++++++++++++++++++++++++++++++++
 3 files changed, 287 insertions(+)
 create mode 100644 drivers/clocksource/timer-ingenic.c

 v2: Use SPDX identifier for the license
 v3: - Move documentation to its own patch
     - Search the devicetree for PWM clients, and use all the TCU
	   channels that won't be used for PWM
 v4: - Add documentation about why we search for PWM clients
     - Verify that the PWM clients are for the TCU PWM driver

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index d2e5382821a4..481422145fb4 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -592,4 +592,12 @@ config CLKSRC_ST_LPC
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
 
+config INGENIC_TIMER
+	bool "Clocksource/timer using the TCU in Ingenic JZ SoCs"
+	depends on MACH_INGENIC || COMPILE_TEST
+	select CLKSRC_OF
+	default y
+	help
+	  Support for the timer/counter unit of the Ingenic JZ SoCs.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index d6dec4489d66..98691e8999fe 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -74,5 +74,6 @@ obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
 obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
 obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
+obj-$(CONFIG_INGENIC_TIMER)		+= timer-ingenic.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
diff --git a/drivers/clocksource/timer-ingenic.c b/drivers/clocksource/timer-ingenic.c
new file mode 100644
index 000000000000..8c777c0c0023
--- /dev/null
+++ b/drivers/clocksource/timer-ingenic.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ingenic JZ47xx SoC TCU clocksource driver
+ * Copyright (C) 2018 Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/ingenic-tcu.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define NUM_CHANNELS	8
+
+struct ingenic_tcu;
+
+struct ingenic_tcu_channel {
+	unsigned int idx;
+	struct clk *clk;
+};
+
+struct ingenic_tcu {
+	struct ingenic_tcu_channel channels[NUM_CHANNELS];
+	unsigned long requested;
+	struct regmap *map;
+};
+
+struct ingenic_clock_event_device {
+	struct clock_event_device cevt;
+	struct ingenic_tcu_channel *channel;
+	char name[32];
+};
+
+#define ingenic_cevt(_evt) \
+	container_of(_evt, struct ingenic_clock_event_device, cevt)
+
+static inline struct ingenic_tcu *to_ingenic_tcu(struct ingenic_tcu_channel *ch)
+{
+	return container_of(ch, struct ingenic_tcu, channels[ch->idx]);
+}
+
+static int ingenic_tcu_cevt_set_state_shutdown(struct clock_event_device *evt)
+{
+	struct ingenic_clock_event_device *jzcevt = ingenic_cevt(evt);
+	struct ingenic_tcu_channel *channel = jzcevt->channel;
+	struct ingenic_tcu *tcu = to_ingenic_tcu(channel);
+	unsigned int idx = channel->idx;
+
+	regmap_write(tcu->map, TCU_REG_TECR, BIT(idx));
+	return 0;
+}
+
+static int ingenic_tcu_cevt_set_next(unsigned long next,
+		struct clock_event_device *evt)
+{
+	struct ingenic_clock_event_device *jzcevt = ingenic_cevt(evt);
+	struct ingenic_tcu_channel *channel = jzcevt->channel;
+	struct ingenic_tcu *tcu = to_ingenic_tcu(channel);
+	unsigned int idx = channel->idx;
+
+	if (next > 0xffff)
+		return -EINVAL;
+
+	regmap_write(tcu->map, TCU_REG_TDFRc(idx), (unsigned int) next);
+	regmap_write(tcu->map, TCU_REG_TCNTc(idx), 0);
+	regmap_write(tcu->map, TCU_REG_TESR, BIT(idx));
+
+	return 0;
+}
+
+static irqreturn_t ingenic_tcu_cevt_cb(int irq, void *dev_id)
+{
+	struct clock_event_device *cevt = dev_id;
+	struct ingenic_clock_event_device *jzcevt = ingenic_cevt(cevt);
+	struct ingenic_tcu_channel *channel = jzcevt->channel;
+	struct ingenic_tcu *tcu = to_ingenic_tcu(channel);
+	unsigned int idx = channel->idx;
+
+	regmap_write(tcu->map, TCU_REG_TECR, BIT(idx));
+
+	if (cevt->event_handler)
+		cevt->event_handler(cevt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init ingenic_tcu_req_channel(struct ingenic_tcu_channel *channel)
+{
+	struct ingenic_tcu *tcu = to_ingenic_tcu(channel);
+	char buf[16];
+	int err;
+
+	if (test_and_set_bit(channel->idx, &tcu->requested))
+		return -EBUSY;
+
+	snprintf(buf, sizeof(buf), "timer%u", channel->idx);
+	channel->clk = clk_get(NULL, buf);
+	if (IS_ERR(channel->clk)) {
+		err = PTR_ERR(channel->clk);
+		goto out_release;
+	}
+
+	err = clk_prepare_enable(channel->clk);
+	if (err)
+		goto out_clk_put;
+
+	return 0;
+
+out_clk_put:
+	clk_put(channel->clk);
+out_release:
+	clear_bit(channel->idx, &tcu->requested);
+	return err;
+}
+
+static int __init ingenic_tcu_reset_channel(struct device_node *np,
+		struct ingenic_tcu_channel *channel)
+{
+	struct ingenic_tcu *tcu = to_ingenic_tcu(channel);
+
+	return regmap_update_bits(tcu->map, TCU_REG_TCSRc(channel->idx),
+				0xffff & ~TCU_TCSR_RESERVED_BITS, 0);
+}
+
+static void __init ingenic_tcu_free_channel(struct ingenic_tcu_channel *channel)
+{
+	struct ingenic_tcu *tcu = to_ingenic_tcu(channel);
+
+	clk_disable_unprepare(channel->clk);
+	clk_put(channel->clk);
+	clear_bit(channel->idx, &tcu->requested);
+}
+
+static const char * const ingenic_tcu_timer_names[] = {
+	"TCU0", "TCU1", "TCU2", "TCU3", "TCU4", "TCU5", "TCU6", "TCU7",
+};
+
+static int __init ingenic_tcu_setup_cevt(struct device_node *np,
+		struct ingenic_tcu *tcu, unsigned int idx)
+{
+	struct ingenic_tcu_channel *channel = &tcu->channels[idx];
+	struct ingenic_clock_event_device *jzcevt;
+	unsigned long rate;
+	int err, virq;
+
+	err = ingenic_tcu_req_channel(channel);
+	if (err)
+		return err;
+
+	err = ingenic_tcu_reset_channel(np, channel);
+	if (err)
+		goto err_out_free_channel;
+
+	rate = clk_get_rate(channel->clk);
+	if (!rate) {
+		err = -EINVAL;
+		goto err_out_free_channel;
+	}
+
+	jzcevt = kzalloc(sizeof(*jzcevt), GFP_KERNEL);
+	if (!jzcevt) {
+		err = -ENOMEM;
+		goto err_out_free_channel;
+	}
+
+	virq = irq_of_parse_and_map(np, idx);
+	if (!virq) {
+		err = -EINVAL;
+		goto err_out_kfree_jzcevt;
+	}
+
+	err = request_irq(virq, ingenic_tcu_cevt_cb, IRQF_TIMER,
+			ingenic_tcu_timer_names[idx], &jzcevt->cevt);
+	if (err)
+		goto err_out_irq_dispose_mapping;
+
+	jzcevt->channel = channel;
+	snprintf(jzcevt->name, sizeof(jzcevt->name), "ingenic-tcu-chan%u",
+		 channel->idx);
+
+	jzcevt->cevt.cpumask = cpumask_of(smp_processor_id());
+	jzcevt->cevt.features = CLOCK_EVT_FEAT_ONESHOT;
+	jzcevt->cevt.name = jzcevt->name;
+	jzcevt->cevt.rating = 200;
+	jzcevt->cevt.set_state_shutdown = ingenic_tcu_cevt_set_state_shutdown;
+	jzcevt->cevt.set_next_event = ingenic_tcu_cevt_set_next;
+
+	clockevents_config_and_register(&jzcevt->cevt, rate, 10, (1 << 16) - 1);
+
+	return 0;
+
+err_out_irq_dispose_mapping:
+	irq_dispose_mapping(virq);
+err_out_kfree_jzcevt:
+	kfree(jzcevt);
+err_out_free_channel:
+	ingenic_tcu_free_channel(channel);
+	return err;
+}
+
+static int __init ingenic_tcu_init(struct device_node *np)
+{
+	unsigned long available_channels = GENMASK(NUM_CHANNELS - 1, 0);
+	struct device_node *node, *pwm_driver_node;
+	struct ingenic_tcu *tcu;
+	unsigned int i, channel;
+	int err;
+	u32 val;
+
+	/* Parse the devicetree for clients of the TCU PWM driver;
+	 * every TCU channel not requested for PWM will be used as
+	 * a timer.
+	 */
+	for_each_node_with_property(node, "pwms") {
+		/* Get the PWM channel ID (field 1 of the "pwms" node) */
+		err = of_property_read_u32_index(node, "pwms", 1, &val);
+		if (!err && val >= NUM_CHANNELS)
+			err = -EINVAL;
+		if (err) {
+			pr_err("timer-ingenic: Unable to parse PWM nodes!");
+			break;
+		}
+
+		/* Get the PWM driver node (field 0 of the "pwms" node) */
+		pwm_driver_node = of_parse_phandle(node, "pwms", 0);
+		if (!pwm_driver_node) {
+			pr_err("timer-ingenic: Unable to find PWM driver node");
+			break;
+		}
+
+		/* Verify that the node we found is for the TCU PWM driver,
+		 * by checking that this driver and the PWM driver passed
+		 * as phandle share the same parent (the "ingenic,tcu"
+		 * compatible MFD/syscon node).
+		 */
+		if (pwm_driver_node->parent != np->parent)
+			continue;
+
+		pr_info("timer-ingenic: Reserving channel %u for PWM", val);
+		available_channels &= ~BIT(val);
+	}
+
+	tcu = kzalloc(sizeof(*tcu), GFP_KERNEL);
+	if (!tcu)
+		return -ENOMEM;
+
+	tcu->map = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(tcu->map)) {
+		err = PTR_ERR(tcu->map);
+		kfree(tcu);
+		return err;
+	}
+
+	for (i = 0; i < NUM_CHANNELS; i++)
+		tcu->channels[i].idx = i;
+
+	for_each_set_bit(channel, &available_channels, NUM_CHANNELS) {
+		err = ingenic_tcu_setup_cevt(np, tcu, channel);
+		if (err) {
+			pr_warn("timer-ingenic: Unable to init TCU channel %u: %i",
+					channel, err);
+			continue;
+		}
+	}
+
+	return 0;
+}
+
+/* We only probe via devicetree, no need for a platform driver */
+CLOCKSOURCE_OF_DECLARE(jz4740_tcu, "ingenic,jz4740-tcu", ingenic_tcu_init);
+CLOCKSOURCE_OF_DECLARE(jz4770_tcu, "ingenic,jz4770-tcu", ingenic_tcu_init);
+CLOCKSOURCE_OF_DECLARE(jz4780_tcu, "ingenic,jz4780-tcu", ingenic_tcu_init);
-- 
2.11.0
