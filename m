Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2010 03:09:05 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8880 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491022Ab0L1CIl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Dec 2010 03:08:41 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d1946d50000>; Mon, 27 Dec 2010 18:09:25 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 27 Dec 2010 18:08:39 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 27 Dec 2010 18:08:39 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oBS28Vxf009237;
        Mon, 27 Dec 2010 18:08:31 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oBS28UDe009236;
        Mon, 27 Dec 2010 18:08:30 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Add LDX and LWX instructions to uasm.
Date:   Mon, 27 Dec 2010 18:07:56 -0800
Message-Id: <1293502077-9196-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1293502077-9196-1-git-send-email-ddaney@caviumnetworks.com>
References: <1293502077-9196-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Dec 2010 02:08:39.0713 (UTC) FILETIME=[24DC7910:01CBA634]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Needed by Octeon II optimized TLB handlers.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/inst.h |   14 ++++++++++++++
 arch/mips/include/asm/uasm.h |    4 ++++
 arch/mips/mm/uasm.c          |    7 ++++++-
 3 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/inst.h b/arch/mips/include/asm/inst.h
index 444ff71..7ebfc39 100644
--- a/arch/mips/include/asm/inst.h
+++ b/arch/mips/include/asm/inst.h
@@ -72,6 +72,7 @@ enum spec2_op {
 enum spec3_op {
 	ext_op, dextm_op, dextu_op, dext_op,
 	ins_op, dinsm_op, dinsu_op, dins_op,
+	lx_op = 0x0a,
 	bshfl_op = 0x20,
 	dbshfl_op = 0x24,
 	rdhwr_op = 0x3b
@@ -179,6 +180,19 @@ enum mad_func {
 };
 
 /*
+ * func field for special3 lx opcodes (Cavium Octeon).
+ */
+enum lx_func {
+	lwx_op	= 0x00,
+	lhx_op	= 0x04,
+	lbux_op	= 0x06,
+	ldx_op	= 0x08,
+	lwux_op	= 0x10,
+	lhux_op	= 0x14,
+	lbx_op	= 0x16,
+};
+
+/*
  * Damn ...  bitfields depend from byteorder :-(
  */
 #ifdef __MIPSEB__
diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index d361df3..dcbd4bb 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -119,6 +119,8 @@ Ip_u2u1msbu3(_dinsm);
 Ip_u1(_syscall);
 Ip_u1u2s3(_bbit0);
 Ip_u1u2s3(_bbit1);
+Ip_u3u1u2(_lwx);
+Ip_u3u1u2(_ldx);
 
 /* Handle labels. */
 struct uasm_label {
@@ -156,6 +158,7 @@ static inline void __uasminit uasm_l##lb(struct uasm_label **lab, u32 *addr) \
 # define UASM_i_SUBU(buf, rs, rt, rd) uasm_i_dsubu(buf, rs, rt, rd)
 # define UASM_i_LL(buf, rs, rt, off) uasm_i_lld(buf, rs, rt, off)
 # define UASM_i_SC(buf, rs, rt, off) uasm_i_scd(buf, rs, rt, off)
+# define UASM_i_LWX(buf, rs, rt, rd) uasm_i_ldx(buf, rs, rt, rd)
 #else
 # define UASM_i_LW(buf, rs, rt, off) uasm_i_lw(buf, rs, rt, off)
 # define UASM_i_SW(buf, rs, rt, off) uasm_i_sw(buf, rs, rt, off)
@@ -170,6 +173,7 @@ static inline void __uasminit uasm_l##lb(struct uasm_label **lab, u32 *addr) \
 # define UASM_i_SUBU(buf, rs, rt, rd) uasm_i_subu(buf, rs, rt, rd)
 # define UASM_i_LL(buf, rs, rt, off) uasm_i_ll(buf, rs, rt, off)
 # define UASM_i_SC(buf, rs, rt, off) uasm_i_sc(buf, rs, rt, off)
+# define UASM_i_LWX(buf, rs, rt, rd) uasm_i_lwx(buf, rs, rt, rd)
 #endif
 
 #define uasm_i_b(buf, off) uasm_i_beq(buf, 0, 0, off)
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 99f0347..357916d 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -68,7 +68,8 @@ enum opcode {
 	insn_pref, insn_rfe, insn_sc, insn_scd, insn_sd, insn_sll,
 	insn_sra, insn_srl, insn_rotr, insn_subu, insn_sw, insn_tlbp,
 	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor, insn_xori,
-	insn_dins, insn_dinsm, insn_syscall, insn_bbit0, insn_bbit1
+	insn_dins, insn_dinsm, insn_syscall, insn_bbit0, insn_bbit1,
+	insn_lwx, insn_ldx
 };
 
 struct insn {
@@ -146,6 +147,8 @@ static struct insn insn_table[] __uasminitdata = {
 	{ insn_syscall, M(spec_op, 0, 0, 0, 0, syscall_op), SCIMM},
 	{ insn_bbit0, M(lwc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
 	{ insn_bbit1, M(swc2_op, 0, 0, 0, 0, 0), RS | RT | BIMM },
+	{ insn_lwx, M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD },
+	{ insn_ldx, M(spec3_op, 0, 0, 0, ldx_op, lx_op), RS | RT | RD },
 	{ insn_invalid, 0, 0 }
 };
 
@@ -434,6 +437,8 @@ I_u2u1msb32u3(_dinsm);
 I_u1(_syscall);
 I_u1u2s3(_bbit0);
 I_u1u2s3(_bbit1);
+I_u3u1u2(_lwx)
+I_u3u1u2(_ldx)
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
 #include <asm/octeon/octeon.h>
-- 
1.7.2.3
