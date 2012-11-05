Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:50:35 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:42849 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825989Ab2KEWrr30aw3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:47 +0100
Received: by mail-pb0-f49.google.com with SMTP id xa7so3934314pbc.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9d1p16UxpHgLiDgYrHm5qtZ+RMSoNXJrQ35btDVX0rw=;
        b=ofN2QjRoBMSMq4+89G+B7mlBJNDSGdX22GlOoGSaifzVOtzSBGu7mg1yqLcbnFz/e7
         RtRy1kEdrMWi8ffNUPoO4pghoUtIRYnF7Tp4YIrdVJVrK8PBNYcezR23KPIJb2Tjf0fT
         +cYKxHpI9gqXdmNXFtK4Oo29vK/SgdP6bMiboSHGvyW9WFFlQI2ebMqir5NcYRML+Tv9
         Tte1wgXWIbaxJzt7RCaU1rZVgYbol83hDR0+lk9v9L/NPJycV78onjn2suKp9CtPfIpD
         rtEv7q/xz/IyPiLFgqMF0ZiA+oz69hozxUOBH8TDpson76P7kcexYa/BeGNEn5BGSFdr
         xOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=9d1p16UxpHgLiDgYrHm5qtZ+RMSoNXJrQ35btDVX0rw=;
        b=SXOochFRKy1QBR1fvjEBaaPAgx0TNGcI22o/lu8WAaaY1H89TtdUrbFbg7CXTFEX5r
         gTHy5w+jVGIUXM2fqOtYhZXNeJdgAoRppKmDJYs6DUl1afBPTDHk4PTV/wvHZDv9mO/6
         m9uJYO47sFbW96vZdXdTBHRKttUPCyMkolDsZRKi3f2KqfWeXNH10NeVaBKuXtY3Csi/
         hswCFkQ+kHKM1iQ9Gs1Tt7tnHjFf+wZ6K8MNn88OPs5AF1OLqFe4gt5xMEpJP0cDpMc1
         gO/ElXN9m1fXoHIF9LbZjYOrsAUbfbzphSrvNLLi08Poe0OOVxVsaqCdIkBcBxcM4SgH
         UWcA==
Received: by 10.66.87.163 with SMTP id az3mr32328750pab.62.1352155666665;
        Mon, 05 Nov 2012 14:47:46 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:45 -0800 (PST)
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
Subject: [PATCH 09/16] mm: use vm_unmapped_area() in hugetlbfs on i386 architecture
Date:   Mon,  5 Nov 2012 14:47:06 -0800
Message-Id: <1352155633-8648-10-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQlh/PLJYLVw5+8YulTil7IfxT1mD1zGU5INEF3Isw4mcS7rZmQctv+x2xiaJ55wKYTs+cd13/4zzQ8oBvF3nSfhLNLr7ibuKVyiVpi5AoTMZ9ogqJSNJ3uVMbvo+hU9Iw77cOprmZ6KkXH3ZOYm/XoyI8Hn3SvKKyZB4nG9vzviiZUDi7217x/HwtOOhc9Y9zpV4FR6b5rZDUFj1T4FzQEo3t6z3g==
X-archive-position: 34879
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

Update the i386 hugetlb_get_unmapped_area function to make use of
vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>

---
 arch/x86/mm/hugetlbpage.c |  130 +++++++++------------------------------------
 1 files changed, 25 insertions(+), 105 deletions(-)

diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 937bff5cdaa7..c00c4a4cd564 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -274,42 +274,15 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	unsigned long start_addr;
-
-	if (len > mm->cached_hole_size) {
-	        start_addr = mm->free_area_cache;
-	} else {
-	        start_addr = TASK_UNMAPPED_BASE;
-	        mm->cached_hole_size = 0;
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
-		        mm->cached_hole_size = vma->vm_start - addr;
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
@@ -317,83 +290,30 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	unsigned long base = mm->mmap_base;
-	unsigned long addr = addr0;
-	unsigned long largest_hole = mm->cached_hole_size;
-	unsigned long start_addr;
-
-	/* don't allow allocations above current base */
-	if (mm->free_area_cache > base)
-		mm->free_area_cache = base;
-
-	if (len <= largest_hole) {
-	        largest_hole = 0;
-		mm->free_area_cache  = base;
-	}
-try_again:
-	start_addr = mm->free_area_cache;
-
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
-		vma = find_vma(mm, addr);
-		if (!vma)
-			return addr;
+	struct vm_unmapped_area_info info;
+	unsigned long addr;
 
-		if (addr + len <= vma->vm_start) {
-			/* remember the address as a hint for next time */
-		        mm->cached_hole_size = largest_hole;
-		        return (mm->free_area_cache = addr);
-		} else if (mm->free_area_cache == vma->vm_end) {
-			/* pull free_area_cache down to the first hole */
-			mm->free_area_cache = vma->vm_start;
-			mm->cached_hole_size = largest_hole;
-		}
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = PAGE_SIZE;
+	info.high_limit = mm->mmap_base;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	addr = vm_unmapped_area(&info);
 
-		/* remember the largest hole we saw so far */
-		if (addr + largest_hole < vma->vm_start)
-		        largest_hole = vma->vm_start - addr;
-
-		/* try just below the current vma->vm_start */
-		addr = (vma->vm_start - len) & huge_page_mask(h);
-	} while (len <= vma->vm_start);
-
-fail:
-	/*
-	 * if hint left us with no space for the requested
-	 * mapping then try again:
-	 */
-	if (start_addr != base) {
-		mm->free_area_cache = base;
-		largest_hole = 0;
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
