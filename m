From: Paul Burton <paul.burton@mips.com>
Date: Fri, 27 Jul 2018 18:23:19 -0700
Subject: MIPS: Fix ISA virt/bus conversion for non-zero PHYS_OFFSET
Message-ID: <20180728012319.AqEBsXYrJrBqrU27QT3voZY0mJkLhPax_nnHIHGl2po@z>

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit 0494d7ffdcebc6935410ea0719b24ab626675351 ]

isa_virt_to_bus() & isa_bus_to_virt() claim to treat ISA bus addresses
as being identical to physical addresses, but they fail to do so in the
presence of a non-zero PHYS_OFFSET.

Correct this by having them use virt_to_phys() & phys_to_virt(), which
consolidates the calculations to one place & ensures that ISA bus
addresses do indeed match physical addresses.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20047/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/io.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -141,14 +141,14 @@ static inline void * phys_to_virt(unsign
 /*
  * ISA I/O bus memory addresses are 1:1 with the physical address.
  */
-static inline unsigned long isa_virt_to_bus(volatile void * address)
+static inline unsigned long isa_virt_to_bus(volatile void *address)
 {
-	return (unsigned long)address - PAGE_OFFSET;
+	return virt_to_phys(address);
 }
 
-static inline void * isa_bus_to_virt(unsigned long address)
+static inline void *isa_bus_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET);
+	return phys_to_virt(address);
 }
 
 #define isa_page_to_bus page_to_phys


Patches currently in stable-queue which might be from paul.burton@mips.com are

queue-4.14/mips-fix-isa-virt-bus-conversion-for-non-zero-phys_offset.patch
queue-4.14/mips-generic-fix-missing-of_node_put.patch
queue-4.14/mips-warn_on-invalid-dma-cache-maintenance-not-bug_on.patch
queue-4.14/mips-vdso-match-data-page-cache-colouring-when-d-aliases.patch
queue-4.14/mips-octeon-add-missing-of_node_put.patch
