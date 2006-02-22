Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Feb 2006 19:02:45 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:7196 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133530AbWBVTCe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Feb 2006 19:02:34 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1MJ9e6r030028
	for <linux-mips@linux-mips.org>; Wed, 22 Feb 2006 19:09:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1MJ9ej3030027
	for linux-mips@linux-mips.org; Wed, 22 Feb 2006 19:09:40 GMT
Date:	Wed, 22 Feb 2006 19:09:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: [RFC] SMP initialization order fixes.
Message-ID: <20060222190940.GA29967@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

This one should hopefully fix the SMP problems of the resent times.  It
works on Malta with 34K, it seems to work on IP27 (the kernel is
presumably failing due to other issues), so now I'd ask especially
RM9000 & BCM1250 users for testing.  This really needs to be fixed for
2.6.16.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index d86affa..d9293c5 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -540,6 +540,9 @@ void __init setup_arch(char **cmdline_p)
 	sparse_init();
 	paging_init();
 	resource_init();
+#ifdef CONFIG_SMP
+	plat_smp_setup();
+#endif
 }
 
 int __init fpu_disable(char *s)
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 5e18986..06ed907 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -236,7 +236,7 @@ void __init smp_prepare_cpus(unsigned in
 	init_new_context(current, &init_mm);
 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
-	prom_prepare_cpus(max_cpus);
+	plat_prepare_cpus(max_cpus);
 }
 
 /* preload SMP state for boot cpu */
diff --git a/arch/mips/kernel/smp_mt.c b/arch/mips/kernel/smp_mt.c
index c930364..993b8bf 100644
--- a/arch/mips/kernel/smp_mt.c
+++ b/arch/mips/kernel/smp_mt.c
@@ -143,7 +143,7 @@ static struct irqaction irq_call = {
  * Make sure all CPU's are in a sensible state before we boot any of the
  * secondarys
  */
-void prom_prepare_cpus(unsigned int max_cpus)
+void plat_smp_setup(void)
 {
 	unsigned long val;
 	int i, num;
@@ -179,11 +179,9 @@ void prom_prepare_cpus(unsigned int max_
 				write_vpe_c0_vpeconf0(tmp);
 
 				/* Record this as available CPU */
-				if (i < max_cpus) {
-					cpu_set(i, phys_cpu_present_map);
-					__cpu_number_map[i]	= ++num;
-					__cpu_logical_map[num]	= i;
-				}
+				cpu_set(i, phys_cpu_present_map);
+				__cpu_number_map[i]	= ++num;
+				__cpu_logical_map[num]	= i;
 			}
 
 			/* disable multi-threading with TC's */
@@ -241,7 +239,10 @@ void prom_prepare_cpus(unsigned int max_
 		set_vi_handler (MIPS_CPU_IPI_RESCHED_IRQ, ipi_resched_dispatch);
 		set_vi_handler (MIPS_CPU_IPI_CALL_IRQ, ipi_call_dispatch);
 	}
+}
 
+void __init plat_prepare_cpus(unsigned int max_cpus)
+{
 	cpu_ipi_resched_irq = MIPSCPU_INT_BASE + MIPS_CPU_IPI_RESCHED_IRQ;
 	cpu_ipi_call_irq = MIPSCPU_INT_BASE + MIPS_CPU_IPI_CALL_IRQ;
 
diff --git a/arch/mips/pmc-sierra/yosemite/smp.c b/arch/mips/pmc-sierra/yosemite/smp.c
index 7f8fda9..0e903cc 100644
--- a/arch/mips/pmc-sierra/yosemite/smp.c
+++ b/arch/mips/pmc-sierra/yosemite/smp.c
@@ -50,37 +50,25 @@ void __init prom_grab_secondary(void)
  * We don't want to start the secondary CPU yet nor do we have a nice probing
  * feature in PMON so we just assume presence of the secondary core.
  */
-static char maxcpus_string[] __initdata =
-	KERN_WARNING "max_cpus set to 0; using 1 instead\n";
-
-void __init prom_prepare_cpus(unsigned int max_cpus)
+void __init plat_smp_setup(void)
 {
-	int enabled = 0, i;
-
-	if (max_cpus == 0) {
-		printk(maxcpus_string);
-		max_cpus = 1;
-	}
+	int i;
 
 	cpus_clear(phys_cpu_present_map);
 
 	for (i = 0; i < 2; i++) {
-		if (i == max_cpus)
-			break;
-
-		/*
-		 * The boot CPU
-		 */
-		cpu_set(i, phys_cpu_present_map);
+		cpu_set(i, cpu_present_map);
 		__cpu_number_map[i]	= i;
 		__cpu_logical_map[i]	= i;
-		enabled++;
 	}
+}
 
+void __init plat_prepare_cpus(unsigned int max_cpus)
+{
 	/*
 	 * Be paranoid.  Enable the IPI only if we're really about to go SMP.
 	 */
-	if (enabled > 1)
+	if (cpus_weight(cpu_possible_map))
 		set_c0_status(STATUSF_IP5);
 }
 
diff --git a/arch/mips/sgi-ip27/ip27-smp.c b/arch/mips/sgi-ip27/ip27-smp.c
index dbef3f6..09fa7f5 100644
--- a/arch/mips/sgi-ip27/ip27-smp.c
+++ b/arch/mips/sgi-ip27/ip27-smp.c
@@ -140,7 +140,7 @@ static __init void intr_clear_all(nasid_
 		REMOTE_HUB_CLR_INTR(nasid, i);
 }
 
-void __init prom_prepare_cpus(unsigned int max_cpus)
+void __init plat_smp_setup(void)
 {
 	cnodeid_t	cnode;
 
@@ -161,6 +161,11 @@ void __init prom_prepare_cpus(unsigned i
 	alloc_cpupda(0, 0);
 }
 
+void __init plat_prepare_cpus(unsigned int max_cpus)
+{
+	/* We already did everything necessary earlier */
+}
+
 /*
  * Launch a slave into smp_bootstrap().  It doesn't take an argument, and we
  * set sp to the kernel stack of the newly created idle process, gp to the proc
diff --git a/arch/mips/sibyte/cfe/smp.c b/arch/mips/sibyte/cfe/smp.c
index 4477af3..eab20e2 100644
--- a/arch/mips/sibyte/cfe/smp.c
+++ b/arch/mips/sibyte/cfe/smp.c
@@ -31,7 +31,7 @@
  *
  * Common setup before any secondaries are started
  */
-void __init prom_prepare_cpus(unsigned int max_cpus)
+void __init plat_smp_setup(void)
 {
 	int i, num;
 
@@ -40,14 +40,18 @@ void __init prom_prepare_cpus(unsigned i
 	__cpu_number_map[0] = 0;
 	__cpu_logical_map[0] = 0;
 
-	for (i=1, num=0; i<NR_CPUS; i++) {
+	for (i = 1, num = 0; i < NR_CPUS; i++) {
 		if (cfe_cpu_stop(i) == 0) {
 			cpu_set(i, phys_cpu_present_map);
 			__cpu_number_map[i] = ++num;
 			__cpu_logical_map[num] = i;
 		}
 	}
-	printk("Detected %i available secondary CPU(s)\n", num);
+	printk(KERN_INFO "Detected %i available secondary CPU(s)\n", num);
+}
+
+void __init plat_prepare_cpus(unsigned int max_cpus)
+{
 }
 
 /*
diff --git a/include/asm-mips/smp.h b/include/asm-mips/smp.h
index 5618f1e..75c6fe7 100644
--- a/include/asm-mips/smp.h
+++ b/include/asm-mips/smp.h
@@ -58,7 +58,9 @@ static inline int num_booting_cpus(void)
 	return cpus_weight(cpu_callout_map);
 }
 
-/* These are defined by the board-specific code. */
+/*
+ * These are defined by the board-specific code.
+ */
 
 /*
  * Cause the function described by call_data to be executed on the passed
@@ -79,7 +81,12 @@ extern void prom_boot_secondary(int cpu,
 extern void prom_init_secondary(void);
 
 /*
- * Detect available CPUs, populate phys_cpu_present_map before smp_init
+ * Populate cpu_possible_map before smp_init, called from setup_arch.
+ */
+extern void plat_smp_setup(void);
+
+/*
+ * Called after init_IRQ but before __cpu_up.
  */
 extern void prom_prepare_cpus(unsigned int max_cpus);
 
