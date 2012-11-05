Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:51:12 +0100 (CET)
Received: from mail-da0-f49.google.com ([209.85.210.49]:35354 "EHLO
        mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825988Ab2KEWrvZJjk0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:51 +0100
Received: by mail-da0-f49.google.com with SMTP id q27so2653752daj.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MWc6J7OqfM3miOevYSOwknDFbsAJCZ6PT1IGIKW/UV0=;
        b=o5xJXCz+TclulYKRY6QXfZzSVSNsP4WecozLL9IYsflIviGPHG2648uQ/1tN736AdA
         mtmzdhP/8+LeMY8CgOXefL0lj1DqmghDA4+MABZSpI/4HTSeF7vWrNU5pYpSCLS/BCZq
         nTJ7mPcDuylqt3SX9ppta719ac3fmuKq5d1szVA88E5BC8lhfhYk6xIgevgHZfUnxZz6
         IfPucDW+a/q+c5zWaiVIW9hprsHgiCqjUpcq6F9UJ/Ed/Q2b6N+xKkf2NFlIWbCLXu5V
         CE8nFJtGC86haiWH1DXhJsliX79RjnSsA12o2DxRPFMc2gzEL7X+lJZVoCUy1WPEi9yn
         FvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=MWc6J7OqfM3miOevYSOwknDFbsAJCZ6PT1IGIKW/UV0=;
        b=c5plRztGySaZVrftMryjuoZ50zOj05iRnL3yP16GnDk7ev4YnY3ZsyhOmePs7E1DpB
         EMKau+jb3bPPzPm0C6H1HvjMaJTKGq5NuQx4rw7GQSvLORAaFs8InovNACp3dfhdGBek
         X+qwo3vkfqyyxr+BUTPwrt2OrI0a1Ulso1qBYZesV/ZNg1lY8DzAl+R4CRAV0a25zAD+
         vPKRk+H3jHZIGppndtC+t2xIubdNVWMkdzq3cToylYgP80nub3FELSAjZDSF6DNIAJF+
         EclcidolLeox7exAWilNekMF7o0sVTji8wH3KtpeguncTLjX66tyDpJSb183pFEYeBxN
         63Pg==
Received: by 10.66.81.199 with SMTP id c7mr32516837pay.19.1352155670583;
        Mon, 05 Nov 2012 14:47:50 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:49 -0800 (PST)
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
Subject: [PATCH 11/16] mm: use vm_unmapped_area() on arm architecture
Date:   Mon,  5 Nov 2012 14:47:08 -0800
Message-Id: <1352155633-8648-12-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQkb+IncdJgQyUsdPJycCxWo1qUv1zjHeMI+/RNJ7Q5TaHa+sGmFdWxd3WAfKi4P0i3XyBOYouF2vrpXZP/ZE+np5atBscp9Bb0n3G75lYZsa8nI9Z5Ai56o9YElanVfWSvNRs4/wPQXtBntRJi6EQ9z4f5WwelbEP2jNBb+MybgWtJ79rYzv4NAU51TGBkivTbLYzlzxE5IHzy/U7OuMDrXGxLx7Q==
X-archive-position: 34881
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

Update the arm arch_get_unmapped_area[_topdown] functions to make
use of vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>

---
 arch/arm/mm/mmap.c |  119 ++++++++++------------------------------------------
 1 files changed, 23 insertions(+), 96 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index ce8cb1970d7a..267e63f58098 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -72,6 +72,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	unsigned long start_addr;
 	int do_align = 0;
 	int aliasing = cache_is_vipt_aliasing();
+	struct vm_unmapped_area_info info;
 
 	/*
 	 * We only need to do colour alignment if either the I or D
@@ -104,46 +105,14 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
-	if (len > mm->cached_hole_size) {
-	        start_addr = addr = mm->free_area_cache;
-	} else {
-	        start_addr = addr = mm->mmap_base;
-	        mm->cached_hole_size = 0;
-	}
 
-full_search:
-	if (do_align)
-		addr = COLOUR_ALIGN(addr, pgoff);
-	else
-		addr = PAGE_ALIGN(addr);
-
-	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
-		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr) {
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
-		if (do_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-	}
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = mm->mmap_base;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
+	return vm_unmapped_area(&info);
 }
 
 unsigned long
@@ -156,6 +125,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	unsigned long addr = addr0;
 	int do_align = 0;
 	int aliasing = cache_is_vipt_aliasing();
+	struct vm_unmapped_area_info info;
 
 	/*
 	 * We only need to do colour alignment if either the I or D
@@ -187,70 +157,27 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 			return addr;
 	}
 
-	/* check if free_area_cache is useful for us */
-	if (len <= mm->cached_hole_size) {
-		mm->cached_hole_size = 0;
-		mm->free_area_cache = mm->mmap_base;
-	}
-
-	/* either no address requested or can't fit in requested address hole */
-	addr = mm->free_area_cache;
-	if (do_align) {
-		unsigned long base = COLOUR_ALIGN_DOWN(addr - len, pgoff);
-		addr = base + len;
-	}
-
-	/* make sure it can fit in the remaining address space */
-	if (addr > len) {
-		vma = find_vma(mm, addr-len);
-		if (!vma || addr <= vma->vm_start)
-			/* remember the address as a hint for next time */
-			return (mm->free_area_cache = addr-len);
-	}
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = PAGE_SIZE;
+	info.high_limit = mm->mmap_base;
+	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
+	addr = vm_unmapped_area(&info);
 
-	if (mm->mmap_base < len)
-		goto bottomup;
-
-	addr = mm->mmap_base - len;
-	if (do_align)
-		addr = COLOUR_ALIGN_DOWN(addr, pgoff);
-
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
-		/* remember the largest hole we saw so far */
-		if (addr + mm->cached_hole_size < vma->vm_start)
-			mm->cached_hole_size = vma->vm_start - addr;
-
-		/* try just below the current vma->vm_start */
-		addr = vma->vm_start - len;
-		if (do_align)
-			addr = COLOUR_ALIGN_DOWN(addr, pgoff);
-	} while (len < vma->vm_start);
-
-bottomup:
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
+		info.low_limit = mm->mmap_base;
+		info.high_limit = TASK_SIZE;
+		addr = vm_unmapped_area(&info);
+	}
 
 	return addr;
 }
-- 
1.7.7.3
