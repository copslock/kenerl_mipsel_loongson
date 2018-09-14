Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 14:11:28 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993094AbeINMLOM1DfF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2018 14:11:14 +0200
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8EC58qj009981
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2018 08:11:13 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mgamuw5m1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2018 08:11:12 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <rppt@linux.vnet.ibm.com>;
        Fri, 14 Sep 2018 13:11:10 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Sep 2018 13:10:59 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8ECAwcw655672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Sep 2018 12:10:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F68742041;
        Fri, 14 Sep 2018 15:10:48 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AE5042049;
        Fri, 14 Sep 2018 15:10:43 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.116])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 14 Sep 2018 15:10:43 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Fri, 14 Sep 2018 15:10:52 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jonas Bonn <jonas@southpole.se>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <lftan@altera.com>,
        Mark Salter <msalter@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 01/30] mips: switch to NO_BOOTMEM
Date:   Fri, 14 Sep 2018 15:10:16 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091412-0008-0000-0000-000002715A42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091412-0009-0000-0000-000021D9A024
Message-Id: <1536927045-23536-2-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809140129
Return-Path: <rppt@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66259
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

Since memblock allocates memory in top-down mode, we ensure that memblock
limit is max_low_pfn to prevent allocations from the high memory.

To have the exceptions base in the lower 512M of the physical memory, its
allocation in arch/mips/kernel/traps.c::traps_init() is using bottom-up
mode.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/mips/Kconfig                      |  1 +
 arch/mips/kernel/setup.c               | 99 ++++++++--------------------------
 arch/mips/kernel/traps.c               |  3 ++
 arch/mips/loongson64/loongson-3/numa.c | 34 ++++++------
 arch/mips/sgi-ip27/ip27-memory.c       | 11 ++--
 5 files changed, 46 insertions(+), 102 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 54532f2..1b5fa1a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -78,6 +78,7 @@ config MIPS
 	select RTC_LIB
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
+	select NO_BOOTMEM
 
 menu "Machine selection"
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 32fc11d..2fde53e 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -333,7 +333,7 @@ static void __init finalize_initrd(void)
 
 	maybe_bswap_initrd();
 
-	reserve_bootmem(__pa(initrd_start), size, BOOTMEM_DEFAULT);
+	memblock_reserve(__pa(initrd_start), size);
 	initrd_below_start_ok = 1;
 
 	pr_info("Initial ramdisk at: 0x%lx (%lu bytes)\n",
@@ -370,20 +370,10 @@ static void __init bootmem_init(void)
 
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
@@ -395,6 +385,8 @@ static void __init bootmem_init(void)
 	init_initrd();
 	reserved_end = (unsigned long) PFN_UP(__pa_symbol(&_end));
 
+	memblock_reserve(PHYS_OFFSET, reserved_end << PAGE_SHIFT);
+
 	/*
 	 * max_low_pfn is not a number of pages. The number of pages
 	 * of the system is given by 'max_low_pfn - min_low_pfn'.
@@ -442,9 +434,6 @@ static void __init bootmem_init(void)
 		if (initrd_end && end <= (unsigned long)PFN_UP(__pa(initrd_end)))
 			continue;
 #endif
-		if (start >= mapstart)
-			continue;
-		mapstart = max(reserved_end, start);
 	}
 
 	if (min_low_pfn >= max_low_pfn)
@@ -456,9 +445,11 @@ static void __init bootmem_init(void)
 	/*
 	 * Reserve any memory between the start of RAM and PHYS_OFFSET
 	 */
-	if (ramstart > PHYS_OFFSET)
+	if (ramstart > PHYS_OFFSET) {
 		add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
 				  BOOT_MEM_RESERVED);
+		memblock_reserve(PHYS_OFFSET, ramstart - PHYS_OFFSET);
+	}
 
 	if (min_low_pfn > ARCH_PFN_OFFSET) {
 		pr_info("Wasting %lu bytes for tracking %lu unused pages\n",
@@ -483,52 +474,6 @@ static void __init bootmem_init(void)
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
 
@@ -577,9 +522,9 @@ static void __init bootmem_init(void)
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
 
@@ -602,15 +547,9 @@ static void __init bootmem_init(void)
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
@@ -907,21 +846,29 @@ static void __init arch_mem_init(char **cmdline_p)
 	early_init_fdt_scan_reserved_mem();
 
 	bootmem_init();
+
+	/*
+	 * Prevent memblock from allocating high memory.
+	 * This cannot be done before max_low_pfn is detected, so up
+	 * to this point is possible to only reserve physical memory
+	 * with memblock_reserve; memblock_virt_alloc* can be used
+	 * only after this point
+	 */
+	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
+
 #ifdef CONFIG_PROC_VMCORE
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
@@ -931,7 +878,7 @@ static void __init arch_mem_init(char **cmdline_p)
 	/* Tell bootmem about cma reserved memblock section */
 	for_each_memblock(reserved, reg)
 		if (reg->size != 0)
-			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
+			memblock_reserve(reg->base, reg->size);
 
 	reserve_bootmem_region(__pa_symbol(&__nosave_begin),
 			__pa_symbol(&__nosave_end)); /* Reserve for hibernation */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 576aeef..5feef28 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -29,6 +29,7 @@
 #include <linux/spinlock.h>
 #include <linux/kallsyms.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/interrupt.h>
 #include <linux/ptrace.h>
 #include <linux/kgdb.h>
@@ -2260,8 +2261,10 @@ void __init trap_init(void)
 		unsigned long size = 0x200 + VECTORSPACING*64;
 		phys_addr_t ebase_pa;
 
+		memblock_set_bottom_up(true);
 		ebase = (unsigned long)
 			__alloc_bootmem(size, 1 << fls(size), 0);
+		memblock_set_bottom_up(false);
 
 		/*
 		 * Try to ensure ebase resides in KSeg0 if possible.
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
