Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 23:23:11 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:39926 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225525AbUDTWXI>;
	Tue, 20 Apr 2004 23:23:08 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i3KMN6x6009693;
	Tue, 20 Apr 2004 15:23:06 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i3KMN6OJ009691;
	Tue, 20 Apr 2004 15:23:06 -0700
Date: Tue, 20 Apr 2004 15:23:06 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [RFC] Support cpu timer for SMP case
Message-ID: <20040420152306.E22846@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This patch illustrates that the cpu timer can be used as
system timer on a SMP system:

1) count/compare on CPU 0 registers are used to generate 
   jiffy interrupts

2) at the end of processing jiffy interrupt, cpu 0 sends
   a special inter-processor interrupt (IPI) to all other
   cpus and make them do process accounting stuff 
   (local_timer_interrupt()).

3) count registers on all CPU 0 are sync'ed up at the beginning.
   As a result we will have a consistent time reading on 
   all CPUs (do_gettimeofday()).

This patch assumes that the count registers on different CPUs
don't drift from each other after they sync up.  If they do drift,
we can change the code to allow periodic sync up.  We can
probably even support different count frequencies.

This patch is actually tested to be working on sibyte boards.

As a by-product of the patch we also fix a "gettimeofday() going backward"
problem on those smp boards.

Jun

P.S., the patch really looks more complicated than it should be, because
	I am leaving the old time code for the board there but "ifdef"ed out.
	If we make a complete transition to cpu timer, all the ifdef's and
	old time code for the board should go away.

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="040420.a-cpu-timer-for-smp.patch"

diff -u linux/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux/arch/mips/Kconfig	2004-04-19 16:42:18.000000000 -0700
+++ linux/arch/mips/Kconfig	2004-04-20 14:38:18.000000000 -0700
@@ -522,10 +522,12 @@
 config SIBYTE_SENTOSA
 	bool "BCM91250E-Sentosa"
 	select SIBYTE_SB1250
+	select CPU_TIMER
 
 config SIBYTE_RHONE
 	bool "BCM91125E-Rhone"
 	select SIBYTE_BCM1125H
+	select CPU_TIMER
 
 config SIBYTE_CARMEL
 	bool "BCM91120x-Carmel"
diff -u linux/arch/mips/kernel/cpu-timer.c linux/arch/mips/kernel/cpu-timer.c
--- linux/arch/mips/kernel/cpu-timer.c	2004-04-19 17:01:13.000000000 -0700
+++ linux/arch/mips/kernel/cpu-timer.c	2004-04-20 14:23:11.000000000 -0700
@@ -244,6 +244,11 @@
 			atomic_inc((atomic_t *)&prof_buffer[pc]);
 		}
 	}
+
+#ifdef CONFIG_SMP
+	/* in UP mode, update_process_times() is invoked by do_timer() */
+	update_process_times(user_mode(regs));
+#endif
 }
 
 /*
@@ -296,6 +301,16 @@
 	 */
 	local_timer_interrupt(irq, dev_id, regs);
 
+#if defined(CONFIG_SMP)
+	/* In SMP mode, we also ask other CPUs to do the same */
+	{ 
+		int i;
+		for (i = 1; i < NR_CPUS; i++) 
+			if (cpu_online(i))
+				core_send_ipi(i, SMP_EMULATE_LOCAL_TIMER);
+	}
+#endif
+
 	return IRQ_HANDLED;
 }
 
@@ -446,0 +461,135 @@
+
+#if defined(CONFIG_SMP)
+static atomic_t  rend_start;
+static atomic_t  rend_ready;
+static atomic_t  rend_cpus;
+
+static void rendezvous_init(int v)
+{
+       atomic_set(&rend_cpus, 0); mb();
+       atomic_set(&rend_start, v); mb();
+       atomic_set(&rend_ready, v); mb();
+}
+
+static void rendezvous_master(int v)
+{
+       db_assert(atomic_read(&rend_start) != v); 
+
+       atomic_set(&rend_cpus, 0); mb();
+       atomic_set(&rend_start, v); mb();
+       while (atomic_read(&rend_cpus) != num_online_cpus() -1)
+               mb();
+       atomic_set(&rend_ready, v); mb();
+}
+
+#define rendezvous_master_extra(v, cmd) { \
+       int val=(v); \
+       db_assert(atomic_read(&rend_start) != val); \
+       atomic_set(&rend_cpus, 0); mb(); \
+       atomic_set(&rend_start, val); mb(); \
+       while (atomic_read(&rend_cpus) != num_online_cpus() -1) mb(); \
+       { cmd; } \
+       atomic_set(&rend_ready, val); mb(); \
+}
+       
+static void rendezvous_slave(int v)
+{
+       while (atomic_read(&rend_start) != v)
+               mb();
+       atomic_inc(&rend_cpus); mb();
+       while (atomic_read(&rend_ready) != v)
+               mb();
+}
+
+static void rendezvous_slave_exit(int v)
+{
+       while (atomic_read(&rend_start) != v)
+               mb();
+       atomic_inc(&rend_cpus); mb();
+}
+
+#define        LOOPS           8
+static u32 c0_count[NR_CPUS];
+static u32 c[NR_CPUS][LOOPS+1];
+static void sync_c0_count_slave(void *info)
+{
+       unsigned long flags;
+       int i, loop;
+       int cpu = smp_processor_id();
+       u32 diff;
+       int prev_diff;
+
+       db_assert(cpu != 0);
+
+       i=1;
+       prev_diff = 0;
+
+       local_irq_save(flags);
+       for (loop=0; loop<= LOOPS; loop++) {
+
+               rendezvous_slave(i++);
+               c[cpu][loop] = c0_count[cpu] = read_c0_count(); mb();
+
+               if (loop == LOOPS)
+                       break;
+
+               rendezvous_slave(i++);
+               diff = c0_count[0] - c0_count[cpu];
+               diff += (u32)prev_diff;
+               diff += read_c0_count();
+               write_c0_count(diff);
+       
+               /* discard the first diff which is probably very big */ 
+               if (loop > 0)
+                      prev_diff = (prev_diff >> 1) +
+                              ((int)(c0_count[0] - c0_count[cpu]) >> 1);
+       }
+
+       rendezvous_slave_exit(i++);
+       local_irq_restore(flags);
+}
+
+void sync_c0_count(void)
+{
+       int cpu=smp_processor_id();
+       unsigned long flags;
+       int i, loop;
+
+       db_assert(cpu == 0);
+
+       printk("SMP: start to sync c0 count...\n");
+
+       i=0; rendezvous_init(i++);
+
+       smp_call_function(sync_c0_count_slave, NULL, 0, 0);
+
+       local_irq_save(flags);
+       for (loop=0; loop<= LOOPS; loop++) {
+               /* wait for all cpus to gether here */
+               rendezvous_master(i++);
+               c[cpu][loop] = c0_count[cpu] = read_c0_count(); mb();
+
+               if (loop == LOOPS)
+                       break;
+
+               rendezvous_master(i++);
+               /* master does nothing here */
+       }
+
+       rendezvous_master(i++);
+       local_irq_restore(flags);
+
+       /* print results */
+       printk("SMP: end of c0 count sync'ing ... \n");
+       for (i=0; i<= LOOPS; i++) {
+               int j;
+               printk("\t%08x", c[0][i]);
+               for (j=1; j<NR_CPUS; j++) 
+                       if (c[j][i] == 0) 
+                               printk("\t-");
+                       else
+                               printk("\t%d", c[j][i] - c[0][i]);
+               printk("\n");
+       }
+}
+#endif
only in patch2:
unchanged:
--- linux/include/asm-mips/smp.h.orig	2004-03-09 16:41:35.000000000 -0800
+++ linux/include/asm-mips/smp.h	2004-04-20 13:55:09.000000000 -0700
@@ -46,6 +46,7 @@
 
 #define SMP_RESCHEDULE_YOURSELF	0x1	/* XXX braindead */
 #define SMP_CALL_FUNCTION	0x2
+#define SMP_EMULATE_LOCAL_TIMER	0x4
 
 extern cpumask_t phys_cpu_present_map;
 extern cpumask_t cpu_online_map;
only in patch2:
unchanged:
--- linux/arch/mips/sibyte/swarm/setup.c.orig	2004-03-15 17:55:24.000000000 -0800
+++ linux/arch/mips/sibyte/swarm/setup.c	2004-04-20 14:00:02.000000000 -0700
@@ -57,6 +57,7 @@
 
 void __init swarm_timer_setup(struct irqaction *irq)
 {
+#if !defined(CONFIG_CPU_TIMER)
         /*
          * we don't set up irqaction, because we will deliver timer
          * interrupts through low-level (direct) meachanism.
@@ -64,6 +65,7 @@
 
         /* We only need to setup the generic timer */
         sb1250_time_init();
+#endif
 }
 
 int swarm_be_handler(struct pt_regs *regs, int is_fixup)
@@ -104,6 +106,9 @@
 		rtc_set_time = m41t81_set_time;
 	}
 
+	/* hack for now */
+	mips_hpt_frequency = 600000000;
+
 	printk("This kernel optimized for "
 #ifdef CONFIG_SIMULATION
 	       "simulation"
only in patch2:
unchanged:
--- linux/arch/mips/sibyte/sb1250/Makefile.orig	2003-10-02 14:34:44.000000000 -0700
+++ linux/arch/mips/sibyte/sb1250/Makefile	2004-04-20 14:40:29.000000000 -0700
@@ -1,8 +1,12 @@
-obj-y := setup.o irq.o irq_handler.o time.o
+obj-y := setup.o irq.o irq_handler.o 
 
 obj-$(CONFIG_SMP)			+= smp.o
 obj-$(CONFIG_SIBYTE_TBPROF)		+= bcm1250_tbprof.o
 obj-$(CONFIG_SIBYTE_STANDALONE)		+= prom.o
 obj-$(CONFIG_SIBYTE_BUS_WATCHER)	+= bus_watcher.o
 
+ifndef CONFIG_CPU_TIMER
+obj-y					+= time.o
+endif
+
 EXTRA_AFLAGS := $(CFLAGS)
only in patch2:
unchanged:
--- linux/arch/mips/sibyte/sb1250/irq_handler.S.orig	2004-01-05 10:48:17.000000000 -0800
+++ linux/arch/mips/sibyte/sb1250/irq_handler.S	2004-04-20 14:18:01.000000000 -0700
@@ -65,6 +65,8 @@
 #endif
 	/* Read cause */
 	mfc0	s0, CP0_CAUSE
+	mfc0    t0, CP0_STATUS
+	and     s0, s0, t0              /* mask away disabled irqs */
 
 #ifdef CONFIG_SIBYTE_SB1250_PROF
 	/* Cpu performance counter interrupt is routed to IP[7] */
@@ -80,6 +82,17 @@
 0:
 #endif
 
+#if defined(CONFIG_CPU_TIMER)
+	andi    t1, s0, CAUSEF_IP7
+	beqz    t1, 1f
+	nop
+	li      a0, 64
+	move    a1, sp
+	jal     ll_timer_interrupt
+	nop
+	j       ret_from_irq
+	nop
+#else
 	/* Timer interrupt is routed to IP[4] */
 	andi	t1, s0, CAUSEF_IP4
 	beqz	t1, 1f
@@ -88,6 +101,7 @@
 	 move	a0, sp			/* Pass the registers along */
 	j	ret_from_irq
 	 nop				# delay slot
+#endif
 1:
 
 #ifdef CONFIG_SMP
only in patch2:
unchanged:
--- linux/arch/mips/sibyte/sb1250/irq.c.orig	2003-11-10 15:24:40.000000000 -0800
+++ linux/arch/mips/sibyte/sb1250/irq.c	2004-04-20 14:14:37.000000000 -0700
@@ -386,6 +386,9 @@
 #ifdef CONFIG_KGDB
 	imask |= STATUSF_IP6;
 #endif
+#if defined(CONFIG_CPU_TIMER)
+	imask |= STATUSF_IP7;
+#endif
 	/* Enable necessary IPs, disable the rest */
 	change_c0_status(ST0_IM, imask);
 	set_except_vector(0, sb1250_irq_handler);
only in patch2:
unchanged:
--- linux/arch/mips/sibyte/sb1250/smp.c.orig	2004-03-15 17:55:24.000000000 -0800
+++ linux/arch/mips/sibyte/sb1250/smp.c	2004-04-20 14:43:23.000000000 -0700
@@ -22,6 +22,7 @@
 #include <linux/smp.h>
 #include <linux/kernel_stat.h>
 
+#include <asm/time.h>
 #include <asm/mmu_context.h>
 #include <asm/io.h>
 #include <asm/sibyte/sb1250.h>
@@ -57,8 +58,10 @@
 
 void sb1250_smp_finish(void)
 {
+#if !defined(CONFIG_CPU_TIMER)
 	extern void sb1250_time_init(void);
 	sb1250_time_init();
+#endif
 	local_irq_enable();
 }
 
@@ -95,4 +98,10 @@
 
 	if (action & SMP_CALL_FUNCTION)
 		smp_call_function_interrupt();
+
+	if (action & SMP_EMULATE_LOCAL_TIMER) {
+		irq_enter();
+		local_timer_interrupt(0, NULL, regs);
+		irq_exit();
+	}
 }
only in patch2:
unchanged:
--- linux/arch/mips/kernel/smp.c.orig	2004-03-09 16:40:21.000000000 -0800
+++ linux/arch/mips/kernel/smp.c	2004-04-20 14:18:55.000000000 -0700
@@ -224,6 +224,13 @@
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	prom_cpus_done();
+
+#if defined(CONFIG_CPU_TIMER)
+	{
+		extern void sync_c0_count(void);
+		sync_c0_count();
+	}
+#endif
 }
 
 /* called from main before smp_init() */

--tKW2IUtsqtDRztdT--
