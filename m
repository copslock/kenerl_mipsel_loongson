Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2004 22:34:13 +0100 (BST)
Received: from [IPv6:::ffff:217.157.140.228] ([IPv6:::ffff:217.157.140.228]:2380
	"EHLO brian.localnet") by linux-mips.org with ESMTP
	id <S8225456AbUDGVeM>; Wed, 7 Apr 2004 22:34:12 +0100
Received: from brm by brian.localnet with local (Exim 3.36 #1 (Debian))
	id 1BBKgO-0001W0-00; Wed, 07 Apr 2004 23:34:05 +0200
To: ralf@linux-mips.org
Subject: [PATCH 2.5] LASAT updates
Cc: linux-mips@linux-mips.org
Message-Id: <E1BBKgO-0001W0-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Wed, 07 Apr 2004 23:34:05 +0200
Return-Path: <brm@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brm@murphy.dk
Precedence: bulk
X-list: linux-mips

Hi Ralf,
	this patch includes various cleanups and re-impliments pci support
for the Lasat platforms. It includes the machinfo patch I sent before.
It also includes a patch to allow an ethernet device to have irq 0 on 
lasat platforms. I have tried many times to get the network folk to accept
a patch but they don't even reply. Interrupt 0 is a very valid interrupt
for a pci device (255 means undefined) but on a pc 0 is always taken
by the timer so most bioses seem to be broken and set an undefined pci
interrupt to 0 and not to 255. Drivers such as pcnet impliment accordingly.
Anyway since there are CONFIG_LASAT hacks in pcnet32.c already it
should not be a big problem to have one more ;).

I found that I needed to set MAX_HWIFS to 2 in 
include/asm-mips/mach-generic/ide.h
The ide drivers take forever to time out the probe for the other 16 devices
which don't exist on a Lasat board. Is there an official way to disable this 
probing? Setting MAX_HWIFS does not seem possible except by hacking in this 
file.

With this patch the Lasat machines seem to have a reasonably stable 2.6.4
support (although crashme can create a process which cannot die without
a reset).
Thanks for the hard work guys - the last time I looked at 2.5 support it
barely booted.

/Brian

Index: arch/mips/lasat/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/Makefile,v
retrieving revision 1.9
diff -u -r1.9 Makefile
--- arch/mips/lasat/Makefile	19 Oct 2003 21:08:57 -0000	1.9
+++ arch/mips/lasat/Makefile	29 Oct 2003 18:10:07 -0000
@@ -7,7 +7,6 @@
 
 obj-$(CONFIG_LASAT_SYSCTL)	+= sysctl.o
 obj-$(CONFIG_DS1603)		+= ds1603.o
-obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_PICVUE)		+= picvue.o
 obj-$(CONFIG_PICVUE_PROC)	+= picvue_proc.o
 
Index: arch/mips/lasat/interrupt.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/interrupt.c,v
retrieving revision 1.9
diff -u -r1.9 interrupt.c
--- arch/mips/lasat/interrupt.c	18 Nov 2003 01:17:46 -0000	1.9
+++ arch/mips/lasat/interrupt.c	6 Apr 2004 20:57:35 -0000
@@ -33,7 +33,7 @@
 static volatile int *lasat_int_mask = NULL;
 static volatile int lasat_int_mask_shift;
 
-extern asmlinkage void mipsIRQ(void);
+extern asmlinkage void lasatIRQ(void);
 
 void disable_lasat_irq(unsigned int irq_nr)
 {
@@ -141,7 +141,6 @@
 		*lasat_int_mask = 0;
 		break;
 	case MACH_LASAT_200:
-		printk("**** MACH_LASAT_200 interrupt routines\n");
 		lasat_int_status = (void *)LASAT_INT_STATUS_REG_200;
 		lasat_int_mask = (void *)LASAT_INT_MASK_REG_200;
 		lasat_int_mask_shift = LASATINT_MASK_SHIFT_200;
@@ -153,7 +152,7 @@
 	}
 
 	/* Now safe to set the exception vector. */
-	set_except_vector(0, mipsIRQ);
+	set_except_vector(0, lasatIRQ);
 
 	for (i = 0; i <= LASATINT_END; i++) {
 		irq_desc[i].status	= IRQ_DISABLED;
Index: arch/mips/lasat/lasatIRQ.S
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/lasatIRQ.S,v
retrieving revision 1.4
diff -u -r1.4 lasatIRQ.S
--- arch/mips/lasat/lasatIRQ.S	18 Nov 2003 01:17:46 -0000	1.4
+++ arch/mips/lasat/lasatIRQ.S	26 Jan 2004 17:20:16 -0000
@@ -24,12 +24,13 @@
 
 	.text
 	.set	noreorder
-	.set	noat
 	.align	5
-	NESTED(mipsIRQ, PT_SIZE, sp)
+	NESTED(lasatIRQ, PT_SIZE, sp)
+	.set	noat
 	SAVE_ALL
 	CLI
 	.set	at
+	.set	noreorder
 
 	mfc0	s0, CP0_CAUSE		# get irq mask
 
@@ -39,9 +40,9 @@
 	 andi	a0, s0, CAUSEF_IP2	# delay slot, check hw0 interrupt
 
 	/* Wheee, a timer interrupt. */
-	move	a0, sp
-	jal	lasat_timer_interrupt
-	 nop
+	li	a0, 7
+	jal	ll_timer_interrupt
+	 move	a1, sp
 
 	j	ret_from_irq
 	 nop
@@ -65,4 +66,4 @@
 
 	j	ret_from_irq
 	 nop
-	END(mipsIRQ)
+	END(lasatIRQ)
Index: arch/mips/lasat/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/setup.c,v
retrieving revision 1.12
diff -u -r1.12 setup.c
--- arch/mips/lasat/setup.c	28 Jan 2004 22:16:39 -0000	1.12
+++ arch/mips/lasat/setup.c	5 Apr 2004 22:00:10 -0000
@@ -44,7 +44,6 @@
 #endif
 
 #include "ds1603.h"
-#include "at93c.h"
 #include <asm/lasat/ds1603.h>
 #include <asm/lasat/picvue.h>
 #include <asm/lasat/eeprom.h>
@@ -126,12 +125,6 @@
 	change_c0_status(ST0_IM, IE_IRQ0 | IE_IRQ5);
 }
 
-#define MIPS_CPU_TIMER_IRQ 7
-asmlinkage void lasat_timer_interrupt(struct pt_regs *regs)
-{
-	ll_timer_interrupt(MIPS_CPU_TIMER_IRQ, regs);
-}
-
 #define DYNAMIC_SERIAL_INIT
 #ifdef DYNAMIC_SERIAL_INIT
 void __init serial_init(void)
Index: arch/mips/lasat/image/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips/lasat/image/Makefile,v
retrieving revision 1.6
diff -u -r1.6 Makefile
--- arch/mips/lasat/image/Makefile	22 Jun 2003 02:19:24 -0000	1.6
+++ arch/mips/lasat/image/Makefile	30 Jan 2004 11:30:13 -0000
@@ -18,14 +18,15 @@
 
 LDSCRIPT= -L$(obj) -Tromscript.normal
 
-AFLAGS_head.o += -D_kernel_start=0x$(KERNEL_START) \
+HEAD_DEFINES := -D_kernel_start=0x$(KERNEL_START) \
 		-D_kernel_entry=0x$(KERNEL_ENTRY) \
 		-D VERSION="\"$(Version)\"" \
 		-D TIMESTAMP=$(shell date +%s) 
 
-head.o: $(KERNEL_IMAGE)
+$(obj)/head.o: $(obj)/head.S $(KERNEL_IMAGE)
+	$(CC) -fno-pic $(HEAD_DEFINES) -I$(TOPDIR)/include -c -o $@ $<
 
-obj-y = head.o kImage.o
+OBJECTS = head.o kImage.o
 
 rom.sw:	$(obj)/rom.sw
 
@@ -36,7 +37,7 @@
 	$(OBJCOPY) -O binary -S $^ $@
 
 # Rule to make the bootloader
-$(obj)/rom: $(addprefix $(obj)/,$(obj-y))
+$(obj)/rom: $(addprefix $(obj)/,$(OBJECTS))
 	$(LD) $(LDFLAGS) $(LDSCRIPT) -o $@ $^
 
 $(obj)/%.o: $(obj)/%.gz
Index: arch/mips/pci/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips/pci/Makefile,v
retrieving revision 1.13
diff -u -r1.13 Makefile
--- arch/mips/pci/Makefile	17 Mar 2004 17:24:38 -0000	1.13
+++ arch/mips/pci/Makefile	23 Mar 2004 21:23:01 -0000
@@ -24,6 +24,7 @@
 obj-$(CONFIG_DDB5476)		+= ops-ddb5476.o pci-ddb5476.o
 obj-$(CONFIG_DDB5477)		+= fixup-ddb5477.o pci-ddb5477.o ops-ddb5477.o
 obj-$(CONFIG_HP_LASERJET)	+= pci-hplj.o
+obj-$(CONFIG_LASAT)		+= pci-lasat.o fixup-lasat.o
 obj-$(CONFIG_MIPS_ATLAS)	+= fixup-atlas.o
 obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
 obj-$(CONFIG_MIPS_EV96100)	+= fixup-ev64120.o
Index: drivers/net/pcnet32.c
===================================================================
RCS file: /cvs/linux/drivers/net/pcnet32.c,v
retrieving revision 1.59
diff -u -r1.59 pcnet32.c
--- drivers/net/pcnet32.c	11 Mar 2004 16:46:51 -0000	1.59
+++ drivers/net/pcnet32.c	7 Apr 2004 19:56:05 -0000
@@ -1144,7 +1144,10 @@
     int i;
     int rc;
 
-    if (dev->irq == 0 ||
+    if (
+#ifndef CONFIG_LASAT
+        dev->irq == 0 ||
+#endif
 	request_irq(dev->irq, &pcnet32_interrupt,
 		    lp->shared_irq ? SA_SHIRQ : 0, lp->name, (void *)dev)) {
 	return -EAGAIN;
Index: include/asm-mips/bootinfo.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/bootinfo.h,v
retrieving revision 1.73
diff -u -r1.73 bootinfo.h
--- include/asm-mips/bootinfo.h	15 Mar 2004 07:55:26 -0000	1.73
+++ include/asm-mips/bootinfo.h	6 Apr 2004 19:46:13 -0000
@@ -200,8 +200,8 @@
  * Valid machtype for group LASAT
  */
 #define MACH_GROUP_LASAT       21
-#define  MACH_LASAT_100		1	/* Masquerade II/SP100/SP50/SP25 */
-#define  MACH_LASAT_200		2	/* Masquerade PRO/SP200 */
+#define  MACH_LASAT_100		0	/* Masquerade II/SP100/SP50/SP25 */
+#define  MACH_LASAT_200		1	/* Masquerade PRO/SP200 */
 
 /*
  * Valid machtype for group TITAN
--- /dev/null	2003-04-09 22:42:25.000000000 +0200
+++ arch/mips/pci/fixup-lasat.c	2003-11-17 20:37:45.000000000 +0100
@@ -0,0 +1,10 @@
+#include <linux/init.h>
+#include <linux/pci.h>
+
+void __init pcibios_fixup_irqs(void)
+{
+}
+
+struct pci_fixup pcibios_fixups[] __initdata = {
+    { 0 }
+};
--- /dev/null	2003-04-09 22:42:25.000000000 +0200
+++ arch/mips/pci/pci-lasat.c	2004-04-06 23:32:57.000000000 +0200
@@ -0,0 +1,89 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2000, 2001 Keith M Wesolowski
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <asm/pci_channel.h>
+#include <linux/delay.h>
+#include <asm/bootinfo.h>
+
+extern struct pci_ops nile4_pci_ops;
+extern struct pci_ops gt64120_pci_ops;
+static struct resource lasat_pci_mem_resource = {
+	.name	= "LASAT PCI MEM",
+	.start	= 0x18000000,
+	.end	= 0x19FFFFFF,
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct resource lasat_pci_io_resource = {
+	.name	= "LASAT PCI IO",
+	.start	= 0x1a000000,
+	.end	= 0x1bFFFFFF,
+	.flags	= IORESOURCE_IO,
+};
+
+static struct pci_controller lasat_pci_controller = {
+	.mem_resource	= &lasat_pci_mem_resource,
+	.io_resource	= &lasat_pci_io_resource,
+};
+
+static int __init lasat_pci_setup(void)
+{
+ 	printk("PCI: starting\n");
+
+        switch (mips_machtype) {
+            case MACH_LASAT_100:
+                lasat_pci_controller.pci_ops = &gt64120_pci_ops;
+                break;
+            case MACH_LASAT_200:
+                lasat_pci_controller.pci_ops = &nile4_pci_ops;
+                break;
+            default:
+                panic("pcibios_init: mips_machtype incorrect");
+        }
+
+	register_pci_controller(&lasat_pci_controller);
+        return 0;
+}
+early_initcall(lasat_pci_setup);
+
+#define LASATINT_ETH1   0
+#define LASATINT_ETH0   1
+#define LASATINT_HDC    2
+#define LASATINT_COMP   3
+#define LASATINT_HDLC   4
+#define LASATINT_PCIA   5
+#define LASATINT_PCIB   6
+#define LASATINT_PCIC   7
+#define LASATINT_PCID   8
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+    switch (slot) {
+        case 1:
+            return LASATINT_PCIA;   /* Expansion Module 0 */
+        case 2:
+            return LASATINT_PCIB;   /* Expansion Module 1 */
+        case 3:
+            return LASATINT_PCIC;   /* Expansion Module 2 */
+        case 4:
+            return LASATINT_ETH1;   /* Ethernet 1 (LAN 2) */
+        case 5:
+            return LASATINT_ETH0;   /* Ethernet 0 (LAN 1) */
+        case 6:
+            return LASATINT_HDC;    /* IDE controller */
+        default:
+            return 0xff;            /* Illegal */
+    }
+
+    return -1;
+}
--- arch/mips/lasat/pci.c	2004-04-07 23:09:38.000000000 +0200
+++ /dev/null	2003-04-09 22:42:25.000000000 +0200
@@ -1,25 +0,0 @@
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <asm/bootinfo.h>
-
-extern struct pci_ops nile4_pci_ops;
-extern struct pci_ops gt64120_pci_ops;
-
-void __init pcibios_init(void)
-{
-	struct pci_ops *pci_ops;
-
-	switch (mips_machtype) {
-	case MACH_LASAT_100:
-		pci_ops = &gt64120_pci_ops;
-		break;
-	case MACH_LASAT_200:
-		pci_ops = &nile4_pci_ops;
-		break;
-	default:
-		panic("pcibios_init: mips_machtype incorrect");
-	}
-
-	pci_scan_bus(0, pci_ops, NULL);
-}
