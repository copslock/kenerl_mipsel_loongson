Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 14:18:36 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:43097 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823066Ab3DJMSbUC0Xt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Apr 2013 14:18:31 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Gabor Juhos <juhosg@openwrt.org>, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 16/18] MIPS: ralink: add support for periodic timer irq
Date:   Wed, 10 Apr 2013 13:47:25 +0200
Message-Id: <1365594447-13068-17-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
References: <1365594447-13068-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Adds a driver for the periodic timer found on Ralink SoC.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/Makefile |    2 +-
 arch/mips/ralink/timer.c  |  192 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/ralink/timer.c

diff --git a/arch/mips/ralink/Makefile b/arch/mips/ralink/Makefile
index 341b4de..cae7d88 100644
--- a/arch/mips/ralink/Makefile
+++ b/arch/mips/ralink/Makefile
@@ -6,7 +6,7 @@
 # Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
 # Copyright (C) 2013 John Crispin <blogic@openwrt.org>
 
-obj-y := prom.o of.o reset.o clk.o irq.o pinmux.o
+obj-y := prom.o of.o reset.o clk.o irq.o pinmux.o timer.o
 
 obj-$(CONFIG_SOC_RT288X) += rt288x.o
 obj-$(CONFIG_SOC_RT305X) += rt305x.o
diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
new file mode 100644
index 0000000..f3bd44d
--- /dev/null
+++ b/arch/mips/ralink/timer.c
@@ -0,0 +1,192 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+*/
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/timer.h>
+#include <linux/of_gpio.h>
+#include <linux/clk.h>
+
+#include <asm/mach-ralink/ralink_regs.h>
+
+#define TIMER_REG_TMRSTAT		0x00
+#define TIMER_REG_TMR0LOAD		0x10
+#define TIMER_REG_TMR0CTL		0x18
+
+#define TMRSTAT_TMR0INT			BIT(0)
+
+#define TMR0CTL_ENABLE			BIT(7)
+#define TMR0CTL_MODE_PERIODIC		BIT(4)
+#define TMR0CTL_PRESCALER		1
+#define TMR0CTL_PRESCALE_VAL		(0xf - TMR0CTL_PRESCALER)
+#define TMR0CTL_PRESCALE_DIV		(65536 / BIT(TMR0CTL_PRESCALER))
+
+struct rt_timer {
+	struct device	*dev;
+	void __iomem	*membase;
+	int		irq;
+	unsigned long	timer_freq;
+	unsigned long	timer_div;
+};
+
+static inline void rt_timer_w32(struct rt_timer *rt, u8 reg, u32 val)
+{
+	__raw_writel(val, rt->membase + reg);
+}
+
+static inline u32 rt_timer_r32(struct rt_timer *rt, u8 reg)
+{
+	return __raw_readl(rt->membase + reg);
+}
+
+static irqreturn_t rt_timer_irq(int irq, void *_rt)
+{
+	struct rt_timer *rt =  (struct rt_timer *) _rt;
+
+	rt_timer_w32(rt, TIMER_REG_TMR0LOAD, rt->timer_freq / rt->timer_div);
+	rt_timer_w32(rt, TIMER_REG_TMRSTAT, TMRSTAT_TMR0INT);
+
+	return IRQ_HANDLED;
+}
+
+
+static int rt_timer_request(struct rt_timer *rt)
+{
+	int err = request_irq(rt->irq, rt_timer_irq, IRQF_DISABLED,
+						dev_name(rt->dev), rt);
+	if (err) {
+		dev_err(rt->dev, "failed to request irq\n");
+	} else {
+		u32 t = TMR0CTL_MODE_PERIODIC | TMR0CTL_PRESCALE_VAL;
+		rt_timer_w32(rt, TIMER_REG_TMR0CTL, t);
+	}
+	return err;
+}
+
+static void rt_timer_free(struct rt_timer *rt)
+{
+	free_irq(rt->irq, rt);
+}
+
+static int rt_timer_config(struct rt_timer *rt, unsigned long divisor)
+{
+	if (rt->timer_freq < divisor)
+		rt->timer_div = rt->timer_freq;
+	else
+		rt->timer_div = divisor;
+
+	rt_timer_w32(rt, TIMER_REG_TMR0LOAD, rt->timer_freq / rt->timer_div);
+
+	return 0;
+}
+
+static int rt_timer_enable(struct rt_timer *rt)
+{
+	u32 t;
+
+	rt_timer_w32(rt, TIMER_REG_TMR0LOAD, rt->timer_freq / rt->timer_div);
+
+	t = rt_timer_r32(rt, TIMER_REG_TMR0CTL);
+	t |= TMR0CTL_ENABLE;
+	rt_timer_w32(rt, TIMER_REG_TMR0CTL, t);
+
+	return 0;
+}
+
+static void rt_timer_disable(struct rt_timer *rt)
+{
+	u32 t;
+
+	t = rt_timer_r32(rt, TIMER_REG_TMR0CTL);
+	t &= ~TMR0CTL_ENABLE;
+	rt_timer_w32(rt, TIMER_REG_TMR0CTL, t);
+}
+
+static int rt_timer_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct rt_timer *rt;
+	struct clk *clk;
+
+	if (!res) {
+		dev_err(&pdev->dev, "no memory resource found\n");
+		return -EINVAL;
+	}
+
+	rt = devm_kzalloc(&pdev->dev, sizeof(*rt), GFP_KERNEL);
+	if (!rt) {
+		dev_err(&pdev->dev, "failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	rt->irq = platform_get_irq(pdev, 0);
+	if (!rt->irq) {
+		dev_err(&pdev->dev, "failed to load irq\n");
+		return -ENOENT;
+	}
+
+	rt->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (!rt->membase) {
+		dev_err(&pdev->dev, "failed to ioremap\n");
+		return -ENOMEM;
+	}
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "failed get clock rate\n");
+		return PTR_ERR(clk);
+	}
+
+	rt->timer_freq = clk_get_rate(clk) / TMR0CTL_PRESCALE_DIV;
+	if (!rt->timer_freq)
+		return -EINVAL;
+
+	rt->dev = &pdev->dev;
+	platform_set_drvdata(pdev, rt);
+
+	rt_timer_request(rt);
+	rt_timer_config(rt, 2);
+	rt_timer_enable(rt);
+
+	dev_info(&pdev->dev, "maximum frequency is %luHz\n", rt->timer_freq);
+
+	return 0;
+}
+
+static int rt_timer_remove(struct platform_device *pdev)
+{
+	struct rt_timer *rt = platform_get_drvdata(pdev);
+
+	rt_timer_disable(rt);
+	rt_timer_free(rt);
+
+	return 0;
+}
+
+static const struct of_device_id rt_timer_match[] = {
+	{ .compatible = "ralink,rt2880-timer" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt_timer_match);
+
+static struct platform_driver rt_timer_driver = {
+	.probe = rt_timer_probe,
+	.remove = rt_timer_remove,
+	.driver = {
+		.name		= "rt-timer",
+		.owner          = THIS_MODULE,
+		.of_match_table	= rt_timer_match
+	},
+};
+
+module_platform_driver(rt_timer_driver);
+
+MODULE_DESCRIPTION("Ralink RT2880 timer");
+MODULE_AUTHOR("John Crispin <blogic@openwrt.org");
+MODULE_LICENSE("GPL");
-- 
1.7.10.4
