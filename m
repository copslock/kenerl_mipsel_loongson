Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 04:16:31 +0200 (CEST)
Received: from smtpbgau2.qq.com ([54.206.34.216]:45731 "EHLO smtpbgau2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992400AbdHJCQShlJoC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Aug 2017 04:16:18 +0200
X-QQ-mid: bizesmtp1t1502331314t2r6gw174
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 10 Aug 2017 10:15:10 +0800 (CST)
X-QQ-SSF: 01100000004000F0FMF0000A0000000
X-QQ-FEAT: qOizwVFmHvHToAnTon0brMCs9iyXI0PjOIhcBl2hIOMgH5+XpTpYpy/YWAMHk
        TL2bzYBdV59B9s/fXxbf0dvVh8JKgXCnph59skBFgT7jbp5utW65m29U0bHUMb4r30CBMxN
        7phYZo7IHl/cwDru08GE+6k6tgji4OcQeXkqFk4bYqhZ5qFVlvVYnTsDczkMNUkxj0uewuD
        MrVb6y9opWrS8lKymiU5nm7ObBd4yzxuCEvwfGYFGd4AU0q/QoSvxEV03kGWCizDiUK8Jp/
        xnk0L1lVa6gIvwgBeLvI+Uql/UpTCD2vLxlBD3isFZiMKE
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 7/8] MIPS: Loongson: Make CPUFreq usable for Loongson-3
Date:   Thu, 10 Aug 2017 10:15:52 +0800
Message-Id: <1502331353-17062-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1502330433-16670-1-git-send-email-chenhc@lemote.com>
References: <1502330433-16670-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lemote.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Loongson-3A/3B support frequency scaling. But due to hardware
limitation, Loongson-3A's frequency scaling is not independent for
each core, we suggest enable Loongson-3A's CPUFreq only when there is
one core online. Loongson-3B can adjust frequency independently for
each core, so it can be always enabled.

Each package has only one register (ChipConfig or FreqCtrl) to control
frequency, so we need spinlocks to protect register access for multi-
cores. However, we cannot use spinlock when a core becomes into "wait"
status (frequency = 0), so we only enable "wait" when there is one core
in a package online.

arch/mips/kernel/smp.c is modified to guarantee udelay_val has the
correct value while both CPU hotplug and CPUFreq are enabled.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson64/loongson.h |   1 +
 arch/mips/kernel/smp.c                           |   3 +-
 arch/mips/loongson64/Kconfig                     |   1 +
 arch/mips/loongson64/common/platform.c           |  13 +-
 arch/mips/loongson64/loongson-3/Makefile         |   2 +-
 arch/mips/loongson64/loongson-3/clock.c          | 191 ++++++++++++++++++
 drivers/cpufreq/Kconfig                          |  15 ++
 drivers/cpufreq/Makefile                         |   1 +
 drivers/cpufreq/loongson3_cpufreq.c              | 236 +++++++++++++++++++++++
 9 files changed, 458 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/loongson64/loongson-3/clock.c
 create mode 100644 drivers/cpufreq/loongson3_cpufreq.c

diff --git a/arch/mips/include/asm/mach-loongson64/loongson.h b/arch/mips/include/asm/mach-loongson64/loongson.h
index c68c0cc..271cabb 100644
--- a/arch/mips/include/asm/mach-loongson64/loongson.h
+++ b/arch/mips/include/asm/mach-loongson64/loongson.h
@@ -277,6 +277,7 @@ extern u64 loongson_freqctrl[MAX_PACKAGES];
 #ifdef CONFIG_CPU_SUPPORTS_CPUFREQ
 #include <linux/cpufreq.h>
 extern struct cpufreq_frequency_table loongson2_clockmod_table[];
+extern struct cpufreq_frequency_table loongson3_clockmod_table[];
 #endif
 
 /*
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 770d4d1..eb1bb0a 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -371,7 +371,8 @@ asmlinkage void start_secondary(void)
 	calibrate_delay();
 	preempt_disable();
 	cpu = smp_processor_id();
-	cpu_data[cpu].udelay_val = loops_per_jiffy;
+	if (!cpu_data[cpu].udelay_val)
+		cpu_data[cpu].udelay_val = loops_per_jiffy;
 
 	cpumask_set_cpu(cpu, &cpu_coherent_mask);
 	notify_cpu_starting(cpu);
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index 8e6e292..7e5bb30 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -69,6 +69,7 @@ config LOONGSON_MACH3X
 	select CSRC_R4K
 	select CEVT_R4K
 	select CPU_HAS_WB
+	select HAVE_CLK
 	select HW_HAS_PCI
 	select ISA
 	select HT_PCI
diff --git a/arch/mips/loongson64/common/platform.c b/arch/mips/loongson64/common/platform.c
index 0ed3832..733a13f 100644
--- a/arch/mips/loongson64/common/platform.c
+++ b/arch/mips/loongson64/common/platform.c
@@ -17,15 +17,22 @@ static struct platform_device loongson2_cpufreq_device = {
 	.id = -1,
 };
 
-static int __init loongson2_cpufreq_init(void)
+static struct platform_device loongson3_cpufreq_device = {
+	.name = "loongson3_cpufreq",
+	.id = -1,
+};
+
+static int __init loongson_cpufreq_init(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 
 	/* Only 2F revision and it's successors support CPUFreq */
-	if ((c->processor_id & PRID_REV_MASK) >= PRID_REV_LOONGSON2F)
+	if ((c->processor_id & PRID_REV_MASK) == PRID_REV_LOONGSON2F)
 		return platform_device_register(&loongson2_cpufreq_device);
+	if ((c->processor_id & PRID_REV_MASK) >= PRID_REV_LOONGSON3A_R1)
+		return platform_device_register(&loongson3_cpufreq_device);
 
 	return -ENODEV;
 }
 
-arch_initcall(loongson2_cpufreq_init);
+arch_initcall(loongson_cpufreq_init);
diff --git a/arch/mips/loongson64/loongson-3/Makefile b/arch/mips/loongson64/loongson-3/Makefile
index 44bc148..7b035b7 100644
--- a/arch/mips/loongson64/loongson-3/Makefile
+++ b/arch/mips/loongson64/loongson-3/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for Loongson-3 family machines
 #
-obj-y			+= irq.o cop2-ex.o platform.o acpi_init.o
+obj-y			+= irq.o cop2-ex.o platform.o acpi_init.o clock.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 
diff --git a/arch/mips/loongson64/loongson-3/clock.c b/arch/mips/loongson64/loongson-3/clock.c
new file mode 100644
index 0000000..118f539
--- /dev/null
+++ b/arch/mips/loongson64/loongson-3/clock.c
@@ -0,0 +1,191 @@
+/*
+ * Copyright (C) 2008 - 2014 Lemote Inc.
+ * Author: Yan Hua, yanh@lemote.com
+ *         Chen Huacai, chenhc@lemote.com
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/slab.h>
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
+struct cpufreq_frequency_table loongson3_clockmod_table[] = {
+	{0, DC_RESV, CPUFREQ_ENTRY_INVALID},
+	{0, DC_ZERO, CPUFREQ_ENTRY_INVALID},
+	{0, DC_25PT, 0},
+	{0, DC_37PT, 0},
+	{0, DC_50PT, 0},
+	{0, DC_62PT, 0},
+	{0, DC_75PT, 0},
+	{0, DC_87PT, 0},
+	{0, DC_DISABLE, 0},
+	{0, DC_RESV, CPUFREQ_TABLE_END},
+};
+EXPORT_SYMBOL_GPL(loongson3_clockmod_table);
+
+static struct clk cpu_clks[NR_CPUS];
+static char clk_names[NR_CPUS][10];
+
+struct clk *cpu_clk_get(int cpu)
+{
+	return &cpu_clks[cpu];
+}
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	int i;
+	struct clk *clk;
+
+	if (!id)
+		return NULL;
+
+	for_each_possible_cpu(i) {
+		clk = &cpu_clks[i];
+		if (strcmp(clk->name, id) == 0)
+			return clk;
+	}
+
+	return NULL;
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
+	if (!clk)
+		return 0;
+
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
+	int regval, ret = 0;
+	struct cpufreq_frequency_table *pos;
+	int cpu = clk - cpu_clks;
+	uint64_t core_id = cpu_data[cpu].core;
+	uint64_t package_id = cpu_data[cpu].package;
+
+	if (likely(clk->ops && clk->ops->set_rate)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&clock_lock, flags);
+		ret = clk->ops->set_rate(clk, rate, 0);
+		spin_unlock_irqrestore(&clock_lock, flags);
+	}
+
+	if (unlikely(clk->flags & CLK_RATE_PROPAGATES))
+		propagate_rate(clk);
+
+	cpufreq_for_each_valid_entry(pos, loongson3_clockmod_table)
+		if (rate == pos->frequency)
+			break;
+	if (rate != pos->frequency)
+		return -ENOTSUPP;
+
+	clk->rate = rate;
+
+	if ((read_c0_prid() & 0xf) == PRID_REV_LOONGSON3A_R1) {
+		regval = LOONGSON_CHIPCFG(package_id);
+		regval = (regval & ~0x7) | (pos->driver_data - 1);
+		LOONGSON_CHIPCFG(package_id) = regval;
+	} else {
+		regval = LOONGSON_FREQCTRL(package_id);
+		regval = (regval & ~(0x7 << (core_id*4))) |
+			((pos->driver_data - 1) << (core_id*4));
+		LOONGSON_FREQCTRL(package_id) = regval;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_rate);
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
+static int loongson3_clock_init(void)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		sprintf(clk_names[i], "cpu%d_clk", i);
+		cpu_clks[i].name = clk_names[i];
+		cpu_clks[i].flags = CLK_ALWAYS_ENABLED | CLK_RATE_PROPAGATES;
+		cpu_clks[i].rate = cpu_clock_freq / 1000;
+	}
+
+	/* clock table init */
+	for (i = 2;
+	     (loongson3_clockmod_table[i].frequency != CPUFREQ_TABLE_END);
+	     i++)
+		loongson3_clockmod_table[i].frequency = ((cpu_clock_freq / 1000) * i) / 8;
+
+	return 0;
+}
+arch_initcall(loongson3_clock_init);
+
+MODULE_AUTHOR("Huacai Chen <chenhc@lemote.com>");
+MODULE_DESCRIPTION("CPUFreq driver for Loongson 3A/3B");
+MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 4ebae43..7d79e5e 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -275,6 +275,7 @@ config BMIPS_CPUFREQ
 
 config LOONGSON2_CPUFREQ
 	tristate "Loongson2 CPUFreq Driver"
+	depends on CPU_LOONGSON2
 	help
 	  This option adds a CPUFreq driver for loongson processors which
 	  support software configurable cpu frequency.
@@ -285,8 +286,22 @@ config LOONGSON2_CPUFREQ
 
 	  If in doubt, say N.
 
+config LOONGSON3_CPUFREQ
+	tristate "Loongson3 CPUFreq Driver"
+	depends on CPU_LOONGSON3
+	help
+	  This option adds a CPUFreq driver for loongson processors which
+	  support software configurable cpu frequency.
+
+	  Loongson-3A and it's successors support this feature.
+
+	  For details, take a look at <file:Documentation/cpu-freq/>.
+
+	  If in doubt, say N.
+
 config LOONGSON1_CPUFREQ
 	tristate "Loongson1 CPUFreq Driver"
+	depends on CPU_LOONGSON1
 	help
 	  This option adds a CPUFreq driver for loongson1 processors which
 	  support software configurable cpu frequency.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index ab3a42c..9b09a25 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
 obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
 obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
+obj-$(CONFIG_LOONGSON3_CPUFREQ)		+= loongson3_cpufreq.o
 obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
 obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
 obj-$(CONFIG_SPARC_US2E_CPUFREQ)	+= sparc-us2e-cpufreq.o
diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
new file mode 100644
index 0000000..e71f3cd
--- /dev/null
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -0,0 +1,236 @@
+/*
+ * CPUFreq driver for the loongson-3 processors
+ *
+ * All revisions of Loongson-3 processor support this feature.
+ *
+ * Copyright (C) 2008 - 2014 Lemote Inc.
+ * Author: Yan Hua, yanh@lemote.com
+ *         Chen Huacai, chenhc@lemote.com
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/module.h>
+#include <linux/time.h>
+#include <linux/delay.h>
+#include <linux/cpufreq.h>
+#include <linux/platform_device.h>
+#include <asm/idle.h>
+#include <asm/clock.h>
+#include <asm/cevt-r4k.h>
+
+#include <loongson.h>
+
+static uint nowait = 1;
+static spinlock_t cpufreq_reg_lock[MAX_PACKAGES];
+
+static void (*saved_cpu_wait)(void);
+extern struct clk *cpu_clk_get(int cpu);
+
+static int loongson3_cpu_freq_notifier(struct notifier_block *nb,
+					unsigned long val, void *data);
+
+static struct notifier_block loongson3_cpufreq_notifier_block = {
+	.notifier_call = loongson3_cpu_freq_notifier
+};
+
+#ifdef CONFIG_SMP
+static int loongson3_cpu_freq_notifier(struct notifier_block *nb,
+					unsigned long val, void *data)
+{
+	struct cpufreq_freqs *freqs = (struct cpufreq_freqs *)data;
+	unsigned long cpu = freqs->cpu;
+	struct clock_event_device *cd = &per_cpu(mips_clockevent_device, cpu);
+
+	if (val == CPUFREQ_POSTCHANGE) {
+		if (cpu == smp_processor_id())
+			clockevents_update_freq(cd, freqs->new * 1000 / 2);
+		else {
+			clockevents_calc_mult_shift(cd, freqs->new * 1000 / 2, 4);
+			cd->min_delta_ns = clockevent_delta2ns(cd->min_delta_ticks, cd);
+			cd->max_delta_ns = clockevent_delta2ns(cd->max_delta_ticks, cd);
+		}
+		cpu_data[cpu].udelay_val =
+			cpufreq_scale(loops_per_jiffy, cpu_clock_freq / 1000, freqs->new);
+	}
+
+	return 0;
+}
+#else
+static int loongson3_cpu_freq_notifier(struct notifier_block *nb,
+					unsigned long val, void *data)
+{
+	struct cpufreq_freqs *freqs = (struct cpufreq_freqs *)data;
+	struct clock_event_device *cd = &per_cpu(mips_clockevent_device, 0);
+
+	if (val == CPUFREQ_POSTCHANGE) {
+		clockevents_update_freq(cd, freqs->new * 1000 / 2);
+		current_cpu_data.udelay_val = loops_per_jiffy;
+	}
+
+	return 0;
+}
+#endif
+
+static unsigned int loongson3_cpufreq_get(unsigned int cpu)
+{
+	return clk_get_rate(cpu_clk_get(cpu));
+}
+
+/*
+ * Here we notify other drivers of the proposed change and the final change.
+ */
+static int loongson3_cpufreq_target(struct cpufreq_policy *policy,
+				     unsigned int index)
+{
+	unsigned int freq;
+	unsigned int cpu = policy->cpu;
+	unsigned int package = cpu_data[cpu].package;
+
+	if (!cpu_online(cpu))
+		return -ENODEV;
+
+	freq =
+	    ((cpu_clock_freq / 1000) *
+	     loongson3_clockmod_table[index].driver_data) / 8;
+
+	/* setting the cpu frequency */
+	spin_lock(&cpufreq_reg_lock[package]);
+	clk_set_rate(policy->clk, freq);
+	spin_unlock(&cpufreq_reg_lock[package]);
+
+	return 0;
+}
+
+static int loongson3_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	if (!cpu_online(policy->cpu))
+		return -ENODEV;
+
+	policy->clk = cpu_clk_get(policy->cpu);
+	policy->cur = loongson3_cpufreq_get(policy->cpu);
+
+	policy->cpuinfo.transition_latency = 1000;
+
+	/* Loongson-3A R1: all cores in a package share one clock */
+	if ((read_c0_prid() & 0xf) == PRID_REV_LOONGSON3A_R1)
+		cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
+
+	return cpufreq_table_validate_and_show(policy,
+			&loongson3_clockmod_table[0]);
+}
+
+static int loongson3_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+
+static struct cpufreq_driver loongson3_cpufreq_driver = {
+	.name = "loongson3",
+	.init = loongson3_cpufreq_cpu_init,
+	.verify = cpufreq_generic_frequency_table_verify,
+	.target_index = loongson3_cpufreq_target,
+	.get = loongson3_cpufreq_get,
+	.exit = loongson3_cpufreq_exit,
+	.attr = cpufreq_generic_attr,
+};
+
+static struct platform_device_id platform_device_ids[] = {
+	{
+		.name = "loongson3_cpufreq",
+	},
+	{}
+};
+
+MODULE_DEVICE_TABLE(platform, platform_device_ids);
+
+static struct platform_driver platform_driver = {
+	.driver = {
+		.name = "loongson3_cpufreq",
+		.owner = THIS_MODULE,
+	},
+	.id_table = platform_device_ids,
+};
+
+/*
+ * This is the simple version of Loongson-3 wait, Maybe we need do this in
+ * interrupt disabled content
+ */
+
+void loongson3_cpu_wait(void)
+{
+	u32 cpu_freq, shared_cpus = 0;
+	int i, cpu = smp_processor_id();
+	uint64_t core_id = cpu_data[cpu].core;
+	uint64_t package_id = cpu_data[cpu].package;
+
+	for_each_online_cpu(i)
+		if (cpu_data[i].package == package_id)
+			shared_cpus++;
+
+	if (shared_cpus > 1)
+		goto out;
+
+	if ((read_c0_prid() & 0xf) == PRID_REV_LOONGSON3A_R1) {
+		cpu_freq = LOONGSON_CHIPCFG(package_id);
+		LOONGSON_CHIPCFG(package_id) &= ~0x7;    /* Put CPU into wait mode */
+		LOONGSON_CHIPCFG(package_id) = cpu_freq; /* Restore CPU state */
+	} else {
+		cpu_freq = LOONGSON_FREQCTRL(package_id);
+		LOONGSON_FREQCTRL(package_id) &= ~(0x7 << (core_id*4)); /* Put CPU into wait mode */
+		LOONGSON_FREQCTRL(package_id) = cpu_freq;               /* Restore CPU state */
+	}
+
+out:
+	local_irq_enable();
+}
+EXPORT_SYMBOL_GPL(loongson3_cpu_wait);
+
+static int __init cpufreq_init(void)
+{
+	int i, ret;
+
+	/* Register platform stuff */
+	ret = platform_driver_register(&platform_driver);
+	if (ret)
+		return ret;
+
+	pr_info("cpufreq: Loongson-3 CPU frequency driver.\n");
+
+	for (i = 0; i < MAX_PACKAGES; i++)
+		spin_lock_init(&cpufreq_reg_lock[i]);
+
+	cpufreq_register_notifier(&loongson3_cpufreq_notifier_block,
+				  CPUFREQ_TRANSITION_NOTIFIER);
+
+	ret = cpufreq_register_driver(&loongson3_cpufreq_driver);
+
+	if (!ret && !nowait) {
+		saved_cpu_wait = cpu_wait;
+		cpu_wait = loongson3_cpu_wait;
+	}
+
+	return ret;
+}
+
+static void __exit cpufreq_exit(void)
+{
+	if (!nowait && saved_cpu_wait)
+		cpu_wait = saved_cpu_wait;
+	cpufreq_unregister_driver(&loongson3_cpufreq_driver);
+	cpufreq_unregister_notifier(&loongson3_cpufreq_notifier_block,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+
+	platform_driver_unregister(&platform_driver);
+}
+
+module_init(cpufreq_init);
+module_exit(cpufreq_exit);
+
+module_param(nowait, uint, 0644);
+MODULE_PARM_DESC(nowait, "Disable Loongson-3A/3B specific wait");
+
+MODULE_AUTHOR("Huacai Chen <chenhc@lemote.com>");
+MODULE_DESCRIPTION("CPUFreq driver for Loongson-3A/3B");
+MODULE_LICENSE("GPL");
-- 
2.7.0
