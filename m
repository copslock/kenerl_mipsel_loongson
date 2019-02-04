Return-Path: <SRS0=rTdo=QL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE3FC282C4
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 22:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B7620821
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 22:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfBDWl5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:41:57 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:60582 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfBDWl5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 4 Feb 2019 17:41:57 -0500
Received: from localhost.localdomain (85-76-69-76-nat.elisa-mobile.fi [85.76.69.76])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 6BB29300B3;
        Tue,  5 Feb 2019 00:41:55 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/5] MIPS: OCTEON: don't lie about interface type of CN3005 board
Date:   Tue,  5 Feb 2019 00:41:47 +0200
Message-Id: <20190204224149.8139-4-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190204224149.8139-1-aaro.koskinen@iki.fi>
References: <20190204224149.8139-1-aaro.koskinen@iki.fi>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The fixed-link node in the DT should now take care of the link status,
so this hack can be deleted.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-helper.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index b695d134b60f..151fd440a4b4 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -317,22 +317,6 @@ cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int interface)
 			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
 	}
 
-	if (interface == 0
-	    && cvmx_sysinfo_get()->board_type == CVMX_BOARD_TYPE_CN3005_EVB_HS5
-	    && cvmx_sysinfo_get()->board_rev_major == 1) {
-		/*
-		 * Lie about interface type of CN3005 board.  This
-		 * board has a switch on port 1 like the other
-		 * evaluation boards, but it is connected over RGMII
-		 * instead of GMII.  Report GMII mode so that the
-		 * speed is forced to 1 Gbit full duplex.  Other than
-		 * some initial configuration (which does not use the
-		 * output of this function) there is no difference in
-		 * setup between GMII and RGMII modes.
-		 */
-		return CVMX_HELPER_INTERFACE_MODE_GMII;
-	}
-
 	/* Interface 1 is always disabled on CN31XX and CN30XX */
 	if ((interface == 1)
 	    && (OCTEON_IS_MODEL(OCTEON_CN31XX) || OCTEON_IS_MODEL(OCTEON_CN30XX)
-- 
2.17.0

