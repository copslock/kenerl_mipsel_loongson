Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 07:15:19 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:50959 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012511AbaKDGOUYw1yQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2014 07:14:20 +0100
Received: by mail-pa0-f52.google.com with SMTP id fa1so13631206pad.25
        for <multiple recipients>; Mon, 03 Nov 2014 22:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GBbnfNOb1SD2+z02QIBJukXIrHPRBbYSGci5L8o0B/s=;
        b=RiQXFBYE5nrauxifddj2IB6WN2ZJfbYxPBCjFFBq6S0+J1aV9CZ4vjw8fBThPUuA1L
         n7AdwuWPfICQqaLFhQO9QWqb1YfraG35Ks7Y3uAG+ZIxUXmAseN9RbHDw5aSKS6aja4M
         6TorY4isr+1M8f8kJbYZq4BycTTuuTJZBZOBtiJIeLIEsccN1f7dK7CN5FUFtK+kl4Tp
         eruPO1t5SK0YicYBg2PAs1vPfY4K+lmJV04Rc61VGEATRCbWRe8zLduzXxOB4jOAIR4T
         GW29t6HzeRoyjz1b6UJI1XIKvrncMDTlvJaBOdEidfehNRlj/u7RhzcV/d3PKJW/d4Ao
         c6rw==
X-Received: by 10.70.102.234 with SMTP id fr10mr5480091pdb.145.1415081652109;
        Mon, 03 Nov 2014 22:14:12 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id cs9sm7712498pac.8.2014.11.03.22.14.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Nov 2014 22:14:07 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 05/12] MIPS: Loongson: Allow booting from any core
Date:   Tue,  4 Nov 2014 14:13:26 +0800
Message-Id: <1415081610-25639-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
References: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43854
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

By offering Logical->Physical core id mapping, so as to reserve some
physical cores via mask. This allow booting from any core when core-0
has problems. Since the maximun cores supported by Loongson-3 is 16,
32-bit cpu_startup_core_id can be split to 16-bit cpu_startup_core_id
and 16-bit reserved_cores_mask for compatibility.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mach-loongson/boot_param.h |    5 +-
 arch/mips/include/asm/mach-loongson/irq.h        |    3 +-
 arch/mips/include/asm/mach-loongson/topology.h   |    2 +-
 arch/mips/loongson/common/env.c                  |    2 +
 arch/mips/loongson/loongson-3/irq.c              |   14 +++--
 arch/mips/loongson/loongson-3/numa.c             |   12 +++-
 arch/mips/loongson/loongson-3/smp.c              |   65 ++++++++++++++--------
 7 files changed, 67 insertions(+), 36 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/boot_param.h b/arch/mips/include/asm/mach-loongson/boot_param.h
index 3388fc5..11ebf4c 100644
--- a/arch/mips/include/asm/mach-loongson/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson/boot_param.h
@@ -42,7 +42,8 @@ struct efi_cpuinfo_loongson {
 	u32 processor_id; /* PRID, e.g. 6305, 6306 */
 	u32 cputype;  /* Loongson_3A/3B, etc. */
 	u32 total_node;   /* num of total numa nodes */
-	u32 cpu_startup_core_id; /* Core id */
+	u16 cpu_startup_core_id; /* Boot core id */
+	u16 reserved_cores_mask;
 	u32 cpu_clock_freq; /* cpu_clock */
 	u32 nr_cpus;
 } __packed;
@@ -149,6 +150,8 @@ struct loongson_system_configuration {
 	u32 nr_nodes;
 	int cores_per_node;
 	int cores_per_package;
+	u16 boot_cpu_id;
+	u16 reserved_cpus_mask;
 	enum loongson_cpu_type cputype;
 	u64 ht_control_base;
 	u64 pci_mem_start_addr;
diff --git a/arch/mips/include/asm/mach-loongson/irq.h b/arch/mips/include/asm/mach-loongson/irq.h
index 34560bd..a281cca 100644
--- a/arch/mips/include/asm/mach-loongson/irq.h
+++ b/arch/mips/include/asm/mach-loongson/irq.h
@@ -32,8 +32,7 @@
 #define LOONGSON_INT_ROUTER_LPC		LOONGSON_INT_ROUTER_ENTRY(0x0a)
 #define LOONGSON_INT_ROUTER_HT1(n)	LOONGSON_INT_ROUTER_ENTRY(n + 0x18)
 
-#define LOONGSON_INT_CORE0_INT0		0x11 /* route to int 0 of core 0 */
-#define LOONGSON_INT_CORE0_INT1		0x21 /* route to int 1 of core 0 */
+#define LOONGSON_INT_COREx_INTy(x, y)	(1<<(x) | 1<<(y+4))	/* route to int y of core x */
 
 #endif
 
diff --git a/arch/mips/include/asm/mach-loongson/topology.h b/arch/mips/include/asm/mach-loongson/topology.h
index 5598ba7..0d8f3b5 100644
--- a/arch/mips/include/asm/mach-loongson/topology.h
+++ b/arch/mips/include/asm/mach-loongson/topology.h
@@ -3,7 +3,7 @@
 
 #ifdef CONFIG_NUMA
 
-#define cpu_to_node(cpu)	((cpu) >> 2)
+#define cpu_to_node(cpu)	(cpu_logical_map(cpu) >> 2)
 #define parent_node(node)	(node)
 #define cpumask_of_node(node)	(&__node_data[(node)]->cpumask)
 
diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
index f152285..d8be539 100644
--- a/arch/mips/loongson/common/env.c
+++ b/arch/mips/loongson/common/env.c
@@ -119,6 +119,8 @@ void __init prom_init_env(void)
 	}
 
 	loongson_sysconf.nr_cpus = ecpu->nr_cpus;
+	loongson_sysconf.boot_cpu_id = ecpu->cpu_startup_core_id;
+	loongson_sysconf.reserved_cpus_mask = ecpu->reserved_cores_mask;
 	if (ecpu->nr_cpus > NR_CPUS || ecpu->nr_cpus == 0)
 		loongson_sysconf.nr_cpus = NR_CPUS;
 	loongson_sysconf.nr_nodes = (loongson_sysconf.nr_cpus +
diff --git a/arch/mips/loongson/loongson-3/irq.c b/arch/mips/loongson/loongson-3/irq.c
index ca1c62a..5813d94 100644
--- a/arch/mips/loongson/loongson-3/irq.c
+++ b/arch/mips/loongson/loongson-3/irq.c
@@ -55,8 +55,8 @@ static inline void mask_loongson_irq(struct irq_data *d)
 	/* Workaround: UART IRQ may deliver to any core */
 	if (d->irq == LOONGSON_UART_IRQ) {
 		int cpu = smp_processor_id();
-		int node_id = cpu / loongson_sysconf.cores_per_node;
-		int core_id = cpu % loongson_sysconf.cores_per_node;
+		int node_id = cpu_logical_map(cpu) / loongson_sysconf.cores_per_node;
+		int core_id = cpu_logical_map(cpu) % loongson_sysconf.cores_per_node;
 		u64 intenclr_addr = smp_group[node_id] |
 			(u64)(&LOONGSON_INT_ROUTER_INTENCLR);
 		u64 introuter_lpc_addr = smp_group[node_id] |
@@ -72,8 +72,8 @@ static inline void unmask_loongson_irq(struct irq_data *d)
 	/* Workaround: UART IRQ may deliver to any core */
 	if (d->irq == LOONGSON_UART_IRQ) {
 		int cpu = smp_processor_id();
-		int node_id = cpu / loongson_sysconf.cores_per_node;
-		int core_id = cpu % loongson_sysconf.cores_per_node;
+		int node_id = cpu_logical_map(cpu) / loongson_sysconf.cores_per_node;
+		int core_id = cpu_logical_map(cpu) % loongson_sysconf.cores_per_node;
 		u64 intenset_addr = smp_group[node_id] |
 			(u64)(&LOONGSON_INT_ROUTER_INTENSET);
 		u64 introuter_lpc_addr = smp_group[node_id] |
@@ -102,10 +102,12 @@ void irq_router_init(void)
 	int i;
 
 	/* route LPC int to cpu core0 int 0 */
-	LOONGSON_INT_ROUTER_LPC = LOONGSON_INT_CORE0_INT0;
+	LOONGSON_INT_ROUTER_LPC =
+		LOONGSON_INT_COREx_INTy(loongson_sysconf.boot_cpu_id, 0);
 	/* route HT1 int0 ~ int7 to cpu core0 INT1*/
 	for (i = 0; i < 8; i++)
-		LOONGSON_INT_ROUTER_HT1(i) = LOONGSON_INT_CORE0_INT1;
+		LOONGSON_INT_ROUTER_HT1(i) =
+			LOONGSON_INT_COREx_INTy(loongson_sysconf.boot_cpu_id, 1);
 	/* enable HT1 interrupt */
 	LOONGSON_HT1_INTN_EN(0) = 0xffffffff;
 	/* enable router interrupt intenset */
diff --git a/arch/mips/loongson/loongson-3/numa.c b/arch/mips/loongson/loongson-3/numa.c
index 37ed184..5246043 100644
--- a/arch/mips/loongson/loongson-3/numa.c
+++ b/arch/mips/loongson/loongson-3/numa.c
@@ -223,7 +223,7 @@ static void __init node_mem_init(unsigned int node)
 
 static __init void prom_meminit(void)
 {
-	unsigned int node, cpu;
+	unsigned int node, cpu, active_cpu = 0;
 
 	cpu_node_probe();
 	init_topology_matrix();
@@ -239,8 +239,14 @@ static __init void prom_meminit(void)
 		node = cpu / loongson_sysconf.cores_per_node;
 		if (node >= num_online_nodes())
 			node = 0;
-		pr_info("NUMA: set cpumask cpu %d on node %d\n", cpu, node);
-		cpu_set(cpu, __node_data[(node)]->cpumask);
+
+		if (loongson_sysconf.reserved_cpus_mask & (1<<cpu))
+			continue;
+
+		cpu_set(active_cpu, __node_data[(node)]->cpumask);
+		pr_info("NUMA: set cpumask cpu %d on node %d\n", active_cpu, node);
+
+		active_cpu++;
 	}
 }
 
diff --git a/arch/mips/loongson/loongson-3/smp.c b/arch/mips/loongson/loongson-3/smp.c
index d8c63af..94ed8a5 100644
--- a/arch/mips/loongson/loongson-3/smp.c
+++ b/arch/mips/loongson/loongson-3/smp.c
@@ -239,7 +239,7 @@ static void ipi_mailbox_buf_init(void)
  */
 static void loongson3_send_ipi_single(int cpu, unsigned int action)
 {
-	loongson3_ipi_write32((u32)action, ipi_set0_regs[cpu]);
+	loongson3_ipi_write32((u32)action, ipi_set0_regs[cpu_logical_map(cpu)]);
 }
 
 static void
@@ -248,7 +248,7 @@ loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 	unsigned int i;
 
 	for_each_cpu(i, mask)
-		loongson3_ipi_write32((u32)action, ipi_set0_regs[i]);
+		loongson3_ipi_write32((u32)action, ipi_set0_regs[cpu_logical_map(i)]);
 }
 
 void loongson3_ipi_interrupt(struct pt_regs *regs)
@@ -257,10 +257,10 @@ void loongson3_ipi_interrupt(struct pt_regs *regs)
 	unsigned int action, c0count;
 
 	/* Load the ipi register to figure out what we're supposed to do */
-	action = loongson3_ipi_read32(ipi_status0_regs[cpu]);
+	action = loongson3_ipi_read32(ipi_status0_regs[cpu_logical_map(cpu)]);
 
 	/* Clear the ipi register to clear the interrupt */
-	loongson3_ipi_write32((u32)action, ipi_clear0_regs[cpu]);
+	loongson3_ipi_write32((u32)action, ipi_clear0_regs[cpu_logical_map(cpu)]);
 
 	if (action & SMP_RESCHEDULE_YOURSELF)
 		scheduler_ipi();
@@ -291,12 +291,14 @@ static void loongson3_init_secondary(void)
 	/* Set interrupt mask, but don't enable */
 	change_c0_status(ST0_IM, imask);
 
-	for (i = 0; i < loongson_sysconf.nr_cpus; i++)
-		loongson3_ipi_write32(0xffffffff, ipi_en0_regs[i]);
+	for (i = 0; i < num_possible_cpus(); i++)
+		loongson3_ipi_write32(0xffffffff, ipi_en0_regs[cpu_logical_map(i)]);
 
-	cpu_data[cpu].package = cpu / loongson_sysconf.cores_per_package;
-	cpu_data[cpu].core = cpu % loongson_sysconf.cores_per_package;
 	per_cpu(cpu_state, cpu) = CPU_ONLINE;
+	cpu_data[cpu].core =
+		cpu_logical_map(cpu) % loongson_sysconf.cores_per_package;
+	cpu_data[cpu].package =
+		cpu_logical_map(cpu) / loongson_sysconf.cores_per_package;
 
 	i = 0;
 	__this_cpu_write(core0_c0count, 0);
@@ -314,37 +316,50 @@ static void loongson3_init_secondary(void)
 
 static void loongson3_smp_finish(void)
 {
+	int cpu = smp_processor_id();
+
 	write_c0_compare(read_c0_count() + mips_hpt_frequency/HZ);
 	local_irq_enable();
 	loongson3_ipi_write64(0,
-			(void *)(ipi_mailbox_buf[smp_processor_id()]+0x0));
+			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x0));
 	pr_info("CPU#%d finished, CP0_ST=%x\n",
 			smp_processor_id(), read_c0_status());
 }
 
 static void __init loongson3_smp_setup(void)
 {
-	int i, num;
+	int i = 0, num = 0; /* i: physical id, num: logical id */
 
 	init_cpu_possible(cpu_none_mask);
-	set_cpu_possible(0, true);
-
-	__cpu_number_map[0] = 0;
-	__cpu_logical_map[0] = 0;
 
 	/* For unified kernel, NR_CPUS is the maximum possible value,
 	 * loongson_sysconf.nr_cpus is the really present value */
-	for (i = 1, num = 0; i < loongson_sysconf.nr_cpus; i++) {
-		set_cpu_possible(i, true);
-		__cpu_number_map[i] = ++num;
-		__cpu_logical_map[num] = i;
+	while (i < loongson_sysconf.nr_cpus) {
+		if (loongson_sysconf.reserved_cpus_mask & (1<<i)) {
+			/* Reserved physical CPU cores */
+			__cpu_number_map[i] = -1;
+		} else {
+			__cpu_number_map[i] = num;
+			__cpu_logical_map[num] = i;
+			set_cpu_possible(num, true);
+			num++;
+		}
+		i++;
 	}
+	pr_info("Detected %i available CPU(s)\n", num);
+
+	while (num < loongson_sysconf.nr_cpus) {
+		__cpu_logical_map[num] = -1;
+		num++;
+	}
+
 	ipi_set0_regs_init();
 	ipi_clear0_regs_init();
 	ipi_status0_regs_init();
 	ipi_en0_regs_init();
 	ipi_mailbox_buf_init();
-	pr_info("Detected %i available secondary CPU(s)\n", num);
+	cpu_data[0].core = cpu_logical_map(0) % loongson_sysconf.cores_per_package;
+	cpu_data[0].package = cpu_logical_map(0) / loongson_sysconf.cores_per_package;
 }
 
 static void __init loongson3_prepare_cpus(unsigned int max_cpus)
@@ -371,10 +386,14 @@ static void loongson3_boot_secondary(int cpu, struct task_struct *idle)
 	pr_debug("CPU#%d, func_pc=%lx, sp=%lx, gp=%lx\n",
 			cpu, startargs[0], startargs[1], startargs[2]);
 
-	loongson3_ipi_write64(startargs[3], (void *)(ipi_mailbox_buf[cpu]+0x18));
-	loongson3_ipi_write64(startargs[2], (void *)(ipi_mailbox_buf[cpu]+0x10));
-	loongson3_ipi_write64(startargs[1], (void *)(ipi_mailbox_buf[cpu]+0x8));
-	loongson3_ipi_write64(startargs[0], (void *)(ipi_mailbox_buf[cpu]+0x0));
+	loongson3_ipi_write64(startargs[3],
+			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x18));
+	loongson3_ipi_write64(startargs[2],
+			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x10));
+	loongson3_ipi_write64(startargs[1],
+			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x8));
+	loongson3_ipi_write64(startargs[0],
+			(void *)(ipi_mailbox_buf[cpu_logical_map(cpu)]+0x0));
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
1.7.7.3
