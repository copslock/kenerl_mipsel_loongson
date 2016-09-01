Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 22:46:02 +0200 (CEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:42602 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992307AbcIAUoL24K2N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 22:44:11 +0200
Received: from localhost.localdomain (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id E3BC8433C;
        Thu,  1 Sep 2016 23:44:10 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 4/6] MIPS: OCTEON: delete cvmx_helper_board_link_set_phy
Date:   Thu,  1 Sep 2016 23:43:58 +0300
Message-Id: <20160901204400.16562-5-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160901204400.16562-1-aaro.koskinen@iki.fi>
References: <20160901204400.16562-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Delete unused cvmx_helper_board_link_set_phy.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../cavium-octeon/executive/cvmx-helper-board.c    | 170 ---------------------
 arch/mips/include/asm/octeon/cvmx-helper-board.h   |  20 ---
 2 files changed, 190 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index 0deeb82..5572e39 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -418,176 +418,6 @@ cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port)
 }
 
 /**
- * This function as a board specific method of changing the PHY
- * speed, duplex, and auto-negotiation. This programs the PHY and
- * not Octeon. This can be used to force Octeon's links to
- * specific settings.
- *
- * @phy_addr:  The address of the PHY to program
- * @enable_autoneg:
- *		    Non zero if you want to enable auto-negotiation.
- * @link_info: Link speed to program. If the speed is zero and auto-negotiation
- *		    is enabled, all possible negotiation speeds are advertised.
- *
- * Returns Zero on success, negative on failure
- */
-int cvmx_helper_board_link_set_phy(int phy_addr,
-				   cvmx_helper_board_set_phy_link_flags_types_t
-				   link_flags,
-				   cvmx_helper_link_info_t link_info)
-{
-
-	/* Set the flow control settings based on link_flags */
-	if ((link_flags & set_phy_link_flags_flow_control_mask) !=
-	    set_phy_link_flags_flow_control_dont_touch) {
-		cvmx_mdio_phy_reg_autoneg_adver_t reg_autoneg_adver;
-		reg_autoneg_adver.u16 =
-		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
-				   CVMX_MDIO_PHY_REG_AUTONEG_ADVER);
-		reg_autoneg_adver.s.asymmetric_pause =
-		    (link_flags & set_phy_link_flags_flow_control_mask) ==
-		    set_phy_link_flags_flow_control_enable;
-		reg_autoneg_adver.s.pause =
-		    (link_flags & set_phy_link_flags_flow_control_mask) ==
-		    set_phy_link_flags_flow_control_enable;
-		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
-				CVMX_MDIO_PHY_REG_AUTONEG_ADVER,
-				reg_autoneg_adver.u16);
-	}
-
-	/* If speed isn't set and autoneg is on advertise all supported modes */
-	if ((link_flags & set_phy_link_flags_autoneg)
-	    && (link_info.s.speed == 0)) {
-		cvmx_mdio_phy_reg_control_t reg_control;
-		cvmx_mdio_phy_reg_status_t reg_status;
-		cvmx_mdio_phy_reg_autoneg_adver_t reg_autoneg_adver;
-		cvmx_mdio_phy_reg_extended_status_t reg_extended_status;
-		cvmx_mdio_phy_reg_control_1000_t reg_control_1000;
-
-		reg_status.u16 =
-		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
-				   CVMX_MDIO_PHY_REG_STATUS);
-		reg_autoneg_adver.u16 =
-		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
-				   CVMX_MDIO_PHY_REG_AUTONEG_ADVER);
-		reg_autoneg_adver.s.advert_100base_t4 =
-		    reg_status.s.capable_100base_t4;
-		reg_autoneg_adver.s.advert_10base_tx_full =
-		    reg_status.s.capable_10_full;
-		reg_autoneg_adver.s.advert_10base_tx_half =
-		    reg_status.s.capable_10_half;
-		reg_autoneg_adver.s.advert_100base_tx_full =
-		    reg_status.s.capable_100base_x_full;
-		reg_autoneg_adver.s.advert_100base_tx_half =
-		    reg_status.s.capable_100base_x_half;
-		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
-				CVMX_MDIO_PHY_REG_AUTONEG_ADVER,
-				reg_autoneg_adver.u16);
-		if (reg_status.s.capable_extended_status) {
-			reg_extended_status.u16 =
-			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
-					   CVMX_MDIO_PHY_REG_EXTENDED_STATUS);
-			reg_control_1000.u16 =
-			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
-					   CVMX_MDIO_PHY_REG_CONTROL_1000);
-			reg_control_1000.s.advert_1000base_t_full =
-			    reg_extended_status.s.capable_1000base_t_full;
-			reg_control_1000.s.advert_1000base_t_half =
-			    reg_extended_status.s.capable_1000base_t_half;
-			cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
-					CVMX_MDIO_PHY_REG_CONTROL_1000,
-					reg_control_1000.u16);
-		}
-		reg_control.u16 =
-		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
-				   CVMX_MDIO_PHY_REG_CONTROL);
-		reg_control.s.autoneg_enable = 1;
-		reg_control.s.restart_autoneg = 1;
-		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
-				CVMX_MDIO_PHY_REG_CONTROL, reg_control.u16);
-	} else if ((link_flags & set_phy_link_flags_autoneg)) {
-		cvmx_mdio_phy_reg_control_t reg_control;
-		cvmx_mdio_phy_reg_status_t reg_status;
-		cvmx_mdio_phy_reg_autoneg_adver_t reg_autoneg_adver;
-		cvmx_mdio_phy_reg_control_1000_t reg_control_1000;
-
-		reg_status.u16 =
-		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
-				   CVMX_MDIO_PHY_REG_STATUS);
-		reg_autoneg_adver.u16 =
-		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
-				   CVMX_MDIO_PHY_REG_AUTONEG_ADVER);
-		reg_autoneg_adver.s.advert_100base_t4 = 0;
-		reg_autoneg_adver.s.advert_10base_tx_full = 0;
-		reg_autoneg_adver.s.advert_10base_tx_half = 0;
-		reg_autoneg_adver.s.advert_100base_tx_full = 0;
-		reg_autoneg_adver.s.advert_100base_tx_half = 0;
-		if (reg_status.s.capable_extended_status) {
-			reg_control_1000.u16 =
-			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
-					   CVMX_MDIO_PHY_REG_CONTROL_1000);
-			reg_control_1000.s.advert_1000base_t_full = 0;
-			reg_control_1000.s.advert_1000base_t_half = 0;
-		}
-		switch (link_info.s.speed) {
-		case 10:
-			reg_autoneg_adver.s.advert_10base_tx_full =
-			    link_info.s.full_duplex;
-			reg_autoneg_adver.s.advert_10base_tx_half =
-			    !link_info.s.full_duplex;
-			break;
-		case 100:
-			reg_autoneg_adver.s.advert_100base_tx_full =
-			    link_info.s.full_duplex;
-			reg_autoneg_adver.s.advert_100base_tx_half =
-			    !link_info.s.full_duplex;
-			break;
-		case 1000:
-			reg_control_1000.s.advert_1000base_t_full =
-			    link_info.s.full_duplex;
-			reg_control_1000.s.advert_1000base_t_half =
-			    !link_info.s.full_duplex;
-			break;
-		}
-		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
-				CVMX_MDIO_PHY_REG_AUTONEG_ADVER,
-				reg_autoneg_adver.u16);
-		if (reg_status.s.capable_extended_status)
-			cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
-					CVMX_MDIO_PHY_REG_CONTROL_1000,
-					reg_control_1000.u16);
-		reg_control.u16 =
-		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
-				   CVMX_MDIO_PHY_REG_CONTROL);
-		reg_control.s.autoneg_enable = 1;
-		reg_control.s.restart_autoneg = 1;
-		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
-				CVMX_MDIO_PHY_REG_CONTROL, reg_control.u16);
-	} else {
-		cvmx_mdio_phy_reg_control_t reg_control;
-		reg_control.u16 =
-		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
-				   CVMX_MDIO_PHY_REG_CONTROL);
-		reg_control.s.autoneg_enable = 0;
-		reg_control.s.restart_autoneg = 1;
-		reg_control.s.duplex = link_info.s.full_duplex;
-		if (link_info.s.speed == 1000) {
-			reg_control.s.speed_msb = 1;
-			reg_control.s.speed_lsb = 0;
-		} else if (link_info.s.speed == 100) {
-			reg_control.s.speed_msb = 0;
-			reg_control.s.speed_lsb = 1;
-		} else if (link_info.s.speed == 10) {
-			reg_control.s.speed_msb = 0;
-			reg_control.s.speed_lsb = 0;
-		}
-		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
-				CVMX_MDIO_PHY_REG_CONTROL, reg_control.u16);
-	}
-	return 0;
-}
-
-/**
  * This function is called by cvmx_helper_interface_probe() after it
  * determines the number of ports Octeon can support on a specific
  * interface. This function is the per board location to override
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-board.h b/arch/mips/include/asm/octeon/cvmx-helper-board.h
index 271be7a..b4d19c21 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-board.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-board.h
@@ -76,26 +76,6 @@ typedef enum {
 extern int cvmx_helper_board_get_mii_address(int ipd_port);
 
 /**
- * This function as a board specific method of changing the PHY
- * speed, duplex, and autonegotiation. This programs the PHY and
- * not Octeon. This can be used to force Octeon's links to
- * specific settings.
- *
- * @phy_addr:  The address of the PHY to program
- * @link_flags:
- *		    Flags to control autonegotiation.  Bit 0 is autonegotiation
- *		    enable/disable to maintain backward compatibility.
- * @link_info: Link speed to program. If the speed is zero and autonegotiation
- *		    is enabled, all possible negotiation speeds are advertised.
- *
- * Returns Zero on success, negative on failure
- */
-int cvmx_helper_board_link_set_phy(int phy_addr,
-				   cvmx_helper_board_set_phy_link_flags_types_t
-				   link_flags,
-				   cvmx_helper_link_info_t link_info);
-
-/**
  * This function is the board specific method of determining an
  * ethernet ports link speed. Most Octeon boards have Marvell PHYs
  * and are handled by the fall through case. This function must be
-- 
2.9.2
