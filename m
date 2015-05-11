Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 13:26:41 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:19354 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013127AbbEKL0W4epV- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 13:26:22 +0200
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4BBQD6Q011233
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 11 May 2015 11:26:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t4BBQCiG008245
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 11 May 2015 11:26:13 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t4BBQCfq015825;
        Mon, 11 May 2015 11:26:12 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.159.243.153)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2015 04:26:11 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: asm: asm-eva: Introduce kernel load/store variants
Date:   Mon, 11 May 2015 07:17:14 -0400
Message-Id: <1431343152-19437-53-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1431343152-19437-1-git-send-email-sasha.levin@oracle.com>
References: <1431343152-19437-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: Markos Chandras <markos.chandras@imgtec.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 60cd7e08e453bc6828ac4b539f949e4acd80f143 ]

Introduce new macros for kernel load/store variants which will be
used to perform regular kernel space load/store operations in EVA
mode.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: <stable@vger.kernel.org> # v3.15+
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9500/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/include/asm/asm-eva.h | 137 +++++++++++++++++++++++++++-------------
 1 file changed, 93 insertions(+), 44 deletions(-)

diff --git a/arch/mips/include/asm/asm-eva.h b/arch/mips/include/asm/asm-eva.h
index e41c56e..1e38f0e 100644
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
2.1.0
