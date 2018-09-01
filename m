Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Sep 2018 14:04:47 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:64726 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992408AbeIAMElgqX9d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 1 Sep 2018 14:04:41 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id E938941680;
        Sat,  1 Sep 2018 14:04:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id jUefShEYE2Ch; Sat,  1 Sep 2018 14:04:33 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
Subject: [PATCH v2 net-next 5/7] net: lantiq: Add Lantiq / Intel VRX200 Ethernet driver
Date:   Sat,  1 Sep 2018 14:04:27 +0200
Message-Id: <20180901120427.9983-1-hauke@hauke-m.de>
In-Reply-To: <20180901114535.9070-1-hauke@hauke-m.de>
References: <20180901114535.9070-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This drives the PMAC between the GSWIP Switch and the CPU in the VRX200
SoC. This is currently only the very basic version of the Ethernet
driver.

When the DMA channel is activated we receive some packets which were
send to the SoC while it was still in U-Boot, these packets have the
wrong header. Resetting the IP cores did not work so we read out the
extra packets at the beginning and discard them.

This also adapts the clock code in sysctrl.c to use the default name of
the device node so that the driver gets the correct clock. sysctrl.c
should be replaced with a proper common clock driver later.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 MAINTAINERS                          |   1 +
 arch/mips/lantiq/xway/sysctrl.c      |   6 +-
 drivers/net/ethernet/Kconfig         |   7 +
 drivers/net/ethernet/Makefile        |   1 +
 drivers/net/ethernet/lantiq_xrx200.c | 591 +++++++++++++++++++++++++++++++++++
 5 files changed, 603 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/lantiq_xrx200.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b2ee65f6086..ffff912d31b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8171,6 +8171,7 @@ M:	Hauke Mehrtens <hauke@hauke-m.de>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	net/dsa/tag_gswip.c
+F:	drivers/net/ethernet/lantiq_xrx200.c
 
 LANTIQ MIPS ARCHITECTURE
 M:	John Crispin <john@phrozen.org>
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index e0af39b33e28..eeb89a37e27e 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -505,7 +505,7 @@ void __init ltq_soc_init(void)
 		clkdev_add_pmu("1a800000.pcie", "msi", 1, 1, PMU1_PCIE2_MSI);
 		clkdev_add_pmu("1a800000.pcie", "pdi", 1, 1, PMU1_PCIE2_PDI);
 		clkdev_add_pmu("1a800000.pcie", "ctl", 1, 1, PMU1_PCIE2_CTL);
-		clkdev_add_pmu("1e108000.eth", NULL, 0, 0, PMU_SWITCH | PMU_PPE_DP);
+		clkdev_add_pmu("1e10b308.eth", NULL, 0, 0, PMU_SWITCH | PMU_PPE_DP);
 		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 	} else if (of_machine_is_compatible("lantiq,ar10")) {
@@ -513,7 +513,7 @@ void __init ltq_soc_init(void)
 				  ltq_ar10_fpi_hz(), ltq_ar10_pp32_hz());
 		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
 		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1);
-		clkdev_add_pmu("1e108000.eth", NULL, 0, 0, PMU_SWITCH |
+		clkdev_add_pmu("1e10b308.eth", NULL, 0, 0, PMU_SWITCH |
 			       PMU_PPE_DP | PMU_PPE_TC);
 		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
 		clkdev_add_pmu("1f203020.gphy", NULL, 1, 0, PMU_GPHY);
@@ -536,7 +536,7 @@ void __init ltq_soc_init(void)
 		clkdev_add_pmu(NULL, "ahb", 1, 0, PMU_AHBM | PMU_AHBS);
 
 		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
-		clkdev_add_pmu("1e108000.eth", NULL, 0, 0,
+		clkdev_add_pmu("1e10b308.eth", NULL, 0, 0,
 				PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM |
 				PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |
 				PMU_PPE_QSB | PMU_PPE_TOP);
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 6fde68aa13a4..885e00d17807 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -108,6 +108,13 @@ config LANTIQ_ETOP
 	---help---
 	  Support for the MII0 inside the Lantiq SoC
 
+config LANTIQ_XRX200
+	tristate "Lantiq / Intel xRX200 PMAC network driver"
+	depends on SOC_TYPE_XWAY
+	---help---
+	  Support for the PMAC of the Gigabit switch (GSWIP) inside the
+	  Lantiq / Intel VRX200 VDSL SoC
+
 source "drivers/net/ethernet/marvell/Kconfig"
 source "drivers/net/ethernet/mediatek/Kconfig"
 source "drivers/net/ethernet/mellanox/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index b45d5f626b59..7b5bf9682066 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_NET_VENDOR_XSCALE) += xscale/
 obj-$(CONFIG_JME) += jme.o
 obj-$(CONFIG_KORINA) += korina.o
 obj-$(CONFIG_LANTIQ_ETOP) += lantiq_etop.o
+obj-$(CONFIG_LANTIQ_XRX200) += lantiq_xrx200.o
 obj-$(CONFIG_NET_VENDOR_MARVELL) += marvell/
 obj-$(CONFIG_NET_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_NET_VENDOR_MELLANOX) += mellanox/
diff --git a/drivers/net/ethernet/lantiq_xrx200.c b/drivers/net/ethernet/lantiq_xrx200.c
new file mode 100644
index 000000000000..328f0253fb4a
--- /dev/null
+++ b/drivers/net/ethernet/lantiq_xrx200.c
@@ -0,0 +1,591 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lantiq / Intel PMAC driver for XRX200 SoCs
+ *
+ * Copyright (C) 2010 Lantiq Deutschland
+ * Copyright (C) 2012 John Crispin <john@phrozen.org>
+ * Copyright (C) 2017 - 2018 Hauke Mehrtens <hauke@hauke-m.de>
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+
+#include <xway_dma.h>
+
+/* DMA */
+#define XRX200_DMA_DATA_LEN	0x600
+#define XRX200_DMA_RX		0
+#define XRX200_DMA_TX		1
+
+/* cpu port mac */
+#define PMAC_RX_IPG		0x0024
+#define PMAC_RX_IPG_MASK	0xf
+
+#define PMAC_HD_CTL		0x0000
+/* Add Ethernet header to packets from DMA to PMAC */
+#define PMAC_HD_CTL_ADD		BIT(0)
+/* Add VLAN tag to Packets from DMA to PMAC */
+#define PMAC_HD_CTL_TAG		BIT(1)
+/* Add CRC to packets from DMA to PMAC */
+#define PMAC_HD_CTL_AC		BIT(2)
+/* Add status header to packets from PMAC to DMA */
+#define PMAC_HD_CTL_AS		BIT(3)
+/* Remove CRC from packets from PMAC to DMA */
+#define PMAC_HD_CTL_RC		BIT(4)
+/* Remove Layer-2 header from packets from PMAC to DMA */
+#define PMAC_HD_CTL_RL2		BIT(5)
+/* Status header is present from DMA to PMAC */
+#define PMAC_HD_CTL_RXSH	BIT(6)
+/* Add special tag from PMAC to switch */
+#define PMAC_HD_CTL_AST		BIT(7)
+/* Remove specail Tag from PMAC to DMA */
+#define PMAC_HD_CTL_RST		BIT(8)
+/* Check CRC from DMA to PMAC */
+#define PMAC_HD_CTL_CCRC	BIT(9)
+/* Enable reaction to Pause frames in the PMAC */
+#define PMAC_HD_CTL_FC		BIT(10)
+
+struct xrx200_chan {
+	int tx_free;
+
+	struct tasklet_struct tasklet;
+	struct napi_struct napi;
+	struct ltq_dma_channel dma;
+	struct sk_buff *skb[LTQ_DESC_NUM];
+
+	struct xrx200_priv *priv;
+};
+
+struct xrx200_priv {
+	struct net_device_stats stats;
+
+	struct clk *clk;
+
+	struct xrx200_chan chan_tx;
+	struct xrx200_chan chan_rx;
+
+	struct net_device *net_dev;
+	struct device *dev;
+
+	__iomem void *pmac_reg;
+};
+
+static u32 xrx200_pmac_r32(struct xrx200_priv *priv, u32 offset)
+{
+	return __raw_readl(priv->pmac_reg + offset);
+}
+
+static void xrx200_pmac_w32(struct xrx200_priv *priv, u32 val, u32 offset)
+{
+	return __raw_writel(val, priv->pmac_reg + offset);
+}
+
+static void xrx200_pmac_mask(struct xrx200_priv *priv, u32 clear, u32 set,
+			     u32 offset)
+{
+	u32 val = xrx200_pmac_r32(priv, offset);
+
+	val &= ~(clear);
+	val |= set;
+	xrx200_pmac_w32(priv, val, offset);
+}
+
+/* drop all the packets from the DMA ring */
+static void xrx200_flush_dma(struct xrx200_chan *ch)
+{
+	int i;
+
+	for (i = 0; i < LTQ_DESC_NUM; i++) {
+		struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
+
+		if ((desc->ctl & (LTQ_DMA_OWN | LTQ_DMA_C)) != LTQ_DMA_C)
+			break;
+
+		desc->ctl = LTQ_DMA_OWN | LTQ_DMA_RX_OFFSET(NET_IP_ALIGN) |
+			    XRX200_DMA_DATA_LEN;
+		ch->dma.desc++;
+		ch->dma.desc %= LTQ_DESC_NUM;
+	}
+}
+
+static int xrx200_open(struct net_device *dev)
+{
+	struct xrx200_priv *priv = netdev_priv(dev);
+
+	ltq_dma_open(&priv->chan_tx.dma);
+	ltq_dma_enable_irq(&priv->chan_tx.dma);
+
+	napi_enable(&priv->chan_rx.napi);
+	ltq_dma_open(&priv->chan_rx.dma);
+	/* The boot loader does not always deactivate the receiving of frames
+	 * on the ports and then some packets queue up in the PPE buffers.
+	 * They already passed the PMAC so they do not have the tags
+	 * configured here. Read the these packets here and drop them.
+	 * The HW should have written them into memory after 10us
+	 */
+	udelay(10);
+	xrx200_flush_dma(&priv->chan_rx);
+	ltq_dma_enable_irq(&priv->chan_rx.dma);
+
+	netif_wake_queue(dev);
+
+	return 0;
+}
+
+static int xrx200_close(struct net_device *dev)
+{
+	struct xrx200_priv *priv = netdev_priv(dev);
+
+	netif_stop_queue(dev);
+
+	napi_disable(&priv->chan_rx.napi);
+	ltq_dma_close(&priv->chan_rx.dma);
+
+	ltq_dma_close(&priv->chan_tx.dma);
+
+	return 0;
+}
+
+static int xrx200_alloc_skb(struct xrx200_chan *ch)
+{
+	int ret = 0;
+
+#define DMA_PAD	(NET_IP_ALIGN + NET_SKB_PAD)
+	ch->skb[ch->dma.desc] = dev_alloc_skb(XRX200_DMA_DATA_LEN + DMA_PAD);
+	if (!ch->skb[ch->dma.desc]) {
+		ret = -ENOMEM;
+		goto skip;
+	}
+
+	skb_reserve(ch->skb[ch->dma.desc], NET_SKB_PAD);
+	ch->dma.desc_base[ch->dma.desc].addr = dma_map_single(ch->priv->dev,
+			ch->skb[ch->dma.desc]->data, XRX200_DMA_DATA_LEN,
+			DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(ch->priv->dev,
+				       ch->dma.desc_base[ch->dma.desc].addr))) {
+		dev_kfree_skb_any(ch->skb[ch->dma.desc]);
+		ret = -ENOMEM;
+		goto skip;
+	}
+
+	ch->dma.desc_base[ch->dma.desc].addr =
+		CPHYSADDR(ch->skb[ch->dma.desc]->data);
+	skb_reserve(ch->skb[ch->dma.desc], NET_IP_ALIGN);
+
+skip:
+	ch->dma.desc_base[ch->dma.desc].ctl =
+		LTQ_DMA_OWN | LTQ_DMA_RX_OFFSET(NET_IP_ALIGN) |
+		XRX200_DMA_DATA_LEN;
+
+	return ret;
+}
+
+static int xrx200_hw_receive(struct xrx200_chan *ch)
+{
+	struct xrx200_priv *priv = ch->priv;
+	struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
+	struct sk_buff *skb = ch->skb[ch->dma.desc];
+	int len = (desc->ctl & LTQ_DMA_SIZE_MASK);
+	int ret;
+
+	ret = xrx200_alloc_skb(ch);
+
+	ch->dma.desc++;
+	ch->dma.desc %= LTQ_DESC_NUM;
+
+	if (ret) {
+		netdev_err(priv->net_dev,
+			   "failed to allocate new rx buffer\n");
+		return ret;
+	}
+
+	skb_put(skb, len);
+	skb->dev = priv->net_dev;
+	skb->protocol = eth_type_trans(skb, priv->net_dev);
+	netif_receive_skb(skb);
+	priv->stats.rx_packets++;
+	priv->stats.rx_bytes += len;
+
+	return 0;
+}
+
+static int xrx200_poll_rx(struct napi_struct *napi, int budget)
+{
+	struct xrx200_chan *ch = container_of(napi,
+				struct xrx200_chan, napi);
+	int rx = 0;
+	int ret;
+
+	while (rx < budget) {
+		struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
+
+		if ((desc->ctl & (LTQ_DMA_OWN | LTQ_DMA_C)) == LTQ_DMA_C) {
+			ret = xrx200_hw_receive(ch);
+			if (ret)
+				return ret;
+			rx++;
+		} else {
+			break;
+		}
+	}
+
+	if (rx < budget) {
+		napi_complete(&ch->napi);
+		ltq_dma_enable_irq(&ch->dma);
+	}
+
+	return rx;
+}
+
+static void xrx200_tx_housekeeping(unsigned long ptr)
+{
+	struct xrx200_chan *ch = (struct xrx200_chan *)ptr;
+	int pkts = 0;
+	int bytes = 0;
+
+	ltq_dma_ack_irq(&ch->dma);
+	while ((ch->dma.desc_base[ch->tx_free].ctl &
+		(LTQ_DMA_OWN | LTQ_DMA_C)) == LTQ_DMA_C) {
+		struct sk_buff *skb = ch->skb[ch->tx_free];
+
+		pkts++;
+		bytes += skb->len;
+		ch->skb[ch->tx_free] = NULL;
+		dev_kfree_skb(skb);
+		memset(&ch->dma.desc_base[ch->tx_free], 0,
+		       sizeof(struct ltq_dma_desc));
+		ch->tx_free++;
+		ch->tx_free %= LTQ_DESC_NUM;
+	}
+	ltq_dma_enable_irq(&ch->dma);
+
+	netdev_completed_queue(ch->priv->net_dev, pkts, bytes);
+
+	if (!pkts)
+		return;
+
+	netif_wake_queue(ch->priv->net_dev);
+}
+
+static struct net_device_stats *xrx200_get_stats(struct net_device *dev)
+{
+	struct xrx200_priv *priv = netdev_priv(dev);
+
+	return &priv->stats;
+}
+
+static int xrx200_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct xrx200_priv *priv = netdev_priv(dev);
+	struct xrx200_chan *ch;
+	struct ltq_dma_desc *desc;
+	u32 byte_offset;
+	dma_addr_t mapping;
+	int len;
+
+	ch = &priv->chan_tx;
+
+	desc = &ch->dma.desc_base[ch->dma.desc];
+
+	skb->dev = dev;
+	len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
+
+	/* dma needs to start on a 16 byte aligned address */
+	byte_offset = CPHYSADDR(skb->data) % 16;
+
+	if ((desc->ctl & (LTQ_DMA_OWN | LTQ_DMA_C)) || ch->skb[ch->dma.desc]) {
+		netdev_err(dev, "tx ring full\n");
+		netif_stop_queue(dev);
+		return NETDEV_TX_BUSY;
+	}
+
+	ch->skb[ch->dma.desc] = skb;
+
+	netif_trans_update(dev);
+
+	mapping = dma_map_single(priv->dev, skb->data, len, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(priv->dev, mapping)))
+		goto err_drop;
+
+	desc->addr = mapping - byte_offset;
+	/* Make sure the address is written before we give it to HW */
+	wmb();
+	desc->ctl = LTQ_DMA_OWN | LTQ_DMA_SOP | LTQ_DMA_EOP |
+		LTQ_DMA_TX_OFFSET(byte_offset) | (len & LTQ_DMA_SIZE_MASK);
+	ch->dma.desc++;
+	ch->dma.desc %= LTQ_DESC_NUM;
+	if (ch->dma.desc == ch->tx_free)
+		netif_stop_queue(dev);
+
+	netdev_sent_queue(dev, skb->len);
+	priv->stats.tx_packets++;
+	priv->stats.tx_bytes += len;
+
+	return NETDEV_TX_OK;
+
+err_drop:
+	dev_kfree_skb(skb);
+	priv->stats.tx_dropped++;
+	priv->stats.tx_errors++;
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops xrx200_netdev_ops = {
+	.ndo_open		= xrx200_open,
+	.ndo_stop		= xrx200_close,
+	.ndo_start_xmit		= xrx200_start_xmit,
+	.ndo_set_mac_address	= eth_mac_addr,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_change_mtu		= eth_change_mtu,
+	.ndo_get_stats		= xrx200_get_stats,
+};
+
+static irqreturn_t xrx200_dma_irq_tx(int irq, void *ptr)
+{
+	struct xrx200_priv *priv = ptr;
+	struct xrx200_chan *ch = &priv->chan_tx;
+
+	ltq_dma_disable_irq(&ch->dma);
+	ltq_dma_ack_irq(&ch->dma);
+
+	tasklet_schedule(&ch->tasklet);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t xrx200_dma_irq_rx(int irq, void *ptr)
+{
+	struct xrx200_priv *priv = ptr;
+	struct xrx200_chan *ch = &priv->chan_rx;
+
+	ltq_dma_disable_irq(&ch->dma);
+	ltq_dma_ack_irq(&ch->dma);
+
+	napi_schedule(&ch->napi);
+
+	return IRQ_HANDLED;
+}
+
+static int xrx200_dma_init(struct xrx200_priv *priv)
+{
+	struct xrx200_chan *ch_rx = &priv->chan_rx;
+	struct xrx200_chan *ch_tx = &priv->chan_tx;
+	int ret = 0;
+	int i;
+
+	ltq_dma_init_port(DMA_PORT_ETOP);
+
+	ch_rx->dma.nr = XRX200_DMA_RX;
+	ch_rx->dma.dev = priv->dev;
+	ch_rx->priv = priv;
+
+	ltq_dma_alloc_rx(&ch_rx->dma);
+	for (ch_rx->dma.desc = 0; ch_rx->dma.desc < LTQ_DESC_NUM;
+	     ch_rx->dma.desc++) {
+		ret = xrx200_alloc_skb(ch_rx);
+		if (ret)
+			goto rx_free;
+	}
+	ch_rx->dma.desc = 0;
+	ret = devm_request_irq(priv->dev, ch_rx->dma.irq, xrx200_dma_irq_rx, 0,
+			       "xrx200_net_rx", priv);
+	if (ret) {
+		dev_err(priv->dev, "failed to request RX irq %d\n",
+			ch_rx->dma.irq);
+		goto rx_ring_free;
+	}
+
+	ch_tx->dma.nr = XRX200_DMA_TX;
+	ch_tx->dma.dev = priv->dev;
+	ch_tx->priv = priv;
+
+	ltq_dma_alloc_tx(&ch_tx->dma);
+	ret = devm_request_irq(priv->dev, ch_tx->dma.irq, xrx200_dma_irq_tx, 0,
+			       "xrx200_net_tx", priv);
+	if (ret) {
+		dev_err(priv->dev, "failed to request TX irq %d\n",
+			ch_tx->dma.irq);
+		goto tx_free;
+	}
+
+	return ret;
+
+tx_free:
+	ltq_dma_free(&ch_tx->dma);
+
+rx_ring_free:
+	/* free the allocated RX ring */
+	for (i = 0; i < LTQ_DESC_NUM; i++) {
+		if (priv->chan_rx.skb[i])
+			dev_kfree_skb_any(priv->chan_rx.skb[i]);
+	}
+
+rx_free:
+	ltq_dma_free(&ch_rx->dma);
+	return ret;
+}
+
+static void xrx200_hw_cleanup(struct xrx200_priv *priv)
+{
+	int i;
+
+	ltq_dma_free(&priv->chan_tx.dma);
+	ltq_dma_free(&priv->chan_rx.dma);
+
+	/* free the allocated RX ring */
+	for (i = 0; i < LTQ_DESC_NUM; i++)
+		dev_kfree_skb_any(priv->chan_rx.skb[i]);
+}
+
+static int xrx200_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct resource *res;
+	struct xrx200_priv *priv;
+	struct net_device *net_dev;
+	const u8 *mac;
+	int err;
+
+	/* alloc the network device */
+	net_dev = devm_alloc_etherdev(dev, sizeof(struct xrx200_priv));
+	if (!net_dev)
+		return -ENOMEM;
+
+	priv = netdev_priv(net_dev);
+	priv->net_dev = net_dev;
+	priv->dev = dev;
+
+	net_dev->netdev_ops = &xrx200_netdev_ops;
+	SET_NETDEV_DEV(net_dev, dev);
+	net_dev->min_mtu = ETH_ZLEN;
+	net_dev->max_mtu = XRX200_DMA_DATA_LEN;
+
+	/* load the memory ranges */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get resources\n");
+		return -ENOENT;
+	}
+
+	priv->pmac_reg = devm_ioremap_resource(dev, res);
+	if (!priv->pmac_reg) {
+		dev_err(dev, "failed to request and remap io ranges\n");
+		return -ENOMEM;
+	}
+
+	priv->chan_rx.dma.irq = platform_get_irq_byname(pdev, "rx");
+	if (priv->chan_rx.dma.irq < 0) {
+		dev_err(dev, "failed to get RX IRQ, %i\n",
+			priv->chan_rx.dma.irq);
+		return -ENOENT;
+	}
+	priv->chan_tx.dma.irq = platform_get_irq_byname(pdev, "tx");
+	if (priv->chan_tx.dma.irq < 0) {
+		dev_err(dev, "failed to get TX IRQ, %i\n",
+			priv->chan_tx.dma.irq);
+		return -ENOENT;
+	}
+
+	/* get the clock */
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(dev, "failed to get clock\n");
+		return PTR_ERR(priv->clk);
+	}
+
+	mac = of_get_mac_address(np);
+	if (mac && is_valid_ether_addr(mac))
+		ether_addr_copy(net_dev->dev_addr, mac);
+	else
+		eth_hw_addr_random(net_dev);
+
+	/* bring up the dma engine and IP core */
+	err = xrx200_dma_init(priv);
+	if (err)
+		return err;
+
+	/* enable clock gate */
+	err = clk_prepare_enable(priv->clk);
+	if (err)
+		goto err_uninit_dma;
+
+	/* set IPG to 12 */
+	xrx200_pmac_mask(priv, PMAC_RX_IPG_MASK, 0xb, PMAC_RX_IPG);
+
+	/* enable status header, enable CRC */
+	xrx200_pmac_mask(priv, 0,
+			 PMAC_HD_CTL_RST | PMAC_HD_CTL_AST | PMAC_HD_CTL_RXSH |
+			 PMAC_HD_CTL_AS | PMAC_HD_CTL_AC | PMAC_HD_CTL_RC,
+			 PMAC_HD_CTL);
+
+	tasklet_init(&priv->chan_tx.tasklet, xrx200_tx_housekeeping,
+		     (u32)&priv->chan_tx);
+
+	/* setup NAPI */
+	netif_napi_add(net_dev, &priv->chan_rx.napi, xrx200_poll_rx, 32);
+
+	platform_set_drvdata(pdev, priv);
+
+	err = register_netdev(net_dev);
+	if (err)
+		goto err_unprepare_clk;
+	return err;
+
+err_unprepare_clk:
+	clk_disable_unprepare(priv->clk);
+
+err_uninit_dma:
+	xrx200_hw_cleanup(priv);
+
+	return 0;
+}
+
+static int xrx200_remove(struct platform_device *pdev)
+{
+	struct xrx200_priv *priv = platform_get_drvdata(pdev);
+	struct net_device *net_dev = priv->net_dev;
+
+	/* free stack related instances */
+	netif_stop_queue(net_dev);
+	netif_napi_del(&priv->chan_rx.napi);
+
+	/* remove the actual device */
+	unregister_netdev(net_dev);
+
+	/* release the clock */
+	clk_disable_unprepare(priv->clk);
+
+	/* shut down hardware */
+	xrx200_hw_cleanup(priv);
+
+	return 0;
+}
+
+static const struct of_device_id xrx200_match[] = {
+	{ .compatible = "lantiq,xrx200-net" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xrx200_match);
+
+static struct platform_driver xrx200_driver = {
+	.probe = xrx200_probe,
+	.remove = xrx200_remove,
+	.driver = {
+		.name = "lantiq,xrx200-net",
+		.of_match_table = xrx200_match,
+	},
+};
+
+module_platform_driver(xrx200_driver);
+
+MODULE_AUTHOR("John Crispin <john@phrozen.org>");
+MODULE_DESCRIPTION("Lantiq SoC XRX200 ethernet");
+MODULE_LICENSE("GPL");
-- 
2.11.0
