Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 01:29:44 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:61250 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903741Ab2FFX2q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 01:28:46 +0200
Received: by dadm1 with SMTP id m1so8205dad.36
        for <multiple recipients>; Wed, 06 Jun 2012 16:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ta9z0tVBR1c8phUfaoCNieFW4ziS1JCyvO1SNE+nylM=;
        b=CFS9vh44omq8zPfWBptr4TI+R+uudrmwXp1nQWoGvnWcVKgG8KXf4dqWq6kZ35AzCc
         dTIAI43cA8KYFWkaYy7+u+2zkLU+cyznndwHjmimB3O8fcUA547k8DYWr6vCr+/ULCtF
         bNOUIwDRFtVGiXNnI+LHkDMydrlzAe+eHK6cmgqUj9WDyIEOMUBoGFrxvF558zKBuFmv
         qLN9S76mCZZKhYIIGRiTtzWZJrtxiLlqdKvaA+094WStRfM2h9QeQnG2ycuLTib+1pRG
         2zlBVpbtvHATDaqXW6exv61wTgY9VxM9dHt3T8vNaHynDjjibei3+Tj3JalCHCiXItF4
         U+qA==
Received: by 10.68.138.169 with SMTP id qr9mr1832072pbb.27.1339025319615;
        Wed, 06 Jun 2012 16:28:39 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pe2sm1887602pbc.59.2012.06.06.16.28.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 16:28:38 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q56NSbuV024258;
        Wed, 6 Jun 2012 16:28:37 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q56NSbZA024257;
        Wed, 6 Jun 2012 16:28:37 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v3 1/5] i2c: Convert i2c-octeon.c to use device tree.
Date:   Wed,  6 Jun 2012 16:28:30 -0700
Message-Id: <1339025314-24216-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1339025314-24216-1-git-send-email-ddaney.cavm@gmail.com>
References: <1339025314-24216-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

There are three parts to this:

1) Remove the definitions of OCTEON_IRQ_TWSI and OCTEON_IRQ_TWSI2.
   The interrupts are specified by the device tree and these hard
   coded irq numbers block the used of the irq lines by the irq_domain
   code.

2) Remove platform device setup code from octeon-platform.c, it is
   now unused.

3) Convert i2c-octeon.c to use device tree.  Part of this includes
   using the devm_* functions instead of the raw counterparts, thus
   simplifying error handling.  No functionality is changed.

Signed-off-by: David Daney <david.daney@cavium.com>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/mips/cavium-octeon/octeon-irq.c      |    2 -
 arch/mips/cavium-octeon/octeon-platform.c |   84 --------------------------
 arch/mips/include/asm/octeon/octeon.h     |    5 --
 drivers/i2c/busses/i2c-octeon.c           |   92 +++++++++++++++-------------
 4 files changed, 49 insertions(+), 134 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 52610ce..2a661ad 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1192,13 +1192,11 @@ static void __init octeon_irq_init_ciu(void)
 	for (i = 0; i < 4; i++)
 		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_PCI_MSI0, 0, i + 40, chip, handle_level_irq);
 
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TWSI, 0, 45, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_RML, 0, 46, chip, handle_level_irq);
 	for (i = 0; i < 4; i++)
 		octeon_irq_set_ciu_mapping(i + OCTEON_IRQ_TIMER0, 0, i + 52, chip, handle_edge_irq);
 
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_USB0, 0, 56, chip, handle_level_irq);
-	octeon_irq_set_ciu_mapping(OCTEON_IRQ_TWSI2, 0, 59, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_MII0, 0, 62, chip, handle_level_irq);
 	octeon_irq_set_ciu_mapping(OCTEON_IRQ_BOOTDMA, 0, 63, chip, handle_level_irq);
 
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 2754bc2..f62a40f 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -168,90 +168,6 @@ out:
 }
 device_initcall(octeon_rng_device_init);
 
-static struct i2c_board_info __initdata octeon_i2c_devices[] = {
-	{
-		I2C_BOARD_INFO("ds1337", 0x68),
-	},
-};
-
-static int __init octeon_i2c_devices_init(void)
-{
-	return i2c_register_board_info(0, octeon_i2c_devices,
-				       ARRAY_SIZE(octeon_i2c_devices));
-}
-arch_initcall(octeon_i2c_devices_init);
-
-#define OCTEON_I2C_IO_BASE 0x1180000001000ull
-#define OCTEON_I2C_IO_UNIT_OFFSET 0x200
-
-static struct octeon_i2c_data octeon_i2c_data[2];
-
-static int __init octeon_i2c_device_init(void)
-{
-	struct platform_device *pd;
-	int ret = 0;
-	int port, num_ports;
-
-	struct resource i2c_resources[] = {
-		{
-			.flags	= IORESOURCE_MEM,
-		}, {
-			.flags	= IORESOURCE_IRQ,
-		}
-	};
-
-	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN52XX))
-		num_ports = 2;
-	else
-		num_ports = 1;
-
-	for (port = 0; port < num_ports; port++) {
-		octeon_i2c_data[port].sys_freq = octeon_get_io_clock_rate();
-		/*FIXME: should be examined. At the moment is set for 100Khz */
-		octeon_i2c_data[port].i2c_freq = 100000;
-
-		pd = platform_device_alloc("i2c-octeon", port);
-		if (!pd) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		pd->dev.platform_data = octeon_i2c_data + port;
-
-		i2c_resources[0].start =
-			OCTEON_I2C_IO_BASE + (port * OCTEON_I2C_IO_UNIT_OFFSET);
-		i2c_resources[0].end = i2c_resources[0].start + 0x1f;
-		switch (port) {
-		case 0:
-			i2c_resources[1].start = OCTEON_IRQ_TWSI;
-			i2c_resources[1].end = OCTEON_IRQ_TWSI;
-			break;
-		case 1:
-			i2c_resources[1].start = OCTEON_IRQ_TWSI2;
-			i2c_resources[1].end = OCTEON_IRQ_TWSI2;
-			break;
-		default:
-			BUG();
-		}
-
-		ret = platform_device_add_resources(pd,
-						    i2c_resources,
-						    ARRAY_SIZE(i2c_resources));
-		if (ret)
-			goto fail;
-
-		ret = platform_device_add(pd);
-		if (ret)
-			goto fail;
-	}
-	return ret;
-fail:
-	platform_device_put(pd);
-out:
-	return ret;
-}
-device_initcall(octeon_i2c_device_init);
-
 /* Octeon SMI/MDIO interface.  */
 static int __init octeon_mdiobus_device_init(void)
 {
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index f72f768..1e2486e 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -215,11 +215,6 @@ struct octeon_cf_data {
 	int		dma_engine;	/* -1 for no DMA */
 };
 
-struct octeon_i2c_data {
-	unsigned int	sys_freq;
-	unsigned int	i2c_freq;
-};
-
 extern void octeon_write_lcd(const char *s);
 extern void octeon_check_cpu_bist(void);
 extern int octeon_get_boot_debug_flag(void);
diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index ee139a5..f44c835 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -2,7 +2,7 @@
  * (C) Copyright 2009-2010
  * Nokia Siemens Networks, michael.lawnick.ext@nsn.com
  *
- * Portions Copyright (C) 2010 Cavium Networks, Inc.
+ * Portions Copyright (C) 2010, 2011 Cavium Networks, Inc.
  *
  * This is a driver for the i2c adapter in Cavium Networks' OCTEON processors.
  *
@@ -11,17 +11,18 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_i2c.h>
+#include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-
-#include <linux/io.h>
 #include <linux/i2c.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/of.h>
 
 #include <asm/octeon/octeon.h>
 
@@ -65,7 +66,7 @@ struct octeon_i2c {
 	wait_queue_head_t queue;
 	struct i2c_adapter adap;
 	int irq;
-	int twsi_freq;
+	u32 twsi_freq;
 	int sys_freq;
 	resource_size_t twsi_phys;
 	void __iomem *twsi_base;
@@ -121,10 +122,8 @@ static u8 octeon_i2c_read_sw(struct octeon_i2c *i2c, u64 eop_reg)
  */
 static void octeon_i2c_write_int(struct octeon_i2c *i2c, u64 data)
 {
-	u64 tmp;
-
 	__raw_writeq(data, i2c->twsi_base + TWSI_INT);
-	tmp = __raw_readq(i2c->twsi_base + TWSI_INT);
+	__raw_readq(i2c->twsi_base + TWSI_INT);
 }
 
 /**
@@ -515,7 +514,6 @@ static int __devinit octeon_i2c_probe(struct platform_device *pdev)
 {
 	int irq, result = 0;
 	struct octeon_i2c *i2c;
-	struct octeon_i2c_data *i2c_data;
 	struct resource *res_mem;
 
 	/* All adaptors have an irq.  */
@@ -523,86 +521,90 @@ static int __devinit octeon_i2c_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
+	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c) {
 		dev_err(&pdev->dev, "kzalloc failed\n");
 		result = -ENOMEM;
 		goto out;
 	}
 	i2c->dev = &pdev->dev;
-	i2c_data = pdev->dev.platform_data;
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	if (res_mem == NULL) {
 		dev_err(i2c->dev, "found no memory resource\n");
 		result = -ENXIO;
-		goto fail_region;
+		goto out;
 	}
+	i2c->twsi_phys = res_mem->start;
+	i2c->regsize = resource_size(res_mem);
 
-	if (i2c_data == NULL) {
-		dev_err(i2c->dev, "no I2C frequency data\n");
+	/*
+	 * "clock-rate" is a legacy binding, the official binding is
+	 * "clock-frequency".  Try the official one first and then
+	 * fall back if it doesn't exist.
+	 */
+	if (of_property_read_u32(pdev->dev.of_node,
+				 "clock-frequency", &i2c->twsi_freq) &&
+	    of_property_read_u32(pdev->dev.of_node,
+				 "clock-rate", &i2c->twsi_freq)) {
+		dev_err(i2c->dev,
+			"no I2C 'clock-rate' or 'clock-frequency' property\n");
 		result = -ENXIO;
-		goto fail_region;
+		goto out;
 	}
 
-	i2c->twsi_phys = res_mem->start;
-	i2c->regsize = resource_size(res_mem);
-	i2c->twsi_freq = i2c_data->i2c_freq;
-	i2c->sys_freq = i2c_data->sys_freq;
+	i2c->sys_freq = octeon_get_io_clock_rate();
 
-	if (!request_mem_region(i2c->twsi_phys, i2c->regsize, res_mem->name)) {
+	if (!devm_request_mem_region(&pdev->dev, i2c->twsi_phys, i2c->regsize,
+				      res_mem->name)) {
 		dev_err(i2c->dev, "request_mem_region failed\n");
-		goto fail_region;
+		goto out;
 	}
-	i2c->twsi_base = ioremap(i2c->twsi_phys, i2c->regsize);
+	i2c->twsi_base = devm_ioremap(&pdev->dev, i2c->twsi_phys, i2c->regsize);
 
 	init_waitqueue_head(&i2c->queue);
 
 	i2c->irq = irq;
 
-	result = request_irq(i2c->irq, octeon_i2c_isr, 0, DRV_NAME, i2c);
+	result = devm_request_irq(&pdev->dev, i2c->irq,
+				  octeon_i2c_isr, 0, DRV_NAME, i2c);
 	if (result < 0) {
 		dev_err(i2c->dev, "failed to attach interrupt\n");
-		goto fail_irq;
+		goto out;
 	}
 
 	result = octeon_i2c_initlowlevel(i2c);
 	if (result) {
 		dev_err(i2c->dev, "init low level failed\n");
-		goto  fail_add;
+		goto  out;
 	}
 
 	result = octeon_i2c_setclock(i2c);
 	if (result) {
 		dev_err(i2c->dev, "clock init failed\n");
-		goto  fail_add;
+		goto  out;
 	}
 
 	i2c->adap = octeon_i2c_ops;
 	i2c->adap.dev.parent = &pdev->dev;
-	i2c->adap.nr = pdev->id >= 0 ? pdev->id : 0;
+	i2c->adap.dev.of_node = pdev->dev.of_node;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	platform_set_drvdata(pdev, i2c);
 
-	result = i2c_add_numbered_adapter(&i2c->adap);
+	result = i2c_add_adapter(&i2c->adap);
 	if (result < 0) {
 		dev_err(i2c->dev, "failed to add adapter\n");
 		goto fail_add;
 	}
-
 	dev_info(i2c->dev, "version %s\n", DRV_VERSION);
 
-	return result;
+	of_i2c_register_devices(&i2c->adap);
+
+	return 0;
 
 fail_add:
 	platform_set_drvdata(pdev, NULL);
-	free_irq(i2c->irq, i2c);
-fail_irq:
-	iounmap(i2c->twsi_base);
-	release_mem_region(i2c->twsi_phys, i2c->regsize);
-fail_region:
-	kfree(i2c);
 out:
 	return result;
 };
@@ -613,19 +615,24 @@ static int __devexit octeon_i2c_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&i2c->adap);
 	platform_set_drvdata(pdev, NULL);
-	free_irq(i2c->irq, i2c);
-	iounmap(i2c->twsi_base);
-	release_mem_region(i2c->twsi_phys, i2c->regsize);
-	kfree(i2c);
 	return 0;
 };
 
+static struct of_device_id octeon_i2c_match[] = {
+	{
+		.compatible = "cavium,octeon-3860-twsi",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_i2c_match);
+
 static struct platform_driver octeon_i2c_driver = {
 	.probe		= octeon_i2c_probe,
 	.remove		= __devexit_p(octeon_i2c_remove),
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= DRV_NAME,
+		.of_match_table = octeon_i2c_match,
 	},
 };
 
@@ -635,4 +642,3 @@ MODULE_AUTHOR("Michael Lawnick <michael.lawnick.ext@nsn.com>");
 MODULE_DESCRIPTION("I2C-Bus adapter for Cavium OCTEON processors");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.2.3
