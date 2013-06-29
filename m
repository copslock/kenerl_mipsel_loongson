Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jun 2013 22:19:36 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44537 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823043Ab3F2USWP6sje (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 29 Jun 2013 22:18:22 +0200
Received: from shaker64.lan (unknown [IPv6:2001:470:9e39:0:a00:27ff:fee0:c7df])
        by mail.nanl.de (Postfix) with ESMTPSA id C252B402E2;
        Sat, 29 Jun 2013 20:18:11 +0000 (UTC)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 04/10] MIPS: bmips: change compile time checks to runtime checks
Date:   Sat, 29 Jun 2013 22:17:46 +0200
Message-Id: <1372537073-27370-5-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
References: <1372537073-27370-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37226
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

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/kernel/bmips_vec.S |   55 +++++++---
 arch/mips/kernel/smp-bmips.c |  241 ++++++++++++++++++++++--------------------
 2 files changed, 172 insertions(+), 124 deletions(-)

diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
index 64c4fd6..043b42c 100644
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
@@ -89,12 +90,18 @@ NESTED(bmips_reset_nmi_vec, PT_SIZE, sp)
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
@@ -137,7 +144,12 @@ bmips_smp_entry:
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
@@ -148,14 +160,21 @@ bmips_smp_entry:
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
index aea6c08..d591876 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -49,8 +49,11 @@ cpumask_t bmips_booted_mask;
 unsigned long bmips_smp_boot_sp;
 unsigned long bmips_smp_boot_gp;
 
+static void bmips43xx_send_ipi_single(int cpu, unsigned int action);
+static void bmips5000_send_ipi_single(int cpu, unsigned int action);
 static void bmips_send_ipi_single(int cpu, unsigned int action);
-static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id);
+static irqreturn_t bmips43xx_ipi_interrupt(int irq, void *dev_id);
+static irqreturn_t bmips5000_ipi_interrupt(int irq, void *dev_id);
 
 /* SW interrupts 0,1 are used for interprocessor signaling */
 #define IPI0_IRQ			(MIPS_CPU_IRQ_BASE + 0)
@@ -65,48 +68,49 @@ static void __init bmips_smp_setup(void)
 {
 	int i, cpu = 1, boot_cpu = 0;
 
-#if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
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
-	 *
-	 * If booting from TP1, leave the existing CMT interrupt routing
-	 * such that TP0 responds to SW1 and TP1 responds to SW0.
-	 */
-	if (boot_cpu == 0)
-		change_c0_brcm_cmt_intr(0xf8018000,
+	if (cpu_is_bmips4350() || cpu_is_bmips4380()) {
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
+		 *
+		 * If booting from TP1, leave the existing CMT interrupt routing
+		 * such that TP0 responds to SW1 and TP1 responds to SW0.
+		 */
+		if (boot_cpu == 0)
+			change_c0_brcm_cmt_intr(0xf8018000,
 					(0x02 << 27) | (0x03 << 15));
-	else
-		change_c0_brcm_cmt_intr(0xf8018000, (0x1d << 27));
+		else
+			change_c0_brcm_cmt_intr(0xf8018000, (0x1d << 27));
 
-	/* single core, 2 threads (2 pipelines) */
-	max_cpus = 2;
-#elif defined(CONFIG_CPU_BMIPS5000)
-	/* enable raceless SW interrupts */
-	set_c0_brcm_config(0x03 << 22);
+		/* single core, 2 threads (2 pipelines) */
+		max_cpus = 2;
+	} else if (cpu_is_bmips5000()) {
+		/* enable raceless SW interrupts */
+		set_c0_brcm_config(0x03 << 22);
 
-	/* route HW interrupt 0 to CPU0, HW interrupt 1 to CPU1 */
-	change_c0_brcm_mode(0x1f << 27, 0x02 << 27);
+		/* route HW interrupt 0 to CPU0, HW interrupt 1 to CPU1 */
+		change_c0_brcm_mode(0x1f << 27, 0x02 << 27);
 
-	/* N cores, 2 threads per core */
-	max_cpus = (((read_c0_brcm_config() >> 6) & 0x03) + 1) << 1;
+		/* N cores, 2 threads per core */
+		max_cpus = (((read_c0_brcm_config() >> 6) & 0x03) + 1) << 1;
 
-	/* clear any pending SW interrupts */
-	for (i = 0; i < max_cpus; i++) {
-		write_c0_brcm_action(ACTION_CLR_IPI(i, 0));
-		write_c0_brcm_action(ACTION_CLR_IPI(i, 1));
+		/* clear any pending SW interrupts */
+		for (i = 0; i < max_cpus; i++) {
+			write_c0_brcm_action(ACTION_CLR_IPI(i, 0));
+			write_c0_brcm_action(ACTION_CLR_IPI(i, 1));
+		}
 	}
-#endif
 
 	if (!bmips_smp_enabled)
 		max_cpus = 1;
@@ -134,6 +138,15 @@ static void __init bmips_smp_setup(void)
  */
 static void bmips_prepare_cpus(unsigned int max_cpus)
 {
+	irqreturn_t (*bmips_ipi_interrupt)(int irq, void *dev_id);
+
+	if (cpu_is_bmips4350() || cpu_is_bmips4380())
+		bmips_ipi_interrupt = bmips43xx_ipi_interrupt;
+	else if (cpu_is_bmips5000())
+		bmips_ipi_interrupt = bmips5000_ipi_interrupt;
+	else
+		return;
+
 	if (request_irq(IPI0_IRQ, bmips_ipi_interrupt, IRQF_PERCPU,
 			"smp_ipi0", NULL))
 		panic("Can't request IPI0 interrupt\n");
@@ -168,26 +181,26 @@ static void bmips_boot_secondary(int cpu, struct task_struct *idle)
 
 	pr_info("SMP: Booting CPU%d...\n", cpu);
 
-	if (cpumask_test_cpu(cpu, &bmips_booted_mask))
+	if (cpumask_test_cpu(cpu, &bmips_booted_mask)) {
 		bmips_send_ipi_single(cpu, 0);
-	else {
-#if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
-		/* Reset slave TP1 if booting from TP0 */
-		if (cpu_logical_map(cpu) == 0)
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
+	} else {
+		if (cpu_is_bmips4350() || cpu_is_bmips4380()) {
+			/* Reset slave TP1 if booting from TP0 */
+			if (cpu_logical_map(cpu) == 0)
+				set_c0_brcm_cmt_ctrl(0x01);
+		} else if (cpu_is_bmips5000()) {
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
 		}
-#endif
 		cpumask_set_cpu(cpu, &bmips_booted_mask);
 	}
 }
@@ -199,20 +212,21 @@ static void bmips_init_secondary(void)
 {
 	/* move NMI vector to kseg0, in case XKS01 is enabled */
 
-#if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
-	void __iomem *cbr = BMIPS_GET_CBR();
-	unsigned long old_vec;
+	if (cpu_is_bmips4350() || cpu_is_bmips4380()) {
+		void __iomem *cbr = BMIPS_GET_CBR();
+		unsigned long old_vec;
 
-	old_vec = __raw_readl(cbr + BMIPS_RELO_VECTOR_CONTROL_1);
-	__raw_writel(old_vec & ~0x20000000, cbr + BMIPS_RELO_VECTOR_CONTROL_1);
+		old_vec = __raw_readl(cbr + BMIPS_RELO_VECTOR_CONTROL_1);
+		__raw_writel(old_vec & ~0x20000000,
+			cbr + BMIPS_RELO_VECTOR_CONTROL_1);
 
-	clear_c0_cause(smp_processor_id() ? C_SW1 : C_SW0);
-#elif defined(CONFIG_CPU_BMIPS5000)
-	write_c0_brcm_bootvec(read_c0_brcm_bootvec() &
-		(smp_processor_id() & 0x01 ? ~0x20000000 : ~0x2000));
+		clear_c0_cause(smp_processor_id() ? C_SW1 : C_SW0);
+	} else if (cpu_is_bmips5000()) {
+		write_c0_brcm_bootvec(read_c0_brcm_bootvec() &
+			(smp_processor_id() & 0x01 ? ~0x20000000 : ~0x2000));
 
-	write_c0_brcm_action(ACTION_CLR_IPI(smp_processor_id(), 0));
-#endif
+		write_c0_brcm_action(ACTION_CLR_IPI(smp_processor_id(), 0));
+	}
 }
 
 /*
@@ -237,8 +251,6 @@ static void bmips_cpus_done(void)
 {
 }
 
-#if defined(CONFIG_CPU_BMIPS5000)
-
 /*
  * BMIPS5000 raceless IPIs
  *
@@ -247,12 +259,12 @@ static void bmips_cpus_done(void)
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
 
@@ -266,8 +278,6 @@ static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-#else
-
 /*
  * BMIPS43xx racey IPIs
  *
@@ -281,7 +291,7 @@ static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id)
 static DEFINE_SPINLOCK(ipi_lock);
 static DEFINE_PER_CPU(int, ipi_action_mask);
 
-static void bmips_send_ipi_single(int cpu, unsigned int action)
+static void bmips43xx_send_ipi_single(int cpu, unsigned int action)
 {
 	unsigned long flags;
 
@@ -292,7 +302,7 @@ static void bmips_send_ipi_single(int cpu, unsigned int action)
 	spin_unlock_irqrestore(&ipi_lock, flags);
 }
 
-static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id)
+static irqreturn_t bmips43xx_ipi_interrupt(int irq, void *dev_id)
 {
 	unsigned long flags;
 	int action, cpu = irq - IPI0_IRQ;
@@ -311,7 +321,13 @@ static irqreturn_t bmips_ipi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-#endif /* BMIPS type */
+static void bmips_send_ipi_single(int cpu, unsigned int action)
+{
+	if (cpu_is_bmips4350() || cpu_is_bmips4380())
+		bmips43xx_send_ipi_single(cpu, action);
+	else if (cpu_is_bmips5000())
+		bmips5000_send_ipi_single(cpu, action);
+}
 
 static void bmips_send_ipi_mask(const struct cpumask *mask,
 	unsigned int action)
@@ -421,43 +437,44 @@ void __cpuinit bmips_ebase_setup(void)
 
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
+	if (cpu_is_bmips4350()) {
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
+	} else if (cpu_is_bmips4380()) {
+		/*
+		 * 0x8000_0000: reset/NMI (initially in kseg1)
+		 * 0x8000_0400: normal vectors
+		 */
+		new_ebase = 0x80000400;
+		cbr = BMIPS_GET_CBR();
+		__raw_writel(0x80080800, cbr + BMIPS_RELO_VECTOR_CONTROL_0);
+		__raw_writel(0xa0080800, cbr + BMIPS_RELO_VECTOR_CONTROL_1);
+	} else if (cpu_is_bmips5000()) {
+		/*
+		 * 0x8000_0000: reset/NMI (initially in kseg1)
+		 * 0x8000_1000: normal vectors
+		 */
+		new_ebase = 0x80001000;
+		write_c0_brcm_bootvec(0xa0088008);
+		write_c0_ebase(new_ebase);
+		if (max_cpus > 2)
+			bmips_write_zscm_reg(0xa0, 0xa008a008);
+	} else {
+		return;
+	}
+
 	board_nmi_handler_setup = &bmips_nmi_handler_setup;
 	ebase = new_ebase;
 }
-- 
1.7.10.4
