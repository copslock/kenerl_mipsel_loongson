Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:34:35 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27237 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992535AbdAFBdgyu7pu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:36 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D16A880E5939A;
        Fri,  6 Jan 2017 01:33:29 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:30 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <kvm@vger.kernel.org>
Subject: [PATCH 2/30] MIPS: Export pgd/pmd symbols for KVM
Date:   Fri, 6 Jan 2017 01:32:34 +0000
Message-ID: <dd23ddfe6b616c2111a395e7b0351d7c2c3f8683.1483665879.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
References: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Export pgd_init(), pmd_init(), invalid_pmd_table and
tlbmiss_handler_setup_pgd to GPL kernel modules so that MIPS KVM can use
the inline page table management functions and switch between page
tables:

- pgd_init() is used inline by pgd_alloc(), which KVM will use to
  allocate page directory tables for GVA mappings.

- pmd_init() will be used directly by KVM to initialise newly allocated
  pmd tables with invalid lower level table pointers.

- invalid_pmd_table is used by pud_present(), pud_none(), and
  pud_clear(), which KVM will use to test and clear pud entries.

- tlbmiss_handler_setup_pgd() will be called by KVM entry code to switch
  to the appropriate GVA page tables.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/mm/init.c       | 1 +
 arch/mips/mm/pgtable-32.c | 1 +
 arch/mips/mm/pgtable-64.c | 3 +++
 arch/mips/mm/tlbex.c      | 5 ++++-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index e86ebcf5c071..653569bc0da7 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -538,5 +538,6 @@ unsigned long pgd_current[NR_CPUS];
 pgd_t swapper_pg_dir[_PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
 #ifndef __PAGETABLE_PMD_FOLDED
 pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
+EXPORT_SYMBOL_GPL(invalid_pmd_table);
 #endif
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
diff --git a/arch/mips/mm/pgtable-32.c b/arch/mips/mm/pgtable-32.c
index adc6911ba748..b3465c03a3c2 100644
--- a/arch/mips/mm/pgtable-32.c
+++ b/arch/mips/mm/pgtable-32.c
@@ -29,6 +29,7 @@ void pgd_init(unsigned long page)
 		p[i + 7] = (unsigned long) invalid_pte_table;
 	}
 }
+EXPORT_SYMBOL_GPL(pgd_init);
 
 void __init pagetable_init(void)
 {
diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index ce4473e7c0d2..88a96b64fcb2 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -6,6 +6,7 @@
  * Copyright (C) 1999, 2000 by Silicon Graphics
  * Copyright (C) 2003 by Ralf Baechle
  */
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <asm/fixmap.h>
@@ -39,6 +40,7 @@ void pgd_init(unsigned long page)
 		p[-1] = entry;
 	} while (p != end);
 }
+EXPORT_SYMBOL_GPL(pgd_init);
 
 #ifndef __PAGETABLE_PMD_FOLDED
 void pmd_init(unsigned long addr, unsigned long pagetable)
@@ -60,6 +62,7 @@ void pmd_init(unsigned long addr, unsigned long pagetable)
 		p[-1] = pagetable;
 	} while (p != end);
 }
+EXPORT_SYMBOL_GPL(pmd_init);
 #endif
 
 pmd_t mk_pmd(struct page *page, pgprot_t prot)
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 55ce39606cb8..dc7bb1506103 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/bug.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/smp.h>
@@ -1536,7 +1537,9 @@ static void build_loongson3_tlb_refill_handler(void)
 extern u32 handle_tlbl[], handle_tlbl_end[];
 extern u32 handle_tlbs[], handle_tlbs_end[];
 extern u32 handle_tlbm[], handle_tlbm_end[];
-extern u32 tlbmiss_handler_setup_pgd_start[], tlbmiss_handler_setup_pgd[];
+extern u32 tlbmiss_handler_setup_pgd_start[];
+extern u32 tlbmiss_handler_setup_pgd[];
+EXPORT_SYMBOL_GPL(tlbmiss_handler_setup_pgd);
 extern u32 tlbmiss_handler_setup_pgd_end[];
 
 static void build_setup_pgd(void)
-- 
git-series 0.8.10
