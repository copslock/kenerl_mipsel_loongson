Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2016 10:29:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34150 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027019AbcDSI2bFSw8Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Apr 2016 10:28:31 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 4EF9143A20573;
        Tue, 19 Apr 2016 09:28:22 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 19 Apr 2016 09:28:24 +0100
Received: from localhost (10.100.200.185) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 19 Apr
 2016 09:28:24 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Marchand <jmarchan@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 12/13] MIPS: mm: Don't do MTHC0 if XPA not present
Date:   Tue, 19 Apr 2016 09:25:10 +0100
Message-ID: <1461054311-387-13-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461054311-387-1-git-send-email-paul.burton@imgtec.com>
References: <1461054311-387-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.185]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53093
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

From: James Hogan <james.hogan@imgtec.com>

Performing an MTHC0 instruction without XPA being present will trigger a
reserved instruction exception, therefore conditionalise the use of this
instruction when building TLB handlers (build_update_entries()), and in
__update_tlb().

This allows an XPA kernel to run on non XPA hardware without that
instruction implemented, just like it can run on XPA capable hardware
without XPA in use (with the noxpa kernel argument) or with XPA not
configured in hardware.

[paul.burton@imgtec.com:
  - Rebase atop other TLB work.
  - Add "mm" to subject.
  - Handle the __kmap_pgprot case.]

Fixes: c5b367835cfc ("MIPS: Add support for XPA.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

Changes in v3:
- Use #ifdef CONFIG_XPA to avoid use of _PFNX_MASK in __kmap_pgprot in configurations where it isn't defined.

Changes in v2: None

 arch/mips/mm/init.c    |  8 +++++---
 arch/mips/mm/tlb-r4k.c |  6 ++++--
 arch/mips/mm/tlbex.c   | 16 ++++++++++------
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 0e57893..307c534 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -112,9 +112,11 @@ static void *__kmap_pgprot(struct page *page, unsigned long addr, pgprot_t prot)
 	write_c0_entrylo0(entrylo);
 	write_c0_entrylo1(entrylo);
 #ifdef CONFIG_XPA
-	entrylo = (pte.pte_low & _PFNX_MASK);
-	writex_c0_entrylo0(entrylo);
-	writex_c0_entrylo1(entrylo);
+	if (cpu_has_xpa) {
+		entrylo = (pte.pte_low & _PFNX_MASK);
+		writex_c0_entrylo0(entrylo);
+		writex_c0_entrylo1(entrylo);
+	}
 #endif
 	tlbidx = read_c0_wired();
 	write_c0_wired(tlbidx + 1);
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index c17d762..b99695c 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -336,10 +336,12 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 #if defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
 #ifdef CONFIG_XPA
 		write_c0_entrylo0(pte_to_entrylo(ptep->pte_high));
-		writex_c0_entrylo0(ptep->pte_low & _PFNX_MASK);
+		if (cpu_has_xpa)
+			writex_c0_entrylo0(ptep->pte_low & _PFNX_MASK);
 		ptep++;
 		write_c0_entrylo1(pte_to_entrylo(ptep->pte_high));
-		writex_c0_entrylo1(ptep->pte_low & _PFNX_MASK);
+		if (cpu_has_xpa)
+			writex_c0_entrylo1(ptep->pte_low & _PFNX_MASK);
 #else
 		write_c0_entrylo0(ptep->pte_high);
 		ptep++;
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index c7c14bd..3f1a8a2 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1022,17 +1022,21 @@ static void build_update_entries(u32 **p, unsigned int tmp, unsigned int ptep)
 		UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL));
 		UASM_i_MTC0(p, tmp, C0_ENTRYLO0);
 
-		uasm_i_lw(p, tmp, 0, ptep);
-		uasm_i_ext(p, tmp, tmp, 0, 24);
-		uasm_i_mthc0(p, tmp, C0_ENTRYLO0);
+		if (cpu_has_xpa && !mips_xpa_disabled) {
+			uasm_i_lw(p, tmp, 0, ptep);
+			uasm_i_ext(p, tmp, tmp, 0, 24);
+			uasm_i_mthc0(p, tmp, C0_ENTRYLO0);
+		}
 
 		uasm_i_lw(p, tmp, pte_off_odd, ptep); /* odd pte */
 		UASM_i_ROTR(p, tmp, tmp, ilog2(_PAGE_GLOBAL));
 		UASM_i_MTC0(p, tmp, C0_ENTRYLO1);
 
-		uasm_i_lw(p, tmp, sizeof(pte_t), ptep);
-		uasm_i_ext(p, tmp, tmp, 0, 24);
-		uasm_i_mthc0(p, tmp, C0_ENTRYLO1);
+		if (cpu_has_xpa && !mips_xpa_disabled) {
+			uasm_i_lw(p, tmp, sizeof(pte_t), ptep);
+			uasm_i_ext(p, tmp, tmp, 0, 24);
+			uasm_i_mthc0(p, tmp, C0_ENTRYLO1);
+		}
 		return;
 	}
 
-- 
2.8.0
