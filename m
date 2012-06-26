Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:50:05 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:54988 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903762Ab2FZEth (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:49:37 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbV-0002zj-V8; Mon, 25 Jun 2012 23:42:17 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 26/33] MIPS: PowerTV: Cleanup firmware support for PowerTV platform.
Date:   Mon, 25 Jun 2012 23:41:41 -0500
Message-Id: <1340685708-14408-27-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/powertv/asic/asic_int.c |    1 -
 arch/mips/powertv/init.c          |   54 +++----------------------------------
 arch/mips/powertv/memory.c        |   13 +++------
 arch/mips/powertv/powertv_setup.c |    2 --
 4 files changed, 7 insertions(+), 63 deletions(-)

diff --git a/arch/mips/powertv/asic/asic_int.c b/arch/mips/powertv/asic/asic_int.c
index 99d82e1..8728c3b 100644
--- a/arch/mips/powertv/asic/asic_int.c
+++ b/arch/mips/powertv/asic/asic_int.c
@@ -35,7 +35,6 @@
 #include <linux/io.h>
 #include <asm/irq_regs.h>
 #include <asm/setup.h>
-#include <asm/mips-boards/generic.h>
 
 #include <asm/mach-powertv/asic_regs.h>
 
diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
index 1cf5abb..14cdf19 100644
--- a/arch/mips/powertv/init.c
+++ b/arch/mips/powertv/init.c
@@ -23,52 +23,15 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-
-#include <asm/bootinfo.h>
 #include <linux/io.h>
+
 #include <asm/cacheflush.h>
 #include <asm/traps.h>
-
-#include <asm/mips-boards/prom.h>
-#include <asm/mips-boards/generic.h>
+#include <asm/fw/fw.h>
 #include <asm/mach-powertv/asic.h>
 
-static int *_prom_envp;
 unsigned long _prom_memsize;
 
-/*
- * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
- * This macro take care of sign extension, if running in 64-bit mode.
- */
-#define prom_envp(index) ((char *)(long)_prom_envp[(index)])
-
-char *prom_getenv(char *envname)
-{
-	char *result = NULL;
-
-	if (_prom_envp != NULL) {
-		/*
-		 * Return a pointer to the given environment variable.
-		 * In 64-bit mode: we're using 64-bit pointers, but all pointers
-		 * in the PROM structures are only 32-bit, so we need some
-		 * workarounds, if we are running in 64-bit mode.
-		 */
-		int i, index = 0;
-
-		i = strlen(envname);
-
-		while (prom_envp(index)) {
-			if (strncmp(envname, prom_envp(index), i) == 0) {
-				result = prom_envp(index + 1);
-				break;
-			}
-			index += 2;
-		}
-	}
-
-	return result;
-}
-
 /* TODO: Verify on linux-mips mailing list that the following two  */
 /* functions are correct                                           */
 /* TODO: Copy NMI and EJTAG exception vectors to memory from the   */
@@ -105,24 +68,15 @@ static void __init mips_ejtag_setup(void)
 
 void __init prom_init(void)
 {
-	int prom_argc;
-	char *prom_argv;
-
-	prom_argc = fw_arg0;
-	prom_argv = (char *) fw_arg1;
-	_prom_envp = (int *) fw_arg2;
 	_prom_memsize = (unsigned long) fw_arg3;
 
 	board_nmi_handler_setup = mips_nmi_setup;
 	board_ejtag_handler_setup = mips_ejtag_setup;
 
-	if (prom_argc == 1) {
-		strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(arcs_cmdline, prom_argv, COMMAND_LINE_SIZE);
-	}
+	fw_init_cmdline();
 
 	configure_platform();
-	prom_meminit();
+	fw_meminit();
 
 #ifndef CONFIG_BOOTLOADER_DRIVER
 	pr_info("\nBootloader driver isn't loaded...\n");
diff --git a/arch/mips/powertv/memory.c b/arch/mips/powertv/memory.c
index fb3d296..56f0193 100644
--- a/arch/mips/powertv/memory.c
+++ b/arch/mips/powertv/memory.c
@@ -28,8 +28,8 @@
 #include <asm/bootinfo.h>
 #include <asm/page.h>
 #include <asm/sections.h>
+#include <asm/fw/fw.h>
 
-#include <asm/mips-boards/prom.h>
 #include <asm/mach-powertv/asic.h>
 #include <asm/mach-powertv/ioremap.h>
 
@@ -163,7 +163,6 @@ static phys_addr_t get_memsize(void)
 {
 	static char cmdline[COMMAND_LINE_SIZE] __initdata;
 	phys_addr_t memsize = 0;
-	char *memsize_str;
 	char *ptr;
 
 	/* Check the command line first for a memsize directive */
@@ -176,13 +175,7 @@ static phys_addr_t get_memsize(void)
 		memsize = memparse(ptr + 8, &ptr);
 	} else {
 		/* otherwise look in the environment */
-		memsize_str = prom_getenv("memsize");
-
-		if (memsize_str != NULL) {
-			pr_info("prom memsize = %s\n", memsize_str);
-			memsize = simple_strtol(memsize_str, NULL, 0);
-		}
-
+		memsize = (phys_addr_t) fw_getenvl("memsize");
 		if (memsize == 0) {
 			if (_prom_memsize != 0) {
 				memsize = _prom_memsize;
@@ -332,7 +325,7 @@ static __init void register_address_space(phys_addr_t memsize)
 	}
 }
 
-void __init prom_meminit(void)
+void __init fw_meminit(void)
 {
 	ptv_memsize = get_memsize();
 	register_address_space(ptv_memsize);
diff --git a/arch/mips/powertv/powertv_setup.c b/arch/mips/powertv/powertv_setup.c
index 3933c37..55a3fc5 100644
--- a/arch/mips/powertv/powertv_setup.c
+++ b/arch/mips/powertv/powertv_setup.c
@@ -30,8 +30,6 @@
 
 #include <asm/bootinfo.h>
 #include <asm/irq.h>
-#include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/prom.h>
 #include <asm/dma.h>
 #include <asm/asm.h>
 #include <asm/traps.h>
-- 
1.7.10.3
