Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2011 13:34:33 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:41490 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493635Ab1HXLe0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Aug 2011 13:34:26 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>, Felix Fietkau <nbd@openwrt.org>,
        linux-mips@linux-mips.org
Subject: [PATCH 1/2] MIPS: make oprofile use cp0_perfcount_irq if it is set
Date:   Wed, 24 Aug 2011 13:36:08 +0200
Message-Id: <1314185769-16745-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 30977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17803

The patch makes the oprofile code use the performance counters irq.

This patch is written by Felix Fietkau.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
---
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
1.7.2.3
