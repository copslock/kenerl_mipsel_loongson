Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:53:52 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55009 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903773Ab2FZEui (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:50:38 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbS-0002zj-Gc; Mon, 25 Jun 2012 23:42:14 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 20/33] MIPS: Malta: Cleanup files effected by firmware changes.
Date:   Mon, 25 Jun 2012 23:41:35 -0500
Message-Id: <1340685708-14408-21-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33828
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

Make headers consistent across the files and make changes based on
running the checkpatch script.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/mips-boards/generic.h |   21 ++----
 arch/mips/mti-malta/malta-display.c         |   39 +++++-----
 arch/mips/mti-malta/malta-init.c            |  104 +++++++--------------------
 arch/mips/mti-malta/malta-memory.c          |   32 ++++-----
 arch/mips/mti-malta/malta-setup.c           |   51 +++++--------
 arch/mips/mti-malta/malta-time.c            |   65 ++++++-----------
 6 files changed, 99 insertions(+), 213 deletions(-)

diff --git a/arch/mips/include/asm/mips-boards/generic.h b/arch/mips/include/asm/mips-boards/generic.h
index cf20a30..d99f5b6 100644
--- a/arch/mips/include/asm/mips-boards/generic.h
+++ b/arch/mips/include/asm/mips-boards/generic.h
@@ -1,21 +1,14 @@
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
  * Defines of the MIPS boards specific address-MAP, registers, etc.
+ *
+ * Copyright (C) 2000,2012 MIPS Technologies, Inc.
+ * All rights reserved.
+ * Authors: Carsten Langgaard <carstenl@mips.com>
+ *          Steven J. Hill <sjhill@mips.com>
  */
 #ifndef __ASM_MIPS_BOARDS_GENERIC_H
 #define __ASM_MIPS_BOARDS_GENERIC_H
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
index 9844f31..0ae857a 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -1,40 +1,26 @@
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
-
 #include <asm/fw/fw.h>
 #include <asm/gcmpregs.h>
 #include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/bonito64.h>
-#include <asm/mips-boards/msc01_pci.h>
-
 #include <asm/mips-boards/malta.h>
 
 extern void mips_display_message(const char *str);
@@ -52,52 +38,6 @@ unsigned long _pcictrl_gt64120;
 /* MIPS System controller register base */
 unsigned long _pcictrl_msc;
 
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
@@ -111,12 +51,18 @@ static void __init console_config(void)
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
@@ -126,7 +72,8 @@ static void __init console_config(void)
 			bits = '8';
 		if (flow == '\0')
 			flow = 'r';
-		sprintf(console_string, " console=ttyS0,%d%c%c%c", baud, parity, bits, flow);
+		sprintf(console_string, " console=ttyS0,%d%c%c%c", baud,
+			parity, bits, flow);
 		strcat(fw_getcmdline(), console_string);
 		pr_info("Config serial console:%s\n", console_string);
 	}
@@ -270,7 +217,7 @@ void __init prom_init(void)
 	case MIPS_REVISION_SCON_SOCIT:
 	case MIPS_REVISION_SCON_ROCIT:
 		_pcictrl_msc = (unsigned long)ioremap(MIPS_MSC01_PCI_REG_BASE, 0x2000);
-	mips_pci_controller:
+mips_pci_controller:
 		mb();
 		MSC_READ(MSC01_PCI_CFG, data);
 		MSC_WRITE(MSC01_PCI_CFG, data & ~MSC01_PCI_CFG_EN_BIT);
@@ -312,14 +259,13 @@ void __init prom_init(void)
 	default:
 		/* Unknown system controller */
 		mips_display_message("SC Error");
-		while (1);   /* We die here... */
+		while (1);	/* We die here... */
 	}
 	board_nmi_handler_setup = mips_nmi_setup;
 	board_ejtag_handler_setup = mips_ejtag_setup;
 
 	fw_init_cmdline();
 	fw_meminit();
-
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	console_config();
 #endif
diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index cddcd46..cfea067 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -1,30 +1,21 @@
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
 
-#include <asm/page.h>
+#include <asm/bootinfo.h>
 #include <asm/sections.h>
 #include <asm/fw/fw.h>
 
@@ -92,7 +83,8 @@ fw_memblock_t * __init fw_getmdesc(void)
 
 	mdesc[3].type = fw_dontuse;
 	mdesc[3].base = 0x00100000;
-	mdesc[3].size = CPHYSADDR(PFN_ALIGN((unsigned long)&_end)) - mdesc[3].base;
+	mdesc[3].size = CPHYSADDR(PFN_ALIGN((unsigned long)&_end)) -
+		mdesc[3].base;
 
 	mdesc[4].type = fw_free;
 	mdesc[4].base = CPHYSADDR(PFN_ALIGN(&_end));
@@ -128,7 +120,7 @@ void __init fw_meminit(void)
 		size = p->size;
 
 		add_memory_region(base, size, type);
-                p++;
+		p++;
 	}
 }
 
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 08cdf8f..dd3288a 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -1,39 +1,23 @@
 /*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
- * Copyright (C) 2008 Dmitri Vorobiev
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
+ * Copyright (C) 2000,2012  MIPS Technologies, Inc.
+ * All rights reserved.
+ * Authors: Carsten Langgaard <carstenl@mips.com>
+ *          Steven J. Hill <sjhill@mips.com>
  *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ * Copyright (C) 2008 Dmitri Vorobiev
  */
-#include <linux/cpu.h>
 #include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/ioport.h>
-#include <linux/irq.h>
 #include <linux/pci.h>
 #include <linux/screen_info.h>
-#include <linux/time.h>
 
-#include <asm/fw/fw.h>
-#include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/malta.h>
-#include <asm/mips-boards/maltaint.h>
 #include <asm/dma.h>
 #include <asm/traps.h>
-#ifdef CONFIG_VT
-#include <linux/console.h>
-#endif
+#include <asm/fw/fw.h>
+#include <asm/mips-boards/generic.h>
 
 extern void malta_be_init(void);
 extern int malta_be_handler(struct pt_regs *regs, int is_fixup);
@@ -117,13 +101,12 @@ static void __init pci_clock_check(void)
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
@@ -155,14 +138,14 @@ static void __init bonito_quirks_setup(void)
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
@@ -170,13 +153,13 @@ static void __init bonito_quirks_setup(void)
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
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 8a5d589..0045e31 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -1,47 +1,22 @@
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
  * Setting up the clock on the MIPS boards.
+ *
+ * Copyright (C) 1999,2000,2012  MIPS Technologies, Inc.
+ * All rights reserved.
+ * Authors: Carsten Langgaard <carstenl@mips.com>
+ *          Steven J. Hill <sjhill@mips.com>
  */
-
-#include <linux/types.h>
-#include <linux/i8253.h>
 #include <linux/init.h>
-#include <linux/kernel_stat.h>
-#include <linux/sched.h>
-#include <linux/spinlock.h>
-#include <linux/interrupt.h>
-#include <linux/time.h>
-#include <linux/timex.h>
-#include <linux/mc146818rtc.h>
-
-#include <asm/mipsregs.h>
-#include <asm/mipsmtregs.h>
-#include <asm/hardirq.h>
-#include <asm/irq.h>
-#include <asm/div64.h>
-#include <asm/cpu.h>
+#include <linux/i8253.h>
+
 #include <asm/setup.h>
 #include <asm/time.h>
 #include <asm/mc146818-time.h>
-#include <asm/msc01_ic.h>
-
 #include <asm/mips-boards/generic.h>
-
 #include <asm/mips-boards/maltaint.h>
 
 unsigned long cpu_khz;
@@ -74,15 +49,19 @@ static unsigned int __init estimate_cpu_frequency(void)
 	local_irq_save(flags);
 
 	/* Start counter exactly on falling edge of update flag */
-	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
-	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
+	while (CMOS_READ(RTC_REG_A) & RTC_UIP)
+		;
+	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP))
+		;
 
 	/* Start r4k counter. */
 	start = read_c0_count();
 
 	/* Read counter exactly on falling edge of update flag */
-	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
-	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
+	while (CMOS_READ(RTC_REG_A) & RTC_UIP)
+		;
+	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP))
+		;
 
 	count = read_c0_count() - start;
 
@@ -145,15 +124,15 @@ void __init plat_time_init(void)
 {
 	unsigned int est_freq;
 
-        /* Set Data mode - binary. */
-        CMOS_WRITE(CMOS_READ(RTC_CONTROL) | RTC_DM_BINARY, RTC_CONTROL);
+	/* Set Data mode - binary. */
+	CMOS_WRITE(CMOS_READ(RTC_CONTROL) | RTC_DM_BINARY, RTC_CONTROL);
 
 	est_freq = estimate_cpu_frequency();
 
-	printk("CPU frequency %d.%02d MHz\n", est_freq/1000000,
+	pr_info("CPU frequency %d.%02d MHz\n", est_freq/1000000,
 	       (est_freq%1000000)*100/1000000);
 
-        cpu_khz = est_freq / 1000;
+	cpu_khz = est_freq / 1000;
 
 	mips_scroll_message();
 #ifdef CONFIG_I8253		/* Only Malta has a PIT */
-- 
1.7.10.3
