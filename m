Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2011 02:56:42 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13504 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492830Ab1ANBz4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jan 2011 02:55:56 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d2fad5a0000>; Thu, 13 Jan 2011 17:56:42 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 13 Jan 2011 17:55:54 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 13 Jan 2011 17:55:54 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p0E1tnt4016168;
        Thu, 13 Jan 2011 17:55:49 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p0E1tm81016167;
        Thu, 13 Jan 2011 17:55:48 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Octeon: Add initrd from named block support.
Date:   Thu, 13 Jan 2011 17:55:43 -0800
Message-Id: <1294970143-16124-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1294970143-16124-1-git-send-email-ddaney@caviumnetworks.com>
References: <1294970143-16124-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 14 Jan 2011 01:55:54.0370 (UTC) FILETIME=[2DB42620:01CBB38E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Many Octeon bootloaders have the ability to create named blocks of
memory.  Add the ability to use an initrd loaded into such a block.
Since the block may be anywhere in memory, set initrd_not_reserved and
add it as BOOT_MEM_INIT_RAM region, allowing the memory to be reused.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/setup.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index b4a977b..2c3c439 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -20,6 +20,9 @@
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
+#ifdef CONFIG_BLK_DEV_INITRD
+#include <linux/initrd.h>
+#endif
 
 #include <asm/processor.h>
 #include <asm/reboot.h>
@@ -64,6 +67,9 @@ static int octeon_uart;
 extern asmlinkage void handle_int(void);
 extern asmlinkage void plat_irq_dispatch(void);
 
+/* If an initrd named block is specified, its name goes here. */
+static char __initdata rd_name[64];
+
 /**
  * Return non zero if we are currently running in the Octeon simulator
  *
@@ -585,13 +591,18 @@ void __init prom_init(void)
 			MAX_MEMORY <<= 20;
 			if (MAX_MEMORY == 0)
 				MAX_MEMORY = 32ull << 30;
-		} else if (strcmp(arg, "ecc_verbose") == 0) {
+		} else if (strncmp(arg, "rd_name=", 8) == 0) {
+			strncpy(rd_name, arg + 8, sizeof(rd_name));
+			rd_name[sizeof(rd_name) - 1] = 0;
+		}
 #ifdef CONFIG_CAVIUM_REPORT_SINGLE_BIT_ECC
+		else if (strcmp(arg, "ecc_verbose") == 0) {
 			__cvmx_interrupt_ecc_report_single_bit_errors = 1;
 			pr_notice("Reporting of single bit ECC errors is "
 				  "turned on\n");
+		}
 #endif
-		} else if (strlen(arcs_cmdline) + strlen(arg) + 1 <
+		else if (strlen(arcs_cmdline) + strlen(arg) + 1 <
 			   sizeof(arcs_cmdline) - 1) {
 			strcat(arcs_cmdline, " ");
 			strcat(arcs_cmdline, arg);
@@ -649,11 +660,22 @@ static __init void memory_exclude_page(u64 addr, u64 *mem, u64 *size)
 void __init plat_mem_setup(void)
 {
 	uint64_t mem_alloc_size;
-	uint64_t total;
+	uint64_t total = 0;
 	int64_t memory;
 
-	total = 0;
 
+#ifdef CONFIG_BLK_DEV_INITRD
+	const struct cvmx_bootmem_named_block_desc *initrd_block;
+
+	if (rd_name[0] &&
+	    (initrd_block = cvmx_bootmem_find_named_block(rd_name)) != NULL) {
+		initrd_start = initrd_block->base_addr + PAGE_OFFSET;
+		initrd_end = initrd_start + initrd_block->size;
+		add_memory_region(initrd_block->base_addr, initrd_block->size,
+				  BOOT_MEM_INIT_RAM);
+		initrd_not_reserved = 1;
+	}
+#endif
 	/*
 	 * The Mips memory init uses the first memory location for
 	 * some memory vectors. When SPARSEMEM is in use, it doesn't
-- 
1.7.2.3
