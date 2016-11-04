Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 09:41:57 +0100 (CET)
Received: from smtpproxy19.qq.com ([184.105.206.84]:55078 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990521AbcKDIltZUudt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2016 09:41:49 +0100
X-QQ-mid: bizesmtp1t1478248887t3s69kihw
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 04 Nov 2016 16:41:26 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ72000A0000000
X-QQ-FEAT: UQzUm2uM70duu5ZIrrT3GiQVFYbRh2CaJsS8+AI3Rvuvh/kG7SCCODdUUrcto
        gbotU9MjtI2kmQXXuUV5ldcSYWRivfBmaRYKDfxymjNE+wqc3uNGsMe9t6hsunu7hYEsuN4
        TLY3hmG4EWzEm7FSN95hmxYYkXn7xTufGebdXMoHVT5zj95YCeHDxVeDQBQoboPlG3A/2uc
        pZ6J8A2njiA6I5dhVsS3m7vh8GuLQmcdXMsrBB/HIOiLglai2a/9hKOP4y9qH3Mips4p8CI
        L4JIfcHIr3NTUuMLyTbdRkzRw=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org,
        Rui Wang <wangr@lemote.com>
Subject: [PATCH 2/3] MIPS: Flush wrong invalid FTLB entry for huge page
Date:   Fri,  4 Nov 2016 16:41:27 +0800
Message-Id: <1478248888-31003-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1478248888-31003-1-git-send-email-chenhc@lemote.com>
References: <1478248888-31003-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

On VTLB+FTLB platforms (such as Loongson-3A R2), FTLB's pagesize is
usually configured the same as PAGE_SIZE. In such a case, Huge page
entry is not suitable to write in FTLB.

Unfortunately, when a huge page is created, its page table entries
haven't created immediately. Then the TLB refill handler will fetch an
invalid page table entry which has no "HUGE" bit, and this entry may be
written to FTLB. Since it is invalid, TLB load/store handler will then
use tlbwi to write the valid entry at the same place. However, the
valid entry is a huge page entry which isn't suitable for FTLB.

Our solution is to modify build_huge_handler_tail. Flush the invalid
old entry (whether it is in FTLB or VTLB, this is in order to reduce
branches) and use tlbwr to write the valid new entry.

Cc: stable@vger.kernel.org
Signed-off-by: Rui Wang <wangr@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/mm/tlbex.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 55ce396..2da5649 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -762,7 +762,8 @@ static void build_huge_update_entries(u32 **p, unsigned int pte,
 static void build_huge_handler_tail(u32 **p, struct uasm_reloc **r,
 				    struct uasm_label **l,
 				    unsigned int pte,
-				    unsigned int ptr)
+				    unsigned int ptr,
+				    unsigned int flush)
 {
 #ifdef CONFIG_SMP
 	UASM_i_SC(p, pte, 0, ptr);
@@ -771,6 +772,22 @@ static void build_huge_handler_tail(u32 **p, struct uasm_reloc **r,
 #else
 	UASM_i_SW(p, pte, 0, ptr);
 #endif
+	if (cpu_has_ftlb && flush) {
+		BUG_ON(!cpu_has_tlbinv);
+
+		UASM_i_MFC0(p, ptr, C0_ENTRYHI);
+		uasm_i_ori(p, ptr, ptr, MIPS_ENTRYHI_EHINV);
+		UASM_i_MTC0(p, ptr, C0_ENTRYHI);
+		build_tlb_write_entry(p, l, r, tlb_indexed);
+
+		uasm_i_xori(p, ptr, ptr, MIPS_ENTRYHI_EHINV);
+		UASM_i_MTC0(p, ptr, C0_ENTRYHI);
+		build_huge_update_entries(p, pte, ptr);
+		build_huge_tlb_write_entry(p, l, r, pte, tlb_random, 0);
+
+		return;
+	}
+
 	build_huge_update_entries(p, pte, ptr);
 	build_huge_tlb_write_entry(p, l, r, pte, tlb_indexed, 0);
 }
@@ -2197,7 +2214,7 @@ static void build_r4000_tlb_load_handler(void)
 		uasm_l_tlbl_goaround2(&l, p);
 	}
 	uasm_i_ori(&p, wr.r1, wr.r1, (_PAGE_ACCESSED | _PAGE_VALID));
-	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2);
+	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2, 1);
 #endif
 
 	uasm_l_nopage_tlbl(&l, p);
@@ -2252,7 +2269,7 @@ static void build_r4000_tlb_store_handler(void)
 	build_tlb_probe_entry(&p);
 	uasm_i_ori(&p, wr.r1, wr.r1,
 		   _PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID | _PAGE_DIRTY);
-	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2);
+	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2, 1);
 #endif
 
 	uasm_l_nopage_tlbs(&l, p);
@@ -2308,7 +2325,7 @@ static void build_r4000_tlb_modify_handler(void)
 	build_tlb_probe_entry(&p);
 	uasm_i_ori(&p, wr.r1, wr.r1,
 		   _PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID | _PAGE_DIRTY);
-	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2);
+	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2, 0);
 #endif
 
 	uasm_l_nopage_tlbm(&l, p);
-- 
2.7.0
