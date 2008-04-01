Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 02:04:08 +0200 (CEST)
Received: from smtp03.mtu.ru ([62.5.255.50]:25083 "EHLO smtp03.mtu.ru")
	by lappi.linux-mips.net with ESMTP id S1103057AbYDAX7t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Apr 2008 01:59:49 +0200
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 9688218708B3;
	Wed,  2 Apr 2008 03:58:47 +0400 (MSD)
Received: from localhost.localdomain (ppp91-76-28-42.pppoe.mtu-net.ru [91.76.28.42])
	by smtp03.mtu.ru (Postfix) with ESMTP id 72F0718708AC;
	Wed,  2 Apr 2008 03:58:47 +0400 (MSD)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] [MIPS] unexport null_perf_irq() and make it static
Date:	Wed,  2 Apr 2008 03:58:38 +0400
Message-Id: <1207094318-21748-6-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

This patch unexports the null_perf_irq() symbol, and simultaneously
makes this function static.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/kernel/time.c              |    4 +---
 arch/mips/oprofile/op_impl.h         |    1 -
 arch/mips/oprofile/op_model_mipsxx.c |    5 ++++-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index d70ce5c..1f467d5 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -49,13 +49,11 @@ int update_persistent_clock(struct timespec now)
 	return rtc_mips_set_mmss(now.tv_sec);
 }
 
-int null_perf_irq(void)
+static int null_perf_irq(void)
 {
 	return 0;
 }
 
-EXPORT_SYMBOL(null_perf_irq);
-
 int (*perf_irq)(void) = null_perf_irq;
 
 EXPORT_SYMBOL(perf_irq);
diff --git a/arch/mips/oprofile/op_impl.h b/arch/mips/oprofile/op_impl.h
index fa6b4aa..2bfc17c 100644
--- a/arch/mips/oprofile/op_impl.h
+++ b/arch/mips/oprofile/op_impl.h
@@ -10,7 +10,6 @@
 #ifndef OP_IMPL_H
 #define OP_IMPL_H 1
 
-extern int null_perf_irq(void);
 extern int (*perf_irq)(void);
 
 /* Per-counter configuration as set via oprofilefs.  */
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index ccbea22..12e840f 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -31,6 +31,8 @@
 
 #define M_COUNTER_OVERFLOW		(1UL      << 31)
 
+int (*save_perf_irq)(void);
+
 #ifdef CONFIG_MIPS_MT_SMP
 #define WHAT		(M_TC_EN_VPE | M_PERFCTL_VPEID(smp_processor_id()))
 #define vpe_id()	smp_processor_id()
@@ -355,6 +357,7 @@ static int __init mipsxx_init(void)
 		return -ENODEV;
 	}
 
+	save_perf_irq = perf_irq;
 	perf_irq = mipsxx_perfcount_handler;
 
 	return 0;
@@ -367,7 +370,7 @@ static void mipsxx_exit(void)
 	counters = counters_per_cpu_to_total(counters);
 	reset_counters(counters);
 
-	perf_irq = null_perf_irq;
+	perf_irq = save_perf_irq;
 }
 
 struct op_mips_model op_model_mipsxx_ops = {
-- 
1.5.3
