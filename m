Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2014 16:53:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.115]:60914 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816887AbaCFPxVuc4YN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2014 16:53:21 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B8503C820C05F
        for <linux-mips@linux-mips.org>; Thu,  6 Mar 2014 15:53:10 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 6 Mar 2014 15:53:13 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.47) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Thu, 6 Mar 2014 15:53:13 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2 03/58] MIPS: asm: Add wrappers for EVA/non-EVA instructions
Date:   Thu, 6 Mar 2014 15:52:51 +0000
Message-ID: <1394121171-24457-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1390853985-14246-4-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-4-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39433
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
Changes since v1:
- Move EVA instruction wrappers to a new header file to avoid problematic
inclusions of the asm/asm.h header file.

This is already included in the upstream-sfr/mips-for-linux-next tree.
The files that have previously been modified to include <asm/asm.h> have been
updated to include <asm/asm-eva.h>. The fixes are also in the upstream-sfr/
mips-for-linux-next tree but I will not post new versions of these patches
because the change is rather trivial.

For this patch, no further action is required apart from updating the
patchwork URL for this commit in the mips-for-linux-next branch.
---

 arch/mips/include/asm/asm-eva.h | 135 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/asm.h     |   1 +
 2 files changed, 136 insertions(+)
 create mode 100644 arch/mips/include/asm/asm-eva.h

diff --git a/arch/mips/include/asm/asm-eva.h b/arch/mips/include/asm/asm-eva.h
new file mode 100644
index 0000000..e41c56e
--- /dev/null
+++ b/arch/mips/include/asm/asm-eva.h
@@ -0,0 +1,135 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2014 Imagination Technologies Ltd.
+ *
+ */
+
+#ifndef __ASM_ASM_EVA_H
+#define __ASM_ASM_EVA_H
+
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
+#endif /* __ASM_ASM_EVA_H */
diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index b79be18a..b153e79 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -18,6 +18,7 @@
 #define __ASM_ASM_H
 
 #include <asm/sgidefs.h>
+#include <asm/asm-eva.h>
 
 #ifndef CAT
 #ifdef __STDC__
-- 
1.9.0
