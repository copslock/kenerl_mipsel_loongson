Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2011 22:02:58 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15611 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491887Ab1HaUB4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2011 22:01:56 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e5e93790000>; Wed, 31 Aug 2011 13:03:05 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 31 Aug 2011 13:01:54 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 31 Aug 2011 13:01:54 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p7VK1rq2014048;
        Wed, 31 Aug 2011 13:01:53 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p7VK1rUD014047;
        Wed, 31 Aug 2011 13:01:53 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     David Daney <david.daney@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 2/3] netdev/of/phy: Add MDIO bus multiplexer support.
Date:   Wed, 31 Aug 2011 13:01:45 -0700
Message-Id: <1314820906-14004-3-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1314820906-14004-1-git-send-email-david.daney@cavium.com>
References: <1314820906-14004-1-git-send-email-david.daney@cavium.com>
X-OriginalArrivalTime: 31 Aug 2011 20:01:54.0140 (UTC) FILETIME=[D48CC1C0:01CC6818]
X-archive-position: 31023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 23652

This patch adds a somewhat generic framework for MDIO bus
multiplexers.  It is modeled on the I2C multiplexer.

The multiplexer is needed if there are multiple PHYs with the same
address connected to the same MDIO bus adepter, or if there is
insufficient electrical drive capability for all the connected PHY
devices.

Conceptually it could look something like this:

                   ------------------
                   | Control Signal |
                   --------+---------
                           |
 ---------------   --------+------
 | MDIO MASTER |---| Multiplexer |
 ---------------   --+-------+----
                     |       |
                     C       C
                     h       h
                     i       i
                     l       l
                     d       d
                     |       |
     ---------       A       B   ---------
     |       |       |       |   |       |
     | PHY@1 +-------+       +---+ PHY@1 |
     |       |       |       |   |       |
     ---------       |       |   ---------
     ---------       |       |   ---------
     |       |       |       |   |       |
     | PHY@2 +-------+       +---+ PHY@2 |
     |       |                   |       |
     ---------                   ---------

This framework configures the bus topology from device tree data.  The
mechanics of switching the multiplexer is left to device specific
drivers.

The follow-on patch contains a multiplexer driven by GPIO lines.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: "David S. Miller" <davem@davemloft.net>
---
 Documentation/devicetree/bindings/net/mdio-mux.txt |  132 ++++++++++++++
 drivers/net/phy/Kconfig                            |    8 +
 drivers/net/phy/Makefile                           |    1 +
 drivers/net/phy/mdio-mux.c                         |  182 ++++++++++++++++++++
 include/linux/mdio-mux.h                           |   18 ++
 5 files changed, 341 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux.txt
 create mode 100644 drivers/net/phy/mdio-mux.c
 create mode 100644 include/linux/mdio-mux.h

diff --git a/Documentation/devicetree/bindings/net/mdio-mux.txt b/Documentation/devicetree/bindings/net/mdio-mux.txt
new file mode 100644
index 0000000..a908312
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mdio-mux.txt
@@ -0,0 +1,132 @@
+Common MDIO bus multiplexer/switch properties.
+
+An MDIO bus multiplexer/switch will have several child busses that are
+numbered uniquely in a device dependent manner.  The nodes for an MDIO
+bus multiplexer/switch will have one child node for each child bus.
+
+Required properties:
+- parent-bus : phandle to the parent MDIO bus.
+
+Optional properties:
+- Other properties specific to the multiplexer/switch hardware.
+
+Required properties for child nodes:
+- #address-cells = <1>;
+- #size-cells = <0>;
+- cell-index : The sub-bus number.
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
index a702443..59848bc 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -119,6 +119,14 @@ config MDIO_GPIO
 	  To compile this driver as a module, choose M here: the module
 	  will be called mdio-gpio.
 
+config MDIO_BUS_MUX
+	tristate "Support for MDIO bus multiplexers"
+	help
+	  This module provides a driver framework for MDIO bus
+	  multiplexers which connect one of several child MDIO busses
+	  to a parent bus.  Switching between child busses is done by
+	  device specific drivers.
+
 config MDIO_OCTEON
 	tristate "Support for MDIO buses on Octeon SOCs"
 	depends on  CPU_CAVIUM_OCTEON
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 2333215..0c081d5 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_DP83640_PHY)	+= dp83640.o
 obj-$(CONFIG_STE10XP)		+= ste10Xp.o
 obj-$(CONFIG_MICREL_PHY)	+= micrel.o
 obj-$(CONFIG_MDIO_OCTEON)	+= mdio-octeon.o
+obj-$(CONFIG_MDIO_BUS_MUX)	+= mdio-mux.o
diff --git a/drivers/net/phy/mdio-mux.c b/drivers/net/phy/mdio-mux.c
new file mode 100644
index 0000000..f9c5826
--- /dev/null
+++ b/drivers/net/phy/mdio-mux.c
@@ -0,0 +1,182 @@
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
+
+#define DRV_VERSION "1.0"
+#define DRV_DESCRIPTION "MDIO bus multiplexer driver"
+
+struct mdio_mux_parent_bus {
+	struct mii_bus *mii_bus;
+	int current_child;
+	int parent_id;
+	void *switch_data;
+	int (*switch_fn)(int current_child, int desired_child, void *data);
+};
+
+struct mdio_mux_child_bus {
+	struct mii_bus *mii_bus;
+	struct mdio_mux_parent_bus *parent;
+	int bus_number;
+	int phy_irq[PHY_MAX_ADDR];
+};
+
+/*
+ * The parent bus' lock is used to order access to the switch_fn.
+ */
+static int mdio_mux_read(struct mii_bus *bus, int phy_id, int regnum)
+{
+	struct mdio_mux_child_bus *cb = bus->priv;
+	struct mdio_mux_parent_bus *pb = cb->parent;
+	int r;
+
+	mutex_lock(&pb->mii_bus->mdio_lock);
+	r = pb->switch_fn(pb->current_child, cb->bus_number, pb->switch_data);
+	if (r)
+		goto out;
+
+	pb->current_child = cb->bus_number;
+
+	r = pb->mii_bus->read(pb->mii_bus, phy_id, regnum);
+out:
+	mutex_unlock(&pb->mii_bus->mdio_lock);
+
+	return r;
+}
+
+/*
+ * The parent bus' lock is used to order access to the switch_fn.
+ */
+static int mdio_mux_write(struct mii_bus *bus, int phy_id,
+			  int regnum, u16 val)
+{
+	struct mdio_mux_child_bus *cb = bus->priv;
+	struct mdio_mux_parent_bus *pb = cb->parent;
+
+	int r;
+
+	mutex_lock(&pb->mii_bus->mdio_lock);
+	r = pb->switch_fn(pb->current_child, cb->bus_number, pb->switch_data);
+	if (r)
+		goto out;
+
+	pb->current_child = cb->bus_number;
+
+	r = pb->mii_bus->write(pb->mii_bus, phy_id, regnum, val);
+out:
+	mutex_unlock(&pb->mii_bus->mdio_lock);
+
+	return r;
+}
+
+static int parent_count;
+
+int mdio_mux_probe(struct platform_device *pdev,
+		   int (*switch_fn)(int cur, int desired, void *data),
+		   void *data)
+{
+	struct device_node *parent_bus_node;
+	struct device_node *child_bus_node;
+	int r, n, ret_val;
+	struct mii_bus *parent_bus;
+	struct mdio_mux_parent_bus *pb;
+	struct mdio_mux_child_bus *cb;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	parent_bus_node = of_parse_phandle(pdev->dev.of_node, "parent-bus", 0);
+
+	if (!parent_bus_node)
+		return -ENODEV;
+
+	parent_bus = of_mdio_find_bus(parent_bus_node);
+
+	pb = devm_kzalloc(&pdev->dev, sizeof(*pb), GFP_KERNEL);
+	if (pb == NULL) {
+		ret_val = -ENOMEM;
+		goto err_parent_bus;
+	}
+
+	pb->switch_data = data;
+	pb->switch_fn = switch_fn;
+	pb->current_child = -1;
+	pb->parent_id = parent_count++;
+	pb->mii_bus = parent_bus;
+
+	n = 0;
+	for_each_child_of_node(pdev->dev.of_node, child_bus_node) {
+		u32 v;
+
+		r = of_property_read_u32(child_bus_node, "cell-index", &v);
+		if (r == 0) {
+			cb = devm_kzalloc(&pdev->dev, sizeof(*cb), GFP_KERNEL);
+			if (cb == NULL)
+				break;
+			cb->bus_number = v;
+			cb->parent = pb;
+			cb->mii_bus = mdiobus_alloc();
+			cb->mii_bus->priv = cb;
+
+			cb->mii_bus->irq = cb->phy_irq;
+			cb->mii_bus->name = "mdio_mux";
+			snprintf(cb->mii_bus->id, MII_BUS_ID_SIZE, "%x.%x",
+				 pb->parent_id, v);
+			cb->mii_bus->parent = &pdev->dev;
+			cb->mii_bus->read = mdio_mux_read;
+			cb->mii_bus->write = mdio_mux_write;
+			r = of_mdiobus_register(cb->mii_bus, child_bus_node);
+			if (r) {
+				of_node_put(child_bus_node);
+				devm_kfree(&pdev->dev, cb);
+			} else {
+				n++;
+			}
+
+		} else {
+			of_node_put(child_bus_node);
+		}
+	}
+	if (n) {
+		dev_info(&pdev->dev, "Version " DRV_VERSION "\n");
+		return 0;
+	}
+	ret_val = -ENOMEM;
+	devm_kfree(&pdev->dev, pb);
+err_parent_bus:
+	of_node_put(parent_bus_node);
+	return ret_val;
+}
+EXPORT_SYMBOL(mdio_mux_probe);
+
+static int __devexit mdio_mux_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int __init mdio_mux_mod_init(void)
+{
+	return 0;
+}
+module_init(mdio_mux_mod_init);
+
+static void __exit mdio_mux_mod_exit(void)
+{
+}
+module_exit(mdio_mux_mod_exit);
+
+MODULE_DESCRIPTION(DRV_DESCRIPTION);
+MODULE_VERSION(DRV_VERSION);
+MODULE_AUTHOR("David Daney");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mdio-mux.h b/include/linux/mdio-mux.h
new file mode 100644
index 0000000..522992a
--- /dev/null
+++ b/include/linux/mdio-mux.h
@@ -0,0 +1,18 @@
+/*
+ * MDIO bus multiplexer framwork.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011 Cavium Networks
+ */
+#ifndef __LINUX_MDIO_MUX_H
+#define __LINUX_MDIO_MUX_H
+#include <linux/platform_device.h>
+
+int mdio_mux_probe(struct platform_device *pdev,
+		   int (*switch_fn) (int cur, int desired, void *data),
+		   void *data);
+
+#endif /* __LINUX_MDIO_MUX_H */
-- 
1.7.2.3
