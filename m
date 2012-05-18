Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 May 2012 17:44:21 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:60793 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903713Ab2ERPnO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 May 2012 17:43:14 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/3] GPIO: MIPS: lantiq: convert gpio-mm-lantiq to OF and of_mm_gpio
Date:   Fri, 18 May 2012 17:42:56 +0200
Message-Id: <1337355777-1680-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1337355777-1680-1-git-send-email-blogic@openwrt.org>
References: <1337355777-1680-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Implements OF support and convert to of_mm_gpio.

By attaching hardware latches to the External Bus Unit (EBU) on Lantiq SoC, it
is possible to create output only gpios. This driver configures a special
memory address, which when written to, outputs 16 bit to the latches.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org
---
This patch is part of a series moving the mips/lantiq target to OF and clkdev
support. The patch, once Acked, should go upstream via Ralf's MIPS tree.

Changes in V4
* add #include "linux/gpio.h"
* fix casting
* fix doc style
* make use of be32_to_cpu()

 .../devicetree/bindings/gpio/gpio-mm-lantiq.txt    |   38 +++++
 drivers/gpio/gpio-mm-lantiq.c                      |  146 ++++++++++++--------
 2 files changed, 127 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mm-lantiq.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mm-lantiq.txt b/Documentation/devicetree/bindings/gpio/gpio-mm-lantiq.txt
new file mode 100644
index 0000000..f93d514
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-mm-lantiq.txt
@@ -0,0 +1,38 @@
+Lantiq SoC External Bus memory mapped GPIO controller
+
+By attaching hardware latches to the EBU it is possible to create output
+only gpios. This driver configures a special memory address, which when
+written to outputs 16 bit to the latches.
+
+The node describing the memory mapped GPIOs needs to be a child of the node
+describing the "lantiq,localbus".
+
+Required properties:
+- compatible : Should be "lantiq,gpio-mm-lantiq"
+- reg : Address and length of the register set for the device
+- #gpio-cells : Should be two.  The first cell is the pin number and
+  the second cell is used to specify optional parameters (currently
+  unused).
+- gpio-controller : Marks the device node as a gpio controller.
+
+Optional properties:
+- lantiq,shadow : The default value that we shall assume as already set on the
+  shift register cascade.
+
+Example:
+
+localbus@0 {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	ranges = <0 0 0x0 0x3ffffff /* addrsel0 */
+		1 0 0x4000000 0x4000010>; /* addsel1 */
+	compatible = "lantiq,localbus", "simple-bus";
+
+	gpio_mm0: gpio@4000000 {
+		compatible = "lantiq,gpio-mm";
+		reg = <1 0x0 0x10>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		lantiq,shadow = <0x77f>
+	};
+}
diff --git a/drivers/gpio/gpio-mm-lantiq.c b/drivers/gpio/gpio-mm-lantiq.c
index b91c7f1..2983dfb 100644
--- a/drivers/gpio/gpio-mm-lantiq.c
+++ b/drivers/gpio/gpio-mm-lantiq.c
@@ -3,16 +3,19 @@
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
  *
- *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
+ *  Copyright (C) 2012 John Crispin <blogic@openwrt.org>
  */
 
 #include <linux/init.h>
-#include <linux/export.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/io.h>
+#include <linux/slab.h>
 
 #include <lantiq_soc.h>
 
@@ -25,102 +28,131 @@
 #define LTQ_EBU_BUSCON	0x1e7ff		/* 16 bit access, slowest timing */
 #define LTQ_EBU_WP	0x80000000	/* write protect bit */
 
-/* we keep a shadow value of the last value written to the ebu */
-static int ltq_ebu_gpio_shadow = 0x0;
-static void __iomem *ltq_ebu_gpio_membase;
+struct ltq_mm {
+	struct of_mm_gpio_chip mmchip;
+	u16 shadow;	/* shadow the latches state */
+};
 
-static void ltq_ebu_apply(void)
+/**
+ * ltq_mm_apply() - write the shadow value to the ebu address.
+ * @chip:     Pointer to our private data structure.
+ *
+ * Write the shadow value to the EBU to set the gpios. We need to set the
+ * global EBU lock to make sure that PCI/MTD dont break.
+ */
+static void ltq_mm_apply(struct ltq_mm *chip)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&ebu_lock, flags);
 	ltq_ebu_w32(LTQ_EBU_BUSCON, LTQ_EBU_BUSCON1);
-	*((__u16 *)ltq_ebu_gpio_membase) = ltq_ebu_gpio_shadow;
+	__raw_writew(chip->shadow, chip->mmchip.regs);
 	ltq_ebu_w32(LTQ_EBU_BUSCON | LTQ_EBU_WP, LTQ_EBU_BUSCON1);
 	spin_unlock_irqrestore(&ebu_lock, flags);
 }
 
-static void ltq_ebu_set(struct gpio_chip *chip, unsigned offset, int value)
+/**
+ * ltq_mm_set() - gpio_chip->set - set gpios.
+ * @gc:     Pointer to gpio_chip device structure.
+ * @gpio:   GPIO signal number.
+ * @val:    Value to be written to specified signal.
+ *
+ * Set the shadow value and call ltq_mm_apply.
+ */
+static void ltq_mm_set(struct gpio_chip *gc, unsigned offset, int value)
 {
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct ltq_mm *chip =
+		container_of(mm_gc, struct ltq_mm, mmchip);
+
 	if (value)
-		ltq_ebu_gpio_shadow |= (1 << offset);
+		chip->shadow |= (1 << offset);
 	else
-		ltq_ebu_gpio_shadow &= ~(1 << offset);
-	ltq_ebu_apply();
+		chip->shadow &= ~(1 << offset);
+	ltq_mm_apply(chip);
 }
 
-static int ltq_ebu_direction_output(struct gpio_chip *chip, unsigned offset,
-	int value)
+/**
+ * ltq_mm_dir_out() - gpio_chip->dir_out - set gpio direction.
+ * @gc:     Pointer to gpio_chip device structure.
+ * @gpio:   GPIO signal number.
+ * @val:    Value to be written to specified signal.
+ *
+ * Same as ltq_mm_set, always returns 0.
+ */
+static int ltq_mm_dir_out(struct gpio_chip *gc, unsigned offset, int value)
 {
-	ltq_ebu_set(chip, offset, value);
+	ltq_mm_set(gc, offset, value);
 
 	return 0;
 }
 
-static struct gpio_chip ltq_ebu_chip = {
-	.label = "ltq_ebu",
-	.direction_output = ltq_ebu_direction_output,
-	.set = ltq_ebu_set,
-	.base = 72,
-	.ngpio = 16,
-	.can_sleep = 1,
-	.owner = THIS_MODULE,
-};
+/**
+ * ltq_mm_save_regs() - Set initial values of GPIO pins
+ * @mm_gc: pointer to memory mapped GPIO chip structure
+ */
+static void ltq_mm_save_regs(struct of_mm_gpio_chip *mm_gc)
+{
+	struct ltq_mm *chip =
+		container_of(mm_gc, struct ltq_mm, mmchip);
+
+	/* tell the ebu controller which memory address we will be using */
+	ltq_ebu_w32(CPHYSADDR(chip->mmchip.regs) | 0x1, LTQ_EBU_ADDRSEL1);
+
+	ltq_mm_apply(chip);
+}
 
-static int ltq_ebu_probe(struct platform_device *pdev)
+static int ltq_mm_probe(struct platform_device *pdev)
 {
-	int ret = 0;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct ltq_mm *chip;
+	const __be32 *shadow;
+	int ret = 0;
 
 	if (!res) {
 		dev_err(&pdev->dev, "failed to get memory resource\n");
 		return -ENOENT;
 	}
 
-	res = devm_request_mem_region(&pdev->dev, res->start,
-		resource_size(res), dev_name(&pdev->dev));
-	if (!res) {
-		dev_err(&pdev->dev, "failed to request memory resource\n");
-		return -EBUSY;
-	}
-
-	ltq_ebu_gpio_membase = devm_ioremap_nocache(&pdev->dev, res->start,
-		resource_size(res));
-	if (!ltq_ebu_gpio_membase) {
-		dev_err(&pdev->dev, "Failed to ioremap mem region\n");
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip)
 		return -ENOMEM;
-	}
 
-	/* grab the default shadow value passed form the platform code */
-	ltq_ebu_gpio_shadow = (unsigned int) pdev->dev.platform_data;
+	chip->mmchip.gc.ngpio = 16;
+	chip->mmchip.gc.label = "gpio-mm-ltq";
+	chip->mmchip.gc.direction_output = ltq_mm_dir_out;
+	chip->mmchip.gc.set = ltq_mm_set;
+	chip->mmchip.save_regs = ltq_mm_save_regs;
 
-	/* tell the ebu controller which memory address we will be using */
-	ltq_ebu_w32(pdev->resource->start | 0x1, LTQ_EBU_ADDRSEL1);
+	/* store the shadow value if one was passed by the devicetree */
+	shadow = of_get_property(pdev->dev.of_node, "lantiq,shadow", NULL);
+	if (shadow)
+		chip->shadow = be32_to_cpu(*shadow);
 
-	/* write protect the region */
-	ltq_ebu_w32(LTQ_EBU_BUSCON | LTQ_EBU_WP, LTQ_EBU_BUSCON1);
-
-	ret = gpiochip_add(&ltq_ebu_chip);
-	if (!ret)
-		ltq_ebu_apply();
+	ret = of_mm_gpiochip_add(pdev->dev.of_node, &chip->mmchip);
+	if (ret)
+		kfree(chip);
 	return ret;
 }
 
-static struct platform_driver ltq_ebu_driver = {
-	.probe = ltq_ebu_probe,
+static const struct of_device_id ltq_mm_match[] = {
+	{ .compatible = "lantiq,gpio-mm" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ltq_mm_match);
+
+static struct platform_driver ltq_mm_driver = {
+	.probe = ltq_mm_probe,
 	.driver = {
-		.name = "ltq_ebu",
+		.name = "gpio-mm-ltq",
 		.owner = THIS_MODULE,
+		.of_match_table = ltq_mm_match,
 	},
 };
 
-static int __init ltq_ebu_init(void)
+static int __init ltq_mm_init(void)
 {
-	int ret = platform_driver_register(&ltq_ebu_driver);
-
-	if (ret)
-		pr_info("ltq_ebu : Error registering platfom driver!");
-	return ret;
+	return platform_driver_register(&ltq_mm_driver);
 }
 
-postcore_initcall(ltq_ebu_init);
+subsys_initcall(ltq_mm_init);
-- 
1.7.9.1
