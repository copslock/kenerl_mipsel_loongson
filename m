Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 10:38:16 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:14597 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867712Ab3I3IiCPg4u6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Sep 2013 10:38:02 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: bcm63xx: cpu: Replace BUG() with panic()
Date:   Mon, 30 Sep 2013 09:38:00 +0100
Message-ID: <1380530280-6467-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_09_30_09_37_55
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38060
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

BUG() can be a noop if CONFIG_BUG is not selected,
leading to the following build problem on a randconfig:

arch/mips/bcm63xx/cpu.c: In function 'detect_cpu_clock':
arch/mips/bcm63xx/cpu.c:254:1: error: control reaches end of
non-void function [-Werror=return-type]

We fix this problem by replacing BUG() with panic() since it's
best to handle the case of an unknown board instead of silently
returning a random clock frequency.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/bcm63xx/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index b713cd6..88c57cc 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -123,7 +123,9 @@ unsigned int bcm63xx_get_memory_size(void)
 
 static unsigned int detect_cpu_clock(void)
 {
-	switch (bcm63xx_get_cpu_id()) {
+	u16 cpu_id = bcm63xx_get_cpu_id();
+
+	switch (cpu_id) {
 	case BCM3368_CPU_ID:
 		return 300000000;
 
@@ -249,7 +251,7 @@ static unsigned int detect_cpu_clock(void)
 	}
 
 	default:
-		BUG();
+		panic("Failed to detect clock for CPU with id=%04d\n", cpu_id);
 	}
 }
 
-- 
1.8.3.2
