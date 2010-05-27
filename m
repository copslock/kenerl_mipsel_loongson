Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 15:04:53 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:46150 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492355Ab0E0NE1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 May 2010 15:04:27 +0200
Received: by pwi2 with SMTP id 2so248069pwi.36
        for <multiple recipients>; Thu, 27 May 2010 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3DfMfZGXmQYJ1/sf2yuiTCoYpPhYTQK2ik4pXyei3tg=;
        b=RbXeD+SNlqLbUQSOC2UNzvcLGRTIeq0eRhw7eDfwOPB9vYypwX9agf0k+6Zr3jeIaM
         19mwLgK15SGLl7vIF2tfwtdR2fla7gas1oPbYd32UDiQdBL33/rOxTTydvL1h4ZMQW5x
         JIgG286ZZpSSwuoCqy5fIyXQD9L2sDH1cm7l8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OJ+0uXFeHFNF1MrvLm4yiuMxoLAhxZ4HO2Y9pVxfmkjT+d61uTJlxX6XQgltelyeks
         9Gk3QNHEKs3evQgDyIf/iktBIg55Yh9hJ/+7VUxVIzIogLAA/AzGoKhBYltLuT2c+nRe
         nV21MQdJmOdebpA2YNeQpgcmElSQLocCUEfFA=
Received: by 10.143.87.5 with SMTP id p5mr7053639wfl.221.1274965458758;
        Thu, 27 May 2010 06:04:18 -0700 (PDT)
Received: from localhost.localdomain ([114.84.70.124])
        by mx.google.com with ESMTPS id 21sm972927pzk.8.2010.05.27.06.04.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 06:04:17 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v5 01/12] MIPS/Oprofile: extract PMU defines/helper functions for sharing
Date:   Thu, 27 May 2010 21:03:29 +0800
Message-Id: <1274965420-5091-2-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Moving performance counter/control defines/helper functions into a single
header file, so that software using the MIPS PMU can share the code.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/include/asm/pmu.h             |  236 +++++++++++++++++++++++++++++++
 arch/mips/oprofile/op_model_loongson2.c |   18 +---
 arch/mips/oprofile/op_model_mipsxx.c    |  164 +---------------------
 arch/mips/oprofile/op_model_rm9000.c    |   16 +--
 4 files changed, 240 insertions(+), 194 deletions(-)
 create mode 100644 arch/mips/include/asm/pmu.h

diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h
new file mode 100644
index 0000000..162b24f
--- /dev/null
+++ b/arch/mips/include/asm/pmu.h
@@ -0,0 +1,236 @@
+/*
+ * linux/arch/mips/include/asm/pmu.h
+ *
+ * Copyright (C) 2004, 05, 06 by Ralf Baechle
+ * Copyright (C) 2005 by MIPS Technologies, Inc.
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Yanhua <yanh@lemote.com>
+ * Author: Wu Zhangjin <wuzhangjin@gmail.com>
+ * Copyright (C) 2010 MIPS Technologies, Inc. Deng-Cheng Zhu
+ *
+ * This file is shared by Oprofile and Perf. It is also shared across the
+ * Oprofile implementation for different MIPS CPUs.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MIPS_PMU_H__
+#define __MIPS_PMU_H__
+
+#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64) || \
+    defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_SB1)
+
+#define M_CONFIG1_PC	(1 << 4)
+
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
+#ifdef CONFIG_MIPS_MT_SMP
+static int cpu_has_mipsmt_pertccounters;
+#define WHAT		(M_TC_EN_VPE | \
+			M_PERFCTL_VPEID(cpu_data[smp_processor_id()].vpe_id))
+/*
+ * FIXME: For VSMP, vpe_id() is redefined for Perf, because
+ * cpu_data[cpuid].vpe_id reports 0 for _both_ CPUs. WHAT is not
+ * redefined because Perf does not use it.
+ */
+#if defined(CONFIG_HW_PERF_EVENTS)
+#define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
+			0 : smp_processor_id())
+#else
+#define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
+			0 : cpu_data[smp_processor_id()].vpe_id)
+#endif
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
+#else
+#define WHAT		0
+#define vpe_id()	0
+static inline unsigned int vpe_shift(void)
+{
+	return 0;
+}
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
+
+/* Used by Perf */
+#define MIPS_MAX_HWEVENTS 4
+
+#elif defined(CONFIG_CPU_RM9000)
+
+#define RM9K_COUNTER1_EVENT(event)	((event) << 0)
+#define RM9K_COUNTER1_SUPERVISOR	(1ULL    <<  7)
+#define RM9K_COUNTER1_KERNEL		(1ULL    <<  8)
+#define RM9K_COUNTER1_USER		(1ULL    <<  9)
+#define RM9K_COUNTER1_ENABLE		(1ULL    << 10)
+#define RM9K_COUNTER1_OVERFLOW		(1ULL    << 15)
+
+#define RM9K_COUNTER2_EVENT(event)	((event) << 16)
+#define RM9K_COUNTER2_SUPERVISOR	(1ULL    << 23)
+#define RM9K_COUNTER2_KERNEL		(1ULL    << 24)
+#define RM9K_COUNTER2_USER		(1ULL    << 25)
+#define RM9K_COUNTER2_ENABLE		(1ULL    << 26)
+#define RM9K_COUNTER2_OVERFLOW		(1ULL    << 31)
+
+extern unsigned int rm9000_perfcount_irq;
+
+#elif defined(CONFIG_CPU_LOONGSON2)
+
+#define LOONGSON2_CPU_TYPE	"mips/loongson2"
+
+#define LOONGSON2_PERFCNT_OVERFLOW		(1ULL   << 31)
+
+#define LOONGSON2_PERFCTRL_EXL			(1UL	<<  0)
+#define LOONGSON2_PERFCTRL_KERNEL		(1UL    <<  1)
+#define LOONGSON2_PERFCTRL_SUPERVISOR		(1UL    <<  2)
+#define LOONGSON2_PERFCTRL_USER			(1UL    <<  3)
+#define LOONGSON2_PERFCTRL_ENABLE		(1UL    <<  4)
+#define LOONGSON2_PERFCTRL_EVENT(idx, event) \
+	(((event) & 0x0f) << ((idx) ? 9 : 5))
+
+#define read_c0_perfctrl() __read_64bit_c0_register($24, 0)
+#define write_c0_perfctrl(val) __write_64bit_c0_register($24, 0, val)
+#define read_c0_perfcnt() __read_64bit_c0_register($25, 0)
+#define write_c0_perfcnt(val) __write_64bit_c0_register($25, 0, val)
+
+#endif /* CONFIG_CPU_* */
+
+#endif /* __MIPS_PMU_H__ */
diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index d0d24e0..9e61ecd 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -12,27 +12,11 @@
 #include <linux/init.h>
 #include <linux/oprofile.h>
 #include <linux/interrupt.h>
+#include <asm/pmu.h>
 
 #include <loongson.h>			/* LOONGSON2_PERFCNT_IRQ */
 #include "op_impl.h"
 
-#define LOONGSON2_CPU_TYPE	"mips/loongson2"
-
-#define LOONGSON2_PERFCNT_OVERFLOW		(1ULL   << 31)
-
-#define LOONGSON2_PERFCTRL_EXL			(1UL	<<  0)
-#define LOONGSON2_PERFCTRL_KERNEL		(1UL    <<  1)
-#define LOONGSON2_PERFCTRL_SUPERVISOR		(1UL    <<  2)
-#define LOONGSON2_PERFCTRL_USER			(1UL    <<  3)
-#define LOONGSON2_PERFCTRL_ENABLE		(1UL    <<  4)
-#define LOONGSON2_PERFCTRL_EVENT(idx, event) \
-	(((event) & 0x0f) << ((idx) ? 9 : 5))
-
-#define read_c0_perfctrl() __read_64bit_c0_register($24, 0)
-#define write_c0_perfctrl(val) __write_64bit_c0_register($24, 0, val)
-#define read_c0_perfcnt() __read_64bit_c0_register($25, 0)
-#define write_c0_perfcnt(val) __write_64bit_c0_register($25, 0, val)
-
 static struct loongson2_register_config {
 	unsigned int ctrl;
 	unsigned long long reset_counter1;
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 54759f1..96f14e8 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -11,116 +11,10 @@
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <asm/irq_regs.h>
+#include <asm/pmu.h>
 
 #include "op_impl.h"
 
-#define M_PERFCTL_EXL			(1UL      <<  0)
-#define M_PERFCTL_KERNEL		(1UL      <<  1)
-#define M_PERFCTL_SUPERVISOR		(1UL      <<  2)
-#define M_PERFCTL_USER			(1UL      <<  3)
-#define M_PERFCTL_INTERRUPT_ENABLE	(1UL      <<  4)
-#define M_PERFCTL_EVENT(event)		(((event) & 0x3ff)  << 5)
-#define M_PERFCTL_VPEID(vpe)		((vpe)    << 16)
-#define M_PERFCTL_MT_EN(filter)		((filter) << 20)
-#define    M_TC_EN_ALL			M_PERFCTL_MT_EN(0)
-#define    M_TC_EN_VPE			M_PERFCTL_MT_EN(1)
-#define    M_TC_EN_TC			M_PERFCTL_MT_EN(2)
-#define M_PERFCTL_TCID(tcid)		((tcid)   << 22)
-#define M_PERFCTL_WIDE			(1UL      << 30)
-#define M_PERFCTL_MORE			(1UL      << 31)
-
-#define M_COUNTER_OVERFLOW		(1UL      << 31)
-
-static int (*save_perf_irq)(void);
-
-#ifdef CONFIG_MIPS_MT_SMP
-static int cpu_has_mipsmt_pertccounters;
-#define WHAT		(M_TC_EN_VPE | \
-			 M_PERFCTL_VPEID(cpu_data[smp_processor_id()].vpe_id))
-#define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
-			0 : cpu_data[smp_processor_id()].vpe_id)
-
-/*
- * The number of bits to shift to convert between counters per core and
- * counters per VPE.  There is no reasonable interface atm to obtain the
- * number of VPEs used by Linux and in the 34K this number is fixed to two
- * anyways so we hardcore a few things here for the moment.  The way it's
- * done here will ensure that oprofile VSMP kernel will run right on a lesser
- * core like a 24K also or with maxcpus=1.
- */
-static inline unsigned int vpe_shift(void)
-{
-	if (num_possible_cpus() > 1)
-		return 1;
-
-	return 0;
-}
-
-#else
-
-#define WHAT		0
-#define vpe_id()	0
-
-static inline unsigned int vpe_shift(void)
-{
-	return 0;
-}
-
-#endif
-
-static inline unsigned int counters_total_to_per_cpu(unsigned int counters)
-{
-	return counters >> vpe_shift();
-}
-
-static inline unsigned int counters_per_cpu_to_total(unsigned int counters)
-{
-	return counters << vpe_shift();
-}
-
-#define __define_perf_accessors(r, n, np)				\
-									\
-static inline unsigned int r_c0_ ## r ## n(void)			\
-{									\
-	unsigned int cpu = vpe_id();					\
-									\
-	switch (cpu) {							\
-	case 0:								\
-		return read_c0_ ## r ## n();				\
-	case 1:								\
-		return read_c0_ ## r ## np();				\
-	default:							\
-		BUG();							\
-	}								\
-	return 0;							\
-}									\
-									\
-static inline void w_c0_ ## r ## n(unsigned int value)			\
-{									\
-	unsigned int cpu = vpe_id();					\
-									\
-	switch (cpu) {							\
-	case 0:								\
-		write_c0_ ## r ## n(value);				\
-		return;							\
-	case 1:								\
-		write_c0_ ## r ## np(value);				\
-		return;							\
-	default:							\
-		BUG();							\
-	}								\
-	return;								\
-}									\
-
-__define_perf_accessors(perfcntr, 0, 2)
-__define_perf_accessors(perfcntr, 1, 3)
-__define_perf_accessors(perfcntr, 2, 0)
-__define_perf_accessors(perfcntr, 3, 1)
-
-__define_perf_accessors(perfctrl, 0, 2)
-__define_perf_accessors(perfctrl, 1, 3)
-__define_perf_accessors(perfctrl, 2, 0)
-__define_perf_accessors(perfctrl, 3, 1)
 
 struct op_mips_model op_model_mipsxx_ops;
 
@@ -242,61 +136,7 @@ static int mipsxx_perfcount_handler(void)
 	return handled;
 }
 
-#define M_CONFIG1_PC	(1 << 4)
-
-static inline int __n_counters(void)
-{
-	if (!(read_c0_config1() & M_CONFIG1_PC))
-		return 0;
-	if (!(read_c0_perfctrl0() & M_PERFCTL_MORE))
-		return 1;
-	if (!(read_c0_perfctrl1() & M_PERFCTL_MORE))
-		return 2;
-	if (!(read_c0_perfctrl2() & M_PERFCTL_MORE))
-		return 3;
-
-	return 4;
-}
-
-static inline int n_counters(void)
-{
-	int counters;
-
-	switch (current_cpu_type()) {
-	case CPU_R10000:
-		counters = 2;
-		break;
-
-	case CPU_R12000:
-	case CPU_R14000:
-		counters = 4;
-		break;
-
-	default:
-		counters = __n_counters();
-	}
-
-	return counters;
-}
-
-static void reset_counters(void *arg)
-{
-	int counters = (int)(long)arg;
-	switch (counters) {
-	case 4:
-		w_c0_perfctrl3(0);
-		w_c0_perfcntr3(0);
-	case 3:
-		w_c0_perfctrl2(0);
-		w_c0_perfcntr2(0);
-	case 2:
-		w_c0_perfctrl1(0);
-		w_c0_perfcntr1(0);
-	case 1:
-		w_c0_perfctrl0(0);
-		w_c0_perfcntr0(0);
-	}
-}
+static int (*save_perf_irq)(void);
 
 static int __init mipsxx_init(void)
 {
diff --git a/arch/mips/oprofile/op_model_rm9000.c b/arch/mips/oprofile/op_model_rm9000.c
index 3aa8138..48e7487 100644
--- a/arch/mips/oprofile/op_model_rm9000.c
+++ b/arch/mips/oprofile/op_model_rm9000.c
@@ -9,24 +9,10 @@
 #include <linux/oprofile.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
+#include <asm/pmu.h>
 
 #include "op_impl.h"
 
-#define RM9K_COUNTER1_EVENT(event)	((event) << 0)
-#define RM9K_COUNTER1_SUPERVISOR	(1ULL    <<  7)
-#define RM9K_COUNTER1_KERNEL		(1ULL    <<  8)
-#define RM9K_COUNTER1_USER		(1ULL    <<  9)
-#define RM9K_COUNTER1_ENABLE		(1ULL    << 10)
-#define RM9K_COUNTER1_OVERFLOW		(1ULL    << 15)
-
-#define RM9K_COUNTER2_EVENT(event)	((event) << 16)
-#define RM9K_COUNTER2_SUPERVISOR	(1ULL    << 23)
-#define RM9K_COUNTER2_KERNEL		(1ULL    << 24)
-#define RM9K_COUNTER2_USER		(1ULL    << 25)
-#define RM9K_COUNTER2_ENABLE		(1ULL    << 26)
-#define RM9K_COUNTER2_OVERFLOW		(1ULL    << 31)
-
-extern unsigned int rm9000_perfcount_irq;
 
 static struct rm9k_register_config {
 	unsigned int control;
-- 
1.6.3.3
