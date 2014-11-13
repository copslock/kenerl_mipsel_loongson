Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 07:07:11 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:33763 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012575AbaKMGGAPTJOR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 07:06:00 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1XonXU-0007Qu-Q2; Thu, 13 Nov 2014 00:05:52 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 02/11] MIPS: Revert fixrange_init() limiting to the FIXMAP region.
Date:   Thu, 13 Nov 2014 00:05:34 -0600
Message-Id: <1415858743-24492-3-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1415858743-24492-1-git-send-email-Steven.Hill@imgtec.com>
References: <1415858743-24492-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

This patch refactors commit 464fd83e841a16f4ea1325b33eb08170ef5cd1f4
(MIPS: Limit fixrange_init() to the FIXMAP region) and correctly
calculates the right length while taking into account page table
alignment by PMD.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/mm/init.c       |    6 +++---
 arch/mips/mm/pgtable-64.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 5efe70f..ed217db 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -232,11 +232,11 @@ void __init fixrange_init(unsigned long start, unsigned long end,
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
diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index e8adc00..a6ae0f1 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -107,5 +107,5 @@ void __init pagetable_init(void)
 	 * Fixed mappings:
 	 */
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, vaddr + FIXADDR_SIZE, pgd_base);
+	fixrange_init(vaddr, 0, pgd_base);
 }
-- 
1.7.10.4
