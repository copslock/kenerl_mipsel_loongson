Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 17:19:14 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:60927 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903523Ab2HPPQg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 17:16:36 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 16 Aug 2012 08:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,778,1336374000"; 
   d="scan'208";a="209391446"
Received: from blue.fi.intel.com ([10.237.72.50])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2012 08:15:56 -0700
Received: by blue.fi.intel.com (Postfix, from userid 1000)
        id 470B5E008A; Thu, 16 Aug 2012 18:15:59 +0300 (EEST)
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
Subject: [PATCH v3 6/7] mm: make clear_huge_page cache clear only around the fault address
Date:   Thu, 16 Aug 2012 18:15:53 +0300
Message-Id: <1345130154-9602-7-git-send-email-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1345130154-9602-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1345130154-9602-1-git-send-email-kirill.shutemov@linux.intel.com>
X-archive-position: 34215
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
 mm/memory.c |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index dfc179b..d4626b9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3969,18 +3969,34 @@ EXPORT_SYMBOL(might_fault);
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
-				unsigned long addr,
-				unsigned int pages_per_huge_page)
+		unsigned long haddr, unsigned long fault_address,
+		unsigned int pages_per_huge_page)
 {
 	int i;
 	struct page *p = page;
+	unsigned long vaddr;
+	int target = (fault_address - haddr) >> PAGE_SHIFT;
 
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
@@ -3988,16 +4004,24 @@ void clear_huge_page(struct page *page,
 		     unsigned int pages_per_huge_page)
 {
 	int i;
+	unsigned long vaddr;
+	int target = (fault_address - haddr) >> PAGE_SHIFT;
 
 	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
-		clear_gigantic_page(page, haddr, pages_per_huge_page);
+		clear_gigantic_page(page, haddr, fault_address,
+				pages_per_huge_page);
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
