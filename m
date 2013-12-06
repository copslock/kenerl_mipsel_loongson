Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2013 12:01:36 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:31731 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823021Ab3LFLBeJNALj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 Dec 2013 12:01:34 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 1/4] sead3-setup: allow cmdline/env to change memory size using memsize param
Date:   Fri, 6 Dec 2013 11:00:42 +0000
Message-ID: <1386327645-17571-2-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1386327645-17571-1-git-send-email-qais.yousef@imgtec.com>
References: <1386327645-17571-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.36]
X-SEF-Processed: 7_3_0_01192__2013_12_06_11_01_26
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

if the user sets memsize parameter in commandline or bootloader
environment, we use it to modify the built-in dtb memory size

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/Kconfig                 |    1 +
 arch/mips/mti-sead3/Makefile      |    2 +
 arch/mips/mti-sead3/sead3-setup.c |   68 +++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9dbd904..3bc8088 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -347,6 +347,7 @@ config MIPS_SEAD3
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select IRQ_GIC
+	select LIBFDT
 	select MIPS_MSC
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index be11420..071786f 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -21,5 +21,7 @@ obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
 obj-$(CONFIG_USB_EHCI_HCD)	+= sead3-ehci.o
 obj-$(CONFIG_OF)		+= sead3.dtb.o
 
+CFLAGS_sead3-setup.o = -I$(src)/../../../scripts/dtc/libfdt
+
 $(obj)/%.dtb: $(obj)/%.dts
 	$(call if_changed,dtc)
diff --git a/arch/mips/mti-sead3/sead3-setup.c b/arch/mips/mti-sead3/sead3-setup.c
index 928ba84..a499f99 100644
--- a/arch/mips/mti-sead3/sead3-setup.c
+++ b/arch/mips/mti-sead3/sead3-setup.c
@@ -4,13 +4,16 @@
  * for more details.
  *
  * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2013 Imagination Technologies Ltd.
  */
 #include <linux/init.h>
+#include <linux/libfdt.h>
 #include <linux/of_platform.h>
 #include <linux/of_fdt.h>
 #include <linux/bootmem.h>
 
 #include <asm/prom.h>
+#include <asm/fw/fw.h>
 
 #include <asm/mips-boards/generic.h>
 
@@ -19,8 +22,73 @@ const char *get_system_type(void)
 	return "MIPS SEAD3";
 }
 
+static uint32_t get_memsize_from_cmdline(void)
+{
+	int memsize = 0;
+	char *p = arcs_cmdline;
+	char *s = "memsize=";
+
+	p = strstr(p, s);
+	if (p) {
+		p += strlen(s);
+		memsize = memparse(p, NULL);
+	}
+
+	return memsize;
+}
+
+static uint32_t get_memsize_from_env(void)
+{
+	int memsize = 0;
+	char *p;
+
+	p = fw_getenv("memsize");
+	if (p)
+		memsize = memparse(p, NULL);
+
+	return memsize;
+}
+
+static uint32_t get_memsize(void)
+{
+	uint32_t memsize;
+
+	memsize = get_memsize_from_cmdline();
+	if (memsize)
+		return memsize;
+
+	return get_memsize_from_env();
+}
+
+static void __init parse_memsize_param(void)
+{
+	int offset;
+	const uint64_t *prop_value;
+	int prop_len;
+	uint32_t memsize = get_memsize();
+
+	if (!memsize)
+		return;
+
+	offset = fdt_path_offset(&__dtb_start, "/memory");
+	if (offset > 0) {
+		uint64_t new_value;
+		/*
+		 * reg contains 2 32-bits BE values, offset and size. We just
+		 * want to replace the size value without affecting the offset
+		 */
+		prop_value = fdt_getprop(&__dtb_start, offset, "reg", &prop_len);
+		new_value = be64_to_cpu(*prop_value);
+		new_value =  (new_value & ~0xffffffffllu) | memsize;
+		fdt_setprop_inplace_u64(&__dtb_start, offset, "reg", new_value);
+	}
+}
+
 void __init plat_mem_setup(void)
 {
+	/* allow command line/bootloader env to override memory size in DT */
+	parse_memsize_param();
+
 	/*
 	 * Load the builtin devicetree. This causes the chosen node to be
 	 * parsed resulting in our memory appearing
-- 
1.7.1
