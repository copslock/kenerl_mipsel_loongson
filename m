Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 17:17:50 +0200 (CEST)
Received: from mga03.intel.com ([143.182.124.21]:13557 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903669Ab2HPPQ2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2012 17:16:28 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
  by azsmga101.ch.intel.com with ESMTP; 16 Aug 2012 08:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,778,1336374000"; 
   d="scan'208";a="135014822"
Received: from blue.fi.intel.com ([10.237.72.50])
  by AZSMGA002.ch.intel.com with ESMTP; 16 Aug 2012 08:15:51 -0700
Received: by blue.fi.intel.com (Postfix, from userid 1000)
        id 287AFE0085; Thu, 16 Aug 2012 18:15:59 +0300 (EEST)
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
Subject: [PATCH v3 4/7] mm: pass fault address to clear_huge_page()
Date:   Thu, 16 Aug 2012 18:15:51 +0300
Message-Id: <1345130154-9602-5-git-send-email-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1345130154-9602-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1345130154-9602-1-git-send-email-kirill.shutemov@linux.intel.com>
X-archive-position: 34212
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

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/mm.h |    2 +-
 mm/huge_memory.c   |    2 +-
 mm/hugetlb.c       |    3 ++-
 mm/memory.c        |    7 ++++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 311be90..2858723 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1638,7 +1638,7 @@ extern void dump_page(struct page *page);
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
 extern void clear_huge_page(struct page *page,
-			    unsigned long addr,
+			    unsigned long haddr, unsigned long fault_address,
 			    unsigned int pages_per_huge_page);
 extern void copy_user_huge_page(struct page *dst, struct page *src,
 				unsigned long addr, struct vm_area_struct *vma,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6f0825b611..070bf89 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -644,7 +644,7 @@ static int __do_huge_pmd_anonymous_page(struct mm_struct *mm,
 	if (unlikely(!pgtable))
 		return VM_FAULT_OOM;
 
-	clear_huge_page(page, haddr, HPAGE_PMD_NR);
+	clear_huge_page(page, haddr, address, HPAGE_PMD_NR);
 	__SetPageUptodate(page);
 
 	spin_lock(&mm->page_table_lock);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3c86d3d..5182192 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2718,7 +2718,8 @@ retry:
 				ret = VM_FAULT_SIGBUS;
 			goto out;
 		}
-		clear_huge_page(page, haddr, pages_per_huge_page(h));
+		clear_huge_page(page, haddr, fault_address,
+				pages_per_huge_page(h));
 		__SetPageUptodate(page);
 
 		if (vma->vm_flags & VM_MAYSHARE) {
diff --git a/mm/memory.c b/mm/memory.c
index 5736170..dfc179b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3984,19 +3984,20 @@ static void clear_gigantic_page(struct page *page,
 	}
 }
 void clear_huge_page(struct page *page,
-		     unsigned long addr, unsigned int pages_per_huge_page)
+		     unsigned long haddr, unsigned long fault_address,
+		     unsigned int pages_per_huge_page)
 {
 	int i;
 
 	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
-		clear_gigantic_page(page, addr, pages_per_huge_page);
+		clear_gigantic_page(page, haddr, pages_per_huge_page);
 		return;
 	}
 
 	might_sleep();
 	for (i = 0; i < pages_per_huge_page; i++) {
 		cond_resched();
-		clear_user_highpage(page + i, addr + i * PAGE_SIZE);
+		clear_user_highpage(page + i, haddr + i * PAGE_SIZE);
 	}
 }
 
-- 
1.7.7.6
