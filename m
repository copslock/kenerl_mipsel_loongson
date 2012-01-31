Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:17:30 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59770 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904039Ab2AaOMs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:12:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 94310338ACE;
        Tue, 31 Jan 2012 15:12:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WIlvhfEDoGMp; Tue, 31 Jan 2012 15:12:48 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id D76FB35D627;
        Tue, 31 Jan 2012 15:12:47 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 5/5 v2] hw_random: add Broadcom BCM63xx RNG driver
Date:   Tue, 31 Jan 2012 15:12:25 +0100
Message-Id: <1328019145-5946-6-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328019145-5946-1-git-send-email-florian@openwrt.org>
References: <1328019145-5946-1-git-send-email-florian@openwrt.org>
X-archive-position: 32363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- renamed TRNG -> RNG and trng -> rng

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
index 0000000..b789dbf
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
+struct bcm63xx_rng_priv {
+	struct clk *clk;
+	void __iomem *regs;
+};
+
+#define to_rng_priv(rng)	((struct bcm63xx_rng_priv *)rng->priv)
+
+static int bcm63xx_rng_init(struct hwrng *rng)
+{
+	struct bcm63xx_rng_priv *priv = to_rng_priv(rng);
+	u32 val;
+
+	val = bcm_readl(priv->regs + RNG_CTRL);
+	val |= RNG_EN;
+	bcm_writel(val, priv->regs + RNG_CTRL);
+
+	return 0;
+}
+
+static void bcm63xx_rng_cleanup(struct hwrng *rng)
+{
+	struct bcm63xx_rng_priv *priv = to_rng_priv(rng);
+	u32 val;
+
+	val = bcm_readl(priv->regs + RNG_CTRL);
+	val &= ~RNG_EN;
+	bcm_writel(val, priv->regs + RNG_CTRL);
+}
+
+static int bcm63xx_rng_data_present(struct hwrng *rng, int wait)
+{
+	struct bcm63xx_rng_priv *priv = to_rng_priv(rng);
+
+	return bcm_readl(priv->regs + RNG_STAT) & RNG_AVAIL_MASK;
+}
+
+static int bcm63xx_rng_data_read(struct hwrng *rng, u32 *data)
+{
+	struct bcm63xx_rng_priv *priv = to_rng_priv(rng);
+
+	*data = bcm_readl(priv->regs + RNG_DATA);
+
+	return 4;
+}
+
+static int __init bcm63xx_rng_probe(struct platform_device *pdev)
+{
+	struct resource *r;
+	struct clk *clk;
+	int ret;
+	struct bcm63xx_rng_priv *priv;
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
+	rng->init = bcm63xx_rng_init;
+	rng->cleanup = bcm63xx_rng_cleanup;
+	rng->data_present = bcm63xx_rng_data_present;
+	rng->data_read = bcm63xx_rng_data_read;
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
+static int __devexit bcm63xx_rng_remove(struct platform_device *pdev)
+{
+	struct hwrng *rng = platform_get_drvdata(pdev);
+	struct bcm63xx_rng_priv *priv = to_rng_priv(rng);
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
+static struct platform_driver bcm63xx_rng_driver = {
+	.probe		= bcm63xx_rng_probe,
+	.remove		= __devexit_p(bcm63xx_rng_remove),
+	.driver		= {
+		.name	= "bcm63xx-rng",
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(bcm63xx_rng_driver);
+
+MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
+MODULE_DESCRIPTION("Broadcom BCM63xx RNG driver");
+MODULE_LICENSE("GPL");
-- 
1.7.5.4
