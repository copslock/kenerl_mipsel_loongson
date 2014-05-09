Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2014 17:49:39 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:29054 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854774AbaEIPtelIzAW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 May 2014 17:49:34 +0200
X-IronPort-AV: E=Sophos;i="4.97,1018,1389772800"; 
   d="scan'208";a="28924434"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 09 May 2014 10:05:16 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Fri, 9 May 2014 08:49:26 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.174.1; Fri, 9 May 2014 08:49:26 -0700
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 509A65D818;    Fri,  9 May 2014 08:49:25 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH RFC] MIPS: Netlogic: Add NUMA support for XLP
Date:   Fri, 9 May 2014 21:26:29 +0530
Message-ID: <1399650989-14061-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40060
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

Support NUMA on XLP8XX/XLP9XX multi-chip configuration.

 * Create mach-netlogic/mmzone.h to do memory to node mapping.
 * Update mach-netlogic/topology.h for cpu to node mapping.
 * Add memory initialization code xlp_numa_bootmem_init() and call it
   from mips bootmem_init()
 * Use DRAM configuration of each node to separate the memory given to
   linux to node specific regions
 * Add platform_notify hook to setup node id correctly for PCI devices

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/Kconfig                              |    3 +-
 arch/mips/include/asm/mach-netlogic/mmzone.h   |   19 +++
 arch/mips/include/asm/mach-netlogic/topology.h |   10 ++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h   |    5 +
 arch/mips/kernel/setup.c                       |    8 +
 arch/mips/netlogic/common/smp.c                |    8 +-
 arch/mips/netlogic/xlp/Makefile                |    1 +
 arch/mips/netlogic/xlp/numa.c                  |  191 ++++++++++++++++++++++++
 arch/mips/netlogic/xlp/setup.c                 |    1 +
 arch/mips/pci/pci-xlp.c                        |   28 ++++
 10 files changed, 272 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-netlogic/mmzone.h
 create mode 100644 arch/mips/netlogic/xlp/numa.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e149850..2c8d243 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -782,6 +782,7 @@ config NLM_XLP_BOARD
 	select ZONE_DMA32 if 64BIT
 	select SYNC_R4K
 	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_NUMA
 	select USE_OF
 	select SYS_SUPPORTS_ZBOOT
 	select SYS_SUPPORTS_ZBOOT_UART16550
@@ -2215,7 +2216,7 @@ config ARCH_FLATMEM_ENABLE
 
 config ARCH_DISCONTIGMEM_ENABLE
 	bool
-	default y if SGI_IP27
+	default y if SGI_IP27 || NUMA
 	help
 	  Say Y to support efficient handling of discontiguous physical memory,
 	  for architectures which are either NUMA (Non-Uniform Memory Access)
diff --git a/arch/mips/include/asm/mach-netlogic/mmzone.h b/arch/mips/include/asm/mach-netlogic/mmzone.h
new file mode 100644
index 0000000..7f4afe9
--- /dev/null
+++ b/arch/mips/include/asm/mach-netlogic/mmzone.h
@@ -0,0 +1,19 @@
+#ifndef _NETLOGIC_MMZONE_H_
+#define _NETLOGIC_MMZONE_H_
+
+#include <asm/mach-netlogic/multi-node.h>
+
+struct node_data {
+	struct pglist_data pglist;
+	struct nlm_soc_info *node;
+};
+
+#ifdef CONFIG_NUMA
+extern struct node_data *__node_data[];
+extern int xlp_pa_to_nid(phys_addr_t addr);
+
+#define pa_to_nid(addr)         xlp_pa_to_nid(addr)
+#define NODE_DATA(n)            (&__node_data[(n)]->pglist)
+#endif
+
+#endif /* _NETLOGIC_MMZONE_H_ */
diff --git a/arch/mips/include/asm/mach-netlogic/topology.h b/arch/mips/include/asm/mach-netlogic/topology.h
index ceeb1f5..dfd7c37 100644
--- a/arch/mips/include/asm/mach-netlogic/topology.h
+++ b/arch/mips/include/asm/mach-netlogic/topology.h
@@ -11,6 +11,16 @@
 #include <asm/mach-netlogic/multi-node.h>
 
 #ifdef CONFIG_SMP
+#ifdef CONFIG_NUMA
+#define cpu_to_node(cpu)	nlm_cpuid_to_node(cpu_logical_map(cpu))
+#define cpumask_of_node(node)	(&nlm_get_node(node)->cpumask)
+#define parent_node(node)	(node)
+#endif
+
+struct pci_bus;
+extern int pcibus_to_node(struct pci_bus *);
+#define cpumask_of_pcibus(bus)  (cpu_online_mask)
+
 #define topology_physical_package_id(cpu)	cpu_to_node(cpu)
 #define topology_core_id(cpu)	(cpu_logical_map(cpu) / NLM_THREADS_PER_CORE)
 #define topology_thread_cpumask(cpu)		(&cpu_sibling_map[cpu])
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index c0b2a80..67842b7 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -93,6 +93,11 @@ int nlm_get_dram_map(int node, uint64_t *dram_map, int nentries);
 
 struct pci_dev;
 int xlp_socdev_to_node(const struct pci_dev *dev);
+#ifdef CONFIG_NUMA
+void xlp_numa_init(void);
+#else
+static inline void xlp_numa_init(void) {}
+#endif
 
 /* Device tree related */
 void xlp_early_init_devtree(void);
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 74c5f6d..666480c 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -290,6 +290,14 @@ static void __init bootmem_init(void)
 	finalize_initrd();
 }
 
+#elif defined(CONFIG_CPU_XLP) && defined(CONFIG_NUMA)
+extern void xlp_numa_bootmem_init(void);
+static void __init bootmem_init(void)
+{
+	init_initrd();
+	xlp_numa_bootmem_init();
+	finalize_initrd();
+}
 #else  /* !CONFIG_SGI_IP27 */
 
 static void __init bootmem_init(void)
diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
index b93c5d4..89dc1fe 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -175,6 +175,7 @@ void __init nlm_smp_setup(void)
 	__cpu_number_map[boot_cpu] = 0;
 	__cpu_logical_map[0] = boot_cpu;
 	set_cpu_possible(0, true);
+	cpumask_set_cpu(0, &nlm_get_node(0)->cpumask);
 
 	num_cpus = 1;
 	for (i = 0; i < NR_CPUS; i++) {
@@ -199,8 +200,12 @@ void __init nlm_smp_setup(void)
 	pr_info("Possible CPU mask: %s\n", buf);
 
 	/* check with the cores we have woken up */
-	for (ncore = 0, i = 0; i < NLM_NR_NODES; i++)
+	for (ncore = 0, i = 0; i < NLM_NR_NODES; i++) {
 		ncore += hweight32(nlm_get_node(i)->coremask);
+		cpumask_scnprintf(buf, ARRAY_SIZE(buf),
+						&nlm_get_node(i)->cpumask);
+		pr_info("\tnode %d: %s\n", i, buf);
+	}
 
 	pr_info("Detected (%dc%dt) %d Slave CPU(s)\n", ncore,
 		nlm_threads_per_core, num_cpus);
@@ -215,6 +220,7 @@ static int nlm_parse_cpumask(cpumask_t *wakeup_mask)
 	int threadmode, i, j;
 	char buf[64];
 
+	/* Get Core 0 thread mask and value for thread mode register */
 	core0_thr_mask = 0;
 	for (i = 0; i < NLM_THREADS_PER_CORE; i++)
 		if (cpumask_test_cpu(i, wakeup_mask))
diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
index be358a8..b7b8fe9 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_USB)		+= usb-init.o
 obj-$(CONFIG_USB)		+= usb-init-xlp2.o
 obj-$(CONFIG_SATA_AHCI)		+= ahci-init.o
 obj-$(CONFIG_SATA_AHCI)		+= ahci-init-xlp2.o
+obj-$(CONFIG_NUMA)		+= numa.o
diff --git a/arch/mips/netlogic/xlp/numa.c b/arch/mips/netlogic/xlp/numa.c
new file mode 100644
index 0000000..4e07fc0
--- /dev/null
+++ b/arch/mips/netlogic/xlp/numa.c
@@ -0,0 +1,191 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Broadcom Corporation.
+ *
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/memblock.h>
+#include <linux/mmzone.h>
+#include <linux/nodemask.h>
+#include <linux/bootmem.h>
+#include <linux/pfn.h>
+#include <linux/initrd.h>
+#include <linux/swap.h>
+
+#include <asm/bootinfo.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <asm/sections.h>
+
+#include <asm/mach-netlogic/multi-node.h>
+#include <asm/netlogic/common.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+
+#define NODE_RESV_MEM	(64 * 1024)
+struct node_data *__node_data[NLM_NR_NODES];
+
+/* Quick and dirty implementation for now */
+int xlp_pa_to_nid(phys_addr_t pa)
+{
+	unsigned long pfn, start, end;
+	int n;
+
+	pfn = PFN_DOWN(pa);
+	for_each_online_node(n) {
+		start = NODE_DATA(n)->node_start_pfn;
+		end = start + NODE_DATA(n)->node_spanned_pages - 1;
+		if (pfn >= start && pfn <= end)
+			return n;
+	}
+	BUG();
+	return 0;		/* not reached */
+}
+
+static void __init init_node_bootmem(int node, unsigned long min_pfn,
+	unsigned long max_pfn)
+{
+	unsigned long freepfn, bootmap_size, kpfn;
+	unsigned long nodedata_size = sizeof(struct node_data);
+	unsigned long ofreepfn;
+
+	/* skip kernel and initrd load area on node it is on */
+	kpfn = max(PFN_UP(__pa(initrd_start)), PFN_UP(__pa_symbol(&_end)));
+	if (kpfn > min_pfn && kpfn <= max_pfn)
+		freepfn = kpfn;
+	else
+		freepfn = min_pfn + PFN_UP(NODE_RESV_MEM);
+
+	/* Allocate node area starting at freepfn */
+	__node_data[node] = __va(PFN_PHYS(freepfn));
+	memset(__node_data[node], 0, PAGE_SIZE * PFN_UP(nodedata_size));
+
+	NODE_DATA(node)->bdata = &bootmem_node_data[node];
+	NODE_DATA(node)->node_start_pfn = min_pfn;
+	NODE_DATA(node)->node_spanned_pages = max_pfn - min_pfn + 1;
+
+	ofreepfn = freepfn;
+	freepfn += PFN_UP(nodedata_size);
+	bootmap_size = init_bootmem_node(NODE_DATA(node), freepfn,
+							min_pfn, max_pfn);
+	free_bootmem_with_active_regions(node, max_pfn);
+	reserve_bootmem_node(NODE_DATA(node), PFN_PHYS(min_pfn),
+		PFN_PHYS(freepfn - min_pfn) + bootmap_size,
+		BOOTMEM_DEFAULT);
+	sparse_memory_present_with_active_regions(node);
+}
+/*
+ * This is done in  bootmem_init() for other mips, but in NUMA config
+ * we need to do it for each node.
+ */
+void __init xlp_numa_bootmem_init(void)
+{
+	uint64_t map[16];
+	unsigned long node_pfn_start, node_pfn_end;	/* from DRAM bars */
+	unsigned long min_node_pfn, max_node_pfn;	/* from device tree */
+	int node, n, i;
+
+	/*
+	 * At this point, the boot_mem_map is setup from the DTB, and
+	 * that needs to be split based on the NODE memory setup and
+	 * added to the right node
+	 */
+	for_each_online_node(node) {
+		/* Get the node's DRAM map */
+		n = nlm_get_dram_map(node, map, ARRAY_SIZE(map));
+		if (n == 0)  {
+			pr_err("Node %d: No DRAM found\n", node);
+			goto fail;
+		}
+		node_pfn_start = PFN_UP(map[0]);
+		node_pfn_end = PFN_DOWN(map[n - 1] - 1);
+
+		/* pick up the pieces of boot_mem_map in this node */
+		max_node_pfn = 0;
+		min_node_pfn = ~0ul;
+		for (i = 0;  i < boot_mem_map.nr_map; i++) {
+			unsigned long pfn_start, pfn_end;
+
+			if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
+				continue;
+			pfn_start = PFN_UP(boot_mem_map.map[i].addr);
+			pfn_end = PFN_DOWN(boot_mem_map.map[i].addr
+						+ boot_mem_map.map[i].size);
+			/*
+			 * find which node it falls under, and add it there
+			 */
+			if (pfn_start > node_pfn_end)
+				continue;
+
+			/* if entry starts before node region, discard */
+			if (pfn_start < node_pfn_start)
+				pfn_start = node_pfn_start;
+			/* if entry goes beyond node region, split */
+			if (pfn_end > node_pfn_end)
+				pfn_end = node_pfn_end;
+
+			if (pfn_start >= pfn_end)
+				continue;	/* nothing left in segment */
+
+			memblock_add_node(PFN_PHYS(pfn_start),
+					  PFN_PHYS(pfn_end - pfn_start), node);
+			if (pfn_start < min_node_pfn)
+				min_node_pfn = pfn_start;
+			if (pfn_end > max_node_pfn)
+				max_node_pfn = pfn_end;
+
+		}
+		if (min_node_pfn < max_node_pfn)
+			init_node_bootmem(node, min_node_pfn, max_node_pfn);
+		else {
+			pr_err("No memory on node %d\n", node);
+			goto fail;
+		}
+	}
+
+	return;
+fail:
+	panic("Invalid memory config!\n");
+}
+
+extern void setup_zero_pages(void);
+
+void __init paging_init(void)
+{
+	unsigned long zones_size[MAX_NR_ZONES] = {0, };
+	unsigned node;
+
+	pagetable_init();
+
+	for_each_online_node(node) {
+		unsigned long start_pfn, end_pfn;
+
+		get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
+
+		if (end_pfn > max_low_pfn)
+			max_low_pfn = end_pfn;
+	}
+	zones_size[ZONE_NORMAL] = max_low_pfn;
+	free_area_init_nodes(zones_size);
+}
+
+void __init mem_init(void)
+{
+	high_memory = (void *) __va(get_num_physpages() << PAGE_SHIFT);
+
+	free_all_bootmem();
+	setup_zero_pages();	/* This comes from node 0 */
+	mem_init_print_info(NULL);
+}
+
+void __init xlp_numa_init(void)
+{
+	int i;
+
+	for (i = 0; i < NLM_NR_NODES; i++)
+		if (nlm_get_node(i)->coremask)
+			node_set_online(i);
+}
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index bf4f6d3..5516a7d 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -103,6 +103,7 @@ void __init plat_mem_setup(void)
 		pr_info("Using DRAM BARs for memory map.\n");
 		xlp_init_mem_from_bars();
 	}
+	xlp_numa_init();
 }
 
 const char *get_system_type(void)
diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
index 7babf01..9ea47ee 100644
--- a/arch/mips/pci/pci-xlp.c
+++ b/arch/mips/pci/pci-xlp.c
@@ -286,6 +286,31 @@ static void xlp_config_pci_bswap(int node, int link)
 static inline void xlp_config_pci_bswap(int node, int link) {}
 #endif /* __BIG_ENDIAN */
 
+#ifdef CONFIG_NUMA
+int pcibus_to_node(struct pci_bus *bus)
+{
+	return dev_to_node(&bus->dev);
+}
+
+int xlp_fixup_numa_node(struct device *dev)
+{
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		int node;
+
+		/* fix the node numbers in top level devices */
+		if (pdev->bus->number == 0) {
+			if (cpu_is_xlp9xx())
+				node = PCI_FUNC(pdev->devfn);
+			else
+				node = PCI_SLOT(pdev->devfn) / 8;
+			set_dev_node(dev, node);
+		}
+	}
+	return 0;
+}
+#endif
+
 static int __init pcibios_init(void)
 {
 	uint64_t pciebase;
@@ -327,6 +352,9 @@ static int __init pcibios_init(void)
 	pr_info("XLP PCIe Controller %pR%pR.\n", &nlm_pci_io_resource,
 		&nlm_pci_mem_resource);
 
+#ifdef CONFIG_NUMA
+	platform_notify = xlp_fixup_numa_node;
+#endif
 	return 0;
 }
 arch_initcall(pcibios_init);
-- 
1.7.9.5
