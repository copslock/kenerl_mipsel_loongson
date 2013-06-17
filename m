Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 16:02:19 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:32343 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835146Ab3FQOBc7Q21D (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jun 2013 16:01:32 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <sibyte-users@bitmover.com>
Subject: [PATCH 1/7] MIPS: sibyte: Fix build for SIBYTE_BW_TRACE
Date:   Mon, 17 Jun 2013 15:00:35 +0100
Message-ID: <1371477641-7989-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1371477641-7989-1-git-send-email-markos.chandras@imgtec.com>
References: <1371477641-7989-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_06_17_15_01_27
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The M_BCM1480_SCD_TRACE_CFG_FREEZE macro removed in
8deab1144b553548fb2f1b51affdd36dcd652aaa
"[MIPS] Updated Sibyte headers"

This broke the build for the sibyte platfrom when
SIBYTE_BW_TRACE is enabled:
arch/mips/mm/cerr-sb1.c:186:2: error: 'M_BCM1480_SCD_TRACE_CFG_FREEZE'
undeclared (first use in this function)

We fix this by replacing it with the M_BCM1480_SYS_RESERVED4 macro

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: sibyte-users@bitmover.com
---
 arch/mips/mm/cerr-sb1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/cerr-sb1.c b/arch/mips/mm/cerr-sb1.c
index 576add3..1a24534 100644
--- a/arch/mips/mm/cerr-sb1.c
+++ b/arch/mips/mm/cerr-sb1.c
@@ -183,7 +183,7 @@ asmlinkage void sb1_cache_error(void)
 #ifdef CONFIG_SIBYTE_BW_TRACE
 	/* Freeze the trace buffer now */
 #if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
-	csr_out32(M_BCM1480_SCD_TRACE_CFG_FREEZE, IOADDR(A_SCD_TRACE_CFG));
+	csr_out32(M_BCM1480_SYS_RESERVED4, IOADDR(A_SCD_TRACE_CFG));
 #else
 	csr_out32(M_SCD_TRACE_CFG_FREEZE, IOADDR(A_SCD_TRACE_CFG));
 #endif
-- 
1.8.2.1
