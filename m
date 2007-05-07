Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2007 17:01:50 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.225]:27626 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022100AbXEGQBP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 May 2007 17:01:15 +0100
Received: by wx-out-0506.google.com with SMTP id s14so831996wxc
        for <linux-mips@linux-mips.org>; Mon, 07 May 2007 09:00:07 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=C7n7RULIEQ6Fqb6zFVxjR+MZDZ3zeINkzTQn9PV6G+TFzueVsOGHqy9yED+8/yREhQpzZ3TzG9tNRIJ5E7rHlXqoW2fSBDHEoiTYI7XlNHjFySESjfsEk4CRx0rrj3e4LdftEFV+PE7ANKJeRp5vy74rs3wWnF/bOB9HzZqQo54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=AuSMYTiQGWdDpvca3RK6GOm+NoXEK8vWfb7QY+x3p38GtLjbxXC3HSAGsvjUOTad1nQYpV5kF3RygEXr4javeuLXQaVmGGQA3Df9ft7qwjAP95ZGvmUcRrht33tDWURgmsrQ0DcGmAhMEfSWspGOAHpI1bbc1DVd0Rj8eOtqAA0=
Received: by 10.90.105.19 with SMTP id d19mr5271463agc.1178553607526;
        Mon, 07 May 2007 09:00:07 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id 9sm8417174wrl.2007.05.07.09.00.02;
        Mon, 07 May 2007 09:00:06 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 8DE8023F76E; Mon,  7 May 2007 18:01:54 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, linux-mips@linux-mips.org
Subject: [PATCH 3/3] Remove LIMITED_DMA support
Date:	Mon,  7 May 2007 18:01:53 +0200
Message-Id: <11785537142626-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: <11785537132378-git-send-email-fbuihuu@gmail.com>
References: <11785537132378-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This code was needed only by Jaguar ATX.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/Kconfig          |    5 -----
 arch/mips/mm/highmem.c     |    2 --
 arch/mips/mm/init.c        |    3 ---
 include/asm-mips/highmem.h |   42 ------------------------------------------
 include/asm-mips/page.h    |    4 ----
 5 files changed, 0 insertions(+), 56 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 28caf80..77a1ef0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -885,11 +885,6 @@ config GENERIC_ISA_DMA
 config I8259
 	bool
 
-config LIMITED_DMA
-	bool
-	select HIGHMEM
-	select SYS_SUPPORTS_HIGHMEM
-
 config MIPS_BONITO64
 	bool
 
diff --git a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
index 675502a..10dd2af 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -80,7 +80,6 @@ void __kunmap_atomic(void *kvaddr, enum km_type type)
 	pagefault_enable();
 }
 
-#ifndef CONFIG_LIMITED_DMA
 /*
  * This is the same as kmap_atomic() but can map memory that doesn't
  * have a struct page associated with it.
@@ -99,7 +98,6 @@ void *kmap_atomic_pfn(unsigned long pfn, enum km_type type)
 
 	return (void*) vaddr;
 }
-#endif /* CONFIG_LIMITED_DMA */
 
 struct page *__kmap_atomic_to_page(void *ptr)
 {
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 2d1c2c0..4c80528 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -424,9 +424,6 @@ void __init mem_init(void)
 			continue;
 		}
 		ClearPageReserved(page);
-#ifdef CONFIG_LIMITED_DMA
-		set_page_address(page, lowmem_page_address(page));
-#endif
 		init_page_count(page);
 		__free_page(page);
 		totalhigh_pages++;
diff --git a/include/asm-mips/highmem.h b/include/asm-mips/highmem.h
index f8c8182..4d6bd5c 100644
--- a/include/asm-mips/highmem.h
+++ b/include/asm-mips/highmem.h
@@ -48,46 +48,6 @@ extern pte_t *pkmap_page_table;
 extern void * kmap_high(struct page *page);
 extern void kunmap_high(struct page *page);
 
-/*
- * CONFIG_LIMITED_DMA is for systems with DMA limitations such as Momentum's
- * Jaguar ATX.  This option exploits the highmem code in the kernel so is
- * always enabled together with CONFIG_HIGHMEM but at this time doesn't
- * actually add highmem functionality.
- */
-
-#ifdef CONFIG_LIMITED_DMA
-
-/*
- * These are the default functions for the no-highmem case from
- * <linux/highmem.h>
- */
-static inline void *kmap(struct page *page)
-{
-	might_sleep();
-	return page_address(page);
-}
-
-#define kunmap(page) do { (void) (page); } while (0)
-
-static inline void *kmap_atomic(struct page *page, enum km_type type)
-{
-	pagefault_disable();
-	return page_address(page);
-}
-
-static inline void kunmap_atomic(void *kvaddr, enum km_type type)
-{
-	pagefault_enable();
-}
-
-#define kmap_atomic_pfn(pfn, idx) kmap_atomic(pfn_to_page(pfn), (idx))
-
-#define kmap_atomic_to_page(ptr) virt_to_page(ptr)
-
-#define flush_cache_kmaps()	do { } while (0)
-
-#else /* LIMITED_DMA */
-
 extern void *__kmap(struct page *page);
 extern void __kunmap(struct page *page);
 extern void *__kmap_atomic(struct page *page, enum km_type type);
@@ -103,8 +63,6 @@ extern struct page *__kmap_atomic_to_page(void *ptr);
 
 #define flush_cache_kmaps()	flush_cache_all()
 
-#endif /* LIMITED_DMA */
-
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_HIGHMEM_H */
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index d3fbd83..5c3239d 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -190,10 +190,6 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
 #define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
 
-#ifdef CONFIG_LIMITED_DMA
-#define WANT_PAGE_VIRTUAL
-#endif
-
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
-- 
1.5.1.3
