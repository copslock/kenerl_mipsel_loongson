Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2012 03:05:45 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:50602 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903690Ab2DQBDs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Apr 2012 03:03:48 +0200
Received: by obcni5 with SMTP id ni5so253554obc.36
        for <linux-mips@linux-mips.org>; Mon, 16 Apr 2012 18:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+L6RKIJdnuPhu0uf9zR7x+s8lODEdeeCHKM3Y+MW/g4=;
        b=MyMmudoixAHihoK4P3BomwErbFuOSDPwIUNDc5NkQ5DYXJayYW24pFdgCXr5/sMVRP
         nXfbnMYbrHuFWJ1uMwP47/GKZQGoU4zDMZu+b2zYYToPJWSllYKaIkpkvj0FgYH4mvVI
         EIxScz4o4fnRe/2uk/d8Iy7l+7J+eF+S3cvWorC2l5t/Dp72TT+ATnbNewwJiLPbQBA+
         mMojo147iiOdauFOBo063NwoyBNQCZXFI4yRnAcGqio9JCqK6TAiCpA3kBliA6geGoRA
         blaUNRxNrBsJw1717KMYIbymQGCEsgSsDe9Pwt5w4Ss534nlHH9UjqrDOa8Xjmh+/VvH
         PWFQ==
Received: by 10.182.118.38 with SMTP id kj6mr10754208obb.60.1334624622064;
        Mon, 16 Apr 2012 18:03:42 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id es5sm21372371obc.11.2012.04.16.18.03.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 18:03:40 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3H13cjd026714;
        Mon, 16 Apr 2012 18:03:38 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3H13csi026713;
        Mon, 16 Apr 2012 18:03:38 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, galak@kernel.crashing.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v3 3/3] netdev/of/phy: Add MDIO bus multiplexer driven by GPIO lines.
Date:   Mon, 16 Apr 2012 18:03:28 -0700
Message-Id: <1334624608-26667-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1334624608-26667-1-git-send-email-ddaney.cavm@gmail.com>
References: <1334624608-26667-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The GPIO pins select which sub bus is connected to the master.

Initially tested with an sn74cbtlv3253 switch device wired into the
MDIO bus.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 .../devicetree/bindings/net/mdio-mux-gpio.txt      |  127 +++++++++++++++++
 drivers/net/phy/Kconfig                            |   10 ++
 drivers/net/phy/Makefile                           |    1 +
 drivers/net/phy/mdio-mux-gpio.c                    |  142 ++++++++++++++++++++
 4 files changed, 280 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux-gpio.txt
 create mode 100644 drivers/net/phy/mdio-mux-gpio.c

diff --git a/Documentation/devicetree/bindings/net/mdio-mux-gpio.txt b/Documentation/devicetree/bindings/net/mdio-mux-gpio.txt
new file mode 100644
index 0000000..7938411
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mdio-mux-gpio.txt
@@ -0,0 +1,127 @@
+Properties for an MDIO bus multiplexer/switch controlled by GPIO pins.
+
+This is a special case of a MDIO bus multiplexer.  One or more GPIO
+lines are used to control which child bus is connected.
+
+Required properties in addition to the generic multiplexer properties:
+
+- compatible : mdio-mux-gpio.
+- gpios : GPIO specifiers for each GPIO line.  One or more must be specified.
+
+
+Example :
+
+	/* The parent MDIO bus. */
+	smi1: mdio@1180000001900 {
+		compatible = "cavium,octeon-3860-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x11800 0x00001900 0x0 0x40>;
+	};
+
+	/*
+	   An NXP sn74cbtlv3253 dual 1-of-4 switch controlled by a
+	   pair of GPIO lines.  Child busses 2 and 3 populated with 4
+	   PHYs each.
+	 */
+	mdio-mux {
+		compatible = "mdio-mux-gpio";
+		gpios = <&gpio1 3 0>, <&gpio1 4 0>;
+		mdio-parent-bus = <&smi1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mdio@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			phy11: ethernet-phy@1 {
+				reg = <1>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+				interrupt-parent = <&gpio>;
+				interrupts = <10 8>; /* Pin 10, active low */
+			};
+			phy12: ethernet-phy@2 {
+				reg = <2>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+				interrupt-parent = <&gpio>;
+				interrupts = <10 8>; /* Pin 10, active low */
+			};
+			phy13: ethernet-phy@3 {
+				reg = <3>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+				interrupt-parent = <&gpio>;
+				interrupts = <10 8>; /* Pin 10, active low */
+			};
+			phy14: ethernet-phy@4 {
+				reg = <4>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+				interrupt-parent = <&gpio>;
+				interrupts = <10 8>; /* Pin 10, active low */
+			};
+		};
+
+		mdio@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			phy21: ethernet-phy@1 {
+				reg = <1>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+				interrupt-parent = <&gpio>;
+				interrupts = <12 8>; /* Pin 12, active low */
+			};
+			phy22: ethernet-phy@2 {
+				reg = <2>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+				interrupt-parent = <&gpio>;
+				interrupts = <12 8>; /* Pin 12, active low */
+			};
+			phy23: ethernet-phy@3 {
+				reg = <3>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+				interrupt-parent = <&gpio>;
+				interrupts = <12 8>; /* Pin 12, active low */
+			};
+			phy24: ethernet-phy@4 {
+				reg = <4>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+				interrupt-parent = <&gpio>;
+				interrupts = <12 8>; /* Pin 12, active low */
+			};
+		};
+	};
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 222b06b..39d8c66 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -143,6 +143,16 @@ config MDIO_BUS_MUX
 	  to a parent bus.  Switching between child busses is done by
 	  device specific drivers.
 
+config MDIO_BUS_MUX_GPIO
+	tristate "Support for GPIO controlled MDIO bus multiplexers"
+	depends on GENERIC_GPIO
+	select MDIO_BUS_MUX
+	help
+	  This module provides a driver for MDIO bus multiplexers that
+	  are controlled via GPIO lines.  The multiplexer connects one of
+	  several child MDIO busses to a parent bus.  Child bus
+	  selection is under the control of GPIO lines.
+
 endif # PHYLIB
 
 config MICREL_KS8995MA
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index a6b50e7..f51af68 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_MDIO_OCTEON)	+= mdio-octeon.o
 obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
 obj-$(CONFIG_MDIO_BUS_MUX)	+= mdio-mux.o
+obj-$(CONFIG_MDIO_BUS_MUX_GPIO)	+= mdio-mux-gpio.o
diff --git a/drivers/net/phy/mdio-mux-gpio.c b/drivers/net/phy/mdio-mux-gpio.c
new file mode 100644
index 0000000..e0cc4ef
--- /dev/null
+++ b/drivers/net/phy/mdio-mux-gpio.c
@@ -0,0 +1,142 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011, 2012 Cavium, Inc.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/of_mdio.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/phy.h>
+#include <linux/mdio-mux.h>
+#include <linux/of_gpio.h>
+
+#define DRV_VERSION "1.0"
+#define DRV_DESCRIPTION "GPIO controlled MDIO bus multiplexer driver"
+
+#define MDIO_MUX_GPIO_MAX_BITS 8
+
+struct mdio_mux_gpio_state {
+	int gpio[MDIO_MUX_GPIO_MAX_BITS];
+	unsigned int num_gpios;
+	void *mux_handle;
+};
+
+static int mdio_mux_gpio_switch_fn(int current_child, int desired_child,
+				   void *data)
+{
+	int change;
+	unsigned int n;
+	struct mdio_mux_gpio_state *s = data;
+
+	if (current_child == desired_child)
+		return 0;
+
+	change = current_child == -1 ? -1 : current_child ^ desired_child;
+
+	for (n = 0; n < s->num_gpios; n++) {
+		if (change & 1)
+			gpio_set_value_cansleep(s->gpio[n],
+						(desired_child & 1) != 0);
+		change >>= 1;
+		desired_child >>= 1;
+	}
+
+	return 0;
+}
+
+static int __devinit mdio_mux_gpio_probe(struct platform_device *pdev)
+{
+	enum of_gpio_flags f;
+	struct mdio_mux_gpio_state *s;
+	unsigned int num_gpios;
+	unsigned int n;
+	int r;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	num_gpios = of_gpio_count(pdev->dev.of_node);
+	if (num_gpios == 0 || num_gpios > MDIO_MUX_GPIO_MAX_BITS)
+		return -ENODEV;
+
+	s = devm_kzalloc(&pdev->dev, sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	s->num_gpios = num_gpios;
+
+	for (n = 0; n < num_gpios; ) {
+		int gpio = of_get_gpio_flags(pdev->dev.of_node, n, &f);
+		if (gpio < 0) {
+			r = (gpio == -ENODEV) ? -EPROBE_DEFER : gpio;
+			goto err;
+		}
+		s->gpio[n] = gpio;
+
+		n++;
+
+		r = gpio_request(gpio, "mdio_mux_gpio");
+		if (r)
+			goto err;
+
+		r = gpio_direction_output(gpio, 0);
+		if (r)
+			goto err;
+	}
+
+	r = mdio_mux_init(&pdev->dev,
+			  mdio_mux_gpio_switch_fn, &s->mux_handle, s);
+
+	if (r == 0) {
+		pdev->dev.platform_data = s;
+		return 0;
+	}
+err:
+	while (n) {
+		n--;
+		gpio_free(s->gpio[n]);
+	}
+	devm_kfree(&pdev->dev, s);
+	return r;
+}
+
+static int __devexit mdio_mux_gpio_remove(struct platform_device *pdev)
+{
+	struct mdio_mux_gpio_state *s = pdev->dev.platform_data;
+	mdio_mux_uninit(s->mux_handle);
+	return 0;
+}
+
+static struct of_device_id mdio_mux_gpio_match[] = {
+	{
+		.compatible = "mdio-mux-gpio",
+	},
+	{
+		/* Legacy compatible property. */
+		.compatible = "cavium,mdio-mux-sn74cbtlv3253",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mdio_mux_gpio_match);
+
+static struct platform_driver mdio_mux_gpio_driver = {
+	.driver = {
+		.name		= "mdio-mux-gpio",
+		.owner		= THIS_MODULE,
+		.of_match_table = mdio_mux_gpio_match,
+	},
+	.probe		= mdio_mux_gpio_probe,
+	.remove		= __devexit_p(mdio_mux_gpio_remove),
+};
+
+module_platform_driver(mdio_mux_gpio_driver);
+
+MODULE_DESCRIPTION(DRV_DESCRIPTION);
+MODULE_VERSION(DRV_VERSION);
+MODULE_AUTHOR("David Daney");
+MODULE_LICENSE("GPL");
-- 
1.7.2.3
