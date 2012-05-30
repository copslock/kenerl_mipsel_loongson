Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2012 00:13:18 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43490 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903652Ab2E3WLL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 May 2012 00:11:11 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SZr6f-00012l-Cl; Wed, 30 May 2012 17:11:05 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 5/5] MIPS: Clean up YAMON support for MIPS Malta and SEAD-3 platforms.
Date:   Wed, 30 May 2012 17:10:55 -0500
Message-Id: <1338415855-11401-6-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1338415855-11401-1-git-send-email-sjhill@mips.com>
References: <1338415855-11401-1-git-send-email-sjhill@mips.com>
X-archive-position: 33497
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
 arch/mips/include/asm/mips-boards/generic.h |   41 ++++++--------
 arch/mips/include/asm/mips-boards/prom.h    |   47 ---------------
 arch/mips/mti-malta/Makefile                |    2 +-
 arch/mips/mti-malta/malta-cmdline.c         |   59 -------------------
 arch/mips/mti-malta/malta-display.c         |    2 +-
 arch/mips/mti-malta/malta-init.c            |   82 +--------------------------
 arch/mips/mti-malta/malta-memory.c          |   10 +---
 arch/mips/mti-malta/malta-setup.c           |   16 +++---
 arch/mips/mti-malta/malta-time.c            |    3 +-
 9 files changed, 32 insertions(+), 230 deletions(-)
 delete mode 100644 arch/mips/include/asm/mips-boards/prom.h
 delete mode 100644 arch/mips/mti-malta/malta-cmdline.c

diff --git a/arch/mips/include/asm/mips-boards/generic.h b/arch/mips/include/asm/mips-boards/generic.h
index 46c0856..3afa531 100644
--- a/arch/mips/include/asm/mips-boards/generic.h
+++ b/arch/mips/include/asm/mips-boards/generic.h
@@ -1,21 +1,10 @@
 /*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- *
- * This program is free software; you can distribute it and/or modify it
- * under the terms of the GNU General Public License (Version 2) as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Defines of the MIPS boards specific address-MAP, registers, etc.
+ * Copyright (C) 2000-2012 MIPS Technologies, Inc.
+ * Copyright (C) 2000-2012 MIPS Technologies, Inc.
  */
 #ifndef __ASM_MIPS_BOARDS_GENERIC_H
 #define __ASM_MIPS_BOARDS_GENERIC_H
@@ -30,18 +19,20 @@
 #define ASCII_DISPLAY_WORD_BASE    0x1f000410
 #define ASCII_DISPLAY_POS_BASE     0x1f000418
 
-
-/*
- * Yamon Prom print address.
- */
-#define YAMON_PROM_PRINT_ADDR      0x1fc00504
-
-
 /*
  * Reset register.
  */
-#define SOFTRES_REG       0x1f000500
-#define GORESET           0x42
+#ifdef CONFIG_MIPS_MALTA
+#define SOFTRES_REG		0x1f000500
+#define GORESET			0x42
+#else
+#ifdef CONFIG_MIPS_SEAD3
+#define SOFTRES_REG		0x1f000050
+#define GORESET			0x4d
+#else
+#error No reset register defined for this platform.
+#endif
+#endif
 
 /*
  * Revision register.
@@ -97,4 +88,6 @@ extern void mips_pcibios_init(void);
 extern void kgdb_config(void);
 #endif
 
+extern void mips_scroll_message(void);
+
 #endif  /* __ASM_MIPS_BOARDS_GENERIC_H */
diff --git a/arch/mips/include/asm/mips-boards/prom.h b/arch/mips/include/asm/mips-boards/prom.h
deleted file mode 100644
index a9db576..0000000
--- a/arch/mips/include/asm/mips-boards/prom.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- *
- * ########################################################################
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * ########################################################################
- *
- * MIPS boards bootprom interface for the Linux kernel.
- *
- */
-
-#ifndef _MIPS_PROM_H
-#define _MIPS_PROM_H
-
-extern char *prom_getcmdline(void);
-extern char *prom_getenv(char *name);
-extern void prom_init_cmdline(void);
-extern void prom_meminit(void);
-extern void prom_fixup_mem_map(unsigned long start_mem, unsigned long end_mem);
-extern void mips_display_message(const char *str);
-extern void mips_display_word(unsigned int num);
-extern void mips_scroll_message(void);
-extern int get_ethernet_addr(char *ethernet_addr);
-
-/* Memory descriptor management. */
-#define PROM_MAX_PMEMBLOCKS    32
-struct prom_pmemblock {
-        unsigned long base; /* Within KSEG0. */
-        unsigned int size;  /* In bytes. */
-        unsigned int type;  /* free or prom memory */
-};
-
-#endif /* !(_MIPS_PROM_H) */
diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index 6079ef3..8d64bd4 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -5,7 +5,7 @@
 # Copyright (C) 2008 Wind River Systems, Inc.
 #   written by Ralf Baechle <ralf@linux-mips.org>
 #
-obj-y				:= malta-amon.o malta-cmdline.o \
+obj-y				:= malta-amon.o \
 				   malta-display.o malta-init.o malta-int.o \
 				   malta-memory.o malta-platform.o \
 				   malta-reset.o malta-setup.o malta-time.o
diff --git a/arch/mips/mti-malta/malta-cmdline.c b/arch/mips/mti-malta/malta-cmdline.c
deleted file mode 100644
index 1871c30..0000000
--- a/arch/mips/mti-malta/malta-cmdline.c
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
- *
- * This program is free software; you can distribute it and/or modify it
- * under the terms of the GNU General Public License (Version 2) as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- * for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Kernel command line creation using the prom monitor (YAMON) argc/argv.
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
-
-void  __init prom_init_cmdline(void)
-{
-	char *cp;
-	int actr;
-
-	actr = 1; /* Always ignore argv[0] */
-
-	cp = &(arcs_cmdline[0]);
-	while(actr < prom_argc) {
-	        strcpy(cp, prom_argv(actr));
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
diff --git a/arch/mips/mti-malta/malta-display.c b/arch/mips/mti-malta/malta-display.c
index 7c8828f..6139be0 100644
--- a/arch/mips/mti-malta/malta-display.c
+++ b/arch/mips/mti-malta/malta-display.c
@@ -22,7 +22,7 @@
 #include <linux/timer.h>
 #include <asm/io.h>
 #include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/prom.h>
+#include <asm/fw/yamon/yamon.h>
 
 extern const char display_string[];
 static unsigned int display_count;
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index 27a6cdb..c47e83c 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -31,23 +31,13 @@
 #include <asm/traps.h>
 
 #include <asm/gcmpregs.h>
-#include <asm/mips-boards/prom.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/bonito64.h>
 #include <asm/mips-boards/msc01_pci.h>
-
 #include <asm/mips-boards/malta.h>
+#include <asm/fw/yamon/yamon.h>
 
-int prom_argc;
-int *_prom_argv, *_prom_envp;
-
-/*
- * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
- * This macro take care of sign extension, if running in 64-bit mode.
- */
-#define prom_envp(index) ((char *)(long)_prom_envp[(index)])
-
-int init_debug;
+extern void mips_display_message(const char *str);
 
 static int mips_revision_corid;
 int mips_revision_sconid;
@@ -62,74 +52,6 @@ unsigned long _pcictrl_gt64120;
 /* MIPS System controller register base */
 unsigned long _pcictrl_msc;
 
-char *prom_getenv(char *envname)
-{
-	/*
-	 * Return a pointer to the given environment variable.
-	 * In 64-bit mode: we're using 64-bit pointers, but all pointers
-	 * in the PROM structures are only 32-bit, so we need some
-	 * workarounds, if we are running in 64-bit mode.
-	 */
-	int i, index=0;
-
-	i = strlen(envname);
-
-	while (prom_envp(index)) {
-		if(strncmp(envname, prom_envp(index), i) == 0) {
-			return(prom_envp(index+1));
-		}
-		index += 2;
-	}
-
-	return NULL;
-}
-
-static inline unsigned char str2hexnum(unsigned char c)
-{
-	if (c >= '0' && c <= '9')
-		return c - '0';
-	if (c >= 'a' && c <= 'f')
-		return c - 'a' + 10;
-	return 0; /* foo */
-}
-
-static inline void str2eaddr(unsigned char *ea, unsigned char *str)
-{
-	int i;
-
-	for (i = 0; i < 6; i++) {
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
-
-	if (init_debug > 1) {
-	        int i;
-		printk("get_ethernet_addr: ");
-	        for (i=0; i<5; i++)
-		        printk("%02x:", (unsigned char)*(ethernet_addr+i));
-		printk("%02x\n", *(ethernet_addr+i));
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 static void __init console_config(void)
 {
diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index d57a233..370bfdf 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -27,16 +27,10 @@
 #include <asm/bootinfo.h>
 #include <asm/page.h>
 #include <asm/sections.h>
-
-#include <asm/mips-boards/prom.h>
+#include <asm/fw/yamon/yamon.h>
 
 /*#define DEBUG*/
 
-enum yamon_memtypes {
-	yamon_dontuse,
-	yamon_prom,
-	yamon_free,
-};
 static struct prom_pmemblock mdesc[PROM_MAX_PMEMBLOCKS];
 
 #ifdef DEBUG
@@ -50,7 +44,7 @@ static char *mtypes[3] = {
 /* determined physical memory size, not overridden by command line args  */
 unsigned long physical_memsize = 0L;
 
-static struct prom_pmemblock * __init prom_getmdesc(void)
+struct prom_pmemblock * __init prom_getmdesc(void)
 {
 	char *memsize_str;
 	unsigned int memsize;
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 4ca09bf..c83c681 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -22,20 +22,20 @@
 #include <linux/ioport.h>
 #include <linux/irq.h>
 #include <linux/pci.h>
-#include <linux/screen_info.h>
 #include <linux/time.h>
+#ifdef CONFIG_VT
+#include <linux/console.h>
+#endif
+#include <linux/screen_info.h>
 
 #include <asm/bootinfo.h>
-#include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/prom.h>
-#include <asm/mips-boards/malta.h>
-#include <asm/mips-boards/maltaint.h>
 #include <asm/dma.h>
 #include <asm/traps.h>
 #include <asm/gcmpregs.h>
-#ifdef CONFIG_VT
-#include <linux/console.h>
-#endif
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-boards/malta.h>
+#include <asm/mips-boards/maltaint.h>
+#include <asm/fw/yamon/yamon.h>
 
 extern void malta_be_init(void);
 extern int malta_be_handler(struct pt_regs *regs, int is_fixup);
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index c9b2eaa..0d21d86 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -42,9 +42,8 @@
 #include <asm/gic.h>
 
 #include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/prom.h>
-
 #include <asm/mips-boards/maltaint.h>
+#include <asm/fw/yamon/yamon.h>
 
 unsigned long cpu_khz;
 
-- 
1.7.10
