From: Paul Burton <paul.burton@imgtec.com>
Date: Tue, 1 Mar 2016 02:37:58 +0000
Subject: MIPS: Handle highmem pages in __update_cache
Message-ID: <20160301023758.YAHXRqtCr34CJjKwtkbhvcVm2o6ZUe1Donmg43fxCaw@z>

commit f4281bba818105c7c91799abe40bc05c0dbdaa25 upstream.

The following patch will expose __update_cache to highmem pages. Handle
them by mapping them in for the duration of the cache maintenance, just
like in __flush_dcache_page. The code for that isn't shared because we
need the page address in __update_cache so sharing became messy. Given
that the entirity is an extra 5 lines, just duplicate it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars Persson <lars.persson@axis.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jerome Marchand <jmarchan@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/12721/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/mm/cache.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index aab218c..0d71fdd 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -143,9 +143,17 @@ void __update_cache(struct vm_area_struct *vma, unsigned long address,
 		return;
 	page = pfn_to_page(pfn);
 	if (page_mapping(page) && Page_dcache_dirty(page)) {
-		addr = (unsigned long) page_address(page);
+		if (PageHighMem(page))
+			addr = (unsigned long)kmap_atomic(page);
+		else
+			addr = (unsigned long)page_address(page);
+
 		if (exec || pages_do_alias(addr, address & PAGE_MASK))
 			flush_data_cache_page(addr);
+
+		if (PageHighMem(page))
+			__kunmap_atomic((void *)addr);
+
 		ClearPageDcacheDirty(page);
 	}
 }
--
2.7.4
