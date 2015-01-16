Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 13:39:05 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:53217 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010531AbbAPMicIQFEa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 13:38:32 +0100
X-IronPort-AV: E=Sophos;i="5.09,410,1418112000"; 
   d="scan'208";a="54822171"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw3-out.broadcom.com with ESMTP; 16 Jan 2015 04:54:17 -0800
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Fri, 16 Jan 2015 04:38:25 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.3.174.1; Fri, 16 Jan 2015 04:39:03 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 DEBE840FE5;    Fri, 16 Jan 2015 04:37:32 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 2/5] MIPS: Add platform function to fixup memory
Date:   Fri, 16 Jan 2015 18:08:05 +0530
Message-ID: <1421411888-3367-3-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1421411888-3367-1-git-send-email-jchandra@broadcom.com>
References: <1421411888-3367-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Provide a function plat_mem_fixup() that is called after memory
command line args are parsed. This can be used to fixup memory
regions including those passed thru device tree and command line.

In XLR/XLP, use this to reduce the size of the memory segments so
that prefetch will not access illegal addresses.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/kernel/setup.c           |  4 +++
 arch/mips/netlogic/common/Makefile |  1 +
 arch/mips/netlogic/common/memory.c | 53 ++++++++++++++++++++++++++++++++++++++
 arch/mips/netlogic/xlp/setup.c     | 14 ----------
 arch/mips/netlogic/xlr/setup.c     |  3 +--
 5 files changed, 59 insertions(+), 16 deletions(-)
 create mode 100644 arch/mips/netlogic/common/memory.c

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 0589290..d995904 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -614,6 +614,7 @@ static void __init arch_mem_init(char **cmdline_p)
 {
 	struct memblock_region *reg;
 	extern void plat_mem_setup(void);
+	extern void plat_mem_fixup(void);
 
 	/* call board setup routine */
 	plat_mem_setup();
@@ -657,6 +658,9 @@ static void __init arch_mem_init(char **cmdline_p)
 		pr_info("User-defined physical RAM map:\n");
 		print_memory_map();
 	}
+#if defined(CONFIG_CPU_XLP) || defined(CONFIG_CPU_XLR)
+	plat_mem_fixup();
+#endif
 
 	bootmem_init();
 #ifdef CONFIG_PROC_VMCORE
diff --git a/arch/mips/netlogic/common/Makefile b/arch/mips/netlogic/common/Makefile
index 362739d..44b0e7e 100644
--- a/arch/mips/netlogic/common/Makefile
+++ b/arch/mips/netlogic/common/Makefile
@@ -1,5 +1,6 @@
 obj-y				+= irq.o time.o
 obj-y				+= nlm-dma.o
 obj-y				+= reset.o
+obj-y				+= memory.o
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o
 obj-$(CONFIG_EARLY_PRINTK)	+= earlycons.o
diff --git a/arch/mips/netlogic/common/memory.c b/arch/mips/netlogic/common/memory.c
new file mode 100644
index 00000000..980c102
--- /dev/null
+++ b/arch/mips/netlogic/common/memory.c
@@ -0,0 +1,53 @@
+/*
+ * Copyright (c) 2003-2014 Broadcom Corporation
+ * All Rights Reserved
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the Broadcom
+ * license below:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY BROADCOM ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL BROADCOM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include <asm/bootinfo.h>
+#include <asm/types.h>
+
+static const int prefetch_backup = 512;
+
+void __init plat_mem_fixup(void)
+{
+	int i;
+
+	/* fixup entries for prefetch */
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+			continue;
+		boot_mem_map.map[i].size -= prefetch_backup;
+	}
+}
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index f743fd9..adc6390 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -64,18 +64,6 @@ static void nlm_linux_exit(void)
 		cpu_wait();
 }
 
-static void nlm_fixup_mem(void)
-{
-	const int pref_backup = 512;
-	int i;
-
-	for (i = 0; i < boot_mem_map.nr_map; i++) {
-		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
-			continue;
-		boot_mem_map.map[i].size -= pref_backup;
-	}
-}
-
 static void __init xlp_init_mem_from_bars(void)
 {
 	uint64_t map[16];
@@ -114,8 +102,6 @@ void __init plat_mem_setup(void)
 		pr_info("Using DRAM BARs for memory map.\n");
 		xlp_init_mem_from_bars();
 	}
-	/* Calculate and setup wired entries for mapped kernel */
-	nlm_fixup_mem();
 }
 
 const char *get_system_type(void)
diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index d118b9a..714f6a3 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -144,7 +144,6 @@ static void prom_add_memory(void)
 {
 	struct nlm_boot_mem_map *bootm;
 	u64 start, size;
-	u64 pref_backup = 512;	/* avoid pref walking beyond end */
 	int i;
 
 	bootm = (void *)(long)nlm_prom_info.psb_mem_map;
@@ -158,7 +157,7 @@ static void prom_add_memory(void)
 		if (i == 0 && start == 0 && size == 0x0c000000)
 			size = 0x0ff00000;
 
-		add_memory_region(start, size - pref_backup, BOOT_MEM_RAM);
+		add_memory_region(start, size, BOOT_MEM_RAM);
 	}
 }
 
-- 
1.9.1
