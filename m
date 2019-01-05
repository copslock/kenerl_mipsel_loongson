Return-Path: <SRS0=5/jd=PN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BF4C43387
	for <linux-mips@archiver.kernel.org>; Sat,  5 Jan 2019 15:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282042085A
	for <linux-mips@archiver.kernel.org>; Sat,  5 Jan 2019 15:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsU1I8tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfAEPBV (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 5 Jan 2019 10:01:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44033 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAEPBU (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 5 Jan 2019 10:01:20 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so18763293plt.11
        for <linux-mips@vger.kernel.org>; Sat, 05 Jan 2019 07:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9vXuOvmMWhjscUj8b94Fxsujqr48ha60ukO/a+kPS8=;
        b=tsU1I8tfVleSgbbNYvvoFoMJ55YrM2TZKAtm7Z5ZJI3mPVfzLNipmLr0xF9leT+rBI
         nIMsEuUyb5bu6XF5K1liRs20PU2ZR/MvUSOB5YPcnB4TXnbdZC+76NV60iCwbi6tJQHz
         uvqayhSiWkYLXZtK0A8Si6igAi0CBppNqdUnAGw1lEB55gwL3vU2YGRC0mls7tK57fkK
         Vkrg8eNNhxJYje8kDCOXIZ3rxv+lZ0pw670YibBXevLundtT3czsnSP+ODAaYyaRZmex
         ONN0WbrLab1h4q2zFP+7qnM+XeDQSKC7kDoMttGel9Rrgwxy0ku+X8ay16jTqNNEGTyy
         oWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=s9vXuOvmMWhjscUj8b94Fxsujqr48ha60ukO/a+kPS8=;
        b=sz6pW9hr0IfTiPuZ83O6/4fIn6uO3of2w6SDyuk2NxmCcfhbJT9kp/uV+ImIO/EKnW
         c7eE/++8grtoJwm4iNJgGjXphB0xHnJMyDJDhBCjPF1IiOeh8zYQOMgqaRO3uzNYhvK5
         9HAWGX6n2OL5bNcMaEngv1bRMhd0LnngLSwZQFlD14/cWLvDTdZxXB1TXBKAXHqZtI4B
         JcRGY15iGyOw/a9d6p8lRxWG6FKEsp6x2Dq7dsvnsb6g1+0Z3WeoJIAzF3XPXaHUa4iI
         cr9P9mmuXpvQlMUO2hvbAmhR+BpY6JycRwLhsf75FOSkl6Ppgys2DWzs3tnpyMocWX3R
         l2xg==
X-Gm-Message-State: AJcUukdhzf4K8lcn264jHNmwzbFbS8PwQH/CdskG8l0JUpB+9uoKA8bx
        OK7m11jCi7o/y4cSrkGgFQ8=
X-Google-Smtp-Source: ALg8bN5xtSRhuSHeKWl4vFUvQtNQPmNKL1OdCD+PPm4dFDorwHO2dfD7f8yYezMd0Xs5t1Mk07fLOA==
X-Received: by 2002:a17:902:28aa:: with SMTP id f39mr55378382plb.297.1546700477613;
        Sat, 05 Jan 2019 07:01:17 -0800 (PST)
Received: from localhost.localdomain ([47.74.12.188])
        by smtp.gmail.com with ESMTPSA id j21sm87248890pfn.175.2019.01.05.07.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 07:01:16 -0800 (PST)
From:   YunQiang Su <syq@debian.org>
To:     pburton@wavecomp.com, linux-mips@vger.kernel.org
Cc:     chehc@lemote.com, syq@debian.org, zhangfx@lemote.com,
        wuzhangjin@gmail.com, linux-mips@linux-mips.org,
        YunQiang Su <ysu@wavecomp.com>
Subject: [PATCH 2/2] MIPS: Loongson, workaround ll/sc weak ordering
Date:   Sat,  5 Jan 2019 23:00:37 +0800
Message-Id: <20190105150037.30261-2-syq@debian.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105150037.30261-1-syq@debian.org>
References: <20190105150037.30261-1-syq@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: YunQiang Su <ysu@wavecomp.com>

On the Loongson-2G/2H/3A/3B there is a hardware flaw that ll/sc and
lld/scd is very weak ordering. We should add sync instructions before
each ll/lld and after the last sc/scd to workaround. Otherwise, this
flaw will cause deadlock occationally (e.g. when doing heavy load test
with LTP).

We introduced an gcc/as option "-mfix-loongson3-llsc", this option
inserts sync before ll, and so some addresses in __ex_table will need
to be shift.

Not all Loongson CPU have this problem, aka Loongson starts to solve it
in their new models, such as the last series Loongson 3A 3000.
So for kerenel we introduce a config option CPU_LOONGSON3_WORKAROUND_LLSC,
with this option enabled, we will add "-mfix-loongson3-llsc" to
cc-option.

This is based on the patch from Huacai Chen.

Signed-off-by: YunQiang Su <ysu@wavecomp.com>
---
 arch/mips/Kconfig             | 19 +++++++++++++++++++
 arch/mips/Makefile            |  5 +++++
 arch/mips/include/asm/futex.h | 20 ++++++++++++--------
 arch/mips/mm/tlbex.c          |  3 +++
 4 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 787290781..4660e7847 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1385,6 +1385,25 @@ config CPU_LOONGSON3
 		The Loongson 3 processor implements the MIPS64R2 instruction
 		set with many extensions.
 
+config CPU_LOONGSON3_WORKAROUND_LLSC
+	bool "Workaround the LL/SC weak ordering"
+	default n
+	depends on CPU_LOONGSON3
+	help
+	  On the Loongson-2G/2H/3A/3B there is a hardware flaw that ll/sc and
+	  lld/scd is very weak ordering. We should add sync instructions before
+	  each ll/lld and after the last sc/scd to workaround. Otherwise, this
+	  flaw will cause deadlock occationally (e.g. when doing heavy load test
+	  with LTP).
+
+	  We introduced a gcc/as option "-mfix-loongson3-llsc", this option
+	  inserts sync before ll, and so some addresses in __ex_table will need
+	  to be shift.
+
+	  Newer model has solve this problem, such as the last series of 3A 3000
+	  but not all 3A 3000. If you want enable this workaround for older
+	  Loongson's CPU, please say 'Y' here.
+
 config LOONGSON3_ENHANCEMENT
 	bool "New Loongson 3 CPU Enhancements"
 	default n
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 5b174c3d0..c2afaf58b 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -194,6 +194,11 @@ cflags-$(CONFIG_CPU_CAVIUM_OCTEON) += -Wa,-march=octeon
 endif
 cflags-$(CONFIG_CAVIUM_CN63XXP1) += -Wa,-mfix-cn63xxp1
 cflags-$(CONFIG_CPU_BMIPS)	+= -march=mips32 -Wa,-mips32 -Wa,--trap
+ifeq ($(CONFIG_CPU_LOONGSON3_WORKAROUND_LLSC),y)
+cflags-y	+= -mfix-loongson3-llsc
+else
+cflags-y	+= $(call cc-option,-mno-fix-loongson3-llsc,)
+endif
 
 cflags-$(CONFIG_CPU_R4000_WORKAROUNDS)	+= $(call cc-option,-mfix-r4000,)
 cflags-$(CONFIG_CPU_R4400_WORKAROUNDS)	+= $(call cc-option,-mfix-r4400,)
diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index 8eff134b3..c0608697f 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -18,6 +18,14 @@
 #include <asm/errno.h>
 #include <asm/war.h>
 
+#if defined(__mips_fix_loongson3_llsc) && defined(CONFIG_CPU_LOONGSON3_WORKAROUND_LLSC)
+# define LL_SHIFT_UA __UA_ADDR "\t(1b+0), 4b		\n" 	\
+		__UA_ADDR "\t(1b+4), 4b			\n"	\
+		__UA_ADDR "\t(2b+0), 4b			\n"
+#else
+# define LL_SHIFT_UA __UA_ADDR "\t1b, 4b		\n" 	\
+		__UA_ADDR "\t2b, 4b			\n"
+#endif
 #define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)		\
 {									\
 	if (cpu_has_llsc && R10000_LLSC_WAR) {				\
@@ -41,8 +49,7 @@
 		"	j	3b				\n"	\
 		"	.previous				\n"	\
 		"	.section __ex_table,\"a\"		\n"	\
-		"	"__UA_ADDR "\t1b, 4b			\n"	\
-		"	"__UA_ADDR "\t2b, 4b			\n"	\
+		LL_SHIFT_UA						\
 		"	.previous				\n"	\
 		: "=r" (ret), "=&r" (oldval),				\
 		  "=" GCC_OFF_SMALL_ASM() (*uaddr)				\
@@ -70,8 +77,7 @@
 		"	j	3b				\n"	\
 		"	.previous				\n"	\
 		"	.section __ex_table,\"a\"		\n"	\
-		"	"__UA_ADDR "\t1b, 4b			\n"	\
-		"	"__UA_ADDR "\t2b, 4b			\n"	\
+		LL_SHIFT_UA						\
 		"	.previous				\n"	\
 		: "=r" (ret), "=&r" (oldval),				\
 		  "=" GCC_OFF_SMALL_ASM() (*uaddr)				\
@@ -155,8 +161,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"	j	3b					\n"
 		"	.previous					\n"
 		"	.section __ex_table,\"a\"			\n"
-		"	"__UA_ADDR "\t1b, 4b				\n"
-		"	"__UA_ADDR "\t2b, 4b				\n"
+		LL_SHIFT_UA
 		"	.previous					\n"
 		: "+r" (ret), "=&r" (val), "=" GCC_OFF_SMALL_ASM() (*uaddr)
 		: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
@@ -185,8 +190,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"	j	3b					\n"
 		"	.previous					\n"
 		"	.section __ex_table,\"a\"			\n"
-		"	"__UA_ADDR "\t1b, 4b				\n"
-		"	"__UA_ADDR "\t2b, 4b				\n"
+		LL_SHIFT_UA
 		"	.previous					\n"
 		: "+r" (ret), "=&r" (val), "=" GCC_OFF_SMALL_ASM() (*uaddr)
 		: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 08a9a66ef..e9eb4715c 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1649,6 +1649,9 @@ static void
 iPTE_LW(u32 **p, unsigned int pte, unsigned int ptr)
 {
 #ifdef CONFIG_SMP
+# ifdef CONFIG_CPU_LOONGSON3_WORKAROUND_LLSC
+	uasm_i_sync(p, 0);
+# endif
 # ifdef CONFIG_PHYS_ADDR_T_64BIT
 	if (cpu_has_64bits)
 		uasm_i_lld(p, pte, 0, ptr);
-- 
2.20.1

