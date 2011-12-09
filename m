Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2011 20:04:06 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59820 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903743Ab1LITBz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Dec 2011 20:01:55 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 66E3738FEB9;
        Fri,  9 Dec 2011 20:01:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5uLGWDiu4hub; Fri,  9 Dec 2011 20:01:54 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id D55CD398038;
        Fri,  9 Dec 2011 20:01:53 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     Matt Mackall <mpm@selenic.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 5/5] hw_random: add Broadcom BCM63xx RNG driver
Date:   Fri,  9 Dec 2011 20:01:10 +0100
Message-Id: <1323457270-16330-6-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1323457270-16330-1-git-send-email-florian@openwrt.org>
References: <1323457270-16330-1-git-send-email-florian@openwrt.org>
X-archive-position: 32075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7991

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 drivers/char/hw_random/Kconfig       |   14 +++
 drivers/char/hw_random/Makefile      |    1 +
 drivers/char/hw_random/bcm63xx-rng.c |  175 ++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 0 deletions(-)
 create mode 100644 drivers/char/hw_random/bcm63xx-rng.c

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 0689bf6..f29d1bc 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -73,6 +73,20 @@ config HW_RANDOM_ATMEL
 
 	  If unsure, say Y.
 
+config HW_RANDOM_BCM63XX
+	tristate "Broadcom BCM63xx Random Number Generator support"
+	depends on HW_RANDOM && BCM63XX
+	default HW_RANDOM
+	---help---
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on the Broadcom BCM63xx SoCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called bcm63xx-rng
+
+	  If unusure, say Y.
+
+
 config HW_RANDOM_GEODE
 	tristate "AMD Geode HW Random Number Generator support"
 	depends on HW_RANDOM && X86_32 && PCI
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index b2ff526..8cfac60 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_HW_RANDOM_TIMERIOMEM) += timeriomem-rng.o
 obj-$(CONFIG_HW_RANDOM_INTEL) += intel-rng.o
 obj-$(CONFIG_HW_RANDOM_AMD) += amd-rng.o
 obj-$(CONFIG_HW_RANDOM_ATMEL) += atmel-rng.o
+obj-$(CONFIG_HW_RANDOM_BCM63XX)	+= bcm63xx-rng.o
 obj-$(CONFIG_HW_RANDOM_GEODE) += geode-rng.o
 obj-$(CONFIG_HW_RANDOM_N2RNG) += n2-rng.o
 n2-rng-y := n2-drv.o n2-asm.o
diff --git a/drivers/char/hw_random/bcm63xx-rng.c b/drivers/char/hw_random/bcm63xx-rng.c
new file mode 100644
index 0000000..80e282d
--- /dev/null
+++ b/drivers/char/hw_random/bcm63xx-rng.c
@@ -0,0 +1,175 @@
+/*
+ * Broadcom BCM63xx Random Number Generator support
+ *
+ * Copyright (C) 2011, Florian Fainelli <florian@openwrt.org>
+ * Copyright (C) 2009, Broadcom Corporation
+ *
+ */
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/hw_random.h>
+
+#include <bcm63xx_io.h>
+#include <bcm63xx_regs.h>
+
+struct bcm63xx_trng_priv {
+	struct clk *clk;
+	void __iomem *regs;
+};
+
+#define to_trng_priv(rng)	((struct bcm63xx_trng_priv *)rng->priv)
+
+static int bcm63xx_trng_init(struct hwrng *rng)
+{
+	struct bcm63xx_trng_priv *priv = to_trng_priv(rng);
+	u32 val;
+
+	val = bcm_readl(priv->regs + TRNG_CTRL);
+	val |= TRNG_EN;
+	bcm_writel(val, priv->regs + TRNG_CTRL);
+
+	return 0;
+}
+
+static void bcm63xx_trng_cleanup(struct hwrng *rng)
+{
+	struct bcm63xx_trng_priv *priv = to_trng_priv(rng);
+	u32 val;
+
+	val = bcm_readl(priv->regs + TRNG_CTRL);
+	val &= ~TRNG_EN;
+	bcm_writel(val, priv->regs + TRNG_CTRL);
+}
+
+static int bcm63xx_trng_data_present(struct hwrng *rng, int wait)
+{
+	struct bcm63xx_trng_priv *priv = to_trng_priv(rng);
+
+	return bcm_readl(priv->regs + TRNG_STAT) & TRNG_AVAIL_MASK;
+}
+
+static int bcm63xx_trng_data_read(struct hwrng *rng, u32 *data)
+{
+	struct bcm63xx_trng_priv *priv = to_trng_priv(rng);
+
+	*data = bcm_readl(priv->regs + TRNG_DATA);
+
+	return 4;
+}
+
+static int __init bcm63xx_trng_probe(struct platform_device *pdev)
+{
+	struct resource *r;
+	struct clk *clk;
+	int ret;
+	struct bcm63xx_trng_priv *priv;
+	struct hwrng *rng;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		dev_err(&pdev->dev, "no iomem resource\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(&pdev->dev, "no memory for private structure\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	rng = kzalloc(sizeof(*rng), GFP_KERNEL);
+	if (!rng) {
+		dev_err(&pdev->dev, "no memory for rng structure\n");
+		ret = -ENOMEM;
+		goto out_free_priv;
+	}
+
+	platform_set_drvdata(pdev, rng);
+	rng->priv = (unsigned long)priv;
+	rng->name = pdev->name;
+	rng->init = bcm63xx_trng_init;
+	rng->cleanup = bcm63xx_trng_cleanup;
+	rng->data_present = bcm63xx_trng_data_present;
+	rng->data_read = bcm63xx_trng_data_read;
+
+	clk = clk_get(&pdev->dev, "ipsec");
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "no clock for device\n");
+		ret = PTR_ERR(clk);
+		goto out_free_rng;
+	}
+
+	priv->clk = clk;
+
+	if (!devm_request_mem_region(&pdev->dev, r->start,
+					resource_size(r), pdev->name)) {
+		dev_err(&pdev->dev, "request mem failed");
+		ret = -ENOMEM;
+		goto out_free_rng;
+	}
+
+	priv->regs = devm_ioremap_nocache(&pdev->dev, r->start,
+					resource_size(r));
+	if (!priv->regs) {
+		dev_err(&pdev->dev, "ioremap failed");
+		ret = -ENOMEM;
+		goto out_free_rng;
+	}
+
+	clk_enable(clk);
+
+	ret = hwrng_register(rng);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register rng device\n");
+		goto out_clk_disable;
+	}
+
+	dev_info(&pdev->dev, "registered RNG driver\n");
+
+	return 0;
+
+out_clk_disable:
+	clk_disable(clk);
+out_free_rng:
+	platform_set_drvdata(pdev, NULL);
+	kfree(rng);
+out_free_priv:
+	kfree(priv);
+out:
+	return ret;
+}
+
+static int __devexit bcm63xx_trng_remove(struct platform_device *pdev)
+{
+	struct hwrng *rng = platform_get_drvdata(pdev);
+	struct bcm63xx_trng_priv *priv = to_trng_priv(rng);
+
+	hwrng_unregister(rng);
+	clk_disable(priv->clk);
+	kfree(priv);
+	kfree(rng);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver bcm63xx_trng_driver = {
+	.probe		= bcm63xx_trng_probe,
+	.remove		= __devexit_p(bcm63xx_trng_remove),
+	.driver		= {
+		.name	= "bcm63xx-trng",
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(bcm63xx_trng_driver);
+
+MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
+MODULE_DESCRIPTION("Broadcom BCM63xx RNG driver");
+MODULE_LICENSE("GPL");
-- 
1.7.5.4
