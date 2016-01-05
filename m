Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 16:23:45 +0100 (CET)
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35881 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009632AbcAEPXneKc0k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Jan 2016 16:23:43 +0100
Received: by mail-wm0-f48.google.com with SMTP id l65so26818366wmf.1
        for <linux-mips@linux-mips.org>; Tue, 05 Jan 2016 07:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=bd/9uNMBRUpJljqyqwuxaLklXzQSDPlLuVVQFBV0gLA=;
        b=Cymk3XPb7oS3fxCfCnQPwH2dE7skgZLKIOXP6i0TtpBpidL88TPh25Su9YfV4lIxPx
         LGfcBxeNIa/8wEvhwVSyOGN+PjCHBWCf0FoqbozoRFNyFZBfnrw2if/BNlWXmPKDCo9p
         6UA2bzueagG8T+EhOId91/cbgTvCS57jnN/yTfCKMuNaqOYQAs3i2UyuZawUXw6hGbnh
         2XOhptVJ+iU29kXkYLyj5cVde9fU2FcDnWSqrVsofQmNQpTr4uA/p6Y438pPlHfhcD5V
         4FIsj4zC9aL66etCo7pYwe59qON+Yt2gobU4uWhlxL4dzp0zm9O1bpkVRNB4Cu+FvBLp
         u5AQ==
X-Received: by 10.194.88.73 with SMTP id be9mr100133201wjb.44.1452007418304;
        Tue, 05 Jan 2016 07:23:38 -0800 (PST)
Received: from localhost.localdomain (h249n21-ld-c-a31.ias.bredband.telia.com. [78.70.84.249])
        by smtp.gmail.com with ESMTPSA id r4sm3820803wjy.39.2016.01.05.07.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 07:23:37 -0800 (PST)
From:   Rabin Vincent <rabin@rab.in>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rabin Vincent <rabin@rab.in>
Subject: [PATCH] net: filter: make JITs zero A for SKF_AD_ALU_XOR_X
Date:   Tue,  5 Jan 2016 16:23:07 +0100
Message-Id: <1452007387-626-1-git-send-email-rabin@rab.in>
X-Mailer: git-send-email 2.6.4
Return-Path: <rabin.vincent@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rabin@rab.in
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

The SKF_AD_ALU_XOR_X ancillary is not like the other ancillary data
instructions since it XORs A with X while all the others replace A with
some loaded value.  All the BPF JITs fail to clear A if this is used as
the first instruction in a filter.  This was found using american fuzzy
lop.

Add a helper to determine if A needs to be cleared given the first
instruction in a filter, and use this in the JITs.  Except for ARM, the
rest have only been compile-tested.

Fixes: 3480593131e0 ("net: filter: get rid of BPF_S_* enum")
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/net/bpf_jit_32.c       | 16 +---------------
 arch/mips/net/bpf_jit.c         | 16 +---------------
 arch/powerpc/net/bpf_jit_comp.c | 13 ++-----------
 arch/sparc/net/bpf_jit_comp.c   | 17 ++---------------
 include/linux/filter.h          | 19 +++++++++++++++++++
 5 files changed, 25 insertions(+), 56 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 591f9db3bf40..e153eb065fe4 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -187,19 +187,6 @@ static inline int mem_words_used(struct jit_ctx *ctx)
 	return fls(ctx->seen & SEEN_MEM);
 }
 
-static inline bool is_load_to_a(u16 inst)
-{
-	switch (inst) {
-	case BPF_LD | BPF_W | BPF_LEN:
-	case BPF_LD | BPF_W | BPF_ABS:
-	case BPF_LD | BPF_H | BPF_ABS:
-	case BPF_LD | BPF_B | BPF_ABS:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static void jit_fill_hole(void *area, unsigned int size)
 {
 	u32 *ptr;
@@ -211,7 +198,6 @@ static void jit_fill_hole(void *area, unsigned int size)
 static void build_prologue(struct jit_ctx *ctx)
 {
 	u16 reg_set = saved_regs(ctx);
-	u16 first_inst = ctx->skf->insns[0].code;
 	u16 off;
 
 #ifdef CONFIG_FRAME_POINTER
@@ -241,7 +227,7 @@ static void build_prologue(struct jit_ctx *ctx)
 		emit(ARM_MOV_I(r_X, 0), ctx);
 
 	/* do not leak kernel data to userspace */
-	if ((first_inst != (BPF_RET | BPF_K)) && !(is_load_to_a(first_inst)))
+	if (bpf_needs_clear_a(&ctx->skf->insns[0]))
 		emit(ARM_MOV_I(r_A, 0), ctx);
 
 	/* stack space for the BPF_MEM words */
diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 77cb27309db2..1a8c96035716 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -521,19 +521,6 @@ static inline u16 align_sp(unsigned int num)
 	return num;
 }
 
-static bool is_load_to_a(u16 inst)
-{
-	switch (inst) {
-	case BPF_LD | BPF_W | BPF_LEN:
-	case BPF_LD | BPF_W | BPF_ABS:
-	case BPF_LD | BPF_H | BPF_ABS:
-	case BPF_LD | BPF_B | BPF_ABS:
-		return true;
-	default:
-		return false;
-	}
-}
-
 static void save_bpf_jit_regs(struct jit_ctx *ctx, unsigned offset)
 {
 	int i = 0, real_off = 0;
@@ -614,7 +601,6 @@ static unsigned int get_stack_depth(struct jit_ctx *ctx)
 
 static void build_prologue(struct jit_ctx *ctx)
 {
-	u16 first_inst = ctx->skf->insns[0].code;
 	int sp_off;
 
 	/* Calculate the total offset for the stack pointer */
@@ -641,7 +627,7 @@ static void build_prologue(struct jit_ctx *ctx)
 		emit_jit_reg_move(r_X, r_zero, ctx);
 
 	/* Do not leak kernel data to userspace */
-	if ((first_inst != (BPF_RET | BPF_K)) && !(is_load_to_a(first_inst)))
+	if (bpf_needs_clear_a(&ctx->skf->insns[0]))
 		emit_jit_reg_move(r_A, r_zero, ctx);
 }
 
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 04782164ee67..2d66a8446198 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -78,18 +78,9 @@ static void bpf_jit_build_prologue(struct bpf_prog *fp, u32 *image,
 		PPC_LI(r_X, 0);
 	}
 
-	switch (filter[0].code) {
-	case BPF_RET | BPF_K:
-	case BPF_LD | BPF_W | BPF_LEN:
-	case BPF_LD | BPF_W | BPF_ABS:
-	case BPF_LD | BPF_H | BPF_ABS:
-	case BPF_LD | BPF_B | BPF_ABS:
-		/* first instruction sets A register (or is RET 'constant') */
-		break;
-	default:
-		/* make sure we dont leak kernel information to user */
+	/* make sure we dont leak kernel information to user */
+	if (bpf_needs_clear_a(&filter[0]))
 		PPC_LI(r_A, 0);
-	}
 }
 
 static void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
diff --git a/arch/sparc/net/bpf_jit_comp.c b/arch/sparc/net/bpf_jit_comp.c
index 22564f5f2364..3e6e05a7c4c2 100644
--- a/arch/sparc/net/bpf_jit_comp.c
+++ b/arch/sparc/net/bpf_jit_comp.c
@@ -420,22 +420,9 @@ void bpf_jit_compile(struct bpf_prog *fp)
 		}
 		emit_reg_move(O7, r_saved_O7);
 
-		switch (filter[0].code) {
-		case BPF_RET | BPF_K:
-		case BPF_LD | BPF_W | BPF_LEN:
-		case BPF_LD | BPF_W | BPF_ABS:
-		case BPF_LD | BPF_H | BPF_ABS:
-		case BPF_LD | BPF_B | BPF_ABS:
-			/* The first instruction sets the A register (or is
-			 * a "RET 'constant'")
-			 */
-			break;
-		default:
-			/* Make sure we dont leak kernel information to the
-			 * user.
-			 */
+		/* Make sure we dont leak kernel information to the user. */
+		if (bpf_needs_clear_a(&filter[0]))
 			emit_clear(r_A); /* A = 0 */
-		}
 
 		for (i = 0; i < flen; i++) {
 			unsigned int K = filter[i].k;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4165e9ac9e36..5972ffe5719a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -493,6 +493,25 @@ static inline void bpf_jit_free(struct bpf_prog *fp)
 
 #define BPF_ANC		BIT(15)
 
+static inline bool bpf_needs_clear_a(const struct sock_filter *first)
+{
+	switch (first->code) {
+	case BPF_RET | BPF_K:
+	case BPF_LD | BPF_W | BPF_LEN:
+		return false;
+
+	case BPF_LD | BPF_W | BPF_ABS:
+	case BPF_LD | BPF_H | BPF_ABS:
+	case BPF_LD | BPF_B | BPF_ABS:
+		if (first->k == SKF_AD_OFF + SKF_AD_ALU_XOR_X)
+			return true;
+		return false;
+
+	default:
+		return true;
+	}
+}
+
 static inline u16 bpf_anc_helper(const struct sock_filter *ftest)
 {
 	BUG_ON(ftest->code & BPF_ANC);
-- 
2.6.4
