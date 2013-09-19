Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2013 19:19:49 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:47918 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817546Ab3ISRTqpryxL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Sep 2013 19:19:46 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: mm: c-r4k: Panic if IL or DL fields have a reserved value
Date:   Thu, 19 Sep 2013 18:18:41 +0100
Message-ID: <1379611121-12977-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_09_19_18_19_38
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37890
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

According to MIPS32 and MIPS64 PRA documents,
a value of 7 in IL and DL fields is marked as "Reserved"
so panic if the core uses this value in the config1 register.
Also simplify the code a little bit.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/mm/c-r4k.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 73ca8c5..618994e 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -987,10 +987,14 @@ static void probe_pcache(void)
 		 */
 		config1 = read_c0_config1();
 
-		if ((lsize = ((config1 >> 19) & 7)))
-			c->icache.linesz = 2 << lsize;
-		else
-			c->icache.linesz = lsize;
+		lsize = (config1 >> 19) & 7;
+
+		/* IL == 7 is reserved */
+		if (lsize == 7)
+			panic("Invalid icache line size");
+
+		c->icache.linesz = lsize ? 2 << lsize : 0;
+
 		c->icache.sets = 32 << (((config1 >> 22) + 1) & 7);
 		c->icache.ways = 1 + ((config1 >> 16) & 7);
 
@@ -1007,10 +1011,14 @@ static void probe_pcache(void)
 		 */
 		c->dcache.flags = 0;
 
-		if ((lsize = ((config1 >> 10) & 7)))
-			c->dcache.linesz = 2 << lsize;
-		else
-			c->dcache.linesz= lsize;
+		lsize = (config1 >> 10) & 7;
+
+		/* DL == 7 is reserved */
+		if (lsize == 7)
+			panic("Invalid dcache line size");
+
+		c->dcache.linesz = lsize ? 2 << lsize : 0;
+
 		c->dcache.sets = 32 << (((config1 >> 13) + 1) & 7);
 		c->dcache.ways = 1 + ((config1 >> 7) & 7);
 
-- 
1.8.3.2
