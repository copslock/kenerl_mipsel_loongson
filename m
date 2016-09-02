Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 17:51:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10831 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992181AbcIBPvQO7GnA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 17:51:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5B4846C8D5646;
        Fri,  2 Sep 2016 16:50:56 +0100 (IST)
Received: from localhost (10.100.200.40) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Sep
 2016 16:50:57 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 05/12] MIPS: Malta: Use all available DDR by default
Date:   Fri, 2 Sep 2016 16:48:51 +0100
Message-ID: <20160902154859.24269-6-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160902154859.24269-1-paul.burton@imgtec.com>
References: <20160902154859.24269-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.40]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55009
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

Malta boards can have more than 256MB DDR available, but we have
previously only made use of up to 256MB (ie. the DDR accessible via
kseg0) by default, without the user manually specifying mem= kernel
parameters. This patch causes all available DDR, as reported by the
bootloader via the ememsize or memsize environment variables or
optionally on the command line, to be used when possible without the
user needing to manually provide the memory ranges.

Malta now has 2 subtly different memory maps which have to be taken into
account when setting this up. The original memory map (referred to by
the code as v1) has up to 2GB of DDR aliased in both the upper & lower
halves of the 32 bit physical address space, with a 256MB I/O region
obscuring 0x10000000-0x1fffffff only in the lower alias. The revised v2
memory map is flat with up to 4GB DDR starting from 0x0, and the I/O
region obscures 256MB of DDR which becomes inacessible. The memory map
in use is indicated by a register provided by the rocit2 system
controller, which is checked in order to set up the kernels memory
ranges accordingly.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/mti-malta/malta-dtshim.c | 109 +++++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mti-malta/malta-dtshim.c b/arch/mips/mti-malta/malta-dtshim.c
index 151f488..5d37b7e 100644
--- a/arch/mips/mti-malta/malta-dtshim.c
+++ b/arch/mips/mti-malta/malta-dtshim.c
@@ -13,18 +13,63 @@
 #include <linux/libfdt.h>
 #include <linux/of_fdt.h>
 #include <linux/sizes.h>
+#include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 #include <asm/fw/fw.h>
 #include <asm/page.h>
 
+#define ROCIT_REG_BASE			0x1f403000
+#define ROCIT_CONFIG_GEN1		(ROCIT_REG_BASE + 0x04)
+#define  ROCIT_CONFIG_GEN1_MEMMAP_SHIFT	8
+#define  ROCIT_CONFIG_GEN1_MEMMAP_MASK	(0xf << 8)
+
 static unsigned char fdt_buf[16 << 10] __initdata;
 
 /* determined physical memory size, not overridden by command line args	 */
 extern unsigned long physical_memsize;
 
-#define MAX_MEM_ARRAY_ENTRIES 1
+enum mem_map {
+	MEM_MAP_V1 = 0,
+	MEM_MAP_V2,
+};
+
+#define MAX_MEM_ARRAY_ENTRIES 2
+
+static __init int malta_scon(void)
+{
+	int scon = MIPS_REVISION_SCONID;
+
+	if (scon != MIPS_REVISION_SCON_OTHER)
+		return scon;
+
+	switch (MIPS_REVISION_CORID) {
+	case MIPS_REVISION_CORID_QED_RM5261:
+	case MIPS_REVISION_CORID_CORE_LV:
+	case MIPS_REVISION_CORID_CORE_FPGA:
+	case MIPS_REVISION_CORID_CORE_FPGAR2:
+		return MIPS_REVISION_SCON_GT64120;
+
+	case MIPS_REVISION_CORID_CORE_EMUL_BON:
+	case MIPS_REVISION_CORID_BONITO64:
+	case MIPS_REVISION_CORID_CORE_20K:
+		return MIPS_REVISION_SCON_BONITO;
+
+	case MIPS_REVISION_CORID_CORE_MSC:
+	case MIPS_REVISION_CORID_CORE_FPGA2:
+	case MIPS_REVISION_CORID_CORE_24K:
+		return MIPS_REVISION_SCON_SOCIT;
+
+	case MIPS_REVISION_CORID_CORE_FPGA3:
+	case MIPS_REVISION_CORID_CORE_FPGA4:
+	case MIPS_REVISION_CORID_CORE_FPGA5:
+	case MIPS_REVISION_CORID_CORE_EMUL_MSC:
+	default:
+		return MIPS_REVISION_SCON_ROCIT;
+	}
+}
 
-static unsigned __init gen_fdt_mem_array(__be32 *mem_array, unsigned long size)
+static unsigned __init gen_fdt_mem_array(__be32 *mem_array, unsigned long size,
+					 enum mem_map map)
 {
 	unsigned long size_preio;
 	unsigned entries;
@@ -39,11 +84,47 @@ static unsigned __init gen_fdt_mem_array(__be32 *mem_array, unsigned long size)
 		 * DDR but limits it to 2GB.
 		 */
 		mem_array[1] = cpu_to_be32(size);
+		goto done;
+	}
+
+	size_preio = min_t(unsigned long, size, SZ_256M);
+	mem_array[1] = cpu_to_be32(size_preio);
+	size -= size_preio;
+	if (!size)
+		goto done;
+
+	if (map == MEM_MAP_V2) {
+		/*
+		 * We have a flat 32 bit physical memory map with DDR filling
+		 * all 4GB of the memory map, apart from the I/O region which
+		 * obscures 256MB from 0x10000000-0x1fffffff.
+		 *
+		 * Therefore we discard the 256MB behind the I/O region.
+		 */
+		if (size <= SZ_256M)
+			goto done;
+		size -= SZ_256M;
+
+		/* Make use of the memory following the I/O region */
+		entries++;
+		mem_array[2] = cpu_to_be32(PHYS_OFFSET + SZ_512M);
+		mem_array[3] = cpu_to_be32(size);
 	} else {
-		size_preio = min_t(unsigned long, size, SZ_256M);
-		mem_array[1] = cpu_to_be32(size_preio);
+		/*
+		 * We have a 32 bit physical memory map with a 2GB DDR region
+		 * aliased in the upper & lower halves of it. The I/O region
+		 * obscures 256MB from 0x10000000-0x1fffffff in the low alias
+		 * but the DDR it obscures is accessible via the high alias.
+		 *
+		 * Simply access everything beyond the lowest 256MB of DDR using
+		 * the high alias.
+		 */
+		entries++;
+		mem_array[2] = cpu_to_be32(PHYS_OFFSET + SZ_2G + SZ_256M);
+		mem_array[3] = cpu_to_be32(size);
 	}
 
+done:
 	BUG_ON(entries > MAX_MEM_ARRAY_ENTRIES);
 	return entries;
 }
@@ -54,6 +135,8 @@ static void __init append_memory(void *fdt, int root_off)
 	unsigned long memsize;
 	unsigned mem_entries;
 	int i, err, mem_off;
+	enum mem_map mem_map;
+	u32 config;
 	char *var, param_name[10], *var_names[] = {
 		"ememsize", "memsize",
 	};
@@ -106,6 +189,20 @@ static void __init append_memory(void *fdt, int root_off)
 	/* if the user says there's more RAM than we thought, believe them */
 	physical_memsize = max_t(unsigned long, physical_memsize, memsize);
 
+	/* detect the memory map in use */
+	if (malta_scon() == MIPS_REVISION_SCON_ROCIT) {
+		/* ROCit has a register indicating the memory map in use */
+		config = readl((void __iomem *)CKSEG1ADDR(ROCIT_CONFIG_GEN1));
+		mem_map = config & ROCIT_CONFIG_GEN1_MEMMAP_MASK;
+		mem_map >>= ROCIT_CONFIG_GEN1_MEMMAP_SHIFT;
+	} else {
+		/* if not using ROCit, presume the v1 memory map */
+		mem_map = MEM_MAP_V1;
+	}
+	if (mem_map > MEM_MAP_V2)
+		panic("Unsupported physical memory map v%u detected",
+		      (unsigned int)mem_map);
+
 	/* append memory to the DT */
 	mem_off = fdt_add_subnode(fdt, root_off, "memory");
 	if (mem_off < 0)
@@ -115,13 +212,13 @@ static void __init append_memory(void *fdt, int root_off)
 	if (err)
 		panic("Unable to set memory node device_type: %d", err);
 
-	mem_entries = gen_fdt_mem_array(mem_array, physical_memsize);
+	mem_entries = gen_fdt_mem_array(mem_array, physical_memsize, mem_map);
 	err = fdt_setprop(fdt, mem_off, "reg", mem_array,
 			  mem_entries * 2 * sizeof(mem_array[0]));
 	if (err)
 		panic("Unable to set memory regs property: %d", err);
 
-	mem_entries = gen_fdt_mem_array(mem_array, memsize);
+	mem_entries = gen_fdt_mem_array(mem_array, memsize, mem_map);
 	err = fdt_setprop(fdt, mem_off, "linux,usable-memory", mem_array,
 			  mem_entries * 2 * sizeof(mem_array[0]));
 	if (err)
-- 
2.9.3
