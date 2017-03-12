Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Mar 2017 19:17:05 +0100 (CET)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:60801 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993948AbdCLSQyUqVIF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Mar 2017 19:16:54 +0100
Received: from hauke-desktop.lan (p20030086281B7F001E80E46CAF8E5409.dip0.t-ipconnect.de [IPv6:2003:86:281b:7f00:1e80:e46c:af8e:5409])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 3A47410026D;
        Sun, 12 Mar 2017 19:16:50 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, james.hogan@imgtec.com
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        "# 4 . 4 . x-" <stable@vger.kernel.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH] MIPS: Lantiq: fix missing xbar kernel panic
Date:   Sun, 12 Mar 2017 19:16:33 +0100
Message-Id: <20170312181633.23453-1-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57143
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

Commit 08b3c894e5 "MIPS: lantiq: Disable xbar fpi burst mode"
accidentally requested the resources from the pmu address region
instead of the xbar registers region, but the check for the returns
value of request_mem_region() was wrong. Commit 98ea51cb0c8 "MIPS:
Lantiq: Fix another request_mem_region() return code check" fixed the
check of the return value of request_mem_region() which made the kernel
panics.
This patch now makes use of the correct memory region for the cross bar.

Fixes: 08b3c894e5 ("MIPS: lantiq: Disable xbar fpi burst mode")
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
