Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2014 16:50:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:56574 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822429AbaDXOuuRieVq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Apr 2014 16:50:50 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A3EA9E3E49B8;
        Thu, 24 Apr 2014 15:50:40 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 24 Apr
 2014 15:50:42 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 24 Apr 2014 15:50:41 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.57) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 24 Apr 2014 15:50:41 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: [PATCH v3 13/14] MIPS: net: Add BPF JIT
Date:   Thu, 24 Apr 2014 15:50:13 +0100
Message-ID: <1398351013-29490-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.2
In-Reply-To: <1396957635-27071-14-git-send-email-markos.chandras@imgtec.com>
References: <1396957635-27071-14-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.57]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39918
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

This adds initial support for BPF-JIT on MIPS

Tested on mips32 LE/BE and mips64 BE/n64 using
dhcp, ping and various tcpdump filters.

Benchmarking:

Assuming the remote MIPS target uses 192.168.154.181
as its IP address, and the local host uses 192.168.154.136,
the following results can be obtained using the following
tcpdump filter (catches no frames) and a simple
'time ping -f -c 1000000' command.

[root@(none) ~]# tcpdump -p -n -s 0 -i eth0 net 10.0.0.0/24 -d
(000) ldh      [12]
(001) jeq      #0x800           jt 2	jf 8
(002) ld       [26]
(003) and      #0xffffff00
(004) jeq      #0xa000000       jt 16	jf 5
(005) ld       [30]
(006) and      #0xffffff00
(007) jeq      #0xa000000       jt 16	jf 17
(008) jeq      #0x806           jt 10	jf 9
(009) jeq      #0x8035          jt 10	jf 17
(010) ld       [28]
(011) and      #0xffffff00
(012) jeq      #0xa000000       jt 16	jf 13
(013) ld       [38]
(014) and      #0xffffff00
(015) jeq      #0xa000000       jt 16	jf 17
(016) ret      #65535

- BPF-JIT Disabled

real    1m38.005s
user    0m1.510s
sys     0m6.710s

- BPF-JIT Enabled

real    1m35.215s
user    0m1.200s
sys     0m4.140s

Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Changes since v2
- Use cpu_has_mips_r1 instead of CONFIG_CPU_MIPSR1 for runtime MIPS32/64 R1 detection
- Implement missing opcodes
- Remove a few pr_debug statements
- A bit of clean up
---
 arch/mips/Kbuild        |    1 +
 arch/mips/net/Makefile  |    3 +
 arch/mips/net/bpf_jit.c | 1399 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/net/bpf_jit.h |   44 ++
 4 files changed, 1447 insertions(+)
 create mode 100644 arch/mips/net/Makefile
 create mode 100644 arch/mips/net/bpf_jit.c
 create mode 100644 arch/mips/net/bpf_jit.h

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index d2cfe45..9179336 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -17,6 +17,7 @@ obj- := $(platform-)
 obj-y += kernel/
 obj-y += mm/
 obj-y += math-emu/
+obj-y += net/
 
 ifdef CONFIG_KVM
 obj-y += kvm/
diff --git a/arch/mips/net/Makefile b/arch/mips/net/Makefile
new file mode 100644
index 0000000..ae74b3a
--- /dev/null
+++ b/arch/mips/net/Makefile
@@ -0,0 +1,3 @@
+# MIPS networking code
+
+obj-$(CONFIG_BPF_JIT) += bpf_jit.o
diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
new file mode 100644
index 0000000..864e5b7
--- /dev/null
+++ b/arch/mips/net/bpf_jit.c
@@ -0,0 +1,1399 @@
+/*
+ * Just-In-Time compiler for BPF filters on MIPS
+ *
+ * Copyright (c) 2014 Imagination Technologies Ltd.
+ * Author: Markos Chandras <markos.chandras@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/filter.h>
+#include <linux/if_vlan.h>
+#include <linux/kconfig.h>
+#include <linux/moduleloader.h>
+#include <linux/netdevice.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <asm/bitops.h>
+#include <asm/cacheflush.h>
+#include <asm/cpu-features.h>
+#include <asm/uasm.h>
+
+#include "bpf_jit.h"
+
+/* ABI
+ *
+ * s0	1st scratch register
+ * s1	2nd scratch register
+ * s2	offset register
+ * s3	BPF register A
+ * s4	BPF register X
+ * s5	*skb
+ * s6	*scratch memory
+ *
+ * On entry (*bpf_func)(*skb, *filter)
+ * a0 = MIPS_R_A0 = skb;
+ * a1 = MIPS_R_A1 = filter;
+ *
+ * Stack
+ * ...
+ * M[15]
+ * M[14]
+ * M[13]
+ * ...
+ * M[0] <-- r_M
+ * saved reg k-1
+ * saved reg k-2
+ * ...
+ * saved reg 0 <-- r_sp
+ * <no argument area>
+ *
+ *                     Packet layout
+ *
+ * <--------------------- len ------------------------>
+ * <--skb-len(r_skb_hl)-->< ----- skb->data_len ------>
+ * ----------------------------------------------------
+ * |                  skb->data                       |
+ * ----------------------------------------------------
+ */
+
+#define RSIZE	(sizeof(unsigned long))
+#define ptr typeof(unsigned long)
+
+/* ABI specific return values */
+#ifdef CONFIG_32BIT /* O32 */
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define r_err	MIPS_R_V1
+#define r_val	MIPS_R_V0
+#else /* CONFIG_CPU_LITTLE_ENDIAN */
+#define r_err	MIPS_R_V0
+#define r_val	MIPS_R_V1
+#endif
+#else /* N64 */
+#define r_err	MIPS_R_V0
+#define r_val	MIPS_R_V0
+#endif
+
+#define r_ret	MIPS_R_V0
+
+/*
+ * Use 2 scratch registers to avoid pipeline interlocks.
+ * There is no overhead during epilogue and prologue since
+ * any of the $s0-$s6 registers will only be preserved if
+ * they are going to actually be used.
+ */
+#define r_s0		MIPS_R_S0 /* scratch reg 1 */
+#define r_s1		MIPS_R_S1 /* scratch reg 2 */
+#define r_off		MIPS_R_S2
+#define r_A		MIPS_R_S3
+#define r_X		MIPS_R_S4
+#define r_skb		MIPS_R_S5
+#define r_M		MIPS_R_S6
+#define r_tmp_imm	MIPS_R_T6 /* No need to preserve this */
+#define r_tmp		MIPS_R_T7 /* No need to preserve this */
+#define r_zero		MIPS_R_ZERO
+#define r_sp		MIPS_R_SP
+#define r_ra		MIPS_R_RA
+
+#define SCRATCH_OFF(k)		(4 * (k))
+
+/* JIT flags */
+#define SEEN_CALL		(1 << BPF_MEMWORDS)
+#define SEEN_SREG_SFT		(BPF_MEMWORDS + 1)
+#define SEEN_SREG_BASE		(1 << SEEN_SREG_SFT)
+#define SEEN_SREG(x)		(SEEN_SREG_BASE << (x))
+#define SEEN_S0			SEEN_SREG(0)
+#define SEEN_S1			SEEN_SREG(1)
+#define SEEN_OFF		SEEN_SREG(2)
+#define SEEN_A			SEEN_SREG(3)
+#define SEEN_X			SEEN_SREG(4)
+#define SEEN_SKB		SEEN_SREG(5)
+#define SEEN_MEM		SEEN_SREG(6)
+
+/* Arguments used by JIT */
+#define ARGS_USED_BY_JIT	2 /* only applicable to 64-bit */
+
+#define FLAG_NEED_X_RESET	(1 << 0)
+
+#define SBIT(x)			(1 << (x)) /* Signed version of BIT() */
+
+/**
+ * struct jit_ctx - JIT context
+ * @skf:		The sk_filter
+ * @prologue_bytes:	Number of bytes for prologue
+ * @idx:		Instruction index
+ * @flags:		JIT flags
+ * @offsets:		Instruction offsets
+ * @target:		Memory location for the compiled filter
+ */
+struct jit_ctx {
+	const struct sk_filter *skf;
+	unsigned int prologue_bytes;
+	u32 idx;
+	u32 flags;
+	u32 *offsets;
+	u32 *target;
+};
+
+
+static inline int optimize_div(u32 *k)
+{
+	/* power of 2 divides can be implemented with right shift */
+	if (!(*k & (*k-1))) {
+		*k = ilog2(*k);
+		return 1;
+	}
+
+	return 0;
+}
+
+/* Simply emit the instruction if the JIT memory space has been allocated */
+#define emit_instr(ctx, func, ...)			\
+do {							\
+	if ((ctx)->target != NULL) {			\
+		u32 *p = &(ctx)->target[ctx->idx];	\
+		uasm_i_##func(&p, ##__VA_ARGS__);	\
+	}						\
+	(ctx)->idx++;					\
+} while (0)
+
+/* Determine if immediate is within the 16-bit signed range */
+static inline bool is_range16(s32 imm)
+{
+	if (imm >= SBIT(15) || imm < -SBIT(15))
+		return true;
+	return false;
+}
+
+static inline void emit_addu(unsigned int dst, unsigned int src1,
+			     unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, addu, dst, src1, src2);
+}
+
+static inline void emit_nop(struct jit_ctx *ctx)
+{
+	emit_instr(ctx, nop);
+}
+
+/* Load a u32 immediate to a register */
+static inline void emit_load_imm(unsigned int dst, u32 imm, struct jit_ctx *ctx)
+{
+	if (ctx->target != NULL) {
+		/* addiu can only handle s16 */
+		if (is_range16(imm)) {
+			u32 *p = &ctx->target[ctx->idx];
+			uasm_i_lui(&p, r_tmp_imm, (s32)imm >> 16);
+			p = &ctx->target[ctx->idx + 1];
+			uasm_i_ori(&p, dst, r_tmp_imm, imm & 0xffff);
+		} else {
+			u32 *p = &ctx->target[ctx->idx];
+			uasm_i_addiu(&p, dst, r_zero, imm);
+		}
+	}
+	ctx->idx++;
+
+	if (is_range16(imm))
+		ctx->idx++;
+}
+
+static inline void emit_or(unsigned int dst, unsigned int src1,
+			   unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, or, dst, src1, src2);
+}
+
+static inline void emit_ori(unsigned int dst, unsigned src, u32 imm,
+			    struct jit_ctx *ctx)
+{
+	if (imm >= BIT(16)) {
+		emit_load_imm(r_tmp, imm, ctx);
+		emit_or(dst, src, r_tmp, ctx);
+	} else {
+		emit_instr(ctx, ori, dst, src, imm);
+	}
+}
+
+
+static inline void emit_daddu(unsigned int dst, unsigned int src1,
+			      unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, daddu, dst, src1, src2);
+}
+
+static inline void emit_daddiu(unsigned int dst, unsigned int src,
+			       int imm, struct jit_ctx *ctx)
+{
+	/*
+	 * Only used for stack, so the imm is relatively small
+	 * and it fits in 15-bits
+	 */
+	emit_instr(ctx, daddiu, dst, src, imm);
+}
+
+static inline void emit_addiu(unsigned int dst, unsigned int src,
+			      u32 imm, struct jit_ctx *ctx)
+{
+	if (is_range16(imm)) {
+		emit_load_imm(r_tmp, imm, ctx);
+		emit_addu(dst, r_tmp, src, ctx);
+	} else {
+		emit_instr(ctx, addiu, dst, src, imm);
+	}
+}
+
+static inline void emit_and(unsigned int dst, unsigned int src1,
+			    unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, and, dst, src1, src2);
+}
+
+static inline void emit_andi(unsigned int dst, unsigned int src,
+			     u32 imm, struct jit_ctx *ctx)
+{
+	/* If imm does not fit in u16 then load it to register */
+	if (imm >= BIT(16)) {
+		emit_load_imm(r_tmp, imm, ctx);
+		emit_and(dst, src, r_tmp, ctx);
+	} else {
+		emit_instr(ctx, andi, dst, src, imm);
+	}
+}
+
+static inline void emit_xor(unsigned int dst, unsigned int src1,
+			    unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, xor, dst, src1, src2);
+}
+
+static inline void emit_xori(ptr dst, ptr src, u32 imm, struct jit_ctx *ctx)
+{
+	/* If imm does not fit in u16 then load it to register */
+	if (imm >= BIT(16)) {
+		emit_load_imm(r_tmp, imm, ctx);
+		emit_xor(dst, src, r_tmp, ctx);
+	} else {
+		emit_instr(ctx, xori, dst, src, imm);
+	}
+}
+
+static inline void emit_stack_offset(int offset, struct jit_ctx *ctx)
+{
+	if (config_enabled(CONFIG_64BIT))
+		emit_instr(ctx, daddiu, r_sp, r_sp, offset);
+	else
+		emit_instr(ctx, addiu, r_sp, r_sp, offset);
+
+}
+
+static inline void emit_subu(unsigned int dst, unsigned int src1,
+			     unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, subu, dst, src1, src2);
+}
+
+static inline void emit_neg(unsigned int reg, struct jit_ctx *ctx)
+{
+	emit_subu(reg, r_zero, reg, ctx);
+}
+
+static inline void emit_sllv(unsigned int dst, unsigned int src,
+			     unsigned int sa, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, sllv, dst, src, sa);
+}
+
+static inline void emit_sll(unsigned int dst, unsigned int src,
+			    unsigned int sa, struct jit_ctx *ctx)
+{
+	/* sa is 5-bits long */
+	BUG_ON(sa >= BIT(5));
+	emit_instr(ctx, sll, dst, src, sa);
+}
+
+static inline void emit_srlv(unsigned int dst, unsigned int src,
+			     unsigned int sa, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, srlv, dst, src, sa);
+}
+
+static inline void emit_srl(unsigned int dst, unsigned int src,
+			    unsigned int sa, struct jit_ctx *ctx)
+{
+	/* sa is 5-bits long */
+	BUG_ON(sa >= BIT(5));
+	emit_instr(ctx, srl, dst, src, sa);
+}
+
+static inline void emit_sltu(unsigned int dst, unsigned int src1,
+			     unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, sltu, dst, src1, src2);
+}
+
+static inline void emit_sltiu(unsigned dst, unsigned int src,
+			      unsigned int imm, struct jit_ctx *ctx)
+{
+	/* 16 bit immediate */
+	if (is_range16((s32)imm)) {
+		emit_load_imm(r_tmp, imm, ctx);
+		emit_sltu(dst, src, r_tmp, ctx);
+	} else {
+		emit_instr(ctx, sltiu, dst, src, imm);
+	}
+
+}
+
+/* Store register on the stack */
+static inline void emit_store_stack_reg(ptr reg, ptr base,
+					unsigned int offset,
+					struct jit_ctx *ctx)
+{
+	if (config_enabled(CONFIG_64BIT))
+		emit_instr(ctx, sd, reg, offset, base);
+	else
+		emit_instr(ctx, sw, reg, offset, base);
+}
+
+static inline void emit_store(ptr reg, ptr base, unsigned int offset,
+			      struct jit_ctx *ctx)
+{
+	emit_instr(ctx, sw, reg, offset, base);
+}
+
+static inline void emit_load_stack_reg(ptr reg, ptr base,
+				       unsigned int offset,
+				       struct jit_ctx *ctx)
+{
+	if (config_enabled(CONFIG_64BIT))
+		emit_instr(ctx, ld, reg, offset, base);
+	else
+		emit_instr(ctx, lw, reg, offset, base);
+}
+
+static inline void emit_load(unsigned int reg, unsigned int base,
+			     unsigned int offset, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, lw, reg, offset, base);
+}
+
+static inline void emit_load_byte(unsigned int reg, unsigned int base,
+				  unsigned int offset, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, lb, reg, offset, base);
+}
+
+static inline void emit_half_load(unsigned int reg, unsigned int base,
+				  unsigned int offset, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, lh, reg, offset, base);
+}
+
+static inline void emit_mul(unsigned int dst, unsigned int src1,
+			    unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, mul, dst, src1, src2);
+}
+
+static inline void emit_div(unsigned int dst, unsigned int src,
+			    struct jit_ctx *ctx)
+{
+	if (ctx->target != NULL) {
+		u32 *p = &ctx->target[ctx->idx];
+		uasm_i_divu(&p, dst, src);
+		p = &ctx->target[ctx->idx + 1];
+		uasm_i_mfhi(&p, dst);
+	}
+	ctx->idx += 2; /* 2 insts */
+}
+
+static inline void emit_mod(unsigned int dst, unsigned int src,
+			    struct jit_ctx *ctx)
+{
+	if (ctx->target != NULL) {
+		u32 *p = &ctx->target[ctx->idx];
+		uasm_i_divu(&p, dst, src);
+		p = &ctx->target[ctx->idx + 1];
+		uasm_i_mflo(&p, dst);
+	}
+	ctx->idx += 2; /* 2 insts */
+}
+
+static inline void emit_dsll(unsigned int dst, unsigned int src,
+			     unsigned int sa, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, dsll, dst, src, sa);
+}
+
+static inline void emit_dsrl32(unsigned int dst, unsigned int src,
+			       unsigned int sa, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, dsrl32, dst, src, sa);
+}
+
+static inline void emit_wsbh(unsigned int dst, unsigned int src,
+			     struct jit_ctx *ctx)
+{
+	emit_instr(ctx, wsbh, dst, src);
+}
+
+/* load a function pointer to register */
+static inline void emit_load_func(unsigned int reg, ptr imm,
+				  struct jit_ctx *ctx)
+{
+	if (config_enabled(CONFIG_64BIT)) {
+		/* At this point imm is always 64-bit */
+		emit_load_imm(r_tmp, (u64)imm >> 32, ctx);
+		emit_dsll(r_tmp_imm, r_tmp, 16, ctx); /* left shift by 16 */
+		emit_ori(r_tmp, r_tmp_imm, (imm >> 16) & 0xffff, ctx);
+		emit_dsll(r_tmp_imm, r_tmp, 16, ctx); /* left shift by 16 */
+		emit_ori(reg, r_tmp_imm, imm & 0xffff, ctx);
+	} else {
+		emit_load_imm(reg, imm, ctx);
+	}
+}
+
+/* Move to real MIPS register */
+static inline void emit_reg_move(ptr dst, ptr src, struct jit_ctx *ctx)
+{
+	if (config_enabled(CONFIG_64BIT))
+		emit_daddu(dst, src, r_zero, ctx);
+	else
+		emit_addu(dst, src, r_zero, ctx);
+}
+
+/* Move to JIT (32-bit) register */
+static inline void emit_jit_reg_move(ptr dst, ptr src, struct jit_ctx *ctx)
+{
+	emit_addu(dst, src, r_zero, ctx);
+}
+
+/* Compute the immediate value for PC-relative branches. */
+static inline u32 b_imm(unsigned int tgt, struct jit_ctx *ctx)
+{
+	if (ctx->target == NULL)
+		return 0;
+
+	/*
+	 * We want a pc-relative branch. We only do forward branches
+	 * so tgt is always after pc. tgt is the instruction offset
+	 * we want to jump to.
+
+	 * Branch on MIPS:
+	 * I: target_offset <- sign_extend(offset)
+	 * I+1: PC += target_offset (delay slot)
+	 *
+	 * ctx->idx currently points to the branch instruction
+	 * but the offset is added to the delay slot so we need
+	 * to subtract 4.
+	 */
+	return ctx->offsets[tgt] -
+		(ctx->idx * 4 - ctx->prologue_bytes) - 4;
+}
+
+static inline void emit_bcond(int cond, unsigned int reg1, unsigned int reg2,
+			     unsigned int imm, struct jit_ctx *ctx)
+{
+	if (ctx->target != NULL) {
+		u32 *p = &ctx->target[ctx->idx];
+
+		switch (cond) {
+		case MIPS_COND_EQ:
+			uasm_i_beq(&p, reg1, reg2, imm);
+			break;
+		case MIPS_COND_NE:
+			uasm_i_bne(&p, reg1, reg2, imm);
+			break;
+		case MIPS_COND_ALL:
+			uasm_i_b(&p, imm);
+			break;
+		default:
+			pr_warn("%s: Unhandled branch conditional: %d\n",
+				__func__, cond);
+		}
+	}
+	ctx->idx++;
+}
+
+static inline void emit_b(unsigned int imm, struct jit_ctx *ctx)
+{
+	emit_bcond(MIPS_COND_ALL, r_zero, r_zero, imm, ctx);
+}
+
+static inline void emit_jalr(unsigned int link, unsigned int reg,
+			     struct jit_ctx *ctx)
+{
+	emit_instr(ctx, jalr, link, reg);
+}
+
+static inline void emit_jr(unsigned int reg, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, jr, reg);
+}
+
+static inline u16 align_sp(unsigned int num)
+{
+	/* Double word alignment for 32-bit, quadword for 64-bit */
+	unsigned int align = config_enabled(CONFIG_64BIT) ? 16 : 8;
+	num = (num + (align - 1)) & -align;
+	return num;
+}
+
+static inline void update_on_xread(struct jit_ctx *ctx)
+{
+	if (!(ctx->flags & SEEN_X))
+		ctx->flags |= FLAG_NEED_X_RESET;
+
+	ctx->flags |= SEEN_X;
+}
+
+static bool is_load_to_a(u16 inst)
+{
+	switch (inst) {
+	case BPF_S_LD_W_LEN:
+	case BPF_S_LD_W_ABS:
+	case BPF_S_LD_H_ABS:
+	case BPF_S_LD_B_ABS:
+	case BPF_S_ANC_CPU:
+	case BPF_S_ANC_IFINDEX:
+	case BPF_S_ANC_MARK:
+	case BPF_S_ANC_PROTOCOL:
+	case BPF_S_ANC_RXHASH:
+	case BPF_S_ANC_VLAN_TAG:
+	case BPF_S_ANC_VLAN_TAG_PRESENT:
+	case BPF_S_ANC_QUEUE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void save_bpf_jit_regs(struct jit_ctx *ctx, unsigned offset)
+{
+	int i = 0, real_off = 0;
+	u32 sflags, tmp_flags;
+
+	/* Adjust the stack pointer */
+	emit_stack_offset(-align_sp(offset), ctx);
+
+	if (ctx->flags & SEEN_CALL) {
+		/* Argument save area */
+		if (config_enabled(CONFIG_64BIT))
+			/* Bottom of current frame */
+			real_off = align_sp(offset) - RSIZE;
+		else
+			/* Top of previous frame */
+			real_off = align_sp(offset) + RSIZE;
+		emit_store_stack_reg(MIPS_R_A0, r_sp, real_off, ctx);
+		emit_store_stack_reg(MIPS_R_A1, r_sp, real_off + RSIZE, ctx);
+
+		real_off = 0;
+	}
+
+	tmp_flags = sflags = ctx->flags >> SEEN_SREG_SFT;
+	/* sflags is essentially a bitmap */
+	while (tmp_flags) {
+		if ((sflags >> i) & 0x1) {
+			emit_store_stack_reg(MIPS_R_S0 + i, r_sp, real_off,
+					     ctx);
+			real_off += RSIZE;
+		}
+		i++;
+		tmp_flags >>= 1;
+	}
+
+	/* save return address */
+	if (ctx->flags & SEEN_CALL) {
+		emit_store_stack_reg(r_ra, r_sp, real_off, ctx);
+		real_off += RSIZE;
+	}
+
+	/* Setup r_M leaving the alignment gap if necessary */
+	if (ctx->flags & SEEN_MEM) {
+		if (real_off % (RSIZE * 2))
+			real_off += RSIZE;
+		emit_addiu(r_M, r_sp, real_off, ctx);
+	}
+}
+
+static void restore_bpf_jit_regs(struct jit_ctx *ctx,
+				 unsigned int offset)
+{
+	int i, real_off = 0;
+	u32 sflags, tmp_flags;
+
+	if (ctx->flags & SEEN_CALL) {
+		if (config_enabled(CONFIG_64BIT))
+			/* Bottom of current frame */
+			real_off = align_sp(offset) - RSIZE;
+		else
+			/* Top of previous frame */
+			real_off = align_sp(offset) + RSIZE;
+		emit_load_stack_reg(MIPS_R_A0, r_sp, real_off, ctx);
+		emit_load_stack_reg(MIPS_R_A1, r_sp, real_off + RSIZE, ctx);
+
+		real_off = 0;
+	}
+
+	tmp_flags = sflags = ctx->flags >> SEEN_SREG_SFT;
+	/* sflags is a bitmap */
+	i = 0;
+	while (tmp_flags) {
+		if ((sflags >> i) & 0x1) {
+			emit_load_stack_reg(MIPS_R_S0 + i, r_sp, real_off,
+					    ctx);
+			real_off += RSIZE;
+		}
+		i++;
+		tmp_flags >>= 1;
+	}
+
+	/* restore return address */
+	if (ctx->flags & SEEN_CALL)
+		emit_load_stack_reg(r_ra, r_sp, real_off, ctx);
+
+	/* Restore the sp and discard the scrach memory */
+	emit_stack_offset(align_sp(offset), ctx);
+}
+
+static unsigned int get_stack_depth(struct jit_ctx *ctx)
+{
+	int sp_off = 0;
+
+
+	/* How may s* regs do we need to preserved? */
+	sp_off += hweight32(ctx->flags >> SEEN_SREG_SFT) * RSIZE;
+
+	if (ctx->flags & SEEN_MEM)
+		sp_off += 4 * BPF_MEMWORDS; /* BPF_MEMWORDS are 32-bit */
+
+	if (ctx->flags & SEEN_CALL)
+		/*
+		 * The JIT code make calls to external functions using 2
+		 * arguments. Therefore, for o32 we don't need to allocate
+		 * space because we don't care if the argumetns are lost
+		 * across calls. We do need however to preserve incoming
+		 * arguments but the space is already allocated for us by
+		 * the caller. On the other hand, for n64, we need to allocate
+		 * this space ourselves. We need to preserve $ra as well.
+		 */
+		sp_off += config_enabled(CONFIG_64BIT) ?
+			(ARGS_USED_BY_JIT + 1) * RSIZE : RSIZE;
+
+	/*
+	 * Subtract the bytes for the last registers since we only care about
+	 * the location on the stack pointer.
+	 */
+	return sp_off - RSIZE;
+}
+
+static void build_prologue(struct jit_ctx *ctx)
+{
+	u16 first_inst = ctx->skf->insns[0].code;
+	int sp_off;
+
+	/* Calculate the total offset for the stack pointer */
+	sp_off = get_stack_depth(ctx);
+	save_bpf_jit_regs(ctx, sp_off);
+
+	if (ctx->flags & SEEN_SKB)
+		emit_reg_move(r_skb, MIPS_R_A0, ctx);
+
+	if (ctx->flags & FLAG_NEED_X_RESET)
+		emit_jit_reg_move(r_X, r_zero, ctx);
+
+	/* Do not leak kernel data to userspace */
+	if ((first_inst != BPF_S_RET_K) && !(is_load_to_a(first_inst)))
+		emit_jit_reg_move(r_A, r_zero, ctx);
+}
+
+static void build_epilogue(struct jit_ctx *ctx)
+{
+	unsigned int sp_off;
+
+	/* Calculate the total offset for the stack pointer */
+
+	sp_off = get_stack_depth(ctx);
+	restore_bpf_jit_regs(ctx, sp_off);
+
+	/* Return */
+	emit_jr(r_ra, ctx);
+	emit_nop(ctx);
+}
+
+static u64 jit_get_skb_b(struct sk_buff *skb, unsigned offset)
+{
+	u8 ret;
+	int err;
+
+	err = skb_copy_bits(skb, offset, &ret, 1);
+
+	return (u64)err << 32 | ret;
+}
+
+static u64 jit_get_skb_h(struct sk_buff *skb, unsigned offset)
+{
+	u16 ret;
+	int err;
+
+	err = skb_copy_bits(skb, offset, &ret, 2);
+
+	return (u64)err << 32 | ntohs(ret);
+}
+
+static u64 jit_get_skb_w(struct sk_buff *skb, unsigned offset)
+{
+	u32 ret;
+	int err;
+
+	err = skb_copy_bits(skb, offset, &ret, 4);
+
+	return (u64)err << 32 | ntohl(ret);
+}
+
+#define PKT_TYPE_MAX 7
+static int pkt_type_offset(void)
+{
+	struct sk_buff skb_probe = {
+		.pkt_type = ~0,
+	};
+	char *ct = (char *)&skb_probe;
+	unsigned int off;
+
+	for (off = 0; off < sizeof(struct sk_buff); off++) {
+		if (ct[off] == PKT_TYPE_MAX)
+			return off;
+	}
+	pr_err_once("Please fix pkt_type_offset(), as pkt_type couldn't be found\n");
+	return -1;
+}
+
+static int build_body(struct jit_ctx *ctx)
+{
+	void *load_func[] = {jit_get_skb_b, jit_get_skb_h, jit_get_skb_w};
+	const struct sk_filter *prog = ctx->skf;
+	const struct sock_filter *inst;
+	unsigned int i, off, load_order, condt;
+	u32 k, b_off __maybe_unused;
+
+	for (i = 0; i < prog->len; i++) {
+		inst = &(prog->insns[i]);
+		pr_debug("%s: code->0x%02x, jt->0x%x, jf->0x%x, k->0x%x\n",
+			 __func__, inst->code, inst->jt, inst->jf, inst->k);
+		k = inst->k;
+
+		if (ctx->target == NULL)
+			ctx->offsets[i] = ctx->idx * 4;
+
+		switch (inst->code) {
+		case BPF_S_LD_IMM:
+			/* A <- k ==> li r_A, k */
+			ctx->flags |= SEEN_A;
+			emit_load_imm(r_A, k, ctx);
+			break;
+		case BPF_S_LD_W_LEN:
+			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, len) != 4);
+			/* A <- len ==> lw r_A, offset(skb) */
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			off = offsetof(struct sk_buff, len);
+			emit_load(r_A, r_skb, off, ctx);
+			break;
+		case BPF_S_LD_MEM:
+			/* A <- M[k] ==> lw r_A, offset(M) */
+			ctx->flags |= SEEN_MEM | SEEN_A;
+			emit_load(r_A, r_M, SCRATCH_OFF(k), ctx);
+			break;
+		case BPF_S_LD_W_ABS:
+			/* A <- P[k:4] */
+			load_order = 2;
+			goto load;
+		case BPF_S_LD_H_ABS:
+			/* A <- P[k:2] */
+			load_order = 1;
+			goto load;
+		case BPF_S_LD_B_ABS:
+			/* A <- P[k:1] */
+			load_order = 0;
+load:
+			emit_load_imm(r_off, k, ctx);
+load_common:
+			ctx->flags |= SEEN_CALL | SEEN_OFF | SEEN_S0 |
+				SEEN_SKB | SEEN_A;
+
+			emit_load_func(r_s0, (ptr)load_func[load_order],
+				      ctx);
+			emit_reg_move(MIPS_R_A0, r_skb, ctx);
+			emit_jalr(MIPS_R_RA, r_s0, ctx);
+			/* Load second argument to delay slot */
+			emit_reg_move(MIPS_R_A1, r_off, ctx);
+			/* Check the error value */
+			if (config_enabled(CONFIG_64BIT)) {
+				/* Get error code from the top 32-bits */
+				emit_dsrl32(r_s0, r_val, 0, ctx);
+				/* Branch to 3 instructions ahead */
+				emit_bcond(MIPS_COND_NE, r_s0, r_zero, 3 << 2,
+					   ctx);
+			} else {
+				/* Branch to 3 instructions ahead */
+				emit_bcond(MIPS_COND_NE, r_err, r_zero, 3 << 2,
+					   ctx);
+			}
+			emit_nop(ctx);
+			/* We are good */
+			emit_b(b_imm(i + 1, ctx), ctx);
+			emit_jit_reg_move(r_A, r_val, ctx);
+			/* Return with error */
+			emit_b(b_imm(prog->len, ctx), ctx);
+			emit_reg_move(r_ret, r_zero, ctx);
+			break;
+		case BPF_S_LD_W_IND:
+			/* A <- P[X + k:4] */
+			load_order = 2;
+			goto load_ind;
+		case BPF_S_LD_H_IND:
+			/* A <- P[X + k:2] */
+			load_order = 1;
+			goto load_ind;
+		case BPF_S_LD_B_IND:
+			/* A <- P[X + k:1] */
+			load_order = 0;
+load_ind:
+			update_on_xread(ctx);
+			ctx->flags |= SEEN_OFF | SEEN_X;
+			emit_addiu(r_off, r_X, k, ctx);
+			goto load_common;
+		case BPF_S_LDX_IMM:
+			/* X <- k */
+			ctx->flags |= SEEN_X;
+			emit_load_imm(r_X, k, ctx);
+			break;
+		case BPF_S_LDX_MEM:
+			/* X <- M[k] */
+			ctx->flags |= SEEN_X | SEEN_MEM;
+			emit_load(r_X, r_M, SCRATCH_OFF(k), ctx);
+			break;
+		case BPF_S_LDX_W_LEN:
+			/* X <- len */
+			ctx->flags |= SEEN_X | SEEN_SKB;
+			off = offsetof(struct sk_buff, len);
+			emit_load(r_X, r_skb, off, ctx);
+			break;
+		case BPF_S_LDX_B_MSH:
+			/* X <- 4 * (P[k:1] & 0xf) */
+			ctx->flags |= SEEN_X | SEEN_CALL | SEEN_S0 | SEEN_SKB;
+			/* Load offset to a1 */
+			emit_load_func(r_s0, (ptr)jit_get_skb_b, ctx);
+			/*
+			 * This may emit two instructions so it may not fit
+			 * in the delay slot. So use a0 in the delay slot.
+			 */
+			emit_load_imm(MIPS_R_A1, k, ctx);
+			emit_jalr(MIPS_R_RA, r_s0, ctx);
+			emit_reg_move(MIPS_R_A0, r_skb, ctx); /* delay slot */
+			/* Check the error value */
+			if (config_enabled(CONFIG_64BIT)) {
+				/* Top 32-bits of $v0 on 64-bit */
+				emit_dsrl32(r_s0, r_val, 0, ctx);
+				emit_bcond(MIPS_COND_NE, r_s0, r_zero,
+					   3 << 2, ctx);
+			} else {
+				emit_bcond(MIPS_COND_NE, r_err, r_zero,
+					   3 << 2, ctx);
+			}
+			/* No need for delay slot */
+			/* We are good */
+			/* X <- P[1:K] & 0xf */
+			emit_andi(r_X, r_val, 0xf, ctx);
+			/* X << 2 */
+			emit_b(b_imm(i + 1, ctx), ctx);
+			emit_sll(r_X, r_X, 2, ctx); /* delay slot */
+			/* Return with error */
+			emit_b(b_imm(prog->len, ctx), ctx);
+			emit_load_imm(r_ret, 0, ctx); /* delay slot */
+			break;
+		case BPF_S_ST:
+			/* M[k] <- A */
+			ctx->flags |= SEEN_MEM | SEEN_A;
+			emit_store(r_A, r_M, SCRATCH_OFF(k), ctx);
+			break;
+		case BPF_S_STX:
+			/* M[k] <- X */
+			ctx->flags |= SEEN_MEM | SEEN_X;
+			emit_store(r_X, r_M, SCRATCH_OFF(k), ctx);
+			break;
+		case BPF_S_ALU_ADD_K:
+			/* A += K */
+			ctx->flags |= SEEN_A;
+			emit_addiu(r_A, r_A, k, ctx);
+			break;
+		case BPF_S_ALU_ADD_X:
+			/* A += X */
+			ctx->flags |= SEEN_A | SEEN_X;
+			emit_addu(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_S_ALU_SUB_K:
+			/* A -= K */
+			ctx->flags |= SEEN_A;
+			emit_addiu(r_A, r_A, -k, ctx);
+			break;
+		case BPF_S_ALU_SUB_X:
+			/* A -= X */
+			ctx->flags |= SEEN_A | SEEN_X;
+			emit_subu(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_S_ALU_MUL_K:
+			/* A *= K */
+			/* Load K to scratch register before MUL */
+			ctx->flags |= SEEN_A | SEEN_S0;
+			emit_load_imm(r_s0, k, ctx);
+			emit_mul(r_A, r_A, r_s0, ctx);
+			break;
+		case BPF_S_ALU_MUL_X:
+			/* A *= X */
+			update_on_xread(ctx);
+			ctx->flags |= SEEN_A | SEEN_X;
+			emit_mul(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_S_ALU_DIV_K:
+			/* A /= k */
+			if (k == 1)
+				break;
+			if (optimize_div(&k)) {
+				ctx->flags |= SEEN_A;
+				emit_srl(r_A, r_A, k, ctx);
+				break;
+			}
+			ctx->flags |= SEEN_A | SEEN_S0;
+			emit_load_imm(r_s0, k, ctx);
+			emit_div(r_A, r_s0, ctx);
+			break;
+		case BPF_S_ALU_MOD_K:
+			/* A %= k */
+			if (k == 1 || optimize_div(&k)) {
+				ctx->flags |= SEEN_A;
+				emit_jit_reg_move(r_A, r_zero, ctx);
+			} else {
+				ctx->flags |= SEEN_A | SEEN_S0;
+				emit_load_imm(r_s0, k, ctx);
+				emit_mod(r_A, r_s0, ctx);
+			}
+			break;
+		case BPF_S_ALU_DIV_X:
+			/* A /= X */
+			update_on_xread(ctx);
+			ctx->flags |= SEEN_X | SEEN_A;
+			/* Check if r_X is zero */
+			emit_bcond(MIPS_COND_EQ, r_X, r_zero,
+				   b_imm(prog->len, ctx), ctx);
+			emit_load_imm(r_val, 0, ctx); /* delay slot */
+			emit_div(r_A, r_X, ctx);
+			break;
+		case BPF_S_ALU_MOD_X:
+			/* A %= X */
+			update_on_xread(ctx);
+			ctx->flags |= SEEN_X | SEEN_A;
+			/* Check if r_X is zero */
+			emit_bcond(MIPS_COND_EQ, r_X, r_zero,
+				   b_imm(prog->len, ctx), ctx);
+			emit_load_imm(r_val, 0, ctx); /* delay slot */
+			emit_mod(r_A, r_X, ctx);
+			break;
+		case BPF_S_ALU_OR_K:
+			/* A |= K */
+			ctx->flags |= SEEN_A;
+			emit_ori(r_A, r_A, k, ctx);
+			break;
+		case BPF_S_ALU_OR_X:
+			/* A |= X */
+			update_on_xread(ctx);
+			ctx->flags |= SEEN_A;
+			emit_ori(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_S_ALU_XOR_K:
+			/* A ^= k */
+			ctx->flags |= SEEN_A;
+			emit_xori(r_A, r_A, k, ctx);
+			break;
+		case BPF_S_ANC_ALU_XOR_X:
+		case BPF_S_ALU_XOR_X:
+			/* A ^= X */
+			update_on_xread(ctx);
+			ctx->flags |= SEEN_A;
+			emit_xor(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_S_ALU_AND_K:
+			/* A &= K */
+			ctx->flags |= SEEN_A;
+			emit_andi(r_A, r_A, k, ctx);
+			break;
+		case BPF_S_ALU_AND_X:
+			/* A &= X */
+			update_on_xread(ctx);
+			ctx->flags |= SEEN_A | SEEN_X;
+			emit_and(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_S_ALU_LSH_K:
+			/* A <<= K */
+			ctx->flags |= SEEN_A;
+			emit_sll(r_A, r_A, k, ctx);
+			break;
+		case BPF_S_ALU_LSH_X:
+			/* A <<= X */
+			ctx->flags |= SEEN_A | SEEN_X;
+			update_on_xread(ctx);
+			emit_sllv(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_S_ALU_RSH_K:
+			/* A >>= K */
+			ctx->flags |= SEEN_A;
+			emit_srl(r_A, r_A, k, ctx);
+			break;
+		case BPF_S_ALU_RSH_X:
+			ctx->flags |= SEEN_A | SEEN_X;
+			update_on_xread(ctx);
+			emit_srlv(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_S_ALU_NEG:
+			/* A = -A */
+			ctx->flags |= SEEN_A;
+			emit_neg(r_A, ctx);
+			break;
+		case BPF_S_JMP_JA:
+			/* pc += K */
+			emit_b(b_imm(i + k + 1, ctx), ctx);
+			emit_nop(ctx);
+			break;
+		case BPF_S_JMP_JEQ_K:
+			/* pc += ( A == K ) ? pc->jt : pc->jf */
+			condt = MIPS_COND_EQ | MIPS_COND_K;
+			goto jmp_cmp;
+		case BPF_S_JMP_JEQ_X:
+			ctx->flags |= SEEN_X;
+			/* pc += ( A == X ) ? pc->jt : pc->jf */
+			condt = MIPS_COND_EQ | MIPS_COND_X;
+			goto jmp_cmp;
+		case BPF_S_JMP_JGE_K:
+			/* pc += ( A >= K ) ? pc->jt : pc->jf */
+			condt = MIPS_COND_GE | MIPS_COND_K;
+			goto jmp_cmp;
+		case BPF_S_JMP_JGE_X:
+			ctx->flags |= SEEN_X;
+			/* pc += ( A >= X ) ? pc->jt : pc->jf */
+			condt = MIPS_COND_GE | MIPS_COND_X;
+			goto jmp_cmp;
+		case BPF_S_JMP_JGT_K:
+			/* pc += ( A > K ) ? pc->jt : pc->jf */
+			condt = MIPS_COND_GT | MIPS_COND_K;
+			goto jmp_cmp;
+		case BPF_S_JMP_JGT_X:
+			ctx->flags |= SEEN_X;
+			/* pc += ( A > X ) ? pc->jt : pc->jf */
+			condt = MIPS_COND_GT | MIPS_COND_X;
+jmp_cmp:
+			/* Greater or Equal */
+			if ((condt & MIPS_COND_GE) ||
+			    (condt & MIPS_COND_GT)) {
+				if (condt & MIPS_COND_K) { /* K */
+					ctx->flags |= SEEN_S0 | SEEN_A;
+					emit_sltiu(r_s0, r_A, k, ctx);
+				} else { /* X */
+					ctx->flags |= SEEN_S0 | SEEN_A |
+						SEEN_X;
+					emit_sltu(r_s0, r_A, r_X, ctx);
+				}
+				/* A < (K|X) ? r_scrach = 1 */
+				b_off = b_imm(i + inst->jf + 1, ctx);
+				emit_bcond(MIPS_COND_GT, r_s0, r_zero, b_off,
+					   ctx);
+				emit_nop(ctx);
+				/* A > (K|X) ? scratch = 0 */
+				if (condt & MIPS_COND_GT) {
+					/* Checking for equality */
+					ctx->flags |= SEEN_S0 | SEEN_A | SEEN_X;
+					if (condt & MIPS_COND_K)
+						emit_load_imm(r_s0, k, ctx);
+					else
+						emit_jit_reg_move(r_s0, r_X,
+								  ctx);
+					b_off = b_imm(i + inst->jf + 1, ctx);
+					emit_bcond(MIPS_COND_EQ, r_A, r_s0,
+						   b_off, ctx);
+					emit_nop(ctx);
+					/* Finally, A > K|X */
+					b_off = b_imm(i + inst->jt + 1, ctx);
+					emit_b(b_off, ctx);
+					emit_nop(ctx);
+				} else {
+					/* A >= (K|X) so jump */
+					b_off = b_imm(i + inst->jt + 1, ctx);
+					emit_b(b_off, ctx);
+					emit_nop(ctx);
+				}
+			} else {
+				/* A == K|X */
+				if (condt & MIPS_COND_K) { /* K */
+					ctx->flags |= SEEN_S0 | SEEN_A;
+					emit_load_imm(r_s0, k, ctx);
+					/* jump true */
+					b_off = b_imm(i + inst->jt + 1, ctx);
+					emit_bcond(MIPS_COND_EQ, r_A, r_s0,
+						   b_off, ctx);
+					emit_nop(ctx);
+					/* jump false */
+					b_off = b_imm(i + inst->jf + 1,
+						      ctx);
+					emit_bcond(MIPS_COND_NE, r_A, r_s0,
+						   b_off, ctx);
+					emit_nop(ctx);
+				} else { /* X */
+					/* jump true */
+					ctx->flags |= SEEN_A | SEEN_X;
+					b_off = b_imm(i + inst->jt + 1,
+						      ctx);
+					emit_bcond(MIPS_COND_EQ, r_A, r_X,
+						   b_off, ctx);
+					emit_nop(ctx);
+					/* jump false */
+					b_off = b_imm(i + inst->jf + 1, ctx);
+					emit_bcond(MIPS_COND_NE, r_A, r_X,
+						   b_off, ctx);
+					emit_nop(ctx);
+				}
+			}
+			break;
+		case BPF_S_JMP_JSET_K:
+			ctx->flags |= SEEN_S0 | SEEN_S1 | SEEN_A;
+			/* pc += (A & K) ? pc -> jt : pc -> jf */
+			emit_load_imm(r_s1, k, ctx);
+			emit_and(r_s0, r_A, r_s1, ctx);
+			/* jump true */
+			b_off = b_imm(i + inst->jt + 1, ctx);
+			emit_bcond(MIPS_COND_NE, r_s0, r_zero, b_off, ctx);
+			emit_nop(ctx);
+			/* jump false */
+			b_off = b_imm(i + inst->jf + 1, ctx);
+			emit_b(b_off, ctx);
+			emit_nop(ctx);
+			break;
+		case BPF_S_JMP_JSET_X:
+			ctx->flags |= SEEN_S0 | SEEN_X | SEEN_A;
+			/* pc += (A & X) ? pc -> jt : pc -> jf */
+			emit_and(r_s0, r_A, r_X, ctx);
+			/* jump true */
+			b_off = b_imm(i + inst->jt + 1, ctx);
+			emit_bcond(MIPS_COND_NE, r_s0, r_zero, b_off, ctx);
+			emit_nop(ctx);
+			/* jump false */
+			b_off = b_imm(i + inst->jf + 1, ctx);
+			emit_b(b_off, ctx);
+			emit_nop(ctx);
+			break;
+		case BPF_S_RET_A:
+			ctx->flags |= SEEN_A;
+			if (i != prog->len - 1)
+				/*
+				 * If this is not the last instruction
+				 * then jump to the epilogue
+				 */
+				emit_b(b_imm(prog->len, ctx), ctx);
+			emit_reg_move(r_ret, r_A, ctx); /* delay slot */
+			break;
+		case BPF_S_RET_K:
+			/*
+			 * It can emit two instructions so it does not fit on
+			 * the delay slot.
+			 */
+			emit_load_imm(r_ret, k, ctx);
+			if (i != prog->len - 1) {
+				/*
+				 * If this is not the last instruction
+				 * then jump to the epilogue
+				 */
+				emit_b(b_imm(prog->len, ctx), ctx);
+				emit_nop(ctx);
+			}
+			break;
+		case BPF_S_MISC_TAX:
+			/* X = A */
+			ctx->flags |= SEEN_X | SEEN_A;
+			emit_jit_reg_move(r_X, r_A, ctx);
+			break;
+		case BPF_S_MISC_TXA:
+			/* A = X */
+			ctx->flags |= SEEN_A | SEEN_X;
+			update_on_xread(ctx);
+			emit_jit_reg_move(r_A, r_X, ctx);
+			break;
+		/* AUX */
+		case BPF_S_ANC_PROTOCOL:
+			/* A = ntohs(skb->protocol */
+			ctx->flags |= SEEN_SKB | SEEN_OFF | SEEN_A;
+			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
+						  protocol) != 2);
+			off = offsetof(struct sk_buff, protocol);
+			emit_half_load(r_A, r_skb, off, ctx);
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+			/* This needs little endian fixup */
+			if (cpu_has_mips_r1) {
+				/* Get first byte */
+				emit_andi(r_tmp_imm, r_A, 0xff, ctx);
+				/* Shift it */
+				emit_sll(r_tmp, r_tmp_imm, 8, ctx);
+				/* Get second byte */
+				emit_srl(r_tmp_imm, r_A, 8, ctx);
+				emit_andi(r_tmp_imm, r_tmp_imm, 0xff, ctx);
+				/* Put everyting together in r_A */
+				emit_or(r_A, r_tmp, r_tmp_imm, ctx);
+			} else {
+				/* R2 and later have the wsbh instruction */
+				emit_wsbh(r_A, r_A, ctx);
+			}
+#endif
+			break;
+		case BPF_S_ANC_CPU:
+			ctx->flags |= SEEN_A | SEEN_OFF;
+			/* A = current_thread_info()->cpu */
+			BUILD_BUG_ON(FIELD_SIZEOF(struct thread_info,
+						  cpu) != 4);
+			off = offsetof(struct thread_info, cpu);
+			/* $28/gp points to the thread_info struct */
+			emit_load(r_A, 28, off, ctx);
+			break;
+		case BPF_S_ANC_IFINDEX:
+			/* A = skb->dev->ifindex */
+			ctx->flags |= SEEN_SKB | SEEN_A | SEEN_S0;
+			off = offsetof(struct sk_buff, dev);
+			emit_load(r_s0, r_skb, off, ctx);
+			/* error (0) in the delay slot */
+			emit_bcond(MIPS_COND_EQ, r_s0, r_zero,
+				   b_imm(prog->len, ctx), ctx);
+			emit_reg_move(r_ret, r_zero, ctx);
+			BUILD_BUG_ON(FIELD_SIZEOF(struct net_device,
+						  ifindex) != 4);
+			off = offsetof(struct net_device, ifindex);
+			emit_load(r_A, r_s0, off, ctx);
+			break;
+		case BPF_S_ANC_MARK:
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, mark) != 4);
+			off = offsetof(struct sk_buff, mark);
+			emit_load(r_A, r_skb, off, ctx);
+			break;
+		case BPF_S_ANC_RXHASH:
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, hash) != 4);
+			off = offsetof(struct sk_buff, hash);
+			emit_load(r_A, r_skb, off, ctx);
+			break;
+		case BPF_S_ANC_VLAN_TAG:
+		case BPF_S_ANC_VLAN_TAG_PRESENT:
+			ctx->flags |= SEEN_SKB | SEEN_S0 | SEEN_A;
+			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
+						  vlan_tci) != 2);
+			off = offsetof(struct sk_buff, vlan_tci);
+			emit_half_load(r_s0, r_skb, off, ctx);
+			if (inst->code == BPF_S_ANC_VLAN_TAG)
+				emit_and(r_A, r_s0, VLAN_VID_MASK, ctx);
+			else
+				emit_and(r_A, r_s0, VLAN_TAG_PRESENT, ctx);
+			break;
+		case BPF_S_ANC_PKTTYPE:
+			off = pkt_type_offset();
+
+			if (off < 0)
+				return -1;
+			emit_load_byte(r_tmp, r_skb, off, ctx);
+			/* Keep only the last 3 bits */
+			emit_andi(r_A, r_tmp, PKT_TYPE_MAX, ctx);
+			break;
+		case BPF_S_ANC_QUEUE:
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
+						  queue_mapping) != 2);
+			BUILD_BUG_ON(offsetof(struct sk_buff,
+					      queue_mapping) > 0xff);
+			off = offsetof(struct sk_buff, queue_mapping);
+			emit_half_load(r_A, r_skb, off, ctx);
+			break;
+		default:
+			pr_warn("%s: Unhandled opcode: 0x%02x\n", __FILE__,
+				inst->code);
+			return -1;
+		}
+	}
+
+	/* compute offsets only during the first pass */
+	if (ctx->target == NULL)
+		ctx->offsets[i] = ctx->idx * 4;
+
+	return 0;
+}
+
+int bpf_jit_enable __read_mostly;
+
+void bpf_jit_compile(struct sk_filter *fp)
+{
+	struct jit_ctx ctx;
+	unsigned int alloc_size, tmp_idx;
+
+	if (!bpf_jit_enable)
+		return;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	ctx.offsets = kcalloc(fp->len, sizeof(*ctx.offsets), GFP_KERNEL);
+	if (ctx.offsets == NULL)
+		return;
+
+	ctx.skf = fp;
+
+	if (build_body(&ctx))
+		goto out;
+
+	tmp_idx = ctx.idx;
+	build_prologue(&ctx);
+	ctx.prologue_bytes = (ctx.idx - tmp_idx) * 4;
+	/* just to complete the ctx.idx count */
+	build_epilogue(&ctx);
+
+	alloc_size = 4 * ctx.idx;
+	ctx.target = module_alloc(alloc_size);
+	if (ctx.target == NULL)
+		goto out;
+
+	/* Clean it */
+	memset(ctx.target, 0, alloc_size);
+
+	ctx.idx = 0;
+
+	/* Generate the actual JIT code */
+	build_prologue(&ctx);
+	build_body(&ctx);
+	build_epilogue(&ctx);
+
+	/* Update the icache */
+	flush_icache_range((ptr)ctx.target, (ptr)(ctx.target + ctx.idx));
+
+	if (bpf_jit_enable > 1)
+		/* Dump JIT code */
+		bpf_jit_dump(fp->len, alloc_size, 2, ctx.target);
+
+	fp->bpf_func = (void *)ctx.target;
+	fp->jited = 1;
+
+out:
+	kfree(ctx.offsets);
+}
+
+void bpf_jit_free(struct sk_filter *fp)
+{
+	if (fp->jited)
+		module_free(NULL, fp->bpf_func);
+	kfree(fp);
+}
diff --git a/arch/mips/net/bpf_jit.h b/arch/mips/net/bpf_jit.h
new file mode 100644
index 0000000..3a5751b
--- /dev/null
+++ b/arch/mips/net/bpf_jit.h
@@ -0,0 +1,44 @@
+/*
+ * Just-In-Time compiler for BPF filters on MIPS
+ *
+ * Copyright (c) 2014 Imagination Technologies Ltd.
+ * Author: Markos Chandras <markos.chandras@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ */
+
+#ifndef BPF_JIT_MIPS_OP_H
+#define BPF_JIT_MIPS_OP_H
+
+/* Registers used by JIT */
+#define MIPS_R_ZERO	0
+#define MIPS_R_V0	2
+#define MIPS_R_V1	3
+#define MIPS_R_A0	4
+#define MIPS_R_A1	5
+#define MIPS_R_T6	14
+#define MIPS_R_T7	15
+#define MIPS_R_S0	16
+#define MIPS_R_S1	17
+#define MIPS_R_S2	18
+#define MIPS_R_S3	19
+#define MIPS_R_S4	20
+#define MIPS_R_S5	21
+#define MIPS_R_S6	22
+#define MIPS_R_S7	23
+#define MIPS_R_SP	29
+#define MIPS_R_RA	31
+
+/* Conditional codes */
+#define MIPS_COND_EQ	0x1
+#define MIPS_COND_GE	(0x1 << 1)
+#define MIPS_COND_GT	(0x1 << 2)
+#define MIPS_COND_NE	(0x1 << 3)
+#define MIPS_COND_ALL	(0x1 << 4)
+/* Conditionals on X register or K immediate */
+#define MIPS_COND_X	(0x1 << 5)
+#define MIPS_COND_K	(0x1 << 6)
+
+#endif /* BPF_JIT_MIPS_OP_H */
-- 
1.9.2
