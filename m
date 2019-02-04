Return-Path: <SRS0=rTdo=QL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F63C282D7
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 22:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FC320821
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 22:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfBDWl6 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:41:58 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:60586 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfBDWl5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 4 Feb 2019 17:41:57 -0500
Received: from localhost.localdomain (85-76-69-76-nat.elisa-mobile.fi [85.76.69.76])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 8517D300B7;
        Tue,  5 Feb 2019 00:41:55 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 4/5] MIPS: OCTEON: delete board-specific link status
Date:   Tue,  5 Feb 2019 00:41:48 +0200
Message-Id: <20190204224149.8139-5-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190204224149.8139-1-aaro.koskinen@iki.fi>
References: <20190204224149.8139-1-aaro.koskinen@iki.fi>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Delete board-specific link status. This info should now come from
the DT only.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../executive/cvmx-helper-board.c             | 43 +------------------
 1 file changed, 1 insertion(+), 42 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index 46ea54ea73ea..634eae578ffe 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -217,53 +217,12 @@ cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port)
 	/* Unless we fix it later, all links are defaulted to down */
 	result.u64 = 0;
 
-	/*
-	 * This switch statement should handle all ports that either don't use
-	 * Marvell PHYS, or don't support in-band status.
-	 */
-	switch (cvmx_sysinfo_get()->board_type) {
-	case CVMX_BOARD_TYPE_SIM:
+	if (octeon_is_simulation()) {
 		/* The simulator gives you a simulated 1Gbps full duplex link */
 		result.s.link_up = 1;
 		result.s.full_duplex = 1;
 		result.s.speed = 1000;
 		return result;
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
-		}
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
 	}
 
 	if (OCTEON_IS_MODEL(OCTEON_CN3XXX)
-- 
2.17.0

