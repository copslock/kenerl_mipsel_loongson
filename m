Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:51:31 +0100 (CET)
Received: from mail-da0-f49.google.com ([209.85.210.49]:57030 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825986Ab2KEWrwxsqMR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:52 +0100
Received: by mail-da0-f49.google.com with SMTP id q27so2653793daj.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jriq2c28wB7qvBxitV3Yd3C3X4S2XGT9zeWPSztxpbY=;
        b=oVzpOWaNpXfXNVTDmftk8wN8BwGYZyuJahaoUxa2G7y5LjnYVXUHGYIsy6I2ioH+3R
         MJddHQFuKggNToSkICvHqsSsARlzUkNv5FFKY+JA3mLYhojOzf/vvEhIE2JkgBaXwM2X
         YpKBAmNItSs5Cyq3YFWWAkmA9uWw31ZCGwzU9ZNujkeCxvol+4e7HByO8nqYogvzEsTa
         AKWI4RSLl9IYLG1Yf8rC7wDfc5jspxqyOLx0WFRDcHcDZmhpfY58usw4KJxyq2K/CbSx
         xnpqV73XbbrN65OjePUw6f/fjcVtb7GKNpNouNWQKTSbfrtDRKVIXliUZJjF39CcbwFh
         TRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=jriq2c28wB7qvBxitV3Yd3C3X4S2XGT9zeWPSztxpbY=;
        b=mO1IsmNV+Ef6oeqfDQ195iBGmm4Ng/BrgoMfesZrZtaQPIlpOyjiD/nUp1CebdDiGC
         6TdZKdRQwLnItTNB353LKnUTEKrREsAaGh5whV41THmI5yGL4HzTT8QetMjXCG6eyvgJ
         YcHFHZ4prSadm5qf9gdGVU+q6GK5KzuJaJreiP3ovEAiJlRmOe4tZd/YtlGuUylaxqcx
         KNuAtAgKhH4O6h4l6kKv2vYftXLyziNiXybglpZ6W1FAiiXUV02yptyGxvNTf0r0X610
         ghN4h5r6EpBBkzdGG3zqphGC2MzdK4Nav8mmbz4H1/w6zi592mSyl4g9yUSuEqkX1GxI
         DsQw==
Received: by 10.68.197.71 with SMTP id is7mr34543465pbc.79.1352155672086;
        Mon, 05 Nov 2012 14:47:52 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:51 -0800 (PST)
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org,
        William Irwin <wli@holomorphy.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH 12/16] mm: use vm_unmapped_area() on sh architecture
Date:   Mon,  5 Nov 2012 14:47:09 -0800
Message-Id: <1352155633-8648-13-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQndw68bd7xZh59NduyFnDFZNxi5SsYFdxcgVNvXiZRdo2ej917YSJAFQ9ivNhbgVLknyP8ZOVpLTyFRI7uU0pEd7OqWl7pfkY0lHS9P1x7mN9+ysEpTHuPb6xH6xoiXISma6+oukITT9rxK+kr3lxzsriMluArjTUeFZrmklYuXZGQgPVLkQ8Pqxa9k8bC/lOfphpBy9vUuXbzkeNL7yjpHeerrag==
X-archive-position: 34882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: walken@google.com
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

Update the sh arch_get_unmapped_area[_topdown] functions to make
use of vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>

---
 arch/sh/mm/mmap.c |  126 ++++++++++-------------------------------------------
 1 files changed, 24 insertions(+), 102 deletions(-)

diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index afeb710ec5c3..acb3b8f71908 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -49,6 +49,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct vm_area_struct *vma;
 	unsigned long start_addr;
 	int do_colour_align;
+	struct vm_unmapped_area_info info;
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -79,47 +80,13 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 			return addr;
 	}
 
-	if (len > mm->cached_hole_size) {
-		start_addr = addr = mm->free_area_cache;
-	} else {
-	        mm->cached_hole_size = 0;
-		start_addr = addr = TASK_UNMAPPED_BASE;
-	}
-
-full_search:
-	if (do_colour_align)
-		addr = COLOUR_ALIGN(addr, pgoff);
-	else
-		addr = PAGE_ALIGN(mm->free_area_cache);
-
-	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
-		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (unlikely(TASK_SIZE - len < addr)) {
-			/*
-			 * Start a new search - just in case we missed
-			 * some holes.
-			 */
-			if (start_addr != TASK_UNMAPPED_BASE) {
-				start_addr = addr = TASK_UNMAPPED_BASE;
-				mm->cached_hole_size = 0;
-				goto full_search;
-			}
-			return -ENOMEM;
-		}
-		if (likely(!vma || addr + len <= vma->vm_start)) {
-			/*
-			 * Remember the place where we stopped the search:
-			 */
-			mm->free_area_cache = addr + len;
-			return addr;
-		}
-		if (addr + mm->cached_hole_size < vma->vm_start)
-		        mm->cached_hole_size = vma->vm_start - addr;
-
-		addr = vma->vm_end;
-		if (do_colour_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-	}
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = TASK_UNMAPPED_BASE;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
+	return vm_unmapped_area(&info);
 }
 
 unsigned long
@@ -131,6 +98,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
 	int do_colour_align;
+	struct vm_unmapped_area_info info;
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -162,73 +130,27 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 			return addr;
 	}
 
-	/* check if free_area_cache is useful for us */
-	if (len <= mm->cached_hole_size) {
-	        mm->cached_hole_size = 0;
-		mm->free_area_cache = mm->mmap_base;
-	}
-
-	/* either no address requested or can't fit in requested address hole */
-	addr = mm->free_area_cache;
-	if (do_colour_align) {
-		unsigned long base = COLOUR_ALIGN_DOWN(addr-len, pgoff);
-
-		addr = base + len;
-	}
-
-	/* make sure it can fit in the remaining address space */
-	if (likely(addr > len)) {
-		vma = find_vma(mm, addr-len);
-		if (!vma || addr <= vma->vm_start) {
-			/* remember the address as a hint for next time */
-			return (mm->free_area_cache = addr-len);
-		}
-	}
-
-	if (unlikely(mm->mmap_base < len))
-		goto bottomup;
-
-	addr = mm->mmap_base-len;
-	if (do_colour_align)
-		addr = COLOUR_ALIGN_DOWN(addr, pgoff);
-
-	do {
-		/*
-		 * Lookup failure means no vma is above this address,
-		 * else if new region fits below vma->vm_start,
-		 * return with success:
-		 */
-		vma = find_vma(mm, addr);
-		if (likely(!vma || addr+len <= vma->vm_start)) {
-			/* remember the address as a hint for next time */
-			return (mm->free_area_cache = addr);
-		}
-
-		/* remember the largest hole we saw so far */
-		if (addr + mm->cached_hole_size < vma->vm_start)
-		        mm->cached_hole_size = vma->vm_start - addr;
-
-		/* try just below the current vma->vm_start */
-		addr = vma->vm_start-len;
-		if (do_colour_align)
-			addr = COLOUR_ALIGN_DOWN(addr, pgoff);
-	} while (likely(len < vma->vm_start));
-
-bottomup:
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = PAGE_SIZE;
+	info.high_limit = mm->mmap_base;
+	info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
+	addr = vm_unmapped_area(&info);
+	
 	/*
 	 * A failed mmap() very likely causes application failure,
 	 * so fall back to the bottom-up function here. This scenario
 	 * can happen with large stack limits and large mmap()
 	 * allocations.
 	 */
-	mm->cached_hole_size = ~0UL;
-	mm->free_area_cache = TASK_UNMAPPED_BASE;
-	addr = arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
-	/*
-	 * Restore the topdown base:
-	 */
-	mm->free_area_cache = mm->mmap_base;
-	mm->cached_hole_size = ~0UL;
+	if (addr & ~PAGE_MASK) {
+		VM_BUG_ON(addr != -ENOMEM);
+		info.flags = 0;
+		info.low_limit = TASK_UNMAPPED_BASE;
+		info.high_limit = TASK_SIZE;
+		addr = vm_unmapped_area(&info);
+	}
 
 	return addr;
 }
-- 
1.7.7.3
