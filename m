Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 16:55:47 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:5826 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226043AbUEZPwU>;
	Wed, 26 May 2004 16:52:20 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA14660;
	Thu, 27 May 2004 00:52:17 +0900 (JST)
Received: 4UMDO00 id i4QFqHQ29971; Thu, 27 May 2004 00:52:17 +0900 (JST)
Received: 4UMRO00 id i4QFqGV28830; Thu, 27 May 2004 00:52:16 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 27 May 2004 00:52:14 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][12/14] vr41xx: update setup.c for Victor MP-C30x
Message-Id: <20040527005214.64ddfa46.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

setup.c for Victor MP-C30x was updated.

Please apply to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c linux/arch/mips/vr41xx/victor-mpc30x/setup.c
--- linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c	Thu Apr 29 10:42:49 2004
+++ linux/arch/mips/vr41xx/victor-mpc30x/setup.c	Fri May 14 00:16:15 2004
@@ -18,59 +18,8 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/config.h>
-#include <linux/ioport.h>
 
-#include <asm/io.h>
-#include <asm/pci_channel.h>
-#include <asm/vr41xx/mpc30x.h>
-
-#ifdef CONFIG_PCI
-static struct resource vr41xx_pci_io_resource = {
-	"PCI I/O space",
-	VR41XX_PCI_IO_START,
-	VR41XX_PCI_IO_END,
-	IORESOURCE_IO
-};
-
-static struct resource vr41xx_pci_mem_resource = {
-	"PCI memory space",
-	VR41XX_PCI_MEM_START,
-	VR41XX_PCI_MEM_END,
-	IORESOURCE_MEM
-};
-
-extern struct pci_ops vr41xx_pci_ops;
-
-struct pci_controller vr41xx_controller[] = {
-	.pci_ops	= &vr41xx_pci_ops,
-	.io_resource	= &vr41xx_pci_io_resource,
-	.mem_resource	= &vr41xx_pci_mem_resource,
-};
-
-struct vr41xx_pci_address_space vr41xx_pci_mem1 = {
-	VR41XX_PCI_MEM1_BASE,
-	VR41XX_PCI_MEM1_MASK,
-	IO_MEM1_RESOURCE_START
-};
-
-struct vr41xx_pci_address_space vr41xx_pci_mem2 = {
-	VR41XX_PCI_MEM2_BASE,
-	VR41XX_PCI_MEM2_MASK,
-	IO_MEM2_RESOURCE_START
-};
-
-struct vr41xx_pci_address_space vr41xx_pci_io = {
-	VR41XX_PCI_IO_BASE,
-	VR41XX_PCI_IO_MASK,
-	IO_PORT_RESOURCE_START
-};
-
-static struct vr41xx_pci_address_map pci_address_map = {
-	&vr41xx_pci_mem1,
-	&vr41xx_pci_mem2,
-	&vr41xx_pci_io
-};
-#endif
+#include <asm/vr41xx/vr41xx.h>
 
 const char *get_system_type(void)
 {
@@ -79,17 +28,9 @@
 
 static int victor_mpc30x_setup(void)
 {
-	set_io_port_base(IO_PORT_BASE);
-	ioport_resource.start = IO_PORT_RESOURCE_START;
-	ioport_resource.end = IO_PORT_RESOURCE_END;
-
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
 	vr41xx_siu_init();
-#endif
-
-#ifdef CONFIG_PCI
-	vr41xx_pciu_init(&pci_address_map);
 #endif
 
 	return 0;
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/mpc30x.h linux/include/asm-mips/vr41xx/mpc30x.h
--- linux-orig/include/asm-mips/vr41xx/mpc30x.h	Tue Nov 18 12:34:50 2003
+++ linux/include/asm-mips/vr41xx/mpc30x.h	Fri May 14 00:16:15 2004
@@ -1,52 +1,26 @@
 /*
- * FILE NAME
- *	include/asm-mips/vr41xx/mpc30x.h
+ *  mpc30x.h, Include file for Victor MP-C303/304.
  *
- * BRIEF MODULE DESCRIPTION
- *	Include file for Victor MP-C303/304.
+ *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Copyright 2002,2003 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #ifndef __VICTOR_MPC30X_H
 #define __VICTOR_MPC30X_H
 
-#include <asm/addrspace.h>
 #include <asm/vr41xx/vr41xx.h>
-
-/*
- * Board specific address mapping
- */
-#define VR41XX_PCI_MEM1_BASE		0x10000000
-#define VR41XX_PCI_MEM1_SIZE		0x04000000
-#define VR41XX_PCI_MEM1_MASK		0x7c000000
-
-#define VR41XX_PCI_MEM2_BASE		0x14000000
-#define VR41XX_PCI_MEM2_SIZE		0x02000000
-#define VR41XX_PCI_MEM2_MASK		0x7e000000
-
-#define VR41XX_PCI_IO_BASE		0x16000000
-#define VR41XX_PCI_IO_SIZE		0x02000000
-#define VR41XX_PCI_IO_MASK		0x7e000000
-
-#define VR41XX_PCI_IO_START		0x01000000
-#define VR41XX_PCI_IO_END		0x01ffffff
-
-#define VR41XX_PCI_MEM_START		0x12000000
-#define VR41XX_PCI_MEM_END		0x15ffffff
-
-#define IO_PORT_BASE			KSEG1ADDR(VR41XX_PCI_IO_BASE)
-#define IO_PORT_RESOURCE_START		0
-#define IO_PORT_RESOURCE_END		VR41XX_PCI_IO_SIZE
-#define IO_MEM1_RESOURCE_START		VR41XX_PCI_MEM1_BASE
-#define IO_MEM1_RESOURCE_END		(VR41XX_PCI_MEM1_BASE + VR41XX_PCI_MEM1_SIZE)
-#define IO_MEM2_RESOURCE_START		VR41XX_PCI_MEM2_BASE
-#define IO_MEM2_RESOURCE_END		(VR41XX_PCI_MEM2_BASE + VR41XX_PCI_MEM2_SIZE)
 
 /*
  * General-Purpose I/O Pin Number
