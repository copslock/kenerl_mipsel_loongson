Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 10:48:59 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:48175 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491861Ab0FBIsw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 10:48:52 +0200
Received: by vws7 with SMTP id 7so7507384vws.36
        for <multiple recipients>; Wed, 02 Jun 2010 01:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=gjMM8VtptnTKe6tS+gMPmay9MLbKCYnCnu/DT+1QA/o=;
        b=FHla/9pv3wGJUEexBQhfHTWXeaF6Ckb1agswFv6fM/8Ph+M1N2fe2XYEI7xi48xKr2
         xj6FPckx1Nw3/5NMVfHgDH1eUvB5lo+ipVhmkPaa0Re+zVB22ioJBoJfTMkF6eCRPsgd
         rUdJ1OV77l1b8qtg/yroVa9RjJGI1JCegObsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=RwpZeVrSoBHcDM+1NQOs2xq/Hu7gNisAVu4ix7fXp1RXqtXOaPmRPlmhqL2ovuanaH
         2FqG+QgR/k1xNWw7UtSgkimzZh0o8p8WqtA08RdxNbdbWuHJalip4bUHNtUzCS+bDfY1
         bLp5eKAWGuJF9e39pLNrE6qizo2Ak2z3id0Tc=
MIME-Version: 1.0
Received: by 10.224.41.14 with SMTP id m14mr3021810qae.336.1275468523884; Wed, 
        02 Jun 2010 01:48:43 -0700 (PDT)
Received: by 10.229.232.141 with HTTP; Wed, 2 Jun 2010 01:48:43 -0700 (PDT)
Date:   Wed, 2 Jun 2010 01:48:43 -0700
Message-ID: <AANLkTilcSFUBHXHHttcXFVToL8waTmlxmts-elClSJar@mail.gmail.com>
Subject: [loongson2-PATCH] modification of the cpufreq module
From:   Gang Liang <randomizedthinking@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 26994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randomizedthinking@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1117

This patch updates some aspects of the current implementation of
cpufreq driver for Loongson2.

1) A default cpu_wait handler is installed such that the cpu will be
alive at the lowest possible power level when a cpu_wait call is made;

2) The number of frequency levels is reduced to 3, and the lowest
frequency is capped as a half of the full cpu speed. The "nowait" option
is removed.

Thanks!

---
 arch/mips/include/asm/mach-loongson/loongson.h |    4 +-
 arch/mips/kernel/cpu-probe.c                   |   21 +++++++++
 arch/mips/kernel/cpufreq/loongson2_clock.c     |   52 +++--------------------
 arch/mips/kernel/cpufreq/loongson2_cpufreq.c   |   54 +++++++++---------------
 4 files changed, 50 insertions(+), 81 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h
b/arch/mips/include/asm/mach-loongson/loongson.h
index 53d0bef..33164b9 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -242,8 +242,8 @@ extern int mach_i8259_irq(void);

 #ifdef CONFIG_CPU_SUPPORTS_CPUFREQ
 #include <linux/cpufreq.h>
-extern void loongson2_cpu_wait(void);
-extern struct cpufreq_frequency_table loongson2_clockmod_table[];
+/* extern void loongson2_cpu_wait(void); */
+/* extern struct cpufreq_frequency_table loongson2_clockmod_table[]; */

 /* Chip Config */
 #define LOONGSON_CHIPCFG0		LOONGSON_REG(LOONGSON_REGBASE + 0x80)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index be5bb16..5b3072c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -25,6 +25,9 @@
 #include <asm/system.h>
 #include <asm/watch.h>
 #include <asm/spram.h>
+
+#include <loongson.h>
+
 /*
  * Not all of the MIPS CPUs have the "wait" instruction available. Moreover,
  * the implementation of the "wait" feature differs between CPU families. This
@@ -51,6 +54,21 @@ static void r39xx_wait(void)

 extern void r4k_wait(void);

+DEFINE_SPINLOCK(loongson2_wait_lock);
+static void loongson2_cpu_wait(void)
+{
+    u32 cpu_freq;
+    unsigned long flags;
+
+    /* enter the lowest power mode available while still alive */
+    /* future work: check cpu freq -- do nothing if no change */
+    /* otherwise, change the frequency and propagate the clock rate */
+    spin_lock_irqsave(&loongson2_wait_lock, flags);
+    cpu_freq = LOONGSON_CHIPCFG0;
+	LOONGSON_CHIPCFG0 = (cpu_freq & ~0x7) | 1;
+    spin_unlock_irqrestore(&loongson2_wait_lock, flags);
+}
+
 /*
  * This variant is preferable as it allows testing need_resched and going to
  * sleep depending on the outcome atomically.  Unfortunately the "It is
@@ -212,6 +230,9 @@ void __init check_wait(void)
 		if ((c->processor_id & 0x00ff) >= 0x40)
 			cpu_wait = r4k_wait;
 		break;
+    case CPU_LOONGSON2:
+        cpu_wait = loongson2_cpu_wait;
+        break;
 	default:
 		break;
 	}
diff --git a/arch/mips/kernel/cpufreq/loongson2_clock.c
b/arch/mips/kernel/cpufreq/loongson2_clock.c
index cefc6e2..0b30fe9 100644
--- a/arch/mips/kernel/cpufreq/loongson2_clock.c
+++ b/arch/mips/kernel/cpufreq/loongson2_clock.c
@@ -18,25 +18,7 @@ static LIST_HEAD(clock_list);
 static DEFINE_SPINLOCK(clock_lock);
 static DEFINE_MUTEX(clock_list_sem);

-/* Minimum CLK support */
-enum {
-	DC_ZERO, DC_25PT = 2, DC_37PT, DC_50PT, DC_62PT, DC_75PT,
-	DC_87PT, DC_DISABLE, DC_RESV
-};
-
-struct cpufreq_frequency_table loongson2_clockmod_table[] = {
-	{DC_RESV, CPUFREQ_ENTRY_INVALID},
-	{DC_ZERO, CPUFREQ_ENTRY_INVALID},
-	{DC_25PT, 0},
-	{DC_37PT, 0},
-	{DC_50PT, 0},
-	{DC_62PT, 0},
-	{DC_75PT, 0},
-	{DC_87PT, 0},
-	{DC_DISABLE, 0},
-	{DC_RESV, CPUFREQ_TABLE_END},
-};
-EXPORT_SYMBOL_GPL(loongson2_clockmod_table);
+#define LS2_MAX_CPUFREQ_LEVEL 8

 static struct clk cpu_clk = {
 	.name = "cpu_clk",
@@ -109,21 +91,15 @@ int clk_set_rate_ex(struct clk *clk, unsigned
long rate, int algo_id)
 	if (unlikely(clk->flags & CLK_RATE_PROPAGATES))
 		propagate_rate(clk);

-	for (i = 0; loongson2_clockmod_table[i].frequency != CPUFREQ_TABLE_END;
-	     i++) {
-		if (loongson2_clockmod_table[i].frequency ==
-		    CPUFREQ_ENTRY_INVALID)
-			continue;
-		if (rate == loongson2_clockmod_table[i].frequency)
-			break;
-	}
-	if (rate != loongson2_clockmod_table[i].frequency)
-		return -ENOTSUPP;
+    i = rate * LS2_MAX_CPUFREQ_LEVEL / cpu_clock_freq;
+    if ( i < 1 || i > LS2_MAX_CPUFREQ_LEVEL )
+        return -ENOTSUPP;

-	clk->rate = rate;
+    /* indeed, a rounded rate is assigned */
+	clk->rate = i * (cpu_clock_freq / LS2_MAX_CPUFREQ_LEVEL);

 	regval = LOONGSON_CHIPCFG0;
-	regval = (regval & ~0x7) | (loongson2_clockmod_table[i].index - 1);
+	regval = (regval & ~0x7) | i;
 	LOONGSON_CHIPCFG0 = regval;

 	return ret;
@@ -151,20 +127,6 @@ EXPORT_SYMBOL_GPL(clk_round_rate);
  * interrupt disabled content
  */

-DEFINE_SPINLOCK(loongson2_wait_lock);
-void loongson2_cpu_wait(void)
-{
-	u32 cpu_freq;
-	unsigned long flags;
-
-	spin_lock_irqsave(&loongson2_wait_lock, flags);
-	cpu_freq = LOONGSON_CHIPCFG0;
-	LOONGSON_CHIPCFG0 &= ~0x7;	/* Put CPU into wait mode */
-	LOONGSON_CHIPCFG0 = cpu_freq;	/* Restore CPU state */
-	spin_unlock_irqrestore(&loongson2_wait_lock, flags);
-}
-EXPORT_SYMBOL_GPL(loongson2_cpu_wait);
-
 MODULE_AUTHOR("Yanhua <yanh@lemote.com>");
 MODULE_DESCRIPTION("cpufreq driver for Loongson 2F");
 MODULE_LICENSE("GPL");
diff --git a/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
b/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
index 2f6a0b1..0488945 100644
--- a/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
+++ b/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
@@ -21,11 +21,16 @@

 #include <loongson.h>

-static uint nowait;
+#define LS2_CPUFREQ_LEVEL 3

 static struct clk *cpuclk;

-static void (*saved_cpu_wait) (void);
+struct cpufreq_frequency_table loongson2_clockmod_table[] = {
+	{0, 0},
+	{1, 0},
+	{2, 0},
+	{ .frequency = CPUFREQ_TABLE_END },
+};

 static int loongson2_cpu_freq_notifier(struct notifier_block *nb,
 					unsigned long val, void *data);
@@ -67,14 +72,11 @@ static int loongson2_cpufreq_target(struct
cpufreq_policy *policy,
 	cpus_allowed = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(cpu));

-	if (cpufreq_frequency_table_target
-	    (policy, &loongson2_clockmod_table[0], target_freq, relation,
-	     &newstate))
+	if (cpufreq_frequency_table_target (policy,
+			&loongson2_clockmod_table[0], target_freq, relation, &newstate))
 		return -EINVAL;

-	freq =
-	    ((cpu_clock_freq / 1000) *
-	     loongson2_clockmod_table[newstate].index) / 8;
+	freq = loongson2_clockmod_table[newstate].frequency;
 	if (freq < policy->min || freq > policy->max)
 		return -EINVAL;

@@ -88,15 +90,10 @@ static int loongson2_cpufreq_target(struct
cpufreq_policy *policy,
 	if (freqs.new == freqs.old)
 		return 0;

-	/* notifiers */
+	/* change cpu clock between notifier pairs */
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-
 	set_cpus_allowed(current, cpus_allowed);
-
-	/* setting the cpu frequency */
 	clk_set_rate(cpuclk, freq);
-
-	/* notifiers */
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);

 	pr_debug("cpufreq: set frequency %u kHz\n", freq);
@@ -121,11 +118,12 @@ static int loongson2_cpufreq_cpu_init(struct
cpufreq_policy *policy)
 	if (!cpuclk->rate)
 		return -EINVAL;

-	/* clock table init */
-	for (i = 2;
-	     (loongson2_clockmod_table[i].frequency != CPUFREQ_TABLE_END);
-	     i++)
-		loongson2_clockmod_table[i].frequency = (cpuclk->rate * i) / 8;
+	/* initialize the clock table such that all frequencies */
+	/* evenly span within [cpu_clock_freq/2, cpu_clock_freq] */
+	for (i = 0; i < LS2_CPUFREQ_LEVEL; i++) {
+		loongson2_clockmod_table[i].frequency = cpuclk->rate *
+			(i+LS2_CPUFREQ_LEVEL-1) / (2*LS2_CPUFREQ_LEVEL-2);
+    }

 	policy->cur = loongson2_cpufreq_get(policy->cpu);

@@ -139,7 +137,7 @@ static int loongson2_cpufreq_cpu_init(struct
cpufreq_policy *policy)
 static int loongson2_cpufreq_verify(struct cpufreq_policy *policy)
 {
 	return cpufreq_frequency_table_verify(policy,
-					      &loongson2_clockmod_table[0]);
+					&loongson2_clockmod_table[0]);
 }

 static int loongson2_cpufreq_exit(struct cpufreq_policy *policy)
@@ -185,7 +183,7 @@ static int __init cpufreq_init(void)
 {
 	int ret;

-	/* Register platform stuff */
+	/* Register platform driver */
 	ret = platform_driver_register(&platform_driver);
 	if (ret)
 		return ret;
@@ -195,20 +193,11 @@ static int __init cpufreq_init(void)
 	cpufreq_register_notifier(&loongson2_cpufreq_notifier_block,
 				  CPUFREQ_TRANSITION_NOTIFIER);

-	ret = cpufreq_register_driver(&loongson2_cpufreq_driver);
-
-	if (!ret && !nowait) {
-		saved_cpu_wait = cpu_wait;
-		cpu_wait = loongson2_cpu_wait;
-	}
-
-	return ret;
+	return cpufreq_register_driver(&loongson2_cpufreq_driver);
 }

 static void __exit cpufreq_exit(void)
 {
-	if (!nowait && saved_cpu_wait)
-		cpu_wait = saved_cpu_wait;
 	cpufreq_unregister_driver(&loongson2_cpufreq_driver);
 	cpufreq_unregister_notifier(&loongson2_cpufreq_notifier_block,
 				    CPUFREQ_TRANSITION_NOTIFIER);
@@ -219,9 +208,6 @@ static void __exit cpufreq_exit(void)
 module_init(cpufreq_init);
 module_exit(cpufreq_exit);

-module_param(nowait, uint, 0644);
-MODULE_PARM_DESC(nowait, "Disable Loongson-2F specific wait");
-
 MODULE_AUTHOR("Yanhua <yanh@lemote.com>");
 MODULE_DESCRIPTION("cpufreq driver for Loongson2F");
 MODULE_LICENSE("GPL");



--
Gang Liang
Life is beautiful!
