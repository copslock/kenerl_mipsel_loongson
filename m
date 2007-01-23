Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 14:23:37 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:38813 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573782AbXAWOXf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 14:23:35 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0NENZrq018623
	for <linux-mips@linux-mips.org>; Tue, 23 Jan 2007 14:23:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0NENZaU018622
	for linux-mips@linux-mips.org; Tue, 23 Jan 2007 14:23:35 GMT
Date:	Tue, 23 Jan 2007 14:23:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Fwdu: [patch] mm: mremap correct rmap accounting
Message-ID: <20070123142335.GB18083@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

----- Forwarded message from Nick Piggin <nickpiggin@yahoo.com.au> -----

From:	Nick Piggin <nickpiggin@yahoo.com.au>
Date:	Wed, 24 Jan 2007 01:19:19 +1100
To:	Linux Memory Management <linux-mm@kvack.org>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: [patch] mm: mremap correct rmap accounting
Content-Type: multipart/mixed;
 boundary="------------010108040409060501050009"

Just spotted this possible issue when searching for another bug. Am I right
in my thinking? I haven't dug out my x86-multi-ZERO_PAGE-patch to verify
(or actually test the patch :P).

Comments?

Nick

-- 
SUSE Labs, Novell Inc.


When mremap()ing virtual addresses, some architectures (read: MIPS) switches
underlying pages if encountering ZERO_PAGE(old_vaddr) != ZERO_PAGE(new_vaddr).

The problem is that the refcount and mapcount remain on the old page, while
the actual pte is switched to the new one. This would counter underruns and
confuse the rmap code.

Fix it by actually moving accounting info to the new page. Would it be neater
to do this in move_pte? maybe rmap.c? (nick mumbles something about not
accounting ZERO_PAGE()s)

Signed-off-by: Nick Piggin <npiggin@suse.de>


Index: linux-2.6/mm/mremap.c
===================================================================
--- linux-2.6.orig/mm/mremap.c	2007-01-24 01:00:53.000000000 +1100
+++ linux-2.6/mm/mremap.c	2007-01-24 01:01:16.000000000 +1100
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/rmap.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -72,7 +73,7 @@ static void move_ptes(struct vm_area_str
 {
 	struct address_space *mapping = NULL;
 	struct mm_struct *mm = vma->vm_mm;
-	pte_t *old_pte, *new_pte, pte;
+	pte_t *old_pte, *new_pte;
 	spinlock_t *old_ptl, *new_ptl;
 
 	if (vma->vm_file) {
@@ -102,12 +103,28 @@ static void move_ptes(struct vm_area_str
 
 	for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
 				   new_pte++, new_addr += PAGE_SIZE) {
+		pte_t new, old;
+
 		if (pte_none(*old_pte))
 			continue;
-		pte = ptep_clear_flush(vma, old_addr, old_pte);
+		old = ptep_clear_flush(vma, old_addr, old_pte);
 		/* ZERO_PAGE can be dependant on virtual addr */
-		pte = move_pte(pte, new_vma->vm_page_prot, old_addr, new_addr);
-		set_pte_at(mm, new_addr, new_pte, pte);
+		new = move_pte(old, new_vma->vm_page_prot, old_addr, new_addr);
+		if (unlikely(pte_pfn(old) != pte_pfn(new))) {
+			struct page *page;
+			/* must be different ZERO_PAGE()es. Update accounting */
+
+			page = vm_normal_page(vma, old_addr, old);
+			BUG_ON(page != ZERO_PAGE(old_addr));
+			put_page(page);
+			page_remove_rmap(page, vma);
+
+			page = vm_normal_page(new_vma, new_addr, new);
+			BUG_ON(page != ZERO_PAGE(new_addr));
+			get_page(page);
+			page_add_file_rmap(page);
+		}
+		set_pte_at(mm, new_addr, new_pte, new);
 	}
 
 	arch_leave_lazy_mmu_mode();


----- End forwarded message -----
