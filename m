Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 13:39:18 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:23786 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038796AbWJMMjK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 13:39:10 +0100
Received: by nf-out-0910.google.com with SMTP id a25so860036nfc
        for <linux-mips@linux-mips.org>; Fri, 13 Oct 2006 05:39:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=lLOIkY0+wp5/bHTolzZ6UQUCJ4BG9GBuFKVKcYL/DR2Knr6/VQoTPBqbIRPVtNdUnHduNYzTxPdZkmYr33eC5f1t4tJ7LKrubuMzFunYxhONmhBnwYpMNI1HR1sQ5HOD2+ek3TL/vkFYkpAcSDGNyPDbXKKpCseNPs0Kp0SAZhQ=
Received: by 10.48.48.1 with SMTP id v1mr2234935nfv;
        Fri, 13 Oct 2006 05:39:09 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id o53sm891661nfa.2006.10.13.05.39.08;
        Fri, 13 Oct 2006 05:39:09 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 5C6C923F76E; Fri, 13 Oct 2006 14:39:06 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org,
	Franck Bui-Huu <fbuihuu@gmail.com>
Subject: [PATCH 1/7] page.h: remove __pa() usages.
Date:	Fri, 13 Oct 2006 14:39:00 +0200
Message-Id: <11607431461941-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <11607431461469-git-send-email-fbuihuu@gmail.com>
References: <11607431461469-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

__pa() was used by virt_to_page() and virt_addr_valid(). These
latter are used when kernel is initialised so __pa() is not
appropriate, we use virt_to_phys() instead.

Futhermore __pa() is going to take care of CKSEG0/XKPHYS
address mix for 64 bit kernels. This makes __pa() more complex
than virt_to_phys() and this extra work is not needed by
virt_to_page() and virt_addr_valid().

Eventually it consolidates virt_to_phys() prototype by making
its argument 'const'. this avoids some warnings that was due
to some virt_to_page() usages which pass const pointer.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/mm/init.c        |    8 ++++----
 include/asm-mips/io.h      |    2 +-
 include/asm-mips/page.h    |    4 ++--
 include/asm-mips/pgtable.h |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 2f346d1..4431ea0 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -90,9 +90,9 @@ unsigned long setup_zero_pages(void)
 	if (!empty_zero_page)
 		panic("Oh boy, that early out of memory?");
 
-	page = virt_to_page(empty_zero_page);
+	page = virt_to_page((void *)empty_zero_page);
 	split_page(page, order);
-	while (page < virt_to_page(empty_zero_page + (PAGE_SIZE << order))) {
+	while (page < virt_to_page((void *)(empty_zero_page + (PAGE_SIZE << order)))) {
 		SetPageReserved(page);
 		page++;
 	}
@@ -490,8 +490,8 @@ void free_init_pages(char *what, unsigne
 	unsigned long addr;
 
 	for (addr = begin; addr < end; addr += PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(addr));
-		init_page_count(virt_to_page(addr));
+		ClearPageReserved(virt_to_page((void *)addr));
+		init_page_count(virt_to_page((void *)addr));
 		memset((void *)addr, 0xcc, PAGE_SIZE);
 		free_page(addr);
 		totalram_pages++;
diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
index cfad7c8..5ff8fc2 100644
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -113,7 +113,7 @@ #endif
  *     almost all conceivable cases a device driver should not be using
  *     this function
  */
-static inline unsigned long virt_to_phys(volatile void * address)
+static inline unsigned long virt_to_phys(volatile const void *address)
 {
 	return (unsigned long)address - PAGE_OFFSET;
 }
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index 32e5625..0821eb0 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -157,8 +157,8 @@ ({									\
 
 #endif
 
-#define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
-#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
+#define virt_to_page(kaddr)	pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
+#define virt_addr_valid(kaddr)	pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
diff --git a/include/asm-mips/pgtable.h b/include/asm-mips/pgtable.h
index 1ca4d1e..f2e1325 100644
--- a/include/asm-mips/pgtable.h
+++ b/include/asm-mips/pgtable.h
@@ -67,7 +67,7 @@ extern unsigned long empty_zero_page;
 extern unsigned long zero_page_mask;
 
 #define ZERO_PAGE(vaddr) \
-	(virt_to_page(empty_zero_page + (((unsigned long)(vaddr)) & zero_page_mask)))
+	(virt_to_page((void *)(empty_zero_page + (((unsigned long)(vaddr)) & zero_page_mask))))
 
 #define __HAVE_ARCH_MOVE_PTE
 #define move_pte(pte, prot, old_addr, new_addr)				\
-- 
1.4.2.3
