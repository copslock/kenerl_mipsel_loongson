From: Kevin D. Kissell <kevink@paralogos.com>
Date: Tue, 9 Sep 2008 21:48:52 +0200
Subject: [PATCH] Rework of SMTC support to make it work with the new clock event
 system, allowing "tickless" operation, and to make it compatible
 with the use of the "wait_irqoff" idle loop.  The new clocking
 scheme means that the previously optional IPI instant replay
 mechanism is now required, and has been made more robust.
 Signed-off-by: Kevin D. Kissell <kevink@paralogos.com>
Message-ID: <20080909194852.Spfq6S4yjfPGeFC9ejSQphrJlzkOacR6FiKQ6w7mi6s@z>

---
 arch/mips/Kconfig                        |   26 +--
 arch/mips/kernel/Makefile                |    1 +
 arch/mips/kernel/cevt-r4k.c              |  173 +++++------------
 arch/mips/kernel/cevt-smtc.c             |  321 ++++++++++++++++++++++++++++++
 arch/mips/kernel/cpu-probe.c             |   10 +-
 arch/mips/kernel/genex.S                 |    4 +-
 arch/mips/kernel/smtc.c                  |  254 +++++++++++++-----------
 arch/mips/mips-boards/malta/malta_smtc.c |    9 +-
 include/asm-mips/cevt-r4k.h              |   46 +++++
 include/asm-mips/irqflags.h              |   26 ++-
 include/asm-mips/smtc.h                  |    8 +-
 11 files changed, 598 insertions(+), 280 deletions(-)
 create mode 100644 arch/mips/kernel/cevt-smtc.c
 create mode 100644 include/asm-mips/cevt-r4k.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 24c5dee..30e6cdd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1496,7 +1496,6 @@ config MIPS_MT_SMTC
 	depends on CPU_MIPS32_R2
 	#depends on CPU_MIPS64_R2		# once there is hardware ...
 	depends on SYS_SUPPORTS_MULTITHREADING
-	select GENERIC_CLOCKEVENTS_BROADCAST
 	select CPU_MIPSR2_IRQ_VI
 	select CPU_MIPSR2_IRQ_EI
 	select MIPS_MT
@@ -1544,32 +1543,17 @@ config MIPS_VPE_LOADER
 	  Includes a loader for loading an elf relocatable object
 	  onto another VPE and running it.
 
-config MIPS_MT_SMTC_INSTANT_REPLAY
-	bool "Low-latency Dispatch of Deferred SMTC IPIs"
-	depends on MIPS_MT_SMTC && !PREEMPT
-	default y
-	help
-	  SMTC pseudo-interrupts between TCs are deferred and queued
-	  if the target TC is interrupt-inhibited (IXMT). In the first
-	  SMTC prototypes, these queued IPIs were serviced on return
-	  to user mode, or on entry into the kernel idle loop. The
-	  INSTANT_REPLAY option dispatches them as part of local_irq_restore()
-	  processing, which adds runtime overhead (hence the option to turn
-	  it off), but ensures that IPIs are handled promptly even under
-	  heavy I/O interrupt load.
-
 config MIPS_MT_SMTC_IM_BACKSTOP
 	bool "Use per-TC register bits as backstop for inhibited IM bits"
 	depends on MIPS_MT_SMTC
-	default y
+	default n
 	help
 	  To support multiple TC microthreads acting as "CPUs" within
 	  a VPE, VPE-wide interrupt mask bits must be specially manipulated
 	  during interrupt handling. To support legacy drivers and interrupt
 	  controller management code, SMTC has a "backstop" to track and
 	  if necessary restore the interrupt mask. This has some performance
-	  impact on interrupt service overhead. Disable it only if you know
-	  what you are doing.
+	  impact on interrupt service overhead.
 
 config MIPS_MT_SMTC_IRQAFF
 	bool "Support IRQ affinity API"
@@ -1579,10 +1563,8 @@ config MIPS_MT_SMTC_IRQAFF
 	  Enables SMP IRQ affinity API (/proc/irq/*/smp_affinity, etc.)
 	  for SMTC Linux kernel. Requires platform support, of which
 	  an example can be found in the MIPS kernel i8259 and Malta
-	  platform code.  It is recommended that MIPS_MT_SMTC_INSTANT_REPLAY
-	  be enabled if MIPS_MT_SMTC_IRQAFF is used. Adds overhead to
-	  interrupt dispatch, and should be used only if you know what
-	  you are doing.
+	  platform code.  Adds some overhead to interrupt dispatch, and 
+	  should be used only if you know what you are doing.
 
 config MIPS_VPE_LOADER_TOM
 	bool "Load VPE program into memory hidden from linux"
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 65e46a6..4710a6d 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -10,6 +10,7 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
 obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
+obj-$(CONFIG_MIPS_MT_SMTC)	+= cevt-smtc.o
 obj-$(CONFIG_CEVT_DS1287)	+= cevt-ds1287.o
 obj-$(CONFIG_CEVT_GT641XX)	+= cevt-gt641xx.o
 obj-$(CONFIG_CEVT_SB1250)	+= cevt-sb1250.o
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 24a2d90..4a4c59f 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -12,6 +12,14 @@
 
 #include <asm/smtc_ipi.h>
 #include <asm/time.h>
+#include <asm/cevt-r4k.h>
+
+/*
+ * The SMTC Kernel for the 34K, 1004K, et. al. replaces several
+ * of these routines with SMTC-specific variants.
+ */
+
+#ifndef CONFIG_MIPS_MT_SMTC
 
 static int mips_next_event(unsigned long delta,
                            struct clock_event_device *evt)
@@ -19,60 +27,27 @@ static int mips_next_event(unsigned long delta,
 	unsigned int cnt;
 	int res;
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	{
-	unsigned long flags, vpflags;
-	local_irq_save(flags);
-	vpflags = dvpe();
-#endif
 	cnt = read_c0_count();
 	cnt += delta;
 	write_c0_compare(cnt);
 	res = ((int)(read_c0_count() - cnt) > 0) ? -ETIME : 0;
-#ifdef CONFIG_MIPS_MT_SMTC
-	evpe(vpflags);
-	local_irq_restore(flags);
-	}
-#endif
 	return res;
 }
 
-static void mips_set_mode(enum clock_event_mode mode,
-                          struct clock_event_device *evt)
+#endif /* CONFIG_MIPS_MT_SMTC */
+
+void mips_set_clock_mode(enum clock_event_mode mode,
+				struct clock_event_device *evt)
 {
 	/* Nothing to do ...  */
 }
 
-static DEFINE_PER_CPU(struct clock_event_device, mips_clockevent_device);
-static int cp0_timer_irq_installed;
+DEFINE_PER_CPU(struct clock_event_device, mips_clockevent_device);
+int cp0_timer_irq_installed;
 
-/*
- * Timer ack for an R4k-compatible timer of a known frequency.
- */
-static void c0_timer_ack(void)
-{
-	write_c0_compare(read_c0_compare());
-}
+#ifndef CONFIG_MIPS_MT_SMTC
 
-/*
- * Possibly handle a performance counter interrupt.
- * Return true if the timer interrupt should not be checked
- */
-static inline int handle_perf_irq(int r2)
-{
-	/*
-	 * The performance counter overflow interrupt may be shared with the
-	 * timer interrupt (cp0_perfcount_irq < 0). If it is and a
-	 * performance counter has overflowed (perf_irq() == IRQ_HANDLED)
-	 * and we can't reliably determine if a counter interrupt has also
-	 * happened (!r2) then don't check for a timer interrupt.
-	 */
-	return (cp0_perfcount_irq < 0) &&
-		perf_irq() == IRQ_HANDLED &&
-		!r2;
-}
-
-static irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
+irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
 {
 	const int r2 = cpu_has_mips_r2;
 	struct clock_event_device *cd;
@@ -93,12 +68,8 @@ static irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
 	 * interrupt.  Being the paranoiacs we are we check anyway.
 	 */
 	if (!r2 || (read_c0_cause() & (1 << 30))) {
-		c0_timer_ack();
-#ifdef CONFIG_MIPS_MT_SMTC
-		if (cpu_data[cpu].vpe_id)
-			goto out;
-		cpu = 0;
-#endif
+		/* Clear Count/Compare Interrupt */
+		write_c0_compare(read_c0_compare());
 		cd = &per_cpu(mips_clockevent_device, cpu);
 		cd->event_handler(cd);
 	}
@@ -107,65 +78,16 @@ out:
 	return IRQ_HANDLED;
 }
 
-static struct irqaction c0_compare_irqaction = {
+#endif /* Not CONFIG_MIPS_MT_SMTC */
+
+struct irqaction c0_compare_irqaction = {
 	.handler = c0_compare_interrupt,
-#ifdef CONFIG_MIPS_MT_SMTC
-	.flags = IRQF_DISABLED,
-#else
 	.flags = IRQF_DISABLED | IRQF_PERCPU,
-#endif
 	.name = "timer",
 };
 
-#ifdef CONFIG_MIPS_MT_SMTC
-DEFINE_PER_CPU(struct clock_event_device, smtc_dummy_clockevent_device);
-
-static void smtc_set_mode(enum clock_event_mode mode,
-                          struct clock_event_device *evt)
-{
-}
-
-static void mips_broadcast(cpumask_t mask)
-{
-	unsigned int cpu;
-
-	for_each_cpu_mask(cpu, mask)
-		smtc_send_ipi(cpu, SMTC_CLOCK_TICK, 0);
-}
-
-static void setup_smtc_dummy_clockevent_device(void)
-{
-	//uint64_t mips_freq = mips_hpt_^frequency;
-	unsigned int cpu = smp_processor_id();
-	struct clock_event_device *cd;
 
-	cd = &per_cpu(smtc_dummy_clockevent_device, cpu);
-
-	cd->name		= "SMTC";
-	cd->features		= CLOCK_EVT_FEAT_DUMMY;
-
-	/* Calculate the min / max delta */
-	cd->mult	= 0; //div_sc((unsigned long) mips_freq, NSEC_PER_SEC, 32);
-	cd->shift		= 0; //32;
-	cd->max_delta_ns	= 0; //clockevent_delta2ns(0x7fffffff, cd);
-	cd->min_delta_ns	= 0; //clockevent_delta2ns(0x30, cd);
-
-	cd->rating		= 200;
-	cd->irq			= 17; //-1;
-//	if (cpu)
-//		cd->cpumask	= CPU_MASK_ALL; // cpumask_of_cpu(cpu);
-//	else
-		cd->cpumask	= cpumask_of_cpu(cpu);
-
-	cd->set_mode		= smtc_set_mode;
-
-	cd->broadcast		= mips_broadcast;
-
-	clockevents_register_device(cd);
-}
-#endif
-
-static void mips_event_handler(struct clock_event_device *dev)
+void mips_event_handler(struct clock_event_device *dev)
 {
 }
 
@@ -177,7 +99,23 @@ static int c0_compare_int_pending(void)
 	return (read_c0_cause() >> cp0_compare_irq) & 0x100;
 }
 
-static int c0_compare_int_usable(void)
+/*
+ * Compare interrupt can be routed and latched outside the core,
+ * so a single execution hazard barrier may not be enough to give
+ * it time to clear as seen in the Cause register.  4 time the
+ * pipeline depth seems reasonably conservative, and empirically
+ * works better in configurations with high CPU/bus clock ratios.
+ */
+
+#define compare_change_hazard() \
+	do { \
+		irq_disable_hazard(); \
+		irq_disable_hazard(); \
+		irq_disable_hazard(); \
+		irq_disable_hazard(); \
+	} while (0)
+
+int c0_compare_int_usable(void)
 {
 	unsigned int delta;
 	unsigned int cnt;
@@ -187,7 +125,7 @@ static int c0_compare_int_usable(void)
 	 */
 	if (c0_compare_int_pending()) {
 		write_c0_compare(read_c0_count());
-		irq_disable_hazard();
+		compare_change_hazard();
 		if (c0_compare_int_pending())
 			return 0;
 	}
@@ -196,7 +134,7 @@ static int c0_compare_int_usable(void)
 		cnt = read_c0_count();
 		cnt += delta;
 		write_c0_compare(cnt);
-		irq_disable_hazard();
+		compare_change_hazard();
 		if ((int)(read_c0_count() - cnt) < 0)
 		    break;
 		/* increase delta if the timer was already expired */
@@ -205,11 +143,12 @@ static int c0_compare_int_usable(void)
 	while ((int)(read_c0_count() - cnt) <= 0)
 		;	/* Wait for expiry  */
 
+	compare_change_hazard();
 	if (!c0_compare_int_pending())
 		return 0;
 
 	write_c0_compare(read_c0_count());
-	irq_disable_hazard();
+	compare_change_hazard();
 	if (c0_compare_int_pending())
 		return 0;
 
@@ -219,6 +158,8 @@ static int c0_compare_int_usable(void)
 	return 1;
 }
 
+#ifndef CONFIG_MIPS_MT_SMTC
+
 int __cpuinit mips_clockevent_init(void)
 {
 	uint64_t mips_freq = mips_hpt_frequency;
@@ -229,17 +170,6 @@ int __cpuinit mips_clockevent_init(void)
 	if (!cpu_has_counter || !mips_hpt_frequency)
 		return -ENXIO;
 
-#ifdef CONFIG_MIPS_MT_SMTC
-	setup_smtc_dummy_clockevent_device();
-
-	/*
-	 * On SMTC we only register VPE0's compare interrupt as clockevent
-	 * device.
-	 */
-	if (cpu)
-		return 0;
-#endif
-
 	if (!c0_compare_int_usable())
 		return -ENXIO;
 
@@ -265,13 +195,9 @@ int __cpuinit mips_clockevent_init(void)
 
 	cd->rating		= 300;
 	cd->irq			= irq;
-#ifdef CONFIG_MIPS_MT_SMTC
-	cd->cpumask		= CPU_MASK_ALL;
-#else
 	cd->cpumask		= cpumask_of_cpu(cpu);
-#endif
 	cd->set_next_event	= mips_next_event;
-	cd->set_mode		= mips_set_mode;
+	cd->set_mode		= mips_set_clock_mode;
 	cd->event_handler	= mips_event_handler;
 
 	clockevents_register_device(cd);
@@ -281,12 +207,9 @@ int __cpuinit mips_clockevent_init(void)
 
 	cp0_timer_irq_installed = 1;
 
-#ifdef CONFIG_MIPS_MT_SMTC
-#define CPUCTR_IMASKBIT (0x100 << cp0_compare_irq)
-	setup_irq_smtc(irq, &c0_compare_irqaction, CPUCTR_IMASKBIT);
-#else
 	setup_irq(irq, &c0_compare_irqaction);
-#endif
 
 	return 0;
 }
+
+#endif /* Not CONFIG_MIPS_MT_SMTC */
diff --git a/arch/mips/kernel/cevt-smtc.c b/arch/mips/kernel/cevt-smtc.c
new file mode 100644
index 0000000..5162fe4
--- /dev/null
+++ b/arch/mips/kernel/cevt-smtc.c
@@ -0,0 +1,321 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2007 MIPS Technologies, Inc.
+ * Copyright (C) 2007 Ralf Baechle <ralf@linux-mips.org>
+ * Copyright (C) 2008 Kevin D. Kissell, Paralogos sarl
+ */
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/percpu.h>
+
+#include <asm/smtc_ipi.h>
+#include <asm/time.h>
+#include <asm/cevt-r4k.h>
+
+/*
+ * Variant clock event timer support for SMTC on MIPS 34K, 1004K
+ * or other MIPS MT cores.
+ *
+ * Notes on SMTC Support:
+ *
+ * SMTC has multiple microthread TCs pretending to be Linux CPUs.
+ * But there's only one Count/Compare pair per VPE, and Compare
+ * interrupts are taken opportunisitically by available TCs
+ * bound to the VPE with the Count register.  The new timer
+ * framework provides for global broadcasts, but we really
+ * want VPE-level multicasts for best behavior. So instead
+ * of invoking the high-level clock-event broadcast code,
+ * this version of SMTC support uses the historical SMTC
+ * multicast mechanisms "under the hood", appearing to the
+ * generic clock layer as if the interrupts are per-CPU.
+ *
+ * The approach taken here is to maintain a set of NR_CPUS
+ * virtual timers, and track which "CPU" needs to be alerted
+ * at each event.
+ *
+ * It's unlikely that we'll see a MIPS MT core with more than
+ * 2 VPEs, but we *know* that we won't need to handle more
+ * VPEs than we have "CPUs".  So NCPUs arrays of NCPUs elements
+ * is always going to be overkill, but always going to be enough.
+ */
+
+unsigned long smtc_nexttime[NR_CPUS][NR_CPUS];
+static int smtc_nextinvpe[NR_CPUS];
+
+/*
+ * Timestamps stored are absolute values to be programmed
+ * into Count register.  Valid timestamps will never be zero.
+ * If a Zero Count value is actually calculated, it is converted
+ * to be a 1, which will introduce 1 or two CPU cycles of error
+ * roughly once every four billion events, which at 1000 HZ means
+ * about once every 50 days.  If that's actually a problem, one
+ * could alternate squashing 0 to 1 and to -1.
+ */
+
+#define MAKEVALID(x) (((x) == 0L) ? 1L : (x))
+#define ISVALID(x) ((x) != 0L)
+
+/*
+ * Time comparison is subtle, as it's really truncated
+ * modular arithmetic.
+ */
+
+#define IS_SOONER(a, b, reference) \
+    (((a) - (unsigned long)(reference)) < ((b) - (unsigned long)(reference)))
+
+/*
+ * CATCHUP_INCREMENT, used when the function falls behind the counter.
+ * Could be an increasing function instead of a constant;
+ */
+
+#define CATCHUP_INCREMENT 64
+
+static int mips_next_event(unsigned long delta,
+				struct clock_event_device *evt)
+{
+	unsigned long flags;
+	unsigned int mtflags;
+	unsigned long timestamp, reference, previous;
+	unsigned long nextcomp = 0L;
+	int vpe = current_cpu_data.vpe_id;
+	int cpu = smp_processor_id();
+	local_irq_save(flags);
+	mtflags = dmt();
+
+	/*
+	 * Maintain the per-TC virtual timer
+	 * and program the per-VPE shared Count register
+	 * as appropriate here...
+	 */
+	reference = (unsigned long)read_c0_count();
+	timestamp = MAKEVALID(reference + delta);
+	/*
+	 * To really model the clock, we have to catch the case
+	 * where the current next-in-VPE timestamp is the old
+	 * timestamp for the calling CPE, but the new value is
+	 * in fact later.  In that case, we have to do a full
+	 * scan and discover the new next-in-VPE CPU id and
+	 * timestamp.
+	 */
+	previous = smtc_nexttime[vpe][cpu];
+	if (cpu == smtc_nextinvpe[vpe] && ISVALID(previous)
+	    && IS_SOONER(previous, timestamp, reference)) {
+		int i;
+		int soonest = cpu;
+
+		/*
+		 * Update timestamp array here, so that new
+		 * value gets considered along with those of
+		 * other virtual CPUs on the VPE.
+		 */
+		smtc_nexttime[vpe][cpu] = timestamp;
+		for_each_online_cpu(i) {
+			if (ISVALID(smtc_nexttime[vpe][i])
+			    && IS_SOONER(smtc_nexttime[vpe][i],
+				smtc_nexttime[vpe][soonest], reference)) {
+				    soonest = i;
+			}
+		}
+		smtc_nextinvpe[vpe] = soonest;
+		nextcomp = smtc_nexttime[vpe][soonest];
+	/*
+	 * Otherwise, we don't have to process the whole array rank,
+	 * we just have to see if the event horizon has gotten closer.
+	 */
+	} else {
+		if (!ISVALID(smtc_nexttime[vpe][smtc_nextinvpe[vpe]]) ||
+		    IS_SOONER(timestamp,
+			smtc_nexttime[vpe][smtc_nextinvpe[vpe]], reference)) {
+			    smtc_nextinvpe[vpe] = cpu;
+			    nextcomp = timestamp;
+		}
+		/*
+		 * Since next-in-VPE may me the same as the executing
+		 * virtual CPU, we update the array *after* checking
+		 * its value.
+		 */
+		smtc_nexttime[vpe][cpu] = timestamp;
+	}
+
+	/*
+	 * It may be that, in fact, we don't need to update Compare,
+	 * but if we do, we want to make sure we didn't fall into
+	 * a crack just behind Count.
+	 */
+	if (ISVALID(nextcomp)) {
+		write_c0_compare(nextcomp);
+		ehb();
+		/*
+		 * We never return an error, we just make sure
+		 * that we trigger the handlers as quickly as
+		 * we can if we fell behind.
+		 */
+		while ((nextcomp - (unsigned long)read_c0_count())
+			> (unsigned long)LONG_MAX) {
+			nextcomp += CATCHUP_INCREMENT;
+			write_c0_compare(nextcomp);
+			ehb();
+		}
+	}
+	emt(mtflags);
+	local_irq_restore(flags);
+	return 0;
+}
+
+
+void smtc_distribute_timer(int vpe)
+{
+	unsigned long flags;
+	unsigned int mtflags;
+	int cpu;
+	struct clock_event_device *cd;
+	unsigned long nextstamp = 0L;
+	unsigned long reference;
+
+
+repeat:
+	for_each_online_cpu(cpu) {
+	    /*
+	     * Find virtual CPUs within the current VPE who have
+	     * unserviced timer requests whose time is now past.
+	     */
+	    local_irq_save(flags);
+	    mtflags = dmt();
+	    if (cpu_data[cpu].vpe_id == vpe &&
+		ISVALID(smtc_nexttime[vpe][cpu])) {
+		reference = (unsigned long)read_c0_count();
+		if ((smtc_nexttime[vpe][cpu] - reference)
+			 > (unsigned long)LONG_MAX) {
+			    smtc_nexttime[vpe][cpu] = 0L;
+			    emt(mtflags);
+			    local_irq_restore(flags);
+			    /*
+			     * We don't send IPIs to ourself.
+			     */
+			    if (cpu != smp_processor_id()) {
+				smtc_send_ipi(cpu, SMTC_CLOCK_TICK, 0);
+			    } else {
+				cd = &per_cpu(mips_clockevent_device, cpu);
+				cd->event_handler(cd);
+			    }
+		} else {
+			/* Local to VPE but Valid Time not yet reached. */
+			if (!ISVALID(nextstamp) ||
+			    IS_SOONER(smtc_nexttime[vpe][cpu], nextstamp,
+			    reference)) {
+				smtc_nextinvpe[vpe] = cpu;
+				nextstamp = smtc_nexttime[vpe][cpu];
+			}
+			emt(mtflags);
+			local_irq_restore(flags);
+		}
+	    } else {
+		emt(mtflags);
+		local_irq_restore(flags);
+
+	    }
+	}
+	/* Reprogram for interrupt at next soonest timestamp for VPE */
+	if (ISVALID(nextstamp)) {
+		write_c0_compare(nextstamp);
+		ehb();
+		if ((nextstamp - (unsigned long)read_c0_count())
+			> (unsigned long)LONG_MAX)
+				goto repeat;
+	}
+}
+
+
+irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
+{
+	int cpu = smp_processor_id();
+
+	/* If we're running SMTC, we've got MIPS MT and therefore MIPS32R2 */
+	handle_perf_irq(1);
+
+	if (read_c0_cause() & (1 << 30)) {
+		/* Clear Count/Compare Interrupt */
+		write_c0_compare(read_c0_compare());
+		smtc_distribute_timer(cpu_data[cpu].vpe_id);
+	}
+	return IRQ_HANDLED;
+}
+
+
+int __cpuinit mips_clockevent_init(void)
+{
+	uint64_t mips_freq = mips_hpt_frequency;
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *cd;
+	unsigned int irq;
+	int i;
+	int j;
+
+	if (!cpu_has_counter || !mips_hpt_frequency)
+		return -ENXIO;
+	if (cpu == 0) {
+		for (i = 0; i < num_possible_cpus(); i++) {
+			smtc_nextinvpe[i] = 0;
+			for (j = 0; j < num_possible_cpus(); j++)
+				smtc_nexttime[i][j] = 0L;
+		}
+		/*
+		 * SMTC also can't have the usablility test
+		 * run by secondary TCs once Compare is in use.
+		 */
+		if (!c0_compare_int_usable())
+			return -ENXIO;
+	}
+
+	/*
+	 * With vectored interrupts things are getting platform specific.
+	 * get_c0_compare_int is a hook to allow a platform to return the
+	 * interrupt number of it's liking.
+	 */
+	irq = MIPS_CPU_IRQ_BASE + cp0_compare_irq;
+	if (get_c0_compare_int)
+		irq = get_c0_compare_int();
+
+	cd = &per_cpu(mips_clockevent_device, cpu);
+
+	cd->name		= "MIPS";
+	cd->features		= CLOCK_EVT_FEAT_ONESHOT;
+
+	/* Calculate the min / max delta */
+	cd->mult	= div_sc((unsigned long) mips_freq, NSEC_PER_SEC, 32);
+	cd->shift		= 32;
+	cd->max_delta_ns	= clockevent_delta2ns(0x7fffffff, cd);
+	cd->min_delta_ns	= clockevent_delta2ns(0x300, cd);
+
+	cd->rating		= 300;
+	cd->irq			= irq;
+	cd->cpumask		= cpumask_of_cpu(cpu);
+	cd->set_next_event	= mips_next_event;
+	cd->set_mode		= mips_set_clock_mode;
+	cd->event_handler	= mips_event_handler;
+
+	clockevents_register_device(cd);
+
+	/*
+	 * On SMTC we only want to do the data structure
+	 * initialization and IRQ setup once.
+	 */
+	if (cpu)
+		return 0;
+	/*
+	 * And we need the hwmask associated with the c0_compare
+	 * vector to be initialized.
+	 */
+	irq_hwmask[irq] = (0x100 << cp0_compare_irq);
+	if (cp0_timer_irq_installed)
+		return 0;
+
+	cp0_timer_irq_installed = 1;
+
+	setup_irq(irq, &c0_compare_irqaction);
+
+	return 0;
+}
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 335a6ae..537caec 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -65,14 +65,18 @@ static void r4k_wait(void)
  * interrupt is requested" restriction in the MIPS32/MIPS64 architecture makes
  * using this version a gamble.
  */
-static void r4k_wait_irqoff(void)
+void r4k_wait_irqoff(void)
 {
 	local_irq_disable();
 	if (!need_resched())
-		__asm__("	.set	mips3		\n"
+		__asm__("	.set	push		\n"
+			"	.set	mips3		\n"
 			"	wait			\n"
-			"	.set	mips0		\n");
+			"	.set	pop		\n");
 	local_irq_enable();
+	__asm__(" 	.globl __pastwait	\n"
+		"__pastwait:			\n");
+	return;
 }
 
 /*
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index c6ada98..4f25712 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -245,8 +245,8 @@ NESTED(except_vec_vi_handler, 0, sp)
 	and	t0, a0, t1
 #ifdef CONFIG_MIPS_MT_SMTC_IM_BACKSTOP
 	mfc0	t2, CP0_TCCONTEXT
-	or	t0, t0, t2
-	mtc0	t0, CP0_TCCONTEXT
+	or	t2, t0, t2
+	mtc0	t2, CP0_TCCONTEXT
 #endif /* CONFIG_MIPS_MT_SMTC_IM_BACKSTOP */
 	xor	t1, t1, t0
 	mtc0	t1, CP0_STATUS
diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index 3e86318..9685a64 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -1,4 +1,21 @@
-/* Copyright (C) 2004 Mips Technologies, Inc */
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * Copyright (C) 2004 Mips Technologies, Inc
+ * Copyright (C) 2008 Kevin D. Kissell
+ */
 
 #include <linux/clockchips.h>
 #include <linux/kernel.h>
@@ -21,7 +38,6 @@
 #include <asm/time.h>
 #include <asm/addrspace.h>
 #include <asm/smtc.h>
-#include <asm/smtc_ipi.h>
 #include <asm/smtc_proc.h>
 
 /*
@@ -58,11 +74,6 @@ unsigned long irq_hwmask[NR_IRQS];
 
 asiduse smtc_live_asid[MAX_SMTC_TLBS][MAX_SMTC_ASIDS];
 
-/*
- * Clock interrupt "latch" buffers, per "CPU"
- */
-
-static atomic_t ipi_timer_latch[NR_CPUS];
 
 /*
  * Number of InterProcessor Interrupt (IPI) message buffers to allocate
@@ -70,7 +81,7 @@ static atomic_t ipi_timer_latch[NR_CPUS];
 
 #define IPIBUF_PER_CPU 4
 
-static struct smtc_ipi_q IPIQ[NR_CPUS];
+struct smtc_ipi_q IPIQ[NR_CPUS];
 static struct smtc_ipi_q freeIPIq;
 
 
@@ -282,7 +293,7 @@ static void smtc_configure_tlb(void)
  * phys_cpu_present_map and the logical/physical mappings.
  */
 
-int __init mipsmt_build_cpu_map(int start_cpu_slot)
+int __init smtc_build_cpu_map(int start_cpu_slot)
 {
 	int i, ntcs;
 
@@ -325,7 +336,12 @@ static void smtc_tc_setup(int vpe, int tc, int cpu)
 	write_tc_c0_tcstatus((read_tc_c0_tcstatus()
 			& ~(TCSTATUS_TKSU | TCSTATUS_DA | TCSTATUS_IXMT))
 			| TCSTATUS_A);
-	write_tc_c0_tccontext(0);
+	/*
+	 * TCContext gets an offset from the base of the IPIQ array
+	 * to be used in low-level code to detect the presence of
+	 * an active IPI queue
+	 */
+	write_tc_c0_tccontext((sizeof(struct smtc_ipi_q) * cpu) << 16);
 	/* Bind tc to vpe */
 	write_tc_c0_tcbind(vpe);
 	/* In general, all TCs should have the same cpu_data indications */
@@ -336,10 +352,18 @@ static void smtc_tc_setup(int vpe, int tc, int cpu)
 		cpu_data[cpu].options &= ~MIPS_CPU_FPU;
 	cpu_data[cpu].vpe_id = vpe;
 	cpu_data[cpu].tc_id = tc;
+	/* Multi-core SMTC hasn't been tested, but be prepared */
+	cpu_data[cpu].core = (read_vpe_c0_ebase() >> 1) & 0xff;
 }
 
+/*
+ * Tweak to get Count registes in as close a sync as possible.
+ * Value seems good for 34K-class cores.
+ */
+
+#define CP0_SKEW 8
 
-void mipsmt_prepare_cpus(void)
+void smtc_prepare_cpus(int cpus)
 {
 	int i, vpe, tc, ntc, nvpe, tcpervpe[NR_CPUS], slop, cpu;
 	unsigned long flags;
@@ -363,13 +387,13 @@ void mipsmt_prepare_cpus(void)
 		IPIQ[i].head = IPIQ[i].tail = NULL;
 		spin_lock_init(&IPIQ[i].lock);
 		IPIQ[i].depth = 0;
-		atomic_set(&ipi_timer_latch[i], 0);
 	}
 
 	/* cpu_data index starts at zero */
 	cpu = 0;
 	cpu_data[cpu].vpe_id = 0;
 	cpu_data[cpu].tc_id = 0;
+	cpu_data[cpu].core = (read_c0_ebase() >> 1) & 0xff;
 	cpu++;
 
 	/* Report on boot-time options */
@@ -484,7 +508,8 @@ void mipsmt_prepare_cpus(void)
 			write_vpe_c0_compare(0);
 			/* Propagate Config7 */
 			write_vpe_c0_config7(read_c0_config7());
-			write_vpe_c0_count(read_c0_count());
+			write_vpe_c0_count(read_c0_count() + CP0_SKEW);
+			ehb();
 		}
 		/* enable multi-threading within VPE */
 		write_vpe_c0_vpecontrol(read_vpe_c0_vpecontrol() | VPECONTROL_TE);
@@ -585,24 +610,22 @@ void __cpuinit smtc_boot_secondary(int cpu, struct task_struct *idle)
 
 void smtc_init_secondary(void)
 {
-	/*
-	 * Start timer on secondary VPEs if necessary.
-	 * plat_timer_setup has already have been invoked by init/main
-	 * on "boot" TC.  Like per_cpu_trap_init() hack, this assumes that
-	 * SMTC init code assigns TCs consdecutively and in ascending order
-	 * to across available VPEs.
-	 */
-	if (((read_c0_tcbind() & TCBIND_CURTC) != 0) &&
-	    ((read_c0_tcbind() & TCBIND_CURVPE)
-	    != cpu_data[smp_processor_id() - 1].vpe_id)){
-		write_c0_compare(read_c0_count() + mips_hpt_frequency/HZ);
-	}
-
 	local_irq_enable();
 }
 
 void smtc_smp_finish(void)
 {
+	int cpu = smp_processor_id();
+
+	/*
+	 * Lowest-numbered CPU per VPE starts a clock tick.
+	 * Like per_cpu_trap_init() hack, this assumes that
+	 * SMTC init code assigns TCs consdecutively and
+	 * in ascending order across available VPEs.
+	 */
+	if (cpu > 0 && (cpu_data[cpu].vpe_id != cpu_data[cpu - 1].vpe_id))
+		write_c0_compare(read_c0_count() + mips_hpt_frequency/HZ);
+
 	printk("TC %d going on-line as CPU %d\n",
 		cpu_data[smp_processor_id()].tc_id, smp_processor_id());
 }
@@ -755,6 +778,8 @@ void smtc_send_ipi(int cpu, int type, unsigned int action)
 	struct smtc_ipi *pipi;
 	long flags;
 	int mtflags;
+	unsigned long tcrestart;
+	extern void r4k_wait_irqoff(void), __pastwait(void);
 
 	if (cpu == smp_processor_id()) {
 		printk("Cannot Send IPI to self!\n");
@@ -771,8 +796,6 @@ void smtc_send_ipi(int cpu, int type, unsigned int action)
 	pipi->arg = (void *)action;
 	pipi->dest = cpu;
 	if (cpu_data[cpu].vpe_id != cpu_data[smp_processor_id()].vpe_id) {
-		if (type == SMTC_CLOCK_TICK)
-			atomic_inc(&ipi_timer_latch[cpu]);
 		/* If not on same VPE, enqueue and send cross-VPE interrupt */
 		smtc_ipi_nq(&IPIQ[cpu], pipi);
 		LOCK_CORE_PRA();
@@ -800,22 +823,29 @@ void smtc_send_ipi(int cpu, int type, unsigned int action)
 
 		if ((tcstatus & TCSTATUS_IXMT) != 0) {
 			/*
-			 * Spin-waiting here can deadlock,
-			 * so we queue the message for the target TC.
+			 * If we're in the the irq-off version of the wait
+			 * loop, we need to force exit from the wait and
+			 * do a direct post of the IPI.
+			 */
+			if (cpu_wait == r4k_wait_irqoff) {
+				tcrestart = read_tc_c0_tcrestart();
+				if (tcrestart >= (unsigned long)r4k_wait_irqoff
+				    && tcrestart < (unsigned long)__pastwait) {
+					write_tc_c0_tcrestart(__pastwait);
+					tcstatus &= ~TCSTATUS_IXMT;
+					write_tc_c0_tcstatus(tcstatus);
+					goto postdirect;
+				}
+			}
+			/*
+			 * Otherwise we queue the message for the target TC
+			 * to pick up when he does a local_irq_restore()
 			 */
 			write_tc_c0_tchalt(0);
 			UNLOCK_CORE_PRA();
-			/* Try to reduce redundant timer interrupt messages */
-			if (type == SMTC_CLOCK_TICK) {
-			    if (atomic_postincrement(&ipi_timer_latch[cpu])!=0){
-				smtc_ipi_nq(&freeIPIq, pipi);
-				return;
-			    }
-			}
 			smtc_ipi_nq(&IPIQ[cpu], pipi);
 		} else {
-			if (type == SMTC_CLOCK_TICK)
-				atomic_inc(&ipi_timer_latch[cpu]);
+postdirect:
 			post_direct_ipi(cpu, pipi);
 			write_tc_c0_tchalt(0);
 			UNLOCK_CORE_PRA();
@@ -884,7 +914,7 @@ static void ipi_call_interrupt(void)
 	smp_call_function_interrupt();
 }
 
-DECLARE_PER_CPU(struct clock_event_device, smtc_dummy_clockevent_device);
+DECLARE_PER_CPU(struct clock_event_device, mips_clockevent_device);
 
 void ipi_decode(struct smtc_ipi *pipi)
 {
@@ -892,20 +922,13 @@ void ipi_decode(struct smtc_ipi *pipi)
 	struct clock_event_device *cd;
 	void *arg_copy = pipi->arg;
 	int type_copy = pipi->type;
-	int ticks;
-
 	smtc_ipi_nq(&freeIPIq, pipi);
 	switch (type_copy) {
 	case SMTC_CLOCK_TICK:
 		irq_enter();
 		kstat_this_cpu.irqs[MIPS_CPU_IRQ_BASE + 1]++;
-		cd = &per_cpu(smtc_dummy_clockevent_device, cpu);
-		ticks = atomic_read(&ipi_timer_latch[cpu]);
-		atomic_sub(ticks, &ipi_timer_latch[cpu]);
-		while (ticks) {
-			cd->event_handler(cd);
-			ticks--;
-		}
+		cd = &per_cpu(mips_clockevent_device, cpu);
+		cd->event_handler(cd);
 		irq_exit();
 		break;
 
@@ -938,24 +961,48 @@ void ipi_decode(struct smtc_ipi *pipi)
 	}
 }
 
+/*
+ * Similar to smtc_ipi_replay(), but invoked from context restore,
+ * so it reuses the current exception frame rather than set up a
+ * new one with self_ipi.
+ */
+
 void deferred_smtc_ipi(void)
 {
-	struct smtc_ipi *pipi;
-	unsigned long flags;
-/* DEBUG */
-	int q = smp_processor_id();
+	int cpu = smp_processor_id();
 
 	/*
 	 * Test is not atomic, but much faster than a dequeue,
 	 * and the vast majority of invocations will have a null queue.
+	 * If irq_disabled when this was called, then any IPIs queued
+	 * after we test last will be taken on the next irq_enable/restore.
+	 * If interrupts were enabled, then any IPIs added after the
+	 * last test will be taken directly.
 	 */
-	if (IPIQ[q].head != NULL) {
-		while((pipi = smtc_ipi_dq(&IPIQ[q])) != NULL) {
-			/* ipi_decode() should be called with interrupts off */
-			local_irq_save(flags);
+
+	while (IPIQ[cpu].head != NULL) {
+		struct smtc_ipi_q *q = &IPIQ[cpu];
+		struct smtc_ipi *pipi;
+		unsigned long flags;
+
+		/*
+		 * It may be possible we'll come in with interrupts
+		 * already enabled.
+		 */
+		local_irq_save(flags);
+
+		spin_lock(&q->lock);
+		pipi = __smtc_ipi_dq(q);
+		spin_unlock(&q->lock);
+		if (pipi != NULL)
 			ipi_decode(pipi);
-			local_irq_restore(flags);
-		}
+		/*
+		 * The use of the __raw_local restore isn't
+		 * as obviously necessary here as in smtc_ipi_replay(),
+		 * but it's more efficient, given that we're already
+		 * running down the IPI queue.
+		 */
+		__raw_local_irq_restore(flags);
 	}
 }
 
@@ -1067,55 +1114,53 @@ static void setup_cross_vpe_interrupts(unsigned int nvpe)
 
 /*
  * SMTC-specific hacks invoked from elsewhere in the kernel.
- *
- * smtc_ipi_replay is called from raw_local_irq_restore which is only ever
- * called with interrupts disabled.  We do rely on interrupts being disabled
- * here because using spin_lock_irqsave()/spin_unlock_irqrestore() would
- * result in a recursive call to raw_local_irq_restore().
  */
 
-static void __smtc_ipi_replay(void)
+ /*
+  * smtc_ipi_replay is called from raw_local_irq_restore
+  */
+
+void smtc_ipi_replay(void)
 {
 	unsigned int cpu = smp_processor_id();
 
 	/*
 	 * To the extent that we've ever turned interrupts off,
 	 * we may have accumulated deferred IPIs.  This is subtle.
-	 * If we use the smtc_ipi_qdepth() macro, we'll get an
-	 * exact number - but we'll also disable interrupts
-	 * and create a window of failure where a new IPI gets
-	 * queued after we test the depth but before we re-enable
-	 * interrupts. So long as IXMT never gets set, however,
 	 * we should be OK:  If we pick up something and dispatch
 	 * it here, that's great. If we see nothing, but concurrent
 	 * with this operation, another TC sends us an IPI, IXMT
 	 * is clear, and we'll handle it as a real pseudo-interrupt
-	 * and not a pseudo-pseudo interrupt.
+	 * and not a pseudo-pseudo interrupt.  The important thing
+	 * is to do the last check for queued message *after* the
+	 * re-enabling of interrupts.
 	 */
-	if (IPIQ[cpu].depth > 0) {
-		while (1) {
-			struct smtc_ipi_q *q = &IPIQ[cpu];
-			struct smtc_ipi *pipi;
-			extern void self_ipi(struct smtc_ipi *);
-
-			spin_lock(&q->lock);
-			pipi = __smtc_ipi_dq(q);
-			spin_unlock(&q->lock);
-			if (!pipi)
-				break;
+	while (IPIQ[cpu].head != NULL) {
+		struct smtc_ipi_q *q = &IPIQ[cpu];
+		struct smtc_ipi *pipi;
+		unsigned long flags;
 
+		/*
+		 * It's just possible we'll come in with interrupts
+		 * already enabled.
+		 */
+		local_irq_save(flags);
+
+		spin_lock(&q->lock);
+		pipi = __smtc_ipi_dq(q);
+		spin_unlock(&q->lock);
+		/*
+		 ** But use a raw restore here to avoid recursion.
+		 */
+		__raw_local_irq_restore(flags);
+
+		if (pipi) {
 			self_ipi(pipi);
 			smtc_cpu_stats[cpu].selfipis++;
 		}
 	}
 }
 
-void smtc_ipi_replay(void)
-{
-	raw_local_irq_disable();
-	__smtc_ipi_replay();
-}
-
 EXPORT_SYMBOL(smtc_ipi_replay);
 
 void smtc_idle_loop_hook(void)
@@ -1194,40 +1239,13 @@ void smtc_idle_loop_hook(void)
 		}
 	}
 
-	/*
-	 * Now that we limit outstanding timer IPIs, check for hung TC
-	 */
-	for (tc = 0; tc < NR_CPUS; tc++) {
-		/* Don't check ourself - we'll dequeue IPIs just below */
-		if ((tc != smp_processor_id()) &&
-		    atomic_read(&ipi_timer_latch[tc]) > timerq_limit) {
-		    if (clock_hang_reported[tc] == 0) {
-			pdb_msg += sprintf(pdb_msg,
-				"TC %d looks hung with timer latch at %d\n",
-				tc, atomic_read(&ipi_timer_latch[tc]));
-			clock_hang_reported[tc]++;
-			}
-		}
-	}
 	emt(mtflags);
 	local_irq_restore(flags);
 	if (pdb_msg != &id_ho_db_msg[0])
 		printk("CPU%d: %s", smp_processor_id(), id_ho_db_msg);
 #endif /* CONFIG_SMTC_IDLE_HOOK_DEBUG */
 
-	/*
-	 * Replay any accumulated deferred IPIs. If "Instant Replay"
-	 * is in use, there should never be any.
-	 */
-#ifndef CONFIG_MIPS_MT_SMTC_INSTANT_REPLAY
-	{
-		unsigned long flags;
-
-		local_irq_save(flags);
-		__smtc_ipi_replay();
-		local_irq_restore(flags);
-	}
-#endif /* CONFIG_MIPS_MT_SMTC_INSTANT_REPLAY */
+	smtc_ipi_replay();
 }
 
 void smtc_soft_dump(void)
@@ -1243,10 +1261,6 @@ void smtc_soft_dump(void)
 		printk("%d: %ld\n", i, smtc_cpu_stats[i].selfipis);
 	}
 	smtc_ipi_qdump();
-	printk("Timer IPI Backlogs:\n");
-	for (i=0; i < NR_CPUS; i++) {
-		printk("%d: %d\n", i, atomic_read(&ipi_timer_latch[i]));
-	}
 	printk("%d Recoveries of \"stolen\" FPU\n",
 	       atomic_read(&smtc_fpu_recoveries));
 }
diff --git a/arch/mips/mips-boards/malta/malta_smtc.c b/arch/mips/mips-boards/malta/malta_smtc.c
index 5ea705e..f84a46a 100644
--- a/arch/mips/mips-boards/malta/malta_smtc.c
+++ b/arch/mips/mips-boards/malta/malta_smtc.c
@@ -84,12 +84,17 @@ static void msmtc_cpus_done(void)
 
 static void __init msmtc_smp_setup(void)
 {
-	mipsmt_build_cpu_map(0);
+	/*
+	 * we won't get the definitive value until
+	 * we've run smtc_prepare_cpus later, but
+	 * we would appear to need an upper bound now.
+	 */
+	smp_num_siblings = smtc_build_cpu_map(0);
 }
 
 static void __init msmtc_prepare_cpus(unsigned int max_cpus)
 {
-	mipsmt_prepare_cpus();
+	smtc_prepare_cpus(max_cpus);
 }
 
 struct plat_smp_ops msmtc_smp_ops = {
diff --git a/include/asm-mips/cevt-r4k.h b/include/asm-mips/cevt-r4k.h
new file mode 100644
index 0000000..fa4328f
--- /dev/null
+++ b/include/asm-mips/cevt-r4k.h
@@ -0,0 +1,46 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Kevin D. Kissell
+ */
+
+/*
+ * Definitions used for common event timer implementation
+ * for MIPS 4K-type processors and their MIPS MT variants.
+ * Avoids unsightly extern declarations in C files.
+ */
+#ifndef __ASM_CEVT_R4K_H
+#define __ASM_CEVT_R4K_H
+
+DECLARE_PER_CPU(struct clock_event_device, mips_clockevent_device);
+
+void mips_event_handler(struct clock_event_device *dev);
+int c0_compare_int_usable(void);
+void mips_set_clock_mode(enum clock_event_mode, struct clock_event_device *);
+irqreturn_t c0_compare_interrupt(int, void *);
+
+extern struct irqaction c0_compare_irqaction;
+extern int cp0_timer_irq_installed;
+
+/*
+ * Possibly handle a performance counter interrupt.
+ * Return true if the timer interrupt should not be checked
+ */
+
+static inline int handle_perf_irq(int r2)
+{
+	/*
+	 * The performance counter overflow interrupt may be shared with the
+	 * timer interrupt (cp0_perfcount_irq < 0). If it is and a
+	 * performance counter has overflowed (perf_irq() == IRQ_HANDLED)
+	 * and we can't reliably determine if a counter interrupt has also
+	 * happened (!r2) then don't check for a timer interrupt.
+	 */
+	return (cp0_perfcount_irq < 0) &&
+		perf_irq() == IRQ_HANDLED &&
+		!r2;
+}
+
+#endif /* __ASM_CEVT_R4K_H */
diff --git a/include/asm-mips/irqflags.h b/include/asm-mips/irqflags.h
index 881e886..701ec0b 100644
--- a/include/asm-mips/irqflags.h
+++ b/include/asm-mips/irqflags.h
@@ -38,8 +38,17 @@ __asm__(
 	"	.set	pop						\n"
 	"	.endm");
 
+extern void smtc_ipi_replay(void);
+
 static inline void raw_local_irq_enable(void)
 {
+#ifdef CONFIG_MIPS_MT_SMTC
+	/*
+	 * SMTC kernel needs to do a software replay of queued
+	 * IPIs, at the cost of call overhead on each local_irq_enable()
+	 */
+	smtc_ipi_replay();
+#endif
 	__asm__ __volatile__(
 		"raw_local_irq_enable"
 		: /* no outputs */
@@ -47,6 +56,7 @@ static inline void raw_local_irq_enable(void)
 		: "memory");
 }
 
+
 /*
  * For cli() we have to insert nops to make sure that the new value
  * has actually arrived in the status register before the end of this
@@ -185,15 +195,14 @@ __asm__(
 	"	.set	pop						\n"
 	"	.endm							\n");
 
-extern void smtc_ipi_replay(void);
 
 static inline void raw_local_irq_restore(unsigned long flags)
 {
 	unsigned long __tmp1;
 
-#ifdef CONFIG_MIPS_MT_SMTC_INSTANT_REPLAY
+#ifdef CONFIG_MIPS_MT_SMTC
 	/*
-	 * CONFIG_MIPS_MT_SMTC_INSTANT_REPLAY does prompt replay of deferred
+	 * SMTC kernel needs to do a software replay of queued
 	 * IPIs, at the cost of branch and call overhead on each
 	 * local_irq_restore()
 	 */
@@ -208,6 +217,17 @@ static inline void raw_local_irq_restore(unsigned long flags)
 		: "memory");
 }
 
+static inline void __raw_local_irq_restore(unsigned long flags)
+{
+	unsigned long __tmp1;
+
+	__asm__ __volatile__(
+		"raw_local_irq_restore\t%0"
+		: "=r" (__tmp1)
+		: "0" (flags)
+		: "memory");
+}
+
 static inline int raw_irqs_disabled_flags(unsigned long flags)
 {
 #ifdef CONFIG_MIPS_MT_SMTC
diff --git a/include/asm-mips/smtc.h b/include/asm-mips/smtc.h
index 3639b28..ea60bf0 100644
--- a/include/asm-mips/smtc.h
+++ b/include/asm-mips/smtc.h
@@ -6,6 +6,7 @@
  */
 
 #include <asm/mips_mt.h>
+#include <asm/smtc_ipi.h>
 
 /*
  * System-wide SMTC status information
@@ -38,14 +39,15 @@ struct mm_struct;
 struct task_struct;
 
 void smtc_get_new_mmu_context(struct mm_struct *mm, unsigned long cpu);
-
+void self_ipi(struct smtc_ipi *);
 void smtc_flush_tlb_asid(unsigned long asid);
-extern int mipsmt_build_cpu_map(int startslot);
-extern void mipsmt_prepare_cpus(void);
+extern int smtc_build_cpu_map(int startslot);
+extern void smtc_prepare_cpus(int cpus);
 extern void smtc_smp_finish(void);
 extern void smtc_boot_secondary(int cpu, struct task_struct *t);
 extern void smtc_cpus_done(void);
 
+
 /*
  * Sharing the TLB between multiple VPEs means that the
  * "random" index selection function is not allowed to
-- 
1.5.3.3


--------------060403060504020202070903--
