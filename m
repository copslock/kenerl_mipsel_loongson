Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2010 17:41:32 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:52735 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492022Ab0EOPjB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 May 2010 17:39:01 +0200
Received: by mail-pw0-f49.google.com with SMTP id 3so708651pwi.36
        for <multiple recipients>; Sat, 15 May 2010 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MOMbDJZs8qDBLw/nm7G+nmVNXmVY6sz5CxNO4+EsiLE=;
        b=ErRFbtkInhpcsgeAb8Qp6quEiWzBSewqNoF+gZyDcEiMhzJfakpnMtmD0ly9yeTLq3
         yxUz0ytbTrl8yqWaH+2708MQkHdteYxhYTq8IwdpqJcJA49kFugylf+bTSbrnOzi8yBk
         Kynv0Aat2ZNM8KiHWIrpn/69YGoR3Wq8muVb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YZoK1qDzC2Lfjef+zXGJXD/Y7R1gvJ7zqga9kCA7bmf6FqgxZJ0V4WcW+bn7iZjj/S
         skoj/5k9MEb7bQshPAyA+bB8KCV5TFFif3RFqTu+ecZnyB8AccOo6lrERuLU9zJBVVpz
         2ZOaqPpa6D89g/XLJDKaSKqg0K/uZqHlG1pXs=
Received: by 10.114.248.9 with SMTP id v9mr2329091wah.164.1273937940758;
        Sat, 15 May 2010 08:39:00 -0700 (PDT)
Received: from localhost.localdomain ([114.84.90.117])
        by mx.google.com with ESMTPS id n32sm30648683wae.10.2010.05.15.08.38.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 08:39:00 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v4 9/9] MIPS/Oprofile: remove old files and update Kconfig/Makefile
Date:   Sat, 15 May 2010 23:36:55 +0800
Message-Id: <1273937815-4781-10-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Now that Oprofile uses Perf-events as backend, its old framework files
are not needed. Kconfig is modified to let hardware performance events be
the prerequisite of Oprofile.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/Kconfig                       |    4 +-
 arch/mips/oprofile/Makefile             |    7 -
 arch/mips/oprofile/op_impl.h            |   39 -----
 arch/mips/oprofile/op_model_loongson2.c |  139 ------------------
 arch/mips/oprofile/op_model_mipsxx.c    |  237 -------------------------------
 arch/mips/oprofile/op_model_rm9000.c    |  124 ----------------
 6 files changed, 2 insertions(+), 548 deletions(-)
 delete mode 100644 arch/mips/oprofile/op_impl.h
 delete mode 100644 arch/mips/oprofile/op_model_loongson2.c
 delete mode 100644 arch/mips/oprofile/op_model_mipsxx.c
 delete mode 100644 arch/mips/oprofile/op_model_rm9000.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 27577b4..6f47117 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3,7 +3,7 @@ config MIPS
 	default y
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
-	select HAVE_OPROFILE
+	select HAVE_OPROFILE if HW_PERF_EVENTS
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
 	select GENERIC_ATOMIC64 if !64BIT
@@ -1890,7 +1890,7 @@ config NODES_SHIFT
 
 config HW_PERF_EVENTS
 	bool "Enable hardware performance counter support for perf events"
-	depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n && CPU_MIPS32
+	depends on PERF_EVENTS && !MIPS_MT_SMTC
 	default y
 	help
 	  Enable hardware performance counter support for perf events. If
diff --git a/arch/mips/oprofile/Makefile b/arch/mips/oprofile/Makefile
index 02cc65e..10ec71d 100644
--- a/arch/mips/oprofile/Makefile
+++ b/arch/mips/oprofile/Makefile
@@ -9,10 +9,3 @@ DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
 		timer_int.o )
 
 oprofile-y				:= $(DRIVER_OBJS) common.o
-
-oprofile-$(CONFIG_CPU_MIPS32)		+= op_model_mipsxx.o
-oprofile-$(CONFIG_CPU_MIPS64)		+= op_model_mipsxx.o
-oprofile-$(CONFIG_CPU_R10000)		+= op_model_mipsxx.o
-oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
-oprofile-$(CONFIG_CPU_RM9000)		+= op_model_rm9000.o
-oprofile-$(CONFIG_CPU_LOONGSON2)	+= op_model_loongson2.o
diff --git a/arch/mips/oprofile/op_impl.h b/arch/mips/oprofile/op_impl.h
deleted file mode 100644
index f04b54f..0000000
--- a/arch/mips/oprofile/op_impl.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/**
- * @file arch/alpha/oprofile/op_impl.h
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author Richard Henderson <rth@twiddle.net>
- */
-
-#ifndef OP_IMPL_H
-#define OP_IMPL_H 1
-
-extern int (*perf_irq)(void);
-
-/* Per-counter configuration as set via oprofilefs.  */
-struct op_counter_config {
-	unsigned long enabled;
-	unsigned long event;
-	unsigned long count;
-	/* Dummies because I am too lazy to hack the userspace tools.  */
-	unsigned long kernel;
-	unsigned long user;
-	unsigned long exl;
-	unsigned long unit_mask;
-};
-
-/* Per-architecture configury and hooks.  */
-struct op_mips_model {
-	void (*reg_setup) (struct op_counter_config *);
-	void (*cpu_setup) (void *dummy);
-	int (*init)(void);
-	void (*exit)(void);
-	void (*cpu_start)(void *args);
-	void (*cpu_stop)(void *args);
-	char *cpu_type;
-	unsigned char num_counters;
-};
-
-#endif
diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
deleted file mode 100644
index 9e61ecd..0000000
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ /dev/null
@@ -1,139 +0,0 @@
-/*
- * Loongson2 performance counter driver for oprofile
- *
- * Copyright (C) 2009 Lemote Inc.
- * Author: Yanhua <yanh@lemote.com>
- * Author: Wu Zhangjin <wuzhangjin@gmail.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/oprofile.h>
-#include <linux/interrupt.h>
-#include <asm/pmu.h>
-
-#include <loongson.h>			/* LOONGSON2_PERFCNT_IRQ */
-#include "op_impl.h"
-
-static struct loongson2_register_config {
-	unsigned int ctrl;
-	unsigned long long reset_counter1;
-	unsigned long long reset_counter2;
-	int cnt1_enabled, cnt2_enabled;
-} reg;
-
-static char *oprofid = "LoongsonPerf";
-static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id);
-
-static void loongson2_reg_setup(struct op_counter_config *cfg)
-{
-	unsigned int ctrl = 0;
-
-	reg.reset_counter1 = 0;
-	reg.reset_counter2 = 0;
-
-	/*
-	 * Compute the performance counter ctrl word.
-	 * For now, count kernel and user mode.
-	 */
-	if (cfg[0].enabled) {
-		ctrl |= LOONGSON2_PERFCTRL_EVENT(0, cfg[0].event);
-		reg.reset_counter1 = 0x80000000ULL - cfg[0].count;
-	}
-
-	if (cfg[1].enabled) {
-		ctrl |= LOONGSON2_PERFCTRL_EVENT(1, cfg[1].event);
-		reg.reset_counter2 = 0x80000000ULL - cfg[1].count;
-	}
-
-	if (cfg[0].enabled || cfg[1].enabled) {
-		ctrl |= LOONGSON2_PERFCTRL_EXL | LOONGSON2_PERFCTRL_ENABLE;
-		if (cfg[0].kernel || cfg[1].kernel)
-			ctrl |= LOONGSON2_PERFCTRL_KERNEL;
-		if (cfg[0].user || cfg[1].user)
-			ctrl |= LOONGSON2_PERFCTRL_USER;
-	}
-
-	reg.ctrl = ctrl;
-
-	reg.cnt1_enabled = cfg[0].enabled;
-	reg.cnt2_enabled = cfg[1].enabled;
-}
-
-static void loongson2_cpu_setup(void *args)
-{
-	write_c0_perfcnt((reg.reset_counter2 << 32) | reg.reset_counter1);
-}
-
-static void loongson2_cpu_start(void *args)
-{
-	/* Start all counters on current CPU */
-	if (reg.cnt1_enabled || reg.cnt2_enabled)
-		write_c0_perfctrl(reg.ctrl);
-}
-
-static void loongson2_cpu_stop(void *args)
-{
-	/* Stop all counters on current CPU */
-	write_c0_perfctrl(0);
-	memset(&reg, 0, sizeof(reg));
-}
-
-static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id)
-{
-	uint64_t counter, counter1, counter2;
-	struct pt_regs *regs = get_irq_regs();
-	int enabled;
-
-	/* Check whether the irq belongs to me */
-	enabled = read_c0_perfctrl() & LOONGSON2_PERFCTRL_ENABLE;
-	if (!enabled)
-		return IRQ_NONE;
-	enabled = reg.cnt1_enabled | reg.cnt2_enabled;
-	if (!enabled)
-		return IRQ_NONE;
-
-	counter = read_c0_perfcnt();
-	counter1 = counter & 0xffffffff;
-	counter2 = counter >> 32;
-
-	if (counter1 & LOONGSON2_PERFCNT_OVERFLOW) {
-		if (reg.cnt1_enabled)
-			oprofile_add_sample(regs, 0);
-		counter1 = reg.reset_counter1;
-	}
-	if (counter2 & LOONGSON2_PERFCNT_OVERFLOW) {
-		if (reg.cnt2_enabled)
-			oprofile_add_sample(regs, 1);
-		counter2 = reg.reset_counter2;
-	}
-
-	write_c0_perfcnt((counter2 << 32) | counter1);
-
-	return IRQ_HANDLED;
-}
-
-static int __init loongson2_init(void)
-{
-	return request_irq(LOONGSON2_PERFCNT_IRQ, loongson2_perfcount_handler,
-			   IRQF_SHARED, "Perfcounter", oprofid);
-}
-
-static void loongson2_exit(void)
-{
-	write_c0_perfctrl(0);
-	free_irq(LOONGSON2_PERFCNT_IRQ, oprofid);
-}
-
-struct op_mips_model op_model_loongson2_ops = {
-	.reg_setup = loongson2_reg_setup,
-	.cpu_setup = loongson2_cpu_setup,
-	.init = loongson2_init,
-	.exit = loongson2_exit,
-	.cpu_start = loongson2_cpu_start,
-	.cpu_stop = loongson2_cpu_stop,
-	.cpu_type = LOONGSON2_CPU_TYPE,
-	.num_counters = 2
-};
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
deleted file mode 100644
index 96f14e8..0000000
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ /dev/null
@@ -1,237 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2004, 05, 06 by Ralf Baechle
- * Copyright (C) 2005 by MIPS Technologies, Inc.
- */
-#include <linux/cpumask.h>
-#include <linux/oprofile.h>
-#include <linux/interrupt.h>
-#include <linux/smp.h>
-#include <asm/irq_regs.h>
-#include <asm/pmu.h>
-
-#include "op_impl.h"
-
-
-struct op_mips_model op_model_mipsxx_ops;
-
-static struct mipsxx_register_config {
-	unsigned int control[4];
-	unsigned int counter[4];
-} reg;
-
-/* Compute all of the registers in preparation for enabling profiling.  */
-
-static void mipsxx_reg_setup(struct op_counter_config *ctr)
-{
-	unsigned int counters = op_model_mipsxx_ops.num_counters;
-	int i;
-
-	/* Compute the performance counter control word.  */
-	for (i = 0; i < counters; i++) {
-		reg.control[i] = 0;
-		reg.counter[i] = 0;
-
-		if (!ctr[i].enabled)
-			continue;
-
-		reg.control[i] = M_PERFCTL_EVENT(ctr[i].event) |
-		                 M_PERFCTL_INTERRUPT_ENABLE;
-		if (ctr[i].kernel)
-			reg.control[i] |= M_PERFCTL_KERNEL;
-		if (ctr[i].user)
-			reg.control[i] |= M_PERFCTL_USER;
-		if (ctr[i].exl)
-			reg.control[i] |= M_PERFCTL_EXL;
-		reg.counter[i] = 0x80000000 - ctr[i].count;
-	}
-}
-
-/* Program all of the registers in preparation for enabling profiling.  */
-
-static void mipsxx_cpu_setup(void *args)
-{
-	unsigned int counters = op_model_mipsxx_ops.num_counters;
-
-	switch (counters) {
-	case 4:
-		w_c0_perfctrl3(0);
-		w_c0_perfcntr3(reg.counter[3]);
-	case 3:
-		w_c0_perfctrl2(0);
-		w_c0_perfcntr2(reg.counter[2]);
-	case 2:
-		w_c0_perfctrl1(0);
-		w_c0_perfcntr1(reg.counter[1]);
-	case 1:
-		w_c0_perfctrl0(0);
-		w_c0_perfcntr0(reg.counter[0]);
-	}
-}
-
-/* Start all counters on current CPU */
-static void mipsxx_cpu_start(void *args)
-{
-	unsigned int counters = op_model_mipsxx_ops.num_counters;
-
-	switch (counters) {
-	case 4:
-		w_c0_perfctrl3(WHAT | reg.control[3]);
-	case 3:
-		w_c0_perfctrl2(WHAT | reg.control[2]);
-	case 2:
-		w_c0_perfctrl1(WHAT | reg.control[1]);
-	case 1:
-		w_c0_perfctrl0(WHAT | reg.control[0]);
-	}
-}
-
-/* Stop all counters on current CPU */
-static void mipsxx_cpu_stop(void *args)
-{
-	unsigned int counters = op_model_mipsxx_ops.num_counters;
-
-	switch (counters) {
-	case 4:
-		w_c0_perfctrl3(0);
-	case 3:
-		w_c0_perfctrl2(0);
-	case 2:
-		w_c0_perfctrl1(0);
-	case 1:
-		w_c0_perfctrl0(0);
-	}
-}
-
-static int mipsxx_perfcount_handler(void)
-{
-	unsigned int counters = op_model_mipsxx_ops.num_counters;
-	unsigned int control;
-	unsigned int counter;
-	int handled = IRQ_NONE;
-
-	if (cpu_has_mips_r2 && !(read_c0_cause() & (1 << 26)))
-		return handled;
-
-	switch (counters) {
-#define HANDLE_COUNTER(n)						\
-	case n + 1:							\
-		control = r_c0_perfctrl ## n();				\
-		counter = r_c0_perfcntr ## n();				\
-		if ((control & M_PERFCTL_INTERRUPT_ENABLE) &&		\
-		    (counter & M_COUNTER_OVERFLOW)) {			\
-			oprofile_add_sample(get_irq_regs(), n);		\
-			w_c0_perfcntr ## n(reg.counter[n]);		\
-			handled = IRQ_HANDLED;				\
-		}
-	HANDLE_COUNTER(3)
-	HANDLE_COUNTER(2)
-	HANDLE_COUNTER(1)
-	HANDLE_COUNTER(0)
-	}
-
-	return handled;
-}
-
-static int (*save_perf_irq)(void);
-
-static int __init mipsxx_init(void)
-{
-	int counters;
-
-	counters = n_counters();
-	if (counters == 0) {
-		printk(KERN_ERR "Oprofile: CPU has no performance counters\n");
-		return -ENODEV;
-	}
-
-#ifdef CONFIG_MIPS_MT_SMP
-	cpu_has_mipsmt_pertccounters = read_c0_config7() & (1<<19);
-	if (!cpu_has_mipsmt_pertccounters)
-		counters = counters_total_to_per_cpu(counters);
-#endif
-	on_each_cpu(reset_counters, (void *)(long)counters, 1);
-
-	op_model_mipsxx_ops.num_counters = counters;
-	switch (current_cpu_type()) {
-	case CPU_20KC:
-		op_model_mipsxx_ops.cpu_type = "mips/20K";
-		break;
-
-	case CPU_24K:
-		op_model_mipsxx_ops.cpu_type = "mips/24K";
-		break;
-
-	case CPU_25KF:
-		op_model_mipsxx_ops.cpu_type = "mips/25K";
-		break;
-
-	case CPU_1004K:
-#if 0
-		/* FIXME: report as 34K for now */
-		op_model_mipsxx_ops.cpu_type = "mips/1004K";
-		break;
-#endif
-
-	case CPU_34K:
-		op_model_mipsxx_ops.cpu_type = "mips/34K";
-		break;
-
-	case CPU_74K:
-		op_model_mipsxx_ops.cpu_type = "mips/74K";
-		break;
-
-	case CPU_5KC:
-		op_model_mipsxx_ops.cpu_type = "mips/5K";
-		break;
-
-	case CPU_R10000:
-		if ((current_cpu_data.processor_id & 0xff) == 0x20)
-			op_model_mipsxx_ops.cpu_type = "mips/r10000-v2.x";
-		else
-			op_model_mipsxx_ops.cpu_type = "mips/r10000";
-		break;
-
-	case CPU_R12000:
-	case CPU_R14000:
-		op_model_mipsxx_ops.cpu_type = "mips/r12000";
-		break;
-
-	case CPU_SB1:
-	case CPU_SB1A:
-		op_model_mipsxx_ops.cpu_type = "mips/sb1";
-		break;
-
-	default:
-		printk(KERN_ERR "Profiling unsupported for this CPU\n");
-
-		return -ENODEV;
-	}
-
-	save_perf_irq = perf_irq;
-	perf_irq = mipsxx_perfcount_handler;
-
-	return 0;
-}
-
-static void mipsxx_exit(void)
-{
-	int counters = op_model_mipsxx_ops.num_counters;
-
-	counters = counters_per_cpu_to_total(counters);
-	on_each_cpu(reset_counters, (void *)(long)counters, 1);
-
-	perf_irq = save_perf_irq;
-}
-
-struct op_mips_model op_model_mipsxx_ops = {
-	.reg_setup	= mipsxx_reg_setup,
-	.cpu_setup	= mipsxx_cpu_setup,
-	.init		= mipsxx_init,
-	.exit		= mipsxx_exit,
-	.cpu_start	= mipsxx_cpu_start,
-	.cpu_stop	= mipsxx_cpu_stop,
-};
diff --git a/arch/mips/oprofile/op_model_rm9000.c b/arch/mips/oprofile/op_model_rm9000.c
deleted file mode 100644
index 48e7487..0000000
--- a/arch/mips/oprofile/op_model_rm9000.c
+++ /dev/null
@@ -1,124 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2004 by Ralf Baechle
- */
-#include <linux/init.h>
-#include <linux/oprofile.h>
-#include <linux/interrupt.h>
-#include <linux/smp.h>
-#include <asm/pmu.h>
-
-#include "op_impl.h"
-
-
-static struct rm9k_register_config {
-	unsigned int control;
-	unsigned int reset_counter1;
-	unsigned int reset_counter2;
-} reg;
-
-/* Compute all of the registers in preparation for enabling profiling.  */
-
-static void rm9000_reg_setup(struct op_counter_config *ctr)
-{
-	unsigned int control = 0;
-
-	/* Compute the performance counter control word.  */
-	/* For now count kernel and user mode */
-	if (ctr[0].enabled)
-		control |= RM9K_COUNTER1_EVENT(ctr[0].event) |
-		           RM9K_COUNTER1_KERNEL |
-		           RM9K_COUNTER1_USER |
-		           RM9K_COUNTER1_ENABLE;
-	if (ctr[1].enabled)
-		control |= RM9K_COUNTER2_EVENT(ctr[1].event) |
-		           RM9K_COUNTER2_KERNEL |
-		           RM9K_COUNTER2_USER |
-		           RM9K_COUNTER2_ENABLE;
-	reg.control = control;
-
-	reg.reset_counter1 = 0x80000000 - ctr[0].count;
-	reg.reset_counter2 = 0x80000000 - ctr[1].count;
-}
-
-/* Program all of the registers in preparation for enabling profiling.  */
-
-static void rm9000_cpu_setup(void *args)
-{
-	uint64_t perfcount;
-
-	perfcount = ((uint64_t) reg.reset_counter2 << 32) | reg.reset_counter1;
-	write_c0_perfcount(perfcount);
-}
-
-static void rm9000_cpu_start(void *args)
-{
-	/* Start all counters on current CPU */
-	write_c0_perfcontrol(reg.control);
-}
-
-static void rm9000_cpu_stop(void *args)
-{
-	/* Stop all counters on current CPU */
-	write_c0_perfcontrol(0);
-}
-
-static irqreturn_t rm9000_perfcount_handler(int irq, void *dev_id)
-{
-	unsigned int control = read_c0_perfcontrol();
-	struct pt_regs *regs = get_irq_regs();
-	uint32_t counter1, counter2;
-	uint64_t counters;
-
-	/*
-	 * RM9000 combines two 32-bit performance counters into a single
-	 * 64-bit coprocessor zero register.  To avoid a race updating the
-	 * registers we need to stop the counters while we're messing with
-	 * them ...
-	 */
-	write_c0_perfcontrol(0);
-
-	counters = read_c0_perfcount();
-	counter1 = counters;
-	counter2 = counters >> 32;
-
-	if (control & RM9K_COUNTER1_OVERFLOW) {
-		oprofile_add_sample(regs, 0);
-		counter1 = reg.reset_counter1;
-	}
-	if (control & RM9K_COUNTER2_OVERFLOW) {
-		oprofile_add_sample(regs, 1);
-		counter2 = reg.reset_counter2;
-	}
-
-	counters = ((uint64_t)counter2 << 32) | counter1;
-	write_c0_perfcount(counters);
-	write_c0_perfcontrol(reg.control);
-
-	return IRQ_HANDLED;
-}
-
-static int __init rm9000_init(void)
-{
-	return request_irq(rm9000_perfcount_irq, rm9000_perfcount_handler,
-	                   0, "Perfcounter", NULL);
-}
-
-static void rm9000_exit(void)
-{
-	free_irq(rm9000_perfcount_irq, NULL);
-}
-
-struct op_mips_model op_model_rm9000_ops = {
-	.reg_setup	= rm9000_reg_setup,
-	.cpu_setup	= rm9000_cpu_setup,
-	.init		= rm9000_init,
-	.exit		= rm9000_exit,
-	.cpu_start	= rm9000_cpu_start,
-	.cpu_stop	= rm9000_cpu_stop,
-	.cpu_type	= "mips/rm9000",
-	.num_counters	= 2
-};
-- 
1.6.3.3
