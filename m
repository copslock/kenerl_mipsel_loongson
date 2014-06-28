Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 22:35:31 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:45160 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859961AbaF1UeeB5sX- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jun 2014 22:34:34 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 1577256F87D;
        Sat, 28 Jun 2014 23:34:32 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id ZwiLNRZE6X8w; Sat, 28 Jun 2014 23:34:25 +0300 (EEST)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 794CD5BC012;
        Sat, 28 Jun 2014 23:34:25 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/3] MIPS: OCTEON: add interface & port definitions for D-Link DSR-1000N
Date:   Sat, 28 Jun 2014 23:34:10 +0300
Message-Id: <1403987650-6194-4-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1403987650-6194-1-git-send-email-aaro.koskinen@iki.fi>
References: <1403987650-6194-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40909
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

Add interface & port definitions for D-Link DSR-1000N.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../cavium-octeon/executive/cvmx-helper-board.c     | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index 6c871a5..5dfef84 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -186,6 +186,15 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
 			return 7 - ipd_port;
 		else
 			return -1;
+	case CVMX_BOARD_TYPE_CUST_DSR1000N:
+		/*
+		 * Port 2 connects to Broadcom PHY (B5081). Other ports (0-1)
+		 * connect to a switch (BCM53115).
+		 */
+		if (ipd_port == 2)
+			return 8;
+		else
+			return -1;
 	}
 
 	/* Some unknown board. Somebody forgot to update this function... */
@@ -274,6 +283,18 @@ cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port)
 			return result;
 		}
 		break;
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
 	}
 
 	phy_addr = cvmx_helper_board_get_mii_address(ipd_port);
-- 
2.0.0
