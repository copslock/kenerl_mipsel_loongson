Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:52:48 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:43960 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825994Ab2KEWsAKjHYQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:48:00 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi5so3945704pad.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LonywyeY1NXUd18fG679gz3Gm1u+npkfSQa1NSSzh0c=;
        b=RHdbx6J17EWCi4f+h4fbznabactrrrQ1pSPGKT6hFx47dg/WWM7OD/sYX/DQbaMkKo
         miNi7UhoJzyQU5oXo2SqViglnHG0IWVe/2wV03hwkvfq6R4oouOE2M0y61I+po3v9qkG
         yreKHvMCbxANA8W9VuFqGKHvytKaom13hpJEE+pNfkseqiY5WWYce/U70fC6R861mAb8
         Z+7/sZ4uARc24OIGgtY7qLD6iRco01aHzUGe1RgHxnwR7vp3iGIIUB0zQhy46/Syt3Ew
         e09oBFFxDI01P5H68bAb8rO+UPy4QVphkdJRKSGOrY1ff54lw5ipvZGjI5+GR2nCMLUf
         75nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=LonywyeY1NXUd18fG679gz3Gm1u+npkfSQa1NSSzh0c=;
        b=dtGQRJHwtLaL+/7GXlzbldU9+65L8n8ZxMqqJ9Sfmr92wk0Ut/oemr4KQF4ySyRcov
         00BC0tMDm3UiCv/5+V2NecnqXTqz2QLLwxktRlTyDYlQKlvEcIRD9tgJ2va3QDIibOh3
         9JJkwGcEa6ZAu+mw4V7/OzHfA5tN3O/P67GlXmSmxKLSrBnf433cJcsEo5g44rRVRKCQ
         37c9VyT8WROwmq1lBTQNpo5wUjbiaGuPVfV/3J9aAlobF59juY9cMHZirF3+6KI6x3qU
         C7Xrd58Zb9waPo9OGpugQl/8pAbL8/8PoyGbmjxhmCJtx5W78amuuAby6u5WD6snt5Y3
         +amQ==
Received: by 10.69.1.8 with SMTP id bc8mr370495pbd.9.1352155679344;
        Mon, 05 Nov 2012 14:47:59 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:58 -0800 (PST)
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
Subject: [PATCH 16/16] mm: use vm_unmapped_area() in hugetlbfs on tile architecture
Date:   Mon,  5 Nov 2012 14:47:13 -0800
Message-Id: <1352155633-8648-17-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQljplCiHGwZO+gsZfU12HfrJpahpObhvYij0hY4RtLpdfegNHdPdC9J2v4pVo5V71RypFn9zM9G8Lh/dsK0j96E7bY7kZsnDEu8g+d3qW4EUPPl6O+YJQ8inK+a/t7YS2FkH1SncHwe9amflM2kNbOp+sdwkOVLqq0u9AunPKd21fcLB7jAg0+iAjhW07FAAEs4yjw/lPxyoNRuZBe765+qzC6oeg==
X-archive-position: 34886
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

Update the tile hugetlb_get_unmapped_area function to make use of
vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>

---
 arch/tile/mm/hugetlbpage.c |  139 ++++++++------------------------------------
 1 files changed, 25 insertions(+), 114 deletions(-)

diff --git a/arch/tile/mm/hugetlbpage.c b/arch/tile/mm/hugetlbpage.c
index 812e2d037972..6f74cce053e1 100644
--- a/arch/tile/mm/hugetlbpage.c
+++ b/arch/tile/mm/hugetlbpage.c
@@ -231,42 +231,15 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	unsigned long start_addr;
-
-	if (len > mm->cached_hole_size) {
-		start_addr = mm->free_area_cache;
-	} else {
-		start_addr = TASK_UNMAPPED_BASE;
-		mm->cached_hole_size = 0;
-	}
-
-full_search:
-	addr = ALIGN(start_addr, huge_page_size(h));
-
-	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
-		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr) {
-			/*
-			 * Start a new search - just in case we missed
-			 * some holes.
-			 */
-			if (start_addr != TASK_UNMAPPED_BASE) {
-				start_addr = TASK_UNMAPPED_BASE;
-				mm->cached_hole_size = 0;
-				goto full_search;
-			}
-			return -ENOMEM;
-		}
-		if (!vma || addr + len <= vma->vm_start) {
-			mm->free_area_cache = addr + len;
-			return addr;
-		}
-		if (addr + mm->cached_hole_size < vma->vm_start)
-			mm->cached_hole_size = vma->vm_start - addr;
-		addr = ALIGN(vma->vm_end, huge_page_size(h));
-	}
+	struct vm_unmapped_area_info info;
+
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = TASK_UNMAPPED_BASE;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	return vm_unmapped_area(&info);
 }
 
 static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
@@ -274,92 +247,30 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma, *prev_vma;
-	unsigned long base = mm->mmap_base, addr = addr0;
-	unsigned long largest_hole = mm->cached_hole_size;
-	int first_time = 1;
-
-	/* don't allow allocations above current base */
-	if (mm->free_area_cache > base)
-		mm->free_area_cache = base;
-
-	if (len <= largest_hole) {
-		largest_hole = 0;
-		mm->free_area_cache  = base;
-	}
-try_again:
-	/* make sure it can fit in the remaining address space */
-	if (mm->free_area_cache < len)
-		goto fail;
-
-	/* either no address requested or can't fit in requested address hole */
-	addr = (mm->free_area_cache - len) & huge_page_mask(h);
-	do {
-		/*
-		 * Lookup failure means no vma is above this address,
-		 * i.e. return with success:
-		 */
-		vma = find_vma_prev(mm, addr, &prev_vma);
-		if (!vma) {
-			return addr;
-			break;
-		}
-
-		/*
-		 * new region fits between prev_vma->vm_end and
-		 * vma->vm_start, use it:
-		 */
-		if (addr + len <= vma->vm_start &&
-			    (!prev_vma || (addr >= prev_vma->vm_end))) {
-			/* remember the address as a hint for next time */
-			mm->cached_hole_size = largest_hole;
-			mm->free_area_cache = addr;
-			return addr;
-		} else {
-			/* pull free_area_cache down to the first hole */
-			if (mm->free_area_cache == vma->vm_end) {
-				mm->free_area_cache = vma->vm_start;
-				mm->cached_hole_size = largest_hole;
-			}
-		}
+	struct vm_unmapped_area_info info;
+	unsigned long addr;
 
-		/* remember the largest hole we saw so far */
-		if (addr + largest_hole < vma->vm_start)
-			largest_hole = vma->vm_start - addr;
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = PAGE_SIZE;
+	info.high_limit = mm->mmap_base;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	addr = vm_unmapped_area(&info);
 
-		/* try just below the current vma->vm_start */
-		addr = (vma->vm_start - len) & huge_page_mask(h);
-
-	} while (len <= vma->vm_start);
-
-fail:
-	/*
-	 * if hint left us with no space for the requested
-	 * mapping then try again:
-	 */
-	if (first_time) {
-		mm->free_area_cache = base;
-		largest_hole = 0;
-		first_time = 0;
-		goto try_again;
-	}
 	/*
 	 * A failed mmap() very likely causes application failure,
 	 * so fall back to the bottom-up function here. This scenario
 	 * can happen with large stack limits and large mmap()
 	 * allocations.
 	 */
-	mm->free_area_cache = TASK_UNMAPPED_BASE;
-	mm->cached_hole_size = ~0UL;
-	addr = hugetlb_get_unmapped_area_bottomup(file, addr0,
-			len, pgoff, flags);
-
-	/*
-	 * Restore the topdown base:
-	 */
-	mm->free_area_cache = base;
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
