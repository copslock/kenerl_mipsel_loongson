Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2011 18:46:31 +0100 (CET)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:43154 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491869Ab1CNRq1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Mar 2011 18:46:27 +0100
Received: by qyl38 with SMTP id 38so4703025qyl.15
        for <multiple recipients>; Mon, 14 Mar 2011 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=SHXpsHO9iRdOOn0Fd+FGP/x21MYrZD3UGbO8b0hSVJs=;
        b=VBD7c8YwYqSeJ5ruTWy5Whr/RCvzD7n4Ur3no1PyK8x+URm2l1qEHzNx+zuORpkpPg
         I2nkGUUAlNPaZw+ZinuWDoFLVC5b1AvFkZVyZZEgtJYZPHS7L3eyDJ1F2nwGUlEqoc5f
         L8g9wtX1J3z0rwXlsfyXZipcw3dvwkm3Iai0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ko9LwlM2OKT6tcm6jHA/64ungQxBcf0snftR6zC7N/K1iEFpyXH22MRXsRK7JBw6+j
         MR7nnpCjnE9aq9A9lzqGAgine7TPLeFxnp6KFZp8wJZj8ksBPY7WfEM/twu6GI/5z9Iz
         MjZl7tMesoX4DqxB70jLbp54W1HuasOAYa6Y8=
MIME-Version: 1.0
Received: by 10.229.76.4 with SMTP id a4mr5927509qck.55.1300124781397; Mon, 14
 Mar 2011 10:46:21 -0700 (PDT)
Received: by 10.229.99.68 with HTTP; Mon, 14 Mar 2011 10:46:21 -0700 (PDT)
Date:   Mon, 14 Mar 2011 17:46:21 +0000
Message-ID: <AANLkTin2c2wTpqBNF_ZjmeTex9m5+3h6vhH7=jD1JX0K@mail.gmail.com>
Subject: [RFC][PATCH v2 10/23] (mips) __vmalloc: add gfp flags variant of pte
 and pmd allocation
From:   Prasad Joshi <prasadjoshi124@gmail.com>
To:     Prasad Joshi <prasadjoshi124@gmail.com>,
        Anand Mitra <mitra@kqinfotech.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <prasadjoshi124@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasadjoshi124@gmail.com
Precedence: bulk
X-list: linux-mips

__vmalloc: propagating GFP allocation flag.

- adds functions to allow caller to pass the GFP flag for memory allocation
- helps in fixing the Bug 30702 (__vmalloc(GFP_NOFS) can callback
		  file system evict_inode).

Signed-off-by: Anand Mitra <mitra@kqinfotech.com>
Signed-off-by: Prasad Joshi <prasadjoshi124@gmail.com>
---
Chnagelog:
arch/mips/include/asm/pgalloc.h |   22 +++++++++++++++-------
1 files changed, 15 insertions(+), 7 deletions(-)
---
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 881d18b..f2c5439 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -64,14 +64,16 @@ static inline void pgd_free(struct mm_struct *mm,
pgd_t *pgd)
 	free_pages((unsigned long)pgd, PGD_ORDER);
 }

+static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm,
+	unsigned long address, gfp_t gfp_mask)
+{
+	return (pte_t *) __get_free_pages(gfp_mask | __GFP_ZERO, PTE_ORDER);
+}
+
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
 	unsigned long address)
 {
-	pte_t *pte;
-
-	pte = (pte_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO,
PTE_ORDER);
-
-	return pte;
+	return __pte_alloc_one_kernel(mm, address, GFP_KERNEL | __GFP_REPEAT);
 }

 static inline struct page *pte_alloc_one(struct mm_struct *mm,
@@ -106,16 +108,22 @@ do {							\

 #ifndef __PAGETABLE_PMD_FOLDED

-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
+static inline pmd_t *
+__pmd_alloc_one(struct mm_struct *mm, unsigned long address, gfp_t gfp_mask)
 {
 	pmd_t *pmd;

-	pmd = (pmd_t *) __get_free_pages(GFP_KERNEL|__GFP_REPEAT, PMD_ORDER);
+	pmd = (pmd_t *) __get_free_pages(gfp_mask, PMD_ORDER);
 	if (pmd)
 		pmd_init((unsigned long)pmd, (unsigned long)invalid_pte_table);
 	return pmd;
 }

+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	return __pmd_alloc_one(mm, address, GFP_KERNEL | __GFP_REPEAT);
+}
+
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 	free_pages((unsigned long)pmd, PMD_ORDER);
