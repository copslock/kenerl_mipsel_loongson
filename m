Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Nov 2002 14:42:21 +0100 (CET)
Received: from p508B75AF.dip.t-dialin.net ([80.139.117.175]:65424 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123974AbSKRNmU>; Mon, 18 Nov 2002 14:42:20 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAIDgCm12364
	for linux-mips@linux-mips.org; Mon, 18 Nov 2002 14:42:12 +0100
Date: Mon, 18 Nov 2002 14:42:12 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Origin patches, take 2
Message-ID: <20021118144212.A12262@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Take two on the Origin patches.  This patch pulls the broken IOC3 patches
which somebody from SGI sneaked to Linus making the IO3 ethernet driver
close to unusable ...

This is a fairly dirty patchkit to revive the port.  I'm posting it here
because these patches are quite quick'n'dirty and various people have
been flooding my mailbox during the past time with requests for Origin
kernels.

The serial console is still seriously missbehaving; fixing that is the
last big to do item before the port is fully usable again.

  Ralf

diff -u -r1.99.2.32 traps.c
--- arch/mips/kernel/traps.c 4 Nov 2002 19:39:56 -0000
+++ arch/mips/kernel/traps.c 18 Nov 2002 11:43:14 -0000
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
+++ arch/mips/sgi-ip27/ip27-console.c 18 Nov 2002 11:43:15 -0000
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
+++ arch/mips/sgi-ip27/ip27-init.c 18 Nov 2002 11:43:16 -0000
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
diff -u -r1.1.2.3 ip27-rtc.c
--- arch/mips/sgi-ip27/ip27-rtc.c 7 Nov 2002 01:47:45 -0000
+++ arch/mips/sgi-ip27/ip27-rtc.c 18 Nov 2002 11:43:17 -0000
@@ -61,7 +61,6 @@
 #define RTC_TIMER_ON		0x02	/* missed irq timer active	*/
 
 static unsigned char rtc_status;	/* bitmapped status byte.	*/
-static spinlock_t rtc_status_lock = SPIN_LOCK_UNLOCKED;
 static unsigned long rtc_freq;	/* Current periodic IRQ rate	*/
 static struct m48t35_rtc *rtc;
 
@@ -125,10 +124,7 @@
 		if ((yrs -= epoch) > 255)    /* They are unsigned */
 			return -EINVAL;
 
-		save_flags(flags);
-		cli();
 		if (yrs > 169) {
-			restore_flags(flags);
 			return -EINVAL;
 		}
 		if (yrs >= 100)
@@ -141,6 +137,7 @@
 		BIN_TO_BCD(mon);
 		BIN_TO_BCD(yrs);
 
+		spin_lock_irq(&rtc_lock);
 		rtc->control &= ~M48T35_RTC_SET;
 		rtc->year = yrs;
 		rtc->month = mon;
@@ -149,8 +146,8 @@
 		rtc->min = min;
 		rtc->sec = sec;
 		rtc->control &= ~M48T35_RTC_SET;
+		spin_unlock_irq(&rtc_lock);
 
-		restore_flags(flags);
 		return 0;
 	}
 	default:
@@ -167,15 +164,15 @@
 
 static int rtc_open(struct inode *inode, struct file *file)
 {
-	spin_lock(rtc_status_lock);
+	spin_lock_irq(rtc_lock);
 
 	if (rtc_status & RTC_IS_OPEN) {
-		spin_unlock(rtc_status_lock);
+		spin_unlock_irq(rtc_status_lock);
 		return -EBUSY;
 	}
 
 	rtc_status |= RTC_IS_OPEN;
-	spin_unlock(rtc_status_lock);
+	spin_unlock_irq(rtc_lock);
 
 	return 0;
 }
@@ -187,9 +184,9 @@
 	 * in use, and clear the data.
 	 */
 
-	spin_lock(rtc_status_lock);
+	spin_lock_irq(rtc_lock);
 	rtc_status &= ~RTC_IS_OPEN;
-	spin_unlock(rtc_status_lock);
+	spin_unlock_irq(rtc_lock);
 
 	return 0;
 }
@@ -226,9 +223,6 @@
 		return -ENODEV;
 	create_proc_read_entry ("rtc", 0, NULL, rtc_read_proc, NULL);
 
-	save_flags(flags);
-	cli();
-	restore_flags(flags);
 	rtc_freq = 1024;
 	return 0;
 }
@@ -304,8 +298,7 @@
 	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
 	 * by the RTC when initially set to a non-zero value.
 	 */
-	save_flags(flags);
-	cli();
+	spin_lock_irq(&rtc_lock);
         rtc->control |= M48T35_RTC_READ;
 	rtc_tm->tm_sec = rtc->sec;
 	rtc_tm->tm_min = rtc->min;
@@ -314,7 +307,7 @@
 	rtc_tm->tm_mon = rtc->month;
 	rtc_tm->tm_year = rtc->year;
 	rtc->control &= ~M48T35_RTC_READ;
-	restore_flags(flags);
+	spin_unlock_irq(&rtc_lock);
 
 	BCD_TO_BIN(rtc_tm->tm_sec);
 	BCD_TO_BIN(rtc_tm->tm_min);
diff -u -r1.1.2.3 ip27-setup.c
--- arch/mips/sgi-ip27/ip27-setup.c 21 Sep 2002 21:15:23 -0000
+++ arch/mips/sgi-ip27/ip27-setup.c 18 Nov 2002 11:43:17 -0000
@@ -311,6 +311,6 @@
 	ioc3_eth_init();
 	per_cpu_init();
 
-	mips_io_port_base = IO_BASE;
+	set_io_port_base(IO_BASE);
 	board_time_init = ip27_time_init;
 }
diff -u -r1.1.2.2 ip27-timer.c
--- arch/mips/sgi-ip27/ip27-timer.c 5 Aug 2002 23:53:35 -0000
+++ arch/mips/sgi-ip27/ip27-timer.c 18 Nov 2002 11:43:21 -0000
@@ -1,5 +1,5 @@
 /*
- * Copytight (C) 1999, 2000 Ralf Baechle (ralf@gnu.org)
+ * Copytight (C) 1999, 2000, 2002 Ralf Baechle (ralf@gnu.org)
  * Copytight (C) 1999, 2000 Silicon Graphics, Inc.
  */
 #include <linux/config.h>
@@ -55,6 +55,7 @@
 	rtc = (struct m48t35_rtc *)(KL_CONFIG_CH_CONS_INFO(nid)->memory_base +
 							IOC3_BYTEBUS_DEV0);
 
+	spin_lock(&rtc_lock);
 	rtc->control |= M48T35_RTC_READ;
 	cmos_minutes = rtc->min;
 	BCD_TO_BIN(cmos_minutes);
@@ -84,15 +85,18 @@
 		       cmos_minutes, real_minutes);
 		retval = -1;
 	}
+	spin_unlock(&rtc_lock);
 
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
@@ -157,7 +161,7 @@
 
 static __init unsigned long get_m48t35_time(void)
 {
-        unsigned int year, month, date, hour, min, sec;
+	unsigned int year, month, date, hour, min, sec;
 	struct m48t35_rtc *rtc;
 	nasid_t nid;
 
@@ -165,6 +169,7 @@
 	rtc = (struct m48t35_rtc *)(KL_CONFIG_CH_CONS_INFO(nid)->memory_base +
 							IOC3_BYTEBUS_DEV0);
 
+	spin_lock(&rtc_lock);
 	rtc->control |= M48T35_RTC_READ;
 	sec = rtc->sec;
 	min = rtc->min;
@@ -173,17 +178,27 @@
 	month = rtc->month;
 	year = rtc->year;
 	rtc->control &= ~M48T35_RTC_READ;
+	spin_unlock(&rtc_lock);
+
+	BCD_TO_BIN(sec);
+	BCD_TO_BIN(min);
+	BCD_TO_BIN(hour);
+	BCD_TO_BIN(date);
+	BCD_TO_BIN(month);
+	BCD_TO_BIN(year);
+
+	year += 1970;
 
-        BCD_TO_BIN(sec);
-        BCD_TO_BIN(min);
-        BCD_TO_BIN(hour);
-        BCD_TO_BIN(date);
-        BCD_TO_BIN(month);
-        BCD_TO_BIN(year);
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
@@ -192,6 +207,9 @@
 	xtime.tv_usec = 0;
 
 	do_gettimeoffset = ip27_do_gettimeoffset;
+
+	// board_time_init = ip27_time_init;
+	board_timer_setup = ip27_timer_setup;
 }
 
 void __init cpu_time_init(void)
diff -u -r1.2.2.5 smp.c
--- arch/mips/sibyte/sb1250/smp.c 28 Sep 2002 22:28:38 -0000
+++ arch/mips/sibyte/sb1250/smp.c 18 Nov 2002 11:43:21 -0000
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
+++ arch/mips64/Makefile 18 Nov 2002 11:43:21 -0000
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
diff -u -r1.73.2.22 defconfig
--- arch/mips64/defconfig 8 Nov 2002 01:39:44 -0000
+++ arch/mips64/defconfig 18 Nov 2002 11:43:21 -0000
@@ -49,8 +49,8 @@
 # CONFIG_SGI_IP22 is not set
 CONFIG_SGI_IP27=y
 # CONFIG_SGI_SN0_N_MODE is not set
-CONFIG_DISCONTIGMEM=y
-CONFIG_NUMA=y
+# CONFIG_DISCONTIGMEM is not set
+# CONFIG_NUMA is not set
 # CONFIG_MAPPED_KERNEL is not set
 # CONFIG_REPLICATE_KTEXT is not set
 # CONFIG_REPLICATE_EXHANDLERS is not set
@@ -473,8 +473,8 @@
 # CONFIG_BEFS_FS is not set
 # CONFIG_BEFS_DEBUG is not set
 # CONFIG_BFS_FS is not set
-# CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
+CONFIG_EXT3_FS=y
+CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 # CONFIG_FAT_FS is not set
 # CONFIG_MSDOS_FS is not set
diff -u -r1.67.2.22 defconfig-ip27
--- arch/mips64/defconfig-ip27 8 Nov 2002 01:39:44 -0000
+++ arch/mips64/defconfig-ip27 18 Nov 2002 11:43:21 -0000
@@ -49,8 +49,8 @@
 # CONFIG_SGI_IP22 is not set
 CONFIG_SGI_IP27=y
 # CONFIG_SGI_SN0_N_MODE is not set
-CONFIG_DISCONTIGMEM=y
-CONFIG_NUMA=y
+# CONFIG_DISCONTIGMEM is not set
+# CONFIG_NUMA is not set
 # CONFIG_MAPPED_KERNEL is not set
 # CONFIG_REPLICATE_KTEXT is not set
 # CONFIG_REPLICATE_EXHANDLERS is not set
@@ -473,8 +473,8 @@
 # CONFIG_BEFS_FS is not set
 # CONFIG_BEFS_DEBUG is not set
 # CONFIG_BFS_FS is not set
-# CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
+CONFIG_EXT3_FS=y
+CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 # CONFIG_FAT_FS is not set
 # CONFIG_MSDOS_FS is not set
diff -u -r1.11.2.12 Makefile
--- arch/mips64/kernel/Makefile 7 Nov 2002 18:01:32 -0000
+++ arch/mips64/kernel/Makefile 18 Nov 2002 11:43:21 -0000
@@ -12,7 +12,7 @@
 
 O_TARGET := kernel.o
 
-export-objs	= irq.o mips64_ksyms.o pci-dma.o setup.o smp.o
+export-objs	= irq.o mips64_ksyms.o pci-dma.o setup.o smp.o time.o
 
 obj-y		:= branch.o cpu-probe.o entry.o irq.o proc.o process.o \
 		   ptrace.o r4k_cache.o r4k_fpu.o r4k_genex.o r4k_switch.o \
diff -u -r1.31.2.21 setup.c
--- arch/mips64/kernel/setup.c 25 Oct 2002 23:01:17 -0000
+++ arch/mips64/kernel/setup.c 18 Nov 2002 11:43:21 -0000
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
diff -u -r1.1.2.6 time.c
--- arch/mips64/kernel/time.c 31 Oct 2002 19:50:14 -0000
+++ arch/mips64/kernel/time.c 18 Nov 2002 11:43:28 -0000
@@ -21,6 +21,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
@@ -38,6 +39,8 @@
 extern rwlock_t xtime_lock;
 extern volatile unsigned long wall_jiffies;
 
+spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
+
 /*
  * whether we emulate local_timer_interrupts for SMP machines.
  */
@@ -580,3 +583,5 @@
 	 */
 	tm->tm_wday = (gday + 4) % 7; /* 1970/1/1 was Thursday */
 }
+
+EXPORT_SYMBOL(rtc_lock);
diff -u -r1.30.2.35 traps.c
--- arch/mips64/kernel/traps.c 4 Nov 2002 19:39:56 -0000
+++ arch/mips64/kernel/traps.c 18 Nov 2002 11:43:28 -0000
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
diff -u -r1.56.2.6 ioc3-eth.c
--- drivers/net/ioc3-eth.c 7 Nov 2002 01:47:46 -0000
+++ drivers/net/ioc3-eth.c 18 Nov 2002 11:43:39 -0000
@@ -26,7 +26,6 @@
  *    which workarounds are required for them?  Do we ever have Lucent's?
  *  o For the 2.5 branch kill the mii-tool ioctls.
  */
-#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
@@ -34,7 +33,6 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/crc32.h>
 
 #ifdef CONFIG_SERIAL
 #include <linux/serial.h>
@@ -342,15 +340,14 @@
 }
 
 /*
- * Read the NIC (Number-In-a-Can) device used to store the MAC address on
- * SN0 / SN00 nodeboards and PCI cards.
+ * Read the NIC (Number-In-a-Can) device.
  */
-static void ioc3_get_eaddr_nic(struct ioc3_private *ip)
+static void ioc3_get_eaddr(struct ioc3_private *ip)
 {
 	struct ioc3 *ioc3 = ip->regs;
 	u8 nic[14];
-	int tries = 2; /* There may be some problem with the battery?  */
 	int i;
+	int tries = 2; /* There may be some problem with the battery?  */
 
 	ioc3_w(gpcr_s, (1 << 21));
 
@@ -373,123 +370,16 @@
 	for (i = 13; i >= 0; i--)
 		nic[i] = nic_read_byte(ioc3);
 
-	for (i = 2; i < 8; i++)
-		ip->dev->dev_addr[i - 2] = nic[i];
-}
-
-#if defined(CONFIG_IA64_SGI_SN1) || defined(CONFIG_IA64_SGI_SN2)
-/*
- * Get the ether-address on SN1 nodes
- */
-static void ioc3_get_eaddr_sn(struct ioc3_private *ip)
-{
-	int ibrick_mac_addr_get(nasid_t, char *);
-	struct ioc3 *ioc3 = ip->regs;
-	nasid_t nasid_of_ioc3;
-	char io7eaddr[20];
-	long mac;
-	int err_val;
-
-	/*
-	 * err_val = ibrick_mac_addr_get(get_nasid(), io7eaddr );
-	 * 
-	 * BAD!!  The above call uses get_nasid() and assumes that
-	 * the ioc3 pointed to by struct ioc3 is hooked up to the
-	 * cbrick that we're running on.  The proper way to make this call
-	 * is to figure out which nasid the ioc3 is connected to
-	 * and use that to call ibrick_mac_addr_get.  Below is
-	 * a hack to do just that.
-	 */
-
-	/*
-	 * Get the nasid of the ioc3 from the ioc3's base addr.
-	 * FIXME: the 8 at the end assumes we're in memory mode, 
-	 * not node mode (for that, we'd change it to a 9).
-	 * Is there a call to extract this info from a physical
-	 * addr somewhere in an sn header file already?  If so,
-	 * we should probably use that, or restructure this routine
-	 * to use pci_dev and generic numa nodeid getting stuff.
-	 */
-	nasid_of_ioc3 = (((unsigned long)ioc3 >> 33) & ~(-1 << 8));
-	err_val = ibrick_mac_addr_get(nasid_of_ioc3, io7eaddr );
-
-
-	if (err_val) {
-		/* Couldn't read the eeprom; try OSLoadOptions. */
-		printk("WARNING: ibrick_mac_addr_get failed: %d\n", err_val);
-
-		/* this is where we hardwire the mac address
- 		 * 1st ibrick had 08:00:69:11:34:75
- 		 * 2nd ibrick had 08:00:69:11:35:35
- 		 *
- 		 * Eagan Machines:
- 		 *      mankato1 08:00:69:11:BE:95
- 		 *      warroad  08:00:69:11:bd:60
- 		 *      duron    08:00:69:11:34:60
- 		 *
- 		 * an easy way to get the mac address is to hook
- 		 * up an ip35, then from L1 do 'cti serial'
- 		 * and then look for MAC line XXX THIS DOESN"T QUITE WORK!!
- 		 */
-		printk("ioc3_get_eaddr: setting ethernet address to:\n -----> ");
-		ip->dev->dev_addr[0] = 0x8;
-		ip->dev->dev_addr[1] = 0x0;
-		ip->dev->dev_addr[2] = 0x69;
-		ip->dev->dev_addr[3] = 0x11;
-		ip->dev->dev_addr[4] = 0x34;
-		ip->dev->dev_addr[5] = 0x60;
-	}
-	else {
-		long simple_strtol(const char *,char **,unsigned int);
-
-		mac = simple_strtol(io7eaddr, (char **)0, 16);
-		ip->dev->dev_addr[0] = (mac >> 40) & 0xff;
-		ip->dev->dev_addr[1] = (mac >> 32) & 0xff;
-		ip->dev->dev_addr[2] = (mac >> 24) & 0xff;
-		ip->dev->dev_addr[3] = (mac >> 16) & 0xff;
-		ip->dev->dev_addr[4] = (mac >> 8) & 0xff;
-		ip->dev->dev_addr[5] = mac & 0xff;
-	}
-}
-#endif
-
-/*
- * Ok, this is hosed by design.  It's necessary to know what machine the
- * NIC is in in order to know how to read the NIC address.  We also have
- * to know if it's a PCI card or a NIC in on the node board ...
- */
-static void ioc3_get_eaddr(struct ioc3_private *ip)
-{
-	void (*do_get_eaddr)(struct ioc3_private *ip) = NULL;
-	int i;
-
-	/*
-	 * We should also use this code for PCI cards, no matter what host
-	 * machine but how to know that we're a PCI card?
-	 */
-#ifdef CONFIG_SGI_IP27
-	do_get_eaddr = ioc3_get_eaddr_nic;
-#endif
-#if defined(CONFIG_IA64_SGI_SN1) || defined(CONFIG_IA64_SGI_SN2)
-	do_get_eaddr = ioc3_get_eaddr_sn;
-#endif
-
-	if (!do_get_eaddr) {
-		printk(KERN_ERR "Don't know how to read MAC address of this "
-		       "IOC3 NIC\n");
-		return;
-	}
-
 	printk("Ethernet address is ");
-	for (i = 0; i < 6; i++) {
-		printk("%02x", ip->dev->dev_addr[i]);
+	for (i = 2; i < 8; i++) {
+		ip->dev->dev_addr[i - 2] = nic[i];
+		printk("%02x", nic[i]);
 		if (i < 7)
 			printk(":");
 	}
 	printk(".\n");
 }
 
-
 /*
  * Caller must hold the ioc3_lock ever for MII readers.  This is also
  * used to protect the transmitter side but it's low contention.
@@ -544,10 +434,10 @@
 
 	skb = ip->rx_skbs[rx_entry];
 	rxb = (struct ioc3_erxbuf *) (skb->data - RX_OFFSET);
-	w0 = be32_to_cpu(rxb->w0);
+	w0 = rxb->w0;
 
 	while (w0 & ERXBUF_V) {
-		err = be32_to_cpu(rxb->err);		/* It's valid ...  */
+		err = rxb->err;				/* It's valid ...  */
 		if (err & ERXBUF_GOODPKT) {
 			len = ((w0 >> ERXBUF_BYTECNT_SHIFT) & 0x7ff) - 4;
 			skb_trim(skb, len);
@@ -588,8 +478,8 @@
 			ip->stats.rx_frame_errors++;
 next:
 		ip->rx_skbs[n_entry] = new_skb;
-		rxr[n_entry] = cpu_to_be32((0xa5UL << 56) |
-		                         ((unsigned long) rxb & TO_PHYS_MASK));
+		rxr[n_entry] = (0xa5UL << 56) |
+		                ((unsigned long) rxb & TO_PHYS_MASK);
 		rxb->w0 = 0;				/* Clear valid flag */
 		n_entry = (n_entry + 1) & 511;		/* Update erpir */
 
@@ -597,7 +487,7 @@
 		rx_entry = (rx_entry + 1) & 511;
 		skb = ip->rx_skbs[rx_entry];
 		rxb = (struct ioc3_erxbuf *) (skb->data - RX_OFFSET);
-		w0 = be32_to_cpu(rxb->w0);
+		w0 = rxb->w0;
 	}
 	ioc3->erpir = (n_entry << 3) | ERPIR_ARM;
 	ip->rx_pi = n_entry;
@@ -1299,8 +1189,8 @@
 			/* Because we reserve afterwards. */
 			skb_put(skb, (1664 + RX_OFFSET));
 			rxb = (struct ioc3_erxbuf *) skb->data;
-			rxr[i] = cpu_to_be64((0xa5UL << 56) |
-			                ((unsigned long) rxb & TO_PHYS_MASK));
+			rxr[i] = (0xa5UL << 56)
+				| ((unsigned long) rxb & TO_PHYS_MASK);
 			skb_reserve(skb, RX_OFFSET);
 		}
 		ip->rx_ci = 0;
@@ -1622,10 +1512,10 @@
 MODULE_DEVICE_TABLE(pci, ioc3_pci_tbl);
 
 static struct pci_driver ioc3_driver = {
-	.name		= "ioc3-eth",
-	.id_table	= ioc3_pci_tbl,
-	.probe		= ioc3_probe,
-	.remove		= __devexit_p(ioc3_remove_one),
+	name:		"ioc3-eth",
+	id_table:	ioc3_pci_tbl,
+	probe:		ioc3_probe,
+	remove:		__devexit_p(ioc3_remove_one),
 };
 
 static int __init ioc3_init_module(void)
@@ -1664,8 +1554,8 @@
 			memset(desc->data + len, 0, ETH_ZLEN - len);
 			len = ETH_ZLEN;
 		}
-		desc->cmd    = cpu_to_be32(len | ETXD_INTWHENDONE | ETXD_D0V);
-		desc->bufcnt = cpu_to_be32(len);
+		desc->cmd    = len | ETXD_INTWHENDONE | ETXD_D0V;
+		desc->bufcnt = len;
 	} else if ((data ^ (data + len)) & 0x4000) {
 		unsigned long b2, s1, s2;
 
@@ -1673,20 +1563,16 @@
 		s1 = b2 - data;
 		s2 = data + len - b2;
 
-		desc->cmd    = cpu_to_be32(len | ETXD_INTWHENDONE |
-		                           ETXD_B1V | ETXD_B2V);
-		desc->bufcnt = cpu_to_be32((s1 << ETXD_B1CNT_SHIFT)
-		                           | (s2 << ETXD_B2CNT_SHIFT));
-		desc->p1     = cpu_to_be64((0xa5UL << 56) |
-                                           (data & TO_PHYS_MASK));
-		desc->p2     = cpu_to_be64((0xa5UL << 56) |
-		                           (data & TO_PHYS_MASK));
+		desc->cmd    = len | ETXD_INTWHENDONE | ETXD_B1V | ETXD_B2V;
+		desc->bufcnt = (s1 << ETXD_B1CNT_SHIFT) |
+		               (s2 << ETXD_B2CNT_SHIFT);
+		desc->p1     = (0xa5UL << 56) | (data & TO_PHYS_MASK);
+		desc->p2     = (0xa5UL << 56) | (data & TO_PHYS_MASK);
 	} else {
 		/* Normal sized packet that doesn't cross a page boundary. */
-		desc->cmd    = cpu_to_be32(len | ETXD_INTWHENDONE | ETXD_B1V);
-		desc->bufcnt = cpu_to_be32(len << ETXD_B1CNT_SHIFT);
-		desc->p1     = cpu_to_be64((0xa5UL << 56) |
-		                           (data & TO_PHYS_MASK));
+		desc->cmd    = len | ETXD_INTWHENDONE | ETXD_B1V;
+		desc->bufcnt = len << ETXD_B1CNT_SHIFT;
+		desc->p1     = (0xa5UL << 56) | (data & TO_PHYS_MASK);
 	}
 
 	BARRIER();
@@ -1725,16 +1611,27 @@
  * Given a multicast ethernet address, this routine calculates the
  * address's bit index in the logical address filter mask
  */
+#define CRC_MASK        0xedb88320
 
 static inline unsigned int
 ioc3_hash(const unsigned char *addr)
 {
 	unsigned int temp = 0;
 	unsigned char byte;
-	u32 crc;
-	int bits;
+	unsigned int crc;
+	int bits, len;
 
-	crc = ether_crc_le(ETH_ALEN, addr);
+	len = ETH_ALEN;
+	for (crc = ~0; --len >= 0; addr++) {
+		byte = *addr;
+		for (bits = 8; --bits >= 0; ) {
+			if ((byte ^ crc) & 1)
+				crc = (crc >> 1) ^ CRC_MASK;
+			else
+				crc >>= 1;
+			byte >>= 1;
+		}
+	}
 
 	crc &= 0x3f;    /* bit reverse lowest 6 bits for hash index */
 	for (bits = 6; --bits >= 0; ) {
@@ -1920,7 +1817,6 @@
 
 MODULE_AUTHOR("Ralf Baechle <ralf@oss.sgi.com>");
 MODULE_DESCRIPTION("SGI IOC3 Ethernet driver");
-MODULE_LICENSE("GPL");
 
 module_init(ioc3_init_module);
 module_exit(ioc3_cleanup_module);
diff -u -r1.25.2.14 io.h
--- include/asm-mips64/io.h 28 Sep 2002 22:28:38 -0000
+++ include/asm-mips64/io.h 18 Nov 2002 11:44:01 -0000
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
diff -u -r1.1 m48t35.h
--- include/asm-mips64/m48t35.h 18 Feb 2000 09:54:39 -0000
+++ include/asm-mips64/m48t35.h 18 Nov 2002 11:44:01 -0000
@@ -1,32 +1,30 @@
 /*
  *  Registers for the SGS-Thomson M48T35 Timekeeper RAM chip
  */
-
 #ifndef _ASM_M48T35_H
 #define _ASM_M48T35_H
 
+#include <linux/spinlock.h>
+
+extern spinlock_t rtc_lock;
+
 struct m48t35_rtc {
-        volatile u8         pad[0x7ff8];    /* starts at 0x7ff8 */
-        volatile u8         control;
-        volatile u8         sec;
-        volatile u8         min;
-        volatile u8         hour;
-        volatile u8         day;
-        volatile u8         date;
-        volatile u8         month;
-        volatile u8         year;
+	volatile u8	pad[0x7ff8];    /* starts at 0x7ff8 */
+	volatile u8	control;
+	volatile u8	sec;
+	volatile u8	min;
+	volatile u8	hour;
+	volatile u8	day;
+	volatile u8	date;
+	volatile u8	month;
+	volatile u8	year;
 };
 
-#define M48T35_RTC_SET      0x80
-#define M48T35_RTC_STOPPED  0x80
-#define M48T35_RTC_READ     0x40
-
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(x)   ((x)=((x)&15) + ((x)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(x)   ((x)=(((x)/10)<<4) + (x)%10)
-#endif
+#define M48T35_RTC_SET		0x80
+#define M48T35_RTC_STOPPED	0x80
+#define M48T35_RTC_READ		0x40
+
+#define BCD_TO_BIN(x)		((x)=((x)&15) + ((x)>>4)*10)
+#define BIN_TO_BCD(x)		((x)=(((x)/10)<<4) + (x)%10)
 
-#endif
+#endif /* _ASM_M48T35_H */
diff -u -r1.10.2.14 page.h
--- include/asm-mips64/page.h 30 Sep 2002 17:00:03 -0000
+++ include/asm-mips64/page.h 18 Nov 2002 11:44:02 -0000
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
+++ include/asm-mips64/sn/sn0/addrs.h 18 Nov 2002 11:44:06 -0000
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
 
