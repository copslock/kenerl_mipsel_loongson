Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 10:52:16 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:53430 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903632Ab2EQIvq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 May 2012 10:51:46 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q4H8pdql011015;
        Thu, 17 May 2012 01:51:39 -0700
Received: from fun-lab.MIPSCN.CEC (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Thu, 17 May 2012
 01:51:36 -0700
From:   Deng-Cheng Zhu <dczhu@mips.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <kevink@paralogos.com>
CC:     <dczhu@mips.com>
Subject: [PATCH v2 1/2] MIPS: fix/enrich 34K APRP (APSP) functionalities
Date:   Thu, 17 May 2012 16:51:19 +0800
Message-ID: <1337244680-29968-2-git-send-email-dczhu@mips.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1337244680-29968-1-git-send-email-dczhu@mips.com>
References: <1337244680-29968-1-git-send-email-dczhu@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: Z0bWwchS04h2YCR9jzAHmw==
X-archive-position: 33339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Deng-Cheng Zhu <dczhu@mips.com>

This patch makes 34K APRP (also known as APSP) works. Also, it allows the
RP side to run floating point heavy jobs and uses interrupt to wake up RP
side read. These functionalities need proper RP code to work correctly.

For a 34Kf core, currently we simply disable the FPU on the AP side. And RP
will init it and use it exclusively.

Sample programs were created and tests had been done sucessfully.

Signed-off-by: Deng-Cheng Zhu <dczhu@mips.com>
---
Changes:
v2 - v1:
o Rebase the patch to the latest kernel, and fix a bunch of warnings and
  errors reported by the current scripts/checkpatch.pl. However, there are
  still 2 warnings that I think don't make sense:
  1) please write a paragraph that describes the config symbol fully
     #44: FILE: arch/mips/Kconfig:1969:
     +config MIPS_SP_FP_INTENSIVE
  2) EXPORT_SYMBOL(foo); should immediately follow its function/variable
     #205: FILE: arch/mips/mti-malta/malta-int.c:127:
     +EXPORT_SYMBOL(aprp_dispatch);
o Add MIPS_MALTA dependency to Kconfig since modifications of Malta files
  are needed. But it should be easy to port changes to other platforms.

 arch/mips/Kconfig                                  |   10 +++++-
 .../include/asm/mach-malta/cpu-feature-overrides.h |    3 ++
 arch/mips/include/asm/rtlx.h                       |    2 +
 arch/mips/kernel/rtlx.c                            |   33 +++++++++++++++++---
 arch/mips/kernel/vpe.c                             |    2 +-
 arch/mips/mti-malta/malta-int.c                    |   25 ++++++++++++++-
 6 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ce30e2f..8205afe 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1925,7 +1925,7 @@ config MIPS_MT_FPAFF
 
 config MIPS_VPE_LOADER
 	bool "VPE loader support."
-	depends on SYS_SUPPORTS_MULTITHREADING
+	depends on SYS_SUPPORTS_MULTITHREADING && MIPS_MALTA
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select MIPS_MT
@@ -1966,6 +1966,14 @@ config MIPS_VPE_LOADER_TOM
 	  you to ensure the amount you put in the option and the space your
 	  program requires is less or equal to the amount physically present.
 
+config MIPS_SP_FP_INTENSIVE
+	bool "SP is used for running FP-intensive jobs"
+	depends on MIPS_VPE_LOADER
+	---help---
+	  If you intend to use the SP to run FP-intensive jobs, you probably
+	  want to say yes here. Your FPU will then be exclusively used by the
+	  SP, and the Linux on the AP side will not see the FPU.
+
 # this should possibly be in drivers/char, but it is rather cpu related. Hmmm
 config MIPS_VPE_APSP_API
 	bool "Enable support for AP/SP API (RTLX)"
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
diff --git a/arch/mips/include/asm/rtlx.h b/arch/mips/include/asm/rtlx.h
index 4ca3063..cf23a8c 100644
--- a/arch/mips/include/asm/rtlx.h
+++ b/arch/mips/include/asm/rtlx.h
@@ -28,6 +28,8 @@ extern ssize_t rtlx_write(int index, const void __user *buffer, size_t count);
 extern unsigned int rtlx_read_poll(int index, int can_sleep);
 extern unsigned int rtlx_write_poll(int index);
 
+extern void (*aprp_dispatch)(void);
+
 enum rtlx_state {
 	RTLX_STATE_UNUSED = 0,
 	RTLX_STATE_INITIALISED,
diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index b8c18dc..9522aa5 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2005 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2005, 2012 MIPS Technologies, Inc.  All rights reserved.
  * Copyright (C) 2005, 06 Ralf Baechle (ralf@linux-mips.org)
  *
  *  This program is free software; you can distribute it and/or modify it
@@ -54,12 +54,14 @@ static struct chan_waitqueues {
 
 static struct vpe_notifications notify;
 static int sp_stopping;
+static void (*save_aprp_dispatch)(void);
 
 extern void *vpe_get_shared(int index);
 
 static void rtlx_dispatch(void)
 {
-	do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ);
+	if (read_c0_cause() & read_c0_status() & C_SW0)
+		do_IRQ(MIPS_CPU_IRQ_BASE + MIPS_CPU_RTLX_IRQ);
 }
 
 
@@ -343,6 +345,18 @@ out:
 	return count;
 }
 
+static void _interrupt_sp(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	dvpe();
+	settc(1);
+	write_vpe_c0_cause(read_vpe_c0_cause() | C_SW0);
+	evpe(EVPE_ENABLE);
+	local_irq_restore(flags);
+}
+
 ssize_t rtlx_write(int index, const void __user *buffer, size_t count)
 {
 	struct rtlx_channel *rt;
@@ -383,6 +397,8 @@ out:
 	smp_wmb();
 	mutex_unlock(&channel_wqs[index].mutex);
 
+	_interrupt_sp();
+
 	return count;
 }
 
@@ -524,9 +540,15 @@ static int __init rtlx_module_init(void)
 	notify.stop = stopping;
 	vpe_notify(tclimit, &notify);
 
-	if (cpu_has_vint)
-		set_vi_handler(MIPS_CPU_RTLX_IRQ, rtlx_dispatch);
-	else {
+	if (cpu_has_vint) {
+		/*
+		 * set_vi_handler() doesn't work in some cases: When sw0
+		 * gets set, a hw interrupt is signaled as well. Here we
+		 * are hooking it into platform specific dispatch.
+		 */
+		save_aprp_dispatch = aprp_dispatch;
+		aprp_dispatch = rtlx_dispatch;
+	} else {
 		pr_err("APRP RTLX init on non-vectored-interrupt processor\n");
 		err = -ENODEV;
 		goto out_chrdev;
@@ -552,6 +574,7 @@ static void __exit rtlx_module_exit(void)
 		device_destroy(mt_class, MKDEV(major, i));
 
 	unregister_chrdev(major, module_name);
+	aprp_dispatch = save_aprp_dispatch;
 }
 
 module_init(rtlx_module_init);
diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index f6f9152..b1f69f2 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2004, 2005 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2004, 2005, 2012 MIPS Technologies, Inc.  All rights reserved.
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 7b13a4c..62d77df 100644
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
@@ -30,6 +30,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/kernel.h>
 #include <linux/random.h>
+#include <linux/module.h>
 
 #include <asm/traps.h>
 #include <asm/i8259.h>
@@ -117,6 +118,15 @@ static inline int get_int(void)
 	return irq;
 }
 
+#ifdef CONFIG_MIPS_VPE_APSP_API
+static void null_aprp_dispatch(void)
+{
+}
+
+void (*aprp_dispatch)(void);
+EXPORT_SYMBOL(aprp_dispatch);
+#endif
+
 static void malta_hw0_irqdispatch(void)
 {
 	int irq;
@@ -128,6 +138,15 @@ static void malta_hw0_irqdispatch(void)
 	}
 
 	do_IRQ(MALTA_INT_BASE + irq);
+
+#ifdef CONFIG_MIPS_VPE_APSP_API
+	/*
+	 * When sw0 gets set, a spurious hw interrupt is signaled as well.
+	 * The sw0 will not be handled until the hw interrupt is cleared.
+	 * We use the hook to handle sw0 and the hw interrupt gets cleared.
+	 */
+	aprp_dispatch();
+#endif
 }
 
 static void malta_ipi_irqdispatch(void)
@@ -619,6 +638,10 @@ void __init arch_init_irq(void)
 		arch_init_ipiirq(cpu_ipi_call_irq, &irq_call);
 #endif
 	}
+
+#ifdef CONFIG_MIPS_VPE_APSP_API
+	aprp_dispatch = null_aprp_dispatch;
+#endif
 }
 
 void malta_be_init(void)
-- 
1.7.1
