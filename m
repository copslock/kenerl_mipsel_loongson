Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2011 02:51:18 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13399 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492823Ab1ANBvN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Jan 2011 02:51:13 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d2fac3c0000>; Thu, 13 Jan 2011 17:51:56 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 13 Jan 2011 17:51:08 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 13 Jan 2011 17:51:08 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p0E1p4U4015959;
        Thu, 13 Jan 2011 17:51:04 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p0E1p1WH015958;
        Thu, 13 Jan 2011 17:51:01 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Handle init mem in systems where kernel does not reside in add_memory_region() memory.
Date:   Thu, 13 Jan 2011 17:51:00 -0800
Message-Id: <1294969860-15926-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 14 Jan 2011 01:51:08.0427 (UTC) FILETIME=[8344B5B0:01CBB38D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This patch addresses a couple of related problems:

1) The kernel may reside in physical memory outside of the ranges set
   by plat_mem_setup().  If this is the case, init mem cannot be
   reused as it resides outside of the range of pages that the kernel
   memory allocators control.

2) initrd images might be loaded in physical memory outside of the
   ranges set by plat_mem_setup().  The memory likewise cannot be
   reused.  The patch doesn't handle this specific case, but the
   infrastructure is useful for future patches that do.

The crux of the problem is that there are memory regions that need be
memory_present(), but that cannot be free_bootmem() at the time of
arch_mem_init().  We create a new type of memory (BOOT_MEM_INIT_RAM)
for use with add_memory_region().  Then arch_mem_init() adds the init
mem with this type if the init mem is not already covered by existing
ranges.

When memory is being freed into the bootmem allocator, we skip the
BOOT_MEM_INIT_RAM ranges so they are not clobbered, but we do signal
them as memory_present().  This way when they are later freed, the
necessary memory manager structures have initialized and the Sparse
allocater is prevented from crashing.

The Octeon specific code that handled this case is removed, because
the new general purpose code handles the case.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/setup.c  |    8 -------
 arch/mips/include/asm/bootinfo.h |    1 +
 arch/mips/kernel/setup.c         |   43 ++++++++++++++++++++++++++++++++++---
 arch/mips/mm/init.c              |    9 ++++++-
 4 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 26e9bb3..b4a977b 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -654,14 +654,6 @@ void __init plat_mem_setup(void)
 
 	total = 0;
 
-	/* First add the init memory we will be returning.  */
-	memory = __pa_symbol(&__init_begin) & PAGE_MASK;
-	mem_alloc_size = (__pa_symbol(&__init_end) & PAGE_MASK) - memory;
-	if (mem_alloc_size > 0) {
-		add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM);
-		total += mem_alloc_size;
-	}
-
 	/*
 	 * The Mips memory init uses the first memory location for
 	 * some memory vectors. When SPARSEMEM is in use, it doesn't
diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index 35cd1ba..7a51d87 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -86,6 +86,7 @@ extern unsigned long mips_machtype;
 #define BOOT_MEM_RAM		1
 #define BOOT_MEM_ROM_DATA	2
 #define BOOT_MEM_RESERVED	3
+#define BOOT_MEM_INIT_RAM	4
 
 /*
  * A memory map that's built upon what was determined
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8ad1d56..2d4eb68 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -121,6 +121,9 @@ static void __init print_memory_map(void)
 		case BOOT_MEM_RAM:
 			printk(KERN_CONT "(usable)\n");
 			break;
+		case BOOT_MEM_INIT_RAM:
+			printk(KERN_CONT "(usable after init)\n");
+			break;
 		case BOOT_MEM_ROM_DATA:
 			printk(KERN_CONT "(ROM data)\n");
 			break;
@@ -361,15 +364,24 @@ static void __init bootmem_init(void)
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long start, end, size;
 
+		start = PFN_UP(boot_mem_map.map[i].addr);
+		end   = PFN_DOWN(boot_mem_map.map[i].addr
+				    + boot_mem_map.map[i].size);
+
 		/*
 		 * Reserve usable memory.
 		 */
-		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+		switch (boot_mem_map.map[i].type) {
+		case BOOT_MEM_RAM:
+			break;
+		case BOOT_MEM_INIT_RAM:
+			memory_present(0, start, end);
 			continue;
+		default:
+			/* Not usable memory */
+			continue;
+		}
 
-		start = PFN_UP(boot_mem_map.map[i].addr);
-		end   = PFN_DOWN(boot_mem_map.map[i].addr
-				    + boot_mem_map.map[i].size);
 		/*
 		 * We are rounding up the start address of usable memory
 		 * and at the end of the usable range downwards.
@@ -455,11 +467,33 @@ early_param("mem", early_parse_mem);
 
 static void __init arch_mem_init(char **cmdline_p)
 {
+	phys_t init_mem, init_end, init_size;
+
 	extern void plat_mem_setup(void);
 
 	/* call board setup routine */
 	plat_mem_setup();
 
+	init_mem = PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT;
+	init_end = PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT;
+	init_size = init_end - init_mem;
+	if (init_size) {
+		/* Make sure it is in the boot_mem_map */
+		int i, found;
+		found = 0;
+		for (i = 0; i < boot_mem_map.nr_map; i++) {
+			if (init_mem >= boot_mem_map.map[i].addr &&
+			    init_mem < (boot_mem_map.map[i].addr +
+					boot_mem_map.map[i].size)) {
+				found = 1;
+				break;
+			}
+		}
+		if (!found)
+			add_memory_region(init_mem, init_size,
+					  BOOT_MEM_INIT_RAM);
+	}
+
 	pr_info("Determined physical RAM map:\n");
 	print_memory_map();
 
@@ -523,6 +557,7 @@ static void __init resource_init(void)
 		res = alloc_bootmem(sizeof(struct resource));
 		switch (boot_mem_map.map[i].type) {
 		case BOOT_MEM_RAM:
+		case BOOT_MEM_INIT_RAM:
 		case BOOT_MEM_ROM_DATA:
 			res->name = "System RAM";
 			break;
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 2efcbd2..dff6421 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -306,9 +306,14 @@ int page_is_ram(unsigned long pagenr)
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long addr, end;
 
-		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+		switch (boot_mem_map.map[i].type) {
+		case BOOT_MEM_RAM:
+		case BOOT_MEM_INIT_RAM:
+			break;
+		default:
 			/* not usable memory */
 			continue;
+		}
 
 		addr = PFN_UP(boot_mem_map.map[i].addr);
 		end = PFN_DOWN(boot_mem_map.map[i].addr +
@@ -381,7 +386,7 @@ void __init mem_init(void)
 
 	reservedpages = ram = 0;
 	for (tmp = 0; tmp < max_low_pfn; tmp++)
-		if (page_is_ram(tmp)) {
+		if (page_is_ram(tmp) && pfn_valid(tmp)) {
 			ram++;
 			if (PageReserved(pfn_to_page(tmp)))
 				reservedpages++;
-- 
1.7.2.3
