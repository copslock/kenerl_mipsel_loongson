Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2003 07:47:51 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:26562 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225072AbTGYGrq>;
	Fri, 25 Jul 2003 07:47:46 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id PAA02234;
	Fri, 25 Jul 2003 15:47:36 +0900 (JST)
Received: 4UMDO00 id h6P6laP14612; Fri, 25 Jul 2003 15:47:36 +0900 (JST)
Received: 4UMRO00 id h6P6lYD12445; Fri, 25 Jul 2003 15:47:35 +0900 (JST)
	from pudding.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Fri, 25 Jul 2003 15:47:35 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: [patch]  IDE common routine for VR41xx
Message-Id: <20030725154735.40697dca.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__25_Jul_2003_15:47:35_+0900_0861d1f0"
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Fri__25_Jul_2003_15:47:35_+0900_0861d1f0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Ralf,

I made a patch about IDE common routine for NEC VR41xx.

Please apply this patch to v2.4 CVS tree.

Yoichi

--Multipart_Fri__25_Jul_2003_15:47:35_+0900_0861d1f0
Content-Type: text/plain;
 name="vr41xx-ide.diff"
Content-Disposition: attachment;
 filename="vr41xx-ide.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/casio-e55/Makefile linux/arch/mips/vr41xx/casio-e55/Makefile
--- linux.orig/arch/mips/vr41xx/casio-e55/Makefile	Wed Nov 13 19:00:14 2002
+++ linux/arch/mips/vr41xx/casio-e55/Makefile	Fri Jul 25 12:25:24 2003
@@ -14,6 +14,4 @@
 
 obj-y	:= init.o setup.o
 
-obj-$(CONFIG_IDE)	+= ide-e55.o
-
 include $(TOPDIR)/Rules.make
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/casio-e55/ide-e55.c linux/arch/mips/vr41xx/casio-e55/ide-e55.c
--- linux.orig/arch/mips/vr41xx/casio-e55/ide-e55.c	Fri Oct  4 01:58:02 2002
+++ linux/arch/mips/vr41xx/casio-e55/ide-e55.c	Thu Jan  1 09:00:00 1970
@@ -1,99 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * IDE routines for typical pc-like standard configurations
- * for the CASIO CASSIOPEIA E-55/65.
- *
- * Copyright (C) 1998, 1999, 2001 by Ralf Baechle
- */
-/*
- * Changes:
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>  Sun, 24 Feb 2002
- *  - Added CASIO CASSIOPEIA E-55/65 support.
- */
-#include <linux/sched.h>
-#include <linux/ide.h>
-#include <linux/ioport.h>
-#include <linux/hdreg.h>
-#include <asm/ptrace.h>
-#include <asm/hdreg.h>
-
-static int e55_ide_default_irq(ide_ioreg_t base)
-{
-	return 40;
-}
-
-static ide_ioreg_t e55_ide_default_io_base(int index)
-{
-	switch (index) {
-		case 0: return 0xc1f0;
-		case 1: return 0xc170;
-		case 2: return 0xc1e8;
-		case 3: return 0xc168;
-		case 4: return 0xc1e0;
-		case 5: return 0xc160;
-	}
-	return 0;
-}
-
-static void e55_ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port,
-                                    ide_ioreg_t ctrl_port, int *irq)
-{
-	ide_ioreg_t reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
-static int e55_ide_request_irq(unsigned int irq,
-                               void (*handler)(int,void *, struct pt_regs *),
-                               unsigned long flags, const char *device,
-                               void *dev_id)
-{
-	return request_irq(irq, handler, flags, device, dev_id);
-}			
-
-static void e55_ide_free_irq(unsigned int irq, void *dev_id)
-{
-	free_irq(irq, dev_id);
-}
-
-static int e55_ide_check_region(ide_ioreg_t from, unsigned int extent)
-{
-	return check_region(from, extent);
-}
-
-static void e55_ide_request_region(ide_ioreg_t from, unsigned int extent,
-                                   const char *name)
-{
-	request_region(from, extent, name);
-}
-
-static void e55_ide_release_region(ide_ioreg_t from, unsigned int extent)
-{
-	release_region(from, extent);
-}
-
-struct ide_ops e55_ide_ops = {
-	&e55_ide_default_irq,
-	&e55_ide_default_io_base,
-	&e55_ide_init_hwif_ports,
-	&e55_ide_request_irq,
-	&e55_ide_free_irq,
-	&e55_ide_check_region,
-	&e55_ide_request_region,
-	&e55_ide_release_region
-};
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/casio-e55/setup.c linux/arch/mips/vr41xx/casio-e55/setup.c
--- linux.orig/arch/mips/vr41xx/casio-e55/setup.c	Fri Oct  4 01:58:02 2002
+++ linux/arch/mips/vr41xx/casio-e55/setup.c	Fri Jul 25 12:25:25 2003
@@ -28,10 +28,6 @@
 extern void * __rd_start, * __rd_end;
 #endif
 
-#ifdef CONFIG_BLK_DEV_IDE
-extern struct ide_ops e55_ide_ops;
-#endif
-
 void __init casio_e55_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
@@ -57,8 +53,8 @@
 	conswitchp = &dummy_con;
 #endif
 
-#ifdef CONFIG_BLK_DEV_IDE
-	ide_ops = &e55_ide_ops;
+#if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE)
+	ide_ops = &vr41xx_ide_ops;
 #endif
 
 	vr41xx_bcu_init();
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/Makefile linux/arch/mips/vr41xx/common/Makefile
--- linux.orig/arch/mips/vr41xx/common/Makefile	Thu Dec 12 10:10:09 2002
+++ linux/arch/mips/vr41xx/common/Makefile	Fri Jul 25 12:25:25 2003
@@ -20,5 +20,6 @@
 obj-$(CONFIG_SERIAL)		+= serial.o
 obj-$(CONFIG_VR41XX_TIME_C)	+= time.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
+obj-$(subst m,y,$(CONFIG_IDE))	+= ide.o
 
 include $(TOPDIR)/Rules.make
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/ide.c linux/arch/mips/vr41xx/common/ide.c
--- linux.orig/arch/mips/vr41xx/common/ide.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/common/ide.c	Fri Jul 25 14:31:32 2003
@@ -0,0 +1,50 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * IDE routines for NEC VR4100 series standard configurations.
+ *
+ * Copyright (C) 1998, 1999, 2001 by Ralf Baechle
+ * Copyright (C) 2003 Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ */
+#include <linux/hdreg.h>
+#include <linux/ide.h>
+
+#include <asm/hdreg.h>
+
+static int vr41xx_ide_default_irq(ide_ioreg_t base)
+{
+	return 0;
+}
+
+static ide_ioreg_t vr41xx_ide_default_io_base(int index)
+{
+	return 0;
+}
+
+static void vr41xx_ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port,
+                                       ide_ioreg_t ctrl_port, int *irq)
+{
+	ide_ioreg_t reg = data_port;
+	int i;
+
+	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
+		hw->io_ports[i] = reg;
+		reg += 1;
+	}
+	if (ctrl_port) {
+		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
+	} else {
+		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
+	}
+	if (irq != NULL)
+		*irq = 0;
+	hw->io_ports[IDE_IRQ_OFFSET] = 0;
+}
+
+struct ide_ops vr41xx_ide_ops = {
+	.ide_default_irq	= &vr41xx_ide_default_irq,
+	.ide_default_io_base	= &vr41xx_ide_default_io_base,
+	.ide_init_hwif_ports	= &vr41xx_ide_init_hwif_ports
+};
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/ibm-workpad/Makefile linux/arch/mips/vr41xx/ibm-workpad/Makefile
--- linux.orig/arch/mips/vr41xx/ibm-workpad/Makefile	Wed Nov 13 19:00:14 2002
+++ linux/arch/mips/vr41xx/ibm-workpad/Makefile	Fri Jul 25 12:25:25 2003
@@ -14,6 +14,4 @@
 
 obj-y	:= init.o setup.o
 
-obj-$(CONFIG_IDE)	+= ide-workpad.o
-
 include $(TOPDIR)/Rules.make
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/ibm-workpad/ide-workpad.c linux/arch/mips/vr41xx/ibm-workpad/ide-workpad.c
--- linux.orig/arch/mips/vr41xx/ibm-workpad/ide-workpad.c	Fri Oct  4 01:58:02 2002
+++ linux/arch/mips/vr41xx/ibm-workpad/ide-workpad.c	Thu Jan  1 09:00:00 1970
@@ -1,98 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * IDE routines for typical pc-like standard configurations for the IBM WorkPad z50.
- *
- * Copyright (C) 1998, 1999, 2001 by Ralf Baechle
- */
-/*
- * Changes:
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>  Sun, 24 Feb 2002
- *  - Added IBM WorkPad z50 support.
- */
-#include <linux/sched.h>
-#include <linux/ide.h>
-#include <linux/ioport.h>
-#include <linux/hdreg.h>
-#include <asm/ptrace.h>
-#include <asm/hdreg.h>
-
-static int workpad_ide_default_irq(ide_ioreg_t base)
-{
-	return 49;
-}
-
-static ide_ioreg_t workpad_ide_default_io_base(int index)
-{
-	switch (index) {
-		case 0: return 0x1f0;
-		case 1: return 0x170;
-		case 2: return 0x1e8;
-		case 3: return 0x168;
-		case 4: return 0x1e0;
-		case 5: return 0x160;
-	}
-	return 0;
-}
-
-static void workpad_ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port,
-                                        ide_ioreg_t ctrl_port, int *irq)
-{
-	ide_ioreg_t reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
-static int workpad_ide_request_irq(unsigned int irq,
-                                   void (*handler)(int,void *, struct pt_regs *),
-                                   unsigned long flags, const char *device,
-                                   void *dev_id)
-{
-	return request_irq(irq, handler, SA_SHIRQ, device, dev_id);
-}			
-
-static void workpad_ide_free_irq(unsigned int irq, void *dev_id)
-{
-	free_irq(irq, dev_id);
-}
-
-static int workpad_ide_check_region(ide_ioreg_t from, unsigned int extent)
-{
-	return check_region(from, extent);
-}
-
-static void workpad_ide_request_region(ide_ioreg_t from, unsigned int extent,
-                                       const char *name)
-{
-	request_region(from, extent, name);
-}
-
-static void workpad_ide_release_region(ide_ioreg_t from, unsigned int extent)
-{
-	release_region(from, extent);
-}
-
-struct ide_ops workpad_ide_ops = {
-	&workpad_ide_default_irq,
-	&workpad_ide_default_io_base,
-	&workpad_ide_init_hwif_ports,
-	&workpad_ide_request_irq,
-	&workpad_ide_free_irq,
-	&workpad_ide_check_region,
-	&workpad_ide_request_region,
-	&workpad_ide_release_region
-};
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/ibm-workpad/setup.c linux/arch/mips/vr41xx/ibm-workpad/setup.c
--- linux.orig/arch/mips/vr41xx/ibm-workpad/setup.c	Fri Oct  4 01:58:02 2002
+++ linux/arch/mips/vr41xx/ibm-workpad/setup.c	Fri Jul 25 12:25:25 2003
@@ -28,10 +28,6 @@
 extern void * __rd_start, * __rd_end;
 #endif
 
-#ifdef CONFIG_BLK_DEV_IDE
-extern struct ide_ops workpad_ide_ops;
-#endif
-
 void __init ibm_workpad_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
@@ -57,8 +53,8 @@
 	conswitchp = &dummy_con;
 #endif
 
-#ifdef CONFIG_BLK_DEV_IDE
-	ide_ops = &workpad_ide_ops;
+#if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE)
+	ide_ops = &vr41xx_ide_ops;
 #endif
 
 	vr41xx_bcu_init();
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/nec-eagle/Makefile linux/arch/mips/vr41xx/nec-eagle/Makefile
--- linux.orig/arch/mips/vr41xx/nec-eagle/Makefile	Thu Dec 12 10:10:09 2002
+++ linux/arch/mips/vr41xx/nec-eagle/Makefile	Fri Jul 25 12:25:25 2003
@@ -19,7 +19,6 @@
 
 obj-y	:= init.o irq.o setup.o
 
-obj-$(CONFIG_IDE)	+= ide-eagle.o
 obj-$(CONFIG_PCI)	+= pci_fixup.o vrc4173.o
 
 include $(TOPDIR)/Rules.make
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/nec-eagle/ide-eagle.c linux/arch/mips/vr41xx/nec-eagle/ide-eagle.c
--- linux.orig/arch/mips/vr41xx/nec-eagle/ide-eagle.c	Tue Aug  6 08:53:36 2002
+++ linux/arch/mips/vr41xx/nec-eagle/ide-eagle.c	Thu Jan  1 09:00:00 1970
@@ -1,96 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * IDE routines for typical pc-like standard configurations
- * for the NEC Eagle/Hawk board.
- *
- * Copyright (C) 1998, 1999, 2001 by Ralf Baechle
- */
-/*
- * Changes:
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  Fri,  5 Apr 2002
- *  - Added support for NEC Hawk.
- *
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  Fri,  1 Mar 2002
- *  - Added support for NEC Eagle.
- */
-#include <linux/sched.h>
-#include <linux/ide.h>
-#include <linux/ioport.h>
-#include <linux/hdreg.h>
-#include <asm/ptrace.h>
-#include <asm/hdreg.h>
-
-static int eagle_ide_default_irq(ide_ioreg_t base)
-{
-	return 0;
-}
-
-static ide_ioreg_t eagle_ide_default_io_base(int index)
-{
-	return 0;
-}
-
-static void eagle_ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port,
-                                      ide_ioreg_t ctrl_port, int *irq)
-{
-	ide_ioreg_t reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
-static int eagle_ide_request_irq(unsigned int irq,
-                                 void (*handler)(int,void *, struct pt_regs *),
-                                 unsigned long flags, const char *device,
-                                 void *dev_id)
-{
-	return request_irq(irq, handler, SA_SHIRQ, device, dev_id);
-}
-
-static void eagle_ide_free_irq(unsigned int irq, void *dev_id)
-{
-	free_irq(irq, dev_id);
-}
-
-static int eagle_ide_check_region(ide_ioreg_t from, unsigned int extent)
-{
-	return check_region(from, extent);
-}
-
-static void eagle_ide_request_region(ide_ioreg_t from, unsigned int extent,
-                                     const char *name)
-{
-	request_region(from, extent, name);
-}
-
-static void eagle_ide_release_region(ide_ioreg_t from, unsigned int extent)
-{
-	release_region(from, extent);
-}
-
-struct ide_ops eagle_ide_ops = {
-	&eagle_ide_default_irq,
-	&eagle_ide_default_io_base,
-	&eagle_ide_init_hwif_ports,
-	&eagle_ide_request_irq,
-	&eagle_ide_free_irq,
-	&eagle_ide_check_region,
-	&eagle_ide_request_region,
-	&eagle_ide_release_region
-};
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux.orig/arch/mips/vr41xx/nec-eagle/setup.c	Thu Dec 12 10:10:09 2002
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Fri Jul 25 12:25:25 2003
@@ -55,10 +55,6 @@
 extern void * __rd_start, * __rd_end;
 #endif
 
-#ifdef CONFIG_BLK_DEV_IDE
-extern struct ide_ops eagle_ide_ops;
-#endif
-
 extern void eagle_irq_init(void);
 
 #ifdef CONFIG_PCI
@@ -138,8 +134,8 @@
 	conswitchp = &dummy_con;
 #endif
 
-#ifdef CONFIG_BLK_DEV_IDE
-	ide_ops = &eagle_ide_ops;
+#if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE)
+	ide_ops = &vr41xx_ide_ops;
 #endif
 
 	vr41xx_bcu_init();
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux.orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Tue Feb  4 21:43:06 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	Fri Jul 25 12:25:25 2003
@@ -16,7 +16,6 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/console.h>
-#include <linux/ide.h>
 #include <linux/ioport.h>
 
 #include <asm/pci_channel.h>
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/victor-mpc30x/Makefile linux/arch/mips/vr41xx/victor-mpc30x/Makefile
--- linux.orig/arch/mips/vr41xx/victor-mpc30x/Makefile	Fri Oct  4 01:58:02 2002
+++ linux/arch/mips/vr41xx/victor-mpc30x/Makefile	Fri Jul 25 12:25:25 2003
@@ -14,7 +14,6 @@
 
 obj-y	:= init.o setup.o
 
-obj-$(CONFIG_IDE)	+= ide-mpc30x.o
 obj-$(CONFIG_PCI)	+= pci_fixup.o
 
 include $(TOPDIR)/Rules.make
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/victor-mpc30x/ide-mpc30x.c linux/arch/mips/vr41xx/victor-mpc30x/ide-mpc30x.c
--- linux.orig/arch/mips/vr41xx/victor-mpc30x/ide-mpc30x.c	Fri Oct  4 01:58:02 2002
+++ linux/arch/mips/vr41xx/victor-mpc30x/ide-mpc30x.c	Thu Jan  1 09:00:00 1970
@@ -1,91 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * IDE routines for typical pc-like standard configurations
- * for the ZAO Networks Capcella.
- *
- * Copyright (C) 1998, 1999, 2001 by Ralf Baechle
- */
-/*
- * Changes:
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>  Fri, 23 Aug 2002
- *  - Added Victor MP-C303/304 support.
- */
-#include <linux/sched.h>
-#include <linux/ide.h>
-#include <linux/ioport.h>
-#include <linux/hdreg.h>
-#include <asm/ptrace.h>
-#include <asm/hdreg.h>
-
-static int mpc30x_ide_default_irq(ide_ioreg_t base)
-{
-	return 0;
-}
-
-static ide_ioreg_t mpc30x_ide_default_io_base(int index)
-{
-	return 0;
-}
-
-static void mpc30x_ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port,
-                                       ide_ioreg_t ctrl_port, int *irq)
-{
-	ide_ioreg_t reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
-static int mpc30x_ide_request_irq(unsigned int irq,
-                                  void (*handler)(int,void *, struct pt_regs *),
-                                  unsigned long flags, const char *device,
-                                  void *dev_id)
-{
-	return request_irq(irq, handler, flags, device, dev_id);
-}
-
-static void mpc30x_ide_free_irq(unsigned int irq, void *dev_id)
-{
-	free_irq(irq, dev_id);
-}
-
-static int mpc30x_ide_check_region(ide_ioreg_t from, unsigned int extent)
-{
-	return check_region(from, extent);
-}
-
-static void mpc30x_ide_request_region(ide_ioreg_t from, unsigned int extent,
-                                      const char *name)
-{
-	request_region(from, extent, name);
-}
-
-static void mpc30x_ide_release_region(ide_ioreg_t from, unsigned int extent)
-{
-	release_region(from, extent);
-}
-
-struct ide_ops mpc30x_ide_ops = {
-	&mpc30x_ide_default_irq,
-	&mpc30x_ide_default_io_base,
-	&mpc30x_ide_init_hwif_ports,
-	&mpc30x_ide_request_irq,
-	&mpc30x_ide_free_irq,
-	&mpc30x_ide_check_region,
-	&mpc30x_ide_request_region,
-	&mpc30x_ide_release_region
-};
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/victor-mpc30x/setup.c linux/arch/mips/vr41xx/victor-mpc30x/setup.c
--- linux.orig/arch/mips/vr41xx/victor-mpc30x/setup.c	Fri Oct  4 01:58:02 2002
+++ linux/arch/mips/vr41xx/victor-mpc30x/setup.c	Fri Jul 25 12:25:25 2003
@@ -29,10 +29,6 @@
 extern void * __rd_start, * __rd_end;
 #endif
 
-#ifdef CONFIG_BLK_DEV_IDE
-extern struct ide_ops mpc30x_ide_ops;
-#endif
-
 #ifdef CONFIG_PCI
 static struct resource vr41xx_pci_io_resource = {
 	"PCI I/O space",
@@ -105,8 +101,8 @@
 	conswitchp = &dummy_con;
 #endif
 
-#ifdef CONFIG_BLK_DEV_IDE
-	ide_ops = &mpc30x_ide_ops;
+#if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE)
+	ide_ops = &vr41xx_ide_ops;
 #endif
 
 	vr41xx_bcu_init();
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/zao-capcella/Makefile linux/arch/mips/vr41xx/zao-capcella/Makefile
--- linux.orig/arch/mips/vr41xx/zao-capcella/Makefile	Mon Jul 15 09:02:56 2002
+++ linux/arch/mips/vr41xx/zao-capcella/Makefile	Fri Jul 25 12:25:25 2003
@@ -14,7 +14,6 @@
 
 obj-y	:= init.o setup.o
 
-obj-$(CONFIG_IDE)	+= ide-capcella.o
 obj-$(CONFIG_PCI)	+= pci_fixup.o
 
 include $(TOPDIR)/Rules.make
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/zao-capcella/ide-capcella.c linux/arch/mips/vr41xx/zao-capcella/ide-capcella.c
--- linux.orig/arch/mips/vr41xx/zao-capcella/ide-capcella.c	Tue Aug  6 08:53:36 2002
+++ linux/arch/mips/vr41xx/zao-capcella/ide-capcella.c	Thu Jan  1 09:00:00 1970
@@ -1,99 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * IDE routines for typical pc-like standard configurations
- * for the ZAO Networks Capcella.
- *
- * Copyright (C) 1998, 1999, 2001 by Ralf Baechle
- */
-/*
- * Changes:
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>  Sun, 24 Feb 2002
- *  - Added ZAO Networks Capcella support.
- */
-#include <linux/sched.h>
-#include <linux/ide.h>
-#include <linux/ioport.h>
-#include <linux/hdreg.h>
-#include <asm/ptrace.h>
-#include <asm/hdreg.h>
-
-static int capcella_ide_default_irq(ide_ioreg_t base)
-{
-	switch (base) {
-	case 0x8300: return 42;
-	}
-
-	return 0;
-}
-
-static ide_ioreg_t capcella_ide_default_io_base(int index)
-{
-	switch (index) {
-	case 0: return 0x8300;
-	}
-
-	return 0;
-}
-
-static void capcella_ide_init_hwif_ports(hw_regs_t *hw, ide_ioreg_t data_port,
-                                         ide_ioreg_t ctrl_port, int *irq)
-{
-	ide_ioreg_t reg = data_port;
-	int i;
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = reg;
-		reg += 1;
-	}
-	if (ctrl_port) {
-		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
-	} else {
-		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
-	}
-	if (irq != NULL)
-		*irq = 0;
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-}
-
-static int capcella_ide_request_irq(unsigned int irq,
-                                    void (*handler)(int,void *, struct pt_regs *),
-                                    unsigned long flags, const char *device,
-                                    void *dev_id)
-{
-	return request_irq(irq, handler, flags, device, dev_id);
-}
-
-static void capcella_ide_free_irq(unsigned int irq, void *dev_id)
-{
-	free_irq(irq, dev_id);
-}
-
-static int capcella_ide_check_region(ide_ioreg_t from, unsigned int extent)
-{
-	return check_region(from, extent);
-}
-
-static void capcella_ide_request_region(ide_ioreg_t from, unsigned int extent,
-                                        const char *name)
-{
-	request_region(from, extent, name);
-}
-
-static void capcella_ide_release_region(ide_ioreg_t from, unsigned int extent)
-{
-	release_region(from, extent);
-}
-
-struct ide_ops capcella_ide_ops = {
-	&capcella_ide_default_irq,
-	&capcella_ide_default_io_base,
-	&capcella_ide_init_hwif_ports,
-	&capcella_ide_request_irq,
-	&capcella_ide_free_irq,
-	&capcella_ide_check_region,
-	&capcella_ide_request_region,
-	&capcella_ide_release_region
-};
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/zao-capcella/setup.c linux/arch/mips/vr41xx/zao-capcella/setup.c
--- linux.orig/arch/mips/vr41xx/zao-capcella/setup.c	Fri Oct  4 01:58:02 2002
+++ linux/arch/mips/vr41xx/zao-capcella/setup.c	Fri Jul 25 12:25:25 2003
@@ -29,10 +29,6 @@
 extern void * __rd_start, * __rd_end;
 #endif
 
-#ifdef CONFIG_BLK_DEV_IDE
-extern struct ide_ops capcella_ide_ops;
-#endif
-
 #ifdef CONFIG_PCI
 static struct resource vr41xx_pci_io_resource = {
 	"PCI I/O space",
@@ -105,8 +101,8 @@
 	conswitchp = &dummy_con;
 #endif
 
-#ifdef CONFIG_BLK_DEV_IDE
-	ide_ops = &capcella_ide_ops;
+#if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE)
+	ide_ops = &vr41xx_ide_ops;
 #endif
 
 	vr41xx_bcu_init();
diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux.orig/include/asm-mips/vr41xx/vr41xx.h	Thu Mar 20 10:48:19 2003
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Fri Jul 25 14:51:18 2003
@@ -189,4 +189,8 @@
 extern void vr41xx_halt(void);
 extern void vr41xx_power_off(void);
 
+#if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE)
+extern struct ide_ops vr41xx_ide_ops;
+#endif
+
 #endif /* __NEC_VR41XX_H */

--Multipart_Fri__25_Jul_2003_15:47:35_+0900_0861d1f0--
