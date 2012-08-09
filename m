Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2012 17:03:58 +0200 (CEST)
Received: from mga03.intel.com ([143.182.124.21]:20250 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903744Ab2HIPDa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2012 17:03:30 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
  by azsmga101.ch.intel.com with ESMTP; 09 Aug 2012 08:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,740,1336374000"; 
   d="scan'208";a="131994079"
Received: from blue.fi.intel.com ([10.237.72.50])
  by AZSMGA002.ch.intel.com with ESMTP; 09 Aug 2012 08:03:17 -0700
Received: by blue.fi.intel.com (Postfix, from userid 1000)
        id C7101E0088; Thu,  9 Aug 2012 18:03:14 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Alex Shi <alex.shu@intel.com>,
        Jan Beulich <jbeulich@novell.com>,
        Robert Richter <robert.richter@amd.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v2 5/6] mm: make clear_huge_page cache clear only around the fault address
Date:   Thu,  9 Aug 2012 18:03:02 +0300
Message-Id: <1344524583-1096-6-git-send-email-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
X-archive-position: 34076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kirill.shutemov@linux.intel.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Andi Kleen <ak@linux.intel.com>

Clearing a 2MB huge page will typically blow away several levels
of CPU caches. To avoid this only cache clear the 4K area
around the fault address and use a cache avoiding clears
for the rest of the 2MB area.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/memory.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b47199a..e9a75c2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3969,18 +3969,35 @@ EXPORT_SYMBOL(might_fault);
 #endif
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
+
+#ifndef ARCH_HAS_USER_NOCACHE
+#define ARCH_HAS_USER_NOCACHE 0
+#endif
+
+#if ARCH_HAS_USER_NOCACHE == 0
+#define clear_user_highpage_nocache clear_user_highpage
+#endif
+
 static void clear_gigantic_page(struct page *page,
 				unsigned long addr,
 				unsigned int pages_per_huge_page)
 {
 	int i;
 	struct page *p = page;
+	unsigned long vaddr;
+	unsigned long haddr = addr & HPAGE_PMD_MASK;
+	int target = (addr - haddr) >> PAGE_SHIFT;
 
 	might_sleep();
+	vaddr = haddr;
 	for (i = 0; i < pages_per_huge_page;
 	     i++, p = mem_map_next(p, page, i)) {
 		cond_resched();
-		clear_user_highpage(p, addr + i * PAGE_SIZE);
+		vaddr = haddr + i*PAGE_SIZE;
+		if (!ARCH_HAS_USER_NOCACHE  || i == target)
+			clear_user_highpage(p, vaddr);
+		else
+			clear_user_highpage_nocache(p, vaddr);
 	}
 }
 void clear_huge_page(struct page *page,
@@ -3988,16 +4005,23 @@ void clear_huge_page(struct page *page,
 {
 	int i;
 	unsigned long haddr = addr & HPAGE_PMD_MASK;
+	unsigned long vaddr;
+	int target = (addr - haddr) >> PAGE_SHIFT;
 
 	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
-		clear_gigantic_page(page, haddr, pages_per_huge_page);
+		clear_gigantic_page(page, addr, pages_per_huge_page);
 		return;
 	}
 
 	might_sleep();
+	vaddr = haddr;
 	for (i = 0; i < pages_per_huge_page; i++) {
 		cond_resched();
-		clear_user_highpage(page + i, haddr + i * PAGE_SIZE);
+		vaddr = haddr + i*PAGE_SIZE;
+		if (!ARCH_HAS_USER_NOCACHE || i == target)
+			clear_user_highpage(page + i, vaddr);
+		else
+			clear_user_highpage_nocache(page + i, vaddr);
 	}
 }
 
-- 
1.7.7.6
