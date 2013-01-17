Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2013 18:37:07 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:42801 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6833222Ab3AQRhDzaNpJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jan 2013 18:37:03 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TvtOZ-0003Gq-C4; Thu, 17 Jan 2013 11:36:55 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v2] MIPS: malta: Code clean-ups.
Date:   Thu, 17 Jan 2013 11:36:50 -0600
Message-Id: <1358444210-17179-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35483
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

Do whitespace/formatting clean-up and remove obsolete header file.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/mips-boards/prom.h |   47 ------------------------
 arch/mips/mti-malta/malta-display.c      |   39 +++++++++-----------
 arch/mips/mti-malta/malta-init.c         |   58 ++++++++++++++----------------
 arch/mips/mti-malta/malta-memory.c       |   42 +++++++++-------------
 arch/mips/mti-malta/malta-setup.c        |   15 ++++----
 5 files changed, 66 insertions(+), 135 deletions(-)
 delete mode 100644 arch/mips/include/asm/mips-boards/prom.h

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
diff --git a/arch/mips/mti-malta/malta-display.c b/arch/mips/mti-malta/malta-display.c
index 2a0057c..04826d7 100644
--- a/arch/mips/mti-malta/malta-display.c
+++ b/arch/mips/mti-malta/malta-display.c
@@ -1,26 +1,19 @@
 /*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
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
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
  * Display routines for display messages in MIPS boards ascii display.
+ *
+ * Copyright (C) 1999,2000,2012  MIPS Technologies, Inc.
+ * All rights reserved.
+ * Authors: Carsten Langgaard <carstenl@mips.com>
+ *          Steven J. Hill <sjhill@mips.com>
  */
-
 #include <linux/compiler.h>
 #include <linux/timer.h>
-#include <asm/io.h>
+#include <linux/io.h>
+
 #include <asm/mips-boards/generic.h>
 
 extern const char display_string[];
@@ -29,17 +22,17 @@ static unsigned int max_display_count;
 
 void mips_display_message(const char *str)
 {
-	static unsigned int __iomem *display = NULL;
+	static unsigned int __iomem *display;
 	int i;
 
 	if (unlikely(display == NULL))
 		display = ioremap(ASCII_DISPLAY_POS_BASE, 16*sizeof(int));
 
-	for (i = 0; i <= 14; i=i+2) {
-	         if (*str)
-		         __raw_writel(*str++, display + i);
-		 else
-		         __raw_writel(' ', display + i);
+	for (i = 0; i <= 14; i += 2) {
+		if (*str)
+			__raw_writel(*str++, display + i);
+		else
+			__raw_writel(' ', display + i);
 	}
 }
 
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index 6c61e94..0ae857a 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -1,42 +1,29 @@
 /*
- * Copyright (C) 1999, 2000, 2004, 2005  MIPS Technologies, Inc.
- *	All rights reserved.
- *	Authors: Carsten Langgaard <carstenl@mips.com>
- *		 Maciej W. Rozycki <macro@mips.com>
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
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
  * PROM library initialisation code.
+ *
+ * Copyright (C) 1999,2000,2004,2005,2012  MIPS Technologies, Inc.
+ * All rights reserved.
+ * Authors: Carsten Langgaard <carstenl@mips.com>
+ *	    Maciej W. Rozycki <macro@mips.com>
+ *          Steven J. Hill <sjhill@mips.com>
  */
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 
-#include <asm/gt64120.h>
-#include <asm/io.h>
 #include <asm/cacheflush.h>
 #include <asm/smp-ops.h>
 #include <asm/traps.h>
 #include <asm/fw/fw.h>
 #include <asm/gcmpregs.h>
 #include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/bonito64.h>
-#include <asm/mips-boards/msc01_pci.h>
-
 #include <asm/mips-boards/malta.h>
 
-int init_debug;
+extern void mips_display_message(const char *str);
 
 static int mips_revision_corid;
 int mips_revision_sconid;
@@ -64,12 +51,18 @@ static void __init console_config(void)
 		if (s) {
 			while (*s >= '0' && *s <= '9')
 				baud = baud*10 + *s++ - '0';
-			if (*s == ',') s++;
-			if (*s) parity = *s++;
-			if (*s == ',') s++;
-			if (*s) bits = *s++;
-			if (*s == ',') s++;
-			if (*s == 'h') flow = 'r';
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
 		}
 		if (baud == 0)
 			baud = 38400;
@@ -79,7 +72,8 @@ static void __init console_config(void)
 			bits = '8';
 		if (flow == '\0')
 			flow = 'r';
-		sprintf(console_string, " console=ttyS0,%d%c%c%c", baud, parity, bits, flow);
+		sprintf(console_string, " console=ttyS0,%d%c%c%c", baud,
+			parity, bits, flow);
 		strcat(fw_getcmdline(), console_string);
 		pr_info("Config serial console:%s\n", console_string);
 	}
@@ -223,7 +217,7 @@ void __init prom_init(void)
 	case MIPS_REVISION_SCON_SOCIT:
 	case MIPS_REVISION_SCON_ROCIT:
 		_pcictrl_msc = (unsigned long)ioremap(MIPS_MSC01_PCI_REG_BASE, 0x2000);
-	mips_pci_controller:
+mips_pci_controller:
 		mb();
 		MSC_READ(MSC01_PCI_CFG, data);
 		MSC_WRITE(MSC01_PCI_CFG, data & ~MSC01_PCI_CFG_EN_BIT);
@@ -265,7 +259,7 @@ void __init prom_init(void)
 	default:
 		/* Unknown system controller */
 		mips_display_message("SC Error");
-		while (1);   /* We die here... */
+		while (1);	/* We die here... */
 	}
 	board_nmi_handler_setup = mips_nmi_setup;
 	board_ejtag_handler_setup = mips_ejtag_setup;
diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index 06fa4ad..391960a 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -1,31 +1,21 @@
 /*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
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
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
  * PROM library functions for acquiring/using memory descriptors given to
  * us from the YAMON.
+ *
+ * Copyright (C) 1999,2000,2012  MIPS Technologies, Inc.
+ * All rights reserved.
+ * Authors: Carsten Langgaard <carstenl@mips.com>
+ *          Steven J. Hill <sjhill@mips.com>
  */
 #include <linux/init.h>
-#include <linux/mm.h>
 #include <linux/bootmem.h>
-#include <linux/pfn.h>
 #include <linux/string.h>
 
 #include <asm/bootinfo.h>
-#include <asm/page.h>
 #include <asm/sections.h>
 #include <asm/fw/fw.h>
 
@@ -36,19 +26,20 @@ unsigned long physical_memsize = 0L;
 
 fw_memblock_t * __init fw_getmdesc(void)
 {
-	char *memsize_str;
+	char *memsize_str, *ptr;
 	unsigned int memsize;
-	char *ptr;
 	static char cmdline[COMMAND_LINE_SIZE] __initdata;
+	long val;
+	int tmp;
 
 	/* otherwise look in the environment */
 	memsize_str = fw_getenv("memsize");
 	if (!memsize_str) {
-		printk(KERN_WARNING
-		       "memsize not set in boot prom, set to default (32Mb)\n");
+		pr_warn("memsize not set in YAMON, set to default (32Mb)\n");
 		physical_memsize = 0x02000000;
 	} else {
-		physical_memsize = simple_strtol(memsize_str, NULL, 0);
+		tmp = kstrtol(memsize_str, 0, &val);
+		physical_memsize = (unsigned long)val;
 	}
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
@@ -92,7 +83,8 @@ fw_memblock_t * __init fw_getmdesc(void)
 
 	mdesc[3].type = fw_dontuse;
 	mdesc[3].base = 0x00100000;
-	mdesc[3].size = CPHYSADDR(PFN_ALIGN((unsigned long)&_end)) - mdesc[3].base;
+	mdesc[3].size = CPHYSADDR(PFN_ALIGN((unsigned long)&_end)) -
+		mdesc[3].base;
 
 	mdesc[4].type = fw_free;
 	mdesc[4].base = CPHYSADDR(PFN_ALIGN(&_end));
@@ -142,7 +134,7 @@ void __init prom_free_prom_memory(void)
 			continue;
 
 		addr = boot_mem_map.map[i].addr;
-		free_init_pages("prom memory",
+		free_init_pages("YAMON memory",
 				addr, addr + boot_mem_map.map[i].size);
 	}
 }
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 08cdf8f..ed68073 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -117,13 +117,12 @@ static void __init pci_clock_check(void)
 	char *argptr = fw_getcmdline();
 
 	if (pciclock != 33 && !strstr(argptr, "idebus=")) {
-		printk(KERN_WARNING "WARNING: PCI clock is %dMHz, "
-				"setting idebus\n", pciclock);
+		pr_warn("WARNING: PCI clock is %dMHz, setting idebus\n",
+			pciclock);
 		argptr += strlen(argptr);
 		sprintf(argptr, " idebus=%d", pciclock);
 		if (pciclock < 20 || pciclock > 66)
-			printk(KERN_WARNING "WARNING: IDE timing "
-					"calculations will be incorrect\n");
+			pr_warn("WARNING: IDE timing calculations will be incorrect\n");
 	}
 }
 #endif
@@ -155,14 +154,14 @@ static void __init bonito_quirks_setup(void)
 	argptr = fw_getcmdline();
 	if (strstr(argptr, "debug")) {
 		BONITO_BONGENCFG |= BONITO_BONGENCFG_DEBUGMODE;
-		printk(KERN_INFO "Enabled Bonito debug mode\n");
+		pr_info("Enabled Bonito debug mode\n");
 	} else
 		BONITO_BONGENCFG &= ~BONITO_BONGENCFG_DEBUGMODE;
 
 #ifdef CONFIG_DMA_COHERENT
 	if (BONITO_PCICACHECTRL & BONITO_PCICACHECTRL_CPUCOH_PRES) {
 		BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
-		printk(KERN_INFO "Enabled Bonito CPU coherency\n");
+		pr_info("Enabled Bonito CPU coherency\n");
 
 		argptr = fw_getcmdline();
 		if (strstr(argptr, "iobcuncached")) {
@@ -170,13 +169,13 @@ static void __init bonito_quirks_setup(void)
 			BONITO_PCIMEMBASECFG = BONITO_PCIMEMBASECFG &
 				~(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
 					BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
-			printk(KERN_INFO "Disabled Bonito IOBC coherency\n");
+			pr_info("Disabled Bonito IOBC coherency\n");
 		} else {
 			BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_IOBCCOH_EN;
 			BONITO_PCIMEMBASECFG |=
 				(BONITO_PCIMEMBASECFG_MEMBASE0_CACHED |
 					BONITO_PCIMEMBASECFG_MEMBASE1_CACHED);
-			printk(KERN_INFO "Enabled Bonito IOBC coherency\n");
+			pr_info("Enabled Bonito IOBC coherency\n");
 		}
 	} else
 		panic("Hardware DMA cache coherency not supported");
-- 
1.7.9.5
