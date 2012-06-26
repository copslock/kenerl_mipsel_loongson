Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:43:08 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:54948 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903482Ab2FZEmK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:42:10 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbI-0002zj-3l; Mon, 25 Jun 2012 23:42:04 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 02/33] MIPS: Alchemy: Cleanup firmware support for Alchemy platforms.
Date:   Mon, 25 Jun 2012 23:41:17 -0500
Message-Id: <1340685708-14408-3-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33810
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
 arch/mips/alchemy/board-gpr.c                  |   22 +++++--------
 arch/mips/alchemy/board-mtx1.c                 |   22 +++++--------
 arch/mips/alchemy/board-xxs1500.c              |   21 +++++-------
 arch/mips/alchemy/common/platform.c            |    3 +-
 arch/mips/alchemy/common/prom.c                |   42 ++----------------------
 arch/mips/alchemy/devboards/db1000.c           |    1 -
 arch/mips/alchemy/devboards/db1300.c           |    1 -
 arch/mips/alchemy/devboards/db1550.c           |    1 -
 arch/mips/alchemy/devboards/pb1100.c           |    1 -
 arch/mips/alchemy/devboards/pb1500.c           |    1 -
 arch/mips/alchemy/devboards/prom.c             |   19 ++++-------
 arch/mips/include/asm/mach-au1x00/au1xxx_eth.h |    1 +
 arch/mips/include/asm/mach-au1x00/prom.h       |   12 -------
 drivers/net/ethernet/amd/au1000_eth.c          |    1 -
 14 files changed, 35 insertions(+), 113 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-au1x00/prom.h

diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
index ba32590..1139173 100644
--- a/arch/mips/alchemy/board-gpr.c
+++ b/arch/mips/alchemy/board-gpr.c
@@ -30,10 +30,10 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
-#include <asm/bootinfo.h>
+
 #include <asm/reboot.h>
+#include <asm/fw/fw.h>
 #include <asm/mach-au1x00/au1000.h>
-#include <prom.h>
 
 const char *get_system_type(void)
 {
@@ -42,21 +42,15 @@ const char *get_system_type(void)
 
 void __init prom_init(void)
 {
-	unsigned char *memsize_str;
-	unsigned long memsize;
+	unsigned long physical_memsize;
 
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	fw_init_cmdline();
 
-	prom_init_cmdline();
+	physical_memsize = fw_getenvl("memsize");
+	if (!physical_memsize)
+		physical_memsize = 0x04000000;
 
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
-		memsize = 0x04000000;
-	else
-		strict_strtoul(memsize_str, 0, &memsize);
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
+	add_memory_region(0, physical_memsize, BOOT_MEM_RAM);
 }
 
 void prom_putchar(unsigned char c)
diff --git a/arch/mips/alchemy/board-mtx1.c b/arch/mips/alchemy/board-mtx1.c
index 295f1a9..7d1ea7a 100644
--- a/arch/mips/alchemy/board-mtx1.c
+++ b/arch/mips/alchemy/board-mtx1.c
@@ -29,11 +29,11 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <mtd/mtd-abi.h>
-#include <asm/bootinfo.h>
+
 #include <asm/reboot.h>
+#include <asm/fw/fw.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_eth.h>
-#include <prom.h>
 
 const char *get_system_type(void)
 {
@@ -42,21 +42,15 @@ const char *get_system_type(void)
 
 void __init prom_init(void)
 {
-	unsigned char *memsize_str;
-	unsigned long memsize;
+	unsigned long physical_memsize;
 
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	fw_init_cmdline();
 
-	prom_init_cmdline();
+	physical_memsize = fw_getenvl("memsize");
+	if (!physical_memsize)
+		physical_memsize = 0x04000000;
 
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str)
-		memsize = 0x04000000;
-	else
-		strict_strtoul(memsize_str, 0, &memsize);
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
+	add_memory_region(0, physical_memsize, BOOT_MEM_RAM);
 }
 
 void prom_putchar(unsigned char c)
diff --git a/arch/mips/alchemy/board-xxs1500.c b/arch/mips/alchemy/board-xxs1500.c
index bd55136..0469f1c 100644
--- a/arch/mips/alchemy/board-xxs1500.c
+++ b/arch/mips/alchemy/board-xxs1500.c
@@ -27,10 +27,10 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
-#include <asm/bootinfo.h>
+
 #include <asm/reboot.h>
+#include <asm/fw/fw.h>
 #include <asm/mach-au1x00/au1000.h>
-#include <prom.h>
 
 const char *get_system_type(void)
 {
@@ -39,20 +39,15 @@ const char *get_system_type(void)
 
 void __init prom_init(void)
 {
-	unsigned char *memsize_str;
-	unsigned long memsize;
-
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	unsigned long physical_memsize;
 
-	prom_init_cmdline();
+	fw_init_cmdline();
 
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str || strict_strtoul(memsize_str, 0, &memsize))
-		memsize = 0x04000000;
+	physical_memsize = fw_getenvl("memsize");
+	if (!physical_memsize)
+		physical_memsize = 0x04000000;
 
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
+	add_memory_region(0, physical_memsize, BOOT_MEM_RAM);
 }
 
 void prom_putchar(unsigned char c)
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 95cb911..2c5c014 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -18,13 +18,12 @@
 #include <linux/serial_8250.h>
 #include <linux/slab.h>
 
+#include <asm/fw/fw.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/mach-au1x00/au1xxx_eth.h>
 
-#include <prom.h>
-
 static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
 			    unsigned int old_state)
 {
diff --git a/arch/mips/alchemy/common/prom.c b/arch/mips/alchemy/common/prom.c
index 5340210..a67012d 100644
--- a/arch/mips/alchemy/common/prom.c
+++ b/arch/mips/alchemy/common/prom.c
@@ -37,45 +37,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 
-#include <asm/bootinfo.h>
-
-int prom_argc;
-char **prom_argv;
-char **prom_envp;
-
-void __init prom_init_cmdline(void)
-{
-	int i;
-
-	for (i = 1; i < prom_argc; i++) {
-		strlcat(arcs_cmdline, prom_argv[i], COMMAND_LINE_SIZE);
-		if (i < (prom_argc - 1))
-			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
-	}
-}
-
-char *prom_getenv(char *envname)
-{
-	/*
-	 * Return a pointer to the given environment variable.
-	 * YAMON uses "name", "value" pairs, while U-Boot uses "name=value".
-	 */
-
-	char **env = prom_envp;
-	int i = strlen(envname);
-	int yamon = (*env && strchr(*env, '=') == NULL);
-
-	while (*env) {
-		if (yamon) {
-			if (strcmp(envname, *env++) == 0)
-				return *env;
-		} else if (strncmp(envname, *env, i) == 0 && (*env)[i] == '=')
-			return *env + i + 1;
-		env++;
-	}
-
-	return NULL;
-}
+#include <asm/fw/fw.h>
 
 static inline unsigned char str2hexnum(unsigned char c)
 {
@@ -109,7 +71,7 @@ int __init prom_get_ethernet_addr(char *ethernet_addr)
 	char *ethaddr_str;
 
 	/* Check the environment variables first */
-	ethaddr_str = prom_getenv("ethaddr");
+	ethaddr_str = fw_getenv("ethaddr");
 	if (!ethaddr_str) {
 		/* Check command line */
 		ethaddr_str = strstr(arcs_cmdline, "ethaddr=");
diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 1b81dbf..53ff8a4 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -36,7 +36,6 @@
 #include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/mach-db1x00/bcsr.h>
 #include <asm/reboot.h>
-#include <prom.h>
 #include "platform.h"
 
 #define F_SWAPPED (bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1000_SWAPBOOT)
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index c56e024..8073c86 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -28,7 +28,6 @@
 #include <asm/mach-au1x00/au1xxx_psc.h>
 #include <asm/mach-db1x00/db1300.h>
 #include <asm/mach-db1x00/bcsr.h>
-#include <asm/mach-au1x00/prom.h>
 
 #include "platform.h"
 
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index 9eb7906..7d72509 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -23,7 +23,6 @@
 #include <asm/mach-au1x00/au1xxx_psc.h>
 #include <asm/mach-au1x00/au1550_spi.h>
 #include <asm/mach-db1x00/bcsr.h>
-#include <prom.h>
 #include "platform.h"
 
 
diff --git a/arch/mips/alchemy/devboards/pb1100.c b/arch/mips/alchemy/devboards/pb1100.c
index cff50d0..a9d8904 100644
--- a/arch/mips/alchemy/devboards/pb1100.c
+++ b/arch/mips/alchemy/devboards/pb1100.c
@@ -26,7 +26,6 @@
 #include <linux/platform_device.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/bcsr.h>
-#include <prom.h>
 #include "platform.h"
 
 const char *get_system_type(void)
diff --git a/arch/mips/alchemy/devboards/pb1500.c b/arch/mips/alchemy/devboards/pb1500.c
index e7b807b..36e1853 100644
--- a/arch/mips/alchemy/devboards/pb1500.c
+++ b/arch/mips/alchemy/devboards/pb1500.c
@@ -26,7 +26,6 @@
 #include <linux/platform_device.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/bcsr.h>
-#include <prom.h>
 #include "platform.h"
 
 const char *get_system_type(void)
diff --git a/arch/mips/alchemy/devboards/prom.c b/arch/mips/alchemy/devboards/prom.c
index 93a2210..59af1d4 100644
--- a/arch/mips/alchemy/devboards/prom.c
+++ b/arch/mips/alchemy/devboards/prom.c
@@ -29,9 +29,8 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
 #include <asm/mach-au1x00/au1000.h>
-#include <prom.h>
 
 #if defined(CONFIG_MIPS_DB1000) || \
     defined(CONFIG_MIPS_PB1100) || \
@@ -44,19 +43,15 @@
 
 void __init prom_init(void)
 {
-	unsigned char *memsize_str;
-	unsigned long memsize;
+	unsigned long physical_memsize;
 
-	prom_argc = (int)fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	fw_init_cmdline();
 
-	prom_init_cmdline();
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str || strict_strtoul(memsize_str, 0, &memsize))
-		memsize = ALCHEMY_BOARD_DEFAULT_MEMSIZE;
+	physical_memsize = fw_getenvl("memsize");
+	if (!physical_memsize)
+		physical_memsize = ALCHEMY_BOARD_DEFAULT_MEMSIZE;
 
-	add_memory_region(0, memsize, BOOT_MEM_RAM);
+	add_memory_region(0, physical_memsize, BOOT_MEM_RAM);
 }
 
 void prom_putchar(unsigned char c)
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h b/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h
index 49dc8d9..3f22d5a 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h
@@ -14,5 +14,6 @@ struct au1000_eth_platform_data {
 
 void __init au1xxx_override_eth_cfg(unsigned port,
 			struct au1000_eth_platform_data *eth_data);
+int __init prom_get_ethernet_addr(char *ethernet_addr);
 
 #endif /* __AU1X00_ETH_DATA_H */
diff --git a/arch/mips/include/asm/mach-au1x00/prom.h b/arch/mips/include/asm/mach-au1x00/prom.h
deleted file mode 100644
index 4c0e09c..0000000
--- a/arch/mips/include/asm/mach-au1x00/prom.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef __AU1X00_PROM_H
-#define __AU1X00_PROM_H
-
-extern int prom_argc;
-extern char **prom_argv;
-extern char **prom_envp;
-
-extern void prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
-extern int prom_get_ethernet_addr(char *ethernet_addr);
-
-#endif
diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 397596b..200ccc2 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -67,7 +67,6 @@
 
 #include <au1000.h>
 #include <au1xxx_eth.h>
-#include <prom.h>
 
 #include "au1000_eth.h"
 
-- 
1.7.10.3
