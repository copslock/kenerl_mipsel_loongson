Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2012 16:06:55 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:4779 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903692Ab2D1OGs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Apr 2012 16:06:48 +0200
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 28 Apr 2012 07:06:40 -0700
X-Server-Uuid: 72204117-5C29-4314-8910-60DB108979CB
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Sat, 28 Apr 2012 07:05:49 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id BF2799F9F5; Sat, 28
 Apr 2012 07:06:27 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Sat, 28 Apr 2012 07:06:27 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Madhusudan Bhat" <mbhat@netlogicmicro.com>,
        "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 1/2] MIPS: oprofile: Support for XLR/XLS processors
Date:   Sat, 28 Apr 2012 19:36:20 +0530
Message-ID: <1335621981-18259-1-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 638526FA3JG2125327-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Madhusudan Bhat <mbhat@netlogicmicro.com>

Add support for XLR and XLS processors in MIPS Oprofile code. These
processors are multi-threaded and have two counters per core. Each
counter can track either all the events in the core (global mode),
or events in just one thread.

We use the counters in the global mode, and use only the first thread
in each core to handle the configuration etc.

Signed-off-by: Madhusudan Bhat <mbhat@netlogicmicro.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/oprofile/Makefile          |    1 +
 arch/mips/oprofile/common.c          |    1 +
 arch/mips/oprofile/op_model_mipsxx.c |   29 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/mips/oprofile/Makefile b/arch/mips/oprofile/Makefile
index 29f2f13..e851d10 100644
--- a/arch/mips/oprofile/Makefile
+++ b/arch/mips/oprofile/Makefile
@@ -14,5 +14,6 @@ oprofile-$(CONFIG_CPU_MIPS32)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_MIPS64)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_R10000)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
+oprofile-$(CONFIG_CPU_XLR)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_RM9000)		+= op_model_rm9000.o
 oprofile-$(CONFIG_CPU_LOONGSON2)	+= op_model_loongson2.o
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index d1f2d4c..0c01142 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -89,6 +89,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_R10000:
 	case CPU_R12000:
 	case CPU_R14000:
+	case CPU_XLR:
 		lmodel = &op_model_mipsxx_ops;
 		break;
 
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 54759f1..15cbc34 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -31,8 +31,22 @@
 
 #define M_COUNTER_OVERFLOW		(1UL      << 31)
 
+/* Netlogic XLR specific, count events in all threads in a core */
+#define M_PERFCTL_COUNT_ALL_THREADS	(1UL      << 13)
+
 static int (*save_perf_irq)(void);
 
+/*
+ * XLR has only one set of counters per core. Designate the
+ * first hardware thread in the core for setup and init.
+ * Skip CPUs with non-zero hardware thread id (4 hwt per core)
+ */
+#ifdef CONFIG_CPU_XLR
+#define oprofile_skip_cpu(c)	((cpu_logical_map(c) & 0x3) != 0)
+#else
+#define oprofile_skip_cpu(c)	0
+#endif
+
 #ifdef CONFIG_MIPS_MT_SMP
 static int cpu_has_mipsmt_pertccounters;
 #define WHAT		(M_TC_EN_VPE | \
@@ -152,6 +166,8 @@ static void mipsxx_reg_setup(struct op_counter_config *ctr)
 			reg.control[i] |= M_PERFCTL_USER;
 		if (ctr[i].exl)
 			reg.control[i] |= M_PERFCTL_EXL;
+		if (current_cpu_type() == CPU_XLR)
+			reg.control[i] |= M_PERFCTL_COUNT_ALL_THREADS;
 		reg.counter[i] = 0x80000000 - ctr[i].count;
 	}
 }
@@ -162,6 +178,9 @@ static void mipsxx_cpu_setup(void *args)
 {
 	unsigned int counters = op_model_mipsxx_ops.num_counters;
 
+	if (oprofile_skip_cpu(smp_processor_id()))
+		return;
+
 	switch (counters) {
 	case 4:
 		w_c0_perfctrl3(0);
@@ -183,6 +202,9 @@ static void mipsxx_cpu_start(void *args)
 {
 	unsigned int counters = op_model_mipsxx_ops.num_counters;
 
+	if (oprofile_skip_cpu(smp_processor_id()))
+		return;
+
 	switch (counters) {
 	case 4:
 		w_c0_perfctrl3(WHAT | reg.control[3]);
@@ -200,6 +222,9 @@ static void mipsxx_cpu_stop(void *args)
 {
 	unsigned int counters = op_model_mipsxx_ops.num_counters;
 
+	if (oprofile_skip_cpu(smp_processor_id()))
+		return;
+
 	switch (counters) {
 	case 4:
 		w_c0_perfctrl3(0);
@@ -365,6 +390,10 @@ static int __init mipsxx_init(void)
 		op_model_mipsxx_ops.cpu_type = "mips/sb1";
 		break;
 
+	case CPU_XLR:
+		op_model_mipsxx_ops.cpu_type = "mips/xlr";
+		break;
+
 	default:
 		printk(KERN_ERR "Profiling unsupported for this CPU\n");
 
-- 
1.7.9.5
