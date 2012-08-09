Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2012 17:05:20 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:31735 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903755Ab2HIPDr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2012 17:03:47 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 09 Aug 2012 08:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,740,1336374000"; 
   d="scan'208";a="195494524"
Received: from blue.fi.intel.com ([10.237.72.50])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2012 08:03:10 -0700
Received: by blue.fi.intel.com (Postfix, from userid 1000)
        id 9B902E0069; Thu,  9 Aug 2012 18:03:14 +0300 (EEST)
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
Subject: [PATCH v2 2/6] mm: make clear_huge_page tolerate non aligned address
Date:   Thu,  9 Aug 2012 18:02:59 +0300
Message-Id: <1344524583-1096-3-git-send-email-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
X-archive-position: 34079
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

hugetlb does not necessarily pass in an aligned address, so the
low level address computation is wrong.

This will fix architectures that actually use the address for flushing
the cleared address (very few, like xtensa/sparc/...?)

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/memory.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5736170..b47199a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3987,16 +3987,17 @@ void clear_huge_page(struct page *page,
 		     unsigned long addr, unsigned int pages_per_huge_page)
 {
 	int i;
+	unsigned long haddr = addr & HPAGE_PMD_MASK;
 
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
