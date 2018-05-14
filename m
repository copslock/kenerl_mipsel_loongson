Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 22:06:45 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:47558 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992737AbeENUF3nXRl- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 22:05:29 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7F421208BB; Mon, 14 May 2018 22:05:22 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id EB81B20794;
        Mon, 14 May 2018 22:05:21 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH net-next v3 4/7] net: mscc: Add initial Ocelot switch support
Date:   Mon, 14 May 2018 22:04:57 +0200
Message-Id: <20180514200500.2953-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Add a driver for Microsemi Ocelot Ethernet switch support.

This makes two modules:
mscc_ocelot_common handles all the common features that doesn't depend on
how the switch is integrated in the SoC. Currently, it handles offloading
bridging to the hardware. ocelot_io.c handles register accesses. This is
unfortunately needed because the register layout is packed and then depends
on the number of ports available on the switch. The register definition
files are automatically generated.

ocelot_board handles the switch integration on the SoC and on the board.

Frame injection and extraction to/from the CPU port is currently done using
register accesses which is quite slow. DMA is possible but the port is not
able to absorb the whole switch bandwidth.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/net/ethernet/Kconfig                |    1 +
 drivers/net/ethernet/Makefile               |    1 +
 drivers/net/ethernet/mscc/Kconfig           |   30 +
 drivers/net/ethernet/mscc/Makefile          |    5 +
 drivers/net/ethernet/mscc/ocelot.c          | 1333 +++++++++++++++++++
 drivers/net/ethernet/mscc/ocelot.h          |  572 ++++++++
 drivers/net/ethernet/mscc/ocelot_ana.h      |  625 +++++++++
 drivers/net/ethernet/mscc/ocelot_board.c    |  316 +++++
 drivers/net/ethernet/mscc/ocelot_dev.h      |  275 ++++
 drivers/net/ethernet/mscc/ocelot_dev_gmii.h |  154 +++
 drivers/net/ethernet/mscc/ocelot_hsio.h     |  785 +++++++++++
 drivers/net/ethernet/mscc/ocelot_io.c       |  116 ++
 drivers/net/ethernet/mscc/ocelot_qs.h       |   78 ++
 drivers/net/ethernet/mscc/ocelot_qsys.h     |  270 ++++
 drivers/net/ethernet/mscc/ocelot_regs.c     |  497 +++++++
 drivers/net/ethernet/mscc/ocelot_rew.h      |   81 ++
 drivers/net/ethernet/mscc/ocelot_sys.h      |  144 ++
 17 files changed, 5283 insertions(+)
 create mode 100644 drivers/net/ethernet/mscc/Kconfig
 create mode 100644 drivers/net/ethernet/mscc/Makefile
 create mode 100644 drivers/net/ethernet/mscc/ocelot.c
 create mode 100644 drivers/net/ethernet/mscc/ocelot.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_ana.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_board.c
 create mode 100644 drivers/net/ethernet/mscc/ocelot_dev.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_dev_gmii.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_hsio.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_io.c
 create mode 100644 drivers/net/ethernet/mscc/ocelot_qs.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_qsys.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_regs.c
 create mode 100644 drivers/net/ethernet/mscc/ocelot_rew.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_sys.h

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 603a5704dab8..54d71e1c48d5 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -114,6 +114,7 @@ source "drivers/net/ethernet/mediatek/Kconfig"
 source "drivers/net/ethernet/mellanox/Kconfig"
 source "drivers/net/ethernet/micrel/Kconfig"
 source "drivers/net/ethernet/microchip/Kconfig"
+source "drivers/net/ethernet/mscc/Kconfig"
 source "drivers/net/ethernet/moxa/Kconfig"
 source "drivers/net/ethernet/myricom/Kconfig"
 
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 2bfd2eea50bf..8fbfe9ce2fa5 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_NET_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_NET_VENDOR_MELLANOX) += mellanox/
 obj-$(CONFIG_NET_VENDOR_MICREL) += micrel/
 obj-$(CONFIG_NET_VENDOR_MICROCHIP) += microchip/
+obj-$(CONFIG_NET_VENDOR_MICROSEMI) += mscc/
 obj-$(CONFIG_NET_VENDOR_MOXART) += moxa/
 obj-$(CONFIG_NET_VENDOR_MYRI) += myricom/
 obj-$(CONFIG_FEALNX) += fealnx.o
diff --git a/drivers/net/ethernet/mscc/Kconfig b/drivers/net/ethernet/mscc/Kconfig
new file mode 100644
index 000000000000..36c84625d54e
--- /dev/null
+++ b/drivers/net/ethernet/mscc/Kconfig
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+config NET_VENDOR_MICROSEMI
+	bool "Microsemi devices"
+	default y
+	help
+	  If you have a network (Ethernet) card belonging to this class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Microsemi devices.
+
+if NET_VENDOR_MICROSEMI
+
+config MSCC_OCELOT_SWITCH
+	tristate "Ocelot switch driver"
+	depends on NET_SWITCHDEV
+	depends on HAS_IOMEM
+	select PHYLIB
+	select REGMAP_MMIO
+	help
+	  This driver supports the Ocelot network switch device.
+
+config MSCC_OCELOT_SWITCH_OCELOT
+	tristate "Ocelot switch driver on Ocelot"
+	depends on MSCC_OCELOT_SWITCH
+	help
+	  This driver supports the Ocelot network switch device as present on
+	  the Ocelot SoCs.
+
+endif # NET_VENDOR_MICROSEMI
diff --git a/drivers/net/ethernet/mscc/Makefile b/drivers/net/ethernet/mscc/Makefile
new file mode 100644
index 000000000000..cb52a3b128ae
--- /dev/null
+++ b/drivers/net/ethernet/mscc/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+obj-$(CONFIG_MSCC_OCELOT_SWITCH) += mscc_ocelot_common.o
+mscc_ocelot_common-y := ocelot.o ocelot_io.o
+mscc_ocelot_common-y += ocelot_regs.o
+obj-$(CONFIG_MSCC_OCELOT_SWITCH_OCELOT) += ocelot_board.o
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
new file mode 100644
index 000000000000..c8c74aa548d9
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -0,0 +1,1333 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/if_bridge.h>
+#include <linux/if_ether.h>
+#include <linux/if_vlan.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/phy.h>
+#include <linux/skbuff.h>
+#include <net/arp.h>
+#include <net/netevent.h>
+#include <net/rtnetlink.h>
+#include <net/switchdev.h>
+
+#include "ocelot.h"
+
+/* MAC table entry types.
+ * ENTRYTYPE_NORMAL is subject to aging.
+ * ENTRYTYPE_LOCKED is not subject to aging.
+ * ENTRYTYPE_MACv4 is not subject to aging. For IPv4 multicast.
+ * ENTRYTYPE_MACv6 is not subject to aging. For IPv6 multicast.
+ */
+enum macaccess_entry_type {
+	ENTRYTYPE_NORMAL = 0,
+	ENTRYTYPE_LOCKED,
+	ENTRYTYPE_MACv4,
+	ENTRYTYPE_MACv6,
+};
+
+struct ocelot_mact_entry {
+	u8 mac[ETH_ALEN];
+	u16 vid;
+	enum macaccess_entry_type type;
+};
+
+static inline int ocelot_mact_wait_for_completion(struct ocelot *ocelot)
+{
+	unsigned int val, timeout = 10;
+
+	/* Wait for the issued mac table command to be completed, or timeout.
+	 * When the command read from  ANA_TABLES_MACACCESS is
+	 * MACACCESS_CMD_IDLE, the issued command completed successfully.
+	 */
+	do {
+		val = ocelot_read(ocelot, ANA_TABLES_MACACCESS);
+		val &= ANA_TABLES_MACACCESS_MAC_TABLE_CMD_M;
+	} while (val != MACACCESS_CMD_IDLE && timeout--);
+
+	if (!timeout)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static void ocelot_mact_select(struct ocelot *ocelot,
+			       const unsigned char mac[ETH_ALEN],
+			       unsigned int vid)
+{
+	u32 macl = 0, mach = 0;
+
+	/* Set the MAC address to handle and the vlan associated in a format
+	 * understood by the hardware.
+	 */
+	mach |= vid    << 16;
+	mach |= mac[0] << 8;
+	mach |= mac[1] << 0;
+	macl |= mac[2] << 24;
+	macl |= mac[3] << 16;
+	macl |= mac[4] << 8;
+	macl |= mac[5] << 0;
+
+	ocelot_write(ocelot, macl, ANA_TABLES_MACLDATA);
+	ocelot_write(ocelot, mach, ANA_TABLES_MACHDATA);
+
+}
+
+static int ocelot_mact_learn(struct ocelot *ocelot, int port,
+			     const unsigned char mac[ETH_ALEN],
+			     unsigned int vid,
+			     enum macaccess_entry_type type)
+{
+	ocelot_mact_select(ocelot, mac, vid);
+
+	/* Issue a write command */
+	ocelot_write(ocelot, ANA_TABLES_MACACCESS_VALID |
+			     ANA_TABLES_MACACCESS_DEST_IDX(port) |
+			     ANA_TABLES_MACACCESS_ENTRYTYPE(type) |
+			     ANA_TABLES_MACACCESS_MAC_TABLE_CMD(MACACCESS_CMD_LEARN),
+			     ANA_TABLES_MACACCESS);
+
+	return ocelot_mact_wait_for_completion(ocelot);
+}
+
+static int ocelot_mact_forget(struct ocelot *ocelot,
+			      const unsigned char mac[ETH_ALEN],
+			      unsigned int vid)
+{
+	ocelot_mact_select(ocelot, mac, vid);
+
+	/* Issue a forget command */
+	ocelot_write(ocelot,
+		     ANA_TABLES_MACACCESS_MAC_TABLE_CMD(MACACCESS_CMD_FORGET),
+		     ANA_TABLES_MACACCESS);
+
+	return ocelot_mact_wait_for_completion(ocelot);
+}
+
+static void ocelot_mact_init(struct ocelot *ocelot)
+{
+	/* Configure the learning mode entries attributes:
+	 * - Do not copy the frame to the CPU extraction queues.
+	 * - Use the vlan and mac_cpoy for dmac lookup.
+	 */
+	ocelot_rmw(ocelot, 0,
+		   ANA_AGENCTRL_LEARN_CPU_COPY | ANA_AGENCTRL_IGNORE_DMAC_FLAGS
+		   | ANA_AGENCTRL_LEARN_FWD_KILL
+		   | ANA_AGENCTRL_LEARN_IGNORE_VLAN,
+		   ANA_AGENCTRL);
+
+	/* Clear the MAC table */
+	ocelot_write(ocelot, MACACCESS_CMD_INIT, ANA_TABLES_MACACCESS);
+}
+
+static inline int ocelot_vlant_wait_for_completion(struct ocelot *ocelot)
+{
+	unsigned int val, timeout = 10;
+
+	/* Wait for the issued mac table command to be completed, or timeout.
+	 * When the command read from ANA_TABLES_MACACCESS is
+	 * MACACCESS_CMD_IDLE, the issued command completed successfully.
+	 */
+	do {
+		val = ocelot_read(ocelot, ANA_TABLES_VLANACCESS);
+		val &= ANA_TABLES_VLANACCESS_VLAN_TBL_CMD_M;
+	} while (val != ANA_TABLES_VLANACCESS_CMD_IDLE && timeout--);
+
+	if (!timeout)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static void ocelot_vlan_init(struct ocelot *ocelot)
+{
+	/* Clear VLAN table, by default all ports are members of all VLANs */
+	ocelot_write(ocelot, ANA_TABLES_VLANACCESS_CMD_INIT,
+		     ANA_TABLES_VLANACCESS);
+	ocelot_vlant_wait_for_completion(ocelot);
+}
+
+/* Watermark encode
+ * Bit 8:   Unit; 0:1, 1:16
+ * Bit 7-0: Value to be multiplied with unit
+ */
+static u16 ocelot_wm_enc(u16 value)
+{
+	if (value >= BIT(8))
+		return BIT(8) | (value / 16);
+
+	return value;
+}
+
+static void ocelot_port_adjust_link(struct net_device *dev)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+	u8 p = port->chip_port;
+	int speed, atop_wm, mode = 0;
+
+	switch (dev->phydev->speed) {
+	case SPEED_10:
+		speed = OCELOT_SPEED_10;
+		break;
+	case SPEED_100:
+		speed = OCELOT_SPEED_100;
+		break;
+	case SPEED_1000:
+		speed = OCELOT_SPEED_1000;
+		mode = DEV_MAC_MODE_CFG_GIGA_MODE_ENA;
+		break;
+	case SPEED_2500:
+		speed = OCELOT_SPEED_2500;
+		mode = DEV_MAC_MODE_CFG_GIGA_MODE_ENA;
+		break;
+	default:
+		netdev_err(dev, "Unsupported PHY speed: %d\n",
+			   dev->phydev->speed);
+		return;
+	}
+
+	phy_print_status(dev->phydev);
+
+	if (!dev->phydev->link)
+		return;
+
+	/* Only full duplex supported for now */
+	ocelot_port_writel(port, DEV_MAC_MODE_CFG_FDX_ENA |
+			   mode, DEV_MAC_MODE_CFG);
+
+	/* Set MAC IFG Gaps
+	 * FDX: TX_IFG = 5, RX_IFG1 = RX_IFG2 = 0
+	 * !FDX: TX_IFG = 5, RX_IFG1 = RX_IFG2 = 5
+	 */
+	ocelot_port_writel(port, DEV_MAC_IFG_CFG_TX_IFG(5), DEV_MAC_IFG_CFG);
+
+	/* Load seed (0) and set MAC HDX late collision  */
+	ocelot_port_writel(port, DEV_MAC_HDX_CFG_LATE_COL_POS(67) |
+			   DEV_MAC_HDX_CFG_SEED_LOAD,
+			   DEV_MAC_HDX_CFG);
+	mdelay(1);
+	ocelot_port_writel(port, DEV_MAC_HDX_CFG_LATE_COL_POS(67),
+			   DEV_MAC_HDX_CFG);
+
+	/* Disable HDX fast control */
+	ocelot_port_writel(port, DEV_PORT_MISC_HDX_FAST_DIS, DEV_PORT_MISC);
+
+	/* SGMII only for now */
+	ocelot_port_writel(port, PCS1G_MODE_CFG_SGMII_MODE_ENA, PCS1G_MODE_CFG);
+	ocelot_port_writel(port, PCS1G_SD_CFG_SD_SEL, PCS1G_SD_CFG);
+
+	/* Enable PCS */
+	ocelot_port_writel(port, PCS1G_CFG_PCS_ENA, PCS1G_CFG);
+
+	/* No aneg on SGMII */
+	ocelot_port_writel(port, 0, PCS1G_ANEG_CFG);
+
+	/* No loopback */
+	ocelot_port_writel(port, 0, PCS1G_LB_CFG);
+
+	/* Set Max Length and maximum tags allowed */
+	ocelot_port_writel(port, VLAN_ETH_FRAME_LEN, DEV_MAC_MAXLEN_CFG);
+	ocelot_port_writel(port, DEV_MAC_TAGS_CFG_TAG_ID(ETH_P_8021AD) |
+			   DEV_MAC_TAGS_CFG_VLAN_AWR_ENA |
+			   DEV_MAC_TAGS_CFG_VLAN_LEN_AWR_ENA,
+			   DEV_MAC_TAGS_CFG);
+
+	/* Enable MAC module */
+	ocelot_port_writel(port, DEV_MAC_ENA_CFG_RX_ENA |
+			   DEV_MAC_ENA_CFG_TX_ENA, DEV_MAC_ENA_CFG);
+
+	/* Take MAC, Port, Phy (intern) and PCS (SGMII/Serdes) clock out of
+	 * reset */
+	ocelot_port_writel(port, DEV_CLOCK_CFG_LINK_SPEED(speed),
+			   DEV_CLOCK_CFG);
+
+	/* Set SMAC of Pause frame (00:00:00:00:00:00) */
+	ocelot_port_writel(port, 0, DEV_MAC_FC_MAC_HIGH_CFG);
+	ocelot_port_writel(port, 0, DEV_MAC_FC_MAC_LOW_CFG);
+
+	/* No PFC */
+	ocelot_write_gix(ocelot, ANA_PFC_PFC_CFG_FC_LINK_SPEED(speed),
+			 ANA_PFC_PFC_CFG, p);
+
+	/* Set Pause WM hysteresis
+	 * 152 = 6 * VLAN_ETH_FRAME_LEN / OCELOT_BUFFER_CELL_SZ
+	 * 101 = 4 * VLAN_ETH_FRAME_LEN / OCELOT_BUFFER_CELL_SZ
+	 */
+	ocelot_write_rix(ocelot, SYS_PAUSE_CFG_PAUSE_ENA |
+			 SYS_PAUSE_CFG_PAUSE_STOP(101) |
+			 SYS_PAUSE_CFG_PAUSE_START(152), SYS_PAUSE_CFG, p);
+
+	/* Core: Enable port for frame transfer */
+	ocelot_write_rix(ocelot, QSYS_SWITCH_PORT_MODE_INGRESS_DROP_MODE |
+			 QSYS_SWITCH_PORT_MODE_SCH_NEXT_CFG(1) |
+			 QSYS_SWITCH_PORT_MODE_PORT_ENA,
+			 QSYS_SWITCH_PORT_MODE, p);
+
+	/* Flow control */
+	ocelot_write_rix(ocelot, SYS_MAC_FC_CFG_PAUSE_VAL_CFG(0xffff) |
+			 SYS_MAC_FC_CFG_RX_FC_ENA | SYS_MAC_FC_CFG_TX_FC_ENA |
+			 SYS_MAC_FC_CFG_ZERO_PAUSE_ENA |
+			 SYS_MAC_FC_CFG_FC_LATENCY_CFG(0x7) |
+			 SYS_MAC_FC_CFG_FC_LINK_SPEED(speed),
+			 SYS_MAC_FC_CFG, p);
+	ocelot_write_rix(ocelot, 0, ANA_POL_FLOWC, p);
+
+	/* Tail dropping watermark */
+	atop_wm = (ocelot->shared_queue_sz - 9 * VLAN_ETH_FRAME_LEN) / OCELOT_BUFFER_CELL_SZ;
+	ocelot_write_rix(ocelot, ocelot_wm_enc(9 * VLAN_ETH_FRAME_LEN),
+			 SYS_ATOP, p);
+	ocelot_write(ocelot, ocelot_wm_enc(atop_wm), SYS_ATOP_TOT_CFG);
+}
+
+static int ocelot_port_open(struct net_device *dev)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+	int err;
+
+	/* Enable receiving frames on the port, and activate auto-learning of
+	 * MAC addresses.
+	 */
+	ocelot_write_gix(ocelot, ANA_PORT_PORT_CFG_LEARNAUTO |
+			 ANA_PORT_PORT_CFG_RECV_ENA |
+			 ANA_PORT_PORT_CFG_PORTID_VAL(port->chip_port),
+			 ANA_PORT_PORT_CFG, port->chip_port);
+
+	err = phy_connect_direct(dev, port->phy, &ocelot_port_adjust_link,
+				 PHY_INTERFACE_MODE_NA);
+	if (err) {
+		netdev_err(dev, "Could not attach to PHY\n");
+		return err;
+	}
+
+	dev->phydev = port->phy;
+
+	phy_attached_info(port->phy);
+	phy_start(port->phy);
+	return 0;
+}
+
+static int ocelot_port_stop(struct net_device *dev)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+
+	phy_disconnect(port->phy);
+
+	dev->phydev = NULL;
+
+	ocelot_port_writel(port, 0, DEV_MAC_ENA_CFG);
+	ocelot_rmw_rix(port->ocelot, 0, QSYS_SWITCH_PORT_MODE_PORT_ENA,
+			 QSYS_SWITCH_PORT_MODE, port->chip_port);
+	return 0;
+}
+
+/* Generate the IFH for frame injection
+ *
+ * The IFH is a 128bit-value
+ * bit 127: bypass the analyzer processing
+ * bit 56-67: destination mask
+ * bit 28-29: pop_cnt: 3 disables all rewriting of the frame
+ * bit 20-27: cpu extraction queue mask
+ * bit 16: tag type 0: C-tag, 1: S-tag
+ * bit 0-11: VID
+ */
+static int ocelot_gen_ifh(u32 *ifh, struct frame_info *info)
+{
+	ifh[0] = IFH_INJ_BYPASS;
+	ifh[1] = (0xff00 & info->port) >> 8;
+	ifh[2] = (0xff & info->port) << 24;
+	ifh[3] = IFH_INJ_POP_CNT_DISABLE | (info->cpuq << 20) |
+		 (info->tag_type << 16) | info->vid;
+
+	return 0;
+}
+
+static int ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+	u32 val, ifh[IFH_LEN];
+	struct frame_info info = {};
+	u8 grp = 0; /* Send everything on CPU group 0 */
+	unsigned int i, count, last;
+
+	val = ocelot_read(ocelot, QS_INJ_STATUS);
+	if (!(val & QS_INJ_STATUS_FIFO_RDY(BIT(grp))) ||
+	    (val & QS_INJ_STATUS_WMARK_REACHED(BIT(grp))))
+		return NETDEV_TX_BUSY;
+
+	ocelot_write_rix(ocelot, QS_INJ_CTRL_GAP_SIZE(1) |
+			 QS_INJ_CTRL_SOF, QS_INJ_CTRL, grp);
+
+	info.port = BIT(port->chip_port);
+	info.cpuq = 0xff;
+	ocelot_gen_ifh(ifh, &info);
+
+	for (i = 0; i < IFH_LEN; i++)
+		ocelot_write_rix(ocelot, ifh[i], QS_INJ_WR, grp);
+
+	count = (skb->len + 3) / 4;
+	last = skb->len % 4;
+	for (i = 0; i < count; i++) {
+		ocelot_write_rix(ocelot, ((u32 *)skb->data)[i], QS_INJ_WR, grp);
+	}
+
+	/* Add padding */
+	while (i < (OCELOT_BUFFER_CELL_SZ / 4)) {
+		ocelot_write_rix(ocelot, 0, QS_INJ_WR, grp);
+		i++;
+	}
+
+	/* Indicate EOF and valid bytes in last word */
+	ocelot_write_rix(ocelot, QS_INJ_CTRL_GAP_SIZE(1) |
+			 QS_INJ_CTRL_VLD_BYTES(skb->len < OCELOT_BUFFER_CELL_SZ ? 0 : last) |
+			 QS_INJ_CTRL_EOF,
+			 QS_INJ_CTRL, grp);
+
+	/* Add dummy CRC */
+	ocelot_write_rix(ocelot, 0, QS_INJ_WR, grp);
+	skb_tx_timestamp(skb);
+
+	dev->stats.tx_packets++;
+	dev->stats.tx_bytes += skb->len;
+	dev_kfree_skb_any(skb);
+
+	return NETDEV_TX_OK;
+}
+
+static void ocelot_mact_mc_reset(struct ocelot_port *port)
+{
+	struct ocelot *ocelot = port->ocelot;
+	struct netdev_hw_addr *ha, *n;
+
+	/* Free and forget all the MAC addresses stored in the port private mc
+	 * list. These are mc addresses that were previously added by calling
+	 * ocelot_mact_mc_add().
+	 */
+	list_for_each_entry_safe(ha, n, &port->mc, list) {
+		ocelot_mact_forget(ocelot, ha->addr, port->pvid);
+		list_del(&ha->list);
+		kfree(ha);
+	}
+}
+
+static int ocelot_mact_mc_add(struct ocelot_port *port,
+			      struct netdev_hw_addr *hw_addr)
+{
+	struct ocelot *ocelot = port->ocelot;
+	struct netdev_hw_addr *ha = kzalloc(sizeof(*ha), GFP_KERNEL);
+
+	if (!ha)
+		return -ENOMEM;
+
+	memcpy(ha, hw_addr, sizeof(*ha));
+	list_add_tail(&ha->list, &port->mc);
+
+	ocelot_mact_learn(ocelot, PGID_CPU, ha->addr, port->pvid,
+			  ENTRYTYPE_LOCKED);
+
+	return 0;
+}
+
+static void ocelot_set_rx_mode(struct net_device *dev)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+	struct netdev_hw_addr *ha;
+	int i;
+	u32 val;
+
+	/* This doesn't handle promiscuous mode because the bridge core is
+	 * setting IFF_PROMISC on all slave interfaces and all frames would be
+	 * forwarded to the CPU port.
+	 */
+	val = GENMASK(ocelot->num_phys_ports - 1, 0);
+	for (i = ocelot->num_phys_ports + 1; i < PGID_CPU; i++)
+		ocelot_write_rix(ocelot, val, ANA_PGID_PGID, i);
+
+	/* Handle the device multicast addresses. First remove all the
+	 * previously installed addresses and then add the latest ones to the
+	 * mac table.
+	 */
+	ocelot_mact_mc_reset(port);
+	netdev_for_each_mc_addr(ha, dev)
+		ocelot_mact_mc_add(port, ha);
+}
+
+static int ocelot_port_get_phys_port_name(struct net_device *dev,
+					  char *buf, size_t len)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	int ret;
+
+	ret = snprintf(buf, len, "p%d", port->chip_port);
+	if (ret >= len)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ocelot_port_set_mac_address(struct net_device *dev, void *p)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+	const struct sockaddr *addr = p;
+
+	/* Learn the new net device MAC address in the mac table. */
+	ocelot_mact_learn(ocelot, PGID_CPU, addr->sa_data, port->pvid,
+			  ENTRYTYPE_LOCKED);
+	/* Then forget the previous one. */
+	ocelot_mact_forget(ocelot, dev->dev_addr, port->pvid);
+
+	ether_addr_copy(dev->dev_addr, addr->sa_data);
+	return 0;
+}
+
+static void ocelot_get_stats64(struct net_device *dev,
+			       struct rtnl_link_stats64 *stats)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+
+	/* Configure the port to read the stats from */
+	ocelot_write(ocelot, SYS_STAT_CFG_STAT_VIEW(port->chip_port),
+		     SYS_STAT_CFG);
+
+	/* Get Rx stats */
+	stats->rx_bytes = ocelot_read(ocelot, SYS_COUNT_RX_OCTETS);
+	stats->rx_packets = ocelot_read(ocelot, SYS_COUNT_RX_SHORTS) +
+			    ocelot_read(ocelot, SYS_COUNT_RX_FRAGMENTS) +
+			    ocelot_read(ocelot, SYS_COUNT_RX_JABBERS) +
+			    ocelot_read(ocelot, SYS_COUNT_RX_LONGS) +
+			    ocelot_read(ocelot, SYS_COUNT_RX_64) +
+			    ocelot_read(ocelot, SYS_COUNT_RX_65_127) +
+			    ocelot_read(ocelot, SYS_COUNT_RX_128_255) +
+			    ocelot_read(ocelot, SYS_COUNT_RX_256_1023) +
+			    ocelot_read(ocelot, SYS_COUNT_RX_1024_1526) +
+			    ocelot_read(ocelot, SYS_COUNT_RX_1527_MAX);
+	stats->multicast = ocelot_read(ocelot, SYS_COUNT_RX_MULTICAST);
+	stats->rx_dropped = dev->stats.rx_dropped;
+
+	/* Get Tx stats */
+	stats->tx_bytes = ocelot_read(ocelot, SYS_COUNT_TX_OCTETS);
+	stats->tx_packets = ocelot_read(ocelot, SYS_COUNT_TX_64) +
+			    ocelot_read(ocelot, SYS_COUNT_TX_65_127) +
+			    ocelot_read(ocelot, SYS_COUNT_TX_128_511) +
+			    ocelot_read(ocelot, SYS_COUNT_TX_512_1023) +
+			    ocelot_read(ocelot, SYS_COUNT_TX_1024_1526) +
+			    ocelot_read(ocelot, SYS_COUNT_TX_1527_MAX);
+	stats->tx_dropped = ocelot_read(ocelot, SYS_COUNT_TX_DROPS) +
+			    ocelot_read(ocelot, SYS_COUNT_TX_AGING);
+	stats->collisions = ocelot_read(ocelot, SYS_COUNT_TX_COLLISION);
+}
+
+static int ocelot_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
+			  struct net_device *dev, const unsigned char *addr,
+			  u16 vid, u16 flags)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+
+	return ocelot_mact_learn(ocelot, port->chip_port, addr, vid,
+				 ENTRYTYPE_NORMAL);
+}
+
+static int ocelot_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
+			  struct net_device *dev,
+			  const unsigned char *addr, u16 vid)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+
+	return ocelot_mact_forget(ocelot, addr, vid);
+}
+
+struct ocelot_dump_ctx {
+	struct net_device *dev;
+	struct sk_buff *skb;
+	struct netlink_callback *cb;
+	int idx;
+};
+
+static int ocelot_fdb_do_dump(struct ocelot_mact_entry *entry,
+			      struct ocelot_dump_ctx *dump)
+{
+	u32 portid = NETLINK_CB(dump->cb->skb).portid;
+	u32 seq = dump->cb->nlh->nlmsg_seq;
+	struct nlmsghdr *nlh;
+	struct ndmsg *ndm;
+
+	if (dump->idx < dump->cb->args[2])
+		goto skip;
+
+	nlh = nlmsg_put(dump->skb, portid, seq, RTM_NEWNEIGH,
+			sizeof(*ndm), NLM_F_MULTI);
+	if (!nlh)
+		return -EMSGSIZE;
+
+	ndm = nlmsg_data(nlh);
+	ndm->ndm_family  = AF_BRIDGE;
+	ndm->ndm_pad1    = 0;
+	ndm->ndm_pad2    = 0;
+	ndm->ndm_flags   = NTF_SELF;
+	ndm->ndm_type    = 0;
+	ndm->ndm_ifindex = dump->dev->ifindex;
+	ndm->ndm_state   = NUD_REACHABLE;
+
+	if (nla_put(dump->skb, NDA_LLADDR, ETH_ALEN, entry->mac))
+		goto nla_put_failure;
+
+	if (entry->vid && nla_put_u16(dump->skb, NDA_VLAN, entry->vid))
+		goto nla_put_failure;
+
+	nlmsg_end(dump->skb, nlh);
+
+skip:
+	dump->idx++;
+	return 0;
+
+nla_put_failure:
+	nlmsg_cancel(dump->skb, nlh);
+	return -EMSGSIZE;
+}
+
+static inline int ocelot_mact_read(struct ocelot_port *port, int row, int col,
+				   struct ocelot_mact_entry *entry)
+{
+	struct ocelot *ocelot = port->ocelot;
+	char mac[ETH_ALEN];
+	u32 val, dst, macl, mach;
+
+	/* Set row and column to read from */
+	ocelot_field_write(ocelot, ANA_TABLES_MACTINDX_M_INDEX, row);
+	ocelot_field_write(ocelot, ANA_TABLES_MACTINDX_BUCKET, col);
+
+	/* Issue a read command */
+	ocelot_write(ocelot,
+		     ANA_TABLES_MACACCESS_MAC_TABLE_CMD(MACACCESS_CMD_READ),
+		     ANA_TABLES_MACACCESS);
+
+	if (ocelot_mact_wait_for_completion(ocelot))
+		return -ETIMEDOUT;
+
+	/* Read the entry flags */
+	val = ocelot_read(ocelot, ANA_TABLES_MACACCESS);
+	if (!(val & ANA_TABLES_MACACCESS_VALID))
+		return -EINVAL;
+
+	/* If the entry read has another port configured as its destination,
+	 * do not report it.
+	 */
+	dst = (val & ANA_TABLES_MACACCESS_DEST_IDX_M) >> 3;
+	if (dst != port->chip_port)
+		return -EINVAL;
+
+	/* Get the entry's MAC address and VLAN id */
+	macl = ocelot_read(ocelot, ANA_TABLES_MACLDATA);
+	mach = ocelot_read(ocelot, ANA_TABLES_MACHDATA);
+
+	mac[0] = (mach >> 8)  & 0xff;
+	mac[1] = (mach >> 0)  & 0xff;
+	mac[2] = (macl >> 24) & 0xff;
+	mac[3] = (macl >> 16) & 0xff;
+	mac[4] = (macl >> 8)  & 0xff;
+	mac[5] = (macl >> 0)  & 0xff;
+
+	entry->vid = (mach >> 16) & 0xfff;
+	ether_addr_copy(entry->mac, mac);
+
+	return 0;
+}
+
+static int ocelot_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
+			   struct net_device *dev,
+			   struct net_device *filter_dev, int *idx)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	int i, j, ret = 0;
+	struct ocelot_dump_ctx dump = {
+		.dev = dev,
+		.skb = skb,
+		.cb = cb,
+		.idx = *idx,
+	};
+
+	struct ocelot_mact_entry entry;
+
+	/* Loop through all the mac tables entries. There are 1024 rows of 4
+	 * entries.
+	 */
+	for (i = 0; i < 1024; i++) {
+		for (j = 0; j < 4; j++) {
+			ret = ocelot_mact_read(port, i, j, &entry);
+			/* If the entry is invalid (wrong port, invalid...),
+			 * skip it.
+			 */
+			if (ret == -EINVAL)
+				continue;
+			else if (ret)
+				goto end;
+
+			ret = ocelot_fdb_do_dump(&entry, &dump);
+			if (ret)
+				goto end;
+		}
+	}
+
+end:
+	*idx = dump.idx;
+	return ret;
+}
+
+static const struct net_device_ops ocelot_port_netdev_ops = {
+	.ndo_open			= ocelot_port_open,
+	.ndo_stop			= ocelot_port_stop,
+	.ndo_start_xmit			= ocelot_port_xmit,
+	.ndo_set_rx_mode		= ocelot_set_rx_mode,
+	.ndo_get_phys_port_name		= ocelot_port_get_phys_port_name,
+	.ndo_set_mac_address		= ocelot_port_set_mac_address,
+	.ndo_get_stats64		= ocelot_get_stats64,
+	.ndo_fdb_add			= ocelot_fdb_add,
+	.ndo_fdb_del			= ocelot_fdb_del,
+	.ndo_fdb_dump			= ocelot_fdb_dump,
+};
+
+static void ocelot_get_strings(struct net_device *netdev, u32 sset, u8 *data)
+{
+	struct ocelot_port *port = netdev_priv(netdev);
+	struct ocelot *ocelot = port->ocelot;
+	int i;
+
+	if (sset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < ocelot->num_stats; i++)
+		memcpy(data + i * ETH_GSTRING_LEN, ocelot->stats_layout[i].name,
+		       ETH_GSTRING_LEN);
+}
+
+static void ocelot_check_stats(struct work_struct *work)
+{
+	struct delayed_work *del_work = to_delayed_work(work);
+	struct ocelot *ocelot = container_of(del_work, struct ocelot, stats_work);
+	int i, j;
+
+	mutex_lock(&ocelot->stats_lock);
+
+	for (i = 0; i < ocelot->num_phys_ports; i++) {
+		/* Configure the port to read the stats from */
+		ocelot_write(ocelot, SYS_STAT_CFG_STAT_VIEW(i), SYS_STAT_CFG);
+
+		for (j = 0; j < ocelot->num_stats; j++) {
+			u32 val;
+			unsigned int idx = i * ocelot->num_stats + j;
+
+			val = ocelot_read_rix(ocelot, SYS_COUNT_RX_OCTETS,
+					      ocelot->stats_layout[j].offset);
+
+			if (val < (ocelot->stats[idx] & U32_MAX))
+				ocelot->stats[idx] += (u64)1 << 32;
+
+			ocelot->stats[idx] = (ocelot->stats[idx] &
+					      ~(u64)U32_MAX) + val;
+		}
+	}
+
+	cancel_delayed_work(&ocelot->stats_work);
+	queue_delayed_work(ocelot->stats_queue, &ocelot->stats_work,
+			   OCELOT_STATS_CHECK_DELAY);
+
+	mutex_unlock(&ocelot->stats_lock);
+}
+
+static void ocelot_get_ethtool_stats(struct net_device *dev,
+				     struct ethtool_stats *stats, u64 *data)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+	int i;
+
+	/* check and update now */
+	ocelot_check_stats(&ocelot->stats_work.work);
+
+	/* Copy all counters */
+	for (i = 0; i < ocelot->num_stats; i++)
+		*data++ = ocelot->stats[port->chip_port * ocelot->num_stats + i];
+}
+
+static int ocelot_get_sset_count(struct net_device *dev, int sset)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+
+	if (sset != ETH_SS_STATS)
+		return -EOPNOTSUPP;
+	return ocelot->num_stats;
+}
+
+static const struct ethtool_ops ocelot_ethtool_ops = {
+	.get_strings		= ocelot_get_strings,
+	.get_ethtool_stats	= ocelot_get_ethtool_stats,
+	.get_sset_count		= ocelot_get_sset_count,
+};
+
+static int ocelot_port_attr_get(struct net_device *dev,
+				struct switchdev_attr *attr)
+{
+	struct ocelot_port *ocelot_port = netdev_priv(dev);
+	struct ocelot *ocelot = ocelot_port->ocelot;
+
+	switch (attr->id) {
+	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
+		attr->u.ppid.id_len = sizeof(ocelot->base_mac);
+		memcpy(&attr->u.ppid.id, &ocelot->base_mac,
+		       attr->u.ppid.id_len);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int ocelot_port_attr_stp_state_set(struct ocelot_port *ocelot_port,
+					  struct switchdev_trans *trans,
+					  u8 state)
+{
+	struct ocelot *ocelot = ocelot_port->ocelot;
+	u32 port_cfg;
+	int port, i;
+
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	if (!(BIT(ocelot_port->chip_port) & ocelot->bridge_mask))
+		return 0;
+
+	port_cfg = ocelot_read_gix(ocelot, ANA_PORT_PORT_CFG,
+				   ocelot_port->chip_port);
+
+	switch (state) {
+	case BR_STATE_FORWARDING:
+		ocelot->bridge_fwd_mask |= BIT(ocelot_port->chip_port);
+		/* Fallthrough */
+	case BR_STATE_LEARNING:
+		port_cfg |= ANA_PORT_PORT_CFG_LEARN_ENA;
+		break;
+
+	default:
+		port_cfg &= ~ANA_PORT_PORT_CFG_LEARN_ENA;
+		ocelot->bridge_fwd_mask &= ~BIT(ocelot_port->chip_port);
+		break;
+	}
+
+	ocelot_write_gix(ocelot, port_cfg, ANA_PORT_PORT_CFG,
+			 ocelot_port->chip_port);
+
+	/* Apply FWD mask. The loop is needed to add/remove the current port as
+	 * a source for the other ports.
+	 */
+	for (port = 0; port < ocelot->num_phys_ports; port++) {
+		if (ocelot->bridge_fwd_mask & BIT(port)) {
+			unsigned long mask = ocelot->bridge_fwd_mask & ~BIT(port);
+
+			for (i = 0; i < ocelot->num_phys_ports; i++) {
+				unsigned long bond_mask = ocelot->lags[i];
+
+				if (!bond_mask)
+					continue;
+
+				if (bond_mask & BIT(port)) {
+					mask &= ~bond_mask;
+					break;
+				}
+			}
+
+			ocelot_write_rix(ocelot,
+					 BIT(ocelot->num_phys_ports) | mask,
+					 ANA_PGID_PGID, PGID_SRC + port);
+		} else {
+			/* Only the CPU port, this is compatible with link
+			 * aggregation.
+			 */
+			ocelot_write_rix(ocelot,
+					 BIT(ocelot->num_phys_ports),
+					 ANA_PGID_PGID, PGID_SRC + port);
+		}
+	}
+
+	return 0;
+}
+
+static void ocelot_port_attr_ageing_set(struct ocelot_port *ocelot_port,
+					unsigned long ageing_clock_t)
+{
+	struct ocelot *ocelot = ocelot_port->ocelot;
+	unsigned long ageing_jiffies = clock_t_to_jiffies(ageing_clock_t);
+	u32 ageing_time = jiffies_to_msecs(ageing_jiffies) / 1000;
+
+	ocelot_write(ocelot, ANA_AUTOAGE_AGE_PERIOD(ageing_time / 2),
+		     ANA_AUTOAGE);
+}
+
+static void ocelot_port_attr_mc_set(struct ocelot_port *port, bool mc)
+{
+	struct ocelot *ocelot = port->ocelot;
+	u32 val = ocelot_read_gix(ocelot, ANA_PORT_CPU_FWD_CFG,
+				  port->chip_port);
+
+	if (mc)
+		val |= ANA_PORT_CPU_FWD_CFG_CPU_IGMP_REDIR_ENA |
+		       ANA_PORT_CPU_FWD_CFG_CPU_MLD_REDIR_ENA |
+		       ANA_PORT_CPU_FWD_CFG_CPU_IPMC_CTRL_COPY_ENA;
+	else
+		val &= ~(ANA_PORT_CPU_FWD_CFG_CPU_IGMP_REDIR_ENA |
+			 ANA_PORT_CPU_FWD_CFG_CPU_MLD_REDIR_ENA |
+			 ANA_PORT_CPU_FWD_CFG_CPU_IPMC_CTRL_COPY_ENA);
+
+	ocelot_write_gix(ocelot, val, ANA_PORT_CPU_FWD_CFG, port->chip_port);
+}
+
+static int ocelot_port_attr_set(struct net_device *dev,
+				const struct switchdev_attr *attr,
+				struct switchdev_trans *trans)
+{
+	struct ocelot_port *ocelot_port = netdev_priv(dev);
+	int err = 0;
+
+	switch (attr->id) {
+	case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
+		ocelot_port_attr_stp_state_set(ocelot_port, trans,
+					       attr->u.stp_state);
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
+		ocelot_port_attr_ageing_set(ocelot_port, attr->u.ageing_time);
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED:
+		ocelot_port_attr_mc_set(ocelot_port, !attr->u.mc_disabled);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static struct ocelot_multicast *ocelot_multicast_get(struct ocelot *ocelot,
+						     const unsigned char *addr,
+						     u16 vid)
+{
+	struct ocelot_multicast *mc;
+
+	list_for_each_entry(mc, &ocelot->multicast, list) {
+		if (ether_addr_equal(mc->addr, addr) && mc->vid == vid)
+			return mc;
+	}
+
+	return NULL;
+}
+
+static int ocelot_port_obj_add_mdb(struct net_device *dev,
+				   const struct switchdev_obj_port_mdb *mdb,
+				   struct switchdev_trans *trans)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+	struct ocelot_multicast *mc;
+	unsigned char addr[ETH_ALEN];
+	u16 vid = mdb->vid;
+	bool new = false;
+
+	if (!vid)
+		vid = 1;
+
+	mc = ocelot_multicast_get(ocelot, mdb->addr, vid);
+	if (!mc) {
+		mc = devm_kzalloc(ocelot->dev, sizeof(*mc), GFP_KERNEL);
+		if (!mc)
+			return -ENOMEM;
+
+		memcpy(mc->addr, mdb->addr, ETH_ALEN);
+		mc->vid = vid;
+
+		list_add_tail(&mc->list, &ocelot->multicast);
+		new = true;
+	}
+
+	memcpy(addr, mc->addr, ETH_ALEN);
+	addr[0] = 0;
+
+	if (!new) {
+		addr[2] = mc->ports << 0;
+		addr[1] = mc->ports << 8;
+		ocelot_mact_forget(ocelot, addr, vid);
+	}
+
+	mc->ports |= BIT(port->chip_port);
+	addr[2] = mc->ports << 0;
+	addr[1] = mc->ports << 8;
+
+	return ocelot_mact_learn(ocelot, 0, addr, vid, ENTRYTYPE_MACv4);
+}
+
+static int ocelot_port_obj_del_mdb(struct net_device *dev,
+				   const struct switchdev_obj_port_mdb *mdb)
+{
+	struct ocelot_port *port = netdev_priv(dev);
+	struct ocelot *ocelot = port->ocelot;
+	struct ocelot_multicast *mc;
+	unsigned char addr[ETH_ALEN];
+	u16 vid = mdb->vid;
+
+	if (!vid)
+		vid = 1;
+
+	mc = ocelot_multicast_get(ocelot, mdb->addr, vid);
+	if (!mc)
+		return -ENOENT;
+
+	memcpy(addr, mc->addr, ETH_ALEN);
+	addr[2] = mc->ports << 0;
+	addr[1] = mc->ports << 8;
+	addr[0] = 0;
+	ocelot_mact_forget(ocelot, addr, vid);
+
+	mc->ports &= ~BIT(port->chip_port);
+	if (!mc->ports) {
+		list_del(&mc->list);
+		devm_kfree(ocelot->dev, mc);
+		return 0;
+	}
+
+	addr[2] = mc->ports << 0;
+	addr[1] = mc->ports << 8;
+
+	return ocelot_mact_learn(ocelot, 0, addr, vid, ENTRYTYPE_MACv4);
+}
+
+static int ocelot_port_obj_add(struct net_device *dev,
+			       const struct switchdev_obj *obj,
+			       struct switchdev_trans *trans)
+{
+	int ret = 0;
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+		ret = ocelot_port_obj_add_mdb(dev, SWITCHDEV_OBJ_PORT_MDB(obj),
+					      trans);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static int ocelot_port_obj_del(struct net_device *dev,
+			       const struct switchdev_obj *obj)
+{
+	int ret = 0;
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+		ret = ocelot_port_obj_del_mdb(dev, SWITCHDEV_OBJ_PORT_MDB(obj));
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static const struct switchdev_ops ocelot_port_switchdev_ops = {
+	.switchdev_port_attr_get	= ocelot_port_attr_get,
+	.switchdev_port_attr_set	= ocelot_port_attr_set,
+	.switchdev_port_obj_add		= ocelot_port_obj_add,
+	.switchdev_port_obj_del		= ocelot_port_obj_del,
+};
+
+static int ocelot_port_bridge_join(struct ocelot_port *ocelot_port,
+				   struct net_device *bridge)
+{
+	struct ocelot *ocelot = ocelot_port->ocelot;
+
+	if (!ocelot->bridge_mask) {
+		ocelot->hw_bridge_dev = bridge;
+	} else {
+		if (ocelot->hw_bridge_dev != bridge)
+			/* This is adding the port to a second bridge, this is
+			 * unsupported */
+			return -ENODEV;
+	}
+
+	ocelot->bridge_mask |= BIT(ocelot_port->chip_port);
+
+	return 0;
+}
+
+static void ocelot_port_bridge_leave(struct ocelot_port *ocelot_port,
+				     struct net_device *bridge)
+{
+	struct ocelot *ocelot = ocelot_port->ocelot;
+
+	ocelot->bridge_mask &= ~BIT(ocelot_port->chip_port);
+
+	if (!ocelot->bridge_mask)
+		ocelot->hw_bridge_dev = NULL;
+}
+
+/* Checks if the net_device instance given to us originate from our driver. */
+static bool ocelot_netdevice_dev_check(const struct net_device *dev)
+{
+	return dev->netdev_ops == &ocelot_port_netdev_ops;
+}
+
+static int ocelot_netdevice_port_event(struct net_device *dev,
+				       unsigned long event,
+				       struct netdev_notifier_changeupper_info *info)
+{
+	struct ocelot_port *ocelot_port = netdev_priv(dev);
+	int err = 0;
+
+	if (!ocelot_netdevice_dev_check(dev))
+		return 0;
+
+	switch (event) {
+	case NETDEV_CHANGEUPPER:
+		if (netif_is_bridge_master(info->upper_dev)) {
+			if (info->linking)
+				err = ocelot_port_bridge_join(ocelot_port,
+							      info->upper_dev);
+			else
+				ocelot_port_bridge_leave(ocelot_port,
+							 info->upper_dev);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return err;
+}
+
+static int ocelot_netdevice_event(struct notifier_block *unused,
+				  unsigned long event, void *ptr)
+{
+	struct netdev_notifier_changeupper_info *info = ptr;
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	int ret;
+
+	if (netif_is_lag_master(dev)) {
+		struct net_device *slave;
+		struct list_head *iter;
+
+		netdev_for_each_lower_dev(dev, slave, iter) {
+			ret = ocelot_netdevice_port_event(slave, event, info);
+			if (ret)
+				goto notify;
+		}
+	} else {
+		ret = ocelot_netdevice_port_event(dev, event, info);
+	}
+
+notify:
+	return notifier_from_errno(ret);
+}
+
+struct notifier_block ocelot_netdevice_nb __read_mostly = {
+	.notifier_call = ocelot_netdevice_event,
+};
+EXPORT_SYMBOL(ocelot_netdevice_nb);
+
+int ocelot_probe_port(struct ocelot *ocelot, u8 port,
+		      void __iomem *regs,
+		      struct phy_device *phy)
+{
+	struct ocelot_port *ocelot_port;
+	struct net_device *dev;
+	int err;
+
+	dev = alloc_etherdev(sizeof(struct ocelot_port));
+	if (!dev)
+		return -ENOMEM;
+	SET_NETDEV_DEV(dev, ocelot->dev);
+	ocelot_port = netdev_priv(dev);
+	ocelot_port->dev = dev;
+	ocelot_port->ocelot = ocelot;
+	ocelot_port->regs = regs;
+	ocelot_port->chip_port = port;
+	ocelot_port->phy = phy;
+	INIT_LIST_HEAD(&ocelot_port->mc);
+	ocelot->ports[port] = ocelot_port;
+
+	dev->netdev_ops = &ocelot_port_netdev_ops;
+	dev->ethtool_ops = &ocelot_ethtool_ops;
+	dev->switchdev_ops = &ocelot_port_switchdev_ops;
+
+	memcpy(dev->dev_addr, ocelot->base_mac, ETH_ALEN);
+	dev->dev_addr[ETH_ALEN - 1] += port;
+	ocelot_mact_learn(ocelot, PGID_CPU, dev->dev_addr, ocelot_port->pvid,
+			  ENTRYTYPE_LOCKED);
+
+	err = register_netdev(dev);
+	if (err) {
+		dev_err(ocelot->dev, "register_netdev failed\n");
+		goto err_register_netdev;
+	}
+
+	return 0;
+
+err_register_netdev:
+	free_netdev(dev);
+	return err;
+}
+EXPORT_SYMBOL(ocelot_probe_port);
+
+int ocelot_init(struct ocelot *ocelot)
+{
+	u32 port;
+	int i, cpu = ocelot->num_phys_ports;
+	char queue_name[32];
+
+	ocelot->stats = devm_kcalloc(ocelot->dev,
+				     ocelot->num_phys_ports * ocelot->num_stats,
+				     sizeof(u64), GFP_KERNEL);
+	if (!ocelot->stats)
+		return -ENOMEM;
+
+	mutex_init(&ocelot->stats_lock);
+	snprintf(queue_name, sizeof(queue_name), "%s-stats",
+		 dev_name(ocelot->dev));
+	ocelot->stats_queue = create_singlethread_workqueue(queue_name);
+	if (!ocelot->stats_queue)
+		return -ENOMEM;
+
+	ocelot_mact_init(ocelot);
+	ocelot_vlan_init(ocelot);
+
+	for (port = 0; port < ocelot->num_phys_ports; port++) {
+		/* Clear all counters (5 groups) */
+		ocelot_write(ocelot, SYS_STAT_CFG_STAT_VIEW(port) |
+				     SYS_STAT_CFG_STAT_CLEAR_SHOT(0x7f),
+			     SYS_STAT_CFG);
+	}
+
+	/* Only use S-Tag */
+	ocelot_write(ocelot, ETH_P_8021AD, SYS_VLAN_ETYPE_CFG);
+
+	/* Aggregation mode */
+	ocelot_write(ocelot, ANA_AGGR_CFG_AC_SMAC_ENA |
+			     ANA_AGGR_CFG_AC_DMAC_ENA |
+			     ANA_AGGR_CFG_AC_IP4_SIPDIP_ENA |
+			     ANA_AGGR_CFG_AC_IP4_TCPUDP_ENA, ANA_AGGR_CFG);
+
+	/* Set MAC age time to default value. The entry is aged after
+	 * 2*AGE_PERIOD
+	 */
+	ocelot_write(ocelot,
+		     ANA_AUTOAGE_AGE_PERIOD(BR_DEFAULT_AGEING_TIME / 2 / HZ),
+		     ANA_AUTOAGE);
+
+	/* Disable learning for frames discarded by VLAN ingress filtering */
+	regmap_field_write(ocelot->regfields[ANA_ADVLEARN_VLAN_CHK], 1);
+
+	/* Setup frame ageing - fixed value "2 sec" - in 6.5 us units */
+	ocelot_write(ocelot, SYS_FRM_AGING_AGE_TX_ENA |
+		     SYS_FRM_AGING_MAX_AGE(307692), SYS_FRM_AGING);
+
+	/* Setup flooding PGIDs */
+	ocelot_write_rix(ocelot, ANA_FLOODING_FLD_MULTICAST(PGID_MC) |
+			 ANA_FLOODING_FLD_BROADCAST(PGID_MC) |
+			 ANA_FLOODING_FLD_UNICAST(PGID_UC),
+			 ANA_FLOODING, 0);
+	ocelot_write(ocelot, ANA_FLOODING_IPMC_FLD_MC6_DATA(PGID_MCIPV6) |
+		     ANA_FLOODING_IPMC_FLD_MC6_CTRL(PGID_MC) |
+		     ANA_FLOODING_IPMC_FLD_MC4_DATA(PGID_MCIPV4) |
+		     ANA_FLOODING_IPMC_FLD_MC4_CTRL(PGID_MC),
+		     ANA_FLOODING_IPMC);
+
+	for (port = 0; port < ocelot->num_phys_ports; port++) {
+		/* Transmit the frame to the local port. */
+		ocelot_write_rix(ocelot, BIT(port), ANA_PGID_PGID, port);
+		/* Do not forward BPDU frames to the front ports. */
+		ocelot_write_gix(ocelot,
+				 ANA_PORT_CPU_FWD_BPDU_CFG_BPDU_REDIR_ENA(0xffff),
+				 ANA_PORT_CPU_FWD_BPDU_CFG,
+				 port);
+		/* Ensure bridging is disabled */
+		ocelot_write_rix(ocelot, 0, ANA_PGID_PGID, PGID_SRC + port);
+	}
+
+	/* Configure and enable the CPU port. */
+	ocelot_write_rix(ocelot, 0, ANA_PGID_PGID, cpu);
+	ocelot_write_rix(ocelot, BIT(cpu), ANA_PGID_PGID, PGID_CPU);
+	ocelot_write_gix(ocelot, ANA_PORT_PORT_CFG_RECV_ENA |
+			 ANA_PORT_PORT_CFG_PORTID_VAL(cpu),
+			 ANA_PORT_PORT_CFG, cpu);
+
+	/* Allow broadcast MAC frames. */
+	for (i = ocelot->num_phys_ports + 1; i < PGID_CPU; i++) {
+		u32 val = ANA_PGID_PGID_PGID(GENMASK(ocelot->num_phys_ports - 1, 0));
+
+		ocelot_write_rix(ocelot, val, ANA_PGID_PGID, i);
+	}
+	ocelot_write_rix(ocelot,
+			 ANA_PGID_PGID_PGID(GENMASK(ocelot->num_phys_ports, 0)),
+			 ANA_PGID_PGID, PGID_MC);
+	ocelot_write_rix(ocelot, 0, ANA_PGID_PGID, PGID_MCIPV4);
+	ocelot_write_rix(ocelot, 0, ANA_PGID_PGID, PGID_MCIPV6);
+
+	/* CPU port Injection/Extraction configuration */
+	ocelot_write_rix(ocelot, QSYS_SWITCH_PORT_MODE_INGRESS_DROP_MODE |
+			 QSYS_SWITCH_PORT_MODE_SCH_NEXT_CFG(1) |
+			 QSYS_SWITCH_PORT_MODE_PORT_ENA,
+			 QSYS_SWITCH_PORT_MODE, cpu);
+	ocelot_write_rix(ocelot, SYS_PORT_MODE_INCL_XTR_HDR(1) |
+			 SYS_PORT_MODE_INCL_INJ_HDR(1), SYS_PORT_MODE, cpu);
+	/* Allow manual injection via DEVCPU_QS registers, and byte swap these
+	 * registers endianness.
+	 */
+	ocelot_write_rix(ocelot, QS_INJ_GRP_CFG_BYTE_SWAP |
+			 QS_INJ_GRP_CFG_MODE(1), QS_INJ_GRP_CFG, 0);
+	ocelot_write_rix(ocelot, QS_XTR_GRP_CFG_BYTE_SWAP |
+			 QS_XTR_GRP_CFG_MODE(1), QS_XTR_GRP_CFG, 0);
+	ocelot_write(ocelot, ANA_CPUQ_CFG_CPUQ_MIRROR(2) |
+		     ANA_CPUQ_CFG_CPUQ_LRN(2) |
+		     ANA_CPUQ_CFG_CPUQ_MAC_COPY(2) |
+		     ANA_CPUQ_CFG_CPUQ_SRC_COPY(2) |
+		     ANA_CPUQ_CFG_CPUQ_LOCKED_PORTMOVE(2) |
+		     ANA_CPUQ_CFG_CPUQ_ALLBRIDGE(6) |
+		     ANA_CPUQ_CFG_CPUQ_IPMC_CTRL(6) |
+		     ANA_CPUQ_CFG_CPUQ_IGMP(6) |
+		     ANA_CPUQ_CFG_CPUQ_MLD(6), ANA_CPUQ_CFG);
+	for (i = 0; i < 16; i++)
+		ocelot_write_rix(ocelot, ANA_CPUQ_8021_CFG_CPUQ_GARP_VAL(6) |
+				 ANA_CPUQ_8021_CFG_CPUQ_BPDU_VAL(6),
+				 ANA_CPUQ_8021_CFG, i);
+
+	INIT_DELAYED_WORK(&ocelot->stats_work, ocelot_check_stats);
+	queue_delayed_work(ocelot->stats_queue, &ocelot->stats_work,
+			   OCELOT_STATS_CHECK_DELAY);
+	return 0;
+}
+EXPORT_SYMBOL(ocelot_init);
+
+void ocelot_deinit(struct ocelot *ocelot)
+{
+	destroy_workqueue(ocelot->stats_queue);
+	mutex_destroy(&ocelot->stats_lock);
+}
+EXPORT_SYMBOL(ocelot_deinit);
+
+MODULE_LICENSE("Dual MIT/GPL");
diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
new file mode 100644
index 000000000000..097bd12a10d4
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -0,0 +1,572 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+
+#ifndef _MSCC_OCELOT_H_
+#define _MSCC_OCELOT_H_
+
+#include <linux/bitops.h>
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "ocelot_ana.h"
+#include "ocelot_dev.h"
+#include "ocelot_hsio.h"
+#include "ocelot_qsys.h"
+#include "ocelot_rew.h"
+#include "ocelot_sys.h"
+#include "ocelot_qs.h"
+
+#define PGID_AGGR    64
+#define PGID_SRC     80
+
+/* Reserved PGIDs */
+#define PGID_CPU     (PGID_AGGR - 5)
+#define PGID_UC      (PGID_AGGR - 4)
+#define PGID_MC      (PGID_AGGR - 3)
+#define PGID_MCIPV4  (PGID_AGGR - 2)
+#define PGID_MCIPV6  (PGID_AGGR - 1)
+
+#define OCELOT_BUFFER_CELL_SZ 60
+
+#define OCELOT_STATS_CHECK_DELAY (2 * HZ)
+
+#define IFH_LEN 4
+
+struct frame_info {
+	u32 len;
+	u16 port;
+	u16 vid;
+	u8 cpuq;
+	u8 tag_type;
+};
+
+#define IFH_INJ_BYPASS	BIT(31)
+#define IFH_INJ_POP_CNT_DISABLE (3 << 28)
+
+#define IFH_TAG_TYPE_C 0
+#define IFH_TAG_TYPE_S 1
+
+#define OCELOT_SPEED_2500 0
+#define OCELOT_SPEED_1000 1
+#define OCELOT_SPEED_100  2
+#define OCELOT_SPEED_10   3
+
+#define TARGET_OFFSET 24
+#define REG_MASK GENMASK(TARGET_OFFSET - 1, 0)
+#define REG(reg, offset) [reg & REG_MASK] = offset
+
+enum ocelot_target {
+	ANA = 1,
+	QS,
+	QSYS,
+	REW,
+	SYS,
+	HSIO,
+	TARGET_MAX,
+};
+
+enum ocelot_reg {
+	ANA_ADVLEARN = ANA << TARGET_OFFSET,
+	ANA_VLANMASK,
+	ANA_PORT_B_DOMAIN,
+	ANA_ANAGEFIL,
+	ANA_ANEVENTS,
+	ANA_STORMLIMIT_BURST,
+	ANA_STORMLIMIT_CFG,
+	ANA_ISOLATED_PORTS,
+	ANA_COMMUNITY_PORTS,
+	ANA_AUTOAGE,
+	ANA_MACTOPTIONS,
+	ANA_LEARNDISC,
+	ANA_AGENCTRL,
+	ANA_MIRRORPORTS,
+	ANA_EMIRRORPORTS,
+	ANA_FLOODING,
+	ANA_FLOODING_IPMC,
+	ANA_SFLOW_CFG,
+	ANA_PORT_MODE,
+	ANA_CUT_THRU_CFG,
+	ANA_PGID_PGID,
+	ANA_TABLES_ANMOVED,
+	ANA_TABLES_MACHDATA,
+	ANA_TABLES_MACLDATA,
+	ANA_TABLES_STREAMDATA,
+	ANA_TABLES_MACACCESS,
+	ANA_TABLES_MACTINDX,
+	ANA_TABLES_VLANACCESS,
+	ANA_TABLES_VLANTIDX,
+	ANA_TABLES_ISDXACCESS,
+	ANA_TABLES_ISDXTIDX,
+	ANA_TABLES_ENTRYLIM,
+	ANA_TABLES_PTP_ID_HIGH,
+	ANA_TABLES_PTP_ID_LOW,
+	ANA_TABLES_STREAMACCESS,
+	ANA_TABLES_STREAMTIDX,
+	ANA_TABLES_SEQ_HISTORY,
+	ANA_TABLES_SEQ_MASK,
+	ANA_TABLES_SFID_MASK,
+	ANA_TABLES_SFIDACCESS,
+	ANA_TABLES_SFIDTIDX,
+	ANA_MSTI_STATE,
+	ANA_OAM_UPM_LM_CNT,
+	ANA_SG_ACCESS_CTRL,
+	ANA_SG_CONFIG_REG_1,
+	ANA_SG_CONFIG_REG_2,
+	ANA_SG_CONFIG_REG_3,
+	ANA_SG_CONFIG_REG_4,
+	ANA_SG_CONFIG_REG_5,
+	ANA_SG_GCL_GS_CONFIG,
+	ANA_SG_GCL_TI_CONFIG,
+	ANA_SG_STATUS_REG_1,
+	ANA_SG_STATUS_REG_2,
+	ANA_SG_STATUS_REG_3,
+	ANA_PORT_VLAN_CFG,
+	ANA_PORT_DROP_CFG,
+	ANA_PORT_QOS_CFG,
+	ANA_PORT_VCAP_CFG,
+	ANA_PORT_VCAP_S1_KEY_CFG,
+	ANA_PORT_VCAP_S2_CFG,
+	ANA_PORT_PCP_DEI_MAP,
+	ANA_PORT_CPU_FWD_CFG,
+	ANA_PORT_CPU_FWD_BPDU_CFG,
+	ANA_PORT_CPU_FWD_GARP_CFG,
+	ANA_PORT_CPU_FWD_CCM_CFG,
+	ANA_PORT_PORT_CFG,
+	ANA_PORT_POL_CFG,
+	ANA_PORT_PTP_CFG,
+	ANA_PORT_PTP_DLY1_CFG,
+	ANA_PORT_PTP_DLY2_CFG,
+	ANA_PORT_SFID_CFG,
+	ANA_PFC_PFC_CFG,
+	ANA_PFC_PFC_TIMER,
+	ANA_IPT_OAM_MEP_CFG,
+	ANA_IPT_IPT,
+	ANA_PPT_PPT,
+	ANA_FID_MAP_FID_MAP,
+	ANA_AGGR_CFG,
+	ANA_CPUQ_CFG,
+	ANA_CPUQ_CFG2,
+	ANA_CPUQ_8021_CFG,
+	ANA_DSCP_CFG,
+	ANA_DSCP_REWR_CFG,
+	ANA_VCAP_RNG_TYPE_CFG,
+	ANA_VCAP_RNG_VAL_CFG,
+	ANA_VRAP_CFG,
+	ANA_VRAP_HDR_DATA,
+	ANA_VRAP_HDR_MASK,
+	ANA_DISCARD_CFG,
+	ANA_FID_CFG,
+	ANA_POL_PIR_CFG,
+	ANA_POL_CIR_CFG,
+	ANA_POL_MODE_CFG,
+	ANA_POL_PIR_STATE,
+	ANA_POL_CIR_STATE,
+	ANA_POL_STATE,
+	ANA_POL_FLOWC,
+	ANA_POL_HYST,
+	ANA_POL_MISC_CFG,
+	QS_XTR_GRP_CFG = QS << TARGET_OFFSET,
+	QS_XTR_RD,
+	QS_XTR_FRM_PRUNING,
+	QS_XTR_FLUSH,
+	QS_XTR_DATA_PRESENT,
+	QS_XTR_CFG,
+	QS_INJ_GRP_CFG,
+	QS_INJ_WR,
+	QS_INJ_CTRL,
+	QS_INJ_STATUS,
+	QS_INJ_ERR,
+	QS_INH_DBG,
+	QSYS_PORT_MODE = QSYS << TARGET_OFFSET,
+	QSYS_SWITCH_PORT_MODE,
+	QSYS_STAT_CNT_CFG,
+	QSYS_EEE_CFG,
+	QSYS_EEE_THRES,
+	QSYS_IGR_NO_SHARING,
+	QSYS_EGR_NO_SHARING,
+	QSYS_SW_STATUS,
+	QSYS_EXT_CPU_CFG,
+	QSYS_PAD_CFG,
+	QSYS_CPU_GROUP_MAP,
+	QSYS_QMAP,
+	QSYS_ISDX_SGRP,
+	QSYS_TIMED_FRAME_ENTRY,
+	QSYS_TFRM_MISC,
+	QSYS_TFRM_PORT_DLY,
+	QSYS_TFRM_TIMER_CFG_1,
+	QSYS_TFRM_TIMER_CFG_2,
+	QSYS_TFRM_TIMER_CFG_3,
+	QSYS_TFRM_TIMER_CFG_4,
+	QSYS_TFRM_TIMER_CFG_5,
+	QSYS_TFRM_TIMER_CFG_6,
+	QSYS_TFRM_TIMER_CFG_7,
+	QSYS_TFRM_TIMER_CFG_8,
+	QSYS_RED_PROFILE,
+	QSYS_RES_QOS_MODE,
+	QSYS_RES_CFG,
+	QSYS_RES_STAT,
+	QSYS_EGR_DROP_MODE,
+	QSYS_EQ_CTRL,
+	QSYS_EVENTS_CORE,
+	QSYS_QMAXSDU_CFG_0,
+	QSYS_QMAXSDU_CFG_1,
+	QSYS_QMAXSDU_CFG_2,
+	QSYS_QMAXSDU_CFG_3,
+	QSYS_QMAXSDU_CFG_4,
+	QSYS_QMAXSDU_CFG_5,
+	QSYS_QMAXSDU_CFG_6,
+	QSYS_QMAXSDU_CFG_7,
+	QSYS_PREEMPTION_CFG,
+	QSYS_CIR_CFG,
+	QSYS_EIR_CFG,
+	QSYS_SE_CFG,
+	QSYS_SE_DWRR_CFG,
+	QSYS_SE_CONNECT,
+	QSYS_SE_DLB_SENSE,
+	QSYS_CIR_STATE,
+	QSYS_EIR_STATE,
+	QSYS_SE_STATE,
+	QSYS_HSCH_MISC_CFG,
+	QSYS_TAG_CONFIG,
+	QSYS_TAS_PARAM_CFG_CTRL,
+	QSYS_PORT_MAX_SDU,
+	QSYS_PARAM_CFG_REG_1,
+	QSYS_PARAM_CFG_REG_2,
+	QSYS_PARAM_CFG_REG_3,
+	QSYS_PARAM_CFG_REG_4,
+	QSYS_PARAM_CFG_REG_5,
+	QSYS_GCL_CFG_REG_1,
+	QSYS_GCL_CFG_REG_2,
+	QSYS_PARAM_STATUS_REG_1,
+	QSYS_PARAM_STATUS_REG_2,
+	QSYS_PARAM_STATUS_REG_3,
+	QSYS_PARAM_STATUS_REG_4,
+	QSYS_PARAM_STATUS_REG_5,
+	QSYS_PARAM_STATUS_REG_6,
+	QSYS_PARAM_STATUS_REG_7,
+	QSYS_PARAM_STATUS_REG_8,
+	QSYS_PARAM_STATUS_REG_9,
+	QSYS_GCL_STATUS_REG_1,
+	QSYS_GCL_STATUS_REG_2,
+	REW_PORT_VLAN_CFG = REW << TARGET_OFFSET,
+	REW_TAG_CFG,
+	REW_PORT_CFG,
+	REW_DSCP_CFG,
+	REW_PCP_DEI_QOS_MAP_CFG,
+	REW_PTP_CFG,
+	REW_PTP_DLY1_CFG,
+	REW_RED_TAG_CFG,
+	REW_DSCP_REMAP_DP1_CFG,
+	REW_DSCP_REMAP_CFG,
+	REW_STAT_CFG,
+	REW_REW_STICKY,
+	REW_PPT,
+	SYS_COUNT_RX_OCTETS = SYS << TARGET_OFFSET,
+	SYS_COUNT_RX_UNICAST,
+	SYS_COUNT_RX_MULTICAST,
+	SYS_COUNT_RX_BROADCAST,
+	SYS_COUNT_RX_SHORTS,
+	SYS_COUNT_RX_FRAGMENTS,
+	SYS_COUNT_RX_JABBERS,
+	SYS_COUNT_RX_CRC_ALIGN_ERRS,
+	SYS_COUNT_RX_SYM_ERRS,
+	SYS_COUNT_RX_64,
+	SYS_COUNT_RX_65_127,
+	SYS_COUNT_RX_128_255,
+	SYS_COUNT_RX_256_1023,
+	SYS_COUNT_RX_1024_1526,
+	SYS_COUNT_RX_1527_MAX,
+	SYS_COUNT_RX_PAUSE,
+	SYS_COUNT_RX_CONTROL,
+	SYS_COUNT_RX_LONGS,
+	SYS_COUNT_RX_CLASSIFIED_DROPS,
+	SYS_COUNT_TX_OCTETS,
+	SYS_COUNT_TX_UNICAST,
+	SYS_COUNT_TX_MULTICAST,
+	SYS_COUNT_TX_BROADCAST,
+	SYS_COUNT_TX_COLLISION,
+	SYS_COUNT_TX_DROPS,
+	SYS_COUNT_TX_PAUSE,
+	SYS_COUNT_TX_64,
+	SYS_COUNT_TX_65_127,
+	SYS_COUNT_TX_128_511,
+	SYS_COUNT_TX_512_1023,
+	SYS_COUNT_TX_1024_1526,
+	SYS_COUNT_TX_1527_MAX,
+	SYS_COUNT_TX_AGING,
+	SYS_RESET_CFG,
+	SYS_SR_ETYPE_CFG,
+	SYS_VLAN_ETYPE_CFG,
+	SYS_PORT_MODE,
+	SYS_FRONT_PORT_MODE,
+	SYS_FRM_AGING,
+	SYS_STAT_CFG,
+	SYS_SW_STATUS,
+	SYS_MISC_CFG,
+	SYS_REW_MAC_HIGH_CFG,
+	SYS_REW_MAC_LOW_CFG,
+	SYS_TIMESTAMP_OFFSET,
+	SYS_CMID,
+	SYS_PAUSE_CFG,
+	SYS_PAUSE_TOT_CFG,
+	SYS_ATOP,
+	SYS_ATOP_TOT_CFG,
+	SYS_MAC_FC_CFG,
+	SYS_MMGT,
+	SYS_MMGT_FAST,
+	SYS_EVENTS_DIF,
+	SYS_EVENTS_CORE,
+	SYS_CNT,
+	SYS_PTP_STATUS,
+	SYS_PTP_TXSTAMP,
+	SYS_PTP_NXT,
+	SYS_PTP_CFG,
+	SYS_RAM_INIT,
+	SYS_CM_ADDR,
+	SYS_CM_DATA_WR,
+	SYS_CM_DATA_RD,
+	SYS_CM_OP,
+	SYS_CM_DATA,
+	HSIO_PLL5G_CFG0 = HSIO << TARGET_OFFSET,
+	HSIO_PLL5G_CFG1,
+	HSIO_PLL5G_CFG2,
+	HSIO_PLL5G_CFG3,
+	HSIO_PLL5G_CFG4,
+	HSIO_PLL5G_CFG5,
+	HSIO_PLL5G_CFG6,
+	HSIO_PLL5G_STATUS0,
+	HSIO_PLL5G_STATUS1,
+	HSIO_PLL5G_BIST_CFG0,
+	HSIO_PLL5G_BIST_CFG1,
+	HSIO_PLL5G_BIST_CFG2,
+	HSIO_PLL5G_BIST_STAT0,
+	HSIO_PLL5G_BIST_STAT1,
+	HSIO_RCOMP_CFG0,
+	HSIO_RCOMP_STATUS,
+	HSIO_SYNC_ETH_CFG,
+	HSIO_SYNC_ETH_PLL_CFG,
+	HSIO_S1G_DES_CFG,
+	HSIO_S1G_IB_CFG,
+	HSIO_S1G_OB_CFG,
+	HSIO_S1G_SER_CFG,
+	HSIO_S1G_COMMON_CFG,
+	HSIO_S1G_PLL_CFG,
+	HSIO_S1G_PLL_STATUS,
+	HSIO_S1G_DFT_CFG0,
+	HSIO_S1G_DFT_CFG1,
+	HSIO_S1G_DFT_CFG2,
+	HSIO_S1G_TP_CFG,
+	HSIO_S1G_RC_PLL_BIST_CFG,
+	HSIO_S1G_MISC_CFG,
+	HSIO_S1G_DFT_STATUS,
+	HSIO_S1G_MISC_STATUS,
+	HSIO_MCB_S1G_ADDR_CFG,
+	HSIO_S6G_DIG_CFG,
+	HSIO_S6G_DFT_CFG0,
+	HSIO_S6G_DFT_CFG1,
+	HSIO_S6G_DFT_CFG2,
+	HSIO_S6G_TP_CFG0,
+	HSIO_S6G_TP_CFG1,
+	HSIO_S6G_RC_PLL_BIST_CFG,
+	HSIO_S6G_MISC_CFG,
+	HSIO_S6G_OB_ANEG_CFG,
+	HSIO_S6G_DFT_STATUS,
+	HSIO_S6G_ERR_CNT,
+	HSIO_S6G_MISC_STATUS,
+	HSIO_S6G_DES_CFG,
+	HSIO_S6G_IB_CFG,
+	HSIO_S6G_IB_CFG1,
+	HSIO_S6G_IB_CFG2,
+	HSIO_S6G_IB_CFG3,
+	HSIO_S6G_IB_CFG4,
+	HSIO_S6G_IB_CFG5,
+	HSIO_S6G_OB_CFG,
+	HSIO_S6G_OB_CFG1,
+	HSIO_S6G_SER_CFG,
+	HSIO_S6G_COMMON_CFG,
+	HSIO_S6G_PLL_CFG,
+	HSIO_S6G_ACJTAG_CFG,
+	HSIO_S6G_GP_CFG,
+	HSIO_S6G_IB_STATUS0,
+	HSIO_S6G_IB_STATUS1,
+	HSIO_S6G_ACJTAG_STATUS,
+	HSIO_S6G_PLL_STATUS,
+	HSIO_S6G_REVID,
+	HSIO_MCB_S6G_ADDR_CFG,
+	HSIO_HW_CFG,
+	HSIO_HW_QSGMII_CFG,
+	HSIO_HW_QSGMII_STAT,
+	HSIO_CLK_CFG,
+	HSIO_TEMP_SENSOR_CTRL,
+	HSIO_TEMP_SENSOR_CFG,
+	HSIO_TEMP_SENSOR_STAT,
+};
+
+enum ocelot_regfield {
+	ANA_ADVLEARN_VLAN_CHK,
+	ANA_ADVLEARN_LEARN_MIRROR,
+	ANA_ANEVENTS_FLOOD_DISCARD,
+	ANA_ANEVENTS_MSTI_DROP,
+	ANA_ANEVENTS_ACLKILL,
+	ANA_ANEVENTS_ACLUSED,
+	ANA_ANEVENTS_AUTOAGE,
+	ANA_ANEVENTS_VS2TTL1,
+	ANA_ANEVENTS_STORM_DROP,
+	ANA_ANEVENTS_LEARN_DROP,
+	ANA_ANEVENTS_AGED_ENTRY,
+	ANA_ANEVENTS_CPU_LEARN_FAILED,
+	ANA_ANEVENTS_AUTO_LEARN_FAILED,
+	ANA_ANEVENTS_LEARN_REMOVE,
+	ANA_ANEVENTS_AUTO_LEARNED,
+	ANA_ANEVENTS_AUTO_MOVED,
+	ANA_ANEVENTS_DROPPED,
+	ANA_ANEVENTS_CLASSIFIED_DROP,
+	ANA_ANEVENTS_CLASSIFIED_COPY,
+	ANA_ANEVENTS_VLAN_DISCARD,
+	ANA_ANEVENTS_FWD_DISCARD,
+	ANA_ANEVENTS_MULTICAST_FLOOD,
+	ANA_ANEVENTS_UNICAST_FLOOD,
+	ANA_ANEVENTS_DEST_KNOWN,
+	ANA_ANEVENTS_BUCKET3_MATCH,
+	ANA_ANEVENTS_BUCKET2_MATCH,
+	ANA_ANEVENTS_BUCKET1_MATCH,
+	ANA_ANEVENTS_BUCKET0_MATCH,
+	ANA_ANEVENTS_CPU_OPERATION,
+	ANA_ANEVENTS_DMAC_LOOKUP,
+	ANA_ANEVENTS_SMAC_LOOKUP,
+	ANA_ANEVENTS_SEQ_GEN_ERR_0,
+	ANA_ANEVENTS_SEQ_GEN_ERR_1,
+	ANA_TABLES_MACACCESS_B_DOM,
+	ANA_TABLES_MACTINDX_BUCKET,
+	ANA_TABLES_MACTINDX_M_INDEX,
+	QSYS_TIMED_FRAME_ENTRY_TFRM_VLD,
+	QSYS_TIMED_FRAME_ENTRY_TFRM_FP,
+	QSYS_TIMED_FRAME_ENTRY_TFRM_PORTNO,
+	QSYS_TIMED_FRAME_ENTRY_TFRM_TM_SEL,
+	QSYS_TIMED_FRAME_ENTRY_TFRM_TM_T,
+	SYS_RESET_CFG_CORE_ENA,
+	SYS_RESET_CFG_MEM_ENA,
+	SYS_RESET_CFG_MEM_INIT,
+	REGFIELD_MAX
+};
+
+struct ocelot_multicast {
+	struct list_head list;
+	unsigned char addr[ETH_ALEN];
+	u16 vid;
+	u16 ports;
+};
+
+struct ocelot_port;
+
+struct ocelot_stat_layout {
+	u32 offset;
+	char name[ETH_GSTRING_LEN];
+};
+
+struct ocelot {
+	struct device *dev;
+
+	struct regmap *targets[TARGET_MAX];
+	struct regmap_field *regfields[REGFIELD_MAX];
+	const u32 *const *map;
+	const struct ocelot_stat_layout *stats_layout;
+	unsigned int num_stats;
+
+	u8 base_mac[ETH_ALEN];
+
+	struct net_device *hw_bridge_dev;
+	u16 bridge_mask;
+	u16 bridge_fwd_mask;
+
+	struct workqueue_struct *ocelot_owq;
+
+	int shared_queue_sz;
+
+	u8 num_phys_ports;
+	u8 num_cpu_ports;
+	struct ocelot_port **ports;
+
+	u16 lags[16];
+
+	/* Keep track of the vlan port masks */
+	u32 vlan_mask[VLAN_N_VID];
+
+	struct list_head multicast;
+
+	/* Workqueue to check statistics for overflow with its lock */
+	struct mutex stats_lock;
+	u64 *stats;
+	struct delayed_work stats_work;
+	struct workqueue_struct *stats_queue;
+};
+
+struct ocelot_port {
+	struct net_device *dev;
+	struct ocelot *ocelot;
+	struct phy_device *phy;
+	void __iomem *regs;
+	u8 chip_port;
+	/* Keep a track of the mc addresses added to the mac table, so that they
+	 * can be removed when needed.
+	 */
+	struct list_head mc;
+
+	/* Ingress default VLAN (pvid) */
+	u16 pvid;
+
+	/* Egress default VLAN (vid) */
+	u16 vid;
+
+	u8 vlan_aware;
+
+	u64 *stats;
+};
+
+u32 __ocelot_read_ix(struct ocelot *ocelot, u32 reg, u32 offset);
+#define ocelot_read_ix(ocelot, reg, gi, ri) __ocelot_read_ix(ocelot, reg, reg##_GSZ * (gi) + reg##_RSZ * (ri))
+#define ocelot_read_gix(ocelot, reg, gi) __ocelot_read_ix(ocelot, reg, reg##_GSZ * (gi))
+#define ocelot_read_rix(ocelot, reg, ri) __ocelot_read_ix(ocelot, reg, reg##_RSZ * (ri))
+#define ocelot_read(ocelot, reg) __ocelot_read_ix(ocelot, reg, 0)
+
+void __ocelot_write_ix(struct ocelot *ocelot, u32 val, u32 reg, u32 offset);
+#define ocelot_write_ix(ocelot, val, reg, gi, ri) __ocelot_write_ix(ocelot, val, reg, reg##_GSZ * (gi) + reg##_RSZ * (ri))
+#define ocelot_write_gix(ocelot, val, reg, gi) __ocelot_write_ix(ocelot, val, reg, reg##_GSZ * (gi))
+#define ocelot_write_rix(ocelot, val, reg, ri) __ocelot_write_ix(ocelot, val, reg, reg##_RSZ * (ri))
+#define ocelot_write(ocelot, val, reg) __ocelot_write_ix(ocelot, val, reg, 0)
+
+void __ocelot_rmw_ix(struct ocelot *ocelot, u32 val, u32 reg, u32 mask,
+		     u32 offset);
+#define ocelot_rmw_ix(ocelot, val, m, reg, gi, ri) __ocelot_rmw_ix(ocelot, val, m, reg, reg##_GSZ * (gi) + reg##_RSZ * (ri))
+#define ocelot_rmw_gix(ocelot, val, m, reg, gi) __ocelot_rmw_ix(ocelot, val, m, reg, reg##_GSZ * (gi))
+#define ocelot_rmw_rix(ocelot, val, m, reg, ri) __ocelot_rmw_ix(ocelot, val, m, reg, reg##_RSZ * (ri))
+#define ocelot_rmw(ocelot, val, m, reg) __ocelot_rmw_ix(ocelot, val, m, reg, 0)
+
+u32 ocelot_port_readl(struct ocelot_port *port, u32 reg);
+void ocelot_port_writel(struct ocelot_port *port, u32 val, u32 reg);
+
+int ocelot_regfields_init(struct ocelot *ocelot,
+			  const struct reg_field *const regfields);
+struct regmap *ocelot_io_platform_init(struct ocelot *ocelot,
+				       struct platform_device *pdev,
+				       const char *name);
+
+#define ocelot_field_write(ocelot, reg, val) regmap_field_write((ocelot)->regfields[(reg)], (val))
+#define ocelot_field_read(ocelot, reg, val) regmap_field_read((ocelot)->regfields[(reg)], (val))
+
+int ocelot_init(struct ocelot *ocelot);
+void ocelot_deinit(struct ocelot *ocelot);
+int ocelot_chip_init(struct ocelot *ocelot);
+int ocelot_probe_port(struct ocelot *ocelot, u8 port,
+		      void __iomem *regs,
+		      struct phy_device *phy);
+
+extern struct notifier_block ocelot_netdevice_nb;
+
+#endif
diff --git a/drivers/net/ethernet/mscc/ocelot_ana.h b/drivers/net/ethernet/mscc/ocelot_ana.h
new file mode 100644
index 000000000000..841c6ec22b64
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot_ana.h
@@ -0,0 +1,625 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+
+#ifndef _MSCC_OCELOT_ANA_H_
+#define _MSCC_OCELOT_ANA_H_
+
+#define ANA_ANAGEFIL_B_DOM_EN                             BIT(22)
+#define ANA_ANAGEFIL_B_DOM_VAL                            BIT(21)
+#define ANA_ANAGEFIL_AGE_LOCKED                           BIT(20)
+#define ANA_ANAGEFIL_PID_EN                               BIT(19)
+#define ANA_ANAGEFIL_PID_VAL(x)                           (((x) << 14) & GENMASK(18, 14))
+#define ANA_ANAGEFIL_PID_VAL_M                            GENMASK(18, 14)
+#define ANA_ANAGEFIL_PID_VAL_X(x)                         (((x) & GENMASK(18, 14)) >> 14)
+#define ANA_ANAGEFIL_VID_EN                               BIT(13)
+#define ANA_ANAGEFIL_VID_VAL(x)                           ((x) & GENMASK(12, 0))
+#define ANA_ANAGEFIL_VID_VAL_M                            GENMASK(12, 0)
+
+#define ANA_STORMLIMIT_CFG_RSZ                            0x4
+
+#define ANA_STORMLIMIT_CFG_STORM_RATE(x)                  (((x) << 3) & GENMASK(6, 3))
+#define ANA_STORMLIMIT_CFG_STORM_RATE_M                   GENMASK(6, 3)
+#define ANA_STORMLIMIT_CFG_STORM_RATE_X(x)                (((x) & GENMASK(6, 3)) >> 3)
+#define ANA_STORMLIMIT_CFG_STORM_UNIT                     BIT(2)
+#define ANA_STORMLIMIT_CFG_STORM_MODE(x)                  ((x) & GENMASK(1, 0))
+#define ANA_STORMLIMIT_CFG_STORM_MODE_M                   GENMASK(1, 0)
+
+#define ANA_AUTOAGE_AGE_FAST                              BIT(21)
+#define ANA_AUTOAGE_AGE_PERIOD(x)                         (((x) << 1) & GENMASK(20, 1))
+#define ANA_AUTOAGE_AGE_PERIOD_M                          GENMASK(20, 1)
+#define ANA_AUTOAGE_AGE_PERIOD_X(x)                       (((x) & GENMASK(20, 1)) >> 1)
+#define ANA_AUTOAGE_AUTOAGE_LOCKED                        BIT(0)
+
+#define ANA_MACTOPTIONS_REDUCED_TABLE                     BIT(1)
+#define ANA_MACTOPTIONS_SHADOW                            BIT(0)
+
+#define ANA_AGENCTRL_FID_MASK(x)                          (((x) << 12) & GENMASK(23, 12))
+#define ANA_AGENCTRL_FID_MASK_M                           GENMASK(23, 12)
+#define ANA_AGENCTRL_FID_MASK_X(x)                        (((x) & GENMASK(23, 12)) >> 12)
+#define ANA_AGENCTRL_IGNORE_DMAC_FLAGS                    BIT(11)
+#define ANA_AGENCTRL_IGNORE_SMAC_FLAGS                    BIT(10)
+#define ANA_AGENCTRL_FLOOD_SPECIAL                        BIT(9)
+#define ANA_AGENCTRL_FLOOD_IGNORE_VLAN                    BIT(8)
+#define ANA_AGENCTRL_MIRROR_CPU                           BIT(7)
+#define ANA_AGENCTRL_LEARN_CPU_COPY                       BIT(6)
+#define ANA_AGENCTRL_LEARN_FWD_KILL                       BIT(5)
+#define ANA_AGENCTRL_LEARN_IGNORE_VLAN                    BIT(4)
+#define ANA_AGENCTRL_CPU_CPU_KILL_ENA                     BIT(3)
+#define ANA_AGENCTRL_GREEN_COUNT_MODE                     BIT(2)
+#define ANA_AGENCTRL_YELLOW_COUNT_MODE                    BIT(1)
+#define ANA_AGENCTRL_RED_COUNT_MODE                       BIT(0)
+
+#define ANA_FLOODING_RSZ                                  0x4
+
+#define ANA_FLOODING_FLD_UNICAST(x)                       (((x) << 12) & GENMASK(17, 12))
+#define ANA_FLOODING_FLD_UNICAST_M                        GENMASK(17, 12)
+#define ANA_FLOODING_FLD_UNICAST_X(x)                     (((x) & GENMASK(17, 12)) >> 12)
+#define ANA_FLOODING_FLD_BROADCAST(x)                     (((x) << 6) & GENMASK(11, 6))
+#define ANA_FLOODING_FLD_BROADCAST_M                      GENMASK(11, 6)
+#define ANA_FLOODING_FLD_BROADCAST_X(x)                   (((x) & GENMASK(11, 6)) >> 6)
+#define ANA_FLOODING_FLD_MULTICAST(x)                     ((x) & GENMASK(5, 0))
+#define ANA_FLOODING_FLD_MULTICAST_M                      GENMASK(5, 0)
+
+#define ANA_FLOODING_IPMC_FLD_MC4_CTRL(x)                 (((x) << 18) & GENMASK(23, 18))
+#define ANA_FLOODING_IPMC_FLD_MC4_CTRL_M                  GENMASK(23, 18)
+#define ANA_FLOODING_IPMC_FLD_MC4_CTRL_X(x)               (((x) & GENMASK(23, 18)) >> 18)
+#define ANA_FLOODING_IPMC_FLD_MC4_DATA(x)                 (((x) << 12) & GENMASK(17, 12))
+#define ANA_FLOODING_IPMC_FLD_MC4_DATA_M                  GENMASK(17, 12)
+#define ANA_FLOODING_IPMC_FLD_MC4_DATA_X(x)               (((x) & GENMASK(17, 12)) >> 12)
+#define ANA_FLOODING_IPMC_FLD_MC6_CTRL(x)                 (((x) << 6) & GENMASK(11, 6))
+#define ANA_FLOODING_IPMC_FLD_MC6_CTRL_M                  GENMASK(11, 6)
+#define ANA_FLOODING_IPMC_FLD_MC6_CTRL_X(x)               (((x) & GENMASK(11, 6)) >> 6)
+#define ANA_FLOODING_IPMC_FLD_MC6_DATA(x)                 ((x) & GENMASK(5, 0))
+#define ANA_FLOODING_IPMC_FLD_MC6_DATA_M                  GENMASK(5, 0)
+
+#define ANA_SFLOW_CFG_RSZ                                 0x4
+
+#define ANA_SFLOW_CFG_SF_RATE(x)                          (((x) << 2) & GENMASK(13, 2))
+#define ANA_SFLOW_CFG_SF_RATE_M                           GENMASK(13, 2)
+#define ANA_SFLOW_CFG_SF_RATE_X(x)                        (((x) & GENMASK(13, 2)) >> 2)
+#define ANA_SFLOW_CFG_SF_SAMPLE_RX                        BIT(1)
+#define ANA_SFLOW_CFG_SF_SAMPLE_TX                        BIT(0)
+
+#define ANA_PORT_MODE_RSZ                                 0x4
+
+#define ANA_PORT_MODE_REDTAG_PARSE_CFG                    BIT(3)
+#define ANA_PORT_MODE_VLAN_PARSE_CFG(x)                   (((x) << 1) & GENMASK(2, 1))
+#define ANA_PORT_MODE_VLAN_PARSE_CFG_M                    GENMASK(2, 1)
+#define ANA_PORT_MODE_VLAN_PARSE_CFG_X(x)                 (((x) & GENMASK(2, 1)) >> 1)
+#define ANA_PORT_MODE_L3_PARSE_CFG                        BIT(0)
+
+#define ANA_CUT_THRU_CFG_RSZ                              0x4
+
+#define ANA_PGID_PGID_RSZ                                 0x4
+
+#define ANA_PGID_PGID_PGID(x)                             ((x) & GENMASK(11, 0))
+#define ANA_PGID_PGID_PGID_M                              GENMASK(11, 0)
+#define ANA_PGID_PGID_CPUQ_DST_PGID(x)                    (((x) << 27) & GENMASK(29, 27))
+#define ANA_PGID_PGID_CPUQ_DST_PGID_M                     GENMASK(29, 27)
+#define ANA_PGID_PGID_CPUQ_DST_PGID_X(x)                  (((x) & GENMASK(29, 27)) >> 27)
+
+#define ANA_TABLES_MACHDATA_VID(x)                        (((x) << 16) & GENMASK(28, 16))
+#define ANA_TABLES_MACHDATA_VID_M                         GENMASK(28, 16)
+#define ANA_TABLES_MACHDATA_VID_X(x)                      (((x) & GENMASK(28, 16)) >> 16)
+#define ANA_TABLES_MACHDATA_MACHDATA(x)                   ((x) & GENMASK(15, 0))
+#define ANA_TABLES_MACHDATA_MACHDATA_M                    GENMASK(15, 0)
+
+#define ANA_TABLES_STREAMDATA_SSID_VALID                  BIT(16)
+#define ANA_TABLES_STREAMDATA_SSID(x)                     (((x) << 9) & GENMASK(15, 9))
+#define ANA_TABLES_STREAMDATA_SSID_M                      GENMASK(15, 9)
+#define ANA_TABLES_STREAMDATA_SSID_X(x)                   (((x) & GENMASK(15, 9)) >> 9)
+#define ANA_TABLES_STREAMDATA_SFID_VALID                  BIT(8)
+#define ANA_TABLES_STREAMDATA_SFID(x)                     ((x) & GENMASK(7, 0))
+#define ANA_TABLES_STREAMDATA_SFID_M                      GENMASK(7, 0)
+
+#define ANA_TABLES_MACACCESS_MAC_CPU_COPY                 BIT(15)
+#define ANA_TABLES_MACACCESS_SRC_KILL                     BIT(14)
+#define ANA_TABLES_MACACCESS_IGNORE_VLAN                  BIT(13)
+#define ANA_TABLES_MACACCESS_AGED_FLAG                    BIT(12)
+#define ANA_TABLES_MACACCESS_VALID                        BIT(11)
+#define ANA_TABLES_MACACCESS_ENTRYTYPE(x)                 (((x) << 9) & GENMASK(10, 9))
+#define ANA_TABLES_MACACCESS_ENTRYTYPE_M                  GENMASK(10, 9)
+#define ANA_TABLES_MACACCESS_ENTRYTYPE_X(x)               (((x) & GENMASK(10, 9)) >> 9)
+#define ANA_TABLES_MACACCESS_DEST_IDX(x)                  (((x) << 3) & GENMASK(8, 3))
+#define ANA_TABLES_MACACCESS_DEST_IDX_M                   GENMASK(8, 3)
+#define ANA_TABLES_MACACCESS_DEST_IDX_X(x)                (((x) & GENMASK(8, 3)) >> 3)
+#define ANA_TABLES_MACACCESS_MAC_TABLE_CMD(x)             ((x) & GENMASK(2, 0))
+#define ANA_TABLES_MACACCESS_MAC_TABLE_CMD_M              GENMASK(2, 0)
+#define MACACCESS_CMD_IDLE                     0
+#define MACACCESS_CMD_LEARN                    1
+#define MACACCESS_CMD_FORGET                   2
+#define MACACCESS_CMD_AGE                      3
+#define MACACCESS_CMD_GET_NEXT                 4
+#define MACACCESS_CMD_INIT                     5
+#define MACACCESS_CMD_READ                     6
+#define MACACCESS_CMD_WRITE                    7
+
+#define ANA_TABLES_VLANACCESS_VLAN_PORT_MASK(x)           (((x) << 2) & GENMASK(13, 2))
+#define ANA_TABLES_VLANACCESS_VLAN_PORT_MASK_M            GENMASK(13, 2)
+#define ANA_TABLES_VLANACCESS_VLAN_PORT_MASK_X(x)         (((x) & GENMASK(13, 2)) >> 2)
+#define ANA_TABLES_VLANACCESS_VLAN_TBL_CMD(x)             ((x) & GENMASK(1, 0))
+#define ANA_TABLES_VLANACCESS_VLAN_TBL_CMD_M              GENMASK(1, 0)
+#define ANA_TABLES_VLANACCESS_CMD_IDLE                    0x0
+#define ANA_TABLES_VLANACCESS_CMD_WRITE                   0x2
+#define ANA_TABLES_VLANACCESS_CMD_INIT                    0x3
+
+#define ANA_TABLES_VLANTIDX_VLAN_SEC_FWD_ENA              BIT(17)
+#define ANA_TABLES_VLANTIDX_VLAN_FLOOD_DIS                BIT(16)
+#define ANA_TABLES_VLANTIDX_VLAN_PRIV_VLAN                BIT(15)
+#define ANA_TABLES_VLANTIDX_VLAN_LEARN_DISABLED           BIT(14)
+#define ANA_TABLES_VLANTIDX_VLAN_MIRROR                   BIT(13)
+#define ANA_TABLES_VLANTIDX_VLAN_SRC_CHK                  BIT(12)
+#define ANA_TABLES_VLANTIDX_V_INDEX(x)                    ((x) & GENMASK(11, 0))
+#define ANA_TABLES_VLANTIDX_V_INDEX_M                     GENMASK(11, 0)
+
+#define ANA_TABLES_ISDXACCESS_ISDX_PORT_MASK(x)           (((x) << 2) & GENMASK(8, 2))
+#define ANA_TABLES_ISDXACCESS_ISDX_PORT_MASK_M            GENMASK(8, 2)
+#define ANA_TABLES_ISDXACCESS_ISDX_PORT_MASK_X(x)         (((x) & GENMASK(8, 2)) >> 2)
+#define ANA_TABLES_ISDXACCESS_ISDX_TBL_CMD(x)             ((x) & GENMASK(1, 0))
+#define ANA_TABLES_ISDXACCESS_ISDX_TBL_CMD_M              GENMASK(1, 0)
+
+#define ANA_TABLES_ISDXTIDX_ISDX_SDLBI(x)                 (((x) << 21) & GENMASK(28, 21))
+#define ANA_TABLES_ISDXTIDX_ISDX_SDLBI_M                  GENMASK(28, 21)
+#define ANA_TABLES_ISDXTIDX_ISDX_SDLBI_X(x)               (((x) & GENMASK(28, 21)) >> 21)
+#define ANA_TABLES_ISDXTIDX_ISDX_MSTI(x)                  (((x) << 15) & GENMASK(20, 15))
+#define ANA_TABLES_ISDXTIDX_ISDX_MSTI_M                   GENMASK(20, 15)
+#define ANA_TABLES_ISDXTIDX_ISDX_MSTI_X(x)                (((x) & GENMASK(20, 15)) >> 15)
+#define ANA_TABLES_ISDXTIDX_ISDX_ES0_KEY_ENA              BIT(14)
+#define ANA_TABLES_ISDXTIDX_ISDX_FORCE_ENA                BIT(10)
+#define ANA_TABLES_ISDXTIDX_ISDX_INDEX(x)                 ((x) & GENMASK(7, 0))
+#define ANA_TABLES_ISDXTIDX_ISDX_INDEX_M                  GENMASK(7, 0)
+
+#define ANA_TABLES_ENTRYLIM_RSZ                           0x4
+
+#define ANA_TABLES_ENTRYLIM_ENTRYLIM(x)                   (((x) << 14) & GENMASK(17, 14))
+#define ANA_TABLES_ENTRYLIM_ENTRYLIM_M                    GENMASK(17, 14)
+#define ANA_TABLES_ENTRYLIM_ENTRYLIM_X(x)                 (((x) & GENMASK(17, 14)) >> 14)
+#define ANA_TABLES_ENTRYLIM_ENTRYSTAT(x)                  ((x) & GENMASK(13, 0))
+#define ANA_TABLES_ENTRYLIM_ENTRYSTAT_M                   GENMASK(13, 0)
+
+#define ANA_TABLES_STREAMACCESS_GEN_REC_SEQ_NUM(x)        (((x) << 4) & GENMASK(31, 4))
+#define ANA_TABLES_STREAMACCESS_GEN_REC_SEQ_NUM_M         GENMASK(31, 4)
+#define ANA_TABLES_STREAMACCESS_GEN_REC_SEQ_NUM_X(x)      (((x) & GENMASK(31, 4)) >> 4)
+#define ANA_TABLES_STREAMACCESS_SEQ_GEN_REC_ENA           BIT(3)
+#define ANA_TABLES_STREAMACCESS_GEN_REC_TYPE              BIT(2)
+#define ANA_TABLES_STREAMACCESS_STREAM_TBL_CMD(x)         ((x) & GENMASK(1, 0))
+#define ANA_TABLES_STREAMACCESS_STREAM_TBL_CMD_M          GENMASK(1, 0)
+
+#define ANA_TABLES_STREAMTIDX_SEQ_GEN_ERR_STATUS(x)       (((x) << 30) & GENMASK(31, 30))
+#define ANA_TABLES_STREAMTIDX_SEQ_GEN_ERR_STATUS_M        GENMASK(31, 30)
+#define ANA_TABLES_STREAMTIDX_SEQ_GEN_ERR_STATUS_X(x)     (((x) & GENMASK(31, 30)) >> 30)
+#define ANA_TABLES_STREAMTIDX_S_INDEX(x)                  (((x) << 16) & GENMASK(22, 16))
+#define ANA_TABLES_STREAMTIDX_S_INDEX_M                   GENMASK(22, 16)
+#define ANA_TABLES_STREAMTIDX_S_INDEX_X(x)                (((x) & GENMASK(22, 16)) >> 16)
+#define ANA_TABLES_STREAMTIDX_FORCE_SF_BEHAVIOUR          BIT(14)
+#define ANA_TABLES_STREAMTIDX_SEQ_HISTORY_LEN(x)          (((x) << 8) & GENMASK(13, 8))
+#define ANA_TABLES_STREAMTIDX_SEQ_HISTORY_LEN_M           GENMASK(13, 8)
+#define ANA_TABLES_STREAMTIDX_SEQ_HISTORY_LEN_X(x)        (((x) & GENMASK(13, 8)) >> 8)
+#define ANA_TABLES_STREAMTIDX_RESET_ON_ROGUE              BIT(7)
+#define ANA_TABLES_STREAMTIDX_REDTAG_POP                  BIT(6)
+#define ANA_TABLES_STREAMTIDX_STREAM_SPLIT                BIT(5)
+#define ANA_TABLES_STREAMTIDX_SEQ_SPACE_LOG2(x)           ((x) & GENMASK(4, 0))
+#define ANA_TABLES_STREAMTIDX_SEQ_SPACE_LOG2_M            GENMASK(4, 0)
+
+#define ANA_TABLES_SEQ_MASK_SPLIT_MASK(x)                 (((x) << 16) & GENMASK(22, 16))
+#define ANA_TABLES_SEQ_MASK_SPLIT_MASK_M                  GENMASK(22, 16)
+#define ANA_TABLES_SEQ_MASK_SPLIT_MASK_X(x)               (((x) & GENMASK(22, 16)) >> 16)
+#define ANA_TABLES_SEQ_MASK_INPUT_PORT_MASK(x)            ((x) & GENMASK(6, 0))
+#define ANA_TABLES_SEQ_MASK_INPUT_PORT_MASK_M             GENMASK(6, 0)
+
+#define ANA_TABLES_SFID_MASK_IGR_PORT_MASK(x)             (((x) << 1) & GENMASK(7, 1))
+#define ANA_TABLES_SFID_MASK_IGR_PORT_MASK_M              GENMASK(7, 1)
+#define ANA_TABLES_SFID_MASK_IGR_PORT_MASK_X(x)           (((x) & GENMASK(7, 1)) >> 1)
+#define ANA_TABLES_SFID_MASK_IGR_SRCPORT_MATCH_ENA        BIT(0)
+
+#define ANA_TABLES_SFIDACCESS_IGR_PRIO_MATCH_ENA          BIT(22)
+#define ANA_TABLES_SFIDACCESS_IGR_PRIO(x)                 (((x) << 19) & GENMASK(21, 19))
+#define ANA_TABLES_SFIDACCESS_IGR_PRIO_M                  GENMASK(21, 19)
+#define ANA_TABLES_SFIDACCESS_IGR_PRIO_X(x)               (((x) & GENMASK(21, 19)) >> 19)
+#define ANA_TABLES_SFIDACCESS_FORCE_BLOCK                 BIT(18)
+#define ANA_TABLES_SFIDACCESS_MAX_SDU_LEN(x)              (((x) << 2) & GENMASK(17, 2))
+#define ANA_TABLES_SFIDACCESS_MAX_SDU_LEN_M               GENMASK(17, 2)
+#define ANA_TABLES_SFIDACCESS_MAX_SDU_LEN_X(x)            (((x) & GENMASK(17, 2)) >> 2)
+#define ANA_TABLES_SFIDACCESS_SFID_TBL_CMD(x)             ((x) & GENMASK(1, 0))
+#define ANA_TABLES_SFIDACCESS_SFID_TBL_CMD_M              GENMASK(1, 0)
+
+#define ANA_TABLES_SFIDTIDX_SGID_VALID                    BIT(26)
+#define ANA_TABLES_SFIDTIDX_SGID(x)                       (((x) << 18) & GENMASK(25, 18))
+#define ANA_TABLES_SFIDTIDX_SGID_M                        GENMASK(25, 18)
+#define ANA_TABLES_SFIDTIDX_SGID_X(x)                     (((x) & GENMASK(25, 18)) >> 18)
+#define ANA_TABLES_SFIDTIDX_POL_ENA                       BIT(17)
+#define ANA_TABLES_SFIDTIDX_POL_IDX(x)                    (((x) << 8) & GENMASK(16, 8))
+#define ANA_TABLES_SFIDTIDX_POL_IDX_M                     GENMASK(16, 8)
+#define ANA_TABLES_SFIDTIDX_POL_IDX_X(x)                  (((x) & GENMASK(16, 8)) >> 8)
+#define ANA_TABLES_SFIDTIDX_SFID_INDEX(x)                 ((x) & GENMASK(7, 0))
+#define ANA_TABLES_SFIDTIDX_SFID_INDEX_M                  GENMASK(7, 0)
+
+#define ANA_MSTI_STATE_RSZ                                0x4
+
+#define ANA_OAM_UPM_LM_CNT_RSZ                            0x4
+
+#define ANA_SG_ACCESS_CTRL_SGID(x)                        ((x) & GENMASK(7, 0))
+#define ANA_SG_ACCESS_CTRL_SGID_M                         GENMASK(7, 0)
+#define ANA_SG_ACCESS_CTRL_CONFIG_CHANGE                  BIT(28)
+
+#define ANA_SG_CONFIG_REG_3_BASE_TIME_SEC_MSB(x)          ((x) & GENMASK(15, 0))
+#define ANA_SG_CONFIG_REG_3_BASE_TIME_SEC_MSB_M           GENMASK(15, 0)
+#define ANA_SG_CONFIG_REG_3_LIST_LENGTH(x)                (((x) << 16) & GENMASK(18, 16))
+#define ANA_SG_CONFIG_REG_3_LIST_LENGTH_M                 GENMASK(18, 16)
+#define ANA_SG_CONFIG_REG_3_LIST_LENGTH_X(x)              (((x) & GENMASK(18, 16)) >> 16)
+#define ANA_SG_CONFIG_REG_3_GATE_ENABLE                   BIT(20)
+#define ANA_SG_CONFIG_REG_3_INIT_IPS(x)                   (((x) << 24) & GENMASK(27, 24))
+#define ANA_SG_CONFIG_REG_3_INIT_IPS_M                    GENMASK(27, 24)
+#define ANA_SG_CONFIG_REG_3_INIT_IPS_X(x)                 (((x) & GENMASK(27, 24)) >> 24)
+#define ANA_SG_CONFIG_REG_3_INIT_GATE_STATE               BIT(28)
+
+#define ANA_SG_GCL_GS_CONFIG_RSZ                          0x4
+
+#define ANA_SG_GCL_GS_CONFIG_IPS(x)                       ((x) & GENMASK(3, 0))
+#define ANA_SG_GCL_GS_CONFIG_IPS_M                        GENMASK(3, 0)
+#define ANA_SG_GCL_GS_CONFIG_GATE_STATE                   BIT(4)
+
+#define ANA_SG_GCL_TI_CONFIG_RSZ                          0x4
+
+#define ANA_SG_STATUS_REG_3_CFG_CHG_TIME_SEC_MSB(x)       ((x) & GENMASK(15, 0))
+#define ANA_SG_STATUS_REG_3_CFG_CHG_TIME_SEC_MSB_M        GENMASK(15, 0)
+#define ANA_SG_STATUS_REG_3_GATE_STATE                    BIT(16)
+#define ANA_SG_STATUS_REG_3_IPS(x)                        (((x) << 20) & GENMASK(23, 20))
+#define ANA_SG_STATUS_REG_3_IPS_M                         GENMASK(23, 20)
+#define ANA_SG_STATUS_REG_3_IPS_X(x)                      (((x) & GENMASK(23, 20)) >> 20)
+#define ANA_SG_STATUS_REG_3_CONFIG_PENDING                BIT(24)
+
+#define ANA_PORT_VLAN_CFG_GSZ                             0x100
+
+#define ANA_PORT_VLAN_CFG_VLAN_VID_AS_ISDX                BIT(21)
+#define ANA_PORT_VLAN_CFG_VLAN_AWARE_ENA                  BIT(20)
+#define ANA_PORT_VLAN_CFG_VLAN_POP_CNT(x)                 (((x) << 18) & GENMASK(19, 18))
+#define ANA_PORT_VLAN_CFG_VLAN_POP_CNT_M                  GENMASK(19, 18)
+#define ANA_PORT_VLAN_CFG_VLAN_POP_CNT_X(x)               (((x) & GENMASK(19, 18)) >> 18)
+#define ANA_PORT_VLAN_CFG_VLAN_INNER_TAG_ENA              BIT(17)
+#define ANA_PORT_VLAN_CFG_VLAN_TAG_TYPE                   BIT(16)
+#define ANA_PORT_VLAN_CFG_VLAN_DEI                        BIT(15)
+#define ANA_PORT_VLAN_CFG_VLAN_PCP(x)                     (((x) << 12) & GENMASK(14, 12))
+#define ANA_PORT_VLAN_CFG_VLAN_PCP_M                      GENMASK(14, 12)
+#define ANA_PORT_VLAN_CFG_VLAN_PCP_X(x)                   (((x) & GENMASK(14, 12)) >> 12)
+#define ANA_PORT_VLAN_CFG_VLAN_VID(x)                     ((x) & GENMASK(11, 0))
+#define ANA_PORT_VLAN_CFG_VLAN_VID_M                      GENMASK(11, 0)
+
+#define ANA_PORT_DROP_CFG_GSZ                             0x100
+
+#define ANA_PORT_DROP_CFG_DROP_UNTAGGED_ENA               BIT(6)
+#define ANA_PORT_DROP_CFG_DROP_S_TAGGED_ENA               BIT(5)
+#define ANA_PORT_DROP_CFG_DROP_C_TAGGED_ENA               BIT(4)
+#define ANA_PORT_DROP_CFG_DROP_PRIO_S_TAGGED_ENA          BIT(3)
+#define ANA_PORT_DROP_CFG_DROP_PRIO_C_TAGGED_ENA          BIT(2)
+#define ANA_PORT_DROP_CFG_DROP_NULL_MAC_ENA               BIT(1)
+#define ANA_PORT_DROP_CFG_DROP_MC_SMAC_ENA                BIT(0)
+
+#define ANA_PORT_QOS_CFG_GSZ                              0x100
+
+#define ANA_PORT_QOS_CFG_DP_DEFAULT_VAL                   BIT(8)
+#define ANA_PORT_QOS_CFG_QOS_DEFAULT_VAL(x)               (((x) << 5) & GENMASK(7, 5))
+#define ANA_PORT_QOS_CFG_QOS_DEFAULT_VAL_M                GENMASK(7, 5)
+#define ANA_PORT_QOS_CFG_QOS_DEFAULT_VAL_X(x)             (((x) & GENMASK(7, 5)) >> 5)
+#define ANA_PORT_QOS_CFG_QOS_DSCP_ENA                     BIT(4)
+#define ANA_PORT_QOS_CFG_QOS_PCP_ENA                      BIT(3)
+#define ANA_PORT_QOS_CFG_DSCP_TRANSLATE_ENA               BIT(2)
+#define ANA_PORT_QOS_CFG_DSCP_REWR_CFG(x)                 ((x) & GENMASK(1, 0))
+#define ANA_PORT_QOS_CFG_DSCP_REWR_CFG_M                  GENMASK(1, 0)
+
+#define ANA_PORT_VCAP_CFG_GSZ                             0x100
+
+#define ANA_PORT_VCAP_CFG_S1_ENA                          BIT(14)
+#define ANA_PORT_VCAP_CFG_S1_DMAC_DIP_ENA(x)              (((x) << 11) & GENMASK(13, 11))
+#define ANA_PORT_VCAP_CFG_S1_DMAC_DIP_ENA_M               GENMASK(13, 11)
+#define ANA_PORT_VCAP_CFG_S1_DMAC_DIP_ENA_X(x)            (((x) & GENMASK(13, 11)) >> 11)
+#define ANA_PORT_VCAP_CFG_S1_VLAN_INNER_TAG_ENA(x)        (((x) << 8) & GENMASK(10, 8))
+#define ANA_PORT_VCAP_CFG_S1_VLAN_INNER_TAG_ENA_M         GENMASK(10, 8)
+#define ANA_PORT_VCAP_CFG_S1_VLAN_INNER_TAG_ENA_X(x)      (((x) & GENMASK(10, 8)) >> 8)
+#define ANA_PORT_VCAP_CFG_PAG_VAL(x)                      ((x) & GENMASK(7, 0))
+#define ANA_PORT_VCAP_CFG_PAG_VAL_M                       GENMASK(7, 0)
+
+#define ANA_PORT_VCAP_S1_KEY_CFG_GSZ                      0x100
+#define ANA_PORT_VCAP_S1_KEY_CFG_RSZ                      0x4
+
+#define ANA_PORT_VCAP_S1_KEY_CFG_S1_KEY_IP6_CFG(x)        (((x) << 4) & GENMASK(6, 4))
+#define ANA_PORT_VCAP_S1_KEY_CFG_S1_KEY_IP6_CFG_M         GENMASK(6, 4)
+#define ANA_PORT_VCAP_S1_KEY_CFG_S1_KEY_IP6_CFG_X(x)      (((x) & GENMASK(6, 4)) >> 4)
+#define ANA_PORT_VCAP_S1_KEY_CFG_S1_KEY_IP4_CFG(x)        (((x) << 2) & GENMASK(3, 2))
+#define ANA_PORT_VCAP_S1_KEY_CFG_S1_KEY_IP4_CFG_M         GENMASK(3, 2)
+#define ANA_PORT_VCAP_S1_KEY_CFG_S1_KEY_IP4_CFG_X(x)      (((x) & GENMASK(3, 2)) >> 2)
+#define ANA_PORT_VCAP_S1_KEY_CFG_S1_KEY_OTHER_CFG(x)      ((x) & GENMASK(1, 0))
+#define ANA_PORT_VCAP_S1_KEY_CFG_S1_KEY_OTHER_CFG_M       GENMASK(1, 0)
+
+#define ANA_PORT_VCAP_S2_CFG_GSZ                          0x100
+
+#define ANA_PORT_VCAP_S2_CFG_S2_UDP_PAYLOAD_ENA(x)        (((x) << 17) & GENMASK(18, 17))
+#define ANA_PORT_VCAP_S2_CFG_S2_UDP_PAYLOAD_ENA_M         GENMASK(18, 17)
+#define ANA_PORT_VCAP_S2_CFG_S2_UDP_PAYLOAD_ENA_X(x)      (((x) & GENMASK(18, 17)) >> 17)
+#define ANA_PORT_VCAP_S2_CFG_S2_ETYPE_PAYLOAD_ENA(x)      (((x) << 15) & GENMASK(16, 15))
+#define ANA_PORT_VCAP_S2_CFG_S2_ETYPE_PAYLOAD_ENA_M       GENMASK(16, 15)
+#define ANA_PORT_VCAP_S2_CFG_S2_ETYPE_PAYLOAD_ENA_X(x)    (((x) & GENMASK(16, 15)) >> 15)
+#define ANA_PORT_VCAP_S2_CFG_S2_ENA                       BIT(14)
+#define ANA_PORT_VCAP_S2_CFG_S2_SNAP_DIS(x)               (((x) << 12) & GENMASK(13, 12))
+#define ANA_PORT_VCAP_S2_CFG_S2_SNAP_DIS_M                GENMASK(13, 12)
+#define ANA_PORT_VCAP_S2_CFG_S2_SNAP_DIS_X(x)             (((x) & GENMASK(13, 12)) >> 12)
+#define ANA_PORT_VCAP_S2_CFG_S2_ARP_DIS(x)                (((x) << 10) & GENMASK(11, 10))
+#define ANA_PORT_VCAP_S2_CFG_S2_ARP_DIS_M                 GENMASK(11, 10)
+#define ANA_PORT_VCAP_S2_CFG_S2_ARP_DIS_X(x)              (((x) & GENMASK(11, 10)) >> 10)
+#define ANA_PORT_VCAP_S2_CFG_S2_IP_TCPUDP_DIS(x)          (((x) << 8) & GENMASK(9, 8))
+#define ANA_PORT_VCAP_S2_CFG_S2_IP_TCPUDP_DIS_M           GENMASK(9, 8)
+#define ANA_PORT_VCAP_S2_CFG_S2_IP_TCPUDP_DIS_X(x)        (((x) & GENMASK(9, 8)) >> 8)
+#define ANA_PORT_VCAP_S2_CFG_S2_IP_OTHER_DIS(x)           (((x) << 6) & GENMASK(7, 6))
+#define ANA_PORT_VCAP_S2_CFG_S2_IP_OTHER_DIS_M            GENMASK(7, 6)
+#define ANA_PORT_VCAP_S2_CFG_S2_IP_OTHER_DIS_X(x)         (((x) & GENMASK(7, 6)) >> 6)
+#define ANA_PORT_VCAP_S2_CFG_S2_IP6_CFG(x)                (((x) << 2) & GENMASK(5, 2))
+#define ANA_PORT_VCAP_S2_CFG_S2_IP6_CFG_M                 GENMASK(5, 2)
+#define ANA_PORT_VCAP_S2_CFG_S2_IP6_CFG_X(x)              (((x) & GENMASK(5, 2)) >> 2)
+#define ANA_PORT_VCAP_S2_CFG_S2_OAM_DIS(x)                ((x) & GENMASK(1, 0))
+#define ANA_PORT_VCAP_S2_CFG_S2_OAM_DIS_M                 GENMASK(1, 0)
+
+#define ANA_PORT_PCP_DEI_MAP_GSZ                          0x100
+#define ANA_PORT_PCP_DEI_MAP_RSZ                          0x4
+
+#define ANA_PORT_PCP_DEI_MAP_DP_PCP_DEI_VAL               BIT(3)
+#define ANA_PORT_PCP_DEI_MAP_QOS_PCP_DEI_VAL(x)           ((x) & GENMASK(2, 0))
+#define ANA_PORT_PCP_DEI_MAP_QOS_PCP_DEI_VAL_M            GENMASK(2, 0)
+
+#define ANA_PORT_CPU_FWD_CFG_GSZ                          0x100
+
+#define ANA_PORT_CPU_FWD_CFG_CPU_VRAP_REDIR_ENA           BIT(7)
+#define ANA_PORT_CPU_FWD_CFG_CPU_MLD_REDIR_ENA            BIT(6)
+#define ANA_PORT_CPU_FWD_CFG_CPU_IGMP_REDIR_ENA           BIT(5)
+#define ANA_PORT_CPU_FWD_CFG_CPU_IPMC_CTRL_COPY_ENA       BIT(4)
+#define ANA_PORT_CPU_FWD_CFG_CPU_SRC_COPY_ENA             BIT(3)
+#define ANA_PORT_CPU_FWD_CFG_CPU_ALLBRIDGE_DROP_ENA       BIT(2)
+#define ANA_PORT_CPU_FWD_CFG_CPU_ALLBRIDGE_REDIR_ENA      BIT(1)
+#define ANA_PORT_CPU_FWD_CFG_CPU_OAM_ENA                  BIT(0)
+
+#define ANA_PORT_CPU_FWD_BPDU_CFG_GSZ                     0x100
+
+#define ANA_PORT_CPU_FWD_BPDU_CFG_BPDU_DROP_ENA(x)        (((x) << 16) & GENMASK(31, 16))
+#define ANA_PORT_CPU_FWD_BPDU_CFG_BPDU_DROP_ENA_M         GENMASK(31, 16)
+#define ANA_PORT_CPU_FWD_BPDU_CFG_BPDU_DROP_ENA_X(x)      (((x) & GENMASK(31, 16)) >> 16)
+#define ANA_PORT_CPU_FWD_BPDU_CFG_BPDU_REDIR_ENA(x)       ((x) & GENMASK(15, 0))
+#define ANA_PORT_CPU_FWD_BPDU_CFG_BPDU_REDIR_ENA_M        GENMASK(15, 0)
+
+#define ANA_PORT_CPU_FWD_GARP_CFG_GSZ                     0x100
+
+#define ANA_PORT_CPU_FWD_GARP_CFG_GARP_DROP_ENA(x)        (((x) << 16) & GENMASK(31, 16))
+#define ANA_PORT_CPU_FWD_GARP_CFG_GARP_DROP_ENA_M         GENMASK(31, 16)
+#define ANA_PORT_CPU_FWD_GARP_CFG_GARP_DROP_ENA_X(x)      (((x) & GENMASK(31, 16)) >> 16)
+#define ANA_PORT_CPU_FWD_GARP_CFG_GARP_REDIR_ENA(x)       ((x) & GENMASK(15, 0))
+#define ANA_PORT_CPU_FWD_GARP_CFG_GARP_REDIR_ENA_M        GENMASK(15, 0)
+
+#define ANA_PORT_CPU_FWD_CCM_CFG_GSZ                      0x100
+
+#define ANA_PORT_CPU_FWD_CCM_CFG_CCM_DROP_ENA(x)          (((x) << 16) & GENMASK(31, 16))
+#define ANA_PORT_CPU_FWD_CCM_CFG_CCM_DROP_ENA_M           GENMASK(31, 16)
+#define ANA_PORT_CPU_FWD_CCM_CFG_CCM_DROP_ENA_X(x)        (((x) & GENMASK(31, 16)) >> 16)
+#define ANA_PORT_CPU_FWD_CCM_CFG_CCM_REDIR_ENA(x)         ((x) & GENMASK(15, 0))
+#define ANA_PORT_CPU_FWD_CCM_CFG_CCM_REDIR_ENA_M          GENMASK(15, 0)
+
+#define ANA_PORT_PORT_CFG_GSZ                             0x100
+
+#define ANA_PORT_PORT_CFG_SRC_MIRROR_ENA                  BIT(15)
+#define ANA_PORT_PORT_CFG_LIMIT_DROP                      BIT(14)
+#define ANA_PORT_PORT_CFG_LIMIT_CPU                       BIT(13)
+#define ANA_PORT_PORT_CFG_LOCKED_PORTMOVE_DROP            BIT(12)
+#define ANA_PORT_PORT_CFG_LOCKED_PORTMOVE_CPU             BIT(11)
+#define ANA_PORT_PORT_CFG_LEARNDROP                       BIT(10)
+#define ANA_PORT_PORT_CFG_LEARNCPU                        BIT(9)
+#define ANA_PORT_PORT_CFG_LEARNAUTO                       BIT(8)
+#define ANA_PORT_PORT_CFG_LEARN_ENA                       BIT(7)
+#define ANA_PORT_PORT_CFG_RECV_ENA                        BIT(6)
+#define ANA_PORT_PORT_CFG_PORTID_VAL(x)                   (((x) << 2) & GENMASK(5, 2))
+#define ANA_PORT_PORT_CFG_PORTID_VAL_M                    GENMASK(5, 2)
+#define ANA_PORT_PORT_CFG_PORTID_VAL_X(x)                 (((x) & GENMASK(5, 2)) >> 2)
+#define ANA_PORT_PORT_CFG_USE_B_DOM_TBL                   BIT(1)
+#define ANA_PORT_PORT_CFG_LSR_MODE                        BIT(0)
+
+#define ANA_PORT_POL_CFG_GSZ                              0x100
+
+#define ANA_PORT_POL_CFG_POL_CPU_REDIR_8021               BIT(19)
+#define ANA_PORT_POL_CFG_POL_CPU_REDIR_IP                 BIT(18)
+#define ANA_PORT_POL_CFG_PORT_POL_ENA                     BIT(17)
+#define ANA_PORT_POL_CFG_QUEUE_POL_ENA(x)                 (((x) << 9) & GENMASK(16, 9))
+#define ANA_PORT_POL_CFG_QUEUE_POL_ENA_M                  GENMASK(16, 9)
+#define ANA_PORT_POL_CFG_QUEUE_POL_ENA_X(x)               (((x) & GENMASK(16, 9)) >> 9)
+#define ANA_PORT_POL_CFG_POL_ORDER(x)                     ((x) & GENMASK(8, 0))
+#define ANA_PORT_POL_CFG_POL_ORDER_M                      GENMASK(8, 0)
+
+#define ANA_PORT_PTP_CFG_GSZ                              0x100
+
+#define ANA_PORT_PTP_CFG_PTP_BACKPLANE_MODE               BIT(0)
+
+#define ANA_PORT_PTP_DLY1_CFG_GSZ                         0x100
+
+#define ANA_PORT_PTP_DLY2_CFG_GSZ                         0x100
+
+#define ANA_PORT_SFID_CFG_GSZ                             0x100
+#define ANA_PORT_SFID_CFG_RSZ                             0x4
+
+#define ANA_PORT_SFID_CFG_SFID_VALID                      BIT(8)
+#define ANA_PORT_SFID_CFG_SFID(x)                         ((x) & GENMASK(7, 0))
+#define ANA_PORT_SFID_CFG_SFID_M                          GENMASK(7, 0)
+
+#define ANA_PFC_PFC_CFG_GSZ                               0x40
+
+#define ANA_PFC_PFC_CFG_RX_PFC_ENA(x)                     (((x) << 2) & GENMASK(9, 2))
+#define ANA_PFC_PFC_CFG_RX_PFC_ENA_M                      GENMASK(9, 2)
+#define ANA_PFC_PFC_CFG_RX_PFC_ENA_X(x)                   (((x) & GENMASK(9, 2)) >> 2)
+#define ANA_PFC_PFC_CFG_FC_LINK_SPEED(x)                  ((x) & GENMASK(1, 0))
+#define ANA_PFC_PFC_CFG_FC_LINK_SPEED_M                   GENMASK(1, 0)
+
+#define ANA_PFC_PFC_TIMER_GSZ                             0x40
+#define ANA_PFC_PFC_TIMER_RSZ                             0x4
+
+#define ANA_IPT_OAM_MEP_CFG_GSZ                           0x8
+
+#define ANA_IPT_OAM_MEP_CFG_MEP_IDX_P(x)                  (((x) << 6) & GENMASK(10, 6))
+#define ANA_IPT_OAM_MEP_CFG_MEP_IDX_P_M                   GENMASK(10, 6)
+#define ANA_IPT_OAM_MEP_CFG_MEP_IDX_P_X(x)                (((x) & GENMASK(10, 6)) >> 6)
+#define ANA_IPT_OAM_MEP_CFG_MEP_IDX(x)                    (((x) << 1) & GENMASK(5, 1))
+#define ANA_IPT_OAM_MEP_CFG_MEP_IDX_M                     GENMASK(5, 1)
+#define ANA_IPT_OAM_MEP_CFG_MEP_IDX_X(x)                  (((x) & GENMASK(5, 1)) >> 1)
+#define ANA_IPT_OAM_MEP_CFG_MEP_IDX_ENA                   BIT(0)
+
+#define ANA_IPT_IPT_GSZ                                   0x8
+
+#define ANA_IPT_IPT_IPT_CFG(x)                            (((x) << 15) & GENMASK(16, 15))
+#define ANA_IPT_IPT_IPT_CFG_M                             GENMASK(16, 15)
+#define ANA_IPT_IPT_IPT_CFG_X(x)                          (((x) & GENMASK(16, 15)) >> 15)
+#define ANA_IPT_IPT_ISDX_P(x)                             (((x) << 7) & GENMASK(14, 7))
+#define ANA_IPT_IPT_ISDX_P_M                              GENMASK(14, 7)
+#define ANA_IPT_IPT_ISDX_P_X(x)                           (((x) & GENMASK(14, 7)) >> 7)
+#define ANA_IPT_IPT_PPT_IDX(x)                            ((x) & GENMASK(6, 0))
+#define ANA_IPT_IPT_PPT_IDX_M                             GENMASK(6, 0)
+
+#define ANA_PPT_PPT_RSZ                                   0x4
+
+#define ANA_FID_MAP_FID_MAP_RSZ                           0x4
+
+#define ANA_FID_MAP_FID_MAP_FID_C_VAL(x)                  (((x) << 6) & GENMASK(11, 6))
+#define ANA_FID_MAP_FID_MAP_FID_C_VAL_M                   GENMASK(11, 6)
+#define ANA_FID_MAP_FID_MAP_FID_C_VAL_X(x)                (((x) & GENMASK(11, 6)) >> 6)
+#define ANA_FID_MAP_FID_MAP_FID_B_VAL(x)                  ((x) & GENMASK(5, 0))
+#define ANA_FID_MAP_FID_MAP_FID_B_VAL_M                   GENMASK(5, 0)
+
+#define ANA_AGGR_CFG_AC_RND_ENA                           BIT(7)
+#define ANA_AGGR_CFG_AC_DMAC_ENA                          BIT(6)
+#define ANA_AGGR_CFG_AC_SMAC_ENA                          BIT(5)
+#define ANA_AGGR_CFG_AC_IP6_FLOW_LBL_ENA                  BIT(4)
+#define ANA_AGGR_CFG_AC_IP6_TCPUDP_ENA                    BIT(3)
+#define ANA_AGGR_CFG_AC_IP4_SIPDIP_ENA                    BIT(2)
+#define ANA_AGGR_CFG_AC_IP4_TCPUDP_ENA                    BIT(1)
+#define ANA_AGGR_CFG_AC_ISDX_ENA                          BIT(0)
+
+#define ANA_CPUQ_CFG_CPUQ_MLD(x)                          (((x) << 27) & GENMASK(29, 27))
+#define ANA_CPUQ_CFG_CPUQ_MLD_M                           GENMASK(29, 27)
+#define ANA_CPUQ_CFG_CPUQ_MLD_X(x)                        (((x) & GENMASK(29, 27)) >> 27)
+#define ANA_CPUQ_CFG_CPUQ_IGMP(x)                         (((x) << 24) & GENMASK(26, 24))
+#define ANA_CPUQ_CFG_CPUQ_IGMP_M                          GENMASK(26, 24)
+#define ANA_CPUQ_CFG_CPUQ_IGMP_X(x)                       (((x) & GENMASK(26, 24)) >> 24)
+#define ANA_CPUQ_CFG_CPUQ_IPMC_CTRL(x)                    (((x) << 21) & GENMASK(23, 21))
+#define ANA_CPUQ_CFG_CPUQ_IPMC_CTRL_M                     GENMASK(23, 21)
+#define ANA_CPUQ_CFG_CPUQ_IPMC_CTRL_X(x)                  (((x) & GENMASK(23, 21)) >> 21)
+#define ANA_CPUQ_CFG_CPUQ_ALLBRIDGE(x)                    (((x) << 18) & GENMASK(20, 18))
+#define ANA_CPUQ_CFG_CPUQ_ALLBRIDGE_M                     GENMASK(20, 18)
+#define ANA_CPUQ_CFG_CPUQ_ALLBRIDGE_X(x)                  (((x) & GENMASK(20, 18)) >> 18)
+#define ANA_CPUQ_CFG_CPUQ_LOCKED_PORTMOVE(x)              (((x) << 15) & GENMASK(17, 15))
+#define ANA_CPUQ_CFG_CPUQ_LOCKED_PORTMOVE_M               GENMASK(17, 15)
+#define ANA_CPUQ_CFG_CPUQ_LOCKED_PORTMOVE_X(x)            (((x) & GENMASK(17, 15)) >> 15)
+#define ANA_CPUQ_CFG_CPUQ_SRC_COPY(x)                     (((x) << 12) & GENMASK(14, 12))
+#define ANA_CPUQ_CFG_CPUQ_SRC_COPY_M                      GENMASK(14, 12)
+#define ANA_CPUQ_CFG_CPUQ_SRC_COPY_X(x)                   (((x) & GENMASK(14, 12)) >> 12)
+#define ANA_CPUQ_CFG_CPUQ_MAC_COPY(x)                     (((x) << 9) & GENMASK(11, 9))
+#define ANA_CPUQ_CFG_CPUQ_MAC_COPY_M                      GENMASK(11, 9)
+#define ANA_CPUQ_CFG_CPUQ_MAC_COPY_X(x)                   (((x) & GENMASK(11, 9)) >> 9)
+#define ANA_CPUQ_CFG_CPUQ_LRN(x)                          (((x) << 6) & GENMASK(8, 6))
+#define ANA_CPUQ_CFG_CPUQ_LRN_M                           GENMASK(8, 6)
+#define ANA_CPUQ_CFG_CPUQ_LRN_X(x)                        (((x) & GENMASK(8, 6)) >> 6)
+#define ANA_CPUQ_CFG_CPUQ_MIRROR(x)                       (((x) << 3) & GENMASK(5, 3))
+#define ANA_CPUQ_CFG_CPUQ_MIRROR_M                        GENMASK(5, 3)
+#define ANA_CPUQ_CFG_CPUQ_MIRROR_X(x)                     (((x) & GENMASK(5, 3)) >> 3)
+#define ANA_CPUQ_CFG_CPUQ_SFLOW(x)                        ((x) & GENMASK(2, 0))
+#define ANA_CPUQ_CFG_CPUQ_SFLOW_M                         GENMASK(2, 0)
+
+#define ANA_CPUQ_8021_CFG_RSZ                             0x4
+
+#define ANA_CPUQ_8021_CFG_CPUQ_BPDU_VAL(x)                (((x) << 6) & GENMASK(8, 6))
+#define ANA_CPUQ_8021_CFG_CPUQ_BPDU_VAL_M                 GENMASK(8, 6)
+#define ANA_CPUQ_8021_CFG_CPUQ_BPDU_VAL_X(x)              (((x) & GENMASK(8, 6)) >> 6)
+#define ANA_CPUQ_8021_CFG_CPUQ_GARP_VAL(x)                (((x) << 3) & GENMASK(5, 3))
+#define ANA_CPUQ_8021_CFG_CPUQ_GARP_VAL_M                 GENMASK(5, 3)
+#define ANA_CPUQ_8021_CFG_CPUQ_GARP_VAL_X(x)              (((x) & GENMASK(5, 3)) >> 3)
+#define ANA_CPUQ_8021_CFG_CPUQ_CCM_VAL(x)                 ((x) & GENMASK(2, 0))
+#define ANA_CPUQ_8021_CFG_CPUQ_CCM_VAL_M                  GENMASK(2, 0)
+
+#define ANA_DSCP_CFG_RSZ                                  0x4
+
+#define ANA_DSCP_CFG_DP_DSCP_VAL                          BIT(11)
+#define ANA_DSCP_CFG_QOS_DSCP_VAL(x)                      (((x) << 8) & GENMASK(10, 8))
+#define ANA_DSCP_CFG_QOS_DSCP_VAL_M                       GENMASK(10, 8)
+#define ANA_DSCP_CFG_QOS_DSCP_VAL_X(x)                    (((x) & GENMASK(10, 8)) >> 8)
+#define ANA_DSCP_CFG_DSCP_TRANSLATE_VAL(x)                (((x) << 2) & GENMASK(7, 2))
+#define ANA_DSCP_CFG_DSCP_TRANSLATE_VAL_M                 GENMASK(7, 2)
+#define ANA_DSCP_CFG_DSCP_TRANSLATE_VAL_X(x)              (((x) & GENMASK(7, 2)) >> 2)
+#define ANA_DSCP_CFG_DSCP_TRUST_ENA                       BIT(1)
+#define ANA_DSCP_CFG_DSCP_REWR_ENA                        BIT(0)
+
+#define ANA_DSCP_REWR_CFG_RSZ                             0x4
+
+#define ANA_VCAP_RNG_TYPE_CFG_RSZ                         0x4
+
+#define ANA_VCAP_RNG_VAL_CFG_RSZ                          0x4
+
+#define ANA_VCAP_RNG_VAL_CFG_VCAP_RNG_MIN_VAL(x)          (((x) << 16) & GENMASK(31, 16))
+#define ANA_VCAP_RNG_VAL_CFG_VCAP_RNG_MIN_VAL_M           GENMASK(31, 16)
+#define ANA_VCAP_RNG_VAL_CFG_VCAP_RNG_MIN_VAL_X(x)        (((x) & GENMASK(31, 16)) >> 16)
+#define ANA_VCAP_RNG_VAL_CFG_VCAP_RNG_MAX_VAL(x)          ((x) & GENMASK(15, 0))
+#define ANA_VCAP_RNG_VAL_CFG_VCAP_RNG_MAX_VAL_M           GENMASK(15, 0)
+
+#define ANA_VRAP_CFG_VRAP_VLAN_AWARE_ENA                  BIT(12)
+#define ANA_VRAP_CFG_VRAP_VID(x)                          ((x) & GENMASK(11, 0))
+#define ANA_VRAP_CFG_VRAP_VID_M                           GENMASK(11, 0)
+
+#define ANA_DISCARD_CFG_DROP_TAGGING_ISDX0                BIT(3)
+#define ANA_DISCARD_CFG_DROP_CTRLPROT_ISDX0               BIT(2)
+#define ANA_DISCARD_CFG_DROP_TAGGING_S2_ENA               BIT(1)
+#define ANA_DISCARD_CFG_DROP_CTRLPROT_S2_ENA              BIT(0)
+
+#define ANA_FID_CFG_VID_MC_ENA                            BIT(0)
+
+#define ANA_POL_PIR_CFG_GSZ                               0x20
+
+#define ANA_POL_PIR_CFG_PIR_RATE(x)                       (((x) << 6) & GENMASK(20, 6))
+#define ANA_POL_PIR_CFG_PIR_RATE_M                        GENMASK(20, 6)
+#define ANA_POL_PIR_CFG_PIR_RATE_X(x)                     (((x) & GENMASK(20, 6)) >> 6)
+#define ANA_POL_PIR_CFG_PIR_BURST(x)                      ((x) & GENMASK(5, 0))
+#define ANA_POL_PIR_CFG_PIR_BURST_M                       GENMASK(5, 0)
+
+#define ANA_POL_CIR_CFG_GSZ                               0x20
+
+#define ANA_POL_CIR_CFG_CIR_RATE(x)                       (((x) << 6) & GENMASK(20, 6))
+#define ANA_POL_CIR_CFG_CIR_RATE_M                        GENMASK(20, 6)
+#define ANA_POL_CIR_CFG_CIR_RATE_X(x)                     (((x) & GENMASK(20, 6)) >> 6)
+#define ANA_POL_CIR_CFG_CIR_BURST(x)                      ((x) & GENMASK(5, 0))
+#define ANA_POL_CIR_CFG_CIR_BURST_M                       GENMASK(5, 0)
+
+#define ANA_POL_MODE_CFG_GSZ                              0x20
+
+#define ANA_POL_MODE_CFG_IPG_SIZE(x)                      (((x) << 5) & GENMASK(9, 5))
+#define ANA_POL_MODE_CFG_IPG_SIZE_M                       GENMASK(9, 5)
+#define ANA_POL_MODE_CFG_IPG_SIZE_X(x)                    (((x) & GENMASK(9, 5)) >> 5)
+#define ANA_POL_MODE_CFG_FRM_MODE(x)                      (((x) << 3) & GENMASK(4, 3))
+#define ANA_POL_MODE_CFG_FRM_MODE_M                       GENMASK(4, 3)
+#define ANA_POL_MODE_CFG_FRM_MODE_X(x)                    (((x) & GENMASK(4, 3)) >> 3)
+#define ANA_POL_MODE_CFG_DLB_COUPLED                      BIT(2)
+#define ANA_POL_MODE_CFG_CIR_ENA                          BIT(1)
+#define ANA_POL_MODE_CFG_OVERSHOOT_ENA                    BIT(0)
+
+#define ANA_POL_PIR_STATE_GSZ                             0x20
+
+#define ANA_POL_CIR_STATE_GSZ                             0x20
+
+#define ANA_POL_STATE_GSZ                                 0x20
+
+#define ANA_POL_FLOWC_RSZ                                 0x4
+
+#define ANA_POL_FLOWC_POL_FLOWC                           BIT(0)
+
+#define ANA_POL_HYST_POL_FC_HYST(x)                       (((x) << 4) & GENMASK(9, 4))
+#define ANA_POL_HYST_POL_FC_HYST_M                        GENMASK(9, 4)
+#define ANA_POL_HYST_POL_FC_HYST_X(x)                     (((x) & GENMASK(9, 4)) >> 4)
+#define ANA_POL_HYST_POL_STOP_HYST(x)                     ((x) & GENMASK(3, 0))
+#define ANA_POL_HYST_POL_STOP_HYST_M                      GENMASK(3, 0)
+
+#define ANA_POL_MISC_CFG_POL_CLOSE_ALL                    BIT(1)
+#define ANA_POL_MISC_CFG_POL_LEAK_DIS                     BIT(0)
+
+#endif
diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
new file mode 100644
index 000000000000..18df7d934e81
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of_mdio.h>
+#include <linux/of_platform.h>
+#include <linux/skbuff.h>
+
+#include "ocelot.h"
+
+static int ocelot_parse_ifh(u32 *ifh, struct frame_info *info)
+{
+	int i;
+	u8 llen, wlen;
+
+	/* The IFH is in network order, switch to CPU order */
+	for (i = 0; i < IFH_LEN; i++)
+		ifh[i] = ntohl((__force __be32)ifh[i]);
+
+	wlen = (ifh[1] >> 7) & 0xff;
+	llen = (ifh[1] >> 15) & 0x3f;
+	info->len = OCELOT_BUFFER_CELL_SZ * wlen + llen - 80;
+
+	info->port = (ifh[2] & GENMASK(14, 11)) >> 11;
+
+	info->cpuq = (ifh[3] & GENMASK(27, 20)) >> 20;
+	info->tag_type = (ifh[3] & GENMASK(16, 16)) >> 16;
+	info->vid = ifh[3] & GENMASK(11, 0);
+
+	return 0;
+}
+
+static int ocelot_rx_frame_word(struct ocelot *ocelot, u8 grp, bool ifh,
+				u32 *rval)
+{
+	u32 val;
+	u32 bytes_valid;
+
+	val = ocelot_read_rix(ocelot, QS_XTR_RD, grp);
+	if (val == XTR_NOT_READY) {
+		if (ifh)
+			return -EIO;
+
+		do {
+			val = ocelot_read_rix(ocelot, QS_XTR_RD, grp);
+		} while (val == XTR_NOT_READY);
+	}
+
+	switch (val) {
+	case XTR_ABORT:
+		return -EIO;
+	case XTR_EOF_0:
+	case XTR_EOF_1:
+	case XTR_EOF_2:
+	case XTR_EOF_3:
+	case XTR_PRUNED:
+		bytes_valid = XTR_VALID_BYTES(val);
+		val = ocelot_read_rix(ocelot, QS_XTR_RD, grp);
+		if (val == XTR_ESCAPE)
+			*rval = ocelot_read_rix(ocelot, QS_XTR_RD, grp);
+		else
+			*rval = val;
+
+		return bytes_valid;
+	case XTR_ESCAPE:
+		*rval = ocelot_read_rix(ocelot, QS_XTR_RD, grp);
+
+		return 4;
+	default:
+		*rval = val;
+
+		return 4;
+	}
+}
+
+static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
+{
+	struct ocelot *ocelot = arg;
+	int i = 0, grp = 0;
+	int err = 0;
+
+	if (!(ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp)))
+		return IRQ_NONE;
+
+	do {
+		struct sk_buff *skb;
+		struct net_device *dev;
+		u32 *buf;
+		int sz, len;
+		u32 ifh[4];
+		u32 val;
+		struct frame_info info;
+
+		for (i = 0; i < IFH_LEN; i++) {
+			err = ocelot_rx_frame_word(ocelot, grp, true, &ifh[i]);
+			if (err != 4)
+				break;
+		}
+
+		if (err != 4)
+			break;
+
+		ocelot_parse_ifh(ifh, &info);
+
+		dev = ocelot->ports[info.port]->dev;
+
+		skb = netdev_alloc_skb(dev, info.len);
+
+		if (unlikely(!skb)) {
+			netdev_err(dev, "Unable to allocate sk_buff\n");
+			err = -ENOMEM;
+			break;
+		}
+		buf = (u32 *)skb_put(skb, info.len);
+
+		len = 0;
+		do {
+			sz = ocelot_rx_frame_word(ocelot, grp, false, &val);
+			*buf++ = val;
+			len += sz;
+		} while ((sz == 4) && (len < info.len));
+
+		if (sz < 0) {
+			err = sz;
+			break;
+		}
+
+		/* Everything we see on an interface that is in the HW bridge
+		 * has already been forwarded.
+		 */
+		if (ocelot->bridge_mask & BIT(info.port))
+			skb->offload_fwd_mark = 1;
+
+		skb->protocol = eth_type_trans(skb, dev);
+		netif_rx(skb);
+		dev->stats.rx_bytes += len;
+		dev->stats.rx_packets++;
+	} while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp));
+
+	if (err)
+		while (ocelot_read(ocelot, QS_XTR_DATA_PRESENT) & BIT(grp))
+			ocelot_read_rix(ocelot, QS_XTR_RD, grp);
+
+	return IRQ_HANDLED;
+}
+
+static const struct of_device_id mscc_ocelot_match[] = {
+	{ .compatible = "mscc,vsc7514-switch" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mscc_ocelot_match);
+
+static int mscc_ocelot_probe(struct platform_device *pdev)
+{
+	int err, irq;
+	unsigned int i;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *ports, *portnp;
+	struct ocelot *ocelot;
+	u32 val;
+
+	struct {
+		enum ocelot_target id;
+		char *name;
+	} res[] = {
+		{ SYS, "sys" },
+		{ REW, "rew" },
+		{ QSYS, "qsys" },
+		{ ANA, "ana" },
+		{ QS, "qs" },
+		{ HSIO, "hsio" },
+	};
+
+	if (!np && !pdev->dev.platform_data)
+		return -ENODEV;
+
+	ocelot = devm_kzalloc(&pdev->dev, sizeof(*ocelot), GFP_KERNEL);
+	if (!ocelot)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ocelot);
+	ocelot->dev = &pdev->dev;
+
+	for (i = 0; i < ARRAY_SIZE(res); i++) {
+		struct regmap *target;
+
+		target = ocelot_io_platform_init(ocelot, pdev, res[i].name);
+		if (IS_ERR(target))
+			return PTR_ERR(target);
+
+		ocelot->targets[res[i].id] = target;
+	}
+
+	err = ocelot_chip_init(ocelot);
+	if (err)
+		return err;
+
+	irq = platform_get_irq_byname(pdev, "xtr");
+	if (irq < 0)
+		return -ENODEV;
+
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					ocelot_xtr_irq_handler, IRQF_ONESHOT,
+					"frame extraction", ocelot);
+	if (err)
+		return err;
+
+	regmap_field_write(ocelot->regfields[SYS_RESET_CFG_MEM_INIT], 1);
+	regmap_field_write(ocelot->regfields[SYS_RESET_CFG_MEM_ENA], 1);
+
+	do {
+		msleep(1);
+		regmap_field_read(ocelot->regfields[SYS_RESET_CFG_MEM_INIT],
+				  &val);
+	} while (val);
+
+	regmap_field_write(ocelot->regfields[SYS_RESET_CFG_MEM_ENA], 1);
+	regmap_field_write(ocelot->regfields[SYS_RESET_CFG_CORE_ENA], 1);
+
+	ocelot->num_cpu_ports = 1; /* 1 port on the switch, two groups */
+
+	ports = of_get_child_by_name(np, "ethernet-ports");
+	if (!ports) {
+		dev_err(&pdev->dev, "no ethernet-ports child node found\n");
+		return -ENODEV;
+	}
+
+	ocelot->num_phys_ports = of_get_child_count(ports);
+
+	ocelot->ports = devm_kcalloc(&pdev->dev, ocelot->num_phys_ports,
+				     sizeof(struct ocelot_port *), GFP_KERNEL);
+
+	INIT_LIST_HEAD(&ocelot->multicast);
+	ocelot_init(ocelot);
+
+	ocelot_rmw(ocelot, HSIO_HW_CFG_DEV1G_4_MODE |
+		     HSIO_HW_CFG_DEV1G_6_MODE |
+		     HSIO_HW_CFG_DEV1G_9_MODE,
+		     HSIO_HW_CFG_DEV1G_4_MODE |
+		     HSIO_HW_CFG_DEV1G_6_MODE |
+		     HSIO_HW_CFG_DEV1G_9_MODE,
+		     HSIO_HW_CFG);
+
+	for_each_available_child_of_node(ports, portnp) {
+		struct device_node *phy_node;
+		struct phy_device *phy;
+		struct resource *res;
+		void __iomem *regs;
+		char res_name[8];
+		u32 port;
+
+		if (of_property_read_u32(portnp, "reg", &port))
+			continue;
+
+		snprintf(res_name, sizeof(res_name), "port%d", port);
+
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   res_name);
+		regs = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(regs))
+			continue;
+
+		phy_node = of_parse_phandle(portnp, "phy-handle", 0);
+		if (!phy_node)
+			continue;
+
+		phy = of_phy_find_device(phy_node);
+		if (!phy)
+			continue;
+
+		err = ocelot_probe_port(ocelot, port, regs, phy);
+		if (err) {
+			dev_err(&pdev->dev, "failed to probe ports\n");
+			goto err_probe_ports;
+		}
+	}
+
+	register_netdevice_notifier(&ocelot_netdevice_nb);
+
+	dev_info(&pdev->dev, "Ocelot switch probed\n");
+
+	return 0;
+
+err_probe_ports:
+	return err;
+}
+
+static int mscc_ocelot_remove(struct platform_device *pdev)
+{
+	struct ocelot *ocelot = platform_get_drvdata(pdev);
+
+	ocelot_deinit(ocelot);
+	unregister_netdevice_notifier(&ocelot_netdevice_nb);
+
+	return 0;
+}
+
+static struct platform_driver mscc_ocelot_driver = {
+	.probe = mscc_ocelot_probe,
+	.remove = mscc_ocelot_remove,
+	.driver = {
+		.name = "ocelot-switch",
+		.of_match_table = mscc_ocelot_match,
+	},
+};
+
+module_platform_driver(mscc_ocelot_driver);
+
+MODULE_DESCRIPTION("Microsemi Ocelot switch driver");
+MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@bootlin.com>");
+MODULE_LICENSE("Dual MIT/GPL");
diff --git a/drivers/net/ethernet/mscc/ocelot_dev.h b/drivers/net/ethernet/mscc/ocelot_dev.h
new file mode 100644
index 000000000000..0a50d53bbd3f
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot_dev.h
@@ -0,0 +1,275 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+
+#ifndef _MSCC_OCELOT_DEV_H_
+#define _MSCC_OCELOT_DEV_H_
+
+#define DEV_CLOCK_CFG                                     0x0
+
+#define DEV_CLOCK_CFG_MAC_TX_RST                          BIT(7)
+#define DEV_CLOCK_CFG_MAC_RX_RST                          BIT(6)
+#define DEV_CLOCK_CFG_PCS_TX_RST                          BIT(5)
+#define DEV_CLOCK_CFG_PCS_RX_RST                          BIT(4)
+#define DEV_CLOCK_CFG_PORT_RST                            BIT(3)
+#define DEV_CLOCK_CFG_PHY_RST                             BIT(2)
+#define DEV_CLOCK_CFG_LINK_SPEED(x)                       ((x) & GENMASK(1, 0))
+#define DEV_CLOCK_CFG_LINK_SPEED_M                        GENMASK(1, 0)
+
+#define DEV_PORT_MISC                                     0x4
+
+#define DEV_PORT_MISC_FWD_ERROR_ENA                       BIT(4)
+#define DEV_PORT_MISC_FWD_PAUSE_ENA                       BIT(3)
+#define DEV_PORT_MISC_FWD_CTRL_ENA                        BIT(2)
+#define DEV_PORT_MISC_DEV_LOOP_ENA                        BIT(1)
+#define DEV_PORT_MISC_HDX_FAST_DIS                        BIT(0)
+
+#define DEV_EVENTS                                        0x8
+
+#define DEV_EEE_CFG                                       0xc
+
+#define DEV_EEE_CFG_EEE_ENA                               BIT(22)
+#define DEV_EEE_CFG_EEE_TIMER_AGE(x)                      (((x) << 15) & GENMASK(21, 15))
+#define DEV_EEE_CFG_EEE_TIMER_AGE_M                       GENMASK(21, 15)
+#define DEV_EEE_CFG_EEE_TIMER_AGE_X(x)                    (((x) & GENMASK(21, 15)) >> 15)
+#define DEV_EEE_CFG_EEE_TIMER_WAKEUP(x)                   (((x) << 8) & GENMASK(14, 8))
+#define DEV_EEE_CFG_EEE_TIMER_WAKEUP_M                    GENMASK(14, 8)
+#define DEV_EEE_CFG_EEE_TIMER_WAKEUP_X(x)                 (((x) & GENMASK(14, 8)) >> 8)
+#define DEV_EEE_CFG_EEE_TIMER_HOLDOFF(x)                  (((x) << 1) & GENMASK(7, 1))
+#define DEV_EEE_CFG_EEE_TIMER_HOLDOFF_M                   GENMASK(7, 1)
+#define DEV_EEE_CFG_EEE_TIMER_HOLDOFF_X(x)                (((x) & GENMASK(7, 1)) >> 1)
+#define DEV_EEE_CFG_PORT_LPI                              BIT(0)
+
+#define DEV_RX_PATH_DELAY                                 0x10
+
+#define DEV_TX_PATH_DELAY                                 0x14
+
+#define DEV_PTP_PREDICT_CFG                               0x18
+
+#define DEV_PTP_PREDICT_CFG_PTP_PHY_PREDICT_CFG(x)        (((x) << 4) & GENMASK(11, 4))
+#define DEV_PTP_PREDICT_CFG_PTP_PHY_PREDICT_CFG_M         GENMASK(11, 4)
+#define DEV_PTP_PREDICT_CFG_PTP_PHY_PREDICT_CFG_X(x)      (((x) & GENMASK(11, 4)) >> 4)
+#define DEV_PTP_PREDICT_CFG_PTP_PHASE_PREDICT_CFG(x)      ((x) & GENMASK(3, 0))
+#define DEV_PTP_PREDICT_CFG_PTP_PHASE_PREDICT_CFG_M       GENMASK(3, 0)
+
+#define DEV_MAC_ENA_CFG                                   0x1c
+
+#define DEV_MAC_ENA_CFG_RX_ENA                            BIT(4)
+#define DEV_MAC_ENA_CFG_TX_ENA                            BIT(0)
+
+#define DEV_MAC_MODE_CFG                                  0x20
+
+#define DEV_MAC_MODE_CFG_FC_WORD_SYNC_ENA                 BIT(8)
+#define DEV_MAC_MODE_CFG_GIGA_MODE_ENA                    BIT(4)
+#define DEV_MAC_MODE_CFG_FDX_ENA                          BIT(0)
+
+#define DEV_MAC_MAXLEN_CFG                                0x24
+
+#define DEV_MAC_TAGS_CFG                                  0x28
+
+#define DEV_MAC_TAGS_CFG_TAG_ID(x)                        (((x) << 16) & GENMASK(31, 16))
+#define DEV_MAC_TAGS_CFG_TAG_ID_M                         GENMASK(31, 16)
+#define DEV_MAC_TAGS_CFG_TAG_ID_X(x)                      (((x) & GENMASK(31, 16)) >> 16)
+#define DEV_MAC_TAGS_CFG_VLAN_LEN_AWR_ENA                 BIT(2)
+#define DEV_MAC_TAGS_CFG_PB_ENA                           BIT(1)
+#define DEV_MAC_TAGS_CFG_VLAN_AWR_ENA                     BIT(0)
+
+#define DEV_MAC_ADV_CHK_CFG                               0x2c
+
+#define DEV_MAC_ADV_CHK_CFG_LEN_DROP_ENA                  BIT(0)
+
+#define DEV_MAC_IFG_CFG                                   0x30
+
+#define DEV_MAC_IFG_CFG_RESTORE_OLD_IPG_CHECK             BIT(17)
+#define DEV_MAC_IFG_CFG_REDUCED_TX_IFG                    BIT(16)
+#define DEV_MAC_IFG_CFG_TX_IFG(x)                         (((x) << 8) & GENMASK(12, 8))
+#define DEV_MAC_IFG_CFG_TX_IFG_M                          GENMASK(12, 8)
+#define DEV_MAC_IFG_CFG_TX_IFG_X(x)                       (((x) & GENMASK(12, 8)) >> 8)
+#define DEV_MAC_IFG_CFG_RX_IFG2(x)                        (((x) << 4) & GENMASK(7, 4))
+#define DEV_MAC_IFG_CFG_RX_IFG2_M                         GENMASK(7, 4)
+#define DEV_MAC_IFG_CFG_RX_IFG2_X(x)                      (((x) & GENMASK(7, 4)) >> 4)
+#define DEV_MAC_IFG_CFG_RX_IFG1(x)                        ((x) & GENMASK(3, 0))
+#define DEV_MAC_IFG_CFG_RX_IFG1_M                         GENMASK(3, 0)
+
+#define DEV_MAC_HDX_CFG                                   0x34
+
+#define DEV_MAC_HDX_CFG_BYPASS_COL_SYNC                   BIT(26)
+#define DEV_MAC_HDX_CFG_OB_ENA                            BIT(25)
+#define DEV_MAC_HDX_CFG_WEXC_DIS                          BIT(24)
+#define DEV_MAC_HDX_CFG_SEED(x)                           (((x) << 16) & GENMASK(23, 16))
+#define DEV_MAC_HDX_CFG_SEED_M                            GENMASK(23, 16)
+#define DEV_MAC_HDX_CFG_SEED_X(x)                         (((x) & GENMASK(23, 16)) >> 16)
+#define DEV_MAC_HDX_CFG_SEED_LOAD                         BIT(12)
+#define DEV_MAC_HDX_CFG_RETRY_AFTER_EXC_COL_ENA           BIT(8)
+#define DEV_MAC_HDX_CFG_LATE_COL_POS(x)                   ((x) & GENMASK(6, 0))
+#define DEV_MAC_HDX_CFG_LATE_COL_POS_M                    GENMASK(6, 0)
+
+#define DEV_MAC_DBG_CFG                                   0x38
+
+#define DEV_MAC_DBG_CFG_TBI_MODE                          BIT(4)
+#define DEV_MAC_DBG_CFG_IFG_CRS_EXT_CHK_ENA               BIT(0)
+
+#define DEV_MAC_FC_MAC_LOW_CFG                            0x3c
+
+#define DEV_MAC_FC_MAC_HIGH_CFG                           0x40
+
+#define DEV_MAC_STICKY                                    0x44
+
+#define DEV_MAC_STICKY_RX_IPG_SHRINK_STICKY               BIT(9)
+#define DEV_MAC_STICKY_RX_PREAM_SHRINK_STICKY             BIT(8)
+#define DEV_MAC_STICKY_RX_CARRIER_EXT_STICKY              BIT(7)
+#define DEV_MAC_STICKY_RX_CARRIER_EXT_ERR_STICKY          BIT(6)
+#define DEV_MAC_STICKY_RX_JUNK_STICKY                     BIT(5)
+#define DEV_MAC_STICKY_TX_RETRANSMIT_STICKY               BIT(4)
+#define DEV_MAC_STICKY_TX_JAM_STICKY                      BIT(3)
+#define DEV_MAC_STICKY_TX_FIFO_OFLW_STICKY                BIT(2)
+#define DEV_MAC_STICKY_TX_FRM_LEN_OVR_STICKY              BIT(1)
+#define DEV_MAC_STICKY_TX_ABORT_STICKY                    BIT(0)
+
+#define PCS1G_CFG                                         0x48
+
+#define PCS1G_CFG_LINK_STATUS_TYPE                        BIT(4)
+#define PCS1G_CFG_AN_LINK_CTRL_ENA                        BIT(1)
+#define PCS1G_CFG_PCS_ENA                                 BIT(0)
+
+#define PCS1G_MODE_CFG                                    0x4c
+
+#define PCS1G_MODE_CFG_UNIDIR_MODE_ENA                    BIT(4)
+#define PCS1G_MODE_CFG_SGMII_MODE_ENA                     BIT(0)
+
+#define PCS1G_SD_CFG                                      0x50
+
+#define PCS1G_SD_CFG_SD_SEL                               BIT(8)
+#define PCS1G_SD_CFG_SD_POL                               BIT(4)
+#define PCS1G_SD_CFG_SD_ENA                               BIT(0)
+
+#define PCS1G_ANEG_CFG                                    0x54
+
+#define PCS1G_ANEG_CFG_ADV_ABILITY(x)                     (((x) << 16) & GENMASK(31, 16))
+#define PCS1G_ANEG_CFG_ADV_ABILITY_M                      GENMASK(31, 16)
+#define PCS1G_ANEG_CFG_ADV_ABILITY_X(x)                   (((x) & GENMASK(31, 16)) >> 16)
+#define PCS1G_ANEG_CFG_SW_RESOLVE_ENA                     BIT(8)
+#define PCS1G_ANEG_CFG_ANEG_RESTART_ONE_SHOT              BIT(1)
+#define PCS1G_ANEG_CFG_ANEG_ENA                           BIT(0)
+
+#define PCS1G_ANEG_NP_CFG                                 0x58
+
+#define PCS1G_ANEG_NP_CFG_NP_TX(x)                        (((x) << 16) & GENMASK(31, 16))
+#define PCS1G_ANEG_NP_CFG_NP_TX_M                         GENMASK(31, 16)
+#define PCS1G_ANEG_NP_CFG_NP_TX_X(x)                      (((x) & GENMASK(31, 16)) >> 16)
+#define PCS1G_ANEG_NP_CFG_NP_LOADED_ONE_SHOT              BIT(0)
+
+#define PCS1G_LB_CFG                                      0x5c
+
+#define PCS1G_LB_CFG_RA_ENA                               BIT(4)
+#define PCS1G_LB_CFG_GMII_PHY_LB_ENA                      BIT(1)
+#define PCS1G_LB_CFG_TBI_HOST_LB_ENA                      BIT(0)
+
+#define PCS1G_DBG_CFG                                     0x60
+
+#define PCS1G_DBG_CFG_UDLT                                BIT(0)
+
+#define PCS1G_CDET_CFG                                    0x64
+
+#define PCS1G_CDET_CFG_CDET_ENA                           BIT(0)
+
+#define PCS1G_ANEG_STATUS                                 0x68
+
+#define PCS1G_ANEG_STATUS_LP_ADV_ABILITY(x)               (((x) << 16) & GENMASK(31, 16))
+#define PCS1G_ANEG_STATUS_LP_ADV_ABILITY_M                GENMASK(31, 16)
+#define PCS1G_ANEG_STATUS_LP_ADV_ABILITY_X(x)             (((x) & GENMASK(31, 16)) >> 16)
+#define PCS1G_ANEG_STATUS_PR                              BIT(4)
+#define PCS1G_ANEG_STATUS_PAGE_RX_STICKY                  BIT(3)
+#define PCS1G_ANEG_STATUS_ANEG_COMPLETE                   BIT(0)
+
+#define PCS1G_ANEG_NP_STATUS                              0x6c
+
+#define PCS1G_LINK_STATUS                                 0x70
+
+#define PCS1G_LINK_STATUS_DELAY_VAR(x)                    (((x) << 12) & GENMASK(15, 12))
+#define PCS1G_LINK_STATUS_DELAY_VAR_M                     GENMASK(15, 12)
+#define PCS1G_LINK_STATUS_DELAY_VAR_X(x)                  (((x) & GENMASK(15, 12)) >> 12)
+#define PCS1G_LINK_STATUS_SIGNAL_DETECT                   BIT(8)
+#define PCS1G_LINK_STATUS_LINK_STATUS                     BIT(4)
+#define PCS1G_LINK_STATUS_SYNC_STATUS                     BIT(0)
+
+#define PCS1G_LINK_DOWN_CNT                               0x74
+
+#define PCS1G_STICKY                                      0x78
+
+#define PCS1G_STICKY_LINK_DOWN_STICKY                     BIT(4)
+#define PCS1G_STICKY_OUT_OF_SYNC_STICKY                   BIT(0)
+
+#define PCS1G_DEBUG_STATUS                                0x7c
+
+#define PCS1G_LPI_CFG                                     0x80
+
+#define PCS1G_LPI_CFG_QSGMII_MS_SEL                       BIT(20)
+#define PCS1G_LPI_CFG_RX_LPI_OUT_DIS                      BIT(17)
+#define PCS1G_LPI_CFG_LPI_TESTMODE                        BIT(16)
+#define PCS1G_LPI_CFG_LPI_RX_WTIM(x)                      (((x) << 4) & GENMASK(5, 4))
+#define PCS1G_LPI_CFG_LPI_RX_WTIM_M                       GENMASK(5, 4)
+#define PCS1G_LPI_CFG_LPI_RX_WTIM_X(x)                    (((x) & GENMASK(5, 4)) >> 4)
+#define PCS1G_LPI_CFG_TX_ASSERT_LPIDLE                    BIT(0)
+
+#define PCS1G_LPI_WAKE_ERROR_CNT                          0x84
+
+#define PCS1G_LPI_STATUS                                  0x88
+
+#define PCS1G_LPI_STATUS_RX_LPI_FAIL                      BIT(16)
+#define PCS1G_LPI_STATUS_RX_LPI_EVENT_STICKY              BIT(12)
+#define PCS1G_LPI_STATUS_RX_QUIET                         BIT(9)
+#define PCS1G_LPI_STATUS_RX_LPI_MODE                      BIT(8)
+#define PCS1G_LPI_STATUS_TX_LPI_EVENT_STICKY              BIT(4)
+#define PCS1G_LPI_STATUS_TX_QUIET                         BIT(1)
+#define PCS1G_LPI_STATUS_TX_LPI_MODE                      BIT(0)
+
+#define PCS1G_TSTPAT_MODE_CFG                             0x8c
+
+#define PCS1G_TSTPAT_STATUS                               0x90
+
+#define PCS1G_TSTPAT_STATUS_JTP_ERR_CNT(x)                (((x) << 8) & GENMASK(15, 8))
+#define PCS1G_TSTPAT_STATUS_JTP_ERR_CNT_M                 GENMASK(15, 8)
+#define PCS1G_TSTPAT_STATUS_JTP_ERR_CNT_X(x)              (((x) & GENMASK(15, 8)) >> 8)
+#define PCS1G_TSTPAT_STATUS_JTP_ERR                       BIT(4)
+#define PCS1G_TSTPAT_STATUS_JTP_LOCK                      BIT(0)
+
+#define DEV_PCS_FX100_CFG                                 0x94
+
+#define DEV_PCS_FX100_CFG_SD_SEL                          BIT(26)
+#define DEV_PCS_FX100_CFG_SD_POL                          BIT(25)
+#define DEV_PCS_FX100_CFG_SD_ENA                          BIT(24)
+#define DEV_PCS_FX100_CFG_LOOPBACK_ENA                    BIT(20)
+#define DEV_PCS_FX100_CFG_SWAP_MII_ENA                    BIT(16)
+#define DEV_PCS_FX100_CFG_RXBITSEL(x)                     (((x) << 12) & GENMASK(15, 12))
+#define DEV_PCS_FX100_CFG_RXBITSEL_M                      GENMASK(15, 12)
+#define DEV_PCS_FX100_CFG_RXBITSEL_X(x)                   (((x) & GENMASK(15, 12)) >> 12)
+#define DEV_PCS_FX100_CFG_SIGDET_CFG(x)                   (((x) << 9) & GENMASK(10, 9))
+#define DEV_PCS_FX100_CFG_SIGDET_CFG_M                    GENMASK(10, 9)
+#define DEV_PCS_FX100_CFG_SIGDET_CFG_X(x)                 (((x) & GENMASK(10, 9)) >> 9)
+#define DEV_PCS_FX100_CFG_LINKHYST_TM_ENA                 BIT(8)
+#define DEV_PCS_FX100_CFG_LINKHYSTTIMER(x)                (((x) << 4) & GENMASK(7, 4))
+#define DEV_PCS_FX100_CFG_LINKHYSTTIMER_M                 GENMASK(7, 4)
+#define DEV_PCS_FX100_CFG_LINKHYSTTIMER_X(x)              (((x) & GENMASK(7, 4)) >> 4)
+#define DEV_PCS_FX100_CFG_UNIDIR_MODE_ENA                 BIT(3)
+#define DEV_PCS_FX100_CFG_FEFCHK_ENA                      BIT(2)
+#define DEV_PCS_FX100_CFG_FEFGEN_ENA                      BIT(1)
+#define DEV_PCS_FX100_CFG_PCS_ENA                         BIT(0)
+
+#define DEV_PCS_FX100_STATUS                              0x98
+
+#define DEV_PCS_FX100_STATUS_EDGE_POS_PTP(x)              (((x) << 8) & GENMASK(11, 8))
+#define DEV_PCS_FX100_STATUS_EDGE_POS_PTP_M               GENMASK(11, 8)
+#define DEV_PCS_FX100_STATUS_EDGE_POS_PTP_X(x)            (((x) & GENMASK(11, 8)) >> 8)
+#define DEV_PCS_FX100_STATUS_PCS_ERROR_STICKY             BIT(7)
+#define DEV_PCS_FX100_STATUS_FEF_FOUND_STICKY             BIT(6)
+#define DEV_PCS_FX100_STATUS_SSD_ERROR_STICKY             BIT(5)
+#define DEV_PCS_FX100_STATUS_SYNC_LOST_STICKY             BIT(4)
+#define DEV_PCS_FX100_STATUS_FEF_STATUS                   BIT(2)
+#define DEV_PCS_FX100_STATUS_SIGNAL_DETECT                BIT(1)
+#define DEV_PCS_FX100_STATUS_SYNC_STATUS                  BIT(0)
+
+#endif
diff --git a/drivers/net/ethernet/mscc/ocelot_dev_gmii.h b/drivers/net/ethernet/mscc/ocelot_dev_gmii.h
new file mode 100644
index 000000000000..6aa40ea223a2
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot_dev_gmii.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+
+#ifndef _MSCC_OCELOT_DEV_GMII_H_
+#define _MSCC_OCELOT_DEV_GMII_H_
+
+#define DEV_GMII_PORT_MODE_CLOCK_CFG                      0x0
+
+#define DEV_GMII_PORT_MODE_CLOCK_CFG_MAC_TX_RST           BIT(5)
+#define DEV_GMII_PORT_MODE_CLOCK_CFG_MAC_RX_RST           BIT(4)
+#define DEV_GMII_PORT_MODE_CLOCK_CFG_PORT_RST             BIT(3)
+#define DEV_GMII_PORT_MODE_CLOCK_CFG_PHY_RST              BIT(2)
+#define DEV_GMII_PORT_MODE_CLOCK_CFG_LINK_SPEED(x)        ((x) & GENMASK(1, 0))
+#define DEV_GMII_PORT_MODE_CLOCK_CFG_LINK_SPEED_M         GENMASK(1, 0)
+
+#define DEV_GMII_PORT_MODE_PORT_MISC                      0x4
+
+#define DEV_GMII_PORT_MODE_PORT_MISC_MPLS_RX_ENA          BIT(5)
+#define DEV_GMII_PORT_MODE_PORT_MISC_FWD_ERROR_ENA        BIT(4)
+#define DEV_GMII_PORT_MODE_PORT_MISC_FWD_PAUSE_ENA        BIT(3)
+#define DEV_GMII_PORT_MODE_PORT_MISC_FWD_CTRL_ENA         BIT(2)
+#define DEV_GMII_PORT_MODE_PORT_MISC_GMII_LOOP_ENA        BIT(1)
+#define DEV_GMII_PORT_MODE_PORT_MISC_DEV_LOOP_ENA         BIT(0)
+
+#define DEV_GMII_PORT_MODE_EVENTS                         0x8
+
+#define DEV_GMII_PORT_MODE_EEE_CFG                        0xc
+
+#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_ENA                BIT(22)
+#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_AGE(x)       (((x) << 15) & GENMASK(21, 15))
+#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_AGE_M        GENMASK(21, 15)
+#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_AGE_X(x)     (((x) & GENMASK(21, 15)) >> 15)
+#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_WAKEUP(x)    (((x) << 8) & GENMASK(14, 8))
+#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_WAKEUP_M     GENMASK(14, 8)
+#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_WAKEUP_X(x)  (((x) & GENMASK(14, 8)) >> 8)
+#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_HOLDOFF(x)   (((x) << 1) & GENMASK(7, 1))
+#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_HOLDOFF_M    GENMASK(7, 1)
+#define DEV_GMII_PORT_MODE_EEE_CFG_EEE_TIMER_HOLDOFF_X(x) (((x) & GENMASK(7, 1)) >> 1)
+#define DEV_GMII_PORT_MODE_EEE_CFG_PORT_LPI               BIT(0)
+
+#define DEV_GMII_PORT_MODE_RX_PATH_DELAY                  0x10
+
+#define DEV_GMII_PORT_MODE_TX_PATH_DELAY                  0x14
+
+#define DEV_GMII_PORT_MODE_PTP_PREDICT_CFG                0x18
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_ENA_CFG               0x1c
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_ENA_CFG_RX_ENA        BIT(4)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_ENA_CFG_TX_ENA        BIT(0)
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_MODE_CFG              0x20
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_MODE_CFG_FC_WORD_SYNC_ENA BIT(8)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_MODE_CFG_GIGA_MODE_ENA BIT(4)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_MODE_CFG_FDX_ENA      BIT(0)
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_MAXLEN_CFG            0x24
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_TAGS_CFG              0x28
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_TAGS_CFG_TAG_ID(x)    (((x) << 16) & GENMASK(31, 16))
+#define DEV_GMII_MAC_CFG_STATUS_MAC_TAGS_CFG_TAG_ID_M     GENMASK(31, 16)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_TAGS_CFG_TAG_ID_X(x)  (((x) & GENMASK(31, 16)) >> 16)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_TAGS_CFG_PB_ENA       BIT(1)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_TAGS_CFG_VLAN_AWR_ENA BIT(0)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_TAGS_CFG_VLAN_LEN_AWR_ENA BIT(2)
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_ADV_CHK_CFG           0x2c
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_ADV_CHK_CFG_LEN_DROP_ENA BIT(0)
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG               0x30
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_RESTORE_OLD_IPG_CHECK BIT(17)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_REDUCED_TX_IFG BIT(16)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_TX_IFG(x)     (((x) << 8) & GENMASK(12, 8))
+#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_TX_IFG_M      GENMASK(12, 8)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_TX_IFG_X(x)   (((x) & GENMASK(12, 8)) >> 8)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_RX_IFG2(x)    (((x) << 4) & GENMASK(7, 4))
+#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_RX_IFG2_M     GENMASK(7, 4)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_RX_IFG2_X(x)  (((x) & GENMASK(7, 4)) >> 4)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_RX_IFG1(x)    ((x) & GENMASK(3, 0))
+#define DEV_GMII_MAC_CFG_STATUS_MAC_IFG_CFG_RX_IFG1_M     GENMASK(3, 0)
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG               0x34
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_BYPASS_COL_SYNC BIT(26)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_OB_ENA        BIT(25)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_WEXC_DIS      BIT(24)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_SEED(x)       (((x) << 16) & GENMASK(23, 16))
+#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_SEED_M        GENMASK(23, 16)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_SEED_X(x)     (((x) & GENMASK(23, 16)) >> 16)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_SEED_LOAD     BIT(12)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_RETRY_AFTER_EXC_COL_ENA BIT(8)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_LATE_COL_POS(x) ((x) & GENMASK(6, 0))
+#define DEV_GMII_MAC_CFG_STATUS_MAC_HDX_CFG_LATE_COL_POS_M GENMASK(6, 0)
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_DBG_CFG               0x38
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_DBG_CFG_TBI_MODE      BIT(4)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_DBG_CFG_IFG_CRS_EXT_CHK_ENA BIT(0)
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_FC_MAC_LOW_CFG        0x3c
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_FC_MAC_HIGH_CFG       0x40
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY                0x44
+
+#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_RX_IPG_SHRINK_STICKY BIT(9)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_RX_PREAM_SHRINK_STICKY BIT(8)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_RX_CARRIER_EXT_STICKY BIT(7)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_RX_CARRIER_EXT_ERR_STICKY BIT(6)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_RX_JUNK_STICKY BIT(5)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_TX_RETRANSMIT_STICKY BIT(4)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_TX_JAM_STICKY  BIT(3)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_TX_FIFO_OFLW_STICKY BIT(2)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_TX_FRM_LEN_OVR_STICKY BIT(1)
+#define DEV_GMII_MAC_CFG_STATUS_MAC_STICKY_TX_ABORT_STICKY BIT(0)
+
+#define DEV_GMII_MM_CONFIG_ENABLE_CONFIG                  0x48
+
+#define DEV_GMII_MM_CONFIG_ENABLE_CONFIG_MM_RX_ENA        BIT(0)
+#define DEV_GMII_MM_CONFIG_ENABLE_CONFIG_MM_TX_ENA        BIT(4)
+#define DEV_GMII_MM_CONFIG_ENABLE_CONFIG_KEEP_S_AFTER_D   BIT(8)
+
+#define DEV_GMII_MM_CONFIG_VERIF_CONFIG                   0x4c
+
+#define DEV_GMII_MM_CONFIG_VERIF_CONFIG_PRM_VERIFY_DIS    BIT(0)
+#define DEV_GMII_MM_CONFIG_VERIF_CONFIG_PRM_VERIFY_TIME(x) (((x) << 4) & GENMASK(11, 4))
+#define DEV_GMII_MM_CONFIG_VERIF_CONFIG_PRM_VERIFY_TIME_M GENMASK(11, 4)
+#define DEV_GMII_MM_CONFIG_VERIF_CONFIG_PRM_VERIFY_TIME_X(x) (((x) & GENMASK(11, 4)) >> 4)
+#define DEV_GMII_MM_CONFIG_VERIF_CONFIG_VERIF_TIMER_UNITS(x) (((x) << 12) & GENMASK(13, 12))
+#define DEV_GMII_MM_CONFIG_VERIF_CONFIG_VERIF_TIMER_UNITS_M GENMASK(13, 12)
+#define DEV_GMII_MM_CONFIG_VERIF_CONFIG_VERIF_TIMER_UNITS_X(x) (((x) & GENMASK(13, 12)) >> 12)
+
+#define DEV_GMII_MM_STATISTICS_MM_STATUS                  0x50
+
+#define DEV_GMII_MM_STATISTICS_MM_STATUS_PRMPT_ACTIVE_STATUS BIT(0)
+#define DEV_GMII_MM_STATISTICS_MM_STATUS_PRMPT_ACTIVE_STICKY BIT(4)
+#define DEV_GMII_MM_STATISTICS_MM_STATUS_PRMPT_VERIFY_STATE(x) (((x) << 8) & GENMASK(10, 8))
+#define DEV_GMII_MM_STATISTICS_MM_STATUS_PRMPT_VERIFY_STATE_M GENMASK(10, 8)
+#define DEV_GMII_MM_STATISTICS_MM_STATUS_PRMPT_VERIFY_STATE_X(x) (((x) & GENMASK(10, 8)) >> 8)
+#define DEV_GMII_MM_STATISTICS_MM_STATUS_UNEXP_RX_PFRM_STICKY BIT(12)
+#define DEV_GMII_MM_STATISTICS_MM_STATUS_UNEXP_TX_PFRM_STICKY BIT(16)
+#define DEV_GMII_MM_STATISTICS_MM_STATUS_MM_RX_FRAME_STATUS BIT(20)
+#define DEV_GMII_MM_STATISTICS_MM_STATUS_MM_TX_FRAME_STATUS BIT(24)
+#define DEV_GMII_MM_STATISTICS_MM_STATUS_MM_TX_PRMPT_STATUS BIT(28)
+
+#endif
diff --git a/drivers/net/ethernet/mscc/ocelot_hsio.h b/drivers/net/ethernet/mscc/ocelot_hsio.h
new file mode 100644
index 000000000000..d93ddec3931b
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot_hsio.h
@@ -0,0 +1,785 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+
+#ifndef _MSCC_OCELOT_HSIO_H_
+#define _MSCC_OCELOT_HSIO_H_
+
+#define HSIO_PLL5G_CFG0_ENA_ROT                           BIT(31)
+#define HSIO_PLL5G_CFG0_ENA_LANE                          BIT(30)
+#define HSIO_PLL5G_CFG0_ENA_CLKTREE                       BIT(29)
+#define HSIO_PLL5G_CFG0_DIV4                              BIT(28)
+#define HSIO_PLL5G_CFG0_ENA_LOCK_FINE                     BIT(27)
+#define HSIO_PLL5G_CFG0_SELBGV820(x)                      (((x) << 23) & GENMASK(26, 23))
+#define HSIO_PLL5G_CFG0_SELBGV820_M                       GENMASK(26, 23)
+#define HSIO_PLL5G_CFG0_SELBGV820_X(x)                    (((x) & GENMASK(26, 23)) >> 23)
+#define HSIO_PLL5G_CFG0_LOOP_BW_RES(x)                    (((x) << 18) & GENMASK(22, 18))
+#define HSIO_PLL5G_CFG0_LOOP_BW_RES_M                     GENMASK(22, 18)
+#define HSIO_PLL5G_CFG0_LOOP_BW_RES_X(x)                  (((x) & GENMASK(22, 18)) >> 18)
+#define HSIO_PLL5G_CFG0_SELCPI(x)                         (((x) << 16) & GENMASK(17, 16))
+#define HSIO_PLL5G_CFG0_SELCPI_M                          GENMASK(17, 16)
+#define HSIO_PLL5G_CFG0_SELCPI_X(x)                       (((x) & GENMASK(17, 16)) >> 16)
+#define HSIO_PLL5G_CFG0_ENA_VCO_CONTRH                    BIT(15)
+#define HSIO_PLL5G_CFG0_ENA_CP1                           BIT(14)
+#define HSIO_PLL5G_CFG0_ENA_VCO_BUF                       BIT(13)
+#define HSIO_PLL5G_CFG0_ENA_BIAS                          BIT(12)
+#define HSIO_PLL5G_CFG0_CPU_CLK_DIV(x)                    (((x) << 6) & GENMASK(11, 6))
+#define HSIO_PLL5G_CFG0_CPU_CLK_DIV_M                     GENMASK(11, 6)
+#define HSIO_PLL5G_CFG0_CPU_CLK_DIV_X(x)                  (((x) & GENMASK(11, 6)) >> 6)
+#define HSIO_PLL5G_CFG0_CORE_CLK_DIV(x)                   ((x) & GENMASK(5, 0))
+#define HSIO_PLL5G_CFG0_CORE_CLK_DIV_M                    GENMASK(5, 0)
+
+#define HSIO_PLL5G_CFG1_ENA_DIRECT                        BIT(18)
+#define HSIO_PLL5G_CFG1_ROT_SPEED                         BIT(17)
+#define HSIO_PLL5G_CFG1_ROT_DIR                           BIT(16)
+#define HSIO_PLL5G_CFG1_READBACK_DATA_SEL                 BIT(15)
+#define HSIO_PLL5G_CFG1_RC_ENABLE                         BIT(14)
+#define HSIO_PLL5G_CFG1_RC_CTRL_DATA(x)                   (((x) << 6) & GENMASK(13, 6))
+#define HSIO_PLL5G_CFG1_RC_CTRL_DATA_M                    GENMASK(13, 6)
+#define HSIO_PLL5G_CFG1_RC_CTRL_DATA_X(x)                 (((x) & GENMASK(13, 6)) >> 6)
+#define HSIO_PLL5G_CFG1_QUARTER_RATE                      BIT(5)
+#define HSIO_PLL5G_CFG1_PWD_TX                            BIT(4)
+#define HSIO_PLL5G_CFG1_PWD_RX                            BIT(3)
+#define HSIO_PLL5G_CFG1_OUT_OF_RANGE_RECAL_ENA            BIT(2)
+#define HSIO_PLL5G_CFG1_HALF_RATE                         BIT(1)
+#define HSIO_PLL5G_CFG1_FORCE_SET_ENA                     BIT(0)
+
+#define HSIO_PLL5G_CFG2_ENA_TEST_MODE                     BIT(30)
+#define HSIO_PLL5G_CFG2_ENA_PFD_IN_FLIP                   BIT(29)
+#define HSIO_PLL5G_CFG2_ENA_VCO_NREF_TESTOUT              BIT(28)
+#define HSIO_PLL5G_CFG2_ENA_FBTESTOUT                     BIT(27)
+#define HSIO_PLL5G_CFG2_ENA_RCPLL                         BIT(26)
+#define HSIO_PLL5G_CFG2_ENA_CP2                           BIT(25)
+#define HSIO_PLL5G_CFG2_ENA_CLK_BYPASS1                   BIT(24)
+#define HSIO_PLL5G_CFG2_AMPC_SEL(x)                       (((x) << 16) & GENMASK(23, 16))
+#define HSIO_PLL5G_CFG2_AMPC_SEL_M                        GENMASK(23, 16)
+#define HSIO_PLL5G_CFG2_AMPC_SEL_X(x)                     (((x) & GENMASK(23, 16)) >> 16)
+#define HSIO_PLL5G_CFG2_ENA_CLK_BYPASS                    BIT(15)
+#define HSIO_PLL5G_CFG2_PWD_AMPCTRL_N                     BIT(14)
+#define HSIO_PLL5G_CFG2_ENA_AMPCTRL                       BIT(13)
+#define HSIO_PLL5G_CFG2_ENA_AMP_CTRL_FORCE                BIT(12)
+#define HSIO_PLL5G_CFG2_FRC_FSM_POR                       BIT(11)
+#define HSIO_PLL5G_CFG2_DISABLE_FSM_POR                   BIT(10)
+#define HSIO_PLL5G_CFG2_GAIN_TEST(x)                      (((x) << 5) & GENMASK(9, 5))
+#define HSIO_PLL5G_CFG2_GAIN_TEST_M                       GENMASK(9, 5)
+#define HSIO_PLL5G_CFG2_GAIN_TEST_X(x)                    (((x) & GENMASK(9, 5)) >> 5)
+#define HSIO_PLL5G_CFG2_EN_RESET_OVERRUN                  BIT(4)
+#define HSIO_PLL5G_CFG2_EN_RESET_LIM_DET                  BIT(3)
+#define HSIO_PLL5G_CFG2_EN_RESET_FRQ_DET                  BIT(2)
+#define HSIO_PLL5G_CFG2_DISABLE_FSM                       BIT(1)
+#define HSIO_PLL5G_CFG2_ENA_GAIN_TEST                     BIT(0)
+
+#define HSIO_PLL5G_CFG3_TEST_ANA_OUT_SEL(x)               (((x) << 22) & GENMASK(23, 22))
+#define HSIO_PLL5G_CFG3_TEST_ANA_OUT_SEL_M                GENMASK(23, 22)
+#define HSIO_PLL5G_CFG3_TEST_ANA_OUT_SEL_X(x)             (((x) & GENMASK(23, 22)) >> 22)
+#define HSIO_PLL5G_CFG3_TESTOUT_SEL(x)                    (((x) << 19) & GENMASK(21, 19))
+#define HSIO_PLL5G_CFG3_TESTOUT_SEL_M                     GENMASK(21, 19)
+#define HSIO_PLL5G_CFG3_TESTOUT_SEL_X(x)                  (((x) & GENMASK(21, 19)) >> 19)
+#define HSIO_PLL5G_CFG3_ENA_ANA_TEST_OUT                  BIT(18)
+#define HSIO_PLL5G_CFG3_ENA_TEST_OUT                      BIT(17)
+#define HSIO_PLL5G_CFG3_SEL_FBDCLK                        BIT(16)
+#define HSIO_PLL5G_CFG3_SEL_CML_CMOS_PFD                  BIT(15)
+#define HSIO_PLL5G_CFG3_RST_FB_N                          BIT(14)
+#define HSIO_PLL5G_CFG3_FORCE_VCO_CONTRH                  BIT(13)
+#define HSIO_PLL5G_CFG3_FORCE_LO                          BIT(12)
+#define HSIO_PLL5G_CFG3_FORCE_HI                          BIT(11)
+#define HSIO_PLL5G_CFG3_FORCE_ENA                         BIT(10)
+#define HSIO_PLL5G_CFG3_FORCE_CP                          BIT(9)
+#define HSIO_PLL5G_CFG3_FBDIVSEL_TST_ENA                  BIT(8)
+#define HSIO_PLL5G_CFG3_FBDIVSEL(x)                       ((x) & GENMASK(7, 0))
+#define HSIO_PLL5G_CFG3_FBDIVSEL_M                        GENMASK(7, 0)
+
+#define HSIO_PLL5G_CFG4_IB_BIAS_CTRL(x)                   (((x) << 16) & GENMASK(23, 16))
+#define HSIO_PLL5G_CFG4_IB_BIAS_CTRL_M                    GENMASK(23, 16)
+#define HSIO_PLL5G_CFG4_IB_BIAS_CTRL_X(x)                 (((x) & GENMASK(23, 16)) >> 16)
+#define HSIO_PLL5G_CFG4_IB_CTRL(x)                        ((x) & GENMASK(15, 0))
+#define HSIO_PLL5G_CFG4_IB_CTRL_M                         GENMASK(15, 0)
+
+#define HSIO_PLL5G_CFG5_OB_BIAS_CTRL(x)                   (((x) << 16) & GENMASK(23, 16))
+#define HSIO_PLL5G_CFG5_OB_BIAS_CTRL_M                    GENMASK(23, 16)
+#define HSIO_PLL5G_CFG5_OB_BIAS_CTRL_X(x)                 (((x) & GENMASK(23, 16)) >> 16)
+#define HSIO_PLL5G_CFG5_OB_CTRL(x)                        ((x) & GENMASK(15, 0))
+#define HSIO_PLL5G_CFG5_OB_CTRL_M                         GENMASK(15, 0)
+
+#define HSIO_PLL5G_CFG6_REFCLK_SEL_SRC                    BIT(23)
+#define HSIO_PLL5G_CFG6_REFCLK_SEL(x)                     (((x) << 20) & GENMASK(22, 20))
+#define HSIO_PLL5G_CFG6_REFCLK_SEL_M                      GENMASK(22, 20)
+#define HSIO_PLL5G_CFG6_REFCLK_SEL_X(x)                   (((x) & GENMASK(22, 20)) >> 20)
+#define HSIO_PLL5G_CFG6_REFCLK_SRC                        BIT(19)
+#define HSIO_PLL5G_CFG6_POR_DEL_SEL(x)                    (((x) << 16) & GENMASK(17, 16))
+#define HSIO_PLL5G_CFG6_POR_DEL_SEL_M                     GENMASK(17, 16)
+#define HSIO_PLL5G_CFG6_POR_DEL_SEL_X(x)                  (((x) & GENMASK(17, 16)) >> 16)
+#define HSIO_PLL5G_CFG6_DIV125REF_SEL(x)                  (((x) << 8) & GENMASK(15, 8))
+#define HSIO_PLL5G_CFG6_DIV125REF_SEL_M                   GENMASK(15, 8)
+#define HSIO_PLL5G_CFG6_DIV125REF_SEL_X(x)                (((x) & GENMASK(15, 8)) >> 8)
+#define HSIO_PLL5G_CFG6_ENA_REFCLKC2                      BIT(7)
+#define HSIO_PLL5G_CFG6_ENA_FBCLKC2                       BIT(6)
+#define HSIO_PLL5G_CFG6_DDR_CLK_DIV(x)                    ((x) & GENMASK(5, 0))
+#define HSIO_PLL5G_CFG6_DDR_CLK_DIV_M                     GENMASK(5, 0)
+
+#define HSIO_PLL5G_STATUS0_RANGE_LIM                      BIT(12)
+#define HSIO_PLL5G_STATUS0_OUT_OF_RANGE_ERR               BIT(11)
+#define HSIO_PLL5G_STATUS0_CALIBRATION_ERR                BIT(10)
+#define HSIO_PLL5G_STATUS0_CALIBRATION_DONE               BIT(9)
+#define HSIO_PLL5G_STATUS0_READBACK_DATA(x)               (((x) << 1) & GENMASK(8, 1))
+#define HSIO_PLL5G_STATUS0_READBACK_DATA_M                GENMASK(8, 1)
+#define HSIO_PLL5G_STATUS0_READBACK_DATA_X(x)             (((x) & GENMASK(8, 1)) >> 1)
+#define HSIO_PLL5G_STATUS0_LOCK_STATUS                    BIT(0)
+
+#define HSIO_PLL5G_STATUS1_SIG_DEL(x)                     (((x) << 21) & GENMASK(28, 21))
+#define HSIO_PLL5G_STATUS1_SIG_DEL_M                      GENMASK(28, 21)
+#define HSIO_PLL5G_STATUS1_SIG_DEL_X(x)                   (((x) & GENMASK(28, 21)) >> 21)
+#define HSIO_PLL5G_STATUS1_GAIN_STAT(x)                   (((x) << 16) & GENMASK(20, 16))
+#define HSIO_PLL5G_STATUS1_GAIN_STAT_M                    GENMASK(20, 16)
+#define HSIO_PLL5G_STATUS1_GAIN_STAT_X(x)                 (((x) & GENMASK(20, 16)) >> 16)
+#define HSIO_PLL5G_STATUS1_FBCNT_DIF(x)                   (((x) << 4) & GENMASK(13, 4))
+#define HSIO_PLL5G_STATUS1_FBCNT_DIF_M                    GENMASK(13, 4)
+#define HSIO_PLL5G_STATUS1_FBCNT_DIF_X(x)                 (((x) & GENMASK(13, 4)) >> 4)
+#define HSIO_PLL5G_STATUS1_FSM_STAT(x)                    (((x) << 1) & GENMASK(3, 1))
+#define HSIO_PLL5G_STATUS1_FSM_STAT_M                     GENMASK(3, 1)
+#define HSIO_PLL5G_STATUS1_FSM_STAT_X(x)                  (((x) & GENMASK(3, 1)) >> 1)
+#define HSIO_PLL5G_STATUS1_FSM_LOCK                       BIT(0)
+
+#define HSIO_PLL5G_BIST_CFG0_PLLB_START_BIST              BIT(31)
+#define HSIO_PLL5G_BIST_CFG0_PLLB_MEAS_MODE               BIT(30)
+#define HSIO_PLL5G_BIST_CFG0_PLLB_LOCK_REPEAT(x)          (((x) << 20) & GENMASK(23, 20))
+#define HSIO_PLL5G_BIST_CFG0_PLLB_LOCK_REPEAT_M           GENMASK(23, 20)
+#define HSIO_PLL5G_BIST_CFG0_PLLB_LOCK_REPEAT_X(x)        (((x) & GENMASK(23, 20)) >> 20)
+#define HSIO_PLL5G_BIST_CFG0_PLLB_LOCK_UNCERT(x)          (((x) << 16) & GENMASK(19, 16))
+#define HSIO_PLL5G_BIST_CFG0_PLLB_LOCK_UNCERT_M           GENMASK(19, 16)
+#define HSIO_PLL5G_BIST_CFG0_PLLB_LOCK_UNCERT_X(x)        (((x) & GENMASK(19, 16)) >> 16)
+#define HSIO_PLL5G_BIST_CFG0_PLLB_DIV_FACTOR_PRE(x)       ((x) & GENMASK(15, 0))
+#define HSIO_PLL5G_BIST_CFG0_PLLB_DIV_FACTOR_PRE_M        GENMASK(15, 0)
+
+#define HSIO_PLL5G_BIST_STAT0_PLLB_FSM_STAT(x)            (((x) << 4) & GENMASK(7, 4))
+#define HSIO_PLL5G_BIST_STAT0_PLLB_FSM_STAT_M             GENMASK(7, 4)
+#define HSIO_PLL5G_BIST_STAT0_PLLB_FSM_STAT_X(x)          (((x) & GENMASK(7, 4)) >> 4)
+#define HSIO_PLL5G_BIST_STAT0_PLLB_BUSY                   BIT(2)
+#define HSIO_PLL5G_BIST_STAT0_PLLB_DONE_N                 BIT(1)
+#define HSIO_PLL5G_BIST_STAT0_PLLB_FAIL                   BIT(0)
+
+#define HSIO_PLL5G_BIST_STAT1_PLLB_CNT_OUT(x)             (((x) << 16) & GENMASK(31, 16))
+#define HSIO_PLL5G_BIST_STAT1_PLLB_CNT_OUT_M              GENMASK(31, 16)
+#define HSIO_PLL5G_BIST_STAT1_PLLB_CNT_OUT_X(x)           (((x) & GENMASK(31, 16)) >> 16)
+#define HSIO_PLL5G_BIST_STAT1_PLLB_CNT_REF_DIFF(x)        ((x) & GENMASK(15, 0))
+#define HSIO_PLL5G_BIST_STAT1_PLLB_CNT_REF_DIFF_M         GENMASK(15, 0)
+
+#define HSIO_RCOMP_CFG0_PWD_ENA                           BIT(13)
+#define HSIO_RCOMP_CFG0_RUN_CAL                           BIT(12)
+#define HSIO_RCOMP_CFG0_SPEED_SEL(x)                      (((x) << 10) & GENMASK(11, 10))
+#define HSIO_RCOMP_CFG0_SPEED_SEL_M                       GENMASK(11, 10)
+#define HSIO_RCOMP_CFG0_SPEED_SEL_X(x)                    (((x) & GENMASK(11, 10)) >> 10)
+#define HSIO_RCOMP_CFG0_MODE_SEL(x)                       (((x) << 8) & GENMASK(9, 8))
+#define HSIO_RCOMP_CFG0_MODE_SEL_M                        GENMASK(9, 8)
+#define HSIO_RCOMP_CFG0_MODE_SEL_X(x)                     (((x) & GENMASK(9, 8)) >> 8)
+#define HSIO_RCOMP_CFG0_FORCE_ENA                         BIT(4)
+#define HSIO_RCOMP_CFG0_RCOMP_VAL(x)                      ((x) & GENMASK(3, 0))
+#define HSIO_RCOMP_CFG0_RCOMP_VAL_M                       GENMASK(3, 0)
+
+#define HSIO_RCOMP_STATUS_BUSY                            BIT(12)
+#define HSIO_RCOMP_STATUS_DELTA_ALERT                     BIT(7)
+#define HSIO_RCOMP_STATUS_RCOMP(x)                        ((x) & GENMASK(3, 0))
+#define HSIO_RCOMP_STATUS_RCOMP_M                         GENMASK(3, 0)
+
+#define HSIO_SYNC_ETH_CFG_RSZ                             0x4
+
+#define HSIO_SYNC_ETH_CFG_SEL_RECO_CLK_SRC(x)             (((x) << 4) & GENMASK(7, 4))
+#define HSIO_SYNC_ETH_CFG_SEL_RECO_CLK_SRC_M              GENMASK(7, 4)
+#define HSIO_SYNC_ETH_CFG_SEL_RECO_CLK_SRC_X(x)           (((x) & GENMASK(7, 4)) >> 4)
+#define HSIO_SYNC_ETH_CFG_SEL_RECO_CLK_DIV(x)             (((x) << 1) & GENMASK(3, 1))
+#define HSIO_SYNC_ETH_CFG_SEL_RECO_CLK_DIV_M              GENMASK(3, 1)
+#define HSIO_SYNC_ETH_CFG_SEL_RECO_CLK_DIV_X(x)           (((x) & GENMASK(3, 1)) >> 1)
+#define HSIO_SYNC_ETH_CFG_RECO_CLK_ENA                    BIT(0)
+
+#define HSIO_SYNC_ETH_PLL_CFG_PLL_AUTO_SQUELCH_ENA        BIT(0)
+
+#define HSIO_S1G_DES_CFG_DES_PHS_CTRL(x)                  (((x) << 13) & GENMASK(16, 13))
+#define HSIO_S1G_DES_CFG_DES_PHS_CTRL_M                   GENMASK(16, 13)
+#define HSIO_S1G_DES_CFG_DES_PHS_CTRL_X(x)                (((x) & GENMASK(16, 13)) >> 13)
+#define HSIO_S1G_DES_CFG_DES_CPMD_SEL(x)                  (((x) << 11) & GENMASK(12, 11))
+#define HSIO_S1G_DES_CFG_DES_CPMD_SEL_M                   GENMASK(12, 11)
+#define HSIO_S1G_DES_CFG_DES_CPMD_SEL_X(x)                (((x) & GENMASK(12, 11)) >> 11)
+#define HSIO_S1G_DES_CFG_DES_MBTR_CTRL(x)                 (((x) << 8) & GENMASK(10, 8))
+#define HSIO_S1G_DES_CFG_DES_MBTR_CTRL_M                  GENMASK(10, 8)
+#define HSIO_S1G_DES_CFG_DES_MBTR_CTRL_X(x)               (((x) & GENMASK(10, 8)) >> 8)
+#define HSIO_S1G_DES_CFG_DES_BW_ANA(x)                    (((x) << 5) & GENMASK(7, 5))
+#define HSIO_S1G_DES_CFG_DES_BW_ANA_M                     GENMASK(7, 5)
+#define HSIO_S1G_DES_CFG_DES_BW_ANA_X(x)                  (((x) & GENMASK(7, 5)) >> 5)
+#define HSIO_S1G_DES_CFG_DES_SWAP_ANA                     BIT(4)
+#define HSIO_S1G_DES_CFG_DES_BW_HYST(x)                   (((x) << 1) & GENMASK(3, 1))
+#define HSIO_S1G_DES_CFG_DES_BW_HYST_M                    GENMASK(3, 1)
+#define HSIO_S1G_DES_CFG_DES_BW_HYST_X(x)                 (((x) & GENMASK(3, 1)) >> 1)
+#define HSIO_S1G_DES_CFG_DES_SWAP_HYST                    BIT(0)
+
+#define HSIO_S1G_IB_CFG_IB_FX100_ENA                      BIT(27)
+#define HSIO_S1G_IB_CFG_ACJTAG_HYST(x)                    (((x) << 24) & GENMASK(26, 24))
+#define HSIO_S1G_IB_CFG_ACJTAG_HYST_M                     GENMASK(26, 24)
+#define HSIO_S1G_IB_CFG_ACJTAG_HYST_X(x)                  (((x) & GENMASK(26, 24)) >> 24)
+#define HSIO_S1G_IB_CFG_IB_DET_LEV(x)                     (((x) << 19) & GENMASK(21, 19))
+#define HSIO_S1G_IB_CFG_IB_DET_LEV_M                      GENMASK(21, 19)
+#define HSIO_S1G_IB_CFG_IB_DET_LEV_X(x)                   (((x) & GENMASK(21, 19)) >> 19)
+#define HSIO_S1G_IB_CFG_IB_HYST_LEV                       BIT(14)
+#define HSIO_S1G_IB_CFG_IB_ENA_CMV_TERM                   BIT(13)
+#define HSIO_S1G_IB_CFG_IB_ENA_DC_COUPLING                BIT(12)
+#define HSIO_S1G_IB_CFG_IB_ENA_DETLEV                     BIT(11)
+#define HSIO_S1G_IB_CFG_IB_ENA_HYST                       BIT(10)
+#define HSIO_S1G_IB_CFG_IB_ENA_OFFSET_COMP                BIT(9)
+#define HSIO_S1G_IB_CFG_IB_EQ_GAIN(x)                     (((x) << 6) & GENMASK(8, 6))
+#define HSIO_S1G_IB_CFG_IB_EQ_GAIN_M                      GENMASK(8, 6)
+#define HSIO_S1G_IB_CFG_IB_EQ_GAIN_X(x)                   (((x) & GENMASK(8, 6)) >> 6)
+#define HSIO_S1G_IB_CFG_IB_SEL_CORNER_FREQ(x)             (((x) << 4) & GENMASK(5, 4))
+#define HSIO_S1G_IB_CFG_IB_SEL_CORNER_FREQ_M              GENMASK(5, 4)
+#define HSIO_S1G_IB_CFG_IB_SEL_CORNER_FREQ_X(x)           (((x) & GENMASK(5, 4)) >> 4)
+#define HSIO_S1G_IB_CFG_IB_RESISTOR_CTRL(x)               ((x) & GENMASK(3, 0))
+#define HSIO_S1G_IB_CFG_IB_RESISTOR_CTRL_M                GENMASK(3, 0)
+
+#define HSIO_S1G_OB_CFG_OB_SLP(x)                         (((x) << 17) & GENMASK(18, 17))
+#define HSIO_S1G_OB_CFG_OB_SLP_M                          GENMASK(18, 17)
+#define HSIO_S1G_OB_CFG_OB_SLP_X(x)                       (((x) & GENMASK(18, 17)) >> 17)
+#define HSIO_S1G_OB_CFG_OB_AMP_CTRL(x)                    (((x) << 13) & GENMASK(16, 13))
+#define HSIO_S1G_OB_CFG_OB_AMP_CTRL_M                     GENMASK(16, 13)
+#define HSIO_S1G_OB_CFG_OB_AMP_CTRL_X(x)                  (((x) & GENMASK(16, 13)) >> 13)
+#define HSIO_S1G_OB_CFG_OB_CMM_BIAS_CTRL(x)               (((x) << 10) & GENMASK(12, 10))
+#define HSIO_S1G_OB_CFG_OB_CMM_BIAS_CTRL_M                GENMASK(12, 10)
+#define HSIO_S1G_OB_CFG_OB_CMM_BIAS_CTRL_X(x)             (((x) & GENMASK(12, 10)) >> 10)
+#define HSIO_S1G_OB_CFG_OB_DIS_VCM_CTRL                   BIT(9)
+#define HSIO_S1G_OB_CFG_OB_EN_MEAS_VREG                   BIT(8)
+#define HSIO_S1G_OB_CFG_OB_VCM_CTRL(x)                    (((x) << 4) & GENMASK(7, 4))
+#define HSIO_S1G_OB_CFG_OB_VCM_CTRL_M                     GENMASK(7, 4)
+#define HSIO_S1G_OB_CFG_OB_VCM_CTRL_X(x)                  (((x) & GENMASK(7, 4)) >> 4)
+#define HSIO_S1G_OB_CFG_OB_RESISTOR_CTRL(x)               ((x) & GENMASK(3, 0))
+#define HSIO_S1G_OB_CFG_OB_RESISTOR_CTRL_M                GENMASK(3, 0)
+
+#define HSIO_S1G_SER_CFG_SER_IDLE                         BIT(9)
+#define HSIO_S1G_SER_CFG_SER_DEEMPH                       BIT(8)
+#define HSIO_S1G_SER_CFG_SER_CPMD_SEL                     BIT(7)
+#define HSIO_S1G_SER_CFG_SER_SWAP_CPMD                    BIT(6)
+#define HSIO_S1G_SER_CFG_SER_ALISEL(x)                    (((x) << 4) & GENMASK(5, 4))
+#define HSIO_S1G_SER_CFG_SER_ALISEL_M                     GENMASK(5, 4)
+#define HSIO_S1G_SER_CFG_SER_ALISEL_X(x)                  (((x) & GENMASK(5, 4)) >> 4)
+#define HSIO_S1G_SER_CFG_SER_ENHYS                        BIT(3)
+#define HSIO_S1G_SER_CFG_SER_BIG_WIN                      BIT(2)
+#define HSIO_S1G_SER_CFG_SER_EN_WIN                       BIT(1)
+#define HSIO_S1G_SER_CFG_SER_ENALI                        BIT(0)
+
+#define HSIO_S1G_COMMON_CFG_SYS_RST                       BIT(31)
+#define HSIO_S1G_COMMON_CFG_SE_AUTO_SQUELCH_ENA           BIT(21)
+#define HSIO_S1G_COMMON_CFG_ENA_LANE                      BIT(18)
+#define HSIO_S1G_COMMON_CFG_PWD_RX                        BIT(17)
+#define HSIO_S1G_COMMON_CFG_PWD_TX                        BIT(16)
+#define HSIO_S1G_COMMON_CFG_LANE_CTRL(x)                  (((x) << 13) & GENMASK(15, 13))
+#define HSIO_S1G_COMMON_CFG_LANE_CTRL_M                   GENMASK(15, 13)
+#define HSIO_S1G_COMMON_CFG_LANE_CTRL_X(x)                (((x) & GENMASK(15, 13)) >> 13)
+#define HSIO_S1G_COMMON_CFG_ENA_DIRECT                    BIT(12)
+#define HSIO_S1G_COMMON_CFG_ENA_ELOOP                     BIT(11)
+#define HSIO_S1G_COMMON_CFG_ENA_FLOOP                     BIT(10)
+#define HSIO_S1G_COMMON_CFG_ENA_ILOOP                     BIT(9)
+#define HSIO_S1G_COMMON_CFG_ENA_PLOOP                     BIT(8)
+#define HSIO_S1G_COMMON_CFG_HRATE                         BIT(7)
+#define HSIO_S1G_COMMON_CFG_IF_MODE                       BIT(0)
+
+#define HSIO_S1G_PLL_CFG_PLL_ENA_FB_DIV2                  BIT(22)
+#define HSIO_S1G_PLL_CFG_PLL_ENA_RC_DIV2                  BIT(21)
+#define HSIO_S1G_PLL_CFG_PLL_FSM_CTRL_DATA(x)             (((x) << 8) & GENMASK(15, 8))
+#define HSIO_S1G_PLL_CFG_PLL_FSM_CTRL_DATA_M              GENMASK(15, 8)
+#define HSIO_S1G_PLL_CFG_PLL_FSM_CTRL_DATA_X(x)           (((x) & GENMASK(15, 8)) >> 8)
+#define HSIO_S1G_PLL_CFG_PLL_FSM_ENA                      BIT(7)
+#define HSIO_S1G_PLL_CFG_PLL_FSM_FORCE_SET_ENA            BIT(6)
+#define HSIO_S1G_PLL_CFG_PLL_FSM_OOR_RECAL_ENA            BIT(5)
+#define HSIO_S1G_PLL_CFG_PLL_RB_DATA_SEL                  BIT(3)
+
+#define HSIO_S1G_PLL_STATUS_PLL_CAL_NOT_DONE              BIT(12)
+#define HSIO_S1G_PLL_STATUS_PLL_CAL_ERR                   BIT(11)
+#define HSIO_S1G_PLL_STATUS_PLL_OUT_OF_RANGE_ERR          BIT(10)
+#define HSIO_S1G_PLL_STATUS_PLL_RB_DATA(x)                ((x) & GENMASK(7, 0))
+#define HSIO_S1G_PLL_STATUS_PLL_RB_DATA_M                 GENMASK(7, 0)
+
+#define HSIO_S1G_DFT_CFG0_LAZYBIT                         BIT(31)
+#define HSIO_S1G_DFT_CFG0_INV_DIS                         BIT(23)
+#define HSIO_S1G_DFT_CFG0_PRBS_SEL(x)                     (((x) << 20) & GENMASK(21, 20))
+#define HSIO_S1G_DFT_CFG0_PRBS_SEL_M                      GENMASK(21, 20)
+#define HSIO_S1G_DFT_CFG0_PRBS_SEL_X(x)                   (((x) & GENMASK(21, 20)) >> 20)
+#define HSIO_S1G_DFT_CFG0_TEST_MODE(x)                    (((x) << 16) & GENMASK(18, 16))
+#define HSIO_S1G_DFT_CFG0_TEST_MODE_M                     GENMASK(18, 16)
+#define HSIO_S1G_DFT_CFG0_TEST_MODE_X(x)                  (((x) & GENMASK(18, 16)) >> 16)
+#define HSIO_S1G_DFT_CFG0_RX_PHS_CORR_DIS                 BIT(4)
+#define HSIO_S1G_DFT_CFG0_RX_PDSENS_ENA                   BIT(3)
+#define HSIO_S1G_DFT_CFG0_RX_DFT_ENA                      BIT(2)
+#define HSIO_S1G_DFT_CFG0_TX_DFT_ENA                      BIT(0)
+
+#define HSIO_S1G_DFT_CFG1_TX_JITTER_AMPL(x)               (((x) << 8) & GENMASK(17, 8))
+#define HSIO_S1G_DFT_CFG1_TX_JITTER_AMPL_M                GENMASK(17, 8)
+#define HSIO_S1G_DFT_CFG1_TX_JITTER_AMPL_X(x)             (((x) & GENMASK(17, 8)) >> 8)
+#define HSIO_S1G_DFT_CFG1_TX_STEP_FREQ(x)                 (((x) << 4) & GENMASK(7, 4))
+#define HSIO_S1G_DFT_CFG1_TX_STEP_FREQ_M                  GENMASK(7, 4)
+#define HSIO_S1G_DFT_CFG1_TX_STEP_FREQ_X(x)               (((x) & GENMASK(7, 4)) >> 4)
+#define HSIO_S1G_DFT_CFG1_TX_JI_ENA                       BIT(3)
+#define HSIO_S1G_DFT_CFG1_TX_WAVEFORM_SEL                 BIT(2)
+#define HSIO_S1G_DFT_CFG1_TX_FREQOFF_DIR                  BIT(1)
+#define HSIO_S1G_DFT_CFG1_TX_FREQOFF_ENA                  BIT(0)
+
+#define HSIO_S1G_DFT_CFG2_RX_JITTER_AMPL(x)               (((x) << 8) & GENMASK(17, 8))
+#define HSIO_S1G_DFT_CFG2_RX_JITTER_AMPL_M                GENMASK(17, 8)
+#define HSIO_S1G_DFT_CFG2_RX_JITTER_AMPL_X(x)             (((x) & GENMASK(17, 8)) >> 8)
+#define HSIO_S1G_DFT_CFG2_RX_STEP_FREQ(x)                 (((x) << 4) & GENMASK(7, 4))
+#define HSIO_S1G_DFT_CFG2_RX_STEP_FREQ_M                  GENMASK(7, 4)
+#define HSIO_S1G_DFT_CFG2_RX_STEP_FREQ_X(x)               (((x) & GENMASK(7, 4)) >> 4)
+#define HSIO_S1G_DFT_CFG2_RX_JI_ENA                       BIT(3)
+#define HSIO_S1G_DFT_CFG2_RX_WAVEFORM_SEL                 BIT(2)
+#define HSIO_S1G_DFT_CFG2_RX_FREQOFF_DIR                  BIT(1)
+#define HSIO_S1G_DFT_CFG2_RX_FREQOFF_ENA                  BIT(0)
+
+#define HSIO_S1G_RC_PLL_BIST_CFG_PLL_BIST_ENA             BIT(20)
+#define HSIO_S1G_RC_PLL_BIST_CFG_PLL_BIST_FBS_HIGH(x)     (((x) << 16) & GENMASK(17, 16))
+#define HSIO_S1G_RC_PLL_BIST_CFG_PLL_BIST_FBS_HIGH_M      GENMASK(17, 16)
+#define HSIO_S1G_RC_PLL_BIST_CFG_PLL_BIST_FBS_HIGH_X(x)   (((x) & GENMASK(17, 16)) >> 16)
+#define HSIO_S1G_RC_PLL_BIST_CFG_PLL_BIST_HIGH(x)         (((x) << 8) & GENMASK(15, 8))
+#define HSIO_S1G_RC_PLL_BIST_CFG_PLL_BIST_HIGH_M          GENMASK(15, 8)
+#define HSIO_S1G_RC_PLL_BIST_CFG_PLL_BIST_HIGH_X(x)       (((x) & GENMASK(15, 8)) >> 8)
+#define HSIO_S1G_RC_PLL_BIST_CFG_PLL_BIST_LOW(x)          ((x) & GENMASK(7, 0))
+#define HSIO_S1G_RC_PLL_BIST_CFG_PLL_BIST_LOW_M           GENMASK(7, 0)
+
+#define HSIO_S1G_MISC_CFG_DES_100FX_KICK_MODE(x)          (((x) << 11) & GENMASK(12, 11))
+#define HSIO_S1G_MISC_CFG_DES_100FX_KICK_MODE_M           GENMASK(12, 11)
+#define HSIO_S1G_MISC_CFG_DES_100FX_KICK_MODE_X(x)        (((x) & GENMASK(12, 11)) >> 11)
+#define HSIO_S1G_MISC_CFG_DES_100FX_CPMD_SWAP             BIT(10)
+#define HSIO_S1G_MISC_CFG_DES_100FX_CPMD_MODE             BIT(9)
+#define HSIO_S1G_MISC_CFG_DES_100FX_CPMD_ENA              BIT(8)
+#define HSIO_S1G_MISC_CFG_RX_LPI_MODE_ENA                 BIT(5)
+#define HSIO_S1G_MISC_CFG_TX_LPI_MODE_ENA                 BIT(4)
+#define HSIO_S1G_MISC_CFG_RX_DATA_INV_ENA                 BIT(3)
+#define HSIO_S1G_MISC_CFG_TX_DATA_INV_ENA                 BIT(2)
+#define HSIO_S1G_MISC_CFG_LANE_RST                        BIT(0)
+
+#define HSIO_S1G_DFT_STATUS_PLL_BIST_NOT_DONE             BIT(7)
+#define HSIO_S1G_DFT_STATUS_PLL_BIST_FAILED               BIT(6)
+#define HSIO_S1G_DFT_STATUS_PLL_BIST_TIMEOUT_ERR          BIT(5)
+#define HSIO_S1G_DFT_STATUS_BIST_ACTIVE                   BIT(3)
+#define HSIO_S1G_DFT_STATUS_BIST_NOSYNC                   BIT(2)
+#define HSIO_S1G_DFT_STATUS_BIST_COMPLETE_N               BIT(1)
+#define HSIO_S1G_DFT_STATUS_BIST_ERROR                    BIT(0)
+
+#define HSIO_S1G_MISC_STATUS_DES_100FX_PHASE_SEL          BIT(0)
+
+#define HSIO_MCB_S1G_ADDR_CFG_SERDES1G_WR_ONE_SHOT        BIT(31)
+#define HSIO_MCB_S1G_ADDR_CFG_SERDES1G_RD_ONE_SHOT        BIT(30)
+#define HSIO_MCB_S1G_ADDR_CFG_SERDES1G_ADDR(x)            ((x) & GENMASK(8, 0))
+#define HSIO_MCB_S1G_ADDR_CFG_SERDES1G_ADDR_M             GENMASK(8, 0)
+
+#define HSIO_S6G_DIG_CFG_GP(x)                            (((x) << 16) & GENMASK(18, 16))
+#define HSIO_S6G_DIG_CFG_GP_M                             GENMASK(18, 16)
+#define HSIO_S6G_DIG_CFG_GP_X(x)                          (((x) & GENMASK(18, 16)) >> 16)
+#define HSIO_S6G_DIG_CFG_TX_BIT_DOUBLING_MODE_ENA         BIT(7)
+#define HSIO_S6G_DIG_CFG_SIGDET_TESTMODE                  BIT(6)
+#define HSIO_S6G_DIG_CFG_SIGDET_AST(x)                    (((x) << 3) & GENMASK(5, 3))
+#define HSIO_S6G_DIG_CFG_SIGDET_AST_M                     GENMASK(5, 3)
+#define HSIO_S6G_DIG_CFG_SIGDET_AST_X(x)                  (((x) & GENMASK(5, 3)) >> 3)
+#define HSIO_S6G_DIG_CFG_SIGDET_DST(x)                    ((x) & GENMASK(2, 0))
+#define HSIO_S6G_DIG_CFG_SIGDET_DST_M                     GENMASK(2, 0)
+
+#define HSIO_S6G_DFT_CFG0_LAZYBIT                         BIT(31)
+#define HSIO_S6G_DFT_CFG0_INV_DIS                         BIT(23)
+#define HSIO_S6G_DFT_CFG0_PRBS_SEL(x)                     (((x) << 20) & GENMASK(21, 20))
+#define HSIO_S6G_DFT_CFG0_PRBS_SEL_M                      GENMASK(21, 20)
+#define HSIO_S6G_DFT_CFG0_PRBS_SEL_X(x)                   (((x) & GENMASK(21, 20)) >> 20)
+#define HSIO_S6G_DFT_CFG0_TEST_MODE(x)                    (((x) << 16) & GENMASK(18, 16))
+#define HSIO_S6G_DFT_CFG0_TEST_MODE_M                     GENMASK(18, 16)
+#define HSIO_S6G_DFT_CFG0_TEST_MODE_X(x)                  (((x) & GENMASK(18, 16)) >> 16)
+#define HSIO_S6G_DFT_CFG0_RX_PHS_CORR_DIS                 BIT(4)
+#define HSIO_S6G_DFT_CFG0_RX_PDSENS_ENA                   BIT(3)
+#define HSIO_S6G_DFT_CFG0_RX_DFT_ENA                      BIT(2)
+#define HSIO_S6G_DFT_CFG0_TX_DFT_ENA                      BIT(0)
+
+#define HSIO_S6G_DFT_CFG1_TX_JITTER_AMPL(x)               (((x) << 8) & GENMASK(17, 8))
+#define HSIO_S6G_DFT_CFG1_TX_JITTER_AMPL_M                GENMASK(17, 8)
+#define HSIO_S6G_DFT_CFG1_TX_JITTER_AMPL_X(x)             (((x) & GENMASK(17, 8)) >> 8)
+#define HSIO_S6G_DFT_CFG1_TX_STEP_FREQ(x)                 (((x) << 4) & GENMASK(7, 4))
+#define HSIO_S6G_DFT_CFG1_TX_STEP_FREQ_M                  GENMASK(7, 4)
+#define HSIO_S6G_DFT_CFG1_TX_STEP_FREQ_X(x)               (((x) & GENMASK(7, 4)) >> 4)
+#define HSIO_S6G_DFT_CFG1_TX_JI_ENA                       BIT(3)
+#define HSIO_S6G_DFT_CFG1_TX_WAVEFORM_SEL                 BIT(2)
+#define HSIO_S6G_DFT_CFG1_TX_FREQOFF_DIR                  BIT(1)
+#define HSIO_S6G_DFT_CFG1_TX_FREQOFF_ENA                  BIT(0)
+
+#define HSIO_S6G_DFT_CFG2_RX_JITTER_AMPL(x)               (((x) << 8) & GENMASK(17, 8))
+#define HSIO_S6G_DFT_CFG2_RX_JITTER_AMPL_M                GENMASK(17, 8)
+#define HSIO_S6G_DFT_CFG2_RX_JITTER_AMPL_X(x)             (((x) & GENMASK(17, 8)) >> 8)
+#define HSIO_S6G_DFT_CFG2_RX_STEP_FREQ(x)                 (((x) << 4) & GENMASK(7, 4))
+#define HSIO_S6G_DFT_CFG2_RX_STEP_FREQ_M                  GENMASK(7, 4)
+#define HSIO_S6G_DFT_CFG2_RX_STEP_FREQ_X(x)               (((x) & GENMASK(7, 4)) >> 4)
+#define HSIO_S6G_DFT_CFG2_RX_JI_ENA                       BIT(3)
+#define HSIO_S6G_DFT_CFG2_RX_WAVEFORM_SEL                 BIT(2)
+#define HSIO_S6G_DFT_CFG2_RX_FREQOFF_DIR                  BIT(1)
+#define HSIO_S6G_DFT_CFG2_RX_FREQOFF_ENA                  BIT(0)
+
+#define HSIO_S6G_RC_PLL_BIST_CFG_PLL_BIST_ENA             BIT(20)
+#define HSIO_S6G_RC_PLL_BIST_CFG_PLL_BIST_FBS_HIGH(x)     (((x) << 16) & GENMASK(19, 16))
+#define HSIO_S6G_RC_PLL_BIST_CFG_PLL_BIST_FBS_HIGH_M      GENMASK(19, 16)
+#define HSIO_S6G_RC_PLL_BIST_CFG_PLL_BIST_FBS_HIGH_X(x)   (((x) & GENMASK(19, 16)) >> 16)
+#define HSIO_S6G_RC_PLL_BIST_CFG_PLL_BIST_HIGH(x)         (((x) << 8) & GENMASK(15, 8))
+#define HSIO_S6G_RC_PLL_BIST_CFG_PLL_BIST_HIGH_M          GENMASK(15, 8)
+#define HSIO_S6G_RC_PLL_BIST_CFG_PLL_BIST_HIGH_X(x)       (((x) & GENMASK(15, 8)) >> 8)
+#define HSIO_S6G_RC_PLL_BIST_CFG_PLL_BIST_LOW(x)          ((x) & GENMASK(7, 0))
+#define HSIO_S6G_RC_PLL_BIST_CFG_PLL_BIST_LOW_M           GENMASK(7, 0)
+
+#define HSIO_S6G_MISC_CFG_SEL_RECO_CLK(x)                 (((x) << 13) & GENMASK(14, 13))
+#define HSIO_S6G_MISC_CFG_SEL_RECO_CLK_M                  GENMASK(14, 13)
+#define HSIO_S6G_MISC_CFG_SEL_RECO_CLK_X(x)               (((x) & GENMASK(14, 13)) >> 13)
+#define HSIO_S6G_MISC_CFG_DES_100FX_KICK_MODE(x)          (((x) << 11) & GENMASK(12, 11))
+#define HSIO_S6G_MISC_CFG_DES_100FX_KICK_MODE_M           GENMASK(12, 11)
+#define HSIO_S6G_MISC_CFG_DES_100FX_KICK_MODE_X(x)        (((x) & GENMASK(12, 11)) >> 11)
+#define HSIO_S6G_MISC_CFG_DES_100FX_CPMD_SWAP             BIT(10)
+#define HSIO_S6G_MISC_CFG_DES_100FX_CPMD_MODE             BIT(9)
+#define HSIO_S6G_MISC_CFG_DES_100FX_CPMD_ENA              BIT(8)
+#define HSIO_S6G_MISC_CFG_RX_BUS_FLIP_ENA                 BIT(7)
+#define HSIO_S6G_MISC_CFG_TX_BUS_FLIP_ENA                 BIT(6)
+#define HSIO_S6G_MISC_CFG_RX_LPI_MODE_ENA                 BIT(5)
+#define HSIO_S6G_MISC_CFG_TX_LPI_MODE_ENA                 BIT(4)
+#define HSIO_S6G_MISC_CFG_RX_DATA_INV_ENA                 BIT(3)
+#define HSIO_S6G_MISC_CFG_TX_DATA_INV_ENA                 BIT(2)
+#define HSIO_S6G_MISC_CFG_LANE_RST                        BIT(0)
+
+#define HSIO_S6G_OB_ANEG_CFG_AN_OB_POST0(x)               (((x) << 23) & GENMASK(28, 23))
+#define HSIO_S6G_OB_ANEG_CFG_AN_OB_POST0_M                GENMASK(28, 23)
+#define HSIO_S6G_OB_ANEG_CFG_AN_OB_POST0_X(x)             (((x) & GENMASK(28, 23)) >> 23)
+#define HSIO_S6G_OB_ANEG_CFG_AN_OB_POST1(x)               (((x) << 18) & GENMASK(22, 18))
+#define HSIO_S6G_OB_ANEG_CFG_AN_OB_POST1_M                GENMASK(22, 18)
+#define HSIO_S6G_OB_ANEG_CFG_AN_OB_POST1_X(x)             (((x) & GENMASK(22, 18)) >> 18)
+#define HSIO_S6G_OB_ANEG_CFG_AN_OB_PREC(x)                (((x) << 13) & GENMASK(17, 13))
+#define HSIO_S6G_OB_ANEG_CFG_AN_OB_PREC_M                 GENMASK(17, 13)
+#define HSIO_S6G_OB_ANEG_CFG_AN_OB_PREC_X(x)              (((x) & GENMASK(17, 13)) >> 13)
+#define HSIO_S6G_OB_ANEG_CFG_AN_OB_ENA_CAS(x)             (((x) << 6) & GENMASK(8, 6))
+#define HSIO_S6G_OB_ANEG_CFG_AN_OB_ENA_CAS_M              GENMASK(8, 6)
+#define HSIO_S6G_OB_ANEG_CFG_AN_OB_ENA_CAS_X(x)           (((x) & GENMASK(8, 6)) >> 6)
+#define HSIO_S6G_OB_ANEG_CFG_AN_OB_LEV(x)                 ((x) & GENMASK(5, 0))
+#define HSIO_S6G_OB_ANEG_CFG_AN_OB_LEV_M                  GENMASK(5, 0)
+
+#define HSIO_S6G_DFT_STATUS_PRBS_SYNC_STAT                BIT(8)
+#define HSIO_S6G_DFT_STATUS_PLL_BIST_NOT_DONE             BIT(7)
+#define HSIO_S6G_DFT_STATUS_PLL_BIST_FAILED               BIT(6)
+#define HSIO_S6G_DFT_STATUS_PLL_BIST_TIMEOUT_ERR          BIT(5)
+#define HSIO_S6G_DFT_STATUS_BIST_ACTIVE                   BIT(3)
+#define HSIO_S6G_DFT_STATUS_BIST_NOSYNC                   BIT(2)
+#define HSIO_S6G_DFT_STATUS_BIST_COMPLETE_N               BIT(1)
+#define HSIO_S6G_DFT_STATUS_BIST_ERROR                    BIT(0)
+
+#define HSIO_S6G_MISC_STATUS_DES_100FX_PHASE_SEL          BIT(0)
+
+#define HSIO_S6G_DES_CFG_DES_PHS_CTRL(x)                  (((x) << 13) & GENMASK(16, 13))
+#define HSIO_S6G_DES_CFG_DES_PHS_CTRL_M                   GENMASK(16, 13)
+#define HSIO_S6G_DES_CFG_DES_PHS_CTRL_X(x)                (((x) & GENMASK(16, 13)) >> 13)
+#define HSIO_S6G_DES_CFG_DES_MBTR_CTRL(x)                 (((x) << 10) & GENMASK(12, 10))
+#define HSIO_S6G_DES_CFG_DES_MBTR_CTRL_M                  GENMASK(12, 10)
+#define HSIO_S6G_DES_CFG_DES_MBTR_CTRL_X(x)               (((x) & GENMASK(12, 10)) >> 10)
+#define HSIO_S6G_DES_CFG_DES_CPMD_SEL(x)                  (((x) << 8) & GENMASK(9, 8))
+#define HSIO_S6G_DES_CFG_DES_CPMD_SEL_M                   GENMASK(9, 8)
+#define HSIO_S6G_DES_CFG_DES_CPMD_SEL_X(x)                (((x) & GENMASK(9, 8)) >> 8)
+#define HSIO_S6G_DES_CFG_DES_BW_HYST(x)                   (((x) << 5) & GENMASK(7, 5))
+#define HSIO_S6G_DES_CFG_DES_BW_HYST_M                    GENMASK(7, 5)
+#define HSIO_S6G_DES_CFG_DES_BW_HYST_X(x)                 (((x) & GENMASK(7, 5)) >> 5)
+#define HSIO_S6G_DES_CFG_DES_SWAP_HYST                    BIT(4)
+#define HSIO_S6G_DES_CFG_DES_BW_ANA(x)                    (((x) << 1) & GENMASK(3, 1))
+#define HSIO_S6G_DES_CFG_DES_BW_ANA_M                     GENMASK(3, 1)
+#define HSIO_S6G_DES_CFG_DES_BW_ANA_X(x)                  (((x) & GENMASK(3, 1)) >> 1)
+#define HSIO_S6G_DES_CFG_DES_SWAP_ANA                     BIT(0)
+
+#define HSIO_S6G_IB_CFG_IB_SOFSI(x)                       (((x) << 29) & GENMASK(30, 29))
+#define HSIO_S6G_IB_CFG_IB_SOFSI_M                        GENMASK(30, 29)
+#define HSIO_S6G_IB_CFG_IB_SOFSI_X(x)                     (((x) & GENMASK(30, 29)) >> 29)
+#define HSIO_S6G_IB_CFG_IB_VBULK_SEL                      BIT(28)
+#define HSIO_S6G_IB_CFG_IB_RTRM_ADJ(x)                    (((x) << 24) & GENMASK(27, 24))
+#define HSIO_S6G_IB_CFG_IB_RTRM_ADJ_M                     GENMASK(27, 24)
+#define HSIO_S6G_IB_CFG_IB_RTRM_ADJ_X(x)                  (((x) & GENMASK(27, 24)) >> 24)
+#define HSIO_S6G_IB_CFG_IB_ICML_ADJ(x)                    (((x) << 20) & GENMASK(23, 20))
+#define HSIO_S6G_IB_CFG_IB_ICML_ADJ_M                     GENMASK(23, 20)
+#define HSIO_S6G_IB_CFG_IB_ICML_ADJ_X(x)                  (((x) & GENMASK(23, 20)) >> 20)
+#define HSIO_S6G_IB_CFG_IB_TERM_MODE_SEL(x)               (((x) << 18) & GENMASK(19, 18))
+#define HSIO_S6G_IB_CFG_IB_TERM_MODE_SEL_M                GENMASK(19, 18)
+#define HSIO_S6G_IB_CFG_IB_TERM_MODE_SEL_X(x)             (((x) & GENMASK(19, 18)) >> 18)
+#define HSIO_S6G_IB_CFG_IB_SIG_DET_CLK_SEL(x)             (((x) << 15) & GENMASK(17, 15))
+#define HSIO_S6G_IB_CFG_IB_SIG_DET_CLK_SEL_M              GENMASK(17, 15)
+#define HSIO_S6G_IB_CFG_IB_SIG_DET_CLK_SEL_X(x)           (((x) & GENMASK(17, 15)) >> 15)
+#define HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_HP(x)              (((x) << 13) & GENMASK(14, 13))
+#define HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_HP_M               GENMASK(14, 13)
+#define HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_HP_X(x)            (((x) & GENMASK(14, 13)) >> 13)
+#define HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_MID(x)             (((x) << 11) & GENMASK(12, 11))
+#define HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_MID_M              GENMASK(12, 11)
+#define HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_MID_X(x)           (((x) & GENMASK(12, 11)) >> 11)
+#define HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_LP(x)              (((x) << 9) & GENMASK(10, 9))
+#define HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_LP_M               GENMASK(10, 9)
+#define HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_LP_X(x)            (((x) & GENMASK(10, 9)) >> 9)
+#define HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_OFFSET(x)          (((x) << 7) & GENMASK(8, 7))
+#define HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_OFFSET_M           GENMASK(8, 7)
+#define HSIO_S6G_IB_CFG_IB_REG_PAT_SEL_OFFSET_X(x)        (((x) & GENMASK(8, 7)) >> 7)
+#define HSIO_S6G_IB_CFG_IB_ANA_TEST_ENA                   BIT(6)
+#define HSIO_S6G_IB_CFG_IB_SIG_DET_ENA                    BIT(5)
+#define HSIO_S6G_IB_CFG_IB_CONCUR                         BIT(4)
+#define HSIO_S6G_IB_CFG_IB_CAL_ENA                        BIT(3)
+#define HSIO_S6G_IB_CFG_IB_SAM_ENA                        BIT(2)
+#define HSIO_S6G_IB_CFG_IB_EQZ_ENA                        BIT(1)
+#define HSIO_S6G_IB_CFG_IB_REG_ENA                        BIT(0)
+
+#define HSIO_S6G_IB_CFG1_IB_TJTAG(x)                      (((x) << 17) & GENMASK(21, 17))
+#define HSIO_S6G_IB_CFG1_IB_TJTAG_M                       GENMASK(21, 17)
+#define HSIO_S6G_IB_CFG1_IB_TJTAG_X(x)                    (((x) & GENMASK(21, 17)) >> 17)
+#define HSIO_S6G_IB_CFG1_IB_TSDET(x)                      (((x) << 12) & GENMASK(16, 12))
+#define HSIO_S6G_IB_CFG1_IB_TSDET_M                       GENMASK(16, 12)
+#define HSIO_S6G_IB_CFG1_IB_TSDET_X(x)                    (((x) & GENMASK(16, 12)) >> 12)
+#define HSIO_S6G_IB_CFG1_IB_SCALY(x)                      (((x) << 8) & GENMASK(11, 8))
+#define HSIO_S6G_IB_CFG1_IB_SCALY_M                       GENMASK(11, 8)
+#define HSIO_S6G_IB_CFG1_IB_SCALY_X(x)                    (((x) & GENMASK(11, 8)) >> 8)
+#define HSIO_S6G_IB_CFG1_IB_FILT_HP                       BIT(7)
+#define HSIO_S6G_IB_CFG1_IB_FILT_MID                      BIT(6)
+#define HSIO_S6G_IB_CFG1_IB_FILT_LP                       BIT(5)
+#define HSIO_S6G_IB_CFG1_IB_FILT_OFFSET                   BIT(4)
+#define HSIO_S6G_IB_CFG1_IB_FRC_HP                        BIT(3)
+#define HSIO_S6G_IB_CFG1_IB_FRC_MID                       BIT(2)
+#define HSIO_S6G_IB_CFG1_IB_FRC_LP                        BIT(1)
+#define HSIO_S6G_IB_CFG1_IB_FRC_OFFSET                    BIT(0)
+
+#define HSIO_S6G_IB_CFG2_IB_TINFV(x)                      (((x) << 27) & GENMASK(29, 27))
+#define HSIO_S6G_IB_CFG2_IB_TINFV_M                       GENMASK(29, 27)
+#define HSIO_S6G_IB_CFG2_IB_TINFV_X(x)                    (((x) & GENMASK(29, 27)) >> 27)
+#define HSIO_S6G_IB_CFG2_IB_OINFI(x)                      (((x) << 22) & GENMASK(26, 22))
+#define HSIO_S6G_IB_CFG2_IB_OINFI_M                       GENMASK(26, 22)
+#define HSIO_S6G_IB_CFG2_IB_OINFI_X(x)                    (((x) & GENMASK(26, 22)) >> 22)
+#define HSIO_S6G_IB_CFG2_IB_TAUX(x)                       (((x) << 19) & GENMASK(21, 19))
+#define HSIO_S6G_IB_CFG2_IB_TAUX_M                        GENMASK(21, 19)
+#define HSIO_S6G_IB_CFG2_IB_TAUX_X(x)                     (((x) & GENMASK(21, 19)) >> 19)
+#define HSIO_S6G_IB_CFG2_IB_OINFS(x)                      (((x) << 16) & GENMASK(18, 16))
+#define HSIO_S6G_IB_CFG2_IB_OINFS_M                       GENMASK(18, 16)
+#define HSIO_S6G_IB_CFG2_IB_OINFS_X(x)                    (((x) & GENMASK(18, 16)) >> 16)
+#define HSIO_S6G_IB_CFG2_IB_OCALS(x)                      (((x) << 10) & GENMASK(15, 10))
+#define HSIO_S6G_IB_CFG2_IB_OCALS_M                       GENMASK(15, 10)
+#define HSIO_S6G_IB_CFG2_IB_OCALS_X(x)                    (((x) & GENMASK(15, 10)) >> 10)
+#define HSIO_S6G_IB_CFG2_IB_TCALV(x)                      (((x) << 5) & GENMASK(9, 5))
+#define HSIO_S6G_IB_CFG2_IB_TCALV_M                       GENMASK(9, 5)
+#define HSIO_S6G_IB_CFG2_IB_TCALV_X(x)                    (((x) & GENMASK(9, 5)) >> 5)
+#define HSIO_S6G_IB_CFG2_IB_UMAX(x)                       (((x) << 3) & GENMASK(4, 3))
+#define HSIO_S6G_IB_CFG2_IB_UMAX_M                        GENMASK(4, 3)
+#define HSIO_S6G_IB_CFG2_IB_UMAX_X(x)                     (((x) & GENMASK(4, 3)) >> 3)
+#define HSIO_S6G_IB_CFG2_IB_UREG(x)                       ((x) & GENMASK(2, 0))
+#define HSIO_S6G_IB_CFG2_IB_UREG_M                        GENMASK(2, 0)
+
+#define HSIO_S6G_IB_CFG3_IB_INI_HP(x)                     (((x) << 18) & GENMASK(23, 18))
+#define HSIO_S6G_IB_CFG3_IB_INI_HP_M                      GENMASK(23, 18)
+#define HSIO_S6G_IB_CFG3_IB_INI_HP_X(x)                   (((x) & GENMASK(23, 18)) >> 18)
+#define HSIO_S6G_IB_CFG3_IB_INI_MID(x)                    (((x) << 12) & GENMASK(17, 12))
+#define HSIO_S6G_IB_CFG3_IB_INI_MID_M                     GENMASK(17, 12)
+#define HSIO_S6G_IB_CFG3_IB_INI_MID_X(x)                  (((x) & GENMASK(17, 12)) >> 12)
+#define HSIO_S6G_IB_CFG3_IB_INI_LP(x)                     (((x) << 6) & GENMASK(11, 6))
+#define HSIO_S6G_IB_CFG3_IB_INI_LP_M                      GENMASK(11, 6)
+#define HSIO_S6G_IB_CFG3_IB_INI_LP_X(x)                   (((x) & GENMASK(11, 6)) >> 6)
+#define HSIO_S6G_IB_CFG3_IB_INI_OFFSET(x)                 ((x) & GENMASK(5, 0))
+#define HSIO_S6G_IB_CFG3_IB_INI_OFFSET_M                  GENMASK(5, 0)
+
+#define HSIO_S6G_IB_CFG4_IB_MAX_HP(x)                     (((x) << 18) & GENMASK(23, 18))
+#define HSIO_S6G_IB_CFG4_IB_MAX_HP_M                      GENMASK(23, 18)
+#define HSIO_S6G_IB_CFG4_IB_MAX_HP_X(x)                   (((x) & GENMASK(23, 18)) >> 18)
+#define HSIO_S6G_IB_CFG4_IB_MAX_MID(x)                    (((x) << 12) & GENMASK(17, 12))
+#define HSIO_S6G_IB_CFG4_IB_MAX_MID_M                     GENMASK(17, 12)
+#define HSIO_S6G_IB_CFG4_IB_MAX_MID_X(x)                  (((x) & GENMASK(17, 12)) >> 12)
+#define HSIO_S6G_IB_CFG4_IB_MAX_LP(x)                     (((x) << 6) & GENMASK(11, 6))
+#define HSIO_S6G_IB_CFG4_IB_MAX_LP_M                      GENMASK(11, 6)
+#define HSIO_S6G_IB_CFG4_IB_MAX_LP_X(x)                   (((x) & GENMASK(11, 6)) >> 6)
+#define HSIO_S6G_IB_CFG4_IB_MAX_OFFSET(x)                 ((x) & GENMASK(5, 0))
+#define HSIO_S6G_IB_CFG4_IB_MAX_OFFSET_M                  GENMASK(5, 0)
+
+#define HSIO_S6G_IB_CFG5_IB_MIN_HP(x)                     (((x) << 18) & GENMASK(23, 18))
+#define HSIO_S6G_IB_CFG5_IB_MIN_HP_M                      GENMASK(23, 18)
+#define HSIO_S6G_IB_CFG5_IB_MIN_HP_X(x)                   (((x) & GENMASK(23, 18)) >> 18)
+#define HSIO_S6G_IB_CFG5_IB_MIN_MID(x)                    (((x) << 12) & GENMASK(17, 12))
+#define HSIO_S6G_IB_CFG5_IB_MIN_MID_M                     GENMASK(17, 12)
+#define HSIO_S6G_IB_CFG5_IB_MIN_MID_X(x)                  (((x) & GENMASK(17, 12)) >> 12)
+#define HSIO_S6G_IB_CFG5_IB_MIN_LP(x)                     (((x) << 6) & GENMASK(11, 6))
+#define HSIO_S6G_IB_CFG5_IB_MIN_LP_M                      GENMASK(11, 6)
+#define HSIO_S6G_IB_CFG5_IB_MIN_LP_X(x)                   (((x) & GENMASK(11, 6)) >> 6)
+#define HSIO_S6G_IB_CFG5_IB_MIN_OFFSET(x)                 ((x) & GENMASK(5, 0))
+#define HSIO_S6G_IB_CFG5_IB_MIN_OFFSET_M                  GENMASK(5, 0)
+
+#define HSIO_S6G_OB_CFG_OB_IDLE                           BIT(31)
+#define HSIO_S6G_OB_CFG_OB_ENA1V_MODE                     BIT(30)
+#define HSIO_S6G_OB_CFG_OB_POL                            BIT(29)
+#define HSIO_S6G_OB_CFG_OB_POST0(x)                       (((x) << 23) & GENMASK(28, 23))
+#define HSIO_S6G_OB_CFG_OB_POST0_M                        GENMASK(28, 23)
+#define HSIO_S6G_OB_CFG_OB_POST0_X(x)                     (((x) & GENMASK(28, 23)) >> 23)
+#define HSIO_S6G_OB_CFG_OB_PREC(x)                        (((x) << 18) & GENMASK(22, 18))
+#define HSIO_S6G_OB_CFG_OB_PREC_M                         GENMASK(22, 18)
+#define HSIO_S6G_OB_CFG_OB_PREC_X(x)                      (((x) & GENMASK(22, 18)) >> 18)
+#define HSIO_S6G_OB_CFG_OB_R_ADJ_MUX                      BIT(17)
+#define HSIO_S6G_OB_CFG_OB_R_ADJ_PDR                      BIT(16)
+#define HSIO_S6G_OB_CFG_OB_POST1(x)                       (((x) << 11) & GENMASK(15, 11))
+#define HSIO_S6G_OB_CFG_OB_POST1_M                        GENMASK(15, 11)
+#define HSIO_S6G_OB_CFG_OB_POST1_X(x)                     (((x) & GENMASK(15, 11)) >> 11)
+#define HSIO_S6G_OB_CFG_OB_R_COR                          BIT(10)
+#define HSIO_S6G_OB_CFG_OB_SEL_RCTRL                      BIT(9)
+#define HSIO_S6G_OB_CFG_OB_SR_H                           BIT(8)
+#define HSIO_S6G_OB_CFG_OB_SR(x)                          (((x) << 4) & GENMASK(7, 4))
+#define HSIO_S6G_OB_CFG_OB_SR_M                           GENMASK(7, 4)
+#define HSIO_S6G_OB_CFG_OB_SR_X(x)                        (((x) & GENMASK(7, 4)) >> 4)
+#define HSIO_S6G_OB_CFG_OB_RESISTOR_CTRL(x)               ((x) & GENMASK(3, 0))
+#define HSIO_S6G_OB_CFG_OB_RESISTOR_CTRL_M                GENMASK(3, 0)
+
+#define HSIO_S6G_OB_CFG1_OB_ENA_CAS(x)                    (((x) << 6) & GENMASK(8, 6))
+#define HSIO_S6G_OB_CFG1_OB_ENA_CAS_M                     GENMASK(8, 6)
+#define HSIO_S6G_OB_CFG1_OB_ENA_CAS_X(x)                  (((x) & GENMASK(8, 6)) >> 6)
+#define HSIO_S6G_OB_CFG1_OB_LEV(x)                        ((x) & GENMASK(5, 0))
+#define HSIO_S6G_OB_CFG1_OB_LEV_M                         GENMASK(5, 0)
+
+#define HSIO_S6G_SER_CFG_SER_4TAP_ENA                     BIT(8)
+#define HSIO_S6G_SER_CFG_SER_CPMD_SEL                     BIT(7)
+#define HSIO_S6G_SER_CFG_SER_SWAP_CPMD                    BIT(6)
+#define HSIO_S6G_SER_CFG_SER_ALISEL(x)                    (((x) << 4) & GENMASK(5, 4))
+#define HSIO_S6G_SER_CFG_SER_ALISEL_M                     GENMASK(5, 4)
+#define HSIO_S6G_SER_CFG_SER_ALISEL_X(x)                  (((x) & GENMASK(5, 4)) >> 4)
+#define HSIO_S6G_SER_CFG_SER_ENHYS                        BIT(3)
+#define HSIO_S6G_SER_CFG_SER_BIG_WIN                      BIT(2)
+#define HSIO_S6G_SER_CFG_SER_EN_WIN                       BIT(1)
+#define HSIO_S6G_SER_CFG_SER_ENALI                        BIT(0)
+
+#define HSIO_S6G_COMMON_CFG_SYS_RST                       BIT(17)
+#define HSIO_S6G_COMMON_CFG_SE_DIV2_ENA                   BIT(16)
+#define HSIO_S6G_COMMON_CFG_SE_AUTO_SQUELCH_ENA           BIT(15)
+#define HSIO_S6G_COMMON_CFG_ENA_LANE                      BIT(14)
+#define HSIO_S6G_COMMON_CFG_PWD_RX                        BIT(13)
+#define HSIO_S6G_COMMON_CFG_PWD_TX                        BIT(12)
+#define HSIO_S6G_COMMON_CFG_LANE_CTRL(x)                  (((x) << 9) & GENMASK(11, 9))
+#define HSIO_S6G_COMMON_CFG_LANE_CTRL_M                   GENMASK(11, 9)
+#define HSIO_S6G_COMMON_CFG_LANE_CTRL_X(x)                (((x) & GENMASK(11, 9)) >> 9)
+#define HSIO_S6G_COMMON_CFG_ENA_DIRECT                    BIT(8)
+#define HSIO_S6G_COMMON_CFG_ENA_ELOOP                     BIT(7)
+#define HSIO_S6G_COMMON_CFG_ENA_FLOOP                     BIT(6)
+#define HSIO_S6G_COMMON_CFG_ENA_ILOOP                     BIT(5)
+#define HSIO_S6G_COMMON_CFG_ENA_PLOOP                     BIT(4)
+#define HSIO_S6G_COMMON_CFG_HRATE                         BIT(3)
+#define HSIO_S6G_COMMON_CFG_QRATE                         BIT(2)
+#define HSIO_S6G_COMMON_CFG_IF_MODE(x)                    ((x) & GENMASK(1, 0))
+#define HSIO_S6G_COMMON_CFG_IF_MODE_M                     GENMASK(1, 0)
+
+#define HSIO_S6G_PLL_CFG_PLL_ENA_OFFS(x)                  (((x) << 16) & GENMASK(17, 16))
+#define HSIO_S6G_PLL_CFG_PLL_ENA_OFFS_M                   GENMASK(17, 16)
+#define HSIO_S6G_PLL_CFG_PLL_ENA_OFFS_X(x)                (((x) & GENMASK(17, 16)) >> 16)
+#define HSIO_S6G_PLL_CFG_PLL_DIV4                         BIT(15)
+#define HSIO_S6G_PLL_CFG_PLL_ENA_ROT                      BIT(14)
+#define HSIO_S6G_PLL_CFG_PLL_FSM_CTRL_DATA(x)             (((x) << 6) & GENMASK(13, 6))
+#define HSIO_S6G_PLL_CFG_PLL_FSM_CTRL_DATA_M              GENMASK(13, 6)
+#define HSIO_S6G_PLL_CFG_PLL_FSM_CTRL_DATA_X(x)           (((x) & GENMASK(13, 6)) >> 6)
+#define HSIO_S6G_PLL_CFG_PLL_FSM_ENA                      BIT(5)
+#define HSIO_S6G_PLL_CFG_PLL_FSM_FORCE_SET_ENA            BIT(4)
+#define HSIO_S6G_PLL_CFG_PLL_FSM_OOR_RECAL_ENA            BIT(3)
+#define HSIO_S6G_PLL_CFG_PLL_RB_DATA_SEL                  BIT(2)
+#define HSIO_S6G_PLL_CFG_PLL_ROT_DIR                      BIT(1)
+#define HSIO_S6G_PLL_CFG_PLL_ROT_FRQ                      BIT(0)
+
+#define HSIO_S6G_ACJTAG_CFG_ACJTAG_INIT_DATA_N            BIT(5)
+#define HSIO_S6G_ACJTAG_CFG_ACJTAG_INIT_DATA_P            BIT(4)
+#define HSIO_S6G_ACJTAG_CFG_ACJTAG_INIT_CLK               BIT(3)
+#define HSIO_S6G_ACJTAG_CFG_OB_DIRECT                     BIT(2)
+#define HSIO_S6G_ACJTAG_CFG_ACJTAG_ENA                    BIT(1)
+#define HSIO_S6G_ACJTAG_CFG_JTAG_CTRL_ENA                 BIT(0)
+
+#define HSIO_S6G_GP_CFG_GP_MSB(x)                         (((x) << 16) & GENMASK(31, 16))
+#define HSIO_S6G_GP_CFG_GP_MSB_M                          GENMASK(31, 16)
+#define HSIO_S6G_GP_CFG_GP_MSB_X(x)                       (((x) & GENMASK(31, 16)) >> 16)
+#define HSIO_S6G_GP_CFG_GP_LSB(x)                         ((x) & GENMASK(15, 0))
+#define HSIO_S6G_GP_CFG_GP_LSB_M                          GENMASK(15, 0)
+
+#define HSIO_S6G_IB_STATUS0_IB_CAL_DONE                   BIT(8)
+#define HSIO_S6G_IB_STATUS0_IB_HP_GAIN_ACT                BIT(7)
+#define HSIO_S6G_IB_STATUS0_IB_MID_GAIN_ACT               BIT(6)
+#define HSIO_S6G_IB_STATUS0_IB_LP_GAIN_ACT                BIT(5)
+#define HSIO_S6G_IB_STATUS0_IB_OFFSET_ACT                 BIT(4)
+#define HSIO_S6G_IB_STATUS0_IB_OFFSET_VLD                 BIT(3)
+#define HSIO_S6G_IB_STATUS0_IB_OFFSET_ERR                 BIT(2)
+#define HSIO_S6G_IB_STATUS0_IB_OFFSDIR                    BIT(1)
+#define HSIO_S6G_IB_STATUS0_IB_SIG_DET                    BIT(0)
+
+#define HSIO_S6G_IB_STATUS1_IB_HP_GAIN_STAT(x)            (((x) << 18) & GENMASK(23, 18))
+#define HSIO_S6G_IB_STATUS1_IB_HP_GAIN_STAT_M             GENMASK(23, 18)
+#define HSIO_S6G_IB_STATUS1_IB_HP_GAIN_STAT_X(x)          (((x) & GENMASK(23, 18)) >> 18)
+#define HSIO_S6G_IB_STATUS1_IB_MID_GAIN_STAT(x)           (((x) << 12) & GENMASK(17, 12))
+#define HSIO_S6G_IB_STATUS1_IB_MID_GAIN_STAT_M            GENMASK(17, 12)
+#define HSIO_S6G_IB_STATUS1_IB_MID_GAIN_STAT_X(x)         (((x) & GENMASK(17, 12)) >> 12)
+#define HSIO_S6G_IB_STATUS1_IB_LP_GAIN_STAT(x)            (((x) << 6) & GENMASK(11, 6))
+#define HSIO_S6G_IB_STATUS1_IB_LP_GAIN_STAT_M             GENMASK(11, 6)
+#define HSIO_S6G_IB_STATUS1_IB_LP_GAIN_STAT_X(x)          (((x) & GENMASK(11, 6)) >> 6)
+#define HSIO_S6G_IB_STATUS1_IB_OFFSET_STAT(x)             ((x) & GENMASK(5, 0))
+#define HSIO_S6G_IB_STATUS1_IB_OFFSET_STAT_M              GENMASK(5, 0)
+
+#define HSIO_S6G_ACJTAG_STATUS_ACJTAG_CAPT_DATA_N         BIT(2)
+#define HSIO_S6G_ACJTAG_STATUS_ACJTAG_CAPT_DATA_P         BIT(1)
+#define HSIO_S6G_ACJTAG_STATUS_IB_DIRECT                  BIT(0)
+
+#define HSIO_S6G_PLL_STATUS_PLL_CAL_NOT_DONE              BIT(10)
+#define HSIO_S6G_PLL_STATUS_PLL_CAL_ERR                   BIT(9)
+#define HSIO_S6G_PLL_STATUS_PLL_OUT_OF_RANGE_ERR          BIT(8)
+#define HSIO_S6G_PLL_STATUS_PLL_RB_DATA(x)                ((x) & GENMASK(7, 0))
+#define HSIO_S6G_PLL_STATUS_PLL_RB_DATA_M                 GENMASK(7, 0)
+
+#define HSIO_S6G_REVID_SERDES_REV(x)                      (((x) << 26) & GENMASK(31, 26))
+#define HSIO_S6G_REVID_SERDES_REV_M                       GENMASK(31, 26)
+#define HSIO_S6G_REVID_SERDES_REV_X(x)                    (((x) & GENMASK(31, 26)) >> 26)
+#define HSIO_S6G_REVID_RCPLL_REV(x)                       (((x) << 21) & GENMASK(25, 21))
+#define HSIO_S6G_REVID_RCPLL_REV_M                        GENMASK(25, 21)
+#define HSIO_S6G_REVID_RCPLL_REV_X(x)                     (((x) & GENMASK(25, 21)) >> 21)
+#define HSIO_S6G_REVID_SER_REV(x)                         (((x) << 16) & GENMASK(20, 16))
+#define HSIO_S6G_REVID_SER_REV_M                          GENMASK(20, 16)
+#define HSIO_S6G_REVID_SER_REV_X(x)                       (((x) & GENMASK(20, 16)) >> 16)
+#define HSIO_S6G_REVID_DES_REV(x)                         (((x) << 10) & GENMASK(15, 10))
+#define HSIO_S6G_REVID_DES_REV_M                          GENMASK(15, 10)
+#define HSIO_S6G_REVID_DES_REV_X(x)                       (((x) & GENMASK(15, 10)) >> 10)
+#define HSIO_S6G_REVID_OB_REV(x)                          (((x) << 5) & GENMASK(9, 5))
+#define HSIO_S6G_REVID_OB_REV_M                           GENMASK(9, 5)
+#define HSIO_S6G_REVID_OB_REV_X(x)                        (((x) & GENMASK(9, 5)) >> 5)
+#define HSIO_S6G_REVID_IB_REV(x)                          ((x) & GENMASK(4, 0))
+#define HSIO_S6G_REVID_IB_REV_M                           GENMASK(4, 0)
+
+#define HSIO_MCB_S6G_ADDR_CFG_SERDES6G_WR_ONE_SHOT        BIT(31)
+#define HSIO_MCB_S6G_ADDR_CFG_SERDES6G_RD_ONE_SHOT        BIT(30)
+#define HSIO_MCB_S6G_ADDR_CFG_SERDES6G_ADDR(x)            ((x) & GENMASK(24, 0))
+#define HSIO_MCB_S6G_ADDR_CFG_SERDES6G_ADDR_M             GENMASK(24, 0)
+
+#define HSIO_HW_CFG_DEV2G5_10_MODE                        BIT(6)
+#define HSIO_HW_CFG_DEV1G_9_MODE                          BIT(5)
+#define HSIO_HW_CFG_DEV1G_6_MODE                          BIT(4)
+#define HSIO_HW_CFG_DEV1G_5_MODE                          BIT(3)
+#define HSIO_HW_CFG_DEV1G_4_MODE                          BIT(2)
+#define HSIO_HW_CFG_PCIE_ENA                              BIT(1)
+#define HSIO_HW_CFG_QSGMII_ENA                            BIT(0)
+
+#define HSIO_HW_QSGMII_CFG_SHYST_DIS                      BIT(3)
+#define HSIO_HW_QSGMII_CFG_E_DET_ENA                      BIT(2)
+#define HSIO_HW_QSGMII_CFG_USE_I1_ENA                     BIT(1)
+#define HSIO_HW_QSGMII_CFG_FLIP_LANES                     BIT(0)
+
+#define HSIO_HW_QSGMII_STAT_DELAY_VAR_X200PS(x)           (((x) << 1) & GENMASK(6, 1))
+#define HSIO_HW_QSGMII_STAT_DELAY_VAR_X200PS_M            GENMASK(6, 1)
+#define HSIO_HW_QSGMII_STAT_DELAY_VAR_X200PS_X(x)         (((x) & GENMASK(6, 1)) >> 1)
+#define HSIO_HW_QSGMII_STAT_SYNC                          BIT(0)
+
+#define HSIO_CLK_CFG_CLKDIV_PHY(x)                        (((x) << 1) & GENMASK(8, 1))
+#define HSIO_CLK_CFG_CLKDIV_PHY_M                         GENMASK(8, 1)
+#define HSIO_CLK_CFG_CLKDIV_PHY_X(x)                      (((x) & GENMASK(8, 1)) >> 1)
+#define HSIO_CLK_CFG_CLKDIV_PHY_DIS                       BIT(0)
+
+#define HSIO_TEMP_SENSOR_CTRL_FORCE_TEMP_RD               BIT(5)
+#define HSIO_TEMP_SENSOR_CTRL_FORCE_RUN                   BIT(4)
+#define HSIO_TEMP_SENSOR_CTRL_FORCE_NO_RST                BIT(3)
+#define HSIO_TEMP_SENSOR_CTRL_FORCE_POWER_UP              BIT(2)
+#define HSIO_TEMP_SENSOR_CTRL_FORCE_CLK                   BIT(1)
+#define HSIO_TEMP_SENSOR_CTRL_SAMPLE_ENA                  BIT(0)
+
+#define HSIO_TEMP_SENSOR_CFG_RUN_WID(x)                   (((x) << 8) & GENMASK(15, 8))
+#define HSIO_TEMP_SENSOR_CFG_RUN_WID_M                    GENMASK(15, 8)
+#define HSIO_TEMP_SENSOR_CFG_RUN_WID_X(x)                 (((x) & GENMASK(15, 8)) >> 8)
+#define HSIO_TEMP_SENSOR_CFG_SAMPLE_PER(x)                ((x) & GENMASK(7, 0))
+#define HSIO_TEMP_SENSOR_CFG_SAMPLE_PER_M                 GENMASK(7, 0)
+
+#define HSIO_TEMP_SENSOR_STAT_TEMP_VALID                  BIT(8)
+#define HSIO_TEMP_SENSOR_STAT_TEMP(x)                     ((x) & GENMASK(7, 0))
+#define HSIO_TEMP_SENSOR_STAT_TEMP_M                      GENMASK(7, 0)
+
+#endif
diff --git a/drivers/net/ethernet/mscc/ocelot_io.c b/drivers/net/ethernet/mscc/ocelot_io.c
new file mode 100644
index 000000000000..c6db8ad31fdf
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot_io.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include "ocelot.h"
+
+u32 __ocelot_read_ix(struct ocelot *ocelot, u32 reg, u32 offset)
+{
+	u16 target = reg >> TARGET_OFFSET;
+	u32 val;
+
+	WARN_ON(!target);
+
+	regmap_read(ocelot->targets[target],
+		    ocelot->map[target][reg & REG_MASK] + offset, &val);
+	return val;
+}
+EXPORT_SYMBOL(__ocelot_read_ix);
+
+void __ocelot_write_ix(struct ocelot *ocelot, u32 val, u32 reg, u32 offset)
+{
+	u16 target = reg >> TARGET_OFFSET;
+
+	WARN_ON(!target);
+
+	regmap_write(ocelot->targets[target],
+		     ocelot->map[target][reg & REG_MASK] + offset, val);
+}
+EXPORT_SYMBOL(__ocelot_write_ix);
+
+void __ocelot_rmw_ix(struct ocelot *ocelot, u32 val, u32 mask, u32 reg,
+		     u32 offset)
+{
+	u16 target = reg >> TARGET_OFFSET;
+
+	WARN_ON(!target);
+
+	regmap_update_bits(ocelot->targets[target],
+			   ocelot->map[target][reg & REG_MASK] + offset,
+			   mask, val);
+}
+EXPORT_SYMBOL(__ocelot_rmw_ix);
+
+u32 ocelot_port_readl(struct ocelot_port *port, u32 reg)
+{
+	return readl(port->regs + reg);
+}
+EXPORT_SYMBOL(ocelot_port_readl);
+
+void ocelot_port_writel(struct ocelot_port *port, u32 val, u32 reg)
+{
+	writel(val, port->regs + reg);
+}
+EXPORT_SYMBOL(ocelot_port_writel);
+
+int ocelot_regfields_init(struct ocelot *ocelot,
+			  const struct reg_field *const regfields)
+{
+	unsigned int i;
+	u16 target;
+
+	for (i = 0; i < REGFIELD_MAX; i++) {
+		struct reg_field regfield = {};
+		u32 reg = regfields[i].reg;
+
+		if (!reg)
+			continue;
+
+		target = regfields[i].reg >> TARGET_OFFSET;
+
+		regfield.reg = ocelot->map[target][reg & REG_MASK];
+		regfield.lsb = regfields[i].lsb;
+		regfield.msb = regfields[i].msb;
+
+		ocelot->regfields[i] =
+		devm_regmap_field_alloc(ocelot->dev,
+					ocelot->targets[target],
+					regfield);
+
+		if (IS_ERR(ocelot->regfields[i]))
+			return PTR_ERR(ocelot->regfields[i]);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(ocelot_regfields_init);
+
+static struct regmap_config ocelot_regmap_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+};
+
+struct regmap *ocelot_io_platform_init(struct ocelot *ocelot,
+				       struct platform_device *pdev,
+				       const char *name)
+{
+	struct resource *res;
+	void __iomem *regs;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
+	regs = devm_ioremap_resource(ocelot->dev, res);
+	if (IS_ERR(regs))
+		return ERR_CAST(regs);
+
+	ocelot_regmap_config.name = name;
+	return devm_regmap_init_mmio(ocelot->dev, regs,
+				     &ocelot_regmap_config);
+}
+EXPORT_SYMBOL(ocelot_io_platform_init);
diff --git a/drivers/net/ethernet/mscc/ocelot_qs.h b/drivers/net/ethernet/mscc/ocelot_qs.h
new file mode 100644
index 000000000000..d18ae726c01d
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot_qs.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+
+#ifndef _MSCC_OCELOT_QS_H_
+#define _MSCC_OCELOT_QS_H_
+
+/* TODO handle BE */
+#define XTR_EOF_0          0x00000080U
+#define XTR_EOF_1          0x01000080U
+#define XTR_EOF_2          0x02000080U
+#define XTR_EOF_3          0x03000080U
+#define XTR_PRUNED         0x04000080U
+#define XTR_ABORT          0x05000080U
+#define XTR_ESCAPE         0x06000080U
+#define XTR_NOT_READY      0x07000080U
+#define XTR_VALID_BYTES(x) (4 - (((x) >> 24) & 3))
+
+#define QS_XTR_GRP_CFG_RSZ                                0x4
+
+#define QS_XTR_GRP_CFG_MODE(x)                            (((x) << 2) & GENMASK(3, 2))
+#define QS_XTR_GRP_CFG_MODE_M                             GENMASK(3, 2)
+#define QS_XTR_GRP_CFG_MODE_X(x)                          (((x) & GENMASK(3, 2)) >> 2)
+#define QS_XTR_GRP_CFG_STATUS_WORD_POS                    BIT(1)
+#define QS_XTR_GRP_CFG_BYTE_SWAP                          BIT(0)
+
+#define QS_XTR_RD_RSZ                                     0x4
+
+#define QS_XTR_FRM_PRUNING_RSZ                            0x4
+
+#define QS_XTR_CFG_DP_WM(x)                               (((x) << 5) & GENMASK(7, 5))
+#define QS_XTR_CFG_DP_WM_M                                GENMASK(7, 5)
+#define QS_XTR_CFG_DP_WM_X(x)                             (((x) & GENMASK(7, 5)) >> 5)
+#define QS_XTR_CFG_SCH_WM(x)                              (((x) << 2) & GENMASK(4, 2))
+#define QS_XTR_CFG_SCH_WM_M                               GENMASK(4, 2)
+#define QS_XTR_CFG_SCH_WM_X(x)                            (((x) & GENMASK(4, 2)) >> 2)
+#define QS_XTR_CFG_OFLW_ERR_STICKY(x)                     ((x) & GENMASK(1, 0))
+#define QS_XTR_CFG_OFLW_ERR_STICKY_M                      GENMASK(1, 0)
+
+#define QS_INJ_GRP_CFG_RSZ                                0x4
+
+#define QS_INJ_GRP_CFG_MODE(x)                            (((x) << 2) & GENMASK(3, 2))
+#define QS_INJ_GRP_CFG_MODE_M                             GENMASK(3, 2)
+#define QS_INJ_GRP_CFG_MODE_X(x)                          (((x) & GENMASK(3, 2)) >> 2)
+#define QS_INJ_GRP_CFG_BYTE_SWAP                          BIT(0)
+
+#define QS_INJ_WR_RSZ                                     0x4
+
+#define QS_INJ_CTRL_RSZ                                   0x4
+
+#define QS_INJ_CTRL_GAP_SIZE(x)                           (((x) << 21) & GENMASK(24, 21))
+#define QS_INJ_CTRL_GAP_SIZE_M                            GENMASK(24, 21)
+#define QS_INJ_CTRL_GAP_SIZE_X(x)                         (((x) & GENMASK(24, 21)) >> 21)
+#define QS_INJ_CTRL_ABORT                                 BIT(20)
+#define QS_INJ_CTRL_EOF                                   BIT(19)
+#define QS_INJ_CTRL_SOF                                   BIT(18)
+#define QS_INJ_CTRL_VLD_BYTES(x)                          (((x) << 16) & GENMASK(17, 16))
+#define QS_INJ_CTRL_VLD_BYTES_M                           GENMASK(17, 16)
+#define QS_INJ_CTRL_VLD_BYTES_X(x)                        (((x) & GENMASK(17, 16)) >> 16)
+
+#define QS_INJ_STATUS_WMARK_REACHED(x)                    (((x) << 4) & GENMASK(5, 4))
+#define QS_INJ_STATUS_WMARK_REACHED_M                     GENMASK(5, 4)
+#define QS_INJ_STATUS_WMARK_REACHED_X(x)                  (((x) & GENMASK(5, 4)) >> 4)
+#define QS_INJ_STATUS_FIFO_RDY(x)                         (((x) << 2) & GENMASK(3, 2))
+#define QS_INJ_STATUS_FIFO_RDY_M                          GENMASK(3, 2)
+#define QS_INJ_STATUS_FIFO_RDY_X(x)                       (((x) & GENMASK(3, 2)) >> 2)
+#define QS_INJ_STATUS_INJ_IN_PROGRESS(x)                  ((x) & GENMASK(1, 0))
+#define QS_INJ_STATUS_INJ_IN_PROGRESS_M                   GENMASK(1, 0)
+
+#define QS_INJ_ERR_RSZ                                    0x4
+
+#define QS_INJ_ERR_ABORT_ERR_STICKY                       BIT(1)
+#define QS_INJ_ERR_WR_ERR_STICKY                          BIT(0)
+
+#endif
diff --git a/drivers/net/ethernet/mscc/ocelot_qsys.h b/drivers/net/ethernet/mscc/ocelot_qsys.h
new file mode 100644
index 000000000000..aa7267d5ca77
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot_qsys.h
@@ -0,0 +1,270 @@
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * License: Dual MIT/GPL
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+
+#ifndef _MSCC_OCELOT_QSYS_H_
+#define _MSCC_OCELOT_QSYS_H_
+
+#define QSYS_PORT_MODE_RSZ                                0x4
+
+#define QSYS_PORT_MODE_DEQUEUE_DIS                        BIT(1)
+#define QSYS_PORT_MODE_DEQUEUE_LATE                       BIT(0)
+
+#define QSYS_SWITCH_PORT_MODE_RSZ                         0x4
+
+#define QSYS_SWITCH_PORT_MODE_PORT_ENA                    BIT(14)
+#define QSYS_SWITCH_PORT_MODE_SCH_NEXT_CFG(x)             (((x) << 11) & GENMASK(13, 11))
+#define QSYS_SWITCH_PORT_MODE_SCH_NEXT_CFG_M              GENMASK(13, 11)
+#define QSYS_SWITCH_PORT_MODE_SCH_NEXT_CFG_X(x)           (((x) & GENMASK(13, 11)) >> 11)
+#define QSYS_SWITCH_PORT_MODE_YEL_RSRVD                   BIT(10)
+#define QSYS_SWITCH_PORT_MODE_INGRESS_DROP_MODE           BIT(9)
+#define QSYS_SWITCH_PORT_MODE_TX_PFC_ENA(x)               (((x) << 1) & GENMASK(8, 1))
+#define QSYS_SWITCH_PORT_MODE_TX_PFC_ENA_M                GENMASK(8, 1)
+#define QSYS_SWITCH_PORT_MODE_TX_PFC_ENA_X(x)             (((x) & GENMASK(8, 1)) >> 1)
+#define QSYS_SWITCH_PORT_MODE_TX_PFC_MODE                 BIT(0)
+
+#define QSYS_STAT_CNT_CFG_TX_GREEN_CNT_MODE               BIT(5)
+#define QSYS_STAT_CNT_CFG_TX_YELLOW_CNT_MODE              BIT(4)
+#define QSYS_STAT_CNT_CFG_DROP_GREEN_CNT_MODE             BIT(3)
+#define QSYS_STAT_CNT_CFG_DROP_YELLOW_CNT_MODE            BIT(2)
+#define QSYS_STAT_CNT_CFG_DROP_COUNT_ONCE                 BIT(1)
+#define QSYS_STAT_CNT_CFG_DROP_COUNT_EGRESS               BIT(0)
+
+#define QSYS_EEE_CFG_RSZ                                  0x4
+
+#define QSYS_EEE_THRES_EEE_HIGH_BYTES(x)                  (((x) << 8) & GENMASK(15, 8))
+#define QSYS_EEE_THRES_EEE_HIGH_BYTES_M                   GENMASK(15, 8)
+#define QSYS_EEE_THRES_EEE_HIGH_BYTES_X(x)                (((x) & GENMASK(15, 8)) >> 8)
+#define QSYS_EEE_THRES_EEE_HIGH_FRAMES(x)                 ((x) & GENMASK(7, 0))
+#define QSYS_EEE_THRES_EEE_HIGH_FRAMES_M                  GENMASK(7, 0)
+
+#define QSYS_SW_STATUS_RSZ                                0x4
+
+#define QSYS_EXT_CPU_CFG_EXT_CPU_PORT(x)                  (((x) << 8) & GENMASK(12, 8))
+#define QSYS_EXT_CPU_CFG_EXT_CPU_PORT_M                   GENMASK(12, 8)
+#define QSYS_EXT_CPU_CFG_EXT_CPU_PORT_X(x)                (((x) & GENMASK(12, 8)) >> 8)
+#define QSYS_EXT_CPU_CFG_EXT_CPUQ_MSK(x)                  ((x) & GENMASK(7, 0))
+#define QSYS_EXT_CPU_CFG_EXT_CPUQ_MSK_M                   GENMASK(7, 0)
+
+#define QSYS_QMAP_GSZ                                     0x4
+
+#define QSYS_QMAP_SE_BASE(x)                              (((x) << 5) & GENMASK(12, 5))
+#define QSYS_QMAP_SE_BASE_M                               GENMASK(12, 5)
+#define QSYS_QMAP_SE_BASE_X(x)                            (((x) & GENMASK(12, 5)) >> 5)
+#define QSYS_QMAP_SE_IDX_SEL(x)                           (((x) << 2) & GENMASK(4, 2))
+#define QSYS_QMAP_SE_IDX_SEL_M                            GENMASK(4, 2)
+#define QSYS_QMAP_SE_IDX_SEL_X(x)                         (((x) & GENMASK(4, 2)) >> 2)
+#define QSYS_QMAP_SE_INP_SEL(x)                           ((x) & GENMASK(1, 0))
+#define QSYS_QMAP_SE_INP_SEL_M                            GENMASK(1, 0)
+
+#define QSYS_ISDX_SGRP_GSZ                                0x4
+
+#define QSYS_TIMED_FRAME_ENTRY_GSZ                        0x4
+
+#define QSYS_TFRM_MISC_TIMED_CANCEL_SLOT(x)               (((x) << 9) & GENMASK(18, 9))
+#define QSYS_TFRM_MISC_TIMED_CANCEL_SLOT_M                GENMASK(18, 9)
+#define QSYS_TFRM_MISC_TIMED_CANCEL_SLOT_X(x)             (((x) & GENMASK(18, 9)) >> 9)
+#define QSYS_TFRM_MISC_TIMED_CANCEL_1SHOT                 BIT(8)
+#define QSYS_TFRM_MISC_TIMED_SLOT_MODE_MC                 BIT(7)
+#define QSYS_TFRM_MISC_TIMED_ENTRY_FAST_CNT(x)            ((x) & GENMASK(6, 0))
+#define QSYS_TFRM_MISC_TIMED_ENTRY_FAST_CNT_M             GENMASK(6, 0)
+
+#define QSYS_RED_PROFILE_RSZ                              0x4
+
+#define QSYS_RED_PROFILE_WM_RED_LOW(x)                    (((x) << 8) & GENMASK(15, 8))
+#define QSYS_RED_PROFILE_WM_RED_LOW_M                     GENMASK(15, 8)
+#define QSYS_RED_PROFILE_WM_RED_LOW_X(x)                  (((x) & GENMASK(15, 8)) >> 8)
+#define QSYS_RED_PROFILE_WM_RED_HIGH(x)                   ((x) & GENMASK(7, 0))
+#define QSYS_RED_PROFILE_WM_RED_HIGH_M                    GENMASK(7, 0)
+
+#define QSYS_RES_CFG_GSZ                                  0x8
+
+#define QSYS_RES_STAT_GSZ                                 0x8
+
+#define QSYS_RES_STAT_INUSE(x)                            (((x) << 12) & GENMASK(23, 12))
+#define QSYS_RES_STAT_INUSE_M                             GENMASK(23, 12)
+#define QSYS_RES_STAT_INUSE_X(x)                          (((x) & GENMASK(23, 12)) >> 12)
+#define QSYS_RES_STAT_MAXUSE(x)                           ((x) & GENMASK(11, 0))
+#define QSYS_RES_STAT_MAXUSE_M                            GENMASK(11, 0)
+
+#define QSYS_EVENTS_CORE_EV_FDC(x)                        (((x) << 2) & GENMASK(4, 2))
+#define QSYS_EVENTS_CORE_EV_FDC_M                         GENMASK(4, 2)
+#define QSYS_EVENTS_CORE_EV_FDC_X(x)                      (((x) & GENMASK(4, 2)) >> 2)
+#define QSYS_EVENTS_CORE_EV_FRD(x)                        ((x) & GENMASK(1, 0))
+#define QSYS_EVENTS_CORE_EV_FRD_M                         GENMASK(1, 0)
+
+#define QSYS_QMAXSDU_CFG_0_RSZ                            0x4
+
+#define QSYS_QMAXSDU_CFG_1_RSZ                            0x4
+
+#define QSYS_QMAXSDU_CFG_2_RSZ                            0x4
+
+#define QSYS_QMAXSDU_CFG_3_RSZ                            0x4
+
+#define QSYS_QMAXSDU_CFG_4_RSZ                            0x4
+
+#define QSYS_QMAXSDU_CFG_5_RSZ                            0x4
+
+#define QSYS_QMAXSDU_CFG_6_RSZ                            0x4
+
+#define QSYS_QMAXSDU_CFG_7_RSZ                            0x4
+
+#define QSYS_PREEMPTION_CFG_RSZ                           0x4
+
+#define QSYS_PREEMPTION_CFG_P_QUEUES(x)                   ((x) & GENMASK(7, 0))
+#define QSYS_PREEMPTION_CFG_P_QUEUES_M                    GENMASK(7, 0)
+#define QSYS_PREEMPTION_CFG_MM_ADD_FRAG_SIZE(x)           (((x) << 8) & GENMASK(9, 8))
+#define QSYS_PREEMPTION_CFG_MM_ADD_FRAG_SIZE_M            GENMASK(9, 8)
+#define QSYS_PREEMPTION_CFG_MM_ADD_FRAG_SIZE_X(x)         (((x) & GENMASK(9, 8)) >> 8)
+#define QSYS_PREEMPTION_CFG_STRICT_IPG(x)                 (((x) << 12) & GENMASK(13, 12))
+#define QSYS_PREEMPTION_CFG_STRICT_IPG_M                  GENMASK(13, 12)
+#define QSYS_PREEMPTION_CFG_STRICT_IPG_X(x)               (((x) & GENMASK(13, 12)) >> 12)
+#define QSYS_PREEMPTION_CFG_HOLD_ADVANCE(x)               (((x) << 16) & GENMASK(31, 16))
+#define QSYS_PREEMPTION_CFG_HOLD_ADVANCE_M                GENMASK(31, 16)
+#define QSYS_PREEMPTION_CFG_HOLD_ADVANCE_X(x)             (((x) & GENMASK(31, 16)) >> 16)
+
+#define QSYS_CIR_CFG_GSZ                                  0x80
+
+#define QSYS_CIR_CFG_CIR_RATE(x)                          (((x) << 6) & GENMASK(20, 6))
+#define QSYS_CIR_CFG_CIR_RATE_M                           GENMASK(20, 6)
+#define QSYS_CIR_CFG_CIR_RATE_X(x)                        (((x) & GENMASK(20, 6)) >> 6)
+#define QSYS_CIR_CFG_CIR_BURST(x)                         ((x) & GENMASK(5, 0))
+#define QSYS_CIR_CFG_CIR_BURST_M                          GENMASK(5, 0)
+
+#define QSYS_EIR_CFG_GSZ                                  0x80
+
+#define QSYS_EIR_CFG_EIR_RATE(x)                          (((x) << 7) & GENMASK(21, 7))
+#define QSYS_EIR_CFG_EIR_RATE_M                           GENMASK(21, 7)
+#define QSYS_EIR_CFG_EIR_RATE_X(x)                        (((x) & GENMASK(21, 7)) >> 7)
+#define QSYS_EIR_CFG_EIR_BURST(x)                         (((x) << 1) & GENMASK(6, 1))
+#define QSYS_EIR_CFG_EIR_BURST_M                          GENMASK(6, 1)
+#define QSYS_EIR_CFG_EIR_BURST_X(x)                       (((x) & GENMASK(6, 1)) >> 1)
+#define QSYS_EIR_CFG_EIR_MARK_ENA                         BIT(0)
+
+#define QSYS_SE_CFG_GSZ                                   0x80
+
+#define QSYS_SE_CFG_SE_DWRR_CNT(x)                        (((x) << 6) & GENMASK(9, 6))
+#define QSYS_SE_CFG_SE_DWRR_CNT_M                         GENMASK(9, 6)
+#define QSYS_SE_CFG_SE_DWRR_CNT_X(x)                      (((x) & GENMASK(9, 6)) >> 6)
+#define QSYS_SE_CFG_SE_RR_ENA                             BIT(5)
+#define QSYS_SE_CFG_SE_AVB_ENA                            BIT(4)
+#define QSYS_SE_CFG_SE_FRM_MODE(x)                        (((x) << 2) & GENMASK(3, 2))
+#define QSYS_SE_CFG_SE_FRM_MODE_M                         GENMASK(3, 2)
+#define QSYS_SE_CFG_SE_FRM_MODE_X(x)                      (((x) & GENMASK(3, 2)) >> 2)
+#define QSYS_SE_CFG_SE_EXC_ENA                            BIT(1)
+#define QSYS_SE_CFG_SE_EXC_FWD                            BIT(0)
+
+#define QSYS_SE_DWRR_CFG_GSZ                              0x80
+#define QSYS_SE_DWRR_CFG_RSZ                              0x4
+
+#define QSYS_SE_CONNECT_GSZ                               0x80
+
+#define QSYS_SE_CONNECT_SE_OUTP_IDX(x)                    (((x) << 17) & GENMASK(24, 17))
+#define QSYS_SE_CONNECT_SE_OUTP_IDX_M                     GENMASK(24, 17)
+#define QSYS_SE_CONNECT_SE_OUTP_IDX_X(x)                  (((x) & GENMASK(24, 17)) >> 17)
+#define QSYS_SE_CONNECT_SE_INP_IDX(x)                     (((x) << 9) & GENMASK(16, 9))
+#define QSYS_SE_CONNECT_SE_INP_IDX_M                      GENMASK(16, 9)
+#define QSYS_SE_CONNECT_SE_INP_IDX_X(x)                   (((x) & GENMASK(16, 9)) >> 9)
+#define QSYS_SE_CONNECT_SE_OUTP_CON(x)                    (((x) << 5) & GENMASK(8, 5))
+#define QSYS_SE_CONNECT_SE_OUTP_CON_M                     GENMASK(8, 5)
+#define QSYS_SE_CONNECT_SE_OUTP_CON_X(x)                  (((x) & GENMASK(8, 5)) >> 5)
+#define QSYS_SE_CONNECT_SE_INP_CNT(x)                     (((x) << 1) & GENMASK(4, 1))
+#define QSYS_SE_CONNECT_SE_INP_CNT_M                      GENMASK(4, 1)
+#define QSYS_SE_CONNECT_SE_INP_CNT_X(x)                   (((x) & GENMASK(4, 1)) >> 1)
+#define QSYS_SE_CONNECT_SE_TERMINAL                       BIT(0)
+
+#define QSYS_SE_DLB_SENSE_GSZ                             0x80
+
+#define QSYS_SE_DLB_SENSE_SE_DLB_PRIO(x)                  (((x) << 11) & GENMASK(13, 11))
+#define QSYS_SE_DLB_SENSE_SE_DLB_PRIO_M                   GENMASK(13, 11)
+#define QSYS_SE_DLB_SENSE_SE_DLB_PRIO_X(x)                (((x) & GENMASK(13, 11)) >> 11)
+#define QSYS_SE_DLB_SENSE_SE_DLB_SPORT(x)                 (((x) << 7) & GENMASK(10, 7))
+#define QSYS_SE_DLB_SENSE_SE_DLB_SPORT_M                  GENMASK(10, 7)
+#define QSYS_SE_DLB_SENSE_SE_DLB_SPORT_X(x)               (((x) & GENMASK(10, 7)) >> 7)
+#define QSYS_SE_DLB_SENSE_SE_DLB_DPORT(x)                 (((x) << 3) & GENMASK(6, 3))
+#define QSYS_SE_DLB_SENSE_SE_DLB_DPORT_M                  GENMASK(6, 3)
+#define QSYS_SE_DLB_SENSE_SE_DLB_DPORT_X(x)               (((x) & GENMASK(6, 3)) >> 3)
+#define QSYS_SE_DLB_SENSE_SE_DLB_PRIO_ENA                 BIT(2)
+#define QSYS_SE_DLB_SENSE_SE_DLB_SPORT_ENA                BIT(1)
+#define QSYS_SE_DLB_SENSE_SE_DLB_DPORT_ENA                BIT(0)
+
+#define QSYS_CIR_STATE_GSZ                                0x80
+
+#define QSYS_CIR_STATE_CIR_LVL(x)                         (((x) << 4) & GENMASK(25, 4))
+#define QSYS_CIR_STATE_CIR_LVL_M                          GENMASK(25, 4)
+#define QSYS_CIR_STATE_CIR_LVL_X(x)                       (((x) & GENMASK(25, 4)) >> 4)
+#define QSYS_CIR_STATE_SHP_TIME(x)                        ((x) & GENMASK(3, 0))
+#define QSYS_CIR_STATE_SHP_TIME_M                         GENMASK(3, 0)
+
+#define QSYS_EIR_STATE_GSZ                                0x80
+
+#define QSYS_SE_STATE_GSZ                                 0x80
+
+#define QSYS_SE_STATE_SE_OUTP_LVL(x)                      (((x) << 1) & GENMASK(2, 1))
+#define QSYS_SE_STATE_SE_OUTP_LVL_M                       GENMASK(2, 1)
+#define QSYS_SE_STATE_SE_OUTP_LVL_X(x)                    (((x) & GENMASK(2, 1)) >> 1)
+#define QSYS_SE_STATE_SE_WAS_YEL                          BIT(0)
+
+#define QSYS_HSCH_MISC_CFG_SE_CONNECT_VLD                 BIT(8)
+#define QSYS_HSCH_MISC_CFG_FRM_ADJ(x)                     (((x) << 3) & GENMASK(7, 3))
+#define QSYS_HSCH_MISC_CFG_FRM_ADJ_M                      GENMASK(7, 3)
+#define QSYS_HSCH_MISC_CFG_FRM_ADJ_X(x)                   (((x) & GENMASK(7, 3)) >> 3)
+#define QSYS_HSCH_MISC_CFG_LEAK_DIS                       BIT(2)
+#define QSYS_HSCH_MISC_CFG_QSHP_EXC_ENA                   BIT(1)
+#define QSYS_HSCH_MISC_CFG_PFC_BYP_UPD                    BIT(0)
+
+#define QSYS_TAG_CONFIG_RSZ                               0x4
+
+#define QSYS_TAG_CONFIG_ENABLE                            BIT(0)
+#define QSYS_TAG_CONFIG_LINK_SPEED(x)                     (((x) << 4) & GENMASK(5, 4))
+#define QSYS_TAG_CONFIG_LINK_SPEED_M                      GENMASK(5, 4)
+#define QSYS_TAG_CONFIG_LINK_SPEED_X(x)                   (((x) & GENMASK(5, 4)) >> 4)
+#define QSYS_TAG_CONFIG_INIT_GATE_STATE(x)                (((x) << 8) & GENMASK(15, 8))
+#define QSYS_TAG_CONFIG_INIT_GATE_STATE_M                 GENMASK(15, 8)
+#define QSYS_TAG_CONFIG_INIT_GATE_STATE_X(x)              (((x) & GENMASK(15, 8)) >> 8)
+#define QSYS_TAG_CONFIG_SCH_TRAFFIC_QUEUES(x)             (((x) << 16) & GENMASK(23, 16))
+#define QSYS_TAG_CONFIG_SCH_TRAFFIC_QUEUES_M              GENMASK(23, 16)
+#define QSYS_TAG_CONFIG_SCH_TRAFFIC_QUEUES_X(x)           (((x) & GENMASK(23, 16)) >> 16)
+
+#define QSYS_TAS_PARAM_CFG_CTRL_PORT_NUM(x)               ((x) & GENMASK(7, 0))
+#define QSYS_TAS_PARAM_CFG_CTRL_PORT_NUM_M                GENMASK(7, 0)
+#define QSYS_TAS_PARAM_CFG_CTRL_ALWAYS_GUARD_BAND_SCH_Q   BIT(8)
+#define QSYS_TAS_PARAM_CFG_CTRL_CONFIG_CHANGE             BIT(16)
+
+#define QSYS_PORT_MAX_SDU_RSZ                             0x4
+
+#define QSYS_PARAM_CFG_REG_3_BASE_TIME_SEC_MSB(x)         ((x) & GENMASK(15, 0))
+#define QSYS_PARAM_CFG_REG_3_BASE_TIME_SEC_MSB_M          GENMASK(15, 0)
+#define QSYS_PARAM_CFG_REG_3_LIST_LENGTH(x)               (((x) << 16) & GENMASK(31, 16))
+#define QSYS_PARAM_CFG_REG_3_LIST_LENGTH_M                GENMASK(31, 16)
+#define QSYS_PARAM_CFG_REG_3_LIST_LENGTH_X(x)             (((x) & GENMASK(31, 16)) >> 16)
+
+#define QSYS_GCL_CFG_REG_1_GCL_ENTRY_NUM(x)               ((x) & GENMASK(5, 0))
+#define QSYS_GCL_CFG_REG_1_GCL_ENTRY_NUM_M                GENMASK(5, 0)
+#define QSYS_GCL_CFG_REG_1_GATE_STATE(x)                  (((x) << 8) & GENMASK(15, 8))
+#define QSYS_GCL_CFG_REG_1_GATE_STATE_M                   GENMASK(15, 8)
+#define QSYS_GCL_CFG_REG_1_GATE_STATE_X(x)                (((x) & GENMASK(15, 8)) >> 8)
+
+#define QSYS_PARAM_STATUS_REG_3_BASE_TIME_SEC_MSB(x)      ((x) & GENMASK(15, 0))
+#define QSYS_PARAM_STATUS_REG_3_BASE_TIME_SEC_MSB_M       GENMASK(15, 0)
+#define QSYS_PARAM_STATUS_REG_3_LIST_LENGTH(x)            (((x) << 16) & GENMASK(31, 16))
+#define QSYS_PARAM_STATUS_REG_3_LIST_LENGTH_M             GENMASK(31, 16)
+#define QSYS_PARAM_STATUS_REG_3_LIST_LENGTH_X(x)          (((x) & GENMASK(31, 16)) >> 16)
+
+#define QSYS_PARAM_STATUS_REG_8_CFG_CHG_TIME_SEC_MSB(x)   ((x) & GENMASK(15, 0))
+#define QSYS_PARAM_STATUS_REG_8_CFG_CHG_TIME_SEC_MSB_M    GENMASK(15, 0)
+#define QSYS_PARAM_STATUS_REG_8_OPER_GATE_STATE(x)        (((x) << 16) & GENMASK(23, 16))
+#define QSYS_PARAM_STATUS_REG_8_OPER_GATE_STATE_M         GENMASK(23, 16)
+#define QSYS_PARAM_STATUS_REG_8_OPER_GATE_STATE_X(x)      (((x) & GENMASK(23, 16)) >> 16)
+#define QSYS_PARAM_STATUS_REG_8_CONFIG_PENDING            BIT(24)
+
+#define QSYS_GCL_STATUS_REG_1_GCL_ENTRY_NUM(x)            ((x) & GENMASK(5, 0))
+#define QSYS_GCL_STATUS_REG_1_GCL_ENTRY_NUM_M             GENMASK(5, 0)
+#define QSYS_GCL_STATUS_REG_1_GATE_STATE(x)               (((x) << 8) & GENMASK(15, 8))
+#define QSYS_GCL_STATUS_REG_1_GATE_STATE_M                GENMASK(15, 8)
+#define QSYS_GCL_STATUS_REG_1_GATE_STATE_X(x)             (((x) & GENMASK(15, 8)) >> 8)
+
+#endif
diff --git a/drivers/net/ethernet/mscc/ocelot_regs.c b/drivers/net/ethernet/mscc/ocelot_regs.c
new file mode 100644
index 000000000000..e334b406c40c
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot_regs.c
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+#include "ocelot.h"
+
+static const u32 ocelot_ana_regmap[] = {
+	REG(ANA_ADVLEARN,                  0x009000),
+	REG(ANA_VLANMASK,                  0x009004),
+	REG(ANA_PORT_B_DOMAIN,             0x009008),
+	REG(ANA_ANAGEFIL,                  0x00900c),
+	REG(ANA_ANEVENTS,                  0x009010),
+	REG(ANA_STORMLIMIT_BURST,          0x009014),
+	REG(ANA_STORMLIMIT_CFG,            0x009018),
+	REG(ANA_ISOLATED_PORTS,            0x009028),
+	REG(ANA_COMMUNITY_PORTS,           0x00902c),
+	REG(ANA_AUTOAGE,                   0x009030),
+	REG(ANA_MACTOPTIONS,               0x009034),
+	REG(ANA_LEARNDISC,                 0x009038),
+	REG(ANA_AGENCTRL,                  0x00903c),
+	REG(ANA_MIRRORPORTS,               0x009040),
+	REG(ANA_EMIRRORPORTS,              0x009044),
+	REG(ANA_FLOODING,                  0x009048),
+	REG(ANA_FLOODING_IPMC,             0x00904c),
+	REG(ANA_SFLOW_CFG,                 0x009050),
+	REG(ANA_PORT_MODE,                 0x009080),
+	REG(ANA_PGID_PGID,                 0x008c00),
+	REG(ANA_TABLES_ANMOVED,            0x008b30),
+	REG(ANA_TABLES_MACHDATA,           0x008b34),
+	REG(ANA_TABLES_MACLDATA,           0x008b38),
+	REG(ANA_TABLES_MACACCESS,          0x008b3c),
+	REG(ANA_TABLES_MACTINDX,           0x008b40),
+	REG(ANA_TABLES_VLANACCESS,         0x008b44),
+	REG(ANA_TABLES_VLANTIDX,           0x008b48),
+	REG(ANA_TABLES_ISDXACCESS,         0x008b4c),
+	REG(ANA_TABLES_ISDXTIDX,           0x008b50),
+	REG(ANA_TABLES_ENTRYLIM,           0x008b00),
+	REG(ANA_TABLES_PTP_ID_HIGH,        0x008b54),
+	REG(ANA_TABLES_PTP_ID_LOW,         0x008b58),
+	REG(ANA_MSTI_STATE,                0x008e00),
+	REG(ANA_PORT_VLAN_CFG,             0x007000),
+	REG(ANA_PORT_DROP_CFG,             0x007004),
+	REG(ANA_PORT_QOS_CFG,              0x007008),
+	REG(ANA_PORT_VCAP_CFG,             0x00700c),
+	REG(ANA_PORT_VCAP_S1_KEY_CFG,      0x007010),
+	REG(ANA_PORT_VCAP_S2_CFG,          0x00701c),
+	REG(ANA_PORT_PCP_DEI_MAP,          0x007020),
+	REG(ANA_PORT_CPU_FWD_CFG,          0x007060),
+	REG(ANA_PORT_CPU_FWD_BPDU_CFG,     0x007064),
+	REG(ANA_PORT_CPU_FWD_GARP_CFG,     0x007068),
+	REG(ANA_PORT_CPU_FWD_CCM_CFG,      0x00706c),
+	REG(ANA_PORT_PORT_CFG,             0x007070),
+	REG(ANA_PORT_POL_CFG,              0x007074),
+	REG(ANA_PORT_PTP_CFG,              0x007078),
+	REG(ANA_PORT_PTP_DLY1_CFG,         0x00707c),
+	REG(ANA_OAM_UPM_LM_CNT,            0x007c00),
+	REG(ANA_PORT_PTP_DLY2_CFG,         0x007080),
+	REG(ANA_PFC_PFC_CFG,               0x008800),
+	REG(ANA_PFC_PFC_TIMER,             0x008804),
+	REG(ANA_IPT_OAM_MEP_CFG,           0x008000),
+	REG(ANA_IPT_IPT,                   0x008004),
+	REG(ANA_PPT_PPT,                   0x008ac0),
+	REG(ANA_FID_MAP_FID_MAP,           0x000000),
+	REG(ANA_AGGR_CFG,                  0x0090b4),
+	REG(ANA_CPUQ_CFG,                  0x0090b8),
+	REG(ANA_CPUQ_CFG2,                 0x0090bc),
+	REG(ANA_CPUQ_8021_CFG,             0x0090c0),
+	REG(ANA_DSCP_CFG,                  0x009100),
+	REG(ANA_DSCP_REWR_CFG,             0x009200),
+	REG(ANA_VCAP_RNG_TYPE_CFG,         0x009240),
+	REG(ANA_VCAP_RNG_VAL_CFG,          0x009260),
+	REG(ANA_VRAP_CFG,                  0x009280),
+	REG(ANA_VRAP_HDR_DATA,             0x009284),
+	REG(ANA_VRAP_HDR_MASK,             0x009288),
+	REG(ANA_DISCARD_CFG,               0x00928c),
+	REG(ANA_FID_CFG,                   0x009290),
+	REG(ANA_POL_PIR_CFG,               0x004000),
+	REG(ANA_POL_CIR_CFG,               0x004004),
+	REG(ANA_POL_MODE_CFG,              0x004008),
+	REG(ANA_POL_PIR_STATE,             0x00400c),
+	REG(ANA_POL_CIR_STATE,             0x004010),
+	REG(ANA_POL_STATE,                 0x004014),
+	REG(ANA_POL_FLOWC,                 0x008b80),
+	REG(ANA_POL_HYST,                  0x008bec),
+	REG(ANA_POL_MISC_CFG,              0x008bf0),
+};
+
+static const u32 ocelot_qs_regmap[] = {
+	REG(QS_XTR_GRP_CFG,                0x000000),
+	REG(QS_XTR_RD,                     0x000008),
+	REG(QS_XTR_FRM_PRUNING,            0x000010),
+	REG(QS_XTR_FLUSH,                  0x000018),
+	REG(QS_XTR_DATA_PRESENT,           0x00001c),
+	REG(QS_XTR_CFG,                    0x000020),
+	REG(QS_INJ_GRP_CFG,                0x000024),
+	REG(QS_INJ_WR,                     0x00002c),
+	REG(QS_INJ_CTRL,                   0x000034),
+	REG(QS_INJ_STATUS,                 0x00003c),
+	REG(QS_INJ_ERR,                    0x000040),
+	REG(QS_INH_DBG,                    0x000048),
+};
+
+static const u32 ocelot_hsio_regmap[] = {
+	REG(HSIO_PLL5G_CFG0,               0x000000),
+	REG(HSIO_PLL5G_CFG1,               0x000004),
+	REG(HSIO_PLL5G_CFG2,               0x000008),
+	REG(HSIO_PLL5G_CFG3,               0x00000c),
+	REG(HSIO_PLL5G_CFG4,               0x000010),
+	REG(HSIO_PLL5G_CFG5,               0x000014),
+	REG(HSIO_PLL5G_CFG6,               0x000018),
+	REG(HSIO_PLL5G_STATUS0,            0x00001c),
+	REG(HSIO_PLL5G_STATUS1,            0x000020),
+	REG(HSIO_PLL5G_BIST_CFG0,          0x000024),
+	REG(HSIO_PLL5G_BIST_CFG1,          0x000028),
+	REG(HSIO_PLL5G_BIST_CFG2,          0x00002c),
+	REG(HSIO_PLL5G_BIST_STAT0,         0x000030),
+	REG(HSIO_PLL5G_BIST_STAT1,         0x000034),
+	REG(HSIO_RCOMP_CFG0,               0x000038),
+	REG(HSIO_RCOMP_STATUS,             0x00003c),
+	REG(HSIO_SYNC_ETH_CFG,             0x000040),
+	REG(HSIO_SYNC_ETH_PLL_CFG,         0x000048),
+	REG(HSIO_S1G_DES_CFG,              0x00004c),
+	REG(HSIO_S1G_IB_CFG,               0x000050),
+	REG(HSIO_S1G_OB_CFG,               0x000054),
+	REG(HSIO_S1G_SER_CFG,              0x000058),
+	REG(HSIO_S1G_COMMON_CFG,           0x00005c),
+	REG(HSIO_S1G_PLL_CFG,              0x000060),
+	REG(HSIO_S1G_PLL_STATUS,           0x000064),
+	REG(HSIO_S1G_DFT_CFG0,             0x000068),
+	REG(HSIO_S1G_DFT_CFG1,             0x00006c),
+	REG(HSIO_S1G_DFT_CFG2,             0x000070),
+	REG(HSIO_S1G_TP_CFG,               0x000074),
+	REG(HSIO_S1G_RC_PLL_BIST_CFG,      0x000078),
+	REG(HSIO_S1G_MISC_CFG,             0x00007c),
+	REG(HSIO_S1G_DFT_STATUS,           0x000080),
+	REG(HSIO_S1G_MISC_STATUS,          0x000084),
+	REG(HSIO_MCB_S1G_ADDR_CFG,         0x000088),
+	REG(HSIO_S6G_DIG_CFG,              0x00008c),
+	REG(HSIO_S6G_DFT_CFG0,             0x000090),
+	REG(HSIO_S6G_DFT_CFG1,             0x000094),
+	REG(HSIO_S6G_DFT_CFG2,             0x000098),
+	REG(HSIO_S6G_TP_CFG0,              0x00009c),
+	REG(HSIO_S6G_TP_CFG1,              0x0000a0),
+	REG(HSIO_S6G_RC_PLL_BIST_CFG,      0x0000a4),
+	REG(HSIO_S6G_MISC_CFG,             0x0000a8),
+	REG(HSIO_S6G_OB_ANEG_CFG,          0x0000ac),
+	REG(HSIO_S6G_DFT_STATUS,           0x0000b0),
+	REG(HSIO_S6G_ERR_CNT,              0x0000b4),
+	REG(HSIO_S6G_MISC_STATUS,          0x0000b8),
+	REG(HSIO_S6G_DES_CFG,              0x0000bc),
+	REG(HSIO_S6G_IB_CFG,               0x0000c0),
+	REG(HSIO_S6G_IB_CFG1,              0x0000c4),
+	REG(HSIO_S6G_IB_CFG2,              0x0000c8),
+	REG(HSIO_S6G_IB_CFG3,              0x0000cc),
+	REG(HSIO_S6G_IB_CFG4,              0x0000d0),
+	REG(HSIO_S6G_IB_CFG5,              0x0000d4),
+	REG(HSIO_S6G_OB_CFG,               0x0000d8),
+	REG(HSIO_S6G_OB_CFG1,              0x0000dc),
+	REG(HSIO_S6G_SER_CFG,              0x0000e0),
+	REG(HSIO_S6G_COMMON_CFG,           0x0000e4),
+	REG(HSIO_S6G_PLL_CFG,              0x0000e8),
+	REG(HSIO_S6G_ACJTAG_CFG,           0x0000ec),
+	REG(HSIO_S6G_GP_CFG,               0x0000f0),
+	REG(HSIO_S6G_IB_STATUS0,           0x0000f4),
+	REG(HSIO_S6G_IB_STATUS1,           0x0000f8),
+	REG(HSIO_S6G_ACJTAG_STATUS,        0x0000fc),
+	REG(HSIO_S6G_PLL_STATUS,           0x000100),
+	REG(HSIO_S6G_REVID,                0x000104),
+	REG(HSIO_MCB_S6G_ADDR_CFG,         0x000108),
+	REG(HSIO_HW_CFG,                   0x00010c),
+	REG(HSIO_HW_QSGMII_CFG,            0x000110),
+	REG(HSIO_HW_QSGMII_STAT,           0x000114),
+	REG(HSIO_CLK_CFG,                  0x000118),
+	REG(HSIO_TEMP_SENSOR_CTRL,         0x00011c),
+	REG(HSIO_TEMP_SENSOR_CFG,          0x000120),
+	REG(HSIO_TEMP_SENSOR_STAT,         0x000124),
+};
+
+static const u32 ocelot_qsys_regmap[] = {
+	REG(QSYS_PORT_MODE,                0x011200),
+	REG(QSYS_SWITCH_PORT_MODE,         0x011234),
+	REG(QSYS_STAT_CNT_CFG,             0x011264),
+	REG(QSYS_EEE_CFG,                  0x011268),
+	REG(QSYS_EEE_THRES,                0x011294),
+	REG(QSYS_IGR_NO_SHARING,           0x011298),
+	REG(QSYS_EGR_NO_SHARING,           0x01129c),
+	REG(QSYS_SW_STATUS,                0x0112a0),
+	REG(QSYS_EXT_CPU_CFG,              0x0112d0),
+	REG(QSYS_PAD_CFG,                  0x0112d4),
+	REG(QSYS_CPU_GROUP_MAP,            0x0112d8),
+	REG(QSYS_QMAP,                     0x0112dc),
+	REG(QSYS_ISDX_SGRP,                0x011400),
+	REG(QSYS_TIMED_FRAME_ENTRY,        0x014000),
+	REG(QSYS_TFRM_MISC,                0x011310),
+	REG(QSYS_TFRM_PORT_DLY,            0x011314),
+	REG(QSYS_TFRM_TIMER_CFG_1,         0x011318),
+	REG(QSYS_TFRM_TIMER_CFG_2,         0x01131c),
+	REG(QSYS_TFRM_TIMER_CFG_3,         0x011320),
+	REG(QSYS_TFRM_TIMER_CFG_4,         0x011324),
+	REG(QSYS_TFRM_TIMER_CFG_5,         0x011328),
+	REG(QSYS_TFRM_TIMER_CFG_6,         0x01132c),
+	REG(QSYS_TFRM_TIMER_CFG_7,         0x011330),
+	REG(QSYS_TFRM_TIMER_CFG_8,         0x011334),
+	REG(QSYS_RED_PROFILE,              0x011338),
+	REG(QSYS_RES_QOS_MODE,             0x011378),
+	REG(QSYS_RES_CFG,                  0x012000),
+	REG(QSYS_RES_STAT,                 0x012004),
+	REG(QSYS_EGR_DROP_MODE,            0x01137c),
+	REG(QSYS_EQ_CTRL,                  0x011380),
+	REG(QSYS_EVENTS_CORE,              0x011384),
+	REG(QSYS_CIR_CFG,                  0x000000),
+	REG(QSYS_EIR_CFG,                  0x000004),
+	REG(QSYS_SE_CFG,                   0x000008),
+	REG(QSYS_SE_DWRR_CFG,              0x00000c),
+	REG(QSYS_SE_CONNECT,               0x00003c),
+	REG(QSYS_SE_DLB_SENSE,             0x000040),
+	REG(QSYS_CIR_STATE,                0x000044),
+	REG(QSYS_EIR_STATE,                0x000048),
+	REG(QSYS_SE_STATE,                 0x00004c),
+	REG(QSYS_HSCH_MISC_CFG,            0x011388),
+};
+
+static const u32 ocelot_rew_regmap[] = {
+	REG(REW_PORT_VLAN_CFG,             0x000000),
+	REG(REW_TAG_CFG,                   0x000004),
+	REG(REW_PORT_CFG,                  0x000008),
+	REG(REW_DSCP_CFG,                  0x00000c),
+	REG(REW_PCP_DEI_QOS_MAP_CFG,       0x000010),
+	REG(REW_PTP_CFG,                   0x000050),
+	REG(REW_PTP_DLY1_CFG,              0x000054),
+	REG(REW_DSCP_REMAP_DP1_CFG,        0x000690),
+	REG(REW_DSCP_REMAP_CFG,            0x000790),
+	REG(REW_STAT_CFG,                  0x000890),
+	REG(REW_PPT,                       0x000680),
+};
+
+static const u32 ocelot_sys_regmap[] = {
+	REG(SYS_COUNT_RX_OCTETS,           0x000000),
+	REG(SYS_COUNT_RX_UNICAST,          0x000004),
+	REG(SYS_COUNT_RX_MULTICAST,        0x000008),
+	REG(SYS_COUNT_RX_BROADCAST,        0x00000c),
+	REG(SYS_COUNT_RX_SHORTS,           0x000010),
+	REG(SYS_COUNT_RX_FRAGMENTS,        0x000014),
+	REG(SYS_COUNT_RX_JABBERS,          0x000018),
+	REG(SYS_COUNT_RX_CRC_ALIGN_ERRS,   0x00001c),
+	REG(SYS_COUNT_RX_SYM_ERRS,         0x000020),
+	REG(SYS_COUNT_RX_64,               0x000024),
+	REG(SYS_COUNT_RX_65_127,           0x000028),
+	REG(SYS_COUNT_RX_128_255,          0x00002c),
+	REG(SYS_COUNT_RX_256_1023,         0x000030),
+	REG(SYS_COUNT_RX_1024_1526,        0x000034),
+	REG(SYS_COUNT_RX_1527_MAX,         0x000038),
+	REG(SYS_COUNT_RX_PAUSE,            0x00003c),
+	REG(SYS_COUNT_RX_CONTROL,          0x000040),
+	REG(SYS_COUNT_RX_LONGS,            0x000044),
+	REG(SYS_COUNT_RX_CLASSIFIED_DROPS, 0x000048),
+	REG(SYS_COUNT_TX_OCTETS,           0x000100),
+	REG(SYS_COUNT_TX_UNICAST,          0x000104),
+	REG(SYS_COUNT_TX_MULTICAST,        0x000108),
+	REG(SYS_COUNT_TX_BROADCAST,        0x00010c),
+	REG(SYS_COUNT_TX_COLLISION,        0x000110),
+	REG(SYS_COUNT_TX_DROPS,            0x000114),
+	REG(SYS_COUNT_TX_PAUSE,            0x000118),
+	REG(SYS_COUNT_TX_64,               0x00011c),
+	REG(SYS_COUNT_TX_65_127,           0x000120),
+	REG(SYS_COUNT_TX_128_511,          0x000124),
+	REG(SYS_COUNT_TX_512_1023,         0x000128),
+	REG(SYS_COUNT_TX_1024_1526,        0x00012c),
+	REG(SYS_COUNT_TX_1527_MAX,         0x000130),
+	REG(SYS_COUNT_TX_AGING,            0x000170),
+	REG(SYS_RESET_CFG,                 0x000508),
+	REG(SYS_CMID,                      0x00050c),
+	REG(SYS_VLAN_ETYPE_CFG,            0x000510),
+	REG(SYS_PORT_MODE,                 0x000514),
+	REG(SYS_FRONT_PORT_MODE,           0x000548),
+	REG(SYS_FRM_AGING,                 0x000574),
+	REG(SYS_STAT_CFG,                  0x000578),
+	REG(SYS_SW_STATUS,                 0x00057c),
+	REG(SYS_MISC_CFG,                  0x0005ac),
+	REG(SYS_REW_MAC_HIGH_CFG,          0x0005b0),
+	REG(SYS_REW_MAC_LOW_CFG,           0x0005dc),
+	REG(SYS_CM_ADDR,                   0x000500),
+	REG(SYS_CM_DATA,                   0x000504),
+	REG(SYS_PAUSE_CFG,                 0x000608),
+	REG(SYS_PAUSE_TOT_CFG,             0x000638),
+	REG(SYS_ATOP,                      0x00063c),
+	REG(SYS_ATOP_TOT_CFG,              0x00066c),
+	REG(SYS_MAC_FC_CFG,                0x000670),
+	REG(SYS_MMGT,                      0x00069c),
+	REG(SYS_MMGT_FAST,                 0x0006a0),
+	REG(SYS_EVENTS_DIF,                0x0006a4),
+	REG(SYS_EVENTS_CORE,               0x0006b4),
+	REG(SYS_CNT,                       0x000000),
+	REG(SYS_PTP_STATUS,                0x0006b8),
+	REG(SYS_PTP_TXSTAMP,               0x0006bc),
+	REG(SYS_PTP_NXT,                   0x0006c0),
+	REG(SYS_PTP_CFG,                   0x0006c4),
+};
+
+static const u32 *ocelot_regmap[] = {
+	[ANA] = ocelot_ana_regmap,
+	[QS] = ocelot_qs_regmap,
+	[HSIO] = ocelot_hsio_regmap,
+	[QSYS] = ocelot_qsys_regmap,
+	[REW] = ocelot_rew_regmap,
+	[SYS] = ocelot_sys_regmap,
+};
+
+static const struct reg_field ocelot_regfields[] = {
+	[ANA_ADVLEARN_VLAN_CHK] = REG_FIELD(ANA_ADVLEARN, 11, 11),
+	[ANA_ADVLEARN_LEARN_MIRROR] = REG_FIELD(ANA_ADVLEARN, 0, 10),
+	[ANA_ANEVENTS_MSTI_DROP] = REG_FIELD(ANA_ANEVENTS, 27, 27),
+	[ANA_ANEVENTS_ACLKILL] = REG_FIELD(ANA_ANEVENTS, 26, 26),
+	[ANA_ANEVENTS_ACLUSED] = REG_FIELD(ANA_ANEVENTS, 25, 25),
+	[ANA_ANEVENTS_AUTOAGE] = REG_FIELD(ANA_ANEVENTS, 24, 24),
+	[ANA_ANEVENTS_VS2TTL1] = REG_FIELD(ANA_ANEVENTS, 23, 23),
+	[ANA_ANEVENTS_STORM_DROP] = REG_FIELD(ANA_ANEVENTS, 22, 22),
+	[ANA_ANEVENTS_LEARN_DROP] = REG_FIELD(ANA_ANEVENTS, 21, 21),
+	[ANA_ANEVENTS_AGED_ENTRY] = REG_FIELD(ANA_ANEVENTS, 20, 20),
+	[ANA_ANEVENTS_CPU_LEARN_FAILED] = REG_FIELD(ANA_ANEVENTS, 19, 19),
+	[ANA_ANEVENTS_AUTO_LEARN_FAILED] = REG_FIELD(ANA_ANEVENTS, 18, 18),
+	[ANA_ANEVENTS_LEARN_REMOVE] = REG_FIELD(ANA_ANEVENTS, 17, 17),
+	[ANA_ANEVENTS_AUTO_LEARNED] = REG_FIELD(ANA_ANEVENTS, 16, 16),
+	[ANA_ANEVENTS_AUTO_MOVED] = REG_FIELD(ANA_ANEVENTS, 15, 15),
+	[ANA_ANEVENTS_DROPPED] = REG_FIELD(ANA_ANEVENTS, 14, 14),
+	[ANA_ANEVENTS_CLASSIFIED_DROP] = REG_FIELD(ANA_ANEVENTS, 13, 13),
+	[ANA_ANEVENTS_CLASSIFIED_COPY] = REG_FIELD(ANA_ANEVENTS, 12, 12),
+	[ANA_ANEVENTS_VLAN_DISCARD] = REG_FIELD(ANA_ANEVENTS, 11, 11),
+	[ANA_ANEVENTS_FWD_DISCARD] = REG_FIELD(ANA_ANEVENTS, 10, 10),
+	[ANA_ANEVENTS_MULTICAST_FLOOD] = REG_FIELD(ANA_ANEVENTS, 9, 9),
+	[ANA_ANEVENTS_UNICAST_FLOOD] = REG_FIELD(ANA_ANEVENTS, 8, 8),
+	[ANA_ANEVENTS_DEST_KNOWN] = REG_FIELD(ANA_ANEVENTS, 7, 7),
+	[ANA_ANEVENTS_BUCKET3_MATCH] = REG_FIELD(ANA_ANEVENTS, 6, 6),
+	[ANA_ANEVENTS_BUCKET2_MATCH] = REG_FIELD(ANA_ANEVENTS, 5, 5),
+	[ANA_ANEVENTS_BUCKET1_MATCH] = REG_FIELD(ANA_ANEVENTS, 4, 4),
+	[ANA_ANEVENTS_BUCKET0_MATCH] = REG_FIELD(ANA_ANEVENTS, 3, 3),
+	[ANA_ANEVENTS_CPU_OPERATION] = REG_FIELD(ANA_ANEVENTS, 2, 2),
+	[ANA_ANEVENTS_DMAC_LOOKUP] = REG_FIELD(ANA_ANEVENTS, 1, 1),
+	[ANA_ANEVENTS_SMAC_LOOKUP] = REG_FIELD(ANA_ANEVENTS, 0, 0),
+	[ANA_TABLES_MACACCESS_B_DOM] = REG_FIELD(ANA_TABLES_MACACCESS, 18, 18),
+	[ANA_TABLES_MACTINDX_BUCKET] = REG_FIELD(ANA_TABLES_MACTINDX, 10, 11),
+	[ANA_TABLES_MACTINDX_M_INDEX] = REG_FIELD(ANA_TABLES_MACTINDX, 0, 9),
+	[QSYS_TIMED_FRAME_ENTRY_TFRM_VLD] = REG_FIELD(QSYS_TIMED_FRAME_ENTRY, 20, 20),
+	[QSYS_TIMED_FRAME_ENTRY_TFRM_FP] = REG_FIELD(QSYS_TIMED_FRAME_ENTRY, 8, 19),
+	[QSYS_TIMED_FRAME_ENTRY_TFRM_PORTNO] = REG_FIELD(QSYS_TIMED_FRAME_ENTRY, 4, 7),
+	[QSYS_TIMED_FRAME_ENTRY_TFRM_TM_SEL] = REG_FIELD(QSYS_TIMED_FRAME_ENTRY, 1, 3),
+	[QSYS_TIMED_FRAME_ENTRY_TFRM_TM_T] = REG_FIELD(QSYS_TIMED_FRAME_ENTRY, 0, 0),
+	[SYS_RESET_CFG_CORE_ENA] = REG_FIELD(SYS_RESET_CFG, 2, 2),
+	[SYS_RESET_CFG_MEM_ENA] = REG_FIELD(SYS_RESET_CFG, 1, 1),
+	[SYS_RESET_CFG_MEM_INIT] = REG_FIELD(SYS_RESET_CFG, 0, 0),
+};
+
+static const struct ocelot_stat_layout ocelot_stats_layout[] = {
+	{ .name = "rx_octets", .offset = 0x00, },
+	{ .name = "rx_unicast", .offset = 0x01, },
+	{ .name = "rx_multicast", .offset = 0x02, },
+	{ .name = "rx_broadcast", .offset = 0x03, },
+	{ .name = "rx_shorts", .offset = 0x04, },
+	{ .name = "rx_fragments", .offset = 0x05, },
+	{ .name = "rx_jabbers", .offset = 0x06, },
+	{ .name = "rx_crc_align_errs", .offset = 0x07, },
+	{ .name = "rx_sym_errs", .offset = 0x08, },
+	{ .name = "rx_frames_below_65_octets", .offset = 0x09, },
+	{ .name = "rx_frames_65_to_127_octets", .offset = 0x0A, },
+	{ .name = "rx_frames_128_to_255_octets", .offset = 0x0B, },
+	{ .name = "rx_frames_256_to_511_octets", .offset = 0x0C, },
+	{ .name = "rx_frames_512_to_1023_octets", .offset = 0x0D, },
+	{ .name = "rx_frames_1024_to_1526_octets", .offset = 0x0E, },
+	{ .name = "rx_frames_over_1526_octets", .offset = 0x0F, },
+	{ .name = "rx_pause", .offset = 0x10, },
+	{ .name = "rx_control", .offset = 0x11, },
+	{ .name = "rx_longs", .offset = 0x12, },
+	{ .name = "rx_classified_drops", .offset = 0x13, },
+	{ .name = "rx_red_prio_0", .offset = 0x14, },
+	{ .name = "rx_red_prio_1", .offset = 0x15, },
+	{ .name = "rx_red_prio_2", .offset = 0x16, },
+	{ .name = "rx_red_prio_3", .offset = 0x17, },
+	{ .name = "rx_red_prio_4", .offset = 0x18, },
+	{ .name = "rx_red_prio_5", .offset = 0x19, },
+	{ .name = "rx_red_prio_6", .offset = 0x1A, },
+	{ .name = "rx_red_prio_7", .offset = 0x1B, },
+	{ .name = "rx_yellow_prio_0", .offset = 0x1C, },
+	{ .name = "rx_yellow_prio_1", .offset = 0x1D, },
+	{ .name = "rx_yellow_prio_2", .offset = 0x1E, },
+	{ .name = "rx_yellow_prio_3", .offset = 0x1F, },
+	{ .name = "rx_yellow_prio_4", .offset = 0x20, },
+	{ .name = "rx_yellow_prio_5", .offset = 0x21, },
+	{ .name = "rx_yellow_prio_6", .offset = 0x22, },
+	{ .name = "rx_yellow_prio_7", .offset = 0x23, },
+	{ .name = "rx_green_prio_0", .offset = 0x24, },
+	{ .name = "rx_green_prio_1", .offset = 0x25, },
+	{ .name = "rx_green_prio_2", .offset = 0x26, },
+	{ .name = "rx_green_prio_3", .offset = 0x27, },
+	{ .name = "rx_green_prio_4", .offset = 0x28, },
+	{ .name = "rx_green_prio_5", .offset = 0x29, },
+	{ .name = "rx_green_prio_6", .offset = 0x2A, },
+	{ .name = "rx_green_prio_7", .offset = 0x2B, },
+	{ .name = "tx_octets", .offset = 0x40, },
+	{ .name = "tx_unicast", .offset = 0x41, },
+	{ .name = "tx_multicast", .offset = 0x42, },
+	{ .name = "tx_broadcast", .offset = 0x43, },
+	{ .name = "tx_collision", .offset = 0x44, },
+	{ .name = "tx_drops", .offset = 0x45, },
+	{ .name = "tx_pause", .offset = 0x46, },
+	{ .name = "tx_frames_below_65_octets", .offset = 0x47, },
+	{ .name = "tx_frames_65_to_127_octets", .offset = 0x48, },
+	{ .name = "tx_frames_128_255_octets", .offset = 0x49, },
+	{ .name = "tx_frames_256_511_octets", .offset = 0x4A, },
+	{ .name = "tx_frames_512_1023_octets", .offset = 0x4B, },
+	{ .name = "tx_frames_1024_1526_octets", .offset = 0x4C, },
+	{ .name = "tx_frames_over_1526_octets", .offset = 0x4D, },
+	{ .name = "tx_yellow_prio_0", .offset = 0x4E, },
+	{ .name = "tx_yellow_prio_1", .offset = 0x4F, },
+	{ .name = "tx_yellow_prio_2", .offset = 0x50, },
+	{ .name = "tx_yellow_prio_3", .offset = 0x51, },
+	{ .name = "tx_yellow_prio_4", .offset = 0x52, },
+	{ .name = "tx_yellow_prio_5", .offset = 0x53, },
+	{ .name = "tx_yellow_prio_6", .offset = 0x54, },
+	{ .name = "tx_yellow_prio_7", .offset = 0x55, },
+	{ .name = "tx_green_prio_0", .offset = 0x56, },
+	{ .name = "tx_green_prio_1", .offset = 0x57, },
+	{ .name = "tx_green_prio_2", .offset = 0x58, },
+	{ .name = "tx_green_prio_3", .offset = 0x59, },
+	{ .name = "tx_green_prio_4", .offset = 0x5A, },
+	{ .name = "tx_green_prio_5", .offset = 0x5B, },
+	{ .name = "tx_green_prio_6", .offset = 0x5C, },
+	{ .name = "tx_green_prio_7", .offset = 0x5D, },
+	{ .name = "tx_aged", .offset = 0x5E, },
+	{ .name = "drop_local", .offset = 0x80, },
+	{ .name = "drop_tail", .offset = 0x81, },
+	{ .name = "drop_yellow_prio_0", .offset = 0x82, },
+	{ .name = "drop_yellow_prio_1", .offset = 0x83, },
+	{ .name = "drop_yellow_prio_2", .offset = 0x84, },
+	{ .name = "drop_yellow_prio_3", .offset = 0x85, },
+	{ .name = "drop_yellow_prio_4", .offset = 0x86, },
+	{ .name = "drop_yellow_prio_5", .offset = 0x87, },
+	{ .name = "drop_yellow_prio_6", .offset = 0x88, },
+	{ .name = "drop_yellow_prio_7", .offset = 0x89, },
+	{ .name = "drop_green_prio_0", .offset = 0x8A, },
+	{ .name = "drop_green_prio_1", .offset = 0x8B, },
+	{ .name = "drop_green_prio_2", .offset = 0x8C, },
+	{ .name = "drop_green_prio_3", .offset = 0x8D, },
+	{ .name = "drop_green_prio_4", .offset = 0x8E, },
+	{ .name = "drop_green_prio_5", .offset = 0x8F, },
+	{ .name = "drop_green_prio_6", .offset = 0x90, },
+	{ .name = "drop_green_prio_7", .offset = 0x91, },
+};
+
+static void ocelot_pll5_init(struct ocelot *ocelot)
+{
+	/* Configure PLL5. This will need a proper CCF driver
+	 * The values are coming from the VTSS API for Ocelot
+	 */
+	ocelot_write(ocelot, HSIO_PLL5G_CFG4_IB_CTRL(0x7600) |
+		     HSIO_PLL5G_CFG4_IB_BIAS_CTRL(0x8), HSIO_PLL5G_CFG4);
+	ocelot_write(ocelot, HSIO_PLL5G_CFG0_CORE_CLK_DIV(0x11) |
+		     HSIO_PLL5G_CFG0_CPU_CLK_DIV(2) |
+		     HSIO_PLL5G_CFG0_ENA_BIAS |
+		     HSIO_PLL5G_CFG0_ENA_VCO_BUF |
+		     HSIO_PLL5G_CFG0_ENA_CP1 |
+		     HSIO_PLL5G_CFG0_SELCPI(2) |
+		     HSIO_PLL5G_CFG0_LOOP_BW_RES(0xe) |
+		     HSIO_PLL5G_CFG0_SELBGV820(4) |
+		     HSIO_PLL5G_CFG0_DIV4 |
+		     HSIO_PLL5G_CFG0_ENA_CLKTREE |
+		     HSIO_PLL5G_CFG0_ENA_LANE, HSIO_PLL5G_CFG0);
+	ocelot_write(ocelot, HSIO_PLL5G_CFG2_EN_RESET_FRQ_DET |
+		     HSIO_PLL5G_CFG2_EN_RESET_OVERRUN |
+		     HSIO_PLL5G_CFG2_GAIN_TEST(0x8) |
+		     HSIO_PLL5G_CFG2_ENA_AMPCTRL |
+		     HSIO_PLL5G_CFG2_PWD_AMPCTRL_N |
+		     HSIO_PLL5G_CFG2_AMPC_SEL(0x10), HSIO_PLL5G_CFG2);
+}
+
+int ocelot_chip_init(struct ocelot *ocelot)
+{
+	int ret;
+
+	ocelot->map = ocelot_regmap;
+	ocelot->stats_layout = ocelot_stats_layout;
+	ocelot->num_stats = ARRAY_SIZE(ocelot_stats_layout);
+	ocelot->shared_queue_sz = 224 * 1024;
+
+	ret = ocelot_regfields_init(ocelot, ocelot_regfields);
+	if (ret)
+		return ret;
+
+	ocelot_pll5_init(ocelot);
+
+	eth_random_addr(ocelot->base_mac);
+	ocelot->base_mac[5] &= 0xf0;
+
+	return 0;
+}
+EXPORT_SYMBOL(ocelot_chip_init);
diff --git a/drivers/net/ethernet/mscc/ocelot_rew.h b/drivers/net/ethernet/mscc/ocelot_rew.h
new file mode 100644
index 000000000000..210914b7e20f
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot_rew.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+
+#ifndef _MSCC_OCELOT_REW_H_
+#define _MSCC_OCELOT_REW_H_
+
+#define REW_PORT_VLAN_CFG_GSZ                             0x80
+
+#define REW_PORT_VLAN_CFG_PORT_TPID(x)                    (((x) << 16) & GENMASK(31, 16))
+#define REW_PORT_VLAN_CFG_PORT_TPID_M                     GENMASK(31, 16)
+#define REW_PORT_VLAN_CFG_PORT_TPID_X(x)                  (((x) & GENMASK(31, 16)) >> 16)
+#define REW_PORT_VLAN_CFG_PORT_DEI                        BIT(15)
+#define REW_PORT_VLAN_CFG_PORT_PCP(x)                     (((x) << 12) & GENMASK(14, 12))
+#define REW_PORT_VLAN_CFG_PORT_PCP_M                      GENMASK(14, 12)
+#define REW_PORT_VLAN_CFG_PORT_PCP_X(x)                   (((x) & GENMASK(14, 12)) >> 12)
+#define REW_PORT_VLAN_CFG_PORT_VID(x)                     ((x) & GENMASK(11, 0))
+#define REW_PORT_VLAN_CFG_PORT_VID_M                      GENMASK(11, 0)
+
+#define REW_TAG_CFG_GSZ                                   0x80
+
+#define REW_TAG_CFG_TAG_CFG(x)                            (((x) << 7) & GENMASK(8, 7))
+#define REW_TAG_CFG_TAG_CFG_M                             GENMASK(8, 7)
+#define REW_TAG_CFG_TAG_CFG_X(x)                          (((x) & GENMASK(8, 7)) >> 7)
+#define REW_TAG_CFG_TAG_TPID_CFG(x)                       (((x) << 5) & GENMASK(6, 5))
+#define REW_TAG_CFG_TAG_TPID_CFG_M                        GENMASK(6, 5)
+#define REW_TAG_CFG_TAG_TPID_CFG_X(x)                     (((x) & GENMASK(6, 5)) >> 5)
+#define REW_TAG_CFG_TAG_VID_CFG                           BIT(4)
+#define REW_TAG_CFG_TAG_PCP_CFG(x)                        (((x) << 2) & GENMASK(3, 2))
+#define REW_TAG_CFG_TAG_PCP_CFG_M                         GENMASK(3, 2)
+#define REW_TAG_CFG_TAG_PCP_CFG_X(x)                      (((x) & GENMASK(3, 2)) >> 2)
+#define REW_TAG_CFG_TAG_DEI_CFG(x)                        ((x) & GENMASK(1, 0))
+#define REW_TAG_CFG_TAG_DEI_CFG_M                         GENMASK(1, 0)
+
+#define REW_PORT_CFG_GSZ                                  0x80
+
+#define REW_PORT_CFG_ES0_EN                               BIT(5)
+#define REW_PORT_CFG_FCS_UPDATE_NONCPU_CFG(x)             (((x) << 3) & GENMASK(4, 3))
+#define REW_PORT_CFG_FCS_UPDATE_NONCPU_CFG_M              GENMASK(4, 3)
+#define REW_PORT_CFG_FCS_UPDATE_NONCPU_CFG_X(x)           (((x) & GENMASK(4, 3)) >> 3)
+#define REW_PORT_CFG_FCS_UPDATE_CPU_ENA                   BIT(2)
+#define REW_PORT_CFG_FLUSH_ENA                            BIT(1)
+#define REW_PORT_CFG_AGE_DIS                              BIT(0)
+
+#define REW_DSCP_CFG_GSZ                                  0x80
+
+#define REW_PCP_DEI_QOS_MAP_CFG_GSZ                       0x80
+#define REW_PCP_DEI_QOS_MAP_CFG_RSZ                       0x4
+
+#define REW_PCP_DEI_QOS_MAP_CFG_DEI_QOS_VAL               BIT(3)
+#define REW_PCP_DEI_QOS_MAP_CFG_PCP_QOS_VAL(x)            ((x) & GENMASK(2, 0))
+#define REW_PCP_DEI_QOS_MAP_CFG_PCP_QOS_VAL_M             GENMASK(2, 0)
+
+#define REW_PTP_CFG_GSZ                                   0x80
+
+#define REW_PTP_CFG_PTP_BACKPLANE_MODE                    BIT(7)
+#define REW_PTP_CFG_GP_CFG_UNUSED(x)                      (((x) << 3) & GENMASK(6, 3))
+#define REW_PTP_CFG_GP_CFG_UNUSED_M                       GENMASK(6, 3)
+#define REW_PTP_CFG_GP_CFG_UNUSED_X(x)                    (((x) & GENMASK(6, 3)) >> 3)
+#define REW_PTP_CFG_PTP_1STEP_DIS                         BIT(2)
+#define REW_PTP_CFG_PTP_2STEP_DIS                         BIT(1)
+#define REW_PTP_CFG_PTP_UDP_KEEP                          BIT(0)
+
+#define REW_PTP_DLY1_CFG_GSZ                              0x80
+
+#define REW_RED_TAG_CFG_GSZ                               0x80
+
+#define REW_RED_TAG_CFG_RED_TAG_CFG                       BIT(0)
+
+#define REW_DSCP_REMAP_DP1_CFG_RSZ                        0x4
+
+#define REW_DSCP_REMAP_CFG_RSZ                            0x4
+
+#define REW_REW_STICKY_ES0_TAGB_PUSH_FAILED               BIT(0)
+
+#define REW_PPT_RSZ                                       0x4
+
+#endif
diff --git a/drivers/net/ethernet/mscc/ocelot_sys.h b/drivers/net/ethernet/mscc/ocelot_sys.h
new file mode 100644
index 000000000000..16f91e172bcb
--- /dev/null
+++ b/drivers/net/ethernet/mscc/ocelot_sys.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Microsemi Ocelot Switch driver
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+
+#ifndef _MSCC_OCELOT_SYS_H_
+#define _MSCC_OCELOT_SYS_H_
+
+#define SYS_COUNT_RX_OCTETS_RSZ                           0x4
+
+#define SYS_COUNT_TX_OCTETS_RSZ                           0x4
+
+#define SYS_PORT_MODE_RSZ                                 0x4
+
+#define SYS_PORT_MODE_DATA_WO_TS(x)                       (((x) << 5) & GENMASK(6, 5))
+#define SYS_PORT_MODE_DATA_WO_TS_M                        GENMASK(6, 5)
+#define SYS_PORT_MODE_DATA_WO_TS_X(x)                     (((x) & GENMASK(6, 5)) >> 5)
+#define SYS_PORT_MODE_INCL_INJ_HDR(x)                     (((x) << 3) & GENMASK(4, 3))
+#define SYS_PORT_MODE_INCL_INJ_HDR_M                      GENMASK(4, 3)
+#define SYS_PORT_MODE_INCL_INJ_HDR_X(x)                   (((x) & GENMASK(4, 3)) >> 3)
+#define SYS_PORT_MODE_INCL_XTR_HDR(x)                     (((x) << 1) & GENMASK(2, 1))
+#define SYS_PORT_MODE_INCL_XTR_HDR_M                      GENMASK(2, 1)
+#define SYS_PORT_MODE_INCL_XTR_HDR_X(x)                   (((x) & GENMASK(2, 1)) >> 1)
+#define SYS_PORT_MODE_INJ_HDR_ERR                         BIT(0)
+
+#define SYS_FRONT_PORT_MODE_RSZ                           0x4
+
+#define SYS_FRONT_PORT_MODE_HDX_MODE                      BIT(0)
+
+#define SYS_FRM_AGING_AGE_TX_ENA                          BIT(20)
+#define SYS_FRM_AGING_MAX_AGE(x)                          ((x) & GENMASK(19, 0))
+#define SYS_FRM_AGING_MAX_AGE_M                           GENMASK(19, 0)
+
+#define SYS_STAT_CFG_STAT_CLEAR_SHOT(x)                   (((x) << 10) & GENMASK(16, 10))
+#define SYS_STAT_CFG_STAT_CLEAR_SHOT_M                    GENMASK(16, 10)
+#define SYS_STAT_CFG_STAT_CLEAR_SHOT_X(x)                 (((x) & GENMASK(16, 10)) >> 10)
+#define SYS_STAT_CFG_STAT_VIEW(x)                         ((x) & GENMASK(9, 0))
+#define SYS_STAT_CFG_STAT_VIEW_M                          GENMASK(9, 0)
+
+#define SYS_SW_STATUS_RSZ                                 0x4
+
+#define SYS_SW_STATUS_PORT_RX_PAUSED                      BIT(0)
+
+#define SYS_MISC_CFG_PTP_RSRV_CLR                         BIT(1)
+#define SYS_MISC_CFG_PTP_DIS_NEG_RO                       BIT(0)
+
+#define SYS_REW_MAC_HIGH_CFG_RSZ                          0x4
+
+#define SYS_REW_MAC_LOW_CFG_RSZ                           0x4
+
+#define SYS_TIMESTAMP_OFFSET_ETH_TYPE_CFG(x)              (((x) << 6) & GENMASK(21, 6))
+#define SYS_TIMESTAMP_OFFSET_ETH_TYPE_CFG_M               GENMASK(21, 6)
+#define SYS_TIMESTAMP_OFFSET_ETH_TYPE_CFG_X(x)            (((x) & GENMASK(21, 6)) >> 6)
+#define SYS_TIMESTAMP_OFFSET_TIMESTAMP_OFFSET(x)          ((x) & GENMASK(5, 0))
+#define SYS_TIMESTAMP_OFFSET_TIMESTAMP_OFFSET_M           GENMASK(5, 0)
+
+#define SYS_PAUSE_CFG_RSZ                                 0x4
+
+#define SYS_PAUSE_CFG_PAUSE_START(x)                      (((x) << 10) & GENMASK(18, 10))
+#define SYS_PAUSE_CFG_PAUSE_START_M                       GENMASK(18, 10)
+#define SYS_PAUSE_CFG_PAUSE_START_X(x)                    (((x) & GENMASK(18, 10)) >> 10)
+#define SYS_PAUSE_CFG_PAUSE_STOP(x)                       (((x) << 1) & GENMASK(9, 1))
+#define SYS_PAUSE_CFG_PAUSE_STOP_M                        GENMASK(9, 1)
+#define SYS_PAUSE_CFG_PAUSE_STOP_X(x)                     (((x) & GENMASK(9, 1)) >> 1)
+#define SYS_PAUSE_CFG_PAUSE_ENA                           BIT(0)
+
+#define SYS_PAUSE_TOT_CFG_PAUSE_TOT_START(x)              (((x) << 9) & GENMASK(17, 9))
+#define SYS_PAUSE_TOT_CFG_PAUSE_TOT_START_M               GENMASK(17, 9)
+#define SYS_PAUSE_TOT_CFG_PAUSE_TOT_START_X(x)            (((x) & GENMASK(17, 9)) >> 9)
+#define SYS_PAUSE_TOT_CFG_PAUSE_TOT_STOP(x)               ((x) & GENMASK(8, 0))
+#define SYS_PAUSE_TOT_CFG_PAUSE_TOT_STOP_M                GENMASK(8, 0)
+
+#define SYS_ATOP_RSZ                                      0x4
+
+#define SYS_MAC_FC_CFG_RSZ                                0x4
+
+#define SYS_MAC_FC_CFG_FC_LINK_SPEED(x)                   (((x) << 26) & GENMASK(27, 26))
+#define SYS_MAC_FC_CFG_FC_LINK_SPEED_M                    GENMASK(27, 26)
+#define SYS_MAC_FC_CFG_FC_LINK_SPEED_X(x)                 (((x) & GENMASK(27, 26)) >> 26)
+#define SYS_MAC_FC_CFG_FC_LATENCY_CFG(x)                  (((x) << 20) & GENMASK(25, 20))
+#define SYS_MAC_FC_CFG_FC_LATENCY_CFG_M                   GENMASK(25, 20)
+#define SYS_MAC_FC_CFG_FC_LATENCY_CFG_X(x)                (((x) & GENMASK(25, 20)) >> 20)
+#define SYS_MAC_FC_CFG_ZERO_PAUSE_ENA                     BIT(18)
+#define SYS_MAC_FC_CFG_TX_FC_ENA                          BIT(17)
+#define SYS_MAC_FC_CFG_RX_FC_ENA                          BIT(16)
+#define SYS_MAC_FC_CFG_PAUSE_VAL_CFG(x)                   ((x) & GENMASK(15, 0))
+#define SYS_MAC_FC_CFG_PAUSE_VAL_CFG_M                    GENMASK(15, 0)
+
+#define SYS_MMGT_RELCNT(x)                                (((x) << 16) & GENMASK(31, 16))
+#define SYS_MMGT_RELCNT_M                                 GENMASK(31, 16)
+#define SYS_MMGT_RELCNT_X(x)                              (((x) & GENMASK(31, 16)) >> 16)
+#define SYS_MMGT_FREECNT(x)                               ((x) & GENMASK(15, 0))
+#define SYS_MMGT_FREECNT_M                                GENMASK(15, 0)
+
+#define SYS_MMGT_FAST_FREEVLD(x)                          (((x) << 4) & GENMASK(7, 4))
+#define SYS_MMGT_FAST_FREEVLD_M                           GENMASK(7, 4)
+#define SYS_MMGT_FAST_FREEVLD_X(x)                        (((x) & GENMASK(7, 4)) >> 4)
+#define SYS_MMGT_FAST_RELVLD(x)                           ((x) & GENMASK(3, 0))
+#define SYS_MMGT_FAST_RELVLD_M                            GENMASK(3, 0)
+
+#define SYS_EVENTS_DIF_RSZ                                0x4
+
+#define SYS_EVENTS_DIF_EV_DRX(x)                          (((x) << 6) & GENMASK(8, 6))
+#define SYS_EVENTS_DIF_EV_DRX_M                           GENMASK(8, 6)
+#define SYS_EVENTS_DIF_EV_DRX_X(x)                        (((x) & GENMASK(8, 6)) >> 6)
+#define SYS_EVENTS_DIF_EV_DTX(x)                          ((x) & GENMASK(5, 0))
+#define SYS_EVENTS_DIF_EV_DTX_M                           GENMASK(5, 0)
+
+#define SYS_EVENTS_CORE_EV_FWR                            BIT(2)
+#define SYS_EVENTS_CORE_EV_ANA(x)                         ((x) & GENMASK(1, 0))
+#define SYS_EVENTS_CORE_EV_ANA_M                          GENMASK(1, 0)
+
+#define SYS_CNT_GSZ                                       0x4
+
+#define SYS_PTP_STATUS_PTP_TXSTAMP_OAM                    BIT(29)
+#define SYS_PTP_STATUS_PTP_OVFL                           BIT(28)
+#define SYS_PTP_STATUS_PTP_MESS_VLD                       BIT(27)
+#define SYS_PTP_STATUS_PTP_MESS_ID(x)                     (((x) << 21) & GENMASK(26, 21))
+#define SYS_PTP_STATUS_PTP_MESS_ID_M                      GENMASK(26, 21)
+#define SYS_PTP_STATUS_PTP_MESS_ID_X(x)                   (((x) & GENMASK(26, 21)) >> 21)
+#define SYS_PTP_STATUS_PTP_MESS_TXPORT(x)                 (((x) << 16) & GENMASK(20, 16))
+#define SYS_PTP_STATUS_PTP_MESS_TXPORT_M                  GENMASK(20, 16)
+#define SYS_PTP_STATUS_PTP_MESS_TXPORT_X(x)               (((x) & GENMASK(20, 16)) >> 16)
+#define SYS_PTP_STATUS_PTP_MESS_SEQ_ID(x)                 ((x) & GENMASK(15, 0))
+#define SYS_PTP_STATUS_PTP_MESS_SEQ_ID_M                  GENMASK(15, 0)
+
+#define SYS_PTP_TXSTAMP_PTP_TXSTAMP(x)                    ((x) & GENMASK(29, 0))
+#define SYS_PTP_TXSTAMP_PTP_TXSTAMP_M                     GENMASK(29, 0)
+#define SYS_PTP_TXSTAMP_PTP_TXSTAMP_SEC                   BIT(31)
+
+#define SYS_PTP_NXT_PTP_NXT                               BIT(0)
+
+#define SYS_PTP_CFG_PTP_STAMP_WID(x)                      (((x) << 2) & GENMASK(7, 2))
+#define SYS_PTP_CFG_PTP_STAMP_WID_M                       GENMASK(7, 2)
+#define SYS_PTP_CFG_PTP_STAMP_WID_X(x)                    (((x) & GENMASK(7, 2)) >> 2)
+#define SYS_PTP_CFG_PTP_CF_ROLL_MODE(x)                   ((x) & GENMASK(1, 0))
+#define SYS_PTP_CFG_PTP_CF_ROLL_MODE_M                    GENMASK(1, 0)
+
+#define SYS_RAM_INIT_RAM_INIT                             BIT(1)
+#define SYS_RAM_INIT_RAM_CFG_HOOK                         BIT(0)
+
+#endif
-- 
2.17.0
