Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2018 09:48:06 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992571AbeGPHr6hfswt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jul 2018 09:47:58 +0200
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6G7idhx007899
        for <linux-mips@linux-mips.org>; Mon, 16 Jul 2018 03:47:56 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k8q84r3b2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Mon, 16 Jul 2018 03:47:56 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 08:47:54 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 08:47:50 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6G7lnmP37683252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 07:47:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DA3852063;
        Mon, 16 Jul 2018 10:48:08 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.99])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id CA0D652051;
        Mon, 16 Jul 2018 10:48:06 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 16 Jul 2018 10:47:47 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] mips: switch to NO_BOOTMEM
Date:   Mon, 16 Jul 2018 10:47:42 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18071607-0028-0000-0000-000002DC03C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071607-0029-0000-0000-00002393BF4E
Message-Id: <1531727262-11520-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160092
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rppt@linux.vnet.ibm.com
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

MIPS already has memblock support and all the memory is already registered
with it.

This patch replaces bootmem memory reservations with memblock ones and
removes the bootmem initialization.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
The "generic" part was tested with qemu-system-mipsel (both 32 and 64
bits).
loongson3, sgi-ip27 and allyesconfig are build tested only.

 arch/mips/Kconfig                      |  1 +
 arch/mips/kernel/setup.c               | 89 +++++-----------------------------
 arch/mips/loongson64/loongson-3/numa.c | 34 ++++++-------
 arch/mips/sgi-ip27/ip27-memory.c       | 11 ++---
 4 files changed, 33 insertions(+), 102 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 08c10c5..bd15bad 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -76,6 +76,7 @@ config MIPS
 	select RTC_LIB if !MACH_LOONGSON64
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
+	select NO_BOOTMEM
 
 menu "Machine selection"
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2c96c0c..10f46aa 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -327,7 +327,7 @@ static void __init finalize_initrd(void)
 
 	maybe_bswap_initrd();
 
-	reserve_bootmem(__pa(initrd_start), size, BOOTMEM_DEFAULT);
+	memblock_reserve(__pa(initrd_start), size);
 	initrd_below_start_ok = 1;
 
 	pr_info("Initial ramdisk at: 0x%lx (%lu bytes)\n",
@@ -364,20 +364,10 @@ static void __init bootmem_init(void)
 
 #else  /* !CONFIG_SGI_IP27 */
 
-static unsigned long __init bootmap_bytes(unsigned long pages)
-{
-	unsigned long bytes = DIV_ROUND_UP(pages, 8);
-
-	return ALIGN(bytes, sizeof(long));
-}
-
 static void __init bootmem_init(void)
 {
 	unsigned long reserved_end;
-	unsigned long mapstart = ~0UL;
-	unsigned long bootmap_size;
 	phys_addr_t ramstart = PHYS_ADDR_MAX;
-	bool bootmap_valid = false;
 	int i;
 
 	/*
@@ -389,6 +379,8 @@ static void __init bootmem_init(void)
 	init_initrd();
 	reserved_end = (unsigned long) PFN_UP(__pa_symbol(&_end));
 
+	memblock_reserve(PHYS_OFFSET, reserved_end << PAGE_SHIFT);
+
 	/*
 	 * max_low_pfn is not a number of pages. The number of pages
 	 * of the system is given by 'max_low_pfn - min_low_pfn'.
@@ -436,17 +428,16 @@ static void __init bootmem_init(void)
 		if (initrd_end && end <= (unsigned long)PFN_UP(__pa(initrd_end)))
 			continue;
 #endif
-		if (start >= mapstart)
-			continue;
-		mapstart = max(reserved_end, start);
 	}
 
 	/*
 	 * Reserve any memory between the start of RAM and PHYS_OFFSET
 	 */
-	if (ramstart > PHYS_OFFSET)
+	if (ramstart > PHYS_OFFSET) {
 		add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
 				  BOOT_MEM_RESERVED);
+		memblock_reserve(PHYS_OFFSET, ramstart - PHYS_OFFSET);
+	}
 
 	if (min_low_pfn >= max_low_pfn)
 		panic("Incorrect memory mapping !!!");
@@ -472,52 +463,6 @@ static void __init bootmem_init(void)
 		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 	}
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	/*
-	 * mapstart should be after initrd_end
-	 */
-	if (initrd_end)
-		mapstart = max(mapstart, (unsigned long)PFN_UP(__pa(initrd_end)));
-#endif
-
-	/*
-	 * check that mapstart doesn't overlap with any of
-	 * memory regions that have been reserved through eg. DTB
-	 */
-	bootmap_size = bootmap_bytes(max_low_pfn - min_low_pfn);
-
-	bootmap_valid = memory_region_available(PFN_PHYS(mapstart),
-						bootmap_size);
-	for (i = 0; i < boot_mem_map.nr_map && !bootmap_valid; i++) {
-		unsigned long mapstart_addr;
-
-		switch (boot_mem_map.map[i].type) {
-		case BOOT_MEM_RESERVED:
-			mapstart_addr = PFN_ALIGN(boot_mem_map.map[i].addr +
-						boot_mem_map.map[i].size);
-			if (PHYS_PFN(mapstart_addr) < mapstart)
-				break;
-
-			bootmap_valid = memory_region_available(mapstart_addr,
-								bootmap_size);
-			if (bootmap_valid)
-				mapstart = PHYS_PFN(mapstart_addr);
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (!bootmap_valid)
-		panic("No memory area to place a bootmap bitmap");
-
-	/*
-	 * Initialize the boot-time allocator with low memory only.
-	 */
-	if (bootmap_size != init_bootmem_node(NODE_DATA(0), mapstart,
-					 min_low_pfn, max_low_pfn))
-		panic("Unexpected memory size required for bootmap");
-
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long start, end;
 
@@ -566,9 +511,9 @@ static void __init bootmem_init(void)
 		default:
 			/* Not usable memory */
 			if (start > min_low_pfn && end < max_low_pfn)
-				reserve_bootmem(boot_mem_map.map[i].addr,
-						boot_mem_map.map[i].size,
-						BOOTMEM_DEFAULT);
+				memblock_reserve(boot_mem_map.map[i].addr,
+						boot_mem_map.map[i].size);
+
 			continue;
 		}
 
@@ -591,15 +536,9 @@ static void __init bootmem_init(void)
 		size = end - start;
 
 		/* Register lowmem ranges */
-		free_bootmem(PFN_PHYS(start), size << PAGE_SHIFT);
 		memory_present(0, start, end);
 	}
 
-	/*
-	 * Reserve the bootmap memory.
-	 */
-	reserve_bootmem(PFN_PHYS(mapstart), bootmap_size, BOOTMEM_DEFAULT);
-
 #ifdef CONFIG_RELOCATABLE
 	/*
 	 * The kernel reserves all memory below its _end symbol as bootmem,
@@ -901,17 +840,15 @@ static void __init arch_mem_init(char **cmdline_p)
 	if (setup_elfcorehdr && setup_elfcorehdr_size) {
 		printk(KERN_INFO "kdump reserved memory at %lx-%lx\n",
 		       setup_elfcorehdr, setup_elfcorehdr_size);
-		reserve_bootmem(setup_elfcorehdr, setup_elfcorehdr_size,
-				BOOTMEM_DEFAULT);
+		memblock_reserve(setup_elfcorehdr, setup_elfcorehdr_size);
 	}
 #endif
 
 	mips_parse_crashkernel();
 #ifdef CONFIG_KEXEC
 	if (crashk_res.start != crashk_res.end)
-		reserve_bootmem(crashk_res.start,
-				crashk_res.end - crashk_res.start + 1,
-				BOOTMEM_DEFAULT);
+		memblock_reserve(crashk_res.start,
+				 crashk_res.end - crashk_res.start + 1);
 #endif
 	device_tree_init();
 	sparse_init();
@@ -921,7 +858,7 @@ static void __init arch_mem_init(char **cmdline_p)
 	/* Tell bootmem about cma reserved memblock section */
 	for_each_memblock(reserved, reg)
 		if (reg->size != 0)
-			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
+			memblock_reserve(reg->base, reg->size);
 
 	reserve_bootmem_region(__pa_symbol(&__nosave_begin),
 			__pa_symbol(&__nosave_end)); /* Reserve for hibernation */
diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
index 9717106..c1e6ec5 100644
--- a/arch/mips/loongson64/loongson-3/numa.c
+++ b/arch/mips/loongson64/loongson-3/numa.c
@@ -180,43 +180,39 @@ static void __init szmem(unsigned int node)
 
 static void __init node_mem_init(unsigned int node)
 {
-	unsigned long bootmap_size;
 	unsigned long node_addrspace_offset;
-	unsigned long start_pfn, end_pfn, freepfn;
+	unsigned long start_pfn, end_pfn;
 
 	node_addrspace_offset = nid_to_addroffset(node);
 	pr_info("Node%d's addrspace_offset is 0x%lx\n",
 			node, node_addrspace_offset);
 
 	get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
-	freepfn = start_pfn;
-	if (node == 0)
-		freepfn = PFN_UP(__pa_symbol(&_end)); /* kernel end address */
-	pr_info("Node%d: start_pfn=0x%lx, end_pfn=0x%lx, freepfn=0x%lx\n",
-		node, start_pfn, end_pfn, freepfn);
+	pr_info("Node%d: start_pfn=0x%lx, end_pfn=0x%lx\n",
+		node, start_pfn, end_pfn);
 
 	__node_data[node] = prealloc__node_data + node;
 
-	NODE_DATA(node)->bdata = &bootmem_node_data[node];
 	NODE_DATA(node)->node_start_pfn = start_pfn;
 	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
 
-	bootmap_size = init_bootmem_node(NODE_DATA(node), freepfn,
-					start_pfn, end_pfn);
 	free_bootmem_with_active_regions(node, end_pfn);
-	if (node == 0) /* used by finalize_initrd() */
+
+	if (node == 0) {
+		/* kernel end address */
+		unsigned long kernel_end_pfn = PFN_UP(__pa_symbol(&_end));
+
+		/* used by finalize_initrd() */
 		max_low_pfn = end_pfn;
 
-	/* This is reserved for the kernel and bdata->node_bootmem_map */
-	reserve_bootmem_node(NODE_DATA(node), start_pfn << PAGE_SHIFT,
-		((freepfn - start_pfn) << PAGE_SHIFT) + bootmap_size,
-		BOOTMEM_DEFAULT);
+		/* Reserve the kernel text/data/bss */
+		memblock_reserve(start_pfn << PAGE_SHIFT,
+				 ((kernel_end_pfn - start_pfn) << PAGE_SHIFT));
 
-	if (node == 0 && node_end_pfn(0) >= (0xffffffff >> PAGE_SHIFT)) {
 		/* Reserve 0xfe000000~0xffffffff for RS780E integrated GPU */
-		reserve_bootmem_node(NODE_DATA(node),
-				(node_addrspace_offset | 0xfe000000),
-				32 << 20, BOOTMEM_DEFAULT);
+		if (node_end_pfn(0) >= (0xffffffff >> PAGE_SHIFT))
+			memblock_reserve((node_addrspace_offset | 0xfe000000),
+					 32 << 20);
 	}
 
 	sparse_memory_present_with_active_regions(node);
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 59133d0a..6f7bef0 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -389,7 +389,6 @@ static void __init node_mem_init(cnodeid_t node)
 {
 	unsigned long slot_firstpfn = slot_getbasepfn(node, 0);
 	unsigned long slot_freepfn = node_getfirstfree(node);
-	unsigned long bootmap_size;
 	unsigned long start_pfn, end_pfn;
 
 	get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
@@ -400,7 +399,6 @@ static void __init node_mem_init(cnodeid_t node)
 	__node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
 	memset(__node_data[node], 0, PAGE_SIZE);
 
-	NODE_DATA(node)->bdata = &bootmem_node_data[node];
 	NODE_DATA(node)->node_start_pfn = start_pfn;
 	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
 
@@ -409,12 +407,11 @@ static void __init node_mem_init(cnodeid_t node)
 	slot_freepfn += PFN_UP(sizeof(struct pglist_data) +
 			       sizeof(struct hub_data));
 
-	bootmap_size = init_bootmem_node(NODE_DATA(node), slot_freepfn,
-					start_pfn, end_pfn);
 	free_bootmem_with_active_regions(node, end_pfn);
-	reserve_bootmem_node(NODE_DATA(node), slot_firstpfn << PAGE_SHIFT,
-		((slot_freepfn - slot_firstpfn) << PAGE_SHIFT) + bootmap_size,
-		BOOTMEM_DEFAULT);
+
+	memblock_reserve(slot_firstpfn << PAGE_SHIFT,
+			 ((slot_freepfn - slot_firstpfn) << PAGE_SHIFT));
+
 	sparse_memory_present_with_active_regions(node);
 }
 
-- 
2.7.4
