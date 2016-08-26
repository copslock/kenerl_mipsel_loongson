Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 16:24:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19329 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992608AbcHZOWBYoI6n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 16:22:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 39E0F8F4CFA39;
        Fri, 26 Aug 2016 15:21:41 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 15:21:44 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Rob Herring <robh@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 13/19] MIPS: SEAD3: Parse memsize in DT shim
Date:   Fri, 26 Aug 2016 15:17:45 +0100
Message-ID: <20160826141751.13121-14-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826141751.13121-1-paul.burton@imgtec.com>
References: <20160826141751.13121-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54776
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

Parse the memsize argument provided by the bootloader in the DT shim
code, allowing the user to override it on the command line. This places
all of the DT manipulation code into sead3-dtshim.c.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/mti-sead3/sead3-dtshim.c | 71 ++++++++++++++++++++++++++++++++++++++
 arch/mips/mti-sead3/sead3-setup.c  | 66 -----------------------------------
 2 files changed, 71 insertions(+), 66 deletions(-)

diff --git a/arch/mips/mti-sead3/sead3-dtshim.c b/arch/mips/mti-sead3/sead3-dtshim.c
index 6e32ceb..d6b0708 100644
--- a/arch/mips/mti-sead3/sead3-dtshim.c
+++ b/arch/mips/mti-sead3/sead3-dtshim.c
@@ -22,6 +22,73 @@
 
 static unsigned char fdt_buf[16 << 10] __initdata;
 
+static int append_memory(void *fdt)
+{
+	unsigned long phys_memsize, memsize;
+	__be32 mem_array[2];
+	int err, mem_off;
+	char *var;
+
+	/* find memory size from the bootloader environment */
+	var = fw_getenv("memsize");
+	if (var) {
+		err = kstrtoul(var, 0, &phys_memsize);
+		if (err) {
+			pr_err("Failed to read memsize env variable '%s'\n",
+			       var);
+			return -EINVAL;
+		}
+	} else {
+		pr_warn("The bootloader didn't provide memsize: defaulting to 32MB\n");
+		phys_memsize = 32 << 20;
+	}
+
+	/* default to using all available RAM */
+	memsize = phys_memsize;
+
+	/* allow the user to override the usable memory */
+	var = strstr(arcs_cmdline, "memsize=");
+	if (var)
+		memsize = memparse(var + strlen("memsize="), NULL);
+
+	/* if the user says there's more RAM than we thought, believe them */
+	phys_memsize = max_t(unsigned long, phys_memsize, memsize);
+
+	/* find or add a memory node */
+	mem_off = fdt_path_offset(fdt, "/memory");
+	if (mem_off == -FDT_ERR_NOTFOUND)
+		mem_off = fdt_add_subnode(fdt, 0, "memory");
+	if (mem_off < 0) {
+		pr_err("Unable to find or add memory DT node: %d\n", mem_off);
+		return mem_off;
+	}
+
+	err = fdt_setprop_string(fdt, mem_off, "device_type", "memory");
+	if (err) {
+		pr_err("Unable to set memory node device_type: %d\n", err);
+		return err;
+	}
+
+	mem_array[0] = 0;
+	mem_array[1] = cpu_to_be32(phys_memsize);
+	err = fdt_setprop(fdt, mem_off, "reg", mem_array, sizeof(mem_array));
+	if (err) {
+		pr_err("Unable to set memory regs property: %d\n", err);
+		return err;
+	}
+
+	mem_array[0] = 0;
+	mem_array[1] = cpu_to_be32(memsize);
+	err = fdt_setprop(fdt, mem_off, "linux,usable-memory",
+			  mem_array, sizeof(mem_array));
+	if (err) {
+		pr_err("Unable to set linux,usable-memory property: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
 static int remove_gic(void *fdt)
 {
 	const unsigned int cpu_ehci_int = 2;
@@ -205,6 +272,10 @@ void __init *sead3_dt_shim(void *fdt)
 	if (err)
 		panic("Unable to open FDT: %d", err);
 
+	err = append_memory(fdt_buf);
+	if (err)
+		panic("Unable to patch FDT: %d", err);
+
 	err = remove_gic(fdt_buf);
 	if (err)
 		panic("Unable to patch FDT: %d", err);
diff --git a/arch/mips/mti-sead3/sead3-setup.c b/arch/mips/mti-sead3/sead3-setup.c
index c4fc0c6..c915e54 100644
--- a/arch/mips/mti-sead3/sead3-setup.c
+++ b/arch/mips/mti-sead3/sead3-setup.c
@@ -11,7 +11,6 @@
 #include <linux/of_fdt.h>
 
 #include <asm/prom.h>
-#include <asm/fw/fw.h>
 
 #include <asm/mach-sead3/sead3-dtshim.h>
 #include <asm/mips-boards/generic.h>
@@ -21,68 +20,6 @@ const char *get_system_type(void)
 	return "MIPS SEAD3";
 }
 
-static uint32_t get_memsize_from_cmdline(void)
-{
-	int memsize = 0;
-	char *p = arcs_cmdline;
-	char *s = "memsize=";
-
-	p = strstr(p, s);
-	if (p) {
-		p += strlen(s);
-		memsize = memparse(p, NULL);
-	}
-
-	return memsize;
-}
-
-static uint32_t get_memsize_from_env(void)
-{
-	int memsize = 0;
-	char *p;
-
-	p = fw_getenv("memsize");
-	if (p)
-		memsize = memparse(p, NULL);
-
-	return memsize;
-}
-
-static uint32_t get_memsize(void)
-{
-	uint32_t memsize;
-
-	memsize = get_memsize_from_cmdline();
-	if (memsize)
-		return memsize;
-
-	return get_memsize_from_env();
-}
-
-static void __init parse_memsize_param(void)
-{
-	int offset;
-	const uint64_t *prop_value;
-	int prop_len;
-	uint32_t memsize = get_memsize();
-
-	if (!memsize)
-		return;
-
-	offset = fdt_path_offset(__dtb_start, "/memory");
-	if (offset > 0) {
-		uint64_t new_value;
-		/*
-		 * reg contains 2 32-bits BE values, offset and size. We just
-		 * want to replace the size value without affecting the offset
-		 */
-		prop_value = fdt_getprop(__dtb_start, offset, "reg", &prop_len);
-		new_value = be64_to_cpu(*prop_value);
-		new_value =  (new_value & ~0xffffffffllu) | memsize;
-		fdt_setprop_inplace_u64(__dtb_start, offset, "reg", new_value);
-	}
-}
-
 void __init *plat_get_fdt(void)
 {
 	return (void *)__dtb_start;
@@ -92,9 +29,6 @@ void __init plat_mem_setup(void)
 {
 	void *fdt = plat_get_fdt();
 
-	/* allow command line/bootloader env to override memory size in DT */
-	parse_memsize_param();
-
 	fdt = sead3_dt_shim(fdt);
 	__dt_setup_arch(fdt);
 }
-- 
2.9.3
