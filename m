Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:40:28 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37630 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011832AbbJ1Wh6UUMgO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:37:58 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id CEDE6100033;
        Wed, 28 Oct 2015 23:37:57 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH 09/15] MIPS: lantiq: add support for gphy firmware loading for ar10 and grx390
Date:   Wed, 28 Oct 2015 23:37:38 +0100
Message-Id: <1446071865-21936-10-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49751
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

From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

Signed-off-by: Hauke Mehrtens <hauke.mehrtens@lantiq.com>
---
 arch/mips/lantiq/xway/reset.c | 111 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 91 insertions(+), 20 deletions(-)

diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index fe68f9a..1e23cee 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -22,9 +22,6 @@
 
 #include "../prom.h"
 
-#define ltq_rcu_w32(x, y)	ltq_w32((x), ltq_rcu_membase + (y))
-#define ltq_rcu_r32(x)		ltq_r32(ltq_rcu_membase + (x))
-
 /* reset request register */
 #define RCU_RST_REQ		0x0010
 /* reset status register */
@@ -32,11 +29,29 @@
 /* vr9 gphy registers */
 #define RCU_GFS_ADD0_XRX200	0x0020
 #define RCU_GFS_ADD1_XRX200	0x0068
+/* xRX300 gphy registers */
+#define RCU_GFS_ADD0_XRX300	0x0020
+#define RCU_GFS_ADD1_XRX300	0x0058
+#define RCU_GFS_ADD2_XRX300	0x00AC
+/* xRX330 gphy registers */
+#define RCU_GFS_ADD0_XRX330	0x0020
+#define RCU_GFS_ADD1_XRX330	0x0058
+#define RCU_GFS_ADD2_XRX330	0x00AC
+#define RCU_GFS_ADD3_XRX330	0x0264
 
 /* reboot bit */
 #define RCU_RD_GPHY0_XRX200	BIT(31)
 #define RCU_RD_SRST		BIT(30)
 #define RCU_RD_GPHY1_XRX200	BIT(29)
+/* xRX300 bits */
+#define RCU_RD_GPHY0_XRX300	BIT(31)
+#define RCU_RD_GPHY1_XRX300	BIT(29)
+#define RCU_RD_GPHY2_XRX300	BIT(28)
+/* xRX330 bits */
+#define RCU_RD_GPHY0_XRX330	BIT(31)
+#define RCU_RD_GPHY1_XRX330	BIT(29)
+#define RCU_RD_GPHY2_XRX330	BIT(28)
+#define RCU_RD_GPHY3_XRX330	BIT(10)
 
 /* reset cause */
 #define RCU_STAT_SHIFT		26
@@ -47,6 +62,26 @@
 /* remapped base addr of the reset control unit */
 static void __iomem *ltq_rcu_membase;
 static struct device_node *ltq_rcu_np;
+static DEFINE_SPINLOCK(ltq_rcu_lock);
+
+static void ltq_rcu_w32(uint32_t val, uint32_t reg_off)
+{
+	ltq_w32(val, ltq_rcu_membase + reg_off);
+}
+
+static uint32_t ltq_rcu_r32(uint32_t reg_off)
+{
+	return ltq_r32(ltq_rcu_membase + reg_off);
+}
+
+static void ltq_rcu_w32_mask(uint32_t clr, uint32_t set, uint32_t reg_off)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ltq_rcu_lock, flags);
+	ltq_rcu_w32((ltq_rcu_r32(reg_off) & ~(clr)) | (set), reg_off);
+	spin_unlock_irqrestore(&ltq_rcu_lock, flags);
+}
 
 /* This function is used by the watchdog driver */
 int ltq_reset_cause(void)
@@ -67,15 +102,40 @@ unsigned char ltq_boot_select(void)
 	return RCU_BOOT_SEL(val);
 }
 
-/* reset / boot a gphy */
-static struct ltq_xrx200_gphy_reset {
+struct ltq_gphy_reset {
 	u32 rd;
 	u32 addr;
-} xrx200_gphy[] = {
+};
+
+/* reset / boot a gphy */
+static struct ltq_gphy_reset xrx200_gphy[] = {
 	{RCU_RD_GPHY0_XRX200, RCU_GFS_ADD0_XRX200},
 	{RCU_RD_GPHY1_XRX200, RCU_GFS_ADD1_XRX200},
 };
 
+/* reset / boot a gphy */
+static struct ltq_gphy_reset xrx300_gphy[] = {
+	{RCU_RD_GPHY0_XRX300, RCU_GFS_ADD0_XRX300},
+	{RCU_RD_GPHY1_XRX300, RCU_GFS_ADD1_XRX300},
+	{RCU_RD_GPHY2_XRX300, RCU_GFS_ADD2_XRX300},
+};
+
+/* reset / boot a gphy */
+static struct ltq_gphy_reset xrx330_gphy[] = {
+	{RCU_RD_GPHY0_XRX330, RCU_GFS_ADD0_XRX330},
+	{RCU_RD_GPHY1_XRX330, RCU_GFS_ADD1_XRX330},
+	{RCU_RD_GPHY2_XRX330, RCU_GFS_ADD2_XRX330},
+	{RCU_RD_GPHY3_XRX330, RCU_GFS_ADD3_XRX330},
+};
+
+static void xrx200_gphy_boot_addr(struct ltq_gphy_reset *phy_regs,
+				  dma_addr_t dev_addr)
+{
+	ltq_rcu_w32_mask(0, phy_regs->rd, RCU_RST_REQ);
+	ltq_rcu_w32(dev_addr, phy_regs->addr);
+	ltq_rcu_w32_mask(phy_regs->rd, 0,  RCU_RST_REQ);
+}
+
 /* reset and boot a gphy. these phys only exist on xrx200 SoC */
 int xrx200_gphy_boot(struct device *dev, unsigned int id, dma_addr_t dev_addr)
 {
@@ -86,23 +146,34 @@ int xrx200_gphy_boot(struct device *dev, unsigned int id, dma_addr_t dev_addr)
 		return -EINVAL;
 	}
 
-	clk = clk_get_sys("1f203000.rcu", "gphy");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	clk_enable(clk);
-
-	if (id > 1) {
-		dev_err(dev, "%u is an invalid gphy id\n", id);
-		return -EINVAL;
+	if (of_machine_is_compatible("lantiq,vr9")) {
+		clk = clk_get_sys("1f203000.rcu", "gphy");
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+		clk_enable(clk);
 	}
+
 	dev_info(dev, "booting GPHY%u firmware at %X\n", id, dev_addr);
 
-	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) | xrx200_gphy[id].rd,
-			RCU_RST_REQ);
-	ltq_rcu_w32(dev_addr, xrx200_gphy[id].addr);
-	ltq_rcu_w32(ltq_rcu_r32(RCU_RST_REQ) & ~xrx200_gphy[id].rd,
-			RCU_RST_REQ);
+	if (of_machine_is_compatible("lantiq,vr9")) {
+		if (id >= ARRAY_SIZE(xrx200_gphy)) {
+			dev_err(dev, "%u is an invalid gphy id\n", id);
+			return -EINVAL;
+		}
+		xrx200_gphy_boot_addr(&xrx200_gphy[id], dev_addr);
+	} else if (of_machine_is_compatible("lantiq,ar10")) {
+		if (id >= ARRAY_SIZE(xrx300_gphy)) {
+			dev_err(dev, "%u is an invalid gphy id\n", id);
+			return -EINVAL;
+		}
+		xrx200_gphy_boot_addr(&xrx300_gphy[id], dev_addr);
+	} else if (of_machine_is_compatible("lantiq,grx390")) {
+		if (id >= ARRAY_SIZE(xrx330_gphy)) {
+			dev_err(dev, "%u is an invalid gphy id\n", id);
+			return -EINVAL;
+		}
+		xrx200_gphy_boot_addr(&xrx330_gphy[id], dev_addr);
+	}
 	return 0;
 }
 
-- 
2.6.1
