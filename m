Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2004 00:00:54 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:39417 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225462AbUBFAAx>;
	Fri, 6 Feb 2004 00:00:53 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id JAA22429;
	Fri, 6 Feb 2004 09:00:49 +0900 (JST)
Received: 4UMDO00 id i1600nW15555; Fri, 6 Feb 2004 09:00:49 +0900 (JST)
Received: 4UMRO00 id i1600nE02271; Fri, 6 Feb 2004 09:00:49 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Fri, 6 Feb 2004 09:00:35 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.4]  Removed same processing for initrd of vr41xx
Message-Id: <20040206090035.17cbf272.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made a patch for initrd of vr41xx.

Both arch/mips/kernel/setup.c and following files have the same processing for initrd.
One of the processing for initrd should delete.

Please apply this patch to v2.4.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/casio-e55/setup.c linux/arch/mips/vr41xx/casio-e55/setup.c
--- linux-orig/arch/mips/vr41xx/casio-e55/setup.c	Fri Oct 31 11:28:40 2003
+++ linux/arch/mips/vr41xx/casio-e55/setup.c	Fri Feb  6 08:49:49 2004
@@ -23,11 +23,6 @@
 #include <asm/time.h>
 #include <asm/vr41xx/e55.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 void __init casio_e55_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
@@ -35,12 +30,6 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 	iomem_resource.start = IO_MEM_RESOURCE_START;
 	iomem_resource.end = IO_MEM_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c linux/arch/mips/vr41xx/ibm-workpad/setup.c
--- linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/ibm-workpad/setup.c	Fri Feb  6 08:49:49 2004
@@ -23,11 +23,6 @@
 #include <asm/time.h>
 #include <asm/vr41xx/workpad.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 void __init ibm_workpad_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
@@ -35,12 +30,6 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 	iomem_resource.start = IO_MEM_RESOURCE_START;
 	iomem_resource.end = IO_MEM_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/setup.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Fri Feb  6 08:49:49 2004
@@ -50,11 +50,6 @@
 #include <asm/time.h>
 #include <asm/vr41xx/eagle.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 extern void eagle_irq_init(void);
 
 #ifdef CONFIG_PCI
@@ -114,12 +109,6 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	Fri Feb  6 08:49:49 2004
@@ -23,11 +23,6 @@
 #include <asm/time.h>
 #include <asm/vr41xx/tb0226.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 #ifdef CONFIG_PCI
 static struct resource vr41xx_pci_io_resource = {
 	"PCI I/O space",
@@ -82,12 +77,6 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c linux/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	Fri Feb  6 08:49:50 2004
@@ -28,10 +28,6 @@
 #include <asm/time.h>
 #include <asm/vr41xx/tb0229.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern void * __rd_start, * __rd_end;
-#endif
-
 #ifdef CONFIG_PCI
 static struct resource vr41xx_pci_io_resource = {
 	.name	= "PCI I/O space",
@@ -94,12 +90,6 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	_machine_restart = tanbac_tb0229_restart;
 	_machine_halt = vr41xx_halt;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c linux/arch/mips/vr41xx/victor-mpc30x/setup.c
--- linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/victor-mpc30x/setup.c	Fri Feb  6 08:49:50 2004
@@ -24,11 +24,6 @@
 #include <asm/time.h>
 #include <asm/vr41xx/mpc30x.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 #ifdef CONFIG_PCI
 static struct resource vr41xx_pci_io_resource = {
 	"PCI I/O space",
@@ -83,12 +78,6 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/setup.c linux/arch/mips/vr41xx/zao-capcella/setup.c
--- linux-orig/arch/mips/vr41xx/zao-capcella/setup.c	Fri Oct 31 11:28:41 2003
+++ linux/arch/mips/vr41xx/zao-capcella/setup.c	Fri Feb  6 08:49:50 2004
@@ -24,11 +24,6 @@
 #include <asm/time.h>
 #include <asm/vr41xx/capcella.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 #ifdef CONFIG_PCI
 static struct resource vr41xx_pci_io_resource = {
 	"PCI I/O space",
@@ -83,12 +78,6 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	_machine_restart = vr41xx_restart;
 	_machine_halt = vr41xx_halt;
