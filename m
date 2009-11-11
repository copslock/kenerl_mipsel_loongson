Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 08:11:42 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:58653 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492474AbZKKHKb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 08:10:31 +0100
Received: by mail-pz0-f194.google.com with SMTP id 32so599025pzk.21
        for <multiple recipients>; Tue, 10 Nov 2009 23:10:30 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=v6yFVe0vA8lIJG3bykjoF+oPBA4osE6rYBGMEZOav70=;
        b=T7IbjUd/rPu0M+rykXpGhMys4WR7yP3KHtIzHDn3cTrI0aeS2P1YELLDvMXO1uzP5G
         yAfaU/frt2BFVtx8lFKtyCSUF6wVNKAkjbAoq6Eta2naep4ZKGJiWf7LSwDioL5H5q+V
         LFASumLK3c2ZZ/X8IMR58HWPMA4yC6fksfkeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oTGWD7z6fEZYjaUl8r3a1r6uV3ghLGDhazXsbnZ/CgzGB17dSVMwY3yu/M6Ng7a1RI
         rZxl/LcukUHC5+o3m459pU5SlXC2KKXpTiGIPEcoNroAD4kf52kF9WJo+aLuoV20QY5+
         WOk+jxLlF0NqX6QgaHBruM8wLyw79qvap6/qU=
Received: by 10.115.24.12 with SMTP id b12mr2442990waj.86.1257923430448;
        Tue, 10 Nov 2009 23:10:30 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm830254pzk.7.2009.11.10.23.10.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 23:10:29 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, cpufreq@vger.kernel.org,
	Dave Jones <davej@redhat.com>, yanh@lemote.com,
	huhb@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 3/3] [loongson] 2f: add Cpufreq support
Date:	Wed, 11 Nov 2009 15:09:59 +0800
Message-Id: <acbb780de66413230fb14272e6ce3bf12f9c24d3.1257923011.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <f5f863b7d2bf8f739db134afa12c7b6c2bf7d256.1257923011.git.wuzhangjin@gmail.com>
References: <cover.1257923011.git.wuzhangjin@gmail.com>
 <de82733902e9549883b840f082a67b9edaa32c45.1257923011.git.wuzhangjin@gmail.com>
 <f5f863b7d2bf8f739db134afa12c7b6c2bf7d256.1257923011.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257923011.git.wuzhangjin@gmail.com>
References: <cover.1257923011.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Loongson2f add a new capability to dynamicly scale cpu frequency. And
when we put it into wait mode via setting the frequency as ZERO, it will
wait there until an external interrupt take place, which will help
saving power for us.

And as the last patch described, to enable this support, an external
timer is needed to avoid getting wrong system time when using the MIPS
Timer, 'Cause the MIPS Timer's frequency is half of the cpu frequency,
when the cpu frequency is changed, the MIPS Timer will be not accuracy.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/clock.h                  |   64 ++++++++
 arch/mips/include/asm/mach-loongson/loongson.h |    6 +-
 arch/mips/kernel/Makefile                      |    2 +
 arch/mips/kernel/cpu-probe.c                   |    2 +
 arch/mips/kernel/cpufreq/Kconfig               |   14 ++
 arch/mips/kernel/cpufreq/Makefile              |    5 +
 arch/mips/kernel/cpufreq/loongson2_clock.c     |  166 ++++++++++++++++++++
 arch/mips/kernel/cpufreq/loongson2_cpufreq.c   |  200 ++++++++++++++++++++++++
 arch/mips/loongson/Kconfig                     |    1 +
 arch/mips/loongson/common/env.c                |    3 +
 10 files changed, 462 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/include/asm/clock.h
 create mode 100644 arch/mips/kernel/cpufreq/Makefile
 create mode 100644 arch/mips/kernel/cpufreq/loongson2_clock.c
 create mode 100644 arch/mips/kernel/cpufreq/loongson2_cpufreq.c

diff --git a/arch/mips/include/asm/clock.h b/arch/mips/include/asm/clock.h
new file mode 100644
index 0000000..83894aa
--- /dev/null
+++ b/arch/mips/include/asm/clock.h
@@ -0,0 +1,64 @@
+#ifndef __ASM_MIPS_CLOCK_H
+#define __ASM_MIPS_CLOCK_H
+
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/seq_file.h>
+#include <linux/clk.h>
+
+extern void (*cpu_wait) (void);
+
+struct clk;
+
+struct clk_ops {
+	void (*init) (struct clk *clk);
+	void (*enable) (struct clk *clk);
+	void (*disable) (struct clk *clk);
+	void (*recalc) (struct clk *clk);
+	int (*set_rate) (struct clk *clk, unsigned long rate, int algo_id);
+	long (*round_rate) (struct clk *clk, unsigned long rate);
+};
+
+struct clk {
+	struct list_head node;
+	const char *name;
+	int id;
+	struct module *owner;
+
+	struct clk *parent;
+	struct clk_ops *ops;
+
+	struct kref kref;
+
+	unsigned long rate;
+	unsigned long flags;
+};
+
+#define CLK_ALWAYS_ENABLED	(1 << 0)
+#define CLK_RATE_PROPAGATES	(1 << 1)
+
+/* Should be defined by processor-specific code */
+void arch_init_clk_ops(struct clk_ops **, int type);
+
+int clk_init(void);
+
+int __clk_enable(struct clk *);
+void __clk_disable(struct clk *);
+
+void clk_recalc_rate(struct clk *);
+
+int clk_register(struct clk *);
+void clk_unregister(struct clk *);
+
+/* the exported API, in addition to clk_set_rate */
+/**
+ * clk_set_rate_ex - set the clock rate for a clock source, with additional parameter
+ * @clk: clock source
+ * @rate: desired clock rate in Hz
+ * @algo_id: algorithm id to be passed down to ops->set_rate
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_set_rate_ex(struct clk *clk, unsigned long rate, int algo_id);
+
+#endif				/* __ASM_MIPS_CLOCK_H */
diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 008c768..926f77c 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -226,8 +226,12 @@ extern void mach_irq_dispatch(unsigned int pending);
 #define LOONGSON_PCIMAP_WIN(WIN, ADDR)	\
 	((((ADDR)>>26) & LOONGSON_PCIMAP_PCIMAP_LO0) << ((WIN)*6))
 
-/* Chip Config */
 #ifdef CONFIG_CPU_SUPPORT_CPUFREQ
+#include <linux/cpufreq.h>
+extern void loongson2_cpu_wait(void);
+extern struct cpufreq_frequency_table loongson2_clockmod_table[];
+
+/* Chip Config */
 #define LOONGSON_CHIPCFG0		LOONGSON_REG(LOONGSON_REGBASE + 0x80)
 #endif
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 8e26e9c..1d2ffc3 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -90,6 +90,8 @@ CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(KBUILD_CFLAGS) -Wa,-mdaddi -c -o /dev/n
 
 obj-$(CONFIG_HAVE_STD_PC_SERIAL_PORT)	+= 8250-platform.o
 
+obj-$(CONFIG_MIPS_CPUFREQ)	+= cpufreq/
+
 EXTRA_CFLAGS += -Werror
 
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 7a51866..80e202e 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -16,6 +16,7 @@
 #include <linux/ptrace.h>
 #include <linux/smp.h>
 #include <linux/stddef.h>
+#include <linux/module.h>
 
 #include <asm/bugs.h>
 #include <asm/cpu.h>
@@ -32,6 +33,7 @@
  * the CPU very much.
  */
 void (*cpu_wait)(void);
+EXPORT_SYMBOL(cpu_wait);
 
 static void r3081_wait(void)
 {
diff --git a/arch/mips/kernel/cpufreq/Kconfig b/arch/mips/kernel/cpufreq/Kconfig
index 3969661..d3a7e93 100644
--- a/arch/mips/kernel/cpufreq/Kconfig
+++ b/arch/mips/kernel/cpufreq/Kconfig
@@ -20,6 +20,20 @@ if CPU_FREQ
 
 comment "CPUFreq processor drivers"
 
+config LOONGSON2_CPUFREQ
+	tristate "Loongson2 CPUFreq Driver"
+	select CPU_FREQ_TABLE
+	depends on MIPS_CPUFREQ
+	help
+	  This option adds a CPUFreq driver for loongson processors which
+	  support software configurable cpu frequency.
+
+	  Loongson2F and it's successors support this feature.
+
+	  For details, take a look at <file:Documentation/cpu-freq/>.
+
+	  If in doubt, say N.
+
 endif	# CPU_FREQ
 
 endmenu
diff --git a/arch/mips/kernel/cpufreq/Makefile b/arch/mips/kernel/cpufreq/Makefile
new file mode 100644
index 0000000..c3479a4
--- /dev/null
+++ b/arch/mips/kernel/cpufreq/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the Linux/MIPS cpufreq.
+#
+
+obj-$(CONFIG_LOONGSON2_CPUFREQ) += loongson2_cpufreq.o loongson2_clock.o
diff --git a/arch/mips/kernel/cpufreq/loongson2_clock.c b/arch/mips/kernel/cpufreq/loongson2_clock.c
new file mode 100644
index 0000000..d7ca256
--- /dev/null
+++ b/arch/mips/kernel/cpufreq/loongson2_clock.c
@@ -0,0 +1,166 @@
+/*
+ * Copyright (C) 2006 - 2008 Lemote Inc. & Insititute of Computing Technology
+ * Author: Yanhua, yanh@lemote.com
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/platform_device.h>
+
+#include <asm/clock.h>
+
+#include <loongson.h>
+
+static LIST_HEAD(clock_list);
+static DEFINE_SPINLOCK(clock_lock);
+static DEFINE_MUTEX(clock_list_sem);
+
+/* Minimum CLK support */
+enum {
+	DC_ZERO, DC_25PT = 2, DC_37PT, DC_50PT, DC_62PT, DC_75PT,
+	DC_87PT, DC_DISABLE, DC_RESV
+};
+
+struct cpufreq_frequency_table loongson2_clockmod_table[] = {
+	{DC_RESV, CPUFREQ_ENTRY_INVALID},
+	{DC_ZERO, CPUFREQ_ENTRY_INVALID},
+	{DC_25PT, 0},
+	{DC_37PT, 0},
+	{DC_50PT, 0},
+	{DC_62PT, 0},
+	{DC_75PT, 0},
+	{DC_87PT, 0},
+	{DC_DISABLE, 0},
+	{DC_RESV, CPUFREQ_TABLE_END},
+};
+EXPORT_SYMBOL_GPL(loongson2_clockmod_table);
+
+static struct clk cpu_clk = {
+	.name = "cpu_clk",
+	.flags = CLK_ALWAYS_ENABLED | CLK_RATE_PROPAGATES,
+	.rate = 800000000,
+};
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	return &cpu_clk;
+}
+EXPORT_SYMBOL(clk_get);
+
+static void propagate_rate(struct clk *clk)
+{
+	struct clk *clkp;
+
+	list_for_each_entry(clkp, &clock_list, node) {
+		if (likely(clkp->parent != clk))
+			continue;
+		if (likely(clkp->ops && clkp->ops->recalc))
+			clkp->ops->recalc(clkp);
+		if (unlikely(clkp->flags & CLK_RATE_PROPAGATES))
+			propagate_rate(clkp);
+	}
+}
+
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return (unsigned long)clk->rate;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_put);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	return clk_set_rate_ex(clk, rate, 0);
+}
+EXPORT_SYMBOL_GPL(clk_set_rate);
+
+int clk_set_rate_ex(struct clk *clk, unsigned long rate, int algo_id)
+{
+	int ret = 0;
+	int regval;
+	int i;
+
+	if (likely(clk->ops && clk->ops->set_rate)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&clock_lock, flags);
+		ret = clk->ops->set_rate(clk, rate, algo_id);
+		spin_unlock_irqrestore(&clock_lock, flags);
+	}
+
+	if (unlikely(clk->flags & CLK_RATE_PROPAGATES))
+		propagate_rate(clk);
+
+	for (i = 0; loongson2_clockmod_table[i].frequency != CPUFREQ_TABLE_END;
+	     i++) {
+		if (loongson2_clockmod_table[i].frequency ==
+		    CPUFREQ_ENTRY_INVALID)
+			continue;
+		if (rate == loongson2_clockmod_table[i].frequency)
+			break;
+	}
+	if (rate != loongson2_clockmod_table[i].frequency)
+		return -ENOTSUPP;
+
+	clk->rate = rate;
+
+	regval = LOONGSON_CHIPCFG0;
+	regval = (regval & ~0x7) | (loongson2_clockmod_table[i].index - 1);
+	LOONGSON_CHIPCFG0 = regval;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_rate_ex);
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	if (likely(clk->ops && clk->ops->round_rate)) {
+		unsigned long flags, rounded;
+
+		spin_lock_irqsave(&clock_lock, flags);
+		rounded = clk->ops->round_rate(clk, rate);
+		spin_unlock_irqrestore(&clock_lock, flags);
+
+		return rounded;
+	}
+
+	return rate;
+}
+EXPORT_SYMBOL_GPL(clk_round_rate);
+
+/*
+ * This is the simple version of Loongson-2 wait, Maybe we need do this in
+ * interrupt disabled content
+ */
+
+DEFINE_SPINLOCK(loongson2_wait_lock);
+void loongson2_cpu_wait(void)
+{
+	u32 cpu_freq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&loongson2_wait_lock, flags);
+	cpu_freq = LOONGSON_CHIPCFG0;
+	LOONGSON_CHIPCFG0 &= ~0x7;	/* Put CPU into wait mode */
+	LOONGSON_CHIPCFG0 = cpu_freq;	/* Restore CPU state */
+	spin_unlock_irqrestore(&loongson2_wait_lock, flags);
+}
+EXPORT_SYMBOL_GPL(loongson2_cpu_wait);
diff --git a/arch/mips/kernel/cpufreq/loongson2_cpufreq.c b/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
new file mode 100644
index 0000000..ed08901
--- /dev/null
+++ b/arch/mips/kernel/cpufreq/loongson2_cpufreq.c
@@ -0,0 +1,200 @@
+/*
+ * Cpufreq driver for the loongson-2 processors
+ *
+ * The 2E revision of loongson processor not support this feature.
+ *
+ * Copyright (C) 2006 - 2008 Lemote Inc. & Insititute of Computing Technology
+ * Author: Yanhua, yanh@lemote.com
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/cpufreq.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/sched.h>	/* set_cpus_allowed() */
+#include <linux/delay.h>
+
+#include <asm/clock.h>
+
+#include <loongson.h>
+
+static uint nowait;
+
+static struct clk *cpuclk;
+
+static void (*saved_cpu_wait) (void);
+
+static int loongson2_cpu_freq_notifier(struct notifier_block *nb,
+					unsigned long val, void *data);
+
+static struct notifier_block loongson2_cpufreq_notifier_block = {
+	.notifier_call = loongson2_cpu_freq_notifier
+};
+
+static int loongson2_cpu_freq_notifier(struct notifier_block *nb,
+					unsigned long val, void *data)
+{
+	if (val == CPUFREQ_POSTCHANGE)
+		current_cpu_data.udelay_val = loops_per_jiffy;
+
+	return 0;
+}
+
+static unsigned int loongson2_cpufreq_get(unsigned int cpu)
+{
+	return clk_get_rate(cpuclk);
+}
+
+/*
+ * Here we notify other drivers of the proposed change and the final change.
+ */
+static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
+				     unsigned int target_freq,
+				     unsigned int relation)
+{
+	unsigned int cpu = policy->cpu;
+	unsigned int newstate = 0;
+	cpumask_t cpus_allowed;
+	struct cpufreq_freqs freqs;
+	unsigned int freq;
+
+	if (!cpu_online(cpu))
+		return -ENODEV;
+
+	cpus_allowed = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+
+	if (cpufreq_frequency_table_target
+	    (policy, &loongson2_clockmod_table[0], target_freq, relation,
+	     &newstate))
+		return -EINVAL;
+
+	freq =
+	    ((cpu_clock_freq / 1000) *
+	     loongson2_clockmod_table[newstate].index) / 8;
+	if (freq < policy->min || freq > policy->max)
+		return -EINVAL;
+
+	pr_debug("cpufreq: requested frequency %u Hz\n", target_freq * 1000);
+
+	freqs.cpu = cpu;
+	freqs.old = loongson2_cpufreq_get(cpu);
+	freqs.new = freq;
+	freqs.flags = 0;
+
+	if (freqs.new == freqs.old)
+		return 0;
+
+	/* notifiers */
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	set_cpus_allowed(current, cpus_allowed);
+
+	/* setting the cpu frequency */
+	clk_set_rate(cpuclk, freq);
+
+	/* notifiers */
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	pr_debug("cpufreq: set frequency %u kHz\n", freq);
+
+	return 0;
+}
+
+static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	int i;
+
+	if (!cpu_online(policy->cpu))
+		return -ENODEV;
+
+	cpuclk = clk_get(NULL, "cpu_clk");
+	if (IS_ERR(cpuclk)) {
+		printk(KERN_ERR "cpufreq: couldn't get CPU clk\n");
+		return PTR_ERR(cpuclk);
+	}
+
+	cpuclk->rate = cpu_clock_freq / 1000;
+	if (!cpuclk->rate)
+		return -EINVAL;
+
+	/* clock table init */
+	for (i = 2;
+	     (loongson2_clockmod_table[i].frequency != CPUFREQ_TABLE_END);
+	     i++)
+		loongson2_clockmod_table[i].frequency = (cpuclk->rate * i) / 8;
+
+	policy->cur = loongson2_cpufreq_get(policy->cpu);
+
+	cpufreq_frequency_table_get_attr(&loongson2_clockmod_table[0],
+					 policy->cpu);
+
+	return cpufreq_frequency_table_cpuinfo(policy,
+					    &loongson2_clockmod_table[0]);
+}
+
+static int loongson2_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy,
+					      &loongson2_clockmod_table[0]);
+}
+
+static int loongson2_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	clk_put(cpuclk);
+	return 0;
+}
+
+static struct freq_attr *loongson2_table_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
+static struct cpufreq_driver loongson2_cpufreq_driver = {
+	.owner = THIS_MODULE,
+	.name = "loongson2",
+	.init = loongson2_cpufreq_cpu_init,
+	.verify = loongson2_cpufreq_verify,
+	.target = loongson2_cpufreq_target,
+	.get = loongson2_cpufreq_get,
+	.exit = loongson2_cpufreq_exit,
+	.attr = loongson2_table_attr,
+};
+
+static int __init cpufreq_init(void)
+{
+	int result;
+
+	printk(KERN_INFO "cpufreq: Loongson-2F CPU frequency driver.\n");
+	result = cpufreq_register_driver(&loongson2_cpufreq_driver);
+
+	if (!result && !nowait) {
+		saved_cpu_wait = cpu_wait;
+		cpu_wait = loongson2_cpu_wait;
+	}
+
+	cpufreq_register_notifier(&loongson2_cpufreq_notifier_block,
+				  CPUFREQ_TRANSITION_NOTIFIER);
+	return result;
+}
+
+static void __exit cpufreq_exit(void)
+{
+	if (!nowait && saved_cpu_wait)
+		cpu_wait = saved_cpu_wait;
+	cpufreq_unregister_driver(&loongson2_cpufreq_driver);
+	cpufreq_unregister_notifier(&loongson2_cpufreq_notifier_block,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+}
+
+module_init(cpufreq_init);
+module_exit(cpufreq_exit);
+
+module_param(nowait, uint, 0644);
+MODULE_PARM_DESC(nowait, "Disable Loongson-2F specific wait");
+
+MODULE_AUTHOR("Yanhua <yanh@lemote.com>");
+MODULE_DESCRIPTION("cpufreq driver for Loongson2F");
+MODULE_LICENSE("GPL");
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 648c47d..9e66942 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -65,6 +65,7 @@ config CS5536
 config CS5536_MFGPT
 	bool "Using cs5536's MFGPT as system clock"
 	depends on CS5536
+	select MIPS_EXTERNAL_TIMER
 	help
 	  This is needed when cpufreq or oprofile is enabled in Lemote Loongson2F
 	  family machines
diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
index b9ef503..196d947 100644
--- a/arch/mips/loongson/common/env.c
+++ b/arch/mips/loongson/common/env.c
@@ -17,11 +17,14 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
+#include <linux/module.h>
+
 #include <asm/bootinfo.h>
 
 #include <loongson.h>
 
 unsigned long bus_clock, cpu_clock_freq;
+EXPORT_SYMBOL(cpu_clock_freq);
 unsigned long memsize, highmemsize;
 
 /* pmon passes arguments in 32bit pointers */
-- 
1.6.2.1
