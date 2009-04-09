Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 06:03:07 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:46548 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S20022124AbZDIFDB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 06:03:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id DDFE83412F;
	Thu,  9 Apr 2009 13:00:00 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 20fA5T-Ew+82; Thu,  9 Apr 2009 12:59:54 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 8412C34129;
	Thu,  9 Apr 2009 12:59:54 +0800 (CST)
Message-ID: <49DD8174.1000506@lemote.com>
Date:	Thu, 09 Apr 2009 13:02:44 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:	=?GB2312?B?xe3Bwb31?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: [PATCH 8/14] lemote: Loongson2F cpufreq support
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

Loongson2F add a new capability to dynamic scaling cpu frequency.
However the cpu count timer depends on cpu frequency. So an alternative
clock must be used if this driver is enabled. Besides, the CPU enter
wait state when the frequency is setting zero. All these features help
power save.
---
arch/mips/Kconfig | 17 +++
arch/mips/include/asm/clock.h | 62 ++++++++++
arch/mips/kernel/Makefile | 1 +
arch/mips/kernel/ls2f_freq.c | 216 +++++++++++++++++++++++++++++++++
arch/mips/lemote/lm2f/common/Makefile | 1 +
arch/mips/lemote/lm2f/common/clock.c | 160 ++++++++++++++++++++++++
6 files changed, 457 insertions(+), 0 deletions(-)
create mode 100644 arch/mips/include/asm/clock.h
create mode 100644 arch/mips/kernel/ls2f_freq.c
create mode 100644 arch/mips/lemote/lm2f/common/clock.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 182df7c..8122fc2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2141,6 +2141,23 @@ source "kernel/power/Kconfig"

endmenu

+menu "CPU Frequency scaling"
+
+source "drivers/cpufreq/Kconfig"
+
+config LS2F_CPU_FREQ
+ bool "Loongson-2F CPU Frequency driver"
+ depends on CPU_LOONGSON2 && CPU_FREQ
+ select CPU_FREQ_TABLE
+ help
+ This adds the cpufreq driver for Loongson-2F.
+
+ For details, take a look at <file:Documentation/cpu-freq>.
+
+ If unsure, say N.
+
+endmenu
+
source "net/Kconfig"

source "drivers/Kconfig"
diff --git a/arch/mips/include/asm/clock.h b/arch/mips/include/asm/clock.h
new file mode 100644
index 0000000..9442f3b
--- /dev/null
+++ b/arch/mips/include/asm/clock.h
@@ -0,0 +1,62 @@
+#ifndef __ASM_MIPS_CLOCK_H
+#define __ASM_MIPS_CLOCK_H
+
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/seq_file.h>
+#include <linux/clk.h>
+
+struct clk;
+
+struct clk_ops {
+ void (*init)(struct clk *clk);
+ void (*enable)(struct clk *clk);
+ void (*disable)(struct clk *clk);
+ void (*recalc)(struct clk *clk);
+ int (*set_rate)(struct clk *clk, unsigned long rate, int algo_id);
+ long (*round_rate)(struct clk *clk, unsigned long rate);
+};
+
+struct clk {
+ struct list_head node;
+ const char *name;
+ int id;
+ struct module *owner;
+
+ struct clk *parent;
+ struct clk_ops *ops;
+
+ struct kref kref;
+
+ unsigned long rate;
+ unsigned long flags;
+};
+
+#define CLK_ALWAYS_ENABLED (1 << 0)
+#define CLK_RATE_PROPAGATES (1 << 1)
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
+ * clk_set_rate_ex - set the clock rate for a clock source, with
additional parameter
+ * @clk: clock source
+ * @rate: desired clock rate in Hz
+ * @algo_id: algorithm id to be passed down to ops->set_rate
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_set_rate_ex(struct clk *clk, unsigned long rate, int algo_id);
+
+#endif /* __ASM_MIPS_CLOCK_H */
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index e961221..fab91d2 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_64BIT) += scall64-64.o
obj-$(CONFIG_MIPS32_COMPAT) += linux32.o ptrace32.o signal32.o
obj-$(CONFIG_MIPS32_N32) += binfmt_elfn32.o scall64-n32.o signal_n32.o
obj-$(CONFIG_MIPS32_O32) += binfmt_elfo32.o scall64-o32.o
+obj-$(CONFIG_LS2F_CPU_FREQ) += ls2f_freq.o

obj-$(CONFIG_KGDB) += kgdb.o
obj-$(CONFIG_PROC_FS) += proc.o
diff --git a/arch/mips/kernel/ls2f_freq.c b/arch/mips/kernel/ls2f_freq.c
new file mode 100644
index 0000000..602eb46
--- /dev/null
+++ b/arch/mips/kernel/ls2f_freq.c
@@ -0,0 +1,216 @@
+/*
+ * arch/mips/kernel/cpufreq.c
+ *
+ * cpufreq driver for the loongson-2f processors.
+ *
+ * Copyright (C) 2006 - 2008 Yanhua
+ *
+ *
+ * This file is subject to the terms and conditions of the GNU General
Public
+ * License. See the file "COPYING" in the main directory of this archive
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
+#include <linux/sched.h> /* set_cpus_allowed() */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <asm/delay.h>
+
+#include <asm/clock.h>
+
+static uint nowait = 0;
+
+static struct clk *cpuclk;
+extern unsigned long cpu_clock_freq;
+extern struct cpufreq_frequency_table ls2f_clockmod_table[];
+
+extern void (*cpu_wait)(void);
+extern void ls2f_cpu_wait(void);
+static void (*saved_cpu_wait)(void);
+
+static int
+ls2f_cpu_freq_notifier(struct notifier_block *nb, unsigned long val,
+ void *data);
+
+static struct notifier_block ls2f_cpufreq_notifier_block = {
+ .notifier_call = ls2f_cpu_freq_notifier
+};
+
+static int
+ls2f_cpu_freq_notifier(struct notifier_block *nb, unsigned long val,
void *data)
+{
+ if (val == CPUFREQ_POSTCHANGE) {
+ __udelay_val = loops_per_jiffy;
+ }
+ return 0;
+}
+
+static unsigned int ls2f_cpufreq_get(unsigned int cpu)
+{
+ return clk_get_rate(cpuclk);
+}
+
+/*
+ * Here we notify other drivers of the proposed change and the final
change.
+ */
+static int ls2f_cpufreq_target(struct cpufreq_policy *policy,
+ unsigned int target_freq,
+ unsigned int relation)
+{
+ unsigned int cpu = policy->cpu;
+ unsigned int newstate = 0;
+ cpumask_t cpus_allowed;
+ struct cpufreq_freqs freqs;
+ long freq;
+
+ if (!cpu_online(cpu))
+ return -ENODEV;
+
+ cpus_allowed = current->cpus_allowed;
+ set_cpus_allowed(current, cpumask_of_cpu(cpu));
+
+#ifdef CONFIG_SMP
+ BUG_ON(smp_processor_id() != cpu);
+#endif
+
+ if (cpufreq_frequency_table_target(policy, &ls2f_clockmod_table[0],
target_freq, relation, &newstate))
+ return -EINVAL;
+
+ freq = cpu_clock_freq / 1000 * ls2f_clockmod_table[newstate].index / 8;
+ if (freq < policy->min || freq > policy->max )
+ return -EINVAL;
+
+ pr_debug("cpufreq: requested frequency %u Hz\n", target_freq * 1000);
+
+ freqs.cpu = cpu;
+ freqs.old = ls2f_cpufreq_get(cpu);
+ freqs.new = freq;
+ freqs.flags = 0;
+
+ if (freqs.new == freqs.old)
+ return 0;
+
+ /* notifiers */
+ cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+ set_cpus_allowed(current, cpus_allowed);
+
+ /* setting the cpu frequency */
+ clk_set_rate(cpuclk, freq);
+
+ /* notifiers */
+ cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+ pr_debug("cpufreq: set frequency %lu kHz\n", freq);
+
+ return 0;
+}
+
+static int ls2f_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+ int i;
+ int result;
+
+ if (!cpu_online(policy->cpu))
+ return -ENODEV;
+
+ cpuclk = clk_get(NULL, "cpu_clk");
+ if (IS_ERR(cpuclk)) {
+ printk(KERN_ERR "cpufreq: couldn't get CPU clk\n");
+ return PTR_ERR(cpuclk);
+ }
+
+ cpuclk->rate = cpu_clock_freq / 1000;
+ if(!cpuclk->rate)
+ return -EINVAL;
+
+ /* clock table init */
+ for (i=2; (ls2f_clockmod_table[i].frequency != CPUFREQ_TABLE_END); i++) {
+ ls2f_clockmod_table[i].frequency = (cpuclk->rate * i)/8;
+ }
+
+ policy->cur = ls2f_cpufreq_get(policy->cpu);
+
+ cpufreq_frequency_table_get_attr(&ls2f_clockmod_table[0], policy->cpu);
+
+ result = cpufreq_frequency_table_cpuinfo(policy, &ls2f_clockmod_table[0]);
+ if (result)
+ return (result);
+
+ return 0;
+}
+
+static int ls2f_cpufreq_verify(struct cpufreq_policy *policy)
+{
+ return cpufreq_frequency_table_verify(policy, &ls2f_clockmod_table[0]);
+}
+
+static int ls2f_cpufreq_exit(struct cpufreq_policy *policy)
+{
+ clk_put(cpuclk);
+ return 0;
+}
+
+static struct freq_attr* ls2f_table_attr[] = {
+ &cpufreq_freq_attr_scaling_available_freqs,
+ NULL,
+};
+
+static struct cpufreq_driver ls2f_cpufreq_driver = {
+ .owner = THIS_MODULE,
+ .name = "ls2f",
+ .init = ls2f_cpufreq_cpu_init,
+ .verify = ls2f_cpufreq_verify,
+ .target = ls2f_cpufreq_target,
+ .get = ls2f_cpufreq_get,
+ .exit = ls2f_cpufreq_exit,
+ .attr = ls2f_table_attr,
+};
+
+static int __init ls2f_cpufreq_module_init(void)
+{
+ struct cpuinfo_mips *c = &cpu_data[0];
+ int result;
+
+ if (c->processor_id != 0x6303)
+ return -ENODEV;
+
+ printk(KERN_INFO "cpufreq: Loongson-2F CPU frequency driver.\n");
+ result = cpufreq_register_driver(&ls2f_cpufreq_driver);
+
+ if(!result && !nowait) {
+ saved_cpu_wait = cpu_wait;
+ cpu_wait = ls2f_cpu_wait;
+ }
+
+ cpufreq_register_notifier(&ls2f_cpufreq_notifier_block,
+ CPUFREQ_TRANSITION_NOTIFIER);
+ return result;
+}
+
+static void __exit ls2f_cpufreq_module_exit(void)
+{
+ if(!nowait && saved_cpu_wait)
+ cpu_wait = saved_cpu_wait;
+ cpufreq_unregister_driver(&ls2f_cpufreq_driver);
+ cpufreq_unregister_notifier(&ls2f_cpufreq_notifier_block,
+ CPUFREQ_TRANSITION_NOTIFIER);
+}
+
+//late_initcall(ls2f_cpufreq_module_init);
+module_init(ls2f_cpufreq_module_init);
+module_exit(ls2f_cpufreq_module_exit);
+
+module_param(nowait, uint, 0644);
+MODULE_PARM_DESC(nowait, "Disable Loongson-2F specific wait");
+
+MODULE_AUTHOR("Yanhua <yanh@lemote.com>");
+MODULE_DESCRIPTION("cpufreq driver for Loongson2F");
+MODULE_LICENSE("GPL");
diff --git a/arch/mips/lemote/lm2f/common/Makefile
b/arch/mips/lemote/lm2f/common/Makefile
index 765874a..bd31c72 100644
--- a/arch/mips/lemote/lm2f/common/Makefile
+++ b/arch/mips/lemote/lm2f/common/Makefile
@@ -7,3 +7,4 @@

obj-y += mem.o mipsdha.o pci.o mem.o plat.o mfgpt.o
obj-$(CONFIG_CS5536) += cs5536_vsm.o
+obj-$(CONFIG_LS2F_CPU_FREQ) += clock.o
diff --git a/arch/mips/lemote/lm2f/common/clock.c
b/arch/mips/lemote/lm2f/common/clock.c
new file mode 100644
index 0000000..8c9602f
--- /dev/null
+++ b/arch/mips/lemote/lm2f/common/clock.c
@@ -0,0 +1,160 @@
+#include <linux/cpufreq.h>
+#include <linux/platform_device.h>
+#include <asm/clock.h>
+
+#ifdef CONFIG_64BIT
+#define PTR_PAD(p) ((0xffffffff00000000)|((unsigned long)(p)))
+#else
+#define PTR_PAD(p) (p)
+#endif
+
+static LIST_HEAD(clock_list);
+static DEFINE_SPINLOCK(clock_lock);
+static DEFINE_MUTEX(clock_list_sem);
+
+/* Minimum CLK support */
+enum {
+ DC_ZERO, DC_25PT=2, DC_37PT, DC_50PT, DC_62PT, DC_75PT,
+ DC_87PT, DC_DISABLE, DC_RESV
+};
+
+struct cpufreq_frequency_table ls2f_clockmod_table[] = {
+ {DC_RESV, CPUFREQ_ENTRY_INVALID},
+ {DC_ZERO, CPUFREQ_ENTRY_INVALID},
+ {DC_25PT, 0},
+ {DC_37PT, 0},
+ {DC_50PT, 0},
+ {DC_62PT, 0},
+ {DC_75PT, 0},
+ {DC_87PT, 0},
+ {DC_DISABLE, 0},
+ {DC_RESV, CPUFREQ_TABLE_END},
+};
+
+
+static struct clk cpu_clk = {
+ .name = "cpu_clk",
+ .flags = CLK_ALWAYS_ENABLED | CLK_RATE_PROPAGATES,
+ .rate = 800000000,
+};
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+ return &cpu_clk;
+}
+EXPORT_SYMBOL(clk_get);
+
+static void propagate_rate(struct clk *clk)
+{
+ struct clk *clkp;
+
+ list_for_each_entry(clkp, &clock_list, node) {
+ if (likely(clkp->parent != clk))
+ continue;
+ if (likely(clkp->ops && clkp->ops->recalc))
+ clkp->ops->recalc(clkp);
+ if (unlikely(clkp->flags & CLK_RATE_PROPAGATES))
+ propagate_rate(clkp);
+ }
+}
+
+int clk_enable(struct clk *clk)
+{
+ return 0;
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
+ return (unsigned long)clk->rate;
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
+ return clk_set_rate_ex(clk, rate, 0);
+}
+EXPORT_SYMBOL_GPL(clk_set_rate);
+
+int clk_set_rate_ex(struct clk *clk, unsigned long rate, int algo_id)
+{
+ //int ret = -EOPNOTSUPP;
+ int ret = 0; //-EOPNOTSUPP;
+ int regval;
+ int i;
+
+ if (likely(clk->ops && clk->ops->set_rate)) {
+ unsigned long flags;
+
+ spin_lock_irqsave(&clock_lock, flags);
+ ret = clk->ops->set_rate(clk, rate, algo_id);
+ spin_unlock_irqrestore(&clock_lock, flags);
+ }
+
+ if (unlikely(clk->flags & CLK_RATE_PROPAGATES))
+ propagate_rate(clk);
+
+ for (i =0; ls2f_clockmod_table[i].frequency != CPUFREQ_TABLE_END; i++) {
+ if (ls2f_clockmod_table[i].frequency == CPUFREQ_ENTRY_INVALID)
+ continue;
+ if (rate == ls2f_clockmod_table[i].frequency)
+ break;
+ }
+ if (rate != ls2f_clockmod_table[i].frequency)
+ return -ENOTSUPP;
+
+ clk->rate = rate;
+
+ regval = *(volatile unsigned int*) PTR_PAD(0xbfe00180);
+ regval = (regval & ~0x7) | (ls2f_clockmod_table[i].index -1);
+ *(volatile unsigned int *) PTR_PAD(0xbfe00180) = regval;
+
+ return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_rate_ex);
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+ if (likely(clk->ops && clk->ops->round_rate)) {
+ unsigned long flags, rounded;
+
+ spin_lock_irqsave(&clock_lock, flags);
+ rounded = clk->ops->round_rate(clk, rate);
+ spin_unlock_irqrestore(&clock_lock, flags);
+
+ return rounded;
+ }
+
+ return rate; //clk_get_rate(clk);
+}
+EXPORT_SYMBOL_GPL(clk_round_rate);
+
+/*
+ * This is the simple version of Loongson-2F wait
+ * Maybe we need do this in interrupt disabled content
+ */
+DEFINE_SPINLOCK(ls2f_wait_lock);
+void ls2f_cpu_wait(void)
+{
+ u32 cpu_freq;
+ unsigned long flags;
+
+ spin_lock_irqsave(&ls2f_wait_lock, flags);
+ cpu_freq = *(volatile u32*)PTR_PAD(0xbfe00180);
+ *(volatile u32*)PTR_PAD(0xbfe00180) &= ~0x7; //Put CPU into wait mode
+ *(volatile u32*)PTR_PAD(0xbfe00180) = cpu_freq; //Restore CPU state
+ spin_unlock_irqrestore(&ls2f_wait_lock, flags);
+}
+
+EXPORT_SYMBOL_GPL(ls2f_cpu_wait);
+EXPORT_SYMBOL_GPL(ls2f_clockmod_table);
-- 
1.5.6.5
