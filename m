Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 10:39:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36230 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6818481AbaFYIjufL30e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 10:39:50 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8429AE8CD27A;
        Wed, 25 Jun 2014 09:39:42 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 25 Jun 2014 09:39:43 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.28) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 25 Jun 2014 09:39:43 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Alexei Starovoitov" <ast@plumgrid.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 16/17] MIPS: bpf: Use 32 or 64-bit load instruction to load an address to register
Date:   Wed, 25 Jun 2014 09:39:38 +0100
Message-ID: <1403685578-25170-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <53AA85E8.5090403@imgtec.com>
References: <53AA85E8.5090403@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.28]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40794
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

When loading a pointer to register we need to use the appropriate
32 or 64bit instruction to preserve the pointers' top 32bits.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Daniel Borkmann <dborkman@redhat.com>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Changes since v1:
- Change function name to make it clear that we are loading a
pointer to a register, not an address
---
 arch/mips/net/bpf_jit.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 4505e2e6ab53..6e3963425b64 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -453,6 +453,17 @@ static inline void emit_wsbh(unsigned int dst, unsigned int src,
 	emit_instr(ctx, wsbh, dst, src);
 }
 
+/* load pointer to register */
+static inline void emit_load_ptr(unsigned int dst, unsigned int src,
+				     int imm, struct jit_ctx *ctx)
+{
+	/* src contains the base addr of the 32/64-pointer */
+	if (config_enabled(CONFIG_64BIT))
+		emit_instr(ctx, ld, dst, imm, src);
+	else
+		emit_instr(ctx, lw, dst, imm, src);
+}
+
 /* load a function pointer to register */
 static inline void emit_load_func(unsigned int reg, ptr imm,
 				  struct jit_ctx *ctx)
@@ -1277,7 +1288,8 @@ jmp_cmp:
 			/* A = skb->dev->ifindex */
 			ctx->flags |= SEEN_SKB | SEEN_A | SEEN_S0;
 			off = offsetof(struct sk_buff, dev);
-			emit_load(r_s0, r_skb, off, ctx);
+			/* Load *dev pointer */
+			emit_load_ptr(r_s0, r_skb, off, ctx);
 			/* error (0) in the delay slot */
 			emit_bcond(MIPS_COND_EQ, r_s0, r_zero,
 				   b_imm(prog->len, ctx), ctx);
-- 
2.0.0
