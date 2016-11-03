Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 00:01:34 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:52629 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993074AbcKCXB1yRznk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2016 00:01:27 +0100
X-IronPort-AV: E=Sophos;i="5.31,440,1473145200"; 
   d="scan'208";a="109419949"
Received: from smtphost.broadcom.com (HELO mail-irv-17.broadcom.com) ([10.15.198.34])
  by mail-gw1-out.broadcom.com with ESMTP; 03 Nov 2016 18:26:24 -0700
Received: from stb-bld-02.irv.broadcom.com (stb-bld-02.broadcom.com [10.13.134.28])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 64A9482029;
        Thu,  3 Nov 2016 16:01:20 -0700 (PDT)
From:   Justin Chen <justinpopo6@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     f.fainelli@gmail.com, Justin Chen <justinpopo6@gmail.com>
Subject: [RFC] MIPS: Communicate reserved memblock regions to the page allocator
Date:   Thu,  3 Nov 2016 16:00:54 -0700
Message-Id: <20161103230054.16771-1-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.10.1
Return-Path: <justinpopo6@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinpopo6@gmail.com
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

Reserved memblock regions were not being communicated to the page allocator.
Our systems use memblock to reserve memory regions to not be used by linux.
The regions of reserved memory in memblock do not seem to be communicated to
the page allocator.

Their are two regions we are concerned with lowmem (region < max_low_pfn) and
highmem (max_low_pfn < region < max_pfn).

Lowmem is managed by bootmem. Reserved memblock regions were already communicated
to bootmem, however in bootmem only regions in lowmem are valid. When trying to
reserve_bootmem regions higher then lowmem the kernel crashes. Fixed this problem
by checking memblock reserved regions before reserving them in bootmem.

Highmem is freed by mem_init_free_highmem(). Memblock reserved regions were being
freed without coordinating with memblock. Fixed this problem by checking with
memblock before freeing pages.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 arch/mips/kernel/setup.c | 21 +++++++++++++++------
 arch/mips/mm/init.c      |  3 ++-
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 6e63a62..9e2330d 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -695,15 +695,24 @@ static void __init arch_mem_init(char **cmdline_p)
 	plat_swiotlb_setup();
 	paging_init();
 
-	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
-	/* Tell bootmem about cma reserved memblock section */
-	for_each_memblock(reserved, reg)
-		if (reg->size != 0)
-			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
-
 #ifdef CONFIG_BRCMSTB_MEMORY_API
 	brcmstb_memory_init();
 #endif
+
+	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
+	/* Tell bootmem about reserved memory blocks in memblock */
+	for_each_memblock(reserved, reg) {
+		if (reg->size != 0)
+			continue;
+		/*
+		 * Bootmem does not have knowledge of high mem, however memblock
+		 * does. Make sure the regions we are reserving reside in bootmem
+		 * range. Bootmem range is anything < max_low_pfn.
+		 */
+		if ((reg->base < PFN_PHYS(max_low_pfn)) &&
+		    ((reg->base + reg->size) <= PFN_PHYS(max_low_pfn)))
+			reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
+	}
 }
 
 static void __init resource_init(void)
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index faa5c98..b17ebf3 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -30,6 +30,7 @@
 #include <linux/hardirq.h>
 #include <linux/gfp.h>
 #include <linux/kcore.h>
+#include <linux/memblock.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/bootinfo.h>
@@ -323,7 +324,7 @@ static inline void mem_init_free_highmem(void)
 	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
 		struct page *page = pfn_to_page(tmp);
 
-		if (!page_is_ram(tmp))
+		if (!page_is_ram(tmp) || memblock_is_reserved(PFN_PHYS(tmp)))
 			SetPageReserved(page);
 		else
 			free_highmem_page(page);
-- 
2.10.1
