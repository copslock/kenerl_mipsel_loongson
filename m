Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2016 16:27:40 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:45021 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008985AbcACP0sbwxW7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2016 16:26:48 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id BD1CF28C06D;
        Sun,  3 Jan 2016 16:26:16 +0100 (CET)
Received: from localhost.localdomain (p548C9B8E.dip0.t-ipconnect.de [84.140.155.142])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Sun,  3 Jan 2016 16:26:16 +0100 (CET)
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
Subject: [PATCH 04/12] net-next: mediatek: add switch driver for mt7620
Date:   Sun,  3 Jan 2016 16:26:07 +0100
Message-Id: <1451834775-15789-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
References: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50823
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

This driver is very basic and only provides basic init and irq support.
The SoC and switch core both have support for a special tag making DSA
support possible.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 drivers/net/ethernet/mediatek/gsw_mt7620.c |  256 ++++++++++++++++++++++++++++
 drivers/net/ethernet/mediatek/gsw_mt7620.h |  117 +++++++++++++
 2 files changed, 373 insertions(+)
 create mode 100644 drivers/net/ethernet/mediatek/gsw_mt7620.c
 create mode 100644 drivers/net/ethernet/mediatek/gsw_mt7620.h

diff --git a/drivers/net/ethernet/mediatek/gsw_mt7620.c b/drivers/net/ethernet/mediatek/gsw_mt7620.c
new file mode 100644
index 0000000..08c774b
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gsw_mt7620.c
@@ -0,0 +1,256 @@
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
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+
+#include <ralink_regs.h>
+
+#include "mtk_eth_soc.h"
+#include "gsw_mt7620.h"
+
+void mtk_switch_w32(struct mt7620_gsw *gsw, u32 val, unsigned reg)
+{
+	iowrite32(val, gsw->base + reg);
+}
+
+u32 mtk_switch_r32(struct mt7620_gsw *gsw, unsigned reg)
+{
+	return ioread32(gsw->base + reg);
+}
+
+static irqreturn_t gsw_interrupt_mt7620(int irq, void *_priv)
+{
+	struct fe_priv *priv = (struct fe_priv *)_priv;
+	struct mt7620_gsw *gsw = (struct mt7620_gsw *)priv->soc->swpriv;
+	u32 status;
+	int i, max = (gsw->port4 == PORT4_EPHY) ? (4) : (3);
+
+	status = mtk_switch_r32(gsw, GSW_REG_ISR);
+	if (status & PORT_IRQ_ST_CHG)
+		for (i = 0; i <= max; i++) {
+			u32 status = mtk_switch_r32(gsw,
+						    GSW_REG_PORT_STATUS(i));
+			int link = status & 0x1;
+
+			if (link != priv->link[i])
+				mt7620_print_link_state(priv, i, link,
+							(status >> 2) & 3,
+							(status & 0x2));
+
+			priv->link[i] = link;
+		}
+	mtk_switch_w32(gsw, status, GSW_REG_ISR);
+
+	return IRQ_HANDLED;
+}
+
+static void mt7620_hw_init(struct mt7620_gsw *gsw, struct device_node *np)
+{
+	u32 is_BGA = (rt_sysc_r32(0x0c) >> 16) & 1;
+
+	rt_sysc_w32(rt_sysc_r32(SYSC_REG_CFG1) | BIT(8), SYSC_REG_CFG1);
+	mtk_switch_w32(gsw, mtk_switch_r32(gsw, GSW_REG_CKGCR) & ~(0x3 << 4),
+		       GSW_REG_CKGCR);
+
+	if (of_property_read_bool(np, "mediatek,mt7530")) {
+		u32 val;
+
+		/* turn off ephy and set phy base addr to 12 */
+		mtk_switch_w32(gsw, mtk_switch_r32(gsw, GSW_REG_GPC1) |
+			(0x1f << 24) | (0xc << 16),
+			GSW_REG_GPC1);
+
+		/* set MT7530 central align */
+		val = mt7530_mdio_r32(gsw, 0x7830);
+		val &= ~BIT(0);
+		val |= BIT(1);
+		mt7530_mdio_w32(gsw, 0x7830, val);
+
+		val = mt7530_mdio_r32(gsw, 0x7a40);
+		val &= ~BIT(30);
+		mt7530_mdio_w32(gsw, 0x7a40, val);
+
+		mt7530_mdio_w32(gsw, 0x7a78, 0x855);
+	} else {
+		/* global page 4 */
+		_mt7620_mii_write(gsw, 1, 31, 0x4000);
+
+		_mt7620_mii_write(gsw, 1, 17, 0x7444);
+		if (is_BGA)
+			_mt7620_mii_write(gsw, 1, 19, 0x0114);
+		else
+			_mt7620_mii_write(gsw, 1, 19, 0x0117);
+
+		_mt7620_mii_write(gsw, 1, 22, 0x10cf);
+		_mt7620_mii_write(gsw, 1, 25, 0x6212);
+		_mt7620_mii_write(gsw, 1, 26, 0x0777);
+		_mt7620_mii_write(gsw, 1, 29, 0x4000);
+		_mt7620_mii_write(gsw, 1, 28, 0xc077);
+		_mt7620_mii_write(gsw, 1, 24, 0x0000);
+
+		/* global page 3 */
+		_mt7620_mii_write(gsw, 1, 31, 0x3000);
+		_mt7620_mii_write(gsw, 1, 17, 0x4838);
+
+		/* global page 2 */
+		_mt7620_mii_write(gsw, 1, 31, 0x2000);
+		if (is_BGA) {
+			_mt7620_mii_write(gsw, 1, 21, 0x0515);
+			_mt7620_mii_write(gsw, 1, 22, 0x0053);
+			_mt7620_mii_write(gsw, 1, 23, 0x00bf);
+			_mt7620_mii_write(gsw, 1, 24, 0x0aaf);
+			_mt7620_mii_write(gsw, 1, 25, 0x0fad);
+			_mt7620_mii_write(gsw, 1, 26, 0x0fc1);
+		} else {
+			_mt7620_mii_write(gsw, 1, 21, 0x0517);
+			_mt7620_mii_write(gsw, 1, 22, 0x0fd2);
+			_mt7620_mii_write(gsw, 1, 23, 0x00bf);
+			_mt7620_mii_write(gsw, 1, 24, 0x0aab);
+			_mt7620_mii_write(gsw, 1, 25, 0x00ae);
+			_mt7620_mii_write(gsw, 1, 26, 0x0fff);
+		}
+		/* global page 1 */
+		_mt7620_mii_write(gsw, 1, 31, 0x1000);
+		_mt7620_mii_write(gsw, 1, 17, 0xe7f8);
+	}
+
+	/* global page 0 */
+	_mt7620_mii_write(gsw, 1, 31, 0x8000);
+	_mt7620_mii_write(gsw, 0, 30, 0xa000);
+	_mt7620_mii_write(gsw, 1, 30, 0xa000);
+	_mt7620_mii_write(gsw, 2, 30, 0xa000);
+	_mt7620_mii_write(gsw, 3, 30, 0xa000);
+
+	_mt7620_mii_write(gsw, 0, 4, 0x05e1);
+	_mt7620_mii_write(gsw, 1, 4, 0x05e1);
+	_mt7620_mii_write(gsw, 2, 4, 0x05e1);
+	_mt7620_mii_write(gsw, 3, 4, 0x05e1);
+
+	/* global page 2 */
+	_mt7620_mii_write(gsw, 1, 31, 0xa000);
+	_mt7620_mii_write(gsw, 0, 16, 0x1111);
+	_mt7620_mii_write(gsw, 1, 16, 0x1010);
+	_mt7620_mii_write(gsw, 2, 16, 0x1515);
+	_mt7620_mii_write(gsw, 3, 16, 0x0f0f);
+
+	/* CPU Port6 Force Link 1G, FC ON */
+	mtk_switch_w32(gsw, 0x5e33b, GSW_REG_PORT_PMCR(6));
+
+	/* Set Port 6 as CPU Port */
+	mtk_switch_w32(gsw, 0x7f7f7fe0, 0x0010);
+
+	/* setup port 4 */
+	if (gsw->port4 == PORT4_EPHY) {
+		u32 val = rt_sysc_r32(SYSC_REG_CFG1);
+
+		val |= 3 << 14;
+		rt_sysc_w32(val, SYSC_REG_CFG1);
+		_mt7620_mii_write(gsw, 4, 30, 0xa000);
+		_mt7620_mii_write(gsw, 4, 4, 0x05e1);
+		_mt7620_mii_write(gsw, 4, 16, 0x1313);
+		pr_info("gsw: setting port4 to ephy mode\n");
+	}
+}
+
+static const struct of_device_id mediatek_gsw_match[] = {
+	{ .compatible = "mediatek,mt7620-gsw" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mediatek_gsw_match);
+
+int mtk_gsw_init(struct fe_priv *priv)
+{
+	struct device_node *np = priv->switch_np;
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct mt7620_gsw *gsw;
+
+	if (!pdev)
+		return -ENODEV;
+
+	if (!of_device_is_compatible(np, mediatek_gsw_match->compatible))
+		return -EINVAL;
+
+	gsw = platform_get_drvdata(pdev);
+	priv->soc->swpriv = gsw;
+
+	mt7620_hw_init(gsw, np);
+
+	if (gsw->irq) {
+		request_irq(gsw->irq, gsw_interrupt_mt7620, 0,
+			    "gsw", priv);
+		mtk_switch_w32(gsw, ~PORT_IRQ_ST_CHG, GSW_REG_IMR);
+	}
+
+	return 0;
+}
+
+static int mt7620_gsw_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	const char *port4 = NULL;
+	struct mt7620_gsw *gsw;
+	struct device_node *np;
+
+	gsw = devm_kzalloc(&pdev->dev, sizeof(struct mt7620_gsw), GFP_KERNEL);
+	if (!gsw)
+		return -ENOMEM;
+
+	gsw->base = devm_ioremap_resource(&pdev->dev, res);
+	if (!gsw->base)
+		return -EADDRNOTAVAIL;
+
+	gsw->dev = &pdev->dev;
+
+	of_property_read_string(np, "mediatek,port4", &port4);
+	if (port4 && !strcmp(port4, "ephy"))
+		gsw->port4 = PORT4_EPHY;
+	else if (port4 && !strcmp(port4, "gmac"))
+		gsw->port4 = PORT4_EXT;
+	else
+		gsw->port4 = PORT4_EPHY;
+
+	gsw->irq = irq_of_parse_and_map(np, 0);
+
+	platform_set_drvdata(pdev, gsw);
+
+	return 0;
+}
+
+static int mt7620_gsw_remove(struct platform_device *pdev)
+{
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver gsw_driver = {
+	.probe = mt7620_gsw_probe,
+	.remove = mt7620_gsw_remove,
+	.driver = {
+		.name = "mt7620-gsw",
+		.owner = THIS_MODULE,
+		.of_match_table = mediatek_gsw_match,
+	},
+};
+
+module_platform_driver(gsw_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
+MODULE_DESCRIPTION("GBit switch driver for Mediatek MT7620 SoC");
diff --git a/drivers/net/ethernet/mediatek/gsw_mt7620.h b/drivers/net/ethernet/mediatek/gsw_mt7620.h
new file mode 100644
index 0000000..9f4057c
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gsw_mt7620.h
@@ -0,0 +1,117 @@
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
+#ifndef _RALINK_GSW_MT7620_H__
+#define _RALINK_GSW_MT7620_H__
+
+#define GSW_REG_PHY_TIMEOUT	(5 * HZ)
+
+#ifdef CONFIG_SOC_MT7621
+#define MT7620A_GSW_REG_PIAC	0x0004
+#else
+#define MT7620A_GSW_REG_PIAC	0x7004
+#endif
+
+#define GSW_NUM_VLANS		16
+#define GSW_NUM_VIDS		4096
+#define GSW_NUM_PORTS		7
+#define GSW_PORT6		6
+
+#define GSW_MDIO_ACCESS		BIT(31)
+#define GSW_MDIO_READ		BIT(19)
+#define GSW_MDIO_WRITE		BIT(18)
+#define GSW_MDIO_START		BIT(16)
+#define GSW_MDIO_ADDR_SHIFT	20
+#define GSW_MDIO_REG_SHIFT	25
+
+#define GSW_REG_PORT_PMCR(x)	(0x3000 + (x * 0x100))
+#define GSW_REG_PORT_STATUS(x)	(0x3008 + (x * 0x100))
+#define GSW_REG_SMACCR0		0x3fE4
+#define GSW_REG_SMACCR1		0x3fE8
+#define GSW_REG_CKGCR		0x3ff0
+
+#define GSW_REG_IMR		0x7008
+#define GSW_REG_ISR		0x700c
+#define GSW_REG_GPC1		0x7014
+
+#define SYSC_REG_CHIP_REV_ID	0x0c
+#define SYSC_REG_CFG1		0x14
+#define RST_CTRL_MCM		BIT(2)
+#define SYSC_PAD_RGMII2_MDIO	0x58
+#define SYSC_GPIO_MODE		0x60
+
+#define PORT_IRQ_ST_CHG		0x7f
+
+#ifdef CONFIG_SOC_MT7621
+#define ESW_PHY_POLLING		0x0000
+#else
+#define ESW_PHY_POLLING		0x7000
+#endif
+
+#define	PMCR_IPG		BIT(18)
+#define	PMCR_MAC_MODE		BIT(16)
+#define	PMCR_FORCE		BIT(15)
+#define	PMCR_TX_EN		BIT(14)
+#define	PMCR_RX_EN		BIT(13)
+#define	PMCR_BACKOFF		BIT(9)
+#define	PMCR_BACKPRES		BIT(8)
+#define	PMCR_RX_FC		BIT(5)
+#define	PMCR_TX_FC		BIT(4)
+#define	PMCR_SPEED(_x)		(_x << 2)
+#define	PMCR_DUPLEX		BIT(1)
+#define	PMCR_LINK		BIT(0)
+
+#define PHY_AN_EN		BIT(31)
+#define PHY_PRE_EN		BIT(30)
+#define PMY_MDC_CONF(_x)	((_x & 0x3f) << 24)
+
+enum {
+	/* Global attributes. */
+	GSW_ATTR_ENABLE_VLAN,
+	/* Port attributes. */
+	GSW_ATTR_PORT_UNTAG,
+};
+
+enum {
+	PORT4_EPHY = 0,
+	PORT4_EXT,
+};
+
+struct mt7620_gsw {
+	struct device		*dev;
+	void __iomem		*base;
+	int			irq;
+	int			port4;
+	unsigned long int	autopoll;
+};
+
+void mtk_switch_w32(struct mt7620_gsw *gsw, u32 val, unsigned reg);
+u32 mtk_switch_r32(struct mt7620_gsw *gsw, unsigned reg);
+int mtk_gsw_init(struct fe_priv *priv);
+
+int mt7620_mdio_write(struct mii_bus *bus, int phy_addr, int phy_reg, u16 val);
+int mt7620_mdio_read(struct mii_bus *bus, int phy_addr, int phy_reg);
+void mt7620_mdio_link_adjust(struct fe_priv *priv, int port);
+int mt7620_has_carrier(struct fe_priv *priv);
+void mt7620_print_link_state(struct fe_priv *priv, int port, int link,
+			     int speed, int duplex);
+
+void mt7530_mdio_w32(struct mt7620_gsw *gsw, u32 reg, u32 val);
+u32 mt7530_mdio_r32(struct mt7620_gsw *gsw, u32 reg);
+
+u32 _mt7620_mii_write(struct mt7620_gsw *gsw, u32 phy_addr,
+		      u32 phy_register, u32 write_data);
+u32 _mt7620_mii_read(struct mt7620_gsw *gsw, int phy_addr, int phy_reg);
+
+#endif
-- 
1.7.10.4
