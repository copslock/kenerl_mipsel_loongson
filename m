Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 20:04:08 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:57140 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012171AbbKUTEGb3C5I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Nov 2015 20:04:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=Da/7u8dRlTJ2aCPd4q2iPPqGTD4iUzE7z0EctjH/4Hw=;
        b=B1lrtTjHx2xxKSoPJ9muUStUGCzf4/L3TOHxlO+y3JYlt+uK+KX35rVynZdt+Ey04ScKgDzRe2Gs7HwIU+TwBaYXei8/xiQg8nQryfNolEo+J1l0h2ktuFMJPxKjzB4msLuXC89bfIz0Oswkk4dIB+1QWy460V8A47m55BjHDmb3RYmzvsSnbo4hGbBuoPDMaHnVX86V+0NEG5IaXcNofucwkBKKB6hCKfjR9hKwWgA9fkd7P7FXNA0OiMZEWaUIpKFgjIhd2iIpH5HvnywsId/KmZmCA1B4myJA6lNsuuXoXJnLDzo+2MmXMKdJjbe7UnFD8kA4HUvWpD2zJCph7Q==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:58018 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a0DS3-0006GN-GV (Exim); Sat, 21 Nov 2015 19:04:00 +0000
Subject: [PATCH 2/4] MIPS: bmips: Add bcm6345-l2-timer interrupt controller
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Miguel Gaio <miguel.gaio@efixo.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <5650C01E.4010804@simon.arlott.org.uk>
Date:   Sat, 21 Nov 2015 19:03:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <5650BFD6.5030700@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

Add the BCM6345 timer as an interrupt controller so that it can be used
by the watchdog to warn that its timer will expire soon.

Support for clocksource/clockevents is not implemented as the timer
interrupt is not per CPU (except on the BCM6318) and the MIPS clock is
better. This could be added later if required without changing the device
tree binding.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 drivers/irqchip/Kconfig                |   5 +
 drivers/irqchip/Makefile               |   1 +
 drivers/irqchip/irq-bcm6345-l2-timer.c | 317 +++++++++++++++++++++++++++++++++
 3 files changed, 323 insertions(+)
 create mode 100644 drivers/irqchip/irq-bcm6345-l2-timer.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d307bb3..21c3d9b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -70,6 +70,11 @@ config BCM6345_L1_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
+config BCM6345_L2_TIMER_IRQ
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 config BCM7038_L1_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ded59cf..2687dea 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
 obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
 obj-$(CONFIG_SOC_VF610)			+= irq-vf610-mscm-ir.o
 obj-$(CONFIG_BCM6345_L1_IRQ)		+= irq-bcm6345-l1.o
+obj-$(CONFIG_BCM6345_L2_TIMER_IRQ)	+= irq-bcm6345-l2-timer.o
 obj-$(CONFIG_BCM7038_L1_IRQ)		+= irq-bcm7038-l1.o
 obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
 obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
diff --git a/drivers/irqchip/irq-bcm6345-l2-timer.c b/drivers/irqchip/irq-bcm6345-l2-timer.c
new file mode 100644
index 0000000..a388fcb
--- /dev/null
+++ b/drivers/irqchip/irq-bcm6345-l2-timer.c
@@ -0,0 +1,317 @@
+/*
+ * Copyright 2015 Simon Arlott
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Based on arch/mips/bcm63xx/timer.c:
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ *
+ * Registers for SoCs with 4 timers: BCM6345, BCM6328, BCM6362, BCM6816,
+ *                                   BCM68220,BCM63168, BCM63268
+ *   0x02: IRQ enable (u8)
+ *   0x03: IRQ status (u8)
+ *   0x04: Timer 0 control
+ *   0x08: Timer 1 control
+ *   0x0c: Timer 2 control
+ *   0x10: Timer 0 count
+ *   0x14: Timer 1 count
+ *   0x18: Timer 2 count
+ *   0x1c+: Watchdog registers
+ *
+ * Registers for SoCs with 5 timers: BCM6318
+ *   0x00: IRQ enable (u32)
+ *   0x04: IRQ status (u32)
+ *   0x08: Timer 0 control
+ *   0x0c: Timer 1 control
+ *   0x10: Timer 2 control
+ *   0x14: Timer 3 control
+ *   0x18: Timer 0 count
+ *   0x1c: Timer 1 count
+ *   0x20: Timer 2 count
+ *   0x24: Timer 3 count
+ *   0x28+: Watchdog registers
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+
+#define REG_6345_IRQ_ENABLE		0x02
+#define REG_6345_IRQ_STATUS		0x03
+#define REG_6345_CFG_BASE		0x04
+
+#define REG_6318_IRQ_ENABLE		0x00
+#define REG_6318_IRQ_STATUS		0x04
+#define REG_6318_CFG_BASE		0x08
+
+#define NR_TIMERS_6345			4
+#define WDT_TIMER_ID_6345		(NR_TIMERS_6345 - 1)
+
+#define NR_TIMERS_6318			5
+#define WDT_TIMER_ID_6318		(NR_TIMERS_6318 - 1)
+
+/* Per-timer count register */
+#define COUNT_MASK			(0x3fffffff)
+
+/* Per-timer control register */
+#define CONTROL_COUNTDOWN_MASK		(0x3fffffff)
+#define CONTROL_RSTCNTCLR_MASK		(1 << 30)
+#define CONTROL_ENABLE_MASK		(1 << 31)
+
+enum bcm6345_timer_type {
+	TIMER_TYPE_6345,
+	TIMER_TYPE_6318,
+};
+
+struct bcm6345_timer {
+	raw_spinlock_t lock;
+	void __iomem *base;
+	unsigned int irq;
+	struct irq_domain *domain;
+
+	enum bcm6345_timer_type type;
+	unsigned int nr_timers;
+	/* The watchdog timer has separate control/remaining registers
+	 * and cannot be masked.
+	 */
+	int wdt_timer_id;
+};
+
+static inline u32 bcm6345_timer_read_int_status(struct bcm6345_timer *timer)
+{
+	if (timer->type == TIMER_TYPE_6318)
+		return __raw_readl(timer->base + REG_6318_IRQ_STATUS);
+	else
+		return __raw_readb(timer->base + REG_6345_IRQ_STATUS);
+}
+
+static inline void bcm6345_timer_write_int_status(struct bcm6345_timer *timer,
+	u32 val)
+{
+	if (timer->type == TIMER_TYPE_6318)
+		__raw_writel(val, timer->base + REG_6318_IRQ_STATUS);
+	else
+		__raw_writeb(val, timer->base + REG_6345_IRQ_STATUS);
+}
+
+static inline u32 bcm6345_timer_read_int_enable(struct bcm6345_timer *timer)
+{
+	if (timer->type == TIMER_TYPE_6318)
+		return __raw_readl(timer->base + REG_6318_IRQ_ENABLE);
+	else
+		return __raw_readb(timer->base + REG_6345_IRQ_ENABLE);
+}
+
+static inline void bcm6345_timer_write_int_enable(struct bcm6345_timer *timer,
+	u32 val)
+{
+	if (timer->type == TIMER_TYPE_6318)
+		__raw_writel(val, timer->base + REG_6318_IRQ_ENABLE);
+	else
+		__raw_writeb(val, timer->base + REG_6345_IRQ_ENABLE);
+}
+
+static inline void bcm6345_timer_write_control(struct bcm6345_timer *timer,
+	unsigned int id, u32 val)
+{
+	if (timer->type == TIMER_TYPE_6318)
+		__raw_writel(0, timer->base + REG_6318_CFG_BASE + id * 4);
+	else
+		__raw_writel(0, timer->base + REG_6345_CFG_BASE + id * 4);
+}
+
+static inline void bcm6345_timer_write_count(struct bcm6345_timer *timer,
+	unsigned int id, u32 val)
+{
+	/* Count registers are immediately after the control registers */
+	return bcm6345_timer_write_control(timer, timer->nr_timers + id, val);
+}
+
+static inline void bcm6345_timer_stop(struct bcm6345_timer *timer, int id)
+{
+	if (id != timer->wdt_timer_id) {
+		bcm6345_timer_write_control(timer, id, 0);
+		bcm6345_timer_write_count(timer, id, 0);
+		bcm6345_timer_write_int_status(timer, BIT(id));
+	}
+}
+
+static void bcm6345_timer_interrupt(struct irq_desc *desc)
+{
+	struct bcm6345_timer *timer = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long pending;
+	irq_hw_number_t hwirq;
+	unsigned int irq;
+
+	chained_irq_enter(chip, desc);
+
+	pending = bcm6345_timer_read_int_status(timer);
+	pending &= bcm6345_timer_read_int_enable(timer) |
+			BIT(timer->wdt_timer_id); /* Watchdog can't be masked */
+
+	for_each_set_bit(hwirq, &pending, timer->nr_timers) {
+		irq = irq_linear_revmap(timer->domain, hwirq);
+		if (irq)
+			do_IRQ(irq);
+		else
+			spurious_interrupt();
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void bcm6345_timer_unmask(struct irq_data *d)
+{
+	struct bcm6345_timer *timer = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	u8 val;
+
+	if (d->hwirq != timer->wdt_timer_id) {
+		raw_spin_lock_irqsave(&timer->lock, flags);
+		val = bcm6345_timer_read_int_enable(timer);
+		val |= BIT(d->hwirq);
+		bcm6345_timer_write_int_enable(timer, val);
+		raw_spin_unlock_irqrestore(&timer->lock, flags);
+	}
+}
+
+static void bcm6345_timer_mask(struct irq_data *d)
+{
+	struct bcm6345_timer *timer = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	u32 val;
+
+	if (d->hwirq != timer->wdt_timer_id) {
+		raw_spin_lock_irqsave(&timer->lock, flags);
+		val = bcm6345_timer_read_int_enable(timer);
+		val &= ~BIT(d->hwirq);
+		bcm6345_timer_write_int_enable(timer, val);
+		raw_spin_unlock_irqrestore(&timer->lock, flags);
+	}
+}
+
+static void bcm6345_timer_eoi(struct irq_data *d)
+{
+	struct bcm6345_timer *timer = irq_data_get_irq_chip_data(d);
+
+	if (d->hwirq != timer->wdt_timer_id)
+		bcm6345_timer_write_int_status(timer, BIT(d->hwirq));
+}
+
+static struct irq_chip bcm6345_timer_chip = {
+	.name			= "bcm6345-timer",
+	.irq_mask		= bcm6345_timer_mask,
+	.irq_unmask		= bcm6345_timer_unmask,
+	.irq_eoi		= bcm6345_timer_eoi,
+};
+
+static int bcm6345_timer_map(struct irq_domain *d, unsigned int virq,
+			     irq_hw_number_t hwirq)
+{
+	struct bcm6345_timer *timer = d->host_data;
+
+	irq_set_chip_and_handler(virq, &bcm6345_timer_chip,
+		hwirq == timer->wdt_timer_id ?
+			handle_simple_irq : handle_fasteoi_irq);
+	irq_set_chip_data(virq, timer);
+	return 0;
+}
+
+static const struct irq_domain_ops bcm6345_timer_domain_ops = {
+	.xlate			= irq_domain_xlate_onecell,
+	.map			= bcm6345_timer_map,
+};
+
+static int __init bcm63xx_timer_init(struct device_node *node,
+	enum bcm6345_timer_type type, unsigned int nr_timers, int wdt_timer_id)
+{
+	struct bcm6345_timer *timer;
+	int ret, i;
+
+	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
+	if (!timer)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&timer->lock);
+	timer->type = type;
+	timer->nr_timers = nr_timers;
+	timer->wdt_timer_id = wdt_timer_id;
+
+	timer->irq = irq_of_parse_and_map(node, 0);
+	if (!timer->irq) {
+		pr_err("unable to map parent IRQ\n");
+		ret = -EINVAL;
+		goto free_timer;
+	}
+
+	timer->base = of_iomap(node, 0);
+	if (!timer->base) {
+		pr_err("unable to remap registers\n");
+		ret = -ENOMEM;
+		goto free_timer;
+	}
+
+	timer->domain = irq_domain_add_linear(node, timer->nr_timers,
+					&bcm6345_timer_domain_ops, timer);
+	if (!timer->domain) {
+		pr_err("unable to add IRQ domain");
+		ret = -ENOMEM;
+		goto unmap_io;
+	}
+
+	/* Mask all interrupts and stop all timers */
+	bcm6345_timer_write_int_enable(timer, 0);
+	for (i = 0; i < timer->nr_timers; i++)
+		bcm6345_timer_stop(timer, i);
+
+	irq_set_chained_handler_and_data(timer->irq,
+					bcm6345_timer_interrupt, timer);
+
+	pr_info("registered BCM6345 L2 (timer) intc at MMIO 0x%p (irq = %d, IRQs: %d)\n",
+			timer->base, timer->irq, timer->nr_timers);
+	return 0;
+
+unmap_io:
+	iounmap(timer->base);
+free_timer:
+	kfree(timer);
+	return ret;
+}
+
+static int __init bcm6318_timer_init(struct device_node *node,
+				      struct device_node *parent)
+{
+	return bcm63xx_timer_init(node, TIMER_TYPE_6318,
+				NR_TIMERS_6318, WDT_TIMER_ID_6318);
+}
+
+static int __init bcm6345_timer_init(struct device_node *node,
+				      struct device_node *parent)
+{
+	return bcm63xx_timer_init(node, TIMER_TYPE_6345,
+				NR_TIMERS_6345, WDT_TIMER_ID_6345);
+}
+
+IRQCHIP_DECLARE(bcm6318_l2_timer, "brcm,bcm6318-timer", bcm6318_timer_init);
+IRQCHIP_DECLARE(bcm6345_l2_timer, "brcm,bcm6345-timer", bcm6345_timer_init);
-- 
2.1.4

-- 
Simon Arlott
