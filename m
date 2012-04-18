Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2012 01:22:33 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:38691 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903733Ab2DRXVI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Apr 2012 01:21:08 +0200
Received: by obcni5 with SMTP id ni5so3717465obc.36
        for <linux-mips@linux-mips.org>; Wed, 18 Apr 2012 16:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=F2JRv+F/KaohIsIY5c2WAne0oi26lKd1202lIppncaE=;
        b=Y4KO1zAwDm0Rt2dRtDZiX+jMQJnvMTja8bBXNzIenvh7UytCErVYU5UIn/FDl5f9cD
         KJfxe6iqIvnJeik8yAl13J5ZDH5Bqc0DNJ6QqBhfl0311GG1fNkTtnFhlrHWVIwHGaAT
         rZ813YYys5Ds17DGVpHNi+e/FRtI0/9cvEwktFUeqkKN/28nUK3LP1gauiC6KYJlluYY
         G00RdZaW8U4BcXNEmDlZJv1tcLIvPeqAcSGS204zska9G1RT7fQG21Lor5CovE8tZ7/a
         1OepnH/fNCN2lGM65bJbnDg0mauDwt3ZA8HH39Ei7+kp3fIleo0JsTaqsnY48u4+U9Dl
         aM6g==
Received: by 10.60.29.39 with SMTP id g7mr6048461oeh.6.1334791262580;
        Wed, 18 Apr 2012 16:21:02 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id i6sm522314obv.5.2012.04.18.16.21.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 16:21:00 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3INKx4M016038;
        Wed, 18 Apr 2012 16:20:59 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3INKxD6016037;
        Wed, 18 Apr 2012 16:20:59 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        devicetree-discuss@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, galak@kernel.crashing.org,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v5 2/3] netdev/of/phy: Add MDIO bus multiplexer support.
Date:   Wed, 18 Apr 2012 16:20:53 -0700
Message-Id: <1334791254-15987-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1334791254-15987-1-git-send-email-ddaney.cavm@gmail.com>
References: <1334791254-15987-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

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
---
 Documentation/devicetree/bindings/net/mdio-mux.txt |  136 ++++++++++++++
 drivers/net/phy/Kconfig                            |    8 +
 drivers/net/phy/Makefile                           |    1 +
 drivers/net/phy/mdio-mux.c                         |  192 ++++++++++++++++++++
 include/linux/mdio-mux.h                           |   21 ++
 5 files changed, 358 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux.txt
 create mode 100644 drivers/net/phy/mdio-mux.c
 create mode 100644 include/linux/mdio-mux.h

diff --git a/Documentation/devicetree/bindings/net/mdio-mux.txt b/Documentation/devicetree/bindings/net/mdio-mux.txt
new file mode 100644
index 0000000..f65606f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mdio-mux.txt
@@ -0,0 +1,136 @@
+Common MDIO bus multiplexer/switch properties.
+
+An MDIO bus multiplexer/switch will have several child busses that are
+numbered uniquely in a device dependent manner.  The nodes for an MDIO
+bus multiplexer/switch will have one child node for each child bus.
+
+Required properties:
+- mdio-parent-bus : phandle to the parent MDIO bus.
+- #address-cells = <1>;
+- #size-cells = <0>;
+
+Optional properties:
+- Other properties specific to the multiplexer/switch hardware.
+
+Required properties for child nodes:
+- #address-cells = <1>;
+- #size-cells = <0>;
+- reg : The sub-bus number.
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
index 0e01f4e..222b06b 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -135,6 +135,14 @@ config MDIO_OCTEON
 
 	  If in doubt, say Y.
 
+config MDIO_BUS_MUX
+	tristate
+	help
+	  This module provides a driver framework for MDIO bus
+	  multiplexers which connect one of several child MDIO busses
+	  to a parent bus.  Switching between child busses is done by
+	  device specific drivers.
+
 endif # PHYLIB
 
 config MICREL_KS8995MA
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index b7438b1..a6b50e7 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_MICREL_PHY)	+= micrel.o
 obj-$(CONFIG_MDIO_OCTEON)	+= mdio-octeon.o
 obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
+obj-$(CONFIG_MDIO_BUS_MUX)	+= mdio-mux.o
diff --git a/drivers/net/phy/mdio-mux.c b/drivers/net/phy/mdio-mux.c
new file mode 100644
index 0000000..39ea067
--- /dev/null
+++ b/drivers/net/phy/mdio-mux.c
@@ -0,0 +1,192 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011, 2012 Cavium, Inc.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/mdio-mux.h>
+#include <linux/of_mdio.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+
+#define DRV_VERSION "1.0"
+#define DRV_DESCRIPTION "MDIO bus multiplexer driver"
+
+struct mdio_mux_child_bus;
+
+struct mdio_mux_parent_bus {
+	struct mii_bus *mii_bus;
+	int current_child;
+	int parent_id;
+	void *switch_data;
+	int (*switch_fn)(int current_child, int desired_child, void *data);
+
+	/* List of our children linked through their next fields. */
+	struct mdio_mux_child_bus *children;
+};
+
+struct mdio_mux_child_bus {
+	struct mii_bus *mii_bus;
+	struct mdio_mux_parent_bus *parent;
+	struct mdio_mux_child_bus *next;
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
+int mdio_mux_init(struct device *dev,
+		  int (*switch_fn)(int cur, int desired, void *data),
+		  void **mux_handle,
+		  void *data)
+{
+	struct device_node *parent_bus_node;
+	struct device_node *child_bus_node;
+	int r, ret_val;
+	struct mii_bus *parent_bus;
+	struct mdio_mux_parent_bus *pb;
+	struct mdio_mux_child_bus *cb;
+
+	if (!dev->of_node)
+		return -ENODEV;
+
+	parent_bus_node = of_parse_phandle(dev->of_node, "mdio-parent-bus", 0);
+
+	if (!parent_bus_node)
+		return -ENODEV;
+
+	parent_bus = of_mdio_find_bus(parent_bus_node);
+	if (parent_bus == NULL) {
+		ret_val = -EPROBE_DEFER;
+		goto err_parent_bus;
+	}
+
+	pb = devm_kzalloc(dev, sizeof(*pb), GFP_KERNEL);
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
+	ret_val = -ENODEV;
+	for_each_child_of_node(dev->of_node, child_bus_node) {
+		u32 v;
+
+		r = of_property_read_u32(child_bus_node, "reg", &v);
+		if (r)
+			continue;
+
+		cb = devm_kzalloc(dev, sizeof(*cb), GFP_KERNEL);
+		if (cb == NULL) {
+			dev_err(dev,
+				"Error: Failed to allocate memory for child\n");
+			ret_val = -ENOMEM;
+			break;
+		}
+		cb->bus_number = v;
+		cb->parent = pb;
+		cb->mii_bus = mdiobus_alloc();
+		cb->mii_bus->priv = cb;
+
+		cb->mii_bus->irq = cb->phy_irq;
+		cb->mii_bus->name = "mdio_mux";
+		snprintf(cb->mii_bus->id, MII_BUS_ID_SIZE, "%x.%x",
+			 pb->parent_id, v);
+		cb->mii_bus->parent = dev;
+		cb->mii_bus->read = mdio_mux_read;
+		cb->mii_bus->write = mdio_mux_write;
+		r = of_mdiobus_register(cb->mii_bus, child_bus_node);
+		if (r) {
+			mdiobus_free(cb->mii_bus);
+			devm_kfree(dev, cb);
+		} else {
+			of_node_get(child_bus_node);
+			cb->next = pb->children;
+			pb->children = cb;
+		}
+	}
+	if (pb->children) {
+		*mux_handle = pb;
+		dev_info(dev, "Version " DRV_VERSION "\n");
+		return 0;
+	}
+err_parent_bus:
+	of_node_put(parent_bus_node);
+	return ret_val;
+}
+EXPORT_SYMBOL_GPL(mdio_mux_init);
+
+void mdio_mux_uninit(void *mux_handle)
+{
+	struct mdio_mux_parent_bus *pb = mux_handle;
+	struct mdio_mux_child_bus *cb = pb->children;
+
+	while (cb) {
+		mdiobus_unregister(cb->mii_bus);
+		mdiobus_free(cb->mii_bus);
+		cb = cb->next;
+	}
+}
+EXPORT_SYMBOL_GPL(mdio_mux_uninit);
+
+MODULE_DESCRIPTION(DRV_DESCRIPTION);
+MODULE_VERSION(DRV_VERSION);
+MODULE_AUTHOR("David Daney");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mdio-mux.h b/include/linux/mdio-mux.h
new file mode 100644
index 0000000..a243dbb
--- /dev/null
+++ b/include/linux/mdio-mux.h
@@ -0,0 +1,21 @@
+/*
+ * MDIO bus multiplexer framwork.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2011, 2012 Cavium, Inc.
+ */
+#ifndef __LINUX_MDIO_MUX_H
+#define __LINUX_MDIO_MUX_H
+#include <linux/device.h>
+
+int mdio_mux_init(struct device *dev,
+		  int (*switch_fn) (int cur, int desired, void *data),
+		  void **mux_handle,
+		  void *data);
+
+void mdio_mux_uninit(void *mux_handle);
+
+#endif /* __LINUX_MDIO_MUX_H */
-- 
1.7.2.3
