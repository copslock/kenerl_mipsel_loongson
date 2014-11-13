Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 07:06:52 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:33761 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012569AbaKMGGAEcojL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 07:06:00 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1XonXV-0007Qu-E1; Thu, 13 Nov 2014 00:05:53 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 09/11] MIPS: Add MFHC0 and MTHC0 instructions to uasm.
Date:   Thu, 13 Nov 2014 00:05:41 -0600
Message-Id: <1415858743-24492-10-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1415858743-24492-1-git-send-email-Steven.Hill@imgtec.com>
References: <1415858743-24492-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

New instructions for Extended Physical Addressing (XPA) functionality.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/uasm.h      |    2 ++
 arch/mips/include/uapi/asm/inst.h |    7 ++++---
 arch/mips/mm/uasm-mips.c          |    2 ++
 arch/mips/mm/uasm.c               |   14 ++++++++------
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 708c5d4..fc1cdd2 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -136,9 +136,11 @@ Ip_u1s2(_lui);
 Ip_u2s3u1(_lw);
 Ip_u3u1u2(_lwx);
 Ip_u1u2u3(_mfc0);
+Ip_u1u2u3(_mfhc0);
 Ip_u1(_mfhi);
 Ip_u1(_mflo);
 Ip_u1u2u3(_mtc0);
+Ip_u1u2u3(_mthc0);
 Ip_u3u1u2(_mul);
 Ip_u3u1u2(_or);
 Ip_u2u1u3(_ori);
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 4bfdb9d..89c2243 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -108,9 +108,10 @@ enum rt_op {
  */
 enum cop_op {
 	mfc_op	      = 0x00, dmfc_op	    = 0x01,
-	cfc_op	      = 0x02, mfhc_op	    = 0x03,
-	mtc_op        = 0x04, dmtc_op	    = 0x05,
-	ctc_op	      = 0x06, mthc_op	    = 0x07,
+	cfc_op	      = 0x02, mfhc0_op	    = 0x02,
+	mfhc_op       = 0x03, mtc_op	    = 0x04,
+	dmtc_op	      = 0x05, ctc_op	    = 0x06,
+	mthc0_op      = 0x06, mthc_op	    = 0x07,
 	bc_op	      = 0x08, cop_op	    = 0x10,
 	copm_op	      = 0x18
 };
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 6708a2d..8e02291 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -96,9 +96,11 @@ static struct insn insn_table[] = {
 	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_lwx, M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD },
 	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
+	{ insn_mfhc0,  M(cop0_op, mfhc0_op, 0, 0, 0, 0),  RT | RD | SET},
 	{ insn_mfhi,  M(spec_op, 0, 0, 0, 0, mfhi_op), RD },
 	{ insn_mflo,  M(spec_op, 0, 0, 0, 0, mflo_op), RD },
 	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
+	{ insn_mthc0,  M(cop0_op, mthc0_op, 0, 0, 0, 0),  RT | RD | SET},
 	{ insn_mul, M(spec2_op, 0, 0, 0, 0, mul_op), RS | RT | RD},
 	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM },
 	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index a01b0d6..4adf302 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -51,12 +51,12 @@ enum opcode {
 	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret,
 	insn_ext, insn_ins, insn_j, insn_jal, insn_jalr, insn_jr, insn_lb,
 	insn_ld, insn_ldx, insn_lh, insn_ll, insn_lld, insn_lui, insn_lw,
-	insn_lwx, insn_mfc0, insn_mfhi, insn_mflo, insn_mtc0, insn_mul,
-	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd,
-	insn_sd, insn_sll, insn_sllv, insn_slt, insn_sltiu, insn_sltu, insn_sra,
-	insn_srl, insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall,
-	insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh,
-	insn_xor, insn_xori, insn_yield,
+	insn_lwx, insn_mfc0, insn_mfhc0, insn_mfhi, insn_mflo, insn_mtc0,
+	insn_mthc0, insn_mul, insn_or, insn_ori, insn_pref, insn_rfe,
+	insn_rotr, insn_sc, insn_scd, insn_sd, insn_sll, insn_sllv, insn_slt,
+	insn_sltiu, insn_sltu, insn_sra, insn_srl, insn_srlv, insn_subu,
+	insn_sw, insn_sync, insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi,
+	insn_tlbwr, insn_wait, insn_wsbh, insn_xor, insn_xori, insn_yield,
 };
 
 struct insn {
@@ -284,9 +284,11 @@ I_u2s3u1(_lld)
 I_u1s2(_lui)
 I_u2s3u1(_lw)
 I_u1u2u3(_mfc0)
+I_u1u2u3(_mfhc0)
 I_u1(_mfhi)
 I_u1(_mflo)
 I_u1u2u3(_mtc0)
+I_u1u2u3(_mthc0)
 I_u3u1u2(_mul)
 I_u2u1u3(_ori)
 I_u3u1u2(_or)
-- 
1.7.10.4
