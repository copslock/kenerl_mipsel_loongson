Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 13:28:13 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9867 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012091AbbLBMWnOBMeA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 13:22:43 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 6B408D46019D8;
        Wed,  2 Dec 2015 12:22:34 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 2 Dec 2015 12:22:36 +0000
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 2 Dec 2015 12:22:35 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <jiang.liu@linux.intel.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH v3 18/19] MIPS: Delete smp-gic.c
Date:   Wed, 2 Dec 2015 12:21:59 +0000
Message-ID: <1449058920-21011-19-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1449058920-21011-1-git-send-email-qais.yousef@imgtec.com>
References: <1449058920-21011-1-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

We now have a generic IPI layer that will use GIC automatically
if it's compiled in.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
---
 arch/mips/Kconfig          |  6 -----
 arch/mips/kernel/Makefile  |  1 -
 arch/mips/kernel/smp-gic.c | 64 ----------------------------------------------
 3 files changed, 71 deletions(-)
 delete mode 100644 arch/mips/kernel/smp-gic.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e3aa5b0b4ef1..5a73c1217af7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2123,7 +2123,6 @@ config MIPS_MT_SMP
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select SYNC_R4K
-	select MIPS_GIC_IPI
 	select MIPS_MT
 	select SMP
 	select SMP_UP
@@ -2221,7 +2220,6 @@ config MIPS_VPE_APSP_API_MT
 config MIPS_CMP
 	bool "MIPS CMP framework support (DEPRECATED)"
 	depends on SYS_SUPPORTS_MIPS_CMP && !CPU_MIPSR6
-	select MIPS_GIC_IPI
 	select SMP
 	select SYNC_R4K
 	select SYS_SUPPORTS_SMP
@@ -2241,7 +2239,6 @@ config MIPS_CPS
 	select MIPS_CM
 	select MIPS_CPC
 	select MIPS_CPS_PM if HOTPLUG_CPU
-	select MIPS_GIC_IPI
 	select SMP
 	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
 	select SYS_SUPPORTS_HOTPLUG_CPU
@@ -2259,9 +2256,6 @@ config MIPS_CPS_PM
 	select MIPS_CPC
 	bool
 
-config MIPS_GIC_IPI
-	bool
-
 config MIPS_CM
 	bool
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index d982be1ea1c3..a4bfc41d46b5 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -51,7 +51,6 @@ obj-$(CONFIG_MIPS_MT_FPAFF)	+= mips-mt-fpaff.o
 obj-$(CONFIG_MIPS_MT_SMP)	+= smp-mt.o
 obj-$(CONFIG_MIPS_CMP)		+= smp-cmp.o
 obj-$(CONFIG_MIPS_CPS)		+= smp-cps.o cps-vec.o
-obj-$(CONFIG_MIPS_GIC_IPI)	+= smp-gic.o
 obj-$(CONFIG_MIPS_SPRAM)	+= spram.o
 
 obj-$(CONFIG_MIPS_VPE_LOADER)	+= vpe.o
diff --git a/arch/mips/kernel/smp-gic.c b/arch/mips/kernel/smp-gic.c
deleted file mode 100644
index 5f0ab5bcd01e..000000000000
--- a/arch/mips/kernel/smp-gic.c
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * Copyright (C) 2013 Imagination Technologies
- * Author: Paul Burton <paul.burton@imgtec.com>
- *
- * Based on smp-cmp.c:
- *  Copyright (C) 2007 MIPS Technologies, Inc.
- *  Author: Chris Dearman (chris@mips.com)
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/irqchip/mips-gic.h>
-#include <linux/printk.h>
-
-#include <asm/mips-cpc.h>
-#include <asm/smp-ops.h>
-
-void gic_send_ipi_single(int cpu, unsigned int action)
-{
-	unsigned long flags;
-	unsigned int intr;
-	unsigned int core = cpu_data[cpu].core;
-
-	pr_debug("CPU%d: %s cpu %d action %u status %08x\n",
-		 smp_processor_id(), __func__, cpu, action, read_c0_status());
-
-	local_irq_save(flags);
-
-	switch (action) {
-	case SMP_CALL_FUNCTION:
-		intr = plat_ipi_call_int_xlate(cpu);
-		break;
-
-	case SMP_RESCHEDULE_YOURSELF:
-		intr = plat_ipi_resched_int_xlate(cpu);
-		break;
-
-	default:
-		BUG();
-	}
-
-	gic_send_ipi(intr);
-
-	if (mips_cpc_present() && (core != current_cpu_data.core)) {
-		while (!cpumask_test_cpu(cpu, &cpu_coherent_mask)) {
-			mips_cpc_lock_other(core);
-			write_cpc_co_cmd(CPC_Cx_CMD_PWRUP);
-			mips_cpc_unlock_other();
-		}
-	}
-
-	local_irq_restore(flags);
-}
-
-void gic_send_ipi_mask(const struct cpumask *mask, unsigned int action)
-{
-	unsigned int i;
-
-	for_each_cpu(i, mask)
-		gic_send_ipi_single(i, action);
-}
-- 
2.1.0
