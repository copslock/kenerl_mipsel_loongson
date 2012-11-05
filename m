Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2012 23:50:54 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46108 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825977Ab2KEWrtthh9Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2012 23:47:49 +0100
Received: by mail-pb0-f49.google.com with SMTP id xa7so3934264pbc.36
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 14:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/7PVCT8hQvvPDZ5HFl9fZbfcTHvYH9ZQQQP+Y6+8Qx8=;
        b=FuaFqmMkSytt67V0CDdJNfirnExeWp5BLjr4AS017CP74cRdBB9rRR3oUwr7r/9P/Z
         iItdPrf+ESKJcSI+k1G5NMnYR6UREb8jq1kNdAasbV4TIW3aNsNaN18PUiqOdBiSD1aL
         UGMpKGViBtHFyOh5ODQhfnd8AQmcOvI7cEsNF9zZgjdCyl1OixRlR5KmfhRAk9++KJsO
         D+Cc9MsDU0y40LHp36A9ApDQS/MQ4PaEjEJrYh4kZkwAejTzE4QzXiZJhtSXDxRVr3+b
         DcLhcq1ihunu4hwMB6BQW3fsPJsWh4NlKwc42HOC5t0DsfKNYMq+mwl3Be0PcwvkRWI+
         FFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=/7PVCT8hQvvPDZ5HFl9fZbfcTHvYH9ZQQQP+Y6+8Qx8=;
        b=P+uP+iksGSygMk5fKrWLLnOTHw1CYA7u19clwFhmxcGHPj18pFEkSjZE+IfiTKM0bS
         0aVrzs2Hhe9Y77ABtx6dvYV0xNRq/Muzngw00OaILnVMRJbKcDp5BB6ikB5KaB3NK1A9
         zq9ud8gGHLljHcw3DE55OC3Wik3JS7E0f1Sf2qrNmZoG/UP7J7V344PRDTe2muipuZLb
         MFrd/bJja2VRDwvvHlJQ5L0yQyPnkymXoUOBnNfZm99tGkb9z4EV3PZd2PARVUcqMohQ
         zgt7BYJj8A36VOJT/UopOSTZe4C1aE33YFA/lm7KEZmUrKmbOEguvaxsqC8JMDQUey2h
         fcrQ==
Received: by 10.66.89.98 with SMTP id bn2mr32261865pab.72.1352155668992;
        Mon, 05 Nov 2012 14:47:48 -0800 (PST)
Received: from studio.mtv.corp.google.com (studio.mtv.corp.google.com [172.17.131.106])
        by mx.google.com with ESMTPS id jx4sm11201653pbc.27.2012.11.05.14.47.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 14:47:47 -0800 (PST)
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
Subject: [PATCH 10/16] mm: use vm_unmapped_area() on mips architecture
Date:   Mon,  5 Nov 2012 14:47:07 -0800
Message-Id: <1352155633-8648-11-git-send-email-walken@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
X-Gm-Message-State: ALoCoQmzy7nEWv+OD8dJSYnx9VZDWlBTZM5fSDVxTo9mrujbMAD6fEFBlbCdy42KGzGGhirF1krKoBtJdbk5lQkHqBg6DtCkcJ9dgeQjqrIDpTVjXe3ZS/lsY+kUBU/GF6KBllSofWBtM5PNvy4INkit5gFEf6ODz+z2FiVOIJfgTnAxFhVVG9NFmHdg/JAdwDXaT5af0VWTwWPx4vuliT8rR2q5HxG+3w==
X-archive-position: 34880
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

Update the mips arch_get_unmapped_area[_topdown] functions to make
use of vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>

---
 arch/mips/mm/mmap.c |   99 +++++++++------------------------------------------
 1 files changed, 17 insertions(+), 82 deletions(-)

diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 302d779d5b0d..e4b54b233e17 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -71,6 +71,7 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	struct vm_area_struct *vma;
 	unsigned long addr = addr0;
 	int do_color_align;
+	struct vm_unmapped_area_info info;
 
 	if (unlikely(len > TASK_SIZE))
 		return -ENOMEM;
@@ -107,97 +108,31 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 			return addr;
 	}
 
-	if (dir == UP) {
-		addr = mm->mmap_base;
-		if (do_color_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-		else
-			addr = PAGE_ALIGN(addr);
+	info.length = len;
+	info.align_mask = do_color_align ? (PAGE_MASK & shm_align_mask) : 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
 
-		for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
-			/* At this point:  (!vma || addr < vma->vm_end). */
-			if (TASK_SIZE - len < addr)
-				return -ENOMEM;
-			if (!vma || addr + len <= vma->vm_start)
-				return addr;
-			addr = vma->vm_end;
-			if (do_color_align)
-				addr = COLOUR_ALIGN(addr, pgoff);
-		 }
-	 } else {
-		/* check if free_area_cache is useful for us */
-		if (len <= mm->cached_hole_size) {
-			mm->cached_hole_size = 0;
-			mm->free_area_cache = mm->mmap_base;
-		}
+	if (dir == DOWN) {
+		info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+		info.low_limit = PAGE_SIZE;
+		info.high_limit = mm->mmap_base;
+		addr = vm_unmapped_area(&info);
+
+		if (!(addr & ~PAGE_MASK))
+			return addr;
 
-		/*
-		 * either no address requested, or the mapping can't fit into
-		 * the requested address hole
-		 */
-		addr = mm->free_area_cache;
-		if (do_color_align) {
-			unsigned long base =
-				COLOUR_ALIGN_DOWN(addr - len, pgoff);
-			addr = base + len;
-		}
-
-		/* make sure it can fit in the remaining address space */
-		if (likely(addr > len)) {
-			vma = find_vma(mm, addr - len);
-			if (!vma || addr <= vma->vm_start) {
-				/* cache the address as a hint for next time */
-				return mm->free_area_cache = addr - len;
-			}
-		}
-
-		if (unlikely(mm->mmap_base < len))
-			goto bottomup;
-
-		addr = mm->mmap_base - len;
-		if (do_color_align)
-			addr = COLOUR_ALIGN_DOWN(addr, pgoff);
-
-		do {
-			/*
-			 * Lookup failure means no vma is above this address,
-			 * else if new region fits below vma->vm_start,
-			 * return with success:
-			 */
-			vma = find_vma(mm, addr);
-			if (likely(!vma || addr + len <= vma->vm_start)) {
-				/* cache the address as a hint for next time */
-				return mm->free_area_cache = addr;
-			}
-
-			/* remember the largest hole we saw so far */
-			if (addr + mm->cached_hole_size < vma->vm_start)
-				mm->cached_hole_size = vma->vm_start - addr;
-
-			/* try just below the current vma->vm_start */
-			addr = vma->vm_start - len;
-			if (do_color_align)
-				addr = COLOUR_ALIGN_DOWN(addr, pgoff);
-		} while (likely(len < vma->vm_start));
-
-bottomup:
 		/*
 		 * A failed mmap() very likely causes application failure,
 		 * so fall back to the bottom-up function here. This scenario
 		 * can happen with large stack limits and large mmap()
 		 * allocations.
 		 */
-		mm->cached_hole_size = ~0UL;
-		mm->free_area_cache = TASK_UNMAPPED_BASE;
-		addr = arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
-		/*
-		 * Restore the topdown base:
-		 */
-		mm->free_area_cache = mm->mmap_base;
-		mm->cached_hole_size = ~0UL;
-
-		return addr;
 	}
+
+	info.flags = 0;
+	info.low_limit = mm->mmap_base;
+	info.high_limit = TASK_SIZE;
+	return vm_unmapped_area(&info);
 }
 
 unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr0,
-- 
1.7.7.3
