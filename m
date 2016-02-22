Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 19:10:25 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21094 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013423AbcBVSKX4YcOv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2016 19:10:23 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 5A031B283DB7B;
        Mon, 22 Feb 2016 18:10:15 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 22 Feb 2016 18:10:17 +0000
Received: from localhost (10.100.200.218) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 22 Feb
 2016 18:10:16 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars Persson <lars.persson@axis.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Marchand <jmarchan@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/2] MIPS: Flush highmem pages from dcache in __flush_icache_page
Date:   Mon, 22 Feb 2016 18:09:45 +0000
Message-ID: <1456164585-26910-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456164585-26910-1-git-send-email-paul.burton@imgtec.com>
References: <1456164585-26910-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.218]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

When a page is to be mapped executable for userspace, we can presume
that the icache doesn't contain anything valid for its address range but
we cannot be sure that its content has been written back from the dcache
to L2 or memory further out. If the icache fills from those memories,
ie. does not fill from the dcache, then we need to ensure that content
has been flushed from the dcache. This was being done for lowmem pages
but not for highmem pages. Fix this by mapping the page & flushing its
content from the dcache in __flush_icache_page, before the page is
provided to userland.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

 arch/mips/mm/cache.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 3f159ca..734cb2f 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 
 #include <asm/cacheflush.h>
+#include <asm/highmem.h>
 #include <asm/processor.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
@@ -124,10 +125,14 @@ void __flush_icache_page(struct vm_area_struct *vma, struct page *page)
 	unsigned long addr;
 
 	if (PageHighMem(page))
-		return;
+		addr = (unsigned long)kmap_atomic(page);
+	else
+		addr = (unsigned long)page_address(page);
 
-	addr = (unsigned long) page_address(page);
 	flush_data_cache_page(addr);
+
+	if (PageHighMem(page))
+		__kunmap_atomic((void *)addr);
 }
 EXPORT_SYMBOL_GPL(__flush_icache_page);
 
-- 
2.7.1
