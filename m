Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2015 14:03:17 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:53798 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006924AbbLANDL6DZOd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2015 14:03:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=HA3E8Mo0Qz9lzYLlMswo2Xt7Pp5t5QkrWlBBhqpH8yU=;
        b=PapCbMMUBsuIT4N67HBm/GHhIgfYLsBMbSi9axEiFPOZAnpPfOPwpaEh7BqNV7/711sAD8w8ZfEHuT2i5hlwLnA0DcWMkHO0B7QBDK8Sgi9akZXcRa7VhQ1e9w11Q6/WWglgOeD4iQkVCNDyoeA3rpmhfTIf4nG6ghu0Vg9kMxvLocW36cegvDm6hKnxvqhV4XFfgWuszTpTXkbL4/6AF2XDL9J3MfQt01OT/OyWhU8euLwpN8n5kJQpZyPMe3MMhnvxIw+4iM+EF+zP5hwD2yBItNmzoSwvxnpGhobMxpWkkZsSTNuoNt39vAbX3r2KpvMJy/+RPHqDis3XCCQLBQ==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:45579 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a3kZw-0007bL-Jr (Exim); Tue, 01 Dec 2015 13:02:45 +0000
Subject: [PATCH 02/11] MIPS: bmips: Add bcm6345-l2-timer interrupt controller
To:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <565D9A40.60409@simon.arlott.org.uk>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Jonas Gorski <jogo@openwrt.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <565D9A73.3000500@simon.arlott.org.uk>
Date:   Tue, 1 Dec 2015 13:02:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <565D9A40.60409@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50253
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

Add the BCM6345/BCM6318 timer as an interrupt controller so that it can be
used by the watchdog to warn that its timer will expire soon.

Support for clocksource/clockevents is not implemented as the timer
interrupt is not per CPU (except on the BCM6318) and the MIPS clock is
better. This could be added later if required without changing the device
tree binding.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 drivers/irqchip/Kconfig                |   5 +
 drivers/irqchip/Makefile               |   1 +
 drivers/irqchip/irq-bcm6345-l2-timer.c | 386 +++++++++++++++++++++++++++++++++
 3 files changed, 392 insertions(+)
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
index 0000000..f3acda7
--- /dev/null
+++ b/drivers/irqchip/irq-bcm6345-l2-timer.c
@@ -0,0 +1,386 @@
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
+ *   0x02: Interrupt enable (u8)
+ *   0x03: Interrupt status (u8)
+ *   0x04: Timer 0 control
+ *   0x08: Timer 1 control
+ *   0x0c: Timer 2 control
+ *   0x10: Timer 0 count
+ *   0x14: Timer 1 count
+ *   0x18: Timer 2 count
+ *   0x1c+: Watchdog registers
+ *
+ * Registers for SoCs with 5 timers: BCM6318
+ *   0x00: Interrupt enable (u32)
+ *   0x04: Interrupt status (u32)
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
+enum timer_regs {
+	/* Interrupt enable register:
+	 *   1 bit per timer (without the watchdog)
+	 */
+	TIMER_INT_ENABLE = 0,
+
+	/* Interrupt status register:
+	 *   1 bit per timer (plus the watchdog)
+	 *   Read for status
+	 *   Write bit to ack
+	 */
+	TIMER_INT_STATUS,
+
+	/* Per-timer control register */
+	TIMER_CONTROL,
+
+	/* Per-timer count register */
+	TIMER_COUNT,
+
+
+	/* Number of registers in enum */
+	__TIMER_REGS_ENUM_SIZE
+};
+
+/* Watchdog interrupt is immediately after the timers */
+#define WATCHDOG_INT_BIT(x)		(BIT((x)->variant.nr_timers))
+
+#define CONTROL_COUNTDOWN_MASK		(0x3fffffff)
+#define CONTROL_RSTCNTCLR_MASK		(1 << 30)
+#define CONTROL_ENABLE_MASK		(1 << 31)
+
+#define COUNT_MASK			(0x3fffffff)
+
+struct bcm6345_timer *timer;
+
+struct bcm6345_timer_variant {
+	unsigned int nr_timers;
+	u32 (*int_read)(struct bcm6345_timer *timer, int reg);
+	void (*int_write)(struct bcm6345_timer *timer, int reg, u32 val);
+	long regs[__TIMER_REGS_ENUM_SIZE];
+};
+
+struct bcm6345_timer {
+	raw_spinlock_t lock;
+	void __iomem *base;
+	unsigned int irq;
+	struct irq_domain *domain;
+
+	struct bcm6345_timer_variant variant;
+	unsigned int nr_interrupts;
+};
+
+
+/* Interrupt enable/status are either 8-bit or 32-bit registers */
+
+static u32 bcm6345_timer_int_readl(struct bcm6345_timer *timer, int reg)
+{
+	return __raw_readl(timer->base + timer->variant.regs[reg]);
+}
+
+static void bcm6345_timer_int_writel(struct bcm6345_timer *timer,
+	int reg, u32 val)
+{
+	__raw_writel(val, timer->base + timer->variant.regs[reg]);
+}
+
+static u32 bcm6345_timer_int_readb(struct bcm6345_timer *timer, int reg)
+{
+	return __raw_readb(timer->base + timer->variant.regs[reg]);
+}
+
+static void bcm6345_timer_int_writeb(struct bcm6345_timer *timer,
+	int reg, u32 val)
+{
+	__raw_writeb(val, timer->base + timer->variant.regs[reg]);
+}
+
+
+/* Timer variants */
+
+static const struct bcm6345_timer_variant timer_bcm6318 __initconst = {
+	.nr_timers = 4,
+	.regs = {
+		[TIMER_INT_ENABLE]	= 0x00,
+		[TIMER_INT_STATUS]	= 0x04,
+		[TIMER_CONTROL]		= 0x08,
+		[TIMER_COUNT]		= 0x18,
+	},
+	.int_read = bcm6345_timer_int_readl,
+	.int_write = bcm6345_timer_int_writel,
+};
+
+static const struct bcm6345_timer_variant timer_bcm6345 __initconst = {
+	.nr_timers = 3,
+	.regs = {
+		[TIMER_INT_ENABLE]	= 0x02,
+		[TIMER_INT_STATUS]	= 0x03,
+		[TIMER_CONTROL]		= 0x04,
+		[TIMER_COUNT]		= 0x10,
+	},
+	.int_read = bcm6345_timer_int_readb,
+	.int_write = bcm6345_timer_int_writeb,
+};
+
+
+/* Register access functions */
+
+static inline u32 bcm6345_timer_read_int_status(struct bcm6345_timer *timer)
+{
+	return timer->variant.int_read(timer, TIMER_INT_STATUS);
+}
+
+static inline void bcm6345_timer_write_int_status(struct bcm6345_timer *timer,
+	u32 val)
+{
+	timer->variant.int_write(timer, TIMER_INT_STATUS, val);
+}
+
+static inline u32 bcm6345_timer_read_int_enable(struct bcm6345_timer *timer)
+{
+	return timer->variant.int_read(timer, TIMER_INT_ENABLE);
+}
+
+static inline void bcm6345_timer_write_int_enable(struct bcm6345_timer *timer,
+	u32 val)
+{
+	timer->variant.int_write(timer, TIMER_INT_ENABLE, val);
+}
+
+static inline __init void bcm6345_timer_write_control(
+	struct bcm6345_timer *timer, unsigned int id, u32 val)
+{
+	__raw_writel(val,
+		timer->base + timer->variant.regs[TIMER_CONTROL] + id * 4);
+}
+
+static inline __init void bcm6345_timer_write_count(
+	struct bcm6345_timer *timer, unsigned int id, u32 val)
+{
+	__raw_writel(val,
+		timer->base + timer->variant.regs[TIMER_COUNT] + id * 4);
+}
+
+static inline __init void bcm6345_timer_stop(struct bcm6345_timer *timer,
+	unsigned int id)
+{
+	bcm6345_timer_write_control(timer, id, 0);
+	bcm6345_timer_write_count(timer, id, 0);
+	bcm6345_timer_write_int_status(timer, BIT(id));
+}
+
+
+/* Interrupt handler functions */
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
+			WATCHDOG_INT_BIT(timer); /* Watchdog can't be masked */
+
+	for_each_set_bit(hwirq, &pending, timer->nr_interrupts) {
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
+static void bcm6345_timer_enable(struct irq_data *d)
+{
+	struct bcm6345_timer *timer = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	u8 val;
+
+	raw_spin_lock_irqsave(&timer->lock, flags);
+	val = bcm6345_timer_read_int_enable(timer);
+	val |= BIT(d->hwirq);
+	bcm6345_timer_write_int_enable(timer, val);
+	raw_spin_unlock_irqrestore(&timer->lock, flags);
+}
+
+static void bcm6345_timer_disable(struct irq_data *d)
+{
+	struct bcm6345_timer *timer = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&timer->lock, flags);
+	val = bcm6345_timer_read_int_enable(timer);
+	val &= ~BIT(d->hwirq);
+	bcm6345_timer_write_int_enable(timer, val);
+	raw_spin_unlock_irqrestore(&timer->lock, flags);
+}
+
+static void bcm6345_timer_eoi(struct irq_data *d)
+{
+	struct bcm6345_timer *timer = irq_data_get_irq_chip_data(d);
+
+	bcm6345_timer_write_int_status(timer, BIT(d->hwirq));
+}
+
+static struct irq_chip bcm6345_timer_chip = {
+	.name		= "bcm6345-timer",
+	.irq_enable	= bcm6345_timer_enable,
+	.irq_disable	= bcm6345_timer_disable,
+	.irq_eoi	= bcm6345_timer_eoi,
+};
+
+static void bcm6345_timer_irq_noop(struct irq_data *d)
+{
+	/* The watchdog interrupt can't be masked (its
+	 * enable bit has no effect), so do nothing.
+	 */
+}
+
+static struct irq_chip bcm6345_timer_wdt_chip = {
+	.name		= "bcm6345-timer",
+	.irq_enable	= bcm6345_timer_irq_noop,
+	.irq_disable	= bcm6345_timer_irq_noop,
+};
+
+static int bcm6345_timer_map(struct irq_domain *d, unsigned int virq,
+			     irq_hw_number_t hwirq)
+{
+	struct bcm6345_timer *timer = d->host_data;
+
+	if (hwirq < timer->variant.nr_timers) {
+		irq_set_chip_and_handler(virq, &bcm6345_timer_chip,
+			handle_fasteoi_irq);
+	} else {
+		/* Watchdog interrupt can't be disabled or acked */
+		irq_set_chip_and_handler(virq, &bcm6345_timer_wdt_chip,
+			handle_simple_irq);
+	}
+	irq_set_chip_data(virq, timer);
+	return 0;
+}
+
+static const struct irq_domain_ops bcm6345_timer_domain_ops = {
+	.xlate	= irq_domain_xlate_onecell,
+	.map	= bcm6345_timer_map,
+};
+
+static int __init bcm63xx_timer_init(struct device_node *node,
+	const char *name, const struct bcm6345_timer_variant *variant)
+{
+	struct bcm6345_timer *timer;
+	unsigned int i;
+	int ret;
+
+	timer = kzalloc(sizeof(*timer), GFP_KERNEL);
+	if (!timer)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&timer->lock);
+	memcpy(&timer->variant, variant, sizeof(*variant));
+	/* The watchdog warning event is the next interrupt bit
+	 * after the timers. It has different control/countdown
+	 * registers, handled by the watchdog driver.
+	 */
+	timer->nr_interrupts = timer->variant.nr_timers + 1;
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
+		pr_err("unable to map registers\n");
+		ret = -ENOMEM;
+		goto free_timer;
+	}
+
+	timer->domain = irq_domain_add_linear(node, timer->nr_interrupts,
+					&bcm6345_timer_domain_ops, timer);
+	if (!timer->domain) {
+		pr_err("unable to add IRQ domain");
+		ret = -ENOMEM;
+		goto unmap_io;
+	}
+
+	/* Mask all interrupts and stop all timers */
+	bcm6345_timer_write_int_enable(timer, 0);
+	for (i = 0; i < timer->variant.nr_timers; i++)
+		bcm6345_timer_stop(timer, i);
+
+	irq_set_chained_handler_and_data(timer->irq,
+					bcm6345_timer_interrupt, timer);
+
+	pr_info("registered %s L2 (timer) intc at MMIO 0x%p (irq = %d, IRQs: %d)\n",
+			name, timer->base, timer->irq, timer->nr_interrupts);
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
+	return bcm63xx_timer_init(node, "BCM6318", &timer_bcm6318);
+}
+
+static int __init bcm6345_timer_init(struct device_node *node,
+				      struct device_node *parent)
+{
+	return bcm63xx_timer_init(node, "BCM6345", &timer_bcm6345);
+}
+
+IRQCHIP_DECLARE(bcm6318_l2_timer, "brcm,bcm6318-timer", bcm6318_timer_init);
+IRQCHIP_DECLARE(bcm6345_l2_timer, "brcm,bcm6345-timer", bcm6345_timer_init);
-- 
2.1.4

-- 
Simon Arlott
