Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 11:22:14 +0200 (CEST)
Received: from mail-pd0-f179.google.com ([209.85.192.179]:64413 "EHLO
        mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822318Ab3IYJR1fqoQP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Sep 2013 11:17:27 +0200
Received: by mail-pd0-f179.google.com with SMTP id v10so5794542pde.24
        for <multiple recipients>; Wed, 25 Sep 2013 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kC+Skh0C2s3Txa+xzcPBJlHriI3KnoXAXL32ygx5k1U=;
        b=oatdfEkf7WWxFrroCOvMYP4o4SDHXUgVuO4BZljGRAMwqSR5WYEiIU8JZ2GPy+kEKm
         LEfWfCs8B5FFRi+BN2W72m0++bpaYf9IjHfMwy0KFHt/m/OMqbIxJ1H4UdxNQTsf4/ko
         E5lCOmVHzcIvwq6vBKURe7do14BzRhA6s3mHRKxyXrRrLjjLPq1cOVFn/7Q0ZIYccxKv
         X5Jq+/fT/uKSMR7L3nlHWnnCgBaKL8U3HlpmUcqJDQD66dCo7SX6GzAyAKAT9Mo7/vjA
         6JBxTsvNc9GOErTNEWcu+mFPtqvqZQBl3HojGtpvywpMXvbM+f0UhDqwBwm1d4kH8V4a
         cf0Q==
X-Received: by 10.66.162.136 with SMTP id ya8mr32735332pab.110.1380100641240;
        Wed, 25 Sep 2013 02:17:21 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id ef10sm51851181pac.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 02:17:20 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V12 11/12] MIPS: Loongson 3: Add CPU hotplug support
Date:   Wed, 25 Sep 2013 17:15:45 +0800
Message-Id: <1380100546-8302-12-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1380100546-8302-1-git-send-email-chenhc@lemote.com>
References: <1380100546-8302-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37967
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

Tips of Loongson's CPU hotplug:
1, To fully shutdown a core in Loongson 3, the target core should go to
   CKSEG1 and flush all L1 cache entries at first. Then, another core
   (usually Core 0) can safely disable the clock of the target core. So
   play_dead() call loongson3_play_dead() via CKSEG1 (both uncached and
   unmmaped).
2, The default clocksource of Loongson is MIPS. Since clock source is a
   global device, timekeeping need the CP0' Count registers of each core
   be synchronous. Thus, when a core is up, we use a SMP_ASK_C0COUNT IPI
   to ask Core-0's Count.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/Kconfig                              |    1 +
 arch/mips/include/asm/mach-loongson/loongson.h |    6 +-
 arch/mips/include/asm/smp.h                    |    1 +
 arch/mips/loongson/loongson-3/irq.c            |   10 ++
 arch/mips/loongson/loongson-3/smp.c            |  168 +++++++++++++++++++++++-
 5 files changed, 181 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index db89d44..8f86203 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -273,6 +273,7 @@ config LASAT
 config MACH_LOONGSON
 	bool "Loongson family of machines"
 	select SYS_SUPPORTS_ZBOOT
+	select SYS_SUPPORTS_HOTPLUG_CPU
 	help
 	  This enables the support of Loongson family of machines.
 
diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 40b4892..d4bae71 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -247,6 +247,9 @@ static inline void do_perfcnt_IRQ(void)
 #define LOONGSON_PXARB_CFG		LOONGSON_REG(LOONGSON_REGBASE + 0x68)
 #define LOONGSON_PXARB_STATUS		LOONGSON_REG(LOONGSON_REGBASE + 0x6c)
 
+/* Chip Config */
+#define LOONGSON_CHIPCFG0		LOONGSON_REG(LOONGSON_REGBASE + 0x80)
+
 /* pcimap */
 
 #define LOONGSON_PCIMAP_PCIMAP_LO0	0x0000003f
@@ -262,9 +265,6 @@ static inline void do_perfcnt_IRQ(void)
 #ifdef CONFIG_CPU_SUPPORTS_CPUFREQ
 #include <linux/cpufreq.h>
 extern struct cpufreq_frequency_table loongson2_clockmod_table[];
-
-/* Chip Config */
-#define LOONGSON_CHIPCFG0		LOONGSON_REG(LOONGSON_REGBASE + 0x80)
 #endif
 
 /*
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index eb60087..efa02ac 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -42,6 +42,7 @@ extern int __cpu_logical_map[NR_CPUS];
 #define SMP_ICACHE_FLUSH	0x4
 /* Used by kexec crashdump to save all cpu's state */
 #define SMP_DUMP		0x8
+#define SMP_ASK_C0COUNT		0x10
 
 extern volatile cpumask_t cpu_callin_map;
 
diff --git a/arch/mips/loongson/loongson-3/irq.c b/arch/mips/loongson/loongson-3/irq.c
index 27aef31..83f84e6 100644
--- a/arch/mips/loongson/loongson-3/irq.c
+++ b/arch/mips/loongson/loongson-3/irq.c
@@ -85,3 +85,13 @@ void __init mach_init_irq(void)
 
 	set_c0_status(STATUSF_IP2 | STATUSF_IP6);
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+void fixup_irqs(void)
+{
+	irq_cpu_offline();
+	clear_c0_status(ST0_IM);
+}
+
+#endif
diff --git a/arch/mips/loongson/loongson-3/smp.c b/arch/mips/loongson/loongson-3/smp.c
index 3c52565..9838a51 100644
--- a/arch/mips/loongson/loongson-3/smp.c
+++ b/arch/mips/loongson/loongson-3/smp.c
@@ -30,6 +30,9 @@
 
 #include "smp.h"
 
+DEFINE_PER_CPU(int, cpu_state);
+DEFINE_PER_CPU(uint32_t, core0_c0count);
+
 /* read a 64bit value from ipi register */
 uint64_t loongson3_ipi_read64(void * addr)
 {
@@ -169,8 +172,8 @@ static void loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int act
 
 void loongson3_ipi_interrupt(struct pt_regs *regs)
 {
-	int cpu = smp_processor_id();
-	unsigned int action;
+	int i, cpu = smp_processor_id();
+	unsigned int action, c0count;
 
 	/* Load the ipi register to figure out what we're supposed to do */
 	action = loongson3_ipi_read32(ipi_status0_regs[cpu]);
@@ -185,14 +188,24 @@ void loongson3_ipi_interrupt(struct pt_regs *regs)
 	if (action & SMP_CALL_FUNCTION) {
 		smp_call_function_interrupt();
 	}
+
+	if (action & SMP_ASK_C0COUNT) {
+		BUG_ON(cpu != 0);
+		c0count = read_c0_count();
+		for (i=1; i < nr_cpus_loongson; i++)
+			per_cpu(core0_c0count, i) = c0count;
+	}
 }
 
+#define MAX_LOOPS 1200
 /*
  * SMP init and finish on secondary CPUs
  */
 void loongson3_init_secondary(void)
 {
 	int i;
+	uint32_t initcount;
+	unsigned int cpu = smp_processor_id();
 	unsigned int imask = STATUSF_IP7 | STATUSF_IP6 |
 			     STATUSF_IP3 | STATUSF_IP2;
 
@@ -202,6 +215,19 @@ void loongson3_init_secondary(void)
 	for (i = 0; i < nr_cpus_loongson; i++) {
 		loongson3_ipi_write32(0xffffffff, ipi_en0_regs[i]);
 	}
+
+	per_cpu(cpu_state, cpu) = CPU_ONLINE;
+
+	i = 0;
+	__get_cpu_var(core0_c0count) = 0;
+	loongson3_send_ipi_single(0, SMP_ASK_C0COUNT);
+	while (!__get_cpu_var(core0_c0count))
+		i++;
+
+	if (i > MAX_LOOPS)
+		i = MAX_LOOPS;
+	initcount = __get_cpu_var(core0_c0count) + i;
+	write_c0_count(initcount);
 }
 
 void loongson3_smp_finish(void)
@@ -235,6 +261,8 @@ void __init loongson3_smp_setup(void)
 
 void __init loongson3_prepare_cpus(unsigned int max_cpus)
 {
+	init_cpu_present(cpu_possible_mask);
+	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
 }
 
 /*
@@ -268,6 +296,138 @@ void __init loongson3_cpus_done(void)
 {
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+
+extern void fixup_irqs(void);
+extern void (*flush_cache_all)(void);
+
+static int loongson3_cpu_disable(void)
+{
+	unsigned long flags;
+	unsigned int cpu = smp_processor_id();
+
+	if (cpu == 0)
+		return -EBUSY;
+
+	set_cpu_online(cpu, false);
+	cpu_clear(cpu, cpu_callin_map);
+	local_irq_save(flags);
+	fixup_irqs();
+	local_irq_restore(flags);
+	flush_cache_all();
+	local_flush_tlb_all();
+
+	return 0;
+}
+
+
+static void loongson3_cpu_die(unsigned int cpu)
+{
+	while (per_cpu(cpu_state, cpu) != CPU_DEAD)
+		cpu_relax();
+
+	mb();
+}
+
+/* To shutdown a core in Loongson 3, the target core should go to CKSEG1 and
+ * flush all L1 entries at first. Then, another core (usually Core 0) can
+ * safely disable the clock of the target core. loongson3_play_dead() is
+ * called via CKSEG1 (uncached and unmmaped) */
+void loongson3_play_dead(int *state_addr)
+{
+	__asm__ __volatile__(
+		"      .set push                         \n"
+		"      .set noreorder                    \n"
+		"      li $t0, 0x80000000                \n" /* KSEG0 */
+		"      li $t1, 512                       \n" /* num of L1 entries */
+		"1:    cache 0, 0($t0)                   \n" /* flush L1 ICache */
+		"      cache 0, 1($t0)                   \n"
+		"      cache 0, 2($t0)                   \n"
+		"      cache 0, 3($t0)                   \n"
+		"      cache 1, 0($t0)                   \n" /* flush L1 DCache */
+		"      cache 1, 1($t0)                   \n"
+		"      cache 1, 2($t0)                   \n"
+		"      cache 1, 3($t0)                   \n"
+		"      addiu $t0, $t0, 0x20              \n"
+		"      bnez  $t1, 1b                     \n"
+		"      addiu $t1, $t1, -1                \n"
+		"      li    $t0, 0x7                    \n" /* *state_addr = CPU_DEAD; */
+		"      sw    $t0, 0($a0)                 \n"
+		"      sync                              \n"
+		"      cache 21, 0($a0)                  \n" /* flush entry of *state_addr */
+		"      .set pop                          \n");
+
+	__asm__ __volatile__(
+		"      .set push                         \n"
+		"      .set noreorder                    \n"
+		"      .set mips64                       \n"
+		"      mfc0  $t2, $15, 1                 \n"
+		"      andi  $t2, 0x3ff                  \n"
+		"      dli   $t0, 0x900000003ff01000     \n"
+		"      andi  $t3, $t2, 0x3               \n"
+		"      sll   $t3, 8                      \n"  /* get cpu id */
+		"      or    $t0, $t0, $t3               \n"
+		"      andi  $t1, $t2, 0xc               \n"
+		"      dsll  $t1, 42                     \n"  /* get node id */
+		"      or    $t0, $t0, $t1               \n"
+		"1:    li    $a0, 0x100                  \n"  /* wait for init loop */
+		"2:    bnez  $a0, 2b                     \n"  /* idle loop */
+		"      addiu $a0, -1                     \n"
+		"      lw    $v0, 0x20($t0)              \n"  /* get PC via mailbox */
+		"      beqz  $v0, 1b                     \n"
+		"      nop                               \n"
+		"      ld    $sp, 0x28($t0)              \n"  /* get SP via mailbox */
+		"      ld    $gp, 0x30($t0)              \n"  /* get GP via mailbox */
+		"      ld    $a1, 0x38($t0)              \n"
+		"      jr  $v0                           \n"  /* jump to initial PC */
+		"      nop                               \n"
+		"      .set pop                          \n");
+}
+
+void play_dead(void)
+{
+	int *state_addr;
+	unsigned int cpu = smp_processor_id();
+	void (*play_dead_at_ckseg1)(int *);
+
+	idle_task_exit();
+	play_dead_at_ckseg1 = (void *)CKSEG1ADDR((unsigned long)loongson3_play_dead);
+	state_addr = &per_cpu(cpu_state, cpu);
+	mb();
+	play_dead_at_ckseg1(state_addr);
+}
+
+#define CPU_POST_DEAD_FROZEN	(CPU_POST_DEAD | CPU_TASKS_FROZEN)
+static int loongson3_cpu_callback(struct notifier_block *nfb,
+	unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+
+	switch (action) {
+	case CPU_POST_DEAD:
+	case CPU_POST_DEAD_FROZEN:
+		printk(KERN_INFO "Disable clock for CPU#%d\n", cpu);
+		LOONGSON_CHIPCFG0 &= ~(1 << (12 + cpu));
+		break;
+	case CPU_UP_PREPARE:
+	case CPU_UP_PREPARE_FROZEN:
+		printk(KERN_INFO "Enable clock for CPU#%d\n", cpu);
+		LOONGSON_CHIPCFG0 |= 1 << (12 + cpu);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int register_loongson3_notifier(void)
+{
+	hotcpu_notifier(loongson3_cpu_callback, 0);
+	return 0;
+}
+early_initcall(register_loongson3_notifier);
+
+#endif
+
 struct plat_smp_ops loongson3_smp_ops = {
 	.send_ipi_single = loongson3_send_ipi_single,
 	.send_ipi_mask = loongson3_send_ipi_mask,
@@ -277,4 +437,8 @@ struct plat_smp_ops loongson3_smp_ops = {
 	.boot_secondary = loongson3_boot_secondary,
 	.smp_setup = loongson3_smp_setup,
 	.prepare_cpus = loongson3_prepare_cpus,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable = loongson3_cpu_disable,
+	.cpu_die = loongson3_cpu_die,
+#endif
 };
-- 
1.7.7.3
