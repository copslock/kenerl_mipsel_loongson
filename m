Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jun 2013 11:03:09 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:48537 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820512Ab3FKJDEEhQ7Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jun 2013 11:03:04 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: kernel: mcount.S: Drop FRAME_POINTER codepath
Date:   Tue, 11 Jun 2013 10:02:55 +0100
Message-ID: <1370941375-12195-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_06_11_10_02_57
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36823
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

CONFIG_FRAME_POINTER is not selectable for MIPS so this
codepath was never executed.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/kernel/mcount.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 33d0671..a03e93c 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -168,15 +168,11 @@ NESTED(ftrace_graph_caller, PT_SIZE, ra)
 #endif
 
 	/* arg3: Get frame pointer of current stack */
-#ifdef CONFIG_FRAME_POINTER
-	move	a2, fp
-#else /* ! CONFIG_FRAME_POINTER */
 #ifdef CONFIG_64BIT
 	PTR_LA	a2, PT_SIZE(sp)
 #else
 	PTR_LA	a2, (PT_SIZE+8)(sp)
 #endif
-#endif
 
 	jal	prepare_ftrace_return
 	 nop
-- 
1.8.2.1
