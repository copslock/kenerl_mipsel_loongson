Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 22:46:38 +0200 (CEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:52234 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992127AbcIBUogmMk0g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 22:44:36 +0200
Received: from localhost.localdomain (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id E95F723419D;
        Fri,  2 Sep 2016 23:44:35 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 5/6] MIPS: OCTEON: delete legacy code for PHY access
Date:   Fri,  2 Sep 2016 23:44:20 +0300
Message-Id: <20160902204421.8265-6-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160902204421.8265-1-aaro.koskinen@iki.fi>
References: <20160902204421.8265-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55024
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

PHY access through the board helper is impossible with the
current drivers, so delete this code.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../cavium-octeon/executive/cvmx-helper-board.c    | 108 +--------------------
 1 file changed, 2 insertions(+), 106 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index 5572e39..bc37266 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -211,8 +211,6 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
 cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port)
 {
 	cvmx_helper_link_info_t result;
-	int phy_addr;
-	int is_broadcom_phy = 0;
 
 	/* Unless we fix it later, all links are defaulted to down */
 	result.u64 = 0;
@@ -248,8 +246,7 @@ cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port)
 			result.s.full_duplex = 1;
 			result.s.speed = 1000;
 			return result;
-		} else		/* The other port uses a broadcom PHY */
-			is_broadcom_phy = 1;
+		}
 		break;
 	case CVMX_BOARD_TYPE_BBGW_REF:
 		/* Port 1 on these boards is always Gigabit */
@@ -267,108 +264,7 @@ cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port)
 		break;
 	}
 
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
+	if (OCTEON_IS_MODEL(OCTEON_CN3XXX)
 		   || OCTEON_IS_MODEL(OCTEON_CN58XX)
 		   || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
 		/*
-- 
2.9.2
