Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2007 15:07:33 +0000 (GMT)
Received: from ozlabs.org ([203.10.76.45]:1669 "EHLO ozlabs.org")
	by ftp.linux-mips.org with ESMTP id S20021393AbXCFPH3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Mar 2007 15:07:29 +0000
Received: by ozlabs.org (Postfix, from userid 1034)
	id C0234DDF0E; Wed,  7 Mar 2007 02:06:48 +1100 (EST)
To:	Greg Kroah-Hartman <greg@kroah.com>
CC:	linux-pci@atrey.karlin.mff.cuni.cz, <linuxppc-dev@ozlabs.org>,
	<dev-etrax@axis.com>, <ink@jurassic.park.msu.ru>,
	<rth@twiddle.net>, <kernel@wantstofly.org>,
	<linux-ia64@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
	<gerg@uclinux.org>, <linux-mips@linux-mips.org>,
	<parisc-linux@parisc-linux.org>, <sparclinux@vger.kernel.org>,
	<uclinux-v850@lsi.nec.co.jp>, <discuss@x86-64.org>,
	<chris@zankel.net>, <dhowells@redhat.com>
From:	Michael Ellerman <michael@ellerman.id.au>
Date:	Tue, 06 Mar 2007 16:06:08 +0100
Subject: [PATCH 1/2] Use a weak symbol for the empty version of pcibios_add_platform_entries()
Message-Id: <1173193568.89821.610708199943.qpush@concordia>
Return-Path: <michael@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@ellerman.id.au
Precedence: bulk
X-list: linux-mips

I'm not sure if this is going to fly, weak symbols work on the compilers I'm
using, but whether they work for all of the affected architectures I can't say.
I've cc'ed as many arch maintainers/lists as I could find.

But assuming they do, we can use a weak empty definition of
pcibios_add_platform_entries() to avoid having an empty definition on every
arch.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/ppc/kernel/pci.c       |    6 ------
 drivers/pci/pci-sysfs.c     |    5 +++++
 include/asm-alpha/pci.h     |    5 -----
 include/asm-arm/pci.h       |    4 ----
 include/asm-cris/pci.h      |    4 ----
 include/asm-frv/pci.h       |    4 ----
 include/asm-h8300/pci.h     |    4 ----
 include/asm-i386/pci.h      |    4 ----
 include/asm-ia64/pci.h      |    4 ----
 include/asm-m68k/pci.h      |    4 ----
 include/asm-m68knommu/pci.h |    4 ----
 include/asm-mips/pci.h      |    4 ----
 include/asm-parisc/pci.h    |    4 ----
 include/asm-powerpc/pci.h   |    2 --
 include/asm-ppc/pci.h       |    2 --
 include/asm-sh/pci.h        |    4 ----
 include/asm-sh64/pci.h      |    4 ----
 include/asm-sparc/pci.h     |    4 ----
 include/asm-sparc64/pci.h   |    4 ----
 include/asm-v850/pci.h      |    4 ----
 include/asm-x86_64/pci.h    |    4 ----
 include/asm-xtensa/pci.h    |    4 ----
 include/linux/pci.h         |    2 ++
 23 files changed, 7 insertions(+), 83 deletions(-)

Index: msi-new/arch/ppc/kernel/pci.c
===================================================================
--- msi-new.orig/arch/ppc/kernel/pci.c
+++ msi-new/arch/ppc/kernel/pci.c
@@ -633,12 +633,6 @@ void pcibios_make_OF_bus_map(void)
 {
 }
 
-/* Add sysfs properties */
-void pcibios_add_platform_entries(struct pci_dev *pdev)
-{
-}
-
-
 static int __init
 pcibios_init(void)
 {
Index: msi-new/drivers/pci/pci-sysfs.c
===================================================================
--- msi-new.orig/drivers/pci/pci-sysfs.c
+++ msi-new/drivers/pci/pci-sysfs.c
@@ -600,6 +600,11 @@ static struct bin_attribute pcie_config_
 	.write = pci_write_config,
 };
 
+void __attribute__ ((weak)) pcibios_add_platform_entries(struct pci_dev *dev)
+{
+	return;
+}
+
 int __must_check pci_create_sysfs_dev_files (struct pci_dev *pdev)
 {
 	struct bin_attribute *rom_attr = NULL;
Index: msi-new/include/asm-alpha/pci.h
===================================================================
--- msi-new.orig/include/asm-alpha/pci.h
+++ msi-new/include/asm-alpha/pci.h
@@ -275,11 +275,6 @@ static inline int pci_proc_domain(struct
 	return hose->need_domain_info;
 }
 
-static inline void
-pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 struct pci_dev *alpha_gendev_to_pci(struct device *dev);
 
 #endif /* __KERNEL__ */
Index: msi-new/include/asm-arm/pci.h
===================================================================
--- msi-new.orig/include/asm-arm/pci.h
+++ msi-new/include/asm-arm/pci.h
@@ -76,10 +76,6 @@ pcibios_select_root(struct pci_dev *pdev
 	return root;
 }
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 #endif /* __KERNEL__ */
  
 #endif
Index: msi-new/include/asm-cris/pci.h
===================================================================
--- msi-new.orig/include/asm-cris/pci.h
+++ msi-new/include/asm-cris/pci.h
@@ -89,10 +89,6 @@ extern int pci_mmap_page_range(struct pc
 			       enum pci_mmap_state mmap_state, int write_combine);
 
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 #endif /* __KERNEL__ */
 
 /* implement the pci_ DMA API in terms of the generic device dma_ one */
Index: msi-new/include/asm-frv/pci.h
===================================================================
--- msi-new.orig/include/asm-frv/pci.h
+++ msi-new/include/asm-frv/pci.h
@@ -22,10 +22,6 @@ struct pci_dev;
 
 #define pcibios_assign_all_busses()	0
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 extern void pcibios_set_master(struct pci_dev *dev);
 
 extern void pcibios_penalize_isa_irq(int irq);
Index: msi-new/include/asm-h8300/pci.h
===================================================================
--- msi-new.orig/include/asm-h8300/pci.h
+++ msi-new/include/asm-h8300/pci.h
@@ -22,8 +22,4 @@ static inline void pcibios_penalize_isa_
 
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 #endif /* _ASM_H8300_PCI_H */
Index: msi-new/include/asm-i386/pci.h
===================================================================
--- msi-new.orig/include/asm-i386/pci.h
+++ msi-new/include/asm-i386/pci.h
@@ -94,10 +94,6 @@ extern int pci_mmap_page_range(struct pc
 			       enum pci_mmap_state mmap_state, int write_combine);
 
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 #ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
Index: msi-new/include/asm-ia64/pci.h
===================================================================
--- msi-new.orig/include/asm-ia64/pci.h
+++ msi-new/include/asm-ia64/pci.h
@@ -142,10 +142,6 @@ static inline int pci_proc_domain(struct
 	return (pci_domain_nr(bus) != 0);
 }
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 extern void pcibios_resource_to_bus(struct pci_dev *dev,
 		struct pci_bus_region *region, struct resource *res);
 
Index: msi-new/include/asm-m68k/pci.h
===================================================================
--- msi-new.orig/include/asm-m68k/pci.h
+++ msi-new/include/asm-m68k/pci.h
@@ -54,8 +54,4 @@ static inline void pcibios_penalize_isa_
  */
 #define PCI_DMA_BUS_IS_PHYS	(1)
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 #endif /* _ASM_M68K_PCI_H */
Index: msi-new/include/asm-m68knommu/pci.h
===================================================================
--- msi-new.orig/include/asm-m68knommu/pci.h
+++ msi-new/include/asm-m68knommu/pci.h
@@ -30,10 +30,6 @@ static inline int pci_dma_supported(stru
  */
 #define pci_dac_dma_supported(pci_dev, mask) (0)
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 #endif /* CONFIG_COMEMPCI */
 
 #endif /* M68KNOMMU_PCI_H */
Index: msi-new/include/asm-mips/pci.h
===================================================================
--- msi-new.orig/include/asm-mips/pci.h
+++ msi-new/include/asm-mips/pci.h
@@ -181,10 +181,6 @@ static inline int pci_proc_domain(struct
 /* implement the pci_ DMA API in terms of the generic device dma_ one */
 #include <asm-generic/pci-dma-compat.h>
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 /* Do platform specific device initialization at pci_enable_device() time */
 extern int pcibios_plat_dev_init(struct pci_dev *dev);
 
Index: msi-new/include/asm-parisc/pci.h
===================================================================
--- msi-new.orig/include/asm-parisc/pci.h
+++ msi-new/include/asm-parisc/pci.h
@@ -284,10 +284,6 @@ pcibios_select_root(struct pci_dev *pdev
 	return root;
 }
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 static inline void pcibios_penalize_isa_irq(int irq, int active)
 {
 	/* We don't need to penalize isa irq's */
Index: msi-new/include/asm-powerpc/pci.h
===================================================================
--- msi-new.orig/include/asm-powerpc/pci.h
+++ msi-new/include/asm-powerpc/pci.h
@@ -237,8 +237,6 @@ extern void of_scan_bus(struct device_no
 
 extern int pci_read_irq_line(struct pci_dev *dev);
 
-extern void pcibios_add_platform_entries(struct pci_dev *dev);
-
 struct file;
 extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
 					 unsigned long pfn,
Index: msi-new/include/asm-ppc/pci.h
===================================================================
--- msi-new.orig/include/asm-ppc/pci.h
+++ msi-new/include/asm-ppc/pci.h
@@ -145,8 +145,6 @@ pcibios_select_root(struct pci_dev *pdev
 	return root;
 }
 
-extern void pcibios_add_platform_entries(struct pci_dev *dev);
-
 struct file;
 extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
 					 unsigned long pfn,
Index: msi-new/include/asm-sh/pci.h
===================================================================
--- msi-new.orig/include/asm-sh/pci.h
+++ msi-new/include/asm-sh/pci.h
@@ -134,10 +134,6 @@ int pcibios_map_platform_irq(struct pci_
 int pciauto_assign_resources(int busno, struct pci_channel *hose);
 #endif
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 #endif /* __KERNEL__ */
 
 /* generic pci stuff */
Index: msi-new/include/asm-sh64/pci.h
===================================================================
--- msi-new.orig/include/asm-sh64/pci.h
+++ msi-new/include/asm-sh64/pci.h
@@ -104,10 +104,6 @@ extern void pcibios_fixup_irqs(void);
 extern int pciauto_assign_resources(int busno, struct pci_channel *hose);
 #endif
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 #endif /* __KERNEL__ */
 
 /* generic pci stuff */
Index: msi-new/include/asm-sparc/pci.h
===================================================================
--- msi-new.orig/include/asm-sparc/pci.h
+++ msi-new/include/asm-sparc/pci.h
@@ -154,10 +154,6 @@ static inline void pci_dma_burst_advice(
 }
 #endif
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 #define PCI_DMA_ERROR_CODE      (~(dma_addr_t)0x0)
 
 static inline int pci_dma_mapping_error(dma_addr_t dma_addr)
Index: msi-new/include/asm-sparc64/pci.h
===================================================================
--- msi-new.orig/include/asm-sparc64/pci.h
+++ msi-new/include/asm-sparc64/pci.h
@@ -303,10 +303,6 @@ pcibios_bus_to_resource(struct pci_dev *
 
 extern struct resource *pcibios_select_root(struct pci_dev *, struct resource *);
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
 	return PCI_IRQ_NONE;
Index: msi-new/include/asm-v850/pci.h
===================================================================
--- msi-new.orig/include/asm-v850/pci.h
+++ msi-new/include/asm-v850/pci.h
@@ -116,8 +116,4 @@ static inline void pci_dma_burst_advice(
 extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
 extern void pci_iounmap (struct pci_dev *dev, void __iomem *addr);
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 #endif /* __V850_PCI_H__ */
Index: msi-new/include/asm-x86_64/pci.h
===================================================================
--- msi-new.orig/include/asm-x86_64/pci.h
+++ msi-new/include/asm-x86_64/pci.h
@@ -135,10 +135,6 @@ static inline void pci_dma_burst_advice(
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			       enum pci_mmap_state mmap_state, int write_combine);
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 #endif /* __KERNEL__ */
 
 /* generic pci stuff */
Index: msi-new/include/asm-xtensa/pci.h
===================================================================
--- msi-new.orig/include/asm-xtensa/pci.h
+++ msi-new/include/asm-xtensa/pci.h
@@ -74,10 +74,6 @@ int pci_mmap_page_range(struct pci_dev *
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
 #define HAVE_PCI_MMAP	1
 
-static inline void pcibios_add_platform_entries(struct pci_dev *dev)
-{
-}
-
 #endif /* __KERNEL__ */
 
 /* Implement the pci_ DMA API in terms of the generic device dma_ one */
Index: msi-new/include/linux/pci.h
===================================================================
--- msi-new.orig/include/linux/pci.h
+++ msi-new/include/linux/pci.h
@@ -857,5 +857,7 @@ extern int pci_pci_problems;
 extern unsigned long pci_cardbus_io_size;
 extern unsigned long pci_cardbus_mem_size;
 
+extern void pcibios_add_platform_entries(struct pci_dev *dev);
+
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */
