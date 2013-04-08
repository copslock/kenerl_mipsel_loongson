Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Apr 2013 18:54:56 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:1389 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835003Ab3DHQxZZpLm8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Apr 2013 18:53:25 +0200
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <kevink@paralogos.com>, <macro@linux-mips.org>, <john@phrozen.org>
CC:     <Steven.Hill@imgtec.com>, <dengcheng.zhu@imgtec.com>
Subject: [PATCH v4 5/5] MIPS: APRP (APSP): malta board support
Date:   Mon, 8 Apr 2013 09:53:02 -0700
Message-ID: <1365439982-4117-6-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1365439982-4117-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1365439982-4117-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01181__2013_04_08_17_53_25
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

APRP is supposed to be platform independent, however, this patch is needed
for Malta for various reasons, see code and code comments.

Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 .../include/asm/mach-malta/cpu-feature-overrides.h |    3 ++
 arch/mips/kernel/vpe-cmp.c                         |   17 ++++++++++++++++
 arch/mips/mti-malta/malta-int.c                    |   21 ++++++++++++++++++++
 3 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h b/arch/mips/include/asm/mach-malta/cpu-feature-overrides.h
index de3b66a..ff23f9b 100644
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
index fa39b3b..b210bfb 100644
--- a/arch/mips/kernel/vpe-cmp.c
+++ b/arch/mips/kernel/vpe-cmp.c
@@ -26,7 +26,24 @@
 
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
index e364af7..4387ab2 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -2,6 +2,7 @@
  * Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 2001, 2004 MIPS Technologies, Inc.
  * Copyright (C) 2001 Ralf Baechle
+ * Copyright (C) 2013 Imagination Technologies Ltd.
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -45,6 +46,9 @@
 #include <asm/gic.h>
 #include <asm/gcmpregs.h>
 #include <asm/setup.h>
+#ifdef CONFIG_MIPS_VPE_APSP_API
+#include <asm/rtlx.h>
+#endif
 
 int gcmp_present = -1;
 int gic_present;
@@ -128,6 +132,15 @@ static void malta_hw0_irqdispatch(void)
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
@@ -312,6 +325,10 @@ static void ipi_call_dispatch(void)
 
 static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
 {
+#if defined(CONFIG_MIPS_VPE_APSP_API) && defined(CONFIG_MIPS_CMP)
+	aprp_hook();
+#endif
+
 	scheduler_ipi();
 
 	return IRQ_HANDLED;
@@ -622,6 +639,10 @@ void __init arch_init_irq(void)
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
