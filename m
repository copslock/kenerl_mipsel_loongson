Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2014 11:40:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9338 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860005AbaFWJjeabdiQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jun 2014 11:39:34 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 01733BE10E8F3;
        Mon, 23 Jun 2014 10:39:25 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Mon, 23 Jun
 2014 10:39:27 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 23 Jun 2014 10:39:26 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.28) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 23 Jun 2014 10:39:26 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Alexei Starovoitov" <ast@plumgrid.com>, <netdev@vger.kernel.org>
Subject: [PATCH 05/17] MIPS: bpf: Return error code if the offset is a negative number
Date:   Mon, 23 Jun 2014 10:38:48 +0100
Message-ID: <1403516340-22997-6-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
References: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.28]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40660
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

Previously, the negative offset was not checked leading to failures
due to trying to load data beyond the skb struct boundaries. Until we
have proper asm helpers in place, it's best if we return ENOSUPP if K
is negative when trying to JIT the filter or 0 during runtime if we
do an indirect load where the value of X is unknown during build time.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Daniel Borkmann <dborkman@redhat.com>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/net/bpf_jit.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 5cc92c4590cb..95728ea6cb74 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -331,6 +331,12 @@ static inline void emit_srl(unsigned int dst, unsigned int src,
 	emit_instr(ctx, srl, dst, src, sa);
 }
 
+static inline void emit_slt(unsigned int dst, unsigned int src1,
+			    unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, slt, dst, src1, src2);
+}
+
 static inline void emit_sltu(unsigned int dst, unsigned int src1,
 			     unsigned int src2, struct jit_ctx *ctx)
 {
@@ -816,8 +822,21 @@ static int build_body(struct jit_ctx *ctx)
 			/* A <- P[k:1] */
 			load_order = 0;
 load:
+			/* the interpreter will deal with the negative K */
+			if ((int)k < 0)
+				return -ENOTSUPP;
+
 			emit_load_imm(r_off, k, ctx);
 load_common:
+			/*
+			 * We may got here from the indirect loads so
+			 * return if offset is negative.
+			 */
+			emit_slt(r_s0, r_off, r_zero, ctx);
+			emit_bcond(MIPS_COND_NE, r_s0, r_zero,
+				   b_imm(prog->len, ctx), ctx);
+			emit_reg_move(r_ret, r_zero, ctx);
+
 			ctx->flags |= SEEN_CALL | SEEN_OFF | SEEN_S0 |
 				SEEN_SKB | SEEN_A;
 
@@ -880,6 +899,10 @@ load_ind:
 			emit_load(r_X, r_skb, off, ctx);
 			break;
 		case BPF_LDX | BPF_B | BPF_MSH:
+			/* the interpreter will deal with the negative K */
+			if ((int)k < 0)
+				return -ENOTSUPP;
+
 			/* X <- 4 * (P[k:1] & 0xf) */
 			ctx->flags |= SEEN_X | SEEN_CALL | SEEN_S0 | SEEN_SKB;
 			/* Load offset to a1 */
-- 
2.0.0
