From: Paul Burton <paul.burton@imgtec.com>
Date: Sat, 12 Aug 2017 21:36:30 -0700
Subject: MIPS: VDSO: Drop gic_get_usm_range() usage
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20170813043630.hHCBTAok2BNNbXogXC7urm0_lU9K0ByH_e1RTHittfk@z>

From: Paul Burton <paul.burton@imgtec.com>

commit 00578cd864d45ae4b8fa3f684f8d6f783dd8d15d upstream.

We don't really need gic_get_usm_range() to abstract discovery of the
address of the GIC user-visible section now that we have access to its
base address globally.

Switch to calculating it ourselves, which will allow us to stop
requiring the irqchip driver to care about a counter exposed to userland
for use via the VDSO.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17040/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/vdso.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -13,7 +13,6 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/irqchip/mips-gic.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
@@ -21,6 +20,7 @@
 #include <linux/timekeeper_internal.h>
 
 #include <asm/abi.h>
+#include <asm/mips-cps.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
 
@@ -101,9 +101,8 @@ int arch_setup_additional_pages(struct l
 {
 	struct mips_vdso_image *image = current->thread.abi->vdso;
 	struct mm_struct *mm = current->mm;
-	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr;
+	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr, gic_pfn;
 	struct vm_area_struct *vma;
-	struct resource gic_res;
 	int ret;
 
 	down_write(&mm->mmap_sem);
@@ -116,7 +115,7 @@ int arch_setup_additional_pages(struct l
 	 * only map a page even though the total area is 64K, as we only need
 	 * the counter registers at the start.
 	 */
-	gic_size = gic_present ? PAGE_SIZE : 0;
+	gic_size = mips_gic_present() ? PAGE_SIZE : 0;
 	vvar_size = gic_size + PAGE_SIZE;
 	size = vvar_size + image->size;
 
@@ -157,13 +156,9 @@ int arch_setup_additional_pages(struct l
 
 	/* Map GIC user page. */
 	if (gic_size) {
-		ret = gic_get_usm_range(&gic_res);
-		if (ret)
-			goto out;
+		gic_pfn = virt_to_phys(mips_gic_base + MIPS_GIC_USER_OFS) >> PAGE_SHIFT;
 
-		ret = io_remap_pfn_range(vma, base,
-					 gic_res.start >> PAGE_SHIFT,
-					 gic_size,
+		ret = io_remap_pfn_range(vma, base, gic_pfn, gic_size,
 					 pgprot_noncached(PAGE_READONLY));
 		if (ret)
 			goto out;


Patches currently in stable-queue which might be from paul.burton@imgtec.com are

queue-4.4/mips-vdso-drop-gic_get_usm_range-usage.patch
