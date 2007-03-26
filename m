Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 10:43:44 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:27145 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022719AbXCZJnl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 10:43:41 +0100
Received: by ug-out-1314.google.com with SMTP id 40so1712505uga
        for <linux-mips@linux-mips.org>; Mon, 26 Mar 2007 02:42:41 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        b=OpC6DL6TJZdrTCTjyj9e5XnOt7V3ig/zoS4+d1Bj69g26RYMCWRwLjr15zz6dUlU2axi1jsYU2RhxgfCgRUKyd6ZwWuXlaEwNxXtcBI8fW2jSFwDhum31UE75Sv7LChbXmmTVkgUDFxQloenSzBm15K59YRxjmCoBOkCveY/0fE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=fjtZ9gQYjSMfSaDY0owKfKH8IKq3vn9h/qNvLZsZLoTcjtGeoeI5cOpKmdWrQJeR+L9boPZopXM1YpMI/LDdI1uCDxxqL66dv7BMNiaDm+PEczv0ECzV1VTIYXoqXCAvMbHwkvMULFZ4hRHXRQsRg1S3UrUVjxHI3gP7NRXCDyE=
Received: by 10.66.216.20 with SMTP id o20mr11871987ugg.1174902160963;
        Mon, 26 Mar 2007 02:42:40 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id l33sm5871244ugc.2007.03.26.02.42.39;
        Mon, 26 Mar 2007 02:42:40 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 6CF1223F76F; Mon, 26 Mar 2007 10:42:34 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] Simplify pte_offset_map() and pte_offset_map_nested()
Date:	Mon, 26 Mar 2007 10:42:34 +0200
Message-Id: <1174898554215-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.rc1.27.g1d848
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

These 2 macros did unnecessary extra work for getting a pte from a
pmd.

With this patch the size of the kernel is slighly reduced (-1036b)

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 Ralf,

 This patch does not include any modifications for 64-bits kernel
 since I can't test them. This patch boot fine on a 32-bits platforms.

 Please consider

		Franck

 include/asm-mips/pgtable-32.h |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/asm-mips/pgtable-32.h b/include/asm-mips/pgtable-32.h
index 2fbd47e..a0e76e4 100644
--- a/include/asm-mips/pgtable-32.h
+++ b/include/asm-mips/pgtable-32.h
@@ -143,6 +143,7 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 #define __pgd_offset(address)	pgd_index(address)
 #define __pud_offset(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
 #define __pmd_offset(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
+#define __pte_offset(address)	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE-1))
 
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
@@ -153,17 +154,15 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 #define pgd_offset(mm,addr)	((mm)->pgd + pgd_index(addr))
 
 /* Find an entry in the third-level page table.. */
-#define __pte_offset(address)						\
-	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset(dir, address)					\
 	((pte_t *) pmd_page_vaddr(*(dir)) + __pte_offset(address))
 #define pte_offset_kernel(dir, address)					\
 	((pte_t *) pmd_page_vaddr(*(dir)) + __pte_offset(address))
 
 #define pte_offset_map(dir, address)                                    \
-	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
+	((pte_t *) pmd_page_vaddr(*(dir)) + __pte_offset(address))
 #define pte_offset_map_nested(dir, address)                             \
-	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset(address))
+	((pte_t *) pmd_page_vaddr(*(dir)) + __pte_offset(address))
 #define pte_unmap(pte) ((void)(pte))
 #define pte_unmap_nested(pte) ((void)(pte))
 
-- 
1.5.1.rc1.g1d848
