Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 21:17:26 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:45924 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994657AbeBQUOYgyhgG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 21:14:24 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 17 Feb 2018 20:14:15 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Sat, 17 Feb 2018
 12:09:36 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     <netdev@vger.kernel.org>
CC:     Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH v5 06/14] net: pch_gbe: Allow longer for resets
Date:   Sat, 17 Feb 2018 12:10:29 -0800
Message-ID: <20180217201037.3006-7-paul.burton@mips.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180217201037.3006-1-paul.burton@mips.com>
References: <20180217201037.3006-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1518898455-321458-310-63374-2
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190134
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Resets of the EG20T MAC on the MIPS Boston development board take longer
than the 1000 loops that pch_gbe_wait_clr_bit was performing. Rather
than simply increasing the number of loops, switch to using
readl_poll_timeout_atomic() from linux/iopoll.h in order to provide some
independence from the speed of the CPU.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org

---

Changes in v5:
- Bump up the timeout based on feedback from Marcin.

Changes in v4: None
Changes in v3:
- Switch to using readl_poll_timeout_atomic().

Changes in v2: None

 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 90e795d5cc1c..77f7fbd98e8f 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -24,6 +24,7 @@
 #include <linux/ptp_classify.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
+#include <linux/iopoll.h>
 #include <linux/of_gpio.h>
 
 #define DRV_VERSION     "1.01"
@@ -318,13 +319,11 @@ s32 pch_gbe_mac_read_mac_addr(struct pch_gbe_hw *hw)
  */
 static void pch_gbe_wait_clr_bit(void *reg, u32 bit)
 {
+	int err;
 	u32 tmp;
 
-	/* wait busy */
-	tmp = 1000;
-	while ((ioread32(reg) & bit) && --tmp)
-		cpu_relax();
-	if (!tmp)
+	err = readl_poll_timeout_atomic(reg, tmp, !(tmp & bit), 10, 25000);
+	if (err)
 		pr_err("Error: busy bit is not cleared\n");
 }
 
-- 
2.16.1
