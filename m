Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 12:57:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10780 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008186AbbFDK4nt-UIN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 12:56:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4DE3276C5F172;
        Thu,  4 Jun 2015 11:56:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 4 Jun 2015 11:56:37 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 4 Jun 2015 11:56:37 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Hannes Frederic Sowa" <hannes@stressinduktion.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] MIPS: net: BPF: Replace RSIZE with SZREG
Date:   Thu, 4 Jun 2015 11:56:12 +0100
Message-ID: <1433415376-20952-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433415376-20952-1-git-send-email-markos.chandras@imgtec.com>
References: <1433415376-20952-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47851
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

The RSZIE was used to determine the register width but MIPS
already defines SZREG so use that instead.

Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Cc: Daniel Borkmann <dborkman@redhat.com>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/net/bpf_jit.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 850b08ee3fab..56e0e8e9674d 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -20,6 +20,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <asm/asm.h>
 #include <asm/bitops.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu-features.h>
@@ -60,7 +61,6 @@
  * ----------------------------------------------------
  */
 
-#define RSIZE	(sizeof(unsigned long))
 #define ptr typeof(unsigned long)
 
 /* ABI specific return values */
@@ -576,12 +576,12 @@ static void save_bpf_jit_regs(struct jit_ctx *ctx, unsigned offset)
 		/* Argument save area */
 		if (config_enabled(CONFIG_64BIT))
 			/* Bottom of current frame */
-			real_off = align_sp(offset) - RSIZE;
+			real_off = align_sp(offset) - SZREG;
 		else
 			/* Top of previous frame */
-			real_off = align_sp(offset) + RSIZE;
+			real_off = align_sp(offset) + SZREG;
 		emit_store_stack_reg(MIPS_R_A0, r_sp, real_off, ctx);
-		emit_store_stack_reg(MIPS_R_A1, r_sp, real_off + RSIZE, ctx);
+		emit_store_stack_reg(MIPS_R_A1, r_sp, real_off + SZREG, ctx);
 
 		real_off = 0;
 	}
@@ -592,7 +592,7 @@ static void save_bpf_jit_regs(struct jit_ctx *ctx, unsigned offset)
 		if ((sflags >> i) & 0x1) {
 			emit_store_stack_reg(MIPS_R_S0 + i, r_sp, real_off,
 					     ctx);
-			real_off += RSIZE;
+			real_off += SZREG;
 		}
 		i++;
 		tmp_flags >>= 1;
@@ -601,13 +601,13 @@ static void save_bpf_jit_regs(struct jit_ctx *ctx, unsigned offset)
 	/* save return address */
 	if (ctx->flags & SEEN_CALL) {
 		emit_store_stack_reg(r_ra, r_sp, real_off, ctx);
-		real_off += RSIZE;
+		real_off += SZREG;
 	}
 
 	/* Setup r_M leaving the alignment gap if necessary */
 	if (ctx->flags & SEEN_MEM) {
-		if (real_off % (RSIZE * 2))
-			real_off += RSIZE;
+		if (real_off % (SZREG * 2))
+			real_off += SZREG;
 		emit_long_instr(ctx, ADDIU, r_M, r_sp, real_off);
 	}
 }
@@ -621,12 +621,12 @@ static void restore_bpf_jit_regs(struct jit_ctx *ctx,
 	if (ctx->flags & SEEN_CALL) {
 		if (config_enabled(CONFIG_64BIT))
 			/* Bottom of current frame */
-			real_off = align_sp(offset) - RSIZE;
+			real_off = align_sp(offset) - SZREG;
 		else
 			/* Top of previous frame */
-			real_off = align_sp(offset) + RSIZE;
+			real_off = align_sp(offset) + SZREG;
 		emit_load_stack_reg(MIPS_R_A0, r_sp, real_off, ctx);
-		emit_load_stack_reg(MIPS_R_A1, r_sp, real_off + RSIZE, ctx);
+		emit_load_stack_reg(MIPS_R_A1, r_sp, real_off + SZREG, ctx);
 
 		real_off = 0;
 	}
@@ -638,7 +638,7 @@ static void restore_bpf_jit_regs(struct jit_ctx *ctx,
 		if ((sflags >> i) & 0x1) {
 			emit_load_stack_reg(MIPS_R_S0 + i, r_sp, real_off,
 					    ctx);
-			real_off += RSIZE;
+			real_off += SZREG;
 		}
 		i++;
 		tmp_flags >>= 1;
@@ -658,7 +658,7 @@ static unsigned int get_stack_depth(struct jit_ctx *ctx)
 
 
 	/* How may s* regs do we need to preserved? */
-	sp_off += hweight32(ctx->flags >> SEEN_SREG_SFT) * RSIZE;
+	sp_off += hweight32(ctx->flags >> SEEN_SREG_SFT) * SZREG;
 
 	if (ctx->flags & SEEN_MEM)
 		sp_off += 4 * BPF_MEMWORDS; /* BPF_MEMWORDS are 32-bit */
@@ -674,13 +674,13 @@ static unsigned int get_stack_depth(struct jit_ctx *ctx)
 		 * this space ourselves. We need to preserve $ra as well.
 		 */
 		sp_off += config_enabled(CONFIG_64BIT) ?
-			(ARGS_USED_BY_JIT + 1) * RSIZE : RSIZE;
+			(ARGS_USED_BY_JIT + 1) * SZREG : SZREG;
 
 	/*
 	 * Subtract the bytes for the last registers since we only care about
 	 * the location on the stack pointer.
 	 */
-	return sp_off - RSIZE;
+	return sp_off - SZREG;
 }
 
 static void build_prologue(struct jit_ctx *ctx)
-- 
2.4.2
