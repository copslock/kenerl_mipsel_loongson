Return-Path: <SRS0=rTdo=QL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58177C4151A
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 22:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AE920821
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 22:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfBDWl5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:41:57 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:60576 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfBDWl5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 4 Feb 2019 17:41:57 -0500
Received: from localhost.localdomain (85-76-69-76-nat.elisa-mobile.fi [85.76.69.76])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 540103008D;
        Tue,  5 Feb 2019 00:41:55 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/5] MIPS: OCTEON: warn if deprecated link status is being used
Date:   Tue,  5 Feb 2019 00:41:46 +0200
Message-Id: <20190204224149.8139-3-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190204224149.8139-1-aaro.koskinen@iki.fi>
References: <20190204224149.8139-1-aaro.koskinen@iki.fi>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Warn if deprecated link status is being used.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 4 ++++
 arch/mips/cavium-octeon/executive/cvmx-helper.c       | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index ab8362e04461..46ea54ea73ea 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -31,6 +31,7 @@
  * network ports from the rest of the cvmx-helper files.
  */
 
+#include <linux/bug.h>
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-bootinfo.h>
 
@@ -210,6 +211,9 @@ cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port)
 {
 	cvmx_helper_link_info_t result;
 
+	WARN(!octeon_is_simulation(),
+	     "Using deprecated link status - please update your DT");
+
 	/* Unless we fix it later, all links are defaulted to down */
 	result.u64 = 0;
 
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 520c3bc66655..b695d134b60f 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -30,6 +30,7 @@
  * Helper functions for common, but complicated tasks.
  *
  */
+#include <linux/bug.h>
 #include <asm/octeon/octeon.h>
 
 #include <asm/octeon/cvmx-config.h>
@@ -1116,6 +1117,7 @@ cvmx_helper_link_info_t cvmx_helper_link_get(int ipd_port)
 		if (index == 0)
 			result = __cvmx_helper_rgmii_link_get(ipd_port);
 		else {
+			WARN(1, "Using deprecated link status - please update your DT");
 			result.s.full_duplex = 1;
 			result.s.link_up = 1;
 			result.s.speed = 1000;
-- 
2.17.0

