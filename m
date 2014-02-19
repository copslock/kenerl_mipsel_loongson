Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Feb 2014 11:17:01 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43781 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6837846AbaBSKQ70Vxop (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Feb 2014 11:16:59 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: bcm47xx: board: Include missing errno.h for ENXIO
Date:   Wed, 19 Feb 2014 10:17:18 +0000
Message-ID: <1392805038-29963-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_02_19_10_16_53
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39341
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

Fixes the following build problen on allmodconfig:

arch/mips/bcm47xx/board.c: In function 'bcm47xx_board_detect':
arch/mips/bcm47xx/board.c:291:14: error: 'ENXIO' undeclared
(first use in this function)

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/bcm47xx/board.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index 6d612e2..cdd8246 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -1,3 +1,4 @@
+#include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/string.h>
 #include <bcm47xx_board.h>
-- 
1.9.0
