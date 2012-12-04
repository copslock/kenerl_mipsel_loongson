Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2012 00:56:43 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:33044 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831651Ab2LDXz0lK6zi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Dec 2012 00:55:26 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id qB4Nt48n014718;
        Tue, 4 Dec 2012 15:55:12 -0800
X-WSS-ID: 0MEJ6G0-01-0P4-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.84])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 2D8AE36465A;
        Tue,  4 Dec 2012 15:55:11 -0800 (PST)
Received: from fun-lab.mips.com (192.168.52.61) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Tue, 4 Dec 2012
 15:55:06 -0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <kevink@paralogos.com>, <macro@linux-mips.org>, <john@phrozen.org>
CC:     <dczhu@mips.com>
Subject: [PATCH v3 5/5] MIPS: APRP (APSP): malta board support
Date:   Tue, 4 Dec 2012 15:54:32 -0800
Message-ID: <1354665272-22759-6-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1354665272-22759-1-git-send-email-dczhu@mips.com>
References: <1354665272-22759-1-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: 6KZQfn1T7ANVgeS3a833lA==
X-archive-position: 35182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

APRP is supposed to be platform independent, however, this patch is needed
for Malta for various reasons, see code and code comments.

Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
---
 .../include/asm/mach-malta/cpu-feature-overrides.h |    3 ++
 arch/mips/kernel/vpe-cmp.c                         |   17 +++++++++++++++
 arch/mips/mti-malta/malta-int.c                    |   22 +++++++++++++++++++-
 3 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h b/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
index 37e3583..0bf3872 100644
--- a/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
@@ -17,6 +17,9 @@
 #define cpu_has_tlb		1
 #define cpu_has_4kex		1
 #define cpu_has_4k_cache	1
+#ifdef CONFIG_MIPS_SP_FP_INTENSIVE
+#define cpu_has_fpu		0
+#endif
 /* #define cpu_has_fpu		? */
 /* #define cpu_has_32fpr	? */
 #define cpu_has_counter		1
diff --git a/arch/mips/kernel/vpe-cmp.c b/arch/mips/kernel/vpe-cmp.c
index 9d0c375..20f4497 100644
--- a/arch/mips/kernel/vpe-cmp.c
+++ b/arch/mips/kernel/vpe-cmp.c
@@ -25,7 +25,24 @@
 
 static int major;
 
+#ifdef CONFIG_MIPS_MALTA
+#include <asm/amon.h>
+
+int vpe_run(struct vpe *v)
+{
+	struct vpe_notifications *n;
+
+	if (amon_cpu_start(aprp_cpu_index(), v->__start, 0, 0, 0) < 0)
+		return -1;
+
+	list_for_each_entry(n, &v->notify, list)
+		n->start(VPE_MODULE_MINOR);
+
+	return 0;
+}
+#else
 #error CMP vpe_run() not implemented!
+#endif
 
 void cleanup_tc(struct tc *tc)
 {
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 647b863..cddda99 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -1,6 +1,6 @@
 /*
  * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 2000, 2001, 2004 MIPS Technologies, Inc.
+ * Copyright (C) 2000, 2001, 2004, 2012 MIPS Technologies, Inc.
  * Copyright (C) 2001 Ralf Baechle
  *
  *  This program is free software; you can distribute it and/or modify it
@@ -45,6 +45,9 @@
 #include <asm/gic.h>
 #include <asm/gcmpregs.h>
 #include <asm/setup.h>
+#ifdef CONFIG_MIPS_VPE_APSP_API
+#include <asm/rtlx.h>
+#endif
 
 int gcmp_present = -1;
 int gic_present;
@@ -128,6 +131,15 @@ static void malta_hw0_irqdispatch(void)
 	}
 
 	do_IRQ(MALTA_INT_BASE + irq);
+
+#if defined(CONFIG_MIPS_VPE_APSP_API) && !defined(CONFIG_MIPS_CMP)
+	/*
+	 * When sw0 gets set, a spurious hw interrupt is signaled as well.
+	 * The sw0 will not be handled until the hw interrupt is cleared.
+	 * We use the hook to handle sw0 and the hw interrupt gets cleared.
+	 */
+	aprp_hook();
+#endif
 }
 
 static void malta_ipi_irqdispatch(void)
@@ -312,6 +324,10 @@ static void ipi_call_dispatch(void)
 
 static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
 {
+#if defined(CONFIG_MIPS_VPE_APSP_API) && defined(CONFIG_MIPS_CMP)
+	aprp_hook();
+#endif
+
 	scheduler_ipi();
 
 	return IRQ_HANDLED;
@@ -622,6 +638,10 @@ void __init arch_init_irq(void)
 		arch_init_ipiirq(cpu_ipi_call_irq, &irq_call);
 #endif
 	}
+
+#ifdef CONFIG_MIPS_VPE_APSP_API
+	aprp_hook = null_aprp_hook;
+#endif
 }
 
 void malta_be_init(void)
-- 
1.7.1
