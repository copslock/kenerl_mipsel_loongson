Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBHKTqH31974
	for linux-mips-outgoing; Mon, 17 Dec 2001 12:29:52 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBHKRxo31939
	for <linux-mips@oss.sgi.com>; Mon, 17 Dec 2001 12:27:59 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBHJRfQ02322;
	Mon, 17 Dec 2001 17:27:41 -0200
Date: Mon, 17 Dec 2001 17:27:41 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: New style irqs for DEC
Message-ID: <20011217172741.A2316@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Maciej,

below is my attempt at fixing interrupts for DECstation against the
latest 2.4.  Can you give it a try?

  Ralf

Index: arch/mips/config.in
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/config.in,v
retrieving revision 1.154.2.7
diff -u -r1.154.2.7 config.in
--- arch/mips/config.in 2001/12/14 23:49:15 1.154.2.7  
+++ arch/mips/config.in 2001/12/17 20:21:54   
@@ -83,6 +83,7 @@
 define_bool CONFIG_SBUS n
 
 if [ "$CONFIG_DECSTATION" = "y" ]; then
+   define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_NONCOHERENT_IO y
 fi
 
Index: arch/mips/defconfig-decstation
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/defconfig-decstation,v
retrieving revision 1.76.2.1
diff -u -r1.76.2.1 defconfig-decstation
--- arch/mips/defconfig-decstation 2001/12/14 23:47:16 1.76.2.1  
+++ arch/mips/defconfig-decstation 2001/12/17 20:21:54   
@@ -39,6 +39,7 @@
 # CONFIG_RWSEM_XCHGADD_ALGORITHM is not set
 # CONFIG_MCA is not set
 # CONFIG_SBUS is not set
+CONFIG_NEW_IRQ=y
 CONFIG_NONCOHERENT_IO=y
 # CONFIG_ISA is not set
 # CONFIG_EISA is not set
Index: arch/mips/dec/irq.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/dec/irq.c,v
retrieving revision 1.17
diff -u -r1.17 irq.c
--- arch/mips/dec/irq.c 2001/12/02 02:02:21 1.17  
+++ arch/mips/dec/irq.c 2001/12/17 20:21:54   
@@ -34,242 +34,89 @@
 
 extern asmlinkage void decstation_handle_int(void);
 
-volatile unsigned long irq_err_count;
+spinlock_t DEC_lock = SPIN_LOCK_UNLOCKED;
 
-static inline void mask_irq(unsigned int irq_nr)
+static inline void mask_dec_irq(unsigned int irq_nr)
 {
 	unsigned int dummy;
 
-	if (dec_interrupt[irq_nr].iemask) {	/* This is an ASIC interrupt    */
+	if (dec_interrupt[irq_nr].iemask) {
+		/* This is an ASIC interrupt  */
 		*imr &= ~dec_interrupt[irq_nr].iemask;
 		dummy = *imr;
 		dummy = *imr;
-	} else			/* This is a cpu interrupt        */
+	} else {
+		/* This is a cpu interrupt        */
 		change_cp0_status(ST0_IM,
 				  read_32bit_cp0_register(CP0_STATUS) &
 				  ~dec_interrupt[irq_nr].cpu_mask);
+	}
 }
 
-static inline void unmask_irq(unsigned int irq_nr)
+static inline void unmask_dec_irq(unsigned int irq_nr)
 {
 	unsigned int dummy;
 
-	if (dec_interrupt[irq_nr].iemask) {	/* This is an ASIC interrupt    */
+	if (dec_interrupt[irq_nr].iemask) {
+		/* This is an ASIC interrupt  */
 		*imr |= dec_interrupt[irq_nr].iemask;
 		dummy = *imr;
 		dummy = *imr;
 	}
-	change_cp0_status(ST0_IM,
-			  read_32bit_cp0_register(CP0_STATUS) |
+	change_cp0_status(ST0_IM, read_32bit_cp0_register(CP0_STATUS) |
 			  dec_interrupt[irq_nr].cpu_mask);
 }
-
-void disable_irq(unsigned int irq_nr)
-{
-	unsigned long flags;
-
-	save_and_cli(flags);
-	mask_irq(irq_nr);
-	restore_flags(flags);
-}
-
-void enable_irq(unsigned int irq_nr)
-{
-	unsigned long flags;
-
-	save_and_cli(flags);
-	unmask_irq(irq_nr);
-	restore_flags(flags);
-}
-
-/*
- * Pointers to the low-level handlers: first the general ones, then the
- * fast ones, then the bad ones.
- */
-extern void interrupt(void);
-
-static struct irqaction *irq_action[32] = {
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
-	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
-};
-
-int get_irq_list(char *buf)
-{
-	int i, len = 0;
-	struct irqaction *action;
 
-	for (i = 0; i < 32; i++) {
-		action = irq_action[i];
-		if (!action)
-			continue;
-		len += sprintf(buf + len, "%2d: %8d %c %s",
-			       i, kstat.irqs[0][i],
-			       (action->flags & SA_INTERRUPT) ? '+' : ' ',
-			       action->name);
-		for (action = action->next; action; action = action->next) {
-			len += sprintf(buf + len, ",%s %s",
-				       (action->
-					flags & SA_INTERRUPT) ? " +" : "",
-				       action->name);
-		}
-		len += sprintf(buf + len, "\n");
-	}
-	return len;
-}
+#define shutdown_dec_irq	disable_dec_irq
 
-/*
- * do_IRQ handles IRQ's that have been installed without the
- * SA_INTERRUPT flag: it uses the full signal-handling return
- * and runs with other interrupts enabled. All relatively slow
- * IRQ's should use this format: notably the keyboard/timer
- * routines.
- */
-asmlinkage void do_IRQ(int irq, struct pt_regs *regs)
+static unsigned int startup_dec_irq(unsigned int irq)
 {
-	struct irqaction *action;
-	int do_random, cpu;
-
-	cpu = smp_processor_id();
-	irq_enter(cpu, irq);
-	kstat.irqs[cpu][irq]++;
-
-	mask_irq(irq);
-	action = *(irq + irq_action);
-	if (action) {
-		if (!(action->flags & SA_INTERRUPT))
-			__sti();
-		action = *(irq + irq_action);
-		do_random = 0;
-		do {
-			do_random |= action->flags;
-			action->handler(irq, action->dev_id, regs);
-			action = action->next;
-		} while (action);
-		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
-		__cli();
-		unmask_irq(irq);
-	}
-	irq_exit(cpu, irq);
+	unmask_dec_irq(irq);
 
-	if (softirq_pending(cpu))
-		do_softirq();
+	return 0;	/* never anything pending */
 }
 
-/*
- * Idea is to put all interrupts
- * in a single table and differenciate them just by number.
- */
-int setup_dec_irq(int irq, struct irqaction *new)
+static void disable_dec_irq(unsigned int irq_nr)
 {
-	int shared = 0;
-	struct irqaction *old, **p;
 	unsigned long flags;
 
-	p = irq_action + irq;
-	if ((old = *p) != NULL) {
-		/* Can't share interrupts unless both agree to */
-		if (!(old->flags & new->flags & SA_SHIRQ))
-			return -EBUSY;
-
-		/* Can't share interrupts unless both are same type */
-		if ((old->flags ^ new->flags) & SA_INTERRUPT)
-			return -EBUSY;
-
-		/* add new interrupt at end of irq queue */
-		do {
-			p = &old->next;
-			old = *p;
-		} while (old);
-		shared = 1;
-	}
-	if (new->flags & SA_SAMPLE_RANDOM)
-		rand_initialize_irq(irq);
-
-	save_and_cli(flags);
-	*p = new;
-
-	if (!shared) {
-		unmask_irq(irq);
-	}
-	restore_flags(flags);
-	return 0;
-}
-
-int request_irq(unsigned int irq,
-		void (*handler) (int, void *, struct pt_regs *),
-		unsigned long irqflags, const char *devname, void *dev_id)
-{
-	int retval;
-	struct irqaction *action;
-
-	if (irq >= 32)
-		return -EINVAL;
-	if (!handler)
-		return -EINVAL;
-
-	action =
-	    (struct irqaction *) kmalloc(sizeof(struct irqaction),
-					 GFP_KERNEL);
-	if (!action)
-		return -ENOMEM;
-
-	action->handler = handler;
-	action->flags = irqflags;
-	action->mask = 0;
-	action->name = devname;
-	action->next = NULL;
-	action->dev_id = dev_id;
-
-	retval = setup_dec_irq(irq, action);
-
-	if (retval)
-		kfree(action);
-	return retval;
+	spin_lock_irqsave(&DEC_lock, flags);
+	mask_dec_irq(irq_nr);
+	spin_unlock_irqrestore(&DEC_lock, flags);
 }
 
-void free_irq(unsigned int irq, void *dev_id)
+static inline void enable_dec_irq(unsigned int irq_nr)
 {
-	struct irqaction *action, **p;
 	unsigned long flags;
 
-	if (irq > 39) {
-		printk("Trying to free IRQ%d\n", irq);
-		return;
-	}
-	for (p = irq + irq_action; (action = *p) != NULL;
-	     p = &action->next) {
-		if (action->dev_id != dev_id)
-			continue;
-
-		/* Found it - now free it */
-		save_and_cli(flags);
-		*p = action->next;
-		if (!irq[irq_action])
-			mask_irq(irq);
-		restore_flags(flags);
-		kfree(action);
-		return;
-	}
-	printk("Trying to free free IRQ%d\n", irq);
+	spin_lock_irqsave(&DEC_lock, flags);
+	unmask_dec_irq(irq_nr);
+	spin_unlock_irqrestore(&DEC_lock, flags);
 }
 
-unsigned long probe_irq_on(void)
-{
-	/* TODO */
-	return 0;
-}
+#define mask_and_ack_dec_irq disable_dec_irq
 
-int probe_irq_off(unsigned long irqs)
+static void end_dec_irq (unsigned int irq)
 {
-	/* TODO */
-	return 0;
+	if (!(irq_desc[irq].status & (IRQ_DISABLED|IRQ_INPROGRESS)))
+		enable_dec_irq(irq);
 }
 
+static struct hw_interrupt_type dec_irq_type = {
+	"DEC",
+	startup_dec_irq,
+	shutdown_dec_irq,
+	enable_dec_irq,
+	disable_dec_irq,
+	mask_and_ack_dec_irq,
+	end_dec_irq,
+	NULL
+};
+
 void __init init_IRQ(void)
 {
+	int i;
+
 	switch (mips_machtype) {
 	case MACH_DS23100:
 		dec_init_kn01();
@@ -300,4 +147,13 @@
 		break;
 	}
 	set_except_vector(0, decstation_handle_int);
+
+	init_generic_irq();
+
+	for (i = 0; i < 32; i++) {
+		irq_desc[i].status  = IRQ_DISABLED;
+		irq_desc[i].action  = NULL;
+		irq_desc[i].depth   = 1;
+		irq_desc[i].handler = &dec_irq_type;
+	}
 }
Index: arch/mips/dec/setup.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/dec/setup.c,v
retrieving revision 1.11
diff -u -r1.11 setup.c
--- arch/mips/dec/setup.c 2001/11/24 16:47:23 1.11  
+++ arch/mips/dec/setup.c 2001/12/17 20:21:54   
@@ -28,7 +28,6 @@
 #include <asm/dec/ioasic_addrs.h>
 #include <asm/dec/ioasic_ints.h>
 
-
 char *dec_rtc_base = (void *) KN01_RTC_BASE;	/* Assume DS2100/3100 initially */
 
 volatile unsigned int *ioasic_base;
@@ -51,28 +50,26 @@
 
 extern struct rtc_ops dec_rtc_ops;
 
-extern int setup_dec_irq(int, struct irqaction *);
-
 void (*board_time_init) (struct irqaction * irq);
 
-static struct irqaction haltirq = {dec_intr_halt, 0, 0, "halt", NULL, NULL};
+static struct irqaction haltirq = { dec_intr_halt, 0, 0, "halt", NULL, NULL };
 
 /*
  * enable the periodic interrupts
  */
 static void __init dec_time_init(struct irqaction *irq)
 {
-    /*
-     * Here we go, enable periodic rtc interrupts.
-     */
+	/*
+	 * Here we go, enable periodic rtc interrupts.
+	 */
 
 #ifndef LOG_2_HZ
 #  define LOG_2_HZ 7
 #endif
 
-    CMOS_WRITE(RTC_REF_CLCK_32KHZ | (16 - LOG_2_HZ), RTC_REG_A);
-    CMOS_WRITE(CMOS_READ(RTC_REG_B) | RTC_PIE, RTC_REG_B);
-    setup_dec_irq(CLOCK, irq);
+	CMOS_WRITE(RTC_REF_CLCK_32KHZ | (16 - LOG_2_HZ), RTC_REG_A);
+	CMOS_WRITE(CMOS_READ(RTC_REG_B) | RTC_PIE, RTC_REG_B);
+	setup_irq(CLOCK, irq);
 }
 
 /*
@@ -80,24 +77,24 @@
  */
 static void __init dec_halt_init(struct irqaction *irq)
 {
-    setup_dec_irq(HALT, irq);
+	setup_irq(HALT, irq);
 }
 
 void __init decstation_setup(void)
 {
-    board_time_init = dec_time_init;
+	board_time_init = dec_time_init;
 
-    wbflush_setup();
+	wbflush_setup();
 
-    _machine_restart = dec_machine_restart;
-    _machine_halt = dec_machine_halt;
-    _machine_power_off = dec_machine_power_off;
+	_machine_restart = dec_machine_restart;
+	_machine_halt = dec_machine_halt;
+	_machine_power_off = dec_machine_power_off;
 
 #ifdef CONFIG_FB
-    conswitchp = &dummy_con;
+	conswitchp = &dummy_con;
 #endif
 
-    rtc_ops = &dec_rtc_ops;
+	rtc_ops = &dec_rtc_ops;
 }
 
 /*
@@ -106,43 +103,43 @@
  */
 void __init dec_init_kn01(void)
 {
-    /*
-     * Setup some memory addresses.
-     */
-    dec_rtc_base = (char *) KN01_RTC_BASE;
-
-    /*
-     * Setup interrupt structure
-     */
-    dec_interrupt[CLOCK].cpu_mask = IE_IRQ3;
-    dec_interrupt[CLOCK].iemask = 0;
-    cpu_mask_tbl[0] = IE_IRQ3;
-    cpu_irq_nr[0] = CLOCK;
-
-    dec_interrupt[SCSI_INT].cpu_mask = IE_IRQ0;
-    dec_interrupt[SCSI_INT].iemask = 0;
-    cpu_mask_tbl[1] = IE_IRQ0;
-    cpu_irq_nr[1] = SCSI_INT;
-
-    dec_interrupt[ETHER].cpu_mask = IE_IRQ1;
-    dec_interrupt[ETHER].iemask = 0;
-    cpu_mask_tbl[2] = IE_IRQ1;
-    cpu_irq_nr[2] = ETHER;
-
-    dec_interrupt[SERIAL].cpu_mask = IE_IRQ2;
-    dec_interrupt[SERIAL].iemask = 0;
-    cpu_mask_tbl[3] = IE_IRQ2;
-    cpu_irq_nr[3] = SERIAL;
-
-    dec_interrupt[MEMORY].cpu_mask = IE_IRQ4;
-    dec_interrupt[MEMORY].iemask = 0;
-    cpu_mask_tbl[4] = IE_IRQ4;
-    cpu_irq_nr[4] = MEMORY;
-
-    /*
-     * Enable board interrupts: FPU.
-     */
-    set_cp0_status(DEC_IE_FPU);
+	/*
+	 * Setup some memory addresses.
+	 */
+	dec_rtc_base = (char *) KN01_RTC_BASE;
+
+	/*
+	 * Setup interrupt structure
+	 */
+	dec_interrupt[CLOCK].cpu_mask = IE_IRQ3;
+	dec_interrupt[CLOCK].iemask = 0;
+	cpu_mask_tbl[0] = IE_IRQ3;
+	cpu_irq_nr[0] = CLOCK;
+
+	dec_interrupt[SCSI_INT].cpu_mask = IE_IRQ0;
+	dec_interrupt[SCSI_INT].iemask = 0;
+	cpu_mask_tbl[1] = IE_IRQ0;
+	cpu_irq_nr[1] = SCSI_INT;
+
+	dec_interrupt[ETHER].cpu_mask = IE_IRQ1;
+	dec_interrupt[ETHER].iemask = 0;
+	cpu_mask_tbl[2] = IE_IRQ1;
+	cpu_irq_nr[2] = ETHER;
+
+	dec_interrupt[SERIAL].cpu_mask = IE_IRQ2;
+	dec_interrupt[SERIAL].iemask = 0;
+	cpu_mask_tbl[3] = IE_IRQ2;
+	cpu_irq_nr[3] = SERIAL;
+
+	dec_interrupt[MEMORY].cpu_mask = IE_IRQ4;
+	dec_interrupt[MEMORY].iemask = 0;
+	cpu_mask_tbl[4] = IE_IRQ4;
+	cpu_irq_nr[4] = MEMORY;
+
+	/*
+	 * Enable board interrupts: FPU.
+	 */
+	set_cp0_status(DEC_IE_FPU);
 }				/* dec_init_kn01 */
 
 /*
@@ -152,23 +149,23 @@
  */
 void __init dec_init_kn230(void)
 {
-    /*
-     * Setup some memory addresses.
-     */
-    dec_rtc_base = (char *) KN01_RTC_BASE;
-
-    /*
-     * Setup interrupt structure
-     */
-    dec_interrupt[CLOCK].cpu_mask = IE_IRQ2;
-    dec_interrupt[CLOCK].iemask = 0;
-    cpu_mask_tbl[0] = IE_IRQ2;
-    cpu_irq_nr[0] = CLOCK;
-
-    /*
-     * Enable board interrupts: FPU.
-     */
-    set_cp0_status(DEC_IE_FPU);
+	/*
+	 * Setup some memory addresses.
+	 */
+	dec_rtc_base = (char *) KN01_RTC_BASE;
+
+	/*
+	 * Setup interrupt structure
+	 */
+	dec_interrupt[CLOCK].cpu_mask = IE_IRQ2;
+	dec_interrupt[CLOCK].iemask = 0;
+	cpu_mask_tbl[0] = IE_IRQ2;
+	cpu_irq_nr[0] = CLOCK;
+
+	/*
+	 * Enable board interrupts: FPU.
+	 */
+	set_cp0_status(DEC_IE_FPU);
 }				/* dec_init_kn230 */
 
 /*
@@ -176,71 +173,71 @@
  */
 void __init dec_init_kn02(void)
 {
-    int dec_ie_io;
+	int dec_ie_io;
 
-    /*
-     * Setup some memory addresses. FIXME: probably incomplete!
-     */
-    dec_rtc_base = (char *) KN02_RTC_BASE;
-    isr = (void *) KN02_CSR_ADDR;
-    imr = (void *) KN02_CSR_ADDR;
-
-    /*
-     * Setup I/O interrupt
-     */
-    dec_ie_io = IE_IRQ0;
-    cpu_ivec_tbl[1] = kn02_io_int;
-    cpu_mask_tbl[1] = dec_ie_io;
-    cpu_irq_nr[1] = -1;
-    *imr = *imr & 0xff00ff00;
-
-    /*
-     * Setup interrupt structure
-     */
-    dec_interrupt[CLOCK].cpu_mask = IE_IRQ1;
-    dec_interrupt[CLOCK].iemask = 0;
-    cpu_mask_tbl[0] = IE_IRQ1;
-    cpu_irq_nr[0] = CLOCK;
-
-    dec_interrupt[SCSI_INT].cpu_mask = IE_IRQ0;
-    dec_interrupt[SCSI_INT].iemask = KN02_SLOT5;
-    asic_mask_tbl[0] = KN02_SLOT5;
-    asic_irq_nr[0] = SCSI_INT;
-
-    dec_interrupt[ETHER].cpu_mask = IE_IRQ0;
-    dec_interrupt[ETHER].iemask = KN02_SLOT6;
-    asic_mask_tbl[1] = KN02_SLOT6;
-    asic_irq_nr[1] = ETHER;
-
-    dec_interrupt[SERIAL].cpu_mask = IE_IRQ0;
-    dec_interrupt[SERIAL].iemask = KN02_SLOT7;
-    asic_mask_tbl[2] = KN02_SLOT7;
-    asic_irq_nr[2] = SERIAL;
-
-    dec_interrupt[TC0].cpu_mask = IE_IRQ0;
-    dec_interrupt[TC0].iemask = KN02_SLOT0;
-    asic_mask_tbl[3] = KN02_SLOT0;
-    asic_irq_nr[3] = TC0;
-
-    dec_interrupt[TC1].cpu_mask = IE_IRQ0;
-    dec_interrupt[TC1].iemask = KN02_SLOT1;
-    asic_mask_tbl[4] = KN02_SLOT1;
-    asic_irq_nr[4] = TC1;
-
-    dec_interrupt[TC2].cpu_mask = IE_IRQ0;
-    dec_interrupt[TC2].iemask = KN02_SLOT2;
-    asic_mask_tbl[5] = KN02_SLOT2;
-    asic_irq_nr[5] = TC2;
-
-    dec_interrupt[MEMORY].cpu_mask = IE_IRQ3;
-    dec_interrupt[MEMORY].iemask = 0;
-    cpu_mask_tbl[2] = IE_IRQ3;
-    cpu_irq_nr[2] = MEMORY;
-
-    /*
-     * Enable board interrupts: FPU, I/O.
-     */
-    set_cp0_status(DEC_IE_FPU | dec_ie_io);
+	/*
+	 * Setup some memory addresses. FIXME: probably incomplete!
+	 */
+	dec_rtc_base = (char *) KN02_RTC_BASE;
+	isr = (void *) KN02_CSR_ADDR;
+	imr = (void *) KN02_CSR_ADDR;
+
+	/*
+	 * Setup I/O interrupt
+	 */
+	dec_ie_io = IE_IRQ0;
+	cpu_ivec_tbl[1] = kn02_io_int;
+	cpu_mask_tbl[1] = dec_ie_io;
+	cpu_irq_nr[1] = -1;
+	*imr = *imr & 0xff00ff00;
+
+	/*
+	 * Setup interrupt structure
+	 */
+	dec_interrupt[CLOCK].cpu_mask = IE_IRQ1;
+	dec_interrupt[CLOCK].iemask = 0;
+	cpu_mask_tbl[0] = IE_IRQ1;
+	cpu_irq_nr[0] = CLOCK;
+
+	dec_interrupt[SCSI_INT].cpu_mask = IE_IRQ0;
+	dec_interrupt[SCSI_INT].iemask = KN02_SLOT5;
+	asic_mask_tbl[0] = KN02_SLOT5;
+	asic_irq_nr[0] = SCSI_INT;
+
+	dec_interrupt[ETHER].cpu_mask = IE_IRQ0;
+	dec_interrupt[ETHER].iemask = KN02_SLOT6;
+	asic_mask_tbl[1] = KN02_SLOT6;
+	asic_irq_nr[1] = ETHER;
+
+	dec_interrupt[SERIAL].cpu_mask = IE_IRQ0;
+	dec_interrupt[SERIAL].iemask = KN02_SLOT7;
+	asic_mask_tbl[2] = KN02_SLOT7;
+	asic_irq_nr[2] = SERIAL;
+
+	dec_interrupt[TC0].cpu_mask = IE_IRQ0;
+	dec_interrupt[TC0].iemask = KN02_SLOT0;
+	asic_mask_tbl[3] = KN02_SLOT0;
+	asic_irq_nr[3] = TC0;
+
+	dec_interrupt[TC1].cpu_mask = IE_IRQ0;
+	dec_interrupt[TC1].iemask = KN02_SLOT1;
+	asic_mask_tbl[4] = KN02_SLOT1;
+	asic_irq_nr[4] = TC1;
+
+	dec_interrupt[TC2].cpu_mask = IE_IRQ0;
+	dec_interrupt[TC2].iemask = KN02_SLOT2;
+	asic_mask_tbl[5] = KN02_SLOT2;
+	asic_irq_nr[5] = TC2;
+
+	dec_interrupt[MEMORY].cpu_mask = IE_IRQ3;
+	dec_interrupt[MEMORY].iemask = 0;
+	cpu_mask_tbl[2] = IE_IRQ3;
+	cpu_irq_nr[2] = MEMORY;
+
+	/*
+	 * Enable board interrupts: FPU, I/O.
+	 */
+	set_cp0_status(DEC_IE_FPU | dec_ie_io);
 }				/* dec_init_kn02 */
 
 /*
@@ -248,84 +245,84 @@
  */
 void __init dec_init_kn02ba(void)
 {
-    int dec_ie_ioasic;
+	int dec_ie_ioasic;
 
-    /*
-     * Setup some memory addresses.
-     */
-    ioasic_base = (void *) KN02XA_IOASIC_BASE;
-    dec_rtc_base = (char *) KN02XA_RTC_BASE;
-    isr = (void *) KN02XA_IOASIC_REG(SIR);
-    imr = (void *) KN02XA_IOASIC_REG(SIMR);
-
-    /*
-     * Setup IOASIC interrupt
-     */
-    dec_ie_ioasic = IE_IRQ3;
-    cpu_ivec_tbl[0] = kn02xa_io_int;
-    cpu_mask_tbl[0] = dec_ie_ioasic;
-    cpu_irq_nr[0] = -1;
-    *imr = 0;
-
-    /*
-     * Setup interrupt structure
-     */
-    dec_interrupt[CLOCK].cpu_mask = IE_IRQ3;
-    dec_interrupt[CLOCK].iemask = KMIN_CLOCK;
-    asic_mask_tbl[0] = KMIN_CLOCK;
-    asic_irq_nr[0] = CLOCK;
-
-    dec_interrupt[SCSI_DMA_INT].cpu_mask = IE_IRQ3;
-    dec_interrupt[SCSI_DMA_INT].iemask = SCSI_DMA_INTS;
-    asic_mask_tbl[1] = SCSI_DMA_INTS;
-    asic_irq_nr[1] = SCSI_DMA_INT;
-
-    dec_interrupt[SCSI_INT].cpu_mask = IE_IRQ3;
-    dec_interrupt[SCSI_INT].iemask = SCSI_CHIP;
-    asic_mask_tbl[2] = SCSI_CHIP;
-    asic_irq_nr[2] = SCSI_INT;
-
-    dec_interrupt[ETHER].cpu_mask = IE_IRQ3;
-    dec_interrupt[ETHER].iemask = LANCE_INTS;
-    asic_mask_tbl[3] = LANCE_INTS;
-    asic_irq_nr[3] = ETHER;
-
-    dec_interrupt[SERIAL].cpu_mask = IE_IRQ3;
-    dec_interrupt[SERIAL].iemask = SERIAL_INTS;
-    asic_mask_tbl[4] = SERIAL_INTS;
-    asic_irq_nr[4] = SERIAL;
-
-    dec_interrupt[MEMORY].cpu_mask = IE_IRQ3;
-    dec_interrupt[MEMORY].iemask = KMIN_TIMEOUT;
-    asic_mask_tbl[5] = KMIN_TIMEOUT;
-    asic_irq_nr[5] = MEMORY;
-
-    dec_interrupt[TC0].cpu_mask = IE_IRQ0;
-    dec_interrupt[TC0].iemask = 0;
-    cpu_mask_tbl[1] = IE_IRQ0;
-    cpu_irq_nr[1] = TC0;
-
-    dec_interrupt[TC1].cpu_mask = IE_IRQ1;
-    dec_interrupt[TC1].iemask = 0;
-    cpu_mask_tbl[2] = IE_IRQ1;
-    cpu_irq_nr[2] = TC1;
-
-    dec_interrupt[TC2].cpu_mask = IE_IRQ2;
-    dec_interrupt[TC2].iemask = 0;
-    cpu_mask_tbl[3] = IE_IRQ2;
-    cpu_irq_nr[3] = TC2;
-
-    dec_interrupt[HALT].cpu_mask = IE_IRQ4;
-    dec_interrupt[HALT].iemask = 0;
-    cpu_mask_tbl[4] = IE_IRQ4;
-    cpu_irq_nr[4] = HALT;
-
-    /*
-     * Enable board interrupts: FPU, I/O ASIC.
-     */
-    set_cp0_status(DEC_IE_FPU | dec_ie_ioasic);
+	/*
+	 * Setup some memory addresses.
+	 */
+	ioasic_base = (void *) KN02XA_IOASIC_BASE;
+	dec_rtc_base = (char *) KN02XA_RTC_BASE;
+	isr = (void *) KN02XA_IOASIC_REG(SIR);
+	imr = (void *) KN02XA_IOASIC_REG(SIMR);
+
+	/*
+	 * Setup IOASIC interrupt
+	 */
+	dec_ie_ioasic = IE_IRQ3;
+	cpu_ivec_tbl[0] = kn02xa_io_int;
+	cpu_mask_tbl[0] = dec_ie_ioasic;
+	cpu_irq_nr[0] = -1;
+	*imr = 0;
+
+	/*
+	 * Setup interrupt structure
+	 */
+	dec_interrupt[CLOCK].cpu_mask = IE_IRQ3;
+	dec_interrupt[CLOCK].iemask = KMIN_CLOCK;
+	asic_mask_tbl[0] = KMIN_CLOCK;
+	asic_irq_nr[0] = CLOCK;
+
+	dec_interrupt[SCSI_DMA_INT].cpu_mask = IE_IRQ3;
+	dec_interrupt[SCSI_DMA_INT].iemask = SCSI_DMA_INTS;
+	asic_mask_tbl[1] = SCSI_DMA_INTS;
+	asic_irq_nr[1] = SCSI_DMA_INT;
+
+	dec_interrupt[SCSI_INT].cpu_mask = IE_IRQ3;
+	dec_interrupt[SCSI_INT].iemask = SCSI_CHIP;
+	asic_mask_tbl[2] = SCSI_CHIP;
+	asic_irq_nr[2] = SCSI_INT;
+
+	dec_interrupt[ETHER].cpu_mask = IE_IRQ3;
+	dec_interrupt[ETHER].iemask = LANCE_INTS;
+	asic_mask_tbl[3] = LANCE_INTS;
+	asic_irq_nr[3] = ETHER;
+
+	dec_interrupt[SERIAL].cpu_mask = IE_IRQ3;
+	dec_interrupt[SERIAL].iemask = SERIAL_INTS;
+	asic_mask_tbl[4] = SERIAL_INTS;
+	asic_irq_nr[4] = SERIAL;
+
+	dec_interrupt[MEMORY].cpu_mask = IE_IRQ3;
+	dec_interrupt[MEMORY].iemask = KMIN_TIMEOUT;
+	asic_mask_tbl[5] = KMIN_TIMEOUT;
+	asic_irq_nr[5] = MEMORY;
+
+	dec_interrupt[TC0].cpu_mask = IE_IRQ0;
+	dec_interrupt[TC0].iemask = 0;
+	cpu_mask_tbl[1] = IE_IRQ0;
+	cpu_irq_nr[1] = TC0;
+
+	dec_interrupt[TC1].cpu_mask = IE_IRQ1;
+	dec_interrupt[TC1].iemask = 0;
+	cpu_mask_tbl[2] = IE_IRQ1;
+	cpu_irq_nr[2] = TC1;
+
+	dec_interrupt[TC2].cpu_mask = IE_IRQ2;
+	dec_interrupt[TC2].iemask = 0;
+	cpu_mask_tbl[3] = IE_IRQ2;
+	cpu_irq_nr[3] = TC2;
+
+	dec_interrupt[HALT].cpu_mask = IE_IRQ4;
+	dec_interrupt[HALT].iemask = 0;
+	cpu_mask_tbl[4] = IE_IRQ4;
+	cpu_irq_nr[4] = HALT;
+
+	/*
+	 * Enable board interrupts: FPU, I/O ASIC.
+	 */
+	set_cp0_status(DEC_IE_FPU | dec_ie_ioasic);
 
-    dec_halt_init(&haltirq);
+	dec_halt_init(&haltirq);
 }				/* dec_init_kn02ba */
 
 /*
@@ -333,79 +330,79 @@
  */
 void __init dec_init_kn02ca(void)
 {
-    int dec_ie_ioasic;
+	int dec_ie_ioasic;
 
-    /*
-     * Setup some memory addresses. FIXME: probably incomplete!
-     */
-    ioasic_base = (void *) KN02XA_IOASIC_BASE;
-    dec_rtc_base = (char *) KN02XA_RTC_BASE;
-    isr = (void *) KN02XA_IOASIC_REG(SIR);
-    imr = (void *) KN02XA_IOASIC_REG(SIMR);
-
-    /*
-     * Setup IOASIC interrupt
-     */
-    dec_ie_ioasic = IE_IRQ3;
-    cpu_ivec_tbl[1] = kn02xa_io_int;
-    cpu_mask_tbl[1] = dec_ie_ioasic;
-    cpu_irq_nr[1] = -1;
-    *imr = 0;
-
-    /*
-     * Setup interrupt structure
-     */
-    dec_interrupt[CLOCK].cpu_mask = IE_IRQ1;
-    dec_interrupt[CLOCK].iemask = 0;
-    cpu_mask_tbl[0] = IE_IRQ1;
-    cpu_irq_nr[0] = CLOCK;
-
-    dec_interrupt[SCSI_DMA_INT].cpu_mask = IE_IRQ3;
-    dec_interrupt[SCSI_DMA_INT].iemask = SCSI_DMA_INTS;
-    asic_mask_tbl[0] = SCSI_DMA_INTS;
-    asic_irq_nr[0] = SCSI_DMA_INT;
-
-    dec_interrupt[SCSI_INT].cpu_mask = IE_IRQ3;
-    dec_interrupt[SCSI_INT].iemask = SCSI_CHIP;
-    asic_mask_tbl[1] = SCSI_CHIP;
-    asic_irq_nr[1] = SCSI_INT;
-
-    dec_interrupt[ETHER].cpu_mask = IE_IRQ3;
-    dec_interrupt[ETHER].iemask = LANCE_INTS;
-    asic_mask_tbl[2] = LANCE_INTS;
-    asic_irq_nr[2] = ETHER;
-
-    dec_interrupt[SERIAL].cpu_mask = IE_IRQ3;
-    dec_interrupt[SERIAL].iemask = XINE_SERIAL_INTS;
-    asic_mask_tbl[3] = XINE_SERIAL_INTS;
-    asic_irq_nr[3] = SERIAL;
-
-    dec_interrupt[TC0].cpu_mask = IE_IRQ3;
-    dec_interrupt[TC0].iemask = MAXINE_TC0;
-    asic_mask_tbl[4] = MAXINE_TC0;
-    asic_irq_nr[4] = TC0;
-
-    dec_interrupt[TC1].cpu_mask = IE_IRQ3;
-    dec_interrupt[TC1].iemask = MAXINE_TC1;
-    asic_mask_tbl[5] = MAXINE_TC1;
-    asic_irq_nr[5] = TC1;
-
-    dec_interrupt[MEMORY].cpu_mask = IE_IRQ2;
-    dec_interrupt[MEMORY].iemask = 0;
-    cpu_mask_tbl[2] = IE_IRQ2;
-    cpu_irq_nr[2] = MEMORY;
-
-    dec_interrupt[HALT].cpu_mask = IE_IRQ4;
-    dec_interrupt[HALT].iemask = 0;
-    cpu_mask_tbl[3] = IE_IRQ4;
-    cpu_irq_nr[3] = HALT;
-
-    /*
-     * Enable board interrupts: FPU, I/O ASIC.
-     */
-    set_cp0_status(DEC_IE_FPU | dec_ie_ioasic);
+	/*
+	 * Setup some memory addresses. FIXME: probably incomplete!
+	 */
+	ioasic_base = (void *) KN02XA_IOASIC_BASE;
+	dec_rtc_base = (char *) KN02XA_RTC_BASE;
+	isr = (void *) KN02XA_IOASIC_REG(SIR);
+	imr = (void *) KN02XA_IOASIC_REG(SIMR);
+
+	/*
+	 * Setup IOASIC interrupt
+	 */
+	dec_ie_ioasic = IE_IRQ3;
+	cpu_ivec_tbl[1] = kn02xa_io_int;
+	cpu_mask_tbl[1] = dec_ie_ioasic;
+	cpu_irq_nr[1] = -1;
+	*imr = 0;
+
+	/*
+	 * Setup interrupt structure
+	 */
+	dec_interrupt[CLOCK].cpu_mask = IE_IRQ1;
+	dec_interrupt[CLOCK].iemask = 0;
+	cpu_mask_tbl[0] = IE_IRQ1;
+	cpu_irq_nr[0] = CLOCK;
+
+	dec_interrupt[SCSI_DMA_INT].cpu_mask = IE_IRQ3;
+	dec_interrupt[SCSI_DMA_INT].iemask = SCSI_DMA_INTS;
+	asic_mask_tbl[0] = SCSI_DMA_INTS;
+	asic_irq_nr[0] = SCSI_DMA_INT;
+
+	dec_interrupt[SCSI_INT].cpu_mask = IE_IRQ3;
+	dec_interrupt[SCSI_INT].iemask = SCSI_CHIP;
+	asic_mask_tbl[1] = SCSI_CHIP;
+	asic_irq_nr[1] = SCSI_INT;
+
+	dec_interrupt[ETHER].cpu_mask = IE_IRQ3;
+	dec_interrupt[ETHER].iemask = LANCE_INTS;
+	asic_mask_tbl[2] = LANCE_INTS;
+	asic_irq_nr[2] = ETHER;
+
+	dec_interrupt[SERIAL].cpu_mask = IE_IRQ3;
+	dec_interrupt[SERIAL].iemask = XINE_SERIAL_INTS;
+	asic_mask_tbl[3] = XINE_SERIAL_INTS;
+	asic_irq_nr[3] = SERIAL;
+
+	dec_interrupt[TC0].cpu_mask = IE_IRQ3;
+	dec_interrupt[TC0].iemask = MAXINE_TC0;
+	asic_mask_tbl[4] = MAXINE_TC0;
+	asic_irq_nr[4] = TC0;
+
+	dec_interrupt[TC1].cpu_mask = IE_IRQ3;
+	dec_interrupt[TC1].iemask = MAXINE_TC1;
+	asic_mask_tbl[5] = MAXINE_TC1;
+	asic_irq_nr[5] = TC1;
+
+	dec_interrupt[MEMORY].cpu_mask = IE_IRQ2;
+	dec_interrupt[MEMORY].iemask = 0;
+	cpu_mask_tbl[2] = IE_IRQ2;
+	cpu_irq_nr[2] = MEMORY;
+
+	dec_interrupt[HALT].cpu_mask = IE_IRQ4;
+	dec_interrupt[HALT].iemask = 0;
+	cpu_mask_tbl[3] = IE_IRQ4;
+	cpu_irq_nr[3] = HALT;
+
+	/*
+	 * Enable board interrupts: FPU, I/O ASIC.
+	 */
+	set_cp0_status(DEC_IE_FPU | dec_ie_ioasic);
 
-    dec_halt_init(&haltirq);
+	dec_halt_init(&haltirq);
 }				/* dec_init_kn02ca */
 
 /*
@@ -413,82 +410,82 @@
  */
 void __init dec_init_kn03(void)
 {
-    int dec_ie_ioasic;
+	int dec_ie_ioasic;
 
-    /*
-     * Setup some memory addresses. FIXME: probably incomplete!
-     */
-    ioasic_base = (void *) KN03_IOASIC_BASE;
-    dec_rtc_base = (char *) KN03_RTC_BASE;
-    isr = (void *) KN03_IOASIC_REG(SIR);
-    imr = (void *) KN03_IOASIC_REG(SIMR);
-
-    /*
-     * Setup IOASIC interrupt
-     */
-    dec_ie_ioasic = IE_IRQ0;
-    cpu_ivec_tbl[1] = kn03_io_int;
-    cpu_mask_tbl[1] = dec_ie_ioasic;
-    cpu_irq_nr[1] = -1;
-    *imr = 0;
-
-    /*
-     * Setup interrupt structure
-     */
-    dec_interrupt[CLOCK].cpu_mask = IE_IRQ1;
-    dec_interrupt[CLOCK].iemask = 0;
-    cpu_mask_tbl[0] = IE_IRQ1;
-    cpu_irq_nr[0] = CLOCK;
-
-    dec_interrupt[SCSI_DMA_INT].cpu_mask = IE_IRQ0;
-    dec_interrupt[SCSI_DMA_INT].iemask = SCSI_DMA_INTS;
-    asic_mask_tbl[0] = SCSI_DMA_INTS;
-    asic_irq_nr[0] = SCSI_DMA_INT;
-
-    dec_interrupt[SCSI_INT].cpu_mask = IE_IRQ0;
-    dec_interrupt[SCSI_INT].iemask = SCSI_CHIP;
-    asic_mask_tbl[1] = SCSI_CHIP;
-    asic_irq_nr[1] = SCSI_INT;
-
-    dec_interrupt[ETHER].cpu_mask = IE_IRQ0;
-    dec_interrupt[ETHER].iemask = LANCE_INTS;
-    asic_mask_tbl[2] = LANCE_INTS;
-    asic_irq_nr[2] = ETHER;
-
-    dec_interrupt[SERIAL].cpu_mask = IE_IRQ0;
-    dec_interrupt[SERIAL].iemask = SERIAL_INTS;
-    asic_mask_tbl[3] = SERIAL_INTS;
-    asic_irq_nr[3] = SERIAL;
-
-    dec_interrupt[TC0].cpu_mask = IE_IRQ0;
-    dec_interrupt[TC0].iemask = KN03_TC0;
-    asic_mask_tbl[4] = KN03_TC0;
-    asic_irq_nr[4] = TC0;
-
-    dec_interrupt[TC1].cpu_mask = IE_IRQ0;
-    dec_interrupt[TC1].iemask = KN03_TC1;
-    asic_mask_tbl[5] = KN03_TC1;
-    asic_irq_nr[5] = TC1;
-
-    dec_interrupt[TC2].cpu_mask = IE_IRQ0;
-    dec_interrupt[TC2].iemask = KN03_TC2;
-    asic_mask_tbl[6] = KN03_TC2;
-    asic_irq_nr[6] = TC2;
-
-    dec_interrupt[MEMORY].cpu_mask = IE_IRQ3;
-    dec_interrupt[MEMORY].iemask = 0;
-    cpu_mask_tbl[2] = IE_IRQ3;
-    cpu_irq_nr[2] = MEMORY;
-
-    dec_interrupt[HALT].cpu_mask = IE_IRQ4;
-    dec_interrupt[HALT].iemask = 0;
-    cpu_mask_tbl[3] = IE_IRQ4;
-    cpu_irq_nr[3] = HALT;
-
-    /*
-     * Enable board interrupts: FPU, I/O ASIC.
-     */
-    set_cp0_status(DEC_IE_FPU | dec_ie_ioasic);
+	/*
+	 * Setup some memory addresses. FIXME: probably incomplete!
+	 */
+	ioasic_base = (void *) KN03_IOASIC_BASE;
+	dec_rtc_base = (char *) KN03_RTC_BASE;
+	isr = (void *) KN03_IOASIC_REG(SIR);
+	imr = (void *) KN03_IOASIC_REG(SIMR);
+
+	/*
+	 * Setup IOASIC interrupt
+	 */
+	dec_ie_ioasic = IE_IRQ0;
+	cpu_ivec_tbl[1] = kn03_io_int;
+	cpu_mask_tbl[1] = dec_ie_ioasic;
+	cpu_irq_nr[1] = -1;
+	*imr = 0;
+
+	/*
+	 * Setup interrupt structure
+	 */
+	dec_interrupt[CLOCK].cpu_mask = IE_IRQ1;
+	dec_interrupt[CLOCK].iemask = 0;
+	cpu_mask_tbl[0] = IE_IRQ1;
+	cpu_irq_nr[0] = CLOCK;
+
+	dec_interrupt[SCSI_DMA_INT].cpu_mask = IE_IRQ0;
+	dec_interrupt[SCSI_DMA_INT].iemask = SCSI_DMA_INTS;
+	asic_mask_tbl[0] = SCSI_DMA_INTS;
+	asic_irq_nr[0] = SCSI_DMA_INT;
+
+	dec_interrupt[SCSI_INT].cpu_mask = IE_IRQ0;
+	dec_interrupt[SCSI_INT].iemask = SCSI_CHIP;
+	asic_mask_tbl[1] = SCSI_CHIP;
+	asic_irq_nr[1] = SCSI_INT;
+
+	dec_interrupt[ETHER].cpu_mask = IE_IRQ0;
+	dec_interrupt[ETHER].iemask = LANCE_INTS;
+	asic_mask_tbl[2] = LANCE_INTS;
+	asic_irq_nr[2] = ETHER;
+
+	dec_interrupt[SERIAL].cpu_mask = IE_IRQ0;
+	dec_interrupt[SERIAL].iemask = SERIAL_INTS;
+	asic_mask_tbl[3] = SERIAL_INTS;
+	asic_irq_nr[3] = SERIAL;
+
+	dec_interrupt[TC0].cpu_mask = IE_IRQ0;
+	dec_interrupt[TC0].iemask = KN03_TC0;
+	asic_mask_tbl[4] = KN03_TC0;
+	asic_irq_nr[4] = TC0;
+
+	dec_interrupt[TC1].cpu_mask = IE_IRQ0;
+	dec_interrupt[TC1].iemask = KN03_TC1;
+	asic_mask_tbl[5] = KN03_TC1;
+	asic_irq_nr[5] = TC1;
+
+	dec_interrupt[TC2].cpu_mask = IE_IRQ0;
+	dec_interrupt[TC2].iemask = KN03_TC2;
+	asic_mask_tbl[6] = KN03_TC2;
+	asic_irq_nr[6] = TC2;
+
+	dec_interrupt[MEMORY].cpu_mask = IE_IRQ3;
+	dec_interrupt[MEMORY].iemask = 0;
+	cpu_mask_tbl[2] = IE_IRQ3;
+	cpu_irq_nr[2] = MEMORY;
+
+	dec_interrupt[HALT].cpu_mask = IE_IRQ4;
+	dec_interrupt[HALT].iemask = 0;
+	cpu_mask_tbl[3] = IE_IRQ4;
+	cpu_irq_nr[3] = HALT;
+
+	/*
+	 * Enable board interrupts: FPU, I/O ASIC.
+	 */
+	set_cp0_status(DEC_IE_FPU | dec_ie_ioasic);
 
-    dec_halt_init(&haltirq);
+	dec_halt_init(&haltirq);
 }				/* dec_init_kn03 */
