Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 22:44:38 +0200 (CEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:42593 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992279AbcIAUoKUHZtN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 22:44:10 +0200
Received: from localhost.localdomain (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id C3C0D4191;
        Thu,  1 Sep 2016 23:44:09 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/6] MIPS: OCTEON: delete legacy hack for broken bootloaders
Date:   Thu,  1 Sep 2016 23:43:55 +0300
Message-Id: <20160901204400.16562-2-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160901204400.16562-1-aaro.koskinen@iki.fi>
References: <20160901204400.16562-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54955
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

Delete legacy hack for broken bootloaders. The warning has been in kernel
for several years, and if there are still users using such bootloaders,
they can fix the boot by supplying a proper DTB.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../cavium-octeon/executive/cvmx-helper-board.c    | 42 ----------------------
 1 file changed, 42 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index ff49fc0..3751c58 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -676,48 +676,6 @@ int __cvmx_helper_board_hardware_enable(int interface)
 				       0xc);
 		}
 	} else if (cvmx_sysinfo_get()->board_type ==
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
 			CVMX_BOARD_TYPE_UBNT_E100) {
 		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(0, interface), 0);
 		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(0, interface), 0x10);
-- 
2.9.2
