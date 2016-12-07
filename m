Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2016 22:32:20 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:35360 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993419AbcLGVcNaScig (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Dec 2016 22:32:13 +0100
Received: from hauke-desktop.lan (p2003008628066E00E916589C70E71365.dip0.t-ipconnect.de [IPv6:2003:86:2806:6e00:e916:589c:70e7:1365])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 965CD1001D4;
        Wed,  7 Dec 2016 22:32:12 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     dan.carpenter@oracle.com, linux-mips@linux-mips.org,
        john@phrozen.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Thomas Langer <thomas.langer@intel.com>
Subject: [PATCH] MIPS: lantiq: fix mask of GPE frequency
Date:   Wed,  7 Dec 2016 22:32:00 +0100
Message-Id: <20161207213200.32611-1-hauke@hauke-m.de>
X-Mailer: git-send-email 2.10.2
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55966
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

The hardware documentation says bit 11:10 are used for the GPE
frequency selection. Fix the mask in the define to match these bits.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Thomas Langer <thomas.langer@intel.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/falcon/sysctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index 2a1b302..82bbd0e 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -24,7 +24,7 @@
 
 /* GPE frequency selection */
 #define GPPC_OFFSET		24
-#define GPEFREQ_MASK		0x00000C0
+#define GPEFREQ_MASK		0x0000C00
 #define GPEFREQ_OFFSET		10
 /* Clock status register */
 #define SYSCTL_CLKS		0x0000
-- 
2.10.2
