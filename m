Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2015 01:47:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46495 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013460AbbKMArC7BAgl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Nov 2015 01:47:02 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 1ACE684369937;
        Fri, 13 Nov 2015 00:46:53 +0000 (GMT)
Received: from [10.100.200.62] (10.100.200.62) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server id 14.3.235.1; Fri, 13 Nov 2015
 00:46:56 +0000
Date:   Fri, 13 Nov 2015 00:46:55 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] MIPS: Define the legacy-NaN and 2008-NaN features
In-Reply-To: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1511130006010.7097@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Allocate CPU option bits and define macros for the legacy-NaN and 
2008-NaN IEEE Std 754 MIPS architecture features.  Unconditionally mark 
the legacy-NaN feature as present across hardware and emulated 
floating-point configurations.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-mips-nan-legacy.diff
Index: linux-sfr-test/arch/mips/include/asm/cpu-features.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/cpu-features.h	2015-10-07 19:33:20.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/cpu-features.h	2015-10-07 20:48:14.828556000 +0100
@@ -414,4 +414,11 @@
 # define cpu_has_small_pages	(cpu_data[0].options & MIPS_CPU_SP)
 #endif
 
+#ifndef cpu_has_nan_legacy
+#define cpu_has_nan_legacy	(cpu_data[0].options & MIPS_CPU_NAN_LEGACY)
+#endif
+#ifndef cpu_has_nan_2008
+#define cpu_has_nan_2008	(cpu_data[0].options & MIPS_CPU_NAN_2008)
+#endif
+
 #endif /* __ASM_CPU_FEATURES_H */
Index: linux-sfr-test/arch/mips/include/asm/cpu.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/cpu.h	2015-10-07 19:33:20.000000000 +0100
+++ linux-sfr-test/arch/mips/include/asm/cpu.h	2015-10-07 20:48:14.831542000 +0100
@@ -386,6 +386,8 @@ enum cpu_type_enum {
 #define MIPS_CPU_BP_GHIST	0x8000000000ull /* R12K+ Branch Prediction Global History */
 #define MIPS_CPU_SP		0x10000000000ull /* Small (1KB) page support */
 #define MIPS_CPU_FTLB		0x20000000000ull /* CPU has Fixed-page-size TLB */
+#define MIPS_CPU_NAN_LEGACY	0x40000000000ull /* Legacy NaN implemented */
+#define MIPS_CPU_NAN_2008	0x80000000000ull /* 2008 NaN implemented */
 
 /*
  * CPU ASE encodings
Index: linux-sfr-test/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/cpu-probe.c	2015-10-07 19:33:20.000000000 +0100
+++ linux-sfr-test/arch/mips/kernel/cpu-probe.c	2015-10-07 20:48:14.836528000 +0100
@@ -137,6 +137,7 @@ static void cpu_set_fpu_opts(struct cpui
 	}
 
 	cpu_set_fpu_fcsr_mask(c);
+	c->options |= MIPS_CPU_NAN_LEGACY;
 }
 
 /*
@@ -147,6 +148,7 @@ static void cpu_set_nofpu_opts(struct cp
 	c->options &= ~MIPS_CPU_FPU;
 	c->fpu_msk31 = mips_nofpu_msk31;
 
+	c->options |= MIPS_CPU_NAN_LEGACY;
 	cpu_set_nofpu_id(c);
 }
 
