Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Apr 2010 18:40:28 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:40917 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492453Ab0DOQjq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Apr 2010 18:39:46 +0200
Received: by pwj4 with SMTP id 4so1290781pwj.36
        for <multiple recipients>; Thu, 15 Apr 2010 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=u7ELsplkqggH0rLmaDu9xo/gFkw5NJY3QwZgcqz0h0Q=;
        b=MOtyw/TEyrXFZdYjaX18CpyEUz6GTiXce6sTnnlECeOWsyDCIveMbbzz5cB/hhyadc
         An9wEq1u6P5m6RjkMEtqgodgDDUL8zSKdkad+MRur8fdKJvTo1ddtdwuHKzbbYFgU31D
         QalUb3kS8/S7wSy6pEB6Zex3IDLhI/Mwlb6tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=rcej/2mMbfFiEx6YRGTfVEEKDJW/tho3IWfODGO8Qj9dug36/yzcJPO8LefKoAUgri
         wCYWwQY0xZz9e6P+VekhOTZ8LuRxkpq5fuK1X9HgdUrwQussg9h4qQeQUfmw9vn5Bjty
         iwYwW5/Y/BlzbJswgsaFmQOCMHbjO38+0ZjJ4=
Received: by 10.141.124.2 with SMTP id b2mr616807rvn.23.1271349576664;
        Thu, 15 Apr 2010 09:39:36 -0700 (PDT)
Received: from [192.168.1.101] ([114.84.94.52])
        by mx.google.com with ESMTPS id 5sm452806yxd.53.2010.04.15.09.39.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 09:39:27 -0700 (PDT)
Subject: [PATCH 3/3] MIPS: implement hardware perf event support
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 16 Apr 2010 00:39:17 +0800
Message-ID: <1271349557.7467.424.camel@fun-lab>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch is the HW perf event support. To enable this feature, we can not
choose the SMTC kernel; Oprofile should be disabled; kernel performance
events be selected. Then we can enable it in the Kernel type menu.

Oprofile for MIPS platforms initializes irq at arch init time. Currently we
do not change this logic to allow PMU reservation.

If a platform has EIC, we can use the irq base and perf counter irq
offset defines for the interrupt controller in mipspmu_get_irq().

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/Kconfig             |    8 +
 arch/mips/kernel/Makefile     |    2 +
 arch/mips/kernel/perf_event.c | 1468 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1478 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/kernel/perf_event.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cf33418..9aac9b5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1857,6 +1857,14 @@ config NODES_SHIFT
 	default "6"
 	depends on NEED_MULTIPLE_NODES
 
+config HW_PERF_EVENTS
+	bool "Enable hardware performance counter support for perf events"
+	depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n
+	default y
+	help
+	  Enable hardware performance counter support for perf events. If
+	  disabled, perf events will use software events only.
+
 source "mm/Kconfig"
 
 config SMP
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 7a6ac50..c934ab7 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -101,6 +101,8 @@ obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
 
 obj-$(CONFIG_MIPS_CPUFREQ)	+= cpufreq/
 
+obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
+
 EXTRA_CFLAGS += -Werror
 
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
new file mode 100644
index 0000000..49d101e
--- /dev/null
+++ b/arch/mips/kernel/perf_event.c
@@ -0,0 +1,1468 @@
+/*
+ * Linux performance counter support for MIPS.
+ *
+ * Copyright (C) 2010 MIPS Technologies, Inc. Deng-Cheng Zhu
+ *
+ * This code is based on the implementation for ARM, which is in turn
+ * based on the sparc64 perf event code and the x86 code. Performance
+ * counter access is based on the MIPS Oprofile code. And the callchain
+ * support references the code of MIPS traps.c.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/smp.h>
+#include <asm/irq_regs.h>
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/uaccess.h>
+
+#include <asm/irq.h>
+#include <asm/irq_regs.h>
+#include <asm/stacktrace.h>
+
+
+#define MAX_PERIOD ((1ULL << 32) - 1)
+
+/*
+ * FIXME: For VSMP, originally Oprofile defines vpe_id() like this:
+ * #define vpe_id() (cpu_has_mipsmt_pertccounters ? \
+ *			0 : cpu_data[smp_processor_id()].vpe_id)
+ *
+ * It is now redefined lower, because cpu_data[cpuid].vpe_id reports 0
+ * for _both_ CPUs.
+ *
+ * Copied from Oprofile -- BEGIN
+ */
+#define M_CONFIG1_PC	(1 << 4)
+#define M_PERFCTL_EXL			(1UL      <<  0)
+#define M_PERFCTL_KERNEL		(1UL      <<  1)
+#define M_PERFCTL_SUPERVISOR		(1UL      <<  2)
+#define M_PERFCTL_USER			(1UL      <<  3)
+#define M_PERFCTL_INTERRUPT_ENABLE	(1UL      <<  4)
+#define M_PERFCTL_EVENT(event)		(((event) & 0x3ff)  << 5)
+#define M_PERFCTL_VPEID(vpe)		((vpe)    << 16)
+#define M_PERFCTL_MT_EN(filter)		((filter) << 20)
+#define    M_TC_EN_ALL			M_PERFCTL_MT_EN(0)
+#define    M_TC_EN_VPE			M_PERFCTL_MT_EN(1)
+#define    M_TC_EN_TC			M_PERFCTL_MT_EN(2)
+#define M_PERFCTL_TCID(tcid)		((tcid)   << 22)
+#define M_PERFCTL_WIDE			(1UL      << 30)
+#define M_PERFCTL_MORE			(1UL      << 31)
+
+#define M_COUNTER_OVERFLOW		(1UL      << 31)
+
+static int (*save_perf_irq)(void);
+
+#ifdef CONFIG_MIPS_MT_SMP
+static int cpu_has_mipsmt_pertccounters;
+#define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
+			0 : smp_processor_id())
+
+/*
+ * The number of bits to shift to convert between counters per core and
+ * counters per VPE.  There is no reasonable interface atm to obtain the
+ * number of VPEs used by Linux and in the 34K this number is fixed to two
+ * anyways so we hardcore a few things here for the moment.  The way it's
+ * done here will ensure that oprofile VSMP kernel will run right on a lesser
+ * core like a 24K also or with maxcpus=1.
+ */
+static inline unsigned int vpe_shift(void)
+{
+	if (num_possible_cpus() > 1)
+		return 1;
+
+	return 0;
+}
+
+#else
+
+#define vpe_id()	0
+
+static inline unsigned int vpe_shift(void)
+{
+	return 0;
+}
+
+#endif
+
+static inline unsigned int
+counters_total_to_per_cpu(unsigned int counters)
+{
+	return counters >> vpe_shift();
+}
+
+static inline unsigned int
+counters_per_cpu_to_total(unsigned int counters)
+{
+	return counters << vpe_shift();
+}
+
+#define __define_perf_accessors(r, n, np)				\
+									\
+static inline unsigned int r_c0_ ## r ## n(void)			\
+{									\
+	unsigned int cpu = vpe_id();					\
+									\
+	switch (cpu) {							\
+	case 0:								\
+		return read_c0_ ## r ## n();				\
+	case 1:								\
+		return read_c0_ ## r ## np();				\
+	default:							\
+		BUG();							\
+	}								\
+	return 0;							\
+}									\
+									\
+static inline void w_c0_ ## r ## n(unsigned int value)			\
+{									\
+	unsigned int cpu = vpe_id();					\
+									\
+	switch (cpu) {							\
+	case 0:								\
+		write_c0_ ## r ## n(value);				\
+		return;							\
+	case 1:								\
+		write_c0_ ## r ## np(value);				\
+		return;							\
+	default:							\
+		BUG();							\
+	}								\
+	return;								\
+}									\
+
+__define_perf_accessors(perfcntr, 0, 2)
+__define_perf_accessors(perfcntr, 1, 3)
+__define_perf_accessors(perfcntr, 2, 0)
+__define_perf_accessors(perfcntr, 3, 1)
+
+__define_perf_accessors(perfctrl, 0, 2)
+__define_perf_accessors(perfctrl, 1, 3)
+__define_perf_accessors(perfctrl, 2, 0)
+__define_perf_accessors(perfctrl, 3, 1)
+
+static inline int __n_counters(void)
+{
+	if (!(read_c0_config1() & M_CONFIG1_PC))
+		return 0;
+	if (!(read_c0_perfctrl0() & M_PERFCTL_MORE))
+		return 1;
+	if (!(read_c0_perfctrl1() & M_PERFCTL_MORE))
+		return 2;
+	if (!(read_c0_perfctrl2() & M_PERFCTL_MORE))
+		return 3;
+
+	return 4;
+}
+
+static inline int n_counters(void)
+{
+	int counters;
+
+	switch (current_cpu_type()) {
+	case CPU_R10000:
+		counters = 2;
+		break;
+
+	case CPU_R12000:
+	case CPU_R14000:
+		counters = 4;
+		break;
+
+	default:
+		counters = __n_counters();
+	}
+
+	return counters;
+}
+
+static void reset_counters(void *arg)
+{
+	int counters = (int)(long)arg;
+	switch (counters) {
+	case 4:
+		w_c0_perfctrl3(0);
+		w_c0_perfcntr3(0);
+	case 3:
+		w_c0_perfctrl2(0);
+		w_c0_perfcntr2(0);
+	case 2:
+		w_c0_perfctrl1(0);
+		w_c0_perfcntr1(0);
+	case 1:
+		w_c0_perfctrl0(0);
+		w_c0_perfcntr0(0);
+	}
+}
+/* Copied from Oprofile -- END */
+
+static inline unsigned int
+mips_pmu_read_counter(unsigned int idx)
+{
+	switch (idx) {
+	case 0:
+		return r_c0_perfcntr0();
+	case 1:
+		return r_c0_perfcntr1();
+	case 2:
+		return r_c0_perfcntr2();
+	case 3:
+		return r_c0_perfcntr3();
+	default:
+		WARN_ONCE(1, "Invalid performance counter number (%d)\n", idx);
+		return 0;
+	}
+}
+
+static inline void
+mips_pmu_write_counter(unsigned int idx, unsigned int val)
+{
+	switch (idx) {
+	case 0:
+		w_c0_perfcntr0(val);
+		return;
+	case 1:
+		w_c0_perfcntr1(val);
+		return;
+	case 2:
+		w_c0_perfcntr2(val);
+		return;
+	case 3:
+		w_c0_perfcntr3(val);
+		return;
+	}
+}
+
+static inline unsigned int
+mips_pmu_read_control(unsigned int idx)
+{
+	switch (idx) {
+	case 0:
+		return r_c0_perfctrl0();
+	case 1:
+		return r_c0_perfctrl1();
+	case 2:
+		return r_c0_perfctrl2();
+	case 3:
+		return r_c0_perfctrl3();
+	default:
+		WARN_ONCE(1, "Invalid performance counter number (%d)\n", idx);
+		return 0;
+	}
+}
+
+static inline void
+mips_pmu_write_control(unsigned int idx, unsigned int val)
+{
+	switch (idx) {
+	case 0:
+		w_c0_perfctrl0(val);
+		return;
+	case 1:
+		w_c0_perfctrl1(val);
+		return;
+	case 2:
+		w_c0_perfctrl2(val);
+		return;
+	case 3:
+		w_c0_perfctrl3(val);
+		return;
+	}
+}
+
+#define M_PERFCTL_COUNT_EVENT_WHENEVER		\
+	(M_PERFCTL_EXL | M_PERFCTL_KERNEL |	\
+	M_PERFCTL_USER | M_PERFCTL_SUPERVISOR |	\
+	M_PERFCTL_INTERRUPT_ENABLE)
+
+#ifdef CONFIG_MIPS_MT_SMP
+#define M_PERFCTL_CONFIG_MASK 0x3fff801f
+#else
+#define M_PERFCTL_CONFIG_MASK 0x1f
+#endif
+#define M_PERFCTL_EVENT_MASK 0xfe0
+
+#define MIPS_MAX_HWEVENTS 4
+
+struct cpu_hw_events {
+	/* Array of events on this cpu. */
+	struct perf_event	*events[MIPS_MAX_HWEVENTS];
+
+	/*
+	 * Set the bit (indexed by the counter number) when the counter
+	 * is used for an event.
+	 */
+	unsigned long		used_mask[BITS_TO_LONGS(MIPS_MAX_HWEVENTS)];
+
+	/*
+	 * The borrowed MSB for the performance counter. A MIPS performance
+	 * counter uses its bit 31 as a factor of determining whether a counter
+	 * overflow should be signaled. So here we use a separate MSB for each
+	 * counter to make things easy.
+	 */
+	unsigned long		msbs[BITS_TO_LONGS(MIPS_MAX_HWEVENTS)];
+
+	/*
+	 * Software copy of the control register for each performance counter.
+	 */
+	unsigned int		saved_ctrl[MIPS_MAX_HWEVENTS];
+};
+DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
+	.saved_ctrl = {0},
+};
+
+/* The description of MIPS performance events. */
+struct mips_perf_event {
+	u32	event_id;
+	u32 cntr_mask;
+	#define CNTR_EVEN	0x55555555
+	#define CNTR_ODD	0xaaaaaaaa
+#ifdef CONFIG_MIPS_MT_SMP
+	enum {
+		T  = 0,
+		V  = 1,
+		P  = 2,
+	} range;
+#else
+	#define T
+	#define V
+	#define P
+#endif
+};
+
+#define UNSUPPORTED_PERF_EVENT_ID 0xffffffff
+#define C(x) PERF_COUNT_HW_CACHE_##x
+
+struct mips_pmu {
+	const char	*name;
+	irqreturn_t	(*handle_irq)(int irq, void *dev);
+	int		(*handle_shared_irq)(void);
+	void		(*start)(void);
+	void		(*stop)(void);
+	int		(*alloc_counter)(struct cpu_hw_events *cpuc,
+					struct hw_perf_event *hwc);
+	unsigned int	(*read_counter)(unsigned int idx);
+	void		(*write_counter)(unsigned int idx, unsigned int val);
+	void		(*enable_event)(struct hw_perf_event *evt, int idx);
+	void		(*disable_event)(int idx);
+	const struct mips_perf_event (*general_event_map)[PERF_COUNT_HW_MAX];
+	const struct mips_perf_event (*cache_event_map)
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX];
+	u32		num_counters;
+};
+
+static const struct mips_pmu *mipspmu;
+
+#ifdef CONFIG_MIPS_MT_SMP
+static DEFINE_RWLOCK(pmuint_rwlock);
+#endif
+
+/* 24K/34K/1004K cores can share the same event map. */
+static const struct mips_perf_event mipscore_event_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = { 0x00, CNTR_EVEN | CNTR_ODD, P },
+	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x01, CNTR_EVEN | CNTR_ODD, T },
+	[PERF_COUNT_HW_CACHE_REFERENCES] = { UNSUPPORTED_PERF_EVENT_ID },
+	[PERF_COUNT_HW_CACHE_MISSES] = { UNSUPPORTED_PERF_EVENT_ID },
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = { 0x02, CNTR_EVEN, T },
+	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x02, CNTR_ODD, T },
+	[PERF_COUNT_HW_BUS_CYCLES] = { UNSUPPORTED_PERF_EVENT_ID },
+};
+
+/* 74K core has different branch event code. */
+static const struct mips_perf_event mips74Kcore_event_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = { 0x00, CNTR_EVEN | CNTR_ODD, P },
+	[PERF_COUNT_HW_INSTRUCTIONS] = { 0x01, CNTR_EVEN | CNTR_ODD, T },
+	[PERF_COUNT_HW_CACHE_REFERENCES] = { UNSUPPORTED_PERF_EVENT_ID },
+	[PERF_COUNT_HW_CACHE_MISSES] = { UNSUPPORTED_PERF_EVENT_ID },
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = { 0x27, CNTR_EVEN, T },
+	[PERF_COUNT_HW_BRANCH_MISSES] = { 0x27, CNTR_ODD, T },
+	[PERF_COUNT_HW_BUS_CYCLES] = { UNSUPPORTED_PERF_EVENT_ID },
+};
+
+/* 24K/34K/1004K cores can share the same cache event map. */
+static const struct mips_perf_event mipscore_cache_map
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+[C(L1D)] = {
+	/*
+	 * Like some other architectures (e.g. ARM), the performance
+	 * counters don't differentiate between read and write
+	 * accesses/misses, so this isn't strictly correct, but it's the
+	 * best we can do. Writes and reads get combined.
+	 */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x0a, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x0b, CNTR_EVEN | CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x0a, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x0b, CNTR_EVEN | CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x09, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x09, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x09, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x09, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { 0x14, CNTR_EVEN, T },
+		/*
+		 * Note that MIPS has only "hit" events countable for
+		 * the prefetch operation.
+		 */
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(LL)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x15, CNTR_ODD, P },
+		[C(RESULT_MISS)]	= { 0x16, CNTR_EVEN, P },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x15, CNTR_ODD, P },
+		[C(RESULT_MISS)]	= { 0x16, CNTR_EVEN, P },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(DTLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x06, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x06, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x06, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x06, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x05, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x05, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x05, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x05, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(BPU)] = {
+	/* Using the same code for *HW_BRANCH* */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x02, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x02, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x02, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x02, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+};
+
+/* 74K core has completely different cache event map. */
+static const struct mips_perf_event mips74Kcore_cache_map
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+[C(L1D)] = {
+	/*
+	 * Like some other architectures (e.g. ARM), the performance
+	 * counters don't differentiate between read and write
+	 * accesses/misses, so this isn't strictly correct, but it's the
+	 * best we can do. Writes and reads get combined.
+	 */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x17, CNTR_ODD, T },
+		[C(RESULT_MISS)]	= { 0x18, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x17, CNTR_ODD, T },
+		[C(RESULT_MISS)]	= { 0x18, CNTR_ODD, T},
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(L1I)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x06, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x06, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x06, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x06, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { 0x34, CNTR_EVEN, T },
+		/*
+		 * Note that MIPS has only "hit" events countable for
+		 * the prefetch operation.
+		 */
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(LL)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x1c, CNTR_ODD, P },
+		[C(RESULT_MISS)]	= { 0x1d, CNTR_EVEN | CNTR_ODD, P },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x1c, CNTR_ODD, P },
+		[C(RESULT_MISS)]	= { 0x1d, CNTR_EVEN | CNTR_ODD, P },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(DTLB)] = {
+	/* 74K core does not have specific DTLB events. */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(ITLB)] = {
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x04, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x04, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x04, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x04, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+[C(BPU)] = {
+	/* Using the same code for *HW_BRANCH* */
+	[C(OP_READ)] = {
+		[C(RESULT_ACCESS)]	= { 0x27, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x27, CNTR_ODD, T },
+	},
+	[C(OP_WRITE)] = {
+		[C(RESULT_ACCESS)]	= { 0x27, CNTR_EVEN, T },
+		[C(RESULT_MISS)]	= { 0x27, CNTR_ODD, T },
+	},
+	[C(OP_PREFETCH)] = {
+		[C(RESULT_ACCESS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+		[C(RESULT_MISS)]	= { UNSUPPORTED_PERF_EVENT_ID },
+	},
+},
+};
+
+static int
+mipspmu_event_set_period(struct perf_event *event,
+			struct hw_perf_event *hwc,
+			int idx)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	s64 left = atomic64_read(&hwc->period_left);
+	s64 period = hwc->sample_period;
+	int ret = 0;
+	unsigned long flags, uleft;
+
+	if (unlikely(left <= -period)) {
+		left = period;
+		atomic64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	if (unlikely(left <= 0)) {
+		left += period;
+		atomic64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	if (left > (s64)MAX_PERIOD)
+		left = MAX_PERIOD;
+
+	atomic64_set(&hwc->prev_count, (u64)-left);
+
+	local_irq_save(flags);
+	uleft = (u64)(-left) & 0xffffffff;
+	test_bit(31, &uleft) ?
+		set_bit(idx, cpuc->msbs) : clear_bit(idx, cpuc->msbs);
+	mipspmu->write_counter(idx, (u64)(-left) & 0x7fffffff);
+	local_irq_restore(flags);
+
+	perf_event_update_userpage(event);
+
+	return ret;
+}
+
+static int mipspmu_enable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+	int err = 0;
+
+	/* To look for a free counter for this event. */
+	idx = mipspmu->alloc_counter(cpuc, hwc);
+	if (idx < 0) {
+		err = idx;
+		goto out;
+	}
+
+	/*
+	 * If there is an event in the counter we are going to use then
+	 * make sure it is disabled.
+	 */
+	event->hw.idx = idx;
+	mipspmu->disable_event(idx);
+	cpuc->events[idx] = event;
+
+	/* Set the period for the event. */
+	mipspmu_event_set_period(event, hwc, idx);
+
+	/* Enable the event. */
+	mipspmu->enable_event(hwc, idx);
+
+	/* Propagate our changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+out:
+	return err;
+}
+
+static void mipspmu_event_update(struct perf_event *event,
+			struct hw_perf_event *hwc,
+			int idx)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	unsigned long flags;
+	int shift = 64 - 32;
+	s64 prev_raw_count, new_raw_count;
+	s64 delta;
+
+again:
+	prev_raw_count = atomic64_read(&hwc->prev_count);
+	local_irq_save(flags);
+	/* Make the counter value be a "real" one. */
+	new_raw_count = mipspmu->read_counter(idx);
+	if (new_raw_count & (test_bit(idx, cpuc->msbs) << 31)) {
+		new_raw_count &= 0x7fffffff;
+		clear_bit(idx, cpuc->msbs);
+	} else
+		new_raw_count |= (test_bit(idx, cpuc->msbs) << 31);
+	local_irq_restore(flags);
+
+	if (atomic64_cmpxchg(&hwc->prev_count, prev_raw_count,
+				new_raw_count) != prev_raw_count)
+		goto again;
+
+	delta = (new_raw_count << shift) - (prev_raw_count << shift);
+	delta >>= shift;
+
+	atomic64_add(delta, &event->count);
+	atomic64_sub(delta, &hwc->period_left);
+
+	return;
+}
+
+static void mipspmu_disable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+
+	WARN_ON(idx < 0 || idx >= mipspmu->num_counters);
+
+	/* We are working on a local event. */
+	mipspmu->disable_event(idx);
+
+	barrier();
+
+	mipspmu_event_update(event, hwc, idx);
+	cpuc->events[idx] = NULL;
+	clear_bit(idx, cpuc->used_mask);
+
+	perf_event_update_userpage(event);
+}
+
+static void mipspmu_unthrottle(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	mipspmu->enable_event(hwc, hwc->idx);
+}
+
+static void mipspmu_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* Don't read disabled counters! */
+	if (hwc->idx < 0)
+		return;
+
+	mipspmu_event_update(event, hwc, hwc->idx);
+}
+
+static struct pmu pmu = {
+	.enable		= mipspmu_enable,
+	.disable		= mipspmu_disable,
+	.unthrottle	= mipspmu_unthrottle,
+	.read		= mipspmu_read,
+};
+
+static atomic_t active_events = ATOMIC_INIT(0);
+static DEFINE_MUTEX(pmu_reserve_mutex);
+static int mips_pmu_irq = -1;
+
+static int mipspmu_get_irq(void)
+{
+	int err;
+
+	if (cpu_has_veic) {
+		/*
+		 * Using platform specific interrupt controller defines.
+		 */
+#ifdef MSC01E_INT_BASE
+		mips_pmu_irq = MSC01E_INT_BASE + MSC01E_INT_PERFCTR;
+#endif
+	} else if (cp0_perfcount_irq >= 0) {
+		/*
+		 * Some CPUs have explicitly defined their perfcount irq.
+		 */
+#if defined(CONFIG_CPU_RM9000)
+		mips_pmu_irq =  rm9000_perfcount_irq;
+#elif defined(CONFIG_CPU_LOONGSON2)
+		mips_pmu_irq = LOONGSON2_PERFCNT_IRQ;
+#else
+		mips_pmu_irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
+#endif
+	}
+
+	if (mips_pmu_irq >= 0) {
+		/* Request my own irq handler. */
+		err = request_irq(mips_pmu_irq, mipspmu->handle_irq,
+			IRQF_DISABLED | IRQF_NOBALANCING,
+			"mips_perf_pmu", NULL);
+		if (err) {
+			pr_warning("Unable to request IRQ%d for MIPS "
+			   "performance counters!\n", mips_pmu_irq);
+		}
+	} else if (cp0_perfcount_irq < 0) {
+		/*
+		 * We are sharing the irq number with the timer interrupt.
+		 */
+		save_perf_irq = perf_irq;
+		perf_irq = mipspmu->handle_shared_irq;
+		err = 0;
+	} else {
+		pr_warning("The platform hasn't properly defined its "
+			"interrupt controller.\n");
+		err = -ENOENT;
+	}
+
+	return err;
+}
+
+static void mipspmu_free_irq(void)
+{
+	if (mips_pmu_irq >= 0)
+		free_irq(mips_pmu_irq, NULL);
+	else if (cp0_perfcount_irq < 0)
+		perf_irq = save_perf_irq;
+
+	mips_pmu_irq = -1;
+}
+
+static void hw_perf_event_destroy(struct perf_event *event)
+{
+	if (atomic_dec_and_mutex_lock(&active_events,
+				&pmu_reserve_mutex)) {
+		/*
+		 * We must not call the destroy function with interrupts
+		 * disabled.
+		 */
+		on_each_cpu(reset_counters,
+			(void *)(long)mipspmu->num_counters, 1);
+		mipspmu_free_irq();
+		mutex_unlock(&pmu_reserve_mutex);
+	}
+}
+
+#ifdef CONFIG_MIPS_MT_SMP
+static int
+calc_and_check_range(struct perf_event *event,
+			const struct mips_perf_event *pev)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (event->cpu >= 0) {
+		if (pev->range > V) {
+			/*
+			 * The user selected an event that is processor
+			 * wide, while expecting it to be VPE wide.
+			 */
+			hwc->config_base |= M_TC_EN_ALL;
+		} else {
+			/*
+			 * FIXME: cpu_data[event->cpu].vpe_id reports 0
+			 * for both CPUs.
+			 */
+			hwc->config_base |= M_PERFCTL_VPEID(event->cpu);
+			hwc->config_base |= M_TC_EN_VPE;
+		}
+	} else
+		hwc->config_base |= M_TC_EN_ALL;
+
+	return 0;
+}
+#else
+static int
+calc_and_check_range(struct perf_event *event,
+			const struct mips_perf_event *pev)
+{
+	return 0;
+}
+#endif
+
+static inline u32 perf_event_encode(const struct mips_perf_event *pev)
+{
+/*
+ * Top 8 bits for range, next 16 bits for cntr_mask, lowest 8 bits for
+ * event_id.
+ */
+#ifdef CONFIG_MIPS_MT_SMP
+	return ((u32) pev->range << 24) |
+			(pev->cntr_mask & 0xffff00) |
+			(pev->event_id & 0xff);
+#else
+	return (pev->cntr_mask & 0xffff00) |
+			(pev->event_id & 0xff);
+#endif
+}
+
+static int validate_event(struct cpu_hw_events *cpuc,
+	       struct perf_event *event)
+{
+	struct hw_perf_event fake_hwc = event->hw;
+
+	if (event->pmu && event->pmu != &pmu)
+		return 0;
+
+	return mipspmu->alloc_counter(cpuc, &fake_hwc) >= 0;
+}
+
+static int validate_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+	struct cpu_hw_events fake_cpuc;
+
+	memset(&fake_cpuc, 0, sizeof(fake_cpuc));
+
+	if (!validate_event(&fake_cpuc, leader))
+		return -ENOSPC;
+
+	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
+		if (!validate_event(&fake_cpuc, sibling))
+			return -ENOSPC;
+	}
+
+	if (!validate_event(&fake_cpuc, event))
+		return -ENOSPC;
+
+	return 0;
+}
+
+static const struct mips_perf_event *
+mips_pmu_map_general_event(int idx)
+{
+	const struct mips_perf_event *pev;
+
+	pev = ((*mipspmu->general_event_map)[idx].event_id ==
+		UNSUPPORTED_PERF_EVENT_ID ? ERR_PTR(-EOPNOTSUPP) :
+		&(*mipspmu->general_event_map)[idx]);
+
+	return pev;
+}
+
+static const struct mips_perf_event *
+mips_pmu_map_cache_event(u64 config)
+{
+	unsigned int cache_type, cache_op, cache_result;
+	const struct mips_perf_event *pev;
+
+	cache_type = (config >> 0) & 0xff;
+	if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
+		return ERR_PTR(-EINVAL);
+
+	cache_op = (config >> 8) & 0xff;
+	if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
+		return ERR_PTR(-EINVAL);
+
+	cache_result = (config >> 16) & 0xff;
+	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
+		return ERR_PTR(-EINVAL);
+
+	pev = &((*mipspmu->cache_event_map)
+					[cache_type]
+					[cache_op]
+					[cache_result]);
+
+	if (pev->event_id == UNSUPPORTED_PERF_EVENT_ID)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return pev;
+
+}
+
+static int __hw_perf_event_init(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+	struct hw_perf_event *hwc = &event->hw;
+	const struct mips_perf_event *pev;
+	int err;
+
+	/* Returning MIPS event descriptor for generic perf event. */
+	if (PERF_TYPE_HARDWARE == event->attr.type) {
+		if (event->attr.config >= PERF_COUNT_HW_MAX)
+			return -EINVAL;
+		pev = mips_pmu_map_general_event(event->attr.config);
+	} else if (PERF_TYPE_HW_CACHE == event->attr.type) {
+		pev = mips_pmu_map_cache_event(event->attr.config);
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	if (IS_ERR(pev))
+		return PTR_ERR(pev);
+
+	/*
+	 * We allow max flexibility on how each individual counter shared
+	 * by the single CPU operates (the mode exclusion and the range).
+	 */
+	hwc->config_base = M_PERFCTL_INTERRUPT_ENABLE;
+
+	/* Calculate range bits and validate it. */
+	err = calc_and_check_range(event, pev);
+	if (err < 0)
+		return err;
+
+	if (!attr->exclude_user)
+		hwc->config_base |= M_PERFCTL_USER;
+	if (!attr->exclude_kernel) {
+		hwc->config_base |= M_PERFCTL_KERNEL;
+		/* MIPS kernel mode: KSU == 00b || EXL == 1 || ERL == 1 */
+		hwc->config_base |= M_PERFCTL_EXL;
+	}
+	if (!attr->exclude_hv)
+		hwc->config_base |= M_PERFCTL_SUPERVISOR;
+
+	hwc->config_base &= M_PERFCTL_CONFIG_MASK;
+	hwc->event_base = perf_event_encode(pev);
+	/*
+	 * The event can belong to another cpu. We do not assign a local
+	 * counter for it for now.
+	 */
+	hwc->idx = -1;
+	hwc->config = 0;
+
+	if (!hwc->sample_period) {
+		hwc->sample_period  = MAX_PERIOD;
+		hwc->last_period    = hwc->sample_period;
+		atomic64_set(&hwc->period_left, hwc->sample_period);
+	}
+
+	err = 0;
+	if (event->group_leader != event) {
+		err = validate_group(event);
+		if (err)
+			return -EINVAL;
+	}
+
+	event->destroy = hw_perf_event_destroy;
+
+	return err;
+}
+
+const struct pmu *hw_perf_event_init(struct perf_event *event)
+{
+	int err = 0;
+
+	if (!mipspmu || event->cpu >= nr_cpumask_bits ||
+		(event->cpu >= 0 && !cpu_online(event->cpu)))
+		return ERR_PTR(-ENODEV);
+
+	if (!atomic_inc_not_zero(&active_events)) {
+		if (atomic_read(&active_events) > MIPS_MAX_HWEVENTS) {
+			atomic_dec(&active_events);
+			return ERR_PTR(-ENOSPC);
+		}
+
+		mutex_lock(&pmu_reserve_mutex);
+		if (atomic_read(&active_events) == 0)
+			err = mipspmu_get_irq();
+
+		if (!err)
+			atomic_inc(&active_events);
+		mutex_unlock(&pmu_reserve_mutex);
+	}
+
+	if (err)
+		return ERR_PTR(err);
+
+	err = __hw_perf_event_init(event);
+	if (err)
+		hw_perf_event_destroy(event);
+
+	return err ? ERR_PTR(err) : &pmu;
+}
+
+void hw_perf_enable(void)
+{
+	if (mipspmu)
+		mipspmu->start();
+}
+
+void hw_perf_disable(void)
+{
+	if (mipspmu)
+		mipspmu->stop();
+}
+
+static void
+handle_associated_event(struct cpu_hw_events *cpuc,
+	int idx, struct perf_sample_data *data, struct pt_regs *regs)
+{
+	struct perf_event *event = cpuc->events[idx];
+	struct hw_perf_event *hwc = &event->hw;
+
+	mipspmu_event_update(event, hwc, idx);
+	data->period = event->hw.last_period;
+	if (!mipspmu_event_set_period(event, hwc, idx))
+		return;
+
+	if (perf_event_overflow(event, 0, data, regs))
+		mipspmu->disable_event(idx);
+}
+
+static void pause_local_counters(void)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	int counters = mipspmu->num_counters;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	switch (counters) {
+	case 4:
+		cpuc->saved_ctrl[3] = r_c0_perfctrl3();
+		w_c0_perfctrl3(cpuc->saved_ctrl[3] &
+			~M_PERFCTL_COUNT_EVENT_WHENEVER);
+	case 3:
+		cpuc->saved_ctrl[2] = r_c0_perfctrl2();
+		w_c0_perfctrl2(cpuc->saved_ctrl[2] &
+			~M_PERFCTL_COUNT_EVENT_WHENEVER);
+	case 2:
+		cpuc->saved_ctrl[1] = r_c0_perfctrl1();
+		w_c0_perfctrl1(cpuc->saved_ctrl[1] &
+			~M_PERFCTL_COUNT_EVENT_WHENEVER);
+	case 1:
+		cpuc->saved_ctrl[0] = r_c0_perfctrl0();
+		w_c0_perfctrl0(cpuc->saved_ctrl[0] &
+			~M_PERFCTL_COUNT_EVENT_WHENEVER);
+	}
+	local_irq_restore(flags);
+}
+
+static void resume_local_counters(void)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	int counters = mipspmu->num_counters;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	switch (counters) {
+	case 4:
+		w_c0_perfctrl3(cpuc->saved_ctrl[3]);
+	case 3:
+		w_c0_perfctrl2(cpuc->saved_ctrl[2]);
+	case 2:
+		w_c0_perfctrl1(cpuc->saved_ctrl[1]);
+	case 1:
+		w_c0_perfctrl0(cpuc->saved_ctrl[0]);
+	}
+	local_irq_restore(flags);
+}
+
+static int mips_pmu_handle_shared_irq(void)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct perf_sample_data data;
+	unsigned int counters = mipspmu->num_counters;
+	unsigned int counter;
+	int handled = IRQ_NONE;
+	struct pt_regs *regs;
+
+	if (cpu_has_mips_r2 && !(read_c0_cause() & (1 << 26)))
+		return handled;
+
+	/*
+	 * First we pause the local counters, so that when we are locked
+	 * here, the counters are all paused. When it gets locked due to
+	 * perf_disable(), the timer interrupt handler will be delayed.
+	 *
+	 * See also mips_pmu_start().
+	 */
+	pause_local_counters();
+#ifdef CONFIG_MIPS_MT_SMP
+	read_lock(&pmuint_rwlock);
+#endif
+
+	regs = get_irq_regs();
+
+	perf_sample_data_init(&data, 0);
+
+	switch (counters) {
+#define HANDLE_COUNTER(n)						\
+	case n + 1:							\
+		if (test_bit(n, cpuc->used_mask)) {			\
+			counter = r_c0_perfcntr ## n();			\
+			if (counter & M_COUNTER_OVERFLOW) {	\
+				w_c0_perfcntr ## n(counter &		\
+						0x7fffffff);		\
+				if (test_and_change_bit(n, cpuc->msbs))	\
+					handle_associated_event(cpuc,	\
+						n, &data, regs);	\
+				handled = IRQ_HANDLED;			\
+			}						\
+		}
+	HANDLE_COUNTER(3)
+	HANDLE_COUNTER(2)
+	HANDLE_COUNTER(1)
+	HANDLE_COUNTER(0)
+	}
+
+	/*
+	 * Do all the work for the pending perf events. We can do this
+	 * in here because the performance counter interrupt is a regular
+	 * interrupt, not NMI.
+	 */
+	if (handled == IRQ_HANDLED)
+		perf_event_do_pending();
+
+#ifdef CONFIG_MIPS_MT_SMP
+	read_unlock(&pmuint_rwlock);
+#endif
+	resume_local_counters();
+	return handled;
+}
+
+static irqreturn_t
+mips_pmu_handle_irq(int irq, void *dev)
+{
+	return mips_pmu_handle_shared_irq();
+}
+
+static void mips_pmu_start(void)
+{
+#ifdef CONFIG_MIPS_MT_SMP
+	write_unlock(&pmuint_rwlock);
+#endif
+	resume_local_counters();
+}
+
+/*
+ * MIPS performance counters can be per-TC. The control registers can
+ * not be directly accessed accross CPUs. Hence if we want to do global
+ * control, we need cross CPU calls. on_each_cpu() can help us, but we
+ * can not make sure this function is called with interrupts enabled. So
+ * here we pause local counters and then grab a rwlock and leave the
+ * counters on other CPUs alone. If any counter interrupt raises while
+ * we own the write lock, simply pause local counters on that CPU and
+ * spin in the handler. Also we know we won't be switched to another
+ * CPU after pausing local counters and before grabbing the lock.
+ */
+static void mips_pmu_stop(void)
+{
+	pause_local_counters();
+#ifdef CONFIG_MIPS_MT_SMP
+	write_lock(&pmuint_rwlock);
+#endif
+}
+
+static int
+mips_pmu_alloc_counter(struct cpu_hw_events *cpuc,
+			struct hw_perf_event *hwc)
+{
+	int i;
+
+	/*
+	 * We only need to care the counter mask. The range has been
+	 * checked definitely.
+	 */
+	unsigned long cntr_mask = (hwc->event_base >> 8) & 0xffff;
+
+	for (i = mipspmu->num_counters - 1; i >= 0; i--) {
+		/*
+		 * Note that some MIPS perf events can be counted by both
+		 * even and odd counters, wheresas many other are only by
+		 * even _or_ odd counters. This introduces an issue that
+		 * when the former kind of event takes the counter the
+		 * latter kind of event wants to use, then the "counter
+		 * allocation" for the latter event will fail. In fact if
+		 * they can be dynamically swapped, they both feel happy.
+		 * But here we leave this issue alone for now.
+		 */
+		if (test_bit(i, &cntr_mask) &&
+			!test_and_set_bit(i, cpuc->used_mask))
+			return i;
+	}
+
+	return -EAGAIN;
+}
+
+static void
+mips_pmu_enable_event(struct hw_perf_event *evt, int idx)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	unsigned long flags;
+
+	WARN_ON(idx < 0 || idx >= mipspmu->num_counters);
+
+	local_irq_save(flags);
+	cpuc->saved_ctrl[idx] = M_PERFCTL_EVENT(evt->event_base & 0xff) |
+		(evt->config_base & M_PERFCTL_CONFIG_MASK) |
+		/* Make sure interrupt enabled. */
+		M_PERFCTL_INTERRUPT_ENABLE;
+	/*
+	 * We do not actually let the counter run. Leave it until start().
+	 */
+	local_irq_restore(flags);
+}
+
+static void
+mips_pmu_disable_event(int idx)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	unsigned long flags;
+
+	WARN_ON(idx < 0 || idx >= mipspmu->num_counters);
+
+	local_irq_save(flags);
+	cpuc->saved_ctrl[idx] = mips_pmu_read_control(idx) &
+		~M_PERFCTL_COUNT_EVENT_WHENEVER;
+	mips_pmu_write_control(idx, cpuc->saved_ctrl[idx]);
+	local_irq_restore(flags);
+}
+
+static struct mips_pmu mipscore_pmu = {
+	.handle_irq = mips_pmu_handle_irq,
+	.handle_shared_irq = mips_pmu_handle_shared_irq,
+	.start = mips_pmu_start,
+	.stop = mips_pmu_stop,
+	.alloc_counter = mips_pmu_alloc_counter,
+	.read_counter = mips_pmu_read_counter,
+	.write_counter = mips_pmu_write_counter,
+	.enable_event = mips_pmu_enable_event,
+	.disable_event = mips_pmu_disable_event,
+	.general_event_map = &mipscore_event_map,
+	.cache_event_map = &mipscore_cache_map,
+};
+
+static struct mips_pmu mips74Kcore_pmu = {
+	.handle_irq = mips_pmu_handle_irq,
+	.handle_shared_irq = mips_pmu_handle_shared_irq,
+	.start = mips_pmu_start,
+	.stop = mips_pmu_stop,
+	.alloc_counter = mips_pmu_alloc_counter,
+	.read_counter = mips_pmu_read_counter,
+	.write_counter = mips_pmu_write_counter,
+	.enable_event = mips_pmu_enable_event,
+	.disable_event = mips_pmu_disable_event,
+	.general_event_map = &mips74Kcore_event_map,
+	.cache_event_map = &mips74Kcore_cache_map,
+};
+
+static int __init
+init_hw_perf_events(void)
+{
+	int counters;
+
+	pr_info("Performance counters: ");
+
+	counters = n_counters();
+	if (counters == 0) {
+		pr_cont("No available PMU.\n");
+		return -ENODEV;
+	}
+
+#ifdef CONFIG_MIPS_MT_SMP
+	cpu_has_mipsmt_pertccounters = read_c0_config7() & (1<<19);
+	if (!cpu_has_mipsmt_pertccounters)
+		counters = counters_total_to_per_cpu(counters);
+#endif
+
+	on_each_cpu(reset_counters, (void *)(long)counters, 1);
+
+	switch (current_cpu_type()) {
+	case CPU_24K:
+		mipscore_pmu.name = "mips/24K";
+		mipscore_pmu.num_counters = counters;
+		mipspmu = &mipscore_pmu;
+		break;
+	case CPU_34K:
+		mipscore_pmu.name = "mips/34K";
+		mipscore_pmu.num_counters = counters;
+		mipspmu = &mipscore_pmu;
+		break;
+	case CPU_74K:
+		mips74Kcore_pmu.name = "mips/74K";
+		mips74Kcore_pmu.num_counters = counters;
+		mipspmu = &mips74Kcore_pmu;
+		break;
+	default:
+		pr_cont("Either hardware does not support performance "
+			"counters, or not yet implemented.\n");
+		return -ENODEV;
+	}
+
+	if (mipspmu)
+		pr_cont("%s PMU enabled, %d counters available to each "
+			"CPU\n", mipspmu->name, mipspmu->num_counters);
+
+	return 0;
+}
+arch_initcall(init_hw_perf_events);
+
+/*
+ * Callchain handling code.
+ */
+static inline void
+callchain_store(struct perf_callchain_entry *entry,
+		u64 ip)
+{
+	if (entry->nr < PERF_MAX_STACK_DEPTH)
+		entry->ip[entry->nr++] = ip;
+}
+
+static void
+perf_callchain_user(struct pt_regs *regs,
+		    struct perf_callchain_entry *entry)
+{
+	unsigned long *sp;
+	unsigned long addr;
+
+	callchain_store(entry, PERF_CONTEXT_USER);
+
+	if (!user_mode(regs))
+		regs = task_pt_regs(current);
+
+	sp = (unsigned long *)(regs->regs[29] & ~3);
+
+	while (!kstack_end(sp)) {
+		unsigned long __user *p =
+			(unsigned long __user *)(unsigned long)sp++;
+		if (__get_user(addr, p)) {
+			pr_warning("Performance counter callchain "
+				"suppport: Bad stack address.\n");
+			break;
+		}
+		callchain_store(entry, addr);
+	}
+}
+
+static void
+perf_callchain_kernel(struct pt_regs *regs,
+		      struct perf_callchain_entry *entry)
+{
+	unsigned long sp = regs->regs[29];
+	unsigned long ra = regs->regs[31];
+	unsigned long pc = regs->cp0_epc;
+
+	if (unlikely(!__kernel_text_address(pc))) {
+		pr_warning("Performance counter callchain support "
+			"error.\n");
+		return;
+	}
+
+	callchain_store(entry, PERF_CONTEXT_KERNEL);
+
+	do {
+		callchain_store(entry, pc);
+		pc = unwind_stack(current, &sp, pc, &ra);
+	} while (pc);
+}
+
+static void
+perf_do_callchain(struct pt_regs *regs,
+		  struct perf_callchain_entry *entry)
+{
+	int is_user;
+
+	if (!regs)
+		return;
+
+	is_user = user_mode(regs);
+
+	if (!current || !current->pid)
+		return;
+
+	if (is_user && current->state != TASK_RUNNING)
+		return;
+
+	if (!is_user)
+		perf_callchain_kernel(regs, entry);
+
+	if (current->mm)
+		perf_callchain_user(regs, entry);
+}
+
+static DEFINE_PER_CPU(struct perf_callchain_entry, pmc_irq_entry);
+
+struct perf_callchain_entry *
+perf_callchain(struct pt_regs *regs)
+{
+	struct perf_callchain_entry *entry = &__get_cpu_var(pmc_irq_entry);
+
+	entry->nr = 0;
+	perf_do_callchain(regs, entry);
+	return entry;
+}
+
-- 
1.7.0.4
