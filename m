Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2012 17:47:06 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:56232 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903631Ab2APQoZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Jan 2012 17:44:25 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Felix Fietkau <nbd@openwrt.org>
Subject: [PATCH V2 16/17] MIPS: make oprofile use cp0_perfcount_irq if it is set
Date:   Mon, 16 Jan 2012 17:43:44 +0100
Message-Id: <1326732224-21336-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1326732224-21336-1-git-send-email-blogic@openwrt.org>
References: <1326732224-21336-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The patch makes the oprofile code use the performance counters irq.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
Based on a patch made by Felix

Changes in V2
* fixes code formatting
* 0 is not an IRQ use "> 0" and not ">= 0"

 arch/mips/kernel/cevt-r4k.c          |    2 +-
 arch/mips/oprofile/op_model_mipsxx.c |   12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 51095dd9..bc702c8 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -84,7 +84,7 @@ out:
 
 struct irqaction c0_compare_irqaction = {
 	.handler = c0_compare_interrupt,
-	.flags = IRQF_PERCPU | IRQF_TIMER,
+	.flags = IRQF_PERCPU | IRQF_TIMER | IRQF_SHARED,
 	.name = "timer",
 };
 
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 54759f1..ed35a16 100644
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
 
+	if (cp0_perfcount_irq > 0)
+		return request_irq(cp0_perfcount_irq, mipsxx_perfcount_int,
+			IRQF_SHARED, "Perfcounter", save_perf_irq);
+
 	return 0;
 }
 
@@ -381,6 +390,9 @@ static void mipsxx_exit(void)
 {
 	int counters = op_model_mipsxx_ops.num_counters;
 
+	if (cp0_perfcount_irq > 0)
+		free_irq(cp0_perfcount_irq, save_perf_irq);
+
 	counters = counters_per_cpu_to_total(counters);
 	on_each_cpu(reset_counters, (void *)(long)counters, 1);
 
-- 
1.7.7.1
