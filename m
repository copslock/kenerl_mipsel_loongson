Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Mar 2015 12:41:29 +0100 (CET)
Received: from ozlabs.org ([103.22.144.67]:58681 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006724AbbCBLl0vuRIZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Mar 2015 12:41:26 +0100
Received: by ozlabs.org (Postfix, from userid 1011)
        id BE7EA140271; Mon,  2 Mar 2015 22:41:21 +1100 (AEDT)
From:   Rusty Russell <rusty@rustcorp.com.au>
To:     linux-kernel@vger.kernel.org
Cc:     Rusty Russell <rusty@rustcorp.com.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 09/16] mips: fix up obsolete cpu function usage.
Date:   Mon,  2 Mar 2015 22:05:50 +1030
Message-Id: <1425296150-4722-9-git-send-email-rusty@rustcorp.com.au>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1425296150-4722-1-git-send-email-rusty@rustcorp.com.au>
References: <1425296150-4722-1-git-send-email-rusty@rustcorp.com.au>
Return-Path: <rusty@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rusty@rustcorp.com.au
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

Thanks to spatch, plus manual removal of "&*".  Then a sweep for
for_each_cpu_mask => for_each_cpu.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/bcm63xx/irq.c              |  4 ++--
 arch/mips/cavium-octeon/smp.c        |  4 ++--
 arch/mips/kernel/crash.c             |  8 ++++----
 arch/mips/kernel/mips-mt-fpaff.c     |  4 ++--
 arch/mips/kernel/process.c           |  2 +-
 arch/mips/kernel/smp-bmips.c         |  2 +-
 arch/mips/kernel/smp-cmp.c           |  4 ++--
 arch/mips/kernel/smp-cps.c           |  4 ++--
 arch/mips/kernel/smp-mt.c            |  4 ++--
 arch/mips/kernel/smp.c               | 26 +++++++++++++-------------
 arch/mips/kernel/traps.c             |  6 +++---
 arch/mips/loongson/loongson-3/numa.c |  4 ++--
 arch/mips/loongson/loongson-3/smp.c  |  2 +-
 arch/mips/paravirt/paravirt-smp.c    |  2 +-
 arch/mips/sgi-ip27/ip27-init.c       |  2 +-
 arch/mips/sgi-ip27/ip27-klnuma.c     | 10 +++++-----
 arch/mips/sgi-ip27/ip27-memory.c     |  2 +-
 17 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index b94bf44d8d8e..e3e808a6c542 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -58,9 +58,9 @@ static inline int enable_irq_for_cpu(int cpu, struct irq_data *d,
 
 #ifdef CONFIG_SMP
 	if (m)
-		enable &= cpu_isset(cpu, *m);
+		enable &= cpumask_test_cpu(cpu, m);
 	else if (irqd_affinity_was_set(d))
-		enable &= cpu_isset(cpu, *d->affinity);
+		enable &= cpumask_test_cpu(cpu, d->affinity);
 #endif
 	return enable;
 }
diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 8b1eeffa12ed..56f5d080ef9d 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -72,7 +72,7 @@ static inline void octeon_send_ipi_mask(const struct cpumask *mask,
 {
 	unsigned int i;
 
-	for_each_cpu_mask(i, *mask)
+	for_each_cpu(i, mask)
 		octeon_send_ipi_single(i, action);
 }
 
@@ -239,7 +239,7 @@ static int octeon_cpu_disable(void)
 		return -ENOTSUPP;
 
 	set_cpu_online(cpu, false);
-	cpu_clear(cpu, cpu_callin_map);
+	cpumask_clear_cpu(cpu, &cpu_callin_map);
 	octeon_fixup_irqs();
 
 	flush_cache_all();
diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index d21264681e97..d434d5d5ae6e 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -25,9 +25,9 @@ static void crash_shutdown_secondary(void *ignore)
 		return;
 
 	local_irq_disable();
-	if (!cpu_isset(cpu, cpus_in_crash))
+	if (!cpumask_test_cpu(cpu, &cpus_in_crash))
 		crash_save_cpu(regs, cpu);
-	cpu_set(cpu, cpus_in_crash);
+	cpumask_set_cpu(cpu, &cpus_in_crash);
 
 	while (!atomic_read(&kexec_ready_to_reboot))
 		cpu_relax();
@@ -50,7 +50,7 @@ static void crash_kexec_prepare_cpus(void)
 	 */
 	pr_emerg("Sending IPI to other cpus...\n");
 	msecs = 10000;
-	while ((cpus_weight(cpus_in_crash) < ncpus) && (--msecs > 0)) {
+	while ((cpumask_weight(&cpus_in_crash) < ncpus) && (--msecs > 0)) {
 		cpu_relax();
 		mdelay(1);
 	}
@@ -66,5 +66,5 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	crashing_cpu = smp_processor_id();
 	crash_save_cpu(regs, crashing_cpu);
 	crash_kexec_prepare_cpus();
-	cpu_set(crashing_cpu, cpus_in_crash);
+	cpumask_set_cpu(crashing_cpu, &cpus_in_crash);
 }
diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 362bb3707e62..3e4491aa6d6b 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -114,8 +114,8 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	/* Compute new global allowed CPU set if necessary */
 	ti = task_thread_info(p);
 	if (test_ti_thread_flag(ti, TIF_FPUBOUND) &&
-	    cpus_intersects(*new_mask, mt_fpu_cpumask)) {
-		cpus_and(*effective_mask, *new_mask, mt_fpu_cpumask);
+	    cpumask_intersects(new_mask, &mt_fpu_cpumask)) {
+		cpumask_and(effective_mask, new_mask, &mt_fpu_cpumask);
 		retval = set_cpus_allowed_ptr(p, effective_mask);
 	} else {
 		cpumask_copy(effective_mask, new_mask);
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index bf85cc180d91..4501c7a4bd58 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -49,7 +49,7 @@
 void arch_cpu_idle_dead(void)
 {
 	/* What the heck is this check doing ? */
-	if (!cpu_isset(smp_processor_id(), cpu_callin_map))
+	if (!cpumask_test_cpu(smp_processor_id(), &cpu_callin_map))
 		play_dead();
 }
 #endif
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index b8bd9340c9c7..fd528d7ea278 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -362,7 +362,7 @@ static int bmips_cpu_disable(void)
 	pr_info("SMP: CPU%d is offline\n", cpu);
 
 	set_cpu_online(cpu, false);
-	cpu_clear(cpu, cpu_callin_map);
+	cpumask_clear_cpu(cpu, &cpu_callin_map);
 	clear_c0_status(IE_IRQ5);
 
 	local_flush_tlb_all();
diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
index e36a859af666..d5e0f949dc48 100644
--- a/arch/mips/kernel/smp-cmp.c
+++ b/arch/mips/kernel/smp-cmp.c
@@ -66,7 +66,7 @@ static void cmp_smp_finish(void)
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
 	if (cpu_has_fpu)
-		cpu_set(smp_processor_id(), mt_fpu_cpumask);
+		cpumask_set_cpu(smp_processor_id(), &mt_fpu_cpumask);
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
 	local_irq_enable();
@@ -110,7 +110,7 @@ void __init cmp_smp_setup(void)
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
 	if (cpu_has_fpu)
-		cpu_set(0, mt_fpu_cpumask);
+		cpumask_set_cpu(0, &mt_fpu_cpumask);
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
 	for (i = 1; i < NR_CPUS; i++) {
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index bed7590e475f..b0fe93e6537e 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -284,7 +284,7 @@ static void cps_smp_finish(void)
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
 	if (cpu_has_fpu)
-		cpu_set(smp_processor_id(), mt_fpu_cpumask);
+		cpumask_set_cpu(smp_processor_id(), &mt_fpu_cpumask);
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
 	local_irq_enable();
@@ -307,7 +307,7 @@ static int cps_cpu_disable(void)
 	atomic_sub(1 << cpu_vpe_id(&current_cpu_data), &core_cfg->vpe_mask);
 	smp_mb__after_atomic();
 	set_cpu_online(cpu, false);
-	cpu_clear(cpu, cpu_callin_map);
+	cpumask_clear_cpu(cpu, &cpu_callin_map);
 
 	return 0;
 }
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 17ea705f6c40..86311a164ef1 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -178,7 +178,7 @@ static void vsmp_smp_finish(void)
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
 	if (cpu_has_fpu)
-		cpu_set(smp_processor_id(), mt_fpu_cpumask);
+		cpumask_set_cpu(smp_processor_id(), &mt_fpu_cpumask);
 #endif /* CONFIG_MIPS_MT_FPAFF */
 
 	local_irq_enable();
@@ -239,7 +239,7 @@ static void __init vsmp_smp_setup(void)
 #ifdef CONFIG_MIPS_MT_FPAFF
 	/* If we have an FPU, enroll ourselves in the FPU-full mask */
 	if (cpu_has_fpu)
-		cpu_set(0, mt_fpu_cpumask);
+		cpumask_set_cpu(0, &mt_fpu_cpumask);
 #endif /* CONFIG_MIPS_MT_FPAFF */
 	if (!cpu_has_mipsmt)
 		return;
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 1c0d8c50b7e1..357acd3ac0e6 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -75,30 +75,30 @@ static inline void set_cpu_sibling_map(int cpu)
 {
 	int i;
 
-	cpu_set(cpu, cpu_sibling_setup_map);
+	cpumask_set_cpu(cpu, &cpu_sibling_setup_map);
 
 	if (smp_num_siblings > 1) {
-		for_each_cpu_mask(i, cpu_sibling_setup_map) {
+		for_each_cpu(i, &cpu_sibling_setup_map) {
 			if (cpu_data[cpu].package == cpu_data[i].package &&
 				    cpu_data[cpu].core == cpu_data[i].core) {
-				cpu_set(i, cpu_sibling_map[cpu]);
-				cpu_set(cpu, cpu_sibling_map[i]);
+				cpumask_set_cpu(i, &cpu_sibling_map[cpu]);
+				cpumask_set_cpu(cpu, &cpu_sibling_map[i]);
 			}
 		}
 	} else
-		cpu_set(cpu, cpu_sibling_map[cpu]);
+		cpumask_set_cpu(cpu, &cpu_sibling_map[cpu]);
 }
 
 static inline void set_cpu_core_map(int cpu)
 {
 	int i;
 
-	cpu_set(cpu, cpu_core_setup_map);
+	cpumask_set_cpu(cpu, &cpu_core_setup_map);
 
-	for_each_cpu_mask(i, cpu_core_setup_map) {
+	for_each_cpu(i, &cpu_core_setup_map) {
 		if (cpu_data[cpu].package == cpu_data[i].package) {
-			cpu_set(i, cpu_core_map[cpu]);
-			cpu_set(cpu, cpu_core_map[i]);
+			cpumask_set_cpu(i, &cpu_core_map[cpu]);
+			cpumask_set_cpu(cpu, &cpu_core_map[i]);
 		}
 	}
 }
@@ -138,7 +138,7 @@ asmlinkage void start_secondary(void)
 	cpu = smp_processor_id();
 	cpu_data[cpu].udelay_val = loops_per_jiffy;
 
-	cpu_set(cpu, cpu_coherent_mask);
+	cpumask_set_cpu(cpu, &cpu_coherent_mask);
 	notify_cpu_starting(cpu);
 
 	set_cpu_online(cpu, true);
@@ -146,7 +146,7 @@ asmlinkage void start_secondary(void)
 	set_cpu_sibling_map(cpu);
 	set_cpu_core_map(cpu);
 
-	cpu_set(cpu, cpu_callin_map);
+	cpumask_set_cpu(cpu, &cpu_callin_map);
 
 	synchronise_count_slave(cpu);
 
@@ -210,7 +210,7 @@ void smp_prepare_boot_cpu(void)
 {
 	set_cpu_possible(0, true);
 	set_cpu_online(0, true);
-	cpu_set(0, cpu_callin_map);
+	cpumask_set_cpu(0, &cpu_callin_map);
 }
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
@@ -220,7 +220,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	/*
 	 * Trust is futile.  We should really have timeouts ...
 	 */
-	while (!cpu_isset(cpu, cpu_callin_map))
+	while (!cpumask_test_cpu(cpu, &cpu_callin_map))
 		udelay(100);
 
 	synchronise_count_master(cpu);
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 33984c04b60b..b05b9462c728 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1121,13 +1121,13 @@ static void mt_ase_fp_affinity(void)
 		 * restricted the allowed set to exclude any CPUs with FPUs,
 		 * we'll skip the procedure.
 		 */
-		if (cpus_intersects(current->cpus_allowed, mt_fpu_cpumask)) {
+		if (cpumask_intersects(&current->cpus_allowed, &mt_fpu_cpumask)) {
 			cpumask_t tmask;
 
 			current->thread.user_cpus_allowed
 				= current->cpus_allowed;
-			cpus_and(tmask, current->cpus_allowed,
-				mt_fpu_cpumask);
+			cpumask_and(&tmask, &current->cpus_allowed,
+				    &mt_fpu_cpumask);
 			set_cpus_allowed_ptr(current, &tmask);
 			set_thread_flag(TIF_FPUBOUND);
 		}
diff --git a/arch/mips/loongson/loongson-3/numa.c b/arch/mips/loongson/loongson-3/numa.c
index 6cae0e75de27..12d14ed48778 100644
--- a/arch/mips/loongson/loongson-3/numa.c
+++ b/arch/mips/loongson/loongson-3/numa.c
@@ -233,7 +233,7 @@ static __init void prom_meminit(void)
 		if (node_online(node)) {
 			szmem(node);
 			node_mem_init(node);
-			cpus_clear(__node_data[(node)]->cpumask);
+			cpumask_clear(&__node_data[(node)]->cpumask);
 		}
 	}
 	for (cpu = 0; cpu < loongson_sysconf.nr_cpus; cpu++) {
@@ -244,7 +244,7 @@ static __init void prom_meminit(void)
 		if (loongson_sysconf.reserved_cpus_mask & (1<<cpu))
 			continue;
 
-		cpu_set(active_cpu, __node_data[(node)]->cpumask);
+		cpumask_set_cpu(active_cpu, &__node_data[(node)]->cpumask);
 		pr_info("NUMA: set cpumask cpu %d on node %d\n", active_cpu, node);
 
 		active_cpu++;
diff --git a/arch/mips/loongson/loongson-3/smp.c b/arch/mips/loongson/loongson-3/smp.c
index e2eb688b5434..e3c68b5da18d 100644
--- a/arch/mips/loongson/loongson-3/smp.c
+++ b/arch/mips/loongson/loongson-3/smp.c
@@ -408,7 +408,7 @@ static int loongson3_cpu_disable(void)
 		return -EBUSY;
 
 	set_cpu_online(cpu, false);
-	cpu_clear(cpu, cpu_callin_map);
+	cpumask_clear_cpu(cpu, &cpu_callin_map);
 	local_irq_save(flags);
 	fixup_irqs();
 	local_irq_restore(flags);
diff --git a/arch/mips/paravirt/paravirt-smp.c b/arch/mips/paravirt/paravirt-smp.c
index 0164b0c48352..42181c7105df 100644
--- a/arch/mips/paravirt/paravirt-smp.c
+++ b/arch/mips/paravirt/paravirt-smp.c
@@ -75,7 +75,7 @@ static void paravirt_send_ipi_mask(const struct cpumask *mask, unsigned int acti
 {
 	unsigned int cpu;
 
-	for_each_cpu_mask(cpu, *mask)
+	for_each_cpu(cpu, mask)
 		paravirt_send_ipi_single(cpu, action);
 }
 
diff --git a/arch/mips/sgi-ip27/ip27-init.c b/arch/mips/sgi-ip27/ip27-init.c
index ee736bd103f8..570098bfdf87 100644
--- a/arch/mips/sgi-ip27/ip27-init.c
+++ b/arch/mips/sgi-ip27/ip27-init.c
@@ -60,7 +60,7 @@ static void per_hub_init(cnodeid_t cnode)
 	nasid_t nasid = COMPACT_TO_NASID_NODEID(cnode);
 	int i;
 
-	cpu_set(smp_processor_id(), hub->h_cpus);
+	cpumask_set_cpu(smp_processor_id(), &hub->h_cpus);
 
 	if (test_and_set_bit(cnode, hub_init_mask))
 		return;
diff --git a/arch/mips/sgi-ip27/ip27-klnuma.c b/arch/mips/sgi-ip27/ip27-klnuma.c
index ecbb62f339c5..bda90cf87e8c 100644
--- a/arch/mips/sgi-ip27/ip27-klnuma.c
+++ b/arch/mips/sgi-ip27/ip27-klnuma.c
@@ -29,8 +29,8 @@ static cpumask_t ktext_repmask;
 void __init setup_replication_mask(void)
 {
 	/* Set only the master cnode's bit.  The master cnode is always 0. */
-	cpus_clear(ktext_repmask);
-	cpu_set(0, ktext_repmask);
+	cpumask_clear(&ktext_repmask);
+	cpumask_set_cpu(0, &ktext_repmask);
 
 #ifdef CONFIG_REPLICATE_KTEXT
 #ifndef CONFIG_MAPPED_KERNEL
@@ -43,7 +43,7 @@ void __init setup_replication_mask(void)
 			if (cnode == 0)
 				continue;
 			/* Advertise that we have a copy of the kernel */
-			cpu_set(cnode, ktext_repmask);
+			cpumask_set_cpu(cnode, &ktext_repmask);
 		}
 	}
 #endif
@@ -99,7 +99,7 @@ void __init replicate_kernel_text()
 		client_nasid = COMPACT_TO_NASID_NODEID(cnode);
 
 		/* Check if this node should get a copy of the kernel */
-		if (cpu_isset(cnode, ktext_repmask)) {
+		if (cpumask_test_cpu(cnode, &ktext_repmask)) {
 			server_nasid = client_nasid;
 			copy_kernel(server_nasid);
 		}
@@ -124,7 +124,7 @@ unsigned long node_getfirstfree(cnodeid_t cnode)
 	loadbase += 16777216;
 #endif
 	offset = PAGE_ALIGN((unsigned long)(&_end)) - loadbase;
-	if ((cnode == 0) || (cpu_isset(cnode, ktext_repmask)))
+	if ((cnode == 0) || (cpumask_test_cpu(cnode, &ktext_repmask)))
 		return TO_NODE(nasid, offset) >> PAGE_SHIFT;
 	else
 		return KDM_TO_PHYS(PAGE_ALIGN(SYMMON_STK_ADDR(nasid, 0))) >> PAGE_SHIFT;
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 0b68469e063f..8d0eb2643248 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -404,7 +404,7 @@ static void __init node_mem_init(cnodeid_t node)
 	NODE_DATA(node)->node_start_pfn = start_pfn;
 	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
 
-	cpus_clear(hub_data(node)->h_cpus);
+	cpumask_clear(&hub_data(node)->h_cpus);
 
 	slot_freepfn += PFN_UP(sizeof(struct pglist_data) +
 			       sizeof(struct hub_data));
-- 
2.1.0
