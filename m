From: Paul Burton <paul.burton@mips.com>
Date: Thu, 30 Aug 2018 11:01:21 -0700
Subject: MIPS: VDSO: Match data page cache colouring when D$ aliases
Message-ID: <20180830180121.5_B_oRFtxqHseQzDrG6XEYPsymCYICWg2_yxed6tgZQ@z>

From: Paul Burton <paul.burton@mips.com>

commit 0f02cfbc3d9e413d450d8d0fd660077c23f67eff upstream.

When a system suffers from dcache aliasing a user program may observe
stale VDSO data from an aliased cache line. Notably this can break the
expectation that clock_gettime(CLOCK_MONOTONIC, ...) is, as its name
suggests, monotonic.

In order to ensure that users observe updates to the VDSO data page as
intended, align the user mappings of the VDSO data page such that their
cache colouring matches that of the virtual address range which the
kernel will use to update the data page - typically its unmapped address
within kseg0.

This ensures that we don't introduce aliasing cache lines for the VDSO
data page, and therefore that userland will observe updates without
requiring cache invalidation.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
Reported-by: Rene Nielsen <rene.nielsen@microsemi.com>
Reported-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Patchwork: https://patchwork.linux-mips.org/patch/20344/
Tested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Tested-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/mips/kernel/vdso.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -14,12 +14,14 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/irqchip/mips-gic.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/timekeeper_internal.h>
 
 #include <asm/abi.h>
+#include <asm/page.h>
 #include <asm/vdso.h>
 
 /* Kernel-provided data used by the VDSO. */
@@ -129,12 +131,30 @@ int arch_setup_additional_pages(struct l
 	vvar_size = gic_size + PAGE_SIZE;
 	size = vvar_size + image->size;
 
+	/*
+	 * Find a region that's large enough for us to perform the
+	 * colour-matching alignment below.
+	 */
+	if (cpu_has_dc_aliases)
+		size += shm_align_mask + 1;
+
 	base = get_unmapped_area(NULL, 0, size, 0, 0);
 	if (IS_ERR_VALUE(base)) {
 		ret = base;
 		goto out;
 	}
 
+	/*
+	 * If we suffer from dcache aliasing, ensure that the VDSO data page
+	 * mapping is coloured the same as the kernel's mapping of that memory.
+	 * This ensures that when the kernel updates the VDSO data userland
+	 * will observe it without requiring cache invalidations.
+	 */
+	if (cpu_has_dc_aliases) {
+		base = __ALIGN_MASK(base, shm_align_mask);
+		base += ((unsigned long)&vdso_data - gic_size) & shm_align_mask;
+	}
+
 	data_addr = base + gic_size;
 	vdso_addr = data_addr + PAGE_SIZE;
 


Patches currently in stable-queue which might be from paul.burton@mips.com are

queue-4.9/binfmt_elf-respect-error-return-from-regset-active.patch
queue-4.9/mips-loongson64-cs5536-fix-pci_ohci_int_reg-reads.patch
queue-4.9/mips-ath79-fix-system-restart.patch
queue-4.9/mips-jz4740-bump-zload-address.patch
queue-4.9/mips-vdso-match-data-page-cache-colouring-when-d-aliases.patch
