Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2E00FX06759
	for linux-mips-outgoing; Wed, 13 Mar 2002 16:00:15 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g2E00A906755
	for <linux-mips@oss.sgi.com>; Wed, 13 Mar 2002 16:00:11 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g2DN08k25896
	for linux-mips@oss.sgi.com; Wed, 13 Mar 2002 15:00:09 -0800
Received: from portablue.intern.mind.be (NAT.office.mind.be [62.166.230.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2A59x917411
	for <linux-mips@oss.sgi.com>; Sat, 9 Mar 2002 21:10:00 -0800
Received: by portablue.intern.mind.be (Postfix, from userid 505)
	id AAB8DB2D15; Sun, 10 Mar 2002 05:09:56 +0100 (CET)
Date: Sun, 10 Mar 2002 05:09:55 +0100
To: linux-mips@oss.sgi.com, geert@linux-m68k.org, wim@sonycom.com,
   lionel@sonycom.com, thomasv@sonycom.com, Nico.DeRanter@sonycom.com,
   tea@sonycom.com, joel@sonycom.com, michiels@CoWare.com, gds@denayer.wenk.be,
   p2@mind.be
Subject: and now the real patch
Message-ID: <20020310040955.GB4336@mind.be>
Mail-Followup-To: p2@mind.be, linux-mips@oss.sgi.com,
	geert@linux-m68k.org, wim@sonycom.com, lionel@sonycom.com,
	thomasv@sonycom.com, Nico.DeRanter@sonycom.com, tea@sonycom.com,
	joel@sonycom.com, michiels@CoWare.com, gds@denayer.wenk.be
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Answer: 42
X-Operating-system: Debian GNU/Linux
X-Message-Flag: Get yourself a real email client. http://www.mutt.org/
From: p2@mind.be (Peter De Schrijver)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

And of course I forgot to attach the code...

Have fun,

Peter.

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diffje

diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/arch/mips/Makefile linux/arch/mips/Makefile
--- linux.orig/linux/arch/mips/Makefile	Sat Feb 16 03:02:44 2002
+++ linux/arch/mips/Makefile	Tue Feb 26 20:10:48 2002
@@ -195,8 +195,8 @@
 # NEC DDB Vrc-5074
 #
 ifdef CONFIG_DDB5074
-SUBDIRS       += arch/mips/ddb5074
-LIBS          += arch/mips/ddb5074/ddb5074.a
+SUBDIRS       += arch/mips/ddb5xxx/common arch/mips/ddb5xxx/ddb5074
+LIBS          += arch/mips/ddb5xxx/common/ddb5xxx.o arch/mips/ddb5xxx/ddb5074/ddb5074.o
 LOADADDR      += 0x80080000
 endif
 
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/arch/mips/config.in linux/arch/mips/config.in
--- linux.orig/linux/arch/mips/config.in	Sat Mar  9 17:48:51 2002
+++ linux/arch/mips/config.in	Thu Mar  7 23:33:05 2002
@@ -186,9 +186,12 @@
    define_bool CONFIG_I8259 y
    define_bool CONFIG_ISA y
    define_bool CONFIG_NONCOHERENT_IO y
+   define_bool CONFIG_IRQ_CPU y
    define_bool CONFIG_PCI y
+   define_bool CONFIG_NEW_PCI y
+   define_bool CONFIG_PCI_AUTO y
    define_bool CONFIG_PC_KEYB y
-   define_bool CONFIG_OLD_TIME_C y
+   define_bool CONFIG_NEW_TIME_C y
 fi
 if [ "$CONFIG_DDB5476"  = "y" ]; then
    define_bool CONFIG_ISA y
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/arch/mips/ddb5xxx/ddb5074/Makefile linux/arch/mips/ddb5xxx/ddb5074/Makefile
--- linux.orig/linux/arch/mips/ddb5xxx/ddb5074/Makefile	Thu Jan  1 01:00:00 1970
+++ linux/arch/mips/ddb5xxx/ddb5074/Makefile	Mon Jan 14 14:10:26 2002
@@ -0,0 +1,21 @@
+#
+# Makefile for the NEC DDB Vrc-5074 specific kernel interface routines
+# under Linux.
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+# Note 2! The CFLAGS definitions are now in the main makefile...
+#
+
+.S.s:
+	$(CPP) $(CFLAGS) $< -o $*.s
+.S.o:
+	$(CC) $(CFLAGS) -c $< -o $*.o
+
+O_TARGET = ddb5074.o
+
+obj-y				+= setup.o irq.o int-handler.o pci.o pci_ops.o nile4_pic.o 
+
+include $(TOPDIR)/Rules.make
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/arch/mips/ddb5xxx/ddb5074/int-handler.S linux/arch/mips/ddb5xxx/ddb5074/int-handler.S
--- linux.orig/linux/arch/mips/ddb5xxx/ddb5074/int-handler.S	Thu Jan  1 01:00:00 1970
+++ linux/arch/mips/ddb5xxx/ddb5074/int-handler.S	Mon Jan 14 14:10:26 2002
@@ -0,0 +1,120 @@
+/*
+ *  arch/mips/ddb5074/int-handler.S -- NEC DDB Vrc-5074 interrupt handler
+ *
+ *  Based on arch/mips/sgi/kernel/indyIRQ.S
+ *
+ *  Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
+ *
+ *  Copyright (C) 2000 Geert Uytterhoeven <geert@sonycom.com>
+ *                     Sony Software Development Center Europe (SDCE), Brussels
+ */
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+
+/* A lot of complication here is taken away because:
+ *
+ * 1) We handle one interrupt and return, sitting in a loop and moving across
+ *    all the pending IRQ bits in the cause register is _NOT_ the answer, the
+ *    common case is one pending IRQ so optimize in that direction.
+ *
+ * 2) We need not check against bits in the status register IRQ mask, that
+ *    would make this routine slow as hell.
+ *
+ * 3) Linux only thinks in terms of all IRQs on or all IRQs off, nothing in
+ *    between like BSD spl() brain-damage.
+ *
+ * Furthermore, the IRQs on the INDY look basically (barring software IRQs
+ * which we don't use at all) like:
+ *
+ *	MIPS IRQ	Source
+ *      --------        ------
+ *             0	Software (ignored)
+ *             1        Software (ignored)
+ *             2        Local IRQ level zero
+ *             3        Local IRQ level one
+ *             4        8254 Timer zero
+ *             5        8254 Timer one
+ *             6        Bus Error
+ *             7        R4k timer (what we use)
+ *
+ * We handle the IRQ according to _our_ priority which is:
+ *
+ * Highest ----     R4k Timer
+ *                  Local IRQ zero
+ *                  Local IRQ one
+ *                  Bus Error
+ *                  8254 Timer zero
+ * Lowest  ----     8254 Timer one
+ *
+ * then we just return, if multiple IRQs are pending then we will just take
+ * another exception, big deal.
+ */
+
+	.text
+	.set	noreorder
+	.set	noat
+	.align	5
+	NESTED(ddbIRQ, PT_SIZE, sp)
+	SAVE_ALL
+	CLI
+	.set	at
+	mfc0	s0, CP0_CAUSE		# get irq mask
+
+#if 1
+	mfc0	t2,CP0_STATUS		# get enabled interrupts
+	and	s0,t2			# isolate allowed ones
+#endif
+	/* First we check for r4k counter/timer IRQ. */
+	andi	a0, s0, CAUSEF_IP2	# delay slot, check local level zero
+	beq	a0, zero, 1f
+	 andi	a0, s0, CAUSEF_IP3	# delay slot, check local level one
+
+	/* Wheee, local level zero interrupt. */
+	jal	ddb_local0_irqdispatch
+	 move	a0, sp			# delay slot
+
+	j	ret_from_irq
+	 nop				# delay slot
+
+1:
+	beq	a0, zero, 1f
+	 andi	a0, s0, CAUSEF_IP6	# delay slot, check bus error
+
+	/* Wheee, local level one interrupt. */
+	move	a0, sp
+	jal	ddb_local1_irqdispatch
+	 nop
+
+	j	ret_from_irq
+	 nop
+
+1:
+	beq	a0, zero, 1f
+	 nop
+
+	/* Wheee, an asynchronous bus error... */
+	move	a0, sp
+	jal	ddb_buserror_irq
+	 nop
+
+	j	ret_from_irq
+	 nop
+
+1:
+	/* Here by mistake?  This is possible, what can happen
+	 * is that by the time we take the exception the IRQ
+	 * pin goes low, so just leave if this is the case.
+	 */
+	andi	a0, s0, (CAUSEF_IP4 | CAUSEF_IP5)
+	beq	a0, zero, 1f
+
+	/* Must be one of the 8254 timers... */
+	move	a0, sp
+	jal	ddb_8254timer_irq
+	 nop
+1:
+	j	ret_from_irq
+	 nop
+	END(ddbIRQ)
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/arch/mips/ddb5xxx/ddb5074/irq.c linux/arch/mips/ddb5xxx/ddb5074/irq.c
--- linux.orig/linux/arch/mips/ddb5xxx/ddb5074/irq.c	Thu Jan  1 01:00:00 1970
+++ linux/arch/mips/ddb5xxx/ddb5074/irq.c	Sun Mar 10 03:20:26 2002
@@ -0,0 +1,165 @@
+/*
+ *  arch/mips/ddb5074/irq.c -- NEC DDB Vrc-5074 interrupt routines
+ *
+ *  Copyright (C) 2000 Geert Uytterhoeven <geert@sonycom.com>
+ *                     Sony Software Development Center Europe (SDCE), Brussels
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/ptrace.h>
+#include <asm/nile4.h>
+#include <asm/ddb5xxx/ddb5xxx.h>
+#include <asm/ddb5xxx/ddb5074.h>
+
+
+extern void __init i8259_init(void);
+extern void i8259_disable_irq(unsigned int irq_nr);
+extern void i8259_enable_irq(unsigned int irq_nr);
+
+extern asmlinkage void ddbIRQ(void);
+extern asmlinkage void i8259_do_irq(int irq, struct pt_regs *regs);
+extern asmlinkage void do_IRQ(int irq, struct pt_regs *regs);
+
+static struct irqaction irq_cascade = { no_action, 0, 0, "cascade", NULL, NULL };
+
+#define M1543_PNP_CONFIG	0x03f0	/* PnP Config Port */
+#define M1543_PNP_INDEX		0x03f0	/* PnP Index Port */
+#define M1543_PNP_DATA		0x03f1	/* PnP Data Port */
+
+#define M1543_PNP_ALT_CONFIG	0x0370	/* Alternative PnP Config Port */
+#define M1543_PNP_ALT_INDEX	0x0370	/* Alternative PnP Index Port */
+#define M1543_PNP_ALT_DATA	0x0371	/* Alternative PnP Data Port */
+
+#define M1543_INT1_MASTER_CTRL	0x0020	/* INT_1 (master) Control Register */
+#define M1543_INT1_MASTER_MASK	0x0021	/* INT_1 (master) Mask Register */
+
+#define M1543_INT1_SLAVE_CTRL	0x00a0	/* INT_1 (slave) Control Register */
+#define M1543_INT1_SLAVE_MASK	0x00a1	/* INT_1 (slave) Mask Register */
+
+#define M1543_INT1_MASTER_ELCR	0x04d0	/* INT_1 (master) Edge/Level Control */
+#define M1543_INT1_SLAVE_ELCR	0x04d1	/* INT_1 (slave) Edge/Level Control */
+
+
+static void m1543_irq_setup(void)
+{
+	/*
+	 *  The ALI M1543 has 13 interrupt inputs, IRQ1..IRQ13.  Not all
+	 *  the possible IO sources in the M1543 are in use by us.  We will
+	 *  use the following mapping:
+	 *
+	 *      IRQ1  - keyboard (default set by M1543)
+	 *      IRQ3  - reserved for UART B (default set by M1543) (note that
+	 *              the schematics for the DDB Vrc-5074 board seem to 
+	 *              indicate that IRQ3 is connected to the DS1386 
+	 *              watchdog timer interrupt output so we might have 
+	 *              a conflict)
+	 *      IRQ4  - reserved for UART A (default set by M1543)
+	 *      IRQ5  - parallel (default set by M1543)
+	 *      IRQ8  - DS1386 time of day (RTC) interrupt
+	 *      IRQ12 - mouse
+	 */
+
+	/*
+	 *  Assing mouse interrupt to IRQ12 
+	 */
+
+	/* Enter configuration mode */
+	outb(0x51, M1543_PNP_CONFIG);
+	outb(0x23, M1543_PNP_CONFIG);
+
+	/* Select logical device 7 (Keyboard) */
+	outb(0x07, M1543_PNP_INDEX);
+	outb(0x07, M1543_PNP_DATA);
+
+	/* Select IRQ12 */
+	outb(0x72, M1543_PNP_INDEX);
+	outb(0x0c, M1543_PNP_DATA);
+
+	outb(0x30, M1543_PNP_INDEX);
+
+	outb(0x70, M1543_PNP_INDEX);
+
+	/* Leave configration mode */
+	outb(0xbb, M1543_PNP_CONFIG);
+
+
+}
+
+void ddb_local0_irqdispatch(struct pt_regs *regs)
+{
+	u32 mask;
+	int nile4_irq;
+
+	mask = nile4_get_irq_stat(0);
+
+	/* Handle the timer interrupt first */
+#if 0
+	if (mask & (1 << NILE4_INT_GPT)) {
+		do_IRQ(nile4_to_irq(NILE4_INT_GPT), regs);
+		mask &= ~(1 << NILE4_INT_GPT);
+	}
+#endif
+	for (nile4_irq = 0; mask; nile4_irq++, mask >>= 1)
+		if (mask & 1) {
+			if (nile4_irq == NILE4_INT_INTE) {
+				int i8259_irq;
+				
+				nile4_clear_irq(NILE4_INT_INTE);
+				i8259_irq = nile4_i8259_iack();
+				do_IRQ(i8259_irq, regs);
+			} else
+				do_IRQ(nile4_to_irq(nile4_irq), regs);
+
+		}
+}
+
+void ddb_local1_irqdispatch(void)
+{
+	printk("ddb_local1_irqdispatch called\n");
+}
+
+void ddb_buserror_irq(void)
+{
+	printk("ddb_buserror_irq called\n");
+}
+
+void ddb_8254timer_irq(void)
+{
+	printk("ddb_8254timer_irq called\n");
+}
+
+void __init ddb_irq_setup(void)
+{
+#ifdef CONFIG_REMOTE_DEBUG
+	if (remote_debug)
+		set_debug_traps();
+	breakpoint();		/* you may move this line to whereever you want :-) */
+#endif
+
+	/* setup cascade interrupts */
+	setup_irq(NILE4_IRQ_BASE  + NILE4_INT_INTE, &irq_cascade);
+	setup_irq(CPU_IRQ_BASE + CPU_NILE4_CASCADE, &irq_cascade);
+
+	set_except_vector(0, ddbIRQ);
+
+	nile4_irq_setup(NILE4_IRQ_BASE);
+	m1543_irq_setup();
+	init_i8259_irqs();
+	
+	mips_cpu_irq_init(CPU_IRQ_BASE);
+
+	ddb5074_led_hex(0);
+
+	/* Enable the interrupt cascade */
+	nile4_enable_irq(NILE4_IRQ_BASE+IRQ_I8259_CASCADE);
+
+
+}
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/arch/mips/ddb5xxx/ddb5074/nile4_pic.c linux/arch/mips/ddb5xxx/ddb5074/nile4_pic.c
--- linux.orig/linux/arch/mips/ddb5xxx/ddb5074/nile4_pic.c	Thu Jan  1 01:00:00 1970
+++ linux/arch/mips/ddb5xxx/ddb5074/nile4_pic.c	Tue Feb 26 10:54:06 2002
@@ -0,0 +1,288 @@
+/*
+ *  arch/mips/ddb5476/nile4.c -- 
+ *  	low-level PIC code for NEC Vrc-5476 (Nile 4)
+ *
+ *  Copyright (C) 2000 Geert Uytterhoeven <geert@sonycom.com>
+ *                     Sony Software Development Center Europe (SDCE), Brussels
+ *
+ *  Copyright 2001 MontaVista Software Inc.
+ *  Author: jsun@mvista.com or jsun@junsun.net
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+
+#include <asm/addrspace.h>
+
+#include <asm/ddb5xxx/ddb5xxx.h>
+
+static int irq_base;
+
+/*
+ *  Interrupt Programming
+ */
+void nile4_map_irq(int nile4_irq, int cpu_irq)
+{
+	u32 offset, t;
+
+	offset = DDB_INTCTRL;
+	if (nile4_irq >= 8) {
+		offset += 4;
+		nile4_irq -= 8;
+	}
+	t = ddb_in32(offset);
+	t &= ~(7 << (nile4_irq * 4));
+	t |= cpu_irq << (nile4_irq * 4);
+	ddb_out32(offset, t);
+}
+
+void nile4_map_irq_all(int cpu_irq)
+{
+	u32 all, t;
+
+	all = cpu_irq;
+	all |= all << 4;
+	all |= all << 8;
+	all |= all << 16;
+	t = ddb_in32(DDB_INTCTRL);
+	t &= 0x88888888;
+	t |= all;
+	ddb_out32(DDB_INTCTRL, t);
+	t = ddb_in32(DDB_INTCTRL + 4);
+	t &= 0x88888888;
+	t |= all;
+	ddb_out32(DDB_INTCTRL + 4, t);
+}
+
+void nile4_enable_irq(int nile4_irq)
+{
+	u32 offset, t;
+
+	nile4_irq-=irq_base;
+
+	ddb5074_led_hex(8);
+
+	offset = DDB_INTCTRL;
+	if (nile4_irq >= 8) {
+		offset += 4;
+		nile4_irq -= 8;
+	}
+	ddb5074_led_hex(9);
+	t = ddb_in32(offset);
+	ddb5074_led_hex(0xa);
+	t |= 8 << (nile4_irq * 4);
+	ddb_out32(offset, t);
+	ddb5074_led_hex(0xb);
+}
+
+void nile4_disable_irq(int nile4_irq)
+{
+	u32 offset, t;
+
+	nile4_irq-=irq_base;
+
+	offset = DDB_INTCTRL;
+	if (nile4_irq >= 8) {
+		offset += 4;
+		nile4_irq -= 8;
+	}
+	t = ddb_in32(offset);
+	t &= ~(8 << (nile4_irq * 4));
+	ddb_out32(offset, t);
+}
+
+void nile4_disable_irq_all(void)
+{
+	ddb_out32(DDB_INTCTRL, 0);
+	ddb_out32(DDB_INTCTRL + 4, 0);
+}
+
+u16 nile4_get_irq_stat(int cpu_irq)
+{
+	return ddb_in16(DDB_INTSTAT0 + cpu_irq * 2);
+}
+
+void nile4_enable_irq_output(int cpu_irq)
+{
+	u32 t;
+
+	t = ddb_in32(DDB_INTSTAT1 + 4);
+	t |= 1 << (16 + cpu_irq);
+	ddb_out32(DDB_INTSTAT1, t);
+}
+
+void nile4_disable_irq_output(int cpu_irq)
+{
+	u32 t;
+
+	t = ddb_in32(DDB_INTSTAT1 + 4);
+	t &= ~(1 << (16 + cpu_irq));
+	ddb_out32(DDB_INTSTAT1, t);
+}
+
+void nile4_set_pci_irq_polarity(int pci_irq, int high)
+{
+	u32 t;
+
+	t = ddb_in32(DDB_INTPPES);
+	if (high)
+		t &= ~(1 << (pci_irq * 2));
+	else
+		t |= 1 << (pci_irq * 2);
+	ddb_out32(DDB_INTPPES, t);
+}
+
+void nile4_set_pci_irq_level_or_edge(int pci_irq, int level)
+{
+	u32 t;
+
+	t = ddb_in32(DDB_INTPPES);
+	if (level)
+		t |= 2 << (pci_irq * 2);
+	else
+		t &= ~(2 << (pci_irq * 2));
+	ddb_out32(DDB_INTPPES, t);
+}
+
+void nile4_clear_irq(int nile4_irq)
+{
+	nile4_irq-=irq_base;
+	ddb_out32(DDB_INTCLR, 1 << nile4_irq);
+}
+
+void nile4_clear_irq_mask(u32 mask)
+{
+	ddb_out32(DDB_INTCLR, mask);
+}
+
+u8 nile4_i8259_iack(void)
+{
+	u8 irq;
+	u32 reg;
+
+	/* Set window 0 for interrupt acknowledge */
+	reg = ddb_in32(DDB_PCIINIT0);
+
+	ddb_set_pmr(DDB_PCIINIT0, DDB_PCICMD_IACK, 0, DDB_PCI_ACCESS_32);
+	irq = *(volatile u8 *) KSEG1ADDR(DDB_PCI_IACK_BASE);
+	/* restore window 0 for PCI I/O space */
+	// ddb_set_pmr(DDB_PCIINIT0, DDB_PCICMD_IO, 0, DDB_PCI_ACCESS_32);
+	ddb_out32(DDB_PCIINIT0, reg);
+
+	/* i8269.c set the base vector to be 0x0 */
+	return irq ;
+}
+
+static int nile4_irq_startup(int irq) {
+
+	nile4_enable_irq(irq);
+	return 0;
+
+}
+
+static void nile4_ack_irq(int irq) {
+
+    ddb5074_led_hex(4);
+
+	nile4_clear_irq(irq);
+    ddb5074_led_hex(2);
+	nile4_disable_irq(irq);
+
+    ddb5074_led_hex(0);
+}
+
+static void nile4_irq_end(int irq) {
+
+	ddb5074_led_hex(3);
+	if(!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
+	ddb5074_led_hex(5);
+		nile4_enable_irq(irq);
+	ddb5074_led_hex(7);
+	}
+
+	ddb5074_led_hex(1);
+}
+
+#define nile4_irq_shutdown nile4_disable_irq
+
+static hw_irq_controller nile4_irq_controller = {
+    "nile4",
+    nile4_irq_startup,
+    nile4_irq_shutdown,
+    nile4_enable_irq,
+    nile4_disable_irq,
+    nile4_ack_irq,
+    nile4_irq_end,
+    NULL
+};
+
+void nile4_irq_setup(u32 base) {
+
+	int i;
+	extern irq_desc_t irq_desc[];
+
+	irq_base=base;
+
+	/* Map all interrupts to CPU int #0 */
+	nile4_map_irq_all(0);
+
+	/* PCI INTA#-E# must be level triggered */
+	nile4_set_pci_irq_level_or_edge(0, 1);
+	nile4_set_pci_irq_level_or_edge(1, 1);
+	nile4_set_pci_irq_level_or_edge(2, 1);
+	nile4_set_pci_irq_level_or_edge(3, 1);
+	nile4_set_pci_irq_level_or_edge(4, 1);
+
+	/* PCI INTA#-D# must be active low, INTE# must be active high */
+	nile4_set_pci_irq_polarity(0, 0);
+	nile4_set_pci_irq_polarity(1, 0);
+	nile4_set_pci_irq_polarity(2, 0);
+	nile4_set_pci_irq_polarity(3, 0);
+	nile4_set_pci_irq_polarity(4, 1);
+
+
+	for (i = 0; i < 16; i++) {
+		nile4_clear_irq(i);
+		nile4_disable_irq(i);
+	}
+
+	/* Enable CPU int #0 */
+	nile4_enable_irq_output(0);
+
+	for (i= base; i< base + NUM_NILE4_INTERRUPTS; i++) {
+		irq_desc[i].status = IRQ_DISABLED;
+		irq_desc[i].action = NULL;
+		irq_desc[i].depth = 1;
+		irq_desc[i].handler = &nile4_irq_controller;
+	}
+
+}
+
+#if defined(CONFIG_LL_DEBUG)
+void nile4_dump_irq_status(void)
+{
+	printk(KERN_DEBUG "
+	       CPUSTAT = %p:%p\n", (void *) ddb_in32(DDB_CPUSTAT + 4),
+	       (void *) ddb_in32(DDB_CPUSTAT));
+	printk(KERN_DEBUG "
+	       INTCTRL = %p:%p\n", (void *) ddb_in32(DDB_INTCTRL + 4),
+	       (void *) ddb_in32(DDB_INTCTRL));
+	printk(KERN_DEBUG
+	       "INTSTAT0 = %p:%p\n",
+	       (void *) ddb_in32(DDB_INTSTAT0 + 4),
+	       (void *) ddb_in32(DDB_INTSTAT0));
+	printk(KERN_DEBUG
+	       "INTSTAT1 = %p:%p\n",
+	       (void *) ddb_in32(DDB_INTSTAT1 + 4),
+	       (void *) ddb_in32(DDB_INTSTAT1));
+	printk(KERN_DEBUG
+	       "INTCLR = %p:%p\n", (void *) ddb_in32(DDB_INTCLR + 4),
+	       (void *) ddb_in32(DDB_INTCLR));
+	printk(KERN_DEBUG
+	       "INTPPES = %p:%p\n", (void *) ddb_in32(DDB_INTPPES + 4),
+	       (void *) ddb_in32(DDB_INTPPES));
+}
+
+#endif
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/arch/mips/ddb5xxx/ddb5074/pci.c linux/arch/mips/ddb5xxx/ddb5074/pci.c
--- linux.orig/linux/arch/mips/ddb5xxx/ddb5074/pci.c	Thu Jan  1 01:00:00 1970
+++ linux/arch/mips/ddb5xxx/ddb5074/pci.c	Sun Mar 10 03:20:55 2002
@@ -0,0 +1,129 @@
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+
+#include <asm/pci_channel.h>
+#include <asm/debug.h>
+
+#include <asm/ddb5xxx/ddb5xxx.h>
+
+static struct resource extpci_io_resource = {
+    "pci IO space",
+    0x1000,             /* leave some room for ISA bus */
+    DDB_PCI_IO_SIZE -1,
+    IORESOURCE_IO};
+
+static struct resource extpci_mem_resource = {
+    "pci memory space",
+    DDB_PCI_MEM_BASE + 0x00100000,  /* leave 1 MB for RTC */
+    DDB_PCI_MEM_BASE + DDB_PCI_MEM_SIZE -1,
+    IORESOURCE_MEM};
+
+extern struct pci_ops ddb5476_ext_pci_ops;
+
+struct pci_channel mips_pci_channels[] = {
+    { &ddb5476_ext_pci_ops, &extpci_io_resource, &extpci_mem_resource },
+    { NULL, NULL, NULL}
+};
+
+#define     PCI_EXT_INTA        8
+#define     PCI_EXT_INTB        9
+#define     PCI_EXT_INTC        10
+#define     PCI_EXT_INTD        11
+#define     PCI_EXT_INTE        12
+
+#define     MAX_SLOT_NUM        14
+
+static unsigned char irq_map[MAX_SLOT_NUM] = {
+	/* SLOT:  0 */ nile4_to_irq(PCI_EXT_INTE),
+	/* SLOT:  1 */ nile4_to_irq(PCI_EXT_INTA),
+	/* SLOT:  2 */ nile4_to_irq(PCI_EXT_INTA),
+	/* SLOT:  3 */ nile4_to_irq(PCI_EXT_INTB),		
+	/* SLOT:  4 */ nile4_to_irq(PCI_EXT_INTC),
+	/* SLOT:  5 */ nile4_to_irq(NILE4_INT_UART),
+	/* SLOT:  6 */ 0xff,
+	/* SLOT:  7 */ 0xff,
+	/* SLOT:  8 */ 0xff,
+	/* SLOT:  9 */ 0xff,
+	/* SLOT:  10 */ nile4_to_irq(PCI_EXT_INTE),
+	/* SLOT:  11 */ 0xff,
+	/* SLOT:  12 */ 0xff,
+	/* SLOT:  13 */ nile4_to_irq(PCI_EXT_INTE),
+};
+
+void __init pcibios_fixup_irqs(void) {
+
+	struct pci_dev *dev;
+	int slot_num;
+
+	pci_for_each_dev(dev) {	
+		slot_num = PCI_SLOT(dev->devfn);
+		db_assert(slot_num < MAX_SLOT_NUM);
+		db_assert(irq_map[slot_num] != 0xff);
+
+		pci_write_config_byte(dev,
+							PCI_INTERRUPT_LINE,
+							irq_map[slot_num]);
+
+		dev->irq = irq_map[slot_num];
+	}
+}
+
+void __init ddb_pci_reset_bus(void)
+{
+    u32 temp;
+
+    /*
+     * I am not sure about the "official" procedure, the following
+     * steps work as far as I know:
+     * We first set PCI cold reset bit (bit 31) in PCICTRL-H.
+     * Then we clear the PCI warm reset bit (bit 30) to 0 in PCICTRL-H.
+     * The same is true for both PCI channels.
+     */
+    temp = ddb_in32(DDB_PCICTRL+4);
+    temp |= 0x80000000;
+    ddb_out32(DDB_PCICTRL+4, temp);
+    temp &= ~0xc0000000;
+    ddb_out32(DDB_PCICTRL+4, temp);
+
+}
+
+unsigned __init int pcibios_assign_all_busses(void)
+{
+    /* we hope pci_auto has assigned the bus numbers to all buses */
+    return 1;
+}
+
+void __init pcibios_fixup_resources(struct pci_dev *dev)
+{
+}
+
+void __init pcibios_fixup(void)
+{
+	struct pci_dev *dev;
+
+	pci_for_each_dev(dev) {
+		if (dev->vendor == PCI_VENDOR_ID_AL &&
+			dev->device == PCI_DEVICE_ID_AL_M7101) {
+				/*
+				 * It's nice to have the LEDs on the GPIO pins
+				 * available for debugging
+				 */
+				extern struct pci_dev *pci_pmu;
+				u8 t8;
+					 
+				pci_pmu = dev;  /* for LEDs D2 and D3 */
+				/* Program the lines for LEDs D2 and D3 to output */
+				pci_read_config_byte(dev, 0x7d, &t8);
+				t8 |= 0xc0;
+				pci_write_config_byte(dev, 0x7d, t8);
+				/* Turn LEDs D2 and D3 off */
+				pci_read_config_byte(dev, 0x7e, &t8);
+				t8 |= 0xc0;
+				pci_write_config_byte(dev, 0x7e, t8);
+
+		}
+	}
+}
+
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/arch/mips/ddb5xxx/ddb5074/pci_ops.c linux/arch/mips/ddb5xxx/ddb5074/pci_ops.c
--- linux.orig/linux/arch/mips/ddb5xxx/ddb5074/pci_ops.c	Thu Jan  1 01:00:00 1970
+++ linux/arch/mips/ddb5xxx/ddb5074/pci_ops.c	Mon Feb 25 19:12:48 2002
@@ -0,0 +1,342 @@
+/*
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ *
+ * arch/mips/ddb5xxx/ddb5476/pci_ops.c
+ *     Define the pci_ops for DB5477.
+ *
+ * Much of the code is derived from the original DDB5074 port by 
+ * Geert Uytterhoeven <geert@sonycom.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include <asm/addrspace.h>
+#include <asm/debug.h>
+
+#include <asm/ddb5xxx/ddb5xxx.h>
+
+/*
+ * config_swap structure records what set of pdar/pmr are used
+ * to access pci config space.  It also provides a place hold the
+ * original values for future restoring.
+ */
+struct pci_config_swap {
+	u32 	pdar;
+	u32	pmr;
+	u32	config_base;
+	u32	config_size;
+	u32	pdar_backup;
+	u32	pmr_backup;
+};
+
+/*
+ * On DDB5476, we have one set of swap registers
+ */
+struct pci_config_swap ext_pci_swap = {
+	DDB_PCIW0,  
+	DDB_PCIINIT0,
+	DDB_PCI_CONFIG_BASE,
+	DDB_PCI_CONFIG_SIZE
+};
+
+static int pci_config_workaround=1;
+
+/*
+ * access config space
+ */	
+static inline u32 ddb_access_config_base(struct pci_config_swap *swap,
+					 u32 bus,/* 0 means top level bus */
+					 u32 slot_num)
+{
+	u32 pci_addr = 0;
+	u32 pciinit_offset = 0;
+        u32 virt_addr = swap->config_base;
+	u32 option;
+
+	if (pci_config_workaround) {
+		if (slot_num == 5) slot_num = 14;
+	}
+	else {
+		if (slot_num == 5) return DDB_BASE + DDB_PCI_BASE;
+	}
+
+	/* minimum pdar (window) size is 2MB */
+	db_assert(swap->config_size >= (2 << 20));
+
+	db_assert(slot_num < (1 << 5));
+	db_assert(bus < (1 << 8));
+
+	/* backup registers */
+	swap->pdar_backup = ddb_in32(swap->pdar);
+	swap->pmr_backup = ddb_in32(swap->pmr);
+
+	/* set the pdar (pci window) register */
+	ddb_set_pdar(swap->pdar,
+		     swap->config_base,
+		     swap->config_size,
+		     32,	/* 32 bit wide */
+		     0,		/* not on local memory bus */
+		     0);	/* not visible from PCI bus (N/A) */
+
+	/* 
+	 * calcuate the absolute pci config addr; 
+	 * according to the spec, we start scanning from adr:11 (0x800)
+	 */ 
+	if (bus == 0) {
+		/* type 0 config */
+		pci_addr = 0x00040000 << slot_num;
+	} else {
+		/* type 1 config */
+		pci_addr = 0x00040000 << slot_num;
+		panic("ddb_access_config_base: we don't support type 1 config Yet");
+	}
+
+	/*
+	 * if pci_addr is less than pci config window size,  we set
+	 * pciinit_offset to 0 and adjust the virt_address.
+	 * Otherwise we will try to adjust pciinit_offset.
+	 */
+	if (pci_addr < swap->config_size) {
+		virt_addr = KSEG1ADDR(swap->config_base + pci_addr);
+		pciinit_offset = 0;
+	} else {
+		db_assert( (pci_addr & (swap->config_size - 1)) == 0);
+		virt_addr = KSEG1ADDR(swap->config_base);
+		pciinit_offset = pci_addr;
+	}
+
+	/* set the pmr register */
+	option = DDB_PCI_ACCESS_32;
+	if (bus != 0) option |= DDB_PCI_CFGTYPE1;
+	ddb_set_pmr(swap->pmr, DDB_PCICMD_CFG, pciinit_offset, option);
+
+	return virt_addr;
+}
+
+static inline void ddb_close_config_base(struct pci_config_swap *swap)
+{
+	ddb_out32(swap->pdar, swap->pdar_backup);
+	ddb_out32(swap->pmr, swap->pmr_backup);
+}
+
+static int read_config_dword(struct pci_config_swap *swap,
+			     struct pci_dev *dev,
+			     u32 where,
+			     u32 *val)
+{
+	u32 bus, slot_num, func_num;
+	u32 base;
+
+	db_assert((where & 3) == 0);
+	db_assert(where < (1 << 8));
+
+	/* check if the bus is top-level */
+	if (dev->bus->parent != NULL) {
+		bus = dev->bus->number;
+		db_assert(bus != 0);
+	} else {
+		bus = 0;
+	}
+
+	slot_num = PCI_SLOT(dev->devfn);
+	func_num = PCI_FUNC(dev->devfn);
+	base = ddb_access_config_base(swap, bus, slot_num);
+	*val = *(volatile u32*) (base + (func_num << 8) + where);
+	ddb_close_config_base(swap);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int read_config_word(struct pci_config_swap *swap,
+			    struct pci_dev *dev,
+			    u32 where,
+			    u16 *val)
+{
+        int status;
+        u32 result;
+
+	db_assert((where & 1) == 0);
+
+        status = read_config_dword(swap, dev, where & ~3, &result);
+        if (where & 2) result >>= 16;
+        *val = result & 0xffff;
+        return status;
+}
+
+static int read_config_byte(struct pci_config_swap *swap,
+			    struct pci_dev *dev,
+			    u32 where,
+			    u8 *val)
+{
+        int status;
+        u32 result;
+
+        status = read_config_dword(swap, dev, where & ~3, &result);
+        if (where & 1) result >>= 8;
+        if (where & 2) result >>= 16;
+        *val = result & 0xff;
+        return status;
+}
+
+static int write_config_dword(struct pci_config_swap *swap,
+			      struct pci_dev *dev,
+			      u32 where,
+			      u32 val)
+{
+	u32 bus, slot_num, func_num;
+	u32 base;
+
+	db_assert((where & 3) == 0);
+	db_assert(where < (1 << 8));
+
+	/* check if the bus is top-level */
+	if (dev->bus->parent != NULL) {
+		bus = dev->bus->number;
+		db_assert(bus != 0);
+	} else {
+		bus = 0;
+	}
+
+	slot_num = PCI_SLOT(dev->devfn);
+	func_num = PCI_FUNC(dev->devfn);
+	base = ddb_access_config_base(swap, bus, slot_num);
+	*(volatile u32*) (base + (func_num << 8) + where) = val; 
+	ddb_close_config_base(swap);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int write_config_word(struct pci_config_swap *swap,
+			     struct pci_dev *dev,
+			     u32 where,
+			     u16 val)
+{
+	int status, shift=0;
+	u32 result;
+
+	db_assert((where & 1) == 0);
+
+	status = read_config_dword(swap, dev, where & ~3, &result);
+	if (status != PCIBIOS_SUCCESSFUL) return status;
+
+        if (where & 2)
+                shift += 16;
+        result &= ~(0xffff << shift);
+        result |= val << shift;
+        return write_config_dword(swap, dev, where & ~3, result);
+}
+
+static int write_config_byte(struct pci_config_swap *swap,
+			     struct pci_dev *dev,
+			     u32 where,
+			     u8 val)
+{
+	int status, shift=0;
+	u32 result;
+
+	status = read_config_dword(swap, dev, where & ~3, &result);
+	if (status != PCIBIOS_SUCCESSFUL) return status;
+
+        if (where & 2)
+                shift += 16;
+        if (where & 1)
+                shift += 8;
+        result &= ~(0xff << shift);
+        result |= val << shift;
+        return write_config_dword(swap, dev, where & ~3, result);
+}
+
+#define	MAKE_PCI_OPS(prefix, rw, unitname, unittype, pciswap) \
+static int prefix##_##rw##_config_##unitname(struct pci_dev *dev, int where, unittype val) \
+{ \
+     return rw##_config_##unitname(pciswap, \
+                                   dev, \
+                                   where, \
+                                   val); \
+}
+
+MAKE_PCI_OPS(extpci, read, byte, u8 *, &ext_pci_swap)
+MAKE_PCI_OPS(extpci, read, word, u16 *, &ext_pci_swap)
+MAKE_PCI_OPS(extpci, read, dword, u32 *, &ext_pci_swap)
+
+MAKE_PCI_OPS(extpci, write, byte, u8, &ext_pci_swap)
+MAKE_PCI_OPS(extpci, write, word, u16, &ext_pci_swap)
+MAKE_PCI_OPS(extpci, write, dword, u32, &ext_pci_swap)
+
+struct pci_ops ddb5476_ext_pci_ops ={
+	extpci_read_config_byte,
+	extpci_read_config_word,
+	extpci_read_config_dword,
+	extpci_write_config_byte,
+	extpci_write_config_word,
+	extpci_write_config_dword
+};
+
+
+#if defined(CONFIG_DEBUG)
+void jsun_scan_pci_bus(void)
+{
+	struct pci_bus bus;
+	struct pci_dev dev;
+	unsigned int devfn;
+	int j;
+
+	pci_config_workaround = 0;
+
+	bus.parent = NULL;	/* we scan the top level only */
+	dev.bus = &bus;
+	dev.sysdata = NULL;
+
+	/* scan ext pci bus and io pci bus*/
+	for (j=0; j< 1; j++) {
+		printk(KERN_INFO "scan ddb5476 external PCI bus:\n");
+		bus.ops = &ddb5476_ext_pci_ops;
+	
+		for (devfn = 0; devfn < 0x100; devfn += 8) {
+			u32 temp;
+			u16 temp16;
+			u8 temp8;
+			int i;
+
+			dev.devfn = devfn;
+			db_verify(pci_read_config_dword(&dev, 0, &temp),
+				    == PCIBIOS_SUCCESSFUL);
+			if (temp == 0xffffffff) continue;
+
+			printk(KERN_INFO "slot %d: (addr %d) \n", devfn/8,
+			       11+devfn/8);
+
+			/* verify read word and byte */
+			db_verify(pci_read_config_word(&dev, 2, &temp16),
+				  == PCIBIOS_SUCCESSFUL);
+			db_assert(temp16 == (temp >> 16));
+			db_verify(pci_read_config_byte(&dev, 3, &temp8),
+				  == PCIBIOS_SUCCESSFUL);
+			db_assert(temp8 == (temp >> 24));
+			db_verify(pci_read_config_byte(&dev, 1, &temp8),
+				  == PCIBIOS_SUCCESSFUL);
+			db_assert(temp8 == ((temp >> 8) & 0xff));
+
+			for (i=0; i < 16; i++) {
+				if ((i%4) == 0)
+					printk(KERN_INFO);
+				db_verify(pci_read_config_dword(&dev, i*4, &temp),
+					  == PCIBIOS_SUCCESSFUL);
+				printk("\t%08X", temp);
+				if ((i%4) == 3)
+					printk("\n");
+			}
+		}
+	}
+
+	pci_config_workaround = 1;
+}
+#endif
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/arch/mips/ddb5xxx/ddb5074/setup.c linux/arch/mips/ddb5xxx/ddb5074/setup.c
--- linux.orig/linux/arch/mips/ddb5xxx/ddb5074/setup.c	Thu Jan  1 01:00:00 1970
+++ linux/arch/mips/ddb5xxx/ddb5074/setup.c	Tue Feb 26 10:52:45 2002
@@ -0,0 +1,258 @@
+/*
+ *  arch/mips/ddb5074/setup.c -- NEC DDB Vrc-5074 setup routines
+ *
+ *  Copyright (C) 2000 Geert Uytterhoeven <geert@sonycom.com>
+ *                     Sony Software Development Center Europe (SDCE), Brussels
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kbd_ll.h>
+#include <linux/kernel.h>
+#include <linux/kdev_t.h>
+#include <linux/types.h>
+#include <linux/console.h>
+#include <linux/sched.h>
+#include <linux/mc146818rtc.h>
+#include <linux/pc_keyb.h>
+#include <linux/pci.h>
+#include <linux/ide.h>
+#include <linux/ioport.h>
+
+#include <asm/addrspace.h>
+#include <asm/bcache.h>
+#include <asm/keyboard.h>
+#include <asm/irq.h>
+#include <asm/reboot.h>
+#include <asm/gdb-stub.h>
+#include <asm/nile4.h>
+#include <asm/ddb5xxx/ddb5074.h>
+#include <asm/ddb5xxx/ddb5xxx.h>
+
+
+#ifdef CONFIG_REMOTE_DEBUG
+extern void rs_kgdb_hook(int);
+extern void breakpoint(void);
+#endif
+
+#if defined(CONFIG_SERIAL_CONSOLE)
+extern void console_setup(char *);
+#endif
+
+extern struct ide_ops std_ide_ops;
+extern struct kbd_ops std_kbd_ops;
+
+static void (*back_to_prom) (void) = (void (*)(void)) 0xbfc00000;
+
+static void ddb_machine_restart(char *command)
+{
+	u32 t;
+
+	/* PCI cold reset */
+	t = nile4_in32(NILE4_PCICTRL + 4);
+	t |= 0x40000000;
+	nile4_out32(NILE4_PCICTRL + 4, t);
+	/* CPU cold reset */
+	t = nile4_in32(NILE4_CPUSTAT);
+	t |= 1;
+	nile4_out32(NILE4_CPUSTAT, t);
+	/* Call the PROM */
+	back_to_prom();
+}
+
+static void ddb_machine_halt(void)
+{
+	printk("DDB Vrc-5074 halted.\n");
+	do {
+	} while (1);
+}
+
+static void ddb_machine_power_off(void)
+{
+	printk("DDB Vrc-5074 halted. Please turn off the power.\n");
+	do {
+	} while (1);
+}
+
+extern void ddb_irq_setup(void);
+
+extern void (*board_timer_setup) (struct irqaction * irq);
+
+void __init bus_error_init(void)
+{
+}
+
+static void __init ddb_time_init(struct irqaction *irq)
+{
+	/* set the clock to 1 Hz */
+	nile4_out32(NILE4_T2CTRL, 1000000);
+	/* enable the General-Purpose Timer */
+	nile4_out32(NILE4_T2CTRL + 4, 0x00000001);
+	/* reset timer */
+	nile4_out32(NILE4_T2CNTR, 0);
+	/* enable interrupt */
+	setup_irq(nile4_to_irq(NILE4_INT_GPT), irq);
+	nile4_enable_irq(nile4_to_irq(NILE4_INT_GPT));
+	change_cp0_status(ST0_IM,
+		          IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3 | IE_IRQ4);
+}
+
+void __init ddb_setup(void)
+{
+	extern int panic_timeout;
+
+	irq_setup = ddb_irq_setup;
+	set_io_port_base(NILE4_PCI_IO_BASE);
+	isa_slot_offset = NILE4_PCI_MEM_BASE;
+	board_timer_setup = ddb_time_init;
+
+	_machine_restart = ddb_machine_restart;
+	_machine_halt = ddb_machine_halt;
+	_machine_power_off = ddb_machine_power_off;
+
+#ifdef CONFIG_BLK_DEV_IDE
+	ide_ops = &std_ide_ops;
+#endif
+
+#ifdef CONFIG_PC_KEYB
+	    kbd_ops = &std_kbd_ops;
+#endif
+
+    ddb_out32(DDB_BAR0, 0);
+
+	ddb_set_pmr(DDB_PCIINIT0, DDB_PCICMD_IO, 0, 0x10);
+	ddb_set_pmr(DDB_PCIINIT1, DDB_PCICMD_MEM, DDB_PCI_MEM_BASE , 0x10);
+
+#ifdef CONFIG_FB
+    conswitchp = &dummy_con;
+#endif
+
+	/* Reboot on panic */
+	panic_timeout = 180;
+}
+
+
+#define USE_NILE4_SERIAL	0
+
+#if USE_NILE4_SERIAL
+#define ns16550_in(reg)		nile4_in8((reg)*8)
+#define ns16550_out(reg, val)	nile4_out8((reg)*8, (val))
+#else
+#define NS16550_BASE		(NILE4_PCI_IO_BASE+0x03f8)
+static inline u8 ns16550_in(u32 reg)
+{
+	return *(volatile u8 *) (NS16550_BASE + reg);
+}
+
+static inline void ns16550_out(u32 reg, u8 val)
+{
+	*(volatile u8 *) (NS16550_BASE + reg) = val;
+}
+#endif
+
+#define NS16550_RBR		0
+#define NS16550_THR		0
+#define NS16550_DLL		0
+#define NS16550_IER		1
+#define NS16550_DLM		1
+#define NS16550_FCR		2
+#define NS16550_IIR		2
+#define NS16550_LCR		3
+#define NS16550_MCR		4
+#define NS16550_LSR		5
+#define NS16550_MSR		6
+#define NS16550_SCR		7
+
+#define NS16550_LSR_DR		0x01	/* Data ready */
+#define NS16550_LSR_OE		0x02	/* Overrun */
+#define NS16550_LSR_PE		0x04	/* Parity error */
+#define NS16550_LSR_FE		0x08	/* Framing error */
+#define NS16550_LSR_BI		0x10	/* Break */
+#define NS16550_LSR_THRE	0x20	/* Xmit holding register empty */
+#define NS16550_LSR_TEMT	0x40	/* Xmitter empty */
+#define NS16550_LSR_ERR		0x80	/* Error */
+
+
+void _serinit(void)
+{
+#if USE_NILE4_SERIAL
+	ns16550_out(NS16550_LCR, 0x80);
+	ns16550_out(NS16550_DLM, 0x00);
+	ns16550_out(NS16550_DLL, 0x36);	/* 9600 baud */
+	ns16550_out(NS16550_LCR, 0x00);
+	ns16550_out(NS16550_LCR, 0x03);
+	ns16550_out(NS16550_FCR, 0x47);
+#else
+	/* done by PMON */
+#endif
+}
+
+void _putc(char c)
+{
+	while (!(ns16550_in(NS16550_LSR) & NS16550_LSR_THRE));
+	ns16550_out(NS16550_THR, c);
+	if (c == '\n') {
+		while (!(ns16550_in(NS16550_LSR) & NS16550_LSR_THRE));
+		ns16550_out(NS16550_THR, '\r');
+	}
+}
+
+void _puts(const char *s)
+{
+	char c;
+	while ((c = *s++))
+		_putc(c);
+}
+
+char _getc(void)
+{
+	while (!(ns16550_in(NS16550_LSR) & NS16550_LSR_DR));
+	return ns16550_in(NS16550_RBR);
+}
+
+int _testc(void)
+{
+	return (ns16550_in(NS16550_LSR) & NS16550_LSR_DR) != 0;
+}
+
+
+/*
+ *  Hexadecimal 7-segment LED
+ */
+void ddb5074_led_hex(int hex)
+{
+	outb(hex, 0x80);
+}
+
+
+/*
+ *  LEDs D2 and D3, connected to the GPIO pins of the PMU in the ALi M1543
+ */
+struct pci_dev *pci_pmu = NULL;
+
+void ddb5074_led_d2(int on)
+{
+	u8 t;
+
+	if (pci_pmu) {
+		pci_read_config_byte(pci_pmu, 0x7e, &t);
+		if (on)
+			t &= 0x7f;
+		else
+			t |= 0x80;
+		pci_write_config_byte(pci_pmu, 0x7e, t);
+	}
+}
+
+void ddb5074_led_d3(int on)
+{
+	u8 t;
+
+	if (pci_pmu) {
+		pci_read_config_byte(pci_pmu, 0x7e, &t);
+		if (on)
+			t &= 0xbf;
+		else
+			t |= 0x40;
+		pci_write_config_byte(pci_pmu, 0x7e, t);
+	}
+}
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/arch/mips/kernel/i8259.c linux/arch/mips/kernel/i8259.c
--- linux.orig/linux/arch/mips/kernel/i8259.c	Sat Dec 29 07:07:11 2001
+++ linux/arch/mips/kernel/i8259.c	Sun Mar 10 03:45:32 2002
@@ -176,12 +176,16 @@
 
 handle_real_irq:
 	if (irq & 8) {
+#if 0
 		inb(0xA1);		/* DUMMY - (do we need this?) */
+#endif
 		outb(cached_A1,0xA1);
 		outb(0x60+(irq&7),0xA0);/* 'Specific EOI' to slave */
 		outb(0x62,0x20);	/* 'Specific EOI' to master-IRQ2 */
 	} else {
+#if 0
 		inb(0x21);		/* DUMMY - (do we need this?) */
+#endif
 		outb(cached_21,0x21);
 		outb(0x60+irq,0x20);	/* 'Specific EOI' to master */
 	}
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/drivers/char/serial.c linux/drivers/char/serial.c
--- linux.orig/linux/drivers/char/serial.c	Wed Dec 19 01:03:10 2001
+++ linux/drivers/char/serial.c	Mon Feb 25 16:45:27 2002
@@ -4393,6 +4393,7 @@
 		8<<2, 2, pci_inteli960ni_fn, 0x10000},
 	{ SPCI_FL_BASE0 | SPCI_FL_IRQRESOURCE,		   /* pbn_sgi_ioc3 */
 		1, 458333, 0, 0, 0, 0x20178 },
+#if 0
 #ifdef CONFIG_DDB5074
 	/*
 	 * NEC Vrc-5074 (Nile 4) builtin UART.
@@ -4400,6 +4401,7 @@
 	 */
 	{ SPCI_FL_BASE0, 1, 520833,			   /* pbn_nec_nile4 */
 		64, 3, NULL, 0x300 },
+#endif
 #endif
 #if 0	/* PCI_DEVICE_ID_DCI_PCCOM8 ? */		   /* pbn_dci_pccom8 */
 	{ SPCI_FL_BASE3, 8, 115200, 8 },
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/drivers/net/tulip/interrupt.c linux/drivers/net/tulip/interrupt.c
--- linux.orig/linux/drivers/net/tulip/interrupt.c	Sun Dec  2 12:34:45 2001
+++ linux/drivers/net/tulip/interrupt.c	Sun Mar 10 04:01:58 2002
@@ -186,6 +186,9 @@
 				       tp->rx_buffers[entry].skb->tail,
 				       pkt_len);
 #endif
+#if defined(__mips__)
+				dma_cache_inv((unsigned long)bus_to_virt(tp->rx_ring[entry].buffer1),pkt_len);
+#endif
 			} else { 	/* Pass up the skb already on the Rx ring. */
 				char *temp = skb_put(skb = tp->rx_buffers[entry].skb,
 						     pkt_len);
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/drivers/net/tulip/tulip_core.c linux/drivers/net/tulip/tulip_core.c
--- linux.orig/linux/drivers/net/tulip/tulip_core.c	Wed Jan 16 11:32:15 2002
+++ linux/drivers/net/tulip/tulip_core.c	Sun Mar 10 04:03:46 2002
@@ -94,7 +94,7 @@
 #elif defined(__arm__) || defined(__sh__)
 static int csr0 = 0x01A00000 | 0x4800;
 #elif defined(__mips__)
-static int csr0 = 0x00200000 | 0x4000;
+static int csr0 = 0x4000; 
 #else
 #warning Processor architecture undefined!
 static int csr0 = 0x00A00000 | 0x4800;
@@ -317,6 +317,11 @@
 		tp->tx_buffers[tp->cur_tx].skb = NULL;
 		tp->tx_buffers[tp->cur_tx].mapping = mapping;
 
+#if defined(__mips__)
+              dma_cache_wback_inv((unsigned long)tp->setup_frame,
+                                            sizeof(tp->setup_frame));
+#endif
+
 		/* Put the setup frame on the Tx list. */
 		tp->tx_ring[tp->cur_tx].length = cpu_to_le32(0x08000000 | 192);
 		tp->tx_ring[tp->cur_tx].buffer1 = cpu_to_le32(mapping);
@@ -620,6 +625,10 @@
 					 PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 		tp->rx_buffers[i].mapping = mapping;
 		skb->dev = dev;			/* Mark as being used by this device. */
+#if defined(__mips__)
+		/* Kick out any matching lines in the cache. */
+		dma_cache_inv((unsigned long)skb->tail, PKT_BUF_SZ);
+#endif
 		tp->rx_ring[i].status = cpu_to_le32(DescOwned);	/* Owned by Tulip chip */
 		tp->rx_ring[i].buffer1 = cpu_to_le32(mapping);
 	}
@@ -672,6 +681,9 @@
 	/* if we were using Transmit Automatic Polling, we would need a
 	 * wmb() here. */
 	tp->tx_ring[entry].status = cpu_to_le32(DescOwned);
+#if defined(__mips__)
+	dma_cache_wback_inv((unsigned long)skb->data, skb->len);
+#endif
 	wmb();
 
 	tp->cur_tx++;
@@ -1517,6 +1529,15 @@
                        /* No media table either */
                        tp->flags &= ~HAS_MEDIA_TABLE;
                }
+#endif
+#ifdef CONFIG_DDB5074
+               if ((pdev->bus->number == 0) && (PCI_SLOT(pdev->devfn) == 1)) {
+                       /* DDB5477 MAC address in first EEPROM locations. */
+                       sa_offset = 0;
+                       /* No media table either */
+                       tp->flags &= ~HAS_MEDIA_TABLE;
+               }
+
 #endif
 #ifdef CONFIG_MIPS_COBALT
                if ((pdev->bus->number == 0) && 
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/include/asm-mips/ddb5xxx/ddb5074.h linux/include/asm-mips/ddb5xxx/ddb5074.h
--- linux.orig/linux/include/asm-mips/ddb5xxx/ddb5074.h	Thu Jan  1 01:00:00 1970
+++ linux/include/asm-mips/ddb5xxx/ddb5074.h	Thu Feb 21 22:42:04 2002
@@ -0,0 +1,38 @@
+/*
+ *  include/asm-mips/ddb5074.h -- NEC DDB Vrc-5074 definitions
+ *
+ *  Copyright (C) 2000 Geert Uytterhoeven <geert@sonycom.com>
+ *                     Sony Software Development Center Europe (SDCE), Brussels
+ */
+
+#ifndef _ASM_DDB5XXX_DDB5074_H
+#define _ASM_DDB5XXX_DDB5074_H
+
+#include <asm/nile4.h>
+
+#define DDB_SDRAM_SIZE      0x04000000      /* 64MB */
+
+#define DDB_PCI_IO_BASE     0x06000000
+#define DDB_PCI_IO_SIZE     0x02000000      /* 32 MB */
+
+#define DDB_PCI_MEM_BASE    0x08000000
+#define DDB_PCI_MEM_SIZE    0x08000000  /* 128 MB */
+
+#define DDB_PCI_CONFIG_BASE DDB_PCI_MEM_BASE
+#define DDB_PCI_CONFIG_SIZE DDB_PCI_MEM_SIZE
+
+#define NILE4_PCI_IO_BASE   0xa6000000
+#define NILE4_PCI_MEM_BASE  0xa8000000
+#define NILE4_PCI_CFG_BASE  NILE4_PCI_MEM_BASE
+#define DDB_PCI_IACK_BASE NILE4_PCI_IO_BASE
+
+#define NILE4_IRQ_BASE NUM_I8259_INTERRUPTS
+#define CPU_IRQ_BASE (NUM_NILE4_INTERRUPTS + NILE4_IRQ_BASE)
+#define CPU_NILE4_CASCADE 2
+
+extern void ddb5074_led_hex(int hex);
+extern void ddb5074_led_d2(int on);
+extern void ddb5074_led_d3(int on);
+
+extern void nile4_irq_setup(u32 base);
+#endif
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/include/asm-mips/ddb5xxx/ddb5xxx.h linux/include/asm-mips/ddb5xxx/ddb5xxx.h
--- linux.orig/linux/include/asm-mips/ddb5xxx/ddb5xxx.h	Thu Oct 11 00:41:52 2001
+++ linux/include/asm-mips/ddb5xxx/ddb5xxx.h	Fri Mar  1 00:57:24 2002
@@ -174,8 +174,10 @@
 
 static inline void ddb_sync(void)
 {
+#if 0
     volatile u32 *p = (volatile u32 *)0xbfc00000;
     (void)(*p);
+#endif
 }
 
 static inline void ddb_out32(u32 offset, u32 val)
diff -u -r -N -b -x *.o -x CVS -x .depend -x .config* -x .version -x .hdepend -x System.map -x .* linux.orig/linux/include/asm-mips/nile4.h linux/include/asm-mips/nile4.h
--- linux.orig/linux/include/asm-mips/nile4.h	Thu Sep  6 15:12:02 2001
+++ linux/include/asm-mips/nile4.h	Mon Jan 14 14:10:26 2002
@@ -9,6 +9,9 @@
  *	NEC Vrc 5074 System Controller Data Sheet, June 1998
  */
 
+#ifndef _ASM_NILE4_H
+#define _ASM_NILE4_H
+
 #define NILE4_BASE		0xbfa00000
 #define NILE4_SIZE		0x00200000		/* 2 MB */
 
@@ -303,3 +306,4 @@
 extern u8 nile4_i8259_iack(void);
 extern void nile4_dump_irq_status(void);	/* Debug */
 
+#endif

--82I3+IH0IqGh5yIs--
