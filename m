Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 10:54:20 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:55657 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817974Ab3FQIxzkFRau (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jun 2013 10:53:55 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: powertv: Drop SYS_HAS_EARLY_PRINTK
Date:   Mon, 17 Jun 2013 09:53:47 +0100
Message-ID: <1371459227-5346-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_06_17_09_53_50
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36939
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

PowerTV does not provide a prom_putchar function needed for early
printk so remove this symbol for this platform.

Fixes the following problem when EARLY_PRINTK is enabled for powertv:

arch/mips/kernel/early_printk.c:24: undefined reference to `prom_putchar'
arch/mips/kernel/early_printk.c:23: undefined reference to `prom_putchar'

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com> 
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b599130..7fa967d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -417,7 +417,6 @@ config POWERTV
 	select CSRC_POWERTV
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select SYS_HAS_EARLY_PRINTK
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
-- 
1.8.2.1
