Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2015 22:34:49 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:50107 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013651AbbLJVershJnJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Dec 2015 22:34:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=/Ij9/U3YpDjl5MG6dzMZAFQL9tQueNn/n4deNXbngcA=;
        b=AlBlcDk5F101SdwIxljLLJmUNvFWqUiX9QNavogE+yHcr5UxDwL7rR1h4/DOqhs5DjQ5VIrSp0YR1r+rCJrlUxRBmqG5cc01vOigJb9hJO2XadXYpkQpwA+YZC2M8Hg6JkYO5k4CDXNHvJTw0ugujUv3LdiFPaunG//+jQSHE/hOMY56BBje6d4cUfbuhyLuAqNNnROfLgWbarHp+y/2SpKH0ohioNva5vlBu8KpLx5aeu3DrYMOWYjwIXaQ0Nnl4BZsz/6nQY+o0/8PPLUe9r0dC2uVRYhxHBgj1gvTUEmFOxyIsBUHSEeIP667yVDhpEoPlgt1myOAMwQgodMtEA==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:60727 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a78rE-0008Ed-7F (Exim); Thu, 10 Dec 2015 21:34:37 +0000
Subject: [PATCH linux-next (v3) 2/2] reset: bcm6345: Add support for the
 BCM6345 soft-reset controller
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <5669EE86.8030406@simon.arlott.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Jonas Gorski <jogo@openwrt.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <5669EFEA.7060303@simon.arlott.org.uk>
Date:   Thu, 10 Dec 2015 21:34:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <5669EE86.8030406@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50531
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

The BCM6345 contains a soft-reset controller activated by setting
a bit (that must previously have been cleared).

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
v3: Resend based on linux-next, no changes.

v2: Renamed to bcm6345, removed "mask" property (and the regmap register
    size is always assumed to be 32 bits).
    Moved from drivers/reset/ to drivers/reset/bcm/.

 MAINTAINERS                       |   1 +
 drivers/reset/Kconfig             |   1 +
 drivers/reset/Makefile            |  17 +++---
 drivers/reset/bcm/Kconfig         |  10 ++++
 drivers/reset/bcm/Makefile        |   1 +
 drivers/reset/bcm/reset-bcm6345.c | 109 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 131 insertions(+), 8 deletions(-)
 create mode 100644 drivers/reset/bcm/Kconfig
 create mode 100644 drivers/reset/bcm/Makefile
 create mode 100644 drivers/reset/bcm/reset-bcm6345.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b54ddc..b81b238 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2393,6 +2393,7 @@ F:	drivers/clk/bcm/clk-bcm6345*
 F:	drivers/irqchip/irq-bcm63*
 F:	drivers/irqchip/irq-bcm7*
 F:	drivers/irqchip/irq-brcmstb*
+F:	drivers/reset/bcm/reset-bcm6345*
 F:	include/linux/bcm63xx_wdt.h
 
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 0615f50..ee73f5f 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -12,4 +12,5 @@ menuconfig RESET_CONTROLLER
 
 	  If unsure, say no.
 
+source "drivers/reset/bcm/Kconfig"
 source "drivers/reset/sti/Kconfig"
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 85d5904..a34f469 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,8 +1,9 @@
-obj-$(CONFIG_RESET_CONTROLLER) += core.o
-obj-$(CONFIG_ARCH_LPC18XX) += reset-lpc18xx.o
-obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
-obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
-obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
-obj-$(CONFIG_ARCH_STI) += sti/
-obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
-obj-$(CONFIG_ATH79) += reset-ath79.o
+obj-$(CONFIG_RESET_CONTROLLER)	+= core.o
+obj-$(CONFIG_ARCH_LPC18XX)	+= reset-lpc18xx.o
+obj-$(CONFIG_ARCH_SOCFPGA)	+= reset-socfpga.o
+obj-$(CONFIG_ARCH_BERLIN)	+= reset-berlin.o
+obj-$(CONFIG_ARCH_SUNXI)	+= reset-sunxi.o
+obj-$(CONFIG_ARCH_STI)		+= sti/
+obj-$(CONFIG_ARCH_ZYNQ)		+= reset-zynq.o
+obj-$(CONFIG_ATH79)		+= reset-ath79.o
+obj-y				+= bcm/
diff --git a/drivers/reset/bcm/Kconfig b/drivers/reset/bcm/Kconfig
new file mode 100644
index 0000000..85931c9
--- /dev/null
+++ b/drivers/reset/bcm/Kconfig
@@ -0,0 +1,10 @@
+if RESET_CONTROLLER
+
+config RESET_BCM6345
+	bool "BCM6345 Reset Controller"
+	depends on BMIPS_GENERIC
+	default BMIPS_GENERIC
+	help
+	  Support resetting of devices on BCM6345 boards.
+
+endif
diff --git a/drivers/reset/bcm/Makefile b/drivers/reset/bcm/Makefile
new file mode 100644
index 0000000..3d004bd
--- /dev/null
+++ b/drivers/reset/bcm/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_RESET_BCM6345)	+= reset-bcm6345.o
diff --git a/drivers/reset/bcm/reset-bcm6345.c b/drivers/reset/bcm/reset-bcm6345.c
new file mode 100644
index 0000000..a95433d
--- /dev/null
+++ b/drivers/reset/bcm/reset-bcm6345.c
@@ -0,0 +1,109 @@
+/*
+ * Copyright 2015 Simon Arlott
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Derived from reset-berlin.c:
+ * Copyright (C) 2014 Marvell Technology Group Ltd.
+ *
+ * Antoine Tenart <antoine.tenart@free-electrons.com>
+ * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#define to_bcm6345_reset_priv(p) \
+		container_of((p), struct bcm6345_reset_priv, rcdev)
+
+struct bcm6345_reset_priv {
+	struct regmap *map;
+	u32 offset;
+	struct reset_controller_dev rcdev;
+	struct mutex mutex;
+};
+
+static int bcm6345_reset_reset(struct reset_controller_dev *rcdev,
+	unsigned long id)
+{
+	struct bcm6345_reset_priv *priv = to_bcm6345_reset_priv(rcdev);
+
+	mutex_lock(&priv->mutex);
+	regmap_write_bits(priv->map, priv->offset, BIT(id), 0);
+	usleep_range(10000, 20000);
+	regmap_write_bits(priv->map, priv->offset, BIT(id), BIT(id));
+	usleep_range(10000, 20000);
+	mutex_unlock(&priv->mutex);
+
+	return 0;
+}
+
+static struct reset_control_ops bcm6345_reset_ops = {
+	.reset = bcm6345_reset_reset,
+};
+
+static int __init bcm6345_reset_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct bcm6345_reset_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mutex_init(&priv->mutex);
+
+	priv->map = syscon_regmap_lookup_by_phandle(np, "regmap");
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
+
+	if (of_property_read_u32(np, "offset", &priv->offset))
+		return -EINVAL;
+
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.ops = &bcm6345_reset_ops;
+	priv->rcdev.nr_resets = 32;
+	priv->rcdev.of_node = pdev->dev.of_node;
+
+	ret = reset_controller_register(&priv->rcdev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"unable to register reset controller: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "registered reset controller\n");
+	return 0;
+}
+
+static const struct of_device_id bcm6345_reset_dt_match[] __initconst = {
+	{ .compatible = "brcm,bcm6345-reset" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bcm6345_reset_dt_match);
+
+static struct platform_driver bcm6345_reset_driver __refdata = {
+	.probe	= bcm6345_reset_probe,
+	.driver	= {
+		.name = "bcm6345-reset",
+		.of_match_table = bcm6345_reset_dt_match,
+	},
+};
+module_platform_driver(bcm6345_reset_driver);
+
+MODULE_DESCRIPTION("BCM6345 reset driver");
+MODULE_AUTHOR("Simon Arlott");
+MODULE_LICENSE("GPL");
-- 
2.1.4

-- 
Simon Arlott
