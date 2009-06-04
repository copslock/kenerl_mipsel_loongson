Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:12:30 +0100 (WEST)
Received: from mail-px0-f186.google.com ([209.85.216.186]:49590 "EHLO
	mail-px0-f186.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022635AbZFDNLA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:11:00 +0100
Received: by mail-px0-f186.google.com with SMTP id 16so751437pxi.22
        for <multiple recipients>; Thu, 04 Jun 2009 06:10:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CeWzhiMNgzwKS82zgkuX1aPOu4CUVWjFY2UUf88sCqE=;
        b=uKGwlOJrlGOH1HSLj/+7wEjSZITpLsg+ymG4o5FFBd1owjZXgkvBZ19HZygAY6tEVL
         SL7Atl3/XQw959BVghaR2JBQnLh/b2kYzMzikpbPFbGoFjZZyeAXR4zILZMHVaQ+rxS1
         TGSUecqZCUvRbadso+Yy5TVeGXOYsMFk2E7ls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CRXefp43k7y/ZIUBrCgA0E65EXZRtO5edoAfJ2feN5YlhvYCBU/x5bNEfPkKHGsznF
         q1WN6iA1wS0qs2pF2Euh4kGJnKeKyXyERPcZoX5xWPSv14z+WQ2ysePvxHoGZJS5WAns
         /6PW8vOp59j2wKwOT3SBKJsbYV3bEPOvmgpoo=
Received: by 10.114.211.2 with SMTP id j2mr3413748wag.139.1244121056772;
        Thu, 04 Jun 2009 06:10:56 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id l38sm11191470waf.38.2009.06.04.06.10.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 06:10:55 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v3 23/25] Loongson2F cpufreq support
Date:	Thu,  4 Jun 2009 21:10:43 +0800
Message-Id: <72e8c5577e8208161ada75384aa018e1967cada2.1244120575.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244120575.git.wuzj@lemote.com>
References: <cover.1244120575.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

Loongson2F add a new capability to dynamic scaling cpu frequency.  However the
cpu count timer depends on cpu frequency. So an alternative clock must be used
if this driver is enabled. Besides, the CPU enter wait state when the frequency
is setting zero. All these features help power save.

In fuloong(2f) and yeeloong(2f), if you want to use this feature, you
should enable the cs5536 mfgpt timer.

Reviewed-by: Manuel Lauss <mano@roarinelk.homelinux.net>
Reviewed-by: Arnaud Patard <apatard@mandriva.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: Yan Hua <yanh@lemote.com>
---
 arch/mips/Kconfig                              |   17 ++
 arch/mips/include/asm/mach-loongson/clock.h    |   64 +++++++
 arch/mips/include/asm/mach-loongson/loongson.h |    7 +
 arch/mips/kernel/Makefile                      |    1 +
 arch/mips/kernel/loongson2f_freq.c             |  216 ++++++++++++++++++++++++
 arch/mips/loongson/common/Makefile             |    6 +
 arch/mips/loongson/common/clock.c              |  166 ++++++++++++++++++
 7 files changed, 477 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/clock.h
 create mode 100644 arch/mips/kernel/loongson2f_freq.c
 create mode 100644 arch/mips/loongson/common/clock.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 74efb43..c7d1d08 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2136,6 +2136,23 @@ source "kernel/power/Kconfig"
 
 endmenu
 
+menu "CPU Frequency scaling"
+
+source "drivers/cpufreq/Kconfig"
+
+config LOONGSON2F_CPU_FREQ
+	bool "Loongson-2F CPU Frequency driver"
+	depends on CPU_LOONGSON2F && CPU_FREQ && (CS5536_MFGPT || I8253)
+	select CPU_FREQ_TABLE
+	help
+	  This adds the cpufreq driver for Loongson-2F.
+
+	  For details, take a look at <file:Documentation/cpu-freq>.
+
+	  If unsure, say N.
+
+endmenu
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/arch/mips/include/asm/mach-loongson/clock.h b/arch/mips/include/asm/mach-loongson/clock.h
new file mode 100644
index 0000000..83894aa
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/clock.h
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
index b458a1e..4354c29 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -51,6 +51,13 @@ extern void mach_prepare_shutdown(void);
 		__asm__ __volatile__(""); \
 })
 
+/* loongson-specific cpu frequency relative stuff */
+#ifdef CONFIG_LOONGSON2F_CPU_FREQ
+#include <linux/cpufreq.h>
+extern void loongson2f_cpu_wait(void);
+extern struct cpufreq_frequency_table loongson2f_clockmod_table[];
+#endif
+
 #define LOONGSON_REG(x) \
 	(*(u32 *)((char *)CKSEG1ADDR(LOONGSON_REG_BASE) + (x)))
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index e961221..78c8002 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_64BIT)		+= scall64-64.o
 obj-$(CONFIG_MIPS32_COMPAT)	+= linux32.o ptrace32.o signal32.o
 obj-$(CONFIG_MIPS32_N32)	+= binfmt_elfn32.o scall64-n32.o signal_n32.o
 obj-$(CONFIG_MIPS32_O32)	+= binfmt_elfo32.o scall64-o32.o
+obj-$(CONFIG_LOONGSON2F_CPU_FREQ) += loongson2f_freq.o
 
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_PROC_FS)		+= proc.o
diff --git a/arch/mips/kernel/loongson2f_freq.c b/arch/mips/kernel/loongson2f_freq.c
new file mode 100644
index 0000000..84896c5
--- /dev/null
+++ b/arch/mips/kernel/loongson2f_freq.c
@@ -0,0 +1,216 @@
+/*
+ * arch/mips/kernel/cpufreq.c
+ *
+ * cpufreq driver for the loongson-2f processors.
+ *
+ * Copyright (C) 2006 - 2008 Lemote Inc. & Insititute of Computing Technology
+ * Author: Yanhua, yanh@lemote.com
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/types.h>
+#include <linux/cpufreq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/cpumask.h>
+#include <linux/smp.h>
+#include <linux/sched.h>	/* set_cpus_allowed() */
+#include <linux/clk.h>
+#include <linux/delay.h>
+
+#include <loongson.h>
+#include <clock.h>
+
+static uint nowait;
+
+static struct clk *cpuclk;
+
+static void (*saved_cpu_wait) (void);
+
+static int loongson2f_cpu_freq_notifier(struct notifier_block *nb,
+					unsigned long val, void *data);
+
+static struct notifier_block loongson2f_cpufreq_notifier_block = {
+	.notifier_call = loongson2f_cpu_freq_notifier
+};
+
+static int loongson2f_cpu_freq_notifier(struct notifier_block *nb,
+					unsigned long val, void *data)
+{
+	if (val == CPUFREQ_POSTCHANGE)
+		__udelay_val = loops_per_jiffy;
+
+	return 0;
+}
+
+static unsigned int loongson2f_cpufreq_get(unsigned int cpu)
+{
+	return clk_get_rate(cpuclk);
+}
+
+/*
+ * Here we notify other drivers of the proposed change and the final change.
+ */
+static int loongson2f_cpufreq_target(struct cpufreq_policy *policy,
+				     unsigned int target_freq,
+				     unsigned int relation)
+{
+	unsigned int cpu = policy->cpu;
+	unsigned int newstate = 0;
+	cpumask_t cpus_allowed;
+	struct cpufreq_freqs freqs;
+	long freq;
+
+	if (!cpu_online(cpu))
+		return -ENODEV;
+
+	cpus_allowed = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+
+#ifdef CONFIG_SMP
+	BUG_ON(smp_processor_id() != cpu);
+#endif
+
+	if (cpufreq_frequency_table_target
+	    (policy, &loongson2f_clockmod_table[0], target_freq, relation,
+	     &newstate))
+		return -EINVAL;
+
+	freq =
+	    cpu_clock_freq / 1000 * loongson2f_clockmod_table[newstate].index /
+	    8;
+	if (freq < policy->min || freq > policy->max)
+		return -EINVAL;
+
+	pr_debug("cpufreq: requested frequency %u Hz\n", target_freq * 1000);
+
+	freqs.cpu = cpu;
+	freqs.old = loongson2f_cpufreq_get(cpu);
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
+	pr_debug("cpufreq: set frequency %lu kHz\n", freq);
+
+	return 0;
+}
+
+static int loongson2f_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	int i;
+	int result;
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
+	     (loongson2f_clockmod_table[i].frequency != CPUFREQ_TABLE_END);
+	     i++) {
+		loongson2f_clockmod_table[i].frequency = (cpuclk->rate * i) / 8;
+	}
+
+	policy->cur = loongson2f_cpufreq_get(policy->cpu);
+
+	cpufreq_frequency_table_get_attr(&loongson2f_clockmod_table[0],
+					 policy->cpu);
+
+	result =
+	    cpufreq_frequency_table_cpuinfo(policy,
+					    &loongson2f_clockmod_table[0]);
+	if (result)
+		return result;
+
+	return 0;
+}
+
+static int loongson2f_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy,
+					      &loongson2f_clockmod_table[0]);
+}
+
+static int loongson2f_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	clk_put(cpuclk);
+	return 0;
+}
+
+static struct freq_attr *loongson2f_table_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
+static struct cpufreq_driver loongson2f_cpufreq_driver = {
+	.owner = THIS_MODULE,
+	.name = "loongson2f",
+	.init = loongson2f_cpufreq_cpu_init,
+	.verify = loongson2f_cpufreq_verify,
+	.target = loongson2f_cpufreq_target,
+	.get = loongson2f_cpufreq_get,
+	.exit = loongson2f_cpufreq_exit,
+	.attr = loongson2f_table_attr,
+};
+
+static int __init loongson2f_cpufreq_module_init(void)
+{
+	int result;
+
+	printk(KERN_INFO "cpufreq: Loongson-2F CPU frequency driver.\n");
+	result = cpufreq_register_driver(&loongson2f_cpufreq_driver);
+
+	if (!result && !nowait) {
+		saved_cpu_wait = cpu_wait;
+		cpu_wait = loongson2f_cpu_wait;
+	}
+
+	cpufreq_register_notifier(&loongson2f_cpufreq_notifier_block,
+				  CPUFREQ_TRANSITION_NOTIFIER);
+	return result;
+}
+
+static void __exit loongson2f_cpufreq_module_exit(void)
+{
+	if (!nowait && saved_cpu_wait)
+		cpu_wait = saved_cpu_wait;
+	cpufreq_unregister_driver(&loongson2f_cpufreq_driver);
+	cpufreq_unregister_notifier(&loongson2f_cpufreq_notifier_block,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+}
+
+module_init(loongson2f_cpufreq_module_init);
+module_exit(loongson2f_cpufreq_module_exit);
+
+module_param(nowait, uint, 0644);
+MODULE_PARM_DESC(nowait, "Disable Loongson-2F specific wait");
+
+MODULE_AUTHOR("Yanhua <yanh@lemote.com>");
+MODULE_DESCRIPTION("cpufreq driver for Loongson2F");
+MODULE_LICENSE("GPL");
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index df782d6..a4d46c3 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -24,6 +24,12 @@ obj-$(CONFIG_RTC_DRV_CMOS) += rtc.o
 obj-$(CONFIG_CS5536) += cs5536/
 
 #
+# Enable fuloong(2f) and yeeloong(2f) cpu frequency scaling support
+# This is based on CS5536 mfgpt timer
+#
+obj-$(CONFIG_LOONGSON2F_CPU_FREQ) += clock.o
+
+#
 # Enable serial port
 #
 obj-$(CONFIG_SERIAL_8250) += serial.o
diff --git a/arch/mips/loongson/common/clock.c b/arch/mips/loongson/common/clock.c
new file mode 100644
index 0000000..1a74952
--- /dev/null
+++ b/arch/mips/loongson/common/clock.c
@@ -0,0 +1,166 @@
+/*
+ * arch/mips/loongson/common/clock.c
+ *
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
+#include <loongson.h>
+#include <clock.h>
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
+struct cpufreq_frequency_table loongson2f_clockmod_table[] = {
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
+EXPORT_SYMBOL_GPL(loongson2f_clockmod_table);
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
+	for (i = 0; loongson2f_clockmod_table[i].frequency != CPUFREQ_TABLE_END;
+	     i++) {
+		if (loongson2f_clockmod_table[i].frequency ==
+		    CPUFREQ_ENTRY_INVALID)
+			continue;
+		if (rate == loongson2f_clockmod_table[i].frequency)
+			break;
+	}
+	if (rate != loongson2f_clockmod_table[i].frequency)
+		return -ENOTSUPP;
+
+	clk->rate = rate;
+
+	regval = LOONGSON_CHIPCFG0;
+	regval = (regval & ~0x7) | (loongson2f_clockmod_table[i].index - 1);
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
+ * This is the simple version of Loongson-2F wait
+ * Maybe we need do this in interrupt disabled content
+ */
+DEFINE_SPINLOCK(loongson2f_wait_lock);
+void loongson2f_cpu_wait(void)
+{
+	u32 cpu_freq;
+	unsigned long flags;
+
+	spin_lock_irqsave(&loongson2f_wait_lock, flags);
+	cpu_freq = LOONGSON_CHIPCFG0;
+	LOONGSON_CHIPCFG0 &= ~0x7;	/* Put CPU into wait mode */
+	LOONGSON_CHIPCFG0 = cpu_freq;	/* Restore CPU state */
+	spin_unlock_irqrestore(&loongson2f_wait_lock, flags);
+}
+EXPORT_SYMBOL_GPL(loongson2f_cpu_wait);
-- 
1.6.0.4
