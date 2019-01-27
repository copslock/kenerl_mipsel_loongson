Return-Path: <SRS0=LPLt=QD=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6999FC282CA
	for <linux-mips@archiver.kernel.org>; Sun, 27 Jan 2019 20:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373652087F
	for <linux-mips@archiver.kernel.org>; Sun, 27 Jan 2019 20:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfA0UZL (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:25:11 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:51724 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfA0UZL (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 27 Jan 2019 15:25:11 -0500
Received: from localhost.localdomain (85-76-101-7-nat.elisa-mobile.fi [85.76.101.7])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 6A47120103;
        Sun, 27 Jan 2019 22:25:09 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/2] MIPS: OCTEON: delete SMI/MDIO enable
Date:   Sun, 27 Jan 2019 22:24:30 +0200
Message-Id: <20190127202431.7107-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SMI/MDIO enable is handled by the OCTEON MDIO driver, so we can delete
the duplicated functionality from the platform code.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../cavium-octeon/executive/cvmx-helper.c     | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 38e0444e57e8..520c3bc66655 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -43,7 +43,6 @@
 #include <asm/octeon/cvmx-helper-board.h>
 
 #include <asm/octeon/cvmx-pip-defs.h>
-#include <asm/octeon/cvmx-smix-defs.h>
 #include <asm/octeon/cvmx-asxx-defs.h>
 
 /* Port count per interface */
@@ -1026,7 +1025,6 @@ int cvmx_helper_initialize_packet_io_global(void)
 	int result = 0;
 	int interface;
 	union cvmx_l2c_cfg l2c_cfg;
-	union cvmx_smix_en smix_en;
 	const int num_interfaces = cvmx_helper_get_number_of_interfaces();
 
 	/*
@@ -1046,24 +1044,6 @@ int cvmx_helper_initialize_packet_io_global(void)
 	l2c_cfg.s.rfb_arb_mode = 0;
 	cvmx_write_csr(CVMX_L2C_CFG, l2c_cfg.u64);
 
-	/* Make sure SMI/MDIO is enabled so we can query PHYs */
-	smix_en.u64 = cvmx_read_csr(CVMX_SMIX_EN(0));
-	if (!smix_en.s.en) {
-		smix_en.s.en = 1;
-		cvmx_write_csr(CVMX_SMIX_EN(0), smix_en.u64);
-	}
-
-	/* Newer chips actually have two SMI/MDIO interfaces */
-	if (!OCTEON_IS_MODEL(OCTEON_CN3XXX) &&
-	    !OCTEON_IS_MODEL(OCTEON_CN58XX) &&
-	    !OCTEON_IS_MODEL(OCTEON_CN50XX)) {
-		smix_en.u64 = cvmx_read_csr(CVMX_SMIX_EN(1));
-		if (!smix_en.s.en) {
-			smix_en.s.en = 1;
-			cvmx_write_csr(CVMX_SMIX_EN(1), smix_en.u64);
-		}
-	}
-
 	cvmx_pko_initialize_global();
 	for (interface = 0; interface < num_interfaces; interface++) {
 		result |= cvmx_helper_interface_probe(interface);
-- 
2.17.0

