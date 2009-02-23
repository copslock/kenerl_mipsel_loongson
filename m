Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2009 16:26:46 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:29180 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S20808054AbZBWQ0o (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Feb 2009 16:26:44 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n1NGQZAj006483;
	Mon, 23 Feb 2009 08:26:35 -0800 (PST)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 23 Feb 2009 08:26:35 -0800
Received: from localhost.localdomain ([128.224.146.23]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 23 Feb 2009 08:26:35 -0800
From:	Mark Asselstine <mark.asselstine@windriver.com>
To:	linux-mips@linux-mips.org, oprofile-list@lists.sf.net
Subject: [PATCH] oprofile: VR5500 performance counter driver
Date:	Mon, 23 Feb 2009 11:26:34 -0500
Message-Id: <1235406394-2650-1-git-send-email-mark.asselstine@windriver.com>
X-Mailer: git-send-email 1.5.5.1
X-OriginalArrivalTime: 23 Feb 2009 16:26:35.0159 (UTC) FILETIME=[7E9C7270:01C995D3]
Return-Path: <Mark.Asselstine@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.asselstine@windriver.com
Precedence: bulk
X-list: linux-mips

This is inspired by op_model_mipsxx.c with some modification
in regards to register layout and overflow handling. This has
been tested on a NEC VR5500 board and shown to produce sane
results.

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>

diff --git a/arch/mips/oprofile/Makefile b/arch/mips/oprofile/Makefile
index cfd4b60..977a828 100644
--- a/arch/mips/oprofile/Makefile
+++ b/arch/mips/oprofile/Makefile
@@ -14,4 +14,5 @@ oprofile-$(CONFIG_CPU_MIPS32)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_MIPS64)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_R10000)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
+oprofile-$(CONFIG_CPU_VR5500)		+= op_model_vr5500.o
 oprofile-$(CONFIG_CPU_RM9000)		+= op_model_rm9000.o
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index e1bffab..68aad99 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -17,6 +17,7 @@
 
 extern struct op_mips_model op_model_mipsxx_ops __attribute__((weak));
 extern struct op_mips_model op_model_rm9000_ops __attribute__((weak));
+extern struct op_mips_model op_model_vr5500_ops __attribute__((weak));
 
 static struct op_mips_model *model;
 
@@ -94,6 +95,10 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_RM9000:
 		lmodel = &op_model_rm9000_ops;
 		break;
+
+	case CPU_R5500:
+		lmodel = &op_model_vr5500_ops;
+		break;
 	};
 
 
diff --git a/arch/mips/oprofile/op_model_vr5500.c b/arch/mips/oprofile/op_model_vr5500.c
new file mode 100644
index 0000000..75fae6a
--- /dev/null
+++ b/arch/mips/oprofile/op_model_vr5500.c
@@ -0,0 +1,179 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 2009 Wind River Systems, Inc.
+ */
+#include <linux/cpumask.h>
+#include <linux/oprofile.h>
+#include <linux/interrupt.h>
+#include <linux/smp.h>
+#include <asm/irq_regs.h>
+
+#include "op_impl.h"
+
+#define M_PERFCTL_EXL			(1UL      <<  0)
+#define M_PERFCTL_KERNEL		(1UL      <<  1)
+#define M_PERFCTL_SUPERVISOR		(1UL      <<  2)
+#define M_PERFCTL_USER			(1UL      <<  3)
+#define M_PERFCTL_INTERRUPT_ENABLE	(1UL      <<  4)
+#define M_PERFCTL_INTERRUPT		(1UL      <<  5)
+#define M_PERFCTL_EVENT(event)		(((event) & 0xf)  << 6)
+#define M_PERFCTL_COUNT_ENABLE		(1UL      <<  10)
+
+#define NUM_COUNTERS                    2
+
+static int (*save_perf_irq) (void);
+
+#define __define_perf_accessors(r, n)    				\
+									\
+	static inline unsigned int r_c0_ ## r ## n(void)		\
+	{								\
+		return read_c0_ ## r ## n();				\
+	}								\
+									\
+	static inline void w_c0_ ## r ## n(unsigned int value)		\
+	{								\
+		write_c0_ ## r ## n(value);				\
+	}								\
+
+__define_perf_accessors(perfcntr, 0)
+__define_perf_accessors(perfcntr, 1)
+
+__define_perf_accessors(perfctrl, 0)
+__define_perf_accessors(perfctrl, 1)
+
+struct op_mips_model op_model_vr5500_ops;
+
+static struct vr5500_register_config {
+	unsigned int control[NUM_COUNTERS];
+	unsigned int counter[NUM_COUNTERS];
+} reg;
+
+/* Compute all of the registers in preparation for enabling profiling.  */
+static void vr5500_reg_setup(struct op_counter_config *ctr)
+{
+	int i;
+	unsigned int counters = NUM_COUNTERS;
+
+	/* Compute the performance counter control word.  */
+	for (i = 0; i < counters; i++) {
+		reg.control[i] = 0;
+		reg.counter[i] = 0;
+
+		if (!ctr[i].enabled)
+			continue;
+
+		reg.control[i] = M_PERFCTL_EVENT(ctr[i].event) |
+		    M_PERFCTL_INTERRUPT_ENABLE | M_PERFCTL_COUNT_ENABLE;
+		if (ctr[i].kernel)
+			reg.control[i] |= M_PERFCTL_KERNEL;
+		if (ctr[i].user)
+			reg.control[i] |= M_PERFCTL_USER;
+		if (ctr[i].exl)
+			reg.control[i] |= M_PERFCTL_EXL;
+
+		reg.counter[i] = 0xffffffff - ctr[i].count + 1;
+	}
+}
+
+/* Program all of the registers in preparation for enabling profiling.  */
+static void vr5500_cpu_setup(void *args)
+{
+	w_c0_perfctrl1(0);
+	w_c0_perfcntr1(reg.counter[1]);
+
+	w_c0_perfctrl0(0);
+	w_c0_perfcntr0(reg.counter[0]);
+}
+
+/* Start all counters on current CPU */
+static void vr5500_cpu_start(void *args)
+{
+	w_c0_perfctrl1(reg.control[1]);
+	w_c0_perfctrl0(reg.control[0]);
+}
+
+/* Stop all counters on current CPU */
+static void vr5500_cpu_stop(void *args)
+{
+	w_c0_perfctrl1(0);
+	w_c0_perfctrl0(0);
+}
+
+static int vr5500_perfcount_handler(void)
+{
+	unsigned int control;
+	unsigned int counter;
+	int handled = IRQ_NONE;
+	unsigned int counters = NUM_COUNTERS;
+
+	if (cpu_has_mips_r2 && !(read_c0_cause() & (1 << 26)))
+		return handled;
+
+	switch (counters) {
+	#define HANDLE_COUNTER(n) 					\
+	case n + 1:							\
+		control = r_c0_perfctrl ## n();				\
+		counter = r_c0_perfcntr ## n();				\
+		if ((control & M_PERFCTL_INTERRUPT_ENABLE) &&		\
+			(control & M_PERFCTL_INTERRUPT)) {		\
+			oprofile_add_sample(get_irq_regs(), n);		\
+			w_c0_perfcntr ## n(reg.counter[n]);		\
+			w_c0_perfctrl ## n(control & ~M_PERFCTL_INTERRUPT); \
+			handled = IRQ_HANDLED;				\
+		}
+	HANDLE_COUNTER(1)
+	HANDLE_COUNTER(0)
+	}
+
+	return handled;
+}
+
+static void reset_counters(void *arg)
+{
+	w_c0_perfctrl1(0);
+	w_c0_perfcntr1(0);
+
+	w_c0_perfctrl0(0);
+	w_c0_perfcntr0(0);
+}
+
+static int __init vr5500_init(void)
+{
+	on_each_cpu(reset_counters, NULL, 1);
+
+	switch (current_cpu_type()) {
+	case CPU_R5500:
+		op_model_vr5500_ops.cpu_type = "mips/vr5500";
+		break;
+
+	default:
+		printk(KERN_ERR "Profiling unsupported for this CPU\n");
+
+		return -ENODEV;
+	}
+
+	save_perf_irq = perf_irq;
+	perf_irq = vr5500_perfcount_handler;
+
+	return 0;
+}
+
+static void vr5500_exit(void)
+{
+	on_each_cpu(reset_counters, NULL, 1);
+
+	perf_irq = save_perf_irq;
+}
+
+struct op_mips_model op_model_vr5500_ops = {
+	.reg_setup = vr5500_reg_setup,
+	.cpu_setup = vr5500_cpu_setup,
+	.init = vr5500_init,
+	.exit = vr5500_exit,
+	.cpu_start = vr5500_cpu_start,
+	.cpu_stop = vr5500_cpu_stop,
+	.num_counters = NUM_COUNTERS,
+};
