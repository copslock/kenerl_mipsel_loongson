Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 17:57:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49367 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026815AbbEVP4vZim1L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 17:56:51 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 855C958CC834C;
        Fri, 22 May 2015 16:56:44 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 22 May 2015 16:55:43 +0100
Received: from localhost (192.168.159.131) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 May
 2015 16:55:42 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "Paul Burton" <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 14/15] MIPS: malta: setup RAM regions via DT
Date:   Fri, 22 May 2015 16:51:13 +0100
Message-ID: <1432309875-9712-15-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.131]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47567
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
handling devictrees & filling in the required information, the
malta_dt_shim code is extended to consume the (e)memsize variables
provided as part of the bootloader environment (or on the kernel command
line) then generate the DT memory node using the provided values.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/boot/dts/mti/malta.dts   |   4 ++
 arch/mips/mti-malta/malta-dtshim.c | 104 +++++++++++++++++++++++++++++++++++++
 arch/mips/mti-malta/malta-memory.c |  88 -------------------------------
 3 files changed, 108 insertions(+), 88 deletions(-)

diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
index 9720c66..2fe2364 100644
--- a/arch/mips/boot/dts/mti/malta.dts
+++ b/arch/mips/boot/dts/mti/malta.dts
@@ -1,5 +1,9 @@
 /dts-v1/;
 
+/memreserve/ 0x00000000 0x00001000;	/* reserved */
+/memreserve/ 0x00001000 0x000ef000;	/* YAMON */
+/memreserve/ 0x000f0000 0x00010000;	/* PIIX4 ISA memory */
+
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/mips-gic.h>
 
diff --git a/arch/mips/mti-malta/malta-dtshim.c b/arch/mips/mti-malta/malta-dtshim.c
index ca33201..9074951 100644
--- a/arch/mips/mti-malta/malta-dtshim.c
+++ b/arch/mips/mti-malta/malta-dtshim.c
@@ -20,6 +20,109 @@
 
 static unsigned char fdt_buf[16 << 10] __initdata;
 
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
+		mem_array[1] = cpu_to_be32(PHYS_OFFSET + size);
+	} else {
+		size_preio = min_t(unsigned long, size, 256 << 20);
+		mem_array[1] = cpu_to_be32(PHYS_OFFSET + size_preio);
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
 static void __init remove_gic(void *fdt)
 {
 	int err, gic_off, i8259_off, cpu_off;
@@ -118,6 +221,7 @@ void __init *malta_dt_shim(void *fdt)
 	if (strncmp(compat, "mti,malta", len))
 		return fdt;
 
+	append_memory(fdt_buf, root_off);
 	remove_gic(fdt_buf);
 
 	err = fdt_pack(fdt_buf);
diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index 831f583..5203241 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -32,97 +32,9 @@ static void free_init_pages_eva_malta(void *begin, void *end)
 
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
-- 
2.4.1
