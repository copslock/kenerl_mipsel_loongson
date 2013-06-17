From: Markos Chandras <markos.chandras@imgtec.com>
Date: Mon, 17 Jun 2013 08:09:00 +0000
Subject: [PATCH] MIPS: Expose missing pci_io{map,unmap} declarations
Message-ID: <20130617080900.nuO1mJQJOfeopaIx6GTTONStt_bC-GtQGR53PVfwSU4@z>

commit 78857614104a26cdada4c53eea104752042bf5a1 upstream.

The GENERIC_PCI_IOMAP does not depend on CONFIG_PCI so move
it to the CONFIG_MIPS symbol so it's always selected for MIPS.
This fixes the missing pci_iomap declaration for MIPS.
Moreover, the pci_iounmap function was not defined in the
io.h header file if the CONFIG_PCI symbol is not set,
but it should since MIPS is not using CONFIG_GENERIC_IOMAP.

This fixes the following problem on a allyesconfig:

drivers/net/ethernet/3com/3c59x.c:1031:2: error: implicit declaration of
function 'pci_iomap' [-Werror=implicit-function-declaration]
drivers/net/ethernet/3com/3c59x.c:1044:3: error: implicit declaration of
function 'pci_iounmap' [-Werror=implicit-function-declaration]

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/5478/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/Kconfig          | 2 +-
 arch/mips/include/asm/io.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3e10fd..3811c84 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -25,6 +25,7 @@ config MIPS
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_PCI_IOMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select IRQ_FORCED_THREADING
 	select HAVE_MEMBLOCK
@@ -2353,7 +2354,6 @@ config PCI
 	bool "Support for PCI controller"
 	depends on HW_HAS_PCI
 	select PCI_DOMAINS
-	select GENERIC_PCI_IOMAP
 	select NO_GENERIC_PCI_IOPORT_MAP
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 29d9c23..98ca652 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -169,6 +169,11 @@ static inline void * isa_bus_to_virt(unsigned long address)
 extern void __iomem * __ioremap(phys_t offset, phys_t size, unsigned long flags);
 extern void __iounmap(const volatile void __iomem *addr);

+#ifndef CONFIG_PCI
+struct pci_dev;
+static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr) {}
+#endif
+
 static inline void __iomem * __ioremap_mode(phys_t offset, unsigned long size,
 	unsigned long flags)
 {
--
1.8.3.2
