Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2004 22:12:13 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:30970 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225213AbUKKWMB>; Thu, 11 Nov 2004 22:12:01 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iABMBwdh013655;
	Thu, 11 Nov 2004 14:11:58 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iABMBw52013653;
	Thu, 11 Nov 2004 14:11:58 -0800
Date: Thu, 11 Nov 2004 14:11:57 -0800
From: Manish Lachwani <mlachwani@prometheus.mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Support for Toshiba TX4927 based board in 2.6.10
Message-ID: <20041111221157.GA13646@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@prometheus.mvista.com
Precedence: bulk
X-list: linux-mips


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf 

Attached patch implements support for Toshiba TX4927 based board in 
2.6.10. Please review ...

Thanks
Manish Lachwani


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_toshiba_tx4927_MR9019.patch"

Source: MontaVista Software, Inc. | http://www.mvista.com | Manish lachwani <mlachwani@mvista.com>
Type: Defect Fix
Disposition: Submitted to Linux-MIPS
Description:
	Support TX4927 board in 2.6.10

Index: linux/arch/mips/Makefile
===================================================================
--- linux.orig/arch/mips/Makefile
+++ linux/arch/mips/Makefile
@@ -159,6 +159,10 @@
 			$(call set_gccflags,r4600,mips3,r4600,mips3,mips2) \
 			-Wa,--trap
 
+cflags-$(CONFIG_CPU_TX49XX)	+= \
+			$(call set_gccflags,r4600,mips3,r4600,mips3,mips2)  \
+			-Wa,--trap
+
 cflags-$(CONFIG_CPU_MIPS32)	+= \
 			$(call set_gccflags,mips32,mips32,r4600,mips3,mips2) \
 			-Wa,--trap
Index: linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
===================================================================
--- linux.orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
+++ linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c
@@ -134,10 +134,10 @@
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
 #ifdef CONFIG_RTC_DS1742
-#include <asm/rtc_ds1742.h>
+#include <linux/ds1742rtc.h>
 #endif
 #ifdef CONFIG_TOSHIBA_FPCIB0
-#include <asm/smsc_fdc37m81x.h>
+#include <asm/tx4927/smsc_fdc37m81x.h>
 #endif
 #include <asm/tx4927/toshiba_rbtx4927.h>
 
@@ -681,13 +681,6 @@
 	}
 #endif
 
-#ifdef CONFIG_PCI
-	{
-		extern void toshiba_rbtx4927_pci_irq_init(void);
-		toshiba_rbtx4927_pci_irq_init();
-	}
-#endif
-
 	wbflush();
 
 	return;
Index: linux/drivers/char/serial_txx9.c
===================================================================
--- linux.orig/drivers/char/serial_txx9.c
+++ linux/drivers/char/serial_txx9.c
@@ -10,7 +10,10 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- *  Serial driver for TX3927/TX4927/TX4925/TX4938 internal SIO controller
+ * Serial driver for TX3927/TX4927/TX4925/TX4938 internal SIO controller
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Manish Lachwani, mlachwani@mvista.com
  */
 #include <linux/init.h>
 #include <linux/config.h>
@@ -34,6 +37,7 @@
 #ifdef CONFIG_MAGIC_SYSRQ
 #include <linux/sysrq.h>
 #endif
+#include <asm/irq.h>
 
 #define  DEBUG
 #ifdef  DEBUG
@@ -44,6 +48,7 @@
 
 static char *serial_version = "0.30-mvl";
 static char *serial_name = "TX39/49 Serial driver";
+static struct tty_driver *serial_driver;
 
 #define GS_INTERNAL_FLAGS (GS_TX_INTEN|GS_RX_INTEN|GS_ACTIVE)
 
@@ -734,7 +739,7 @@
 		return -EIO;
 	}
 
-	line = minor(tty->device) - tty->driver.minor_start;
+	line = tty->index;
 
 	if ((line < 0) || (line >= NR_PORTS))
 		return -ENODEV;
@@ -761,8 +766,6 @@
 	port->gs.flags |= GS_ACTIVE;
 
 	if (port->gs.count == 1) {
-		MOD_INC_USE_COUNT;
-
 		/*
 		 * Clear the FIFO buffers and disable them
 		 * (they will be reenabled in rs_set_real_termios())
@@ -781,7 +784,6 @@
 		if (retval) {
 			printk(KERN_ERR "serial_txx9: request_irq: err %d\n",
 			       retval);
-			MOD_DEC_USE_COUNT;
 			port->gs.count--;
 			return retval;
 		}
@@ -815,20 +817,15 @@
 	if (retval) {
 		if (port->gs.count == 1) {
 			free_irq(port->irq, port);
-			MOD_DEC_USE_COUNT;
 		}
 		port->gs.count--;
 		return retval;
 	}
 	/* tty->low_latency = 1; */
 
-	if ((port->gs.count == 1) && (port->gs.flags & ASYNC_SPLIT_TERMIOS)) {
-		if (tty->driver.subtype == SERIAL_TYPE_NORMAL)
-			*tty->termios = port->gs.normal_termios;
-		else
-			*tty->termios = port->gs.callout_termios;
+	if (port->gs.count == 1) 
 		rs_set_real_termios(port);
-	}
+
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
 	if (sercons.cflag && sercons.index == line) {
 		tty->termios->c_cflag = sercons.cflag;
@@ -836,8 +833,6 @@
 		rs_set_real_termios(port);
 	}
 #endif
-	port->gs.session = current->session;
-	port->gs.pgrp = current->pgrp;
 	return 0;
 }
 
@@ -931,7 +926,6 @@
 	struct rs_port *port = ptr;
 	free_irq(port->irq, port);
 #endif
-	MOD_DEC_USE_COUNT;
 }
 
 /* I haven't the foggiest why the decrement use count has to happen
@@ -943,7 +937,6 @@
    exit minicom.  I expect an "oops".  -- REW */
 static void rs_hungup (void *ptr)
 {
-	MOD_DEC_USE_COUNT;
 }
 
 static void rs_getserial (void *ptr, struct serial_struct *sp)
@@ -951,7 +944,7 @@
 	struct rs_port *port = ptr;
 	struct tty_struct *tty = port->gs.tty;
 	/* some applications (busybox, dbootstrap, etc.) look this */
-	sp->line = minor(tty->device) - tty->driver.minor_start;
+	sp->line = tty->index;
 }
 
 /*
@@ -1148,8 +1141,6 @@
 
 	port = rs_ports;
 	for (i=0; i < NR_PORTS;i++) {
-		port->gs.callout_termios = tty_std_termios;
-		port->gs.normal_termios	= tty_std_termios;
 		port->gs.magic = TXX9_SERIAL_MAGIC;
 		port->gs.close_delay = HZ/2;
 		port->gs.closing_wait = 30 * HZ;
@@ -1188,7 +1179,6 @@
 	rs_driver.init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	rs_driver.refcount = &rs_refcount;
-	rs_driver.table = rs_table;
 	rs_driver.termios = rs_termios;
 	rs_driver.termios_locked = rs_termios_locked;
 
@@ -1216,24 +1206,12 @@
 #else
 	rs_callout_driver.name = TXX9_CU_NAME;
 #endif
-	rs_callout_driver.major = TXX9_TTYAUX_MAJOR;
-	rs_callout_driver.subtype = SERIAL_TYPE_CALLOUT;
-	rs_callout_driver.read_proc = 0;
-	rs_callout_driver.proc_entry = 0;
-
 	if ((error = tty_register_driver(&rs_driver))) {
 		printk(KERN_ERR
 		       "Couldn't register serial driver, error = %d\n",
 		       error);
 		return 1;
 	}
-	if ((error = tty_register_driver(&rs_callout_driver))) {
-		tty_unregister_driver(&rs_driver);
-		printk(KERN_ERR
-		       "Couldn't register callout driver, error = %d\n",
-		       error);
-		return 1;
-	}
 
 	return 0;
 }
@@ -1532,16 +1510,17 @@
 	sio_out(port, TXX9_SIDICR, ier);
 }
 
-static kdev_t serial_console_device(struct console *c)
+static struct tty_driver *serial_console_device(struct console *c, int *index)
 {
-	return mk_kdev(TXX9_TTY_MAJOR, TXX9_TTY_MINOR_START + c->index);
+	*index = c->index;
+	return &rs_driver;
 }
 
-static __init int serial_console_setup(struct console *co, char *options)
+static int serial_console_setup(struct console *co, char *options)
 {
 	struct rs_port *port;
 	unsigned cval;
-	int	baud = 9600;
+	int	baud = 9600; 
 	int	bits = 8;
 	int	parity = 'n';
 	int	doflow = 0;
@@ -1643,11 +1622,15 @@
 	index:		-1,
 };
 
-void __init txx9_serial_console_init(void)
+static int __init txx9_serial_console_init(void)
 {
 	register_console(&sercons);
+
+	return 0;
 }
 
+console_initcall(txx9_serial_console_init);
+
 #endif
 
 /******************************************************************************/
@@ -1656,9 +1639,7 @@
 
 #ifdef CONFIG_KGDB
 int kgdb_init_count = 0;
-#endif
 
-#ifdef CONFIG_KGDB
 void txx9_sio_kgdb_hook(unsigned int port, unsigned int baud_rate)
 {
 	static struct resource kgdb_resource;
@@ -1676,9 +1657,6 @@
 
 	return;
 }
-#endif /* CONFIG_KGDB */
-
-#ifdef CONFIG_KGDB
 void
 txx9_sio_kdbg_init( unsigned int port_number )
 {
@@ -1689,9 +1667,7 @@
   }
   return; 
 }
-#endif /* CONFIG_KGDB */
 
-#ifdef CONFIG_KGDB
 u8 
 txx9_sio_kdbg_rd( void )
 {
@@ -1715,10 +1691,7 @@
 
   return( ch );
 }
-#endif /* CONFIG_KGDB */
 
-
-#ifdef CONFIG_KGDB
 int 
 txx9_sio_kdbg_wr( u8 ch )
 {
Index: linux/arch/mips/Kconfig
===================================================================
--- linux.orig/arch/mips/Kconfig
+++ linux/arch/mips/Kconfig
@@ -848,9 +848,18 @@
 	bool "Support for Toshiba TBTX49[23]7 board"
 	depends on MIPS32
 	select DMA_NONCOHERENT
-	select HW_HAS_PCI
 	select ISA
 	select SWAP_IO_SPACE
+	select HW_HAS_PCI
+	select PCI
+	select I8259
+	help
+	  This Toshiba board is based on the TX4927 processor. Say Y here to
+	  support this machine type
+
+config TOSHIBA_FPCIB0
+	bool "FPCIB0 Backplane Support"
+	depends on TOSHIBA_RBTX4927
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
Index: linux/include/asm-mips/tx4927/smsc_fdc37m81x.h
===================================================================
--- /dev/null
+++ linux/include/asm-mips/tx4927/smsc_fdc37m81x.h
@@ -0,0 +1,72 @@
+/*
+ * linux/include/asm-mips/tx4927/smsc_fdc37m81x.h
+ *
+ * Interface for smsc fdc48m81x Super IO chip
+ *
+ * Author: MontaVista Software, Inc. source@mvista.com
+ *
+ * 2001-2003 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Manish Lachwani, mlachwani@mvista.com
+ */
+
+#ifndef _SMSC_FDC37M81X_H_
+#define _SMSC_FDC37M81X_H_
+
+/* Common Registers */
+#define SMSC_FDC37M81X_CONFIG_INDEX  0x00
+#define SMSC_FDC37M81X_CONFIG_DATA   0x01
+#define SMSC_FDC37M81X_CONF          0x02
+#define SMSC_FDC37M81X_INDEX         0x03
+#define SMSC_FDC37M81X_DNUM          0x07
+#define SMSC_FDC37M81X_DID           0x20
+#define SMSC_FDC37M81X_DREV          0x21
+#define SMSC_FDC37M81X_PCNT          0x22
+#define SMSC_FDC37M81X_PMGT          0x23
+#define SMSC_FDC37M81X_OSC           0x24
+#define SMSC_FDC37M81X_CONFPA0       0x26
+#define SMSC_FDC37M81X_CONFPA1       0x27
+#define SMSC_FDC37M81X_TEST4         0x2B
+#define SMSC_FDC37M81X_TEST5         0x2C
+#define SMSC_FDC37M81X_TEST1         0x2D
+#define SMSC_FDC37M81X_TEST2         0x2E
+#define SMSC_FDC37M81X_TEST3         0x2F
+
+/* Logical device numbers */
+#define SMSC_FDC37M81X_FDD           0x00
+#define SMSC_FDC37M81X_PARALLEL      0x03
+#define SMSC_FDC37M81X_SERIAL1       0x04
+#define SMSC_FDC37M81X_SERIAL2       0x05
+#define SMSC_FDC37M81X_KBD           0x07
+#define SMSC_FDC37M81X_AUXIO         0x08
+#define SMSC_FDC37M81X_NONE          0xff
+
+/* Logical device Config Registers */
+#define SMSC_FDC37M81X_ACTIVE        0x30
+#define SMSC_FDC37M81X_BASEADDR0     0x60
+#define SMSC_FDC37M81X_BASEADDR1     0x61
+#define SMSC_FDC37M81X_INT           0x70
+#define SMSC_FDC37M81X_INT2          0x72
+#define SMSC_FDC37M81X_LDCR_F0       0xF0
+
+/* Chip Config Values */
+#define SMSC_FDC37M81X_CONFIG_ENTER  0x55
+#define SMSC_FDC37M81X_CONFIG_EXIT   0xaa
+#define SMSC_FDC37M81X_CHIP_ID       0x4d
+
+unsigned long __init smsc_fdc37m81x_init(unsigned long port);
+
+void
+ smsc_fdc37m81x_config_beg(void);
+
+void
+ smsc_fdc37m81x_config_end(void);
+
+void
+ smsc_fdc37m81x_config_set(u8 reg, u8 val);
+
+#endif
Index: linux/arch/mips/pci/fixup-rbtx4927.c
===================================================================
--- linux.orig/arch/mips/pci/fixup-rbtx4927.c
+++ linux/arch/mips/pci/fixup-rbtx4927.c
@@ -9,6 +9,9 @@
  *
  * Copyright (C) 2000-2001 Toshiba Corporation 
  *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Manish Lachwani (mlachwani@mvista.com)
+ *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
  *  Free Software Foundation;  either version 2 of the  License, or (at your
@@ -115,59 +118,28 @@
 	DBG("assigned irq %d\n", irq);
 	return irq;
 }
-
-
-#ifdef  TX4927_SUPPORT_PCI_66
-extern int tx4927_pci66;
-extern void tx4927_pci66_setup(void);
-#endif
-extern void tx4927_pci_setup(void);
-
-#ifdef  TX4927_SUPPORT_PCI_66
-int tx4927_pci66_check(void)
-{
-	struct pci_dev *dev;
-	unsigned short stat;
-	int cap66 = 1;
-
-	if (tx4927_pci66 < 0)
-		return 0;
-
-	/* check 66MHz capability */
-	pci_for_each_dev(dev) {
-		if (cap66) {
-			pci_read_config_word(dev, PCI_STATUS, &stat);
-			if (!(stat & PCI_STATUS_66MHZ)) {
-				printk(KERN_INFO
-				       "PCI: %02x:%02x not 66MHz capable.\n",
-				       dev->bus->number, dev->devfn);
-				cap66 = 0;
-			}
-		}
-	}
-	return cap66;
-}
-#endif
-
 /*
  * This is dead, rotten code, needs to be rewritten -- Ralf
  */
 int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
+	unsigned int id; 
 	unsigned char irq;
 
-#ifdef  TX4927_SUPPORT_PCI_66	/* Has no f*cking biz here  */
-	if (tx4927_pci66_check()) {
-		tx4927_pci66_setup();
-		tx4927_pci_setup();	/* Reinitialize PCIC */
-	}
-#endif
+	printk("PCI Setup for pin %d \n", pin);
 
-	if (dev->vendor == PCI_VENDOR_ID_EFAR &&
-	    dev->device == PCI_DEVICE_ID_EFAR_SLC90E66_1)
+	pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
+	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+
+	if (id == 0x91301055) {
 		irq = 14;
-	else
-		irq = 0;
+	}
+
+	if (irq == 0)  {
+		irq = pci_get_irq(dev, pin);
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
+	}
 
 	return irq;
 }
Index: linux/arch/mips/tx4927/common/Makefile
===================================================================
--- linux.orig/arch/mips/tx4927/common/Makefile
+++ linux/arch/mips/tx4927/common/Makefile
@@ -8,4 +8,5 @@
 
 obj-y	+= tx4927_prom.o tx4927_setup.o tx4927_irq.o tx4927_irq_handler.o
 
+obj-$(CONFIG_TOSHIBA_FPCIB0)	   += smsc_fdc37m81x.o
 obj-$(CONFIG_KGDB)                 += tx4927_dbgio.o
Index: linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
===================================================================
--- linux.orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
+++ linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_prom.c
@@ -6,6 +6,9 @@
  *
  * Copyright 2001-2002 MontaVista Software Inc.
  *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Manish Lachwani, mlachwani@mvista.com
+ *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
  *  Free Software Foundation; either version 2 of the License, or (at your
@@ -86,3 +89,9 @@
 {
 	return "Toshiba RBTX4927/RBTX4937";
 }
+
+char * __init prom_getcmdline(void)
+{
+        return &(arcs_cmdline[0]);
+}
+
Index: linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
===================================================================
--- linux.orig/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
+++ linux/arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c
@@ -17,7 +17,10 @@
  * Copyright 2002 MontaVista Software Inc.
  * Author: Michael Pruznick, michael_pruznick@mvista.com
  *
- * Copyright (C) 2000-2001 Toshiba Corporation 
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Manish Lachwani, mlachwani@mvista.com
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -61,10 +64,10 @@
 #include <linux/bootmem.h>
 #include <linux/blkdev.h>
 #ifdef CONFIG_RTC_DS1742
-#include <asm/rtc_ds1742.h>
+#include <linux/ds1742rtc.h>
 #endif
 #ifdef CONFIG_TOSHIBA_FPCIB0
-#include <asm/smsc_fdc37m81x.h>
+#include <asm/tx4927/smsc_fdc37m81x.h>
 #endif
 #include <asm/tx4927/toshiba_rbtx4927.h>
 #ifdef CONFIG_PCI
@@ -145,49 +148,15 @@
 unsigned long tx4927_ce_base[8];
 void tx4927_pci_setup(void);
 void tx4927_reset_pci_pcic(void);
-#ifdef  TX4927_SUPPORT_PCI_66
-void tx4927_pci66_setup(void);
-extern int tx4927_pci66_check(void);
-#endif
 int tx4927_pci66 = 0;		/* 0:auto */
 #endif
 
 char *toshiba_name = "";
 
 #ifdef CONFIG_PCI
-void tx4927_dump_pcic_settings(void)
-{
-	printk("%s pcic settings:",toshiba_name);
-	{
-		int i;
-		unsigned long *preg = (unsigned long *) tx4927_pcicptr;
-		for (i = 0; i < sizeof(struct tx4927_pcic_reg); i += 4) {
-			if (i % 32 == 0)
-				printk("\n%04x:", i);
-			if (preg == &tx4927_pcicptr->g2pintack
-			    || preg == &tx4927_pcicptr->g2pspc
-#ifdef CONFIG_TX4927BUG_WORKAROUND
-			    || preg == &tx4927_pcicptr->g2pcfgadrs
-			    || preg == &tx4927_pcicptr->g2pcfgdata
-#endif
-			    ) {
-				printk(" XXXXXXXX");
-				preg++;
-				continue;
-			}
-			printk(" %08lx", *preg++);
-			if (preg == &tx4927_pcicptr->g2pcfgadrs)
-				break;
-		}
-		printk("\n");
-	}
-}
-
 static void tx4927_pcierr_interrupt(int irq, void *dev_id,
 				    struct pt_regs *regs)
 {
-	extern void tx4927_dump_pcic_settings(void);
-
 #ifdef CONFIG_BLK_DEV_IDEPCI
 	/* ignore MasterAbort for ide probing... */
 	if (irq == TX4927_IRQ_IRC_PCIERR &&
@@ -202,6 +171,7 @@
 	}
 #endif
 	printk("PCI error interrupt (irq 0x%x).\n", irq);
+
 	printk("pcistat:%04x, g2pstatus:%08lx, pcicstatus:%08lx\n",
 	       (unsigned short) (tx4927_pcicptr->pcistatus >> 16),
 	       tx4927_pcicptr->g2pstatus, tx4927_pcicptr->pcicstatus);
@@ -210,23 +180,10 @@
 	       (unsigned long) (tx4927_ccfgptr->tear >> 32),
 	       (unsigned long) tx4927_ccfgptr->tear);
 	show_regs(regs);
-	//tx4927_dump_pcic_settings();
-	panic("PCI error at PC:%08lx.", regs->cp0_epc);
 }
 
-static struct irqaction pcic_action = {
-	tx4927_pcierr_interrupt, 0, 0, "PCI-C", NULL, NULL
-};
-
-static struct irqaction pcierr_action = {
-	tx4927_pcierr_interrupt, 0, 0, "PCI-ERR", NULL, NULL
-};
-
-
 void __init toshiba_rbtx4927_pci_irq_init(void)
 {
-	setup_irq(TX4927_IRQ_IRC_PCIC, &pcic_action);
-	setup_irq(TX4927_IRQ_IRC_PCIERR, &pcierr_action);
 	return;
 }
 
@@ -244,91 +201,26 @@
 #endif /* CONFIG_PCI */
 
 #ifdef CONFIG_PCI
-#ifdef  TX4927_SUPPORT_PCI_66
-void tx4927_pci66_setup(void)
-{
-	int pciclk, pciclkin = 1;
-
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI66,
-				       "-\n");
-
-	if (tx4927_ccfgptr->ccfg & TX4927_CCFG_PCI66)
-		return;
-
-	tx4927_reset_pci_pcic();
-
-	/* Assert M66EN */
-	tx4927_ccfgptr->ccfg |= TX4927_CCFG_PCI66;
-	/* set PCICLK 66MHz */
-	if (tx4927_ccfgptr->pcfg & TX4927_PCFG_PCICLKEN_ALL) {
-		unsigned int pcidivmode = 0;
-		pcidivmode =
-		    (unsigned long) tx4927_ccfgptr->
-		    ccfg & TX4927_CCFG_PCIDIVMODE_MASK;
-		if (tx4927_cpu_clock >= 170000000) {
-			/* CPU 200MHz */
-			pcidivmode = TX4927_CCFG_PCIDIVMODE_3;
-			pciclk = tx4927_cpu_clock / 3;
-		} else {
-			/* CPU 166MHz */
-			pcidivmode = TX4927_CCFG_PCIDIVMODE_2_5;
-			pciclk = tx4927_cpu_clock * 2 / 5;
-		}
-		tx4927_ccfgptr->ccfg =
-		    (tx4927_ccfgptr->ccfg & ~TX4927_CCFG_PCIDIVMODE_MASK)
-		    | pcidivmode;
-		TOSHIBA_RBTX4927_SETUP_DPRINTK
-		    (TOSHIBA_RBTX4927_SETUP_PCI66,
-		     ":PCICLK: ccfg:0x%08lx\n",
-		     (unsigned long) tx4927_ccfgptr->ccfg);
-	} else {
-		int pciclk_setting = *tx4927_pci_clk_ptr;
-		pciclkin = 0;
-		pciclk = 66666666;
-		pciclk_setting &= ~TX4927_PCI_CLK_MASK;
-		pciclk_setting |= TX4927_PCI_CLK_66;
-		*tx4927_pci_clk_ptr = pciclk_setting;
-		TOSHIBA_RBTX4927_SETUP_DPRINTK
-		    (TOSHIBA_RBTX4927_SETUP_PCI66,
-		     "PCICLK: pci_clk:%02x\n", *tx4927_pci_clk_ptr);
-	}
-
-	udelay(10000);
-
-	/* clear PCIC reset */
-	tx4927_ccfgptr->clkctr &= ~TX4927_CLKCTR_PCIRST;
-	/* clear PCI reset */
-	*tx4927_pcireset_ptr = 0;
-
-	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI66,
-				       "+\n");
-	return;
-}
-#endif				/* TX4927_SUPPORT_PCI_66 */
-
 void print_pci_status(void)
 {
 	printk("PCI STATUS %lx\n", tx4927_pcicptr->pcistatus);
 	printk("PCIC STATUS %lx\n", tx4927_pcicptr->pcicstatus);
 }
 
+extern struct pci_controller tx4927_controller;
+
 static struct pci_dev *fake_pci_dev(struct pci_controller *hose,
 				    int top_bus, int busnr, int devfn)
 {
 	static struct pci_dev dev;
 	static struct pci_bus bus;
 
-	dev.bus = &bus;
-	dev.sysdata = hose;
+	dev.sysdata = (void *)hose;
 	dev.devfn = devfn;
 	bus.number = busnr;
 	bus.ops = hose->pci_ops;
-
-	if (busnr != top_bus)
-		/* Fake a parent bus structure. */
-		bus.parent = &bus;
-	else
-		bus.parent = NULL;
+	bus.parent = NULL;
+	dev.bus = &bus;
 
 	return &dev;
 }
@@ -349,15 +241,19 @@
 EARLY_PCI_OP(write, word, u16)
 EARLY_PCI_OP(write, dword, u32)
 
-static int __init tx4927_pcibios_init(int busno, struct pci_controller *hose)
+static int __init tx4927_pcibios_init(void)
 {
 	unsigned int id;
 	u32 pci_devfn;
+	int devfn_start = 0;
+	int devfn_stop = 0xff;
+	int busno = 0; /* One bus on the Toshiba */
+	struct pci_controller *hose = &tx4927_controller;
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCIBIOS,
 				       "-\n");
 
-	for (pci_devfn = 0x0; pci_devfn < 0xff; pci_devfn++) {
+	for (pci_devfn = devfn_start; pci_devfn < devfn_stop; pci_devfn++) {
 		early_read_config_dword(hose, busno, busno, pci_devfn,
 					PCI_VENDOR_ID, &id);
 
@@ -580,12 +476,15 @@
 
 	}
 
+	register_pci_controller(&tx4927_controller);
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCIBIOS,
 				       "+\n");
 
-	return busno;
+	return 0;
 }
 
+arch_initcall(tx4927_pcibios_init);
+
 extern struct resource pci_io_resource;
 extern struct resource pci_mem_resource;
 
@@ -596,11 +495,6 @@
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2, "-\n");
 
-#ifndef  TX4927_SUPPORT_PCI_66
-	if (tx4927_ccfgptr->ccfg & TX4927_CCFG_PCI66)
-		printk("PCI 66 current unsupported\n");
-#endif
-
 	mips_memory_upper = tx4927_get_mem_size() << 20;
 	mips_memory_upper += KSEG0;
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
@@ -735,19 +629,6 @@
 	/* PCI->GB mappings (I/O 256B) */
 	tx4927_pcicptr->p2giopbase = 0;	/* 256B */
 
-
-#ifdef TX4927_SUPPORT_COMMAND_IO
-	tx4927_pcicptr->p2giogbase = 0 | TX4927_PCIC_P2GIOGBASE_TIOEN |
-#ifdef __BIG_ENDIAN
-	    TX4927_PCIC_P2GIOGBASE_TECHG
-#else
-	    TX4927_PCIC_P2GIOGBASE_TBSDIS
-#endif
-	    ;
-#else
-	tx4927_pcicptr->p2giogbase = 0;
-#endif
-
 	/* PCI->GB mappings (MEM 512MB) M0 gets all of memory */
 	tx4927_pcicptr->p2gm0plbase = 0;
 	tx4927_pcicptr->p2gm0pubase = 0;
@@ -790,8 +671,6 @@
 	if (tx4927_pcic_trdyto >= 0) {
 		tx4927_pcicptr->g2ptocnt &= ~0xff;
 		tx4927_pcicptr->g2ptocnt |= (tx4927_pcic_trdyto & 0xff);
-		//printk("%s PCIC -- TRDYTO:%02lx\n",toshiba_name,
-		//      tx4927_pcicptr->g2ptocnt & 0xff);
 	}
 
 	/* Clear All Local Bus Status */
@@ -824,17 +703,10 @@
 
 	tx4927_pcicptr->pcistatus = PCI_COMMAND_MASTER |
 	    PCI_COMMAND_MEMORY |
-#ifdef TX4927_SUPPORT_COMMAND_IO
-	    PCI_COMMAND_IO |
-#endif
 	    PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2,
 				       ":pci setup complete:\n");
-	//tx4927_dump_pcic_settings();
-
-	tx4927_pcibios_init(0, &tx4927_controller);
-
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_PCI2, "+\n");
 }
 
@@ -882,6 +754,7 @@
 void __init toshiba_rbtx4927_setup(void)
 {
 	vu32 cp0_config;
+	char *argptr;
 
 	printk("CPU is %s\n", toshiba_name);
 
@@ -922,21 +795,16 @@
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
 				       "+\n");
 
-
-
-	mips_io_port_base = KSEG1 + TBTX4927_ISA_IO_OFFSET;
+	set_io_port_base(KSEG1 + TBTX4927_ISA_IO_OFFSET);
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
 				       ":mips_io_port_base=0x%08lx\n",
 				       mips_io_port_base);
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
 				       ":Resource\n");
-	ioport_resource.start = 0;
 	ioport_resource.end = 0xffffffff;
-	iomem_resource.start = 0;
 	iomem_resource.end = 0xffffffff;
 
-
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
 				       ":ResetRoutines\n");
 	_machine_restart = toshiba_rbtx4927_restart;
@@ -999,25 +867,11 @@
 		tx4927_sdramcptr->tr |= 0x02000000;	/* RCD:3tck */
 #endif
 
-#ifdef  TX4927_SUPPORT_PCI_66
-	tx4927_pci66_setup();
-#endif
-
 	tx4927_pci_setup();
-#endif
-
-
-	{
-		u32 id = 0;
-		early_read_config_dword(&tx4927_controller, 0, 0, 0x90,
-					PCI_VENDOR_ID, &id);
-		if (id == 0x94601055) {
-			tx4927_using_backplane = 1;
-			printk("backplane board IS installed\n");
-		} else {
-			printk("backplane board NOT installed\n");
-		}
-	}
+	if (tx4927_using_backplane == 1)
+		printk("backplane board IS installed\n");
+	else
+		printk("No Backplane \n");
 
 	/* this is on ISA bus behind PCI bus, so need PCI up first */
 #ifdef CONFIG_TOSHIBA_FPCIB0
@@ -1064,11 +918,41 @@
 	}
 #endif
 
+#endif /* CONFIG_PCI */
+
+#ifdef CONFIG_SERIAL_TXX9_CONSOLE
+        argptr = prom_getcmdline();
+        if (strstr(argptr, "console=") == NULL) {
+                strcat(argptr, " console=ttyS0,38400");
+        }
+#endif
+
+#ifdef CONFIG_ROOT_NFS
+        argptr = prom_getcmdline();
+        if (strstr(argptr, "root=") == NULL) {
+                strcat(argptr, " root=/dev/nfs rw");
+        }
+#endif
+
+
+#ifdef CONFIG_IP_PNP
+        argptr = prom_getcmdline();
+        if (strstr(argptr, "ip=") == NULL) {
+                strcat(argptr, " ip=any");
+        }
+#endif
+
 
 	TOSHIBA_RBTX4927_SETUP_DPRINTK(TOSHIBA_RBTX4927_SETUP_SETUP,
-				       "+\n");
+			       "+\n");
 }
 
+#ifdef CONFIG_RTC_DS1742
+extern unsigned long rtc_ds1742_get_time(void);
+extern int rtc_ds1742_set_time(unsigned long);
+extern void rtc_ds1742_wait(void);
+#endif
+
 void __init
 toshiba_rbtx4927_time_init(void)
 {
Index: linux/arch/mips/pci/ops-tx4927.c
===================================================================
--- linux.orig/arch/mips/pci/ops-tx4927.c
+++ linux/arch/mips/pci/ops-tx4927.c
@@ -13,6 +13,9 @@
  * Much of the code is derived from the original DDB5074 port by 
  * Geert Uytterhoeven <geert@sonycom.com>
  *
+ * Copyright 2004 MontaVista Software Inc.
+ * Author: Manish Lachwani (mlachwani@mvista.com)
+ *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
  *  Free Software Foundation;  either version 2 of the  License, or (at your
@@ -44,33 +47,21 @@
 
 /* initialize in setup */
 struct resource pci_io_resource = {
-	"pci IO space",
-	(PCIBIOS_MIN_IO),
-	((PCIBIOS_MIN_IO) + (TX4927_PCIIO_SIZE)) - 1,
-	IORESOURCE_IO
+	.name	= "TX4927 PCI IO SPACE",
+	.start	= 0x1000,
+	.end	= (0x1000 + (TX4927_PCIIO_SIZE)) - 1,
+	.flags	= IORESOURCE_IO
 };
 
 /* initialize in setup */
 struct resource pci_mem_resource = {
-	"pci memory space",
-	TX4927_PCIMEM,
-	TX4927_PCIMEM + TX4927_PCIMEM_SIZE - 1,
-	IORESOURCE_MEM
-};
-
-extern struct pci_ops tx4927_pci_ops;
-
-/*
- * h/w only supports devices 0x00 to 0x14
- */
-struct pci_controller tx4927_controller = {
-	.pci_ops	= &tx4927_pci_ops,
-	.io_resource	= &pci_io_resource,
-	.mem_resource	= &pci_mem_resource,
+	.name	= "TX4927 PCI MEM SPACE",
+	.start	= TX4927_PCIMEM,
+	.end	= TX4927_PCIMEM + TX4927_PCIMEM_SIZE - 1,
+	.flags	= IORESOURCE_MEM
 };
 
-static int mkaddr(unsigned char bus, unsigned char dev_fn,
-	unsigned char where, int *flagsp)
+static int mkaddr(int bus, int dev_fn, int where, int *flagsp)
 {
 	if (bus > 0) {
 		/* Type 1 configuration */
@@ -107,107 +98,49 @@
 	return code;
 }
 
-/*
- * We can't address 8 and 16 bit words directly.  Instead we have to
- * read/write a 32bit word and mask/modify the data we actually want.
- */
-static int tx4927_pcibios_read_config_byte(struct pci_dev *dev,
-					   int where, unsigned char *val)
+static int tx4927_pcibios_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+		int size, u32 * val)
 {
-	int flags, retval;
-	unsigned char bus, func_num;
+	int flags, retval, dev, busno, func;
 
-	db_assert((where & 3) == 0);
-	db_assert(where < (1 << 8));
+	busno = bus->number;
+        dev = PCI_SLOT(devfn);
+        func = PCI_FUNC(devfn);
 
-	/* check if the bus is top-level */
-	if (dev->bus->parent != NULL) {
-		bus = dev->bus->number;
-		db_assert(bus != 0);
-	} else {
-		bus = 0;
+	if (size == 2) {
+		if (where & 1)
+	                return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
-	func_num = PCI_FUNC(dev->devfn);
-	if (mkaddr(bus, dev->devfn, where, &flags))
-		return -1;
-#ifdef __BIG_ENDIAN
-	*val =
-	    *(volatile u8 *) ((ulong) & tx4927_pcicptr->
-			      g2pcfgdata | ((where & 3) ^ 3));
-#else
-	*val =
-	    *(volatile u8 *) ((ulong) & tx4927_pcicptr->
-			      g2pcfgdata | (where & 3));
-#endif
-	retval = check_abort(flags);
-	if (retval == PCIBIOS_DEVICE_NOT_FOUND)
-		*val = 0xff;
-	return retval;
-}
-
-static int tx4927_pcibios_read_config_word(struct pci_dev *dev,
-					   int where, unsigned short *val)
-{
-	int flags, retval;
-	unsigned char bus, func_num;
-
-	if (where & 1)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	db_assert((where & 3) == 0);
-	db_assert(where < (1 << 8));
+	if (size == 4) {
+		if (where & 3)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
 
 	/* check if the bus is top-level */
-	if (dev->bus->parent != NULL) {
-		bus = dev->bus->number;
-		db_assert(bus != 0);
+	if (bus->parent != NULL) {
+		busno = bus->number;
 	} else {
-		bus = 0;
+		busno = 0;
 	}
 
-	func_num = PCI_FUNC(dev->devfn);
-	if (mkaddr(bus, dev->devfn, where, &flags))
+	if (mkaddr(busno, devfn, where, &flags))
 		return -1;
-#ifdef __BIG_ENDIAN
-	*val =
-	    *(volatile u16 *) ((ulong) & tx4927_pcicptr->
-			       g2pcfgdata | ((where & 3) ^ 2));
-#else
-	*val =
-	    *(volatile u16 *) ((ulong) & tx4927_pcicptr->
-			       g2pcfgdata | (where & 3));
-#endif
-	retval = check_abort(flags);
-	if (retval == PCIBIOS_DEVICE_NOT_FOUND)
-		*val = 0xffff;
-	return retval;
-}
-
-static int tx4927_pcibios_read_config_dword(struct pci_dev *dev,
-					    int where, unsigned int *val)
-{
-	int flags, retval;
-	unsigned char bus, func_num;
 
-	if (where & 3)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	db_assert((where & 3) == 0);
-	db_assert(where < (1 << 8));
-
-	/* check if the bus is top-level */
-	if (dev->bus->parent != NULL) {
-		bus = dev->bus->number;
-		db_assert(bus != 0);
-	} else {
-		bus = 0;
+	switch (size) {
+	case 1:
+		*val = *(volatile u8 *) ((ulong) & tx4927_pcicptr->
+                              g2pcfgdata | (where & 3));
+		break;
+	case 2:
+		*val = *(volatile u16 *) ((ulong) & tx4927_pcicptr->
+                               g2pcfgdata | (where & 3));
+		break;
+	case 4:
+		*val = tx4927_pcicptr->g2pcfgdata;
+		break;
 	}
 
-	func_num = PCI_FUNC(dev->devfn);
-	if (mkaddr(bus, dev->devfn, where, &flags))
-		return -1;
-	*val = tx4927_pcicptr->g2pcfgdata;
 	retval = check_abort(flags);
 	if (retval == PCIBIOS_DEVICE_NOT_FOUND)
 		*val = 0xffffffff;
@@ -215,92 +148,62 @@
 	return retval;
 }
 
-static int tx4927_pcibios_write_config_byte(struct pci_dev *dev,
-					    int where, unsigned char val)
+static int tx4927_pcibios_write_config(struct pci_bus *bus, unsigned int devfn, int where,
+				int size, u32 val)
 {
-	int flags;
-	unsigned char bus, func_num;
+	int flags, dev, busno, func;
+	busno = bus->number;
+        dev = PCI_SLOT(devfn);
+        func = PCI_FUNC(devfn);
 
-	/* check if the bus is top-level */
-	if (dev->bus->parent != NULL) {
-		bus = dev->bus->number;
-		db_assert(bus != 0);
-	} else {
-		bus = 0;
+	if (size == 1) {
+		if (where & 1)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
-	func_num = PCI_FUNC(dev->devfn);
-	if (mkaddr(bus, dev->devfn, where, &flags))
-		return -1;
-#ifdef __BIG_ENDIAN
-	*(volatile u8 *) ((ulong) & tx4927_pcicptr->
-			  g2pcfgdata | ((where & 3) ^ 3)) = val;
-#else
-	*(volatile u8 *) ((ulong) & tx4927_pcicptr->
-			  g2pcfgdata | (where & 3)) = val;
-#endif
-	return check_abort(flags);
-}
-
-static int tx4927_pcibios_write_config_word(struct pci_dev *dev,
-					    int where, unsigned short val)
-{
-	int flags;
-	unsigned char bus, func_num;
-
-	if (where & 1)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
+	if (size == 4) {
+		if (where & 3)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
 
 	/* check if the bus is top-level */
-	if (dev->bus->parent != NULL) {
-		bus = dev->bus->number;
-		db_assert(bus != 0);
+	if (bus->parent != NULL) {
+		busno = bus->number;
 	} else {
-		bus = 0;
+		busno = 0;
 	}
 
-	func_num = PCI_FUNC(dev->devfn);
-	if (mkaddr(bus, dev->devfn, where, &flags))
+	if (mkaddr(busno, devfn, where, &flags))
 		return -1;
-#ifdef __BIG_ENDIAN
-	*(volatile u16 *) ((ulong) & tx4927_pcicptr->
-			   g2pcfgdata | ((where & 3) ^ 2)) = val;
-#else
-	*(volatile u16 *) ((ulong) & tx4927_pcicptr->
-			   g2pcfgdata | (where & 3)) = val;
-#endif
-	return check_abort(flags);
-}
-
-static int tx4927_pcibios_write_config_dword(struct pci_dev *dev,
-					     int where, unsigned int val)
-{
-	int flags;
-	unsigned char bus, func_num;
 
-	if (where & 3)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
+	switch (size) {
+	case 1:
+		 *(volatile u8 *) ((ulong) & tx4927_pcicptr->
+                          g2pcfgdata | (where & 3)) = val;
+		break;
 
-	/* check if the bus is top-level */
-	if (dev->bus->parent != NULL) {
-		bus = dev->bus->number;
-		db_assert(bus != 0);
-	} else {
-		bus = 0;
+	case 2:
+		*(volatile u16 *) ((ulong) & tx4927_pcicptr->
+                           g2pcfgdata | (where & 3)) = val;
+		break;
+	case 4:
+		tx4927_pcicptr->g2pcfgdata = val;
+		break;
 	}
 
-	func_num = PCI_FUNC(dev->devfn);
-	if (mkaddr(bus, dev->devfn, where, &flags))
-		return -1;
-	tx4927_pcicptr->g2pcfgdata = val;
 	return check_abort(flags);
 }
 
 struct pci_ops tx4927_pci_ops = {
-	tx4927_pcibios_read_config_byte,
-	tx4927_pcibios_read_config_word,
-	tx4927_pcibios_read_config_dword,
-	tx4927_pcibios_write_config_byte,
-	tx4927_pcibios_write_config_word,
-	tx4927_pcibios_write_config_dword
+	tx4927_pcibios_read_config,
+	tx4927_pcibios_write_config
+};
+
+/*
+ * h/w only supports devices 0x00 to 0x14
+ */
+struct pci_controller tx4927_controller = {
+	.pci_ops        = &tx4927_pci_ops,
+	.io_resource    = &pci_io_resource,
+	.mem_resource   = &pci_mem_resource,
 };

--0OAP2g/MAC+5xKAE--
