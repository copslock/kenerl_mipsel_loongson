Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Apr 2016 18:29:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53447 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027770AbcD2Q3ptwj95 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Apr 2016 18:29:45 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 81FB5A42D5E1A;
        Fri, 29 Apr 2016 17:29:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 29 Apr 2016 17:29:39 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 29 Apr 2016 17:29:38 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: genex: Indent delay slots & clean whitespace
Date:   Fri, 29 Apr 2016 17:29:29 +0100
Message-ID: <1461947369-31151-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53267
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

Various branches and jumps in noreorder parts of genex.S don't have
their delay slot instructions indented conventionally with the extra
space.

Fix these, as well as various other inconsistent whitespace problems in
this file, such as spaces used after some opcodes instead of a tab.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/genex.S | 56 ++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index baa7b6fc0a60..af99af07ff23 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -130,7 +130,7 @@ LEAF(__r4k_wait)
 	/* end of rollback region (the region size must be power of two) */
 1:
 	jr	ra
-	nop
+	 nop
 	.set	pop
 	END(__r4k_wait)
 
@@ -172,7 +172,7 @@ NESTED(handle_int, PT_SIZE, sp)
 	mfc0	k0, CP0_EPC
 	.set	noreorder
 	j	k0
-	rfe
+	 rfe
 #else
 	and	k0, ST0_IE
 	bnez	k0, 1f
@@ -189,7 +189,7 @@ NESTED(handle_int, PT_SIZE, sp)
 	LONG_L	s0, TI_REGS($28)
 	LONG_S	sp, TI_REGS($28)
 	PTR_LA	ra, ret_from_irq
-	PTR_LA  v0, plat_irq_dispatch
+	PTR_LA	v0, plat_irq_dispatch
 	jr	v0
 #ifdef CONFIG_CPU_MICROMIPS
 	nop
@@ -292,7 +292,7 @@ ejtag_return:
 	MFC0	k0, CP0_DESAVE
 	.set	mips32
 	deret
-	.set pop
+	.set	pop
 	END(ejtag_debug_handler)
 
 /*
@@ -329,10 +329,10 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	 * Clear BEV - required for page fault exception handler to work
 	 */
 	mfc0	k0, CP0_STATUS
-	ori     k0, k0, ST0_EXL
+	ori	k0, k0, ST0_EXL
 	li	k1, ~(ST0_BEV | ST0_ERL)
-	and     k0, k0, k1
-	mtc0    k0, CP0_STATUS
+	and	k0, k0, k1
+	mtc0	k0, CP0_STATUS
 	_ehb
 	SAVE_ALL
 	move	a0, sp
@@ -396,7 +396,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 
 	.macro	__BUILD_count exception
 	LONG_L	t0,exception_count_\exception
-	LONG_ADDIU t0, 1
+	LONG_ADDIU	t0, 1
 	LONG_S	t0,exception_count_\exception
 	.comm	exception_count\exception, 8, 8
 	.endm
@@ -457,8 +457,8 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	MFC0	k1, CP0_ENTRYHI
 	andi	k1, 0xff	/* ASID_MASK */
 	MFC0	k0, CP0_EPC
-	PTR_SRL k0, _PAGE_SHIFT + 1
-	PTR_SLL k0, _PAGE_SHIFT + 1
+	PTR_SRL	k0, _PAGE_SHIFT + 1
+	PTR_SLL	k0, _PAGE_SHIFT + 1
 	or	k1, k0
 	MTC0	k1, CP0_ENTRYHI
 	mtc0_tlbw_hazard
@@ -478,27 +478,27 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	/* microMIPS: 0x007d6b3c: rdhwr v1,$29 */
 	MFC0	k1, CP0_EPC
 #if defined(CONFIG_CPU_MICROMIPS) || defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_CPU_MIPS64_R2)
-	and     k0, k1, 1
-	beqz    k0, 1f
-	xor     k1, k0
-	lhu     k0, (k1)
-	lhu     k1, 2(k1)
-	ins     k1, k0, 16, 16
-	lui     k0, 0x007d
-	b       docheck
-	ori     k0, 0x6b3c
+	and	k0, k1, 1
+	beqz	k0, 1f
+	 xor	k1, k0
+	lhu	k0, (k1)
+	lhu	k1, 2(k1)
+	ins	k1, k0, 16, 16
+	lui	k0, 0x007d
+	b	docheck
+	 ori	k0, 0x6b3c
 1:
-	lui     k0, 0x7c03
-	lw      k1, (k1)
-	ori     k0, 0xe83b
+	lui	k0, 0x7c03
+	lw	k1, (k1)
+	ori	k0, 0xe83b
 #else
-	andi    k0, k1, 1
-	bnez    k0, handle_ri
-	lui     k0, 0x7c03
-	lw      k1, (k1)
-	ori     k0, 0xe83b
+	andi	k0, k1, 1
+	bnez	k0, handle_ri
+	 lui	k0, 0x7c03
+	lw	k1, (k1)
+	ori	k0, 0xe83b
 #endif
-	.set    reorder
+	.set	reorder
 docheck:
 	bne	k0, k1, handle_ri	/* if not ours */
 
-- 
2.4.10
