Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 May 2012 14:29:59 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:48060 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903746Ab2EBM3Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 May 2012 14:29:24 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Felix Fietkau <nbd@openwrt.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 01/14] MIPS: make oprofile use cp0_perfcount_irq if it is set
Date:   Wed,  2 May 2012 14:27:32 +0200
Message-Id: <1335961659-21358-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 33116
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

 arch/mips/oprofile/op_model_mipsxx.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 54759f1..86cf234 100644
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
 
+	if (cp0_perfcount_irq >= 0)
+		return request_irq(cp0_perfcount_irq, mipsxx_perfcount_int,
+			IRQF_SHARED, "Perfcounter", save_perf_irq);
+
 	return 0;
 }
 
@@ -381,6 +390,9 @@ static void mipsxx_exit(void)
 {
 	int counters = op_model_mipsxx_ops.num_counters;
 
+	if (cp0_perfcount_irq >= 0)
+		free_irq(cp0_perfcount_irq, save_perf_irq);
+
 	counters = counters_per_cpu_to_total(counters);
 	on_each_cpu(reset_counters, (void *)(long)counters, 1);
 
-- 
1.7.9.1
