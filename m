Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Mar 2004 14:55:52 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:60609 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225255AbUCHOzv>;
	Mon, 8 Mar 2004 14:55:51 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id XAA18214;
	Mon, 8 Mar 2004 23:55:46 +0900 (JST)
Received: 4UMDO00 id i28EtkA15846; Mon, 8 Mar 2004 23:55:46 +0900 (JST)
Received: 4UMRO00 id i28Etju13570; Mon, 8 Mar 2004 23:55:46 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Mon, 8 Mar 2004 23:55:41 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Update TB0229+TB0219 support
Message-Id: <20040308235541.28726dbc.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch fixes so that the code of TB0229(CPU board) and
TB0219(base baord) may be divided correctly.

Please apply this patch to v2.6.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile linux/arch/mips/vr41xx/tanbac-tb0229/Makefile
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile	Thu Feb 26 00:23:50 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0229/Makefile	Mon Mar  8 23:23:20 2004
@@ -4,4 +4,4 @@
 
 obj-y				:= setup.o
 
-obj-$(CONFIG_TANBAC_TB0219)	+= reboot.o
+obj-$(CONFIG_TANBAC_TB0219)	+= tb0219.o
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/reboot.c linux/arch/mips/vr41xx/tanbac-tb0229/reboot.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/reboot.c	Sun Feb  1 21:41:34 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0229/reboot.c	Thu Jan  1 09:00:00 1970
@@ -1,27 +0,0 @@
-/*
- * FILE NAME
- *	arch/mips/vr41xx/tanbac-tb0229/reboot.c
- *
- * BRIEF MODULE DESCRIPTION
- *	Depending on TANBAC TB0229(VR4131DIMM) of reboot system call.
- *
- * Copyright 2003 Megasolution Inc.
- *                matsu@megasolution.jp
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- */
-#include <linux/config.h>
-#include <asm/io.h>
-#include <asm/vr41xx/tb0229.h>
-
-#define tb0229_hard_reset()	writew(0, TB0219_RESET_REGS)
-
-void tanbac_tb0229_restart(char *command)
-{
-	local_irq_disable();
-	tb0229_hard_reset();
-	while (1);
-}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c linux/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	Thu Feb 26 00:23:50 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	Mon Mar  8 23:23:20 2004
@@ -25,7 +25,6 @@
 
 #include <asm/io.h>
 #include <asm/pci_channel.h>
-#include <asm/reboot.h>
 #include <asm/vr41xx/tb0229.h>
 
 #ifdef CONFIG_PCI
@@ -92,10 +91,6 @@
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
-#endif
-
-#ifdef CONFIG_TANBAC_TB0219
-	_machine_restart = tanbac_tb0229_restart;
 #endif
 
 	return 0;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/tb0219.c linux/arch/mips/vr41xx/tanbac-tb0229/tb0219.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/tb0219.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/tanbac-tb0229/tb0219.c	Mon Mar  8 23:23:20 2004
@@ -0,0 +1,45 @@
+/*
+ *  tb0219.c, Setup for the TANBAC TB0219
+ *
+ *  Copyright (C) 2003  Megasolution Inc. <matsu@megasolution.jp>
+ *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/reboot.h>
+#include <asm/vr41xx/tb0229.h>
+
+#define TB0219_RESET_REGS	KSEG1ADDR(0x0a00000e)
+
+#define tb0219_hard_reset()	writew(0, TB0219_RESET_REGS)
+
+void tanbac_tb0219_restart(char *command)
+{
+	local_irq_disable();
+	tb0219_hard_reset();
+	while (1);
+}
+
+static int __init tanbac_tb0219_setup(void)
+{
+	_machine_restart = tanbac_tb0219_restart;
+
+	return 0;
+}
+
+early_initcall(tanbac_tb0219_setup);
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/tb0219.h linux/include/asm-mips/vr41xx/tb0219.h
--- linux-orig/include/asm-mips/vr41xx/tb0219.h	Thu Jan  1 09:00:00 1970
+++ linux/include/asm-mips/vr41xx/tb0219.h	Mon Mar  8 23:23:20 2004
@@ -0,0 +1,42 @@
+/*
+ *  tb0219.h, Include file for TANBAC TB0219.
+ *
+ *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  Modified for TANBAC TB0219:
+ *  Copyright (C) 2003 Megasolution Inc.  <matsu@megasolution.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __TANBAC_TB0219_H
+#define __TANBAC_TB0219_H
+
+#include <asm/vr41xx/vr41xx.h>
+
+/*
+ * General-Purpose I/O Pin Number
+ */
+#define TB0219_PCI_SLOT1_PIN		2
+#define TB0219_PCI_SLOT2_PIN		3
+#define TB0219_PCI_SLOT3_PIN		4
+
+/*
+ * Interrupt Number
+ */
+#define TB0219_PCI_SLOT1_IRQ		GIU_IRQ(TB0219_PCI_SLOT1_PIN)
+#define TB0219_PCI_SLOT2_IRQ		GIU_IRQ(TB0219_PCI_SLOT2_PIN)
+#define TB0219_PCI_SLOT3_IRQ		GIU_IRQ(TB0219_PCI_SLOT3_PIN)
+
+#endif /* __TANBAC_TB0219_H */
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/tb0229.h linux/include/asm-mips/vr41xx/tb0229.h
--- linux-orig/include/asm-mips/vr41xx/tb0229.h	Thu May 22 06:55:39 2003
+++ linux/include/asm-mips/vr41xx/tb0229.h	Mon Mar  8 23:23:20 2004
@@ -1,21 +1,24 @@
 /*
- * FILE NAME
- *	include/asm-mips/vr41xx/tb0229.h
+ *  tb0229.h, Include file for TANBAC TB0229.
  *
- * BRIEF MODULE DESCRIPTION
- *	Include file for TANBAC TB0229 and TB0219.
+ *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Copyright 2002,2003 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ *  Modified for TANBAC TB0229:
+ *  Copyright (C) 2003 Megasolution Inc.  <matsu@megasolution.jp>
  *
- * Modified for TANBAC TB0229:
- * Copyright 2003 Megasolution Inc.
- *                matsu@megasolution.jp
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
 #ifndef __TANBAC_TB0229_H
 #define __TANBAC_TB0229_H
@@ -51,23 +54,5 @@
 #define IO_MEM1_RESOURCE_END		(VR41XX_PCI_MEM1_BASE + VR41XX_PCI_MEM1_SIZE)
 #define IO_MEM2_RESOURCE_START		VR41XX_PCI_MEM2_BASE
 #define IO_MEM2_RESOURCE_END		(VR41XX_PCI_MEM2_BASE + VR41XX_PCI_MEM2_SIZE)
-
-/*
- * General-Purpose I/O Pin Number
- */
-#define TB0219_PCI_SLOT1_PIN		2
-#define TB0219_PCI_SLOT2_PIN		3
-#define TB0219_PCI_SLOT3_PIN		4
-
-/*
- * Interrupt Number
- */
-#define TB0219_PCI_SLOT1_IRQ		GIU_IRQ(TB0219_PCI_SLOT1_PIN)
-#define TB0219_PCI_SLOT2_IRQ		GIU_IRQ(TB0219_PCI_SLOT2_PIN)
-#define TB0219_PCI_SLOT3_IRQ		GIU_IRQ(TB0219_PCI_SLOT3_PIN)
-
-#define TB0219_RESET_REGS		KSEG1ADDR(0x0a00000e)
-
-extern void tanbac_tb0229_restart(char *command);
 
 #endif /* __TANBAC_TB0229_H */
