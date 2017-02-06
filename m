Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 13:38:14 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21223 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991532AbdBFMh6DWEYo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 13:37:58 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 5808E85E551A2;
        Mon,  6 Feb 2017 12:37:47 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 6 Feb 2017 12:37:50 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Robert Richter <rric@kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <oprofile-list@lists.sf.net>
Subject: [PATCH] MIPS: Unify perf counter register definitions
Date:   Mon, 6 Feb 2017 12:37:45 +0000
Message-ID: <c13bc10e3242fd9ef763ba5e7c2e0ec7658b2702.1486384568.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Unify definitions for MIPS performance counter register fields in
mipsregs.h rather than duplicating them in perf_events and oprofile.
This will allow future patches to use them to expose performance
counters to KVM guests.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Cc: oprofile-list@lists.sf.net
---
 arch/mips/include/asm/mipsregs.h     | 33 +++++++++++++++++-
 arch/mips/kernel/perf_event_mipsxx.c | 55 ++++++++++++-----------------
 arch/mips/oprofile/op_model_mipsxx.c | 40 ++++++---------------
 3 files changed, 69 insertions(+), 59 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index df78b2ca70eb..f8d1d2f1d80d 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -685,6 +685,39 @@
 #define MIPS_WATCHHI_W		(_ULCAST_(1) << 0)
 #define MIPS_WATCHHI_IRW	(_ULCAST_(0x7) << 0)
 
+/* PerfCnt control register definitions */
+#define MIPS_PERFCTRL_EXL	(_ULCAST_(1) << 0)
+#define MIPS_PERFCTRL_K		(_ULCAST_(1) << 1)
+#define MIPS_PERFCTRL_S		(_ULCAST_(1) << 2)
+#define MIPS_PERFCTRL_U		(_ULCAST_(1) << 3)
+#define MIPS_PERFCTRL_IE	(_ULCAST_(1) << 4)
+#define MIPS_PERFCTRL_EVENT_S	5
+#define MIPS_PERFCTRL_EVENT	(_ULCAST_(0x3ff) << MIPS_PERFCTRL_EVENT_S)
+#define MIPS_PERFCTRL_PCTD	(_ULCAST_(1) << 15)
+#define MIPS_PERFCTRL_EC	(_ULCAST_(0x3) << 23)
+#define MIPS_PERFCTRL_EC_R	(_ULCAST_(0) << 23)
+#define MIPS_PERFCTRL_EC_RI	(_ULCAST_(1) << 23)
+#define MIPS_PERFCTRL_EC_G	(_ULCAST_(2) << 23)
+#define MIPS_PERFCTRL_EC_GRI	(_ULCAST_(3) << 23)
+#define MIPS_PERFCTRL_W		(_ULCAST_(1) << 30)
+#define MIPS_PERFCTRL_M		(_ULCAST_(1) << 31)
+
+/* PerfCnt control register MT extensions used by MIPS cores */
+#define MIPS_PERFCTRL_VPEID_S	16
+#define MIPS_PERFCTRL_VPEID	(_ULCAST_(0xf) << MIPS_PERFCTRL_VPEID_S)
+#define MIPS_PERFCTRL_TCID_S	22
+#define MIPS_PERFCTRL_TCID	(_ULCAST_(0xff) << MIPS_PERFCTRL_TCID_S)
+#define MIPS_PERFCTRL_MT_EN	(_ULCAST_(0x3) << 20)
+#define MIPS_PERFCTRL_MT_EN_ALL	(_ULCAST_(0) << 20)
+#define MIPS_PERFCTRL_MT_EN_VPE	(_ULCAST_(1) << 20)
+#define MIPS_PERFCTRL_MT_EN_TC	(_ULCAST_(2) << 20)
+
+/* PerfCnt control register MT extensions used by BMIPS5000 */
+#define BRCM_PERFCTRL_TC	(_ULCAST_(1) << 30)
+
+/* PerfCnt control register MT extensions used by Netlogic XLR */
+#define XLR_PERFCTRL_ALLTHREADS	(_ULCAST_(1) << 13)
+
 /* MAAR bit definitions */
 #define MIPS_MAAR_ADDR		((BIT_ULL(BITS_PER_LONG - 12) - 1) << 12)
 #define MIPS_MAAR_ADDR_SHIFT	12
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index d3ba9f4105b5..8c35b3152e1e 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -101,40 +101,31 @@ struct mips_pmu {
 
 static struct mips_pmu mipspmu;
 
-#define M_PERFCTL_EXL			(1	<<  0)
-#define M_PERFCTL_KERNEL		(1	<<  1)
-#define M_PERFCTL_SUPERVISOR		(1	<<  2)
-#define M_PERFCTL_USER			(1	<<  3)
-#define M_PERFCTL_INTERRUPT_ENABLE	(1	<<  4)
-#define M_PERFCTL_EVENT(event)		(((event) & 0x3ff)  << 5)
-#define M_PERFCTL_VPEID(vpe)		((vpe)	  << 16)
+#define M_PERFCTL_EVENT(event)		(((event) << MIPS_PERFCTRL_EVENT_S) & \
+					 MIPS_PERFCTRL_EVENT)
+#define M_PERFCTL_VPEID(vpe)		((vpe)	  << MIPS_PERFCTRL_VPEID_S)
 
 #ifdef CONFIG_CPU_BMIPS5000
 #define M_PERFCTL_MT_EN(filter)		0
 #else /* !CONFIG_CPU_BMIPS5000 */
-#define M_PERFCTL_MT_EN(filter)		((filter) << 20)
+#define M_PERFCTL_MT_EN(filter)		(filter)
 #endif /* CONFIG_CPU_BMIPS5000 */
 
-#define	   M_TC_EN_ALL			M_PERFCTL_MT_EN(0)
-#define	   M_TC_EN_VPE			M_PERFCTL_MT_EN(1)
-#define	   M_TC_EN_TC			M_PERFCTL_MT_EN(2)
-#define M_PERFCTL_TCID(tcid)		((tcid)	  << 22)
-#define M_PERFCTL_WIDE			(1	<< 30)
-#define M_PERFCTL_MORE			(1	<< 31)
-#define M_PERFCTL_TC			(1	<< 30)
+#define	   M_TC_EN_ALL			M_PERFCTL_MT_EN(MIPS_PERFCTRL_MT_EN_ALL)
+#define	   M_TC_EN_VPE			M_PERFCTL_MT_EN(MIPS_PERFCTRL_MT_EN_VPE)
+#define	   M_TC_EN_TC			M_PERFCTL_MT_EN(MIPS_PERFCTRL_MT_EN_TC)
 
-#define M_PERFCTL_COUNT_EVENT_WHENEVER	(M_PERFCTL_EXL |		\
-					M_PERFCTL_KERNEL |		\
-					M_PERFCTL_USER |		\
-					M_PERFCTL_SUPERVISOR |		\
-					M_PERFCTL_INTERRUPT_ENABLE)
+#define M_PERFCTL_COUNT_EVENT_WHENEVER	(MIPS_PERFCTRL_EXL |		\
+					 MIPS_PERFCTRL_K |		\
+					 MIPS_PERFCTRL_U |		\
+					 MIPS_PERFCTRL_S |		\
+					 MIPS_PERFCTRL_IE)
 
 #ifdef CONFIG_MIPS_MT_SMP
 #define M_PERFCTL_CONFIG_MASK		0x3fff801f
 #else
 #define M_PERFCTL_CONFIG_MASK		0x1f
 #endif
-#define M_PERFCTL_EVENT_MASK		0xfe0
 
 
 #ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
@@ -345,11 +336,11 @@ static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
 	cpuc->saved_ctrl[idx] = M_PERFCTL_EVENT(evt->event_base & 0xff) |
 		(evt->config_base & M_PERFCTL_CONFIG_MASK) |
 		/* Make sure interrupt enabled. */
-		M_PERFCTL_INTERRUPT_ENABLE;
+		MIPS_PERFCTRL_IE;
 	if (IS_ENABLED(CONFIG_CPU_BMIPS5000))
 		/* enable the counter for the calling thread */
 		cpuc->saved_ctrl[idx] |=
-			(1 << (12 + vpe_id())) | M_PERFCTL_TC;
+			(1 << (12 + vpe_id())) | BRCM_PERFCTRL_TC;
 
 	/*
 	 * We do not actually let the counter run. Leave it until start().
@@ -754,11 +745,11 @@ static int __n_counters(void)
 {
 	if (!cpu_has_perf)
 		return 0;
-	if (!(read_c0_perfctrl0() & M_PERFCTL_MORE))
+	if (!(read_c0_perfctrl0() & MIPS_PERFCTRL_M))
 		return 1;
-	if (!(read_c0_perfctrl1() & M_PERFCTL_MORE))
+	if (!(read_c0_perfctrl1() & MIPS_PERFCTRL_M))
 		return 2;
-	if (!(read_c0_perfctrl2() & M_PERFCTL_MORE))
+	if (!(read_c0_perfctrl2() & MIPS_PERFCTRL_M))
 		return 3;
 
 	return 4;
@@ -1339,7 +1330,7 @@ static int __hw_perf_event_init(struct perf_event *event)
 	 * We allow max flexibility on how each individual counter shared
 	 * by the single CPU operates (the mode exclusion and the range).
 	 */
-	hwc->config_base = M_PERFCTL_INTERRUPT_ENABLE;
+	hwc->config_base = MIPS_PERFCTRL_IE;
 
 	/* Calculate range bits and validate it. */
 	if (num_possible_cpus() > 1)
@@ -1350,14 +1341,14 @@ static int __hw_perf_event_init(struct perf_event *event)
 		mutex_unlock(&raw_event_mutex);
 
 	if (!attr->exclude_user)
-		hwc->config_base |= M_PERFCTL_USER;
+		hwc->config_base |= MIPS_PERFCTRL_U;
 	if (!attr->exclude_kernel) {
-		hwc->config_base |= M_PERFCTL_KERNEL;
+		hwc->config_base |= MIPS_PERFCTRL_K;
 		/* MIPS kernel mode: KSU == 00b || EXL == 1 || ERL == 1 */
-		hwc->config_base |= M_PERFCTL_EXL;
+		hwc->config_base |= MIPS_PERFCTRL_EXL;
 	}
 	if (!attr->exclude_hv)
-		hwc->config_base |= M_PERFCTL_SUPERVISOR;
+		hwc->config_base |= MIPS_PERFCTRL_S;
 
 	hwc->config_base &= M_PERFCTL_CONFIG_MASK;
 	/*
@@ -1830,7 +1821,7 @@ init_hw_perf_events(void)
 	mipspmu.num_counters = counters;
 	mipspmu.irq = irq;
 
-	if (read_c0_perfctrl0() & M_PERFCTL_WIDE) {
+	if (read_c0_perfctrl0() & MIPS_PERFCTRL_W) {
 		mipspmu.max_period = (1ULL << 63) - 1;
 		mipspmu.valid_count = (1ULL << 63) - 1;
 		mipspmu.overflow = 1ULL << 63;
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 45cb27469fba..c57da6f13929 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -15,26 +15,12 @@
 
 #include "op_impl.h"
 
-#define M_PERFCTL_EXL			(1UL	  <<  0)
-#define M_PERFCTL_KERNEL		(1UL	  <<  1)
-#define M_PERFCTL_SUPERVISOR		(1UL	  <<  2)
-#define M_PERFCTL_USER			(1UL	  <<  3)
-#define M_PERFCTL_INTERRUPT_ENABLE	(1UL	  <<  4)
-#define M_PERFCTL_EVENT(event)		(((event) & 0x3ff)  << 5)
-#define M_PERFCTL_VPEID(vpe)		((vpe)	  << 16)
-#define M_PERFCTL_MT_EN(filter)		((filter) << 20)
-#define	   M_TC_EN_ALL			M_PERFCTL_MT_EN(0)
-#define	   M_TC_EN_VPE			M_PERFCTL_MT_EN(1)
-#define	   M_TC_EN_TC			M_PERFCTL_MT_EN(2)
-#define M_PERFCTL_TCID(tcid)		((tcid)	  << 22)
-#define M_PERFCTL_WIDE			(1UL	  << 30)
-#define M_PERFCTL_MORE			(1UL	  << 31)
+#define M_PERFCTL_EVENT(event)		(((event) << MIPS_PERFCTRL_EVENT_S) & \
+					 MIPS_PERFCTRL_EVENT)
+#define M_PERFCTL_VPEID(vpe)		((vpe)	  << MIPS_PERFCTRL_VPEID_S)
 
 #define M_COUNTER_OVERFLOW		(1UL	  << 31)
 
-/* Netlogic XLR specific, count events in all threads in a core */
-#define M_PERFCTL_COUNT_ALL_THREADS	(1UL	  << 13)
-
 static int (*save_perf_irq)(void);
 static int perfcount_irq;
 
@@ -51,7 +37,7 @@ static int perfcount_irq;
 
 #ifdef CONFIG_MIPS_MT_SMP
 static int cpu_has_mipsmt_pertccounters;
-#define WHAT		(M_TC_EN_VPE | \
+#define WHAT		(MIPS_PERFCTRL_MT_EN_VPE | \
 			 M_PERFCTL_VPEID(cpu_data[smp_processor_id()].vpe_id))
 #define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
 			0 : cpu_data[smp_processor_id()].vpe_id)
@@ -161,15 +147,15 @@ static void mipsxx_reg_setup(struct op_counter_config *ctr)
 			continue;
 
 		reg.control[i] = M_PERFCTL_EVENT(ctr[i].event) |
-				 M_PERFCTL_INTERRUPT_ENABLE;
+				 MIPS_PERFCTRL_IE;
 		if (ctr[i].kernel)
-			reg.control[i] |= M_PERFCTL_KERNEL;
+			reg.control[i] |= MIPS_PERFCTRL_K;
 		if (ctr[i].user)
-			reg.control[i] |= M_PERFCTL_USER;
+			reg.control[i] |= MIPS_PERFCTRL_U;
 		if (ctr[i].exl)
-			reg.control[i] |= M_PERFCTL_EXL;
+			reg.control[i] |= MIPS_PERFCTRL_EXL;
 		if (boot_cpu_type() == CPU_XLR)
-			reg.control[i] |= M_PERFCTL_COUNT_ALL_THREADS;
+			reg.control[i] |= XLR_PERFCTRL_ALLTHREADS;
 		reg.counter[i] = 0x80000000 - ctr[i].count;
 	}
 }
@@ -254,7 +240,7 @@ static int mipsxx_perfcount_handler(void)
 	case n + 1:							\
 		control = r_c0_perfctrl ## n();				\
 		counter = r_c0_perfcntr ## n();				\
-		if ((control & M_PERFCTL_INTERRUPT_ENABLE) &&		\
+		if ((control & MIPS_PERFCTRL_IE) &&			\
 		    (counter & M_COUNTER_OVERFLOW)) {			\
 			oprofile_add_sample(get_irq_regs(), n);		\
 			w_c0_perfcntr ## n(reg.counter[n]);		\
@@ -273,11 +259,11 @@ static inline int __n_counters(void)
 {
 	if (!cpu_has_perf)
 		return 0;
-	if (!(read_c0_perfctrl0() & M_PERFCTL_MORE))
+	if (!(read_c0_perfctrl0() & MIPS_PERFCTRL_M))
 		return 1;
-	if (!(read_c0_perfctrl1() & M_PERFCTL_MORE))
+	if (!(read_c0_perfctrl1() & MIPS_PERFCTRL_M))
 		return 2;
-	if (!(read_c0_perfctrl2() & M_PERFCTL_MORE))
+	if (!(read_c0_perfctrl2() & MIPS_PERFCTRL_M))
 		return 3;
 
 	return 4;
-- 
git-series 0.8.10
