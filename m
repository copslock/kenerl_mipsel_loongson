Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Sep 2014 10:04:03 +0200 (CEST)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:52525 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006537AbaIMIDTrQiNy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Sep 2014 10:03:19 +0200
Received: by mail-pd0-f173.google.com with SMTP id ft15so2782807pdb.18
        for <multiple recipients>; Sat, 13 Sep 2014 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=wRooiwMiU+zXmW5BaAWZax6E0fyuEx/39L2jqm2PsA8=;
        b=raGfXfy1J17GUJ3mqbbM39s4FM7Oh2kHfV2LbsMVKTa+b4x1F1ZiHANuMIds/r8o5L
         orYSQAv+mCkyBxuDADudJu4tHWCAMUT+fJ5LQxt7kQCwVJyGFXuWPKnnqrAEo9dTw5LK
         pDoOwWqrqgn5ze2R/kCw/wyZBB09N39H6snDr0IvHze3qFC8JlmQaLK6ntH5qgSAQXR5
         r0yZsTr7FO8s+QGMudV1UYuo/l1GZC5Fx+/RHTVT7ZMjKIZnzneYcx+5+rgCz8iwXZ/V
         qMDXwqywY8T7oGd8ZP/wxHUVAJxcLrQ7DlnYi4Qe+QjeL7EYjRurHPKR+6J+UAcvosRh
         bQGg==
X-Received: by 10.66.225.141 with SMTP id rk13mr19489138pac.112.1410595393530;
        Sat, 13 Sep 2014 01:03:13 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id v3sm5888617pbs.4.2014.09.13.01.03.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 13 Sep 2014 01:03:13 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>
Subject: [PATCH 11/11] MIPS: Loongson: Make CPUFreq usable for Loongson-3
Date:   Sat, 13 Sep 2014 16:03:00 +0800
Message-Id: <1410595380-11217-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42539
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
Signed-off-by: Hongliang Tao <taohl@lemote.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    1 +
 arch/mips/kernel/smp.c                         |    3 +-
 arch/mips/loongson/Kconfig                     |    1 +
 arch/mips/loongson/common/platform.c           |   13 +-
 arch/mips/loongson/loongson-3/Makefile         |    2 +-
 arch/mips/loongson/loongson-3/clock.c          |  191 +++++++++++++++++++
 drivers/cpufreq/Kconfig                        |   14 ++
 drivers/cpufreq/Makefile                       |    1 +
 drivers/cpufreq/loongson3_cpufreq.c            |  240 ++++++++++++++++++++++++
 9 files changed, 461 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/loongson/loongson-3/clock.c
 create mode 100644 drivers/cpufreq/loongson3_cpufreq.c

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 9783103..ee18a50 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -278,6 +278,7 @@ extern u64 loongson_freqctrl[MAX_PACKAGES];
 #ifdef CONFIG_CPU_SUPPORTS_CPUFREQ
 #include <linux/cpufreq.h>
 extern struct cpufreq_frequency_table loongson2_clockmod_table[];
+extern struct cpufreq_frequency_table loongson3_clockmod_table[];
 #endif
 
 /*
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index c94c4e9..01d676a 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -136,7 +136,8 @@ asmlinkage void start_secondary(void)
 	calibrate_delay();
 	preempt_disable();
 	cpu = smp_processor_id();
-	cpu_data[cpu].udelay_val = loops_per_jiffy;
+	if (!cpu_data[cpu].udelay_val)
+		cpu_data[cpu].udelay_val = loops_per_jiffy;
 
 	cpu_set(cpu, cpu_coherent_mask);
 	notify_cpu_starting(cpu);
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 156de85..58a926a 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -69,6 +69,7 @@ config LOONGSON_MACH3X
 	select CSRC_R4K
 	select CEVT_R4K
 	select CPU_HAS_WB
+	select HAVE_CLK
 	select HW_HAS_PCI
 	select ISA
 	select HT_PCI
diff --git a/arch/mips/loongson/common/platform.c b/arch/mips/loongson/common/platform.c
index 0ed3832..7dd5ed4 100644
--- a/arch/mips/loongson/common/platform.c
+++ b/arch/mips/loongson/common/platform.c
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
+	if ((c->processor_id & PRID_REV_MASK) >= PRID_REV_LOONGSON3A)
+		return platform_device_register(&loongson3_cpufreq_device);
 
 	return -ENODEV;
 }
 
-arch_initcall(loongson2_cpufreq_init);
+arch_initcall(loongson_cpufreq_init);
diff --git a/arch/mips/loongson/loongson-3/Makefile b/arch/mips/loongson/loongson-3/Makefile
index 622fead..1be6a0c 100644
--- a/arch/mips/loongson/loongson-3/Makefile
+++ b/arch/mips/loongson/loongson-3/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for Loongson-3 family machines
 #
-obj-y			+= irq.o cop2-ex.o platform.o
+obj-y			+= irq.o cop2-ex.o platform.o clock.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 
diff --git a/arch/mips/loongson/loongson-3/clock.c b/arch/mips/loongson/loongson-3/clock.c
new file mode 100644
index 0000000..13dc471
--- /dev/null
+++ b/arch/mips/loongson/loongson-3/clock.c
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
+	if (loongson_sysconf.cputype == Loongson_3A) {
+		regval = LOONGSON_CHIPCFG(package_id);
+		regval = (regval & ~0x7) | (pos->driver_data - 1);
+		LOONGSON_CHIPCFG(package_id) = regval;
+	} else if (loongson_sysconf.cputype == Loongson_3B) {
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
index ffe350f..e292e29 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -240,6 +240,7 @@ depends on MIPS
 
 config LOONGSON2_CPUFREQ
 	tristate "Loongson2 CPUFreq Driver"
+	depends on CPU_LOONGSON2
 	help
 	  This option adds a CPUFreq driver for loongson processors which
 	  support software configurable cpu frequency.
@@ -250,6 +251,19 @@ config LOONGSON2_CPUFREQ
 
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
 endmenu
 
 menu "PowerPC CPU frequency scaling drivers"
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index db6d9a2..186e815 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
 obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
 obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
+obj-$(CONFIG_LOONGSON3_CPUFREQ)		+= loongson3_cpufreq.o
 obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
 obj-$(CONFIG_SPARC_US2E_CPUFREQ)	+= sparc-us2e-cpufreq.o
 obj-$(CONFIG_SPARC_US3_CPUFREQ)		+= sparc-us3-cpufreq.o
diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
new file mode 100644
index 0000000..3345002
--- /dev/null
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -0,0 +1,240 @@
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
+static uint nowait;
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
+static void set_shared_udelay_val(int cpu, unsigned long lpj)
+{
+	int i;
+	cpumask_t *mask;
+
+	if (loongson_sysconf.cputype != Loongson_3A)
+		cpu_data[cpu].udelay_val = lpj;
+	else {
+		mask = topology_core_cpumask(cpu);
+		for_each_cpu(i, mask)
+			cpu_data[i].udelay_val = lpj;
+	}
+}
+
+static int loongson3_cpu_freq_notifier(struct notifier_block *nb,
+					unsigned long val, void *data)
+{
+	struct cpufreq_freqs *freqs = (struct cpufreq_freqs *)data;
+	unsigned long lpj, cpu = freqs->cpu;
+	struct clock_event_device *cd = &per_cpu(mips_clockevent_device, cpu);
+
+	if (val == CPUFREQ_POSTCHANGE) {
+		lpj = cpufreq_scale(loops_per_jiffy,
+				cpu_clock_freq / 1000, freqs->new);
+		set_shared_udelay_val(cpu, lpj);
+		clockevent_set_clock(cd, freqs->new * 1000 / 2);
+	}
+
+	return 0;
+}
+#else
+static int loongson3_cpu_freq_notifier(struct notifier_block *nb,
+					unsigned long val, void *data)
+{
+	if (val == CPUFREQ_POSTCHANGE)
+		current_cpu_data.udelay_val = loops_per_jiffy;
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
+	/* Loongson-3A: all cores in a package share one clock */
+	if (loongson_sysconf.cputype == Loongson_3A)
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
+	if (loongson_sysconf.cputype == Loongson_3A) {
+		cpu_freq = LOONGSON_CHIPCFG(package_id);
+		LOONGSON_CHIPCFG(package_id) &= ~0x7;    /* Put CPU into wait mode */
+		LOONGSON_CHIPCFG(package_id) = cpu_freq; /* Restore CPU state */
+	} else if (loongson_sysconf.cputype == Loongson_3B) {
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
1.7.7.3
