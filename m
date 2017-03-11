Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Mar 2017 06:20:03 +0100 (CET)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:48052 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991129AbdCKFTuGZASF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Mar 2017 06:19:50 +0100
X-QQ-mid: bizesmtp8t1489209555tval3617b
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 11 Mar 2017 13:19:13 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK82B00A0000000
X-QQ-FEAT: r8geFCKg7naCf+z28e2nATqh85JNqSNySKHUhtSYmqbjEZdAs5ODN7HeS3Um/
        1YLRF1t7YyiD9W4u5F/QV2eu8d2t1g2mSeeJG7gifQjx+0t5J8lM2WmclvVClWnh6BsEqDt
        V6bKZsYCB3Kn6PpaGhCOOyFD4V5GRgV881U21iOdM70jKp2OSzjeQ+m07APwi2Bf/79uaDg
        fVBOlZpOwEFuNkIKtCUisr7y8Pqwz3Zx5n+oExMXOOe3WECexayKTOn2ZQe0KKY/exh6GQp
        spoqDuflyR96VISmUjr/2wtAHaLUZcbtimtQ==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org,
        Rui Wang <wangr@lemote.com>
Subject: [PATCH V2 3/7] MIPS: Flush wrong invalid FTLB entry for huge page
Date:   Sat, 11 Mar 2017 13:19:54 +0800
Message-Id: <1489209598-30312-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1489209598-30312-1-git-send-email-chenhc@lemote.com>
References: <1489209598-30312-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57136
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
index 9bfee89..4f642e0 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -760,7 +760,8 @@ static void build_huge_update_entries(u32 **p, unsigned int pte,
 static void build_huge_handler_tail(u32 **p, struct uasm_reloc **r,
 				    struct uasm_label **l,
 				    unsigned int pte,
-				    unsigned int ptr)
+				    unsigned int ptr,
+				    unsigned int flush)
 {
 #ifdef CONFIG_SMP
 	UASM_i_SC(p, pte, 0, ptr);
@@ -769,6 +770,22 @@ static void build_huge_handler_tail(u32 **p, struct uasm_reloc **r,
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
@@ -2199,7 +2216,7 @@ static void build_r4000_tlb_load_handler(void)
 		uasm_l_tlbl_goaround2(&l, p);
 	}
 	uasm_i_ori(&p, wr.r1, wr.r1, (_PAGE_ACCESSED | _PAGE_VALID));
-	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2);
+	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2, 1);
 #endif
 
 	uasm_l_nopage_tlbl(&l, p);
@@ -2254,7 +2271,7 @@ static void build_r4000_tlb_store_handler(void)
 	build_tlb_probe_entry(&p);
 	uasm_i_ori(&p, wr.r1, wr.r1,
 		   _PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID | _PAGE_DIRTY);
-	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2);
+	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2, 1);
 #endif
 
 	uasm_l_nopage_tlbs(&l, p);
@@ -2310,7 +2327,7 @@ static void build_r4000_tlb_modify_handler(void)
 	build_tlb_probe_entry(&p);
 	uasm_i_ori(&p, wr.r1, wr.r1,
 		   _PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID | _PAGE_DIRTY);
-	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2);
+	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2, 0);
 #endif
 
 	uasm_l_nopage_tlbm(&l, p);
-- 
2.7.0
