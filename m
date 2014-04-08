Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 13:48:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:34306 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822511AbaDHLr1IjUT7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 13:47:27 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4749A86749974
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 12:47:15 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 8 Apr 2014 12:47:17 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 8 Apr 2014 12:47:16 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 05/14] MIPS: uasm: Add divu uasm instruction
Date:   Tue, 8 Apr 2014 12:47:06 +0100
Message-ID: <1396957635-27071-6-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396957635-27071-1-git-send-email-markos.chandras@imgtec.com>
References: <1396957635-27071-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39712
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

It will be used later on by bpf-jit

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/uasm.h      | 1 +
 arch/mips/include/uapi/asm/inst.h | 1 +
 arch/mips/mm/uasm-micromips.c     | 1 +
 arch/mips/mm/uasm-mips.c          | 1 +
 arch/mips/mm/uasm.c               | 3 ++-
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 5132f00..236b2db 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -105,6 +105,7 @@ Ip_u2u1s3(_daddiu);
 Ip_u3u1u2(_daddu);
 Ip_u2u1msbu3(_dins);
 Ip_u2u1msbu3(_dinsm);
+Ip_u1u2(_divu);
 Ip_u1u2u3(_dmfc0);
 Ip_u1u2u3(_dmtc0);
 Ip_u2u1u3(_drotr);
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 3f973a0..c28cae1 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -305,6 +305,7 @@ enum mm_32axf_minor_op {
 	mm_jalrshb_op = 0x17c,
 	mm_syscall_op = 0x22d,
 	mm_eret_op = 0x3cd,
+	mm_divu_op = 0x5dc,
 };
 
 /*
diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
index 97f4bfb..dc448be 100644
--- a/arch/mips/mm/uasm-micromips.c
+++ b/arch/mips/mm/uasm-micromips.c
@@ -63,6 +63,7 @@ static struct insn insn_table_MM[] = {
 	{ insn_cache, M(mm_pool32b_op, 0, 0, mm_cache_func, 0, 0), RT | RS | SIMM },
 	{ insn_daddu, 0, 0 },
 	{ insn_daddiu, 0, 0 },
+	{ insn_divu, M(mm_pool32a_op, 0, 0, 0, mm_divu_op, mm_pool32axf_op), RT | RS },
 	{ insn_dmfc0, 0, 0 },
 	{ insn_dmtc0, 0, 0 },
 	{ insn_dsll, 0, 0 },
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index 7bcc3b8..fe4be68 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -67,6 +67,7 @@ static struct insn insn_table[] = {
 	{ insn_daddu, M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD },
 	{ insn_dinsm, M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE },
 	{ insn_dins, M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE },
+	{ insn_divu, M(spec_op, 0, 0, 0, 0, divu_op), RS | RT },
 	{ insn_dmfc0, M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
 	{ insn_dmtc0, M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
 	{ insn_drotr32, M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE },
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 9d95c06..c2b7c4b 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -47,7 +47,7 @@ enum opcode {
 	insn_addiu, insn_addu, insn_and, insn_andi, insn_bbit0, insn_bbit1,
 	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
 	insn_bne, insn_cache, insn_daddiu, insn_daddu, insn_dins, insn_dinsm,
-	insn_dmfc0, insn_dmtc0, insn_drotr, insn_drotr32, insn_dsll,
+	insn_divu, insn_dmfc0, insn_dmtc0, insn_drotr, insn_drotr32, insn_dsll,
 	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret,
 	insn_ext, insn_ins, insn_j, insn_jal, insn_jr, insn_ld, insn_ldx,
 	insn_ll, insn_lld, insn_lui, insn_lw, insn_lwx, insn_mfc0, insn_mtc0,
@@ -251,6 +251,7 @@ I_u1u2u3(_dmfc0)
 I_u1u2u3(_dmtc0)
 I_u2u1s3(_daddiu)
 I_u3u1u2(_daddu)
+I_u1u2(_divu)
 I_u2u1u3(_dsll)
 I_u2u1u3(_dsll32)
 I_u2u1u3(_dsra)
-- 
1.9.1
