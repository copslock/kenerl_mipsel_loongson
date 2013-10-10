Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Oct 2013 10:59:18 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:37189 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822451Ab3JJI7M4SIwl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Oct 2013 10:59:12 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2] MIPS: Add printing of ES bit for Imgtec cores when cache error occurs.
Date:   Thu, 10 Oct 2013 09:58:59 +0100
Message-ID: <1381395539-30063-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_10_09_59_07
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38298
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

The cacheer register is always implemented in the same way in the
MIPS32r2 Imgtec cores so print the ES bit when an cache error
occurs.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/traps.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 524841f..2a5523e 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1416,14 +1416,27 @@ asmlinkage void cache_parity_error(void)
 	printk("Decoded c0_cacheerr: %s cache fault in %s reference.\n",
 	       reg_val & (1<<30) ? "secondary" : "primary",
 	       reg_val & (1<<31) ? "data" : "insn");
-	printk("Error bits: %s%s%s%s%s%s%s\n",
-	       reg_val & (1<<29) ? "ED " : "",
-	       reg_val & (1<<28) ? "ET " : "",
-	       reg_val & (1<<26) ? "EE " : "",
-	       reg_val & (1<<25) ? "EB " : "",
-	       reg_val & (1<<24) ? "EI " : "",
-	       reg_val & (1<<23) ? "E1 " : "",
-	       reg_val & (1<<22) ? "E0 " : "");
+	if (cpu_has_mips_r2 &&
+	    ((current_cpu_data.processor_id && 0xff0000) == PRID_COMP_MIPS)) {
+		pr_err("Error bits: %s%s%s%s%s%s%s%s\n",
+			reg_val & (1<<29) ? "ED " : "",
+			reg_val & (1<<28) ? "ET " : "",
+			reg_val & (1<<27) ? "ES " : "",
+			reg_val & (1<<26) ? "EE " : "",
+			reg_val & (1<<25) ? "EB " : "",
+			reg_val & (1<<24) ? "EI " : "",
+			reg_val & (1<<23) ? "E1 " : "",
+			reg_val & (1<<22) ? "E0 " : "");
+	} else {
+		pr_err("Error bits: %s%s%s%s%s%s%s\n",
+			reg_val & (1<<29) ? "ED " : "",
+			reg_val & (1<<28) ? "ET " : "",
+			reg_val & (1<<26) ? "EE " : "",
+			reg_val & (1<<25) ? "EB " : "",
+			reg_val & (1<<24) ? "EI " : "",
+			reg_val & (1<<23) ? "E1 " : "",
+			reg_val & (1<<22) ? "E0 " : "");
+	}
 	printk("IDX: 0x%08x\n", reg_val & ((1<<22)-1));
 
 #if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
-- 
1.8.3.2
