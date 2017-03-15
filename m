Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 23:27:03 +0100 (CET)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:35665 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992100AbdCOW04oO-IK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 23:26:56 +0100
Received: from hauke-desktop.lan (p2003008628074C0054E36B5BED5002D6.dip0.t-ipconnect.de [IPv6:2003:86:2807:4c00:54e3:6b5b:ed50:2d6])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 51D8410026B;
        Wed, 15 Mar 2017 23:26:53 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, james.hogan@imgtec.com
Cc:     arnd@arndb.de, sergei.shtylyov@cogentembedded.com,
        john@phrozen.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "# 4 . 4 . x-" <stable@vger.kernel.org>
Subject: [PATCH v2] MIPS: Lantiq: fix missing xbar kernel panic
Date:   Wed, 15 Mar 2017 23:26:42 +0100
Message-Id: <20170315222642.5446-1-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

Commit 08b3c894e565 ("MIPS: lantiq: Disable xbar fpi burst mode")
accidentally requested the resources from the pmu address region
instead of the xbar registers region, but the check for the return
value of request_mem_region() was wrong. Commit 98ea51cb0c8c ("MIPS:
Lantiq: Fix another request_mem_region() return code check") fixed the
check of the return value of request_mem_region() which made the kernel
panics.
This patch now makes use of the correct memory region for the cross bar.

Fixes: 08b3c894e565 ("MIPS: lantiq: Disable xbar fpi burst mode")
Cc: <stable@vger.kernel.org> # 4.4.x-
Cc: John Crispin <john@phrozen.org>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/xway/sysctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 3c3aa05891dd..95bec460b651 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -467,7 +467,7 @@ void __init ltq_soc_init(void)
 
 		if (!np_xbar)
 			panic("Failed to load xbar nodes from devicetree");
-		if (of_address_to_resource(np_pmu, 0, &res_xbar))
+		if (of_address_to_resource(np_xbar, 0, &res_xbar))
 			panic("Failed to get xbar resources");
 		if (!request_mem_region(res_xbar.start, resource_size(&res_xbar),
 			res_xbar.name))
-- 
2.11.0
