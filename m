Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 11:35:49 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:55074 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816841Ab3IZJfrAeEof (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Sep 2013 11:35:47 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: kernel: traps: Remove useless BUG_ON()
Date:   Thu, 26 Sep 2013 10:35:31 +0100
Message-ID: <1380188131-28792-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_09_26_10_35_38
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37980
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

Checking for n<0 && n>9 makes no sense because it can never
be true. Moreover, we can have up to 64 vectored interrupts
so BUG_ON(n>9) was wrong anyway.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/kernel/traps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 524841f..f2ae9cb 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1554,7 +1554,6 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 	unsigned char *b;
 
 	BUG_ON(!cpu_has_veic && !cpu_has_vint);
-	BUG_ON((n < 0) && (n > 9));
 
 	if (addr == NULL) {
 		handler = (unsigned long) do_default_vi;
-- 
1.8.3.2
