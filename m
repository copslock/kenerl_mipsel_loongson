Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Jun 2011 20:38:18 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:57856 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491134Ab1FRSiL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 18 Jun 2011 20:38:11 +0200
Received: (qmail 27888 invoked from network); 18 Jun 2011 18:38:06 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 18 Jun 2011 18:38:06 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 18 Jun 2011 11:38:06 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jian Peng <jipeng2005@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH -queue] MIPS: Trivial style cleanups in mmap.c
Date:   Sat, 18 Jun 2011 11:28:48 -0700
Message-Id: <50c16d4ef04b5213459ba15d14e30459@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-archive-position: 30435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15274

Fix checkpatch warnings.  Rename arch_get_unmapped_area_foo() to
arch_get_unmapped_area_common().  Make indentations and spacing more
consistent.  Add <linux/compiler.h> for likely/unlikely.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/mm/mmap.c |   48 +++++++++++++++++++++++++-----------------------
 1 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 9ff5d0f..302d779 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2011 Wind River Systems,
  *   written by Ralf Baechle <ralf@linux-mips.org>
  */
+#include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
@@ -15,12 +16,11 @@
 #include <linux/sched.h>
 
 unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
-
 EXPORT_SYMBOL(shm_align_mask);
 
 /* gap between mmap and stack */
 #define MIN_GAP (128*1024*1024UL)
-#define MAX_GAP        ((TASK_SIZE)/6*5)
+#define MAX_GAP ((TASK_SIZE)/6*5)
 
 static int mmap_is_legacy(void)
 {
@@ -57,13 +57,13 @@ static inline unsigned long COLOUR_ALIGN_DOWN(unsigned long addr,
 	return base - off;
 }
 
-#define COLOUR_ALIGN(addr,pgoff)				\
+#define COLOUR_ALIGN(addr, pgoff)				\
 	((((addr) + shm_align_mask) & ~shm_align_mask) +	\
 	 (((pgoff) << PAGE_SHIFT) & shm_align_mask))
 
 enum mmap_allocation_direction {UP, DOWN};
 
-static unsigned long arch_get_unmapped_area_foo(struct file *filp,
+static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	unsigned long addr0, unsigned long len, unsigned long pgoff,
 	unsigned long flags, enum mmap_allocation_direction dir)
 {
@@ -103,16 +103,16 @@ static unsigned long arch_get_unmapped_area_foo(struct file *filp,
 
 		vma = find_vma(mm, addr);
 		if (TASK_SIZE - len >= addr &&
-		   (!vma || addr + len <= vma->vm_start))
+		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
 
 	if (dir == UP) {
 		addr = mm->mmap_base;
-			if (do_color_align)
-				addr = COLOUR_ALIGN(addr, pgoff);
-			else
-				addr = PAGE_ALIGN(addr);
+		if (do_color_align)
+			addr = COLOUR_ALIGN(addr, pgoff);
+		else
+			addr = PAGE_ALIGN(addr);
 
 		for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
 			/* At this point:  (!vma || addr < vma->vm_end). */
@@ -131,28 +131,30 @@ static unsigned long arch_get_unmapped_area_foo(struct file *filp,
 			mm->free_area_cache = mm->mmap_base;
 		}
 
-		/* either no address requested or can't fit in requested address hole */
+		/*
+		 * either no address requested, or the mapping can't fit into
+		 * the requested address hole
+		 */
 		addr = mm->free_area_cache;
-			if (do_color_align) {
-				unsigned long base =
-					COLOUR_ALIGN_DOWN(addr - len, pgoff);
-
+		if (do_color_align) {
+			unsigned long base =
+				COLOUR_ALIGN_DOWN(addr - len, pgoff);
 			addr = base + len;
-		 }
+		}
 
 		/* make sure it can fit in the remaining address space */
 		if (likely(addr > len)) {
 			vma = find_vma(mm, addr - len);
 			if (!vma || addr <= vma->vm_start) {
-				/* remember the address as a hint for next time */
-				return mm->free_area_cache = addr-len;
+				/* cache the address as a hint for next time */
+				return mm->free_area_cache = addr - len;
 			}
 		}
 
 		if (unlikely(mm->mmap_base < len))
 			goto bottomup;
 
-		addr = mm->mmap_base-len;
+		addr = mm->mmap_base - len;
 		if (do_color_align)
 			addr = COLOUR_ALIGN_DOWN(addr, pgoff);
 
@@ -163,8 +165,8 @@ static unsigned long arch_get_unmapped_area_foo(struct file *filp,
 			 * return with success:
 			 */
 			vma = find_vma(mm, addr);
-			if (likely(!vma || addr+len <= vma->vm_start)) {
-				/* remember the address as a hint for next time */
+			if (likely(!vma || addr + len <= vma->vm_start)) {
+				/* cache the address as a hint for next time */
 				return mm->free_area_cache = addr;
 			}
 
@@ -173,7 +175,7 @@ static unsigned long arch_get_unmapped_area_foo(struct file *filp,
 				mm->cached_hole_size = vma->vm_start - addr;
 
 			/* try just below the current vma->vm_start */
-			addr = vma->vm_start-len;
+			addr = vma->vm_start - len;
 			if (do_color_align)
 				addr = COLOUR_ALIGN_DOWN(addr, pgoff);
 		} while (likely(len < vma->vm_start));
@@ -201,7 +203,7 @@ bottomup:
 unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr0,
 	unsigned long len, unsigned long pgoff, unsigned long flags)
 {
-	return arch_get_unmapped_area_foo(filp,
+	return arch_get_unmapped_area_common(filp,
 			addr0, len, pgoff, flags, UP);
 }
 
@@ -213,7 +215,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 	unsigned long addr0, unsigned long len, unsigned long pgoff,
 	unsigned long flags)
 {
-	return arch_get_unmapped_area_foo(filp,
+	return arch_get_unmapped_area_common(filp,
 			addr0, len, pgoff, flags, DOWN);
 }
 
-- 
1.7.5
