Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Oct 2008 03:11:08 +0100 (BST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:43988 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S21816165AbYJSCHI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Oct 2008 03:07:08 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 3AEE51124073; Sun, 19 Oct 2008 04:07:03 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	jgarzik@pobox.com
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH/RFC v1 09/12] [MIPS] BCM63XX: Add integrated ethernet mac support.
Date:	Sun, 19 Oct 2008 04:07:03 +0200
Message-Id: <1224382023-24388-1-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.5.4.3
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/Makefile                         |    1 +
 arch/mips/bcm63xx/dev-enet.c                       |  158 ++
 .../include/asm/mach-bcm63xx/bcm63xx_dev_enet.h    |   45 +
 drivers/net/Kconfig                                |    9 +
 drivers/net/Makefile                               |    1 +
 drivers/net/bcm63xx_enet.c                         | 1911 ++++++++++++++++++++
 drivers/net/bcm63xx_enet.h                         |  294 +++
 7 files changed, 2419 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-enet.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
 create mode 100644 drivers/net/bcm63xx_enet.c
 create mode 100644 drivers/net/bcm63xx_enet.h

diff --git a/arch/mips/bcm63xx/Makefile b/arch/mips/bcm63xx/Makefile
index 99e335d..5358093 100644
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -3,4 +3,5 @@ obj-y		+= dev-uart.o
 obj-y		+= dev-pcmcia.o
 obj-y		+= dev-usb-ohci.o
 obj-y		+= dev-usb-ehci.o
+obj-y		+= dev-enet.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
diff --git a/arch/mips/bcm63xx/dev-enet.c b/arch/mips/bcm63xx/dev-enet.c
new file mode 100644
index 0000000..51c2e5a
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-enet.c
@@ -0,0 +1,158 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <bcm63xx_dev_enet.h>
+#include <bcm63xx_io.h>
+#include <bcm63xx_regs.h>
+
+static struct resource shared_res[] = {
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device bcm63xx_enet_shared_device = {
+	.name		= "bcm63xx_enet_shared",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(shared_res),
+	.resource	= shared_res,
+};
+
+static int shared_device_registered;
+
+static struct resource enet0_res[] = {
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.start		= IRQ_ENET0_RXDMA,
+		.flags		= IORESOURCE_IRQ,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.start		= IRQ_ENET0_TXDMA,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct bcm63xx_enet_platform_data enet0_pd;
+
+static struct platform_device bcm63xx_enet0_device = {
+	.name		= "bcm63xx_enet",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(enet0_res),
+	.resource	= enet0_res,
+	.dev		= {
+		.platform_data = &enet0_pd,
+	},
+};
+
+static struct resource enet1_res[] = {
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct bcm63xx_enet_platform_data enet1_pd;
+
+static struct platform_device bcm63xx_enet1_device = {
+	.name		= "bcm63xx_enet",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(enet1_res),
+	.resource	= enet1_res,
+	.dev		= {
+		.platform_data = &enet1_pd,
+	},
+};
+
+int __init bcm63xx_enet_register(int unit,
+				 const struct bcm63xx_enet_platform_data *pd)
+{
+	struct platform_device *pdev;
+	struct bcm63xx_enet_platform_data *dpd;
+	int ret;
+
+	if (unit > 1)
+		return -ENODEV;
+
+	if (!shared_device_registered) {
+		shared_res[0].start = bcm63xx_regset_address(RSET_ENETDMA);
+		shared_res[0].end = shared_res[0].start;
+		shared_res[0].end += RSET_ENETDMA_SIZE - 1;
+
+		ret = platform_device_register(&bcm63xx_enet_shared_device);
+		if (ret)
+			return ret;
+		shared_device_registered = 1;
+	}
+
+	if (unit == 0) {
+		enet0_res[0].start = bcm63xx_regset_address(RSET_ENET0);
+		enet0_res[0].end = enet0_res[0].start;
+		enet0_res[0].end += RSET_ENET_SIZE - 1;
+		enet0_res[1].start = bcm63xx_get_irq_number(IRQ_ENET0);
+		enet0_res[2].start = bcm63xx_get_irq_number(IRQ_ENET0_RXDMA);
+		enet0_res[3].start = bcm63xx_get_irq_number(IRQ_ENET0_TXDMA);
+		pdev = &bcm63xx_enet0_device;
+	} else {
+		enet1_res[0].start = bcm63xx_regset_address(RSET_ENET1);
+		enet1_res[0].end = enet1_res[0].start;
+		enet1_res[0].end += RSET_ENET_SIZE - 1;
+		enet1_res[1].start = bcm63xx_get_irq_number(IRQ_ENET1);
+		enet1_res[2].start = bcm63xx_get_irq_number(IRQ_ENET1_RXDMA);
+		enet1_res[3].start = bcm63xx_get_irq_number(IRQ_ENET1_TXDMA);
+		pdev = &bcm63xx_enet1_device;
+	}
+
+	/* copy given platform data */
+	dpd = pdev->dev.platform_data;
+	memcpy(dpd, pd, sizeof(*pd));
+
+	/* adjust them in case internal phy is used */
+	if (dpd->use_internal_phy) {
+
+		/* internal phy only exists for enet0 */
+		if (unit == 1)
+			return -ENODEV;
+
+		dpd->phy_id = 1;
+		dpd->has_phy_interrupt = 1;
+		dpd->phy_interrupt = bcm63xx_get_irq_number(IRQ_ENET_PHY);
+	}
+
+	ret = platform_device_register(pdev);
+	if (ret)
+		return ret;
+	return 0;
+}
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
new file mode 100644
index 0000000..d53f611
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
@@ -0,0 +1,45 @@
+#ifndef BCM63XX_DEV_ENET_H_
+#define BCM63XX_DEV_ENET_H_
+
+#include <linux/if_ether.h>
+#include <linux/init.h>
+
+/*
+ * on board ethernet platform data
+ */
+struct bcm63xx_enet_platform_data {
+	char mac_addr[ETH_ALEN];
+
+	int has_phy;
+
+	/* if has_phy, then set use_internal_phy */
+	int use_internal_phy;
+
+	/* or fill phy info to use an external one */
+	int phy_id;
+	int has_phy_interrupt;
+	int phy_interrupt;
+
+	/* if has_phy, use autonegociated pause parameters or force
+	 * them */
+	int pause_auto;
+	int pause_rx;
+	int pause_tx;
+
+	/* if !has_phy, set desired forced speed/duplex */
+	int force_speed_100;
+	int force_duplex_full;
+
+	/* if !has_phy, set callback to perform mii device
+	 * init/remove */
+	int (*mii_config)(struct net_device *dev, int probe,
+			  int (*mii_read)(struct net_device *dev,
+					  int phy_id, int reg),
+			  void (*mii_write)(struct net_device *dev,
+					    int phy_id, int reg, int val));
+};
+
+int __init bcm63xx_enet_register(int unit,
+				 const struct bcm63xx_enet_platform_data *pd);
+
+#endif /* ! BCM63XX_DEV_ENET_H_ */
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index abd50ef..f0c6a02 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1857,6 +1857,15 @@ config ATL2
 	  To compile this driver as a module, choose M here.  The module
 	  will be called atl2.
 
+config BCM63XX_ENET
+	tristate "Broadcom 63xx internal mac support"
+	depends on BCM63XX
+	select MII
+	select PHYLIB
+	help
+	  This driver supports the ethernet MACs in the Broadcom 63xx
+	  MIPS chipset family (BCM63XX).
+
 source "drivers/net/fs_enet/Kconfig"
 
 endif # NET_ETHERNET
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index ba2d4a7..7fd3fd6 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -126,6 +126,7 @@ obj-$(CONFIG_SB1250_MAC) += sb1250-mac.o
 obj-$(CONFIG_B44) += b44.o
 obj-$(CONFIG_FORCEDETH) += forcedeth.o
 obj-$(CONFIG_NE_H8300) += ne-h8300.o
+obj-$(CONFIG_BCM63XX_ENET) += bcm63xx_enet.o
 obj-$(CONFIG_AX88796) += ax88796.o
 
 obj-$(CONFIG_TSI108_ETH) += tsi108_eth.o
diff --git a/drivers/net/bcm63xx_enet.c b/drivers/net/bcm63xx_enet.c
new file mode 100644
index 0000000..aee330b
--- /dev/null
+++ b/drivers/net/bcm63xx_enet.c
@@ -0,0 +1,1911 @@
+/*
+ * Driver for BCM963xx builtin Ethernet mac
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/etherdevice.h>
+#include <linux/delay.h>
+#include <linux/ethtool.h>
+#include <linux/crc32.h>
+#include <linux/err.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+
+#include <bcm63xx_dev_enet.h>
+#include "bcm63xx_enet.h"
+
+static char bcm_enet_driver_name[] = "bcm63xx_enet";
+static char bcm_enet_driver_version[] = "1.0";
+
+static int copybreak __read_mostly = 128;
+module_param(copybreak, int, 0);
+MODULE_PARM_DESC(copybreak, "Receive copy threshold");
+
+/* io memory shared between all devices */
+static void __iomem *bcm_enet_shared_base;
+
+/*
+ * io helpers to access mac registers
+ */
+static inline u32 enet_readl(struct bcm_enet_priv *priv, u32 off)
+{
+	return bcm_readl(priv->base + off);
+}
+
+static inline void enet_writel(struct bcm_enet_priv *priv,
+			       u32 val, u32 off)
+{
+	bcm_writel(val, priv->base + off);
+}
+
+/*
+ * io helpers to access shared registers
+ */
+static inline u32 enet_dma_readl(struct bcm_enet_priv *priv, u32 off)
+{
+	return bcm_readl(bcm_enet_shared_base + off);
+}
+
+static inline void enet_dma_writel(struct bcm_enet_priv *priv,
+				       u32 val, u32 off)
+{
+	bcm_writel(val, bcm_enet_shared_base + off);
+}
+
+/*
+ * write given data into mii register and wait for transfer to end
+ * with timeout (average measured transfer time is 25us)
+ */
+static int do_mdio_op(struct bcm_enet_priv *priv, unsigned int data)
+{
+	int limit;
+
+	/* make sure mii interrupt status is cleared */
+	enet_writel(priv, ENET_IR_MII, ENET_IR_REG);
+
+	enet_writel(priv, data, ENET_MIIDATA_REG);
+	wmb();
+
+	/* busy wait on mii interrupt bit, with timeout */
+	limit = 1000;
+	do {
+		if (enet_readl(priv, ENET_IR_REG) & ENET_IR_MII)
+			break;
+		udelay(1);
+	} while (limit-- >= 0);
+
+	return (limit < 0) ? 1 : 0;
+}
+
+/*
+ * MII internal read callback
+ */
+static int bcm_enet_mdio_read(struct bcm_enet_priv *priv, int mii_id,
+			      int regnum)
+{
+	u32 tmp, val;
+
+	tmp = regnum << ENET_MIIDATA_REG_SHIFT;
+	tmp |= 0x2 << ENET_MIIDATA_TA_SHIFT;
+	tmp |= mii_id << ENET_MIIDATA_PHYID_SHIFT;
+	tmp |= ENET_MIIDATA_OP_READ_MASK;
+
+	if (do_mdio_op(priv, tmp))
+		return -1;
+
+	val = enet_readl(priv, ENET_MIIDATA_REG);
+	val &= 0xffff;
+	return val;
+}
+
+/*
+ * MII internal write callback
+ */
+static int bcm_enet_mdio_write(struct bcm_enet_priv *priv, int mii_id,
+			       int regnum, u16 value)
+{
+	u32 tmp;
+
+	tmp = (value & 0xffff) << ENET_MIIDATA_DATA_SHIFT;
+	tmp |= 0x2 << ENET_MIIDATA_TA_SHIFT;
+	tmp |= regnum << ENET_MIIDATA_REG_SHIFT;
+	tmp |= mii_id << ENET_MIIDATA_PHYID_SHIFT;
+	tmp |= ENET_MIIDATA_OP_WRITE_MASK;
+
+	(void)do_mdio_op(priv, tmp);
+	return 0;
+}
+
+/*
+ * MII read callback from phylib
+ */
+static int bcm_enet_mdio_read_phylib(struct mii_bus *bus, int mii_id,
+				     int regnum)
+{
+	return bcm_enet_mdio_read(bus->priv, mii_id, regnum);
+}
+
+/*
+ * MII write callback from phylib
+ */
+static int bcm_enet_mdio_write_phylib(struct mii_bus *bus, int mii_id,
+				      int regnum, u16 value)
+{
+	return bcm_enet_mdio_write(bus->priv, mii_id, regnum, value);
+}
+
+/*
+ * MII read callback from mii core
+ */
+static int bcm_enet_mdio_read_mii(struct net_device *dev, int mii_id,
+				  int regnum)
+{
+	return bcm_enet_mdio_read(netdev_priv(dev), mii_id, regnum);
+}
+
+/*
+ * MII write callback from mii core
+ */
+static void bcm_enet_mdio_write_mii(struct net_device *dev, int mii_id,
+				    int regnum, int value)
+{
+	bcm_enet_mdio_write(netdev_priv(dev), mii_id, regnum, value);
+}
+
+/*
+ * refill rx queue
+ */
+static int bcm_enet_refill_rx(struct net_device *dev)
+{
+	struct bcm_enet_priv *priv;
+
+	priv = netdev_priv(dev);
+
+	while (priv->rx_desc_count < priv->rx_ring_size) {
+		struct bcm_enet_desc *desc;
+		struct sk_buff *skb;
+		dma_addr_t p;
+		int desc_idx;
+		u32 len_stat;
+
+		desc_idx = priv->rx_dirty_desc;
+		desc = &priv->rx_desc_cpu[desc_idx];
+
+		if (!priv->rx_skb[desc_idx]) {
+			skb = netdev_alloc_skb(dev, BCMENET_MAX_RX_SIZE);
+			if (!skb)
+				break;
+			priv->rx_skb[desc_idx] = skb;
+
+			p = dma_map_single(&priv->pdev->dev, skb->data,
+					   BCMENET_MAX_RX_SIZE,
+					   DMA_FROM_DEVICE);
+			desc->address = p;
+		}
+
+		len_stat = BCMENET_MAX_RX_SIZE << DMADESC_LENGTH_SHIFT;
+		len_stat |= DMADESC_OWNER_MASK;
+		if (priv->rx_dirty_desc == priv->rx_ring_size - 1) {
+			len_stat |= DMADESC_WRAP_MASK;
+			priv->rx_dirty_desc = 0;
+		} else {
+			priv->rx_dirty_desc++;
+		}
+		wmb();
+		desc->len_stat = len_stat;
+
+		priv->rx_desc_count++;
+
+		/* tell dma engine we allocated one buffer */
+		enet_dma_writel(priv, 1, ENETDMA_BUFALLOC_REG(priv->rx_chan));
+	}
+
+	/* If rx ring is still empty, set a timer to try allocating
+	 * again at a later time. */
+	if (priv->rx_desc_count == 0 && netif_running(dev)) {
+		dev_warn(&priv->pdev->dev, "unable to refill rx ring\n");
+		priv->rx_timeout.expires = jiffies + HZ;
+		add_timer(&priv->rx_timeout);
+	}
+
+	return 0;
+}
+
+/*
+ * timer callback to defer refill rx queue in case we're OOM
+ */
+static void bcm_enet_refill_rx_timer(unsigned long data)
+{
+	struct net_device *dev;
+	struct bcm_enet_priv *priv;
+
+	dev = (struct net_device *)data;
+	priv = netdev_priv(dev);
+
+	spin_lock(&priv->rx_lock);
+	bcm_enet_refill_rx((struct net_device *)data);
+	spin_unlock(&priv->rx_lock);
+}
+
+/*
+ * extract packet from rx queue
+ */
+static int bcm_enet_receive_queue(struct net_device *dev, int budget)
+{
+	struct bcm_enet_priv *priv;
+	struct device *kdev;
+	int processed;
+
+	priv = netdev_priv(dev);
+	kdev = &priv->pdev->dev;
+	processed = 0;
+
+	/* don't scan ring further than number of refilled
+	 * descriptor */
+	if (budget > priv->rx_desc_count)
+		budget = priv->rx_desc_count;
+
+	do {
+		struct bcm_enet_desc *desc;
+		struct sk_buff *skb;
+		int desc_idx;
+		u32 len_stat;
+		unsigned int len;
+
+		desc_idx = priv->rx_curr_desc;
+		desc = &priv->rx_desc_cpu[desc_idx];
+
+		/* make sure we actually read the descriptor status at
+		 * each loop */
+		rmb();
+
+		len_stat = desc->len_stat;
+
+		/* break if dma ownership belongs to hw */
+		if (len_stat & DMADESC_OWNER_MASK)
+			break;
+
+		processed++;
+		priv->rx_curr_desc++;
+		if (priv->rx_curr_desc == priv->rx_ring_size)
+			priv->rx_curr_desc = 0;
+		priv->rx_desc_count--;
+
+		/* if the packet does not have start of packet _and_
+		 * end of packet flag set, then just recycle it */
+		if ((len_stat & DMADESC_ESOP_MASK) != DMADESC_ESOP_MASK) {
+			priv->stats.rx_dropped++;
+			continue;
+		}
+
+		/* recycle packet if it's marked as bad */
+		if (unlikely(len_stat & DMADESC_ERR_MASK)) {
+			priv->stats.rx_errors++;
+
+			if (len_stat & DMADESC_OVSIZE_MASK)
+				priv->stats.rx_length_errors++;
+			if (len_stat & DMADESC_CRC_MASK)
+				priv->stats.rx_crc_errors++;
+			if (len_stat & DMADESC_UNDER_MASK)
+				priv->stats.rx_frame_errors++;
+			if (len_stat & DMADESC_OV_MASK)
+				priv->stats.rx_fifo_errors++;
+			continue;
+		}
+
+		/* valid packet */
+		skb = priv->rx_skb[desc_idx];
+		len = (len_stat & DMADESC_LENGTH_MASK) >> DMADESC_LENGTH_SHIFT;
+		/* don't include FCS */
+		len -= 4;
+
+		if (len < copybreak) {
+			struct sk_buff *nskb;
+
+			nskb = netdev_alloc_skb(dev, len + 2);
+			if (!nskb) {
+				/* forget packet, just rearm desc */
+				priv->stats.rx_dropped++;
+				continue;
+			}
+
+			/* since we're copying the data, we can align
+			 * them properly */
+			skb_reserve(nskb, NET_IP_ALIGN);
+			dma_sync_single_for_cpu(kdev, desc->address,
+						len, DMA_FROM_DEVICE);
+			memcpy(nskb->data, skb->data, len);
+			dma_sync_single_for_device(kdev, desc->address,
+						   len, DMA_FROM_DEVICE);
+			skb = nskb;
+		} else {
+			dma_unmap_single(&priv->pdev->dev, desc->address,
+					 BCMENET_MAX_RX_SIZE, DMA_FROM_DEVICE);
+			priv->rx_skb[desc_idx] = NULL;
+		}
+
+		skb_put(skb, len);
+		skb->dev = dev;
+		skb->protocol = eth_type_trans(skb, dev);
+		priv->stats.rx_packets++;
+		priv->stats.rx_bytes += len;
+		dev->last_rx = jiffies;
+		netif_receive_skb(skb);
+
+	} while (--budget > 0);
+
+	if (processed || !priv->rx_desc_count) {
+		bcm_enet_refill_rx(dev);
+
+		/* kick rx dma */
+		enet_dma_writel(priv, ENETDMA_CHANCFG_EN_MASK,
+				ENETDMA_CHANCFG_REG(priv->rx_chan));
+	}
+
+	return processed;
+}
+
+
+/*
+ * try to or force reclaim of transmitted buffers
+ */
+static int bcm_enet_tx_reclaim(struct net_device *dev, int force)
+{
+	struct bcm_enet_priv *priv;
+	int released;
+
+	priv = netdev_priv(dev);
+	released = 0;
+
+	while (priv->tx_desc_count < priv->tx_ring_size) {
+		struct bcm_enet_desc *desc;
+		struct sk_buff *skb;
+
+		/* We run in a bh and fight against start_xmit, which
+		 * is called with bh disabled  */
+		spin_lock(&priv->tx_lock);
+
+		desc = &priv->tx_desc_cpu[priv->tx_dirty_desc];
+
+		if (!force && (desc->len_stat & DMADESC_OWNER_MASK)) {
+			spin_unlock(&priv->tx_lock);
+			break;
+		}
+
+		/* ensure other field of the descriptor were not read
+		 * before we checked ownership */
+		rmb();
+
+		skb = priv->tx_skb[priv->tx_dirty_desc];
+		priv->tx_skb[priv->tx_dirty_desc] = NULL;
+		dma_unmap_single(&priv->pdev->dev, desc->address, skb->len,
+				 DMA_TO_DEVICE);
+
+		priv->tx_dirty_desc++;
+		if (priv->tx_dirty_desc == priv->tx_ring_size)
+			priv->tx_dirty_desc = 0;
+		priv->tx_desc_count++;
+
+		spin_unlock(&priv->tx_lock);
+
+		if (desc->len_stat & DMADESC_UNDER_MASK)
+			priv->stats.tx_errors++;
+
+		dev_kfree_skb(skb);
+		released++;
+	}
+
+	if (netif_queue_stopped(dev) && released)
+		netif_wake_queue(dev);
+
+	return released;
+}
+
+/*
+ * poll func, called by network core
+ */
+static int bcm_enet_poll(struct napi_struct *napi, int budget)
+{
+	struct bcm_enet_priv *priv;
+	struct net_device *dev;
+	int tx_work_done, rx_work_done;
+
+	priv = container_of(napi, struct bcm_enet_priv, napi);
+	dev = priv->net_dev;
+
+	/* ack interrupts */
+	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
+			ENETDMA_IR_REG(priv->rx_chan));
+	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
+			ENETDMA_IR_REG(priv->tx_chan));
+
+	/* reclaim sent skb */
+	tx_work_done = bcm_enet_tx_reclaim(dev, 0);
+
+	spin_lock(&priv->rx_lock);
+	rx_work_done = bcm_enet_receive_queue(dev, budget);
+	spin_unlock(&priv->rx_lock);
+
+	if (rx_work_done >= budget || tx_work_done > 0) {
+		/* rx/tx queue is not yet empty/clean */
+		return rx_work_done;
+	}
+
+	/* no more packet in rx/tx queue, remove device from poll
+	 * queue */
+	__netif_rx_complete(dev, napi);
+
+	/* restore rx/tx interrupt */
+	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
+			ENETDMA_IRMASK_REG(priv->rx_chan));
+	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
+			ENETDMA_IRMASK_REG(priv->tx_chan));
+
+	return rx_work_done;
+}
+
+/*
+ * mac interrupt handler
+ */
+static irqreturn_t bcm_enet_isr_mac(int irq, void *dev_id)
+{
+	struct net_device *dev;
+	struct bcm_enet_priv *priv;
+	u32 stat;
+
+	dev = dev_id;
+	priv = netdev_priv(dev);
+
+	stat = enet_readl(priv, ENET_IR_REG);
+	if (!(stat & ENET_IR_MIB))
+		return IRQ_NONE;
+
+	/* clear & mask interrupt */
+	enet_writel(priv, ENET_IR_MIB, ENET_IR_REG);
+	enet_writel(priv, 0, ENET_IRMASK_REG);
+
+	/* read mib registers in workqueue */
+	schedule_work(&priv->mib_update_task);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * rx/tx dma interrupt handler
+ */
+static irqreturn_t bcm_enet_isr_dma(int irq, void *dev_id)
+{
+	struct net_device *dev;
+	struct bcm_enet_priv *priv;
+
+	dev = dev_id;
+	priv = netdev_priv(dev);
+
+	/* mask rx/tx interrupts */
+	enet_dma_writel(priv, 0, ENETDMA_IRMASK_REG(priv->rx_chan));
+	enet_dma_writel(priv, 0, ENETDMA_IRMASK_REG(priv->tx_chan));
+
+	netif_rx_schedule(dev, &priv->napi);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * tx request callback
+ */
+static int bcm_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct bcm_enet_priv *priv;
+	struct bcm_enet_desc *desc;
+	u32 len_stat;
+	int ret;
+
+	priv = netdev_priv(dev);
+
+	/* lock against tx reclaim */
+	spin_lock(&priv->tx_lock);
+
+	/* make sure  the tx hw queue  is not full,  should not happen
+	 * since we stop queue before it's the case */
+	if (unlikely(!priv->tx_desc_count)) {
+		netif_stop_queue(dev);
+		dev_err(&priv->pdev->dev, "xmit called with no tx desc "
+			"available?\n");
+		ret = NETDEV_TX_BUSY;
+		goto out_unlock;
+	}
+
+	/* point to the next available desc */
+	desc = &priv->tx_desc_cpu[priv->tx_curr_desc];
+	priv->tx_skb[priv->tx_curr_desc] = skb;
+
+	/* fill descriptor */
+	desc->address = dma_map_single(&priv->pdev->dev, skb->data, skb->len,
+				       DMA_TO_DEVICE);
+
+	len_stat = (skb->len << DMADESC_LENGTH_SHIFT) & DMADESC_LENGTH_MASK;
+	len_stat |= DMADESC_ESOP_MASK |
+		DMADESC_APPEND_CRC |
+		DMADESC_OWNER_MASK;
+
+	priv->tx_curr_desc++;
+	if (priv->tx_curr_desc == priv->tx_ring_size) {
+		priv->tx_curr_desc = 0;
+		len_stat |= DMADESC_WRAP_MASK;
+	}
+	priv->tx_desc_count--;
+
+	/* dma might be already polling, make sure we update desc
+	 * fields in correct order */
+	wmb();
+	desc->len_stat = len_stat;
+	wmb();
+
+	/* kick tx dma */
+	enet_dma_writel(priv, ENETDMA_CHANCFG_EN_MASK,
+			ENETDMA_CHANCFG_REG(priv->tx_chan));
+
+	/* stop queue if no more desc available */
+	if (!priv->tx_desc_count)
+		netif_stop_queue(dev);
+
+	priv->stats.tx_bytes += skb->len;
+	priv->stats.tx_packets++;
+	dev->trans_start = jiffies;
+	ret = NETDEV_TX_OK;
+
+out_unlock:
+	spin_unlock(&priv->tx_lock);
+	return ret;
+}
+
+/*
+ * Change the interface's mac address.
+ */
+static int bcm_enet_set_mac_address(struct net_device *dev, void *p)
+{
+	struct bcm_enet_priv *priv;
+	struct sockaddr *addr = p;
+	u32 val;
+
+	priv = netdev_priv(dev);
+	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
+
+	/* use perfect match register 0 to store my mac address */
+	val = (dev->dev_addr[2] << 24) | (dev->dev_addr[3] << 16) |
+		(dev->dev_addr[4] << 8) | dev->dev_addr[5];
+	enet_writel(priv, val, ENET_PML_REG(0));
+
+	val = (dev->dev_addr[0] << 8 | dev->dev_addr[1]);
+	val |= ENET_PMH_DATAVALID_MASK;
+	enet_writel(priv, val, ENET_PMH_REG(0));
+
+	return 0;
+}
+
+/*
+ * Change rx mode (promiscous/allmulti) and update multicast list
+ */
+static void bcm_enet_set_multicast_list(struct net_device *dev)
+{
+	struct bcm_enet_priv *priv;
+	struct dev_mc_list *mc_list;
+	u32 val;
+	int i;
+
+	priv = netdev_priv(dev);
+
+	val = enet_readl(priv, ENET_RXCFG_REG);
+
+	if (dev->flags & IFF_PROMISC)
+		val |= ENET_RXCFG_PROMISC_MASK;
+	else
+		val &= ~ENET_RXCFG_PROMISC_MASK;
+
+	/* only 3 perfect match registers left, first one is used for
+	 * own mac address */
+	if ((dev->flags & IFF_ALLMULTI) || dev->mc_count > 3)
+		val |= ENET_RXCFG_ALLMCAST_MASK;
+	else
+		val &= ~ENET_RXCFG_ALLMCAST_MASK;
+
+	/* no need to set perfect match registers if we catch all
+	 * multicast */
+	if (val & ENET_RXCFG_ALLMCAST_MASK) {
+		enet_writel(priv, val, ENET_RXCFG_REG);
+		return;
+	}
+
+	for (i = 0, mc_list = dev->mc_list;
+	     (mc_list != NULL) && (i < dev->mc_count) && (i < 3);
+	     i++, mc_list = mc_list->next) {
+		u8 *dmi_addr;
+		u32 tmp;
+
+		/* filter non ethernet address */
+		if (mc_list->dmi_addrlen != 6)
+			continue;
+
+		/* update perfect match registers */
+		dmi_addr = mc_list->dmi_addr;
+		tmp = (dmi_addr[2] << 24) | (dmi_addr[3] << 16) |
+			(dmi_addr[4] << 8) | dmi_addr[5];
+		enet_writel(priv, tmp, ENET_PML_REG(i + 1));
+
+		tmp = (dmi_addr[0] << 8 | dmi_addr[1]);
+		tmp |= ENET_PMH_DATAVALID_MASK;
+		enet_writel(priv, tmp, ENET_PMH_REG(i + 1));
+	}
+
+	for (; i < 3; i++) {
+		enet_writel(priv, 0, ENET_PML_REG(i + 1));
+		enet_writel(priv, 0, ENET_PMH_REG(i + 1));
+	}
+
+	enet_writel(priv, val, ENET_RXCFG_REG);
+}
+
+/*
+ * set mac duplex parameters
+ */
+static void bcm_enet_set_duplex(struct bcm_enet_priv *priv, int fullduplex)
+{
+	u32 val;
+
+	val = enet_readl(priv, ENET_TXCTL_REG);
+	if (fullduplex)
+		val |= ENET_TXCTL_FD_MASK;
+	else
+		val &= ~ENET_TXCTL_FD_MASK;
+	enet_writel(priv, val, ENET_TXCTL_REG);
+}
+
+/*
+ * set mac flow control parameters
+ */
+static void bcm_enet_set_flow(struct bcm_enet_priv *priv, int rx_en, int tx_en)
+{
+	u32 val;
+
+	/* rx flow control (pause frame handling) */
+	val = enet_readl(priv, ENET_RXCFG_REG);
+	if (rx_en)
+		val |= ENET_RXCFG_ENFLOW_MASK;
+	else
+		val &= ~ENET_RXCFG_ENFLOW_MASK;
+	enet_writel(priv, val, ENET_RXCFG_REG);
+
+	/* tx flow control (pause frame generation) */
+	val = enet_dma_readl(priv, ENETDMA_CFG_REG);
+	if (tx_en)
+		val |= ENETDMA_CFG_FLOWCH_MASK(priv->rx_chan);
+	else
+		val &= ~ENETDMA_CFG_FLOWCH_MASK(priv->rx_chan);
+	enet_dma_writel(priv, val, ENETDMA_CFG_REG);
+}
+
+/*
+ * link changed callback (from phylib)
+ */
+static void bcm_enet_adjust_phy_link(struct net_device *dev)
+{
+	struct bcm_enet_priv *priv;
+	struct phy_device *phydev;
+	int status_changed;
+
+	priv = netdev_priv(dev);
+	phydev = priv->phydev;
+	status_changed = 0;
+
+	if (priv->old_link != phydev->link) {
+		status_changed = 1;
+		priv->old_link = phydev->link;
+	}
+
+	/* reflect duplex change in mac configuration */
+	if (phydev->link && phydev->duplex != priv->old_duplex) {
+		bcm_enet_set_duplex(priv,
+				    (phydev->duplex == DUPLEX_FULL) ? 1 : 0);
+		status_changed = 1;
+		priv->old_duplex = phydev->duplex;
+	}
+
+	/* enable flow control if remote advertise it (trust phylib to
+	 * check that duplex is full */
+	if (phydev->link && phydev->pause != priv->old_pause) {
+		int rx_pause_en, tx_pause_en;
+
+		if (phydev->pause) {
+			/* pause was advertised by lpa and us */
+			rx_pause_en = 1;
+			tx_pause_en = 1;
+		} else if (!priv->pause_auto) {
+			/* pause setting overrided by user */
+			rx_pause_en = priv->pause_rx;
+			tx_pause_en = priv->pause_tx;
+		} else {
+			rx_pause_en = 0;
+			tx_pause_en = 0;
+		}
+
+		bcm_enet_set_flow(priv, rx_pause_en, tx_pause_en);
+		status_changed = 1;
+		priv->old_pause = phydev->pause;
+	}
+
+	if (status_changed) {
+		pr_info("%s: link %s", dev->name, phydev->link ?
+			"UP" : "DOWN");
+		if (phydev->link)
+			printk(" - %d/%s - flow control %s", phydev->speed,
+			       DUPLEX_FULL == phydev->duplex ? "full" : "half",
+			       phydev->pause == 1 ? "rx&tx" : "off");
+
+		printk("\n");
+	}
+}
+
+/*
+ * link changed callback (if phylib is not used)
+ */
+static void bcm_enet_adjust_link(struct net_device *dev)
+{
+	struct bcm_enet_priv *priv;
+
+	priv = netdev_priv(dev);
+	bcm_enet_set_duplex(priv, priv->force_duplex_full);
+	bcm_enet_set_flow(priv, priv->pause_rx, priv->pause_tx);
+	netif_carrier_on(dev);
+
+	pr_info("%s: link forced UP - %d/%s - flow control %s/%s\n",
+		dev->name,
+		priv->force_speed_100 ? 100 : 10,
+		priv->force_duplex_full ? "full" : "half",
+		priv->pause_rx ? "rx" : "off",
+		priv->pause_tx ? "tx" : "off");
+}
+
+/*
+ * open callback, allocate dma rings & buffers and start rx operation
+ */
+static int bcm_enet_open(struct net_device *dev)
+{
+	struct bcm_enet_priv *priv;
+	struct sockaddr addr;
+	struct device *kdev;
+	struct phy_device *phydev;
+	int i, ret;
+	unsigned int size;
+	char phy_id[BUS_ID_SIZE];
+	void *p;
+	u32 val;
+
+	priv = netdev_priv(dev);
+	kdev = &priv->pdev->dev;
+
+	if (priv->has_phy) {
+		/* connect to PHY */
+		snprintf(phy_id, BUS_ID_SIZE, PHY_ID_FMT,
+			 priv->mac_id ? "1" : "0", priv->phy_id);
+
+		phydev = phy_connect(dev, phy_id, &bcm_enet_adjust_phy_link, 0,
+				     PHY_INTERFACE_MODE_MII);
+
+		if (IS_ERR(phydev)) {
+			dev_err(kdev, "could not attach to PHY\n");
+			return PTR_ERR(phydev);
+		}
+
+		/* mask with MAC supported features */
+		phydev->supported &= (SUPPORTED_10baseT_Half |
+				      SUPPORTED_10baseT_Full |
+				      SUPPORTED_100baseT_Half |
+				      SUPPORTED_100baseT_Full |
+				      SUPPORTED_Autoneg |
+				      SUPPORTED_Pause |
+				      SUPPORTED_MII);
+		phydev->advertising = phydev->supported;
+
+		if (priv->pause_auto && priv->pause_rx && priv->pause_tx)
+			phydev->advertising |= SUPPORTED_Pause;
+		else
+			phydev->advertising &= ~SUPPORTED_Pause;
+
+		dev_info(kdev, "attached PHY at address %d [%s]\n",
+			 phydev->addr, phydev->drv->name);
+
+		priv->old_link = 0;
+		priv->old_duplex = -1;
+		priv->old_pause = -1;
+		priv->phydev = phydev;
+	}
+
+	/* mask all interrupts and request them */
+	enet_writel(priv, 0, ENET_IRMASK_REG);
+	enet_dma_writel(priv, 0, ENETDMA_IRMASK_REG(priv->rx_chan));
+	enet_dma_writel(priv, 0, ENETDMA_IRMASK_REG(priv->tx_chan));
+
+	ret = request_irq(dev->irq, bcm_enet_isr_mac, 0, dev->name, dev);
+	if (ret)
+		goto out_phy_disconnect;
+
+	ret = request_irq(priv->irq_rx, bcm_enet_isr_dma,
+			  IRQF_SAMPLE_RANDOM | IRQF_DISABLED, dev->name, dev);
+	if (ret)
+		goto out_freeirq;
+
+	ret = request_irq(priv->irq_tx, bcm_enet_isr_dma,
+			  IRQF_DISABLED, dev->name, dev);
+	if (ret)
+		goto out_freeirq_rx;
+
+	/* initialize perfect match registers */
+	for (i = 0; i < 4; i++) {
+		enet_writel(priv, 0, ENET_PML_REG(i));
+		enet_writel(priv, 0, ENET_PMH_REG(i));
+	}
+
+	/* write device mac address */
+	memcpy(addr.sa_data, dev->dev_addr, ETH_ALEN);
+	bcm_enet_set_mac_address(dev, &addr);
+
+	/* allocate rx dma ring */
+	size = priv->rx_ring_size * sizeof(struct bcm_enet_desc);
+	p = dma_alloc_coherent(kdev, size, &priv->rx_desc_dma, GFP_KERNEL);
+	if (!p) {
+		dev_err(kdev, "cannot allocate rx ring %u\n", size);
+		ret = -ENOMEM;
+		goto out_freeirq_tx;
+	}
+
+	memset(p, 0, size);
+	priv->rx_desc_alloc_size = size;
+	priv->rx_desc_cpu = p;
+
+	/* allocate tx dma ring */
+	size = priv->tx_ring_size * sizeof(struct bcm_enet_desc);
+	p = dma_alloc_coherent(kdev, size, &priv->tx_desc_dma, GFP_KERNEL);
+	if (!p) {
+		dev_err(kdev, "cannot allocate tx ring\n");
+		ret = -ENOMEM;
+		goto out_free_rx_ring;
+	}
+
+	memset(p, 0, size);
+	priv->tx_desc_alloc_size = size;
+	priv->tx_desc_cpu = p;
+
+	priv->tx_skb = kzalloc(sizeof(struct sk_buff *) * priv->tx_ring_size,
+			       GFP_KERNEL);
+	if (!priv->tx_skb) {
+		dev_err(kdev, "cannot allocate rx skb queue\n");
+		ret = -ENOMEM;
+		goto out_free_tx_ring;
+	}
+
+	priv->tx_desc_count = priv->tx_ring_size;
+	priv->tx_dirty_desc = 0;
+	priv->tx_curr_desc = 0;
+	spin_lock_init(&priv->tx_lock);
+
+	/* init & fill rx ring with skbs */
+	priv->rx_skb = kzalloc(sizeof(struct sk_buff *) * priv->rx_ring_size,
+			       GFP_KERNEL);
+	if (!priv->rx_skb) {
+		dev_err(kdev, "cannot allocate rx skb queue\n");
+		ret = -ENOMEM;
+		goto out_free_tx_skb;
+	}
+
+	priv->rx_desc_count = 0;
+	priv->rx_dirty_desc = 0;
+	priv->rx_curr_desc = 0;
+
+	/* initialize flow control buffer allocation */
+	enet_dma_writel(priv, ENETDMA_BUFALLOC_FORCE_MASK | 0,
+			ENETDMA_BUFALLOC_REG(priv->rx_chan));
+
+	if (bcm_enet_refill_rx(dev)) {
+		dev_err(kdev, "cannot allocate rx skb queue\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* write rx & tx ring addresses */
+	enet_dma_writel(priv, priv->rx_desc_dma,
+			ENETDMA_RSTART_REG(priv->rx_chan));
+	enet_dma_writel(priv, priv->tx_desc_dma,
+			ENETDMA_RSTART_REG(priv->tx_chan));
+
+	/* clear remaining state ram for rx & tx channel */
+	enet_dma_writel(priv, 0, ENETDMA_SRAM2_REG(priv->rx_chan));
+	enet_dma_writel(priv, 0, ENETDMA_SRAM2_REG(priv->tx_chan));
+	enet_dma_writel(priv, 0, ENETDMA_SRAM3_REG(priv->rx_chan));
+	enet_dma_writel(priv, 0, ENETDMA_SRAM3_REG(priv->tx_chan));
+	enet_dma_writel(priv, 0, ENETDMA_SRAM4_REG(priv->rx_chan));
+	enet_dma_writel(priv, 0, ENETDMA_SRAM4_REG(priv->tx_chan));
+
+	/* set max rx/tx length */
+	enet_writel(priv, BCMENET_MAX_RX_SIZE, ENET_RXMAXLEN_REG);
+	enet_writel(priv, BCMENET_MAX_TX_SIZE, ENET_TXMAXLEN_REG);
+
+	/* set dma maximum burst len */
+	enet_dma_writel(priv, BCMENET_DMA_MAXBURST,
+			ENETDMA_MAXBURST_REG(priv->rx_chan));
+	enet_dma_writel(priv, BCMENET_DMA_MAXBURST,
+			ENETDMA_MAXBURST_REG(priv->tx_chan));
+
+	/* set correct transmit fifo watermark */
+	enet_writel(priv, BCMENET_TX_FIFO_TRESH, ENET_TXWMARK_REG);
+
+	/* set flow control low/high threshold to 1/3 / 2/3 */
+	val = priv->rx_ring_size / 3;
+	enet_dma_writel(priv, val, ENETDMA_FLOWCL_REG(priv->rx_chan));
+	val = (priv->rx_ring_size * 2) / 3;
+	enet_dma_writel(priv, val, ENETDMA_FLOWCH_REG(priv->rx_chan));
+
+	/* all set, enable mac and interrupts, start dma engine and
+	 * kick rx dma channel */
+	wmb();
+	enet_writel(priv, ENET_CTL_ENABLE_MASK, ENET_CTL_REG);
+	enet_dma_writel(priv, ENETDMA_CFG_EN_MASK, ENETDMA_CFG_REG);
+	enet_dma_writel(priv, ENETDMA_CHANCFG_EN_MASK,
+			ENETDMA_CHANCFG_REG(priv->rx_chan));
+
+	/* watch "mib counters about to overflow" interrupt */
+	enet_writel(priv, ENET_IR_MIB, ENET_IR_REG);
+	enet_writel(priv, ENET_IR_MIB, ENET_IRMASK_REG);
+
+	/* watch "packet transferred" interrupt in rx and tx */
+	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
+			ENETDMA_IR_REG(priv->rx_chan));
+	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
+			ENETDMA_IR_REG(priv->tx_chan));
+
+	/* make sure we enable napi before rx interrupt  */
+	napi_enable(&priv->napi);
+
+	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
+			ENETDMA_IRMASK_REG(priv->rx_chan));
+	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
+			ENETDMA_IRMASK_REG(priv->tx_chan));
+
+	if (priv->has_phy)
+		phy_start(priv->phydev);
+	else
+		bcm_enet_adjust_link(dev);
+
+	netif_start_queue(dev);
+	return 0;
+
+out:
+	for (i = 0; i < priv->rx_ring_size; i++) {
+		struct bcm_enet_desc *desc;
+
+		if (!priv->rx_skb[i])
+			continue;
+
+		desc = &priv->rx_desc_cpu[i];
+		dma_unmap_single(kdev, desc->address, BCMENET_MAX_RX_SIZE,
+				 DMA_FROM_DEVICE);
+		kfree_skb(priv->rx_skb[i]);
+	}
+	kfree(priv->rx_skb);
+
+out_free_tx_skb:
+	kfree(priv->tx_skb);
+
+out_free_tx_ring:
+	dma_free_coherent(kdev, priv->tx_desc_alloc_size,
+			  priv->tx_desc_cpu, priv->tx_desc_dma);
+
+out_free_rx_ring:
+	dma_free_coherent(kdev, priv->rx_desc_alloc_size,
+			  priv->rx_desc_cpu, priv->rx_desc_dma);
+
+out_freeirq_tx:
+	free_irq(priv->irq_tx, dev);
+
+out_freeirq_rx:
+	free_irq(priv->irq_rx, dev);
+
+out_freeirq:
+	free_irq(dev->irq, dev);
+
+out_phy_disconnect:
+	phy_disconnect(priv->phydev);
+
+	return ret;
+}
+
+/*
+ * disable mac
+ */
+static void bcm_enet_disable_mac(struct bcm_enet_priv *priv)
+{
+	int limit;
+	u32 val;
+
+	val = enet_readl(priv, ENET_CTL_REG);
+	val |= ENET_CTL_DISABLE_MASK;
+	enet_writel(priv, val, ENET_CTL_REG);
+
+	limit = 1000;
+	do {
+		u32 val;
+
+		val = enet_readl(priv, ENET_CTL_REG);
+		if (!(val & ENET_CTL_DISABLE_MASK))
+			break;
+		udelay(1);
+	} while (limit--);
+}
+
+/*
+ * disable dma in given channel
+ */
+static void bcm_enet_disable_dma(struct bcm_enet_priv *priv, int chan)
+{
+	int limit;
+
+	enet_dma_writel(priv, 0, ENETDMA_CHANCFG_REG(chan));
+
+	limit = 1000;
+	do {
+		u32 val;
+
+		val = enet_dma_readl(priv, ENETDMA_CHANCFG_REG(chan));
+		if (!(val & ENETDMA_CHANCFG_EN_MASK))
+			break;
+		udelay(1);
+	} while (limit--);
+}
+
+/*
+ * stop callback
+ */
+static int bcm_enet_stop(struct net_device *dev)
+{
+	struct bcm_enet_priv *priv;
+	struct device *kdev;
+	int i;
+
+	priv = netdev_priv(dev);
+	kdev = &priv->pdev->dev;
+
+	netif_stop_queue(dev);
+	napi_disable(&priv->napi);
+	if (priv->has_phy)
+		phy_stop(priv->phydev);
+	del_timer_sync(&priv->rx_timeout);
+
+	/* mask all interrupts */
+	enet_writel(priv, 0, ENET_IRMASK_REG);
+	enet_dma_writel(priv, 0, ENETDMA_IRMASK_REG(priv->rx_chan));
+	enet_dma_writel(priv, 0, ENETDMA_IRMASK_REG(priv->tx_chan));
+
+	/* make sure no mib update is scheduled */
+	flush_scheduled_work();
+
+	/* disable dma & mac */
+	bcm_enet_disable_dma(priv, priv->tx_chan);
+	bcm_enet_disable_dma(priv, priv->rx_chan);
+	bcm_enet_disable_mac(priv);
+
+	/* force reclaim of all tx buffers */
+	bcm_enet_tx_reclaim(dev, 1);
+
+	/* free the rx skb ring */
+	for (i = 0; i < priv->rx_ring_size; i++) {
+		struct bcm_enet_desc *desc;
+
+		if (!priv->rx_skb[i])
+			continue;
+
+		desc = &priv->rx_desc_cpu[i];
+		dma_unmap_single(kdev, desc->address, BCMENET_MAX_RX_SIZE,
+				 DMA_FROM_DEVICE);
+		kfree_skb(priv->rx_skb[i]);
+	}
+
+	/* free remaining allocated memory */
+	kfree(priv->rx_skb);
+	kfree(priv->tx_skb);
+	dma_free_coherent(kdev, priv->rx_desc_alloc_size,
+			  priv->rx_desc_cpu, priv->rx_desc_dma);
+	dma_free_coherent(kdev, priv->tx_desc_alloc_size,
+			  priv->tx_desc_cpu, priv->tx_desc_dma);
+	free_irq(priv->irq_tx, dev);
+	free_irq(priv->irq_rx, dev);
+	free_irq(dev->irq, dev);
+
+	/* release phy */
+	if (priv->has_phy) {
+		phy_disconnect(priv->phydev);
+		priv->phydev = NULL;
+	}
+
+	return 0;
+}
+
+/*
+ * core request to return device rx/tx stats
+ */
+static struct net_device_stats *bcm_enet_get_stats(struct net_device *dev)
+{
+	struct bcm_enet_priv *priv;
+
+	priv = netdev_priv(dev);
+	return &priv->stats;
+}
+
+/*
+ * ethtool callbacks
+ */
+struct bcm_enet_stats {
+	char stat_string[ETH_GSTRING_LEN];
+	int sizeof_stat;
+	int stat_offset;
+	int mib_reg;
+};
+
+#define GEN_STAT(m) sizeof(((struct bcm_enet_priv *)0)->m),		\
+		     offsetof(struct bcm_enet_priv, m)
+
+static const struct bcm_enet_stats bcm_enet_gstrings_stats[] = {
+	{ "rx_packets", GEN_STAT(stats.rx_packets), -1 },
+	{ "tx_packets",	GEN_STAT(stats.tx_packets), -1 },
+	{ "rx_bytes", GEN_STAT(stats.rx_bytes), -1 },
+	{ "tx_bytes", GEN_STAT(stats.tx_bytes), -1 },
+	{ "rx_errors", GEN_STAT(stats.rx_errors), -1 },
+	{ "tx_errors", GEN_STAT(stats.tx_errors), -1 },
+	{ "rx_dropped",	GEN_STAT(stats.rx_dropped), -1 },
+	{ "tx_dropped",	GEN_STAT(stats.tx_dropped), -1 },
+
+	{ "rx_good_octets", GEN_STAT(mib.rx_gd_octets), ETH_MIB_RX_GD_OCTETS},
+	{ "rx_good_pkts", GEN_STAT(mib.rx_gd_pkts), ETH_MIB_RX_GD_PKTS },
+	{ "rx_broadcast", GEN_STAT(mib.rx_brdcast), ETH_MIB_RX_BRDCAST },
+	{ "rx_multicast", GEN_STAT(mib.rx_mult), ETH_MIB_RX_MULT },
+	{ "rx_64_octets", GEN_STAT(mib.rx_64), ETH_MIB_RX_64 },
+	{ "rx_65_127_oct", GEN_STAT(mib.rx_65_127), ETH_MIB_RX_65_127 },
+	{ "rx_128_255_oct", GEN_STAT(mib.rx_128_255), ETH_MIB_RX_128_255 },
+	{ "rx_256_511_oct", GEN_STAT(mib.rx_256_511), ETH_MIB_RX_256_511 },
+	{ "rx_512_1023_oct", GEN_STAT(mib.rx_512_1023), ETH_MIB_RX_512_1023 },
+	{ "rx_1024_max_oct", GEN_STAT(mib.rx_1024_max), ETH_MIB_RX_1024_MAX },
+	{ "rx_jabber", GEN_STAT(mib.rx_jab), ETH_MIB_RX_JAB },
+	{ "rx_oversize", GEN_STAT(mib.rx_ovr), ETH_MIB_RX_OVR },
+	{ "rx_fragment", GEN_STAT(mib.rx_frag), ETH_MIB_RX_FRAG },
+	{ "rx_dropped",	GEN_STAT(mib.rx_drop), ETH_MIB_RX_DROP },
+	{ "rx_crc_align", GEN_STAT(mib.rx_crc_align), ETH_MIB_RX_CRC_ALIGN },
+	{ "rx_undersize", GEN_STAT(mib.rx_und), ETH_MIB_RX_UND },
+	{ "rx_crc", GEN_STAT(mib.rx_crc), ETH_MIB_RX_CRC },
+	{ "rx_align", GEN_STAT(mib.rx_align), ETH_MIB_RX_ALIGN },
+	{ "rx_symbol_error", GEN_STAT(mib.rx_sym), ETH_MIB_RX_SYM },
+	{ "rx_pause", GEN_STAT(mib.rx_pause), ETH_MIB_RX_PAUSE },
+	{ "rx_control", GEN_STAT(mib.rx_cntrl), ETH_MIB_RX_CNTRL },
+
+	{ "tx_good_octets", GEN_STAT(mib.tx_gd_octets), ETH_MIB_TX_GD_OCTETS },
+	{ "tx_good_pkts", GEN_STAT(mib.tx_gd_pkts), ETH_MIB_TX_GD_PKTS },
+	{ "tx_broadcast", GEN_STAT(mib.tx_brdcast), ETH_MIB_TX_BRDCAST },
+	{ "tx_multicast", GEN_STAT(mib.tx_mult), ETH_MIB_TX_MULT },
+	{ "tx_64_oct", GEN_STAT(mib.tx_64), ETH_MIB_TX_64 },
+	{ "tx_65_127_oct", GEN_STAT(mib.tx_65_127), ETH_MIB_TX_65_127 },
+	{ "tx_128_255_oct", GEN_STAT(mib.tx_128_255), ETH_MIB_TX_128_255 },
+	{ "tx_256_511_oct", GEN_STAT(mib.tx_256_511), ETH_MIB_TX_256_511 },
+	{ "tx_512_1023_oct", GEN_STAT(mib.tx_512_1023), ETH_MIB_TX_512_1023},
+	{ "tx_1024_max_oct", GEN_STAT(mib.tx_1024_max), ETH_MIB_TX_1024_MAX },
+	{ "tx_jabber", GEN_STAT(mib.tx_jab), ETH_MIB_TX_JAB },
+	{ "tx_oversize", GEN_STAT(mib.tx_ovr), ETH_MIB_TX_OVR },
+	{ "tx_fragment", GEN_STAT(mib.tx_frag), ETH_MIB_TX_FRAG },
+	{ "tx_underrun", GEN_STAT(mib.tx_underrun), ETH_MIB_TX_UNDERRUN },
+	{ "tx_collisions", GEN_STAT(mib.tx_col), ETH_MIB_TX_COL },
+	{ "tx_single_collision", GEN_STAT(mib.tx_1_col), ETH_MIB_TX_1_COL },
+	{ "tx_multiple_collision", GEN_STAT(mib.tx_m_col), ETH_MIB_TX_M_COL },
+	{ "tx_excess_collision", GEN_STAT(mib.tx_ex_col), ETH_MIB_TX_EX_COL },
+	{ "tx_late_collision", GEN_STAT(mib.tx_late), ETH_MIB_TX_LATE },
+	{ "tx_deferred", GEN_STAT(mib.tx_def), ETH_MIB_TX_DEF },
+	{ "tx_carrier_sense", GEN_STAT(mib.tx_crs), ETH_MIB_TX_CRS },
+	{ "tx_pause", GEN_STAT(mib.tx_pause), ETH_MIB_TX_PAUSE },
+
+};
+
+#define BCM_ENET_STATS_LEN	\
+	(sizeof(bcm_enet_gstrings_stats) / sizeof(struct bcm_enet_stats))
+
+static const u32 unused_mib_regs[] = {
+	ETH_MIB_TX_ALL_OCTETS,
+	ETH_MIB_TX_ALL_PKTS,
+	ETH_MIB_RX_ALL_OCTETS,
+	ETH_MIB_RX_ALL_PKTS,
+};
+
+
+static void bcm_enet_get_drvinfo(struct net_device *netdev,
+				 struct ethtool_drvinfo *drvinfo)
+{
+	strncpy(drvinfo->driver, bcm_enet_driver_name, 32);
+	strncpy(drvinfo->version, bcm_enet_driver_version, 32);
+	strncpy(drvinfo->fw_version, "N/A", 32);
+	strncpy(drvinfo->bus_info, "bcm63xx", 32);
+	drvinfo->n_stats = BCM_ENET_STATS_LEN;
+}
+
+static int bcm_enet_get_stats_count(struct net_device *netdev)
+{
+	return BCM_ENET_STATS_LEN;
+}
+
+static void bcm_enet_get_strings(struct net_device *netdev,
+				 u32 stringset, u8 *data)
+{
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < BCM_ENET_STATS_LEN; i++) {
+			memcpy(data + i * ETH_GSTRING_LEN,
+			       bcm_enet_gstrings_stats[i].stat_string,
+			       ETH_GSTRING_LEN);
+		}
+		break;
+	}
+}
+
+static void update_mib_counters(struct bcm_enet_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < BCM_ENET_STATS_LEN; i++) {
+		const struct bcm_enet_stats *s;
+		u32 val;
+		char *p;
+
+		s = &bcm_enet_gstrings_stats[i];
+		if (s->mib_reg == -1)
+			continue;
+
+		val = enet_readl(priv, ENET_MIB_REG(s->mib_reg));
+		p = (char *)priv + s->stat_offset;
+
+		if (s->sizeof_stat == sizeof(u64))
+			*(u64 *)p += val;
+		else
+			*(u32 *)p += val;
+	}
+
+	/* also empty unused mib counters to make sure mib counter
+	 * overflow interrupt is cleared */
+	for (i = 0; i < ARRAY_SIZE(unused_mib_regs); i++)
+		(void)enet_readl(priv, ENET_MIB_REG(unused_mib_regs[i]));
+}
+
+static void bcm_enet_update_mib_counters_defer(struct work_struct *t)
+{
+	struct bcm_enet_priv *priv;
+
+	priv = container_of(t, struct bcm_enet_priv, mib_update_task);
+	mutex_lock(&priv->mib_update_lock);
+	update_mib_counters(priv);
+	mutex_unlock(&priv->mib_update_lock);
+
+	/* reenable mib interrupt */
+	if (netif_running(priv->net_dev))
+		enet_writel(priv, ENET_IR_MIB, ENET_IRMASK_REG);
+}
+
+static void bcm_enet_get_ethtool_stats(struct net_device *netdev,
+				       struct ethtool_stats *stats,
+				       u64 *data)
+{
+	struct bcm_enet_priv *priv;
+	int i;
+
+	priv = netdev_priv(netdev);
+
+	mutex_lock(&priv->mib_update_lock);
+	update_mib_counters(priv);
+
+	for (i = 0; i < BCM_ENET_STATS_LEN; i++) {
+		const struct bcm_enet_stats *s;
+		char *p;
+
+		s = &bcm_enet_gstrings_stats[i];
+		p = (char *)priv + s->stat_offset;
+		data[i] = (s->sizeof_stat == sizeof(u64)) ?
+			*(u64 *)p : *(u32 *)p;
+	}
+	mutex_unlock(&priv->mib_update_lock);
+}
+
+static int bcm_enet_get_settings(struct net_device *dev,
+				 struct ethtool_cmd *cmd)
+{
+	struct bcm_enet_priv *priv;
+
+	priv = netdev_priv(dev);
+
+	cmd->maxrxpkt = 0;
+	cmd->maxtxpkt = 0;
+
+	if (priv->has_phy) {
+		if (!priv->phydev)
+			return -ENODEV;
+		return phy_ethtool_gset(priv->phydev, cmd);
+	} else {
+		cmd->autoneg = 0;
+		cmd->speed = (priv->force_speed_100) ? SPEED_100 : SPEED_10;
+		cmd->duplex = (priv->force_duplex_full) ?
+			DUPLEX_FULL : DUPLEX_HALF;
+		cmd->supported = ADVERTISED_10baseT_Half  |
+			ADVERTISED_10baseT_Full |
+			ADVERTISED_100baseT_Half |
+			ADVERTISED_100baseT_Full;
+		cmd->advertising = 0;
+		cmd->port = PORT_MII;
+		cmd->transceiver = XCVR_EXTERNAL;
+	}
+	return 0;
+}
+
+static int bcm_enet_set_settings(struct net_device *dev,
+				 struct ethtool_cmd *cmd)
+{
+	struct bcm_enet_priv *priv;
+
+	priv = netdev_priv(dev);
+	if (priv->has_phy) {
+		if (!priv->phydev)
+			return -ENODEV;
+		return phy_ethtool_sset(priv->phydev, cmd);
+	} else {
+
+		if (cmd->autoneg ||
+		    (cmd->speed != SPEED_100 && cmd->speed != SPEED_10) ||
+		    cmd->port != PORT_MII)
+			return -EINVAL;
+
+		priv->force_speed_100 = (cmd->speed == SPEED_100) ? 1 : 0;
+		priv->force_duplex_full = (cmd->duplex == DUPLEX_FULL) ? 1 : 0;
+
+		if (netif_running(dev))
+			bcm_enet_adjust_link(dev);
+		return 0;
+	}
+}
+
+static void bcm_enet_get_ringparam(struct net_device *dev,
+				   struct ethtool_ringparam *ering)
+{
+	struct bcm_enet_priv *priv;
+
+	priv = netdev_priv(dev);
+
+	/* rx/tx ring is actually only limited by memory */
+	ering->rx_max_pending = 8192;
+	ering->tx_max_pending = 8192;
+	ering->rx_mini_max_pending = 0;
+	ering->rx_jumbo_max_pending = 0;
+	ering->rx_pending = priv->rx_ring_size;
+	ering->tx_pending = priv->tx_ring_size;
+}
+
+static int bcm_enet_set_ringparam(struct net_device *dev,
+				  struct ethtool_ringparam *ering)
+{
+	struct bcm_enet_priv *priv;
+	int was_running;
+
+	priv = netdev_priv(dev);
+
+	was_running = 0;
+	if (netif_running(dev)) {
+		bcm_enet_stop(dev);
+		was_running = 1;
+	}
+
+	priv->rx_ring_size = ering->rx_pending;
+	priv->tx_ring_size = ering->tx_pending;
+
+	if (was_running) {
+		int err;
+
+		err = bcm_enet_open(dev);
+		if (err)
+			dev_close(dev);
+		else
+			bcm_enet_set_multicast_list(dev);
+	}
+	return 0;
+}
+
+static void bcm_enet_get_pauseparam(struct net_device *dev,
+				    struct ethtool_pauseparam *ecmd)
+{
+	struct bcm_enet_priv *priv;
+
+	priv = netdev_priv(dev);
+	ecmd->autoneg = priv->pause_auto;
+	ecmd->rx_pause = priv->pause_rx;
+	ecmd->tx_pause = priv->pause_tx;
+}
+
+static int bcm_enet_set_pauseparam(struct net_device *dev,
+				   struct ethtool_pauseparam *ecmd)
+{
+	struct bcm_enet_priv *priv;
+
+	priv = netdev_priv(dev);
+
+	if (priv->has_phy) {
+		if (ecmd->autoneg && (ecmd->rx_pause != ecmd->tx_pause)) {
+			/* asymetric pause mode not supported,
+			 * actually possible but integrated PHY has RO
+			 * asym_pause bit */
+			return -EINVAL;
+		}
+	} else {
+		/* no pause autoneg on direct mii connection */
+		if (ecmd->autoneg)
+			return -EINVAL;
+	}
+
+	priv->pause_auto = ecmd->autoneg;
+	priv->pause_rx = ecmd->rx_pause;
+	priv->pause_tx = ecmd->tx_pause;
+
+	return 0;
+}
+
+static struct ethtool_ops bcm_enet_ethtool_ops = {
+	.get_strings		= bcm_enet_get_strings,
+	.get_stats_count	= bcm_enet_get_stats_count,
+	.get_ethtool_stats      = bcm_enet_get_ethtool_stats,
+	.get_settings		= bcm_enet_get_settings,
+	.set_settings		= bcm_enet_set_settings,
+	.get_drvinfo		= bcm_enet_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_ringparam		= bcm_enet_get_ringparam,
+	.set_ringparam		= bcm_enet_set_ringparam,
+	.get_pauseparam		= bcm_enet_get_pauseparam,
+	.set_pauseparam		= bcm_enet_set_pauseparam,
+};
+
+static int bcm_enet_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	struct bcm_enet_priv *priv;
+
+	priv = netdev_priv(dev);
+	if (priv->has_phy) {
+		if (!priv->phydev)
+			return -ENODEV;
+		return phy_mii_ioctl(priv->phydev, if_mii(rq), cmd);
+	} else {
+		struct mii_if_info mii;
+
+		mii.dev = dev;
+		mii.mdio_read = bcm_enet_mdio_read_mii;
+		mii.mdio_write = bcm_enet_mdio_write_mii;
+		mii.phy_id = 0;
+		mii.phy_id_mask = 0x3f;
+		mii.reg_num_mask = 0x1f;
+		return generic_mii_ioctl(&mii, if_mii(rq), cmd, NULL);
+	}
+}
+
+/*
+ * preinit hardware to allow mii operation while device is down
+ */
+static void bcm_enet_hw_preinit(struct bcm_enet_priv *priv)
+{
+	u32 val;
+	int limit;
+
+	/* make sure mac is disabled */
+	bcm_enet_disable_mac(priv);
+
+	/* soft reset mac */
+	val = ENET_CTL_SRESET_MASK;
+	enet_writel(priv, val, ENET_CTL_REG);
+	wmb();
+
+	limit = 1000;
+	do {
+		val = enet_readl(priv, ENET_CTL_REG);
+		if (!(val & ENET_CTL_SRESET_MASK))
+			break;
+		udelay(1);
+	} while (limit--);
+
+	/* select correct mii interface */
+	val = enet_readl(priv, ENET_CTL_REG);
+	if (priv->use_external_mii)
+		val |= ENET_CTL_EPHYSEL_MASK;
+	else
+		val &= ~ENET_CTL_EPHYSEL_MASK;
+	enet_writel(priv, val, ENET_CTL_REG);
+
+	/* turn on mdc clock */
+	enet_writel(priv, (0x1f << ENET_MIISC_MDCFREQDIV_SHIFT) |
+		    ENET_MIISC_PREAMBLEEN_MASK, ENET_MIISC_REG);
+
+	/* set mib counters to self-clear when read */
+	val = enet_readl(priv, ENET_MIBCTL_REG);
+	val |= ENET_MIBCTL_RDCLEAR_MASK;
+	enet_writel(priv, val, ENET_MIBCTL_REG);
+}
+
+/*
+ * allocate netdevice, request register memory and register device.
+ */
+static int __devinit bcm_enet_probe(struct platform_device *pdev)
+{
+	struct bcm_enet_priv *priv;
+	struct net_device *dev;
+	struct bcm63xx_enet_platform_data *pd;
+	struct resource *res_mem, *res_irq, *res_irq_rx, *res_irq_tx;
+	struct mii_bus *bus;
+	const char *clk_name;
+	unsigned int iomem_size;
+	int i, ret;
+
+	/* stop if shared driver failed, assume driver->probe will be
+	 * called in the same order we register devices (correct ?) */
+	if (!bcm_enet_shared_base)
+		return -ENODEV;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	res_irq_rx = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
+	res_irq_tx = platform_get_resource(pdev, IORESOURCE_IRQ, 2);
+	if (!res_mem || !res_irq || !res_irq_rx || !res_irq_tx)
+		return -ENODEV;
+
+	ret = 0;
+	dev = alloc_etherdev(sizeof(*priv));
+	if (!dev)
+		return -ENOMEM;
+	priv = netdev_priv(dev);
+	memset(priv, 0, sizeof(*priv));
+
+	iomem_size = res_mem->end - res_mem->start + 1;
+	if (!request_mem_region(res_mem->start, iomem_size, "bcm63xx_enet")) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	priv->base = ioremap(res_mem->start, iomem_size);
+	if (priv->base == NULL) {
+		ret = -ENOMEM;
+		goto out_release_mem;
+	}
+	dev->irq = priv->irq = res_irq->start;
+	priv->irq_rx = res_irq_rx->start;
+	priv->irq_tx = res_irq_tx->start;
+	priv->mac_id = pdev->id;
+
+	/* get rx & tx dma channel id for this mac */
+	if (priv->mac_id == 0) {
+		priv->rx_chan = 0;
+		priv->tx_chan = 1;
+		clk_name = "enet0";
+	} else {
+		priv->rx_chan = 2;
+		priv->tx_chan = 3;
+		clk_name = "enet1";
+	}
+
+	priv->mac_clk = clk_get(&pdev->dev, clk_name);
+	if (IS_ERR(priv->mac_clk)) {
+		ret = PTR_ERR(priv->mac_clk);
+		goto out_unmap;
+	}
+	clk_enable(priv->mac_clk);
+
+	/* initialize default and fetch platform data */
+	priv->rx_ring_size = BCMENET_DEF_RX_DESC;
+	priv->tx_ring_size = BCMENET_DEF_TX_DESC;
+
+	pd = pdev->dev.platform_data;
+	if (pd) {
+		memcpy(dev->dev_addr, pd->mac_addr, ETH_ALEN);
+		priv->has_phy = pd->has_phy;
+		priv->phy_id = pd->phy_id;
+		priv->has_phy_interrupt = pd->has_phy_interrupt;
+		priv->phy_interrupt = pd->phy_interrupt;
+		priv->use_external_mii = !pd->use_internal_phy;
+		priv->pause_auto = pd->pause_auto;
+		priv->pause_rx = pd->pause_rx;
+		priv->pause_tx = pd->pause_tx;
+		priv->force_duplex_full = pd->force_duplex_full;
+		priv->force_speed_100 = pd->force_speed_100;
+	}
+
+	if (priv->mac_id == 0 && priv->has_phy && !priv->use_external_mii) {
+		/* using internal PHY, enable clock */
+		priv->phy_clk = clk_get(&pdev->dev, "ephy");
+		if (IS_ERR(priv->phy_clk)) {
+			ret = PTR_ERR(priv->phy_clk);
+			priv->phy_clk = NULL;
+			goto out_put_clk_mac;
+		}
+		clk_enable(priv->phy_clk);
+	}
+
+	/* do minimal hardware init to be able to probe mii bus */
+	bcm_enet_hw_preinit(priv);
+
+	/* MII bus registration */
+	if (priv->has_phy) {
+
+		priv->mii_bus = mdiobus_alloc();
+		if (!priv->mii_bus) {
+			ret = -ENOMEM;
+			goto out_uninit_hw;
+		}
+
+		bus = priv->mii_bus;
+		bus->name = "bcm63xx_enet MII bus";
+		bus->parent = &pdev->dev;
+		bus->priv = priv;
+		bus->read = bcm_enet_mdio_read_phylib;
+		bus->write = bcm_enet_mdio_write_phylib;
+		sprintf(bus->id, "%d", priv->mac_id);
+
+		/* only probe bus where we think the PHY is, because
+		 * the mdio read operation return 0 instead of 0xffff
+		 * if a slave is not present on hw */
+		bus->phy_mask = ~(1 << priv->phy_id);
+
+		bus->irq = kmalloc(sizeof(int) * PHY_MAX_ADDR, GFP_KERNEL);
+		if (!bus->irq) {
+			ret = -ENOMEM;
+			goto out_free_mdio;
+		}
+
+		if (priv->has_phy_interrupt)
+			bus->irq[priv->phy_id] = priv->phy_interrupt;
+		else
+			bus->irq[priv->phy_id] = PHY_POLL;
+
+		ret = mdiobus_register(bus);
+		if (ret) {
+			dev_err(&pdev->dev, "unable to register mdio bus\n");
+			goto out_free_mdio;
+		}
+	} else {
+
+		/* run platform code to initialize PHY device */
+		if (pd->mii_config &&
+		    pd->mii_config(dev, 1, bcm_enet_mdio_read_mii,
+				   bcm_enet_mdio_write_mii)) {
+			dev_err(&pdev->dev, "unable to configure mdio bus\n");
+			goto out_uninit_hw;
+		}
+	}
+
+	spin_lock_init(&priv->rx_lock);
+
+	/* init rx timeout (used for oom) */
+	init_timer(&priv->rx_timeout);
+	priv->rx_timeout.function = bcm_enet_refill_rx_timer;
+	priv->rx_timeout.data = (unsigned long)dev;
+
+	/* init the mib update lock&work */
+	mutex_init(&priv->mib_update_lock);
+	INIT_WORK(&priv->mib_update_task, bcm_enet_update_mib_counters_defer);
+
+	/* zero mib counters */
+	for (i = 0; i < ENET_MIB_REG_COUNT; i++)
+		enet_writel(priv, 0, ENET_MIB_REG(i));
+
+	/* register netdevice */
+	dev->open = bcm_enet_open;
+	dev->stop = bcm_enet_stop;
+	dev->hard_start_xmit = bcm_enet_start_xmit;
+	dev->get_stats = bcm_enet_get_stats;
+	dev->set_mac_address = bcm_enet_set_mac_address;
+	dev->set_multicast_list = bcm_enet_set_multicast_list;
+	netif_napi_add(dev, &priv->napi, bcm_enet_poll, 16);
+	dev->do_ioctl = bcm_enet_ioctl;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = bcm_enet_netpoll;
+#endif
+
+	SET_ETHTOOL_OPS(dev, &bcm_enet_ethtool_ops);
+
+	ret = register_netdev(dev);
+	if (ret)
+		goto out_unregister_mdio;
+
+	netif_carrier_off(dev);
+	platform_set_drvdata(pdev, dev);
+	priv->pdev = pdev;
+	priv->net_dev = dev;
+	SET_NETDEV_DEV(dev, &pdev->dev);
+
+	return 0;
+
+out_unregister_mdio:
+	if (priv->mii_bus) {
+		mdiobus_unregister(priv->mii_bus);
+		kfree(priv->mii_bus->irq);
+	}
+
+out_free_mdio:
+	if (priv->mii_bus)
+		mdiobus_free(priv->mii_bus);
+
+out_uninit_hw:
+	/* turn off mdc clock */
+	enet_writel(priv, 0, ENET_MIISC_REG);
+	if (priv->phy_clk) {
+		clk_disable(priv->phy_clk);
+		clk_put(priv->phy_clk);
+	}
+
+out_put_clk_mac:
+	clk_disable(priv->mac_clk);
+	clk_put(priv->mac_clk);
+
+out_unmap:
+	iounmap(priv->base);
+
+out_release_mem:
+	release_mem_region(res_mem->start, iomem_size);
+out:
+	free_netdev(dev);
+	return ret;
+}
+
+
+/*
+ * exit func, stops hardware and unregisters netdevice
+ */
+static int __devexit bcm_enet_remove(struct platform_device *pdev)
+{
+	struct bcm_enet_priv *priv;
+	struct net_device *dev;
+	struct resource *res;
+
+	/* stop netdevice */
+	dev = platform_get_drvdata(pdev);
+	priv = netdev_priv(dev);
+	unregister_netdev(dev);
+
+	/* turn off mdc clock */
+	enet_writel(priv, 0, ENET_MIISC_REG);
+
+	if (priv->has_phy) {
+		mdiobus_unregister(priv->mii_bus);
+		kfree(priv->mii_bus->irq);
+		mdiobus_free(priv->mii_bus);
+	} else {
+		struct bcm63xx_enet_platform_data *pd;
+
+		pd = pdev->dev.platform_data;
+		if (pd && pd->mii_config)
+			pd->mii_config(dev, 0, bcm_enet_mdio_read_mii,
+				       bcm_enet_mdio_write_mii);
+	}
+
+	/* release device resources */
+	iounmap(priv->base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, res->end - res->start + 1);
+
+	/* disable hw block clocks */
+	if (priv->phy_clk) {
+		clk_disable(priv->phy_clk);
+		clk_put(priv->phy_clk);
+	}
+	clk_disable(priv->mac_clk);
+	clk_put(priv->mac_clk);
+
+	free_netdev(dev);
+	return 0;
+}
+
+struct platform_driver bcm63xx_enet_driver = {
+	.probe	= bcm_enet_probe,
+	.remove	= __devexit_p(bcm_enet_remove),
+	.driver	= {
+		.name	= "bcm63xx_enet",
+		.owner  = THIS_MODULE,
+	},
+};
+
+/*
+ * reserve & remap memory space shared between all macs
+ */
+static int __devinit bcm_enet_shared_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	unsigned int iomem_size;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	iomem_size = res->end - res->start + 1;
+	if (!request_mem_region(res->start, iomem_size, "bcm63xx_enet_dma"))
+		return -EBUSY;
+
+	bcm_enet_shared_base = ioremap(res->start, iomem_size);
+	if (!bcm_enet_shared_base) {
+		release_mem_region(res->start, iomem_size);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static int __devexit bcm_enet_shared_remove(struct platform_device *pdev)
+{
+	struct resource *res;
+
+	iounmap(bcm_enet_shared_base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, res->end - res->start + 1);
+	return 0;
+}
+
+/*
+ * this "shared" driver is needed because both macs share a single
+ * address space
+ */
+struct platform_driver bcm63xx_enet_shared_driver = {
+	.probe	= bcm_enet_shared_probe,
+	.remove	= __devexit_p(bcm_enet_shared_remove),
+	.driver	= {
+		.name	= "bcm63xx_enet_shared",
+		.owner  = THIS_MODULE,
+	},
+};
+
+/*
+ * entry point
+ */
+static int __init bcm_enet_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&bcm63xx_enet_shared_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&bcm63xx_enet_driver);
+	if (ret)
+		platform_driver_unregister(&bcm63xx_enet_shared_driver);
+
+	return ret;
+}
+
+static void __exit bcm_enet_exit(void)
+{
+	platform_driver_unregister(&bcm63xx_enet_driver);
+	platform_driver_unregister(&bcm63xx_enet_shared_driver);
+}
+
+
+module_init(bcm_enet_init);
+module_exit(bcm_enet_exit);
+
+MODULE_DESCRIPTION("BCM63xx internal ethernet mac driver");
+MODULE_AUTHOR("Maxime Bizon <mbizon@freebox.fr>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/bcm63xx_enet.h b/drivers/net/bcm63xx_enet.h
new file mode 100644
index 0000000..0da8973
--- /dev/null
+++ b/drivers/net/bcm63xx_enet.h
@@ -0,0 +1,294 @@
+#ifndef BCM63XX_ENET_H_
+#define BCM63XX_ENET_H_
+
+#include <linux/types.h>
+#include <linux/mii.h>
+#include <linux/mutex.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+
+#include <bcm63xx_regs.h>
+#include <bcm63xx_irq.h>
+#include <bcm63xx_io.h>
+
+/* default number of descriptor */
+#define BCMENET_DEF_RX_DESC	64
+#define BCMENET_DEF_TX_DESC	32
+
+/* maximum burst len for dma (4 bytes unit) */
+#define BCMENET_DMA_MAXBURST	16
+
+/* tx transmit threshold (4 bytes unit), fifo is 256 bytes, the value
+ * must be low enough so that a DMA transfer of above burst length can
+ * not overflow the fifo  */
+#define BCMENET_TX_FIFO_TRESH	32
+
+/* maximum rx/tx packet size */
+#define	BCMENET_MAX_RX_SIZE	(ETH_FRAME_LEN + 4)
+#define	BCMENET_MAX_TX_SIZE	(ETH_FRAME_LEN + 4)
+
+/*
+ * rx/tx dma descriptor
+ */
+struct bcm_enet_desc {
+	u32 len_stat;
+	u32 address;
+};
+
+#define DMADESC_LENGTH_SHIFT	16
+#define DMADESC_LENGTH_MASK	(0xfff << DMADESC_LENGTH_SHIFT)
+#define DMADESC_OWNER_MASK	(1 << 15)
+#define DMADESC_EOP_MASK	(1 << 14)
+#define DMADESC_SOP_MASK	(1 << 13)
+#define DMADESC_ESOP_MASK	(DMADESC_EOP_MASK | DMADESC_SOP_MASK)
+#define DMADESC_WRAP_MASK	(1 << 12)
+
+#define DMADESC_UNDER_MASK	(1 << 9)
+#define DMADESC_APPEND_CRC	(1 << 8)
+#define DMADESC_OVSIZE_MASK	(1 << 4)
+#define DMADESC_RXER_MASK	(1 << 2)
+#define DMADESC_CRC_MASK	(1 << 1)
+#define DMADESC_OV_MASK		(1 << 0)
+#define DMADESC_ERR_MASK	(DMADESC_UNDER_MASK | \
+				DMADESC_OVSIZE_MASK | \
+				DMADESC_RXER_MASK | \
+				DMADESC_CRC_MASK | \
+				DMADESC_OV_MASK)
+
+
+/*
+ * MIB Counters register definitions
+*/
+#define ETH_MIB_TX_GD_OCTETS			0
+#define ETH_MIB_TX_GD_PKTS			1
+#define ETH_MIB_TX_ALL_OCTETS			2
+#define ETH_MIB_TX_ALL_PKTS			3
+#define ETH_MIB_TX_BRDCAST			4
+#define ETH_MIB_TX_MULT				5
+#define ETH_MIB_TX_64				6
+#define ETH_MIB_TX_65_127			7
+#define ETH_MIB_TX_128_255			8
+#define ETH_MIB_TX_256_511			9
+#define ETH_MIB_TX_512_1023			10
+#define ETH_MIB_TX_1024_MAX			11
+#define ETH_MIB_TX_JAB				12
+#define ETH_MIB_TX_OVR				13
+#define ETH_MIB_TX_FRAG				14
+#define ETH_MIB_TX_UNDERRUN			15
+#define ETH_MIB_TX_COL				16
+#define ETH_MIB_TX_1_COL			17
+#define ETH_MIB_TX_M_COL			18
+#define ETH_MIB_TX_EX_COL			19
+#define ETH_MIB_TX_LATE				20
+#define ETH_MIB_TX_DEF				21
+#define ETH_MIB_TX_CRS				22
+#define ETH_MIB_TX_PAUSE			23
+
+#define ETH_MIB_RX_GD_OCTETS			32
+#define ETH_MIB_RX_GD_PKTS			33
+#define ETH_MIB_RX_ALL_OCTETS			34
+#define ETH_MIB_RX_ALL_PKTS			35
+#define ETH_MIB_RX_BRDCAST			36
+#define ETH_MIB_RX_MULT				37
+#define ETH_MIB_RX_64				38
+#define ETH_MIB_RX_65_127			39
+#define ETH_MIB_RX_128_255			40
+#define ETH_MIB_RX_256_511			41
+#define ETH_MIB_RX_512_1023			42
+#define ETH_MIB_RX_1024_MAX			43
+#define ETH_MIB_RX_JAB				44
+#define ETH_MIB_RX_OVR				45
+#define ETH_MIB_RX_FRAG				46
+#define ETH_MIB_RX_DROP				47
+#define ETH_MIB_RX_CRC_ALIGN			48
+#define ETH_MIB_RX_UND				49
+#define ETH_MIB_RX_CRC				50
+#define ETH_MIB_RX_ALIGN			51
+#define ETH_MIB_RX_SYM				52
+#define ETH_MIB_RX_PAUSE			53
+#define ETH_MIB_RX_CNTRL			54
+
+
+struct bcm_enet_mib_counters {
+	u64 tx_gd_octets;
+	u32 tx_gd_pkts;
+	u32 tx_all_octets;
+	u32 tx_all_pkts;
+	u32 tx_brdcast;
+	u32 tx_mult;
+	u32 tx_64;
+	u32 tx_65_127;
+	u32 tx_128_255;
+	u32 tx_256_511;
+	u32 tx_512_1023;
+	u32 tx_1024_max;
+	u32 tx_jab;
+	u32 tx_ovr;
+	u32 tx_frag;
+	u32 tx_underrun;
+	u32 tx_col;
+	u32 tx_1_col;
+	u32 tx_m_col;
+	u32 tx_ex_col;
+	u32 tx_late;
+	u32 tx_def;
+	u32 tx_crs;
+	u32 tx_pause;
+	u64 rx_gd_octets;
+	u32 rx_gd_pkts;
+	u32 rx_all_octets;
+	u32 rx_all_pkts;
+	u32 rx_brdcast;
+	u32 rx_mult;
+	u32 rx_64;
+	u32 rx_65_127;
+	u32 rx_128_255;
+	u32 rx_256_511;
+	u32 rx_512_1023;
+	u32 rx_1024_max;
+	u32 rx_jab;
+	u32 rx_ovr;
+	u32 rx_frag;
+	u32 rx_drop;
+	u32 rx_crc_align;
+	u32 rx_und;
+	u32 rx_crc;
+	u32 rx_align;
+	u32 rx_sym;
+	u32 rx_pause;
+	u32 rx_cntrl;
+};
+
+
+struct bcm_enet_priv {
+
+	/* mac id (from platform device id) */
+	int mac_id;
+
+	/* base remapped address of device */
+	void __iomem *base;
+
+	/* mac irq, rx_dma irq, tx_dma irq */
+	int irq;
+	int irq_rx;
+	int irq_tx;
+
+	/* hw view of rx & tx dma ring */
+	dma_addr_t rx_desc_dma;
+	dma_addr_t tx_desc_dma;
+
+	/* allocated size (in bytes) for rx & tx dma ring */
+	unsigned int rx_desc_alloc_size;
+	unsigned int tx_desc_alloc_size;
+
+
+	struct napi_struct napi;
+
+	/* dma channel id for rx */
+	int rx_chan;
+
+	/* number of dma desc in rx ring */
+	int rx_ring_size;
+
+	/* cpu view of rx dma ring */
+	struct bcm_enet_desc *rx_desc_cpu;
+
+	/* current number of armed descriptor given to hardware for rx */
+	int rx_desc_count;
+
+	/* next rx descriptor to fetch from hardware */
+	int rx_curr_desc;
+
+	/* next dirty rx descriptor to refill */
+	int rx_dirty_desc;
+
+	/* list of skb given to hw for rx */
+	struct sk_buff **rx_skb;
+
+	/* used when rx skb allocation failed, so we defer rx queue
+	 * refill */
+	struct timer_list rx_timeout;
+
+	/* lock rx_timeout against rx normal operation */
+	spinlock_t rx_lock;
+
+
+	/* dma channel id for tx */
+	int tx_chan;
+
+	/* number of dma desc in tx ring */
+	int tx_ring_size;
+
+	/* cpu view of rx dma ring */
+	struct bcm_enet_desc *tx_desc_cpu;
+
+	/* number of available descriptor for tx */
+	int tx_desc_count;
+
+	/* next tx descriptor avaiable */
+	int tx_curr_desc;
+
+	/* next dirty tx descriptor to reclaim */
+	int tx_dirty_desc;
+
+	/* list of skb given to hw for tx */
+	struct sk_buff **tx_skb;
+
+	/* lock used by tx reclaim and xmit */
+	spinlock_t tx_lock;
+
+
+	/* set if internal phy is ignored and external mii interface
+	 * is selected */
+	int use_external_mii;
+
+	/* set if a phy is connected, phy address must be known,
+	 * probing is not possible */
+	int has_phy;
+	int phy_id;
+
+	/* set if connected phy has an associated irq */
+	int has_phy_interrupt;
+	int phy_interrupt;
+
+	/* used when a phy is connected (phylib used) */
+	struct mii_bus *mii_bus;
+	struct phy_device *phydev;
+	int old_link;
+	int old_duplex;
+	int old_pause;
+
+	/* used when no phy is connected */
+	int force_speed_100;
+	int force_duplex_full;
+
+	/* pause parameters */
+	int pause_auto;
+	int pause_rx;
+	int pause_tx;
+
+	/* stats */
+	struct net_device_stats stats;
+	struct bcm_enet_mib_counters mib;
+
+	/* after mib interrupt, mib registers update is done in this
+	 * work queue */
+	struct work_struct mib_update_task;
+
+	/* lock mib update between userspace request and workqueue */
+	struct mutex mib_update_lock;
+
+	/* mac clock */
+	struct clk *mac_clk;
+
+	/* phy clock if internal phy is used */
+	struct clk *phy_clk;
+
+	/* network device reference */
+	struct net_device *net_dev;
+
+	/* platform device reference */
+	struct platform_device *pdev;
+};
+
+#endif /* ! BCM63XX_ENET_H_ */
-- 
1.5.4.3
