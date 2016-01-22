From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 22 Jan 2016 09:20:37 -0800
Subject: Revert "MIPS: Fix PAGE_MASK definition"
Message-ID: <20160122172037.nlyZGIbIgXJd-SWVhUjSkImivBL-qCSB2cNlr9njKqY@z>

From: Dan Williams <dan.j.williams@intel.com>

commit 800dc4f49cc002879e1e5e6b79926f86b60528e6 upstream.

This reverts commit 22b14523994588279ae9c5ccfe64073c1e5b3c00.

It was originally sent in an earlier revision of the pfn_t patchset.
Besides being broken, the warning is also fixed by PFN_FLAGS_MASK
casting the PAGE_MASK to an unsigned long.

Reported-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Patchwork: https://patchwork.linux-mips.org/patch/12182/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/page.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -33,7 +33,7 @@
 #define PAGE_SHIFT	16
 #endif
 #define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
 
 /*
  * This is used for calculating the real page sizes


Patches currently in stable-queue which might be from dan.j.williams@intel.com are

queue-4.4/revert-mips-fix-page_mask-definition.patch
queue-4.4/devm_memremap-fix-error-value-when-memremap-failed.patch
