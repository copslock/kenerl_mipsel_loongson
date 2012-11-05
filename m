Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:49:00 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46108 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825975Ab2KEWrmejz23 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:42 +0100
Received: by mail-pb0-f49.google.com with SMTP id xa7so3934264pbc.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3EGk4Cd57Te/bpYS5ZOgSitK7/4VoSpjOSpmlAEUQRs=;
        b=l9YXF8yyvmfBCsXDdRDsKcACBf9+4ymwO9DWcWP3KZDCW6qKbeW3tfDRLcp1RKYSsY
         ceQxL3c8eJcMsr41vZ6nuv7sWBs4TV4QpqIMAU8rwoyqO9n39I7StDKjo/AYPl6y46Jr
         dzSK/yQxK3dUXRQvfk+cJYwg9da4mn7IooLOZR/4nBTbE90r8zoalSUKt60JFzKGtomu
         lVZ2HMUSQ+SEYIDyBJkdaciTynW16+KifCG1Mp9wtL3Z1Vx1Foy05ssNnvfog8CWEq/k
         +Cc+0yODriIf/UEJ5hQJAFWah3Ahi1ngJhM/8YQlF/HF14PcBcsL21gGKjCxG4IahkHp
         z68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=3EGk4Cd57Te/bpYS5ZOgSitK7/4VoSpjOSpmlAEUQRs=;
        b=FjMEykAGNRQxAK03DyXayvHcqkumQVWvgSLc/8YijbdkoDACjxnnlgcXWrG7zg5LFJ
         /xkIku4qk9K3f1jTHUVy6QXSwB4iKXNiTXq5dcnZIDlgLUmsRk1dXsydI9Qp0QHS7dZ3
         p6i7kW7jBS2IxgH2aFEPuPIWFEKN3SwmA0f1EbSP3j7gQ90CqyZBJzILcOj7kLdZbzSa
         OS3CCDF1htBCFTv+p64u827wW8uSmbSOoBvkI/spSZ7ldbZoL1iUNySgJUTw88VsZB0P
         Tlt5SIkyfnBHdlJpPEuy0rrTvqExrg9oUFubcp8DNO0qrVBWva2LnDeulCpRc5n5FmBN
         kQLw==
Received: by 10.68.243.70 with SMTP id ww6mr32062326pbc.108.1352155661741;
        Mon, 05 Nov 2012 14:47:41 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:40 -0800 (PST)
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
Subject: [PATCH 06/16] mm: use vm_unmapped_area() on x86_64 architecture
Date:   Mon,  5 Nov 2012 14:47:03 -0800
Message-Id: <1352155633-8648-7-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQmNgguWfEg+msXBJdIg6zjga9UStKKyThtuagotnn7iRuQ43NFUU3NMulo61qUZltieFypYdNwB1guAsyN2stnLAxCvo76It6ATwLRkhsC4XtiIzkmef94AX6QWLNhVSytO8UyNtVlOR8gy85c9yPYUVO8CpGGtzF2GPXBCfh8UM2YoLpSAi8ZCi5Aq17P3YhfTVbsoApVdSJ8PewHRtQPscfkOmA==
X-archive-position: 34874
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

Update the x86_64 arch_get_unmapped_area[_topdown] functions to make
use of vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>
Reviewed-by: Rik van Riel <riel@redhat.com>

---
 arch/x86/include/asm/elf.h   |    6 +-
 arch/x86/kernel/sys_x86_64.c |  151 ++++++++---------------------------------
 arch/x86/vdso/vma.c          |    2 +-
 3 files changed, 33 insertions(+), 126 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 5939f44fe0c0..9c999c1674fa 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -354,12 +354,10 @@ static inline int mmap_is_ia32(void)
 	return 0;
 }
 
-/* The first two values are special, do not change. See align_addr() */
+/* Do not change the values. See get_align_mask() */
 enum align_flags {
 	ALIGN_VA_32	= BIT(0),
 	ALIGN_VA_64	= BIT(1),
-	ALIGN_VDSO	= BIT(2),
-	ALIGN_TOPDOWN	= BIT(3),
 };
 
 struct va_alignment {
@@ -368,5 +366,5 @@ struct va_alignment {
 } ____cacheline_aligned;
 
 extern struct va_alignment va_align;
-extern unsigned long align_addr(unsigned long, struct file *, enum align_flags);
+extern unsigned long align_vdso_addr(unsigned long);
 #endif /* _ASM_X86_ELF_H */
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index b4d3c3927dd8..f00d006d60fd 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -21,37 +21,23 @@
 
 /*
  * Align a virtual address to avoid aliasing in the I$ on AMD F15h.
- *
- * @flags denotes the allocation direction - bottomup or topdown -
- * or vDSO; see call sites below.
  */
-unsigned long align_addr(unsigned long addr, struct file *filp,
-			 enum align_flags flags)
+static unsigned long get_align_mask(void)
 {
-	unsigned long tmp_addr;
-
 	/* handle 32- and 64-bit case with a single conditional */
 	if (va_align.flags < 0 || !(va_align.flags & (2 - mmap_is_ia32())))
-		return addr;
+		return 0;
 
 	if (!(current->flags & PF_RANDOMIZE))
-		return addr;
-
-	if (!((flags & ALIGN_VDSO) || filp))
-		return addr;
-
-	tmp_addr = addr;
-
-	/*
-	 * We need an address which is <= than the original
-	 * one only when in topdown direction.
-	 */
-	if (!(flags & ALIGN_TOPDOWN))
-		tmp_addr += va_align.mask;
+		return 0;
 
-	tmp_addr &= ~va_align.mask;
+	return va_align.mask;
+}
 
-	return tmp_addr;
+unsigned long align_vdso_addr(unsigned long addr)
+{
+	unsigned long align_mask = get_align_mask();
+	return (addr + align_mask) & ~align_mask;
 }
 
 static int __init control_va_addr_alignment(char *str)
@@ -126,7 +112,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long start_addr;
+	struct vm_unmapped_area_info info;
 	unsigned long begin, end;
 
 	if (flags & MAP_FIXED)
@@ -144,50 +130,16 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
-	if (((flags & MAP_32BIT) || test_thread_flag(TIF_ADDR32))
-	    && len <= mm->cached_hole_size) {
-		mm->cached_hole_size = 0;
-		mm->free_area_cache = begin;
-	}
-	addr = mm->free_area_cache;
-	if (addr < begin)
-		addr = begin;
-	start_addr = addr;
-
-full_search:
-
-	addr = align_addr(addr, filp, 0);
-
-	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
-		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (end - len < addr) {
-			/*
-			 * Start a new search - just in case we missed
-			 * some holes.
-			 */
-			if (start_addr != begin) {
-				start_addr = addr = begin;
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
-			mm->cached_hole_size = vma->vm_start - addr;
 
-		addr = vma->vm_end;
-		addr = align_addr(addr, filp, 0);
-	}
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = begin;
+	info.high_limit = end;
+	info.align_mask = filp ? get_align_mask() : 0;
+	info.align_offset = 0;
+	return vm_unmapped_area(&info);
 }
 
-
 unsigned long
 arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 			  const unsigned long len, const unsigned long pgoff,
@@ -195,7 +147,8 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
-	unsigned long addr = addr0, start_addr;
+	unsigned long addr = addr0;
+	struct vm_unmapped_area_info info;
 
 	/* requested length too big for entire address space */
 	if (len > TASK_SIZE)
@@ -217,51 +170,16 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 			return addr;
 	}
 
-	/* check if free_area_cache is useful for us */
-	if (len <= mm->cached_hole_size) {
-		mm->cached_hole_size = 0;
-		mm->free_area_cache = mm->mmap_base;
-	}
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
-		addr = align_addr(addr, filp, ALIGN_TOPDOWN);
-
-		/*
-		 * Lookup failure means no vma is above this address,
-		 * else if new region fits below vma->vm_start,
-		 * return with success:
-		 */
-		vma = find_vma(mm, addr);
-		if (!vma || addr+len <= vma->vm_start)
-			/* remember the address as a hint for next time */
-			return mm->free_area_cache = addr;
-
-		/* remember the largest hole we saw so far */
-		if (addr + mm->cached_hole_size < vma->vm_start)
-			mm->cached_hole_size = vma->vm_start - addr;
-
-		/* try just below the current vma->vm_start */
-		addr = vma->vm_start-len;
-	} while (len < vma->vm_start);
-
-fail:
-	/*
-	 * if hint left us with no space for the requested
-	 * mapping then try again:
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
+	info.align_mask = filp ? get_align_mask() : 0;
+	info.align_offset = 0;
+	addr = vm_unmapped_area(&info);
+	if (!(addr & ~PAGE_MASK))
+		return addr;
+	VM_BUG_ON(addr != -ENOMEM);
 
 bottomup:
 	/*
@@ -270,14 +188,5 @@ bottomup:
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
-
-	return addr;
+	return arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
 }
diff --git a/arch/x86/vdso/vma.c b/arch/x86/vdso/vma.c
index 00aaf047b39f..431e87544411 100644
--- a/arch/x86/vdso/vma.c
+++ b/arch/x86/vdso/vma.c
@@ -141,7 +141,7 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
 	 * unaligned here as a result of stack start randomization.
 	 */
 	addr = PAGE_ALIGN(addr);
-	addr = align_addr(addr, NULL, ALIGN_VDSO);
+	addr = align_vdso_addr(addr);
 
 	return addr;
 }
-- 
1.7.7.3
