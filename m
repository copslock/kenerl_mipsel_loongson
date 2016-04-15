Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 12:39:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9067 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026663AbcDOKi5opUOe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 12:38:57 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 299D0ACBB529C;
        Fri, 15 Apr 2016 11:38:49 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 11:38:51 +0100
Received: from localhost (10.100.200.59) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 15 Apr
 2016 11:38:51 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/12] MIPS: mm: Unify pte_page definition
Date:   Fri, 15 Apr 2016 11:36:54 +0100
Message-ID: <1460716620-13382-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.59]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The same definition for pte_page is duplicated for the MIPS32
PHYS_ADDR_T_64BIT case & the generic case. Unify them by moving a single
definition outside of preprocessor conditionals.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/pgtable-32.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 832e216..181bd8e 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -104,7 +104,7 @@ static inline void pmd_clear(pmd_t *pmdp)
 }
 
 #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
-#define pte_page(x)		pfn_to_page(pte_pfn(x))
+
 #define pte_pfn(x)		(((unsigned long)((x).pte_high >> _PFN_SHIFT)) | (unsigned long)((x).pte_low << _PAGE_PRESENT_SHIFT))
 static inline pte_t
 pfn_pte(unsigned long pfn, pgprot_t prot)
@@ -120,8 +120,6 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 
 #else
 
-#define pte_page(x)		pfn_to_page(pte_pfn(x))
-
 #ifdef CONFIG_CPU_VR41XX
 #define pte_pfn(x)		((unsigned long)((x).pte >> (PAGE_SHIFT + 2)))
 #define pfn_pte(pfn, prot)	__pte(((pfn) << (PAGE_SHIFT + 2)) | pgprot_val(prot))
@@ -131,6 +129,8 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
 #endif
 #endif /* defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32) */
 
+#define pte_page(x)		pfn_to_page(pte_pfn(x))
+
 #define __pgd_offset(address)	pgd_index(address)
 #define __pud_offset(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
 #define __pmd_offset(address)	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
-- 
2.8.0
