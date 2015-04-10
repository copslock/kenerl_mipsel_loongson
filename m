Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Apr 2015 15:21:44 +0200 (CEST)
Received: from bastet.se.axis.com ([195.60.68.11]:50022 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014939AbbDJNVl4vGpU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Apr 2015 15:21:41 +0200
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 6864A18144;
        Fri, 10 Apr 2015 15:21:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id yAyjibKwDBFC; Fri, 10 Apr 2015 15:21:36 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id BC21118081;
        Fri, 10 Apr 2015 15:21:36 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 870C01075;
        Fri, 10 Apr 2015 15:21:36 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id 7A463D46;
        Fri, 10 Apr 2015 15:21:36 +0200 (CEST)
Received: from lnxlarper.se.axis.com (lnxlarper.se.axis.com [10.88.41.1])
        by thoth.se.axis.com (Postfix) with ESMTP id 778E134005;
        Fri, 10 Apr 2015 15:21:36 +0200 (CEST)
Received: by lnxlarper.se.axis.com (Postfix, from userid 20456)
        id 6DEB28023D; Fri, 10 Apr 2015 15:21:36 +0200 (CEST)
From:   Lars Persson <lars.persson@axis.com>
To:     ralf@linux-mips.org, paul.burton@imgtec.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars Persson <larper@axis.com>
Subject: [PATCH] MIPS: Fix HIGHMEM crash in __update_cache().
Date:   Fri, 10 Apr 2015 15:21:24 +0200
Message-Id: <1428672084-20676-1-git-send-email-larper@axis.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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

Commit 8b5fe5e54b47 ("MIPS: Fix race condition in lazy cache flushing.")
triggered NULL pointer dereferences on systems with HIGHMEM.

The problem was caused by not clearing the PG_dcache_dirty flag in
flush_icache_page() and thus we enter __update_cache() that lacks
support for HIGHMEM.

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/mips/include/asm/cacheflush.h |    7 +++++--
 arch/mips/mm/cache.c               |   12 ++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index 37d5cf9..723229f 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -51,6 +51,7 @@ extern void (*flush_cache_range)(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end);
 extern void (*flush_cache_page)(struct vm_area_struct *vma, unsigned long page, unsigned long pfn);
 extern void __flush_dcache_page(struct page *page);
+extern void __flush_icache_page(struct vm_area_struct *vma, struct page *page);
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 static inline void flush_dcache_page(struct page *page)
@@ -77,8 +78,10 @@ static inline void flush_icache_page(struct vm_area_struct *vma,
 	struct page *page)
 {
 	if (!cpu_has_ic_fills_f_dc && (vma->vm_flags & VM_EXEC) &&
-	    Page_dcache_dirty(page))
-		__flush_dcache_page(page);
+	    Page_dcache_dirty(page)) {
+		__flush_icache_page(vma, page);
+		ClearPageDcacheDirty(page);
+	}
 }
 
 extern void (*flush_icache_range)(unsigned long start, unsigned long end);
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index f7b91d3..77d96db 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -119,6 +119,18 @@ void __flush_anon_page(struct page *page, unsigned long vmaddr)
 
 EXPORT_SYMBOL(__flush_anon_page);
 
+void __flush_icache_page(struct vm_area_struct *vma, struct page *page)
+{
+	unsigned long addr;
+
+	if (PageHighMem(page))
+		return;
+
+	addr = (unsigned long) page_address(page);
+	flush_data_cache_page(addr);
+}
+EXPORT_SYMBOL_GPL(__flush_icache_page);
+
 void __update_cache(struct vm_area_struct *vma, unsigned long address,
 	pte_t pte)
 {
-- 
1.7.10.4
