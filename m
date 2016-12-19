Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 03:13:35 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36760 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993059AbcLSCIM5y67K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 03:08:12 +0100
Received: by mail-lf0-f65.google.com with SMTP id o20so6141549lfg.3;
        Sun, 18 Dec 2016 18:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mjKmhU3mFd/9LEdwlqnynhGcnXvHkk9RMNq7Cs+NL3s=;
        b=WcL5kcRJKrBMBT14Xvdd70hHXubF8qDF8fbctro91faKpLPlt38we8Dpl/vESbTliS
         KFSxAFFWMAni4l1CdH4Z7r4YzDovOTM7yzjYnlYyzqVR9t+wG9jzV+9cnPUpyyGWILqW
         Wh8jdRhmiCyFpoKilVFEiC7uf1ng0YvKvns5R2Gyr2d36t82GmPyVcNF0h6cRj9ZhgLb
         6aqL5HELKD696+kuvxwnjQce7iA/OV3EOSi+MlTwJHGMh+4EfpeBb6fGovnbEtxlyybD
         eqDFiaKyq/UAX8OxICyxo9yd4R5aHHojdLYZRbuE6vEnrbfOgHezqq9oVxRtyM46hFFD
         LEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mjKmhU3mFd/9LEdwlqnynhGcnXvHkk9RMNq7Cs+NL3s=;
        b=DfUEyVYOkEij2cCSRYFHBrPSPSc9uyw4cKHWto4vz93PuVJenZLisIcRizD+7G8Puq
         qArCxxegOB2T3dO3es+j1OZ2EM3tfMV7sYWMAITW3U3IeSgnnSCldUYPHrHe9T94Xhk5
         CddUzu3vguhcr/bNJ3yk6KEiOjpQZXb2aj9EdHQ2qi1yqXDiX18asXREq9OoiW3BFSkt
         wMOW8fOVOaNgcWgkdux7sdYbWySV8D+qXbv1Bx30DADChETTlg10Q7J47bF8tWWAo0qY
         8HGONlqGUe6osT9C6xNBk8KP9PpdWNsqHt+xTCeExZI9fCpa5lEL+2W+sDEq+z/nJ6zi
         zboQ==
X-Gm-Message-State: AIkVDXL0ij5t0sc3uxKqWmF9w+rz3rDKBBJHX4O4/qIhNIEAVPHJT6Px1TG0u1glrOXqiQ==
X-Received: by 10.46.74.26 with SMTP id x26mr5664832lja.51.1482113287431;
        Sun, 18 Dec 2016 18:08:07 -0800 (PST)
Received: from linux.local ([95.79.144.28])
        by smtp.gmail.com with ESMTPSA id 9sm3362103ljn.20.2016.12.18.18.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 18:08:06 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 13/21] MIPS memblock: Add memblock allocator initialization
Date:   Mon, 19 Dec 2016 05:07:38 +0300
Message-Id: <1482113266-13207-14-git-send-email-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Initialization is done by subsequent performing of the following
steps:
1) Call platform-specific call adding memory regions
2) Parse kernel parameters looking (they may change memory layout)
3) Check whether declared memory is in sane
4) Reserve memory for kernel, initrd, crashdump, fdt, devices and CMA
5) Find PFN limits of the memory regions
6) Allow memblocks resize
7) Perform basic paging subsystem initialization: nodes, zones, page
tables (if necessary), kernel mapping and so on.

Sparse sections initialization is moved into mem_init() method

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 93 +++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 22 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 409d23d..b18d38c 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -9,6 +9,7 @@
  * Copyright (C) 1996 Stoned Elipot
  * Copyright (C) 1999 Silicon Graphics, Inc.
  * Copyright (C) 2000, 2001, 2002, 2007	 Maciej W. Rozycki
+ * Copyright (C) 2016 T-platforms
  */
 #include <linux/init.h>
 #include <linux/ioport.h>
@@ -27,6 +28,7 @@
 #include <linux/device.h>
 #include <linux/dma-contiguous.h>
 #include <linux/decompress/generic.h>
+#include <linux/of_fdt.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -733,20 +735,34 @@ static void __init find_pfn_limits(void)
 }
 
 /*
- * Initialize the bootmem allocator. It also setup initrd related data
- * if needed.
+ * Initialize the memblock allocator
  */
 #if defined(CONFIG_SGI_IP27) || (defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_NUMA))
 
-static void __init bootmem_init(void)
+static void __init mips_bootmem_init(void)
 {
+	/* Reserve kernel code/data memory */
+	mips_reserve_kernel_mem();
+
 	/* Check and reserve memory occupied by initrd */
 	mips_reserve_initrd_mem();
+
+	/* Reserve memory for elfcorehdr */
+	mips_reserve_elfcorehdr();
+
+	/* Parse crashkernel parameter */
+	mips_parse_crashkernel();
+
+	/* Reserve memory for DMA contiguous allocator */
+	dma_contiguous_reserve(mips_lowmem_limit);
+
+	/* Allow memblock resize from now */
+	memblock_allow_resize();
 }
 
 #else  /* !CONFIG_SGI_IP27 */
 
-static void __init bootmem_init(void)
+static void __init mips_bootmem_init(void)
 {
 	/* Reserve kernel code/data memory */
 	mips_reserve_kernel_mem();
@@ -760,8 +776,23 @@ static void __init bootmem_init(void)
 	/* Parse crashkernel parameter */
 	mips_parse_crashkernel();
 
+	/*
+	 * Platform code usually copies fdt, but still lets reserve its memory
+	 * in case if it doesn't
+	 */
+	early_init_fdt_reserve_self();
+
+	/* Scan reserved-memory nodes of fdt */
+	early_init_fdt_scan_reserved_mem();
+
+	/* Reserve memory for DMA contiguous allocator */
+	dma_contiguous_reserve(mips_lowmem_limit);
+
 	/* Find memory PFN limits */
 	find_pfn_limits();
+
+	/* Allow memblock resize from now */
+	memblock_allow_resize();
 }
 
 #endif	/* CONFIG_SGI_IP27 */
@@ -770,30 +801,51 @@ static void __init bootmem_init(void)
  * arch_mem_init - initialize memory management subsystem
  *
  *  o plat_mem_setup() detects the memory configuration and will record detected
- *    memory areas using add_memory_region.
+ *    memory areas using add_memory_region, which in addition preinitializes
+ *    memblock ranges.
  *
  * At this stage the memory configuration of the system is known to the
  * kernel but generic memory management system is still entirely uninitialized.
  *
- *  o bootmem_init()
- *  o sparse_init()
- *  o paging_init()
- *  o dma_contiguous_reserve()
+ *  o mips_parse_param() parses parameters passed to the kernel in accordance
+ *    with CMDLINE configs.
+ *  o sanity_check_meminfo() performs memory ranges sanity checks, for
+ *    example, drop high mem regions if it's not supported, set memblock limit
+ *    of low memory allocations
+ *  o mips_bootmem_init() performs memblock further initializations,
+ *    particularly reserve crucial regions, including kernel segments, initrd,
+ *    elfcorehdrm, crashkernel, fdt, DMA contiguous allocator, set PFN-related
+ *    global variables.
+ *  o print_memory_map() prints initialized and verified memory map
+ *  o device_tree_init() calls platform-specific method to perform some
+ *    device tree related operations
+ *  o plat_swiotlb_setup() - platform-specific SWIOTLB setup method
+ *
+ * Basic setup of page allocator is done in setup_arch():
+ *  o paging_init() performs initialization of paging subsystem, in particular
+ *    setup page tables (PGD, PMD, etc), kernel mapping, sparse memory segments
+ *    if supported. It performs memory test if one is enabled. Finally it
+ *    calculates memory zone limits and calls free_area_init_node()
+ *    initializing pages memory maps, nodes, nodes free areas - basis of the
+ *    buddy allocator.
  *
  * At this stage the bootmem allocator is ready to use.
  *
  * NOTE: historically plat_mem_setup did the entire platform initialization.
- *	 This was rather impractical because it meant plat_mem_setup had to
+ *       This was rather impractical because it meant plat_mem_setup had to
  * get away without any kind of memory allocator.  To keep old code from
  * breaking plat_setup was just renamed to plat_mem_setup and a second platform
  * initialization hook for anything else was introduced.
+ * Additionally boot_mem_map structure used to keep base memory layout so
+ * then ancient bootmem allocator would be properly initialized. Since memblock
+ * allocator is used for early memory management now, the boot_mem_map is
+ * conserved just for compatibility.
+ */
+/*
+ * MIPS early memory manager setup
  */
-
 static void __init arch_mem_init(char **cmdline_p)
 {
-	struct memblock_region *reg;
-	extern void plat_mem_setup(void);
-
 	/* call board setup routine */
 	plat_mem_setup();
 
@@ -803,20 +855,17 @@ static void __init arch_mem_init(char **cmdline_p)
 	/* Sanity check the specified memory */
 	sanity_check_meminfo();
 
-	bootmem_init();
+	/* Initialize memblock allocator */
+	mips_bootmem_init();
 
 	/* Print memory map initialized by arch-specific code and params */
 	print_memory_map();
 
+	/* Perform platform-specific device tree scanning */
 	device_tree_init();
-	sparse_init();
-	plat_swiotlb_setup();
 
-	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
-	/* Tell bootmem about cma reserved memblock section */
-	for_each_memblock(reserved, reg)
-		if (reg->size != 0)
-			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
+	/* Perform platform-specific SWIOTLB setup */
+	plat_swiotlb_setup();
 }
 
 static void __init resource_init(void)
-- 
2.6.6
