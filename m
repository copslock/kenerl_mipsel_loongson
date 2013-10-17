Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2013 19:22:01 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:53789 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824926Ab3JQRV6QeJRv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Oct 2013 19:21:58 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1VWrGg-0004lW-Fh; Thu, 17 Oct 2013 12:21:50 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>, ralf@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [v2 PATCH 5/6] MIPS: APRP: Add support for Malta CMP platform.
Date:   Thu, 17 Oct 2013 12:21:46 -0500
Message-Id: <1382030506-16588-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

Malta with multi-core CM platforms can now use APRP functionality.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Reviewed-by: Qais Yousef <Qais.Yousef@imgtec.com>
---
 arch/mips/include/asm/amon.h     |    4 ++--
 arch/mips/mti-malta/malta-amon.c |   24 +++++++++++++++++++++---
 arch/mips/mti-malta/malta-int.c  |   12 ++++++++++++
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/amon.h b/arch/mips/include/asm/amon.h
index c3dc1a6..3bd6e76 100644
--- a/arch/mips/include/asm/amon.h
+++ b/arch/mips/include/asm/amon.h
@@ -3,5 +3,5 @@
  */
 
 int amon_cpu_avail(int);
-void amon_cpu_start(int, unsigned long, unsigned long,
-		    unsigned long, unsigned long);
+int amon_cpu_start(int, unsigned long, unsigned long,
+		   unsigned long, unsigned long);
diff --git a/arch/mips/mti-malta/malta-amon.c b/arch/mips/mti-malta/malta-amon.c
index 1e47844..917df6d 100644
--- a/arch/mips/mti-malta/malta-amon.c
+++ b/arch/mips/mti-malta/malta-amon.c
@@ -25,6 +25,7 @@
 #include <asm/addrspace.h>
 #include <asm/mips-boards/launch.h>
 #include <asm/mipsmtregs.h>
+#include <asm/vpe.h>
 
 int amon_cpu_avail(int cpu)
 {
@@ -48,7 +49,7 @@ int amon_cpu_avail(int cpu)
 	return 1;
 }
 
-void amon_cpu_start(int cpu,
+int amon_cpu_start(int cpu,
 		    unsigned long pc, unsigned long sp,
 		    unsigned long gp, unsigned long a0)
 {
@@ -56,10 +57,10 @@ void amon_cpu_start(int cpu,
 		(struct cpulaunch  *)CKSEG0ADDR(CPULAUNCH);
 
 	if (!amon_cpu_avail(cpu))
-		return;
+		return -1;
 	if (cpu == smp_processor_id()) {
 		pr_debug("launch: I am cpu%d!\n", cpu);
-		return;
+		return -1;
 	}
 	launch += cpu;
 
@@ -78,4 +79,21 @@ void amon_cpu_start(int cpu,
 		;
 	smp_rmb();	/* Target will be updating flags soon */
 	pr_debug("launch: cpu%d gone!\n", cpu);
+
+	return 0;
+}
+
+#ifdef CONFIG_MIPS_VPE_LOADER
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
 }
+#endif
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index be4a1092..ea9338d 100644
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
@@ -44,6 +45,7 @@
 #include <asm/gic.h>
 #include <asm/gcmpregs.h>
 #include <asm/setup.h>
+#include <asm/rtlx.h>
 
 int gcmp_present = -1;
 static unsigned long _msc01_biu_base;
@@ -126,6 +128,11 @@ static void malta_hw0_irqdispatch(void)
 	}
 
 	do_IRQ(MALTA_INT_BASE + irq);
+
+#ifdef MIPS_VPE_APSP_API
+	if (aprp_hook)
+		aprp_hook();
+#endif
 }
 
 static void malta_ipi_irqdispatch(void)
@@ -313,6 +320,11 @@ static void ipi_call_dispatch(void)
 
 static irqreturn_t ipi_resched_interrupt(int irq, void *dev_id)
 {
+#ifdef MIPS_VPE_APSP_API
+	if (aprp_hook)
+		aprp_hook();
+#endif
+
 	scheduler_ipi();
 
 	return IRQ_HANDLED;
-- 
1.7.9.5
