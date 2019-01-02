Return-Path: <SRS0=tVBC=PK=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB90DC43387
	for <linux-mips@archiver.kernel.org>; Wed,  2 Jan 2019 18:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2D8218D3
	for <linux-mips@archiver.kernel.org>; Wed,  2 Jan 2019 18:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfABSnQ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:43:16 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:56172 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfABSnQ (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 2 Jan 2019 13:43:16 -0500
Received: from localhost.localdomain (85-76-81-227-nat.elisa-mobile.fi [85.76.81.227])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id E1066B0011;
        Wed,  2 Jan 2019 20:43:13 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: OCTEON: mark RGMII interface disabled on OCTEON III
Date:   Wed,  2 Jan 2019 20:43:01 +0200
Message-Id: <20190102184301.4222-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Commit 885872b722b7 ("MIPS: Octeon: Add Octeon III CN7xxx
interface detection") added RGMII interface detection for OCTEON III,
but it results in the following logs:

[    7.165984] ERROR: Unsupported Octeon model in __cvmx_helper_rgmii_probe
[    7.173017] ERROR: Unsupported Octeon model in __cvmx_helper_rgmii_probe

The current RGMII routines are valid only for older OCTEONS that
use GMX/ASX hardware blocks. On later chips AGL should be used,
but support for that is missing in the mainline. Until that is added,
mark the interface as disabled.

Fixes: 885872b722b7 ("MIPS: Octeon: Add Octeon III CN7xxx interface detection")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index a76bbcc30f95..38e0444e57e8 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -266,7 +266,8 @@ static cvmx_helper_interface_mode_t __cvmx_get_mode_cn7xxx(int interface)
 	case 3:
 		return CVMX_HELPER_INTERFACE_MODE_LOOP;
 	case 4:
-		return CVMX_HELPER_INTERFACE_MODE_RGMII;
+		/* TODO: Implement support for AGL (RGMII). */
+		return CVMX_HELPER_INTERFACE_MODE_DISABLED;
 	default:
 		return CVMX_HELPER_INTERFACE_MODE_DISABLED;
 	}
-- 
2.17.0

