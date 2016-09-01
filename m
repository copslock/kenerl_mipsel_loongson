Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 22:45:31 +0200 (CEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:42599 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992298AbcIAUoLEvBkN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 22:44:11 +0200
Received: from localhost.localdomain (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 8931D433B;
        Thu,  1 Sep 2016 23:44:10 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/6] MIPS: OCTEON: delete cvmx_override_board_link_get
Date:   Thu,  1 Sep 2016 23:43:57 +0300
Message-Id: <20160901204400.16562-4-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160901204400.16562-1-aaro.koskinen@iki.fi>
References: <20160901204400.16562-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54957
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

Delete unused cvmx_override_board_link_get.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 15 ---------------
 arch/mips/include/asm/octeon/cvmx-helper-board.h      | 10 ----------
 2 files changed, 25 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index 3751c58..0deeb82 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -46,17 +46,6 @@
 #include <asm/octeon/cvmx-asxx-defs.h>
 
 /**
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
-/**
  * Return the MII PHY address associated with the given IPD
  * port. A result of -1 means there isn't a MII capable PHY
  * connected to this port. On chips supporting multiple MII
@@ -225,10 +214,6 @@ cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port)
 	int phy_addr;
 	int is_broadcom_phy = 0;
 
-	/* Give the user a chance to override the processing of this function */
-	if (cvmx_override_board_link_get)
-		return cvmx_override_board_link_get(ipd_port);
-
 	/* Unless we fix it later, all links are defaulted to down */
 	result.u64 = 0;
 
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-board.h b/arch/mips/include/asm/octeon/cvmx-helper-board.h
index cda93ae..271be7a 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-board.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-board.h
@@ -58,16 +58,6 @@ typedef enum {
 #define CVMX_HELPER_BOARD_MGMT_IPD_PORT	    -10
 
 /**
- * cvmx_override_board_link_get(int ipd_port) is a function
- * pointer. It is meant to allow customization of the process of
- * talking to a PHY to determine link speed. It is called every
- * time a PHY must be polled for link status. Users should set
- * this pointer to a function before calling any cvmx-helper
- * operations.
- */
-extern cvmx_helper_link_info_t(*cvmx_override_board_link_get) (int ipd_port);
-
-/**
  * Return the MII PHY address associated with the given IPD
  * port. A result of -1 means there isn't a MII capable PHY
  * connected to this port. On chips supporting multiple MII
-- 
2.9.2
