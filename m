Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2013 18:37:48 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:42805 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6832251Ab3AQRhOfNf8U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jan 2013 18:37:14 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TvtOm-0003H0-CY; Thu, 17 Jan 2013 11:37:08 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v4] OF: MIPS: sead3: Implement OF support.
Date:   Thu, 17 Jan 2013 11:37:03 -0600
Message-Id: <1358444223-17247-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35485
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

Activate USE_OF for SEAD-3 platform. Add basic DTS file and convert
memory detection and reservations to use OF.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/Kconfig                           |    1 +
 arch/mips/include/asm/mips-boards/generic.h |    4 +
 arch/mips/mti-sead3/Makefile                |   10 +-
 arch/mips/mti-sead3/sead3-init.c            |    5 +-
 arch/mips/mti-sead3/sead3-memory.c          |  138 ---------------------------
 arch/mips/mti-sead3/sead3-setup.c           |   27 ++++++
 arch/mips/mti-sead3/sead3.dts               |   26 +++++
 7 files changed, 70 insertions(+), 141 deletions(-)
 delete mode 100644 arch/mips/mti-sead3/sead3-memory.c
 create mode 100644 arch/mips/mti-sead3/sead3.dts

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 86153b6..88af14c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -355,6 +355,7 @@ config MIPS_SEAD3
 	select USB_ARCH_HAS_EHCI
 	select USB_EHCI_BIG_ENDIAN_DESC
 	select USB_EHCI_BIG_ENDIAN_MMIO
+	select USE_OF
 	help
 	  This enables support for the MIPS Technologies SEAD3 evaluation
 	  board.
diff --git a/arch/mips/include/asm/mips-boards/generic.h b/arch/mips/include/asm/mips-boards/generic.h
index 6e23ceb..c01e286 100644
--- a/arch/mips/include/asm/mips-boards/generic.h
+++ b/arch/mips/include/asm/mips-boards/generic.h
@@ -87,6 +87,10 @@
 
 extern int mips_revision_sconid;
 
+#ifdef CONFIG_OF
+extern struct boot_param_header __dtb_start;
+#endif
+
 #ifdef CONFIG_PCI
 extern void mips_pcibios_init(void);
 #else
diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index 626afea..10ec701 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -5,10 +5,12 @@
 # Copyright (C) 2008 Wind River Systems, Inc.
 #   written by Ralf Baechle <ralf@linux-mips.org>
 #
+# Copyright (C) 2012 MIPS Technoligies, Inc.  All rights reserved.
+# Steven J. Hill <sjhill@mips.com>
+#
 obj-y				:= sead3-lcd.o sead3-cmdline.o \
 				   sead3-display.o sead3-init.o sead3-int.o \
-				   sead3-mtd.o sead3-net.o \
-				   sead3-memory.o sead3-platform.o \
+				   sead3-mtd.o sead3-net.o sead3-platform.o \
 				   sead3-reset.o sead3-setup.o sead3-time.o
 
 obj-y				+= sead3-i2c-dev.o sead3-i2c.o \
@@ -17,3 +19,7 @@ obj-y				+= sead3-i2c-dev.o sead3-i2c.o \
 
 obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
 obj-$(CONFIG_USB_EHCI_HCD)	+= sead3-ehci.o
+obj-$(CONFIG_OF)		+= sead3.dtb.o
+
+$(obj)/%.dtb: $(obj)/%.dts
+	$(call if_changed,dtc)
diff --git a/arch/mips/mti-sead3/sead3-init.c b/arch/mips/mti-sead3/sead3-init.c
index 802fce2..6939254 100644
--- a/arch/mips/mti-sead3/sead3-init.c
+++ b/arch/mips/mti-sead3/sead3-init.c
@@ -125,7 +125,6 @@ void __init prom_init(void)
 	board_ejtag_handler_setup = mips_ejtag_setup;
 
 	prom_init_cmdline();
-	prom_meminit();
 #ifdef CONFIG_EARLY_PRINTK
 	if ((strstr(prom_getcmdline(), "console=ttyS0")) != NULL)
 		prom_init_early_console(0);
@@ -137,3 +136,7 @@ void __init prom_init(void)
 		strcat(prom_getcmdline(), " console=ttyS0,38400n8r");
 #endif
 }
+
+void prom_free_prom_memory(void)
+{
+}
diff --git a/arch/mips/mti-sead3/sead3-memory.c b/arch/mips/mti-sead3/sead3-memory.c
deleted file mode 100644
index da92441..0000000
--- a/arch/mips/mti-sead3/sead3-memory.c
+++ /dev/null
@@ -1,138 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- */
-#include <linux/bootmem.h>
-
-#include <asm/bootinfo.h>
-#include <asm/sections.h>
-#include <asm/mips-boards/prom.h>
-
-enum yamon_memtypes {
-	yamon_dontuse,
-	yamon_prom,
-	yamon_free,
-};
-
-static struct prom_pmemblock mdesc[PROM_MAX_PMEMBLOCKS];
-
-/* determined physical memory size, not overridden by command line args  */
-unsigned long physical_memsize = 0L;
-
-struct prom_pmemblock * __init prom_getmdesc(void)
-{
-	char *memsize_str, *ptr;
-	unsigned int memsize;
-	static char cmdline[COMMAND_LINE_SIZE] __initdata;
-	long val;
-	int tmp;
-
-	/* otherwise look in the environment */
-	memsize_str = prom_getenv("memsize");
-	if (!memsize_str) {
-		pr_warn("memsize not set in boot prom, set to default 32Mb\n");
-		physical_memsize = 0x02000000;
-	} else {
-		tmp = kstrtol(memsize_str, 0, &val);
-		physical_memsize = (unsigned long)val;
-	}
-
-#ifdef CONFIG_CPU_BIG_ENDIAN
-	/* SOC-it swaps, or perhaps doesn't swap, when DMA'ing the last
-	   word of physical memory */
-	physical_memsize -= PAGE_SIZE;
-#endif
-
-	/* Check the command line for a memsize directive that overrides
-	   the physical/default amount */
-	strcpy(cmdline, arcs_cmdline);
-	ptr = strstr(cmdline, "memsize=");
-	if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
-		ptr = strstr(ptr, " memsize=");
-
-	if (ptr)
-		memsize = memparse(ptr + 8, &ptr);
-	else
-		memsize = physical_memsize;
-
-	memset(mdesc, 0, sizeof(mdesc));
-
-	mdesc[0].type = yamon_dontuse;
-	mdesc[0].base = 0x00000000;
-	mdesc[0].size = 0x00001000;
-
-	mdesc[1].type = yamon_prom;
-	mdesc[1].base = 0x00001000;
-	mdesc[1].size = 0x000ef000;
-
-	/*
-	 * The area 0x000f0000-0x000fffff is allocated for BIOS memory by the
-	 * south bridge and PCI access always forwarded to the ISA Bus and
-	 * BIOSCS# is always generated.
-	 * This mean that this area can't be used as DMA memory for PCI
-	 * devices.
-	 */
-	mdesc[2].type = yamon_dontuse;
-	mdesc[2].base = 0x000f0000;
-	mdesc[2].size = 0x00010000;
-
-	mdesc[3].type = yamon_dontuse;
-	mdesc[3].base = 0x00100000;
-	mdesc[3].size = CPHYSADDR(PFN_ALIGN((unsigned long)&_end)) -
-		mdesc[3].base;
-
-	mdesc[4].type = yamon_free;
-	mdesc[4].base = CPHYSADDR(PFN_ALIGN(&_end));
-	mdesc[4].size = memsize - mdesc[4].base;
-
-	return &mdesc[0];
-}
-
-static int __init prom_memtype_classify(unsigned int type)
-{
-	switch (type) {
-	case yamon_free:
-		return BOOT_MEM_RAM;
-	case yamon_prom:
-		return BOOT_MEM_ROM_DATA;
-	default:
-		return BOOT_MEM_RESERVED;
-	}
-}
-
-void __init prom_meminit(void)
-{
-	struct prom_pmemblock *p;
-
-	p = prom_getmdesc();
-
-	while (p->size) {
-		long type;
-		unsigned long base, size;
-
-		type = prom_memtype_classify(p->type);
-		base = p->base;
-		size = p->size;
-
-		add_memory_region(base, size, type);
-		p++;
-	}
-}
-
-void __init prom_free_prom_memory(void)
-{
-	unsigned long addr;
-	int i;
-
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
-			continue;
-
-		addr = boot_mem_map.map[i].addr;
-		free_init_pages("prom memory",
-				addr, addr + boot_mem_map.map[i].size);
-	}
-}
diff --git a/arch/mips/mti-sead3/sead3-setup.c b/arch/mips/mti-sead3/sead3-setup.c
index 8ad46ad..f012fd1 100644
--- a/arch/mips/mti-sead3/sead3-setup.c
+++ b/arch/mips/mti-sead3/sead3-setup.c
@@ -6,6 +6,12 @@
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
  */
 #include <linux/init.h>
+#include <linux/of_platform.h>
+#include <linux/of_fdt.h>
+#include <linux/bootmem.h>
+
+#include <asm/mips-boards/generic.h>
+#include <asm/prom.h>
 
 int coherentio;		/* 0 => no DMA cache coherency (may be set by user) */
 int hw_coherentio;	/* 0 => no HW DMA cache coherency (reflects real HW) */
@@ -17,4 +23,25 @@ const char *get_system_type(void)
 
 void __init plat_mem_setup(void)
 {
+	/*
+	 * Load the builtin devicetree. This causes the chosen node to be
+	 * parsed resulting in our memory appearing
+	 */
+	__dt_setup_arch(&__dtb_start);
+}
+
+void __init device_tree_init(void)
+{
+	unsigned long base, size;
+
+	if (!initial_boot_params)
+		return;
+
+	base = virt_to_phys((void *)initial_boot_params);
+	size = be32_to_cpu(initial_boot_params->totalsize);
+
+	/* Before we do anything, lets reserve the dt blob */
+	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
+
+	unflatten_device_tree();
 }
diff --git a/arch/mips/mti-sead3/sead3.dts b/arch/mips/mti-sead3/sead3.dts
new file mode 100644
index 0000000..658f437
--- /dev/null
+++ b/arch/mips/mti-sead3/sead3.dts
@@ -0,0 +1,26 @@
+/dts-v1/;
+
+/memreserve/ 0x00000000 0x00001000;	// reserved
+/memreserve/ 0x00001000 0x000ef000;	// ROM data
+/memreserve/ 0x000f0000 0x004cc000;	// reserved
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "mti,sead-3";
+
+	cpus {
+		cpu@0 {
+			compatible = "mti,mips14KEc", "mti,mips14Kc";
+		};
+	};
+
+	chosen {
+		bootargs = "console=ttyS1,38400 rootdelay=10 root=/dev/sda3";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x08000000>;
+	};
+};
-- 
1.7.9.5
