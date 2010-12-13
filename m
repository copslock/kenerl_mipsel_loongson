From: Wolfgang Grandegger <wg@denx.de>
Date: Mon, 13 Dec 2010 21:29:09 +0100
Subject: [PATCH] mips/pci: use pci_resource_to_user to map pci memory space properly
Message-ID: <20101213202909.6kGmLJ4Vj3e1O_ho--f0_MzVjtOJwnizQE8YLzL_NfE@z>

Signed-off-by: Wolfgang Grandegger <wg@denx.de>
---
 arch/mips/include/asm/pci.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 576397c..f38943b 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -82,6 +82,18 @@ static inline void pcibios_penalize_isa_irq(int irq, int active)
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 	enum pci_mmap_state mmap_state, int write_combine);
 
+#define HAVE_ARCH_PCI_RESOURCE_TO_USER
+
+static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
+		const struct resource *rsrc, resource_size_t *start,
+		resource_size_t *end)
+{
+	phys_t size = resource_size(rsrc);
+
+	*start = fixup_bigphys_addr(rsrc->start, size);
+	*end = rsrc->start + size;
+}
+
 /*
  * Dynamic DMA mapping stuff.
  * MIPS has everything mapped statically.
-- 
1.7.2.3
