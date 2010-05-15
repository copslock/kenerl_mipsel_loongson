Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2010 17:39:49 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:52735 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491828Ab0EOPiS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 May 2010 17:38:18 +0200
Received: by mail-pw0-f49.google.com with SMTP id 3so708651pwi.36
        for <multiple recipients>; Sat, 15 May 2010 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DnK2I1HSVfNJ4m51QdunxqxIxk7Wp1V3qRu9byJe1uY=;
        b=ufrNspcJkWnmW70bZuMY9qdq6hE3ok3/ZWL3GtDhpMJeQnwp2xK7/qnuEyV9rU+OPl
         kaieaW7E0pT28m2QeUQQjTZro0joJUNvKSG7KEK3y3D/ZgVmsEZ6r2rVi/QYOGF1AP24
         PtRUOoBw0gvtrCyNawZWv4NeRiJs9eTFmxays=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l9MYrBHYwOAo7ruAO7xV+hXMiNCYw292+wdkJXGiiSsj0RTFQhUMMJqAr5ke9XsmFT
         U4Lp8DZRCDkWZ04/yA72vTuPMC3XHJbnzKa/qIcjKwnJkYnNcwXZ6hP4t2UuBCj++9Vh
         SDQsRMIKzJgwj0ot0XmHXsONnbRCPA8SC7biM=
Received: by 10.114.237.3 with SMTP id k3mr2335277wah.219.1273937897225;
        Sat, 15 May 2010 08:38:17 -0700 (PDT)
Received: from localhost.localdomain ([114.84.90.117])
        by mx.google.com with ESMTPS id n32sm30648683wae.10.2010.05.15.08.38.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 08:38:16 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com,
        Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Subject: [PATCH v4 5/9] MIPS: move mipsxx pmu helper functions to perf events
Date:   Sat, 15 May 2010 23:36:51 +0800
Message-Id: <1273937815-4781-6-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com>
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

This is the 1st patch starting to use perf events as the backend of
Oprofile. Here we move pmu helper functions and macros between pmu.h and
perf_event*.c for mipsxx.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/include/asm/pmu.h          |  160 ++--------------------------------
 arch/mips/kernel/perf_event.c        |    2 +
 arch/mips/kernel/perf_event_mipsxx.c |  145 +++++++++++++++++++++++++++++--
 3 files changed, 147 insertions(+), 160 deletions(-)

diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h
index 162b24f..2822810 100644
--- a/arch/mips/include/asm/pmu.h
+++ b/arch/mips/include/asm/pmu.h
@@ -8,9 +8,6 @@
  * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  * Copyright (C) 2010 MIPS Technologies, Inc. Deng-Cheng Zhu
  *
- * This file is shared by Oprofile and Perf. It is also shared across the
- * Oprofile implementation for different MIPS CPUs.
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -39,160 +36,19 @@
 #define M_PERFCTL_WIDE			(1UL      << 30)
 #define M_PERFCTL_MORE			(1UL      << 31)
 
-#define M_COUNTER_OVERFLOW		(1UL      << 31)
+#define M_PERFCTL_COUNT_EVENT_WHENEVER		\
+	(M_PERFCTL_EXL | M_PERFCTL_KERNEL |	\
+	M_PERFCTL_USER | M_PERFCTL_SUPERVISOR |	\
+	M_PERFCTL_INTERRUPT_ENABLE)
 
 #ifdef CONFIG_MIPS_MT_SMP
-static int cpu_has_mipsmt_pertccounters;
-#define WHAT		(M_TC_EN_VPE | \
-			M_PERFCTL_VPEID(cpu_data[smp_processor_id()].vpe_id))
-/*
- * FIXME: For VSMP, vpe_id() is redefined for Perf, because
- * cpu_data[cpuid].vpe_id reports 0 for _both_ CPUs. WHAT is not
- * redefined because Perf does not use it.
- */
-#if defined(CONFIG_HW_PERF_EVENTS)
-#define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
-			0 : smp_processor_id())
-#else
-#define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
-			0 : cpu_data[smp_processor_id()].vpe_id)
-#endif
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
+#define M_PERFCTL_CONFIG_MASK 0x3fff801f
 #else
-#define WHAT		0
-#define vpe_id()	0
-static inline unsigned int vpe_shift(void)
-{
-	return 0;
-}
+#define M_PERFCTL_CONFIG_MASK 0x1f
 #endif
+#define M_PERFCTL_EVENT_MASK 0xfe0
 
-static inline unsigned int
-counters_total_to_per_cpu(unsigned int counters)
-{
-	return counters >> vpe_shift();
-}
-
-static inline unsigned int
-counters_per_cpu_to_total(unsigned int counters)
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
-
-/* Used by Perf */
-#define MIPS_MAX_HWEVENTS 4
+#define M_COUNTER_OVERFLOW		(1UL      << 31)
 
 #elif defined(CONFIG_CPU_RM9000)
 
diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
index 24e07f8..0ef54e6 100644
--- a/arch/mips/kernel/perf_event.c
+++ b/arch/mips/kernel/perf_event.c
@@ -27,6 +27,7 @@
 
 
 #define MAX_PERIOD ((1ULL << 32) - 1)
+#define MIPS_MAX_HWEVENTS 4
 
 struct cpu_hw_events {
 	/* Array of events on this cpu. */
@@ -428,6 +429,7 @@ static int validate_group(struct perf_event *event)
  * specific low-level init routines.
  */
 static int __hw_perf_event_init(struct perf_event *event);
+static void reset_counters(void *arg);
 
 static void hw_perf_event_destroy(struct perf_event *event)
 {
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 802d98e..1c92917 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1,17 +1,146 @@
 #if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64) || \
     defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_SB1)
 
-#define M_PERFCTL_COUNT_EVENT_WHENEVER		\
-	(M_PERFCTL_EXL | M_PERFCTL_KERNEL |	\
-	M_PERFCTL_USER | M_PERFCTL_SUPERVISOR |	\
-	M_PERFCTL_INTERRUPT_ENABLE)
-
 #ifdef CONFIG_MIPS_MT_SMP
-#define M_PERFCTL_CONFIG_MASK 0x3fff801f
+static int cpu_has_mipsmt_pertccounters;
+/*
+ * FIXME: For VSMP, cpu_data[cpuid].vpe_id reports 0 for _both_ CPUs. So
+ * we use smp_processor_id() to identify VPEs.
+ */
+#define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
+			0 : smp_processor_id())
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
 #else
-#define M_PERFCTL_CONFIG_MASK 0x1f
+#define vpe_id()	0
+static inline unsigned int vpe_shift(void)
+{
+	return 0;
+}
 #endif
-#define M_PERFCTL_EVENT_MASK 0xfe0
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
 
 static inline unsigned int
 mipsxx_pmu_read_counter(unsigned int idx)
-- 
1.6.3.3
