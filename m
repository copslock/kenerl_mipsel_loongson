Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 11:38:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52504 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026884AbcDRJiLbPh3M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 11:38:11 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 7C418335E912D;
        Mon, 18 Apr 2016 10:38:02 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 18 Apr 2016 10:38:05 +0100
Received: from localhost (10.100.200.164) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 18 Apr
 2016 10:38:04 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/13] MIPS: mm: Pass scratch register through to iPTE_SW
Date:   Mon, 18 Apr 2016 10:35:29 +0100
Message-ID: <1460972133-16973-10-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460972133-16973-1-git-send-email-paul.burton@imgtec.com>
References: <1460972133-16973-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.164]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53052
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

Without doing this there are cases (where KScratch registers are
unavailable) in which iPTE_SW will incorrectly clobber $1 despite it
already being in use for the PTE or PTE pointer.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>

---

Changes in v2:
- Mention $1 clobbering.

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
