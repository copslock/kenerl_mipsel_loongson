Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 06:21:40 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60396 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824804Ab2LGFVDkhGQp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 06:21:03 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TgqMr-0007Pp-Ft; Thu, 06 Dec 2012 23:20:57 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 2/4] MIPS: sead3: Use new common FW library variable processing.
Date:   Thu,  6 Dec 2012 23:20:47 -0600
Message-Id: <1354857649-29224-3-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1354857649-29224-1-git-send-email-sjhill@mips.com>
References: <1354857649-29224-1-git-send-email-sjhill@mips.com>
X-archive-position: 35231
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

Remove old YAMON prom code and use common firmware library code
instead for the SEAD-3 platform.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/mti-sead3/Makefile        |    8 ++--
 arch/mips/mti-sead3/sead3-cmdline.c |   46 --------------------
 arch/mips/mti-sead3/sead3-console.c |    2 +-
 arch/mips/mti-sead3/sead3-display.c |    1 -
 arch/mips/mti-sead3/sead3-init.c    |   82 ++++++++++++++++++++---------------
 arch/mips/mti-sead3/sead3-time.c    |    1 -
 6 files changed, 51 insertions(+), 89 deletions(-)
 delete mode 100644 arch/mips/mti-sead3/sead3-cmdline.c

diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index e2ace8a..fd384b5 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -8,10 +8,10 @@
 # Copyright (C) 2012 MIPS Technoligies, Inc.  All rights reserved.
 # Steven J. Hill <sjhill@mips.com>
 #
-obj-y				:= sead3-lcd.o sead3-cmdline.o \
-				   sead3-display.o sead3-init.o sead3-int.o \
-				   sead3-mtd.o sead3-net.o sead3-platform.o \
-				   sead3-reset.o sead3-setup.o sead3-time.o
+obj-y				:= sead3-lcd.o sead3-display.o sead3-init.o \
+				   sead3-int.o sead3-mtd.o sead3-net.o \
+				   sead3-platform.o sead3-reset.o \
+				   sead3-setup.o sead3-time.o
 
 obj-y				+= sead3-i2c-dev.o sead3-i2c.o \
 				   sead3-pic32-i2c-drv.o sead3-pic32-bus.o \
diff --git a/arch/mips/mti-sead3/sead3-cmdline.c b/arch/mips/mti-sead3/sead3-cmdline.c
deleted file mode 100644
index a2e6cec..0000000
--- a/arch/mips/mti-sead3/sead3-cmdline.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- */
-#include <linux/init.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
-
-extern int prom_argc;
-extern int *_prom_argv;
-
-/*
- * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
- * This macro take care of sign extension.
- */
-#define prom_argv(index) ((char *)(long)_prom_argv[(index)])
-
-char * __init prom_getcmdline(void)
-{
-	return &(arcs_cmdline[0]);
-}
-
-void  __init prom_init_cmdline(void)
-{
-	char *cp;
-	int actr;
-
-	actr = 1; /* Always ignore argv[0] */
-
-	cp = &(arcs_cmdline[0]);
-	while (actr < prom_argc) {
-		strcpy(cp, prom_argv(actr));
-		cp += strlen(prom_argv(actr));
-		*cp++ = ' ';
-		actr++;
-	}
-	if (cp != &(arcs_cmdline[0])) {
-		/* get rid of trailing space */
-		--cp;
-		*cp = '\0';
-	}
-}
diff --git a/arch/mips/mti-sead3/sead3-console.c b/arch/mips/mti-sead3/sead3-console.c
index b367391..1b6042c 100644
--- a/arch/mips/mti-sead3/sead3-console.c
+++ b/arch/mips/mti-sead3/sead3-console.c
@@ -26,7 +26,7 @@ static inline void serial_out(int offset, int value, unsigned int base_addr)
 	__raw_writel(value, PORT(base_addr, offset));
 }
 
-void __init prom_init_early_console(char port)
+void __init fw_init_early_console(char port)
 {
 	console_port = port;
 }
diff --git a/arch/mips/mti-sead3/sead3-display.c b/arch/mips/mti-sead3/sead3-display.c
index 8308c7f..62202e1 100644
--- a/arch/mips/mti-sead3/sead3-display.c
+++ b/arch/mips/mti-sead3/sead3-display.c
@@ -8,7 +8,6 @@
 #include <linux/timer.h>
 #include <linux/io.h>
 #include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/prom.h>
 
 static unsigned int display_count;
 static unsigned int max_display_count;
diff --git a/arch/mips/mti-sead3/sead3-init.c b/arch/mips/mti-sead3/sead3-init.c
index 6939254..bfbd17b 100644
--- a/arch/mips/mti-sead3/sead3-init.c
+++ b/arch/mips/mti-sead3/sead3-init.c
@@ -12,38 +12,51 @@
 #include <asm/cacheflush.h>
 #include <asm/traps.h>
 #include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/prom.h>
-
-extern void prom_init_early_console(char port);
+#include <asm/fw/fw.h>
 
 extern char except_vec_nmi;
 extern char except_vec_ejtag_debug;
 
-int prom_argc;
-int *_prom_argv, *_prom_envp;
-
-#define prom_envp(index) ((char *)(long)_prom_envp[(index)])
-
-char *prom_getenv(char *envname)
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+static void __init console_config(void)
 {
-	/*
-	 * Return a pointer to the given environment variable.
-	 * In 64-bit mode: we're using 64-bit pointers, but all pointers
-	 * in the PROM structures are only 32-bit, so we need some
-	 * workarounds, if we are running in 64-bit mode.
-	 */
-	int i, index = 0;
-
-	i = strlen(envname);
-
-	while (prom_envp(index)) {
-		if (strncmp(envname, prom_envp(index), i) == 0)
-			return prom_envp(index+1);
-		index += 2;
+	char console_string[40];
+	int baud = 0;
+	char parity = '\0', bits = '\0', flow = '\0';
+	char *s;
+
+	if ((strstr(fw_getcmdline(), "console=")) == NULL) {
+		s = fw_getenv("modetty0");
+		if (s) {
+			while (*s >= '0' && *s <= '9')
+				baud = baud*10 + *s++ - '0';
+			if (*s == ',')
+				s++;
+			if (*s)
+				parity = *s++;
+			if (*s == ',')
+				s++;
+			if (*s)
+				bits = *s++;
+			if (*s == ',')
+				s++;
+			if (*s == 'h')
+				flow = 'r';
+		}
+		if (baud == 0)
+			baud = 38400;
+		if (parity != 'n' && parity != 'o' && parity != 'e')
+			parity = 'n';
+		if (bits != '7' && bits != '8')
+			bits = '8';
+		if (flow == '\0')
+			flow = 'r';
+		sprintf(console_string, " console=ttyS0,%d%c%c%c", baud,
+			parity, bits, flow);
+		strcat(fw_getcmdline(), console_string);
 	}
-
-	return NULL;
 }
+#endif
 
 static void __init mips_nmi_setup(void)
 {
@@ -117,23 +130,20 @@ static void __init mips_ejtag_setup(void)
 
 void __init prom_init(void)
 {
-	prom_argc = fw_arg0;
-	_prom_argv = (int *) fw_arg1;
-	_prom_envp = (int *) fw_arg2;
-
 	board_nmi_handler_setup = mips_nmi_setup;
 	board_ejtag_handler_setup = mips_ejtag_setup;
 
-	prom_init_cmdline();
+	fw_init_cmdline();
 #ifdef CONFIG_EARLY_PRINTK
-	if ((strstr(prom_getcmdline(), "console=ttyS0")) != NULL)
-		prom_init_early_console(0);
-	else if ((strstr(prom_getcmdline(), "console=ttyS1")) != NULL)
-		prom_init_early_console(1);
+	if ((strstr(fw_getcmdline(), "console=ttyS0")) != NULL)
+		fw_init_early_console(0);
+	else if ((strstr(fw_getcmdline(), "console=ttyS1")) != NULL)
+		fw_init_early_console(1);
 #endif
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-	if ((strstr(prom_getcmdline(), "console=")) == NULL)
-		strcat(prom_getcmdline(), " console=ttyS0,38400n8r");
+	if ((strstr(fw_getcmdline(), "console=")) == NULL)
+		strcat(fw_getcmdline(), " console=ttyS0,38400n8r");
+	console_config();
 #endif
 }
 
diff --git a/arch/mips/mti-sead3/sead3-time.c b/arch/mips/mti-sead3/sead3-time.c
index 048e781..418c07a 100644
--- a/arch/mips/mti-sead3/sead3-time.c
+++ b/arch/mips/mti-sead3/sead3-time.c
@@ -11,7 +11,6 @@
 #include <asm/time.h>
 #include <asm/irq.h>
 #include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/prom.h>
 
 unsigned long cpu_khz;
 
-- 
1.7.9.5
