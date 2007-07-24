Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2007 10:20:42 +0100 (BST)
Received: from qb-out-0506.google.com ([72.14.204.226]:32960 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S28573707AbXGXJUk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jul 2007 10:20:40 +0100
Received: by qb-out-0506.google.com with SMTP id f9so1027763qba
        for <linux-mips@linux-mips.org>; Tue, 24 Jul 2007 02:20:29 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ECroWx098SyoLP1Fg9qzLhfuZFspZLs3kp6Cc6LJwnnt+TItXHgPubjl5iaaV+qMJuNZgA9I3+qsrwVJvT25GPgfDOvUWkCOYHaeVObjqWI2uLJvjXBAvjLgFtDMWp4LbCJFz3NkI3OBAZCs6Qc5ZuKylISXXmppHyOp0d0XMEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oug48bpH4yXSRQGRLmKwFNIcYQpmbbntXtE8eK0E0f4+my5cVVzVH9TiTWE6ctkMsnQ3LsQrZ2QTNS+FFj/gmIv07fAP+3vIv2fG1Y6SR7XIclteYYpqU38opsN5xBXBwj6yZKPEesqEmRUYPbk8Sga/cgKPIu0Bz0UZId6Y39k=
Received: by 10.114.155.1 with SMTP id c1mr3874845wae.1185268827691;
        Tue, 24 Jul 2007 02:20:27 -0700 (PDT)
Received: by 10.114.67.6 with HTTP; Tue, 24 Jul 2007 02:20:27 -0700 (PDT)
Message-ID: <5861a7880707240220g5d8129anc95e10bea833e323@mail.gmail.com>
Date:	Tue, 24 Jul 2007 13:20:27 +0400
From:	"Dajie Tan" <jiankemeng@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: [PATCH] Add support for profiling Loongson 2E
Cc:	linux-mips <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <jiankemeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiankemeng@gmail.com
Precedence: bulk
X-list: linux-mips

Hello,

This patch adds support for profiling Loongson 2E. It's been tested on
FuLong mini PC(loongson2e inside).


=======================================================================

diff -urN b/arch/mips/lemote/lm2e/irq.c a/arch/mips/lemote/lm2e/irq.c
--- b/arch/mips/lemote/lm2e/irq.c	2007-07-24 12:57:38.000000000 +0800
+++ a/arch/mips/lemote/lm2e/irq.c	2007-07-19 08:20:50.000000000 +0800
@@ -82,6 +82,8 @@

 	if (pending & CAUSEF_IP7) {
 		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
+ 	} else if (pending & CAUSEF_IP6) { 	/* performance counter
overflowe at IP6 */
+ 		do_IRQ(MIPS_CPU_IRQ_BASE + 6);
 	} else if (pending & CAUSEF_IP5) {
 		i8259_irqdispatch();
 	} else if (pending & CAUSEF_IP2) {
diff -urN b/arch/mips/oprofile/Makefile a/arch/mips/oprofile/Makefile
--- b/arch/mips/oprofile/Makefile	2007-07-24 12:58:48.000000000 +0800
+++ a/arch/mips/oprofile/Makefile	2007-07-19 08:20:53.000000000 +0800
@@ -15,4 +15,5 @@
 oprofile-$(CONFIG_CPU_R10000)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_RM9000)		+= op_model_rm9000.o
+oprofile-$(CONFIG_CPU_LOONGSON2)		+= op_model_loongson2e.o

diff -urN b/arch/mips/oprofile/common.c a/arch/mips/oprofile/common.c
--- b/arch/mips/oprofile/common.c	2007-07-24 12:59:33.000000000 +0800
+++ a/arch/mips/oprofile/common.c	2007-07-24 08:10:27.000000000 +0800
@@ -16,6 +16,7 @@

 extern struct op_mips_model op_model_mipsxx_ops __attribute__((weak));
 extern struct op_mips_model op_model_rm9000_ops __attribute__((weak));
+extern struct op_mips_model op_model_loongson2e_ops __attribute__((weak));

 static struct op_mips_model *model;

@@ -93,6 +94,10 @@
 		lmodel = &op_model_rm9000_ops;
 		break;

+	case CPU_LOONGSON2:
+		lmodel = &op_model_loongson2e_ops;
+		break;
+
 	};

 	if (!lmodel)
diff -urN b/arch/mips/oprofile/op_model_loongson2e.c
a/arch/mips/oprofile/op_model_loongson2e.c
--- b/arch/mips/oprofile/op_model_loongson2e.c	1970-01-01
08:00:00.000000000 +0800
+++ a/arch/mips/oprofile/op_model_loongson2e.c	2007-07-24
13:03:01.000000000 +0800
@@ -0,0 +1,170 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 by Dajie Tan <jiankemeng@gmail.com>
+ */
+
+#include <linux/init.h>
+#include <linux/oprofile.h>
+#include <linux/interrupt.h>
+#include <linux/smp.h>
+
+#include "op_impl.h"
+
+#define GODSON2E_PERFCTL_EXL			(1UL    <<  0)
+#define GODSON2E_PERFCTL_KERNEL			(1UL    <<  1)
+#define GODSON2E_PERFCTL_SUPERVISOR		(1UL    <<  2)
+#define GODSON2E_PERFCTL_USER			(1UL    <<  3)
+#define GODSON2E_PERFCTL_INTERRUPT_ENABLE	(1UL    <<  4)
+#define GODSON2E_PERFCTL_OVERFLOW		(1ULL	<< 31)
+
+#define GODSON2E_COUNTER1_EVENT(event)	((event) << 5)
+#define GODSON2E_COUNTER2_EVENT(event)	((event) << 9)
+
+
+/* IP6 --- performance counter overflow */
+static int loongson2e_pmc_irq = MIPS_CPU_IRQ_BASE + 6;
+
+
+static struct loongson2e_register_config {
+	unsigned int control;
+	unsigned int reset_counter1;
+	unsigned int reset_counter2;
+	int c1_enabled;
+	int c2_enabled;
+} reg;
+
+/* Compute all of the registers in preparation for enabling profiling.  */
+
+static void loongson2e_reg_setup(struct op_counter_config *ctr)
+{
+	unsigned int control = 0;
+
+	/* Compute the performance counter control word.  */
+	/* For now count kernel and user mode */
+	if (ctr[0].enabled)
+		control |= GODSON2E_COUNTER1_EVENT(ctr[0].event) |
+		           GODSON2E_PERFCTL_INTERRUPT_ENABLE;
+	else
+		control |= GODSON2E_COUNTER1_EVENT(0xe);
+
+	if (ctr[1].enabled)
+		control |= GODSON2E_COUNTER2_EVENT(ctr[1].event) |
+		           GODSON2E_PERFCTL_INTERRUPT_ENABLE;
+	else
+		control |= GODSON2E_COUNTER2_EVENT(0x3);
+
+	if (ctr[0].kernel || ctr[1].kernel)
+		control |= GODSON2E_PERFCTL_KERNEL;
+	else
+		control &= ~GODSON2E_PERFCTL_KERNEL;
+
+	if (ctr[0].user || ctr[1].user)
+		control |= GODSON2E_PERFCTL_USER;
+	else
+		control &= ~GODSON2E_PERFCTL_USER;
+
+	if (ctr[0].exl || ctr[1].exl)
+		control |= GODSON2E_PERFCTL_EXL;
+	else
+		control &= ~GODSON2E_PERFCTL_EXL;
+
+	reg.control = control;
+
+	reg.c1_enabled = ctr[0].enabled;
+	reg.c2_enabled = ctr[1].enabled;
+	reg.reset_counter1 = ctr[0].count ? 0x80000000 - ctr[0].count : 0;
+	reg.reset_counter2 = ctr[1].count ? 0x80000000 - ctr[1].count : 0;
+}
+
+static void loongson2e_cpu_setup (void *args)
+{
+	uint64_t perfcount;
+	perfcount = ((uint64_t) reg.reset_counter2 << 32) | reg.reset_counter1;
+	write_c0_pmc_count(perfcount);
+}
+
+static void loongson2e_cpu_start(void *args)
+{
+	/* Start all counters */
+	write_c0_pmc_control(reg.control);
+}
+
+static void loongson2e_cpu_stop(void *args)
+{
+	/* Stop all counters */
+	write_c0_pmc_control(0);
+}
+
+
+static irqreturn_t loongson2e_pmc_handler(int irq, void * dev_id)
+{
+	uint32_t counter1, counter2;
+	uint64_t counters;
+	uint64_t tmp = 0x0;
+	struct pt_regs *regs = get_irq_regs();
+
+	/*
+	 * Godson2e combines two 32-bit performance counters into a single
+	 * 64-bit coprocessor zero register.  To avoid a race updating the
+	 * registers we need to stop the counters while we're messing with
+	 * them ...
+	 */
+
+	write_c0_pmc_control(tmp);
+
+	counters = read_c0_pmc_count();
+	counter1 = counters;
+	counter2 = counters >> 32;
+
+	if (reg.c2_enabled && counter2 & GODSON2E_PERFCTL_OVERFLOW) {
+		oprofile_add_sample(regs, 1);
+		counter2 = reg.reset_counter2;
+	}
+
+	if (reg.c1_enabled && counter1 & GODSON2E_PERFCTL_OVERFLOW) {
+		oprofile_add_sample(regs, 0);
+		counter1 = reg.reset_counter1;
+	}
+
+	counters = ((uint64_t)counter2 << 32) | counter1;
+
+	write_c0_pmc_count(counters);
+	write_c0_pmc_control(reg.control);
+
+	return IRQ_HANDLED;
+}
+
+static int __init loongson2e_init(void)
+{
+	uint64_t tmp = 0;
+	write_c0_pmc_control(0);
+	write_c0_pmc_count(tmp);
+
+	return request_irq(loongson2e_pmc_irq, loongson2e_pmc_handler,
+	                   IRQF_DISABLED, "Perfcounter", NULL);
+}
+
+static void loongson2e_exit(void)
+{
+	uint64_t tmp = 0;
+	write_c0_pmc_control(0);
+	write_c0_pmc_count(tmp);
+
+	free_irq(loongson2e_pmc_irq, NULL);
+}
+
+struct op_mips_model op_model_loongson2e_ops = {
+	.reg_setup	= loongson2e_reg_setup,
+	.cpu_setup	= loongson2e_cpu_setup,
+	.init		= loongson2e_init,
+	.exit		= loongson2e_exit,
+	.cpu_start	= loongson2e_cpu_start,
+	.cpu_stop	= loongson2e_cpu_stop,
+	.cpu_type	= "mips/loongson2e",
+	.num_counters	= 2
+};
+
+
diff -urN b/include/asm-mips/mipsregs.h a/include/asm-mips/mipsregs.h
--- b/include/asm-mips/mipsregs.h	2007-07-24 13:02:29.000000000 +0800
+++ a/include/asm-mips/mipsregs.h	2007-07-19 08:22:44.000000000 +0800
@@ -594,6 +594,58 @@
 	: "r" (val), "i" (counter));				\
 } while (0)

+
+/*
+ * Macros to access the loongson2e system control coprocessor
+ */
+#define __read_64bit_c0_pmc_split(source, sel)				\
+({									\
+	unsigned long long val;						\
+	unsigned long flags;						\
+									\
+	local_irq_save(flags);						\
+	if (sel == 0)							\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dmfc0\t%M0, " #source "\n\t"			\
+			"dsll\t%L0, %M0, 32\n\t"			\
+			"dsra\t%M0, %M0, 32\n\t"			\
+			"dsra\t%L0, %L0, 32\n\t"			\
+			".set\tmips0"					\
+			: "=r" (val));					\
+	else								\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dmfc0\t%M0, " #source ", " #sel "\n\t"		\
+			"dsll\t%L0, %M0, 32\n\t"			\
+			"dsra\t%M0, %M0, 32\n\t"			\
+			"dsra\t%L0, %L0, 32\n\t"			\
+			".set\tmips0"					\
+			: "=r" (val));					\
+	local_irq_restore(flags);					\
+									\
+	val;								\
+})
+
+#define __read_64bit_c0_pmc(source, sel)				\
+({ unsigned long long __res;						\
+	if (sizeof(unsigned long) == 4)					\
+		__res = __read_64bit_c0_pmc_split(source, sel);		\
+	else if (sel == 0)						\
+		__asm__ __volatile__(					\
+			".set\tmips3\n\t"				\
+			"dmfc0\t%0, " #source "\n\t"			\
+			".set\tmips0"					\
+			: "=r" (__res));				\
+	else								\
+		__asm__ __volatile__(					\
+			".set\tmips64\n\t"				\
+			"dmfc0\t%0, " #source ", " #sel "\n\t"		\
+			".set\tmips0"					\
+			: "=r" (__res));				\
+	__res;								\
+})
+
 /*
  * Macros to access the system control coprocessor
  */
@@ -896,6 +948,14 @@
 #define read_c0_framemask()	__read_32bit_c0_register($21, 0)
 #define write_c0_framemask(val)	__write_32bit_c0_register($21, 0, val)

+/* Loongson2e PMC control register */
+#define read_c0_pmc_control()	__read_32bit_c0_register($24, 0)
+#define write_c0_pmc_control(val) __write_32bit_c0_register($24, 0, val)
+
+/* Loongson2e PMC counter register */
+#define read_c0_pmc_count()	__read_64bit_c0_pmc($25, 0)
+#define write_c0_pmc_count(val)	__write_64bit_c0_register($25, 0, val)
+
 /* RM9000 PerfControl performance counter control register */
 #define read_c0_perfcontrol()	__read_32bit_c0_register($22, 0)
 #define write_c0_perfcontrol(val) __write_32bit_c0_register($22, 0, val)
diff -urN b/drivers/oprofile/cpu_buffer.c a/drivers/oprofile/cpu_buffer.c
--- b/drivers/oprofile/cpu_buffer.c	2007-07-24 13:00:54.000000000 +0800
+++ a/drivers/oprofile/cpu_buffer.c	2007-07-19 08:22:15.000000000 +0800
@@ -148,6 +148,10 @@
            unsigned long pc, unsigned long event)
 {
 	struct op_sample * entry = &cpu_buf->buffer[cpu_buf->head_pos];
+
+	if(!entry)
+		return;
+
 	entry->eip = pc;
 	entry->event = event;
 	increment_head(cpu_buf);
