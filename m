Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 15:55:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27120 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007660AbbCIOzswHfT8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2015 15:55:48 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 09A03108D5A1B;
        Mon,  9 Mar 2015 14:55:40 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 9 Mar 2015 14:55:43 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 9 Mar 2015 14:55:42 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2 1/4] MIPS: asm: asm-eva: Introduce kernel load/store variants
Date:   Mon, 9 Mar 2015 14:54:49 +0000
Message-ID: <1425912892-23133-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1425912892-23133-1-git-send-email-markos.chandras@imgtec.com>
References: <1425912892-23133-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46288
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

Introduce new macros for kernel load/store variants which will be
used to perform regular kernel space load/store operations in EVA
mode.

Cc: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/asm-eva.h | 137 +++++++++++++++++++++++++++-------------
 1 file changed, 93 insertions(+), 44 deletions(-)

diff --git a/arch/mips/include/asm/asm-eva.h b/arch/mips/include/asm/asm-eva.h
index e41c56e375b1..1e38f0e1ea3e 100644
--- a/arch/mips/include/asm/asm-eva.h
+++ b/arch/mips/include/asm/asm-eva.h
@@ -11,6 +11,36 @@
 #define __ASM_ASM_EVA_H
 
 #ifndef __ASSEMBLY__
+
+/* Kernel variants */
+
+#define kernel_cache(op, base)		"cache " op ", " base "\n"
+#define kernel_ll(reg, addr)		"ll " reg ", " addr "\n"
+#define kernel_sc(reg, addr)		"sc " reg ", " addr "\n"
+#define kernel_lw(reg, addr)		"lw " reg ", " addr "\n"
+#define kernel_lwl(reg, addr)		"lwl " reg ", " addr "\n"
+#define kernel_lwr(reg, addr)		"lwr " reg ", " addr "\n"
+#define kernel_lh(reg, addr)		"lh " reg ", " addr "\n"
+#define kernel_lb(reg, addr)		"lb " reg ", " addr "\n"
+#define kernel_lbu(reg, addr)		"lbu " reg ", " addr "\n"
+#define kernel_sw(reg, addr)		"sw " reg ", " addr "\n"
+#define kernel_swl(reg, addr)		"swl " reg ", " addr "\n"
+#define kernel_swr(reg, addr)		"swr " reg ", " addr "\n"
+#define kernel_sh(reg, addr)		"sh " reg ", " addr "\n"
+#define kernel_sb(reg, addr)		"sb " reg ", " addr "\n"
+
+#ifdef CONFIG_32BIT
+/*
+ * No 'sd' or 'ld' instructions in 32-bit but the code will
+ * do the correct thing
+ */
+#define kernel_sd(reg, addr)		user_sw(reg, addr)
+#define kernel_ld(reg, addr)		user_lw(reg, addr)
+#else
+#define kernel_sd(reg, addr)		"sd " reg", " addr "\n"
+#define kernel_ld(reg, addr)		"ld " reg", " addr "\n"
+#endif /* CONFIG_32BIT */
+
 #ifdef CONFIG_EVA
 
 #define __BUILD_EVA_INSN(insn, reg, addr)				\
@@ -41,37 +71,60 @@
 
 #else
 
-#define user_cache(op, base)		"cache " op ", " base "\n"
-#define user_ll(reg, addr)		"ll " reg ", " addr "\n"
-#define user_sc(reg, addr)		"sc " reg ", " addr "\n"
-#define user_lw(reg, addr)		"lw " reg ", " addr "\n"
-#define user_lwl(reg, addr)		"lwl " reg ", " addr "\n"
-#define user_lwr(reg, addr)		"lwr " reg ", " addr "\n"
-#define user_lh(reg, addr)		"lh " reg ", " addr "\n"
-#define user_lb(reg, addr)		"lb " reg ", " addr "\n"
-#define user_lbu(reg, addr)		"lbu " reg ", " addr "\n"
-#define user_sw(reg, addr)		"sw " reg ", " addr "\n"
-#define user_swl(reg, addr)		"swl " reg ", " addr "\n"
-#define user_swr(reg, addr)		"swr " reg ", " addr "\n"
-#define user_sh(reg, addr)		"sh " reg ", " addr "\n"
-#define user_sb(reg, addr)		"sb " reg ", " addr "\n"
+#define user_cache(op, base)		kernel_cache(op, base)
+#define user_ll(reg, addr)		kernel_ll(reg, addr)
+#define user_sc(reg, addr)		kernel_sc(reg, addr)
+#define user_lw(reg, addr)		kernel_lw(reg, addr)
+#define user_lwl(reg, addr)		kernel_lwl(reg, addr)
+#define user_lwr(reg, addr)		kernel_lwr(reg, addr)
+#define user_lh(reg, addr)		kernel_lh(reg, addr)
+#define user_lb(reg, addr)		kernel_lb(reg, addr)
+#define user_lbu(reg, addr)		kernel_lbu(reg, addr)
+#define user_sw(reg, addr)		kernel_sw(reg, addr)
+#define user_swl(reg, addr)		kernel_swl(reg, addr)
+#define user_swr(reg, addr)		kernel_swr(reg, addr)
+#define user_sh(reg, addr)		kernel_sh(reg, addr)
+#define user_sb(reg, addr)		kernel_sb(reg, addr)
 
 #ifdef CONFIG_32BIT
-/*
- * No 'sd' or 'ld' instructions in 32-bit but the code will
- * do the correct thing
- */
-#define user_sd(reg, addr)		user_sw(reg, addr)
-#define user_ld(reg, addr)		user_lw(reg, addr)
+#define user_sd(reg, addr)		kernel_sw(reg, addr)
+#define user_ld(reg, addr)		kernel_lw(reg, addr)
 #else
-#define user_sd(reg, addr)		"sd " reg", " addr "\n"
-#define user_ld(reg, addr)		"ld " reg", " addr "\n"
+#define user_sd(reg, addr)		kernel_sd(reg, addr)
+#define user_ld(reg, addr)		kernel_ld(reg, addr)
 #endif /* CONFIG_32BIT */
 
 #endif /* CONFIG_EVA */
 
 #else /* __ASSEMBLY__ */
 
+#define kernel_cache(op, base)		cache op, base
+#define kernel_ll(reg, addr)		ll reg, addr
+#define kernel_sc(reg, addr)		sc reg, addr
+#define kernel_lw(reg, addr)		lw reg, addr
+#define kernel_lwl(reg, addr)		lwl reg, addr
+#define kernel_lwr(reg, addr)		lwr reg, addr
+#define kernel_lh(reg, addr)		lh reg, addr
+#define kernel_lb(reg, addr)		lb reg, addr
+#define kernel_lbu(reg, addr)		lbu reg, addr
+#define kernel_sw(reg, addr)		sw reg, addr
+#define kernel_swl(reg, addr)		swl reg, addr
+#define kernel_swr(reg, addr)		swr reg, addr
+#define kernel_sh(reg, addr)		sh reg, addr
+#define kernel_sb(reg, addr)		sb reg, addr
+
+#ifdef CONFIG_32BIT
+/*
+ * No 'sd' or 'ld' instructions in 32-bit but the code will
+ * do the correct thing
+ */
+#define kernel_sd(reg, addr)		user_sw(reg, addr)
+#define kernel_ld(reg, addr)		user_lw(reg, addr)
+#else
+#define kernel_sd(reg, addr)		sd reg, addr
+#define kernel_ld(reg, addr)		ld reg, addr
+#endif /* CONFIG_32BIT */
+
 #ifdef CONFIG_EVA
 
 #define __BUILD_EVA_INSN(insn, reg, addr)			\
@@ -101,31 +154,27 @@
 #define user_sd(reg, addr)		user_sw(reg, addr)
 #else
 
-#define user_cache(op, base)		cache op, base
-#define user_ll(reg, addr)		ll reg, addr
-#define user_sc(reg, addr)		sc reg, addr
-#define user_lw(reg, addr)		lw reg, addr
-#define user_lwl(reg, addr)		lwl reg, addr
-#define user_lwr(reg, addr)		lwr reg, addr
-#define user_lh(reg, addr)		lh reg, addr
-#define user_lb(reg, addr)		lb reg, addr
-#define user_lbu(reg, addr)		lbu reg, addr
-#define user_sw(reg, addr)		sw reg, addr
-#define user_swl(reg, addr)		swl reg, addr
-#define user_swr(reg, addr)		swr reg, addr
-#define user_sh(reg, addr)		sh reg, addr
-#define user_sb(reg, addr)		sb reg, addr
+#define user_cache(op, base)		kernel_cache(op, base)
+#define user_ll(reg, addr)		kernel_ll(reg, addr)
+#define user_sc(reg, addr)		kernel_sc(reg, addr)
+#define user_lw(reg, addr)		kernel_lw(reg, addr)
+#define user_lwl(reg, addr)		kernel_lwl(reg, addr)
+#define user_lwr(reg, addr)		kernel_lwr(reg, addr)
+#define user_lh(reg, addr)		kernel_lh(reg, addr)
+#define user_lb(reg, addr)		kernel_lb(reg, addr)
+#define user_lbu(reg, addr)		kernel_lbu(reg, addr)
+#define user_sw(reg, addr)		kernel_sw(reg, addr)
+#define user_swl(reg, addr)		kernel_swl(reg, addr)
+#define user_swr(reg, addr)		kernel_swr(reg, addr)
+#define user_sh(reg, addr)		kernel_sh(reg, addr)
+#define user_sb(reg, addr)		kernel_sb(reg, addr)
 
 #ifdef CONFIG_32BIT
-/*
- * No 'sd' or 'ld' instructions in 32-bit but the code will
- * do the correct thing
- */
-#define user_sd(reg, addr)		user_sw(reg, addr)
-#define user_ld(reg, addr)		user_lw(reg, addr)
+#define user_sd(reg, addr)		kernel_sw(reg, addr)
+#define user_ld(reg, addr)		kernel_lw(reg, addr)
 #else
-#define user_sd(reg, addr)		sd reg, addr
-#define user_ld(reg, addr)		ld reg, addr
+#define user_sd(reg, addr)		kernel_sd(reg, addr)
+#define user_ld(reg, addr)		kernel_sd(reg, addr)
 #endif /* CONFIG_32BIT */
 
 #endif /* CONFIG_EVA */
-- 
2.3.1
