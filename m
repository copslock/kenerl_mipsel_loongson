Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 11:25:48 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:31388 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868725Ab3JGJZpzM08L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Oct 2013 11:25:45 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: [PATCH] MIPS: Add printing of ES bit when cache error occurs.
Date:   Mon, 7 Oct 2013 10:25:52 +0100
Message-ID: <1381137952-18340-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_07_10_25_40
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38215
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

Print out the source of request that caused the error (ES bit) when
a cache error exception occurs.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Acked-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/traps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 08aae2a..840bfcb 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1421,9 +1421,10 @@ asmlinkage void cache_parity_error(void)
 	printk("Decoded c0_cacheerr: %s cache fault in %s reference.\n",
 	       reg_val & (1<<30) ? "secondary" : "primary",
 	       reg_val & (1<<31) ? "data" : "insn");
-	printk("Error bits: %s%s%s%s%s%s%s\n",
+	printk("Error bits: %s%s%s%s%s%s%s%s\n",
 	       reg_val & (1<<29) ? "ED " : "",
 	       reg_val & (1<<28) ? "ET " : "",
+	       reg_val & (1<<27) ? "ES " : "",
 	       reg_val & (1<<26) ? "EE " : "",
 	       reg_val & (1<<25) ? "EB " : "",
 	       reg_val & (1<<24) ? "EI " : "",
-- 
1.8.3.2
