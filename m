Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2011 22:03:21 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15627 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491885Ab1HaUCD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2011 22:02:03 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e5e937e0003>; Wed, 31 Aug 2011 13:03:10 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 31 Aug 2011 13:01:59 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 31 Aug 2011 13:01:59 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p7VK1rrO014052;
        Wed, 31 Aug 2011 13:01:59 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p7VK1rZq014051;
        Wed, 31 Aug 2011 13:01:53 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3/3] netdev/of/phy: Add MDIO bus multiplexer driven by GPIO lines.
Date:   Wed, 31 Aug 2011 13:01:46 -0700
Message-Id: <1314820906-14004-4-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1314820906-14004-1-git-send-email-david.daney@cavium.com>
References: <1314820906-14004-1-git-send-email-david.daney@cavium.com>
X-OriginalArrivalTime: 31 Aug 2011 20:01:59.0781 (UTC) FILETIME=[D7E98150:01CC6818]
X-archive-position: 31024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 23655

The GPIO pins select which sub bus is connected to the master.

Initially tested with an sn74cbtlv3253 switch device wired into the
MDIO bus.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: "David S. Miller" <davem@davemloft.net>
---
 .../devicetree/bindings/net/mdio-mux-gpio.txt      |  127 +++++++++++++++++
 drivers/net/phy/Kconfig                            |    9 ++
 drivers/net/phy/Makefile                           |    1 +
 drivers/net/phy/mdio-mux-gpio.c                    |  143 ++++++++++++++++++++
 4 files changed, 280 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux-gpio.txt
 create mode 100644 drivers/net/phy/mdio-mux-gpio.c

diff --git a/Documentation/devicetree/bindings/net/mdio-mux-gpio.txt b/Documentation/devicetree/bindings/net/mdio-mux-gpio.txt
new file mode 100644
index 0000000..23406a4
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
+- compatible : Should define the compatible device type for the
+               multiplexer.  Currently "cavium,mdio-mux-sn74cbtlv3253"
+               is defined, others are possible.
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
+		compatible = "cavium,mdio-mux-sn74cbtlv3253", "cavium,mdio-mux";
+		gpios = <&gpio1 3 0>, <&gpio1 4 0>;
+		parent-bus = <&smi1>;
+
+		mdio@2 {
+			cell-index = <2>;
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
+			cell-index = <3>;
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
index 59848bc..59b3b17 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -127,6 +127,15 @@ config MDIO_BUS_MUX
 	  to a parent bus.  Switching between child busses is done by
 	  device specific drivers.
 
+config MDIO_BUS_MUX_GPIO
+	tristate "Support for GPIO controlled MDIO bus multiplexers"
+	depends on MDIO_BUS_MUX && GENERIC_GPIO
+	help
+	  This module provides a driver for MDIO bus multiplexers that
+	  are controlled via GPIO lines.  The multiplexer connects one of
+	  several child MDIO busses to a parent bus.  Child bus
+	  selection is under the control of GPIO lines.
+
 config MDIO_OCTEON
 	tristate "Support for MDIO buses on Octeon SOCs"
 	depends on  CPU_CAVIUM_OCTEON
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 0c081d5..d1a1927 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_STE10XP)		+= ste10Xp.o
 obj-$(CONFIG_MICREL_PHY)	+= micrel.o
 obj-$(CONFIG_MDIO_OCTEON)	+= mdio-octeon.o
 obj-$(CONFIG_MDIO_BUS_MUX)	+= mdio-mux.o
+obj-$(CONFIG_MDIO_BUS_MUX_GPIO)	+= mdio-mux-gpio.o
diff --git a/drivers/net/phy/mdio-mux-gpio.c b/drivers/net/phy/mdio-mux-gpio.c
new file mode 100644
index 0000000..3cdad35
--- /dev/null
+++ b/drivers/net/phy/mdio-mux-gpio.c
@@ -0,0 +1,143 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011 Cavium Networks
+ */
+
+#include <linux/platform_device.h>
+#include <linux/of_mdio.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/gfp.h>
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
+		int gpio = of_get_named_gpio_flags(pdev->dev.of_node,
+						   "gpios", n, &f);
+		s->gpio[n] = gpio;
+		if (gpio < 0) {
+			r = -ENODEV;
+			goto err;
+		}
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
+	r = mdio_mux_probe(pdev, mdio_mux_gpio_switch_fn, s);
+
+	if (r == 0)
+		return 0;
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
+	return 0;
+}
+
+static struct of_device_id mdio_mux_gpio_match[] = {
+	{
+		.compatible = "cavium,mdio-mux-sn74cbtlv3253",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mdio_mux_match);
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
+static int __init mdio_mux_gpio_mod_init(void)
+{
+	return platform_driver_register(&mdio_mux_gpio_driver);
+}
+late_initcall(mdio_mux_gpio_mod_init);
+
+static void __exit mdio_mux_gpio_mod_exit(void)
+{
+	platform_driver_unregister(&mdio_mux_gpio_driver);
+}
+module_exit(mdio_mux_gpio_mod_exit);
+
+MODULE_DESCRIPTION(DRV_DESCRIPTION);
+MODULE_VERSION(DRV_VERSION);
+MODULE_AUTHOR("David Daney");
+MODULE_LICENSE("GPL");
-- 
1.7.2.3
