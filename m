Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2003 19:13:19 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:25838 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225199AbTFFSNQ>;
	Fri, 6 Jun 2003 19:13:16 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h56IDF303045;
	Fri, 6 Jun 2003 11:13:15 -0700
Date: Fri, 6 Jun 2003 11:13:15 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] kgdb smp support
Message-ID: <20030606111315.N25414@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This patch adds some essential part for kgdb support on a
SMP machine.

Much of the patch is contributed by Kip Walker.

I have tested it well on UP machines just to make sure
UP does not break.

Comments? Objections?

Jun 

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030606.a-partial-smp-kgdb.patch"

diff -Nru link/arch/mips/kernel/smp.c.orig link/arch/mips/kernel/smp.c
--- link/arch/mips/kernel/smp.c.orig	Wed Apr 23 16:00:13 2003
+++ link/arch/mips/kernel/smp.c	Fri Jun  6 10:25:11 2003
@@ -133,7 +133,7 @@
 	core_send_ipi(cpu, SMP_RESCHEDULE_YOURSELF);
 }
 
-static spinlock_t call_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t smp_call_lock = SPIN_LOCK_UNLOCKED;
 
 struct call_data_struct *call_data;
 
@@ -165,7 +165,7 @@
 	if (wait)
 		atomic_set(&data.finished, 0);
 
-	spin_lock(&call_lock);
+	spin_lock(&smp_call_lock);
 	call_data = &data;
 
 	/* Send a message to all other CPUs and wait for them to respond */
@@ -181,7 +181,7 @@
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
 			barrier();
-	spin_unlock(&call_lock);
+	spin_unlock(&smp_call_lock);
 
 	return 0;
 }
diff -Nru link/arch/mips/kernel/gdb-stub.c.orig link/arch/mips/kernel/gdb-stub.c
--- link/arch/mips/kernel/gdb-stub.c.orig	Wed Feb 26 17:06:27 2003
+++ link/arch/mips/kernel/gdb-stub.c	Fri Jun  6 10:24:09 2003
@@ -127,6 +127,8 @@
 #include <linux/mm.h>
 #include <linux/console.h>
 #include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/reboot.h>
 
@@ -137,6 +139,8 @@
 #include <asm/gdb-stub.h>
 #include <asm/inst.h>
 
+#include <asm/debug.h>
+
 /*
  * external low-level support routines
  */
@@ -150,6 +154,8 @@
  */
 extern void breakpoint(void);
 extern void breakinst(void);
+extern void async_breakpoint(void);
+extern void async_breakinst(void);
 extern void adel(void);
 
 /*
@@ -165,6 +171,12 @@
 void handle_exception(struct gdb_regs *regs);
 
 /*
+ * spin locks for smp case
+ */
+static spinlock_t kgdb_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t kgdb_cpulock[NR_CPUS] = { [0 ... NR_CPUS-1] = SPIN_LOCK_UNLOCKED};
+
+/*
  * BUFMAX defines the maximum number of characters in inbound/outbound buffers
  * at least NUMREGBYTES*2 are needed for register packets
  */
@@ -173,6 +185,7 @@
 static char input_buffer[BUFMAX];
 static char output_buffer[BUFMAX];
 static int initialized;	/* !0 means we've been initialized */
+static int kgdb_started;
 static const char hexchars[]="0123456789abcdef";
 
 /* Used to prevent crashes in memory access.  Note that they'll crash anyway if
@@ -396,6 +409,17 @@
 	restore_flags(flags);
 }
 
+void restore_debug_traps(void)
+{
+	struct hard_trap_info *ht;
+	unsigned long flags;
+
+	save_and_cli(flags);
+	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
+		set_except_vector(ht->tt, saved_vectors[ht->tt]);
+	restore_flags(flags);
+}
+
 /*
  * Convert the MIPS hardware trap type code to a Unix signal number.
  */
@@ -574,12 +598,39 @@
  */
 static struct gdb_bp_save async_bp;
 
-void set_async_breakpoint(unsigned int epc)
+/*
+ * Swap the interrupted EPC with our asynchronous breakpoint routine.
+ * This is safer than stuffing the breakpoint in-place, since no cache
+ * flushes (or resulting smp_call_functions) are required.  The
+ * assumption is that only one CPU will be handling asynchronous bp's,
+ * and only one can be active at a time.
+ */
+extern spinlock_t smp_call_lock;
+void set_async_breakpoint(unsigned long *epc)
 {
-	async_bp.addr = epc;
-	async_bp.val  = *(unsigned *)epc;
-	*(unsigned *)epc = BP;
-	__flush_cache_all();
+	/* skip breaking into userland */
+	if ((*epc & 0x80000000) == 0)
+		return;
+
+	/* avoid deadlock if someone is make IPC */
+	if (spin_is_locked(&smp_call_lock))
+		return;
+
+	async_bp.addr = *epc;
+	*epc = (unsigned long)async_breakpoint;
+}
+
+void kgdb_wait(void *arg)
+{
+	unsigned flags;
+	int cpu = smp_processor_id();
+
+	local_irq_save(flags);
+
+	spin_lock(&kgdb_cpulock[cpu]);
+	spin_unlock(&kgdb_cpulock[cpu]);
+
+	local_irq_restore(flags);
 }
 
 
@@ -596,6 +647,40 @@
 	int length;
 	char *ptr;
 	unsigned long *stack;
+	int i;
+
+	kgdb_started = 1;
+
+	/*
+	 * acquire the big kgdb spinlock
+	 */
+	if (!spin_trylock(&kgdb_lock)) {
+		/* 
+		 * some other CPU has the lock, we should go back to 
+		 * receive the gdb_wait IPC
+		 */
+		return;
+	}
+
+	/*
+	 * If we're in async_breakpoint(), restore the real EPC from
+	 * the breakpoint.
+	 */
+	if (regs->cp0_epc == (unsigned long)async_breakinst) {
+		regs->cp0_epc = async_bp.addr;
+		async_bp.addr = 0;
+	}
+
+	/* 
+	 * acquire the CPU spinlocks
+	 */
+	for (i=0; i< smp_num_cpus; i++) 
+		db_verify(spin_trylock(&kgdb_cpulock[i]), != 0);
+
+	/*
+	 * force other cpus to enter kgdb
+	 */
+	smp_call_function(kgdb_wait, NULL, 0, 0);
 
 	/*
 	 * If we're in breakpoint() increment the PC
@@ -618,16 +703,6 @@
 		}
 	}
 
-	/*
-	 * If we were interrupted asynchronously by gdb, then a
-	 * breakpoint was set at the EPC of the interrupt so
-	 * that we'd wind up here with an interesting stack frame.
-	 */
-	if (async_bp.addr) {
-		*(unsigned *)async_bp.addr = async_bp.val;
-		async_bp.addr = 0;
-	}
-
 	stack = (long *)regs->reg29;			/* stack ptr */
 	sigval = computeSignal(trap);
 
@@ -689,10 +764,13 @@
 			output_buffer[3] = 0;
 			break;
 
+		/*
+		 * Detach debugger; let CPU run
+		 */
 		case 'D':
-			/* detach; let CPU run */
 			putpacket(output_buffer);
-			return;
+			goto finish_kgdb;
+			break;
 
 		case 'd':
 			/* toggle debug flag */
@@ -776,22 +854,10 @@
 			ptr = &input_buffer[1];
 			if (hexToInt(&ptr, &addr))
 				regs->cp0_epc = addr;
-
-			/*
-			 * Need to flush the instruction cache here, as we may
-			 * have deposited a breakpoint, and the icache probably
-			 * has no way of knowing that a data ref to some location
-			 * may have changed something that is in the instruction
-			 * cache.
-			 * NB: We flush both caches, just to be sure...
-			 */
-
-			__flush_cache_all();
-			return;
-			/* NOTREACHED */
+	  
+			goto exit_kgdb_exception;
 			break;
 
-
 		/*
 		 * kill the program; let us try to restart the machine
 		 * Reset the whole machine.
@@ -810,9 +876,9 @@
 			 * use breakpoints and continue, instead.
 			 */
 			single_step(regs);
-			__flush_cache_all();
-			return;
+			goto exit_kgdb_exception;
 			/* NOTREACHED */
+			break;
 
 		/*
 		 * Set baud rate (bBB)
@@ -867,6 +933,20 @@
 		putpacket(output_buffer);
 
 	} /* while */
+
+	return;
+
+finish_kgdb:
+	restore_debug_traps();
+
+exit_kgdb_exception:
+	/* release locks so other CPUs can go */
+	for (i=0; i < smp_num_cpus; i++) 
+		spin_unlock(&kgdb_cpulock[i]);
+	spin_unlock(&kgdb_lock);
+
+	__flush_cache_all();
+	return;
 }
 
 /*
@@ -890,6 +970,19 @@
 			);
 }
 
+/* Nothing but the break; don't pollute any registers */
+void async_breakpoint(void)
+{
+	__asm__ __volatile__(
+			".globl	async_breakinst\n\t" 
+			".set\tnoreorder\n\t"
+			"nop\n\t"
+			"async_breakinst:\tbreak\n\t"
+			"nop\n\t"
+			".set\treorder"
+			);
+}
+
 void adel(void)
 {
 	__asm__ __volatile__(
@@ -919,6 +1012,9 @@
 {
 	char outbuf[18];
 
+	if (!kgdb_started)
+		return;
+
 	outbuf[0]='O';
 
 	while(l) {
diff -Nru link/arch/mips/sibyte/sb1250/irq.c.orig link/arch/mips/sibyte/sb1250/irq.c
--- link/arch/mips/sibyte/sb1250/irq.c.orig	Thu Mar 27 10:54:19 2003
+++ link/arch/mips/sibyte/sb1250/irq.c	Fri Jun  6 10:24:09 2003
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2000, 2001 Broadcom Corporation
+ * Copyright (C) 2000, 2001, 2002, 2003 Broadcom Corporation
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -23,6 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/kernel_stat.h>
 
 #include <asm/errno.h>
 #include <asm/signal.h>
@@ -61,12 +62,14 @@
 #ifdef CONFIG_KGDB
 extern void breakpoint(void);
 extern void set_debug_traps(void);
+static int kgdb_irq;
 
 /* kgdb is on when configured.  Pass "nokgdb" kernel arg to turn it off */
 static int kgdb_flag = 1;
 static int __init nokgdb(char *str)
 {
 	kgdb_flag = 0;
+	return 1;
 }
 __setup("nokgdb", nokgdb);
 #endif
@@ -377,15 +380,19 @@
 
 #ifdef CONFIG_KGDB
 	if (kgdb_flag) {
+		kgdb_irq = K_INT_UART_1;
+
 		/* Setup uart 1 settings, mapper */
 		out64(M_DUART_IMR_BRK, KSEG1 + A_DUART + R_DUART_IMR_B);
 
+		sb1250_steal_irq(kgdb_irq);
 		out64(IMR_IP6_VAL,
-			KSEG1 + A_IMR_REGISTER(0, R_IMR_INTERRUPT_MAP_BASE) + (K_INT_UART_1<<3));
+			KSEG1 + A_IMR_REGISTER(0, R_IMR_INTERRUPT_MAP_BASE) + (kgdb_irq<<3));
 		tmp = in64(KSEG1 + A_IMR_REGISTER(0, R_IMR_INTERRUPT_MASK));
-		tmp &= ~(1<<K_INT_UART_1);
+		tmp &= ~(1LL<<kgdb_irq);
 		out64(tmp, KSEG1 + A_IMR_REGISTER(0, R_IMR_INTERRUPT_MASK));
 
+		prom_printf("Waiting for GDB on UART port 1\n");
 		set_debug_traps();
 		breakpoint();
 	}
@@ -396,10 +403,10 @@
 
 #include <linux/delay.h>
 
-extern void set_async_breakpoint(unsigned int epc);
+extern void set_async_breakpoint(unsigned long *epc);
 
-#define duart_out(reg, val)     out64(val, KSEG1 + A_DUART_CHANREG(1,reg))
-#define duart_in(reg)           in64(KSEG1 + A_DUART_CHANREG(1,reg))
+#define duart_out(reg, val)     csr_out32(val, KSEG1 + A_DUART_CHANREG(1,reg))
+#define duart_in(reg)           csr_in32(KSEG1 + A_DUART_CHANREG(1,reg))
 
 void sb1250_kgdb_interrupt(struct pt_regs *regs)
 {
@@ -408,10 +415,11 @@
 	 * host to stop the break, since we would see another
 	 * interrupt on the end-of-break too)
 	 */
+	kstat.irqs[smp_processor_id()][K_INT_UART_1]++;
 	mdelay(500);
 	duart_out(R_DUART_CMD, V_DUART_MISC_CMD_RESET_BREAK_INT |
 				M_DUART_RX_EN | M_DUART_TX_EN);
-	if (!user_mode(regs))
-		set_async_breakpoint(regs->cp0_epc);
+	set_async_breakpoint(&regs->cp0_epc);
 }
+
 #endif 	/* CONFIG_KGDB */
diff -Nru link/arch/mips/sibyte/swarm/dbg_io.c.orig link/arch/mips/sibyte/swarm/dbg_io.c
--- link/arch/mips/sibyte/swarm/dbg_io.c.orig	Thu Apr 11 15:10:54 2002
+++ link/arch/mips/sibyte/swarm/dbg_io.c	Fri Jun  6 10:24:09 2003
@@ -37,8 +37,8 @@
 /* -------------------- END OF CONFIG --------------------- */
 
 
-#define	duart_out(reg, val)	out64(val, KSEG1 + A_DUART_CHANREG(1,reg))
-#define duart_in(reg)		in64(KSEG1 + A_DUART_CHANREG(1,reg))
+#define	duart_out(reg, val)	csr_out32(val, KSEG1 + A_DUART_CHANREG(1,reg))
+#define duart_in(reg)		csr_in32(KSEG1 + A_DUART_CHANREG(1,reg))
 
 extern void set_async_breakpoint(unsigned int epc);
 
diff -Nru link/arch/mips/Makefile.orig link/arch/mips/Makefile
--- link/arch/mips/Makefile.orig	Fri Jun  6 10:22:24 2003
+++ link/arch/mips/Makefile	Fri Jun  6 10:30:17 2003
@@ -19,7 +19,7 @@
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 tool-prefix	= mipsel-linux-
 else
-tool-prefix	= mips-linux-
+tool-prefix	= /opt/mvl-installs/mvl3.0.0/hardhat/devkit/mips/fp_be/bin/mips_fp_be-
 endif
 
 ifdef CONFIG_CROSSCOMPILE

--G4iJoqBmSsgzjUCe--
