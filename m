Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 14:25:47 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:20771 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823608Ab3F1MZfKULMV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Jun 2013 14:25:35 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: Kconfig: Add missing MODULES dependency to VPE_LOADER
Date:   Fri, 28 Jun 2013 13:25:27 +0100
Message-ID: <1372422327-21814-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_06_28_13_25_29
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37201
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

The vpe.c code uses the 'struct module' which is only available if
CONFIG_MODULES is selected.

Also fixes the following build problem on a lantiq allmodconfig:
In file included from arch/mips/kernel/vpe.c:41:0:
include/linux/moduleloader.h: In function 'apply_relocate':
include/linux/moduleloader.h:48:63: error: dereferencing pointer
to incomplete type
include/linux/moduleloader.h: In function 'apply_relocate_add':
include/linux/moduleloader.h:70:63: error: dereferencing pointer
to incomplete type

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8f5e646..77a6598 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1929,7 +1929,7 @@ config MIPS_MT_FPAFF
 
 config MIPS_VPE_LOADER
 	bool "VPE loader support."
-	depends on SYS_SUPPORTS_MULTITHREADING
+	depends on SYS_SUPPORTS_MULTITHREADING && MODULES
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select MIPS_MT
-- 
1.8.2.1
