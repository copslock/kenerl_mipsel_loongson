Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 12:40:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:48616 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026657AbcDOKjmvvQ9e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 12:39:42 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id A7E7058C9B47C;
        Fri, 15 Apr 2016 11:39:33 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 11:39:36 +0100
Received: from localhost (10.100.200.59) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 15 Apr
 2016 11:39:35 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        "Huacai Chen" <chenhc@lemote.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 09/12] MIPS: mm: Pass scratch register through to iPTE_SW
Date:   Fri, 15 Apr 2016 11:36:57 +0100
Message-ID: <1460716620-13382-10-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 53006
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

Rather than hardcode a scratch register for the XPA case in iPTE_SW,
pass one through from the work registers allocated by the caller. This
allows for the XPA path to function correctly regardless of the work
registers in use.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/mm/tlbex.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 004cd9f..d7a7b3d 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1526,14 +1526,12 @@ iPTE_LW(u32 **p, unsigned int pte, unsigned int ptr)
 
 static void
 iPTE_SW(u32 **p, struct uasm_reloc **r, unsigned int pte, unsigned int ptr,
-	unsigned int mode)
+	unsigned int mode, unsigned int scratch)
 {
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 	unsigned int hwmode = mode & (_PAGE_VALID | _PAGE_DIRTY);
 
 	if (config_enabled(CONFIG_XPA) && !cpu_has_64bits) {
-		const int scratch = 1; /* Our extra working register */
-
 		uasm_i_lui(p, scratch, (mode >> 16));
 		uasm_i_or(p, pte, pte, scratch);
 	} else
@@ -1630,11 +1628,11 @@ build_pte_present(u32 **p, struct uasm_reloc **r,
 /* Make PTE valid, store result in PTR. */
 static void
 build_make_valid(u32 **p, struct uasm_reloc **r, unsigned int pte,
-		 unsigned int ptr)
+		 unsigned int ptr, unsigned int scratch)
 {
 	unsigned int mode = _PAGE_VALID | _PAGE_ACCESSED;
 
-	iPTE_SW(p, r, pte, ptr, mode);
+	iPTE_SW(p, r, pte, ptr, mode, scratch);
 }
 
 /*
@@ -1670,12 +1668,12 @@ build_pte_writable(u32 **p, struct uasm_reloc **r,
  */
 static void
 build_make_write(u32 **p, struct uasm_reloc **r, unsigned int pte,
-		 unsigned int ptr)
+		 unsigned int ptr, unsigned int scratch)
 {
 	unsigned int mode = (_PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID
 			     | _PAGE_DIRTY);
 
-	iPTE_SW(p, r, pte, ptr, mode);
+	iPTE_SW(p, r, pte, ptr, mode, scratch);
 }
 
 /*
@@ -1780,7 +1778,7 @@ static void build_r3000_tlb_load_handler(void)
 	build_r3000_tlbchange_handler_head(&p, K0, K1);
 	build_pte_present(&p, &r, K0, K1, -1, label_nopage_tlbl);
 	uasm_i_nop(&p); /* load delay */
-	build_make_valid(&p, &r, K0, K1);
+	build_make_valid(&p, &r, K0, K1, -1);
 	build_r3000_tlb_reload_write(&p, &l, &r, K0, K1);
 
 	uasm_l_nopage_tlbl(&l, p);
@@ -1811,7 +1809,7 @@ static void build_r3000_tlb_store_handler(void)
 	build_r3000_tlbchange_handler_head(&p, K0, K1);
 	build_pte_writable(&p, &r, K0, K1, -1, label_nopage_tlbs);
 	uasm_i_nop(&p); /* load delay */
-	build_make_write(&p, &r, K0, K1);
+	build_make_write(&p, &r, K0, K1, -1);
 	build_r3000_tlb_reload_write(&p, &l, &r, K0, K1);
 
 	uasm_l_nopage_tlbs(&l, p);
@@ -1842,7 +1840,7 @@ static void build_r3000_tlb_modify_handler(void)
 	build_r3000_tlbchange_handler_head(&p, K0, K1);
 	build_pte_modifiable(&p, &r, K0, K1,  -1, label_nopage_tlbm);
 	uasm_i_nop(&p); /* load delay */
-	build_make_write(&p, &r, K0, K1);
+	build_make_write(&p, &r, K0, K1, -1);
 	build_r3000_pte_reload_tlbwi(&p, K0, K1);
 
 	uasm_l_nopage_tlbm(&l, p);
@@ -2010,7 +2008,7 @@ static void build_r4000_tlb_load_handler(void)
 		}
 		uasm_l_tlbl_goaround1(&l, p);
 	}
-	build_make_valid(&p, &r, wr.r1, wr.r2);
+	build_make_valid(&p, &r, wr.r1, wr.r2, wr.r3);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);
 
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
@@ -2124,7 +2122,7 @@ static void build_r4000_tlb_store_handler(void)
 	build_pte_writable(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbs);
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
-	build_make_write(&p, &r, wr.r1, wr.r2);
+	build_make_write(&p, &r, wr.r1, wr.r2, wr.r3);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);
 
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
@@ -2180,7 +2178,7 @@ static void build_r4000_tlb_modify_handler(void)
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
 	/* Present and writable bits set, set accessed and dirty bits. */
-	build_make_write(&p, &r, wr.r1, wr.r2);
+	build_make_write(&p, &r, wr.r1, wr.r2, wr.r3);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);
 
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
-- 
2.8.0
