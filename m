Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 18:28:15 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:2885 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903729Ab2GMQYm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2012 18:24:42 +0200
Received: from [10.9.200.131] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 13 Jul 2012 09:23:34 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 13 Jul 2012 09:24:32 -0700
Received: from hqcas02.netlogicmicro.com (unknown [10.65.50.15]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 37CC69F9F5; Fri, 13
 Jul 2012 09:24:32 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas02.netlogicmicro.com (10.65.50.15) with Microsoft SMTP Server id
 14.1.339.1; Fri, 13 Jul 2012 09:24:31 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Madhusudan Bhat" <mbhat@netlogicmicro.com>,
        "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 10/12] MIPS: oprofile: Support for XLR/XLS processors
Date:   Fri, 13 Jul 2012 21:53:23 +0530
Message-ID: <1342196605-4260-11-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 7C1E940C3NK5404007-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
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
index 1208c28..65f5237 100644
--- a/arch/mips/oprofile/Makefile
+++ b/arch/mips/oprofile/Makefile
@@ -12,5 +12,6 @@ oprofile-$(CONFIG_CPU_MIPS32)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_MIPS64)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_R10000)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
+oprofile-$(CONFIG_CPU_XLR)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_RM9000)		+= op_model_rm9000.o
 oprofile-$(CONFIG_CPU_LOONGSON2)	+= op_model_loongson2.o
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index f80480a..abd5a02 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -91,6 +91,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	case CPU_R10000:
 	case CPU_R12000:
 	case CPU_R14000:
+	case CPU_XLR:
 		lmodel = &op_model_mipsxx_ops;
 		break;
 
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 28ea1a4..7862546 100644
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
@@ -372,6 +397,10 @@ static int __init mipsxx_init(void)
 		op_model_mipsxx_ops.cpu_type = "mips/loongson1";
 		break;
 
+	case CPU_XLR:
+		op_model_mipsxx_ops.cpu_type = "mips/xlr";
+		break;
+
 	default:
 		printk(KERN_ERR "Profiling unsupported for this CPU\n");
 
-- 
1.7.9.5
