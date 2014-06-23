Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2014 11:44:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24416 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860010AbaFWJjpZMaCj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jun 2014 11:39:45 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B52795686274C;
        Mon, 23 Jun 2014 10:39:34 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Mon, 23 Jun
 2014 10:39:37 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 23 Jun 2014 10:39:36 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.28) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 23 Jun 2014 10:39:36 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Alexei Starovoitov" <ast@plumgrid.com>, <netdev@vger.kernel.org>
Subject: [PATCH 13/17] MIPS: bpf: Drop update_on_xread and always initialize the X register
Date:   Mon, 23 Jun 2014 10:38:56 +0100
Message-ID: <1403516340-22997-14-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 40670
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

Previously, update_on_xread() only set the reset flag if SEEN_X hasn't
been set already. However, SEEN_X is used to indicate that X is used
as destination or source register so there are some cases where X
is only used as source register and we really need to make sure that it
has been initialized in time. As a result of which, drop this function and
always set X to zero if it's used in any of the opcodes.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Daniel Borkmann <dborkman@redhat.com>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/net/bpf_jit.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 00c4c83972bb..1bcd599d9971 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -119,8 +119,6 @@
 /* Arguments used by JIT */
 #define ARGS_USED_BY_JIT	2 /* only applicable to 64-bit */
 
-#define FLAG_NEED_X_RESET	(1 << 0)
-
 #define SBIT(x)			(1 << (x)) /* Signed version of BIT() */
 
 /**
@@ -549,14 +547,6 @@ static inline u16 align_sp(unsigned int num)
 	return num;
 }
 
-static inline void update_on_xread(struct jit_ctx *ctx)
-{
-	if (!(ctx->flags & SEEN_X))
-		ctx->flags |= FLAG_NEED_X_RESET;
-
-	ctx->flags |= SEEN_X;
-}
-
 static bool is_load_to_a(u16 inst)
 {
 	switch (inst) {
@@ -701,7 +691,7 @@ static void build_prologue(struct jit_ctx *ctx)
 	if (ctx->flags & SEEN_SKB)
 		emit_reg_move(r_skb, MIPS_R_A0, ctx);
 
-	if (ctx->flags & FLAG_NEED_X_RESET)
+	if (ctx->flags & SEEN_X)
 		emit_jit_reg_move(r_X, r_zero, ctx);
 
 	/* Do not leak kernel data to userspace */
@@ -876,7 +866,6 @@ load_common:
 			/* A <- P[X + k:1] */
 			load_order = 0;
 load_ind:
-			update_on_xread(ctx);
 			ctx->flags |= SEEN_OFF | SEEN_X;
 			emit_addiu(r_off, r_X, k, ctx);
 			goto load_common;
@@ -972,7 +961,6 @@ load_ind:
 			break;
 		case BPF_ALU | BPF_MUL | BPF_X:
 			/* A *= X */
-			update_on_xread(ctx);
 			ctx->flags |= SEEN_A | SEEN_X;
 			emit_mul(r_A, r_A, r_X, ctx);
 			break;
@@ -1002,7 +990,6 @@ load_ind:
 			break;
 		case BPF_ALU | BPF_DIV | BPF_X:
 			/* A /= X */
-			update_on_xread(ctx);
 			ctx->flags |= SEEN_X | SEEN_A;
 			/* Check if r_X is zero */
 			emit_bcond(MIPS_COND_EQ, r_X, r_zero,
@@ -1012,7 +999,6 @@ load_ind:
 			break;
 		case BPF_ALU | BPF_MOD | BPF_X:
 			/* A %= X */
-			update_on_xread(ctx);
 			ctx->flags |= SEEN_X | SEEN_A;
 			/* Check if r_X is zero */
 			emit_bcond(MIPS_COND_EQ, r_X, r_zero,
@@ -1027,7 +1013,6 @@ load_ind:
 			break;
 		case BPF_ALU | BPF_OR | BPF_X:
 			/* A |= X */
-			update_on_xread(ctx);
 			ctx->flags |= SEEN_A;
 			emit_ori(r_A, r_A, r_X, ctx);
 			break;
@@ -1039,7 +1024,6 @@ load_ind:
 		case BPF_ANC | SKF_AD_ALU_XOR_X:
 		case BPF_ALU | BPF_XOR | BPF_X:
 			/* A ^= X */
-			update_on_xread(ctx);
 			ctx->flags |= SEEN_A;
 			emit_xor(r_A, r_A, r_X, ctx);
 			break;
@@ -1050,7 +1034,6 @@ load_ind:
 			break;
 		case BPF_ALU | BPF_AND | BPF_X:
 			/* A &= X */
-			update_on_xread(ctx);
 			ctx->flags |= SEEN_A | SEEN_X;
 			emit_and(r_A, r_A, r_X, ctx);
 			break;
@@ -1062,7 +1045,6 @@ load_ind:
 		case BPF_ALU | BPF_LSH | BPF_X:
 			/* A <<= X */
 			ctx->flags |= SEEN_A | SEEN_X;
-			update_on_xread(ctx);
 			emit_sllv(r_A, r_A, r_X, ctx);
 			break;
 		case BPF_ALU | BPF_RSH | BPF_K:
@@ -1072,7 +1054,6 @@ load_ind:
 			break;
 		case BPF_ALU | BPF_RSH | BPF_X:
 			ctx->flags |= SEEN_A | SEEN_X;
-			update_on_xread(ctx);
 			emit_srlv(r_A, r_A, r_X, ctx);
 			break;
 		case BPF_ALU | BPF_NEG:
@@ -1243,7 +1224,6 @@ jmp_cmp:
 		case BPF_MISC | BPF_TXA:
 			/* A = X */
 			ctx->flags |= SEEN_A | SEEN_X;
-			update_on_xread(ctx);
 			emit_jit_reg_move(r_A, r_X, ctx);
 			break;
 		/* AUX */
-- 
2.0.0
