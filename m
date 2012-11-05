Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:52:10 +0100 (CET)
Received: from mail-da0-f49.google.com ([209.85.210.49]:35354 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825978Ab2KEWr4ZVOMJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:56 +0100
Received: by mail-da0-f49.google.com with SMTP id q27so2653752daj.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TYTK1BiBxj894RRVsaiUGPodY3/JxFBkeQ7voLG1cIY=;
        b=G0B3QbC3azhj0lXPEXeM2Zle0as/uYqB6oIpN5Mz5XyGYjYgQYggwqvm+BkGyGKMT1
         BAOim4TyE4CYZ8ZwEbvEyTTqwPwhGjcCxkwUUlNgoO+MeJBltlPvHHhnlAQaqArA2CuB
         zzuBHd6uME+SrKeBlUC2DA/d6Xm6QMwxiUHEmC7ALVAMrL7DldrUUKjUROZnCsUeZamY
         aK/hf9pjBbXjp6GuW1IpDeR2cRuBGfbZVX4fDBup9lLjOAUbkSDWrxcxD2VcXHA0t1n9
         gCnQv/DZmZZ6vcx31jaWHTInmaQAbYYAaRUrRCm7B48PVQSDEzl1j8oShP3geBCdxQmK
         PoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=TYTK1BiBxj894RRVsaiUGPodY3/JxFBkeQ7voLG1cIY=;
        b=lvo65T9fneSMPoaVZgIOgzi49xC2b+JhXU5zqt9StYKF8HnWZySpVjYJWeHvR5ynxl
         4TvkFBW8EdAYzwy3gowe2rCIfd9rJtdrBDgOc/Hq96rZGO81Inj5EScvwNrhjWrH/Ew8
         8RQEjkKUUbgZtG0sJ8lKHfpktIyyr0/PjSJ8x95S65BrvEUlkrfva5oPmva9vJxsQJNA
         b+x24qstM+/BeDDEpe6itwOneccWhujUNfq/UiBNZDMY766TedX9ckYx8YldliTFl6sv
         6jWqdB9U/Zq3JW5Vrj2zDmvEIL2EG1fE9aMKrgbiIryagjgXc/KC1VTGcIMyOm3NLW6H
         bamA==
Received: by 10.66.73.34 with SMTP id i2mr32481677pav.28.1352155675601;
        Mon, 05 Nov 2012 14:47:55 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:54 -0800 (PST)
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
Subject: [PATCH 14/16] mm: use vm_unmapped_area() in hugetlbfs on sparc64 architecture
Date:   Mon,  5 Nov 2012 14:47:11 -0800
Message-Id: <1352155633-8648-15-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQnIC80CbHEZF4OEWzSP6l8Lx1EpNhQfIBu9eBHyxVQV3aw5D6Vt5XaCCQnCX9osqsW0WaOmGdkZPBx9gT+LVSWe2Tfu4tMO+1a3Fm3kBfgygCAg6Jd9BRz9lTMoYhA1+g0gSZBlJv5GsxXCi/N2SYi216fQGJmQsFuKzRlkqJBXtoLLXHpHTVAkPYkLMIQQN/uWQYJiZRwHuTvMOgiwh7IUoF631g==
X-archive-position: 34884
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

Update the sparc64 hugetlb_get_unmapped_area function to make use of
vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>

---
 arch/sparc/mm/hugetlbpage.c |  123 ++++++++++--------------------------------
 1 files changed, 30 insertions(+), 93 deletions(-)

diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index f76f83d5ac63..42e5dba6cb26 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -30,55 +30,28 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *filp,
 							unsigned long pgoff,
 							unsigned long flags)
 {
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct * vma;
 	unsigned long task_size = TASK_SIZE;
-	unsigned long start_addr;
+	struct vm_unmapped_area_info info;
 
 	if (test_thread_flag(TIF_32BIT))
 		task_size = STACK_TOP32;
-	if (unlikely(len >= VA_EXCLUDE_START))
-		return -ENOMEM;
 
-	if (len > mm->cached_hole_size) {
-	        start_addr = addr = mm->free_area_cache;
-	} else {
-	        start_addr = addr = TASK_UNMAPPED_BASE;
-	        mm->cached_hole_size = 0;
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = TASK_UNMAPPED_BASE;
+	info.high_limit = min(task_size, VA_EXCLUDE_START);
+	info.align_mask = PAGE_MASK & ~HPAGE_MASK;
+	info.align_offset = 0;
+	addr = vm_unmapped_area(&info);
+
+	if ((addr & ~PAGE_MASK) && task_size > VA_EXCLUDE_END) {
+		VM_BUG_ON(addr != -ENOMEM);
+		info.low_limit = VA_EXCLUDE_END;
+		info.high_limit = task_size;
+		addr = vm_unmapped_area(&info);
 	}
 
-	task_size -= len;
-
-full_search:
-	addr = ALIGN(addr, HPAGE_SIZE);
-
-	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
-		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (addr < VA_EXCLUDE_START &&
-		    (addr + len) >= VA_EXCLUDE_START) {
-			addr = VA_EXCLUDE_END;
-			vma = find_vma(mm, VA_EXCLUDE_END);
-		}
-		if (unlikely(task_size < addr)) {
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
-		addr = ALIGN(vma->vm_end, HPAGE_SIZE);
-	}
+	return addr;
 }
 
 static unsigned long
@@ -90,68 +63,32 @@ hugetlb_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
+	struct vm_unmapped_area_info info;
 
 	/* This should only ever run for 32-bit processes.  */
 	BUG_ON(!test_thread_flag(TIF_32BIT));
 
-	/* check if free_area_cache is useful for us */
-	if (len <= mm->cached_hole_size) {
- 	        mm->cached_hole_size = 0;
- 		mm->free_area_cache = mm->mmap_base;
- 	}
-
-	/* either no address requested or can't fit in requested address hole */
-	addr = mm->free_area_cache & HPAGE_MASK;
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
-	addr = (mm->mmap_base-len) & HPAGE_MASK;
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
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = PAGE_SIZE;
+	info.high_limit = mm->mmap_base;
+	info.align_mask = PAGE_MASK & ~HPAGE_MASK;
+	info.align_offset = 0;
+	addr = vm_unmapped_area(&info);
 
- 		/* remember the largest hole we saw so far */
- 		if (addr + mm->cached_hole_size < vma->vm_start)
- 		        mm->cached_hole_size = vma->vm_start - addr;
-
-		/* try just below the current vma->vm_start */
-		addr = (vma->vm_start-len) & HPAGE_MASK;
-	} while (likely(len < vma->vm_start));
-
-bottomup:
 	/*
 	 * A failed mmap() very likely causes application failure,
 	 * so fall back to the bottom-up function here. This scenario
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
+		info.high_limit = STACK_TOP32;
+		addr = vm_unmapped_area(&info);
+	}
 
 	return addr;
 }
-- 
1.7.7.3
