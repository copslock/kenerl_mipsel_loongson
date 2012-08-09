Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2012 17:06:09 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:22958 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903776Ab2HIPEK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2012 17:04:10 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 09 Aug 2012 08:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,740,1336374000"; 
   d="scan'208";a="183643532"
Received: from blue.fi.intel.com ([10.237.72.50])
  by orsmga002.jf.intel.com with ESMTP; 09 Aug 2012 08:03:10 -0700
Received: by blue.fi.intel.com (Postfix, from userid 1000)
        id 9127AE0080; Thu,  9 Aug 2012 18:03:14 +0300 (EEST)
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
Subject: [PATCH v2 1/6] THP: Use real address for NUMA policy
Date:   Thu,  9 Aug 2012 18:02:58 +0300
Message-Id: <1344524583-1096-2-git-send-email-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
X-archive-position: 34081
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

Use the fault address, not the rounded down hpage address for NUMA
policy purposes. In some circumstances this can give more exact
NUMA policy.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/huge_memory.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 57c4b93..70737ec 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -681,11 +681,11 @@ static inline gfp_t alloc_hugepage_gfpmask(int defrag, gfp_t extra_gfp)
 
 static inline struct page *alloc_hugepage_vma(int defrag,
 					      struct vm_area_struct *vma,
-					      unsigned long haddr, int nd,
+					      unsigned long address, int nd,
 					      gfp_t extra_gfp)
 {
 	return alloc_pages_vma(alloc_hugepage_gfpmask(defrag, extra_gfp),
-			       HPAGE_PMD_ORDER, vma, haddr, nd);
+			       HPAGE_PMD_ORDER, vma, address, nd);
 }
 
 #ifndef CONFIG_NUMA
@@ -710,7 +710,7 @@ int do_huge_pmd_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		if (unlikely(khugepaged_enter(vma)))
 			return VM_FAULT_OOM;
 		page = alloc_hugepage_vma(transparent_hugepage_defrag(vma),
-					  vma, haddr, numa_node_id(), 0);
+					  vma, address, numa_node_id(), 0);
 		if (unlikely(!page)) {
 			count_vm_event(THP_FAULT_FALLBACK);
 			goto out;
@@ -944,7 +944,7 @@ int do_huge_pmd_wp_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (transparent_hugepage_enabled(vma) &&
 	    !transparent_hugepage_debug_cow())
 		new_page = alloc_hugepage_vma(transparent_hugepage_defrag(vma),
-					      vma, haddr, numa_node_id(), 0);
+					      vma, address, numa_node_id(), 0);
 	else
 		new_page = NULL;
 
-- 
1.7.7.6
