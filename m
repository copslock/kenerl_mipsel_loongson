Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2004 12:48:55 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:9964 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226033AbUD0Lsy>;
	Tue, 27 Apr 2004 12:48:54 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id UAA27772;
	Tue, 27 Apr 2004 20:48:50 +0900 (JST)
Received: 4UMDO00 id i3RBmoP21485; Tue, 27 Apr 2004 20:48:50 +0900 (JST)
Received: 4UMRO01 id i3RBmnj04389; Tue, 27 Apr 2004 20:48:49 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Tue, 27 Apr 2004 20:48:48 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: [Update PATCH][2.6] Update TB0229+TB0219 support
Message-Id: <20040427204848.3baeb489.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20040424154839.5b0ea690.yuasa@hh.iij4u.or.jp>
References: <20040424154839.5b0ea690.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I also updated this patch. Please apply serial patch first.

This patch fixes so that the code of TB0229(CPU board) and
TB0219(base baord) may be divided correctly.

Please apply

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile linux/arch/mips/vr41xx/tanbac-tb0229/Makefile
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile	2004-02-25 12:12:07.000000000 +0900
+++ linux/arch/mips/vr41xx/tanbac-tb0229/Makefile	2004-04-27 20:39:43.000000000 +0900
@@ -4,4 +4,4 @@
 
 obj-y				:= setup.o
 
-obj-$(CONFIG_TANBAC_TB0219)	+= reboot.o
+obj-$(CONFIG_TANBAC_TB0219)	+= tb0219.o
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/reboot.c linux/arch/mips/vr41xx/tanbac-tb0229/reboot.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/reboot.c	2004-02-02 11:24:21.000000000 +0900
+++ linux/arch/mips/vr41xx/tanbac-tb0229/reboot.c	1970-01-01 09:00:00.000000000 +0900
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
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	2004-04-27 20:39:24.000000000 +0900
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	2004-04-27 20:39:43.000000000 +0900
@@ -25,7 +25,6 @@
 
 #include <asm/io.h>
 #include <asm/pci_channel.h>
-#include <asm/reboot.h>
 #include <asm/vr41xx/tb0229.h>
 
 #ifdef CONFIG_PCI
@@ -97,10 +96,6 @@
 	vr41xx_pciu_init(&pci_address_map);
 #endif
 
-#ifdef CONFIG_TANBAC_TB0219
-	_machine_restart = tanbac_tb0229_restart;
-#endif
-
 	return 0;
 }
 
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/tb0219.c linux/arch/mips/vr41xx/tanbac-tb0229/tb0219.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/tb0219.c	1970-01-01 09:00:00.000000000 +0900
+++ linux/arch/mips/vr41xx/tanbac-tb0229/tb0219.c	2004-04-27 20:39:43.000000000 +0900
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
--- linux-orig/include/asm-mips/vr41xx/tb0219.h	1970-01-01 09:00:00.000000000 +0900
+++ linux/include/asm-mips/vr41xx/tb0219.h	2004-04-27 20:39:43.000000000 +0900
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
--- linux-orig/include/asm-mips/vr41xx/tb0229.h	2003-05-22 06:55:39.000000000 +0900
+++ linux/include/asm-mips/vr41xx/tb0229.h	2004-04-27 20:39:43.000000000 +0900
@@ -1,27 +1,29 @@
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
 
 #include <asm/addrspace.h>
-#include <asm/vr41xx/vr41xx.h>
 
 /*
  * Board specific address mapping
@@ -52,22 +54,4 @@
 #define IO_MEM2_RESOURCE_START		VR41XX_PCI_MEM2_BASE
 #define IO_MEM2_RESOURCE_END		(VR41XX_PCI_MEM2_BASE + VR41XX_PCI_MEM2_SIZE)
 
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
-
 #endif /* __TANBAC_TB0229_H */
