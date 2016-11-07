Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:15:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27402 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991978AbcKGLPLUtyjd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:15:11 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 10B04A30E4C7;
        Mon,  7 Nov 2016 11:15:03 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:15:05 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 02/10] MIPS: tlbex: Clear ISA bit when writing to handle_tlb{l,m,s}
Date:   Mon, 7 Nov 2016 11:14:08 +0000
Message-ID: <20161107111417.11486-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107111417.11486-1-paul.burton@imgtec.com>
References: <20161107111417.11486-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55685
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

When generating TLB exception handling code we write to memory reserved
at the handle_tlbl, handle_tlbm & handle_tlbs symbols. Up until now the
ISA bit has always been clear simply because the assembly code reserving
the space for those functions places no instructions in them. In
preparation for marking all LEAF functions as containing code,
explicitly clear the ISA bit when calculating the addresses at which to
write TLB exception handling code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/mm/tlbex.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 55ce396..87eed65 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -2041,7 +2041,7 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
 
 static void build_r4000_tlb_load_handler(void)
 {
-	u32 *p = handle_tlbl;
+	u32 *p = (u32 *)msk_isa16_mode((ulong)handle_tlbl);
 	const int handle_tlbl_size = handle_tlbl_end - handle_tlbl;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
@@ -2224,7 +2224,7 @@ static void build_r4000_tlb_load_handler(void)
 
 static void build_r4000_tlb_store_handler(void)
 {
-	u32 *p = handle_tlbs;
+	u32 *p = (u32 *)msk_isa16_mode((ulong)handle_tlbs);
 	const int handle_tlbs_size = handle_tlbs_end - handle_tlbs;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
@@ -2279,7 +2279,7 @@ static void build_r4000_tlb_store_handler(void)
 
 static void build_r4000_tlb_modify_handler(void)
 {
-	u32 *p = handle_tlbm;
+	u32 *p = (u32 *)msk_isa16_mode((ulong)handle_tlbm);
 	const int handle_tlbm_size = handle_tlbm_end - handle_tlbm;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
-- 
2.10.2
