Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 10:37:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29232 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816503AbaFYIhiPH0Rh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 10:37:38 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2A3DE78A7A3FE;
        Wed, 25 Jun 2014 09:37:30 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 25 Jun 2014 09:37:31 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.28) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 25 Jun 2014 09:37:30 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Alexei Starovoitov" <ast@plumgrid.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 14/17] MIPS: bpf: Prevent kernel fall over for >=32bit shifts
Date:   Wed, 25 Jun 2014 09:37:21 +0100
Message-ID: <1403685441-4858-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <53A811FA.5060502@imgtec.com>
References: <53A811FA.5060502@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.28]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40793
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

Remove BUG_ON() if the shift immediate is >=32 to avoid kernel crashes
due to malicious user input. If the shift immediate is >= 32,
we simply load the destination register with 0 since only
32-bit instructions are used by JIT so this will do the
correct thing even on MIPS64.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Daniel Borkmann <dborkman@redhat.com>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Changes since v1:
- For sa >=32, load destination register with zero instead of treating
the immediate as 31
---
 arch/mips/net/bpf_jit.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 1bcd599d9971..9476e7f061a1 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -151,6 +151,8 @@ static inline int optimize_div(u32 *k)
 	return 0;
 }
 
+static inline void emit_jit_reg_move(ptr dst, ptr src, struct jit_ctx *ctx);
+
 /* Simply emit the instruction if the JIT memory space has been allocated */
 #define emit_instr(ctx, func, ...)			\
 do {							\
@@ -309,8 +311,11 @@ static inline void emit_sll(unsigned int dst, unsigned int src,
 			    unsigned int sa, struct jit_ctx *ctx)
 {
 	/* sa is 5-bits long */
-	BUG_ON(sa >= BIT(5));
-	emit_instr(ctx, sll, dst, src, sa);
+	if (sa >= BIT(5))
+		/* Shifting >= 32 results in zero */
+		emit_jit_reg_move(dst, r_zero, ctx);
+	else
+		emit_instr(ctx, sll, dst, src, sa);
 }
 
 static inline void emit_srlv(unsigned int dst, unsigned int src,
@@ -323,8 +328,11 @@ static inline void emit_srl(unsigned int dst, unsigned int src,
 			    unsigned int sa, struct jit_ctx *ctx)
 {
 	/* sa is 5-bits long */
-	BUG_ON(sa >= BIT(5));
-	emit_instr(ctx, srl, dst, src, sa);
+	if (sa >= BIT(5))
+		/* Shifting >= 32 results in zero */
+		emit_jit_reg_move(dst, r_zero, ctx);
+	else
+		emit_instr(ctx, srl, dst, src, sa);
 }
 
 static inline void emit_slt(unsigned int dst, unsigned int src1,
-- 
2.0.0
