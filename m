Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 13:37:34 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:24240 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009238AbbAPMhc4TRCk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 13:37:32 +0100
X-IronPort-AV: E=Sophos;i="5.09,410,1418112000"; 
   d="scan'208";a="54822148"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw3-out.broadcom.com with ESMTP; 16 Jan 2015 04:53:16 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Fri, 16 Jan 2015 04:37:23 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Fri, 16 Jan 2015 04:37:39 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 44E5240FE5;    Fri, 16 Jan 2015 04:36:31 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH] MIPS: Netlogic: Add NUMA support
Date:   Fri, 16 Jan 2015 18:07:15 +0530
Message-ID: <1421411835-3243-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45219
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

Support NUMA on XLP8XX and XLP9XX multi SoC setup.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/Kconfig                              |   3 +-
 arch/mips/include/asm/mach-netlogic/mmzone.h   |  19 +++
 arch/mips/include/asm/mach-netlogic/topology.h |  23 +++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h   |   5 +
 arch/mips/kernel/setup.c                       |   8 ++
 arch/mips/netlogic/common/smp.c                |   8 +-
 arch/mips/netlogic/xlp/Makefile                |   1 +
 arch/mips/netlogic/xlp/numa.c                  | 190 +++++++++++++++++++++++++
 arch/mips/netlogic/xlp/setup.c                 |   1 +
 arch/mips/pci/pci-xlp.c                        |  28 ++++
 10 files changed, 284 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-netlogic/mmzone.h
 create mode 100644 arch/mips/include/asm/mach-netlogic/topology.h
 create mode 100644 arch/mips/netlogic/xlp/numa.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 45cbb09..b71fce3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -851,6 +851,7 @@ config NLM_XLP_BOARD
 	select ZONE_DMA32 if 64BIT
 	select SYNC_R4K
 	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_NUMA
 	select USE_OF
 	select SYS_SUPPORTS_ZBOOT
 	select SYS_SUPPORTS_ZBOOT_UART16550
@@ -2260,7 +2261,7 @@ config ARCH_FLATMEM_ENABLE
 
 config ARCH_DISCONTIGMEM_ENABLE
 	bool
-	default y if SGI_IP27
+	default y if SGI_IP27 || NUMA
 	help
 	  Say Y to support efficient handling of discontiguous physical memory,
 	  for architectures which are either NUMA (Non-Uniform Memory Access)
diff --git a/arch/mips/include/asm/mach-netlogic/mmzone.h b/arch/mips/include/asm/mach-netlogic/mmzone.h
new file mode 100644
index 00000000..7f4afe9
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
new file mode 100644
index 00000000..d4743b8
--- /dev/null
+++ b/arch/mips/include/asm/mach-netlogic/topology.h
@@ -0,0 +1,23 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Broadcom Corporation
+ */
+#ifndef _ASM_MACH_NETLOGIC_TOPOLOGY_H
+#define _ASM_MACH_NETLOGIC_TOPOLOGY_H
+
+#include <asm/mach-netlogic/multi-node.h>
+
+#define cpu_to_node(cpu)			(cpu_data[cpu].package)
+#define cpumask_of_node(node)			(&nlm_get_node(node)->cpumask)
+#define parent_node(node)			(node)
+
+struct pci_bus;
+extern int pcibus_to_node(struct pci_bus *);
+#define cpumask_of_pcibus(bus)			(cpu_online_mask)
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_MACH_NETLOGIC_TOPOLOGY_H */
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index feb6ed8..ba45cf4 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -94,6 +94,11 @@ int nlm_get_dram_map(int node, uint64_t *dram_map, int nentries);
 
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
index d995904..5c0ca16 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -292,6 +292,14 @@ static void __init bootmem_init(void)
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
index 1f709db..769438e 100644
--- a/arch/mips/netlogic/common/smp.c
+++ b/arch/mips/netlogic/common/smp.c
@@ -174,6 +174,7 @@ void __init nlm_smp_setup(void)
 	__cpu_number_map[boot_cpu] = 0;
 	__cpu_logical_map[0] = boot_cpu;
 	set_cpu_possible(0, true);
+	cpumask_set_cpu(0, &nlm_get_node(0)->cpumask);
 
 	num_cpus = 1;
 	for (i = 0; i < NR_CPUS; i++) {
@@ -198,8 +199,12 @@ void __init nlm_smp_setup(void)
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
@@ -214,6 +219,7 @@ static int nlm_parse_cpumask(cpumask_t *wakeup_mask)
 	int threadmode, i, j;
 	char buf[64];
 
+	/* Get Core 0 thread mask and value for thread mode register */
 	core0_thr_mask = 0;
 	for (i = 0; i < NLM_THREADS_PER_CORE; i++)
 		if (cpumask_test_cpu(i, wakeup_mask))
diff --git a/arch/mips/netlogic/xlp/Makefile b/arch/mips/netlogic/xlp/Makefile
index 6b43af0..f77d9ec 100644
--- a/arch/mips/netlogic/xlp/Makefile
+++ b/arch/mips/netlogic/xlp/Makefile
@@ -1,5 +1,6 @@
 obj-y				+= setup.o nlm_hal.o cop2-ex.o dt.o
 obj-$(CONFIG_SMP)		+= wakeup.o
+obj-$(CONFIG_NUMA)		+= numa.o
 ifdef CONFIG_USB
 obj-y				+= usb-init.o
 obj-y				+= usb-init-xlp2.o
diff --git a/arch/mips/netlogic/xlp/numa.c b/arch/mips/netlogic/xlp/numa.c
new file mode 100644
index 00000000..fa5e9d7
--- /dev/null
+++ b/arch/mips/netlogic/xlp/numa.c
@@ -0,0 +1,190 @@
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
+extern unsigned long setup_zero_pages(void);
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
+	free_all_bootmem();
+	setup_zero_pages();
+	mem_init_print_info(NULL);
+}
+
+void __init xlp_numa_init(void)
+{
+	int i;
+
+	for (i = 0; i < NLM_NR_NODES; i++)
+		if (nlm_node_present(i))
+			node_set_online(i);
+}
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index adc6390..3a8b031 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -102,6 +102,7 @@ void __init plat_mem_setup(void)
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
1.9.1
