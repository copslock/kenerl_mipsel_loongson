Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 21:39:37 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:50272 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026352AbbEAThyhI0cy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 21:37:54 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 1546219BCBD;
        Fri,  1 May 2015 22:37:56 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id zTFxsaaqscIO; Fri,  1 May 2015 22:37:51 +0300 (EEST)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id EA6B95BC00B;
        Fri,  1 May 2015 22:37:47 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 08/11] MIPS: OCTEON: move the link helpers into a separate file
Date:   Fri,  1 May 2015 22:37:10 +0300
Message-Id: <1430509033-12113-9-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
References: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47193
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

Move the link helpers into a separate file.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/Makefile         |   2 +-
 .../cavium-octeon/executive/cvmx-helper-board.c    | 511 --------------------
 arch/mips/cavium-octeon/executive/cvmx-link.c      | 534 +++++++++++++++++++++
 3 files changed, 535 insertions(+), 512 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/executive/cvmx-link.c

diff --git a/arch/mips/cavium-octeon/executive/Makefile b/arch/mips/cavium-octeon/executive/Makefile
index e755a73..abafe06 100644
--- a/arch/mips/cavium-octeon/executive/Makefile
+++ b/arch/mips/cavium-octeon/executive/Makefile
@@ -14,7 +14,7 @@ obj-y += cvmx-pko.o cvmx-spi.o cvmx-cmd-queue.o \
 	cvmx-helper-board.o cvmx-helper.o cvmx-helper-xaui.o \
 	cvmx-helper-rgmii.o cvmx-helper-sgmii.o cvmx-helper-npi.o \
 	cvmx-helper-loop.o cvmx-helper-spi.o cvmx-helper-util.o \
-	cvmx-helper-ethernet.o \
+	cvmx-helper-ethernet.o cvmx-link.o \
 	cvmx-interrupt-decodes.o cvmx-interrupt-rsl.o
 
 obj-y += cvmx-helper-errata.o cvmx-helper-jtag.o
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index 9eb0fee..10f8de1 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -36,26 +36,9 @@
 
 #include <asm/octeon/cvmx-config.h>
 
-#include <asm/octeon/cvmx-mdio.h>
-
 #include <asm/octeon/cvmx-helper.h>
-#include <asm/octeon/cvmx-helper-util.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
-#include <asm/octeon/cvmx-gmxx-defs.h>
-#include <asm/octeon/cvmx-asxx-defs.h>
-
-/**
- * cvmx_override_board_link_get(int ipd_port) is a function
- * pointer. It is meant to allow customization of the process of
- * talking to a PHY to determine link speed. It is called every
- * time a PHY must be polled for link status. Users should set
- * this pointer to a function before calling any cvmx-helper
- * operations.
- */
-cvmx_helper_link_info_t(*cvmx_override_board_link_get) (int ipd_port) =
-    NULL;
-
 /**
  * Return the MII PHY address associated with the given IPD
  * port. A result of -1 means there isn't a MII capable PHY
@@ -205,419 +188,6 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
 }
 
 /**
- * This function is the board specific method of determining an
- * ethernet ports link speed. Most Octeon boards have Marvell PHYs
- * and are handled by the fall through case. This function must be
- * updated for boards that don't have the normal Marvell PHYs.
- *
- * This function must be modified for every new Octeon board.
- * Internally it uses switch statements based on the cvmx_sysinfo
- * data to determine board types and revisions. It relies on the
- * fact that every Octeon board receives a unique board type
- * enumeration from the bootloader.
- *
- * @ipd_port: IPD input port associated with the port we want to get link
- *		   status for.
- *
- * Returns The ports link status. If the link isn't fully resolved, this must
- *	   return zero.
- */
-cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port)
-{
-	cvmx_helper_link_info_t result;
-	int phy_addr;
-	int is_broadcom_phy = 0;
-
-	/* Give the user a chance to override the processing of this function */
-	if (cvmx_override_board_link_get)
-		return cvmx_override_board_link_get(ipd_port);
-
-	/* Unless we fix it later, all links are defaulted to down */
-	result.u64 = 0;
-
-	/*
-	 * This switch statement should handle all ports that either don't use
-	 * Marvell PHYS, or don't support in-band status.
-	 */
-	switch (cvmx_sysinfo_get()->board_type) {
-	case CVMX_BOARD_TYPE_SIM:
-		/* The simulator gives you a simulated 1Gbps full duplex link */
-		result.s.link_up = 1;
-		result.s.full_duplex = 1;
-		result.s.speed = 1000;
-		return result;
-	case CVMX_BOARD_TYPE_EBH3100:
-	case CVMX_BOARD_TYPE_CN3010_EVB_HS5:
-	case CVMX_BOARD_TYPE_CN3005_EVB_HS5:
-	case CVMX_BOARD_TYPE_CN3020_EVB_HS5:
-		/* Port 1 on these boards is always Gigabit */
-		if (ipd_port == 1) {
-			result.s.link_up = 1;
-			result.s.full_duplex = 1;
-			result.s.speed = 1000;
-			return result;
-		}
-		/* Fall through to the generic code below */
-		break;
-	case CVMX_BOARD_TYPE_CUST_NB5:
-		/* Port 1 on these boards is always Gigabit */
-		if (ipd_port == 1) {
-			result.s.link_up = 1;
-			result.s.full_duplex = 1;
-			result.s.speed = 1000;
-			return result;
-		} else		/* The other port uses a broadcom PHY */
-			is_broadcom_phy = 1;
-		break;
-	case CVMX_BOARD_TYPE_BBGW_REF:
-		/* Port 1 on these boards is always Gigabit */
-		if (ipd_port == 2) {
-			/* Port 2 is not hooked up */
-			result.u64 = 0;
-			return result;
-		} else {
-			/* Ports 0 and 1 connect to the switch */
-			result.s.link_up = 1;
-			result.s.full_duplex = 1;
-			result.s.speed = 1000;
-			return result;
-		}
-		break;
-	case CVMX_BOARD_TYPE_CUST_DSR1000N:
-		if (ipd_port == 0 || ipd_port == 1) {
-			/* Ports 0 and 1 connect to a switch (BCM53115). */
-			result.s.link_up = 1;
-			result.s.full_duplex = 1;
-			result.s.speed = 1000;
-			return result;
-		} else {
-			/* Port 2 uses a Broadcom PHY (B5081). */
-			is_broadcom_phy = 1;
-		}
-		break;
-	}
-
-	phy_addr = cvmx_helper_board_get_mii_address(ipd_port);
-	if (phy_addr != -1) {
-		if (is_broadcom_phy) {
-			/*
-			 * Below we are going to read SMI/MDIO
-			 * register 0x19 which works on Broadcom
-			 * parts
-			 */
-			int phy_status =
-			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
-					   0x19);
-			switch ((phy_status >> 8) & 0x7) {
-			case 0:
-				result.u64 = 0;
-				break;
-			case 1:
-				result.s.link_up = 1;
-				result.s.full_duplex = 0;
-				result.s.speed = 10;
-				break;
-			case 2:
-				result.s.link_up = 1;
-				result.s.full_duplex = 1;
-				result.s.speed = 10;
-				break;
-			case 3:
-				result.s.link_up = 1;
-				result.s.full_duplex = 0;
-				result.s.speed = 100;
-				break;
-			case 4:
-				result.s.link_up = 1;
-				result.s.full_duplex = 1;
-				result.s.speed = 100;
-				break;
-			case 5:
-				result.s.link_up = 1;
-				result.s.full_duplex = 1;
-				result.s.speed = 100;
-				break;
-			case 6:
-				result.s.link_up = 1;
-				result.s.full_duplex = 0;
-				result.s.speed = 1000;
-				break;
-			case 7:
-				result.s.link_up = 1;
-				result.s.full_duplex = 1;
-				result.s.speed = 1000;
-				break;
-			}
-		} else {
-			/*
-			 * This code assumes we are using a Marvell
-			 * Gigabit PHY. All the speed information can
-			 * be read from register 17 in one
-			 * go. Somebody using a different PHY will
-			 * need to handle it above in the board
-			 * specific area.
-			 */
-			int phy_status =
-			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff, 17);
-
-			/*
-			 * If the resolve bit 11 isn't set, see if
-			 * autoneg is turned off (bit 12, reg 0). The
-			 * resolve bit doesn't get set properly when
-			 * autoneg is off, so force it.
-			 */
-			if ((phy_status & (1 << 11)) == 0) {
-				int auto_status =
-				    cvmx_mdio_read(phy_addr >> 8,
-						   phy_addr & 0xff, 0);
-				if ((auto_status & (1 << 12)) == 0)
-					phy_status |= 1 << 11;
-			}
-
-			/*
-			 * Only return a link if the PHY has finished
-			 * auto negotiation and set the resolved bit
-			 * (bit 11)
-			 */
-			if (phy_status & (1 << 11)) {
-				result.s.link_up = 1;
-				result.s.full_duplex = ((phy_status >> 13) & 1);
-				switch ((phy_status >> 14) & 3) {
-				case 0: /* 10 Mbps */
-					result.s.speed = 10;
-					break;
-				case 1: /* 100 Mbps */
-					result.s.speed = 100;
-					break;
-				case 2: /* 1 Gbps */
-					result.s.speed = 1000;
-					break;
-				case 3: /* Illegal */
-					result.u64 = 0;
-					break;
-				}
-			}
-		}
-	} else if (OCTEON_IS_MODEL(OCTEON_CN3XXX)
-		   || OCTEON_IS_MODEL(OCTEON_CN58XX)
-		   || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
-		/*
-		 * We don't have a PHY address, so attempt to use
-		 * in-band status. It is really important that boards
-		 * not supporting in-band status never get
-		 * here. Reading broken in-band status tends to do bad
-		 * things
-		 */
-		union cvmx_gmxx_rxx_rx_inbnd inband_status;
-		int interface = cvmx_helper_get_interface_num(ipd_port);
-		int index = cvmx_helper_get_interface_index_num(ipd_port);
-		inband_status.u64 =
-		    cvmx_read_csr(CVMX_GMXX_RXX_RX_INBND(index, interface));
-
-		result.s.link_up = inband_status.s.status;
-		result.s.full_duplex = inband_status.s.duplex;
-		switch (inband_status.s.speed) {
-		case 0: /* 10 Mbps */
-			result.s.speed = 10;
-			break;
-		case 1: /* 100 Mbps */
-			result.s.speed = 100;
-			break;
-		case 2: /* 1 Gbps */
-			result.s.speed = 1000;
-			break;
-		case 3: /* Illegal */
-			result.u64 = 0;
-			break;
-		}
-	} else {
-		/*
-		 * We don't have a PHY address and we don't have
-		 * in-band status. There is no way to determine the
-		 * link speed. Return down assuming this port isn't
-		 * wired
-		 */
-		result.u64 = 0;
-	}
-
-	/* If link is down, return all fields as zero. */
-	if (!result.s.link_up)
-		result.u64 = 0;
-
-	return result;
-}
-
-/**
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
@@ -664,87 +234,6 @@ int __cvmx_helper_board_interface_probe(int interface, int supported_ports)
 }
 
 /**
- * Enable packet input/output from the hardware. This function is
- * called after by cvmx_helper_packet_hardware_enable() to
- * perform board specific initialization. For most boards
- * nothing is needed.
- *
- * @interface: Interface to enable
- *
- * Returns Zero on success, negative on failure
- */
-int __cvmx_helper_board_hardware_enable(int interface)
-{
-	if (cvmx_sysinfo_get()->board_type == CVMX_BOARD_TYPE_CN3005_EVB_HS5) {
-		if (interface == 0) {
-			/* Different config for switch port */
-			cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(1, interface), 0);
-			cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(1, interface), 0);
-			/*
-			 * Boards with gigabit WAN ports need a
-			 * different setting that is compatible with
-			 * 100 Mbit settings
-			 */
-			cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(0, interface),
-				       0xc);
-			cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(0, interface),
-				       0xc);
-		}
-	} else if (cvmx_sysinfo_get()->board_type ==
-		   CVMX_BOARD_TYPE_CN3010_EVB_HS5) {
-		/*
-		 * Broadcom PHYs require differnet ASX
-		 * clocks. Unfortunately many boards don't define a
-		 * new board Id and simply mangle the
-		 * CN3010_EVB_HS5
-		 */
-		if (interface == 0) {
-			/*
-			 * Some boards use a hacked up bootloader that
-			 * identifies them as CN3010_EVB_HS5
-			 * evaluation boards.  This leads to all kinds
-			 * of configuration problems.  Detect one
-			 * case, and print warning, while trying to do
-			 * the right thing.
-			 */
-			int phy_addr = cvmx_helper_board_get_mii_address(0);
-			if (phy_addr != -1) {
-				int phy_identifier =
-				    cvmx_mdio_read(phy_addr >> 8,
-						   phy_addr & 0xff, 0x2);
-				/* Is it a Broadcom PHY? */
-				if (phy_identifier == 0x0143) {
-					cvmx_dprintf("\n");
-					cvmx_dprintf("ERROR:\n");
-					cvmx_dprintf
-					    ("ERROR: Board type is CVMX_BOARD_TYPE_CN3010_EVB_HS5, but Broadcom PHY found.\n");
-					cvmx_dprintf
-					    ("ERROR: The board type is mis-configured, and software malfunctions are likely.\n");
-					cvmx_dprintf
-					    ("ERROR: All boards require a unique board type to identify them.\n");
-					cvmx_dprintf("ERROR:\n");
-					cvmx_dprintf("\n");
-					cvmx_wait(1000000000);
-					cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX
-						       (0, interface), 5);
-					cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX
-						       (0, interface), 5);
-				}
-			}
-		}
-	} else if (cvmx_sysinfo_get()->board_type ==
-			CVMX_BOARD_TYPE_UBNT_E100) {
-		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(0, interface), 0);
-		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(0, interface), 0x10);
-		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(1, interface), 0);
-		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(1, interface), 0x10);
-		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(2, interface), 0);
-		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(2, interface), 0x10);
-	}
-	return 0;
-}
-
-/**
  * Get the clock type used for the USB block based on board type.
  * Used by the USB code for auto configuration of clock type.
  *
diff --git a/arch/mips/cavium-octeon/executive/cvmx-link.c b/arch/mips/cavium-octeon/executive/cvmx-link.c
new file mode 100644
index 0000000..626ec88
--- /dev/null
+++ b/arch/mips/cavium-octeon/executive/cvmx-link.c
@@ -0,0 +1,534 @@
+/*
+ * This file is based on code from OCTEON SDK by Cavium Networks.
+ *
+ * Copyright (c) 2003-2008 Cavium Networks
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ *
+ * Helper functions to abstract board specific data about
+ * network ports from the rest of the cvmx-helper files.
+ */
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-bootinfo.h>
+
+#include <asm/octeon/cvmx-config.h>
+
+#include <asm/octeon/cvmx-mdio.h>
+
+#include <asm/octeon/cvmx-helper.h>
+#include <asm/octeon/cvmx-helper-util.h>
+#include <asm/octeon/cvmx-helper-board.h>
+
+#include <asm/octeon/cvmx-gmxx-defs.h>
+#include <asm/octeon/cvmx-asxx-defs.h>
+
+/**
+ * cvmx_override_board_link_get(int ipd_port) is a function
+ * pointer. It is meant to allow customization of the process of
+ * talking to a PHY to determine link speed. It is called every
+ * time a PHY must be polled for link status. Users should set
+ * this pointer to a function before calling any cvmx-helper
+ * operations.
+ */
+cvmx_helper_link_info_t(*cvmx_override_board_link_get) (int ipd_port) =
+    NULL;
+
+/**
+ * This function is the board specific method of determining an
+ * ethernet ports link speed. Most Octeon boards have Marvell PHYs
+ * and are handled by the fall through case. This function must be
+ * updated for boards that don't have the normal Marvell PHYs.
+ *
+ * This function must be modified for every new Octeon board.
+ * Internally it uses switch statements based on the cvmx_sysinfo
+ * data to determine board types and revisions. It relies on the
+ * fact that every Octeon board receives a unique board type
+ * enumeration from the bootloader.
+ *
+ * @ipd_port: IPD input port associated with the port we want to get link
+ *		   status for.
+ *
+ * Returns The ports link status. If the link isn't fully resolved, this must
+ *	   return zero.
+ */
+cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port)
+{
+	cvmx_helper_link_info_t result;
+	int phy_addr;
+	int is_broadcom_phy = 0;
+
+	/* Give the user a chance to override the processing of this function */
+	if (cvmx_override_board_link_get)
+		return cvmx_override_board_link_get(ipd_port);
+
+	/* Unless we fix it later, all links are defaulted to down */
+	result.u64 = 0;
+
+	/*
+	 * This switch statement should handle all ports that either don't use
+	 * Marvell PHYS, or don't support in-band status.
+	 */
+	switch (cvmx_sysinfo_get()->board_type) {
+	case CVMX_BOARD_TYPE_SIM:
+		/* The simulator gives you a simulated 1Gbps full duplex link */
+		result.s.link_up = 1;
+		result.s.full_duplex = 1;
+		result.s.speed = 1000;
+		return result;
+	case CVMX_BOARD_TYPE_EBH3100:
+	case CVMX_BOARD_TYPE_CN3010_EVB_HS5:
+	case CVMX_BOARD_TYPE_CN3005_EVB_HS5:
+	case CVMX_BOARD_TYPE_CN3020_EVB_HS5:
+		/* Port 1 on these boards is always Gigabit */
+		if (ipd_port == 1) {
+			result.s.link_up = 1;
+			result.s.full_duplex = 1;
+			result.s.speed = 1000;
+			return result;
+		}
+		/* Fall through to the generic code below */
+		break;
+	case CVMX_BOARD_TYPE_CUST_NB5:
+		/* Port 1 on these boards is always Gigabit */
+		if (ipd_port == 1) {
+			result.s.link_up = 1;
+			result.s.full_duplex = 1;
+			result.s.speed = 1000;
+			return result;
+		} else		/* The other port uses a broadcom PHY */
+			is_broadcom_phy = 1;
+		break;
+	case CVMX_BOARD_TYPE_BBGW_REF:
+		/* Port 1 on these boards is always Gigabit */
+		if (ipd_port == 2) {
+			/* Port 2 is not hooked up */
+			result.u64 = 0;
+			return result;
+		} else {
+			/* Ports 0 and 1 connect to the switch */
+			result.s.link_up = 1;
+			result.s.full_duplex = 1;
+			result.s.speed = 1000;
+			return result;
+		}
+		break;
+	case CVMX_BOARD_TYPE_CUST_DSR1000N:
+		if (ipd_port == 0 || ipd_port == 1) {
+			/* Ports 0 and 1 connect to a switch (BCM53115). */
+			result.s.link_up = 1;
+			result.s.full_duplex = 1;
+			result.s.speed = 1000;
+			return result;
+		} else {
+			/* Port 2 uses a Broadcom PHY (B5081). */
+			is_broadcom_phy = 1;
+		}
+		break;
+	}
+
+	phy_addr = cvmx_helper_board_get_mii_address(ipd_port);
+	if (phy_addr != -1) {
+		if (is_broadcom_phy) {
+			/*
+			 * Below we are going to read SMI/MDIO
+			 * register 0x19 which works on Broadcom
+			 * parts
+			 */
+			int phy_status =
+			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+					   0x19);
+			switch ((phy_status >> 8) & 0x7) {
+			case 0:
+				result.u64 = 0;
+				break;
+			case 1:
+				result.s.link_up = 1;
+				result.s.full_duplex = 0;
+				result.s.speed = 10;
+				break;
+			case 2:
+				result.s.link_up = 1;
+				result.s.full_duplex = 1;
+				result.s.speed = 10;
+				break;
+			case 3:
+				result.s.link_up = 1;
+				result.s.full_duplex = 0;
+				result.s.speed = 100;
+				break;
+			case 4:
+				result.s.link_up = 1;
+				result.s.full_duplex = 1;
+				result.s.speed = 100;
+				break;
+			case 5:
+				result.s.link_up = 1;
+				result.s.full_duplex = 1;
+				result.s.speed = 100;
+				break;
+			case 6:
+				result.s.link_up = 1;
+				result.s.full_duplex = 0;
+				result.s.speed = 1000;
+				break;
+			case 7:
+				result.s.link_up = 1;
+				result.s.full_duplex = 1;
+				result.s.speed = 1000;
+				break;
+			}
+		} else {
+			/*
+			 * This code assumes we are using a Marvell
+			 * Gigabit PHY. All the speed information can
+			 * be read from register 17 in one
+			 * go. Somebody using a different PHY will
+			 * need to handle it above in the board
+			 * specific area.
+			 */
+			int phy_status =
+			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff, 17);
+
+			/*
+			 * If the resolve bit 11 isn't set, see if
+			 * autoneg is turned off (bit 12, reg 0). The
+			 * resolve bit doesn't get set properly when
+			 * autoneg is off, so force it.
+			 */
+			if ((phy_status & (1 << 11)) == 0) {
+				int auto_status =
+				    cvmx_mdio_read(phy_addr >> 8,
+						   phy_addr & 0xff, 0);
+				if ((auto_status & (1 << 12)) == 0)
+					phy_status |= 1 << 11;
+			}
+
+			/*
+			 * Only return a link if the PHY has finished
+			 * auto negotiation and set the resolved bit
+			 * (bit 11)
+			 */
+			if (phy_status & (1 << 11)) {
+				result.s.link_up = 1;
+				result.s.full_duplex = ((phy_status >> 13) & 1);
+				switch ((phy_status >> 14) & 3) {
+				case 0: /* 10 Mbps */
+					result.s.speed = 10;
+					break;
+				case 1: /* 100 Mbps */
+					result.s.speed = 100;
+					break;
+				case 2: /* 1 Gbps */
+					result.s.speed = 1000;
+					break;
+				case 3: /* Illegal */
+					result.u64 = 0;
+					break;
+				}
+			}
+		}
+	} else if (OCTEON_IS_MODEL(OCTEON_CN3XXX)
+		   || OCTEON_IS_MODEL(OCTEON_CN58XX)
+		   || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+		/*
+		 * We don't have a PHY address, so attempt to use
+		 * in-band status. It is really important that boards
+		 * not supporting in-band status never get
+		 * here. Reading broken in-band status tends to do bad
+		 * things
+		 */
+		union cvmx_gmxx_rxx_rx_inbnd inband_status;
+		int interface = cvmx_helper_get_interface_num(ipd_port);
+		int index = cvmx_helper_get_interface_index_num(ipd_port);
+		inband_status.u64 =
+		    cvmx_read_csr(CVMX_GMXX_RXX_RX_INBND(index, interface));
+
+		result.s.link_up = inband_status.s.status;
+		result.s.full_duplex = inband_status.s.duplex;
+		switch (inband_status.s.speed) {
+		case 0: /* 10 Mbps */
+			result.s.speed = 10;
+			break;
+		case 1: /* 100 Mbps */
+			result.s.speed = 100;
+			break;
+		case 2: /* 1 Gbps */
+			result.s.speed = 1000;
+			break;
+		case 3: /* Illegal */
+			result.u64 = 0;
+			break;
+		}
+	} else {
+		/*
+		 * We don't have a PHY address and we don't have
+		 * in-band status. There is no way to determine the
+		 * link speed. Return down assuming this port isn't
+		 * wired
+		 */
+		result.u64 = 0;
+	}
+
+	/* If link is down, return all fields as zero. */
+	if (!result.s.link_up)
+		result.u64 = 0;
+
+	return result;
+}
+
+/**
+ * This function as a board specific method of changing the PHY
+ * speed, duplex, and auto-negotiation. This programs the PHY and
+ * not Octeon. This can be used to force Octeon's links to
+ * specific settings.
+ *
+ * @phy_addr:  The address of the PHY to program
+ * @enable_autoneg:
+ *		    Non zero if you want to enable auto-negotiation.
+ * @link_info: Link speed to program. If the speed is zero and auto-negotiation
+ *		    is enabled, all possible negotiation speeds are advertised.
+ *
+ * Returns Zero on success, negative on failure
+ */
+int cvmx_helper_board_link_set_phy(int phy_addr,
+				   cvmx_helper_board_set_phy_link_flags_types_t
+				   link_flags,
+				   cvmx_helper_link_info_t link_info)
+{
+
+	/* Set the flow control settings based on link_flags */
+	if ((link_flags & set_phy_link_flags_flow_control_mask) !=
+	    set_phy_link_flags_flow_control_dont_touch) {
+		cvmx_mdio_phy_reg_autoneg_adver_t reg_autoneg_adver;
+		reg_autoneg_adver.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_AUTONEG_ADVER);
+		reg_autoneg_adver.s.asymmetric_pause =
+		    (link_flags & set_phy_link_flags_flow_control_mask) ==
+		    set_phy_link_flags_flow_control_enable;
+		reg_autoneg_adver.s.pause =
+		    (link_flags & set_phy_link_flags_flow_control_mask) ==
+		    set_phy_link_flags_flow_control_enable;
+		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+				CVMX_MDIO_PHY_REG_AUTONEG_ADVER,
+				reg_autoneg_adver.u16);
+	}
+
+	/* If speed isn't set and autoneg is on advertise all supported modes */
+	if ((link_flags & set_phy_link_flags_autoneg)
+	    && (link_info.s.speed == 0)) {
+		cvmx_mdio_phy_reg_control_t reg_control;
+		cvmx_mdio_phy_reg_status_t reg_status;
+		cvmx_mdio_phy_reg_autoneg_adver_t reg_autoneg_adver;
+		cvmx_mdio_phy_reg_extended_status_t reg_extended_status;
+		cvmx_mdio_phy_reg_control_1000_t reg_control_1000;
+
+		reg_status.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_STATUS);
+		reg_autoneg_adver.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_AUTONEG_ADVER);
+		reg_autoneg_adver.s.advert_100base_t4 =
+		    reg_status.s.capable_100base_t4;
+		reg_autoneg_adver.s.advert_10base_tx_full =
+		    reg_status.s.capable_10_full;
+		reg_autoneg_adver.s.advert_10base_tx_half =
+		    reg_status.s.capable_10_half;
+		reg_autoneg_adver.s.advert_100base_tx_full =
+		    reg_status.s.capable_100base_x_full;
+		reg_autoneg_adver.s.advert_100base_tx_half =
+		    reg_status.s.capable_100base_x_half;
+		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+				CVMX_MDIO_PHY_REG_AUTONEG_ADVER,
+				reg_autoneg_adver.u16);
+		if (reg_status.s.capable_extended_status) {
+			reg_extended_status.u16 =
+			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+					   CVMX_MDIO_PHY_REG_EXTENDED_STATUS);
+			reg_control_1000.u16 =
+			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+					   CVMX_MDIO_PHY_REG_CONTROL_1000);
+			reg_control_1000.s.advert_1000base_t_full =
+			    reg_extended_status.s.capable_1000base_t_full;
+			reg_control_1000.s.advert_1000base_t_half =
+			    reg_extended_status.s.capable_1000base_t_half;
+			cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+					CVMX_MDIO_PHY_REG_CONTROL_1000,
+					reg_control_1000.u16);
+		}
+		reg_control.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_CONTROL);
+		reg_control.s.autoneg_enable = 1;
+		reg_control.s.restart_autoneg = 1;
+		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+				CVMX_MDIO_PHY_REG_CONTROL, reg_control.u16);
+	} else if ((link_flags & set_phy_link_flags_autoneg)) {
+		cvmx_mdio_phy_reg_control_t reg_control;
+		cvmx_mdio_phy_reg_status_t reg_status;
+		cvmx_mdio_phy_reg_autoneg_adver_t reg_autoneg_adver;
+		cvmx_mdio_phy_reg_control_1000_t reg_control_1000;
+
+		reg_status.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_STATUS);
+		reg_autoneg_adver.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_AUTONEG_ADVER);
+		reg_autoneg_adver.s.advert_100base_t4 = 0;
+		reg_autoneg_adver.s.advert_10base_tx_full = 0;
+		reg_autoneg_adver.s.advert_10base_tx_half = 0;
+		reg_autoneg_adver.s.advert_100base_tx_full = 0;
+		reg_autoneg_adver.s.advert_100base_tx_half = 0;
+		if (reg_status.s.capable_extended_status) {
+			reg_control_1000.u16 =
+			    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+					   CVMX_MDIO_PHY_REG_CONTROL_1000);
+			reg_control_1000.s.advert_1000base_t_full = 0;
+			reg_control_1000.s.advert_1000base_t_half = 0;
+		}
+		switch (link_info.s.speed) {
+		case 10:
+			reg_autoneg_adver.s.advert_10base_tx_full =
+			    link_info.s.full_duplex;
+			reg_autoneg_adver.s.advert_10base_tx_half =
+			    !link_info.s.full_duplex;
+			break;
+		case 100:
+			reg_autoneg_adver.s.advert_100base_tx_full =
+			    link_info.s.full_duplex;
+			reg_autoneg_adver.s.advert_100base_tx_half =
+			    !link_info.s.full_duplex;
+			break;
+		case 1000:
+			reg_control_1000.s.advert_1000base_t_full =
+			    link_info.s.full_duplex;
+			reg_control_1000.s.advert_1000base_t_half =
+			    !link_info.s.full_duplex;
+			break;
+		}
+		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+				CVMX_MDIO_PHY_REG_AUTONEG_ADVER,
+				reg_autoneg_adver.u16);
+		if (reg_status.s.capable_extended_status)
+			cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+					CVMX_MDIO_PHY_REG_CONTROL_1000,
+					reg_control_1000.u16);
+		reg_control.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_CONTROL);
+		reg_control.s.autoneg_enable = 1;
+		reg_control.s.restart_autoneg = 1;
+		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+				CVMX_MDIO_PHY_REG_CONTROL, reg_control.u16);
+	} else {
+		cvmx_mdio_phy_reg_control_t reg_control;
+		reg_control.u16 =
+		    cvmx_mdio_read(phy_addr >> 8, phy_addr & 0xff,
+				   CVMX_MDIO_PHY_REG_CONTROL);
+		reg_control.s.autoneg_enable = 0;
+		reg_control.s.restart_autoneg = 1;
+		reg_control.s.duplex = link_info.s.full_duplex;
+		if (link_info.s.speed == 1000) {
+			reg_control.s.speed_msb = 1;
+			reg_control.s.speed_lsb = 0;
+		} else if (link_info.s.speed == 100) {
+			reg_control.s.speed_msb = 0;
+			reg_control.s.speed_lsb = 1;
+		} else if (link_info.s.speed == 10) {
+			reg_control.s.speed_msb = 0;
+			reg_control.s.speed_lsb = 0;
+		}
+		cvmx_mdio_write(phy_addr >> 8, phy_addr & 0xff,
+				CVMX_MDIO_PHY_REG_CONTROL, reg_control.u16);
+	}
+	return 0;
+}
+
+/**
+ * Enable packet input/output from the hardware. This function is
+ * called after by cvmx_helper_packet_hardware_enable() to
+ * perform board specific initialization. For most boards
+ * nothing is needed.
+ *
+ * @interface: Interface to enable
+ *
+ * Returns Zero on success, negative on failure
+ */
+int __cvmx_helper_board_hardware_enable(int interface)
+{
+	if (cvmx_sysinfo_get()->board_type == CVMX_BOARD_TYPE_CN3005_EVB_HS5) {
+		if (interface == 0) {
+			/* Different config for switch port */
+			cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(1, interface), 0);
+			cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(1, interface), 0);
+			/*
+			 * Boards with gigabit WAN ports need a
+			 * different setting that is compatible with
+			 * 100 Mbit settings
+			 */
+			cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(0, interface),
+				       0xc);
+			cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(0, interface),
+				       0xc);
+		}
+	} else if (cvmx_sysinfo_get()->board_type ==
+		   CVMX_BOARD_TYPE_CN3010_EVB_HS5) {
+		/*
+		 * Broadcom PHYs require differnet ASX
+		 * clocks. Unfortunately many boards don't define a
+		 * new board Id and simply mangle the
+		 * CN3010_EVB_HS5
+		 */
+		if (interface == 0) {
+			/*
+			 * Some boards use a hacked up bootloader that
+			 * identifies them as CN3010_EVB_HS5
+			 * evaluation boards.  This leads to all kinds
+			 * of configuration problems.  Detect one
+			 * case, and print warning, while trying to do
+			 * the right thing.
+			 */
+			int phy_addr = cvmx_helper_board_get_mii_address(0);
+			if (phy_addr != -1) {
+				int phy_identifier =
+				    cvmx_mdio_read(phy_addr >> 8,
+						   phy_addr & 0xff, 0x2);
+				/* Is it a Broadcom PHY? */
+				if (phy_identifier == 0x0143) {
+					cvmx_dprintf("\n");
+					cvmx_dprintf("ERROR:\n");
+					cvmx_dprintf
+					    ("ERROR: Board type is CVMX_BOARD_TYPE_CN3010_EVB_HS5, but Broadcom PHY found.\n");
+					cvmx_dprintf
+					    ("ERROR: The board type is mis-configured, and software malfunctions are likely.\n");
+					cvmx_dprintf
+					    ("ERROR: All boards require a unique board type to identify them.\n");
+					cvmx_dprintf("ERROR:\n");
+					cvmx_dprintf("\n");
+					cvmx_wait(1000000000);
+					cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX
+						       (0, interface), 5);
+					cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX
+						       (0, interface), 5);
+				}
+			}
+		}
+	} else if (cvmx_sysinfo_get()->board_type ==
+			CVMX_BOARD_TYPE_UBNT_E100) {
+		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(0, interface), 0);
+		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(0, interface), 0x10);
+		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(1, interface), 0);
+		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(1, interface), 0x10);
+		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(2, interface), 0);
+		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(2, interface), 0x10);
+	}
+	return 0;
+}
-- 
2.3.3
