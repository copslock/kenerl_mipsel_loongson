Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBAIJ6410829
	for linux-mips-outgoing; Mon, 10 Dec 2001 10:19:06 -0800
Received: from hlubocky.del.cz (hlubocky.del.cz [212.27.221.67])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBAIIco10820
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 10:18:38 -0800
Received: from ladis (helo=localhost)
	by hlubocky.del.cz with local-esmtp (Exim 3.12 #1 (Debian))
	id 16DU3h-0002R6-00; Mon, 10 Dec 2001 18:17:42 +0100
Date: Mon, 10 Dec 2001 18:17:41 +0100 (CET)
From: Ladislav Michl <ladislav.michl@hlubocky.del.cz>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Ian Chilton <ian@ichilton.co.uk>, Florian Lohoff <flo@rfc822.org>,
   linux-mips@oss.sgi.com
Subject: [PATCH] timer fix (was: Re: 2.4.16 success on Indy...)
In-Reply-To: <Pine.LNX.4.21.0112081727330.14453-100000@hlubocky.del.cz>
Message-ID: <Pine.LNX.4.21.0112101807070.9275-100000@hlubocky.del.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

here it is. the only important change is of course in ip22-time.c
the rest is for better look and feel only :-)

Index: linux/arch/mips/sgi-ip22/ip22-reset.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-reset.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 ip22-reset.c
--- linux/arch/mips/sgi-ip22/ip22-reset.c	2001/12/07 15:45:29	1.1.2.1
+++ linux/arch/mips/sgi-ip22/ip22-reset.c	2001/12/10 18:03:12
@@ -180,7 +180,7 @@
 	unsigned int buttons;
 
 	buttons = hpc3mregs->panel;
-	hpc3mregs->panel = 3; /* power_interrupt | power_supply_on */
+	hpc3mregs->panel = 0x03;	/* power_interrupt | power_supply_on */
 
 	if (ioc_icontrol->istat1 & 2) { /* Wait until interrupt goes away */
 		disable_irq(SGI_PANEL_IRQ);
@@ -190,7 +190,7 @@
 		add_timer(&debounce_timer);
 	}
 
-	if (!(buttons & 2))		/* Power button was pressed */
+	if (!(buttons & 0x02))		/* Power button was pressed */
 		power_button();
 	if (!(buttons & 0x40)) {	/* Volume up button was pressed */
 		init_timer(&volume_timer);
Index: linux/arch/mips/sgi-ip22/ip22-setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-setup.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 ip22-setup.c
--- linux/arch/mips/sgi-ip22/ip22-setup.c	2001/12/07 15:45:29	1.1.2.1
+++ linux/arch/mips/sgi-ip22/ip22-setup.c	2001/12/10 18:03:13
@@ -61,7 +61,7 @@
 	   indy_setup wouldn't work since kmalloc isn't initialized yet.  */
 	indy_reboot_setup();
 
-	return request_irq(SGI_KEYBOARD_IRQ, handler, 0, "keyboard", NULL);
+	return request_irq(SGI_KEYBD_IRQ, handler, 0, "keyboard", NULL);
 }
 
 static int sgi_aux_request_irq(void (*handler)(int, void *, struct pt_regs *))
Index: linux/arch/mips/sgi-ip22/ip22-time.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-time.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 ip22-time.c
--- linux/arch/mips/sgi-ip22/ip22-time.c	2001/12/07 15:45:29	1.1.2.1
+++ linux/arch/mips/sgi-ip22/ip22-time.c	2001/12/10 18:03:13
@@ -127,12 +127,11 @@
 	return ((ct1 - ct0) / 5000) * 5000;
 }
 
+/* 
+ * Here we need to calibrate the cycle counter to at least be close. 
+ */
 void indy_time_init(void)
 {
-	/* Here we need to calibrate the cycle counter to at least be close.
-	 * We don't need to actually register the irq handler because that's
-	 * all done in indyIRQ.S.
-	 */
 	struct sgi_ioc_timers *p;
 	volatile unsigned char *tcwp, *tc2p;
 	unsigned long r4k_ticks[3];
@@ -215,8 +214,16 @@
 
 static void indy_timer_setup(struct irqaction *irq)
 {
+	unsigned long count;
+	
 	/* over-write the handler, we use our own way */
 	irq->handler = no_action;
+
+	/* set time for first interrupt */
+	count = read_32bit_cp0_register(CP0_COUNT);
+	count += mips_counter_frequency / HZ;
+	write_32bit_cp0_register(CP0_COMPARE, count);
+
 	/* setup irqaction */
 	setup_irq(SGI_TIMER_IRQ, irq);
 }
Index: linux/include/asm-mips/sgi/sgint23.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/sgi/sgint23.h,v
retrieving revision 1.5
diff -u -r1.5 sgint23.h
--- linux/include/asm-mips/sgi/sgint23.h	2001/11/23 01:06:57	1.5
+++ linux/include/asm-mips/sgi/sgint23.h	2001/12/10 18:04:59
@@ -64,7 +64,7 @@
  * We map them to 0 */
 #define SGI_VERT_IRQ	SGINT_LOCAL2 + 0	/* INT3: newport vertical status */
 #define SGI_EISA_IRQ	SGINT_LOCAL2 + 3	/* EISA interrupts */
-#define SGI_KEYBOARD_IRQ	SGINT_LOCAL2 + 4	/* keyboard */
+#define SGI_KEYBD_IRQ	SGINT_LOCAL2 + 4	/* keyboard */
 #define SGI_SERIAL_IRQ	SGINT_LOCAL2 + 5	/* onboard serial */
 
 /* INT2 occupies HPC PBUS slot 4, INT3 uses slot 6. */
@@ -227,8 +227,5 @@
 extern struct sgi_ioc_ints *ioc_icontrol;
 extern struct sgi_ioc_timers *ioc_timers;
 extern volatile unsigned char *ioc_tclear;
-
-extern void sgint_init(void);
-extern void indy_timer_init(void);
 
 #endif /* _ASM_SGI_SGINT23_H */
