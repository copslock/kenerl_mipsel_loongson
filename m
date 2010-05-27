Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 15:09:36 +0200 (CEST)
Received: from mail-pz0-f173.google.com ([209.85.222.173]:49968 "EHLO
        mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492374Ab0E0NFy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 15:05:54 +0200
Received: by pzk3 with SMTP id 3so3858955pzk.26
        for <multiple recipients>; Thu, 27 May 2010 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Qo5QA+d3Y92yFU4LZUDfSe3jWuPrkvcXFQ9uwl+iJPQ=;
        b=Hiu5l1buxOqAa+/6XluiT5Zx02x9tqbqjAvXTACplkI4PFiWFDekPWd8zId6xxDgcT
         lfOSM6jlRQ8P3MZVJJ+pXiGQIP2ry7tHmHfazCsaGGqFxYVc89D1IbNtp4vnkciEZ0v7
         wbA+5tEBp2AO2s+7bksblin1WyGqigbvIj/wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EC+xd590NViKYOJImSs7GIDTX0s7ljRkz8mPN0lcXscs+t3SzRKi3nlrqWTt29aeeE
         gmdcvfgwf6tm6dkLlqRCt/4+9xC0VCVqqFTD3KC18C6OH6Zd11XWARyR541WVkWx4wY0
         sCYe8lm0hCg1CvgzoIjTbkty9Zko6hcXL8dEs=
Received: by 10.143.86.10 with SMTP id o10mr6877264wfl.142.1274965545822;
        Thu, 27 May 2010 06:05:45 -0700 (PDT)
Received: from localhost.localdomain ([114.84.70.124])
        by mx.google.com with ESMTPS id 21sm972927pzk.8.2010.05.27.06.05.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 06:05:44 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v5 11/12] MIPS/Oprofile: use Perf-events framework as backend
Date:   Thu, 27 May 2010 21:03:39 +0800
Message-Id: <1274965420-5091-12-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch is based on Will Deacon's work for ARM. The well-written
reasons and ideas can be found here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-April/013210.html

This effort makes the bug-fixes shared by different pmu users/clients
(for now, Oprofile & Perf-events), and make them coexist in the system
without lock issues, and make their results comparable.

So this patch moves Oprofile on top of Perf-events by replacing its
original interfaces with new ones calling Perf-events.

Oprofile uses raw events, so Perf-events (mipsxx in this patch) is
modified to support more mipsxx CPUs.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/kernel/perf_event.c        |    7 +-
 arch/mips/kernel/perf_event_mipsxx.c |  125 ++++++++++++------
 arch/mips/oprofile/common.c          |  237 +++++++++++++++++++++++++---------
 3 files changed, 266 insertions(+), 103 deletions(-)

diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index dc3a553..f3bb2f9 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -390,6 +390,9 @@ mipspmu_map_general_event(int idx)
 {
 	const struct mips_perf_event *pev;
 
+	if (!mipspmu->general_event_map)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	pev = ((*mipspmu->general_event_map)[idx].event_id ==
 		UNSUPPORTED_PERF_EVENT_ID ? ERR_PTR(-EOPNOTSUPP) :
 		&(*mipspmu->general_event_map)[idx]);
@@ -415,6 +418,9 @@ mipspmu_map_cache_event(u64 config)
 	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
 		return ERR_PTR(-EINVAL);
 
+	if (!mipspmu->cache_event_map)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	pev = &((*mipspmu->cache_event_map)
 					[cache_type]
 					[cache_op]
@@ -424,7 +430,6 @@ mipspmu_map_cache_event(u64 config)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	return pev;
-
 }
 
 static int validate_event(struct cpu_hw_events *cpuc,
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 4e37a3a..aa8f5f9 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -904,39 +904,36 @@ mipsxx_pmu_map_raw_event(u64 config)
 			raw_event.range = T;
 #endif
 		break;
+	case CPU_20KC:
+	case CPU_25KF:
+	case CPU_5KC:
+	case CPU_R10000:
+	case CPU_R12000:
+	case CPU_R14000:
+	case CPU_SB1:
+	case CPU_SB1A:
+		raw_event.event_id = base_id;
+		raw_event.cntr_mask = raw_id > 127 ? CNTR_ODD : CNTR_EVEN;
+#ifdef CONFIG_MIPS_MT_SMP
+		raw_event.range = P;
+#endif
+		break;
 	}
 
 	return &raw_event;
 }
 
 static struct mips_pmu mipsxxcore_pmu = {
-	.handle_irq = mipsxx_pmu_handle_irq,
-	.handle_shared_irq = mipsxx_pmu_handle_shared_irq,
-	.start = mipsxx_pmu_start,
-	.stop = mipsxx_pmu_stop,
-	.alloc_counter = mipsxx_pmu_alloc_counter,
-	.read_counter = mipsxx_pmu_read_counter,
-	.write_counter = mipsxx_pmu_write_counter,
-	.enable_event = mipsxx_pmu_enable_event,
-	.disable_event = mipsxx_pmu_disable_event,
-	.map_raw_event = mipsxx_pmu_map_raw_event,
-	.general_event_map = &mipsxxcore_event_map,
-	.cache_event_map = &mipsxxcore_cache_map,
-};
-
-static struct mips_pmu mipsxx74Kcore_pmu = {
-	.handle_irq = mipsxx_pmu_handle_irq,
-	.handle_shared_irq = mipsxx_pmu_handle_shared_irq,
-	.start = mipsxx_pmu_start,
-	.stop = mipsxx_pmu_stop,
-	.alloc_counter = mipsxx_pmu_alloc_counter,
-	.read_counter = mipsxx_pmu_read_counter,
-	.write_counter = mipsxx_pmu_write_counter,
-	.enable_event = mipsxx_pmu_enable_event,
-	.disable_event = mipsxx_pmu_disable_event,
-	.map_raw_event = mipsxx_pmu_map_raw_event,
-	.general_event_map = &mipsxx74Kcore_event_map,
-	.cache_event_map = &mipsxx74Kcore_cache_map,
+	.handle_irq		= mipsxx_pmu_handle_irq,
+	.handle_shared_irq	= mipsxx_pmu_handle_shared_irq,
+	.start			= mipsxx_pmu_start,
+	.stop			= mipsxx_pmu_stop,
+	.alloc_counter		= mipsxx_pmu_alloc_counter,
+	.read_counter		= mipsxx_pmu_read_counter,
+	.write_counter		= mipsxx_pmu_write_counter,
+	.enable_event		= mipsxx_pmu_enable_event,
+	.disable_event		= mipsxx_pmu_disable_event,
+	.map_raw_event		= mipsxx_pmu_map_raw_event,
 };
 
 static int __init
@@ -963,35 +960,77 @@ init_hw_perf_events(void)
 	switch (current_cpu_type()) {
 	case CPU_24K:
 		mipsxxcore_pmu.id = MIPS_PMU_ID_24K;
-		mipsxxcore_pmu.num_counters = counters;
-		mipspmu = &mipsxxcore_pmu;
+		mipsxxcore_pmu.general_event_map = &mipsxxcore_event_map;
+		mipsxxcore_pmu.cache_event_map = &mipsxxcore_cache_map;
 		break;
 	case CPU_34K:
 		mipsxxcore_pmu.id = MIPS_PMU_ID_34K;
-		mipsxxcore_pmu.num_counters = counters;
-		mipspmu = &mipsxxcore_pmu;
+		mipsxxcore_pmu.general_event_map = &mipsxxcore_event_map;
+		mipsxxcore_pmu.cache_event_map = &mipsxxcore_cache_map;
 		break;
 	case CPU_74K:
-		mipsxx74Kcore_pmu.id = MIPS_PMU_ID_74K;
-		mipsxx74Kcore_pmu.num_counters = counters;
-		mipspmu = &mipsxx74Kcore_pmu;
+		mipsxxcore_pmu.id = MIPS_PMU_ID_74K;
+		mipsxxcore_pmu.general_event_map = &mipsxx74Kcore_event_map;
+		mipsxxcore_pmu.cache_event_map = &mipsxx74Kcore_cache_map;
 		break;
 	case CPU_1004K:
 		mipsxxcore_pmu.id = MIPS_PMU_ID_1004K;
-		mipsxxcore_pmu.num_counters = counters;
-		mipspmu = &mipsxxcore_pmu;
+		mipsxxcore_pmu.general_event_map = &mipsxxcore_event_map;
+		mipsxxcore_pmu.cache_event_map = &mipsxxcore_cache_map;
+		break;
+	/*
+	 * To make perf events fully supported for the following cores,
+	 * we need to fill out the general event map and the cache event
+	 * map. Before that, raw events are supported on these cores.
+	 * Note that the raw events for these cores do not go through the
+	 * accurate check in mipsxx_pmu_map_raw_event(), but they can make
+	 * the perf events the backend of perf clients such as Oprofile.
+	 */
+	case CPU_20KC:
+		mipsxxcore_pmu.id = MIPS_PMU_ID_20K;
+		mipsxxcore_pmu.general_event_map = NULL;
+		mipsxxcore_pmu.cache_event_map = NULL;
+		break;
+	case CPU_25KF:
+		mipsxxcore_pmu.id = MIPS_PMU_ID_25K;
+		mipsxxcore_pmu.general_event_map = NULL;
+		mipsxxcore_pmu.cache_event_map = NULL;
+		break;
+	case CPU_5KC:
+		mipsxxcore_pmu.id = MIPS_PMU_ID_5K;
+		mipsxxcore_pmu.general_event_map = NULL;
+		mipsxxcore_pmu.cache_event_map = NULL;
+		break;
+	case CPU_R10000:
+		if ((current_cpu_data.processor_id & 0xff) == 0x20)
+			mipsxxcore_pmu.id = MIPS_PMU_ID_R10000V2;
+		else
+			mipsxxcore_pmu.id = MIPS_PMU_ID_R10000;
+
+		mipsxxcore_pmu.general_event_map = NULL;
+		mipsxxcore_pmu.cache_event_map = NULL;
+		break;
+	case CPU_R12000:
+	case CPU_R14000:
+		mipsxxcore_pmu.id = MIPS_PMU_ID_R12000;
+		mipsxxcore_pmu.general_event_map = NULL;
+		mipsxxcore_pmu.cache_event_map = NULL;
+		break;
+	case CPU_SB1:
+	case CPU_SB1A:
+		mipsxxcore_pmu.id = MIPS_PMU_ID_SB1;
+		mipsxxcore_pmu.general_event_map = NULL;
+		mipsxxcore_pmu.cache_event_map = NULL;
 		break;
 	default:
-		pr_cont("Either hardware does not support performance "
-			"counters, or not yet implemented.\n");
+		pr_cont("Perf events unsupported for this CPU.\n");
 		return -ENODEV;
 	}
+	mipsxxcore_pmu.num_counters = counters;
+	mipspmu = &mipsxxcore_pmu;
 
-	if (mipspmu)
-		pr_cont("%s PMU enabled, %d counters available to each "
-			"CPU\n",
-			mips_pmu_names[mipspmu->id],
-			mipspmu->num_counters);
+	pr_cont("%s PMU enabled, %d counters available to each "
+		"CPU\n", mips_pmu_names[mipspmu->id], mipspmu->num_counters);
 
 	return 0;
 }
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index f9eb1ab..673745d 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -5,40 +5,160 @@
  *
  * Copyright (C) 2004, 2005 Ralf Baechle
  * Copyright (C) 2005 MIPS Technologies, Inc.
+ * Copyright (C) 2010 MIPS Technologies, Inc. Deng-Cheng Zhu (Using perf
+ * events as the backend of Oprofile. This is mainly based on the idea and
+ * the code for ARM.)
  */
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/oprofile.h>
 #include <linux/smp.h>
+#include <linux/cpumask.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
 #include <asm/cpu-info.h>
+#include <asm/pmu.h>
+
+#ifdef CONFIG_HW_PERF_EVENTS
+/* Per-counter configuration as set via oprofilefs.  */
+struct op_counter_config {
+	unsigned long enabled;
+	unsigned long event;
+	unsigned long count;
+	/* Dummies because I am too lazy to hack the userspace tools.  */
+	unsigned long kernel;
+	unsigned long user;
+	unsigned long exl;
+	unsigned long unit_mask;
+	struct perf_event_attr attr;
+};
+static struct op_counter_config ctr[20];
+static struct perf_event **perf_events[nr_cpumask_bits];
+static int perf_num_counters;
 
-#include "op_impl.h"
+/*
+ * Overflow callback for oprofile.
+ */
+static void op_overflow_handler(struct perf_event *event, int unused,
+		struct perf_sample_data *data, struct pt_regs *regs)
+{
+	int id;
+	u32 cpu = smp_processor_id();
+
+	for (id = 0; id < perf_num_counters; ++id)
+		if (perf_events[cpu][id] == event)
+			break;
+
+	if (id != perf_num_counters)
+		oprofile_add_sample(regs, id);
+	else
+		pr_warning("oprofile: ignoring spurious overflow "
+			"on cpu %u\n", cpu);
+}
 
-extern struct op_mips_model op_model_mipsxx_ops __weak;
-extern struct op_mips_model op_model_rm9000_ops __weak;
-extern struct op_mips_model op_model_loongson2_ops __weak;
+/*
+ * Attributes are created as "pinned" events and so are permanently
+ * scheduled on the PMU.
+ */
+static void op_perf_setup(void)
+{
+	int i;
+	u32 size = sizeof(struct perf_event_attr);
+	struct perf_event_attr *attr;
+
+	for (i = 0; i < perf_num_counters; ++i) {
+		attr = &ctr[i].attr;
+		memset(attr, 0, size);
+		attr->type		= PERF_TYPE_RAW;
+		attr->size		= size;
+		attr->config		= ctr[i].event + (i & 0x1 ? 128 : 0);
+		attr->sample_period	= ctr[i].count;
+		attr->pinned		= 1;
+		/*
+		 * Only exclude_user/exclude_kernel/exclude_hv are defined
+		 * in perf_event_attr, maybe we can use exclude_hv for exl.
+		 * But user space perf/oprofile tools need to get agreement.
+		 */
+		if (!ctr[i].user)
+			attr->exclude_user = 1;
+		if (!ctr[i].kernel && !ctr[i].exl)
+			attr->exclude_kernel = 1;
+	}
+}
 
-static struct op_mips_model *model;
+static int op_create_counter(int cpu, int event)
+{
+	int ret = 0;
+	struct perf_event *pevent;
+
+	if (!ctr[event].enabled || (perf_events[cpu][event] != NULL))
+		return ret;
+
+	pevent = perf_event_create_kernel_counter(&ctr[event].attr,
+						  cpu, -1,
+						  op_overflow_handler);
+
+	if (IS_ERR(pevent)) {
+		ret = PTR_ERR(pevent);
+	} else if (pevent->state != PERF_EVENT_STATE_ACTIVE) {
+		pr_warning("oprofile: failed to enable event %d "
+			"on CPU %d (state %d)\n", event, cpu, pevent->state);
+		ret = -EBUSY;
+	} else {
+		perf_events[cpu][event] = pevent;
+	}
 
-static struct op_counter_config ctr[20];
+	return ret;
+}
 
-static int op_mips_setup(void)
+static void op_destroy_counter(int cpu, int event)
+{
+	struct perf_event *pevent = perf_events[cpu][event];
+
+	if (pevent) {
+		perf_event_release_kernel(pevent);
+		perf_events[cpu][event] = NULL;
+	}
+}
+
+static int op_perf_start(void)
 {
-	/* Pre-compute the values to stuff in the hardware registers.  */
-	model->reg_setup(ctr);
+	int cpu, event, ret = 0;
+
+	for_each_online_cpu(cpu) {
+		for (event = 0; event < perf_num_counters; ++event) {
+			ret = op_create_counter(cpu, event);
+			if (ret)
+				goto out;
+		}
+	}
+
+out:
+	return ret;
+}
 
-	/* Configure the registers on all cpus.  */
-	on_each_cpu(model->cpu_setup, NULL, 1);
+static void op_perf_stop(void)
+{
+	int cpu, event;
 
-        return 0;
+	for_each_online_cpu(cpu)
+		for (event = 0; event < perf_num_counters; ++event)
+			op_destroy_counter(cpu, event);
+}
+
+static int op_mips_setup(void)
+{
+	op_perf_setup();
+
+	return 0;
 }
 
 static int op_mips_create_files(struct super_block *sb, struct dentry *root)
 {
 	int i;
 
-	for (i = 0; i < model->num_counters; ++i) {
+	for (i = 0; i < perf_num_counters; ++i) {
 		struct dentry *dir;
 		char buf[4];
 
@@ -60,70 +180,69 @@ static int op_mips_create_files(struct super_block *sb, struct dentry *root)
 
 static int op_mips_start(void)
 {
-	on_each_cpu(model->cpu_start, NULL, 1);
-
-	return 0;
+	return op_perf_start();
 }
 
 static void op_mips_stop(void)
 {
-	/* Disable performance monitoring for all counters.  */
-	on_each_cpu(model->cpu_stop, NULL, 1);
+	op_perf_stop();
 }
 
 int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
-	struct op_mips_model *lmodel = NULL;
-	int res;
-
-	switch (current_cpu_type()) {
-	case CPU_5KC:
-	case CPU_20KC:
-	case CPU_24K:
-	case CPU_25KF:
-	case CPU_34K:
-	case CPU_1004K:
-	case CPU_74K:
-	case CPU_SB1:
-	case CPU_SB1A:
-	case CPU_R10000:
-	case CPU_R12000:
-	case CPU_R14000:
-		lmodel = &op_model_mipsxx_ops;
-		break;
-
-	case CPU_RM9000:
-		lmodel = &op_model_rm9000_ops;
-		break;
-	case CPU_LOONGSON2:
-		lmodel = &op_model_loongson2_ops;
-		break;
-	};
-
-	if (!lmodel)
-		return -ENODEV;
-
-	res = lmodel->init();
-	if (res)
-		return res;
-
-	model = lmodel;
+	int cpu;
+
+	perf_num_counters = mipspmu_get_max_events();
+
+	for_each_possible_cpu(cpu) {
+		perf_events[cpu] = kcalloc(perf_num_counters,
+				sizeof(struct perf_event *), GFP_KERNEL);
+		if (!perf_events[cpu]) {
+			pr_info("oprofile: failed to allocate %d perf events "
+				"for cpu %d\n", perf_num_counters, cpu);
+			while (--cpu >= 0)
+				kfree(perf_events[cpu]);
+			return -ENOMEM;
+		}
+	}
 
 	ops->create_files	= op_mips_create_files;
 	ops->setup		= op_mips_setup;
-	//ops->shutdown         = op_mips_shutdown;
+	ops->shutdown		= op_mips_stop;
 	ops->start		= op_mips_start;
 	ops->stop		= op_mips_stop;
-	ops->cpu_type		= lmodel->cpu_type;
+	ops->cpu_type		= (char *)mips_pmu_names[mipspmu_get_pmu_id()];
 
-	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
-	       lmodel->cpu_type);
+	if (!ops->cpu_type)
+		return -ENODEV;
+	else
+		pr_info("oprofile: using %s performance monitoring.\n",
+			ops->cpu_type);
 
 	return 0;
 }
 
 void oprofile_arch_exit(void)
 {
-	if (model)
-		model->exit();
+	int cpu, id;
+	struct perf_event *event;
+
+	if (*perf_events) {
+		for_each_possible_cpu(cpu) {
+			for (id = 0; id < perf_num_counters; ++id) {
+				event = perf_events[cpu][id];
+				if (event)
+					perf_event_release_kernel(event);
+			}
+			kfree(perf_events[cpu]);
+		}
+	}
+}
+#else
+int __init oprofile_arch_init(struct oprofile_operations *ops)
+{
+	pr_info("oprofile: hardware counters not available\n");
+	return -ENODEV;
 }
+void oprofile_arch_exit(void) {}
+#endif /* CONFIG_HW_PERF_EVENTS */
-- 
1.6.3.3
