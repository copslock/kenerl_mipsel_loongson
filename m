Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2010 23:54:21 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10917 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491882Ab0HDVyN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Aug 2010 23:54:13 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c59e19f0000>; Wed, 04 Aug 2010 14:54:39 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 4 Aug 2010 14:54:10 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 4 Aug 2010 14:54:10 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o74Ls1Xb015094;
        Wed, 4 Aug 2010 14:54:02 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o74Lrw1r015093;
        Wed, 4 Aug 2010 14:53:58 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Allow more than 3.75GB of memory with PCIe
Date:   Wed,  4 Aug 2010 14:53:57 -0700
Message-Id: <1280958837-15061-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
X-OriginalArrivalTime: 04 Aug 2010 21:54:10.0114 (UTC) FILETIME=[9192D220:01CB341F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

We reserve the 3.75GB - 4GB region of PCIe address space for device to
device transfers, making the corresponding physical memory under
direct mapping unavailable for DMA.

To allow for PCIe DMA to all physical memory we map this chunk of
physical memory with BAR1.  Because of the resulting discontinuity in
the mapping function, we remove a page of memory at each end of the
range so multi-page DMA buffers can never be allocated that span the
range.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/dma-octeon.c      |   17 ++++++++-----
 arch/mips/cavium-octeon/setup.c           |   34 +++++++++++++++++++++++++-
 arch/mips/include/asm/octeon/pci-octeon.h |   13 ++++++++++
 arch/mips/pci/pcie-octeon.c               |   37 ++++++++++++++++++++++++----
 4 files changed, 87 insertions(+), 14 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index be531ec..d22b5a2 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -99,13 +99,16 @@ dma_addr_t octeon_map_dma_mem(struct device *dev, void *ptr, size_t size)
 			panic("dma_map_single: "
 			      "Attempt to map illegal memory address 0x%llx\n",
 			      physical);
-		else if ((physical + size >=
-			  (4ull<<30) - (OCTEON_PCI_BAR1_HOLE_SIZE<<20))
-			 && physical < (4ull<<30))
-			pr_warning("dma_map_single: Warning: "
-				   "Mapping memory address that might "
-				   "conflict with devices 0x%llx-0x%llx\n",
-				   physical, physical+size-1);
+		else if (physical >= CVMX_PCIE_BAR1_PHYS_BASE &&
+			 physical + size < (CVMX_PCIE_BAR1_PHYS_BASE + CVMX_PCIE_BAR1_PHYS_SIZE)) {
+			result = physical - CVMX_PCIE_BAR1_PHYS_BASE + CVMX_PCIE_BAR1_RC_BASE;
+
+			if (((result+size-1) & dma_mask) != result+size-1)
+				panic("dma_map_single: Attempt to map address 0x%llx-0x%llx, which can't be accessed according to the dma mask 0x%llx\n",
+				      physical, physical+size-1, dma_mask);
+			goto done;
+		}
+
 		/* The 2nd 256MB is mapped at 256<<20 instead of 0x410000000 */
 		if ((physical >= 0x410000000ull) && physical < 0x420000000ull)
 			result = physical - 0x400000000ull;
diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 041326e..69197cb 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -32,6 +32,7 @@
 #include <asm/time.h>
 
 #include <asm/octeon/octeon.h>
+#include <asm/octeon/pci-octeon.h>
 
 #ifdef CONFIG_CAVIUM_DECODE_RSL
 extern void cvmx_interrupt_rsl_decode(void);
@@ -609,6 +610,22 @@ void __init prom_init(void)
 	register_smp_ops(&octeon_smp_ops);
 }
 
+/* Exclude a single page from the regions obtained in plat_mem_setup. */
+static __init void memory_exclude_page(u64 addr, u64 *mem, u64 *size)
+{
+	if (addr > *mem && addr < *mem + *size) {
+		u64 inc = addr - *mem;
+		add_memory_region(*mem, inc, BOOT_MEM_RAM);
+		*mem += inc;
+		*size -= inc;
+	}
+
+	if (addr == *mem && *size > PAGE_SIZE) {
+		*mem += PAGE_SIZE;
+		*size -= PAGE_SIZE;
+	}
+}
+
 void __init plat_mem_setup(void)
 {
 	uint64_t mem_alloc_size;
@@ -659,12 +676,27 @@ void __init plat_mem_setup(void)
 						CVMX_BOOTMEM_FLAG_NO_LOCKING);
 #endif
 		if (memory >= 0) {
+			u64 size = mem_alloc_size;
+
+			/*
+			 * exclude a page at the beginning and end of
+			 * the 256MB PCIe 'hole' so the kernel will not
+			 * try to allocate multi-page buffers that
+			 * span the discontinuity.
+			 */
+			memory_exclude_page(CVMX_PCIE_BAR1_PHYS_BASE,
+					    &memory, &size);
+			memory_exclude_page(CVMX_PCIE_BAR1_PHYS_BASE +
+					    CVMX_PCIE_BAR1_PHYS_SIZE,
+					    &memory, &size);
+
 			/*
 			 * This function automatically merges address
 			 * regions next to each other if they are
 			 * received in incrementing order.
 			 */
-			add_memory_region(memory, mem_alloc_size, BOOT_MEM_RAM);
+			if (size)
+				add_memory_region(memory, size, BOOT_MEM_RAM);
 			total += mem_alloc_size;
 		} else {
 			break;
diff --git a/arch/mips/include/asm/octeon/pci-octeon.h b/arch/mips/include/asm/octeon/pci-octeon.h
index 6ac5d3e..ece7804 100644
--- a/arch/mips/include/asm/octeon/pci-octeon.h
+++ b/arch/mips/include/asm/octeon/pci-octeon.h
@@ -15,6 +15,19 @@
 #define PCI_CONFIG_SPACE_DELAY 10000
 
 /*
+ * The physical memory base mapped by BAR1.  256MB at the end of the
+ * first 4GB.
+ */
+#define CVMX_PCIE_BAR1_PHYS_BASE ((1ull << 32) - (1ull << 28))
+#define CVMX_PCIE_BAR1_PHYS_SIZE (1ull << 28)
+
+/*
+ * The RC base of BAR1.  gen1 has a 39-bit BAR2, gen2 has 41-bit BAR2,
+ * place BAR1 so it is the same for both.
+ */
+#define CVMX_PCIE_BAR1_RC_BASE (1ull << 41)
+
+/*
  * pcibios_map_irq() is defined inside pci-octeon.c. All it does is
  * call the Octeon specific version pointed to by this variable. This
  * function needs to change for PCI or PCIe based hosts.
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index 6aa5c54..861361e 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -402,6 +402,10 @@ static void __cvmx_pcie_rc_initialize_config_space(int pcie_port)
 	npei_ctl_status2.s.mps = 0;
 	/* Max read request size = 128 bytes for best Octeon DMA performance */
 	npei_ctl_status2.s.mrrs = 0;
+	if (pcie_port)
+		npei_ctl_status2.s.c1_b1_s = 3; /* Port1 BAR1 Size 256MB */
+	else
+		npei_ctl_status2.s.c0_b1_s = 3; /* Port0 BAR1 Size 256MB */
 	cvmx_write_csr(CVMX_PEXP_NPEI_CTL_STATUS2, npei_ctl_status2.u64);
 
 	/* ECRC Generation (PCIE*_CFG070[GE,CE]) */
@@ -666,6 +670,8 @@ static int __cvmx_pcie_rc_initialize_link(int pcie_port)
 static int cvmx_pcie_rc_initialize(int pcie_port)
 {
 	int i;
+	int base;
+	u64 addr_swizzle;
 	union cvmx_ciu_soft_prst ciu_soft_prst;
 	union cvmx_pescx_bist_status pescx_bist_status;
 	union cvmx_pescx_bist_status2 pescx_bist_status2;
@@ -674,6 +680,7 @@ static int cvmx_pcie_rc_initialize(int pcie_port)
 	union cvmx_npei_mem_access_subidx mem_access_subid;
 	union cvmx_npei_dbg_data npei_dbg_data;
 	union cvmx_pescx_ctl_status2 pescx_ctl_status2;
+	union cvmx_npei_bar1_indexx bar1_index;
 
 	/*
 	 * Make sure we aren't trying to setup a target mode interface
@@ -918,12 +925,30 @@ static int cvmx_pcie_rc_initialize(int pcie_port)
 	/* Set Octeon's BAR0 to decode 0-16KB. It overlaps with Bar2 */
 	cvmx_write_csr(CVMX_PESCX_P2N_BAR0_START(pcie_port), 0);
 
-	/*
-	 * Disable Octeon's BAR1. It isn't needed in RC mode since
-	 * BAR2 maps all of memory. BAR2 also maps 256MB-512MB into
-	 * the 2nd 256MB of memory.
-	 */
-	cvmx_write_csr(CVMX_PESCX_P2N_BAR1_START(pcie_port), -1);
+	/* BAR1 follows BAR2 with a gap. */
+	cvmx_write_csr(CVMX_PESCX_P2N_BAR1_START(pcie_port), CVMX_PCIE_BAR1_RC_BASE);
+
+	bar1_index.u32 = 0;
+	bar1_index.s.addr_idx = (CVMX_PCIE_BAR1_PHYS_BASE >> 22);
+	bar1_index.s.ca = 1;       /* Not Cached */
+	bar1_index.s.end_swp = 1;  /* Endian Swap mode */
+	bar1_index.s.addr_v = 1;   /* Valid entry */
+
+	base = pcie_port ? 16 : 0;
+
+	/* Big endian swizzle for 32-bit PEXP_NCB register. */
+#ifdef __MIPSEB__
+	addr_swizzle = 4;
+#else
+	addr_swizzle = 0;
+#endif
+	for (i = 0; i < 16; i++) {
+		cvmx_write64_uint32((CVMX_PEXP_NPEI_BAR1_INDEXX(base) ^ addr_swizzle),
+				    bar1_index.u32);
+		base++;
+		/* 256MB / 16 >> 22 == 4 */
+		bar1_index.s.addr_idx += (((1ull << 28) / 16ull) >> 22);
+	}
 
 	/*
 	 * Set Octeon's BAR2 to decode 0-2^39. Bar0 and Bar1 take
-- 
1.7.1.1
