Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Dec 2013 19:00:33 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:15837 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827312Ab3L0SA2P6Rlx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Dec 2013 19:00:28 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 27 Dec 2013 10:00:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,561,1384329600"; 
   d="scan'208";a="458488717"
Received: from unknown (HELO rizzo.int.wil.cx) ([10.255.12.21])
  by orsmga002.jf.intel.com with ESMTP; 27 Dec 2013 10:00:19 -0800
Received: by rizzo.int.wil.cx (Postfix, from userid 1000)
        id AB382172477; Fri, 27 Dec 2013 13:00:18 -0500 (EST)
Date:   Fri, 27 Dec 2013 13:00:18 -0500
From:   Matthew Wilcox <willy@linux.intel.com>
To:     linux-mm@kvack.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH] remap_file_pages needs to check for cache coherency
Message-ID: <20131227180018.GC4945@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <willy@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: willy@linux.intel.com
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


It seems to me that while (for example) on SPARC, it's not possible to
create a non-coherent mapping with mmap(), after we've done an mmap,
we can then use remap_file_pages() to create a mapping that no longer
aliases in the D-cache.

I have only compile-tested this patch.  I don't have any SPARC hardware,
and my PA-RISC hardware hasn't been turned on in six years ... I noticed
this while wandering around looking at some other stuff.

diff --git a/mm/fremap.c b/mm/fremap.c
index 5bff081..01fc2e7 100644
--- a/mm/fremap.c
+++ b/mm/fremap.c
@@ -19,6 +19,7 @@
 
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
+#include <asm/shmparam.h>
 #include <asm/tlbflush.h>
 
 #include "internal.h"
@@ -177,6 +178,13 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	if (start < vma->vm_start || start + size > vma->vm_end)
 		goto out;
 
+#ifdef __ARCH_FORCE_SHMLBA
+	/* Is the mapping cache-coherent? */
+	if ((pgoff ^ linear_page_index(vma, start)) &
+	    ((SHMLBA-1) >> PAGE_SHIFT))
+		goto out;
+#endif
+
 	/* Must set VM_NONLINEAR before any pages are populated. */
 	if (!(vma->vm_flags & VM_NONLINEAR)) {
 		/*
