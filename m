Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2012 23:53:27 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43564 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903738Ab2FEVuv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jun 2012 23:50:51 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Sc1AX-000824-R2; Tue, 05 Jun 2012 16:20:01 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 26/35] MIPS: PNX83xx, PNX8550: Cleanup firmware support for PNX platforms.
Date:   Tue,  5 Jun 2012 16:19:30 -0500
Message-Id: <1338931179-9611-27-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1338931179-9611-1-git-send-email-sjhill@mips.com>
References: <1338931179-9611-1-git-send-email-sjhill@mips.com>
X-archive-position: 33533
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
 arch/mips/pnx833x/common/Makefile    |    2 +-
 arch/mips/pnx833x/common/prom.c      |   64 -----------------
 arch/mips/pnx833x/common/setup.c     |    4 ++
 arch/mips/pnx833x/stb22x/board.c     |   25 ++-----
 arch/mips/pnx8550/common/Makefile    |    2 +-
 arch/mips/pnx8550/common/prom.c      |  128 ----------------------------------
 arch/mips/pnx8550/common/setup.c     |    7 +-
 arch/mips/pnx8550/jbs/init.c         |    9 +--
 arch/mips/pnx8550/stb810/prom_init.c |   13 +---
 9 files changed, 21 insertions(+), 233 deletions(-)
 delete mode 100644 arch/mips/pnx833x/common/prom.c
 delete mode 100644 arch/mips/pnx8550/common/prom.c

diff --git a/arch/mips/pnx833x/common/Makefile b/arch/mips/pnx833x/common/Makefile
index 1a46dd2..abda463 100644
--- a/arch/mips/pnx833x/common/Makefile
+++ b/arch/mips/pnx833x/common/Makefile
@@ -1 +1 @@
-obj-y := interrupts.o platform.o prom.o setup.o reset.o
+obj-y := interrupts.o platform.o setup.o reset.o
diff --git a/arch/mips/pnx833x/common/prom.c b/arch/mips/pnx833x/common/prom.c
deleted file mode 100644
index 29969f9..0000000
--- a/arch/mips/pnx833x/common/prom.c
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- *  prom.c:
- *
- *  Copyright 2008 NXP Semiconductors
- *	  Chris Steel <chris.steel@nxp.com>
- *    Daniel Laird <daniel.j.laird@nxp.com>
- *
- *  Based on software written by:
- *      Nikita Youshchenko <yoush@debian.org>, based on PNX8550 code.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-#include <linux/init.h>
-#include <asm/bootinfo.h>
-#include <linux/string.h>
-
-void __init prom_init_cmdline(void)
-{
-	int argc = fw_arg0;
-	char **argv = (char **)fw_arg1;
-	char *c = &(arcs_cmdline[0]);
-	int i;
-
-	for (i = 1; i < argc; i++) {
-		strcpy(c, argv[i]);
-		c += strlen(argv[i]);
-		if (i < argc-1)
-			*c++ = ' ';
-	}
-	*c = 0;
-}
-
-char __init *prom_getenv(char *envname)
-{
-	extern char **prom_envp;
-	char **env = prom_envp;
-	int i;
-
-	i = strlen(envname);
-
-	while (*env) {
-		if (strncmp(envname, *env, i) == 0 && *(*env+i) == '=')
-			return *env + i + 1;
-		env++;
-	}
-
-	return 0;
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
diff --git a/arch/mips/pnx833x/common/setup.c b/arch/mips/pnx833x/common/setup.c
index e51fbc4..3ea4926 100644
--- a/arch/mips/pnx833x/common/setup.c
+++ b/arch/mips/pnx833x/common/setup.c
@@ -36,6 +36,10 @@ extern void pnx833x_machine_restart(char *);
 extern void pnx833x_machine_halt(void);
 extern void pnx833x_machine_power_off(void);
 
+void __init prom_free_prom_memory(void)
+{
+}
+
 int __init plat_mem_setup(void)
 {
 	/* fake pci bus to avoid bounce buffers */
diff --git a/arch/mips/pnx833x/stb22x/board.c b/arch/mips/pnx833x/stb22x/board.c
index 644eb7c..cdf1a3b 100644
--- a/arch/mips/pnx833x/stb22x/board.c
+++ b/arch/mips/pnx833x/stb22x/board.c
@@ -23,8 +23,8 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/init.h>
-#include <asm/bootinfo.h>
 #include <linux/mm.h>
+#include <asm/fw/fw.h>
 #include <pnx833x.h>
 #include <gpio.h>
 
@@ -38,34 +38,23 @@
 #define PNX8335_DEBUG6 0x4418
 #define PNX8335_DEBUG7 0x441c
 
-int prom_argc;
-char **prom_argv, **prom_envp;
-
-extern void prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
-
 const char *get_system_type(void)
 {
 	return "NXP STB22x";
 }
 
-static inline unsigned long env_or_default(char *env, unsigned long dfl)
-{
-	char *str = prom_getenv(env);
-	return str ? simple_strtol(str, 0, 0) : dfl;
-}
-
 void __init prom_init(void)
 {
 	unsigned long memsize;
 
-	prom_argc = fw_arg0;
-	prom_argv = (char **)fw_arg1;
-	prom_envp = (char **)fw_arg2;
+	fw_init_cmdline();
 
-	prom_init_cmdline();
+	memsize = fw_getenvl("memsize");
+	if (!memsize) {
+		pr_warn("memsize not set by firmware, setting to 32MB\n");
+		memsize = 0x02000000;
+	}
 
-	memsize = env_or_default("memsize", 0x02000000);
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
 }
 
diff --git a/arch/mips/pnx8550/common/Makefile b/arch/mips/pnx8550/common/Makefile
index f8ce695..32f5399 100644
--- a/arch/mips/pnx8550/common/Makefile
+++ b/arch/mips/pnx8550/common/Makefile
@@ -22,5 +22,5 @@
 # under Linux.
 #
 
-obj-y := setup.o prom.o int.o reset.o time.o proc.o platform.o
+obj-y := setup.o int.o reset.o time.o proc.o platform.o
 obj-$(CONFIG_PCI) += pci.o
diff --git a/arch/mips/pnx8550/common/prom.c b/arch/mips/pnx8550/common/prom.c
deleted file mode 100644
index 49639e8..0000000
--- a/arch/mips/pnx8550/common/prom.c
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- *
- * Per Hallsmark, per.hallsmark@mvista.com
- *
- * Based on jmr3927/common/prom.c
- *
- * 2004 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/string.h>
-#include <linux/serial_pnx8xxx.h>
-
-#include <asm/bootinfo.h>
-#include <uart.h>
-
-/* #define DEBUG_CMDLINE */
-
-extern int prom_argc;
-extern char **prom_argv, **prom_envp;
-
-typedef struct
-{
-    char *name;
-/*    char *val; */
-}t_env_var;
-
-
-char * __init prom_getcmdline(void)
-{
-	return &(arcs_cmdline[0]);
-}
-
-void __init prom_init_cmdline(void)
-{
-	int i;
-
-	arcs_cmdline[0] = '\0';
-	for (i = 0; i < prom_argc; i++) {
-		strcat(arcs_cmdline, prom_argv[i]);
-		strcat(arcs_cmdline, " ");
-	}
-}
-
-char *prom_getenv(char *envname)
-{
-	/*
-	 * Return a pointer to the given environment variable.
-	 * Environment variables are stored in the form of "memsize=64".
-	 */
-
-	t_env_var *env = (t_env_var *)prom_envp;
-	int i;
-
-	i = strlen(envname);
-
-	while(env->name) {
-		if(strncmp(envname, env->name, i) == 0) {
-			return(env->name + strlen(envname) + 1);
-		}
-		env++;
-	}
-	return(NULL);
-}
-
-inline unsigned char str2hexnum(unsigned char c)
-{
-	if(c >= '0' && c <= '9')
-		return c - '0';
-	if(c >= 'a' && c <= 'f')
-		return c - 'a' + 10;
-	if(c >= 'A' && c <= 'F')
-		return c - 'A' + 10;
-	return 0; /* foo */
-}
-
-inline void str2eaddr(unsigned char *ea, unsigned char *str)
-{
-	int i;
-
-	for(i = 0; i < 6; i++) {
-		unsigned char num;
-
-		if((*str == '.') || (*str == ':'))
-			str++;
-		num = str2hexnum(*str++) << 4;
-		num |= (str2hexnum(*str++));
-		ea[i] = num;
-	}
-}
-
-int get_ethernet_addr(char *ethernet_addr)
-{
-        char *ethaddr_str;
-
-        ethaddr_str = prom_getenv("ethaddr");
-	if (!ethaddr_str) {
-	        printk("ethaddr not set in boot prom\n");
-		return -1;
-	}
-	str2eaddr(ethernet_addr, ethaddr_str);
-	return 0;
-}
-
-void __init prom_free_prom_memory(void)
-{
-}
-
-extern int pnx8550_console_port;
-
-/* used by early printk */
-void prom_putchar(char c)
-{
-	if (pnx8550_console_port != -1) {
-		/* Wait until FIFO not full */
-		while( ((ip3106_fifo(UART_BASE, pnx8550_console_port) & PNX8XXX_UART_FIFO_TXFIFO) >> 16) >= 16)
-			;
-		/* Send one char */
-		ip3106_fifo(UART_BASE, pnx8550_console_port) = c;
-	}
-}
-
-EXPORT_SYMBOL(get_ethernet_addr);
-EXPORT_SYMBOL(str2eaddr);
diff --git a/arch/mips/pnx8550/common/setup.c b/arch/mips/pnx8550/common/setup.c
index fccd6b0..b8ae54c 100644
--- a/arch/mips/pnx8550/common/setup.c
+++ b/arch/mips/pnx8550/common/setup.c
@@ -28,10 +28,10 @@
 #include <linux/pm.h>
 
 #include <asm/cpu.h>
-#include <asm/bootinfo.h>
 #include <asm/irq.h>
 #include <asm/mipsregs.h>
 #include <asm/reboot.h>
+#include <asm/fw/fw.h>
 #include <asm/pgtable.h>
 #include <asm/time.h>
 
@@ -46,7 +46,6 @@ extern void pnx8550_machine_restart(char *);
 extern void pnx8550_machine_halt(void);
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
-extern char *prom_getcmdline(void);
 
 struct resource standard_io_resources[] = {
 	{
@@ -128,8 +127,8 @@ void __init plat_mem_setup(void)
 			(PNX8550_GPIO_MODE_PRIMOP << PNX8550_GPIO_MC_17_BIT),
 			PNX8550_GPIO_MC1);
 
-	argptr = prom_getcmdline();
-	if ((argptr = strstr(argptr, "console=ttyS")) != NULL) {
+	argptr = strstr(fw_getcmdline(), "console=ttyS");
+	if (argptr != NULL) {
 		argptr += strlen("console=ttyS");
 		pnx8550_console_port = *argptr == '0' ? 0 : 1;
 
diff --git a/arch/mips/pnx8550/jbs/init.c b/arch/mips/pnx8550/jbs/init.c
index d59b4a4..e682446 100644
--- a/arch/mips/pnx8550/jbs/init.c
+++ b/arch/mips/pnx8550/jbs/init.c
@@ -29,15 +29,10 @@
 #include <linux/sched.h>
 #include <linux/bootmem.h>
 #include <asm/addrspace.h>
-#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 
-int prom_argc;
-char **prom_argv, **prom_envp;
-extern void  __init prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
-
 const char *get_system_type(void)
 {
 	return "NXP PNX8550/JBS";
@@ -47,6 +42,8 @@ void __init prom_init(void)
 {
 	unsigned long memsize;
 
+	fw_init_cmdline();
+
 	//memsize = 0x02800000; /* Trimedia uses memory above */
 	memsize = 0x08000000; /* Trimedia uses memory above */
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
diff --git a/arch/mips/pnx8550/stb810/prom_init.c b/arch/mips/pnx8550/stb810/prom_init.c
index ca7f4ad..cb1b052 100644
--- a/arch/mips/pnx8550/stb810/prom_init.c
+++ b/arch/mips/pnx8550/stb810/prom_init.c
@@ -17,15 +17,10 @@
 #include <linux/sched.h>
 #include <linux/bootmem.h>
 #include <asm/addrspace.h>
-#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 
-int prom_argc;
-char **prom_argv, **prom_envp;
-extern void  __init prom_init_cmdline(void);
-extern char *prom_getenv(char *envname);
-
 const char *get_system_type(void)
 {
 	return "NXP PNX8950/STB810";
@@ -35,11 +30,7 @@ void __init prom_init(void)
 {
 	unsigned long memsize;
 
-	prom_argc = (int) fw_arg0;
-	prom_argv = (char **) fw_arg1;
-	prom_envp = (char **) fw_arg2;
-
-	prom_init_cmdline();
+	fw_init_cmdline();
 
 	memsize = 0x08000000; /* Trimedia uses memory above */
 	add_memory_region(0, memsize, BOOT_MEM_RAM);
-- 
1.7.10.3
