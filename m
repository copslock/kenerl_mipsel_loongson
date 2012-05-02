Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 May 2012 19:34:37 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:43232 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903759Ab2EBRec (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 May 2012 19:34:32 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Felix Fietkau <nbd@openwrt.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH V3 01/14] MIPS: make oprofile use cp0_perfcount_irq if it is set
Date:   Wed,  2 May 2012 19:33:04 +0200
Message-Id: <1335979984-3973-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 33124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Felix Fietkau <nbd@openwrt.org>

Make the oprofile code use the performance counters irq.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: John Crispin <blogic@openwrt.org>

---
Changes in V2
* set Author to Felix

Changes in V3
* remove IRQF_SHARED
* make sure cp0_compare_irq != cp0_perfcount_irq

 arch/mips/kernel/perf_event_mipsxx.c |    3 ++-
 arch/mips/oprofile/op_model_mipsxx.c |   12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 811084f..574b4e9 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1532,7 +1532,8 @@ init_hw_perf_events(void)
 		irq = MSC01E_INT_BASE + MSC01E_INT_PERFCTR;
 	} else {
 #endif
-		if (cp0_perfcount_irq >= 0)
+		if ((cp0_perfcount_irq >= 0) &&
+				(cp0_compare_irq != cp0_perfcount_irq))
 			irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
 		else
 			irq = -1;
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 54759f1..baba3bc 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -298,6 +298,11 @@ static void reset_counters(void *arg)
 	}
 }
 
+static irqreturn_t mipsxx_perfcount_int(int irq, void *dev_id)
+{
+	return mipsxx_perfcount_handler();
+}
+
 static int __init mipsxx_init(void)
 {
 	int counters;
@@ -374,6 +379,10 @@ static int __init mipsxx_init(void)
 	save_perf_irq = perf_irq;
 	perf_irq = mipsxx_perfcount_handler;
 
+	if ((cp0_perfcount_irq >= 0) && (cp0_compare_irq != cp0_perfcount_irq))
+		return request_irq(cp0_perfcount_irq, mipsxx_perfcount_int,
+			0, "Perfcounter", save_perf_irq);
+
 	return 0;
 }
 
@@ -381,6 +390,9 @@ static void mipsxx_exit(void)
 {
 	int counters = op_model_mipsxx_ops.num_counters;
 
+	if ((cp0_perfcount_irq >= 0) && (cp0_compare_irq != cp0_perfcount_irq))
+		free_irq(cp0_perfcount_irq, save_perf_irq);
+
 	counters = counters_per_cpu_to_total(counters);
 	on_each_cpu(reset_counters, (void *)(long)counters, 1);
 
-- 
1.7.9.1
