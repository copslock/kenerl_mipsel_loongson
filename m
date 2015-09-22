Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:57:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13683 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009133AbbIVS54JCBtP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:57:56 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 736769EF54916;
        Tue, 22 Sep 2015 19:57:45 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:57:49 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:57:46 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
        "Kumar Gala" <galak@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        "James Hogan" <james.hogan@imgtec.com>,
        Pawel Moll <pawel.moll@arm.com>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/3] MIPS: malta: setup RAM regions via DT
Date:   Tue, 22 Sep 2015 11:56:38 -0700
Message-ID: <1442948198-14507-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442948198-14507-1-git-send-email-paul.burton@imgtec.com>
References: <1442948198-14507-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Move memory configuration to be performed via device tree for the Malta
board. This moves more Malta specific code to malta-dtshim.c, leaving
the rest of the mti-malta code a little more board-agnostic. This will
be useful to share more code between boards, with the device tree
providing the board specifics as intended.

Since we can't rely upon Malta boards running a bootloader capable of
handling devictrees & filling in the required information, a piece of
shim code (malta_dt_shim) is added to consume the (e)memsize variables
provided as part of the bootloader environment (or on the kernel command
line) then generate the DT memory node using the provided values.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/Kconfig                               |   2 +
 arch/mips/boot/dts/mti/malta.dts                |   4 +
 arch/mips/include/asm/mach-malta/malta-dtshim.h |  29 +++++
 arch/mips/mti-malta/Makefile                    |   3 +
 arch/mips/mti-malta/malta-dtshim.c              | 162 ++++++++++++++++++++++++
 arch/mips/mti-malta/malta-memory.c              |  92 --------------
 arch/mips/mti-malta/malta-setup.c               |   5 +-
 7 files changed, 204 insertions(+), 93 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-malta/malta-dtshim.h
 create mode 100644 arch/mips/mti-malta/malta-dtshim.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e3aa5b0..d08b3d1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -449,6 +449,8 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_ZBOOT
 	select USE_OF
 	select ZONE_DMA32 if 64BIT
+	select BUILTIN_DTB
+	select LIBFDT
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
index c678115..b18c466 100644
--- a/arch/mips/boot/dts/mti/malta.dts
+++ b/arch/mips/boot/dts/mti/malta.dts
@@ -1,5 +1,9 @@
 /dts-v1/;
 
+/memreserve/ 0x00000000 0x00001000;	/* YAMON exception vectors */
+/memreserve/ 0x00001000 0x000ef000;	/* YAMON */
+/memreserve/ 0x000f0000 0x00010000;	/* PIIX4 ISA memory */
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/arch/mips/include/asm/mach-malta/malta-dtshim.h b/arch/mips/include/asm/mach-malta/malta-dtshim.h
new file mode 100644
index 0000000..cfd7776
--- /dev/null
+++ b/arch/mips/include/asm/mach-malta/malta-dtshim.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MIPS_MALTA_DTSHIM_H__
+#define __MIPS_MALTA_DTSHIM_H__
+
+#include <linux/init.h>
+
+#ifdef CONFIG_MIPS_MALTA
+
+extern void __init *malta_dt_shim(void *fdt);
+
+#else /* !CONFIG_MIPS_MALTA */
+
+static inline void *malta_dt_shim(void *fdt)
+{
+	return fdt;
+}
+
+#endif /* !CONFIG_MIPS_MALTA */
+
+#endif /* __MIPS_MALTA_DTSHIM_H__ */
diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index 87c85a5..5827af7 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -7,6 +7,7 @@
 #
 obj-y				+= malta-display.o
 obj-y				+= malta-dt.o
+obj-y				+= malta-dtshim.o
 obj-y				+= malta-init.o
 obj-y				+= malta-int.o
 obj-y				+= malta-memory.o
@@ -17,3 +18,5 @@ obj-y				+= malta-time.o
 
 obj-$(CONFIG_MIPS_CMP)		+= malta-amon.o
 obj-$(CONFIG_MIPS_MALTA_PM)	+= malta-pm.o
+
+CFLAGS_malta-dtshim.o = -I$(src)/../../../scripts/dtc/libfdt
diff --git a/arch/mips/mti-malta/malta-dtshim.c b/arch/mips/mti-malta/malta-dtshim.c
new file mode 100644
index 0000000..f7133ef
--- /dev/null
+++ b/arch/mips/mti-malta/malta-dtshim.c
@@ -0,0 +1,162 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/libfdt.h>
+#include <linux/of_fdt.h>
+#include <linux/sizes.h>
+#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
+#include <asm/page.h>
+
+static unsigned char fdt_buf[16 << 10] __initdata;
+
+/* determined physical memory size, not overridden by command line args	 */
+extern unsigned long physical_memsize;
+
+#define MAX_MEM_ARRAY_ENTRIES 1
+
+static unsigned __init gen_fdt_mem_array(__be32 *mem_array, unsigned long size)
+{
+	unsigned long size_preio;
+	unsigned entries;
+
+	entries = 1;
+	mem_array[0] = cpu_to_be32(PHYS_OFFSET);
+	if (config_enabled(CONFIG_EVA)) {
+		/*
+		 * The current Malta EVA configuration is "special" in that it
+		 * always makes use of addresses in the upper half of the 32 bit
+		 * physical address map, which gives it a contiguous region of
+		 * DDR but limits it to 2GB.
+		 */
+		mem_array[1] = cpu_to_be32(size);
+	} else {
+		size_preio = min_t(unsigned long, size, SZ_256M);
+		mem_array[1] = cpu_to_be32(size_preio);
+	}
+
+	BUG_ON(entries > MAX_MEM_ARRAY_ENTRIES);
+	return entries;
+}
+
+static void __init append_memory(void *fdt, int root_off)
+{
+	__be32 mem_array[2 * MAX_MEM_ARRAY_ENTRIES];
+	unsigned long memsize;
+	unsigned mem_entries;
+	int i, err, mem_off;
+	char *var, param_name[10], *var_names[] = {
+		"ememsize", "memsize",
+	};
+
+	/* if a memory node already exists, leave it alone */
+	mem_off = fdt_path_offset(fdt, "/memory");
+	if (mem_off >= 0)
+		return;
+
+	/* find memory size from the bootloader environment */
+	for (i = 0; i < ARRAY_SIZE(var_names); i++) {
+		var = fw_getenv(var_names[i]);
+		if (!var)
+			continue;
+
+		err = kstrtoul(var, 0, &physical_memsize);
+		if (!err)
+			break;
+
+		pr_warn("Failed to read the '%s' env variable '%s'\n",
+			var_names[i], var);
+	}
+
+	if (!physical_memsize) {
+		pr_warn("The bootloader didn't provide memsize: defaulting to 32MB\n");
+		physical_memsize = 32 << 20;
+	}
+
+	if (config_enabled(CONFIG_CPU_BIG_ENDIAN)) {
+		/*
+		 * SOC-it swaps, or perhaps doesn't swap, when DMA'ing
+		 * the last word of physical memory.
+		 */
+		physical_memsize -= PAGE_SIZE;
+	}
+
+	/* default to using all available RAM */
+	memsize = physical_memsize;
+
+	/* allow the user to override the usable memory */
+	for (i = 0; i < ARRAY_SIZE(var_names); i++) {
+		snprintf(param_name, sizeof(param_name), "%s=", var_names[i]);
+		var = strstr(arcs_cmdline, param_name);
+		if (!var)
+			continue;
+
+		memsize = memparse(var + strlen(param_name), NULL);
+	}
+
+	/* if the user says there's more RAM than we thought, believe them */
+	physical_memsize = max_t(unsigned long, physical_memsize, memsize);
+
+	/* append memory to the DT */
+	mem_off = fdt_add_subnode(fdt, root_off, "memory");
+	if (mem_off < 0)
+		panic("Unable to add memory node to DT: %d", mem_off);
+
+	err = fdt_setprop_string(fdt, mem_off, "device_type", "memory");
+	if (err)
+		panic("Unable to set memory node device_type: %d", err);
+
+	mem_entries = gen_fdt_mem_array(mem_array, physical_memsize);
+	err = fdt_setprop(fdt, mem_off, "reg", mem_array,
+			  mem_entries * 2 * sizeof(mem_array[0]));
+	if (err)
+		panic("Unable to set memory regs property: %d", err);
+
+	mem_entries = gen_fdt_mem_array(mem_array, memsize);
+	err = fdt_setprop(fdt, mem_off, "linux,usable-memory", mem_array,
+			  mem_entries * 2 * sizeof(mem_array[0]));
+	if (err)
+		panic("Unable to set linux,usable-memory property: %d", err);
+}
+
+void __init *malta_dt_shim(void *fdt)
+{
+	int root_off, len, err;
+	const char *compat;
+
+	if (fdt_check_header(fdt))
+		panic("Corrupt DT");
+
+	err = fdt_open_into(fdt, fdt_buf, sizeof(fdt_buf));
+	if (err)
+		panic("Unable to open FDT: %d", err);
+
+	root_off = fdt_path_offset(fdt_buf, "/");
+	if (root_off < 0)
+		panic("No / node in DT");
+
+	compat = fdt_getprop(fdt_buf, root_off, "compatible", &len);
+	if (!compat)
+		panic("No root compatible property in DT: %d", len);
+
+	/* if this isn't Malta, leave the DT alone */
+	if (strncmp(compat, "mti,malta", len))
+		return fdt;
+
+	append_memory(fdt_buf, root_off);
+
+	err = fdt_pack(fdt_buf);
+	if (err)
+		panic("Unable to pack FDT: %d\n", err);
+
+	return fdt_buf;
+}
diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index 93ace96..d5f8dae 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -32,101 +32,9 @@ static void free_init_pages_eva_malta(void *begin, void *end)
 
 void __init fw_meminit(void)
 {
-	char *memsize_str, *ememsize_str = NULL, *ptr;
-	unsigned long memsize = 0, ememsize = 0;
-	unsigned long kernel_start_phys, kernel_end_phys;
-	static char cmdline[COMMAND_LINE_SIZE] __initdata;
 	bool eva = config_enabled(CONFIG_EVA);
-	int tmp;
 
 	free_init_pages_eva = eva ? free_init_pages_eva_malta : NULL;
-
-	memsize_str = fw_getenv("memsize");
-	if (memsize_str) {
-		tmp = kstrtoul(memsize_str, 0, &memsize);
-		if (tmp)
-			pr_warn("Failed to read the 'memsize' env variable.\n");
-	}
-	if (eva) {
-	/* Look for ememsize for EVA */
-		ememsize_str = fw_getenv("ememsize");
-		if (ememsize_str) {
-			tmp = kstrtoul(ememsize_str, 0, &ememsize);
-			if (tmp)
-				pr_warn("Failed to read the 'ememsize' env variable.\n");
-		}
-	}
-	if (!memsize && !ememsize) {
-		pr_warn("memsize not set in YAMON, set to default (32Mb)\n");
-		physical_memsize = 0x02000000;
-	} else {
-		if (memsize > (256 << 20)) { /* memsize should be capped to 256M */
-			pr_warn("Unsupported memsize value (0x%lx) detected! "
-				"Using 0x10000000 (256M) instead\n",
-				memsize);
-			memsize = 256 << 20;
-		}
-		/* If ememsize is set, then set physical_memsize to that */
-		physical_memsize = ememsize ? : memsize;
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
-	/* And now look for ememsize */
-	if (eva) {
-		ptr = strstr(cmdline, "ememsize=");
-		if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
-			ptr = strstr(ptr, " ememsize=");
-	}
-
-	if (ptr)
-		memsize = memparse(ptr + 8 + (eva ? 1 : 0), &ptr);
-	else
-		memsize = physical_memsize;
-
-	/* Last 64K for HIGHMEM arithmetics */
-	if (memsize > 0x7fff0000)
-		memsize = 0x7fff0000;
-
-	add_memory_region(PHYS_OFFSET, 0x00001000, BOOT_MEM_RESERVED);
-
-	/*
-	 * YAMON may still be using the region of memory from 0x1000 to 0xfffff
-	 * if it has started secondary CPUs.
-	 */
-	add_memory_region(PHYS_OFFSET + 0x00001000, 0x000ef000,
-			  BOOT_MEM_ROM_DATA);
-
-	/*
-	 * The area 0x000f0000-0x000fffff is allocated for BIOS memory by the
-	 * south bridge and PCI access always forwarded to the ISA Bus and
-	 * BIOSCS# is always generated.
-	 * This mean that this area can't be used as DMA memory for PCI
-	 * devices.
-	 */
-	add_memory_region(PHYS_OFFSET + 0x000f0000, 0x00010000,
-			  BOOT_MEM_RESERVED);
-
-	/*
-	 * Reserve the memory used by kernel code, and allow the rest of RAM to
-	 * be used.
-	 */
-	kernel_start_phys = PHYS_OFFSET + 0x00100000;
-	kernel_end_phys = PHYS_OFFSET + CPHYSADDR(PFN_ALIGN(&_end));
-	add_memory_region(kernel_start_phys, kernel_end_phys,
-			  BOOT_MEM_RESERVED);
-	add_memory_region(kernel_end_phys, memsize - kernel_end_phys,
-			  BOOT_MEM_RAM);
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 9d1e7f5..4740c82 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -27,6 +27,7 @@
 #include <linux/time.h>
 
 #include <asm/fw/fw.h>
+#include <asm/mach-malta/malta-dtshim.h>
 #include <asm/mips-cm.h>
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/malta.h>
@@ -250,8 +251,10 @@ static void __init bonito_quirks_setup(void)
 void __init plat_mem_setup(void)
 {
 	unsigned int i;
+	void *fdt = __dtb_start;
 
-	__dt_setup_arch(__dtb_start);
+	fdt = malta_dt_shim(fdt);
+	__dt_setup_arch(fdt);
 
 	if (config_enabled(CONFIG_EVA))
 		/* EVA has already been configured in mach-malta/kernel-init.h */
-- 
2.5.3
