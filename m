Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2012 15:55:12 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:59977 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903467Ab2HTNwt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Aug 2012 15:52:49 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 20 Aug 2012 06:52:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,797,1336374000"; 
   d="scan'208";a="206475030"
Received: from blue.fi.intel.com ([10.237.72.50])
  by fmsmga001.fm.intel.com with ESMTP; 20 Aug 2012 06:52:38 -0700
Received: by blue.fi.intel.com (Postfix, from userid 1000)
        id BD131E008C; Mon, 20 Aug 2012 16:52:43 +0300 (EEST)
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
Subject: [PATCH v4 8/8] mm: implement vm.clear_huge_page_nocache sysctl
Date:   Mon, 20 Aug 2012 16:52:37 +0300
Message-Id: <1345470757-12005-9-git-send-email-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com>
X-archive-position: 34293
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

In some cases cache avoiding clearing huge page may slow down workload.
Let's provide an sysctl handle to disable it.

We use static_key here to avoid extra work on fast path.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/sysctl/vm.txt |   13 ++++++++++++
 include/linux/mm.h          |    5 ++++
 kernel/sysctl.c             |   12 +++++++++++
 mm/memory.c                 |   44 +++++++++++++++++++++++++++++++++++++-----
 4 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
index 078701f..9559a97 100644
--- a/Documentation/sysctl/vm.txt
+++ b/Documentation/sysctl/vm.txt
@@ -19,6 +19,7 @@ files can be found in mm/swap.c.
 Currently, these files are in /proc/sys/vm:
 
 - block_dump
+- clear_huge_page_nocache
 - compact_memory
 - dirty_background_bytes
 - dirty_background_ratio
@@ -74,6 +75,18 @@ huge pages although processes will also directly compact memory as required.
 
 ==============================================================
 
+clear_huge_page_nocache
+
+Available only when the architecture provides ARCH_HAS_USER_NOCACHE and
+CONFIG_TRANSPARENT_HUGEPAGE or CONFIG_HUGETLBFS is set.
+
+When set to 1 (default) kernel will use cache avoiding clear routine for
+clearing huge pages. This minimize cache pollution.
+When set to 0 kernel will clear huge pages through cache. This may speed
+up some workloads. Also it's useful for benchmarking propose.
+
+==============================================================
+
 dirty_background_bytes
 
 Contains the amount of dirty memory at which the background kernel
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2858723..9b48f43 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1643,6 +1643,11 @@ extern void clear_huge_page(struct page *page,
 extern void copy_user_huge_page(struct page *dst, struct page *src,
 				unsigned long addr, struct vm_area_struct *vma,
 				unsigned int pages_per_huge_page);
+#ifdef ARCH_HAS_USER_NOCACHE
+extern int sysctl_clear_huge_page_nocache;
+extern int clear_huge_page_nocache_handler(struct ctl_table *table, int write,
+		void __user *buffer, size_t *length, loff_t *ppos);
+#endif
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 87174ef..80ccc67 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1366,6 +1366,18 @@ static struct ctl_table vm_table[] = {
 		.extra2		= &one,
 	},
 #endif
+#if defined(ARCH_HAS_USER_NOCACHE) && \
+	(defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS))
+	{
+		.procname	= "clear_huge_page_nocache",
+		.data		= &sysctl_clear_huge_page_nocache,
+		.maxlen		= sizeof(sysctl_clear_huge_page_nocache),
+		.mode		= 0644,
+		.proc_handler	= clear_huge_page_nocache_handler,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+#endif
 	{ }
 };
 
diff --git a/mm/memory.c b/mm/memory.c
index 625ca33..395d574 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -57,6 +57,7 @@
 #include <linux/swapops.h>
 #include <linux/elf.h>
 #include <linux/gfp.h>
+#include <linux/static_key.h>
 
 #include <asm/io.h>
 #include <asm/pgalloc.h>
@@ -3970,12 +3971,43 @@ EXPORT_SYMBOL(might_fault);
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
 
-#ifndef ARCH_HAS_USER_NOCACHE
-#define ARCH_HAS_USER_NOCACHE 0
-#endif
+#ifdef ARCH_HAS_USER_NOCACHE
+int sysctl_clear_huge_page_nocache = 1;
+static DEFINE_MUTEX(sysctl_clear_huge_page_nocache_lock);
+static struct static_key clear_huge_page_nocache __read_mostly =
+	STATIC_KEY_INIT_TRUE;
 
-#if ARCH_HAS_USER_NOCACHE == 0
+static inline int is_nocache_enabled(void)
+{
+	return static_key_true(&clear_huge_page_nocache);
+}
+
+int clear_huge_page_nocache_handler(struct ctl_table *table, int write,
+		void __user *buffer, size_t *length, loff_t *ppos)
+{
+	int orig_value = sysctl_clear_huge_page_nocache;
+	int ret;
+
+	mutex_lock(&sysctl_clear_huge_page_nocache_lock);
+	orig_value = sysctl_clear_huge_page_nocache;
+	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
+	if (!ret && write && sysctl_clear_huge_page_nocache != orig_value) {
+		if (sysctl_clear_huge_page_nocache)
+			static_key_slow_inc(&clear_huge_page_nocache);
+		else
+			static_key_slow_dec(&clear_huge_page_nocache);
+	}
+	mutex_unlock(&sysctl_clear_huge_page_nocache_lock);
+
+	return ret;
+}
+#else
 #define clear_user_highpage_nocache clear_user_highpage
+
+static inline int is_nocache_enabled(void)
+{
+	return 0;
+}
 #endif
 
 static void clear_gigantic_page(struct page *page,
@@ -3991,7 +4023,7 @@ static void clear_gigantic_page(struct page *page,
 	for (i = 0, vaddr = haddr; i < pages_per_huge_page;
 			i++, p = mem_map_next(p, page, i), vaddr += PAGE_SIZE) {
 		cond_resched();
-		if (!ARCH_HAS_USER_NOCACHE  || i == target)
+		if (!is_nocache_enabled() || i == target)
 			clear_user_highpage(p, vaddr);
 		else
 			clear_user_highpage_nocache(p, vaddr);
@@ -4015,7 +4047,7 @@ void clear_huge_page(struct page *page,
 	for (i = 0, vaddr = haddr; i < pages_per_huge_page;
 			i++, page++, vaddr += PAGE_SIZE) {
 		cond_resched();
-		if (!ARCH_HAS_USER_NOCACHE || i == target)
+		if (!is_nocache_enabled() || i == target)
 			clear_user_highpage(page, vaddr);
 		else
 			clear_user_highpage_nocache(page, vaddr);
-- 
1.7.7.6
