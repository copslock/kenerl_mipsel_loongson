Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2016 10:28:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23883 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027018AbcDSI2BdbL3Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Apr 2016 10:28:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id E9116D67DFBA2;
        Tue, 19 Apr 2016 09:27:52 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 19 Apr 2016 09:27:55 +0100
Received: from localhost (10.100.200.185) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 19 Apr
 2016 09:27:54 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 10/13] MIPS: mm: Be more explicit about PTE mode bit handling
Date:   Tue, 19 Apr 2016 09:25:08 +0100
Message-ID: <1461054311-387-11-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 53091
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

The XPA case in iPTE_SW or's in software mode bits to the pte_low value
(which is what actually ends up in the high 32 bits of EntryLo...). It
does this presuming that only bits in the upper 16 bits of the 32 bit
pte_low value will be set. Make this assumption explicit with a BUG_ON.

A similar assumption is made for the hardware mode bits, which are or'd
in with a single ori instruction. Make that assumption explicit with a
BUG_ON too.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v3: None
Changes in v2: None

 arch/mips/mm/tlbex.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index d7a7b3d..0bd3755 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1528,15 +1528,17 @@ static void
 iPTE_SW(u32 **p, struct uasm_reloc **r, unsigned int pte, unsigned int ptr,
 	unsigned int mode, unsigned int scratch)
 {
-#ifdef CONFIG_PHYS_ADDR_T_64BIT
 	unsigned int hwmode = mode & (_PAGE_VALID | _PAGE_DIRTY);
+	unsigned int swmode = mode & ~hwmode;
 
 	if (config_enabled(CONFIG_XPA) && !cpu_has_64bits) {
-		uasm_i_lui(p, scratch, (mode >> 16));
+		uasm_i_lui(p, scratch, swmode >> 16);
 		uasm_i_or(p, pte, pte, scratch);
-	} else
-#endif
-	uasm_i_ori(p, pte, pte, mode);
+		BUG_ON(swmode & 0xffff);
+	} else {
+		uasm_i_ori(p, pte, pte, mode);
+	}
+
 #ifdef CONFIG_SMP
 # ifdef CONFIG_PHYS_ADDR_T_64BIT
 	if (cpu_has_64bits)
@@ -1555,6 +1557,7 @@ iPTE_SW(u32 **p, struct uasm_reloc **r, unsigned int pte, unsigned int ptr,
 		/* no uasm_i_nop needed */
 		uasm_i_ll(p, pte, sizeof(pte_t) / 2, ptr);
 		uasm_i_ori(p, pte, pte, hwmode);
+		BUG_ON(hwmode & ~0xffff);
 		uasm_i_sc(p, pte, sizeof(pte_t) / 2, ptr);
 		uasm_il_beqz(p, r, pte, label_smp_pgtable_change);
 		/* no uasm_i_nop needed */
@@ -1576,6 +1579,7 @@ iPTE_SW(u32 **p, struct uasm_reloc **r, unsigned int pte, unsigned int ptr,
 	if (!cpu_has_64bits) {
 		uasm_i_lw(p, pte, sizeof(pte_t) / 2, ptr);
 		uasm_i_ori(p, pte, pte, hwmode);
+		BUG_ON(hwmode & ~0xffff);
 		uasm_i_sw(p, pte, sizeof(pte_t) / 2, ptr);
 		uasm_i_lw(p, pte, 0, ptr);
 	}
-- 
2.8.0
