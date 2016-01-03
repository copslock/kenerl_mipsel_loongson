Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2016 16:27:56 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:45027 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008977AbcACP0wIVx87 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 3 Jan 2016 16:26:52 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id BC8A628C06E;
        Sun,  3 Jan 2016 16:26:20 +0100 (CET)
Received: from localhost.localdomain (p548C9B8E.dip0.t-ipconnect.de [84.140.155.142])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Sun,  3 Jan 2016 16:26:20 +0100 (CET)
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
Subject: [PATCH 05/12] net-next: mediatek: add switch driver for mt7621
Date:   Sun,  3 Jan 2016 16:26:08 +0100
Message-Id: <1451834775-15789-5-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
References: <1451834775-15789-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50824
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
 drivers/net/ethernet/mediatek/gsw_mt7621.c |  283 ++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)
 create mode 100644 drivers/net/ethernet/mediatek/gsw_mt7621.c

diff --git a/drivers/net/ethernet/mediatek/gsw_mt7621.c b/drivers/net/ethernet/mediatek/gsw_mt7621.c
new file mode 100644
index 0000000..6f3327e
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gsw_mt7621.c
@@ -0,0 +1,283 @@
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
+static irqreturn_t gsw_interrupt_mt7621(int irq, void *_priv)
+{
+	struct fe_priv *priv = (struct fe_priv *)_priv;
+	struct mt7620_gsw *gsw = (struct mt7620_gsw *)priv->soc->swpriv;
+	u32 reg, i;
+
+	reg = mt7530_mdio_r32(gsw, 0x700c);
+
+	for (i = 0; i < 5; i++)
+		if (reg & BIT(i)) {
+			unsigned int link;
+
+			link = mt7530_mdio_r32(gsw,
+					       0x3008 + (i * 0x100)) & 0x1;
+
+			if (link != priv->link[i]) {
+				priv->link[i] = link;
+				if (link)
+					netdev_info(priv->netdev,
+						    "port %d link up\n", i);
+				else
+					netdev_info(priv->netdev,
+						    "port %d link down\n", i);
+			}
+		}
+
+	mt7530_mdio_w32(gsw, 0x700c, 0x1f);
+
+	return IRQ_HANDLED;
+}
+
+static void mt7621_hw_init(struct mt7620_gsw *gsw, struct device_node *np)
+{
+	u32 i;
+	u32 val;
+
+	/* wardware reset the switch */
+	fe_reset(RST_CTRL_MCM);
+	mdelay(10);
+
+	/* reduce RGMII2 PAD driving strength */
+	rt_sysc_m32(3 << 4, 0, SYSC_PAD_RGMII2_MDIO);
+
+	/* gpio mux - RGMII1=Normal mode */
+	rt_sysc_m32(BIT(14), 0, SYSC_GPIO_MODE);
+
+	/* set GMAC1 RGMII mode */
+	rt_sysc_m32(3 << 12, 0, SYSC_REG_CFG1);
+
+	/* enable MDIO to control MT7530 */
+	rt_sysc_m32(3 << 12, 0, SYSC_GPIO_MODE);
+
+	/* turn off all PHYs */
+	for (i = 0; i <= 4; i++) {
+		val = _mt7620_mii_read(gsw, i, 0x0);
+		val |= BIT(11);
+		_mt7620_mii_write(gsw, i, 0x0, val);
+	}
+
+	/* reset the switch */
+	mt7530_mdio_w32(gsw, 0x7000, 0x3);
+	usleep_range(10, 20);
+
+	if ((rt_sysc_r32(SYSC_REG_CHIP_REV_ID) & 0xFFFF) == 0x0101) {
+		/* (GE1, Force 1000M/FD, FC ON, MAX_RX_LENGTH 1536) */
+		mtk_switch_w32(gsw, 0x2105e30b, 0x100);
+		mt7530_mdio_w32(gsw, 0x3600, 0x5e30b);
+	} else {
+		/* (GE1, Force 1000M/FD, FC ON, MAX_RX_LENGTH 1536) */
+		mtk_switch_w32(gsw, 0x2105e33b, 0x100);
+		mt7530_mdio_w32(gsw, 0x3600, 0x5e33b);
+	}
+
+	/* (GE2, Link down) */
+	mtk_switch_w32(gsw, 0x8000, 0x200);
+
+	/* Enable Port 6, P5 as GMAC5, P5 disable */
+	val = mt7530_mdio_r32(gsw, 0x7804);
+	val &= ~BIT(8);
+	val |= BIT(6) | BIT(13) | BIT(16);
+	mt7530_mdio_w32(gsw, 0x7804, val);
+
+	val = rt_sysc_r32(0x10);
+	val = (val >> 6) & 0x7;
+	if (val >= 6) {
+		/* 25Mhz Xtal - do nothing */
+	} else if (val >= 3) {
+		/* 40Mhz */
+
+		/* disable MT7530 core clock */
+		_mt7620_mii_write(gsw, 0, 13, 0x1f);
+		_mt7620_mii_write(gsw, 0, 14, 0x410);
+		_mt7620_mii_write(gsw, 0, 13, 0x401f);
+		_mt7620_mii_write(gsw, 0, 14, 0x0);
+
+		/* disable MT7530 PLL */
+		_mt7620_mii_write(gsw, 0, 13, 0x1f);
+		_mt7620_mii_write(gsw, 0, 14, 0x40d);
+		_mt7620_mii_write(gsw, 0, 13, 0x401f);
+		_mt7620_mii_write(gsw, 0, 14, 0x2020);
+
+		/* for MT7530 core clock = 500Mhz */
+		_mt7620_mii_write(gsw, 0, 13, 0x1f);
+		_mt7620_mii_write(gsw, 0, 14, 0x40e);
+		_mt7620_mii_write(gsw, 0, 13, 0x401f);
+		_mt7620_mii_write(gsw, 0, 14, 0x119);
+
+		/* enable MT7530 PLL */
+		_mt7620_mii_write(gsw, 0, 13, 0x1f);
+		_mt7620_mii_write(gsw, 0, 14, 0x40d);
+		_mt7620_mii_write(gsw, 0, 13, 0x401f);
+		_mt7620_mii_write(gsw, 0, 14, 0x2820);
+
+		usleep_range(20, 40);
+
+		/* enable MT7530 core clock */
+		_mt7620_mii_write(gsw, 0, 13, 0x1f);
+		_mt7620_mii_write(gsw, 0, 14, 0x410);
+		_mt7620_mii_write(gsw, 0, 13, 0x401f);
+	} else {
+		/* 20Mhz Xtal - TODO */
+	}
+
+	/* RGMII */
+	_mt7620_mii_write(gsw, 0, 14, 0x1);
+
+	/* set MT7530 central align */
+	val = mt7530_mdio_r32(gsw, 0x7830);
+	val &= ~BIT(0);
+	val |= BIT(1);
+	mt7530_mdio_w32(gsw, 0x7830, val);
+	val = mt7530_mdio_r32(gsw, 0x7a40);
+	val &= ~BIT(30);
+	mt7530_mdio_w32(gsw, 0x7a40, val);
+	mt7530_mdio_w32(gsw, 0x7a78, 0x855);
+
+	/* delay setting for 10/1000M */
+	mt7530_mdio_w32(gsw, 0x7b00, 0x102);
+	mt7530_mdio_w32(gsw, 0x7b04, 0x14);
+
+	/* lower Tx Driving*/
+	mt7530_mdio_w32(gsw, 0x7a54, 0x44);
+	mt7530_mdio_w32(gsw, 0x7a5c, 0x44);
+	mt7530_mdio_w32(gsw, 0x7a64, 0x44);
+	mt7530_mdio_w32(gsw, 0x7a6c, 0x44);
+	mt7530_mdio_w32(gsw, 0x7a74, 0x44);
+	mt7530_mdio_w32(gsw, 0x7a7c, 0x44);
+
+	/* turn on all PHYs */
+	for (i = 0; i <= 4; i++) {
+		val = _mt7620_mii_read(gsw, i, 0);
+		val &= ~BIT(11);
+		_mt7620_mii_write(gsw, i, 0, val);
+	}
+
+	/* enable irq */
+	val = mt7530_mdio_r32(gsw, 0x7808);
+	val |= 3 << 16;
+	mt7530_mdio_w32(gsw, 0x7808, val);
+}
+
+static const struct of_device_id mediatek_gsw_match[] = {
+	{ .compatible = "mediatek,mt7621-gsw" },
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
+	mt7621_hw_init(gsw, np);
+
+	if (gsw->irq) {
+		request_irq(gsw->irq, gsw_interrupt_mt7621, 0,
+			    "gsw", priv);
+		mt7530_mdio_w32(gsw, 0x7008, 0x1f);
+	}
+
+	return 0;
+}
+
+static int mt7621_gsw_probe(struct platform_device *pdev)
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
+static int mt7621_gsw_remove(struct platform_device *pdev)
+{
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver gsw_driver = {
+	.probe = mt7621_gsw_probe,
+	.remove = mt7621_gsw_remove,
+	.driver = {
+		.name = "mt7621-gsw",
+		.owner = THIS_MODULE,
+		.of_match_table = mediatek_gsw_match,
+	},
+};
+
+module_platform_driver(gsw_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
+MODULE_DESCRIPTION("GBit switch driver for Mediatek MT7621 SoC");
-- 
1.7.10.4
