Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Nov 2002 05:39:44 +0100 (CET)
Received: from p508B75AF.dip.t-dialin.net ([80.139.117.175]:62604 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1124241AbSKREjn>; Mon, 18 Nov 2002 05:39:43 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAI4dZq25579
	for linux-mips@linux-mips.org; Mon, 18 Nov 2002 05:39:35 +0100
Date: Mon, 18 Nov 2002 05:39:35 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Origin patches for 2.4.19-pre6
Message-ID: <20021118053935.A25428@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Below a fairly dirty set tho revive the IP27 (Origin 200 & 2000) port.
Tested only on Origin 200 for now as I don't have access to something
bigger atm.

  Ralf

diff -u -r1.99.2.32 traps.c
--- arch/mips/kernel/traps.c 4 Nov 2002 19:39:56 -0000
+++ arch/mips/kernel/traps.c 18 Nov 2002 04:30:00 -0000
@@ -909,6 +909,12 @@
 
 	cpu_data[cpu].asid_cache = ASID_FIRST_VERSION;
 	set_context(cpu << 23);
+
+	atomic_inc(&init_mm.mm_count);
+	current->active_mm = &init_mm;
+	if (current->mm)
+		BUG();
+	enter_lazy_tlb(&init_mm, current, cpu);
 }
 
 void __init trap_init(void)
diff -u -r1.1.2.3 ip27-console.c
--- arch/mips/sgi-ip27/ip27-console.c 7 Nov 2002 01:47:45 -0000
+++ arch/mips/sgi-ip27/ip27-console.c 18 Nov 2002 04:30:06 -0000
@@ -9,6 +9,7 @@
 #include <linux/console.h>
 #include <linux/kdev_t.h>
 #include <linux/major.h>
+#include <asm/page.h>
 #include <asm/sn/addrs.h>
 #include <asm/sn/sn0/hub.h>
 #include <asm/sn/klconfig.h>
@@ -45,11 +46,11 @@
 }
 
 static struct console ip27_prom_console = {
-    .name	= "prom",
-    .write	= ip27prom_console_write,
-    .device	= ip27prom_console_dev,
-    .flags	= CON_PRINTBUFFER,
-    .index	= -1,
+	.name	= "prom",
+	.write	= ip27prom_console_write,
+	.device	= ip27prom_console_dev,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
 };
 
 __init void ip27_setup_console(void)
diff -u -r1.1.2.3 ip27-init.c
--- arch/mips/sgi-ip27/ip27-init.c 28 Sep 2002 22:28:38 -0000
+++ arch/mips/sgi-ip27/ip27-init.c 18 Nov 2002 04:30:06 -0000
@@ -424,6 +424,8 @@
 
 void __init start_secondary(void)
 {
+	extern atomic_t smp_commenced;
+
 	CPUMASK_CLRB(boot_barrier, getcpuid());	/* needs atomicity */
 	per_cpu_init();
 	per_cpu_trap_init();
@@ -435,7 +437,20 @@
 	local_flush_tlb_all();
 	flush_cache_l1();
 	flush_cache_l2();
-	start_secondary();
+
+	smp_callin();
+	while (!atomic_read(&smp_commenced));
+	return cpu_idle();
+}
+
+static int __init fork_by_hand(void)
+{
+	struct pt_regs regs;
+	/*
+	 * don't care about the epc and regs settings since
+	 * we'll never reschedule the forked task.
+	 */
+	return do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
 }
 
 __init void allowboot(void)
@@ -457,6 +472,8 @@
 	boot_barrier = boot_cpumask;
 	/* Launch slaves. */
 	for (cpu = 0; cpu < maxcpus; cpu++) {
+		struct task_struct *idle;
+
 		if (cpu == mycpuid) {
 			alloc_cpupda(cpu, num_cpus);
 			num_cpus++;
@@ -466,59 +483,66 @@
 		}
 
 		/* Skip holes in CPU space */
-		if (CPUMASK_TSTB(boot_cpumask, cpu)) {
-			struct task_struct *p;
+		if (!CPUMASK_TSTB(boot_cpumask, cpu))
+			continue;
 
-			/*
-			 * The following code is purely to make sure
-			 * Linux can schedule processes on this slave.
-			 */
-			kernel_thread(0, NULL, CLONE_PID);
-			p = init_task.prev_task;
-			sprintf(p->comm, "%s%d", "Idle", num_cpus);
-			init_tasks[num_cpus] = p;
-			alloc_cpupda(cpu, num_cpus);
-			del_from_runqueue(p);
-			p->processor = num_cpus;
-			p->cpus_runnable = 1 << num_cpus; /* we schedule the first task manually */
-			unhash_process(p);
-			/* Attach to the address space of init_task. */
-			atomic_inc(&init_mm.mm_count);
-			p->active_mm = &init_mm;
-
-			/*
-		 	 * Launch a slave into smp_bootstrap().
-		 	 * It doesn't take an argument, and we
-			 * set sp to the kernel stack of the newly
-			 * created idle process, gp to the proc struct
-			 * (so that current-> works).
-		 	 */
-			LAUNCH_SLAVE(cputonasid(num_cpus),cputoslice(num_cpus),
-				(launch_proc_t)MAPPED_KERN_RW_TO_K0(smp_bootstrap),
-				0, (void *)((unsigned long)p +
-				KERNEL_STACK_SIZE - 32), (void *)p);
-
-			/*
-			 * Now optimistically set the mapping arrays. We
-			 * need to wait here, verify the cpu booted up, then
-			 * fire up the next cpu.
-			 */
-			__cpu_number_map[cpu] = num_cpus;
-			__cpu_logical_map[num_cpus] = cpu;
-			CPUMASK_SETB(cpu_online_map, cpu);
-			num_cpus++;
-			/*
-			 * Wait this cpu to start up and initialize its hub,
-			 * and discover the io devices it will control.
-			 *
-			 * XXX: We really want to fire up launch all the CPUs
-			 * at once.  We have to preserve the order of the
-			 * devices on the bridges first though.
-			 */
-			while(atomic_read(&numstarted) != num_cpus);
-		}
+		/*
+		 * We can't use kernel_thread since we must avoid to
+		 * reschedule the child.
+		 */
+		if (fork_by_hand() < 0)
+			panic("failed fork for CPU %d", num_cpus);
+
+		/*
+		 * We remove it from the pidhash and the runqueue
+		 * once we got the process:
+		 */
+		idle = init_task.prev_task;
+		if (!idle)
+			panic("No idle process for CPU %d", num_cpus);
+
+		idle->processor = num_cpus;
+		idle->cpus_runnable = 1 << cpu; /* we schedule the first task manually */
+
+		alloc_cpupda(cpu, num_cpus);
+
+		idle->thread.reg31 = (unsigned long) start_secondary;
+
+		del_from_runqueue(idle);
+		unhash_process(idle);
+		init_tasks[num_cpus] = idle;
+
+		/*
+	 	 * Launch a slave into smp_bootstrap().
+	 	 * It doesn't take an argument, and we
+		 * set sp to the kernel stack of the newly
+		 * created idle process, gp to the proc struct
+		 * (so that current-> works).
+	 	 */
+		LAUNCH_SLAVE(cputonasid(num_cpus),cputoslice(num_cpus),
+			(launch_proc_t)MAPPED_KERN_RW_TO_K0(smp_bootstrap),
+			0, (void *)((unsigned long)idle +
+			KERNEL_STACK_SIZE - 32), (void *)idle);
+
+		/*
+		 * Now optimistically set the mapping arrays. We
+		 * need to wait here, verify the cpu booted up, then
+		 * fire up the next cpu.
+		 */
+		__cpu_number_map[cpu] = num_cpus;
+		__cpu_logical_map[num_cpus] = cpu;
+		CPUMASK_SETB(cpu_online_map, cpu);
+		num_cpus++;
+		/*
+		 * Wait this cpu to start up and initialize its hub,
+		 * and discover the io devices it will control.
+		 *
+		 * XXX: We really want to fire up launch all the CPUs
+		 * at once.  We have to preserve the order of the
+		 * devices on the bridges first though.
+		 */
+		while(atomic_read(&numstarted) != num_cpus);
 	}
-
 
 #ifdef LATER
 	Wait logic goes here.
diff -u -r1.1.2.3 ip27-setup.c
--- arch/mips/sgi-ip27/ip27-setup.c 21 Sep 2002 21:15:23 -0000
+++ arch/mips/sgi-ip27/ip27-setup.c 18 Nov 2002 04:30:06 -0000
@@ -311,6 +311,6 @@
 	ioc3_eth_init();
 	per_cpu_init();
 
-	mips_io_port_base = IO_BASE;
+	set_io_port_base(IO_BASE);
 	board_time_init = ip27_time_init;
 }
diff -u -r1.1.2.2 ip27-timer.c
--- arch/mips/sgi-ip27/ip27-timer.c 5 Aug 2002 23:53:35 -0000
+++ arch/mips/sgi-ip27/ip27-timer.c 18 Nov 2002 04:30:06 -0000
@@ -1,5 +1,5 @@
 /*
- * Copytight (C) 1999, 2000 Ralf Baechle (ralf@gnu.org)
+ * Copytight (C) 1999, 2000, 2002 Ralf Baechle (ralf@gnu.org)
  * Copytight (C) 1999, 2000 Silicon Graphics, Inc.
  */
 #include <linux/config.h>
@@ -88,11 +88,13 @@
 	return retval;
 }
 
+#define IP27_TIMER_IRQ	9			/* XXX Assign number */
+
 void rt_timer_interrupt(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
 	int cpuA = ((cputoslice(cpu)) == 0);
-	int irq = 9;				/* XXX Assign number */
+	int irq = IP27_TIMER_IRQ;
 
 	irq_enter(cpu, irq);
 	write_lock(&xtime_lock);
@@ -157,7 +159,7 @@
 
 static __init unsigned long get_m48t35_time(void)
 {
-        unsigned int year, month, date, hour, min, sec;
+	unsigned int year, month, date, hour, min, sec;
 	struct m48t35_rtc *rtc;
 	nasid_t nid;
 
@@ -174,16 +176,25 @@
 	year = rtc->year;
 	rtc->control &= ~M48T35_RTC_READ;
 
-        BCD_TO_BIN(sec);
-        BCD_TO_BIN(min);
-        BCD_TO_BIN(hour);
-        BCD_TO_BIN(date);
-        BCD_TO_BIN(month);
-        BCD_TO_BIN(year);
+	BCD_TO_BIN(sec);
+	BCD_TO_BIN(min);
+	BCD_TO_BIN(hour);
+	BCD_TO_BIN(date);
+	BCD_TO_BIN(month);
+	BCD_TO_BIN(year);
+
+	year += 1970;
+
+	return mktime(year, month, date, hour, min, sec);
+}
 
-        year += 1970;
+static void ip27_timer_setup(struct irqaction *irq)
+{
+	/* over-write the handler, we use our own way */
+	irq->handler = no_action;
 
-        return mktime(year, month, date, hour, min, sec);
+	/* setup irqaction */
+//	setup_irq(IP27_TIMER_IRQ, irq);		/* XXX Can't do this yet.  */
 }
 
 void __init ip27_time_init(void)
@@ -192,6 +203,9 @@
 	xtime.tv_usec = 0;
 
 	do_gettimeoffset = ip27_do_gettimeoffset;
+
+	// board_time_init = ip27_time_init;
+	board_timer_setup = ip27_timer_setup;
 }
 
 void __init cpu_time_init(void)
diff -u -r1.2.2.5 smp.c
--- arch/mips/sibyte/sb1250/smp.c 28 Sep 2002 22:28:38 -0000
+++ arch/mips/sibyte/sb1250/smp.c 18 Nov 2002 04:30:06 -0000
@@ -129,9 +129,6 @@
 		p->processor = i;
 		p->cpus_runnable = 1 << i; /* we schedule the first task manually */
 
-		/* Attach to the address space of init_task. */
-		atomic_inc(&init_mm.mm_count);
-		p->active_mm = &init_mm;
 		init_tasks[i] = p;
 
 		del_from_runqueue(p);
diff -u -r1.22.2.19 Makefile
--- arch/mips64/Makefile 12 Nov 2002 02:14:50 -0000
+++ arch/mips64/Makefile 18 Nov 2002 04:30:07 -0000
@@ -215,7 +215,7 @@
 # ELF files from 32-bit files by conversion.
 #
 ifdef CONFIG_BOOT_ELF64
-GCCFLAGS += -Wa,-32 $(shell if $(CC) $(1) -c -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+GCCFLAGS += -Wa,-32 $(shell if $(CC) -Wa,-mgp64 -c -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "-Wa,-mgp64"; fi)
 LINKFLAGS += -T arch/mips64/ld.script.elf32
 #AS += -64
 #LD += -m elf64bmip
@@ -238,9 +238,9 @@
 MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
-64bit-bfd = elf64-littlemips
+64bit-bfd = elf64-tradlittlemips
 else
-64bit-bfd = elf64-bigmips
+64bit-bfd = elf64-tradbigmips
 endif
 
 vmlinux: arch/mips64/ld.script.elf32
@@ -249,10 +249,10 @@
 
 ifdef CONFIG_MAPPED_KERNEL
 vmlinux.64: vmlinux
-	$(OBJCOPY) -O $(64bit-bfd) --change-addresses=0xbfffffff40000000 $< $@
+	$(OBJCOPY) -O $(64bit-bfd) --remove-section=.reginfo --change-addresses=0xbfffffff40000000 $< $@
 else
 vmlinux.64: vmlinux
-	$(OBJCOPY) -O $(64bit-bfd) --change-addresses=0xa7ffffff80000000 $< $@
+	$(OBJCOPY) -O $(64bit-bfd) --remove-section=.reginfo --change-addresses=0xa800000080000000 $< $@
 endif
 
 zImage: vmlinux
diff -u -r1.31.2.21 setup.c
--- arch/mips64/kernel/setup.c 25 Oct 2002 23:01:17 -0000
+++ arch/mips64/kernel/setup.c 18 Nov 2002 04:30:08 -0000
@@ -278,6 +278,7 @@
 	start_pfn = PFN_UP(CPHYSADDR(&_end));
 #endif	/* CONFIG_BLK_DEV_INITRD */
 
+#ifndef CONFIG_SGI_IP27
 	/* Find the highest page frame number we have available.  */
 	max_pfn = 0;
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
@@ -342,6 +343,7 @@
 
 	/* Reserve the bootmap memory.  */
 	reserve_bootmem(PFN_PHYS(start_pfn), bootmap_size);
+#endif
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* Board specific code should have set up initrd_start and initrd_end */
diff -u -r1.30.2.35 traps.c
--- arch/mips64/kernel/traps.c 4 Nov 2002 19:39:56 -0000
+++ arch/mips64/kernel/traps.c 18 Nov 2002 04:30:09 -0000
@@ -686,6 +686,12 @@
 	cpu_data[cpu].asid_cache = ASID_FIRST_VERSION;
 	set_context(((long)(&pgd_current[cpu])) << 23);
 	set_wired(0);
+
+	atomic_inc(&init_mm.mm_count);
+	current->active_mm = &init_mm;
+	if (current->mm)
+		BUG();
+	enter_lazy_tlb(&init_mm, current, cpu);
 }
 
 void __init trap_init(void)
diff -u -r1.25.2.14 io.h
--- include/asm-mips64/io.h 28 Sep 2002 22:28:38 -0000
+++ include/asm-mips64/io.h 18 Nov 2002 04:30:31 -0000
@@ -330,7 +330,7 @@
 
 #define outw(val,port)							\
 do {									\
-	*(volatile u16 *)(mips_io_port_base + (port)) = __ioswab16(val);\
+	*(volatile u16 *)(mips_io_port_base + (port ^ 2)) = __ioswab16(val);\
 } while(0)
 
 #define outl(val,port)							\
@@ -346,7 +346,7 @@
 
 #define outw_p(val,port)						\
 do {									\
-	*(volatile u16 *)(mips_io_port_base + (port)) = __ioswab16(val);\
+	*(volatile u16 *)(mips_io_port_base + (port ^ 2)) = __ioswab16(val);\
 	SLOW_DOWN_IO;							\
 } while(0)
 
@@ -363,7 +363,7 @@
 
 static inline unsigned short inw(unsigned long port)
 {
-	return __ioswab16(*(volatile u16 *)(mips_io_port_base + port));
+	return __ioswab16(*(volatile u16 *)(mips_io_port_base + (port ^ 2)));
 }
 
 static inline unsigned int inl(unsigned long port)
@@ -385,7 +385,7 @@
 {
 	u16 __val;
 
-	__val = *(volatile u16 *)(mips_io_port_base + port);
+	__val = *(volatile u16 *)(mips_io_port_base + (port ^ 2));
 	SLOW_DOWN_IO;
 
 	return __ioswab16(__val);
diff -u -r1.10.2.14 page.h
--- include/asm-mips64/page.h 30 Sep 2002 17:00:03 -0000
+++ include/asm-mips64/page.h 18 Nov 2002 04:30:31 -0000
@@ -115,7 +115,7 @@
 #endif
 #if defined(CONFIG_SGI_IP27)
 #define PAGE_OFFSET	0xa800000000000000UL
-#define UNCAC_BASE	0x9000000000000000UL
+#define UNCAC_BASE	0x9600000000000000UL
 #endif
 #if defined(CONFIG_SIBYTE_SB1250)
 #define PAGE_OFFSET	0xa800000000000000UL
diff -u -r1.2.2.1 addrs.h
--- include/asm-mips64/sn/sn0/addrs.h 27 Jun 2002 14:21:24 -0000
+++ include/asm-mips64/sn/sn0/addrs.h 18 Nov 2002 04:30:32 -0000
@@ -45,11 +45,11 @@
 #define HSPEC_BASE		0x9000000000000000
 #define IO_BASE			0x9200000000000000
 #define MSPEC_BASE		0x9400000000000000
-#define UNCAC_BASE		0x9600000000000000
+#define __UNCAC_BASE		0x9600000000000000
 
 #define TO_PHYS(x)		(	      ((x) & TO_PHYS_MASK))
 #define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
-#define TO_UNCAC(x)		(UNCAC_BASE | ((x) & TO_PHYS_MASK))
+#define TO_UNCAC(x)		(__UNCAC_BASE | ((x) & TO_PHYS_MASK))
 #define TO_MSPEC(x)		(MSPEC_BASE | ((x) & TO_PHYS_MASK))
 #define TO_HSPEC(x)		(HSPEC_BASE | ((x) & TO_PHYS_MASK))
 
