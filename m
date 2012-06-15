Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 10:16:53 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:53092 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903394Ab2FOINv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 10:13:51 +0200
Received: by mail-pz0-f49.google.com with SMTP id m1so3729829dad.36
        for <multiple recipients>; Fri, 15 Jun 2012 01:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/LCQ2qc6XVk9kFBLR3whYazGPQW+fKqsvxbyXxmaFo4=;
        b=WJRCPsp32gm/TAgCn9lxBT09epZzuzGaZrWjV9x6Nx7Wyk4vseQahF9jW+Put5JpJC
         Mxijl7Aca1MNwYaIRZ4OhtVJUgyS6En1GwksMtLiyIcmXrEq9OD8kRrx7ClVUHWYtKHR
         TyMjFSIcp1F0AH5wVNuypuGg/g7M4QXCWy9tT/slWp4PTS5G6eU+q8Fv19CdVocpYrwe
         6NIRBBSHA34RVZLjk25wUZ3T/JdTw+RefvXHzU6sHV9DPW4JoVKNjQk2OBygtgcMJyHB
         l7NuaB/zt3+aAk7jOIdZjb+/zU0k+oIP6ICXpsgDxC+SG/mbKj93F4PA1aM+kAQNwnZz
         SZbQ==
Received: by 10.68.200.102 with SMTP id jr6mr17426185pbc.0.1339748030541;
        Fri, 15 Jun 2012 01:13:50 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id nh8sm12437247pbc.60.2012.06.15.01.13.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 01:13:49 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH 13/14] MIPS: Loongson 3: Add CPU Hotplug support.
Date:   Fri, 15 Jun 2012 16:10:00 +0800
Message-Id: <1339747801-28691-14-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Tips of Loongson's CPU Hotplug:
1, To fully shutdown a core in Loongson 3, the target core should go to
   CKSEG1 and flush all L2 cache entries at first. Then, another core
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
 arch/mips/kernel/process.c                     |    4 +-
 arch/mips/loongson/loongson-3/irq.c            |   10 ++
 arch/mips/loongson/loongson-3/smp.c            |  181 +++++++++++++++++++++++-
 6 files changed, 194 insertions(+), 9 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index da2b1e5..72a0bf1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -256,6 +256,7 @@ config LASAT
 config MACH_LOONGSON
 	bool "Loongson family of machines"
 	select SYS_SUPPORTS_ZBOOT
+	select SYS_SUPPORTS_HOTPLUG_CPU
 	help
 	  This enables the support of Loongson family of machines.
 
diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index 16d0924..fe8995c 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -249,6 +249,9 @@ static inline void do_perfcnt_IRQ(void)
 #define LOONGSON_PXARB_CFG		LOONGSON_REG(LOONGSON_REGBASE + 0x68)
 #define LOONGSON_PXARB_STATUS		LOONGSON_REG(LOONGSON_REGBASE + 0x6c)
 
+/* Chip Config */
+#define LOONGSON_CHIPCFG0		LOONGSON_REG(LOONGSON_REGBASE + 0x80)
+
 /* pcimap */
 
 #define LOONGSON_PCIMAP_PCIMAP_LO0	0x0000003f
@@ -265,9 +268,6 @@ static inline void do_perfcnt_IRQ(void)
 #include <linux/cpufreq.h>
 extern void loongson2_cpu_wait(void);
 extern struct cpufreq_frequency_table loongson2_clockmod_table[];
-
-/* Chip Config */
-#define LOONGSON_CHIPCFG0		LOONGSON_REG(LOONGSON_REGBASE + 0x80)
 #endif
 
 /*
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index d4fb4d8..a6edbbf 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -40,6 +40,7 @@ extern int __cpu_logical_map[NR_CPUS];
 #define SMP_CALL_FUNCTION	0x2
 /* Octeon - Tell another core to flush its icache */
 #define SMP_ICACHE_FLUSH	0x4
+#define SMP_ASK_C0COUNT		0x8
 
 extern volatile cpumask_t cpu_callin_map;
 
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index e9a5fd7..69b17a9 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -72,9 +72,7 @@ void __noreturn cpu_idle(void)
 			}
 		}
 #ifdef CONFIG_HOTPLUG_CPU
-		if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map) &&
-		    (system_state == SYSTEM_RUNNING ||
-		     system_state == SYSTEM_BOOTING))
+		if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map))
 			play_dead();
 #endif
 		rcu_idle_exit();
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
index 8923117..f0da4c3 100644
--- a/arch/mips/loongson/loongson-3/smp.c
+++ b/arch/mips/loongson/loongson-3/smp.c
@@ -30,6 +30,9 @@
 
 #include "smp.h"
 
+DEFINE_PER_CPU(int, cpu_state);
+DEFINE_PER_CPU(uint32_t, core0_c0count);
+
 /* write a 64bit value to ipi register */
 void loongson3_ipi_write64(uint64_t action, void * addr)
 {
@@ -167,8 +170,8 @@ static void loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int act
 
 void loongson3_ipi_interrupt(struct pt_regs *regs)
 {
-	int cpu = smp_processor_id();
-	unsigned int action;
+	int i, cpu = smp_processor_id();
+	unsigned int action, c0count;
 
 	/* Load the ipi register to figure out what we're supposed to do */
 	action = loongson3_ipi_read32(ipi_status_regs0[cpu]);
@@ -183,14 +186,24 @@ void loongson3_ipi_interrupt(struct pt_regs *regs)
 	if (action & SMP_CALL_FUNCTION) {
 		smp_call_function_interrupt();
 	}
+
+	if (action & SMP_ASK_C0COUNT) {
+		BUG_ON(cpu != 0);
+		c0count = read_c0_count();
+		for (i=1; i<NR_CPUS; i++)
+			per_cpu(core0_c0count, i) = c0count;
+	}
 }
 
+#define MAX_LOOPS 1250
 /*
  * SMP init and finish on secondary CPUs
  */
 void __cpuinit loongson3_init_secondary(void)
 {
 	int i;
+	uint32_t initcount;
+	unsigned int cpu = smp_processor_id();
 	unsigned int imask = STATUSF_IP7 | STATUSF_IP6 | STATUSF_IP5 |
 			     STATUSF_IP4 | STATUSF_IP3 | STATUSF_IP2;
 
@@ -200,11 +213,24 @@ void __cpuinit loongson3_init_secondary(void)
 	for (i = 0; i < NR_CPUS; i++) {
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
+	write_c0_compare(initcount + mips_hpt_frequency/HZ);
 }
 
 void __cpuinit loongson3_smp_finish(void)
 {
-	write_c0_compare(read_c0_count() + mips_hpt_frequency/HZ);
 	local_irq_enable();
 	loongson3_ipi_write64(0, (void *)(ipi_mailbox_buf[smp_processor_id()]+0x0));
 	printk(KERN_INFO "CPU#%d finished, CP0_ST=%x\n",
@@ -233,6 +259,8 @@ void __init loongson3_smp_setup(void)
 
 void __init loongson3_prepare_cpus(unsigned int max_cpus)
 {
+	init_cpu_present(cpu_possible_mask);
+	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
 }
 
 /*
@@ -266,6 +294,149 @@ void __init loongson3_cpus_done(void)
 {
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+
+static DEFINE_SPINLOCK(smp_reserve_lock);
+
+extern void fixup_irqs(void);
+
+static int loongson3_cpu_disable(void)
+{
+	extern void (*flush_cache_all)(void);
+	unsigned int cpu = smp_processor_id();
+
+	if (cpu == 0)
+		return -EBUSY;
+
+	spin_lock(&smp_reserve_lock);
+	set_cpu_online(cpu, false);
+	cpu_clear(cpu, cpu_callin_map);
+	local_irq_disable();
+	fixup_irqs();
+	local_irq_enable();
+	flush_cache_all();
+	local_flush_tlb_all();
+	spin_unlock(&smp_reserve_lock);
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
+ * flush all L2 entries at first. Then, another core (usually Core 0) can
+ * safely disable the clock of the target core. loongson3_play_dead() is
+ * called via CKSEG1 (uncached and unmmaped) */
+void loongson3_play_dead(int *state_addr)
+{
+	__asm__ __volatile__(
+		"      .set push                         \n"
+		"      .set noreorder                    \n"
+		"      li $t0, 0x80000000                \n" /* KSEG0 */
+		"      li $t1, 512                       \n" /* num of L2 entries */
+		"flush_loop:                             \n" /* flush L2 */
+		"      cache 0, 0($t0)                   \n" /* ICache */
+		"      cache 0, 1($t0)                   \n"
+		"      cache 0, 2($t0)                   \n"
+		"      cache 0, 3($t0)                   \n"
+		"      cache 1, 0($t0)                   \n" /* DCache */
+		"      cache 1, 1($t0)                   \n"
+		"      cache 1, 2($t0)                   \n"
+		"      cache 1, 3($t0)                   \n"
+		"      addiu $t0, $t0, 0x20              \n"
+		"      bnez  $t1, flush_loop             \n"
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
+		"      .set mips3                        \n"
+		"      dli   $t0, 0x900000003ff01000     \n"
+		"      andi  $t3, $t2, 0x3               \n"
+		"      sll   $t3, 8                      \n"  /* get cpu id */
+		"      or    $t0, $t0, $t3               \n"
+		"      andi  $t1, $t2, 0xc               \n"
+		"      dsll  $t1, 42                     \n"  /* get node id */
+		"      or    $t0, $t0, $t1               \n"
+		"wait_for_init:                          \n"
+		"      li    $a0, 0x100                  \n"
+		"idle_loop:                              \n"
+		"      bnez  $a0, idle_loop              \n"
+		"      addiu $a0, -1                     \n"
+		"      lw    $v0, 0x20($t0)              \n"  /* get PC via mailbox */
+		"      nop                               \n"
+		"      beqz  $v0, wait_for_init          \n"
+		"      nop                               \n"
+		"      ld    $sp, 0x28($t0)              \n"  /* get SP via mailbox */
+		"      nop                               \n"
+		"      ld    $gp, 0x30($t0)              \n"  /* get GP via mailbox */
+		"      nop                               \n"
+		"      ld    $a1, 0x38($t0)              \n"
+		"      nop                               \n"
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
+static int __cpuinit loongson3_cpu_callback(struct notifier_block *nfb,
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
+static int __cpuinit register_loongson3_notifier(void)
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
@@ -275,4 +446,8 @@ struct plat_smp_ops loongson3_smp_ops = {
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
