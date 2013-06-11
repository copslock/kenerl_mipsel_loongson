Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jun 2013 11:49:57 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:55182 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827516Ab3FKJtyT7fc9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Jun 2013 11:49:54 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] lib/Kconfig.debug: Restrict FRAME_POINTER for MIPS
Date:   Tue, 11 Jun 2013 10:49:50 +0100
Message-ID: <1370944190-13553-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_06_11_10_49_48
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36824
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

FAULT_INJECTION_STACKTRACE_FILTER selects FRAME_POINTER but
that symbol is not available for MIPS.

Fixes the following problem on a randconfig:
warning: (LOCKDEP && FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP &&
 KMEMCHECK) selects FRAME_POINTER which has unmet direct dependencies
(DEBUG_KERNEL && (CRIS || M68K || FRV || UML || AVR32 || SUPERH || BLACKFIN ||
MN10300 || METAG) || ARCH_WANT_FRAME_POINTERS)

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 566cf2b..74fdc5c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1272,7 +1272,7 @@ config FAULT_INJECTION_STACKTRACE_FILTER
 	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
 	depends on !X86_64
 	select STACKTRACE
-	select FRAME_POINTER if !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND
+	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND
 	help
 	  Provide stacktrace filter for fault-injection capabilities
 
-- 
1.8.2.1
