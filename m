Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:12:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34132 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009141AbaLRPLKL8OCz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:11:10 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5A34B5D420FDD
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:11:01 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:11:03 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:11:03 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 06/67] MIPS: mm: Add MIPS R6 instruction encodings
Date:   Thu, 18 Dec 2014 15:09:15 +0000
Message-ID: <1418915416-3196-7-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

MIPS R6 defines new opcodes for ll, sc, cache and pref instructions
so we need to take these into consideration in the micro-assembler.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/uapi/asm/inst.h |  9 ++++++---
 arch/mips/mm/uasm-mips.c          | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 4bfdb9d4c186..c330de057558 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -83,9 +83,12 @@ enum spec3_op {
 	swe_op    = 0x1f, bshfl_op  = 0x20,
 	swle_op   = 0x21, swre_op   = 0x22,
 	prefe_op  = 0x23, dbshfl_op = 0x24,
-	lbue_op   = 0x28, lhue_op   = 0x29,
-	lbe_op    = 0x2c, lhe_op    = 0x2d,
-	lle_op    = 0x2e, lwe_op    = 0x2f,
+	cache6_op = 0x25, sc6_op    = 0x26,
+	scd6_op   = 0x27, lbue_op   = 0x28,
+	lhue_op   = 0x29, lbe_op    = 0x2c,
+	lhe_op    = 0x2d, lle_op    = 0x2e,
+	lwe_op    = 0x2f, pref6_op  = 0x35,
+	ll6_op    = 0x36, lld6_op   = 0x37,
 	rdhwr_op  = 0x3b
 };
 
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 6708a2dbf934..c1fb8bdfb06d 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -38,6 +38,14 @@
 	 | (e) << RE_SH						\
 	 | (f) << FUNC_SH)
 
+/* This macro sets the non-variable bits of an R6 instruction. */
+#define M6(a, b, c, d, e)					\
+	((a) << OP_SH						\
+	 | (b) << RS_SH						\
+	 | (c) << RT_SH						\
+	 | (d) << SIMM9_SH					\
+	 | (e) << FUNC_SH)
+
 /* Define these when we are not the ISA the kernel is being compiled with. */
 #ifdef CONFIG_CPU_MICROMIPS
 #define CL_uasm_i_b(buf, off) ISAOPC(_beq)(buf, 0, 0, off)
@@ -62,7 +70,11 @@ static struct insn insn_table[] = {
 	{ insn_bltzl, M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM },
 	{ insn_bltz, M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM },
 	{ insn_bne, M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+#ifndef CONFIG_MIPS_R6
 	{ insn_cache,  M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+#else
+	{ insn_cache,  M6(cache_op, 0, 0, 0, 0, cache6_op),  RS | RT | SIMM9 },
+#endif
 	{ insn_daddiu, M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
 	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
@@ -85,13 +97,22 @@ static struct insn insn_table[] = {
 	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),	JIMM },
 	{ insn_jalr,  M(spec_op, 0, 0, 0, 0, jalr_op), RS | RD },
 	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
+#ifndef CONFIG_CPU_MIPSR6
 	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
+#else
+	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jalr_op),  RS },
+#endif
 	{ insn_lb, M(lb_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
 	{ insn_lh,  M(lh_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+#ifndef CONFIG_CPU_MIPSR6
 	{ insn_lld,  M(lld_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
 	{ insn_ll,  M(ll_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+#else
+	{ insn_lld,  M6(spec3_op, 0, 0, 0, lld6_op),  RS | RT | SIMM9 },
+	{ insn_ll,  M6(spec3_op, 0, 0, 0, ll6_op),  RS | RT | SIMM9 },
+#endif
 	{ insn_lui,  M(lui_op, 0, 0, 0, 0, 0),	RT | SIMM },
 	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_lwx, M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD },
@@ -102,11 +123,20 @@ static struct insn insn_table[] = {
 	{ insn_mul, M(spec2_op, 0, 0, 0, 0, mul_op), RS | RT | RD},
 	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM },
 	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
+#ifndef CONFIG_CPU_MIPSR6
 	{ insn_pref,  M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+#else
+	{ insn_pref,  M6(spec3_op, 0, 0, 0, pref6_op),  RS | RT | SIMM9 },
+#endif
 	{ insn_rfe,  M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0 },
 	{ insn_rotr,  M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE },
+#ifndef CONFIG_CPU_MIPSR6
 	{ insn_scd,  M(scd_op, 0, 0, 0, 0, 0),	RS | RT | SIMM },
 	{ insn_sc,  M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
+#else
+	{ insn_scd,  M6(spec3_op, 0, 0, 0, scd6_op),  RS | RT | SIMM9 },
+	{ insn_sc,  M6(spec3_op, 0, 0, 0, sc6_op),  RS | RT | SIMM9 },
+#endif
 	{ insn_sd,  M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_sll,  M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE },
 	{ insn_sllv,  M(spec_op, 0, 0, 0, 0, sllv_op),  RS | RT | RD },
@@ -196,6 +226,8 @@ static void build_insn(u32 **buf, enum opcode opc, ...)
 		op |= build_set(va_arg(ap, u32));
 	if (ip->fields & SCIMM)
 		op |= build_scimm(va_arg(ap, u32));
+	if (ip->fields & SIMM9)
+		op |= build_scimm9(va_arg(ap, u32));
 	va_end(ap);
 
 	**buf = op;
-- 
2.2.0
