Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:48:40 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:44191 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825980Ab2KEWrlB1Byy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:41 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi5so3945695pad.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ox5IO0GHV2ue8d0HfWIVdfsBboL4Ws3kfBYCYqJcyWw=;
        b=MnlR9KVGWTcZu8QRT24kRVsmbmzL2+BYofxpMBsKhJ56TlQiBoDjNskiF0TL+AQ8pa
         qlv8RcNsnE79OaFgc3xEJXgyDMkGwvvU61HisuCGC0ZRQLgmbkgsgSkpRWEl/V6eYQBr
         LY7tKJniQz9xHHCNldUGIkZAuTMXfVB6zFyEGFsWOkKjZXLEC0gUnlJPZJVShGak39L+
         kdgKZZ5wtGZE8lUoAxZBII03xUECBk29qN80rhkXPuWq5MczhgEycQZ2GpzewZK1+28K
         QSt67qGJALM8ljsGoxu+KhZg/yYApoMPTLUOisr+c8+inYTHwdJNdJXSzT453L11lF7D
         EJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=ox5IO0GHV2ue8d0HfWIVdfsBboL4Ws3kfBYCYqJcyWw=;
        b=M4ttmbVRtXKnoCvU2XuzDgWCCQZjW4vEkUC5d1xBHDSRifCCubdRL/mhLugyTPtoc9
         T/okm/pK8oOSvr4U7U3CKgP6lTzHEjqEWJgN//vFYl411HtiUcJMQ+/lbWrXODZsKExs
         2VgcVqWlOqVtBm4V1UX9rCa7KtlbfrkRqSBf8fCNlyDk0XxrFC6bCS6AzB6zJdEa2U+d
         3uvtoXTiK2ptJQLzUhMEeAPwvh59X/7BnASMUI/mE2ZaBYWJr6q4T4uoBPz5lhcjifBy
         2GiIhGyG3nJ04ssXfiZVelz5rmBi7MEUXViK82INpknBEOz6Yxw82lBk/pNQyX/39WWd
         AeDQ==
Received: by 10.68.228.36 with SMTP id sf4mr34657627pbc.20.1352155659975;
        Mon, 05 Nov 2012 14:47:39 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:39 -0800 (PST)
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
Subject: [PATCH 05/16] mm: vm_unmapped_area() lookup function
Date:   Mon,  5 Nov 2012 14:47:02 -0800
Message-Id: <1352155633-8648-6-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQlDG5uWIylTsRzmCIPAyDQNqjd4otbsvCBwukXVZx6j8x8VrzxitI7eXImG9p5lniNv7RB54lJyQtbIWRh7/Ad3xFJOyn8HltaCC/Hotg8Rn4PhOstTgud2oZc8sd9J0n+BEG8pTuryY2vIoOxB8sk7Wbzq2hTjf5SSHS1ykDB+OlkbAg7hPuY+WW+gTDl50Qrrz0HKtWy3Umwc5ZAMllENzCfD4A==
X-archive-position: 34873
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

Implement vm_unmapped_area() using the rb_subtree_gap and highest_vm_end
information to look up for suitable virtual address space gaps.

struct vm_unmapped_area_info is used to define the desired allocation
request:
- lowest or highest possible address matching the remaining constraints
- desired gap length
- low/high address limits that the gap must fit into
- alignment mask and offset

Also update the generic arch_get_unmapped_area[_topdown] functions to
make use of vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>
Reviewed-by: Rik van Riel <riel@redhat.com>

---
 include/linux/mm.h |   31 +++++
 mm/mmap.c          |  312 +++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 253 insertions(+), 90 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fa0680402738..441dfe8ea24d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1456,6 +1456,37 @@ extern unsigned long vm_mmap(struct file *, unsigned long,
         unsigned long, unsigned long,
         unsigned long, unsigned long);
 
+struct vm_unmapped_area_info {
+#define VM_UNMAPPED_AREA_TOPDOWN 1
+	unsigned long flags;
+	unsigned long length;
+	unsigned long low_limit;
+	unsigned long high_limit;
+	unsigned long align_mask;
+	unsigned long align_offset;
+};
+
+extern unsigned long unmapped_area(struct vm_unmapped_area_info *info);
+extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
+
+/*
+ * Search for an unmapped address range.
+ *
+ * We are looking for a range that:
+ * - does not intersect with any VMA;
+ * - is contained within the [low_limit, high_limit) interval;
+ * - is at least the desired size.
+ * - satisfies (begin_addr & align_mask) == (align_offset & align_mask)
+ */
+static inline unsigned long
+vm_unmapped_area(struct vm_unmapped_area_info *info)
+{
+	if (!(info->flags & VM_UNMAPPED_AREA_TOPDOWN))
+		return unmapped_area(info);
+	else
+		return unmapped_area_topdown(info);
+}
+
 /* truncate.c */
 extern void truncate_inode_pages(struct address_space *, loff_t);
 extern void truncate_inode_pages_range(struct address_space *,
diff --git a/mm/mmap.c b/mm/mmap.c
index 769a09cc71af..aa748988cd54 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1496,6 +1496,206 @@ unacct_error:
 	return error;
 }
 
+unsigned long unmapped_area(struct vm_unmapped_area_info *info)
+{
+	/*
+	 * We implement the search by looking for an rbtree node that
+	 * immediately follows a suitable gap. That is,
+	 * - gap_start = vma->vm_prev->vm_end <= info->high_limit - length;
+	 * - gap_end   = vma->vm_start        >= info->low_limit  + length;
+	 * - gap_end - gap_start >= length
+	 */
+
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+
+	/* Adjust search length to account for worst case alignment overhead */
+	length = info->length + info->align_mask;
+	if (length < info->length)
+		return -ENOMEM;
+
+	/* Adjust search limits by the desired length */
+	if (info->high_limit < length)
+		return -ENOMEM;
+	high_limit = info->high_limit - length;
+
+	if (info->low_limit > high_limit)
+		return -ENOMEM;
+	low_limit = info->low_limit + length;
+
+	/* Check if rbtree root looks promising */
+	if (RB_EMPTY_ROOT(&mm->mm_rb))
+		goto check_highest;
+	vma = rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
+	if (vma->rb_subtree_gap < length)
+		goto check_highest;
+
+	while (true) {
+		/* Visit left subtree if it looks promising */
+		gap_end = vma->vm_start;
+		if (gap_end >= low_limit && vma->vm_rb.rb_left) {
+			struct vm_area_struct *left =
+				rb_entry(vma->vm_rb.rb_left,
+					 struct vm_area_struct, vm_rb);
+			if (left->rb_subtree_gap >= length) {
+				vma = left;
+				continue;
+			}
+		}
+
+		gap_start = vma->vm_prev ? vma->vm_prev->vm_end : 0;
+	check_current:
+		/* Check if current node has a suitable gap */
+		if (gap_start > high_limit)
+			return -ENOMEM;
+		if (gap_end >= low_limit && gap_end - gap_start >= length)
+			goto found;
+
+		/* Visit right subtree if it looks promising */
+		if (vma->vm_rb.rb_right) {
+			struct vm_area_struct *right =
+				rb_entry(vma->vm_rb.rb_right,
+					 struct vm_area_struct, vm_rb);
+			if (right->rb_subtree_gap >= length) {
+				vma = right;
+				continue;
+			}
+		}
+
+		/* Go back up the rbtree to find next candidate node */
+		while (true) {
+			struct rb_node *prev = &vma->vm_rb;
+			if (!rb_parent(prev))
+				goto check_highest;
+			vma = rb_entry(rb_parent(prev),
+				       struct vm_area_struct, vm_rb);
+			if (prev == vma->vm_rb.rb_left) {
+				gap_start = vma->vm_prev->vm_end;
+				gap_end = vma->vm_start;
+				goto check_current;
+			}
+		}
+	}
+
+check_highest:
+	/* Check highest gap, which does not precede any rbtree node */
+	gap_start = mm->highest_vm_end;
+	gap_end = ULONG_MAX;  /* Only for VM_BUG_ON below */
+	if (gap_start > high_limit)
+		return -ENOMEM;
+
+found:
+	/* We found a suitable gap. Clip it with the original low_limit. */
+	if (gap_start < info->low_limit)
+		gap_start = info->low_limit;
+
+	/* Adjust gap address to the desired alignment */
+	gap_start += (info->align_offset - gap_start) & info->align_mask;
+
+	VM_BUG_ON(gap_start + info->length > info->high_limit);
+	VM_BUG_ON(gap_start + info->length > gap_end);
+	return gap_start;
+}
+
+unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+
+	/* Adjust search length to account for worst case alignment overhead */
+	length = info->length + info->align_mask;
+	if (length < info->length)
+		return -ENOMEM;
+
+	/*
+	 * Adjust search limits by the desired length.
+	 * See implementation comment at top of unmapped_area().
+	 */
+	gap_end = info->high_limit;
+	if (gap_end < length)
+		return -ENOMEM;
+	high_limit = gap_end - length;
+
+	if (info->low_limit > high_limit)
+		return -ENOMEM;
+	low_limit = info->low_limit + length;
+
+	/* Check highest gap, which does not precede any rbtree node */
+	gap_start = mm->highest_vm_end;
+	if (gap_start <= high_limit)
+		goto found_highest;
+
+	/* Check if rbtree root looks promising */
+	if (RB_EMPTY_ROOT(&mm->mm_rb))
+		return -ENOMEM;
+	vma = rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
+	if (vma->rb_subtree_gap < length)
+		return -ENOMEM;
+
+	while (true) {
+		/* Visit right subtree if it looks promising */
+		gap_start = vma->vm_prev ? vma->vm_prev->vm_end : 0;
+		if (gap_start <= high_limit && vma->vm_rb.rb_right) {
+			struct vm_area_struct *right =
+				rb_entry(vma->vm_rb.rb_right,
+					 struct vm_area_struct, vm_rb);
+			if (right->rb_subtree_gap >= length) {
+				vma = right;
+				continue;
+			}
+		}
+
+	check_current:
+		/* Check if current node has a suitable gap */
+		gap_end = vma->vm_start;
+		if (gap_end < low_limit)
+			return -ENOMEM;
+		if (gap_start <= high_limit && gap_end - gap_start >= length)
+			goto found;
+
+		/* Visit left subtree if it looks promising */
+		if (vma->vm_rb.rb_left) {
+			struct vm_area_struct *left =
+				rb_entry(vma->vm_rb.rb_left,
+					 struct vm_area_struct, vm_rb);
+			if (left->rb_subtree_gap >= length) {
+				vma = left;
+				continue;
+			}
+		}
+
+		/* Go back up the rbtree to find next candidate node */
+		while (true) {
+			struct rb_node *prev = &vma->vm_rb;
+			if (!rb_parent(prev))
+				return -ENOMEM;
+			vma = rb_entry(rb_parent(prev),
+				       struct vm_area_struct, vm_rb);
+			if (prev == vma->vm_rb.rb_right) {
+				gap_start = vma->vm_prev ?
+					vma->vm_prev->vm_end : 0;
+				goto check_current;
+			}
+		}
+	}
+
+found:
+	/* We found a suitable gap. Clip it with the original high_limit. */
+	if (gap_end > info->high_limit)
+		gap_end = info->high_limit;
+
+found_highest:
+	/* Compute highest gap address at the desired alignment */
+	gap_end -= info->length;
+	gap_end -= (gap_end - info->align_offset) & info->align_mask;
+
+	VM_BUG_ON(gap_end < info->low_limit);
+	VM_BUG_ON(gap_end < gap_start);
+	return gap_end;
+}
+
 /* Get an address range which is currently unmapped.
  * For shmat() with addr=0.
  *
@@ -1514,7 +1714,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long start_addr;
+	struct vm_unmapped_area_info info;
 
 	if (len > TASK_SIZE)
 		return -ENOMEM;
@@ -1529,40 +1729,13 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
-	if (len > mm->cached_hole_size) {
-	        start_addr = addr = mm->free_area_cache;
-	} else {
-	        start_addr = addr = TASK_UNMAPPED_BASE;
-	        mm->cached_hole_size = 0;
-	}
 
-full_search:
-	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
-		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr) {
-			/*
-			 * Start a new search - just in case we missed
-			 * some holes.
-			 */
-			if (start_addr != TASK_UNMAPPED_BASE) {
-				addr = TASK_UNMAPPED_BASE;
-			        start_addr = addr;
-				mm->cached_hole_size = 0;
-				goto full_search;
-			}
-			return -ENOMEM;
-		}
-		if (!vma || addr + len <= vma->vm_start) {
-			/*
-			 * Remember the place where we stopped the search:
-			 */
-			mm->free_area_cache = addr + len;
-			return addr;
-		}
-		if (addr + mm->cached_hole_size < vma->vm_start)
-		        mm->cached_hole_size = vma->vm_start - addr;
-		addr = vma->vm_end;
-	}
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = TASK_UNMAPPED_BASE;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = 0;
+	return vm_unmapped_area(&info);
 }
 #endif	
 
@@ -1587,7 +1760,8 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
-	unsigned long addr = addr0, start_addr;
+	unsigned long addr = addr0;
+	struct vm_unmapped_area_info info;
 
 	/* requested length too big for entire address space */
 	if (len > TASK_SIZE)
@@ -1605,53 +1779,12 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 			return addr;
 	}
 
-	/* check if free_area_cache is useful for us */
-	if (len <= mm->cached_hole_size) {
- 	        mm->cached_hole_size = 0;
- 		mm->free_area_cache = mm->mmap_base;
- 	}
-
-try_again:
-	/* either no address requested or can't fit in requested address hole */
-	start_addr = addr = mm->free_area_cache;
-
-	if (addr < len)
-		goto fail;
-
-	addr -= len;
-	do {
-		/*
-		 * Lookup failure means no vma is above this address,
-		 * else if new region fits below vma->vm_start,
-		 * return with success:
-		 */
-		vma = find_vma(mm, addr);
-		if (!vma || addr+len <= vma->vm_start)
-			/* remember the address as a hint for next time */
-			return (mm->free_area_cache = addr);
-
- 		/* remember the largest hole we saw so far */
- 		if (addr + mm->cached_hole_size < vma->vm_start)
- 		        mm->cached_hole_size = vma->vm_start - addr;
-
-		/* try just below the current vma->vm_start */
-		addr = vma->vm_start-len;
-	} while (len < vma->vm_start);
-
-fail:
-	/*
-	 * if hint left us with no space for the requested
-	 * mapping then try again:
-	 *
-	 * Note: this is different with the case of bottomup
-	 * which does the fully line-search, but we use find_vma
-	 * here that causes some holes skipped.
-	 */
-	if (start_addr != mm->mmap_base) {
-		mm->free_area_cache = mm->mmap_base;
-		mm->cached_hole_size = 0;
-		goto try_again;
-	}
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = PAGE_SIZE;
+	info.high_limit = mm->mmap_base;
+	info.align_mask = 0;
+	addr = vm_unmapped_area(&info);
 
 	/*
 	 * A failed mmap() very likely causes application failure,
@@ -1659,14 +1792,13 @@ fail:
 	 * can happen with large stack limits and large mmap()
 	 * allocations.
 	 */
-	mm->cached_hole_size = ~0UL;
-  	mm->free_area_cache = TASK_UNMAPPED_BASE;
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
