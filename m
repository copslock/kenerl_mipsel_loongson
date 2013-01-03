Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jan 2013 22:45:52 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:43328 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823014Ab3ACVpvBIvXO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jan 2013 22:45:51 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tqsbd-0005YS-Sh; Thu, 03 Jan 2013 15:45:41 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org,
        jchandra@broadcom.com, ddaney.cavm@gmail.com
Subject: [PATCH v2] MIPS: Optimise TLB handlers for MIPS32/64 R2 cores.
Date:   Thu,  3 Jan 2013 15:45:36 -0600
Message-Id: <1357249536-2308-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

The EXT and INS instructions can be used to decrease code size and
thus speed up TLB handlers on MIPS32R2 and MIPS64R2 cores.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/uasm.h |    1 +
 arch/mips/mm/tlbex.c         |   25 +++++++++++++++++++++++++
 arch/mips/mm/uasm.c          |    4 +++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 7e0bf17..e9af35b 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -77,6 +77,7 @@ Ip_u1u2s3(_bne);
 Ip_u2s3u1(_cache);
 Ip_u2u1s3(_daddiu);
 Ip_u3u1u2(_daddu);
+Ip_u2u1msbu3(_dext);
 Ip_u2u1msbu3(_dins);
 Ip_u2u1msbu3(_dinsm);
 Ip_u1u2u3(_dmfc0);
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 074d659..588258f 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -977,6 +977,13 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 #endif
 	uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
 	uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
+
+	if (cpu_has_mips_r2) {
+		uasm_i_ext(p, tmp, tmp, PGDIR_SHIFT, (32 - PGDIR_SHIFT));
+		uasm_i_ins(p, ptr, tmp, PGD_T_LOG2, (32 - PGDIR_SHIFT));
+		return;
+	}
+
 	uasm_i_srl(p, tmp, tmp, PGDIR_SHIFT); /* get pgd only bits */
 	uasm_i_sll(p, tmp, tmp, PGD_T_LOG2);
 	uasm_i_addu(p, ptr, ptr, tmp); /* add in pgd offset */
@@ -1012,6 +1019,24 @@ static void __cpuinit build_adjust_context(u32 **p, unsigned int ctx)
 
 static void __cpuinit build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
 {
+	if (cpu_has_mips_r2) {
+		/* PTE ptr offset is obtained from BadVAddr */
+		UASM_i_MFC0(p, tmp, C0_BADVADDR);
+		UASM_i_LW(p, ptr, 0, ptr);
+#ifdef CONFIG_CPU_MIPS64
+		uasm_i_dext(p, tmp, tmp, (PAGE_SHIFT + 1),
+			(PAGE_SHIFT - PTE_ORDER - PTE_T_LOG2 - 1));
+		uasm_i_dins(p, ptr, tmp, (PTE_T_LOG2 + 1),
+			(PAGE_SHIFT - PTE_ORDER - PTE_T_LOG2 - 1));
+#else
+		uasm_i_ext(p, tmp, tmp, (PAGE_SHIFT + 1),
+			(PGDIR_SHIFT - PAGE_SHIFT - 1);
+		uasm_i_ins(p, ptr, tmp, (PTE_T_LOG2 + 1),
+			(PGDIR_SHIFT - PAGE_SHIFT - 1);
+#endif
+		return;
+	}
+
 	/*
 	 * Bug workaround for the Nevada. It seems as if under certain
 	 * circumstances the move from cp0_context might produce a
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 39b8910..5bfb75a 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -60,7 +60,7 @@ enum opcode {
 	insn_invalid,
 	insn_addiu, insn_addu, insn_and, insn_andi, insn_bbit0, insn_bbit1,
 	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
-	insn_bne, insn_cache, insn_daddiu, insn_daddu, insn_dins, insn_dinsm,
+	insn_bne, insn_cache, insn_daddiu, insn_daddu, insn_dext, insn_dins, insn_dinsm,
 	insn_dmfc0, insn_dmtc0, insn_drotr, insn_drotr32, insn_dsll,
 	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret,
 	insn_ext, insn_ins, insn_j, insn_jal, insn_jr, insn_ld, insn_ldx,
@@ -103,6 +103,7 @@ static struct insn insn_table[] __uasminitdata = {
 	{ insn_cache,  M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
+	{ insn_dext, M(spec3_op, 0, 0, 0, 0, dext_op), RS | RT | RD | RE},
 	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
 	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
 	{ insn_dmfc0, M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
@@ -435,6 +436,7 @@ I_0(_tlbwi)
 I_0(_tlbwr)
 I_u3u1u2(_xor)
 I_u2u1u3(_xori)
+I_u2u1msbdu3(_dext)
 I_u2u1msbu3(_dins);
 I_u2u1msb32u3(_dinsm);
 I_u1(_syscall);
-- 
1.7.9.5
