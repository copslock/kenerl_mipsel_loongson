Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 01:19:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:11687 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038685AbWJWATY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Oct 2006 01:19:24 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9N0JlHh011489;
	Mon, 23 Oct 2006 01:19:47 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9N0Jlxg011488;
	Mon, 23 Oct 2006 01:19:47 +0100
Date:	Mon, 23 Oct 2006 01:19:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Karl-Johan Karlsson <creideiki+linux-mips@ferretporn.se>
Cc:	linux-mips@linux-mips.org
Subject: Re: Extreme system overhead on large IP27
Message-ID: <20061023001947.GA10853@linux-mips.org>
References: <200610212159.04965.creideiki+linux-mips@ferretporn.se> <20061022152158.GB17776@linux-mips.org> <20061022232316.GA19127@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061022232316.GA19127@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 23, 2006 at 12:23:16AM +0100, Ralf Baechle wrote:

> Okay, turns out as I suspected one of the well facts well disguised by the
> R10000, MIPS32 and MIPS64 architecture manuals is that the R10000 MFPS,
> MFPC, MTPS, MTPC instructions use the same encoding as MIPS32/MIPS64 mfc0
> instructions with a selector argument,  So getting oprofile to actually
> work on the R10000 family won't be hard.

Can you test below patch which adds oprofile support for the R10000
family processors?  The patch only adds support for these processors;
it doesn't attempt to get things right for mixes of R10000 and R12000
processors, so as a hint for usage:

 * oprofile will detect the number of performance counters on whatever
   processor (likely to be CPU 0) executes its intialization code.  Whatever
   the result of this detection, oprofile will believe all processors
   are identical.
 * R10000 processors have 2 counters, R12000 processors have 4 counters.
   As the result a mixed configuration will be limited to only 2 counters.
 * R10000 and R12000 processors have different events.  Only the events
   that are identical on both processors can be used.  Most interesting
   these are:

   Counters 0, 1   CYCLES
   Counter  0      INSTRUCTIONS_GRADUATED

  Ralf

[MIPS] Oprofile: kernel support for the R10000.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/oprofile/Makefile b/arch/mips/oprofile/Makefile
index 0a50aad..a54362c 100644
--- a/arch/mips/oprofile/Makefile
+++ b/arch/mips/oprofile/Makefile
@@ -12,5 +12,6 @@ oprofile-y				:= $(DRIVER_OBJS) common.o
 
 oprofile-$(CONFIG_CPU_MIPS32)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_MIPS64)		+= op_model_mipsxx.o
+oprofile-$(CONFIG_CPU_R10000)		+= op_model_r10k.o
 oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_RM9000)		+= op_model_rm9000.o
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index 65eb554..2524215 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -15,6 +15,7 @@ #include <asm/cpu-info.h>
 #include "op_impl.h"
 
 extern struct op_mips_model op_model_mipsxx_ops __attribute__((weak));
+extern struct op_mips_model op_model_r10k_ops __attribute__((weak));
 extern struct op_mips_model op_model_rm9000_ops __attribute__((weak));
 
 static struct op_mips_model *model;
@@ -86,6 +87,12 @@ int __init oprofile_arch_init(struct opr
 		lmodel = &op_model_mipsxx_ops;
 		break;
 
+	case CPU_R10000:
+	case CPU_R12000:
+	case CPU_R14000:
+		lmodel = &op_model_r10k_ops;;
+		break;
+
 	case CPU_RM9000:
 		lmodel = &op_model_rm9000_ops;
 		break;
diff --git a/arch/mips/oprofile/op_model_r10k.c b/arch/mips/oprofile/op_model_r10k.c
new file mode 100644
index 0000000..6dd2a5e
--- /dev/null
+++ b/arch/mips/oprofile/op_model_r10k.c
@@ -0,0 +1,227 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004, 05, 06 by Ralf Baechle
+ * Copyright (C) 2005 by MIPS Technologies, Inc.
+ */
+#include <linux/oprofile.h>
+#include <linux/interrupt.h>
+#include <linux/smp.h>
+#include <asm/irq_regs.h>
+
+#include "op_impl.h"
+
+#define M_PERFCTL_EXL			(1UL    <<  0)
+#define M_PERFCTL_KERNEL		(1UL    <<  1)
+#define M_PERFCTL_SUPERVISOR		(1UL    <<  2)
+#define M_PERFCTL_USER			(1UL    <<  3)
+#define M_PERFCTL_INTERRUPT_ENABLE	(1UL    <<  4)
+#define M_PERFCTL_EVENT(event)		((event) << 5)
+#define M_PERFCTL_WIDE			(1UL    << 30)
+#define M_PERFCTL_MORE			(1UL    << 31)
+
+#define M_COUNTER_OVERFLOW		(1UL    << 31)
+
+struct op_mips_model op_model_r10k_ops;
+
+static struct r10k_register_config {
+	unsigned int control[4];
+	unsigned int counter[4];
+} reg;
+
+/* Compute all of the registers in preparation for enabling profiling.  */
+
+static void r10k_reg_setup(struct op_counter_config *ctr)
+{
+	unsigned int counters = op_model_r10k_ops.num_counters;
+	int i;
+
+	/* Compute the performance counter control word.  */
+	/* For now count kernel and user mode */
+	for (i = 0; i < counters; i++) {
+		reg.control[i] = 0;
+		reg.counter[i] = 0;
+
+		if (!ctr[i].enabled)
+			continue;
+
+		reg.control[i] = M_PERFCTL_EVENT(ctr[i].event) |
+		                 M_PERFCTL_INTERRUPT_ENABLE;
+		if (ctr[i].kernel)
+			reg.control[i] |= M_PERFCTL_KERNEL;
+		if (ctr[i].user)
+			reg.control[i] |= M_PERFCTL_USER;
+		if (ctr[i].exl)
+			reg.control[i] |= M_PERFCTL_EXL;
+		reg.counter[i] = 0x80000000 - ctr[i].count;
+	}
+}
+
+/* Program all of the registers in preparation for enabling profiling.  */
+
+static void r10k_cpu_setup (void *args)
+{
+	unsigned int counters = op_model_r10k_ops.num_counters;
+
+	switch (counters) {
+	case 4:
+		write_c0_perfctrl3(0);
+		write_c0_perfcntr3(reg.counter[3]);
+	case 3:
+		write_c0_perfctrl2(0);
+		write_c0_perfcntr2(reg.counter[2]);
+	case 2:
+		write_c0_perfctrl1(0);
+		write_c0_perfcntr1(reg.counter[1]);
+	case 1:
+		write_c0_perfctrl0(0);
+		write_c0_perfcntr0(reg.counter[0]);
+	}
+}
+
+/* Start all counters on current CPU */
+static void r10k_cpu_start(void *args)
+{
+	unsigned int counters = op_model_r10k_ops.num_counters;
+
+	switch (counters) {
+	case 4:
+		write_c0_perfctrl3(reg.control[3]);
+	case 3:
+		write_c0_perfctrl2(reg.control[2]);
+	case 2:
+		write_c0_perfctrl1(reg.control[1]);
+	case 1:
+		write_c0_perfctrl0(reg.control[0]);
+	}
+}
+
+/* Stop all counters on current CPU */
+static void r10k_cpu_stop(void *args)
+{
+	unsigned int counters = op_model_r10k_ops.num_counters;
+
+	switch (counters) {
+	case 4:
+		write_c0_perfctrl3(0);
+	case 3:
+		write_c0_perfctrl2(0);
+	case 2:
+		write_c0_perfctrl1(0);
+	case 1:
+		write_c0_perfctrl0(0);
+	}
+}
+
+static int r10k_perfcount_handler(void)
+{
+	unsigned int counters = op_model_r10k_ops.num_counters;
+	unsigned int control;
+	unsigned int counter;
+	int handled = 0;
+
+	switch (counters) {
+#define HANDLE_COUNTER(n)						\
+	case n + 1:							\
+		control = read_c0_perfctrl ## n();			\
+		counter = read_c0_perfcntr ## n();			\
+		if ((control & M_PERFCTL_INTERRUPT_ENABLE) &&		\
+		    (counter & M_COUNTER_OVERFLOW)) {			\
+			oprofile_add_sample(get_irq_regs(), n);		\
+			write_c0_perfcntr ## n(reg.counter[n]);		\
+			handled = 1;					\
+		}
+	HANDLE_COUNTER(3)
+	HANDLE_COUNTER(2)
+	HANDLE_COUNTER(1)
+	HANDLE_COUNTER(0)
+	}
+
+	return handled;
+}
+
+#define M_CONFIG1_PC	(1 << 4)
+
+static inline int n_counters(void)
+{
+	switch (current_cpu_data.cputype) {
+	case CPU_R10000:
+	case CPU_R12000:
+		return 2;
+
+	case CPU_R14000:
+		return 4;
+	}
+
+	return 0;
+}
+
+static inline void reset_counters(int counters)
+{
+	switch (counters) {
+	case 4:
+		write_c0_perfctrl3(0);
+		write_c0_perfcntr3(0);
+	case 3:
+		write_c0_perfctrl2(0);
+		write_c0_perfcntr2(0);
+	case 2:
+		write_c0_perfctrl1(0);
+		write_c0_perfcntr1(0);
+	case 1:
+		write_c0_perfctrl0(0);
+		write_c0_perfcntr0(0);
+	}
+}
+
+static int __init r10k_init(void)
+{
+	int counters;
+
+	counters = n_counters();
+	if (counters == 0) {
+		printk(KERN_ERR "Oprofile: CPU has no performance counters\n");
+		return -ENODEV;
+	}
+
+	reset_counters(counters);
+
+	op_model_r10k_ops.num_counters = counters;
+	switch (current_cpu_data.cputype) {
+	case CPU_R10000:
+		op_model_r10k_ops.cpu_type = "mips/r10000";
+		break;
+
+	case CPU_R12000:
+	case CPU_R14000:
+		op_model_r10k_ops.cpu_type = "mips/r12000";
+		break;
+
+	default:
+		printk(KERN_ERR "Profiling unsupported for this CPU\n");
+
+		return -ENODEV;
+	}
+
+	perf_irq = r10k_perfcount_handler;
+
+	return 0;
+}
+
+static void r10k_exit(void)
+{
+	reset_counters(op_model_r10k_ops.num_counters);
+
+	perf_irq = null_perf_irq;
+}
+
+struct op_mips_model op_model_r10k_ops = {
+	.reg_setup	= r10k_reg_setup,
+	.cpu_setup	= r10k_cpu_setup,
+	.init		= r10k_init,
+	.exit		= r10k_exit,
+	.cpu_start	= r10k_cpu_start,
+	.cpu_stop	= r10k_cpu_stop,
+};
