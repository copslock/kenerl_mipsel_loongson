Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 15:02:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:34035 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837153AbaDPNAimsfOc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 15:00:38 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 16C2F35C78A87
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 14:00:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 14:00:31 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 14:00:30 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 22/39] MIPS: uasm: add jalr instruction
Date:   Wed, 16 Apr 2014 13:53:13 +0100
Message-ID: <1397652810-4336-23-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39829
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

This patch allows use of the jalr instruction from uasm. It will be used
by a subsequent patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/uasm.h | 4 ++++
 arch/mips/mm/uasm-mips.c     | 1 +
 arch/mips/mm/uasm.c          | 9 +++++----
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index d1275a2..a3d88ae 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -74,6 +74,9 @@ void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c, \
 #define Ip_u1u2(op)							\
 void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b)
 
+#define Ip_u2u1(op)							\
+void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b)
+
 #define Ip_u1s2(op)							\
 void ISAOPC(op)(u32 **buf, unsigned int a, signed int b)
 
@@ -114,6 +117,7 @@ Ip_u2u1msbu3(_ext);
 Ip_u2u1msbu3(_ins);
 Ip_u1(_j);
 Ip_u1(_jal);
+Ip_u2u1(_jalr);
 Ip_u1(_jr);
 Ip_u2s3u1(_ld);
 Ip_u3u1u2(_ldx);
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 3abd609..45e3dc5 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -82,6 +82,7 @@ static struct insn insn_table[] = {
 	{ insn_ins, M(spec3_op, 0, 0, 0, 0, ins_op), RS | RT | RD | RE },
 	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
 	{ insn_jal,  M(jal_op, 0, 0, 0, 0, 0),	JIMM },
+	{ insn_jalr,  M(spec_op, 0, 0, 0, 0, jalr_op), RS | RD },
 	{ insn_j,  M(j_op, 0, 0, 0, 0, 0),  JIMM },
 	{ insn_jr,  M(spec_op, 0, 0, 0, 0, jr_op),  RS },
 	{ insn_ld,  M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index ae18b82..a77a4b8 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -49,10 +49,10 @@ enum opcode {
 	insn_bne, insn_cache, insn_daddiu, insn_daddu, insn_dins, insn_dinsm,
 	insn_dmfc0, insn_dmtc0, insn_drotr, insn_drotr32, insn_dsll,
 	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret,
-	insn_ext, insn_ins, insn_j, insn_jal, insn_jr, insn_ld, insn_ldx,
-	insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0, insn_mtc0,
-	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd,
-	insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw,
+	insn_ext, insn_ins, insn_j, insn_jal, insn_jalr, insn_jr, insn_ld,
+	insn_ldx, insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0,
+	insn_mtc0, insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sc,
+	insn_scd, insn_sd, insn_sll, insn_sra, insn_srl, insn_subu, insn_sw,
 	insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_xor,
 	insn_xori,
 };
@@ -250,6 +250,7 @@ I_u2u1msbdu3(_ext)
 I_u2u1msbu3(_ins)
 I_u1(_j)
 I_u1(_jal)
+I_u2u1(_jalr)
 I_u1(_jr)
 I_u2s3u1(_ld)
 I_u2s3u1(_ll)
-- 
1.8.5.3
