Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:55:41 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55017 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903779Ab2FZEvE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:51:04 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbR-0002zj-TU; Mon, 25 Jun 2012 23:42:13 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 19/33] MIPS: Malta: Cleanup firmware support for the Malta platform.
Date:   Mon, 25 Jun 2012 23:41:34 -0500
Message-Id: <1340685708-14408-20-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33832
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
 arch/mips/include/asm/mips-boards/generic.h |    9 +---
 arch/mips/include/asm/mips-boards/prom.h    |   47 -----------------
 arch/mips/mti-malta/Makefile                |    2 +-
 arch/mips/mti-malta/malta-cmdline.c         |   59 ---------------------
 arch/mips/mti-malta/malta-display.c         |    1 -
 arch/mips/mti-malta/malta-init.c            |   51 +++---------------
 arch/mips/mti-malta/malta-memory.c          |   76 ++++++++-------------------
 arch/mips/mti-malta/malta-setup.c           |    9 ++--
 arch/mips/mti-malta/malta-time.c            |    1 -
 9 files changed, 38 insertions(+), 217 deletions(-)
 delete mode 100644 arch/mips/include/asm/mips-boards/prom.h
 delete mode 100644 arch/mips/mti-malta/malta-cmdline.c

diff --git a/arch/mips/include/asm/mips-boards/generic.h b/arch/mips/include/asm/mips-boards/generic.h
index 6e23ceb..cf20a30 100644
--- a/arch/mips/include/asm/mips-boards/generic.h
+++ b/arch/mips/include/asm/mips-boards/generic.h
@@ -30,13 +30,6 @@
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
@@ -93,4 +86,6 @@ extern void mips_pcibios_init(void);
 #define mips_pcibios_init() do { } while (0)
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
index 7c8828f..2a0057c 100644
--- a/arch/mips/mti-malta/malta-display.c
+++ b/arch/mips/mti-malta/malta-display.c
@@ -22,7 +22,6 @@
 #include <linux/timer.h>
 #include <asm/io.h>
 #include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/prom.h>
 
 extern const char display_string[];
 static unsigned int display_count;
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index 27a6cdb..9844f31 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -23,31 +23,21 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 
-#include <asm/bootinfo.h>
 #include <asm/gt64120.h>
 #include <asm/io.h>
 #include <asm/cacheflush.h>
 #include <asm/smp-ops.h>
 #include <asm/traps.h>
 
+#include <asm/fw/fw.h>
 #include <asm/gcmpregs.h>
-#include <asm/mips-boards/prom.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/bonito64.h>
 #include <asm/mips-boards/msc01_pci.h>
 
 #include <asm/mips-boards/malta.h>
 
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
@@ -62,28 +52,6 @@ unsigned long _pcictrl_gt64120;
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
 static inline unsigned char str2hexnum(unsigned char c)
 {
 	if (c >= '0' && c <= '9')
@@ -138,8 +106,8 @@ static void __init console_config(void)
 	char parity = '\0', bits = '\0', flow = '\0';
 	char *s;
 
-	if ((strstr(prom_getcmdline(), "console=")) == NULL) {
-		s = prom_getenv("modetty0");
+	if ((strstr(fw_getcmdline(), "console=")) == NULL) {
+		s = fw_getenv("modetty0");
 		if (s) {
 			while (*s >= '0' && *s <= '9')
 				baud = baud*10 + *s++ - '0';
@@ -159,7 +127,7 @@ static void __init console_config(void)
 		if (flow == '\0')
 			flow = 'r';
 		sprintf(console_string, " console=ttyS0,%d%c%c%c", baud, parity, bits, flow);
-		strcat(prom_getcmdline(), console_string);
+		strcat(fw_getcmdline(), console_string);
 		pr_info("Config serial console:%s\n", console_string);
 	}
 }
@@ -193,10 +161,6 @@ extern struct plat_smp_ops msmtc_smp_ops;
 
 void __init prom_init(void)
 {
-	prom_argc = fw_arg0;
-	_prom_argv = (int *) fw_arg1;
-	_prom_envp = (int *) fw_arg2;
-
 	mips_display_message("LINUX");
 
 	/*
@@ -353,8 +317,9 @@ void __init prom_init(void)
 	board_nmi_handler_setup = mips_nmi_setup;
 	board_ejtag_handler_setup = mips_ejtag_setup;
 
-	prom_init_cmdline();
-	prom_meminit();
+	fw_init_cmdline();
+	fw_meminit();
+
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	console_config();
 #endif
diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index a96d281..cddcd46 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -24,50 +24,31 @@
 #include <linux/pfn.h>
 #include <linux/string.h>
 
-#include <asm/bootinfo.h>
 #include <asm/page.h>
 #include <asm/sections.h>
+#include <asm/fw/fw.h>
 
-#include <asm/mips-boards/prom.h>
-
-/*#define DEBUG*/
-
-enum yamon_memtypes {
-	yamon_dontuse,
-	yamon_prom,
-	yamon_free,
-};
-static struct prom_pmemblock mdesc[PROM_MAX_PMEMBLOCKS];
-
-#ifdef DEBUG
-static char *mtypes[3] = {
-	"Dont use memory",
-	"YAMON PROM memory",
-	"Free memory",
-};
-#endif
+static fw_memblock_t mdesc[FW_MAX_MEMBLOCKS];
 
 /* determined physical memory size, not overridden by command line args  */
 unsigned long physical_memsize = 0L;
 
-static struct prom_pmemblock * __init prom_getmdesc(void)
+fw_memblock_t * __init fw_getmdesc(void)
 {
-	char *memsize_str;
+	char *memsize_str, *ptr;
 	unsigned int memsize;
-	char *ptr;
 	static char cmdline[COMMAND_LINE_SIZE] __initdata;
+	long val;
+	int tmp;
 
 	/* otherwise look in the environment */
-	memsize_str = prom_getenv("memsize");
+	memsize_str = fw_getenv("memsize");
 	if (!memsize_str) {
-		printk(KERN_WARNING
-		       "memsize not set in boot prom, set to default (32Mb)\n");
+		pr_warn("memsize not set in YAMON, set to default (32Mb)\n");
 		physical_memsize = 0x02000000;
 	} else {
-#ifdef DEBUG
-		pr_debug("prom_memsize = %s\n", memsize_str);
-#endif
-		physical_memsize = simple_strtol(memsize_str, NULL, 0);
+		tmp = kstrtol(memsize_str, 0, &val);
+		physical_memsize = (unsigned long)val;
 	}
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
@@ -90,11 +71,11 @@ static struct prom_pmemblock * __init prom_getmdesc(void)
 
 	memset(mdesc, 0, sizeof(mdesc));
 
-	mdesc[0].type = yamon_dontuse;
+	mdesc[0].type = fw_dontuse;
 	mdesc[0].base = 0x00000000;
 	mdesc[0].size = 0x00001000;
 
-	mdesc[1].type = yamon_prom;
+	mdesc[1].type = fw_code;
 	mdesc[1].base = 0x00001000;
 	mdesc[1].size = 0x000ef000;
 
@@ -105,55 +86,44 @@ static struct prom_pmemblock * __init prom_getmdesc(void)
 	 * This mean that this area can't be used as DMA memory for PCI
 	 * devices.
 	 */
-	mdesc[2].type = yamon_dontuse;
+	mdesc[2].type = fw_dontuse;
 	mdesc[2].base = 0x000f0000;
 	mdesc[2].size = 0x00010000;
 
-	mdesc[3].type = yamon_dontuse;
+	mdesc[3].type = fw_dontuse;
 	mdesc[3].base = 0x00100000;
 	mdesc[3].size = CPHYSADDR(PFN_ALIGN((unsigned long)&_end)) - mdesc[3].base;
 
-	mdesc[4].type = yamon_free;
+	mdesc[4].type = fw_free;
 	mdesc[4].base = CPHYSADDR(PFN_ALIGN(&_end));
 	mdesc[4].size = memsize - mdesc[4].base;
 
 	return &mdesc[0];
 }
 
-static int __init prom_memtype_classify(unsigned int type)
+static int __init fw_memtype_classify(unsigned int type)
 {
 	switch (type) {
-	case yamon_free:
+	case fw_free:
 		return BOOT_MEM_RAM;
-	case yamon_prom:
+	case fw_code:
 		return BOOT_MEM_ROM_DATA;
 	default:
 		return BOOT_MEM_RESERVED;
 	}
 }
 
-void __init prom_meminit(void)
+void __init fw_meminit(void)
 {
-	struct prom_pmemblock *p;
+	fw_memblock_t *p;
 
-#ifdef DEBUG
-	pr_debug("YAMON MEMORY DESCRIPTOR dump:\n");
-	p = prom_getmdesc();
-	while (p->size) {
-		int i = 0;
-		pr_debug("[%d,%p]: base<%08lx> size<%08lx> type<%s>\n",
-			 i, p, p->base, p->size, mtypes[p->type]);
-		p++;
-		i++;
-	}
-#endif
-	p = prom_getmdesc();
+	p = fw_getmdesc();
 
 	while (p->size) {
 		long type;
 		unsigned long base, size;
 
-		type = prom_memtype_classify(p->type);
+		type = fw_memtype_classify(p->type);
 		base = p->base;
 		size = p->size;
 
@@ -172,7 +142,7 @@ void __init prom_free_prom_memory(void)
 			continue;
 
 		addr = boot_mem_map.map[i].addr;
-		free_init_pages("prom memory",
+		free_init_pages("YAMON memory",
 				addr, addr + boot_mem_map.map[i].size);
 	}
 }
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 2e28f65..08cdf8f 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -25,9 +25,8 @@
 #include <linux/screen_info.h>
 #include <linux/time.h>
 
-#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
 #include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/prom.h>
 #include <asm/mips-boards/malta.h>
 #include <asm/mips-boards/maltaint.h>
 #include <asm/dma.h>
@@ -115,7 +114,7 @@ static void __init pci_clock_check(void)
 		33, 20, 25, 30, 12, 16, 37, 10
 	};
 	int pciclock = pciclocks[jmpr];
-	char *argptr = prom_getcmdline();
+	char *argptr = fw_getcmdline();
 
 	if (pciclock != 33 && !strstr(argptr, "idebus=")) {
 		printk(KERN_WARNING "WARNING: PCI clock is %dMHz, "
@@ -153,7 +152,7 @@ static void __init bonito_quirks_setup(void)
 {
 	char *argptr;
 
-	argptr = prom_getcmdline();
+	argptr = fw_getcmdline();
 	if (strstr(argptr, "debug")) {
 		BONITO_BONGENCFG |= BONITO_BONGENCFG_DEBUGMODE;
 		printk(KERN_INFO "Enabled Bonito debug mode\n");
@@ -165,7 +164,7 @@ static void __init bonito_quirks_setup(void)
 		BONITO_PCICACHECTRL |= BONITO_PCICACHECTRL_CPUCOH_EN;
 		printk(KERN_INFO "Enabled Bonito CPU coherency\n");
 
-		argptr = prom_getcmdline();
+		argptr = fw_getcmdline();
 		if (strstr(argptr, "iobcuncached")) {
 			BONITO_PCICACHECTRL &= ~BONITO_PCICACHECTRL_IOBCCOH_EN;
 			BONITO_PCIMEMBASECFG = BONITO_PCIMEMBASECFG &
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 115f5bc..8a5d589 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -41,7 +41,6 @@
 #include <asm/msc01_ic.h>
 
 #include <asm/mips-boards/generic.h>
-#include <asm/mips-boards/prom.h>
 
 #include <asm/mips-boards/maltaint.h>
 
-- 
1.7.10.3
