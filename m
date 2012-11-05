Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:51:51 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:58458 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825984Ab2KEWryy9FDI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:54 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi5so3945696pad.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TXWcsxmvWNKKo4G7onSquXN7SAJIfpqpWsvD69R3aXA=;
        b=jpw9kmFzf8URdBFvpqrDKO4g0DCIjeDI+lf31oWZrmJkTZigBYYCgxeag85q7T67EM
         wbI7Z9uFVdEy/Q3ZiXavXH1hLsZM9edXmBpI/LQX/zrBBwHc3rwVID7Dp9aUgy6JuAU7
         YdrXjaG6uqy249OzER5b6qeKGpDs//817zNsnw1FrymiK5HkNxAjlJYnoGKLMNvTx7zp
         i5nv3zI5A8E1negiEzCPzVzLi2URjnzTG6fhyZknRvO5LGLXEptoMdJiM35yA4yWpbu4
         TtS/WiJvI4aipRMgUDkqqxO9Fn0oSgi34Wr1DJN9YunjsCdSpc/2FEwiPP+x43AYIPTx
         ypTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=TXWcsxmvWNKKo4G7onSquXN7SAJIfpqpWsvD69R3aXA=;
        b=NQoDHwYv9cHZ3vA4UR4Am51oSAFzLnjuBfqfHN47uickZV97HA6qKfUun5f8Ry4SI7
         TCXaNNpcwMSopdomw9c05nKWbn7DaB3Ir+x58ArX7stWI15fxFknrtH6bqrPeiLjVrix
         4SGkU4Ik4Ry67gFzawkr22BNWVncqPskP9mukk/oFvVog9meZnx0fe/DubJDKcyO1Yek
         R3sbmotGokRl9WpLC5uVcTU6jV9UOaIVar6kGHWhV3Dkm55CDRZBs5hNms62GPFWXF1l
         eRt8sp81lehVvUn2VPesqosgrZ9L4Eip20aIJZRYhgT8PQU/yysd0rfsw3corIbykFRw
         t1lw==
Received: by 10.66.73.227 with SMTP id o3mr22434840pav.78.1352155674079;
        Mon, 05 Nov 2012 14:47:54 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:52 -0800 (PST)
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
Subject: [PATCH 13/16] mm: use vm_unmapped_area() on sparc64 architecture
Date:   Mon,  5 Nov 2012 14:47:10 -0800
Message-Id: <1352155633-8648-14-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQkYb6q4OY1lQ6AQZjBk6MJlH6rN0RrY/gM6S70c/7nWgdvMHClLuPuncOAjbRbeYs7rtf8aB/p/Q71RLrosEiuc/r9/ud2IPcGT7rZKrToxmxXcApaM2jHdXQuNEwX9SgQUdOEPSQSgh5/24O+kGNXXTgpB4JMyXcVLP3BofPIUHIZXaaIr2/E71jUJ4qtU8558cHahGrrfWBU7bwQx9NNCMGxXJg==
X-archive-position: 34883
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

Update the sparc64 arch_get_unmapped_area[_topdown] functions to make
use of vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>

---
 arch/sparc/kernel/sys_sparc_64.c |  132 +++++++++-----------------------------
 1 files changed, 30 insertions(+), 102 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 11c6c9603e71..2999253ff38a 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -102,6 +102,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	unsigned long task_size = TASK_SIZE;
 	unsigned long start_addr;
 	int do_color_align;
+	struct vm_unmapped_area_info info;
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -134,50 +135,22 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 			return addr;
 	}
 
-	if (len > mm->cached_hole_size) {
-	        start_addr = addr = mm->free_area_cache;
-	} else {
-	        start_addr = addr = TASK_UNMAPPED_BASE;
-	        mm->cached_hole_size = 0;
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = TASK_UNMAPPED_BASE;
+	info.high_limit = min(task_size, VA_EXCLUDE_START);
+	info.align_mask = do_color_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
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
-	if (do_color_align)
-		addr = COLOUR_ALIGN(addr, pgoff);
-	else
-		addr = PAGE_ALIGN(addr);
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
-		addr = vma->vm_end;
-		if (do_color_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-	}
+	return addr;
 }
 
 unsigned long
@@ -190,6 +163,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	unsigned long task_size = STACK_TOP32;
 	unsigned long addr = addr0;
 	int do_color_align;
+	struct vm_unmapped_area_info info;
 
 	/* This should only ever run for 32-bit processes.  */
 	BUG_ON(!test_thread_flag(TIF_32BIT));
@@ -224,73 +198,27 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 			return addr;
 	}
 
-	/* check if free_area_cache is useful for us */
-	if (len <= mm->cached_hole_size) {
- 	        mm->cached_hole_size = 0;
- 		mm->free_area_cache = mm->mmap_base;
- 	}
-
-	/* either no address requested or can't fit in requested address hole */
-	addr = mm->free_area_cache;
-	if (do_color_align) {
-		unsigned long base = COLOUR_ALIGN_DOWN(addr-len, pgoff);
-
-		addr = base + len;
-	}
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = PAGE_SIZE;
+	info.high_limit = mm->mmap_base;
+	info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
+	addr = vm_unmapped_area(&info);
 
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
-	if (do_color_align)
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
- 		/* remember the largest hole we saw so far */
- 		if (addr + mm->cached_hole_size < vma->vm_start)
- 		        mm->cached_hole_size = vma->vm_start - addr;
-
-		/* try just below the current vma->vm_start */
-		addr = vma->vm_start-len;
-		if (do_color_align)
-			addr = COLOUR_ALIGN_DOWN(addr, pgoff);
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
