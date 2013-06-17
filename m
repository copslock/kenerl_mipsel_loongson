Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 16:02:42 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:32336 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835155Ab3FQOBdCsHPf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jun 2013 16:01:33 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <sibyte-users@bitmover.com>
Subject: [PATCH 7/7] MIPS: sibyte: Remove unused variable.
Date:   Mon, 17 Jun 2013 15:00:41 +0100
Message-ID: <1371477641-7989-8-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 36948
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

Fixes the following build problem:

arch/mips/sibyte/sb1250/bus_watcher.c: In function 'sibyte_bw_int':
arch/mips/sibyte/sb1250/bus_watcher.c:179:7: error: unused variable 'bw_buf'
[-Werror=unused-variable]

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: sibyte-users@bitmover.com
---
 arch/mips/sibyte/sb1250/bus_watcher.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/sibyte/sb1250/bus_watcher.c b/arch/mips/sibyte/sb1250/bus_watcher.c
index 8871e33..d0ca7b9 100644
--- a/arch/mips/sibyte/sb1250/bus_watcher.c
+++ b/arch/mips/sibyte/sb1250/bus_watcher.c
@@ -175,9 +175,6 @@ static irqreturn_t sibyte_bw_int(int irq, void *data)
 #ifdef CONFIG_SIBYTE_BW_TRACE
 	int i;
 #endif
-#ifndef CONFIG_PROC_FS
-	char bw_buf[1024];
-#endif
 
 #ifdef CONFIG_SIBYTE_BW_TRACE
 	csr_out32(M_SCD_TRACE_CFG_FREEZE, IOADDR(A_SCD_TRACE_CFG));
-- 
1.8.2.1
