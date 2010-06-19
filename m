Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jun 2010 16:47:42 +0200 (CEST)
Received: from smtp-out-047.synserver.de ([212.40.180.47]:1038 "HELO
        smtp-out-047.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491798Ab0FSOri (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jun 2010 16:47:38 +0200
Received: (qmail 14106 invoked by uid 0); 19 Jun 2010 14:47:31 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 13707
Received: from port-13469.pppoe.wtnet.de (HELO localhost.localdomain) [84.46.52.209]
  by 217.119.54.73 with SMTP; 19 Jun 2010 14:47:31 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>, lm-sensors@lm-sensors.org
Subject: [PATCH v3] hwmon: Add JZ4740 ADC driver
Date:   Sat, 19 Jun 2010 16:47:00 +0200
Message-Id: <1276958820-8862-1-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1276924111-11158-24-git-send-email-lars@metafoo.de>
References: <1276924111-11158-24-git-send-email-lars@metafoo.de>
X-archive-position: 27210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13532

This patch adds support for reading the ADCIN pin of ADC unit on JZ4740 SoCs.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: lm-sensors@lm-sensors.org

--
Changes since v1
- Move ADC core access synchronizing from the HWMON driver to a MFD driver. The
  ADC driver now only reads the adcin value.
Changes since v2
- Add name sysfs attribute
- Report adcin in value in millivolts
---
 drivers/hwmon/Kconfig        |   11 ++
 drivers/hwmon/Makefile       |    1 +
 drivers/hwmon/jz4740-hwmon.c |  224 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 236 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/jz4740-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 569082c..51fc2f6 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -446,6 +446,17 @@ config SENSORS_IT87
 	  This driver can also be built as a module.  If so, the module
 	  will be called it87.
 
+config SENSORS_JZ4740
+	tristate "Ingenic JZ4740 SoC ADC driver"
+	depends on MACH_JZ4740
+    help
+      If you say yes here you get support for the Ingenic JZ4740 SoC ADC core.
+      It is required for the JZ4740 battery and touchscreen driver and is used
+      to synchronize access to the adc module between those two.
+
+      This driver can also be build as a module. If so, the module will be
+      called jz4740-adc.
+
 config SENSORS_LM63
 	tristate "National Semiconductor LM63 and LM64"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index bca0d45..dffbdff 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
 obj-$(CONFIG_SENSORS_IBMAEM)	+= ibmaem.o
 obj-$(CONFIG_SENSORS_IBMPEX)	+= ibmpex.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
+obj-$(CONFIG_SENSORS_JZ4740)	+= jz4740-hwmon.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
 obj-$(CONFIG_SENSORS_K10TEMP)	+= k10temp.o
 obj-$(CONFIG_SENSORS_LIS3LV02D) += lis3lv02d.o hp_accel.o
diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
new file mode 100644
index 0000000..a448d78
--- /dev/null
+++ b/drivers/hwmon/jz4740-hwmon.c
@@ -0,0 +1,224 @@
+/*
+ * Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
+ * JZ4740 SoC HWMON driver
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under  the terms of the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <linux/mfd/core.h>
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+struct jz4740_hwmon {
+	struct resource *mem;
+	void __iomem *base;
+
+	int irq;
+
+	struct mfd_cell *cell;
+	struct device *hwmon;
+
+	struct completion read_completion;
+
+	struct mutex lock;
+};
+
+static ssize_t jz4740_hwmon_show_name(struct device *dev,
+	struct device_attribute *dev_attr, char *buf)
+{
+	return sprintf(buf, "jz4740\n");
+}
+
+static irqreturn_t jz4740_hwmon_irq(int irq, void *data)
+{
+	struct jz4740_hwmon *hwmon = data;
+
+	complete(&hwmon->read_completion);
+	return IRQ_HANDLED;
+}
+
+static ssize_t jz4740_hwmon_read_adcin(struct device *dev,
+	struct device_attribute *dev_attr, char *buf)
+{
+	struct jz4740_hwmon *hwmon = dev_get_drvdata(dev);
+	unsigned long t;
+	unsigned long val;
+	int ret;
+
+	mutex_lock(&hwmon->lock);
+
+	INIT_COMPLETION(hwmon->read_completion);
+
+	enable_irq(hwmon->irq);
+	hwmon->cell->enable(to_platform_device(dev));
+
+	t = wait_for_completion_interruptible_timeout(&hwmon->read_completion, HZ);
+
+	if (t > 0) {
+		val = readw(hwmon->base) & 0xfff;
+		val = (val * 3300) >> 12;
+		ret = sprintf(buf, "%lu\n", val);
+	} else {
+		ret = t ? t : -ETIMEDOUT;
+	}
+
+	hwmon->cell->disable(to_platform_device(dev));
+	disable_irq(hwmon->irq);
+
+	mutex_unlock(&hwmon->lock);
+
+	return ret;
+}
+
+static DEVICE_ATTR(name, S_IRUGO, jz4740_hwmon_show_name, NULL);
+static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, jz4740_hwmon_read_adcin, NULL, 0);
+
+static struct attribute jz4740_hwmon_attributes[] = {
+	&dev_attr_name.attr,
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group jz4740_hwmon_attr_group = {
+	.attrs = jz4740_hwmon_attributes,
+};
+
+static int __devinit jz4740_hwmon_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct jz4740_hwmon *hwmon;
+
+	hwmon = kmalloc(sizeof(*hwmon), GFP_KERNEL);
+
+	hwmon->cell = pdev->dev.platform_data;
+
+	hwmon->irq = platform_get_irq(pdev, 0);
+	if (hwmon->irq < 0) {
+		ret = hwmon->irq;
+		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
+		goto err_free;
+	}
+
+	hwmon->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!hwmon->mem) {
+		ret = -ENOENT;
+		dev_err(&pdev->dev, "Failed to get platform mmio resource\n");
+		goto err_free;
+	}
+
+	hwmon->mem = request_mem_region(hwmon->mem->start,
+					resource_size(hwmon->mem), pdev->name);
+	if (!hwmon->mem) {
+		ret = -EBUSY;
+		dev_err(&pdev->dev, "Failed to request mmio memory region\n");
+		goto err_free;
+	}
+
+	hwmon->base = ioremap_nocache(hwmon->mem->start, resource_size(hwmon->mem));
+	if (!hwmon->base) {
+		ret = -EBUSY;
+		dev_err(&pdev->dev, "Failed to ioremap mmio memory\n");
+		goto err_release_mem_region;
+	}
+
+	init_completion(&hwmon->read_completion);
+	mutex_init(&hwmon->lock);
+
+	platform_set_drvdata(pdev, hwmon);
+
+	ret = request_irq(hwmon->irq, jz4740_hwmon_irq, 0, pdev->name, hwmon);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request irq: %d\n", ret);
+		goto err_iounmap;
+	}
+	disable_irq(hwmon->irq);
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &jz4740_hwmon_attr_group);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to create sysfs group: %d\n", ret);
+		goto err_free_irq;
+	}
+
+	hwmon->hwmon = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(hwmon->hwmon)) {
+		ret = PTR_ERR(hwmon->hwmon);
+		goto err_remove_file;
+	}
+
+	return 0;
+
+err_remove_file:
+	sysfs_remove_group(&pdev->dev.kobj, &jz4740_hwmon_attr_group);
+err_free_irq:
+	free_irq(hwmon->irq, hwmon);
+err_iounmap:
+	platform_set_drvdata(pdev, NULL);
+	iounmap(hwmon->base);
+err_release_mem_region:
+	release_mem_region(hwmon->mem->start, resource_size(hwmon->mem));
+err_free:
+	kfree(hwmon);
+
+	return ret;
+}
+
+static int __devexit jz4740_hwmon_remove(struct platform_device *pdev)
+{
+	struct jz4740_hwmon *hwmon = platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(hwmon->hwmon);
+	sysfs_remove_group(&pdev->dev.kobj, &jz4740_hwmon_attr_group);
+
+	free_irq(hwmon->irq, hwmon);
+
+	iounmap(hwmon->base);
+	release_mem_region(hwmon->mem->start, resource_size(hwmon->mem));
+
+	platform_set_drvdata(pdev, NULL);
+	kfree(hwmon);
+
+	return 0;
+}
+
+struct platform_driver jz4740_hwmon_driver = {
+	.probe	= jz4740_hwmon_probe,
+	.remove = __devexit_p(jz4740_hwmon_remove),
+	.driver = {
+		.name = "jz4740-hwmon",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init jz4740_hwmon_init(void)
+{
+	return platform_driver_register(&jz4740_hwmon_driver);
+}
+module_init(jz4740_hwmon_init);
+
+static void __exit jz4740_hwmon_exit(void)
+{
+	platform_driver_unregister(&jz4740_hwmon_driver);
+}
+module_exit(jz4740_hwmon_exit);
+
+MODULE_DESCRIPTION("JZ4740 SoC HWMON driver");
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:jz4740-hwmon");
-- 
1.5.6.5
