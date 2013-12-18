Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2013 14:15:25 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35621 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867271Ab3LRNODjrT2I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Dec 2013 14:14:03 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 2F45728A927;
        Wed, 18 Dec 2013 14:11:45 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from shaker64.lan (dslb-088-073-137-004.pools.arcor-ip.net [88.73.137.4])
        by arrakis.dune.hu (Postfix) with ESMTPSA id E5D19284713;
        Wed, 18 Dec 2013 14:11:40 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH V2 03/13] MIPS: BMIPS: change compile time checks to runtime checks
Date:   Wed, 18 Dec 2013 14:12:01 +0100
Message-Id: <1387372331-23474-4-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
References: <1387372331-23474-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Allow building for all bmips cpus at the same time by changing ifdefs
to checks for the cpu type, or adding appropriate checks to the
assembly.

Since BMIPS43XX and BMIPS5000 require different IPI implementations,
split the SMP ops into one for each, so the runtime overhead is only
at registration time for them.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
V1 -> V2:
  * use switch (cpu_type()) instead of if () else if () ...
  * split the smp ops into bmips43xx and bmips5000

 arch/mips/bcm63xx/prom.c      |   2 +-
 arch/mips/include/asm/bmips.h |   3 +-
 arch/mips/kernel/bmips_vec.S  |  55 ++++++--
 arch/mips/kernel/smp-bmips.c  | 312 +++++++++++++++++++++++++-----------------
 4 files changed, 235 insertions(+), 137 deletions(-)

diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index 0215849..9872ca3 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -61,7 +61,7 @@ void __init prom_init(void)
 
 	if (IS_ENABLED(CONFIG_CPU_BMIPS4350) && IS_ENABLED(CONFIG_SMP)) {
 		/* set up SMP */
-		register_smp_ops(&bmips_smp_ops);
+		register_smp_ops(&bmips43xx_smp_ops);
 
 		/*
 		 * BCM6328 might not have its second CPU enabled, while BCM3368
diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index 27bd060..880f6aa 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -47,7 +47,8 @@
 #include <linux/cpumask.h>
 #include <asm/r4kcache.h>
 
-extern struct plat_smp_ops bmips_smp_ops;
+extern struct plat_smp_ops bmips43xx_smp_ops;
+extern struct plat_smp_ops bmips5000_smp_ops;
 extern char bmips_reset_nmi_vec;
 extern char bmips_reset_nmi_vec_end;
 extern char bmips_smp_movevec;
diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
index bd79c4f..122aa7f 100644
--- a/arch/mips/kernel/bmips_vec.S
+++ b/arch/mips/kernel/bmips_vec.S
@@ -13,6 +13,7 @@
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/cacheops.h>
+#include <asm/cpu.h>
 #include <asm/regdef.h>
 #include <asm/mipsregs.h>
 #include <asm/stackframe.h>
@@ -91,12 +92,18 @@ NESTED(bmips_reset_nmi_vec, PT_SIZE, sp)
 	beqz	k0, bmips_smp_entry
 
 #if defined(CONFIG_CPU_BMIPS5000)
+	mfc0	k0, CP0_PRID
+	li	k1, PRID_IMP_BMIPS5000
+	andi	k0, 0xff00
+	bne	k0, k1, 1f
+
 	/* if we're not on core 0, this must be the SMP boot signal */
 	li	k1, (3 << 25)
 	mfc0	k0, $22
 	and	k0, k1
 	bnez	k0, bmips_smp_entry
-#endif
+1:
+#endif /* CONFIG_CPU_BMIPS5000 */
 #endif /* CONFIG_SMP */
 
 	/* nope, it's just a regular NMI */
@@ -139,7 +146,12 @@ bmips_smp_entry:
 	xori	k0, 0x04
 	mtc0	k0, CP0_CONFIG
 
+	mfc0	k0, CP0_PRID
+	andi	k0, 0xff00
 #if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
+	li	k1, PRID_IMP_BMIPS43XX
+	bne	k0, k1, 2f
+
 	/* initialize CPU1's local I-cache */
 	li	k0, 0x80000000
 	li	k1, 0x80010000
@@ -150,14 +162,21 @@ bmips_smp_entry:
 1:	cache	Index_Store_Tag_I, 0(k0)
 	addiu	k0, 16
 	bne	k0, k1, 1b
-#elif defined(CONFIG_CPU_BMIPS5000)
+
+	b	3f
+2:
+#endif /* CONFIG_CPU_BMIPS4350 || CONFIG_CPU_BMIPS4380 */
+#if defined(CONFIG_CPU_BMIPS5000)
 	/* set exception vector base */
+	li	k1, PRID_IMP_BMIPS5000
+	bne	k0, k1, 3f
+
 	la	k0, ebase
 	lw	k0, 0(k0)
 	mtc0	k0, $15, 1
 	BARRIER
-#endif
-
+#endif /* CONFIG_CPU_BMIPS5000 */
+3:
 	/* jump back to kseg0 in case we need to remap the kseg1 area */
 	la	k0, 1f
 	jr	k0
@@ -221,8 +240,18 @@ END(bmips_smp_int_vec)
 LEAF(bmips_enable_xks01)
 
 #if defined(CONFIG_XKS01)
-
+	mfc0	t0, CP0_PRID
+	andi	t2, t0, 0xff00
 #if defined(CONFIG_CPU_BMIPS4380)
+	li	t1, PRID_IMP_BMIPS43XX
+	bne	t2, t1, 1f
+
+	andi	t0, 0xff
+	addiu	t1, t0, -PRID_REV_BMIPS4380_HI
+	bgtz	t1, 2f
+	addiu	t0, -PRID_REV_BMIPS4380_LO
+	bltz	t0, 2f
+
 	mfc0	t0, $22, 3
 	li	t1, 0x1ff0
 	li	t2, (1 << 12) | (1 << 9)
@@ -231,7 +260,13 @@ LEAF(bmips_enable_xks01)
 	or	t0, t2
 	mtc0	t0, $22, 3
 	BARRIER
-#elif defined(CONFIG_CPU_BMIPS5000)
+	b	2f
+1:
+#endif /* CONFIG_CPU_BMIPS4380 */
+#if defined(CONFIG_CPU_BMIPS5000)
+	li	t1, PRID_IMP_BMIPS5000
+	bne	t2, t1, 2f
+
 	mfc0	t0, $22, 5
 	li	t1, 0x01ff
 	li	t2, (1 << 8) | (1 << 5)
@@ -240,12 +275,8 @@ LEAF(bmips_enable_xks01)
 	or	t0, t2
 	mtc0	t0, $22, 5
 	BARRIER
-#else
-
-#error Missing XKS01 setup
-
-#endif
-
+#endif /* CONFIG_CPU_BMIPS5000 */
+2:
 #endif /* defined(CONFIG_XKS01) */
 
 	jr	ra
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 2362665..ea4c2dc 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -49,8 +49,10 @@ cpumask_t bmips_booted_mask;
 unsigned long bmips_smp_boot_sp;
 unsigned long bmips_smp_boot_gp;
 
-static void bmips_send_ipi_single(int cpu, unsigned int action);
-static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id);
+static void bmips43xx_send_ipi_single(int cpu, unsigned int action);
+static void bmips5000_send_ipi_single(int cpu, unsigned int action);
+static irqreturn_t bmips43xx_ipi_interrupt(int irq, void *dev_id);
+static irqreturn_t bmips5000_ipi_interrupt(int irq, void *dev_id);
 
 /* SW interrupts 0,1 are used for interprocessor signaling */
 #define IPI0_IRQ			(MIPS_CPU_IRQ_BASE + 0)
@@ -64,49 +66,58 @@ static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id);
 static void __init bmips_smp_setup(void)
 {
 	int i, cpu = 1, boot_cpu = 0;
-
-#if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
 	int cpu_hw_intr;
 
-	/* arbitration priority */
-	clear_c0_brcm_cmt_ctrl(0x30);
-
-	/* NBK and weak order flags */
-	set_c0_brcm_config_0(0x30000);
-
-	/* Find out if we are running on TP0 or TP1 */
-	boot_cpu = !!(read_c0_brcm_cmt_local() & (1 << 31));
-
-	/*
-	 * MIPS interrupts 0,1 (SW INT 0,1) cross over to the other thread
-	 * MIPS interrupt 2 (HW INT 0) is the CPU0 L1 controller output
-	 * MIPS interrupt 3 (HW INT 1) is the CPU1 L1 controller output
-	 */
-	if (boot_cpu == 0)
-		cpu_hw_intr = 0x02;
-	else
-		cpu_hw_intr = 0x1d;
-
-	change_c0_brcm_cmt_intr(0xf8018000, (cpu_hw_intr << 27) | (0x03 << 15));
-
-	/* single core, 2 threads (2 pipelines) */
-	max_cpus = 2;
-#elif defined(CONFIG_CPU_BMIPS5000)
-	/* enable raceless SW interrupts */
-	set_c0_brcm_config(0x03 << 22);
-
-	/* route HW interrupt 0 to CPU0, HW interrupt 1 to CPU1 */
-	change_c0_brcm_mode(0x1f << 27, 0x02 << 27);
-
-	/* N cores, 2 threads per core */
-	max_cpus = (((read_c0_brcm_config() >> 6) & 0x03) + 1) << 1;
+	switch (current_cpu_type()) {
+	case CPU_BMIPS4350:
+	case CPU_BMIPS4380:
+		/* arbitration priority */
+		clear_c0_brcm_cmt_ctrl(0x30);
+
+		/* NBK and weak order flags */
+		set_c0_brcm_config_0(0x30000);
+
+		/* Find out if we are running on TP0 or TP1 */
+		boot_cpu = !!(read_c0_brcm_cmt_local() & (1 << 31));
+
+		/*
+		 * MIPS interrupts 0,1 (SW INT 0,1) cross over to the other
+		 * thread
+		 * MIPS interrupt 2 (HW INT 0) is the CPU0 L1 controller output
+		 * MIPS interrupt 3 (HW INT 1) is the CPU1 L1 controller output
+		 */
+		if (boot_cpu == 0)
+			cpu_hw_intr = 0x02;
+		else
+			cpu_hw_intr = 0x1d;
+
+		change_c0_brcm_cmt_intr(0xf8018000,
+					(cpu_hw_intr << 27) | (0x03 << 15));
+
+		/* single core, 2 threads (2 pipelines) */
+		max_cpus = 2;
+
+		break;
+	case CPU_BMIPS5000:
+		/* enable raceless SW interrupts */
+		set_c0_brcm_config(0x03 << 22);
+
+		/* route HW interrupt 0 to CPU0, HW interrupt 1 to CPU1 */
+		change_c0_brcm_mode(0x1f << 27, 0x02 << 27);
+
+		/* N cores, 2 threads per core */
+		max_cpus = (((read_c0_brcm_config() >> 6) & 0x03) + 1) << 1;
+
+		/* clear any pending SW interrupts */
+		for (i = 0; i < max_cpus; i++) {
+			write_c0_brcm_action(ACTION_CLR_IPI(i, 0));
+			write_c0_brcm_action(ACTION_CLR_IPI(i, 1));
+		}
 
-	/* clear any pending SW interrupts */
-	for (i = 0; i < max_cpus; i++) {
-		write_c0_brcm_action(ACTION_CLR_IPI(i, 0));
-		write_c0_brcm_action(ACTION_CLR_IPI(i, 1));
+		break;
+	default:
+		max_cpus = 1;
 	}
-#endif
 
 	if (!bmips_smp_enabled)
 		max_cpus = 1;
@@ -134,6 +145,20 @@ static void __init bmips_smp_setup(void)
  */
 static void bmips_prepare_cpus(unsigned int max_cpus)
 {
+	irqreturn_t (*bmips_ipi_interrupt)(int irq, void *dev_id);
+
+	switch (current_cpu_type()) {
+	case CPU_BMIPS4350:
+	case CPU_BMIPS4380:
+		bmips_ipi_interrupt = bmips43xx_ipi_interrupt;
+		break;
+	case CPU_BMIPS5000:
+		bmips_ipi_interrupt = bmips5000_ipi_interrupt;
+		break;
+	default:
+		return;
+	}
+
 	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
 			"smp_ipi0", NULL))
 		panic("Can't request IPI0 interrupt");
@@ -168,26 +193,39 @@ static void bmips_boot_secondary(int cpu, struct task_struct *idle)
 
 	pr_info("SMP: Booting CPU%d...\n", cpu);
 
-	if (cpumask_test_cpu(cpu, &bmips_booted_mask))
-		bmips_send_ipi_single(cpu, 0);
+	if (cpumask_test_cpu(cpu, &bmips_booted_mask)) {
+		switch (current_cpu_type()) {
+		case CPU_BMIPS4350:
+		case CPU_BMIPS4380:
+			bmips43xx_send_ipi_single(cpu, 0);
+			break;
+		case CPU_BMIPS5000:
+			bmips5000_send_ipi_single(cpu, 0);
+			break;
+		}
+	}
 	else {
-#if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
-		/* Reset slave TP1 if booting from TP0 */
-		if (cpu_logical_map(cpu) == 1)
-			set_c0_brcm_cmt_ctrl(0x01);
-#elif defined(CONFIG_CPU_BMIPS5000)
-		if (cpu & 0x01)
-			write_c0_brcm_action(ACTION_BOOT_THREAD(cpu));
-		else {
-			/*
-			 * core N thread 0 was already booted; just
-			 * pulse the NMI line
-			 */
-			bmips_write_zscm_reg(0x210, 0xc0000000);
-			udelay(10);
-			bmips_write_zscm_reg(0x210, 0x00);
+		switch (current_cpu_type()) {
+		case CPU_BMIPS4350:
+		case CPU_BMIPS4380:
+			/* Reset slave TP1 if booting from TP0 */
+			if (cpu_logical_map(cpu) == 1)
+				set_c0_brcm_cmt_ctrl(0x01);
+			break;
+		case CPU_BMIPS5000:
+			if (cpu & 0x01)
+				write_c0_brcm_action(ACTION_BOOT_THREAD(cpu));
+			else {
+				/*
+				 * core N thread 0 was already booted; just
+				 * pulse the NMI line
+				 */
+				bmips_write_zscm_reg(0x210, 0xc0000000);
+				udelay(10);
+				bmips_write_zscm_reg(0x210, 0x00);
+			}
+			break;
 		}
-#endif
 		cpumask_set_cpu(cpu, &bmips_booted_mask);
 	}
 }
@@ -199,26 +237,32 @@ static void bmips_init_secondary(void)
 {
 	/* move NMI vector to kseg0, in case XKS01 is enabled */
 
-#if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
-	void __iomem *cbr = BMIPS_GET_CBR();
+	void __iomem *cbr;
 	unsigned long old_vec;
 	unsigned long relo_vector;
 	int boot_cpu;
 
-	boot_cpu = !!(read_c0_brcm_cmt_local() & (1 << 31));
-	relo_vector = boot_cpu ? BMIPS_RELO_VECTOR_CONTROL_0 :
-			  BMIPS_RELO_VECTOR_CONTROL_1;
+	switch (current_cpu_type()) {
+	case CPU_BMIPS4350:
+	case CPU_BMIPS4380:
+		cbr = BMIPS_GET_CBR();
 
-	old_vec = __raw_readl(cbr + relo_vector);
-	__raw_writel(old_vec & ~0x20000000, cbr + relo_vector);
+		boot_cpu = !!(read_c0_brcm_cmt_local() & (1 << 31));
+		relo_vector = boot_cpu ? BMIPS_RELO_VECTOR_CONTROL_0 :
+				  BMIPS_RELO_VECTOR_CONTROL_1;
 
-	clear_c0_cause(smp_processor_id() ? C_SW1 : C_SW0);
-#elif defined(CONFIG_CPU_BMIPS5000)
-	write_c0_brcm_bootvec(read_c0_brcm_bootvec() &
-		(smp_processor_id() & 0x01 ? ~0x20000000 : ~0x2000));
+		old_vec = __raw_readl(cbr + relo_vector);
+		__raw_writel(old_vec & ~0x20000000, cbr + relo_vector);
 
-	write_c0_brcm_action(ACTION_CLR_IPI(smp_processor_id(), 0));
-#endif
+		clear_c0_cause(smp_processor_id() ? C_SW1 : C_SW0);
+		break;
+	case CPU_BMIPS5000:
+		write_c0_brcm_bootvec(read_c0_brcm_bootvec() &
+			(smp_processor_id() & 0x01 ? ~0x20000000 : ~0x2000));
+
+		write_c0_brcm_action(ACTION_CLR_IPI(smp_processor_id(), 0));
+		break;
+	}
 }
 
 /*
@@ -243,8 +287,6 @@ static void bmips_cpus_done(void)
 {
 }
 
-#if defined(CONFIG_CPU_BMIPS5000)
-
 /*
  * BMIPS5000 raceless IPIs
  *
@@ -253,12 +295,12 @@ static void bmips_cpus_done(void)
  * IPI1 is used for SMP_CALL_FUNCTION
  */
 
-static void bmips_send_ipi_single(int cpu, unsigned int action)
+static void bmips5000_send_ipi_single(int cpu, unsigned int action)
 {
 	write_c0_brcm_action(ACTION_SET_IPI(cpu, action == SMP_CALL_FUNCTION));
 }
 
-static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id)
+static irqreturn_t bmips5000_ipi_interrupt(int irq, void *dev_id)
 {
 	int action = irq - IPI0_IRQ;
 
@@ -272,7 +314,14 @@ static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-#else
+static void bmips5000_send_ipi_mask(const struct cpumask *mask,
+	unsigned int action)
+{
+	unsigned int i;
+
+	for_each_cpu(i, mask)
+		bmips5000_send_ipi_single(i, action);
+}
 
 /*
  * BMIPS43xx racey IPIs
@@ -287,7 +336,7 @@ static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id)
 static DEFINE_SPINLOCK(ipi_lock);
 static DEFINE_PER_CPU(int, ipi_action_mask);
 
-static void bmips_send_ipi_single(int cpu, unsigned int action)
+static void bmips43xx_send_ipi_single(int cpu, unsigned int action)
 {
 	unsigned long flags;
 
@@ -298,7 +347,7 @@ static void bmips_send_ipi_single(int cpu, unsigned int action)
 	spin_unlock_irqrestore(&ipi_lock, flags);
 }
 
-static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id)
+static irqreturn_t bmips43xx_ipi_interrupt(int irq, void *dev_id)
 {
 	unsigned long flags;
 	int action, cpu = irq - IPI0_IRQ;
@@ -317,15 +366,13 @@ static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-#endif /* BMIPS type */
-
-static void bmips_send_ipi_mask(const struct cpumask *mask,
+static void bmips43xx_send_ipi_mask(const struct cpumask *mask,
 	unsigned int action)
 {
 	unsigned int i;
 
 	for_each_cpu(i, mask)
-		bmips_send_ipi_single(i, action);
+		bmips43xx_send_ipi_single(i, action);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -381,15 +428,30 @@ void __ref play_dead(void)
 
 #endif /* CONFIG_HOTPLUG_CPU */
 
-struct plat_smp_ops bmips_smp_ops = {
+struct plat_smp_ops bmips43xx_smp_ops = {
+	.smp_setup		= bmips_smp_setup,
+	.prepare_cpus		= bmips_prepare_cpus,
+	.boot_secondary		= bmips_boot_secondary,
+	.smp_finish		= bmips_smp_finish,
+	.init_secondary		= bmips_init_secondary,
+	.cpus_done		= bmips_cpus_done,
+	.send_ipi_single	= bmips43xx_send_ipi_single,
+	.send_ipi_mask		= bmips43xx_send_ipi_mask,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= bmips_cpu_disable,
+	.cpu_die		= bmips_cpu_die,
+#endif
+};
+
+struct plat_smp_ops bmips5000_smp_ops = {
 	.smp_setup		= bmips_smp_setup,
 	.prepare_cpus		= bmips_prepare_cpus,
 	.boot_secondary		= bmips_boot_secondary,
 	.smp_finish		= bmips_smp_finish,
 	.init_secondary		= bmips_init_secondary,
 	.cpus_done		= bmips_cpus_done,
-	.send_ipi_single	= bmips_send_ipi_single,
-	.send_ipi_mask		= bmips_send_ipi_mask,
+	.send_ipi_single	= bmips5000_send_ipi_single,
+	.send_ipi_mask		= bmips5000_send_ipi_mask,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_disable		= bmips_cpu_disable,
 	.cpu_die		= bmips_cpu_die,
@@ -427,43 +489,47 @@ void bmips_ebase_setup(void)
 
 	BUG_ON(ebase != CKSEG0);
 
-#if defined(CONFIG_CPU_BMIPS4350)
-	/*
-	 * BMIPS4350 cannot relocate the normal vectors, but it
-	 * can relocate the BEV=1 vectors.  So CPU1 starts up at
-	 * the relocated BEV=1, IV=0 general exception vector @
-	 * 0xa000_0380.
-	 *
-	 * set_uncached_handler() is used here because:
-	 *  - CPU1 will run this from uncached space
-	 *  - None of the cacheflush functions are set up yet
-	 */
-	set_uncached_handler(BMIPS_WARM_RESTART_VEC - CKSEG0,
-		&bmips_smp_int_vec, 0x80);
-	__sync();
-	return;
-#elif defined(CONFIG_CPU_BMIPS4380)
-	/*
-	 * 0x8000_0000: reset/NMI (initially in kseg1)
-	 * 0x8000_0400: normal vectors
-	 */
-	new_ebase = 0x80000400;
-	cbr = BMIPS_GET_CBR();
-	__raw_writel(0x80080800, cbr + BMIPS_RELO_VECTOR_CONTROL_0);
-	__raw_writel(0xa0080800, cbr + BMIPS_RELO_VECTOR_CONTROL_1);
-#elif defined(CONFIG_CPU_BMIPS5000)
-	/*
-	 * 0x8000_0000: reset/NMI (initially in kseg1)
-	 * 0x8000_1000: normal vectors
-	 */
-	new_ebase = 0x80001000;
-	write_c0_brcm_bootvec(0xa0088008);
-	write_c0_ebase(new_ebase);
-	if (max_cpus > 2)
-		bmips_write_zscm_reg(0xa0, 0xa008a008);
-#else
-	return;
-#endif
+	switch (current_cpu_type()) {
+	case CPU_BMIPS4350:
+		/*
+		 * BMIPS4350 cannot relocate the normal vectors, but it
+		 * can relocate the BEV=1 vectors.  So CPU1 starts up at
+		 * the relocated BEV=1, IV=0 general exception vector @
+		 * 0xa000_0380.
+		 *
+		 * set_uncached_handler() is used here because:
+		 *  - CPU1 will run this from uncached space
+		 *  - None of the cacheflush functions are set up yet
+		 */
+		set_uncached_handler(BMIPS_WARM_RESTART_VEC - CKSEG0,
+			&bmips_smp_int_vec, 0x80);
+		__sync();
+		return;
+	case CPU_BMIPS4380:
+		/*
+		 * 0x8000_0000: reset/NMI (initially in kseg1)
+		 * 0x8000_0400: normal vectors
+		 */
+		new_ebase = 0x80000400;
+		cbr = BMIPS_GET_CBR();
+		__raw_writel(0x80080800, cbr + BMIPS_RELO_VECTOR_CONTROL_0);
+		__raw_writel(0xa0080800, cbr + BMIPS_RELO_VECTOR_CONTROL_1);
+		break;
+	case CPU_BMIPS5000:
+		/*
+		 * 0x8000_0000: reset/NMI (initially in kseg1)
+		 * 0x8000_1000: normal vectors
+		 */
+		new_ebase = 0x80001000;
+		write_c0_brcm_bootvec(0xa0088008);
+		write_c0_ebase(new_ebase);
+		if (max_cpus > 2)
+			bmips_write_zscm_reg(0xa0, 0xa008a008);
+		break;
+	default:
+		return;
+	}
+
 	board_nmi_handler_setup = &bmips_nmi_handler_setup;
 	ebase = new_ebase;
 }
-- 
1.8.5.1
