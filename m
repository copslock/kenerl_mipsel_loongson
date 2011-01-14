Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jan 2011 02:59:06 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:54550 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492832Ab1ANB4a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Jan 2011 02:56:30 +0100
Received: (qmail 13367 invoked from network); 14 Jan 2011 01:56:27 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 14 Jan 2011 01:56:27 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Thu, 13 Jan 2011 17:56:27 -0800
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 6/6] MIPS: Limit fixrange_init() to the FIXMAP region
Date:   Thu, 13 Jan 2011 17:52:17 -0800
Message-Id: <701f7c96d791acbfc7a8d913ca60426b@localhost>
In-Reply-To: <491015d51e5d3d36c517da09e038ecaf@localhost>
References: <491015d51e5d3d36c517da09e038ecaf@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

fixrange_init() allocates page tables for all addresses higher than
FIXADDR_TOP.  On processors that override the default FIXADDR_TOP
address of 0xfffe_0000, this can consume up to 4 pages (1 page per 4MB)
for pgd's that are never used.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/mm/init.c       |    6 +++---
 arch/mips/mm/pgtable-32.c |    2 +-
 arch/mips/mm/pgtable-64.c |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 45447cd..14a89bd 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -279,11 +279,11 @@ void __init fixrange_init(unsigned long start, unsigned long end,
 	k = __pmd_offset(vaddr);
 	pgd = pgd_base + i;
 
-	for ( ; (i < PTRS_PER_PGD) && (vaddr != end); pgd++, i++) {
+	for ( ; (i < PTRS_PER_PGD) && (vaddr < end); pgd++, i++) {
 		pud = (pud_t *)pgd;
-		for ( ; (j < PTRS_PER_PUD) && (vaddr != end); pud++, j++) {
+		for ( ; (j < PTRS_PER_PUD) && (vaddr < end); pud++, j++) {
 			pmd = (pmd_t *)pud;
-			for (; (k < PTRS_PER_PMD) && (vaddr != end); pmd++, k++) {
+			for (; (k < PTRS_PER_PMD) && (vaddr < end); pmd++, k++) {
 				if (pmd_none(*pmd)) {
 					pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
 					set_pmd(pmd, __pmd((unsigned long)pte));
diff --git a/arch/mips/mm/pgtable-32.c b/arch/mips/mm/pgtable-32.c
index 575e401..adc6911 100644
--- a/arch/mips/mm/pgtable-32.c
+++ b/arch/mips/mm/pgtable-32.c
@@ -52,7 +52,7 @@ void __init pagetable_init(void)
 	 * Fixed mappings:
 	 */
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, 0, pgd_base);
+	fixrange_init(vaddr, vaddr + FIXADDR_SIZE, pgd_base);
 
 #ifdef CONFIG_HIGHMEM
 	/*
diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index 78eaa4f..cda4e30 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -76,5 +76,5 @@ void __init pagetable_init(void)
 	 * Fixed mappings:
 	 */
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, 0, pgd_base);
+	fixrange_init(vaddr, vaddr + FIXADDR_SIZE, pgd_base);
 }
-- 
1.7.0.4
