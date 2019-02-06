Return-Path: <SRS0=AiVX=QN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAE7C169C4
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 12:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E682175B
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 12:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSPcuRu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfBFMCg (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:02:36 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39552 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730135AbfBFMCg (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 6 Feb 2019 07:02:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so2979851pld.6
        for <linux-mips@vger.kernel.org>; Wed, 06 Feb 2019 04:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=fqUg2jgOjoWPvJr/w38uyf8w7ifDT+469NhTpycxlsg=;
        b=dSPcuRu+N/y5b8fC3f+VDpKhA7oJL+lN/J3Fm2E0j0kBF0GBrLt4wZjf6N4QwTukE4
         udQxUQmAcsTHKLKLZ+Imd8o2HJ9RHxdRmEfDCFLyUqNXYpyI1rP3Gi4NhbmaeG5mYNiw
         hMfD8TjButr0XkM+itKJ7lqsv3s1kZ9evBuXae88z1xcy/XYi7DFvNrPBE95q9fVHYJy
         Oxw9wsGlUbPZc6F6HNAzEDevo76sc8BTbJgeYgjwZNF0/B9ZWNg+jz0nAkZf0O+WDyqR
         FyVkUS4aiazhZxZ9rb/8sasvmksVOAMs1io2x7ucC22zamAXZYWPkFgePih6O8CKAasD
         +bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=fqUg2jgOjoWPvJr/w38uyf8w7ifDT+469NhTpycxlsg=;
        b=HTetrmXLW+AFnYC8XInqpIjzh5F3vCb2+fv2kLK16WGneqIlsEKkIW87PKK7jmaGGU
         5BUFskXgKMgH3aOr40GcDqfnale0Csyly4ziRzIrYLDmq404apsMUwC2nGsMi0dbOSPv
         dRRa0mR6YLUU7XFxC18Y5Cel9jVvkSP3GOA8JipQv1dpxcP677A3pBf4i5iA5zW2oabu
         g+6VDOMfG+fzeL8BAaeCoP/8PxgxzrjfbtRagv4zL6oO1A5S8cbjDXRVWC2eQHMU16r6
         ZCguG4RldbCJhXYLzXOyUAal5oGKVEOKK+LHIh/2OPhNv14ZZ5hUwNsYXTp49RiKKlI0
         lgaw==
X-Gm-Message-State: AHQUAubr/Hgcd6ZaDNO5ZnEwPVlvhwhb2ZDzrisn8M7PNeKDVhvQ/Hce
        GVW2j/0TYrUFtAknQg0OhvQ=
X-Google-Smtp-Source: AHgI3IZ15aM3Lt8F/8mWzQA3ZsL29BgybcTT19RdCAXdjq30PtCbD+5bsqJV6JG/oV2GBjGXa9YnpA==
X-Received: by 2002:a17:902:449:: with SMTP id 67mr1669269ple.310.1549454554920;
        Wed, 06 Feb 2019 04:02:34 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id s190sm9434059pfb.103.2019.02.06.04.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 04:02:34 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-mips@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: Loongson: Make CPUFreq usable for Loongson-3
Date:   Wed,  6 Feb 2019 20:02:31 +0800
Message-Id: <1549454551-9009-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Loongson-3A/3B support frequency scaling. But due to hardware
limitation, Loongson-3A R1's frequency scaling is not independent for
each core, we suggest enable Loongson-3A's CPUFreq only when there is
one core online. Loongson-3B and newer processors can adjust frequency
independently for each core, so it can be always enabled.

Each package has only one register (ChipConfig or FreqCtrl) to control
frequency, so we need spinlocks to protect register access for multi-
cores.

arch/mips/kernel/smp.c is modified to guarantee udelay_val has the
correct value while both CPU hotplug and CPUFreq are enabled.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson64/loongson.h |   1 +
 arch/mips/kernel/smp.c                           |   3 +-
 arch/mips/loongson64/Kconfig                     |   1 +
 arch/mips/loongson64/common/platform.c           |  13 +-
 arch/mips/loongson64/loongson-3/Makefile         |   2 +-
 arch/mips/loongson64/loongson-3/clock.c          | 191 +++++++++++++++++++++++
 drivers/cpufreq/Kconfig                          |  13 ++
 drivers/cpufreq/Makefile                         |   1 +
 drivers/cpufreq/loongson3_cpufreq.c              | 190 ++++++++++++++++++++++
 9 files changed, 410 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/loongson64/loongson-3/clock.c
 create mode 100644 drivers/cpufreq/loongson3_cpufreq.c

diff --git a/arch/mips/include/asm/mach-loongson64/loongson.h b/arch/mips/include/asm/mach-loongson64/loongson.h
index b6870fe..0623cc8 100644
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
index 6fd9e94..f49a2d7 100644
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
index 4c14a11..81d8382 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -74,6 +74,7 @@ config LOONGSON_MACH3X
 	select CSRC_R4K
 	select CEVT_R4K
 	select CPU_HAS_WB
+	select HAVE_CLK
 	select FORCE_PCI
 	select ISA
 	select I8259
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
index b5a0c2f..0c63713 100644
--- a/arch/mips/loongson64/loongson-3/Makefile
+++ b/arch/mips/loongson64/loongson-3/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for Loongson-3 family machines
 #
-obj-y			+= irq.o cop2-ex.o platform.o acpi_init.o dma.o
+obj-y			+= irq.o cop2-ex.o platform.o acpi_init.o dma.o clock.o
 
 obj-$(CONFIG_SMP)	+= smp.o
 
diff --git a/arch/mips/loongson64/loongson-3/clock.c b/arch/mips/loongson64/loongson-3/clock.c
new file mode 100644
index 0000000..df21a5b
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
+	DC_ZERO, DC_12PT, DC_25PT, DC_37PT, DC_50PT, DC_62PT,
+	DC_75PT, DC_87PT, DC_DISABLE, DC_RESV
+};
+
+struct cpufreq_frequency_table loongson3_clockmod_table[] = {
+	{0, DC_ZERO, CPUFREQ_ENTRY_INVALID},
+	{0, DC_12PT, 0},
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
+	uint64_t core_id = cpu_core(&cpu_data[cpu]);
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
+	for (i = 1;
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
index 608af20..88ac6be 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -276,6 +276,19 @@ config LOONGSON2_CPUFREQ
 
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
 	depends on LOONGSON1_LS1B
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 08c071b..9cb0429 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
 obj-$(CONFIG_BMIPS_CPUFREQ)		+= bmips-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
 obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
+obj-$(CONFIG_LOONGSON3_CPUFREQ)		+= loongson3_cpufreq.o
 obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
 obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
 obj-$(CONFIG_SPARC_US2E_CPUFREQ)	+= sparc-us2e-cpufreq.o
diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
new file mode 100644
index 0000000..f76591a
--- /dev/null
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -0,0 +1,190 @@
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
+static spinlock_t cpufreq_reg_lock[MAX_PACKAGES];
+
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
+	policy->freq_table = loongson3_clockmod_table;
+
+	/* Loongson-3A R1: all cores in a package share one clock */
+	if ((read_c0_prid() & 0xf) == PRID_REV_LOONGSON3A_R1)
+		cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
+
+	return 0;
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
+	return ret;
+}
+
+static void __exit cpufreq_exit(void)
+{
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
+MODULE_AUTHOR("Huacai Chen <chenhc@lemote.com>");
+MODULE_DESCRIPTION("CPUFreq driver for Loongson-3A/3B");
+MODULE_LICENSE("GPL");
-- 
2.7.0

