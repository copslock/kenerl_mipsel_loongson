Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 21:31:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46766 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993457AbdFBTa7oldon (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 21:30:59 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id DE9BB271F1253;
        Fri,  2 Jun 2017 20:30:48 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 20:30:52
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 2/9] MIPS: generic/yamon-dt: Support > 256MB of RAM
Date:   Fri, 2 Jun 2017 12:29:52 -0700
Message-ID: <20170602192959.25435-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602192959.25435-1-paul.burton@imgtec.com>
References: <20170602192959.25435-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58145
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

YAMON can expose more than 256MB of RAM to Linux on Malta by passing an
ememsize environment variable with the full size, but the kernel then
needs to be careful to choose the corresponding physical memory regions,
avoiding the IO memory window. This is platform dependent, and on Malta
it also depends on the memory layout which varies between system
controllers.

Extend yamon_dt_amend_memory() to generically handle this by taking
[e]memsize bytes of memory from an array of memory regions passed in as
a new parameter. Board code provides this array as appropriate depending
on its own memory map.

[paul.burton@imgtec.com: SEAD-3 supports 384MB DDR from 0]

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/generic/board-sead3.c  | 17 +++++++-
 arch/mips/generic/yamon-dt.c     | 92 +++++++++++++++++++++++++++++++---------
 arch/mips/include/asm/yamon-dt.h | 22 ++++++++--
 3 files changed, 106 insertions(+), 25 deletions(-)

diff --git a/arch/mips/generic/board-sead3.c b/arch/mips/generic/board-sead3.c
index 63fdc98738ba..97186a3a5d21 100644
--- a/arch/mips/generic/board-sead3.c
+++ b/arch/mips/generic/board-sead3.c
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <linux/libfdt.h>
 #include <linux/printk.h>
+#include <linux/sizes.h>
 
 #include <asm/fw/fw.h>
 #include <asm/io.h>
@@ -26,6 +27,15 @@
 #define MIPS_REVISION_MACHINE		(0xf << 4)
 #define MIPS_REVISION_MACHINE_SEAD3	(0x4 << 4)
 
+/*
+ * Maximum 384MB RAM at physical address 0, preceding any I/O.
+ */
+static struct yamon_mem_region mem_regions[] __initdata = {
+	/* start	size */
+	{ 0,		SZ_256M + SZ_128M },
+	{}
+};
+
 static __init bool sead3_detect(void)
 {
 	uint32_t rev;
@@ -34,6 +44,11 @@ static __init bool sead3_detect(void)
 	return (rev & MIPS_REVISION_MACHINE) == MIPS_REVISION_MACHINE_SEAD3;
 }
 
+static __init int append_memory(void *fdt)
+{
+	return yamon_dt_append_memory(fdt, mem_regions);
+}
+
 static __init int remove_gic(void *fdt)
 {
 	const unsigned int cpu_ehci_int = 2;
@@ -145,7 +160,7 @@ static __init const void *sead3_fixup_fdt(const void *fdt,
 	if (err)
 		panic("Unable to patch FDT: %d", err);
 
-	err = yamon_dt_append_memory(fdt_buf);
+	err = append_memory(fdt_buf);
 	if (err)
 		panic("Unable to patch FDT: %d", err);
 
diff --git a/arch/mips/generic/yamon-dt.c b/arch/mips/generic/yamon-dt.c
index 9a0c8da5a796..8e36a5baaa7e 100644
--- a/arch/mips/generic/yamon-dt.c
+++ b/arch/mips/generic/yamon-dt.c
@@ -17,6 +17,9 @@
 #include <linux/printk.h>
 
 #include <asm/fw/fw.h>
+#include <asm/yamon-dt.h>
+
+#define MAX_MEM_ARRAY_ENTRIES	2
 
 __init int yamon_dt_append_cmdline(void *fdt)
 {
@@ -43,23 +46,64 @@ __init int yamon_dt_append_cmdline(void *fdt)
 	return 0;
 }
 
-__init int yamon_dt_append_memory(void *fdt)
+static unsigned int __init gen_fdt_mem_array(
+					const struct yamon_mem_region *regions,
+					__be32 *mem_array,
+					unsigned int max_entries,
+					unsigned long memsize)
+{
+	const struct yamon_mem_region *mr;
+	unsigned long size;
+	unsigned int entries = 0;
+
+	for (mr = regions; mr->size && memsize; ++mr) {
+		if (entries >= max_entries) {
+			pr_warn("Number of regions exceeds max %u\n",
+				max_entries);
+			break;
+		}
+
+		/* How much of the remaining RAM fits in the next region? */
+		size = min_t(unsigned long, memsize, mr->size);
+		memsize -= size;
+
+		/* Emit a memory region */
+		*(mem_array++) = cpu_to_be32(mr->start);
+		*(mem_array++) = cpu_to_be32(size);
+		++entries;
+
+		/* Discard the next mr->discard bytes */
+		memsize -= min_t(unsigned long, memsize, mr->discard);
+	}
+	return entries;
+}
+
+__init int yamon_dt_append_memory(void *fdt,
+				  const struct yamon_mem_region *regions)
 {
 	unsigned long phys_memsize, memsize;
-	__be32 mem_array[2];
-	int err, mem_off;
-	char *var;
+	__be32 mem_array[2 * MAX_MEM_ARRAY_ENTRIES];
+	unsigned int mem_entries;
+	int i, err, mem_off;
+	char *var, param_name[10], *var_names[] = {
+		"ememsize", "memsize",
+	};
 
 	/* find memory size from the bootloader environment */
-	var = fw_getenv("memsize");
-	if (var) {
+	for (i = 0; i < ARRAY_SIZE(var_names); i++) {
+		var = fw_getenv(var_names[i]);
+		if (!var)
+			continue;
+
 		err = kstrtoul(var, 0, &phys_memsize);
-		if (err) {
-			pr_err("Failed to read memsize env variable '%s'\n",
-			       var);
-			return -EINVAL;
-		}
-	} else {
+		if (!err)
+			break;
+
+		pr_warn("Failed to read the '%s' env variable '%s'\n",
+			var_names[i], var);
+	}
+
+	if (!phys_memsize) {
 		pr_warn("The bootloader didn't provide memsize: defaulting to 32MB\n");
 		phys_memsize = 32 << 20;
 	}
@@ -68,9 +112,14 @@ __init int yamon_dt_append_memory(void *fdt)
 	memsize = phys_memsize;
 
 	/* allow the user to override the usable memory */
-	var = strstr(arcs_cmdline, "memsize=");
-	if (var)
-		memsize = memparse(var + strlen("memsize="), NULL);
+	for (i = 0; i < ARRAY_SIZE(var_names); i++) {
+		snprintf(param_name, sizeof(param_name), "%s=", var_names[i]);
+		var = strstr(arcs_cmdline, param_name);
+		if (!var)
+			continue;
+
+		memsize = memparse(var + strlen(param_name), NULL);
+	}
 
 	/* if the user says there's more RAM than we thought, believe them */
 	phys_memsize = max_t(unsigned long, phys_memsize, memsize);
@@ -90,18 +139,19 @@ __init int yamon_dt_append_memory(void *fdt)
 		return err;
 	}
 
-	mem_array[0] = 0;
-	mem_array[1] = cpu_to_be32(phys_memsize);
-	err = fdt_setprop(fdt, mem_off, "reg", mem_array, sizeof(mem_array));
+	mem_entries = gen_fdt_mem_array(regions, mem_array,
+					MAX_MEM_ARRAY_ENTRIES, phys_memsize);
+	err = fdt_setprop(fdt, mem_off, "reg",
+			  mem_array, mem_entries * 2 * sizeof(mem_array[0]));
 	if (err) {
 		pr_err("Unable to set memory regs property: %d\n", err);
 		return err;
 	}
 
-	mem_array[0] = 0;
-	mem_array[1] = cpu_to_be32(memsize);
+	mem_entries = gen_fdt_mem_array(regions, mem_array,
+					MAX_MEM_ARRAY_ENTRIES, memsize);
 	err = fdt_setprop(fdt, mem_off, "linux,usable-memory",
-			  mem_array, sizeof(mem_array));
+			  mem_array, mem_entries * 2 * sizeof(mem_array[0]));
 	if (err) {
 		pr_err("Unable to set linux,usable-memory property: %d\n", err);
 		return err;
diff --git a/arch/mips/include/asm/yamon-dt.h b/arch/mips/include/asm/yamon-dt.h
index 3f3367de4836..485cfe3e45e1 100644
--- a/arch/mips/include/asm/yamon-dt.h
+++ b/arch/mips/include/asm/yamon-dt.h
@@ -11,6 +11,20 @@
 #ifndef __MIPS_ASM_YAMON_DT_H__
 #define __MIPS_ASM_YAMON_DT_H__
 
+#include <linux/types.h>
+
+/**
+ * struct yamon_mem_region - Represents a contiguous range of physical RAM.
+ * @start:	Start physical address.
+ * @size:	Maximum size of region.
+ * @discard:	Length of additional memory to discard after the region.
+ */
+struct yamon_mem_region {
+	phys_addr_t	start;
+	phys_addr_t	size;
+	phys_addr_t	discard;
+};
+
 /**
  * yamon_dt_append_cmdline() - Append YAMON-provided command line to /chosen
  * @fdt: the FDT blob
@@ -24,14 +38,16 @@ extern __init int yamon_dt_append_cmdline(void *fdt);
 
 /**
  * yamon_dt_append_memory() - Append YAMON-provided memory info to /memory
- * @fdt: the FDT blob
+ * @fdt:	the FDT blob
+ * @regions:	zero size terminated array of physical memory regions
  *
  * Generate a /memory node in @fdt based upon memory size information provided
- * by YAMON in its environment.
+ * by YAMON in its environment and the @regions array.
  *
  * Return: 0 on success, else -errno
  */
-extern __init int yamon_dt_append_memory(void *fdt);
+extern __init int yamon_dt_append_memory(void *fdt,
+					const struct yamon_mem_region *regions);
 
 /**
  * yamon_dt_serial_config() - Append YAMON-provided serial config to /chosen
-- 
2.13.0
