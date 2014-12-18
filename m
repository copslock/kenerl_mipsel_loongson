Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 11:23:05 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:48898 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008664AbaLRKWHQDT0h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 11:22:07 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 18 Dec
 2014 13:22:01 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 08/12] MIPS: OCTEON: Add ability to used an initrd from a named memory block.
Date:   Thu, 18 Dec 2014 13:18:00 +0300
Message-ID: <1418897888-17669-9-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418897888-17669-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418897888-17669-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

From: David Daney <david.daney@cavium.com>

If 'rd_name=xxx' is passed to the kernel, the named block with name
'xxx' is used for the initrd.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
[aleksey.makarov@auriga.com: conflict resolution]
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/cavium-octeon/setup.c  | 37 +++++++++++++++++++++++++++++++++----
 arch/mips/include/asm/bootinfo.h |  1 +
 arch/mips/kernel/setup.c         | 19 ++++++++++++++++---
 3 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 627f9e8..8bba56f 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -28,6 +28,7 @@
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
 #include <linux/kexec.h>
+#include <linux/initrd.h>
 
 #include <asm/processor.h>
 #include <asm/reboot.h>
@@ -264,6 +265,9 @@ static int octeon_uart;
 
 extern asmlinkage void handle_int(void);
 
+/* If an initrd named block is specified, its name goes here. */
+static char rd_name[64] __initdata;
+
 /**
  * Return non zero if we are currently running in the Octeon simulator
  *
@@ -812,6 +816,10 @@ void __init prom_init(void)
 				MAX_MEMORY = 32ull << 30;
 			if (*p == '@')
 				RESERVE_LOW_MEM = memparse(p + 1, &p);
+		} else if (strncmp(arg, "rd_name=", 8) == 0) {
+			strncpy(rd_name, arg + 8, sizeof(rd_name));
+			rd_name[sizeof(rd_name) - 1] = 0;
+			goto append_arg;
 #ifdef CONFIG_KEXEC
 		} else if (strncmp(arg, "crashkernel=", 12) == 0) {
 			crashk_size = memparse(arg+12, &p);
@@ -824,11 +832,15 @@ void __init prom_init(void)
 			 * parse_crashkernel(arg, sysinfo->system_dram_size,
 			 *		  &crashk_size, &crashk_base);
 			 */
+			goto append_arg;
 #endif
-		} else if (strlen(arcs_cmdline) + strlen(arg) + 1 <
-			   sizeof(arcs_cmdline) - 1) {
-			strcat(arcs_cmdline, " ");
-			strcat(arcs_cmdline, arg);
+		} else {
+append_arg:
+			if (strlen(arcs_cmdline) + strlen(arg) + 1
+				< sizeof(arcs_cmdline) - 1) {
+				strcat(arcs_cmdline, " ");
+				strcat(arcs_cmdline, arg);
+			}
 		}
 	}
 
@@ -892,6 +904,23 @@ void __init plat_mem_setup(void)
 	total = 0;
 	crashk_end = 0;
 
+#ifdef CONFIG_BLK_DEV_INITRD
+
+	if (rd_name[0]) {
+		const struct cvmx_bootmem_named_block_desc *initrd_block;
+
+		initrd_block = cvmx_bootmem_find_named_block(rd_name);
+		if (initrd_block != NULL) {
+			initrd_start = initrd_block->base_addr + PAGE_OFFSET;
+			initrd_end = initrd_start + initrd_block->size;
+			add_memory_region(initrd_block->base_addr,
+				initrd_block->size, BOOT_MEM_INIT_RAM);
+			initrd_in_reserved = 1;
+			total += initrd_block->size;
+		}
+	}
+#endif
+
 	/*
 	 * The Mips memory init uses the first memory location for
 	 * some memory vectors. When SPARSEMEM is in use, it doesn't
diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index 1f7ca8b..0720562 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -108,6 +108,7 @@ struct boot_mem_map {
 };
 
 extern struct boot_mem_map boot_mem_map;
+extern bool initrd_in_reserved;
 
 extern void add_memory_region(phys_t start, phys_t size, long type);
 extern void detect_memory_region(phys_t start, phys_t sz_min,  phys_t sz_max);
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f3b635f..b9adfc06 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -62,6 +62,7 @@ unsigned long mips_machtype __read_mostly = MACH_UNKNOWN;
 EXPORT_SYMBOL(mips_machtype);
 
 struct boot_mem_map boot_mem_map;
+bool initrd_in_reserved;
 
 static char __initdata command_line[COMMAND_LINE_SIZE];
 char __initdata arcs_cmdline[COMMAND_LINE_SIZE];
@@ -307,8 +308,14 @@ static void __init bootmem_init(void)
 	 * as our memory range starting point. Once bootmem is inited we
 	 * will reserve the area used for the initrd.
 	 */
-	init_initrd();
-	reserved_end = (unsigned long) PFN_UP(__pa_symbol(&_end));
+
+	if (initrd_in_reserved) {
+		init_initrd();
+		reserved_end = (unsigned long) PFN_UP(__pa_symbol(&_end));
+	} else {
+		reserved_end = max_t(unsigned long, init_initrd(),
+				     PFN_UP(__pa_symbol(&_end)));
+	}
 
 	/*
 	 * max_low_pfn is not a number of pages. The number of pages
@@ -323,8 +330,14 @@ static void __init bootmem_init(void)
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long start, end;
 
-		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+		switch (boot_mem_map.map[i].type) {
+		case BOOT_MEM_RAM:
+		case BOOT_MEM_INIT_RAM:
+			break;
+		default:
+			/* Not usable memory */
 			continue;
+		}
 
 		start = PFN_UP(boot_mem_map.map[i].addr);
 		end = PFN_DOWN(boot_mem_map.map[i].addr
-- 
2.1.3
