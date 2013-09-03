Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2013 16:22:15 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:33531 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824771Ab3ICOWKsDHww (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Sep 2013 16:22:10 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        David VomLehn <dvomlehn@cisco.com>
Subject: [PATCH v2] MIPS: powertv: Drop BOOTLOADER_DRIVER Kconfig symbol
Date:   Tue, 3 Sep 2013 15:21:59 +0100
Message-ID: <1378218119-19770-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_09_03_15_22_05
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37745
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

The kbldr.h header file required for this was neither committed in the
original submission in a3a0f8c8ed2e2470f4dcd6da95020d41fed84747
"MIPS: PowerTV: Base files for Cisco PowerTV platform"
nor was it ever present in the git tree so this option never worked.
Fixes the following build problem:
arch/mips/powertv/reset.c:25:36: fatal error: asm/mach-powertv/kbldr.h: No such
file or directory
compilation terminated.

Cc: David VomLehn <dvomlehn@cisco.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
This patch is for the upstream-sfr/mips-for-linux-next tree

Changes since v1:
- Do not 'select BOOTLOADER_FAMILY'. It's automatically enabled
for the powertv platform.
http://www.linux-mips.org/archives/linux-mips/2013-09/msg00003.html
---
 arch/mips/powertv/Kconfig             |  9 +--------
 arch/mips/powertv/asic/asic_devices.c | 12 +-----------
 arch/mips/powertv/init.c              |  4 ----
 arch/mips/powertv/reset.c             | 12 ------------
 4 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/arch/mips/powertv/Kconfig b/arch/mips/powertv/Kconfig
index 1a1b03e..dd91fba 100644
--- a/arch/mips/powertv/Kconfig
+++ b/arch/mips/powertv/Kconfig
@@ -1,14 +1,7 @@
-config BOOTLOADER_DRIVER
-	bool "PowerTV Bootloader Driver Support"
-	default n
-	depends on POWERTV
-	help
-	  Use this option if you want to load bootloader driver.
-
 config BOOTLOADER_FAMILY
 	string "POWERTV Bootloader Family string"
 	default "85"
-	depends on POWERTV && !BOOTLOADER_DRIVER
+	depends on POWERTV
 	help
 	  This value should be specified when the bootloader driver is disabled
 	  and must be exactly two characters long. Families supported are:
diff --git a/arch/mips/powertv/asic/asic_devices.c b/arch/mips/powertv/asic/asic_devices.c
index 0238af1..8380605 100644
--- a/arch/mips/powertv/asic/asic_devices.c
+++ b/arch/mips/powertv/asic/asic_devices.c
@@ -147,20 +147,10 @@ static __init noinline void platform_set_family(void)
 	if (check_forcefamily(forced_family) == 0)
 		bootldr_family = BOOTLDRFAMILY(forced_family[0],
 			forced_family[1]);
-	else {
-
-#ifdef CONFIG_BOOTLOADER_DRIVER
-		bootldr_family = (unsigned short) kbldr_GetSWFamily();
-#else
-#if defined(CONFIG_BOOTLOADER_FAMILY)
+	else
 		bootldr_family = (unsigned short) BOOTLDRFAMILY(
 			CONFIG_BOOTLOADER_FAMILY[0],
 			CONFIG_BOOTLOADER_FAMILY[1]);
-#else
-#error "Unknown Bootloader Family"
-#endif
-#endif
-	}
 
 	pr_info("Bootloader Family = 0x%04X\n", bootldr_family);
 
diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
index a01baff..4989263 100644
--- a/arch/mips/powertv/init.c
+++ b/arch/mips/powertv/init.c
@@ -87,8 +87,4 @@ void __init prom_init(void)
 
 	configure_platform();
 	prom_meminit();
-
-#ifndef CONFIG_BOOTLOADER_DRIVER
-	pr_info("\nBootloader driver isn't loaded...\n");
-#endif
 }
diff --git a/arch/mips/powertv/reset.c b/arch/mips/powertv/reset.c
index 0007652..11c32fb 100644
--- a/arch/mips/powertv/reset.c
+++ b/arch/mips/powertv/reset.c
@@ -21,24 +21,12 @@
 #include <linux/io.h>
 #include <asm/reboot.h>			/* Not included by linux/reboot.h */
 
-#ifdef CONFIG_BOOTLOADER_DRIVER
-#include <asm/mach-powertv/kbldr.h>
-#endif
-
 #include <asm/mach-powertv/asic_regs.h>
 #include "reset.h"
 
 static void mips_machine_restart(char *command)
 {
-#ifdef CONFIG_BOOTLOADER_DRIVER
-	/*
-	 * Call the bootloader's reset function to ensure
-	 * that persistent data is flushed before hard reset
-	 */
-	kbldr_SetCauseAndReset();
-#else
 	writel(0x1, asic_reg_addr(watchdog));
-#endif
 }
 
 void mips_reboot_setup(void)
-- 
1.8.3.2
