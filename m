Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 18:54:14 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:36417 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903561Ab2EKQyH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 18:54:07 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SSt6O-0003DT-8Q; Fri, 11 May 2012 11:54:00 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>,
        Leonid Yegoshin <yegoshin@mips.com>
Subject: [PATCH v3] Revert fixrange_init() limiting to the FIXMAP region.
Date:   Fri, 11 May 2012 11:53:51 -0500
Message-Id: <1336755231-5678-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

This patch refactors 464fd83e841a16f4ea1325b33eb08170ef5cd1f4 and
correctly calculates the right length while taking into account
page table alignment by PMD.

Signed-off-by: Leonid Yegoshin <yegoshin@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/mm/init.c       |    6 +++---
 arch/mips/mm/pgtable-32.c |    8 ++++++--
 arch/mips/mm/pgtable-64.c |    2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 1a85ba9..75f2724 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -277,11 +277,11 @@ void __init fixrange_init(unsigned long start, unsigned long end,
 	k = __pmd_offset(vaddr);
 	pgd = pgd_base + i;
 
-	for ( ; (i < PTRS_PER_PGD) && (vaddr < end); pgd++, i++) {
+	for ( ; (i < PTRS_PER_PGD) && (vaddr != end); pgd++, i++) {
 		pud = (pud_t *)pgd;
-		for ( ; (j < PTRS_PER_PUD) && (vaddr < end); pud++, j++) {
+		for ( ; (j < PTRS_PER_PUD) && (vaddr != end); pud++, j++) {
 			pmd = (pmd_t *)pud;
-			for (; (k < PTRS_PER_PMD) && (vaddr < end); pmd++, k++) {
+			for (; (k < PTRS_PER_PMD) && (vaddr != end); pmd++, k++) {
 				if (pmd_none(*pmd)) {
 					pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
 					set_pmd(pmd, __pmd((unsigned long)pte));
diff --git a/arch/mips/mm/pgtable-32.c b/arch/mips/mm/pgtable-32.c
index adc6911..5d27baf 100644
--- a/arch/mips/mm/pgtable-32.c
+++ b/arch/mips/mm/pgtable-32.c
@@ -33,6 +33,7 @@ void pgd_init(unsigned long page)
 void __init pagetable_init(void)
 {
 	unsigned long vaddr;
+	unsigned long vend;
 	pgd_t *pgd_base;
 #ifdef CONFIG_HIGHMEM
 	pgd_t *pgd;
@@ -51,8 +52,11 @@ void __init pagetable_init(void)
 	/*
 	 * Fixed mappings:
 	 */
-	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, vaddr + FIXADDR_SIZE, pgd_base);
+	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1);
+	/* Calculate real end before alignment. */
+	vend = vaddr + FIXADDR_SIZE;
+	vaddr = vaddr & PMD_MASK;
+	fixrange_init(vaddr, vend, pgd_base);
 
 #ifdef CONFIG_HIGHMEM
 	/*
diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index cda4e30..78eaa4f 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -76,5 +76,5 @@ void __init pagetable_init(void)
 	 * Fixed mappings:
 	 */
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, vaddr + FIXADDR_SIZE, pgd_base);
+	fixrange_init(vaddr, 0, pgd_base);
 }
-- 
1.7.10
