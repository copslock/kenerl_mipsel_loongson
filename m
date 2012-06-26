Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:44:04 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:54952 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903499Ab2FZEmL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:42:11 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbJ-0002zj-8q; Mon, 25 Jun 2012 23:42:05 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 04/33] MIPS: AR7: Cleanup firmware support for the AR7 platform.
Date:   Mon, 25 Jun 2012 23:41:19 -0500
Message-Id: <1340685708-14408-5-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33812
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
 arch/mips/ar7/memory.c                |    3 +--
 arch/mips/ar7/platform.c              |   10 ++++-----
 arch/mips/ar7/prom.c                  |   40 ++++++++-------------------------
 arch/mips/ar7/setup.c                 |    4 ++--
 arch/mips/include/asm/mach-ar7/prom.h |   25 ---------------------
 5 files changed, 17 insertions(+), 65 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-ar7/prom.h

diff --git a/arch/mips/ar7/memory.c b/arch/mips/ar7/memory.c
index 28abfee..3d7133d 100644
--- a/arch/mips/ar7/memory.c
+++ b/arch/mips/ar7/memory.c
@@ -30,7 +30,6 @@
 #include <asm/sections.h>
 
 #include <asm/mach-ar7/ar7.h>
-#include <asm/mips-boards/prom.h>
 
 static int __init memsize(void)
 {
@@ -57,7 +56,7 @@ static int __init memsize(void)
 	return size;
 }
 
-void __init prom_meminit(void)
+void __init fw_meminit(void)
 {
 	unsigned long pages;
 
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 1a24d31..284b86a 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -38,9 +38,9 @@
 #include <linux/clk.h>
 
 #include <asm/addrspace.h>
+#include <asm/fw/fw.h>
 #include <asm/mach-ar7/ar7.h>
 #include <asm/mach-ar7/gpio.h>
-#include <asm/mach-ar7/prom.h>
 
 /*****************************************************************************
  * VLYNQ Bus
@@ -297,10 +297,10 @@ static void __init cpmac_get_mac(int instance, unsigned char *dev_addr)
 	char name[5], *mac;
 
 	sprintf(name, "mac%c", 'a' + instance);
-	mac = prom_getenv(name);
+	mac = fw_getenv(name);
 	if (!mac && instance) {
 		sprintf(name, "mac%c", 'a');
-		mac = prom_getenv(name);
+		mac = fw_getenv(name);
 	}
 
 	if (mac) {
@@ -514,8 +514,8 @@ static void __init detect_leds(void)
 	ar7_led_data.leds = default_leds;
 
 	/* FIXME: the whole thing is unreliable */
-	prid = prom_getenv("ProductID");
-	usb_prod = prom_getenv("usb_prod");
+	prid = fw_getenv("ProductID");
+	usb_prod = fw_getenv("usb_prod");
 
 	/* If we can't get the product id from PROM, use the default LEDs */
 	if (!prid)
diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index a23adc4..9e5699a 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -24,10 +24,9 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/io.h>
-#include <asm/bootinfo.h>
 
+#include <asm/fw/fw.h>
 #include <asm/mach-ar7/ar7.h>
-#include <asm/mach-ar7/prom.h>
 
 #define MAX_ENTRY 80
 
@@ -38,29 +37,6 @@ struct env_var {
 
 static struct env_var adam2_env[MAX_ENTRY];
 
-char *prom_getenv(const char *name)
-{
-	int i;
-
-	for (i = 0; (i < MAX_ENTRY) && adam2_env[i].name; i++)
-		if (!strcmp(name, adam2_env[i].name))
-			return adam2_env[i].value;
-
-	return NULL;
-}
-EXPORT_SYMBOL(prom_getenv);
-
-static void  __init ar7_init_cmdline(int argc, char *argv[])
-{
-	int i;
-
-	for (i = 1; i < argc; i++) {
-		strlcat(arcs_cmdline, argv[i], COMMAND_LINE_SIZE);
-		if (i < (argc - 1))
-			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
-	}
-}
-
 struct psbl_rec {
 	u32	psbl_size;
 	u32	env_base;
@@ -199,17 +175,19 @@ static void __init console_config(void)
 {
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	char console_string[40];
-	int baud = 0;
+	long val;
+	int tmp, baud = 0;
 	char parity = '\0', bits = '\0', flow = '\0';
-	char *s, *p;
+	char *s;
 
 	if (strstr(arcs_cmdline, "console="))
 		return;
 
-	s = prom_getenv("modetty0");
+	s = fw_getenv("modetty0");
 	if (s) {
-		baud = simple_strtoul(s, &p, 10);
-		s = p;
+		tmp = kstrtol(s, 0, &val);
+		baud = (int)val;
+		while (*s++ != ',');
 		if (*s == ',')
 			s++;
 		if (*s)
@@ -243,7 +221,7 @@ static void __init console_config(void)
 
 void __init prom_init(void)
 {
-	ar7_init_cmdline(fw_arg0, (char **)fw_arg1);
+	fw_init_cmdline();
 	ar7_init_env((struct env_var *)fw_arg2);
 	console_config();
 
diff --git a/arch/mips/ar7/setup.c b/arch/mips/ar7/setup.c
index 9a357ff..ec318bb 100644
--- a/arch/mips/ar7/setup.c
+++ b/arch/mips/ar7/setup.c
@@ -21,8 +21,8 @@
 #include <linux/time.h>
 
 #include <asm/reboot.h>
+#include <asm/fw/fw.h>
 #include <asm/mach-ar7/ar7.h>
-#include <asm/mach-ar7/prom.h>
 #include <asm/mach-ar7/gpio.h>
 
 static void ar7_machine_restart(char *command)
@@ -99,7 +99,7 @@ void __init plat_mem_setup(void)
 		panic("Can't remap IO base!");
 	set_io_port_base(io_base);
 
-	prom_meminit();
+	fw_meminit();
 
 	printk(KERN_INFO "%s, ID: 0x%04x, Revision: 0x%02x\n",
 			get_system_type(), ar7_chip_id(), ar7_chip_rev());
diff --git a/arch/mips/include/asm/mach-ar7/prom.h b/arch/mips/include/asm/mach-ar7/prom.h
deleted file mode 100644
index 088f61f..0000000
--- a/arch/mips/include/asm/mach-ar7/prom.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Copyright (C) 2006, 2007 Florian Fainelli <florian@openwrt.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#ifndef __PROM_H__
-#define __PROM_H__
-
-extern char *prom_getenv(const char *name);
-extern void prom_meminit(void);
-
-#endif /* __PROM_H__ */
-- 
1.7.10.3
