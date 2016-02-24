Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 15:34:18 +0100 (CET)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:48080 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013908AbcBXOeN4FyF6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2016 15:34:13 +0100
X-QQ-mid: bizesmtp8t1456324426t985t057
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 24 Feb 2016 22:33:10 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: nSUdqPGu3ttMDHhrTKQogo44pAW4FzXgGAmTmiqgPoAKILs+9g9S+EnLkcxux
        IkWhQPet4cORcaxEPxdecH/uCFDQVkssowrVwrrQggFqYQ9wMqnPeTYatL0KTeyO73OgMcc
        wBE3rPnqJvos46sAGElj27JLPuNpwwR7+9JK0K0e1YYw+d4PPTaLtwivm5GxCsILNvNmS58
        wSs4gTc4iSI6gDHqrpxw+vtR2pYX8vJ0KClhwXvB4FExXQmDgdbIJZONPluFiaCiE4omV+g
        GMJshOeSxZO+f05d6pl3v6CMw=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@kernel.org
Subject: [PATCH] MIPS: tlbex: Fix bugs in tlbchange handler
Date:   Wed, 24 Feb 2016 22:32:58 +0800
Message-Id: <1456324384-18118-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52193
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

If a tlb miss triggered when EXL=1, tlb refill exception is treated as
tlb invalid exception, so tlbp may fails. In this situation, CP0_Index
register doesn't contain a valid value. This may not be a problem for
VTLB since it is fully-associative. However, FTLB is set-associative so
not every tlb entry is valid for a specific address. Thus, we should
use tlbwr instead of tlbwi when tlbp fails.

There is a similar case for huge page, so build_huge_tlb_write_entry()
is also modified. If wmode != tlb_random, that means the caller is tlb
invalid handler, we should select tlbr/tlbi depend on the tlbp result.

Cc: stable@kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/mm/tlbex.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 5a04b6f..1ab9557 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -173,7 +173,10 @@ enum label_id {
 	label_large_segbits_fault,
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	label_tlb_huge_update,
+	label_tail_huge_miss,
+	label_tail_huge_done,
 #endif
+	label_tail_miss,
 };
 
 UASM_L_LA(_second_part)
@@ -192,7 +195,10 @@ UASM_L_LA(_r3000_write_probe_fail)
 UASM_L_LA(_large_segbits_fault)
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 UASM_L_LA(_tlb_huge_update)
+UASM_L_LA(_tail_huge_miss)
+UASM_L_LA(_tail_huge_done)
 #endif
+UASM_L_LA(_tail_miss)
 
 static int hazard_instance;
 
@@ -701,8 +707,24 @@ static void build_huge_tlb_write_entry(u32 **p, struct uasm_label **l,
 	uasm_i_ori(p, tmp, tmp, PM_HUGE_MASK & 0xffff);
 	uasm_i_mtc0(p, tmp, C0_PAGEMASK);
 
-	build_tlb_write_entry(p, l, r, wmode);
+	if (wmode == tlb_random) { /* Caller is TLB Refill Handler */
+		build_tlb_write_entry(p, l, r, wmode);
+		build_restore_pagemask(p, r, tmp, label_leave, restore_scratch);
+		return;
+	}
+
+	/* Caller is TLB Load/Store/Modify Handler */
+	uasm_i_mfc0(p, tmp, C0_INDEX);
+	uasm_il_bltz(p, r, tmp, label_tail_huge_miss);
+	uasm_i_nop(p);
+	build_tlb_write_entry(p, l, r, tlb_indexed);
+	uasm_il_b(p, r, label_tail_huge_done);
+	uasm_i_nop(p);
+
+	uasm_l_tail_huge_miss(l, *p);
+	build_tlb_write_entry(p, l, r, tlb_random);
 
+	uasm_l_tail_huge_done(l, *p);
 	build_restore_pagemask(p, r, tmp, label_leave, restore_scratch);
 }
 
@@ -1913,7 +1935,14 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
 	uasm_i_ori(p, ptr, ptr, sizeof(pte_t));
 	uasm_i_xori(p, ptr, ptr, sizeof(pte_t));
 	build_update_entries(p, tmp, ptr);
+	uasm_i_mfc0(p, ptr, C0_INDEX);
+	uasm_il_bltz(p, r, ptr, label_tail_miss);
+	uasm_i_nop(p);
 	build_tlb_write_entry(p, l, r, tlb_indexed);
+	uasm_il_b(p, r, label_leave);
+	uasm_i_nop(p);
+	uasm_l_tail_miss(l, *p);
+	build_tlb_write_entry(p, l, r, tlb_random);
 	uasm_l_leave(l, *p);
 	build_restore_work_registers(p);
 	uasm_i_eret(p); /* return from trap */
-- 
2.7.0
