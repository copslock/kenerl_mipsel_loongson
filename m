Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2018 14:45:48 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:38326 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993094AbeG3Mof3xrxl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Jul 2018 14:44:35 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 39984208FF; Mon, 30 Jul 2018 14:44:25 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id C6A6B207AC;
        Mon, 30 Jul 2018 14:44:24 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net
Cc:     kishon@ti.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        allan.nielsen@microsemi.com, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next 05/10] net: mscc: ocelot: simplify register access for PLL5 configuration
Date:   Mon, 30 Jul 2018 14:43:50 +0200
Message-Id: <df5856230f6a2932a8e0289dc6e8d12234a02bfe.1532954208.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quentin.schulz@bootlin.com
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

Since HSIO address space can be accessed by different drivers, let's
simplify the register address definitions so that it can be easily used
by all drivers and put the register address definition in the
include/soc/mscc/ocelot_hsio.h header file.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot.h      | 73 +---------------------
 drivers/net/ethernet/mscc/ocelot_regs.c | 92 ++------------------------
 include/soc/mscc/ocelot_hsio.h          | 74 +++++++++++++++++++++-
 3 files changed, 83 insertions(+), 156 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index 2da20a3..3720e51 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -332,79 +332,6 @@ enum ocelot_reg {
 	SYS_CM_DATA_RD,
 	SYS_CM_OP,
 	SYS_CM_DATA,
-	HSIO_PLL5G_CFG0 = HSIO << TARGET_OFFSET,
-	HSIO_PLL5G_CFG1,
-	HSIO_PLL5G_CFG2,
-	HSIO_PLL5G_CFG3,
-	HSIO_PLL5G_CFG4,
-	HSIO_PLL5G_CFG5,
-	HSIO_PLL5G_CFG6,
-	HSIO_PLL5G_STATUS0,
-	HSIO_PLL5G_STATUS1,
-	HSIO_PLL5G_BIST_CFG0,
-	HSIO_PLL5G_BIST_CFG1,
-	HSIO_PLL5G_BIST_CFG2,
-	HSIO_PLL5G_BIST_STAT0,
-	HSIO_PLL5G_BIST_STAT1,
-	HSIO_RCOMP_CFG0,
-	HSIO_RCOMP_STATUS,
-	HSIO_SYNC_ETH_CFG,
-	HSIO_SYNC_ETH_PLL_CFG,
-	HSIO_S1G_DES_CFG,
-	HSIO_S1G_IB_CFG,
-	HSIO_S1G_OB_CFG,
-	HSIO_S1G_SER_CFG,
-	HSIO_S1G_COMMON_CFG,
-	HSIO_S1G_PLL_CFG,
-	HSIO_S1G_PLL_STATUS,
-	HSIO_S1G_DFT_CFG0,
-	HSIO_S1G_DFT_CFG1,
-	HSIO_S1G_DFT_CFG2,
-	HSIO_S1G_TP_CFG,
-	HSIO_S1G_RC_PLL_BIST_CFG,
-	HSIO_S1G_MISC_CFG,
-	HSIO_S1G_DFT_STATUS,
-	HSIO_S1G_MISC_STATUS,
-	HSIO_MCB_S1G_ADDR_CFG,
-	HSIO_S6G_DIG_CFG,
-	HSIO_S6G_DFT_CFG0,
-	HSIO_S6G_DFT_CFG1,
-	HSIO_S6G_DFT_CFG2,
-	HSIO_S6G_TP_CFG0,
-	HSIO_S6G_TP_CFG1,
-	HSIO_S6G_RC_PLL_BIST_CFG,
-	HSIO_S6G_MISC_CFG,
-	HSIO_S6G_OB_ANEG_CFG,
-	HSIO_S6G_DFT_STATUS,
-	HSIO_S6G_ERR_CNT,
-	HSIO_S6G_MISC_STATUS,
-	HSIO_S6G_DES_CFG,
-	HSIO_S6G_IB_CFG,
-	HSIO_S6G_IB_CFG1,
-	HSIO_S6G_IB_CFG2,
-	HSIO_S6G_IB_CFG3,
-	HSIO_S6G_IB_CFG4,
-	HSIO_S6G_IB_CFG5,
-	HSIO_S6G_OB_CFG,
-	HSIO_S6G_OB_CFG1,
-	HSIO_S6G_SER_CFG,
-	HSIO_S6G_COMMON_CFG,
-	HSIO_S6G_PLL_CFG,
-	HSIO_S6G_ACJTAG_CFG,
-	HSIO_S6G_GP_CFG,
-	HSIO_S6G_IB_STATUS0,
-	HSIO_S6G_IB_STATUS1,
-	HSIO_S6G_ACJTAG_STATUS,
-	HSIO_S6G_PLL_STATUS,
-	HSIO_S6G_REVID,
-	HSIO_MCB_S6G_ADDR_CFG,
-	HSIO_HW_CFG,
-	HSIO_HW_QSGMII_CFG,
-	HSIO_HW_QSGMII_STAT,
-	HSIO_CLK_CFG,
-	HSIO_TEMP_SENSOR_CTRL,
-	HSIO_TEMP_SENSOR_CFG,
-	HSIO_TEMP_SENSOR_STAT,
 };
 
 enum ocelot_regfield {
diff --git a/drivers/net/ethernet/mscc/ocelot_regs.c b/drivers/net/ethernet/mscc/ocelot_regs.c
index bf0c609..9271af1 100644
--- a/drivers/net/ethernet/mscc/ocelot_regs.c
+++ b/drivers/net/ethernet/mscc/ocelot_regs.c
@@ -103,82 +103,6 @@ static const u32 ocelot_qs_regmap[] = {
 	REG(QS_INH_DBG,                    0x000048),
 };
 
-static const u32 ocelot_hsio_regmap[] = {
-	REG(HSIO_PLL5G_CFG0,               0x000000),
-	REG(HSIO_PLL5G_CFG1,               0x000004),
-	REG(HSIO_PLL5G_CFG2,               0x000008),
-	REG(HSIO_PLL5G_CFG3,               0x00000c),
-	REG(HSIO_PLL5G_CFG4,               0x000010),
-	REG(HSIO_PLL5G_CFG5,               0x000014),
-	REG(HSIO_PLL5G_CFG6,               0x000018),
-	REG(HSIO_PLL5G_STATUS0,            0x00001c),
-	REG(HSIO_PLL5G_STATUS1,            0x000020),
-	REG(HSIO_PLL5G_BIST_CFG0,          0x000024),
-	REG(HSIO_PLL5G_BIST_CFG1,          0x000028),
-	REG(HSIO_PLL5G_BIST_CFG2,          0x00002c),
-	REG(HSIO_PLL5G_BIST_STAT0,         0x000030),
-	REG(HSIO_PLL5G_BIST_STAT1,         0x000034),
-	REG(HSIO_RCOMP_CFG0,               0x000038),
-	REG(HSIO_RCOMP_STATUS,             0x00003c),
-	REG(HSIO_SYNC_ETH_CFG,             0x000040),
-	REG(HSIO_SYNC_ETH_PLL_CFG,         0x000048),
-	REG(HSIO_S1G_DES_CFG,              0x00004c),
-	REG(HSIO_S1G_IB_CFG,               0x000050),
-	REG(HSIO_S1G_OB_CFG,               0x000054),
-	REG(HSIO_S1G_SER_CFG,              0x000058),
-	REG(HSIO_S1G_COMMON_CFG,           0x00005c),
-	REG(HSIO_S1G_PLL_CFG,              0x000060),
-	REG(HSIO_S1G_PLL_STATUS,           0x000064),
-	REG(HSIO_S1G_DFT_CFG0,             0x000068),
-	REG(HSIO_S1G_DFT_CFG1,             0x00006c),
-	REG(HSIO_S1G_DFT_CFG2,             0x000070),
-	REG(HSIO_S1G_TP_CFG,               0x000074),
-	REG(HSIO_S1G_RC_PLL_BIST_CFG,      0x000078),
-	REG(HSIO_S1G_MISC_CFG,             0x00007c),
-	REG(HSIO_S1G_DFT_STATUS,           0x000080),
-	REG(HSIO_S1G_MISC_STATUS,          0x000084),
-	REG(HSIO_MCB_S1G_ADDR_CFG,         0x000088),
-	REG(HSIO_S6G_DIG_CFG,              0x00008c),
-	REG(HSIO_S6G_DFT_CFG0,             0x000090),
-	REG(HSIO_S6G_DFT_CFG1,             0x000094),
-	REG(HSIO_S6G_DFT_CFG2,             0x000098),
-	REG(HSIO_S6G_TP_CFG0,              0x00009c),
-	REG(HSIO_S6G_TP_CFG1,              0x0000a0),
-	REG(HSIO_S6G_RC_PLL_BIST_CFG,      0x0000a4),
-	REG(HSIO_S6G_MISC_CFG,             0x0000a8),
-	REG(HSIO_S6G_OB_ANEG_CFG,          0x0000ac),
-	REG(HSIO_S6G_DFT_STATUS,           0x0000b0),
-	REG(HSIO_S6G_ERR_CNT,              0x0000b4),
-	REG(HSIO_S6G_MISC_STATUS,          0x0000b8),
-	REG(HSIO_S6G_DES_CFG,              0x0000bc),
-	REG(HSIO_S6G_IB_CFG,               0x0000c0),
-	REG(HSIO_S6G_IB_CFG1,              0x0000c4),
-	REG(HSIO_S6G_IB_CFG2,              0x0000c8),
-	REG(HSIO_S6G_IB_CFG3,              0x0000cc),
-	REG(HSIO_S6G_IB_CFG4,              0x0000d0),
-	REG(HSIO_S6G_IB_CFG5,              0x0000d4),
-	REG(HSIO_S6G_OB_CFG,               0x0000d8),
-	REG(HSIO_S6G_OB_CFG1,              0x0000dc),
-	REG(HSIO_S6G_SER_CFG,              0x0000e0),
-	REG(HSIO_S6G_COMMON_CFG,           0x0000e4),
-	REG(HSIO_S6G_PLL_CFG,              0x0000e8),
-	REG(HSIO_S6G_ACJTAG_CFG,           0x0000ec),
-	REG(HSIO_S6G_GP_CFG,               0x0000f0),
-	REG(HSIO_S6G_IB_STATUS0,           0x0000f4),
-	REG(HSIO_S6G_IB_STATUS1,           0x0000f8),
-	REG(HSIO_S6G_ACJTAG_STATUS,        0x0000fc),
-	REG(HSIO_S6G_PLL_STATUS,           0x000100),
-	REG(HSIO_S6G_REVID,                0x000104),
-	REG(HSIO_MCB_S6G_ADDR_CFG,         0x000108),
-	REG(HSIO_HW_CFG,                   0x00010c),
-	REG(HSIO_HW_QSGMII_CFG,            0x000110),
-	REG(HSIO_HW_QSGMII_STAT,           0x000114),
-	REG(HSIO_CLK_CFG,                  0x000118),
-	REG(HSIO_TEMP_SENSOR_CTRL,         0x00011c),
-	REG(HSIO_TEMP_SENSOR_CFG,          0x000120),
-	REG(HSIO_TEMP_SENSOR_STAT,         0x000124),
-};
-
 static const u32 ocelot_qsys_regmap[] = {
 	REG(QSYS_PORT_MODE,                0x011200),
 	REG(QSYS_SWITCH_PORT_MODE,         0x011234),
@@ -303,7 +227,6 @@ static const u32 ocelot_sys_regmap[] = {
 static const u32 *ocelot_regmap[] = {
 	[ANA] = ocelot_ana_regmap,
 	[QS] = ocelot_qs_regmap,
-	[HSIO] = ocelot_hsio_regmap,
 	[QSYS] = ocelot_qsys_regmap,
 	[REW] = ocelot_rew_regmap,
 	[SYS] = ocelot_sys_regmap,
@@ -454,9 +377,11 @@ static void ocelot_pll5_init(struct ocelot *ocelot)
 	/* Configure PLL5. This will need a proper CCF driver
 	 * The values are coming from the VTSS API for Ocelot
 	 */
-	ocelot_write(ocelot, HSIO_PLL5G_CFG4_IB_CTRL(0x7600) |
-		     HSIO_PLL5G_CFG4_IB_BIAS_CTRL(0x8), HSIO_PLL5G_CFG4);
-	ocelot_write(ocelot, HSIO_PLL5G_CFG0_CORE_CLK_DIV(0x11) |
+	regmap_write(ocelot->targets[HSIO], HSIO_PLL5G_CFG4,
+		     HSIO_PLL5G_CFG4_IB_CTRL(0x7600) |
+		     HSIO_PLL5G_CFG4_IB_BIAS_CTRL(0x8));
+	regmap_write(ocelot->targets[HSIO], HSIO_PLL5G_CFG0,
+		     HSIO_PLL5G_CFG0_CORE_CLK_DIV(0x11) |
 		     HSIO_PLL5G_CFG0_CPU_CLK_DIV(2) |
 		     HSIO_PLL5G_CFG0_ENA_BIAS |
 		     HSIO_PLL5G_CFG0_ENA_VCO_BUF |
@@ -466,13 +391,14 @@ static void ocelot_pll5_init(struct ocelot *ocelot)
 		     HSIO_PLL5G_CFG0_SELBGV820(4) |
 		     HSIO_PLL5G_CFG0_DIV4 |
 		     HSIO_PLL5G_CFG0_ENA_CLKTREE |
-		     HSIO_PLL5G_CFG0_ENA_LANE, HSIO_PLL5G_CFG0);
-	ocelot_write(ocelot, HSIO_PLL5G_CFG2_EN_RESET_FRQ_DET |
+		     HSIO_PLL5G_CFG0_ENA_LANE);
+	regmap_write(ocelot->targets[HSIO], HSIO_PLL5G_CFG2,
+		     HSIO_PLL5G_CFG2_EN_RESET_FRQ_DET |
 		     HSIO_PLL5G_CFG2_EN_RESET_OVERRUN |
 		     HSIO_PLL5G_CFG2_GAIN_TEST(0x8) |
 		     HSIO_PLL5G_CFG2_ENA_AMPCTRL |
 		     HSIO_PLL5G_CFG2_PWD_AMPCTRL_N |
-		     HSIO_PLL5G_CFG2_AMPC_SEL(0x10), HSIO_PLL5G_CFG2);
+		     HSIO_PLL5G_CFG2_AMPC_SEL(0x10));
 }
 
 int ocelot_chip_init(struct ocelot *ocelot)
diff --git a/include/soc/mscc/ocelot_hsio.h b/include/soc/mscc/ocelot_hsio.h
index d93ddec..43112dd 100644
--- a/include/soc/mscc/ocelot_hsio.h
+++ b/include/soc/mscc/ocelot_hsio.h
@@ -8,6 +8,80 @@
 #ifndef _MSCC_OCELOT_HSIO_H_
 #define _MSCC_OCELOT_HSIO_H_
 
+#define HSIO_PLL5G_CFG0			0x0000
+#define HSIO_PLL5G_CFG1			0x0004
+#define HSIO_PLL5G_CFG2			0x0008
+#define HSIO_PLL5G_CFG3			0x000c
+#define HSIO_PLL5G_CFG4			0x0010
+#define HSIO_PLL5G_CFG5			0x0014
+#define HSIO_PLL5G_CFG6			0x0018
+#define HSIO_PLL5G_STATUS0		0x001c
+#define HSIO_PLL5G_STATUS1		0x0020
+#define HSIO_PLL5G_BIST_CFG0		0x0024
+#define HSIO_PLL5G_BIST_CFG1		0x0028
+#define HSIO_PLL5G_BIST_CFG2		0x002c
+#define HSIO_PLL5G_BIST_STAT0		0x0030
+#define HSIO_PLL5G_BIST_STAT1		0x0034
+#define HSIO_RCOMP_CFG0			0x0038
+#define HSIO_RCOMP_STATUS		0x003c
+#define HSIO_SYNC_ETH_CFG		0x0040
+#define HSIO_SYNC_ETH_PLL_CFG		0x0048
+#define HSIO_S1G_DES_CFG		0x004c
+#define HSIO_S1G_IB_CFG			0x0050
+#define HSIO_S1G_OB_CFG			0x0054
+#define HSIO_S1G_SER_CFG		0x0058
+#define HSIO_S1G_COMMON_CFG		0x005c
+#define HSIO_S1G_PLL_CFG		0x0060
+#define HSIO_S1G_PLL_STATUS		0x0064
+#define HSIO_S1G_DFT_CFG0		0x0068
+#define HSIO_S1G_DFT_CFG1		0x006c
+#define HSIO_S1G_DFT_CFG2		0x0070
+#define HSIO_S1G_TP_CFG			0x0074
+#define HSIO_S1G_RC_PLL_BIST_CFG	0x0078
+#define HSIO_S1G_MISC_CFG		0x007c
+#define HSIO_S1G_DFT_STATUS		0x0080
+#define HSIO_S1G_MISC_STATUS		0x0084
+#define HSIO_MCB_S1G_ADDR_CFG		0x0088
+#define HSIO_S6G_DIG_CFG		0x008c
+#define HSIO_S6G_DFT_CFG0		0x0090
+#define HSIO_S6G_DFT_CFG1		0x0094
+#define HSIO_S6G_DFT_CFG2		0x0098
+#define HSIO_S6G_TP_CFG0		0x009c
+#define HSIO_S6G_TP_CFG1		0x00a0
+#define HSIO_S6G_RC_PLL_BIST_CFG	0x00a4
+#define HSIO_S6G_MISC_CFG		0x00a8
+#define HSIO_S6G_OB_ANEG_CFG		0x00ac
+#define HSIO_S6G_DFT_STATUS		0x00b0
+#define HSIO_S6G_ERR_CNT		0x00b4
+#define HSIO_S6G_MISC_STATUS		0x00b8
+#define HSIO_S6G_DES_CFG		0x00bc
+#define HSIO_S6G_IB_CFG			0x00c0
+#define HSIO_S6G_IB_CFG1		0x00c4
+#define HSIO_S6G_IB_CFG2		0x00c8
+#define HSIO_S6G_IB_CFG3		0x00cc
+#define HSIO_S6G_IB_CFG4		0x00d0
+#define HSIO_S6G_IB_CFG5		0x00d4
+#define HSIO_S6G_OB_CFG			0x00d8
+#define HSIO_S6G_OB_CFG1		0x00dc
+#define HSIO_S6G_SER_CFG		0x00e0
+#define HSIO_S6G_COMMON_CFG		0x00e4
+#define HSIO_S6G_PLL_CFG		0x00e8
+#define HSIO_S6G_ACJTAG_CFG		0x00ec
+#define HSIO_S6G_GP_CFG			0x00f0
+#define HSIO_S6G_IB_STATUS0		0x00f4
+#define HSIO_S6G_IB_STATUS1		0x00f8
+#define HSIO_S6G_ACJTAG_STATUS		0x00fc
+#define HSIO_S6G_PLL_STATUS		0x0100
+#define HSIO_S6G_REVID			0x0104
+#define HSIO_MCB_S6G_ADDR_CFG		0x0108
+#define HSIO_HW_CFG			0x010c
+#define HSIO_HW_QSGMII_CFG		0x0110
+#define HSIO_HW_QSGMII_STAT		0x0114
+#define HSIO_CLK_CFG			0x0118
+#define HSIO_TEMP_SENSOR_CTRL		0x011c
+#define HSIO_TEMP_SENSOR_CFG		0x0120
+#define HSIO_TEMP_SENSOR_STAT		0x0124
+
 #define HSIO_PLL5G_CFG0_ENA_ROT                           BIT(31)
 #define HSIO_PLL5G_CFG0_ENA_LANE                          BIT(30)
 #define HSIO_PLL5G_CFG0_ENA_CLKTREE                       BIT(29)
-- 
git-series 0.9.1
