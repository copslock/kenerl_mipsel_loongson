Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:21:28 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43558 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825865AbaA0UU2yY0x8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:20:28 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 03/58] MIPS: asm: Add wrappers for EVA/non-EVA instructions
Date:   Mon, 27 Jan 2014 20:18:50 +0000
Message-ID: <1390853985-14246-4-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_20_23
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39121
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

EVA uses specific instructions for accessing user memory.
Instead of polluting the kernel with numerous #ifdef CONFIG_EVA
we add wrappers for all the instructions that need special
handling when EVA is enabled.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/asm.h | 122 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index b79be18a..5b11598 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -28,6 +28,128 @@
 #define CAT(str1, str2) __CAT(str1, str2)
 #endif
 
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_EVA
+
+#define __BUILD_EVA_INSN(insn, reg, addr)				\
+				"	.set	push\n"			\
+				"	.set	mips0\n"		\
+				"	.set	eva\n"			\
+				"	"insn" "reg", "addr "\n"	\
+				"	.set	pop\n"
+
+#define user_cache(op, base)		__BUILD_EVA_INSN("cachee", op, base)
+#define user_ll(reg, addr)		__BUILD_EVA_INSN("lle", reg, addr)
+#define user_sc(reg, addr)		__BUILD_EVA_INSN("sce", reg, addr)
+#define user_lw(reg, addr)		__BUILD_EVA_INSN("lwe", reg, addr)
+#define user_lwl(reg, addr)		__BUILD_EVA_INSN("lwle", reg, addr)
+#define user_lwr(reg, addr)		__BUILD_EVA_INSN("lwre", reg, addr)
+#define user_lh(reg, addr)		__BUILD_EVA_INSN("lhe", reg, addr)
+#define user_lb(reg, addr)		__BUILD_EVA_INSN("lbe", reg, addr)
+#define user_lbu(reg, addr)		__BUILD_EVA_INSN("lbue", reg, addr)
+/* No 64-bit EVA instruction for loading double words */
+#define user_ld(reg, addr)		user_lw(reg, addr)
+#define user_sw(reg, addr)		__BUILD_EVA_INSN("swe", reg, addr)
+#define user_swl(reg, addr)		__BUILD_EVA_INSN("swle", reg, addr)
+#define user_swr(reg, addr)		__BUILD_EVA_INSN("swre", reg, addr)
+#define user_sh(reg, addr)		__BUILD_EVA_INSN("she", reg, addr)
+#define user_sb(reg, addr)		__BUILD_EVA_INSN("sbe", reg, addr)
+/* No 64-bit EVA instruction for storing double words */
+#define user_sd(reg, addr)		user_sw(reg, addr)
+
+#else
+
+#define user_cache(op, base)		"cache " op ", " base "\n"
+#define user_ll(reg, addr)		"ll " reg ", " addr "\n"
+#define user_sc(reg, addr)		"sc " reg ", " addr "\n"
+#define user_lw(reg, addr)		"lw " reg ", " addr "\n"
+#define user_lwl(reg, addr)		"lwl " reg ", " addr "\n"
+#define user_lwr(reg, addr)		"lwr " reg ", " addr "\n"
+#define user_lh(reg, addr)		"lh " reg ", " addr "\n"
+#define user_lb(reg, addr)		"lb " reg ", " addr "\n"
+#define user_lbu(reg, addr)		"lbu " reg ", " addr "\n"
+#define user_sw(reg, addr)		"sw " reg ", " addr "\n"
+#define user_swl(reg, addr)		"swl " reg ", " addr "\n"
+#define user_swr(reg, addr)		"swr " reg ", " addr "\n"
+#define user_sh(reg, addr)		"sh " reg ", " addr "\n"
+#define user_sb(reg, addr)		"sb " reg ", " addr "\n"
+
+#ifdef CONFIG_32BIT
+/*
+ * No 'sd' or 'ld' instructions in 32-bit but the code will
+ * do the correct thing
+ */
+#define user_sd(reg, addr)		user_sw(reg, addr)
+#define user_ld(reg, addr)		user_lw(reg, addr)
+#else
+#define user_sd(reg, addr)		"sd " reg", " addr "\n"
+#define user_ld(reg, addr)		"ld " reg", " addr "\n"
+#endif /* CONFIG_32BIT */
+
+#endif /* CONFIG_EVA */
+
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_EVA
+
+#define __BUILD_EVA_INSN(insn, reg, addr)			\
+				.set	push;			\
+				.set	mips0;			\
+				.set	eva;			\
+				insn reg, addr;			\
+				.set	pop;
+
+#define user_cache(op, base)		__BUILD_EVA_INSN(cachee, op, base)
+#define user_ll(reg, addr)		__BUILD_EVA_INSN(lle, reg, addr)
+#define user_sc(reg, addr)		__BUILD_EVA_INSN(sce, reg, addr)
+#define user_lw(reg, addr)		__BUILD_EVA_INSN(lwe, reg, addr)
+#define user_lwl(reg, addr)		__BUILD_EVA_INSN(lwle, reg, addr)
+#define user_lwr(reg, addr)		__BUILD_EVA_INSN(lwre, reg, addr)
+#define user_lh(reg, addr)		__BUILD_EVA_INSN(lhe, reg, addr)
+#define user_lb(reg, addr)		__BUILD_EVA_INSN(lbe, reg, addr)
+#define user_lbu(reg, addr)		__BUILD_EVA_INSN(lbue, reg, addr)
+/* No 64-bit EVA instruction for loading double words */
+#define user_ld(reg, addr)		user_lw(reg, addr)
+#define user_sw(reg, addr)		__BUILD_EVA_INSN(swe, reg, addr)
+#define user_swl(reg, addr)		__BUILD_EVA_INSN(swle, reg, addr)
+#define user_swr(reg, addr)		__BUILD_EVA_INSN(swre, reg, addr)
+#define user_sh(reg, addr)		__BUILD_EVA_INSN(she, reg, addr)
+#define user_sb(reg, addr)		__BUILD_EVA_INSN(sbe, reg, addr)
+/* No 64-bit EVA instruction for loading double words */
+#define user_sd(reg, addr)		user_sw(reg, addr)
+#else
+
+#define user_cache(op, base)		cache op, base
+#define user_ll(reg, addr)		ll reg, addr
+#define user_sc(reg, addr)		sc reg, addr
+#define user_lw(reg, addr)		lw reg, addr
+#define user_lwl(reg, addr)		lwl reg, addr
+#define user_lwr(reg, addr)		lwr reg, addr
+#define user_lh(reg, addr)		lh reg, addr
+#define user_lb(reg, addr)		lb reg, addr
+#define user_lbu(reg, addr)		lbu reg, addr
+#define user_sw(reg, addr)		sw reg, addr
+#define user_swl(reg, addr)		swl reg, addr
+#define user_swr(reg, addr)		swr reg, addr
+#define user_sh(reg, addr)		sh reg, addr
+#define user_sb(reg, addr)		sb reg, addr
+
+#ifdef CONFIG_32BIT
+/*
+ * No 'sd' or 'ld' instructions in 32-bit but the code will
+ * do the correct thing
+ */
+#define user_sd(reg, addr)		user_sw(reg, addr)
+#define user_ld(reg, addr)		user_lw(reg, addr)
+#else
+#define user_sd(reg, addr)		sd reg, addr
+#define user_ld(reg, addr)		ld reg, addr
+#endif /* CONFIG_32BIT */
+
+#endif /* CONFIG_EVA */
+
+#endif /* __ASSEMBLY__ */
+
 /*
  * PIC specific declarations
  * Not used for the kernel but here seems to be the right place.
-- 
1.8.5.3
