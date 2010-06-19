Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jun 2010 21:30:49 +0200 (CEST)
Received: from smtp-out-057.synserver.de ([212.40.180.57]:1065 "HELO
        smtp-out-055.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S1491793Ab0FSTao (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jun 2010 21:30:44 +0200
Received: (qmail 29468 invoked by uid 0); 19 Jun 2010 19:30:39 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 29306
Received: from d044235.adsl.hansenet.de (HELO localhost.localdomain) [80.171.44.235]
  by 217.119.54.81 with SMTP; 19 Jun 2010 19:30:34 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        rtc-linux@googlegroups.com
Subject: [PATCH v3] RTC: Add JZ4740 RTC driver
Date:   Sat, 19 Jun 2010 21:29:50 +0200
Message-Id: <1276975790-25623-1-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1276924111-11158-16-git-send-email-lars@metafoo.de>
References: <1276924111-11158-16-git-send-email-lars@metafoo.de>
X-archive-position: 27222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13614

This patch adds support for the RTC unit on JZ4740 SoCs.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: rtc-linux@googlegroups.com

--
Changes since v1
- Use dev_get_drvdata directly instead of wrapping it in dev_to_rtc
- Add common implementation for jz4740_rtc_{alarm,update}_irq_enable
- Check whether rtc structure could be allocated
- Remove deadlocks which could occur if the HW was broken

Changes since v2
- Use kzalloc instead of kmalloc
- Propagate errors in jz4740_rtc_reg_write up to its callers
---
 drivers/rtc/Kconfig      |   11 ++
 drivers/rtc/Makefile     |    1 +
 drivers/rtc/rtc-jz4740.c |  345 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 357 insertions(+), 0 deletions(-)
 create mode 100644 drivers/rtc/rtc-jz4740.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 10ba12c..d0ed7e6 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -905,4 +905,15 @@ config RTC_DRV_MPC5121
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-mpc5121.
 
+config RTC_DRV_JZ4740
+	tristate "Ingenic JZ4740 SoC"
+	depends on RTC_CLASS
+	depends on MACH_JZ4740
+	help
+	  If you say yes here you get support for the Ingenic JZ4740 SoC RTC
+	  controller.
+
+	  This driver can also be buillt as a module. If so, the module
+	  will be called rtc-jz4740.
+
 endif # RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 5adbba7..fedf9bb 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_RTC_DRV_EP93XX)	+= rtc-ep93xx.o
 obj-$(CONFIG_RTC_DRV_FM3130)	+= rtc-fm3130.o
 obj-$(CONFIG_RTC_DRV_GENERIC)	+= rtc-generic.o
 obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
+obj-$(CONFIG_RTC_DRV_JZ4740)	+= rtc-jz4740.o
 obj-$(CONFIG_RTC_DRV_M41T80)	+= rtc-m41t80.o
 obj-$(CONFIG_RTC_DRV_M41T94)	+= rtc-m41t94.o
 obj-$(CONFIG_RTC_DRV_M48T35)	+= rtc-m48t35.o
diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
new file mode 100644
index 0000000..10b59fc
--- /dev/null
+++ b/drivers/rtc/rtc-jz4740.c
@@ -0,0 +1,345 @@
+/*
+ *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
+ *	 JZ4740 SoC RTC driver
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of  the GNU General Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define JZ_REG_RTC_CTRL		0x00
+#define JZ_REG_RTC_SEC		0x04
+#define JZ_REG_RTC_SEC_ALARM	0x08
+#define JZ_REG_RTC_REGULATOR	0x0C
+#define JZ_REG_RTC_HIBERNATE	0x20
+#define JZ_REG_RTC_SCRATCHPAD	0x34
+
+#define JZ_RTC_CTRL_WRDY	BIT(7)
+#define JZ_RTC_CTRL_1HZ		BIT(6)
+#define JZ_RTC_CTRL_1HZ_IRQ	BIT(5)
+#define JZ_RTC_CTRL_AF		BIT(4)
+#define JZ_RTC_CTRL_AF_IRQ	BIT(3)
+#define JZ_RTC_CTRL_AE		BIT(2)
+#define JZ_RTC_CTRL_ENABLE	BIT(0)
+
+struct jz4740_rtc {
+	struct resource *mem;
+	void __iomem *base;
+
+	struct rtc_device *rtc;
+
+	unsigned int irq;
+
+	spinlock_t lock;
+};
+
+static inline uint32_t jz4740_rtc_reg_read(struct jz4740_rtc *rtc, size_t reg)
+{
+	return readl(rtc->base + reg);
+}
+
+static int jz4740_rtc_wait_write_ready(struct jz4740_rtc *rtc)
+{
+	uint32_t ctrl;
+	int timeout = 1000;
+
+	do {
+		ctrl = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_CTRL);
+	} while (!(ctrl & JZ_RTC_CTRL_WRDY) && --timeout);
+
+	return timeout ? 0 : -EIO;
+}
+
+static inline int jz4740_rtc_reg_write(struct jz4740_rtc *rtc, size_t reg,
+	uint32_t val)
+{
+	int ret;
+	ret = jz4740_rtc_wait_write_ready(rtc);
+	if (ret == 0)
+		writel(val, rtc->base + reg);
+
+	return ret;
+}
+
+static int jz4740_rtc_ctrl_set_bits(struct jz4740_rtc *rtc, uint32_t mask,
+	bool set)
+{
+	int ret;
+	unsigned long flags;
+	uint32_t ctrl;
+
+	spin_lock_irqsave(&rtc->lock, flags);
+
+	ctrl = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_CTRL);
+
+	/* Don't clear interrupt flags by accident */
+	ctrl |= JZ_RTC_CTRL_1HZ | JZ_RTC_CTRL_AF;
+
+	if (set)
+		ctrl |= mask;
+	else
+		ctrl &= ~mask;
+
+	ret = jz4740_rtc_reg_write(rtc, JZ_REG_RTC_CTRL, ctrl);
+
+	spin_unlock_irqrestore(&rtc->lock, flags);
+
+	return ret;
+}
+
+static int jz4740_rtc_read_time(struct device *dev, struct rtc_time *time)
+{
+	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
+	uint32_t secs, secs2;
+	int timeout = 5;
+
+	/* If the seconds register is read while it is updated, it can contain a
+	 * bogus value. This can be avoided by making sure that two consecutive
+	 * reads have the same value.
+	 */
+	secs = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SEC);
+	secs2 = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SEC);
+
+	while (secs != secs2 && --timeout) {
+		secs = secs2;
+		secs2 = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SEC);
+	}
+
+	if (timeout == 0)
+		return -EIO;
+
+	rtc_time_to_tm(secs, time);
+
+	return rtc_valid_tm(time);
+}
+
+static int jz4740_rtc_set_mmss(struct device *dev, unsigned long secs)
+{
+	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
+
+	return jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SEC, secs);
+}
+
+static int jz4740_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
+	uint32_t secs;
+	uint32_t ctrl;
+
+	secs = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SEC_ALARM);
+
+	ctrl = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_CTRL);
+
+	alrm->enabled = !!(ctrl & JZ_RTC_CTRL_AE);
+	alrm->pending = !!(ctrl & JZ_RTC_CTRL_AF);
+
+	rtc_time_to_tm(secs, &alrm->time);
+
+	return rtc_valid_tm(&alrm->time);
+}
+
+static int jz4740_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	int ret;
+	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
+	unsigned long secs;
+
+	rtc_tm_to_time(&alrm->time, &secs);
+
+	ret = jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SEC_ALARM, secs);
+	if (!ret)
+		ret = jz4740_rtc_ctrl_set_bits(rtc, JZ_RTC_CTRL_AE, alrm->enabled);
+
+	return ret;
+}
+
+static int jz4740_rtc_update_irq_enable(struct device *dev, unsigned int enable)
+{
+	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
+	return jz4740_rtc_ctrl_set_bits(rtc, JZ_RTC_CTRL_1HZ_IRQ, enable);
+}
+
+static int jz4740_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
+{
+	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
+	return jz4740_rtc_ctrl_set_bits(rtc, JZ_RTC_CTRL_AF_IRQ, enable);
+}
+
+static struct rtc_class_ops jz4740_rtc_ops = {
+	.read_time	= jz4740_rtc_read_time,
+	.set_mmss	= jz4740_rtc_set_mmss,
+	.read_alarm	= jz4740_rtc_read_alarm,
+	.set_alarm	= jz4740_rtc_set_alarm,
+	.update_irq_enable = jz4740_rtc_update_irq_enable,
+	.alarm_irq_enable = jz4740_rtc_alarm_irq_enable,
+};
+
+static irqreturn_t jz4740_rtc_irq(int irq, void *data)
+{
+	struct jz4740_rtc *rtc = data;
+	uint32_t ctrl;
+	unsigned long events = 0;
+
+	ctrl = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_CTRL);
+
+	if (ctrl & JZ_RTC_CTRL_1HZ)
+		events |= (RTC_UF | RTC_IRQF);
+
+	if (ctrl & JZ_RTC_CTRL_AF)
+		events |= (RTC_AF | RTC_IRQF);
+
+	rtc_update_irq(rtc->rtc, 1, events);
+
+	jz4740_rtc_ctrl_set_bits(rtc, JZ_RTC_CTRL_1HZ | JZ_RTC_CTRL_AF, false);
+
+	return IRQ_HANDLED;
+}
+
+void jz4740_rtc_poweroff(struct device *dev)
+{
+	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
+	jz4740_rtc_reg_write(rtc, JZ_REG_RTC_HIBERNATE, 1);
+}
+EXPORT_SYMBOL_GPL(jz4740_rtc_poweroff);
+
+static int __devinit jz4740_rtc_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct jz4740_rtc *rtc;
+	uint32_t scratchpad;
+
+	rtc = kzalloc(sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	rtc->irq = platform_get_irq(pdev, 0);
+	if (rtc->irq < 0) {
+		ret = -ENOENT;
+		dev_err(&pdev->dev, "Failed to get platform irq\n");
+		goto err_free;
+	}
+
+	rtc->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!rtc->mem) {
+		ret = -ENOENT;
+		dev_err(&pdev->dev, "Failed to get platform mmio memory\n");
+		goto err_free;
+	}
+
+	rtc->mem = request_mem_region(rtc->mem->start, resource_size(rtc->mem),
+					pdev->name);
+	if (!rtc->mem) {
+		ret = -EBUSY;
+		dev_err(&pdev->dev, "Failed to request mmio memory region\n");
+		goto err_free;
+	}
+
+	rtc->base = ioremap_nocache(rtc->mem->start, resource_size(rtc->mem));
+	if (!rtc->base) {
+		ret = -EBUSY;
+		dev_err(&pdev->dev, "Failed to ioremap mmio memory\n");
+		goto err_release_mem_region;
+	}
+
+	spin_lock_init(&rtc->lock);
+
+	platform_set_drvdata(pdev, rtc);
+
+	rtc->rtc = rtc_device_register(pdev->name, &pdev->dev, &jz4740_rtc_ops,
+					THIS_MODULE);
+	if (IS_ERR(rtc->rtc)) {
+		ret = PTR_ERR(rtc->rtc);
+		dev_err(&pdev->dev, "Failed to register rtc device: %d\n", ret);
+		goto err_iounmap;
+	}
+
+	ret = request_irq(rtc->irq, jz4740_rtc_irq, 0,
+				pdev->name, rtc);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request rtc irq: %d\n", ret);
+		goto err_unregister_rtc;
+	}
+
+	scratchpad = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SCRATCHPAD);
+	if (scratchpad != 0x12345678) {
+		ret = jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SCRATCHPAD, 0x12345678);
+		ret = jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SEC, 0);
+		if (ret) {
+			dev_err(&pdev->dev, "Could not write write to RTC registers\n");
+			goto err_free_irq;
+		}
+	}
+
+	return 0;
+
+err_free_irq:
+	free_irq(rtc->irq, rtc);
+err_unregister_rtc:
+	rtc_device_unregister(rtc->rtc);
+err_iounmap:
+	platform_set_drvdata(pdev, NULL);
+	iounmap(rtc->base);
+err_release_mem_region:
+	release_mem_region(rtc->mem->start, resource_size(rtc->mem));
+err_free:
+	kfree(rtc);
+
+	return ret;
+}
+
+static int __devexit jz4740_rtc_remove(struct platform_device *pdev)
+{
+	struct jz4740_rtc *rtc = platform_get_drvdata(pdev);
+
+	free_irq(rtc->irq, rtc);
+
+	rtc_device_unregister(rtc->rtc);
+
+	iounmap(rtc->base);
+	release_mem_region(rtc->mem->start, resource_size(rtc->mem));
+
+	kfree(rtc);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+struct platform_driver jz4740_rtc_driver = {
+	.probe = jz4740_rtc_probe,
+	.remove = __devexit_p(jz4740_rtc_remove),
+	.driver = {
+		.name = "jz4740-rtc",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init jz4740_rtc_init(void)
+{
+	return platform_driver_register(&jz4740_rtc_driver);
+}
+module_init(jz4740_rtc_init);
+
+static void __exit jz4740_rtc_exit(void)
+{
+	platform_driver_unregister(&jz4740_rtc_driver);
+}
+module_exit(jz4740_rtc_exit);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTC driver for the JZ4740 SoC\n");
+MODULE_ALIAS("platform:jz4740-rtc");
-- 
1.5.6.5
