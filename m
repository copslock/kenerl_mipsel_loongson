Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 19:34:09 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:61688 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225262AbTBTTeH>;
	Thu, 20 Feb 2003 19:34:07 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1KJY4g25826;
	Thu, 20 Feb 2003 11:34:04 -0800
Date: Thu, 20 Feb 2003 11:34:04 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] rename CONFIG_REMOTE_DEBUG and CONFIG_DEBUG
Message-ID: <20030220113404.E7466@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This patch make the following changes

	1) CONFIG_REMOTE_DEBUG -> CONFIG_KGDB
	2) CONFIG_DEBUG -> CONFIG_RUNTIME_DEBUG

MIPS is pretty much the only one (other than the pitiful s390 :0)
using REMOTE_DEBUG instead of KGDB.  So it is a good thing to change
it.

As Keith pointed out, CONFIG_DEBUG is too general (which has
already caused confusion, BTW).  RUNTIME_DEBUG is more appropriate.

Jun

--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030220.a-2.4-rename-CONFIG.patch"

diff -Nru linux/Documentation/Configure.help.orig linux/Documentation/Configure.help
--- linux/Documentation/Configure.help.orig	Thu Feb 20 10:22:47 2003
+++ linux/Documentation/Configure.help	Thu Feb 20 11:21:25 2003
@@ -20483,10 +20483,10 @@
   Don't turn this on unless you know what you are doing.
 
 Enable run-time debugging
-CONFIG_DEBUG
+CONFIG_RUNTIME_DEBUG
   If you say Y here, some debugging macros will do run-time checking.
-  If you say N here, those macros will mostly turn to no-ops.  For
-  MIPS boards only.  See include/asm-mips/debug.h for debuging macros.
+  If you say N here, those macros will mostly turn to no-ops.  Currently
+  supported by MIPS arch.  See include/asm-mips/debug.h for debuging macros.
   If unsure, say N.
 
 Remote GDB kernel debugging
diff -Nru linux/arch/mips/au1000/common/Makefile.orig linux/arch/mips/au1000/common/Makefile
--- linux/arch/mips/au1000/common/Makefile.orig	Thu Dec 12 10:35:07 2002
+++ linux/arch/mips/au1000/common/Makefile	Thu Feb 20 10:49:19 2003
@@ -23,7 +23,7 @@
 
 obj-$(CONFIG_AU1X00_UART) += serial.o
 obj-$(CONFIG_AU1000_USB_DEVICE) += usbdev.o
-obj-$(CONFIG_REMOTE_DEBUG) += dbg_io.o
+obj-$(CONFIG_KGDB) += dbg_io.o
 obj-$(CONFIG_RTC) += rtc.o
 
 include $(TOPDIR)/Rules.make
diff -Nru linux/arch/mips/au1000/common/dbg_io.c.orig linux/arch/mips/au1000/common/dbg_io.c
--- linux/arch/mips/au1000/common/dbg_io.c.orig	Wed Jan 29 15:33:01 2003
+++ linux/arch/mips/au1000/common/dbg_io.c	Thu Feb 20 10:49:19 2003
@@ -3,7 +3,7 @@
 #include <asm/io.h>
 #include <asm/au1000.h>
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 
 /*
  * FIXME the user should be able to select the
diff -Nru linux/arch/mips/au1000/common/irq.c.orig linux/arch/mips/au1000/common/irq.c
--- linux/arch/mips/au1000/common/irq.c.orig	Thu Dec 12 10:35:07 2002
+++ linux/arch/mips/au1000/common/irq.c	Thu Feb 20 10:49:19 2003
@@ -77,7 +77,7 @@
 #define EXT_INTC1_REQ1 5 /* IP 5 */
 #define MIPS_TIMER_IP  7 /* IP 7 */
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 extern void breakpoint(void);
 #endif
 
@@ -507,7 +507,7 @@
 	}
 
 	set_c0_status(ALLINTS);
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	/* If local serial I/O used for debug port, enter kgdb at once */
 	puts("Waiting for kgdb to connect...");
 	set_debug_traps();
diff -Nru linux/arch/mips/au1000/common/serial.c.orig linux/arch/mips/au1000/common/serial.c
--- linux/arch/mips/au1000/common/serial.c.orig	Thu Dec 12 10:35:07 2002
+++ linux/arch/mips/au1000/common/serial.c	Thu Feb 20 10:49:19 2003
@@ -987,7 +987,7 @@
 		set_bit(TTY_IO_ERROR, &info->tty->flags);
 
 	info->flags &= ~ASYNC_INITIALIZED;
-#ifndef CONFIG_REMOTE_DEBUG
+#ifndef CONFIG_KGDB
 	au_writel(0, UART_MOD_CNTRL + state->port);
 	au_sync_delay(10);
 #endif
diff -Nru linux/arch/mips/baget/vacserial.c.orig linux/arch/mips/baget/vacserial.c
--- linux/arch/mips/baget/vacserial.c.orig	Thu Nov  7 14:05:32 2002
+++ linux/arch/mips/baget/vacserial.c	Thu Feb 20 10:49:19 2003
@@ -2790,7 +2790,7 @@
 }
 #endif
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 #undef PRINT_DEBUG_PORT_INFO
 
 /*
@@ -2902,4 +2902,4 @@
 	return(serial_inp(info, VAC_UART_RX));
 }
 
-#endif /* CONFIG_REMOTE_DEBUG */
+#endif /* CONFIG_KGDB */
diff -Nru linux/arch/mips/ddb5074/irq.c.orig linux/arch/mips/ddb5074/irq.c
--- linux/arch/mips/ddb5074/irq.c.orig	Mon Aug  5 16:53:31 2002
+++ linux/arch/mips/ddb5074/irq.c	Thu Feb 20 10:49:19 2003
@@ -210,7 +210,7 @@
 
 void __init ddb_irq_setup(void)
 {
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	if (remote_debug)
 		set_debug_traps();
 	breakpoint();		/* you may move this line to whereever you want :-) */
diff -Nru linux/arch/mips/ddb5074/setup.c.orig linux/arch/mips/ddb5074/setup.c
--- linux/arch/mips/ddb5074/setup.c.orig	Mon Dec  2 16:55:37 2002
+++ linux/arch/mips/ddb5074/setup.c	Thu Feb 20 10:49:19 2003
@@ -28,7 +28,7 @@
 #include <asm/traps.h>
 
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 extern void rs_kgdb_hook(int);
 extern void breakpoint(void);
 #endif
diff -Nru linux/arch/mips/ddb5xxx/common/irq.c.orig linux/arch/mips/ddb5xxx/common/irq.c
--- linux/arch/mips/ddb5xxx/common/irq.c.orig	Sun Jul 14 17:02:55 2002
+++ linux/arch/mips/ddb5xxx/common/irq.c	Thu Feb 20 10:49:19 2003
@@ -19,7 +19,7 @@
 
 void __init init_IRQ(void)
 {
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	extern void breakpoint(void);
 	extern void set_debug_traps(void);
 
diff -Nru linux/arch/mips/ddb5xxx/ddb5074/irq.c.orig linux/arch/mips/ddb5xxx/ddb5074/irq.c
--- linux/arch/mips/ddb5xxx/ddb5074/irq.c.orig	Mon Aug  5 16:53:31 2002
+++ linux/arch/mips/ddb5xxx/ddb5074/irq.c	Thu Feb 20 10:49:19 2003
@@ -142,7 +142,7 @@
 
 void __init ddb_irq_setup(void)
 {
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	if (remote_debug)
 		set_debug_traps();
 	breakpoint();		/* you may move this line to whereever you want :-) */
diff -Nru linux/arch/mips/ddb5xxx/ddb5074/setup.c.orig linux/arch/mips/ddb5xxx/ddb5074/setup.c
--- linux/arch/mips/ddb5xxx/ddb5074/setup.c.orig	Mon Dec  2 16:55:40 2002
+++ linux/arch/mips/ddb5xxx/ddb5074/setup.c	Thu Feb 20 10:49:20 2003
@@ -31,7 +31,7 @@
 #include <asm/ddb5xxx/ddb5xxx.h>
 
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 extern void rs_kgdb_hook(int);
 extern void breakpoint(void);
 #endif
diff -Nru linux/arch/mips/ddb5xxx/ddb5074/pci_ops.c.orig linux/arch/mips/ddb5xxx/ddb5074/pci_ops.c
--- linux/arch/mips/ddb5xxx/ddb5074/pci_ops.c.orig	Mon Aug  5 16:53:31 2002
+++ linux/arch/mips/ddb5xxx/ddb5074/pci_ops.c	Thu Feb 20 11:18:54 2003
@@ -281,7 +281,7 @@
 };
 
 
-#if defined(CONFIG_DEBUG)
+#if defined(CONFIG_RUNTIME_DEBUG)
 void jsun_scan_pci_bus(void)
 {
 	struct pci_bus bus;
diff -Nru linux/arch/mips/ddb5xxx/ddb5476/Makefile.orig linux/arch/mips/ddb5xxx/ddb5476/Makefile
--- linux/arch/mips/ddb5xxx/ddb5476/Makefile.orig	Tue Jun 25 08:46:59 2002
+++ linux/arch/mips/ddb5xxx/ddb5476/Makefile	Thu Feb 20 10:49:20 2003
@@ -15,6 +15,6 @@
 
 obj-y				+= setup.o irq.o int-handler.o pci.o pci_ops.o \
 				   nile4_pic.o vrc5476_irq.o
-obj-$(CONFIG_REMOTE_DEBUG)	+= dbg_io.o
+obj-$(CONFIG_KGDB)	+= dbg_io.o
 
 include $(TOPDIR)/Rules.make
diff -Nru linux/arch/mips/ddb5xxx/ddb5476/setup.c.orig linux/arch/mips/ddb5xxx/ddb5476/setup.c
--- linux/arch/mips/ddb5xxx/ddb5476/setup.c.orig	Mon Dec  2 16:55:40 2002
+++ linux/arch/mips/ddb5xxx/ddb5476/setup.c	Thu Feb 20 10:49:20 2003
@@ -41,7 +41,7 @@
 #define TIMER_IRQ			(VRC5476_IRQ_BASE + VRC5476_IRQ_GPT)
 #endif
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 extern void breakpoint(void);
 #endif
 
diff -Nru linux/arch/mips/ddb5xxx/ddb5476/pci.c.orig linux/arch/mips/ddb5xxx/ddb5476/pci.c
--- linux/arch/mips/ddb5xxx/ddb5476/pci.c.orig	Mon Aug  5 16:53:31 2002
+++ linux/arch/mips/ddb5xxx/ddb5476/pci.c	Thu Feb 20 11:18:54 2003
@@ -100,7 +100,7 @@
 	}
 }
 
-#if defined(CONFIG_DEBUG)
+#if defined(CONFIG_RUNTIME_DEBUG)
 extern void jsun_scan_pci_bus(void);
 #endif
 
diff -Nru linux/arch/mips/ddb5xxx/ddb5476/pci_ops.c.orig linux/arch/mips/ddb5xxx/ddb5476/pci_ops.c
--- linux/arch/mips/ddb5xxx/ddb5476/pci_ops.c.orig	Mon Aug  5 16:53:31 2002
+++ linux/arch/mips/ddb5xxx/ddb5476/pci_ops.c	Thu Feb 20 11:18:54 2003
@@ -296,7 +296,7 @@
 };
 
 
-#if defined(CONFIG_DEBUG)
+#if defined(CONFIG_RUNTIME_DEBUG)
 void jsun_scan_pci_bus(void)
 {
 	struct pci_bus bus;
diff -Nru linux/arch/mips/ddb5xxx/ddb5477/Makefile.orig linux/arch/mips/ddb5xxx/ddb5477/Makefile
--- linux/arch/mips/ddb5xxx/ddb5477/Makefile.orig	Tue Jun 25 08:46:59 2002
+++ linux/arch/mips/ddb5xxx/ddb5477/Makefile	Thu Feb 20 11:18:54 2003
@@ -12,7 +12,7 @@
 
 obj-y	 += int-handler.o irq.o irq_5477.o setup.o pci.o pci_ops.o lcd44780.o
 
-obj-$(CONFIG_DEBUG) 		+= debug.o
+obj-$(CONFIG_RUNTIME_DEBUG) 		+= debug.o
 obj-$(CONFIG_REMOTE_DEBUG)	+= kgdb_io.o
 obj-$(CONFIG_BLK_DEV_INITRD)	+= ramdisk.o
 
diff -Nru linux/arch/mips/ddb5xxx/ddb5477/irq.c.orig linux/arch/mips/ddb5xxx/ddb5477/irq.c
--- linux/arch/mips/ddb5xxx/ddb5477/irq.c.orig	Mon Dec  2 16:55:40 2002
+++ linux/arch/mips/ddb5xxx/ddb5477/irq.c	Thu Feb 20 11:18:54 2003
@@ -176,7 +176,7 @@
 	db_assert(ddb_in32(DDB_NMISTAT) == 0);
 
 	if (ddb_in32(DDB_INT1STAT) != 0) {
-#if defined(CONFIG_DEBUG)
+#if defined(CONFIG_RUNTIME_DEBUG)
 		vrc5477_show_int_regs();
 #endif
 		panic("error interrupt has happened.");
diff -Nru linux/arch/mips/ddb5xxx/ddb5477/pci.c.orig linux/arch/mips/ddb5xxx/ddb5477/pci.c
--- linux/arch/mips/ddb5xxx/ddb5477/pci.c.orig	Fri Dec 13 10:25:00 2002
+++ linux/arch/mips/ddb5xxx/ddb5477/pci.c	Thu Feb 20 11:18:54 2003
@@ -166,7 +166,7 @@
 	}
 }
 
-#if defined(CONFIG_DEBUG)
+#if defined(CONFIG_RUNTIME_DEBUG)
 extern void jsun_scan_pci_bus(void);
 extern void jsun_assign_pci_resource(void);
 #endif
diff -Nru linux/arch/mips/galileo-boards/ev64120/irq.c.orig linux/arch/mips/galileo-boards/ev64120/irq.c
--- linux/arch/mips/galileo-boards/ev64120/irq.c.orig	Mon Dec  2 16:55:41 2002
+++ linux/arch/mips/galileo-boards/ev64120/irq.c	Thu Feb 20 10:49:20 2003
@@ -421,7 +421,7 @@
 	set_c0_status(IE_IRQ2);
 
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	{
 		extern int DEBUG_CHANNEL;
 		serial_init(DEBUG_CHANNEL);
diff -Nru linux/arch/mips/gt64120/momenco_ocelot/Makefile.orig linux/arch/mips/gt64120/momenco_ocelot/Makefile
--- linux/arch/mips/gt64120/momenco_ocelot/Makefile.orig	Tue Jun 25 08:47:00 2002
+++ linux/arch/mips/gt64120/momenco_ocelot/Makefile	Thu Feb 20 10:49:20 2003
@@ -12,6 +12,6 @@
 
 obj-y	 += int-handler.o irq.o pci.o prom.o reset.o setup.o
 
-obj-$(CONFIG_REMOTE_DEBUG) += dbg_io.o
+obj-$(CONFIG_KGDB) += dbg_io.o
 
 include $(TOPDIR)/Rules.make
diff -Nru linux/arch/mips/gt64120/momenco_ocelot/dbg_io.c.orig linux/arch/mips/gt64120/momenco_ocelot/dbg_io.c
--- linux/arch/mips/gt64120/momenco_ocelot/dbg_io.c.orig	Thu Nov 29 07:09:48 2001
+++ linux/arch/mips/gt64120/momenco_ocelot/dbg_io.c	Thu Feb 20 10:49:20 2003
@@ -1,6 +1,6 @@
 #include <linux/config.h>
 
-#if defined(CONFIG_REMOTE_DEBUG)
+#if defined(CONFIG_KGDB)
 
 #include <asm/serial.h> /* For the serial port location and base baud */
 
diff -Nru linux/arch/mips/gt64120/momenco_ocelot/irq.c.orig linux/arch/mips/gt64120/momenco_ocelot/irq.c
--- linux/arch/mips/gt64120/momenco_ocelot/irq.c.orig	Mon Dec  2 16:55:49 2002
+++ linux/arch/mips/gt64120/momenco_ocelot/irq.c	Thu Feb 20 10:49:20 2003
@@ -161,7 +161,7 @@
 
 	gt64120_irq_init();
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	printk("start kgdb ...\n");
 	set_debug_traps();
 	breakpoint();	/* you may move this line to whereever you want :-) */
diff -Nru linux/arch/mips/hp-lj/Makefile.orig linux/arch/mips/hp-lj/Makefile
--- linux/arch/mips/hp-lj/Makefile.orig	Tue Jun 25 08:47:00 2002
+++ linux/arch/mips/hp-lj/Makefile	Thu Feb 20 10:49:20 2003
@@ -17,7 +17,7 @@
 
 obj-y   := init.o setup.o irq.o int-handler.o pci.o utils.o asic.o
 
-obj-$(CONFIG_REMOTE_DEBUG) += gdb_hook.o
+obj-$(CONFIG_KGDB) += gdb_hook.o
 obj-$(CONFIG_DIRECT_PRINTK) += gdb_hook.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
diff -Nru linux/arch/mips/hp-lj/irq.c.orig linux/arch/mips/hp-lj/irq.c
--- linux/arch/mips/hp-lj/irq.c.orig	Mon Aug  5 16:53:32 2002
+++ linux/arch/mips/hp-lj/irq.c	Thu Feb 20 10:49:20 2003
@@ -25,7 +25,7 @@
     mips_cpu_irq_init(0);
     set_except_vector(0, hpIRQ);
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
     {
        extern void breakpoint(void);
        extern int remote_debug;
diff -Nru linux/arch/mips/hp-lj/setup.c.orig linux/arch/mips/hp-lj/setup.c
--- linux/arch/mips/hp-lj/setup.c.orig	Mon Aug  5 16:53:32 2002
+++ linux/arch/mips/hp-lj/setup.c	Thu Feb 20 10:49:20 2003
@@ -20,7 +20,7 @@
 #include <asm/hp-lj/asic.h>
 #include "utils.h"
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 int remote_debug = 0;
 #endif
 
@@ -144,7 +144,7 @@
 
    board_timer_setup = hp_time_init;
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
    {
       extern char CommandLine[];
       remote_debug = (strstr(CommandLine, "kgdb") != NULL);
diff -Nru linux/arch/mips/ite-boards/generic/Makefile.orig linux/arch/mips/ite-boards/generic/Makefile
--- linux/arch/mips/ite-boards/generic/Makefile.orig	Mon Aug  5 16:53:32 2002
+++ linux/arch/mips/ite-boards/generic/Makefile	Thu Feb 20 10:49:20 2003
@@ -20,6 +20,6 @@
 
 obj-$(CONFIG_PCI) += it8172_pci.o
 obj-$(CONFIG_IT8172_CIR) += it8172_cir.o
-obj-$(CONFIG_REMOTE_DEBUG) += dbg_io.o
+obj-$(CONFIG_KGDB) += dbg_io.o
 
 include $(TOPDIR)/Rules.make
diff -Nru linux/arch/mips/ite-boards/generic/dbg_io.c.orig linux/arch/mips/ite-boards/generic/dbg_io.c
--- linux/arch/mips/ite-boards/generic/dbg_io.c.orig	Sun Mar 18 05:52:36 2001
+++ linux/arch/mips/ite-boards/generic/dbg_io.c	Thu Feb 20 10:49:20 2003
@@ -1,7 +1,7 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 
 /* --- CONFIG --- */
 
diff -Nru linux/arch/mips/ite-boards/generic/irq.c.orig linux/arch/mips/ite-boards/generic/irq.c
--- linux/arch/mips/ite-boards/generic/irq.c.orig	Mon Dec  2 16:55:49 2002
+++ linux/arch/mips/ite-boards/generic/irq.c	Thu Feb 20 10:49:20 2003
@@ -65,7 +65,7 @@
 #define DPRINTK(fmt, args...)
 #endif
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 extern void breakpoint(void);
 #endif
 
@@ -301,7 +301,7 @@
 	irq_desc[MIPS_CPU_TIMER_IRQ].handler = &cp0_irq_type;
 	set_c0_status(ALLINTS_NOTIMER);
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	/* If local serial I/O used for debug port, enter kgdb at once */
 	puts("Waiting for kgdb to connect...");
 	set_debug_traps();
diff -Nru linux/arch/mips/jmr3927/rbhma3100/Makefile.orig linux/arch/mips/jmr3927/rbhma3100/Makefile
--- linux/arch/mips/jmr3927/rbhma3100/Makefile.orig	Tue Jun 25 08:47:00 2002
+++ linux/arch/mips/jmr3927/rbhma3100/Makefile	Thu Feb 20 10:49:21 2003
@@ -13,6 +13,6 @@
 obj-y	 += init.o int-handler.o irq.o setup.o rtc.o pci_fixup.o pci_ops.o
 
 obj-$(CONFIG_LL_DEBUG) 		+= debug.o
-obj-$(CONFIG_REMOTE_DEBUG)	+= kgdb_io.o
+obj-$(CONFIG_KGDB)	+= kgdb_io.o
 
 include $(TOPDIR)/Rules.make
diff -Nru linux/arch/mips/jmr3927/rbhma3100/irq.c.orig linux/arch/mips/jmr3927/rbhma3100/irq.c
--- linux/arch/mips/jmr3927/rbhma3100/irq.c.orig	Mon Dec  2 16:55:53 2002
+++ linux/arch/mips/jmr3927/rbhma3100/irq.c	Thu Feb 20 10:49:21 2003
@@ -444,7 +444,7 @@
 void __init init_IRQ(void)
 {
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
         extern void breakpoint(void);
         extern void set_debug_traps(void);
 
diff -Nru linux/arch/mips/kernel/Makefile.orig linux/arch/mips/kernel/Makefile
--- linux/arch/mips/kernel/Makefile.orig	Mon Dec 16 18:12:48 2002
+++ linux/arch/mips/kernel/Makefile	Thu Feb 20 10:49:21 2003
@@ -50,7 +50,7 @@
 
 obj-$(CONFIG_BINFMT_IRIX)	+= irixelf.o irixioctl.o irixsig.o sysirix.o \
 				   irixinv.o
-obj-$(CONFIG_REMOTE_DEBUG)	+= gdb-low.o gdb-stub.o
+obj-$(CONFIG_KGDB)	+= gdb-low.o gdb-stub.o
 obj-$(CONFIG_PROC_FS)		+= proc.o
 
 obj-$(CONFIG_NEW_PCI)		+= pci.o
diff -Nru linux/arch/mips/kernel/gdb-stub.c.orig linux/arch/mips/kernel/gdb-stub.c
--- linux/arch/mips/kernel/gdb-stub.c.orig	Thu Feb 20 10:22:50 2003
+++ linux/arch/mips/kernel/gdb-stub.c	Thu Feb 20 10:49:21 2003
@@ -99,7 +99,7 @@
  *  the kernel running. It will promptly halt and wait
  *  for the host gdb session to connect. It does this
  *  since the "Kernel Hacking" option has defined
- *  CONFIG_REMOTE_DEBUG which in turn enables your calls
+ *  CONFIG_KGDB which in turn enables your calls
  *  to:
  *     set_debug_traps();
  *     breakpoint();
diff -Nru linux/arch/mips/mips-boards/atlas/atlas_int.c.orig linux/arch/mips/mips-boards/atlas/atlas_int.c
--- linux/arch/mips/mips-boards/atlas/atlas_int.c.orig	Mon Aug  5 16:53:34 2002
+++ linux/arch/mips/mips-boards/atlas/atlas_int.c	Thu Feb 20 10:49:21 2003
@@ -130,7 +130,7 @@
 	return;
 }
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 extern void breakpoint(void);
 extern int remote_debug;
 #endif
@@ -155,7 +155,7 @@
 		irq_desc[i].handler	= &atlas_irq_type;
 	}
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	if (remote_debug) {
 		set_debug_traps();
 		breakpoint();
diff -Nru linux/arch/mips/mips-boards/atlas/atlas_setup.c.orig linux/arch/mips/mips-boards/atlas/atlas_setup.c
--- linux/arch/mips/mips-boards/atlas/atlas_setup.c.orig	Mon Aug  5 16:53:34 2002
+++ linux/arch/mips/mips-boards/atlas/atlas_setup.c	Thu Feb 20 10:49:21 2003
@@ -38,7 +38,7 @@
 char serial_console[20];
 #endif
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 extern void rs_kgdb_hook(int);
 extern void saa9730_kgdb_hook(void);
 extern void breakpoint(void);
@@ -64,7 +64,7 @@
 
 void __init atlas_setup(void)
 {
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	int rs_putDebugChar(char);
 	char rs_getDebugChar(void);
 	int saa9730_putDebugChar(char);
@@ -90,7 +90,7 @@
 	}
 #endif
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	argptr = prom_getcmdline();
 	if ((argptr = strstr(argptr, "kgdb=ttyS")) != NULL) {
 		int line;
diff -Nru linux/arch/mips/mips-boards/generic/Makefile.orig linux/arch/mips/mips-boards/generic/Makefile
--- linux/arch/mips/mips-boards/generic/Makefile.orig	Mon Aug  5 16:53:34 2002
+++ linux/arch/mips/mips-boards/generic/Makefile	Thu Feb 20 10:49:21 2003
@@ -32,6 +32,6 @@
 obj-$(CONFIG_MIPS_ATLAS)	+= time.o
 obj-$(CONFIG_MIPS_MALTA)	+= time.o
 obj-$(CONFIG_PCI)		+= pci.o
-obj-$(CONFIG_REMOTE_DEBUG)	+= gdb_hook.o
+obj-$(CONFIG_KGDB)	+= gdb_hook.o
 
 include $(TOPDIR)/Rules.make
diff -Nru linux/arch/mips/mips-boards/malta/malta_int.c.orig linux/arch/mips/mips-boards/malta/malta_int.c
--- linux/arch/mips/mips-boards/malta/malta_int.c.orig	Thu Feb 20 10:22:50 2003
+++ linux/arch/mips/mips-boards/malta/malta_int.c	Thu Feb 20 10:49:21 2003
@@ -43,7 +43,7 @@
 extern void init_i8259_irqs (void);
 extern int mips_pcibios_iack(void);
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 extern void breakpoint(void);
 extern void set_debug_traps(void);
 extern int remote_debug;
@@ -142,7 +142,7 @@
 	init_generic_irq();
 	init_i8259_irqs();
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	if (remote_debug) {
 		set_debug_traps();
 		breakpoint();
diff -Nru linux/arch/mips/mips-boards/malta/malta_setup.c.orig linux/arch/mips/mips-boards/malta/malta_setup.c
--- linux/arch/mips/mips-boards/malta/malta_setup.c.orig	Thu Feb 20 10:22:50 2003
+++ linux/arch/mips/mips-boards/malta/malta_setup.c	Thu Feb 20 10:49:21 2003
@@ -50,7 +50,7 @@
 char serial_console[20];
 #endif
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 extern void rs_kgdb_hook(int);
 int remote_debug = 0;
 #endif
@@ -86,7 +86,7 @@
 
 void __init malta_setup(void)
 {
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	int rs_putDebugChar(char);
 	char rs_getDebugChar(void);
 	extern int (*generic_putDebugChar)(char);
@@ -112,7 +112,7 @@
 	}
 #endif
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	argptr = prom_getcmdline();
 	if ((argptr = strstr(argptr, "kgdb=ttyS")) != NULL) {
 		int line;
diff -Nru linux/arch/mips/momentum/ocelot_g/Makefile.orig linux/arch/mips/momentum/ocelot_g/Makefile
--- linux/arch/mips/momentum/ocelot_g/Makefile.orig	Mon Dec  2 16:57:02 2002
+++ linux/arch/mips/momentum/ocelot_g/Makefile	Thu Feb 20 10:49:21 2003
@@ -12,6 +12,6 @@
 
 obj-y	 += gt-irq.o pci-irq.o pci.o int-handler.o irq.o prom.o reset.o setup.o
 
-obj-$(CONFIG_REMOTE_DEBUG) += dbg_io.o
+obj-$(CONFIG_KGDB) += dbg_io.o
 
 include $(TOPDIR)/Rules.make
diff -Nru linux/arch/mips/momentum/ocelot_g/dbg_io.c.orig linux/arch/mips/momentum/ocelot_g/dbg_io.c
--- linux/arch/mips/momentum/ocelot_g/dbg_io.c.orig	Mon Sep  2 09:11:44 2002
+++ linux/arch/mips/momentum/ocelot_g/dbg_io.c	Thu Feb 20 10:49:21 2003
@@ -1,6 +1,6 @@
 #include <linux/config.h>
 
-#if defined(CONFIG_REMOTE_DEBUG)
+#if defined(CONFIG_KGDB)
 
 #include <asm/serial.h> /* For the serial port location and base baud */
 
diff -Nru linux/arch/mips/momentum/ocelot_g/irq.c.orig linux/arch/mips/momentum/ocelot_g/irq.c
--- linux/arch/mips/momentum/ocelot_g/irq.c.orig	Mon Dec  2 16:57:03 2002
+++ linux/arch/mips/momentum/ocelot_g/irq.c	Thu Feb 20 10:49:21 2003
@@ -161,7 +161,7 @@
 
 	gt64240_irq_init();
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	printk("start kgdb ...\n");
 	set_debug_traps();
 	breakpoint();	/* you may move this line to whereever you want :-) */
diff -Nru linux/arch/mips/momentum/ocelot_c/Makefile.orig linux/arch/mips/momentum/ocelot_c/Makefile
--- linux/arch/mips/momentum/ocelot_c/Makefile.orig	Wed Nov 13 02:00:14 2002
+++ linux/arch/mips/momentum/ocelot_c/Makefile	Thu Feb 20 10:49:21 2003
@@ -13,6 +13,6 @@
 obj-y	 += mv-irq.o cpci-irq.o uart-irq.o int-handler.o irq.o
 obj-y    += pci-irq.o pci.o prom.o reset.o setup.o 
 
-obj-$(CONFIG_REMOTE_DEBUG) += dbg_io.o
+obj-$(CONFIG_KGDB) += dbg_io.o
 
 include $(TOPDIR)/Rules.make
diff -Nru linux/arch/mips/momentum/ocelot_c/dbg_io.c.orig linux/arch/mips/momentum/ocelot_c/dbg_io.c
--- linux/arch/mips/momentum/ocelot_c/dbg_io.c.orig	Mon Nov 11 15:05:46 2002
+++ linux/arch/mips/momentum/ocelot_c/dbg_io.c	Thu Feb 20 10:49:21 2003
@@ -1,6 +1,6 @@
 #include <linux/config.h>
 
-#if defined(CONFIG_REMOTE_DEBUG)
+#if defined(CONFIG_KGDB)
 
 #include <asm/serial.h> /* For the serial port location and base baud */
 
diff -Nru linux/arch/mips/momentum/ocelot_c/irq.c.orig linux/arch/mips/momentum/ocelot_c/irq.c
--- linux/arch/mips/momentum/ocelot_c/irq.c.orig	Sun Dec  1 16:24:50 2002
+++ linux/arch/mips/momentum/ocelot_c/irq.c	Thu Feb 20 10:49:21 2003
@@ -171,7 +171,7 @@
 	uart_irq_init();
 	cpci_irq_init();
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	printk("start kgdb ...\n");
 	set_debug_traps();
 	breakpoint();	/* you may move this line to whereever you want :-) */
diff -Nru linux/arch/mips/philips/nino/irq.c.orig linux/arch/mips/philips/nino/irq.c
--- linux/arch/mips/philips/nino/irq.c.orig	Mon Dec  2 16:57:05 2002
+++ linux/arch/mips/philips/nino/irq.c	Thu Feb 20 10:49:22 2003
@@ -251,7 +251,7 @@
 
 void __init init_IRQ(void)
 {
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	extern void breakpoint(void);
 	extern void set_debug_traps(void);
 
diff -Nru linux/arch/mips/sgi-ip22/ip22-setup.c.orig linux/arch/mips/sgi-ip22/ip22-setup.c
--- linux/arch/mips/sgi-ip22/ip22-setup.c.orig	Wed Jan 29 15:33:03 2003
+++ linux/arch/mips/sgi-ip22/ip22-setup.c	Thu Feb 20 10:49:22 2003
@@ -31,7 +31,7 @@
 #include <asm/io.h>
 #include <asm/traps.h>
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 extern void rs_kgdb_hook(int);
 extern void breakpoint(void);
 static int remote_debug = 0;
@@ -129,7 +129,7 @@
 void __init ip22_setup(void)
 {
 	char *ctype;
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	char *kgdb_ttyd;
 #endif
 	sgitime_init();
@@ -173,7 +173,7 @@
 	}
 #endif
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	kgdb_ttyd = prom_getcmdline();
 	if ((kgdb_ttyd = strstr(kgdb_ttyd, "kgdb=ttyd")) != NULL) {
 		int line;
diff -Nru linux/arch/mips/sibyte/sb1250/irq.c.orig linux/arch/mips/sibyte/sb1250/irq.c
--- linux/arch/mips/sibyte/sb1250/irq.c.orig	Thu Feb 13 11:34:55 2003
+++ linux/arch/mips/sibyte/sb1250/irq.c	Thu Feb 20 10:49:22 2003
@@ -58,7 +58,7 @@
 extern unsigned long ldt_eoi_space;
 #endif
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 extern void breakpoint(void);
 extern void set_debug_traps(void);
 
@@ -368,14 +368,14 @@
 #ifdef CONFIG_BCM1250_PROF
 	imask |= STATUSF_IP7;
 #endif
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	imask |= STATUSF_IP6;
 #endif
 	/* Enable necessary IPs, disable the rest */
 	change_c0_status(ST0_IM, imask);
 	set_except_vector(0, sb1250_irq_handler);
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	if (kgdb_flag) {
 		/* Setup uart 1 settings, mapper */
 		out64(M_DUART_IMR_BRK, KSEG1 + A_DUART + R_DUART_IMR_B);
@@ -392,7 +392,7 @@
 #endif
 }
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 
 #include <linux/delay.h>
 
@@ -414,4 +414,4 @@
 	if (!user_mode(regs))
 		set_async_breakpoint(regs->cp0_epc);
 }
-#endif 	/* CONFIG_REMOTE_DEBUG */
+#endif 	/* CONFIG_KGDB */
diff -Nru linux/arch/mips/sibyte/sb1250/irq_handler.S.orig linux/arch/mips/sibyte/sb1250/irq_handler.S
--- linux/arch/mips/sibyte/sb1250/irq_handler.S.orig	Wed Jan 29 15:33:04 2003
+++ linux/arch/mips/sibyte/sb1250/irq_handler.S	Thu Feb 20 10:49:22 2003
@@ -108,7 +108,7 @@
 2:
 #endif
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	/* KGDB (uart 1) interrupt is routed to IP[6] */
 	andi	t1, s0, CAUSEF_IP6
 	beqz	t1, 1f
diff -Nru linux/arch/mips/sibyte/swarm/Makefile.orig linux/arch/mips/sibyte/swarm/Makefile
--- linux/arch/mips/sibyte/swarm/Makefile.orig	Thu Feb 13 11:34:55 2003
+++ linux/arch/mips/sibyte/swarm/Makefile	Thu Feb 20 10:49:22 2003
@@ -4,7 +4,7 @@
 
 OBJS-y                   = setup.o cmdline.o rtc_xicor1241.o rtc_m41t81.o
 
-OBJS-$(CONFIG_REMOTE_DEBUG) += dbg_io.o
+OBJS-$(CONFIG_KGDB) += dbg_io.o
 
 sbswarm.a: $(OBJS-y)
 	$(AR) rcs sbswarm.a $^
diff -Nru linux/arch/mips/vr4181/common/irq.c.orig linux/arch/mips/vr4181/common/irq.c
--- linux/arch/mips/vr4181/common/irq.c.orig	Mon Aug  5 16:53:36 2002
+++ linux/arch/mips/vr4181/common/irq.c	Thu Feb 20 10:49:22 2003
@@ -239,7 +239,7 @@
 	setup_irq(VR4181_IRQ_RTCL1, &reserved);
 	setup_irq(VR4181_IRQ_RTCL2, &reserved);
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	printk("Setting debug traps - please connect the remote debugger.\n");
 
 	set_debug_traps();
diff -Nru linux/arch/mips/vr4181/osprey/Makefile.orig linux/arch/mips/vr4181/osprey/Makefile
--- linux/arch/mips/vr4181/osprey/Makefile.orig	Tue Jun 25 08:47:01 2002
+++ linux/arch/mips/vr4181/osprey/Makefile	Thu Feb 20 10:49:22 2003
@@ -12,6 +12,6 @@
 
 obj-y	 := setup.o prom.o reset.o
 
-obj-$(CONFIG_REMOTE_DEBUG)	+= dbg_io.o
+obj-$(CONFIG_KGDB)	+= dbg_io.o
 
 include $(TOPDIR)/Rules.make
diff -Nru linux/arch/mips/vr41xx/common/icu.c.orig linux/arch/mips/vr41xx/common/icu.c
--- linux/arch/mips/vr41xx/common/icu.c.orig	Thu Oct  3 09:58:02 2002
+++ linux/arch/mips/vr41xx/common/icu.c	Thu Feb 20 10:49:22 2003
@@ -339,7 +339,7 @@
 
 	set_except_vector(0, vr41xx_handle_interrupt);
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	printk("Setting debug traps - please connect the remote debugger.\n");
 	set_debug_traps();
 	breakpoint();
diff -Nru linux/arch/mips/Makefile.orig linux/arch/mips/Makefile
--- linux/arch/mips/Makefile.orig	Thu Feb 20 10:22:49 2003
+++ linux/arch/mips/Makefile	Thu Feb 20 10:49:18 2003
@@ -41,7 +41,7 @@
 LINKFLAGS	+= -G 0 -static # -N
 MODFLAGS	+= -mlong-calls
 
-ifdef CONFIG_REMOTE_DEBUG
+ifdef CONFIG_KGDB
 GCCFLAGS	+= -g
 ifdef CONFIG_SB1XXX_CORELIS
 GCCFLAGS	+= -mno-sched-prolog -fno-omit-frame-pointer
diff -Nru linux/arch/mips/config-shared.in.orig linux/arch/mips/config-shared.in
--- linux/arch/mips/config-shared.in.orig	Thu Feb 20 10:22:49 2003
+++ linux/arch/mips/config-shared.in	Thu Feb 20 11:18:54 2003
@@ -975,11 +975,11 @@
 comment 'Kernel hacking'
 
 bool 'Are you using a crosscompiler' CONFIG_CROSSCOMPILE
-bool 'Enable run-time debugging' CONFIG_DEBUG
+bool 'Enable run-time debugging' CONFIG_RUNTIME_DEBUG
 bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 dep_bool '  Console output to GDB' CONFIG_GDB_CONSOLE $CONFIG_REMOTE_DEBUG
 if [ "$CONFIG_SIBYTE_SB1xxx_SOC" = "y" ]; then
-   dep_bool 'Compile for Corelis Debugger' CONFIG_SB1XXX_CORELIS $CONFIG_DEBUG
+   dep_bool 'Compile for Corelis Debugger' CONFIG_SB1XXX_CORELIS $CONFIG_RUNTIME_DEBUG
 fi
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 if [ "$CONFIG_SMP" != "y" ]; then
diff -Nru linux/arch/mips/defconfig-decstation.orig linux/arch/mips/defconfig-decstation
--- linux/arch/mips/defconfig-decstation.orig	Thu Feb 13 11:34:55 2003
+++ linux/arch/mips/defconfig-decstation	Thu Feb 20 11:18:55 2003
@@ -598,7 +598,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_GDB_CONSOLE is not set
 # CONFIG_MAGIC_SYSRQ is not set
diff -Nru linux/arch/mips/defconfig-pb1000.orig linux/arch/mips/defconfig-pb1000
--- linux/arch/mips/defconfig-pb1000.orig	Thu Feb 13 11:34:55 2003
+++ linux/arch/mips/defconfig-pb1000	Thu Feb 20 11:18:56 2003
@@ -810,7 +810,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_GDB_CONSOLE is not set
 # CONFIG_MAGIC_SYSRQ is not set
diff -Nru linux/arch/mips/defconfig-pb1100.orig linux/arch/mips/defconfig-pb1100
--- linux/arch/mips/defconfig-pb1100.orig	Thu Feb 13 11:34:55 2003
+++ linux/arch/mips/defconfig-pb1100	Thu Feb 20 11:18:56 2003
@@ -834,7 +834,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_GDB_CONSOLE is not set
 # CONFIG_MAGIC_SYSRQ is not set
diff -Nru linux/arch/mips/defconfig-pb1500.orig linux/arch/mips/defconfig-pb1500
--- linux/arch/mips/defconfig-pb1500.orig	Thu Feb 13 11:34:55 2003
+++ linux/arch/mips/defconfig-pb1500	Thu Feb 20 11:18:56 2003
@@ -1019,7 +1019,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_GDB_CONSOLE is not set
 # CONFIG_MAGIC_SYSRQ is not set
diff -Nru linux/arch/mips/defconfig-sb1250-swarm.orig linux/arch/mips/defconfig-sb1250-swarm
--- linux/arch/mips/defconfig-sb1250-swarm.orig	Thu Feb 13 11:34:55 2003
+++ linux/arch/mips/defconfig-sb1250-swarm	Thu Feb 20 11:18:56 2003
@@ -551,7 +551,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_GDB_CONSOLE is not set
 # CONFIG_SB1XXX_CORELIS is not set
diff -Nru linux/arch/mips/defconfig-db1000.orig linux/arch/mips/defconfig-db1000
--- linux/arch/mips/defconfig-db1000.orig	Thu Feb 13 11:34:55 2003
+++ linux/arch/mips/defconfig-db1000	Thu Feb 20 11:18:55 2003
@@ -755,7 +755,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_GDB_CONSOLE is not set
 # CONFIG_MAGIC_SYSRQ is not set
diff -Nru linux/arch/mips/defconfig-db1500.orig linux/arch/mips/defconfig-db1500
--- linux/arch/mips/defconfig-db1500.orig	Thu Feb 13 11:34:55 2003
+++ linux/arch/mips/defconfig-db1500	Thu Feb 20 11:18:55 2003
@@ -763,7 +763,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_GDB_CONSOLE is not set
 # CONFIG_MAGIC_SYSRQ is not set
diff -Nru linux/arch/mips/defconfig.orig linux/arch/mips/defconfig
--- linux/arch/mips/defconfig.orig	Thu Feb  6 13:24:00 2003
+++ linux/arch/mips/defconfig	Thu Feb 20 11:18:55 2003
@@ -641,7 +641,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-atlas.orig linux/arch/mips/defconfig-atlas
--- linux/arch/mips/defconfig-atlas.orig	Thu Feb  6 13:24:00 2003
+++ linux/arch/mips/defconfig-atlas	Thu Feb 20 11:18:55 2003
@@ -640,7 +640,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-capcella.orig linux/arch/mips/defconfig-capcella
--- linux/arch/mips/defconfig-capcella.orig	Thu Feb  6 13:24:00 2003
+++ linux/arch/mips/defconfig-capcella	Thu Feb 20 11:18:55 2003
@@ -641,7 +641,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-cobalt.orig linux/arch/mips/defconfig-cobalt
--- linux/arch/mips/defconfig-cobalt.orig	Thu Feb  6 13:24:00 2003
+++ linux/arch/mips/defconfig-cobalt	Thu Feb 20 11:18:55 2003
@@ -636,7 +636,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-ddb5476.orig linux/arch/mips/defconfig-ddb5476
--- linux/arch/mips/defconfig-ddb5476.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-ddb5476	Thu Feb 20 11:18:55 2003
@@ -677,7 +677,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-CONFIG_DEBUG=y
+CONFIG_RUNTIME_DEBUG=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-ddb5477.orig linux/arch/mips/defconfig-ddb5477
--- linux/arch/mips/defconfig-ddb5477.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-ddb5477	Thu Feb 20 11:18:55 2003
@@ -573,7 +573,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-CONFIG_DEBUG=y
+CONFIG_RUNTIME_DEBUG=y
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-e55.orig linux/arch/mips/defconfig-e55
--- linux/arch/mips/defconfig-e55.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-e55	Thu Feb 20 11:18:55 2003
@@ -601,7 +601,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-eagle.orig linux/arch/mips/defconfig-eagle
--- linux/arch/mips/defconfig-eagle.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-eagle	Thu Feb 20 11:18:55 2003
@@ -776,7 +776,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-ev64120.orig linux/arch/mips/defconfig-ev64120
--- linux/arch/mips/defconfig-ev64120.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-ev64120	Thu Feb 20 11:18:55 2003
@@ -558,7 +558,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-ev96100.orig linux/arch/mips/defconfig-ev96100
--- linux/arch/mips/defconfig-ev96100.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-ev96100	Thu Feb 20 11:18:55 2003
@@ -553,7 +553,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-hp-lj.orig linux/arch/mips/defconfig-hp-lj
--- linux/arch/mips/defconfig-hp-lj.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-hp-lj	Thu Feb 20 11:18:55 2003
@@ -708,7 +708,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-ip22.orig linux/arch/mips/defconfig-ip22
--- linux/arch/mips/defconfig-ip22.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-ip22	Thu Feb 20 11:18:55 2003
@@ -641,7 +641,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-it8172.orig linux/arch/mips/defconfig-it8172
--- linux/arch/mips/defconfig-it8172.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-it8172	Thu Feb 20 11:18:55 2003
@@ -729,7 +729,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-ivr.orig linux/arch/mips/defconfig-ivr
--- linux/arch/mips/defconfig-ivr.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-ivr	Thu Feb 20 11:18:55 2003
@@ -765,7 +765,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-jmr3927.orig linux/arch/mips/defconfig-jmr3927
--- linux/arch/mips/defconfig-jmr3927.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-jmr3927	Thu Feb 20 11:18:55 2003
@@ -618,7 +618,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-lasat.orig linux/arch/mips/defconfig-lasat
--- linux/arch/mips/defconfig-lasat.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-lasat	Thu Feb 20 11:18:55 2003
@@ -705,7 +705,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-malta.orig linux/arch/mips/defconfig-malta
--- linux/arch/mips/defconfig-malta.orig	Thu Feb 20 10:22:49 2003
+++ linux/arch/mips/defconfig-malta	Thu Feb 20 11:18:55 2003
@@ -621,7 +621,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-mpc30x.orig linux/arch/mips/defconfig-mpc30x
--- linux/arch/mips/defconfig-mpc30x.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-mpc30x	Thu Feb 20 11:18:55 2003
@@ -648,7 +648,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-nino.orig linux/arch/mips/defconfig-nino
--- linux/arch/mips/defconfig-nino.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-nino	Thu Feb 20 11:18:55 2003
@@ -498,7 +498,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-ocelot.orig linux/arch/mips/defconfig-ocelot
--- linux/arch/mips/defconfig-ocelot.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-ocelot	Thu Feb 20 11:18:56 2003
@@ -547,7 +547,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-osprey.orig linux/arch/mips/defconfig-osprey
--- linux/arch/mips/defconfig-osprey.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-osprey	Thu Feb 20 11:18:56 2003
@@ -520,7 +520,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-rm200.orig linux/arch/mips/defconfig-rm200
--- linux/arch/mips/defconfig-rm200.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-rm200	Thu Feb 20 11:18:56 2003
@@ -481,7 +481,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-sead.orig linux/arch/mips/defconfig-sead
--- linux/arch/mips/defconfig-sead.orig	Thu Feb  6 13:24:01 2003
+++ linux/arch/mips/defconfig-sead	Thu Feb 20 11:18:56 2003
@@ -359,7 +359,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-tb0226.orig linux/arch/mips/defconfig-tb0226
--- linux/arch/mips/defconfig-tb0226.orig	Tue Feb  4 04:43:06 2003
+++ linux/arch/mips/defconfig-tb0226	Thu Feb 20 11:18:56 2003
@@ -764,7 +764,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips/defconfig-workpad.orig linux/arch/mips/defconfig-workpad
--- linux/arch/mips/defconfig-workpad.orig	Thu Feb  6 13:24:02 2003
+++ linux/arch/mips/defconfig-workpad	Thu Feb 20 11:18:56 2003
@@ -601,7 +601,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips64/Makefile.orig linux/arch/mips64/Makefile
--- linux/arch/mips64/Makefile.orig	Thu Feb 20 10:22:51 2003
+++ linux/arch/mips64/Makefile	Thu Feb 20 10:49:22 2003
@@ -39,7 +39,7 @@
 LINKFLAGS	+= -G 0 -static # -N
 MODFLAGS	+= -mlong-calls
 
-ifdef CONFIG_REMOTE_DEBUG
+ifdef CONFIG_KGDB
 GCCFLAGS	+= -g
 ifdef CONFIG_SB1XXX_CORELIS
 GCCFLAGS	+= -mno-sched-prolog -fno-omit-frame-pointer
diff -Nru linux/arch/mips64/defconfig-malta.orig linux/arch/mips64/defconfig-malta
--- linux/arch/mips64/defconfig-malta.orig	Thu Feb 20 10:22:51 2003
+++ linux/arch/mips64/defconfig-malta	Thu Feb 20 11:18:54 2003
@@ -587,7 +587,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_GDB_CONSOLE is not set
 # CONFIG_MAGIC_SYSRQ is not set
diff -Nru linux/arch/mips64/defconfig-sb1250-swarm.orig linux/arch/mips64/defconfig-sb1250-swarm
--- linux/arch/mips64/defconfig-sb1250-swarm.orig	Thu Feb 13 11:34:55 2003
+++ linux/arch/mips64/defconfig-sb1250-swarm	Thu Feb 20 11:18:54 2003
@@ -551,7 +551,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_GDB_CONSOLE is not set
 # CONFIG_SB1XXX_CORELIS is not set
diff -Nru linux/arch/mips64/defconfig-decstation.orig linux/arch/mips64/defconfig-decstation
--- linux/arch/mips64/defconfig-decstation.orig	Thu Feb 13 11:34:55 2003
+++ linux/arch/mips64/defconfig-decstation	Thu Feb 20 11:18:54 2003
@@ -596,7 +596,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_REMOTE_DEBUG is not set
 # CONFIG_GDB_CONSOLE is not set
 # CONFIG_MAGIC_SYSRQ is not set
diff -Nru linux/arch/mips64/defconfig.orig linux/arch/mips64/defconfig
--- linux/arch/mips64/defconfig.orig	Thu Feb  6 13:24:02 2003
+++ linux/arch/mips64/defconfig	Thu Feb 20 11:18:54 2003
@@ -590,7 +590,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 
 #
diff -Nru linux/arch/mips64/defconfig-atlas.orig linux/arch/mips64/defconfig-atlas
--- linux/arch/mips64/defconfig-atlas.orig	Thu Feb  6 13:24:02 2003
+++ linux/arch/mips64/defconfig-atlas	Thu Feb 20 11:18:54 2003
@@ -584,7 +584,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips64/defconfig-ip22.orig linux/arch/mips64/defconfig-ip22
--- linux/arch/mips64/defconfig-ip22.orig	Thu Feb  6 13:24:02 2003
+++ linux/arch/mips64/defconfig-ip22	Thu Feb 20 11:18:54 2003
@@ -637,7 +637,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/arch/mips64/defconfig-ip27.orig linux/arch/mips64/defconfig-ip27
--- linux/arch/mips64/defconfig-ip27.orig	Thu Feb  6 13:24:02 2003
+++ linux/arch/mips64/defconfig-ip27	Thu Feb 20 11:18:54 2003
@@ -590,7 +590,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 
 #
diff -Nru linux/arch/mips64/defconfig-ip32.orig linux/arch/mips64/defconfig-ip32
--- linux/arch/mips64/defconfig-ip32.orig	Thu Feb  6 13:24:02 2003
+++ linux/arch/mips64/defconfig-ip32	Thu Feb 20 11:18:54 2003
@@ -609,7 +609,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_MIPS_UNCACHED=y
 
diff -Nru linux/arch/mips64/defconfig-sead.orig linux/arch/mips64/defconfig-sead
--- linux/arch/mips64/defconfig-sead.orig	Thu Feb  6 13:24:02 2003
+++ linux/arch/mips64/defconfig-sead	Thu Feb 20 11:18:54 2003
@@ -357,7 +357,7 @@
 # Kernel hacking
 #
 CONFIG_CROSSCOMPILE=y
-# CONFIG_DEBUG is not set
+# CONFIG_RUNTIME_DEBUG is not set
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_MIPS_UNCACHED is not set
 
diff -Nru linux/drivers/char/Config.in.orig linux/drivers/char/Config.in
--- linux/drivers/char/Config.in.orig	Thu Feb 20 10:22:52 2003
+++ linux/drivers/char/Config.in	Thu Feb 20 10:49:23 2003
@@ -99,7 +99,7 @@
             if [ "$CONFIG_SIBYTE_SB1250_DUART_CONSOLE" = "y" ]; then
                define_bool CONFIG_SERIAL_CONSOLE y
             fi
-            if [ "$CONFIG_REMOTE_DEBUG" = "y" ]; then
+            if [ "$CONFIG_KGDB" = "y" ]; then
                define_bool CONFIG_SIBYTE_SB1250_DUART_NO_PORT_1 y
             fi
          fi
diff -Nru linux/drivers/sgi/char/sgiserial.c.orig linux/drivers/sgi/char/sgiserial.c
--- linux/drivers/sgi/char/sgiserial.c.orig	Wed Jan 29 15:33:19 2003
+++ linux/drivers/sgi/char/sgiserial.c	Thu Feb 20 10:49:23 2003
@@ -18,7 +18,7 @@
  *                                             any speed - not only 9600
  */
 
-#include <linux/config.h> /* for CONFIG_REMOTE_DEBUG */
+#include <linux/config.h> /* for CONFIG_KGDB */
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -395,7 +395,7 @@
 	mark_bh(SERIAL_BH);
 }
 
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 extern void set_async_breakpoint(unsigned int epc);
 #endif
 
@@ -431,7 +431,7 @@
 	 * for remote target debugging and arch/sparc/kernel/sparc-stub.c
 	 * to see how all this works.
 	 */
-#ifdef CONFIG_REMOTE_DEBUG
+#ifdef CONFIG_KGDB
 	if((info->kgdb_channel) && (ch =='\003')) {
 		set_async_breakpoint(read_32bit_cp0_register(CP0_EPC));
 		goto clear_and_exit;
diff -Nru linux/drivers/sound/Config.in.orig linux/drivers/sound/Config.in
--- linux/drivers/sound/Config.in.orig	Thu Dec 12 10:35:13 2002
+++ linux/drivers/sound/Config.in	Thu Feb 20 10:49:23 2003
@@ -35,7 +35,7 @@
 dep_mbool    '    Creative SBLive! MIDI' CONFIG_MIDI_EMU10K1 $CONFIG_SOUND_EMU10K1 $CONFIG_EXPERIMENTAL
 dep_tristate '  Crystal SoundFusion (CS4280/461x)' CONFIG_SOUND_FUSION $CONFIG_SOUND $CONFIG_PCI
 dep_tristate '  Crystal Sound CS4281' CONFIG_SOUND_CS4281 $CONFIG_SOUND $CONFIG_PCI
-if [ "$CONFIG_SIBYTE_SB1250" = "y" -a "$CONFIG_REMOTE_DEBUG" != "y" ]; then
+if [ "$CONFIG_SIBYTE_SB1250" = "y" -a "$CONFIG_KGDB" != "y" ]; then
     dep_tristate '  Crystal Sound CS4297a (for Swarm)' CONFIG_SOUND_BCM_CS4297A $CONFIG_SOUND
 fi
 dep_tristate '  Ensoniq AudioPCI (ES1370)' CONFIG_SOUND_ES1370 $CONFIG_SOUND $CONFIG_PCI
diff -Nru linux/drivers/sound/trident.c.orig linux/drivers/sound/trident.c
--- linux/drivers/sound/trident.c.orig	Wed Jan 29 15:33:21 2003
+++ linux/drivers/sound/trident.c	Thu Feb 20 11:18:56 2003
@@ -66,7 +66,7 @@
  *      with nothing in between. 
  *  v0.14.10a
  *      June 21 2002 Muli Ben-Yehuda <mulix@actcom.co.il> 
- *      use a debug macro instead of #ifdef CONFIG_DEBUG, trim to 80 columns 
+ *      use a debug macro instead of #ifdef CONFIG_RUNTIME_DEBUG, trim to 80 columns 
  *      per line, use 'do {} while (0)' in statement macros. 
  *  v0.14.10
  *      June 6 2002 Lei Hu <Lei_hu@ali.com.tw>
diff -Nru linux/include/asm-mips/ddb5xxx/ddb5477.h.orig linux/include/asm-mips/ddb5xxx/ddb5477.h
--- linux/include/asm-mips/ddb5xxx/ddb5477.h.orig	Thu Dec 12 10:39:50 2002
+++ linux/include/asm-mips/ddb5xxx/ddb5477.h	Thu Feb 20 11:18:56 2003
@@ -329,7 +329,7 @@
  * debug routines
  */
 #ifndef __ASSEMBLY__
-#if defined(CONFIG_DEBUG)
+#if defined(CONFIG_RUNTIME_DEBUG)
 extern void vrc5477_show_pdar_regs(void);
 extern void vrc5477_show_pci_regs(void);
 extern void vrc5477_show_bar_regs(void);
diff -Nru linux/include/asm-mips/debug.h.orig linux/include/asm-mips/debug.h
--- linux/include/asm-mips/debug.h.orig	Thu Dec 12 10:42:53 2002
+++ linux/include/asm-mips/debug.h	Thu Feb 20 11:18:56 2003
@@ -1,5 +1,5 @@
 /*
- * Debug macros for run-time debugging.  Turned on/off with CONFIG_DEBUG option.
+ * Debug macros for run-time debugging.  Turned on/off with CONFIG_RUNTIME_DEBUG option.
  *
  * Copyright (C) 2001 MontaVista Software Inc.
  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
@@ -17,13 +17,13 @@
 #include <linux/config.h>
 
 /*
- * run-time macros for catching spurious errors.  Eable CONFIG_DEBUG in
+ * run-time macros for catching spurious errors.  Eable CONFIG_RUNTIME_DEBUG in
  * kernel hacking config menu to use them.
  *
  * Use them as run-time debugging aid.  NEVER USE THEM AS ERROR HANDLING CODE!!!
  */
 
-#ifdef CONFIG_DEBUG
+#ifdef CONFIG_RUNTIME_DEBUG
 
 #include <linux/kernel.h>
 

--wTWi5aaYRw9ix9vO--
