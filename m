Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2003 19:38:24 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:297
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8225217AbTGJSiV>; Thu, 10 Jul 2003 19:38:21 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 19agIk-0000yu-00; Thu, 10 Jul 2003 20:37:54 +0200
To: ralf@linux-mips.org
Subject: [PATCH 2.5] LASAT updates - now it boots- whoohoo
Cc: linux-mips@linux-mips.org
Message-Id: <E19agIk-0000yu-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Thu, 10 Jul 2003 20:37:54 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
	this patch gets the code into the shape where I get up into
userspace - on the boards with flash I can login and the system 
mostly works. On the boards with disks I cant login and I get a 
lot of exceptions on startup but it looks close to working.
The pcnet32 patch is necessary for LASAT and I have not been able
to get a response from anyone with network code responsibility to
even comment the patch. Surely this patch which is necessary for
a platform can be accepted via linux-mips (you) when you merge with
Linus?

/Brian

Index: arch/mips/Kconfig-shared
===================================================================
RCS file: /cvs/linux/arch/mips/Kconfig-shared,v
retrieving revision 1.55
diff -u -r1.55 Kconfig-shared
--- arch/mips/Kconfig-shared	9 Jul 2003 18:13:02 -0000	1.55
+++ arch/mips/Kconfig-shared	10 Jul 2003 18:21:41 -0000
@@ -107,14 +107,6 @@
 config LASAT
 	bool "Support for LASAT Networks platforms"
 
-config LASAT_100
-	bool "Support for LASAT Networks 100 series"
-	depends on LASAT
-
-config LASAT_200
-	bool "Support for LASAT Networks 200 series"
-	depends on LASAT
-
 config PICVUE
 	tristate "PICVUE LCD display driver"
 	depends on LASAT
Index: arch/mips/lasat/prom.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/prom.c,v
retrieving revision 1.4
diff -u -r1.4 prom.c
--- arch/mips/lasat/prom.c	7 Apr 2003 00:17:52 -0000	1.4
+++ arch/mips/lasat/prom.c	8 Jul 2003 18:54:58 -0000
@@ -76,7 +76,7 @@
 {
 	u32 version = *(u32 *)(RESET_VECTOR + 0x90);
 
-	if (version == 306) {
+	if (version >= 307) {
 		prom_display = (void *)PROM_DISPLAY_ADDR;
 		prom_putc = (void *)PROM_PUTC_ADDR;
 		prom_printf = real_prom_printf;
Index: arch/mips/lasat/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/setup.c,v
retrieving revision 1.7
diff -u -r1.7 setup.c
--- arch/mips/lasat/setup.c	5 Jun 2003 18:23:59 -0000	1.7
+++ arch/mips/lasat/setup.c	10 Jul 2003 18:04:46 -0000
@@ -36,7 +36,9 @@
 #include <asm/irq.h>
 #include <asm/lasat/lasat.h>
 
+#include <linux/tty.h>
 #include <linux/serial.h>
+#include <linux/serial_core.h>
 #include <asm/serial.h>
 #include <asm/lasat/serial.h>
 
@@ -150,28 +152,28 @@
 	ll_timer_interrupt(MIPS_CPU_TIMER_IRQ, regs);
 }
 
-//#define DYNAMIC_SERIAL_INIT
+#define DYNAMIC_SERIAL_INIT
 #ifdef DYNAMIC_SERIAL_INIT
 void __init serial_init(void)
 {
-#ifdef CONFIG_SERIAL
-	struct serial_struct s;
+#ifdef CONFIG_SERIAL_8250
+	struct uart_port s;
 
 	memset(&s, 0, sizeof(s));
 
-	s.flags = STD_COM_FLAGS;
-	s.io_type = SERIAL_IO_MEM;
+	s.flags = STD_COM_FLAGS|UPF_RESOURCES;
+	s.iotype = SERIAL_IO_MEM;
 
 	if (mips_machtype == MACH_LASAT_100) {
-		s.baud_base = LASAT_BASE_BAUD_100;
+		s.uartclk = LASAT_BASE_BAUD_100 * 16;
 		s.irq = LASATINT_UART_100;
-		s.iomem_reg_shift = LASAT_UART_REGS_SHIFT_100;
-		s.iomem_base = (u8 *)KSEG1ADDR(LASAT_UART_REGS_BASE_100);
+		s.regshift = LASAT_UART_REGS_SHIFT_100;
+		s.membase = (char *)KSEG1ADDR(LASAT_UART_REGS_BASE_100);
 	} else {
-		s.baud_base = LASAT_BASE_BAUD_200;
+		s.uartclk = LASAT_BASE_BAUD_200 * 16;
 		s.irq = LASATINT_UART_200;
-		s.iomem_reg_shift = LASAT_UART_REGS_SHIFT_200;
-		s.iomem_base = (u8 *)KSEG1ADDR(LASAT_UART_REGS_BASE_200);
+		s.regshift = LASAT_UART_REGS_SHIFT_200;
+		s.membase = (char *)KSEG1ADDR(LASAT_UART_REGS_BASE_200);
 	}
 
 	if (early_serial_setup(&s) != 0)
Index: arch/mips/pci/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips/pci/Makefile,v
retrieving revision 1.1
diff -u -r1.1 Makefile
--- arch/mips/pci/Makefile	13 Jun 2003 13:58:31 -0000	1.1
+++ arch/mips/pci/Makefile	22 Jun 2003 11:14:46 -0000
@@ -12,7 +12,7 @@
 obj-$(CONFIG_DDB5477)		+= pci-ddb5477.o ops-ddb5477.o
 obj-$(CONFIG_HP_LASERJET)	+= pci-hplj.o
 obj-$(CONFIG_ITE_BOARD_GEN)	+= ops-it8172.o
-obj-$(CONFIG_LASAT)		+= pci-lasat.o
+obj-$(CONFIG_LASAT)		+= pci-lasat.o common.o
 obj-$(CONFIG_MIPS_BOARDS_GEN)	+= pci-mips.o
 obj-$(CONFIG_MIPS_COBALT)	+= pci-cobalt.o
 obj-$(CONFIG_MIPS_EV64120)	+= ops-ev64120.o
Index: arch/mips/pci/common.c
===================================================================
RCS file: /cvs/linux/arch/mips/pci/common.c,v
retrieving revision 1.2
diff -u -r1.2 common.c
--- arch/mips/pci/common.c	13 Jun 2003 14:19:56 -0000	1.2
+++ arch/mips/pci/common.c	22 Jun 2003 11:18:07 -0000
@@ -1,6 +1,9 @@
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
 void __init pcibios_fixup_bus(struct pci_bus *b)
 {
-	Dprintk("pcibios_fixup_bus()\n");
 }
 
 static int pcibios_enable_resources(struct pci_dev *dev, int mask)
Index: arch/mips/pci/pci-lasat.c
===================================================================
RCS file: /cvs/linux/arch/mips/pci/pci-lasat.c,v
retrieving revision 1.3
diff -u -r1.3 pci-lasat.c
--- arch/mips/pci/pci-lasat.c	22 Jun 2003 02:19:24 -0000	1.3
+++ arch/mips/pci/pci-lasat.c	22 Jun 2003 11:20:18 -0000
@@ -239,7 +239,4 @@
 	return 0;
 }
 
-unsigned __init int pcibios_assign_all_busses(void)
-{
-	return 1;
-}
+subsys_initcall(pcibios_init);
Index: drivers/net/pcnet32.c
===================================================================
RCS file: /cvs/linux/drivers/net/pcnet32.c,v
retrieving revision 1.51
diff -u -r1.51 pcnet32.c
--- drivers/net/pcnet32.c	23 Jun 2003 01:23:05 -0000	1.51
+++ drivers/net/pcnet32.c	23 Jun 2003 19:18:33 -0000
@@ -769,9 +769,12 @@
     if (irq_line) {
 	dev->irq = irq_line;
     }
-    
+
+#ifndef CONFIG_LASAT
     if (dev->irq >= 2)
+#endif
 	printk(" assigned IRQ %d.\n", dev->irq);
+#ifndef CONFIG_LASAT
     else {
 	unsigned long irq_mask = probe_irq_on();
 	
@@ -794,6 +797,7 @@
 	    return -ENODEV;
 	}
     }
+#endif
 
     /* Set the mii phy_id so that we can query the link state */
     if (lp->mii)
Index: include/asm-mips/serial.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/serial.h,v
retrieving revision 1.39
diff -u -r1.39 serial.h
--- include/asm-mips/serial.h	15 Jun 2003 23:42:07 -0000	1.39
+++ include/asm-mips/serial.h	10 Jul 2003 18:21:22 -0000
@@ -156,13 +156,11 @@
 #endif
 
 #ifdef CONFIG_LASAT
-#include <asm/lasat/serial.h>
-#define LASAT_SERIAL_PORT_DEFNS						\
-	{ .baud_base = LASAT_BASE_BAUD, .irq = LASATINT_UART,		\
-	  .flags = STD_COM_FLAGS,						\
-	  .port = LASAT_UART_REGS_BASE, /* Only for display */		\
-	  .iomem_base = (u8 *)KSEG1ADDR(LASAT_UART_REGS_BASE),		\
-	  .iomem_reg_shift = LASAT_UART_REGS_SHIFT, .io_type = SERIAL_IO_MEM },
+/* This dummy definition allocates one element in the SERIAL_PORT_DFNS
+ * list below. This element is filled out by the the code in serial_init() 
+ * in arch/mips/lasat/setup.c which autoselects the configuration based 
+ * on machine type. */
+#define LASAT_SERIAL_PORT_DEFNS { },
 #else
 #define LASAT_SERIAL_PORT_DEFNS
 #endif
Index: include/asm-mips/lasat/serial.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/lasat/serial.h,v
retrieving revision 1.2
diff -u -r1.2 serial.h
--- include/asm-mips/lasat/serial.h	25 Feb 2003 22:39:02 -0000	1.2
+++ include/asm-mips/lasat/serial.h	10 Jul 2003 18:08:18 -0000
@@ -11,18 +11,3 @@
 #define LASAT_UART_REGS_BASE_200	(Vrc5074_PHYS_BASE + 0x0300)
 #define LASAT_UART_REGS_SHIFT_200	3
 #define LASATINT_UART_200		13
-
-#if defined(CONFIG_LASAT_100)
-#define LASAT_BASE_BAUD		LASAT_BASE_BAUD_200
-#define LASAT_UART_REGS_BASE	LASAT_UART_REGS_BASE_200
-#define LASAT_UART_REGS_SHIFT	LASAT_UART_REGS_SHIFT_200
-#define LASATINT_UART		LASAT_UART_REGS_SHIFT_200
-#elif defined(CONFIG_LASAT_200)
-#define LASAT_BASE_BAUD		LASAT_BASE_BAUD_200
-#define LASAT_UART_REGS_BASE	LASAT_UART_REGS_BASE_200
-#define LASAT_UART_REGS_SHIFT	LASAT_UART_REGS_SHIFT_200
-#define LASATINT_UART		LASAT_UART_REGS_SHIFT_200
-#else
-#error Select a Lasat board in the configuration menu
-#endif
-
