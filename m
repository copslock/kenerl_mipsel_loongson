Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 11:45:26 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:33172 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992066AbeINJpDLZbjI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 11:45:03 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 32938208AC; Fri, 14 Sep 2018 11:44:57 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id B5C7020618;
        Fri, 14 Sep 2018 11:44:56 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, andrew@lunn.ch,
        f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next 2/7] net: phy: mscc: add support for VSC8584 PHY
Date:   Fri, 14 Sep 2018 11:44:23 +0200
Message-Id: <a61d9affd3f1ec9deb60c882cce1daf37fbe2427.1536916714.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
Return-Path: <quentin.schulz@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66243
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

The VSC8584 PHY is a 4-ports PHY that is 10/100/1000BASE-T, 100BASE-FX,
1000BASE-X and triple-speed copper SFP capable, can communicate with the
MAC via SGMII, QSGMII or 1000BASE-X, supports downshifting and can set
the blinking pattern of each of its 4 LEDs, supports hardware offloading
of MACsec and supports SyncE as well as HP Auto-MDIX detection.

This adds support for 10/100/1000BASE-T, SGMII/QSGMII link with the MAC,
downshifting, HP Auto-MDIX detection and blinking pattern for its 4
LEDs.

The VSC8584 has also an internal Intel 8051 microcontroller whose
firmware needs to be patched when the PHY is reset. If the 8051's
firmware has the expected CRC, its patching can be skipped. The
microcontroller can be accessed from any port of the PHY, though the CRC
function can only be done through the PHY that is the base PHY of the
package (internal address 0) due to a limitation of the firmware.

The GPIO register bank is a set of registers that are common to all PHYs
in the package. So any modification in any register of this bank affects
all PHYs of the package.

If the PHYs haven't been reset before booting the Linux kernel and were
configured to use interrupts for e.g. link status updates, it is
required to clear the interrupts mask register of all PHYs before being
able to use interrupts with any PHY. The first PHY of the package that
will be init will take care of clearing all PHYs interrupts mask
registers. Thus, we need to keep track of the init sequence in the
package, if it's already been done or if it's to be done.

Most of the init sequence of a PHY of the package is common to all PHYs
in the package, thus we use the SMI broadcast feature which enables us
to propagate a write in one register of one PHY to all PHYs in the
package.

The revA of the VSC8584 PHY (which is not and will not be publicly
released) should NOT patch the firmware of the microcontroller or it'll
make things worse, the easiest way is just to not support it.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/phy/mscc.c | 714 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 714 insertions(+)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index 24f4754..b450489 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -6,6 +6,8 @@
  * Copyright (c) 2016 Microsemi Corporation
  */
 
+#include <linux/firmware.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mdio.h>
@@ -32,6 +34,10 @@ enum rgmii_rx_clock_delay {
 #define DISABLE_HP_AUTO_MDIX_MASK	  0x0080
 #define DISABLE_PAIR_SWAP_CORR_MASK	  0x0020
 #define DISABLE_POLARITY_CORR_MASK	  0x0010
+#define PARALLEL_DET_IGNORE_ADVERTISED    0x0008
+
+#define MSCC_PHY_EXT_CNTL_STATUS          22
+#define SMI_BROADCAST_WR_EN		  0x0001
 
 #define MSCC_PHY_ERR_RX_CNT		  19
 #define MSCC_PHY_ERR_FALSE_CARRIER_CNT	  20
@@ -44,7 +50,20 @@ enum rgmii_rx_clock_delay {
 #define MAC_IF_SELECTION_RMII             1
 #define MAC_IF_SELECTION_RGMII            2
 #define MAC_IF_SELECTION_POS              11
+#define VSC8584_MAC_IF_SELECTION_MASK     0x1000
+#define VSC8584_MAC_IF_SELECTION_SGMII    0
+#define VSC8584_MAC_IF_SELECTION_1000BASEX 1
+#define VSC8584_MAC_IF_SELECTION_POS      12
 #define FAR_END_LOOPBACK_MODE_MASK        0x0008
+#define MEDIA_OP_MODE_MASK		  0x0700
+#define MEDIA_OP_MODE_COPPER		  0
+#define MEDIA_OP_MODE_SERDES		  1
+#define MEDIA_OP_MODE_1000BASEX		  2
+#define MEDIA_OP_MODE_100BASEFX		  3
+#define MEDIA_OP_MODE_AMS_COPPER_SERDES	  5
+#define MEDIA_OP_MODE_AMS_COPPER_1000BASEX	6
+#define MEDIA_OP_MODE_AMS_COPPER_100BASEFX	7
+#define MEDIA_OP_MODE_POS		  8
 
 #define MII_VSC85XX_INT_MASK		  25
 #define MII_VSC85XX_INT_MASK_MASK	  0xa000
@@ -67,6 +86,13 @@ enum rgmii_rx_clock_delay {
 #define MSCC_PHY_PAGE_STANDARD		  0x0000 /* Standard registers */
 #define MSCC_PHY_PAGE_EXTENDED		  0x0001 /* Extended registers */
 #define MSCC_PHY_PAGE_EXTENDED_2	  0x0002 /* Extended reg - page 2 */
+#define MSCC_PHY_PAGE_EXTENDED_3	  0x0003 /* Extended reg - page 3 */
+#define MSCC_PHY_PAGE_EXTENDED_4	  0x0004 /* Extended reg - page 4 */
+/* Extended reg - GPIO; this is a bank of registers that are shared for all PHYs
+ * in the same package.
+ */
+#define MSCC_PHY_PAGE_EXTENDED_GPIO	  0x0010 /* Extended reg - GPIO */
+#define MSCC_PHY_PAGE_TEST		  0x2a30 /* Test reg */
 #define MSCC_PHY_PAGE_TR		  0x52b5 /* Token ring registers */
 
 /* Extended Page 1 Registers */
@@ -79,13 +105,21 @@ enum rgmii_rx_clock_delay {
 #define FORCE_MDI_CROSSOVER_MDI		  0x0008
 
 #define MSCC_PHY_ACTIPHY_CNTL		  20
+#define PHY_ADDR_REVERSED		  0x0200
 #define DOWNSHIFT_CNTL_MASK		  0x001C
 #define DOWNSHIFT_EN			  0x0010
 #define DOWNSHIFT_CNTL_POS		  2
 
 #define MSCC_PHY_EXT_PHY_CNTL_4		  23
+#define PHY_CNTL_4_ADDR_POS		  11
+
+#define MSCC_PHY_VERIPHY_CNTL_2		  25
+
+#define MSCC_PHY_VERIPHY_CNTL_3		  26
 
 /* Extended Page 2 Registers */
+#define MSCC_PHY_CU_PMD_TX_CNTL		  16
+
 #define MSCC_PHY_RGMII_CNTL		  20
 #define RGMII_RX_CLK_DELAY_MASK		  0x0070
 #define RGMII_RX_CLK_DELAY_POS		  4
@@ -101,6 +135,70 @@ enum rgmii_rx_clock_delay {
 #define SECURE_ON_ENABLE		  0x8000
 #define SECURE_ON_PASSWD_LEN_4		  0x4000
 
+/* Extended Page 3 Registers */
+#define MSCC_PHY_SERDES_TX_VALID_CNT	  21
+#define MSCC_PHY_SERDES_TX_CRC_ERR_CNT	  22
+#define MSCC_PHY_SERDES_RX_VALID_CNT	  28
+#define MSCC_PHY_SERDES_RX_CRC_ERR_CNT	  29
+
+/* Extended page GPIO Registers */
+#define MSCC_DW8051_CNTL_STATUS		  0
+#define MICRO_NSOFT_RESET		  0x8000
+#define RUN_FROM_INT_ROM		  0x4000
+#define AUTOINC_ADDR			  0x2000
+#define PATCH_RAM_CLK			  0x1000
+#define MICRO_PATCH_EN			  0x0080
+#define DW8051_CLK_EN			  0x0010
+#define MICRO_CLK_EN			  0x0008
+#define MICRO_CLK_DIVIDE(x)		  ((x) >> 1)
+
+/* x Address in range 1-4 */
+#define MSCC_TRAP_ROM_ADDR(x)		  ((x) * 2 + 1)
+#define MSCC_PATCH_RAM_ADDR(x)		  (((x) + 1) * 2)
+#define MSCC_INT_MEM_ADDR		  11
+
+#define MSCC_INT_MEM_CNTL		  12
+#define READ_SFR			  0x6000
+#define READ_PRAM			  0x4000
+#define READ_ROM			  0x2000
+#define READ_RAM			  0x0000
+#define INT_MEM_WRITE_EN		  0x1000
+#define EN_PATCH_RAM_TRAP_ADDR(x)	  (0x0100 << ((x) - 1))
+#define INT_MEM_DATA_M			  0x00ff
+#define INT_MEM_DATA(x)			  (INT_MEM_DATA_M & (x))
+
+#define MSCC_PHY_PROC_CMD		  18
+#define PROC_CMD_NCOMPLETED		  0x8000
+#define PROC_CMD_FAILED			  0x4000
+#define PROC_CMD_SGMII_PORT(x)		  ((x) << 8)
+#define PROC_CMD_FIBER_PORT(x)		  (0x0100 << (x) % 4)
+#define PROC_CMD_QSGMII_PORT		  0x0c00
+#define PROC_CMD_RST_CONF_PORT		  0x0080
+#define PROC_CMD_RECONF_PORT		  0x0000
+#define PROC_CMD_READ_MOD_WRITE_PORT	  0x0040
+#define PROC_CMD_WRITE			  0x0040
+#define PROC_CMD_READ			  0x0000
+#define PROC_CMD_FIBER_DISABLE		  0x0020
+#define PROC_CMD_FIBER_100BASE_FX	  0x0010
+#define PROC_CMD_FIBER_1000BASE_X	  0x0000
+#define PROC_CMD_SGMII_MAC		  0x0030
+#define PROC_CMD_QSGMII_MAC		  0x0020
+#define PROC_CMD_NO_MAC_CONF		  0x0000
+#define PROC_CMD_NOP			  0x000f
+#define PROC_CMD_CRC16			  0x0008
+#define PROC_CMD_FIBER_MEDIA_CONF	  0x0001
+#define PROC_CMD_MCB_ACCESS_MAC_CONF	  0x0000
+#define PROC_CMD_NCOMPLETED_TIMEOUT_MS    500
+
+#define MSCC_PHY_MAC_CFG_FASTLINK	  19
+#define MAC_CFG_MASK			  0xc000
+#define MAC_CFG_SGMII			  0x0000
+#define MAC_CFG_QSGMII			  0x4000
+
+/* Test page Registers */
+#define MSCC_PHY_TEST_PAGE_5		  5
+#define MSCC_PHY_TEST_PAGE_8		  8
+
 /* Token ring page Registers */
 #define MSCC_PHY_TR_CNTL		  16
 #define TR_WRITE			  0x8000
@@ -113,6 +211,7 @@ enum rgmii_rx_clock_delay {
 #define PHY_ID_VSC8531			  0x00070570
 #define PHY_ID_VSC8540			  0x00070760
 #define PHY_ID_VSC8541			  0x00070770
+#define PHY_ID_VSC8584			  0x000707c0
 
 #define MSCC_VDDMAC_1500		  1500
 #define MSCC_VDDMAC_1800		  1800
@@ -122,6 +221,24 @@ enum rgmii_rx_clock_delay {
 #define DOWNSHIFT_COUNT_MAX		  5
 
 #define MAX_LEDS			  4
+
+#define VSC8584_SUPP_LED_MODES (BIT(VSC8531_LINK_ACTIVITY) | \
+				BIT(VSC8531_LINK_1000_ACTIVITY) | \
+				BIT(VSC8531_LINK_100_ACTIVITY) | \
+				BIT(VSC8531_LINK_10_ACTIVITY) | \
+				BIT(VSC8531_LINK_100_1000_ACTIVITY) | \
+				BIT(VSC8531_LINK_10_1000_ACTIVITY) | \
+				BIT(VSC8531_LINK_10_100_ACTIVITY) | \
+				BIT(VSC8584_LINK_100FX_1000X_ACTIVITY) | \
+				BIT(VSC8531_DUPLEX_COLLISION) | \
+				BIT(VSC8531_COLLISION) | \
+				BIT(VSC8531_ACTIVITY) | \
+				BIT(VSC8584_100FX_1000X_ACTIVITY) | \
+				BIT(VSC8531_AUTONEG_FAULT) | \
+				BIT(VSC8531_SERIAL_MODE) | \
+				BIT(VSC8531_FORCE_LED_OFF) | \
+				BIT(VSC8531_FORCE_LED_ON))
+
 #define VSC85XX_SUPP_LED_MODES (BIT(VSC8531_LINK_ACTIVITY) | \
 				BIT(VSC8531_LINK_1000_ACTIVITY) | \
 				BIT(VSC8531_LINK_100_ACTIVITY) | \
@@ -137,6 +254,13 @@ enum rgmii_rx_clock_delay {
 				BIT(VSC8531_FORCE_LED_OFF) | \
 				BIT(VSC8531_FORCE_LED_ON))
 
+#define MSCC_VSC8584_REVB_INT8051_FW		"mscc_vsc8584_revb_int8051_fb48.bin"
+#define MSCC_VSC8584_REVB_INT8051_FW_START_ADDR	0xe800
+#define MSCC_VSC8584_REVB_INT8051_FW_CRC	0xfb48
+
+#define VSC8584_REVB				0x0001
+#define MSCC_DEV_REV_MASK			GENMASK(3, 0)
+
 struct vsc85xx_hw_stat {
 	const char *string;
 	u8 reg;
@@ -173,6 +297,55 @@ static struct vsc85xx_hw_stat vsc85xx_hw_stats[] = {
 	},
 };
 
+static struct vsc85xx_hw_stat vsc8584_hw_stats[] = {
+	{
+		.string	= "phy_receive_errors",
+		.reg	= MSCC_PHY_ERR_RX_CNT,
+		.page	= MSCC_PHY_PAGE_STANDARD,
+		.mask	= ERR_CNT_MASK,
+	}, {
+		.string	= "phy_false_carrier",
+		.reg	= MSCC_PHY_ERR_FALSE_CARRIER_CNT,
+		.page	= MSCC_PHY_PAGE_STANDARD,
+		.mask	= ERR_CNT_MASK,
+	}, {
+		.string	= "phy_cu_media_link_disconnect",
+		.reg	= MSCC_PHY_ERR_LINK_DISCONNECT_CNT,
+		.page	= MSCC_PHY_PAGE_STANDARD,
+		.mask	= ERR_CNT_MASK,
+	}, {
+		.string	= "phy_cu_media_crc_good_count",
+		.reg	= MSCC_PHY_CU_MEDIA_CRC_VALID_CNT,
+		.page	= MSCC_PHY_PAGE_EXTENDED,
+		.mask	= VALID_CRC_CNT_CRC_MASK,
+	}, {
+		.string	= "phy_cu_media_crc_error_count",
+		.reg	= MSCC_PHY_EXT_PHY_CNTL_4,
+		.page	= MSCC_PHY_PAGE_EXTENDED,
+		.mask	= ERR_CNT_MASK,
+	}, {
+		.string	= "phy_serdes_tx_good_pkt_count",
+		.reg	= MSCC_PHY_SERDES_TX_VALID_CNT,
+		.page	= MSCC_PHY_PAGE_EXTENDED_3,
+		.mask	= VALID_CRC_CNT_CRC_MASK,
+	}, {
+		.string	= "phy_serdes_tx_bad_crc_count",
+		.reg	= MSCC_PHY_SERDES_TX_CRC_ERR_CNT,
+		.page	= MSCC_PHY_PAGE_EXTENDED_3,
+		.mask	= ERR_CNT_MASK,
+	}, {
+		.string	= "phy_serdes_rx_good_pkt_count",
+		.reg	= MSCC_PHY_SERDES_RX_VALID_CNT,
+		.page	= MSCC_PHY_PAGE_EXTENDED_3,
+		.mask	= VALID_CRC_CNT_CRC_MASK,
+	}, {
+		.string	= "phy_serdes_rx_bad_crc_count",
+		.reg	= MSCC_PHY_SERDES_RX_CRC_ERR_CNT,
+		.page	= MSCC_PHY_PAGE_EXTENDED_3,
+		.mask	= ERR_CNT_MASK,
+	},
+};
+
 struct vsc8531_private {
 	int rate_magic;
 	u16 supp_led_modes;
@@ -181,6 +354,7 @@ struct vsc8531_private {
 	struct vsc85xx_hw_stat *hw_stats;
 	u64 *stats;
 	int nstats;
+	bool pkg_init;
 };
 
 #ifdef CONFIG_OF_MDIO
@@ -730,6 +904,481 @@ static int vsc85xx_eee_init_seq_set(struct phy_device *phydev)
 	return rc;
 }
 
+/* bus->mdio_lock should be locked when using this function */
+static void vsc8584_csr_write(struct mii_bus *bus, int phy, u16 addr, u32 val)
+{
+	__mdiobus_write(bus, phy, MSCC_PHY_TR_MSB, val >> 16);
+	__mdiobus_write(bus, phy, MSCC_PHY_TR_LSB, val & GENMASK(15, 0));
+	__mdiobus_write(bus, phy, MSCC_PHY_TR_CNTL, TR_WRITE | TR_ADDR(addr));
+}
+
+/* bus->mdio_lock should be locked when using this function */
+static int vsc8584_cmd(struct mii_bus *bus, int phy, u16 val)
+{
+	unsigned long deadline;
+	u16 reg_val;
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,
+			MSCC_PHY_PAGE_EXTENDED_GPIO);
+
+	__mdiobus_write(bus, phy, MSCC_PHY_PROC_CMD, PROC_CMD_NCOMPLETED | val);
+
+	deadline = jiffies + msecs_to_jiffies(PROC_CMD_NCOMPLETED_TIMEOUT_MS);
+	do {
+		reg_val = __mdiobus_read(bus, phy, MSCC_PHY_PROC_CMD);
+	} while (time_before(jiffies, deadline) &&
+		 (reg_val & PROC_CMD_NCOMPLETED) &&
+		 !(reg_val & PROC_CMD_FAILED));
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_STANDARD);
+
+	if (reg_val & PROC_CMD_FAILED)
+		return -EIO;
+
+	if (reg_val & PROC_CMD_NCOMPLETED)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+/* bus->mdio_lock should be locked when using this function */
+static int vsc8584_micro_deassert_reset(struct mii_bus *bus, int phy,
+					bool patch_en)
+{
+	u32 enable, release;
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,
+			MSCC_PHY_PAGE_EXTENDED_GPIO);
+
+	enable = RUN_FROM_INT_ROM | MICRO_CLK_EN | DW8051_CLK_EN;
+	release = MICRO_NSOFT_RESET | RUN_FROM_INT_ROM | DW8051_CLK_EN |
+		MICRO_CLK_EN;
+
+	if (patch_en) {
+		enable |= MICRO_PATCH_EN;
+		release |= MICRO_PATCH_EN;
+
+		/* Clear all patches */
+		__mdiobus_write(bus, phy, MSCC_INT_MEM_CNTL, READ_RAM);
+	}
+
+	/* Enable 8051 Micro clock; CLEAR/SET patch present; disable PRAM clock
+	 * override and addr. auto-incr; operate at 125 MHz
+	 */
+	__mdiobus_write(bus, phy, MSCC_DW8051_CNTL_STATUS, enable);
+	/* Release 8051 Micro SW reset */
+	__mdiobus_write(bus, phy, MSCC_DW8051_CNTL_STATUS, release);
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_STANDARD);
+
+	return 0;
+}
+
+/* bus->mdio_lock should be locked when using this function */
+static int vsc8584_micro_assert_reset(struct mii_bus *bus, int phy)
+{
+	int ret;
+	u16 reg;
+
+	ret = vsc8584_cmd(bus, phy, PROC_CMD_NOP);
+	if (ret)
+		return ret;
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,
+			MSCC_PHY_PAGE_EXTENDED_GPIO);
+
+	reg = __mdiobus_read(bus, phy, MSCC_INT_MEM_CNTL);
+	reg &= ~EN_PATCH_RAM_TRAP_ADDR(4);
+	__mdiobus_write(bus, phy, MSCC_INT_MEM_CNTL, reg);
+
+	__mdiobus_write(bus, phy, MSCC_TRAP_ROM_ADDR(4), 0x005b);
+	__mdiobus_write(bus, phy, MSCC_PATCH_RAM_ADDR(4), 0x005b);
+
+	reg = __mdiobus_read(bus, phy, MSCC_INT_MEM_CNTL);
+	reg |= EN_PATCH_RAM_TRAP_ADDR(4);
+	__mdiobus_write(bus, phy, MSCC_INT_MEM_CNTL, reg);
+
+	__mdiobus_write(bus, phy, MSCC_PHY_PROC_CMD, PROC_CMD_NOP);
+
+	reg = __mdiobus_read(bus, phy, MSCC_DW8051_CNTL_STATUS);
+	reg &= ~MICRO_NSOFT_RESET;
+	__mdiobus_write(bus, phy, MSCC_DW8051_CNTL_STATUS, reg);
+
+	__mdiobus_write(bus, phy, MSCC_PHY_PROC_CMD,
+			PROC_CMD_MCB_ACCESS_MAC_CONF |
+			PROC_CMD_SGMII_PORT(0) | PROC_CMD_NO_MAC_CONF |
+			PROC_CMD_READ);
+
+	reg = __mdiobus_read(bus, phy, MSCC_INT_MEM_CNTL);
+	reg &= ~EN_PATCH_RAM_TRAP_ADDR(4);
+	__mdiobus_write(bus, phy, MSCC_INT_MEM_CNTL, reg);
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,	MSCC_PHY_PAGE_STANDARD);
+
+	return 0;
+}
+
+/* bus->mdio_lock should be locked when using this function */
+static int vsc8584_get_fw_crc(struct mii_bus *bus, int phy, u16 start,
+			      u16 size, u16 *crc)
+{
+	int ret;
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_EXTENDED);
+
+	__mdiobus_write(bus, phy, MSCC_PHY_VERIPHY_CNTL_2, start);
+	__mdiobus_write(bus, phy, MSCC_PHY_VERIPHY_CNTL_3, size);
+
+	/* Start Micro command */
+	ret = vsc8584_cmd(bus, phy, PROC_CMD_CRC16);
+	if (ret)
+		goto out;
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,	MSCC_PHY_PAGE_EXTENDED);
+
+	*crc = __mdiobus_read(bus, phy, MSCC_PHY_VERIPHY_CNTL_2);
+
+out:
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,	MSCC_PHY_PAGE_STANDARD);
+
+	return ret;
+}
+
+/* bus->mdio_lock should be locked when using this function */
+static int vsc8584_patch_fw(struct mii_bus *bus, int phy,
+			    const struct firmware *fw)
+{
+	int i, ret;
+
+	ret = vsc8584_micro_assert_reset(bus, phy);
+	if (ret) {
+		dev_err(&bus->mdio_map[phy]->dev,
+			"%s: failed to assert reset of micro\n", __func__);
+		return ret;
+	}
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,
+			MSCC_PHY_PAGE_EXTENDED_GPIO);
+
+	/* Hold 8051 Micro in SW Reset, Enable auto incr address and patch clock
+	 * Disable the 8051 Micro clock
+	 */
+	__mdiobus_write(bus, phy, MSCC_DW8051_CNTL_STATUS, RUN_FROM_INT_ROM |
+			AUTOINC_ADDR | PATCH_RAM_CLK | MICRO_CLK_EN |
+			MICRO_CLK_DIVIDE(2));
+	__mdiobus_write(bus, phy, MSCC_INT_MEM_CNTL, READ_PRAM |
+			INT_MEM_WRITE_EN | INT_MEM_DATA(2));
+	__mdiobus_write(bus, phy, MSCC_INT_MEM_ADDR, 0x0000);
+
+	for (i = 0; i < fw->size; i++)
+		__mdiobus_write(bus, phy, MSCC_INT_MEM_CNTL, READ_PRAM |
+				INT_MEM_WRITE_EN | fw->data[i]);
+
+	/* Clear internal memory access */
+	__mdiobus_write(bus, phy, MSCC_INT_MEM_CNTL, READ_RAM);
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,	MSCC_PHY_PAGE_STANDARD);
+
+	return 0;
+}
+
+/* bus->mdio_lock should be locked when using this function */
+static int vsc8584_config_pre_init(struct mii_bus *bus, int phy)
+{
+	struct device *dev = &bus->mdio_map[phy]->dev;
+	const struct firmware *fw;
+	u16 crc, reg;
+	int ret;
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,	MSCC_PHY_PAGE_STANDARD);
+
+	/* all writes below this line are broadcasted to all PHYs */
+	reg = __mdiobus_read(bus, phy, MSCC_PHY_EXT_CNTL_STATUS);
+	reg |= SMI_BROADCAST_WR_EN;
+	__mdiobus_write(bus, phy, MSCC_PHY_EXT_CNTL_STATUS, reg);
+
+	__mdiobus_write(bus, phy, MII_VSC85XX_INT_MASK, 0);
+
+	reg = __mdiobus_read(bus, phy,  MSCC_PHY_BYPASS_CONTROL);
+	reg |= PARALLEL_DET_IGNORE_ADVERTISED;
+	__mdiobus_write(bus, phy, MSCC_PHY_BYPASS_CONTROL, reg);
+
+	/* The below register writes are tweaking analog and electrical
+	 * configuration that were determined through characterization by PHY
+	 * engineers. These don't mean anything more than "these are the best
+	 * values".
+	 */
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,
+			MSCC_PHY_PAGE_EXTENDED_3);
+
+	__mdiobus_write(bus, phy, MSCC_PHY_SERDES_TX_CRC_ERR_CNT, 0x2000);
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TEST);
+
+	__mdiobus_write(bus, phy, MSCC_PHY_TEST_PAGE_5, 0x1f20);
+
+	reg = __mdiobus_read(bus, phy, MSCC_PHY_TEST_PAGE_8);
+	reg |= 0x8000;
+	__mdiobus_write(bus, phy, MSCC_PHY_TEST_PAGE_8, reg);
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TR);
+
+	__mdiobus_write(bus, phy, MSCC_PHY_TR_CNTL, TR_WRITE | TR_ADDR(0x2fa4));
+
+	reg = __mdiobus_read(bus, phy, MSCC_PHY_TR_MSB);
+	reg &= ~0x007f;
+	reg |= 0x0019;
+	__mdiobus_write(bus, phy, MSCC_PHY_TR_MSB, reg);
+
+	__mdiobus_write(bus, phy, MSCC_PHY_TR_CNTL, TR_WRITE | TR_ADDR(0x0fa4));
+
+	vsc8584_csr_write(bus, phy, 0x07fa, 0x0050100f);
+	vsc8584_csr_write(bus, phy, 0x1688, 0x00049f81);
+	vsc8584_csr_write(bus, phy, 0x0f90, 0x00688980);
+	vsc8584_csr_write(bus, phy, 0x03a4, 0x0000d8f0);
+	vsc8584_csr_write(bus, phy, 0x0fc0, 0x00000400);
+	vsc8584_csr_write(bus, phy, 0x0f82, 0x0012b002);
+	vsc8584_csr_write(bus, phy, 0x1686, 0x00000004);
+	vsc8584_csr_write(bus, phy, 0x168c, 0x00d2c46f);
+	vsc8584_csr_write(bus, phy, 0x17a2, 0x00000620);
+	vsc8584_csr_write(bus, phy, 0x16a0, 0x00eeffdd);
+	vsc8584_csr_write(bus, phy, 0x16a6, 0x00071448);
+	vsc8584_csr_write(bus, phy, 0x16a4, 0x0013132f);
+	vsc8584_csr_write(bus, phy, 0x16a8, 0x00000000);
+	vsc8584_csr_write(bus, phy, 0x0ffc, 0x00c0a028);
+	vsc8584_csr_write(bus, phy, 0x0fe8, 0x0091b06c);
+	vsc8584_csr_write(bus, phy, 0x0fea, 0x00041600);
+	vsc8584_csr_write(bus, phy, 0x0f80, 0x00fffaff);
+	vsc8584_csr_write(bus, phy, 0x0fec, 0x00901809);
+	vsc8584_csr_write(bus, phy, 0x0ffe, 0x00b01007);
+	vsc8584_csr_write(bus, phy, 0x16b0, 0x00eeff00);
+	vsc8584_csr_write(bus, phy, 0x16b2, 0x00007000);
+	vsc8584_csr_write(bus, phy, 0x16b4, 0x00000814);
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,
+			MSCC_PHY_PAGE_EXTENDED_2);
+
+	__mdiobus_write(bus, phy, MSCC_PHY_CU_PMD_TX_CNTL, 0x028e);
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TR);
+
+	vsc8584_csr_write(bus, phy, 0x0486, 0x0008a518);
+	vsc8584_csr_write(bus, phy, 0x0488, 0x006dc696);
+	vsc8584_csr_write(bus, phy, 0x048a, 0x00000912);
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_TEST);
+
+	reg = __mdiobus_read(bus, phy, MSCC_PHY_TEST_PAGE_8);
+	reg &= ~0x8000;
+	__mdiobus_write(bus, phy, MSCC_PHY_TEST_PAGE_8, reg);
+
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,	MSCC_PHY_PAGE_STANDARD);
+
+	/* end of write broadcasting */
+	reg = __mdiobus_read(bus, phy, MSCC_PHY_EXT_CNTL_STATUS);
+	reg &= ~SMI_BROADCAST_WR_EN;
+	__mdiobus_write(bus, phy, MSCC_PHY_EXT_CNTL_STATUS, reg);
+
+	ret = request_firmware(&fw, MSCC_VSC8584_REVB_INT8051_FW, dev);
+	if (ret) {
+		dev_err(dev, "failed to load firmware %s, ret: %d\n",
+			MSCC_VSC8584_REVB_INT8051_FW, ret);
+		return ret;
+	}
+
+	/* Add one byte to size for the one added by the patch_fw function */
+	ret = vsc8584_get_fw_crc(bus, phy,
+				 MSCC_VSC8584_REVB_INT8051_FW_START_ADDR,
+				 fw->size + 1, &crc);
+	if (ret)
+		goto out;
+
+	if (crc != MSCC_VSC8584_REVB_INT8051_FW_CRC) {
+		dev_dbg(dev, "FW CRC is not the expected one, patching FW\n");
+		if (vsc8584_patch_fw(bus, phy, fw))
+			dev_warn(dev,
+				 "failed to patch FW, expect non-optimal device\n");
+	}
+
+	vsc8584_micro_deassert_reset(bus, phy, false);
+
+	/* Add one byte to size for the one added by the patch_fw function */
+	ret = vsc8584_get_fw_crc(bus, phy,
+				 MSCC_VSC8584_REVB_INT8051_FW_START_ADDR,
+				 fw->size + 1, &crc);
+	if (ret)
+		goto out;
+
+	if (crc != MSCC_VSC8584_REVB_INT8051_FW_CRC)
+		dev_warn(dev,
+			 "FW CRC after patching is not the expected one, expect non-optimal device\n");
+
+	ret = vsc8584_micro_assert_reset(bus, phy);
+	if (ret)
+		goto out;
+
+	vsc8584_micro_deassert_reset(bus, phy, true);
+
+out:
+	__mdiobus_write(bus, phy, MSCC_EXT_PAGE_ACCESS,	MSCC_PHY_PAGE_STANDARD);
+
+	release_firmware(fw);
+
+	return ret;
+}
+
+/* Check if one PHY has already done the init of the parts common to all PHYs
+ * in the Quad PHY package.
+ */
+static bool vsc8584_is_pkg_init(struct phy_device *phydev, int phy0,
+				bool reversed)
+{
+	struct mdio_device **map = phydev->mdio.bus->mdio_map;
+	struct vsc8531_private *vsc8531;
+	struct phy_device *phy;
+	int i, addr;
+
+	/* VSC8584 is a Quad PHY */
+	for (i = 0; i < 4; i++) {
+		if (reversed)
+			addr = phy0 - i;
+		else
+			addr = phy0 + i;
+
+		phy = container_of(map[addr], struct phy_device, mdio);
+
+		if ((phy->phy_id & phydev->drv->phy_id_mask) !=
+		    (phydev->drv->phy_id & phydev->drv->phy_id_mask))
+			continue;
+
+		vsc8531 = phy->priv;
+
+		if (vsc8531 && vsc8531->pkg_init)
+			return true;
+	}
+
+	return false;
+}
+
+static int vsc8584_config_init(struct phy_device *phydev)
+{
+	struct vsc8531_private *vsc8531 = phydev->priv;
+	u16 addr, val, base_addr;
+	int ret, i;
+
+	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
+
+	mutex_lock(&phydev->mdio.bus->mdio_lock);
+
+	__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
+			MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_EXTENDED);
+	addr = __mdiobus_read(phydev->mdio.bus, phydev->mdio.addr,
+			      MSCC_PHY_EXT_PHY_CNTL_4);
+	addr >>= PHY_CNTL_4_ADDR_POS;
+
+	val = __mdiobus_read(phydev->mdio.bus, phydev->mdio.addr,
+			     MSCC_PHY_ACTIPHY_CNTL);
+	if (val & PHY_ADDR_REVERSED)
+		base_addr = phydev->mdio.addr + addr;
+	else
+		base_addr = phydev->mdio.addr - addr;
+
+	/* Some parts of the init sequence are identical for every PHY in the
+	 * package. Some parts are modifying the GPIO register bank which is a
+	 * set of registers that are affecting all PHYs, a few resetting the
+	 * microprocessor common to all PHYs. The CRC check responsible of the
+	 * checking the firmware within the 8051 microprocessor can only be
+	 * accessed via the PHY whose internal address in the package is 0.
+	 * All PHYs' interrupts mask register has to be zeroed before enabling
+	 * any PHY's interrupt in this register.
+	 * For all these reasons, we need to do the init sequence once and only
+	 * once whatever is the first PHY in the package that is initialized and
+	 * do the correct init sequence for all PHYs that are package-critical
+	 * in this pre-init function.
+	 */
+	if (!vsc8584_is_pkg_init(phydev, base_addr,
+				 val & PHY_ADDR_REVERSED ? 1 : 0)) {
+		ret = vsc8584_config_pre_init(phydev->mdio.bus, base_addr);
+		if (ret)
+			goto err;
+	}
+
+	vsc8531->pkg_init = true;
+
+	__mdiobus_write(phydev->mdio.bus, base_addr, MSCC_EXT_PAGE_ACCESS,
+			MSCC_PHY_PAGE_EXTENDED_GPIO);
+
+	val = __mdiobus_read(phydev->mdio.bus, base_addr,
+			     MSCC_PHY_MAC_CFG_FASTLINK);
+	val &= ~MAC_CFG_MASK;
+	if (phydev->interface == PHY_INTERFACE_MODE_QSGMII)
+		val |= MAC_CFG_QSGMII;
+	else
+		val |= MAC_CFG_SGMII;
+
+	ret = __mdiobus_write(phydev->mdio.bus, base_addr,
+			      MSCC_PHY_MAC_CFG_FASTLINK, val);
+	if (ret)
+		goto err;
+
+	val = PROC_CMD_MCB_ACCESS_MAC_CONF | PROC_CMD_RST_CONF_PORT |
+		PROC_CMD_READ_MOD_WRITE_PORT;
+	if (phydev->interface == PHY_INTERFACE_MODE_QSGMII)
+		val |= PROC_CMD_QSGMII_MAC;
+	else
+		val |= PROC_CMD_SGMII_MAC;
+
+	ret = vsc8584_cmd(phydev->mdio.bus, base_addr, val);
+	if (ret)
+		goto err;
+
+	usleep_range(10000, 20000);
+
+	/* Disable SerDes for 100Base-FX */
+	ret = vsc8584_cmd(phydev->mdio.bus, base_addr,
+			  PROC_CMD_FIBER_MEDIA_CONF |
+			  PROC_CMD_FIBER_PORT(addr) | PROC_CMD_FIBER_DISABLE |
+			  PROC_CMD_READ_MOD_WRITE_PORT |
+			  PROC_CMD_RST_CONF_PORT | PROC_CMD_FIBER_100BASE_FX);
+	if (ret)
+		goto err;
+
+	/* Disable SerDes for 1000Base-X */
+	ret = vsc8584_cmd(phydev->mdio.bus, base_addr,
+			  PROC_CMD_FIBER_MEDIA_CONF |
+			  PROC_CMD_FIBER_PORT(addr) | PROC_CMD_FIBER_DISABLE |
+			  PROC_CMD_READ_MOD_WRITE_PORT |
+			  PROC_CMD_RST_CONF_PORT | PROC_CMD_FIBER_1000BASE_X);
+	if (ret)
+		goto err;
+
+	mutex_unlock(&phydev->mdio.bus->mdio_lock);
+
+	phy_write(phydev, MSCC_EXT_PAGE_ACCESS, MSCC_PHY_PAGE_STANDARD);
+
+	val = phy_read(phydev, MSCC_PHY_EXT_PHY_CNTL_1);
+	val &= ~(MEDIA_OP_MODE_MASK | VSC8584_MAC_IF_SELECTION_MASK);
+	val |= MEDIA_OP_MODE_COPPER | (VSC8584_MAC_IF_SELECTION_SGMII <<
+				       VSC8584_MAC_IF_SELECTION_POS);
+	ret = phy_write(phydev, MSCC_PHY_EXT_PHY_CNTL_1, val);
+
+	ret = genphy_soft_reset(phydev);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < vsc8531->nleds; i++) {
+		ret = vsc85xx_led_cntl_set(phydev, i, vsc8531->leds_mode[i]);
+		if (ret)
+			return ret;
+	}
+
+	return genphy_config_init(phydev);
+
+err:
+	mutex_unlock(&phydev->mdio.bus->mdio_lock);
+	return ret;
+}
+
 static int vsc85xx_config_init(struct phy_device *phydev)
 {
 	int rc, i;
@@ -760,6 +1409,16 @@ static int vsc85xx_config_init(struct phy_device *phydev)
 	return genphy_config_init(phydev);
 }
 
+static int vsc8584_did_interrupt(struct phy_device *phydev)
+{
+	int rc = 0;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
+		rc = phy_read(phydev, MII_VSC85XX_INT_STATUS);
+
+	return (rc < 0) ? 0 : rc & MII_VSC85XX_INT_MASK_MASK;
+}
+
 static int vsc85xx_ack_interrupt(struct phy_device *phydev)
 {
 	int rc = 0;
@@ -809,6 +1468,37 @@ static int vsc85xx_read_status(struct phy_device *phydev)
 	return genphy_read_status(phydev);
 }
 
+static int vsc8584_probe(struct phy_device *phydev)
+{
+	struct vsc8531_private *vsc8531;
+	u32 default_mode[4] = {VSC8531_LINK_1000_ACTIVITY,
+	   VSC8531_LINK_100_ACTIVITY, VSC8531_LINK_ACTIVITY,
+	   VSC8531_DUPLEX_COLLISION};
+
+	if ((phydev->phy_id & MSCC_DEV_REV_MASK) != VSC8584_REVB) {
+		dev_err(&phydev->mdio.dev, "Only VSC8584 revB is supported.\n");
+		return -ENOTSUPP;
+	}
+
+	vsc8531 = devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531), GFP_KERNEL);
+	if (!vsc8531)
+		return -ENOMEM;
+
+	phydev->priv = vsc8531;
+
+	vsc8531->nleds = 4;
+	vsc8531->supp_led_modes = VSC8584_SUPP_LED_MODES;
+	vsc8531->hw_stats = vsc8584_hw_stats;
+	vsc8531->nstats = ARRAY_SIZE(vsc8584_hw_stats);
+	vsc8531->stats = devm_kzalloc(&phydev->mdio.dev,
+				      sizeof(u64) * vsc8531->nstats,
+				      GFP_KERNEL);
+	if (!vsc8531->stats)
+		return -ENOMEM;
+
+	return vsc85xx_dt_led_modes_get(phydev, default_mode);
+}
+
 static int vsc85xx_probe(struct phy_device *phydev)
 {
 	struct vsc8531_private *vsc8531;
@@ -937,6 +1627,29 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_sset_count = &vsc85xx_get_sset_count,
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
+},
+{
+	.phy_id		= PHY_ID_VSC8584,
+	.name		= "Microsemi GE VSC8584 SyncE",
+	.phy_id_mask	= 0xfffffff0,
+	.features	= PHY_GBIT_FEATURES,
+	.flags		= PHY_HAS_INTERRUPT,
+	.soft_reset	= &genphy_soft_reset,
+	.config_init    = &vsc8584_config_init,
+	.config_aneg    = &vsc85xx_config_aneg,
+	.aneg_done	= &genphy_aneg_done,
+	.read_status	= &vsc85xx_read_status,
+	.ack_interrupt  = &vsc85xx_ack_interrupt,
+	.config_intr    = &vsc85xx_config_intr,
+	.did_interrupt  = &vsc8584_did_interrupt,
+	.suspend	= &genphy_suspend,
+	.resume		= &genphy_resume,
+	.probe		= &vsc8584_probe,
+	.get_tunable	= &vsc85xx_get_tunable,
+	.set_tunable	= &vsc85xx_set_tunable,
+	.get_sset_count = &vsc85xx_get_sset_count,
+	.get_strings    = &vsc85xx_get_strings,
+	.get_stats      = &vsc85xx_get_stats,
 }
 
 };
@@ -948,6 +1661,7 @@ static struct mdio_device_id __maybe_unused vsc85xx_tbl[] = {
 	{ PHY_ID_VSC8531, 0xfffffff0, },
 	{ PHY_ID_VSC8540, 0xfffffff0, },
 	{ PHY_ID_VSC8541, 0xfffffff0, },
+	{ PHY_ID_VSC8584, 0xfffffff0, },
 	{ }
 };
 
-- 
git-series 0.9.1
