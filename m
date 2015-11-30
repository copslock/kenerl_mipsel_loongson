Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 21:58:31 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:57032 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008007AbbK3U631Wxkw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2015 21:58:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=WZ6WSPDoK/+ConlQf0DCgsgUmo6/Hfti7QlhhFEuGk0=;
        b=lnL+nZI4bySy3VfLjN5et/LM5o5wUq5suNCip4laMl9QsBB5RjJoZobXxK4IWmAspEAwFVzP71ioLWAu9NR6Cu0NWMZCziqzOs9yQc/i8H9iDMQMcVq/LMWk8yMtPEpWPV2drUdXojvH+mnIXfoWtPIGToJn2mk1EPWglsGExewf6jQXYgZqr6/d7AHGdwTjdyrE+8Ak/3vpI7wOFUHa+LAYQH3lpHQO5rCzs1sUTrvvMfjg3UrTvsrLpc2Wc4WnqjiYxXGJPINEZD8EACJm3W/UjvRLkHpMSJGaf97Y1wyadtEUlOgez/CwAI5AWfLsQkDfa8rxeJNUswe3KX6s9Q==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:43546 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a3VWi-00023x-VV (Exim); Mon, 30 Nov 2015 20:58:25 +0000
Subject: [PATCH 2/2] reset: bcm63xx: Add support for the BCM63xx soft-reset
 controller
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <565CB83B.7010000@simon.arlott.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <565CB86F.4040303@simon.arlott.org.uk>
Date:   Mon, 30 Nov 2015 20:58:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <565CB83B.7010000@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50218
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

The BCM63xx contains a soft-reset controller activated by setting
a bit (that must previously have cleared).

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 MAINTAINERS                   |   1 +
 drivers/reset/Kconfig         |   9 +++
 drivers/reset/Makefile        |   1 +
 drivers/reset/reset-bcm63xx.c | 134 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+)
 create mode 100644 drivers/reset/reset-bcm63xx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 07613dd..55e493a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2378,6 +2378,7 @@ F:	drivers/irqchip/irq-bcm63*
 F:	drivers/irqchip/irq-bcm7*
 F:	drivers/irqchip/irq-brcmstb*
 F:	drivers/regulator/bcm63*
+F:	drivers/reset/reset-bcm63*
 F:	include/linux/bcm63xx_wdt.h
 
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 0615f50..064dad2 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -12,4 +12,13 @@ menuconfig RESET_CONTROLLER
 
 	  If unsure, say no.
 
+if RESET_CONTROLLER
+
+config RESET_BCM63XX
+	bool "BCM63xx Reset Controller"
+	help
+	  Support resetting of devices on BCM63xx boards.
+
+endif
+
 source "drivers/reset/sti/Kconfig"
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 85d5904..f6e2171 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_ATH79) += reset-ath79.o
+obj-$(CONFIG_RESET_BCM63XX) += reset-bcm63xx.o
diff --git a/drivers/reset/reset-bcm63xx.c b/drivers/reset/reset-bcm63xx.c
new file mode 100644
index 0000000..46db57f
--- /dev/null
+++ b/drivers/reset/reset-bcm63xx.c
@@ -0,0 +1,134 @@
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
+#define to_bcm63xx_reset_priv(p) \
+		container_of((p), struct bcm63xx_reset_priv, rcdev)
+
+struct bcm63xx_reset_priv {
+	struct regmap *map;
+	u32 offset;
+	u32 mask; /* valid reset bits */
+	struct reset_controller_dev rcdev;
+	struct mutex mutex;
+};
+
+static int bcm63xx_reset_reset(struct reset_controller_dev *rcdev,
+	unsigned long id)
+{
+	struct bcm63xx_reset_priv *priv = to_bcm63xx_reset_priv(rcdev);
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
+static int bcm63xx_reset_xlate(struct reset_controller_dev *rcdev,
+	const struct of_phandle_args *reset_spec)
+{
+	struct bcm63xx_reset_priv *priv = to_bcm63xx_reset_priv(rcdev);
+
+	if (WARN_ON(reset_spec->args_count != rcdev->of_reset_n_cells))
+		return -EINVAL;
+
+	if (reset_spec->args[0] >= rcdev->nr_resets)
+		return -EINVAL;
+
+	if (!(BIT(reset_spec->args[0]) & priv->mask))
+		return -EINVAL;
+
+	return reset_spec->args[0];
+}
+
+
+static struct reset_control_ops bcm63xx_reset_ops = {
+	.reset = bcm63xx_reset_reset,
+};
+
+static int __init bcm63xx_reset_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct bcm63xx_reset_priv *priv;
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
+	/* valid reset bits */
+	if (of_property_read_u32(np, "mask", &priv->mask))
+		priv->mask = 0xffffffff;
+
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.ops = &bcm63xx_reset_ops;
+	priv->rcdev.nr_resets = 32;
+	priv->rcdev.of_node = pdev->dev.of_node;
+	priv->rcdev.of_reset_n_cells = 1;
+	priv->rcdev.of_xlate = bcm63xx_reset_xlate;
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
+static const struct of_device_id bcm63xx_reset_dt_match[] __initconst = {
+	{ .compatible = "brcm,bcm63xx-reset" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bcm63xx_reset_dt_match);
+
+static struct platform_driver bcm63xx_reset_driver __refdata = {
+	.probe	= bcm63xx_reset_probe,
+	.driver	= {
+		.name = "bcm63xx-reset",
+		.of_match_table = bcm63xx_reset_dt_match,
+	},
+};
+module_platform_driver(bcm63xx_reset_driver);
+
+MODULE_DESCRIPTION("BCM63xx reset driver");
+MODULE_AUTHOR("Simon Arlott");
+MODULE_LICENSE("GPL");
-- 
2.1.4

-- 
Simon Arlott
