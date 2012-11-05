Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:48:20 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:43960 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825981Ab2KEWrk5cmD5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:40 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi5so3945704pad.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Yid5AWhjb00shEhnqoBh3vNclIZEG1J/PacIg3y29t4=;
        b=j7MCXUnA08iaq7E1SsW2SMPyHUaJ8LXdqs47fV8wxql0654NlkcnnA7b56UNT8D14b
         xxjq/ZFcIjDKpWlq3z7KngFPvEz0xnmM04cWnGB9DH137gLRGxZhuDhHvfV4u6X1c84R
         WCXZ8egdN00FaKpYdE/u1o7Ci/JMV94HKSP0Pi6k+VXUWqr4UL0ecpJT0e+EGQP3/v0i
         bc0LhH/+f2bSRjUAkOFiFOIfXqweqwTb/bxszMbH+IGiZ21ROHWDutjRQEquLegvYpxH
         4fZtgDuUeINEK7nlK0PnaxpwDTA5I2a5jxhkzCoTLBgv7OXgXH35XHV65S/pCl/UshxF
         zOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=Yid5AWhjb00shEhnqoBh3vNclIZEG1J/PacIg3y29t4=;
        b=S3Q7HW8vB9Vzfcf2L93mmVrLwzm8klpaMoraovtlwpoDqBTZwHbJGTGae+6ih8OHyB
         JKhU8az5tbKictslHvuepDocJWvCEsxPz9oXt8lC3qhUgb/FvmMalNb+/QlGrqYrtMnw
         YOzAXE2ne7EYvnbK4di5iGDon8f29sYDhgIVZJCA/WkzFbaxClAwChBppchIKK9vfKag
         NzZ+XgeOfuFZRsI8E0Ppgn9NYkSKRMSx4k30FOIoiX2pF5qj9FSjBVv49FooW2vo1XKj
         Uqgu/PMDFyfqgceYbXKtebDI9j5wQEFEVapodflD8RUTiL2MvQq7+1FPHW6J5MXN1cT1
         5CCg==
Received: by 10.68.201.6 with SMTP id jw6mr34254471pbc.149.1352155654551;
        Mon, 05 Nov 2012 14:47:34 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:33 -0800 (PST)
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
Subject: [PATCH 02/16] mm: augment vma rbtree with rb_subtree_gap
Date:   Mon,  5 Nov 2012 14:46:59 -0800
Message-Id: <1352155633-8648-3-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQmIn7XVcWU2wPj8ogIRoR6vBODz8jz24Qoh3MPqMkNcV55BZHiW8JIc4McZ+izHfj+7qWtPTogGWlK10P2YkOSQO9vZnl/0uDfDoKD6MPIYXZfzUNxgv90Y8qlO++/U7oUzajvjU4xdNW/fZx5NguAbZ7aZCOZ582UZ4jQpmFqaTMdIg/VeZU9XMtnwFlWw+ecdy/8IPQVl3xTCreSyRNL60n1rvg==
X-archive-position: 34872
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

Define vma->rb_subtree_gap as the largest gap between any vma in the
subtree rooted at that vma, and their predecessor. Or, for a recursive
definition, vma->rb_subtree_gap is the max of:
- vma->vm_start - vma->vm_prev->vm_end
- rb_subtree_gap fields of the vmas pointed by vma->rb.rb_left and
  vma->rb.rb_right

This will allow get_unmapped_area_* to find a free area of the right
size in O(log(N)) time, instead of potentially having to do a linear
walk across all the VMAs.

Also define mm->highest_vm_end as the vm_end field of the highest vma,
so that we can easily check if the following gap is suitable.

This does have the potential to make unmapping VMAs more expensive,
especially for processes with very large numbers of VMAs, where the
VMA rbtree can grow quite deep.

Signed-off-by: Michel Lespinasse <walken@google.com>
Reviewed-by: Rik van Riel <riel@redhat.com>

---
 include/linux/mm_types.h |    9 ++++
 mm/mmap.c                |  114 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 114 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 31f8a3af7d94..94fa52b28ee8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -238,6 +238,14 @@ struct vm_area_struct {
 	struct rb_node vm_rb;
 
 	/*
+	 * Largest free memory gap in bytes to the left of this VMA.
+	 * Either between this VMA and vma->vm_prev, or between one of the
+	 * VMAs below us in the VMA rbtree and its ->vm_prev. This helps
+	 * get_unmapped_area find a free area of the right size.
+	 */
+	unsigned long rb_subtree_gap;
+
+	/*
 	 * For areas with an address space and backing store,
 	 * linkage into the address_space->i_mmap interval tree, or
 	 * linkage of vma in the address_space->i_mmap_nonlinear list.
@@ -322,6 +330,7 @@ struct mm_struct {
 	unsigned long task_size;		/* size of task vm space */
 	unsigned long cached_hole_size; 	/* if non-zero, the largest hole below free_area_cache */
 	unsigned long free_area_cache;		/* first hole of size cached_hole_size or larger */
+	unsigned long highest_vm_end;		/* highest vma end address */
 	pgd_t * pgd;
 	atomic_t mm_users;			/* How many users with user space? */
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
diff --git a/mm/mmap.c b/mm/mmap.c
index cf18502e75c6..2de8bcfe859d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -31,6 +31,7 @@
 #include <linux/audit.h>
 #include <linux/khugepaged.h>
 #include <linux/uprobes.h>
+#include <linux/rbtree_augmented.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -297,6 +298,70 @@ out:
 	return retval;
 }
 
+static long vma_compute_subtree_gap(struct vm_area_struct *vma)
+{
+	unsigned long max, subtree_gap;
+	max = vma->vm_start;
+	if (vma->vm_prev)
+		max -= vma->vm_prev->vm_end;
+	if (vma->vm_rb.rb_left) {
+		subtree_gap = rb_entry(vma->vm_rb.rb_left,
+				struct vm_area_struct, vm_rb)->rb_subtree_gap;
+		if (subtree_gap > max)
+			max = subtree_gap;
+	}
+	if (vma->vm_rb.rb_right) {
+		subtree_gap = rb_entry(vma->vm_rb.rb_right,
+				struct vm_area_struct, vm_rb)->rb_subtree_gap;
+		if (subtree_gap > max)
+			max = subtree_gap;
+	}
+	return max;
+}
+
+RB_DECLARE_CALLBACKS(static, vma_gap_callbacks, struct vm_area_struct, vm_rb,
+		     unsigned long, rb_subtree_gap, vma_compute_subtree_gap)
+
+/*
+ * Update augmented rbtree rb_subtree_gap values after vma->vm_start or
+ * vma->vm_prev->vm_end values changed, without modifying the vma's position
+ * in the rbtree.
+ */
+static void vma_gap_update(struct vm_area_struct *vma)
+{
+	/*
+	 * As it turns out, RB_DECLARE_CALLBACKS() already created a callback
+	 * function that does exacltly what we want.
+	 */
+	vma_gap_callbacks_propagate(&vma->vm_rb, NULL);
+}
+
+static inline void vma_rb_insert(struct vm_area_struct *vma,
+				 struct rb_root *root)
+{
+	/*
+	 * vma->vm_prev wasn't known when we followed the rbtree to find the
+	 * correct insertion point for that vma. As a result, we could not
+	 * update the vma vm_rb parents rb_subtree_gap values on the way down.
+	 * So, we first insert the vma with a zero rb_subtree_gap value
+	 * (to be consistent with what we did on the way down), and then
+	 * immediately update the gap to the correct value.
+	 */
+	vma->rb_subtree_gap = 0;
+	rb_insert_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
+	vma_gap_update(vma);
+}
+
+static void vma_rb_erase(struct vm_area_struct *vma, struct rb_root *root)
+{
+	/*
+	 * Note rb_erase_augmented is a fairly large inline function,
+	 * so make sure we instantiate it only once with our desired
+	 * augmented rbtree callbacks.
+	 */
+	rb_erase_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
+}
+
 #ifdef CONFIG_DEBUG_VM_RB
 static int browse_rb(struct rb_root *root)
 {
@@ -422,7 +487,11 @@ void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct rb_node **rb_link, struct rb_node *rb_parent)
 {
 	rb_link_node(&vma->vm_rb, rb_parent, rb_link);
-	rb_insert_color(&vma->vm_rb, &mm->mm_rb);
+	vma_rb_insert(vma, &mm->mm_rb);
+	if (vma->vm_next)
+		vma_gap_update(vma->vm_next);
+	else
+		mm->highest_vm_end = vma->vm_end;
 }
 
 static void __vma_link_file(struct vm_area_struct *vma)
@@ -503,7 +572,7 @@ __vma_unlink(struct mm_struct *mm, struct vm_area_struct *vma,
 	prev->vm_next = next;
 	if (next)
 		next->vm_prev = prev;
-	rb_erase(&vma->vm_rb, &mm->mm_rb);
+	vma_rb_erase(vma, &mm->mm_rb);
 	if (mm->mmap_cache == vma)
 		mm->mmap_cache = prev;
 }
@@ -525,6 +594,7 @@ int vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	struct rb_root *root = NULL;
 	struct anon_vma *anon_vma = NULL;
 	struct file *file = vma->vm_file;
+	bool start_changed = false, end_changed = false;
 	long adjust_next = 0;
 	int remove_next = 0;
 
@@ -615,8 +685,14 @@ again:			remove_next = 1 + (end > next->vm_end);
 			vma_interval_tree_remove(next, root);
 	}
 
-	vma->vm_start = start;
-	vma->vm_end = end;
+	if (start != vma->vm_start) {
+		vma->vm_start = start;
+		start_changed = true;
+	}
+	if (end != vma->vm_end) {
+		vma->vm_end = end;
+		end_changed = true;
+	}
 	vma->vm_pgoff = pgoff;
 	if (adjust_next) {
 		next->vm_start += adjust_next << PAGE_SHIFT;
@@ -645,6 +721,15 @@ again:			remove_next = 1 + (end > next->vm_end);
 		 * (it may either follow vma or precede it).
 		 */
 		__insert_vm_struct(mm, insert);
+	} else {
+		if (start_changed)
+			vma_gap_update(vma);
+		if (end_changed) {
+			if (!next)
+				mm->highest_vm_end = end;
+			else if (!adjust_next)
+				vma_gap_update(next);
+		}
 	}
 
 	if (anon_vma) {
@@ -678,10 +763,13 @@ again:			remove_next = 1 + (end > next->vm_end);
 		 * we must remove another next too. It would clutter
 		 * up the code too much to do both in one go.
 		 */
-		if (remove_next == 2) {
-			next = vma->vm_next;
+		next = vma->vm_next;
+		if (remove_next == 2)
 			goto again;
-		}
+		else if (next)
+			vma_gap_update(next);
+		else
+			mm->highest_vm_end = end;
 	}
 	if (insert && file)
 		uprobe_mmap(insert);
@@ -1783,6 +1871,10 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end = address;
 				anon_vma_interval_tree_post_update_vma(vma);
+				if (vma->vm_next)
+					vma_gap_update(vma->vm_next);
+				else
+					mm->highest_vm_end = address;
 				perf_event_mmap(vma);
 			}
 		}
@@ -1837,6 +1929,7 @@ int expand_downwards(struct vm_area_struct *vma,
 				vma->vm_start = address;
 				vma->vm_pgoff -= grow;
 				anon_vma_interval_tree_post_update_vma(vma);
+				vma_gap_update(vma);
 				perf_event_mmap(vma);
 			}
 		}
@@ -1959,14 +2052,17 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vma,
 	insertion_point = (prev ? &prev->vm_next : &mm->mmap);
 	vma->vm_prev = NULL;
 	do {
-		rb_erase(&vma->vm_rb, &mm->mm_rb);
+		vma_rb_erase(vma, &mm->mm_rb);
 		mm->map_count--;
 		tail_vma = vma;
 		vma = vma->vm_next;
 	} while (vma && vma->vm_start < end);
 	*insertion_point = vma;
-	if (vma)
+	if (vma) {
 		vma->vm_prev = prev;
+		vma_gap_update(vma);
+	} else
+		mm->highest_vm_end = prev ? prev->vm_end : 0;
 	tail_vma->vm_next = NULL;
 	if (mm->unmap_area == arch_unmap_area)
 		addr = prev ? prev->vm_end : mm->mmap_base;
-- 
1.7.7.3
