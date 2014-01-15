Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jan 2014 15:01:40 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:38396 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827435AbaAOOAwJKgYI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Jan 2014 15:00:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 06/10] MIPS: uasm: add mftc0 & mttc0 instructions
Date:   Wed, 15 Jan 2014 13:55:33 +0000
Message-ID: <1389794137-11361-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2014_01_15_14_00_47
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39007
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

This patch allows use of mftc0 & mttc0 instructions from uasm, in order
to access the cop0 registers of another TC within the core. It will be
used by a subsequent patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/uasm.h      |  2 ++
 arch/mips/include/uapi/asm/inst.h |  3 ++-
 arch/mips/mm/uasm-mips.c          |  2 ++
 arch/mips/mm/uasm.c               | 10 ++++++----
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 2d9cedd..86c3535 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -124,7 +124,9 @@ Ip_u1s2(_lui);
 Ip_u2s3u1(_lw);
 Ip_u3u1u2(_lwx);
 Ip_u1u2u3(_mfc0);
+Ip_u2u1u3(_mftc0);
 Ip_u1u2u3(_mtc0);
+Ip_u1u2u3(_mttc0);
 Ip_u3u1u2(_or);
 Ip_u2u1u3(_ori);
 Ip_u2s3u1(_pref);
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index e19d63e..757f472 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -101,7 +101,8 @@ enum cop_op {
 	cfc_op	      = 0x02, mfhc_op	    = 0x03,
 	mtc_op        = 0x04, dmtc_op	    = 0x05,
 	ctc_op	      = 0x06, mthc_op	    = 0x07,
-	bc_op	      = 0x08, cop_op	    = 0x10,
+	bc_op	      = 0x08, mftr_op	    = 0x08,
+	mttr_op	      = 0x0c, cop_op	    = 0x10,
 	copm_op	      = 0x18
 };
 
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 46ca072..814265f 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -94,7 +94,9 @@ static struct insn insn_table[] = {
 	{ insn_lw,  M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
 	{ insn_lwx, M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD },
 	{ insn_mfc0,  M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
+	{ insn_mftc0,  M(cop0_op, mftr_op, 0, 0, 0, 0),  RT | RD | SET},
 	{ insn_mtc0,  M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
+	{ insn_mttc0,  M(cop0_op, mttr_op, 0, 0, 0, 0),  RT | RD | SET},
 	{ insn_ori,  M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM },
 	{ insn_or,  M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD },
 	{ insn_pref,  M(pref_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index f725309..99cb34b 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -51,10 +51,10 @@ enum opcode {
 	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret,
 	insn_ext, insn_ins, insn_j, insn_jal, insn_jr, insn_jr_hb, insn_ld,
 	insn_ldx, insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0,
-	insn_mtc0, insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sc,
-	insn_scd, insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw,
-	insn_sync, insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr,
-	insn_wait, insn_xor, insn_xori,
+	insn_mftc0, insn_mtc0, insn_mttc0, insn_or, insn_ori, insn_pref,
+	insn_rfe, insn_rotr, insn_sc, insn_scd, insn_sd, insn_sll, insn_sra,
+	insn_srl, insn_subu, insn_sw, insn_sync, insn_syscall, insn_tlbp,
+	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_xor, insn_xori,
 };
 
 struct insn {
@@ -258,7 +258,9 @@ I_u2s3u1(_lld)
 I_u1s2(_lui)
 I_u2s3u1(_lw)
 I_u1u2u3(_mfc0)
+I_u2u1u3(_mftc0)
 I_u1u2u3(_mtc0)
+I_u1u2u3(_mttc0)
 I_u2u1u3(_ori)
 I_u3u1u2(_or)
 I_0(_rfe)
-- 
1.8.4.2
