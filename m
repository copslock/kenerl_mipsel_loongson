Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2016 16:28:53 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:45060 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008855AbcACP1B5o0Y7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2016 16:27:01 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id B843328C187;
        Sun,  3 Jan 2016 16:26:30 +0100 (CET)
Received: from localhost.localdomain (p548C9B8E.dip0.t-ipconnect.de [84.140.155.142])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Sun,  3 Jan 2016 16:26:30 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mediatek@lists.infradead.org,
        John Crispin <blogic@openwrt.org>,
        Felix Fietkau <nbd@nbd.name>, Michael Lee <igvtee@gmail.com>,
        =?UTF-8?q?Steven=20Liu=20=28=E5=8A=89=E4=BA=BA=E8=B1=AA=29?= 
        <steven.liu@mediatek.com>,
        =?UTF-8?q?Fred=20Chang=20=28=E5=BC=B5=E5=98=89=E5=AE=8F=29?= 
        <Fred.Chang@mediatek.com>
Subject: [PATCH 08/12] net-next: mediatek: add support for rt3883
Date:   Sun,  3 Jan 2016 16:26:11 +0100
Message-Id: <1451834775-15789-8-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
References: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Add support for rt3883 and its smaller version rt3662. They both have a
single gBit port that will normally be attached to an external phy or
switch.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Michael Lee <igvtee@gmail.com>
---
 drivers/net/ethernet/mediatek/soc_rt3883.c |   77 ++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 drivers/net/ethernet/mediatek/soc_rt3883.c

diff --git a/drivers/net/ethernet/mediatek/soc_rt3883.c b/drivers/net/ethernet/mediatek/soc_rt3883.c
new file mode 100644
index 0000000..6b7286d
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/soc_rt3883.c
@@ -0,0 +1,77 @@
+/*   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; version 2 of the License
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   Copyright (C) 2009-2015 John Crispin <blogic@openwrt.org>
+ *   Copyright (C) 2009-2015 Felix Fietkau <nbd@openwrt.org>
+ *   Copyright (C) 2013-2015 Michael Lee <igvtee@gmail.com>
+ */
+
+#include <linux/module.h>
+
+#include <asm/mach-ralink/ralink_regs.h>
+
+#include "mtk_eth_soc.h"
+#include "mdio_rt2880.h"
+
+#define RT3883_RSTCTRL_FE		BIT(21)
+
+static void rt3883_fe_reset(void)
+{
+	fe_reset(RT3883_RSTCTRL_FE);
+}
+
+static int rt3883_fwd_config(struct fe_priv *priv)
+{
+	int ret;
+
+	ret = fe_set_clock_cycle(priv);
+	if (ret)
+		return ret;
+
+	fe_fwd_config(priv);
+	fe_w32(FE_PSE_FQFC_CFG_256Q, FE_PSE_FQ_CFG);
+	fe_csum_config(priv);
+
+	return ret;
+}
+
+static void rt3883_init_data(struct fe_soc_data *data,
+			     struct net_device *netdev)
+{
+	struct fe_priv *priv = netdev_priv(netdev);
+
+	priv->flags = FE_FLAG_PADDING_64B | FE_FLAG_PADDING_BUG |
+		FE_FLAG_JUMBO_FRAME | FE_FLAG_CALIBRATE_CLK;
+	netdev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM |
+		NETIF_F_RXCSUM | NETIF_F_HW_VLAN_CTAG_TX;
+}
+
+static struct fe_soc_data rt3883_data = {
+	.dma_type = FE_PDMA,
+	.txd4 = TX_DMA_DESP4_DEF,
+	.init_data = rt3883_init_data,
+	.reset_fe = rt3883_fe_reset,
+	.fwd_config = rt3883_fwd_config,
+	.pdma_glo_cfg = FE_PDMA_SIZE_8DWORDS,
+	.rx_int = FE_RX_DONE_INT,
+	.tx_int = FE_TX_DONE_INT,
+	.status_int = FE_CNT_GDM_AF,
+	.checksum_bit = RX_DMA_L4VALID,
+	.mdio_read = rt2880_mdio_read,
+	.mdio_write = rt2880_mdio_write,
+	.mdio_adjust_link = rt2880_mdio_link_adjust,
+	.port_init = rt2880_port_init,
+};
+
+const struct of_device_id of_fe_match[] = {
+	{ .compatible = "ralink,rt3883-eth", .data = &rt3883_data },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, of_fe_match);
-- 
1.7.10.4
