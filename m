From: Andrew Sharp <tigerand@gmail.com>
Date: Tue, 13 Feb 2007 10:15:21 -0800
Subject: [PATCH] 98% of the changes necessary to support SMP on Sibyte 1250 without CFE.
Message-ID: <20070213181521.W8_OQbYlMZPKb3ucb9YAmWMCIe_euAzKEwA0dGYx2DQ@z>

Unfortunately I had to move on before getting to the last 2% but it will
be a lot easier for someone to add it now if they want it.  Including
myself if I'm able to get back to it later.

Fixed the odd whitespace/formatting violation as well.

Signed-off-by: Andrew Sharp <tigerand@gmail.com>
---
 arch/mips/kernel/head.S        |    2 +-
 arch/mips/sibyte/sb1250/prom.c |   98 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 9a7811d..1e44f3c 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -138,7 +138,7 @@
 EXPORT(stext)					# used for profiling
 EXPORT(_stext)
 
-#ifdef CONFIG_MIPS_SIM
+#if defined(CONFIG_MIPS_SIM) || !defined(CONFIG_SIBYTE_CFE)
 	/*
 	 * Give us a fighting chance of running if execution beings at the
 	 * kernel load address.  This is needed because this platform does
diff --git a/arch/mips/sibyte/sb1250/prom.c b/arch/mips/sibyte/sb1250/prom.c
index 3c33a45..d925c0f 100644
--- a/arch/mips/sibyte/sb1250/prom.c
+++ b/arch/mips/sibyte/sb1250/prom.c
@@ -30,6 +30,15 @@
 
 #define MAX_RAM_SIZE ((CONFIG_SIBYTE_STANDALONE_RAM_SIZE * 1024 * 1024) - 1)
 
+#ifdef CONFIG_SMP
+# define LAUNCHSTACK_SIZE 256
+static unsigned long secondary_sp __initdata;
+static unsigned long secondary_gp __initdata;
+
+static unsigned char launchstack[LAUNCHSTACK_SIZE] __initdata
+	__attribute__((aligned(2 * sizeof(long))));
+#endif
+
 static __init void prom_meminit(void)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -52,6 +61,9 @@ static __init void prom_meminit(void)
 			  (CONFIG_SIBYTE_STANDALONE_RAM_SIZE * 1024 * 1024) - initrd_pend,
 			  BOOT_MEM_RAM);
 #else
+	/*
+	 * add your hardcoded memory configuration here or above
+	 */
 	add_memory_region(0, CONFIG_SIBYTE_STANDALONE_RAM_SIZE * 1024 * 1024,
 			  BOOT_MEM_RAM);
 #endif
@@ -66,7 +78,7 @@ static void prom_linux_exit(void)
 {
 #ifdef CONFIG_SMP
 	if (smp_processor_id()) {
-		smp_call_function(prom_cpu0_exit,NULL,1,1);
+		smp_call_function(prom_cpu0_exit, NULL, 1, 1);
 	}
 #endif
 	while(1);
@@ -81,8 +93,6 @@ void __init prom_init(void)
 	_machine_halt      = prom_linux_exit;
 	pm_power_off = prom_linux_exit;
 
-	strcpy(arcs_cmdline, "root=/dev/ram0 ");
-
 	mips_machgroup = MACH_GROUP_SIBYTE;
 	prom_meminit();
 }
@@ -93,6 +103,88 @@ unsigned long __init prom_free_prom_memory(void)
 	return 0;
 }
 
+#if defined(CONFIG_SMP)
+/*
+ * Assume cpus are already set up by whatever prom is in the system.
+ * Set up phys_cpu_present_map and the logical/physical mappings.
+ * XXXKW will the boot CPU ever not be physical 0?
+ *
+ * Common setup before any secondaries are started
+ */
+void __init plat_smp_setup(void)
+{
+	int i, num;
+
+	cpus_clear(phys_cpu_present_map);
+	cpu_set(0, phys_cpu_present_map);
+	__cpu_number_map[0] = 0;
+	__cpu_logical_map[0] = 0;
+
+	for (i = 1, num = 0; i < NR_CPUS; i++) {
+		cpu_set(i, phys_cpu_present_map);
+		__cpu_number_map[i] = ++num;
+		__cpu_logical_map[num] = i;
+	}
+	printk(KERN_INFO "Detected %i available secondary CPU(s)\n", num);
+}
+
+static void __init prom_smp_bootstrap(void)
+{
+	local_irq_disable();
+
+	__asm__ __volatile__(
+	"	move	$sp, %0		\n"
+	"	move	$gp, %1		\n"
+	"	j	smp_bootstrap	\n"
+	:
+	: "r" (secondary_sp), "r" (secondary_gp));
+}
+
+void __init plat_prepare_cpus(unsigned int max_cpus)
+{
+}
+
+
+void prom_smp_finish(void)
+{
+	extern void sb1250_smp_finish(void);
+	sb1250_smp_finish();
+}
+
+void __init prom_init_secondary(void)
+{
+	extern void sb1250_smp_init(void);
+	sb1250_smp_init();
+}
+
+/*
+ * get idle task running on secondary cpu.
+ */
+void prom_boot_secondary(int cpu, struct task_struct *idle)
+{
+	unsigned long gp = (unsigned long) task_thread_info(idle);
+	unsigned long sp = __KSTK_TOS(idle);
+
+	secondary_sp = sp;
+	secondary_gp = gp;
+
+/*
+ * don't have a prom_cpustart just yet...
+
+	prom_cpustart(cpu, &prom_smp_bootstrap, launchstack + LAUNCHSTACK_SIZE, 0);
+
+ */
+}
+
+/*
+ * Final cleanup after all secondaries booted
+ */
+void prom_cpus_done(void)
+{
+}
+
+#endif /* CONFIG_SMP */
+
 void prom_putchar(char c)
 {
 }
-- 
1.4.4.4


--UugvWAfsgieZRqgk--
