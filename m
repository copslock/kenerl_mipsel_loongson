Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 22:47:09 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1339 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903719Ab2GMUqS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2012 22:46:18 +0200
Received: from [10.9.200.131] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 13 Jul 2012 13:44:59 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 13 Jul 2012 13:45:56 -0700
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 732999F9F6; Fri, 13
 Jul 2012 13:45:56 -0700 (PDT)
From:   "Al Cooper" <alcooperx@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
cc:     "Al Cooper" <alcooperx@gmail.com>
Subject: [PATCH 4/5] MIPS: perf: Split the Kconfig option
 CONFIG_MIPS_MT_SMP
Date:   Fri, 13 Jul 2012 16:44:53 -0400
Message-ID: <1342212294-23014-4-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1342212294-23014-1-git-send-email-alcooperx@gmail.com>
References: <y> <1342212294-23014-1-git-send-email-alcooperx@gmail.com>
MIME-Version: 1.0
X-WSS-ID: 7C1E57413NK5453383-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alcooperx@gmail.com
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

Split the Kconfig option CONFIG_MIPS_MT_SMP into CONFIG_MIPS_MT_SMP
and CONFIG_MIPS_PERF_SHARED_TC_COUNTERS so some of the code used
for performance counters that are shared between threads can be used
for MIPS cores that are not MT_SMP.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 arch/mips/Kconfig                    |    4 ++++
 arch/mips/kernel/perf_event_mipsxx.c |   16 ++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 61e1459..bced05c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1898,6 +1898,7 @@ config MIPS_MT_SMP
 	select SYS_SUPPORTS_SCHED_SMT if SMP
 	select SYS_SUPPORTS_SMP
 	select SMP_UP
+	select MIPS_PERF_SHARED_TC_COUNTERS
 	help
 	  This is a kernel model which is known a VSMP but lately has been
 	  marketesed into SMVP.
@@ -2248,6 +2249,9 @@ config NR_CPUS
 	  performance should round up your number of processors to the next
 	  power of two.
 
+config MIPS_PERF_SHARED_TC_COUNTERS
+	bool
+
 #
 # Timer Interrupt Frequency Configuration
 #
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 19253d7..cb21308 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -130,7 +130,7 @@ static struct mips_pmu mipspmu;
 #define M_PERFCTL_EVENT_MASK		0xfe0
 
 
-#ifdef CONFIG_MIPS_MT_SMP
+#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
 static int cpu_has_mipsmt_pertccounters;
 
 static DEFINE_RWLOCK(pmuint_rwlock);
@@ -156,10 +156,10 @@ static unsigned int counters_total_to_per_cpu(unsigned int counters)
 	return counters >> vpe_shift();
 }
 
-#else /* !CONFIG_MIPS_MT_SMP */
+#else /* !CONFIG_MIPS_PERF_SHARED_TC_COUNTERS */
 #define vpe_id()	0
 
-#endif /* CONFIG_MIPS_MT_SMP */
+#endif /* CONFIG_MIPS_PERF_SHARED_TC_COUNTERS */
 
 static void resume_local_counters(void);
 static void pause_local_counters(void);
@@ -503,7 +503,7 @@ static void mipspmu_read(struct perf_event *event)
 
 static void mipspmu_enable(struct pmu *pmu)
 {
-#ifdef CONFIG_MIPS_MT_SMP
+#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
 	write_unlock(&pmuint_rwlock);
 #endif
 	resume_local_counters();
@@ -523,7 +523,7 @@ static void mipspmu_enable(struct pmu *pmu)
 static void mipspmu_disable(struct pmu *pmu)
 {
 	pause_local_counters();
-#ifdef CONFIG_MIPS_MT_SMP
+#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
 	write_lock(&pmuint_rwlock);
 #endif
 }
@@ -1163,7 +1163,7 @@ static int mipsxx_pmu_handle_shared_irq(void)
 	 * See also mipsxx_pmu_start().
 	 */
 	pause_local_counters();
-#ifdef CONFIG_MIPS_MT_SMP
+#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
 	read_lock(&pmuint_rwlock);
 #endif
 
@@ -1195,7 +1195,7 @@ static int mipsxx_pmu_handle_shared_irq(void)
 	if (handled == IRQ_HANDLED)
 		irq_work_run();
 
-#ifdef CONFIG_MIPS_MT_SMP
+#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
 	read_unlock(&pmuint_rwlock);
 #endif
 	resume_local_counters();
@@ -1362,7 +1362,7 @@ init_hw_perf_events(void)
 		return -ENODEV;
 	}
 
-#ifdef CONFIG_MIPS_MT_SMP
+#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
 	cpu_has_mipsmt_pertccounters = read_c0_config7() & (1<<19);
 	if (!cpu_has_mipsmt_pertccounters)
 		counters = counters_total_to_per_cpu(counters);
-- 
1.7.6
