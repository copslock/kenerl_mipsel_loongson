Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Jan 2004 10:25:57 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:13270 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224954AbUAaKZ4>;
	Sat, 31 Jan 2004 10:25:56 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id TAA12213;
	Sat, 31 Jan 2004 19:25:49 +0900 (JST)
Received: 4UMDO00 id i0VAPnY08537; Sat, 31 Jan 2004 19:25:49 +0900 (JST)
Received: 4UMRO00 id i0VAPlo07330; Sat, 31 Jan 2004 19:25:48 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Sat, 31 Jan 2004 19:25:43 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Changed machine_restart/halt/power_off for vr41xx
Message-Id: <20040131192543.1eb7b88d.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made the patch for machine_restart/halt/power_off for vr41xx.
This patch updates these functions.

I am going to add power management to pmu.c.

Please apply this patch to v2.6.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/casio-e55/setup.c linux/arch/mips/vr41xx/casio-e55/setup.c
--- linux-orig/arch/mips/vr41xx/casio-e55/setup.c	Fri Jan 23 21:19:39 2004
+++ linux/arch/mips/vr41xx/casio-e55/setup.c	Sat Jan 31 18:58:52 2004
@@ -1,17 +1,21 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/casio-e55/setup.c
+ *  setup.c, Setup for the CASIO CASSIOPEIA E-11/15/55/65.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the CASIO CASSIOPEIA E-11/15/55/65.
+ *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Copyright 2002 Yoichi Yuasa
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
 #include <linux/config.h>
 #include <linux/init.h>
@@ -20,7 +24,6 @@
 #include <linux/kdev_t.h>
 #include <linux/root_dev.h>
 
-#include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/vr41xx/e55.h>
 
@@ -43,16 +46,14 @@
 	initrd_end = (unsigned long)&__rd_end;
 #endif
 
-	_machine_restart = vr41xx_restart;
-	_machine_halt = vr41xx_halt;
-	_machine_power_off = vr41xx_power_off;
-
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
 
 	vr41xx_bcu_init();
 
 	vr41xx_cmu_init();
+
+	vr41xx_pmu_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/Makefile linux/arch/mips/vr41xx/common/Makefile
--- linux-orig/arch/mips/vr41xx/common/Makefile	Fri Jan 16 01:21:15 2004
+++ linux/arch/mips/vr41xx/common/Makefile	Sat Jan 31 18:58:52 2004
@@ -2,7 +2,7 @@
 # Makefile for common code of the NEC VR4100 series.
 #
 
-obj-y				+= bcu.o cmu.o giu.o icu.o int-handler.o ksyms.o reset.o rtc.o
+obj-y				+= bcu.o cmu.o giu.o icu.o int-handler.o ksyms.o pmu.o rtc.o
 obj-$(CONFIG_SERIAL_8250)	+= serial.o
 obj-$(CONFIG_VRC4171)		+= vrc4171.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/pmu.c linux/arch/mips/vr41xx/common/pmu.c
--- linux-orig/arch/mips/vr41xx/common/pmu.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/common/pmu.c	Sat Jan 31 18:58:52 2004
@@ -0,0 +1,75 @@
+/*
+ *  pmu.c, Power Management Unit routines for NEC VR4100 series.
+ *
+ *  Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
+#include <linux/types.h>
+
+#include <asm/cpu.h>
+#include <asm/io.h>
+#include <asm/reboot.h>
+#include <asm/system.h>
+
+#define PMUCNT2REG	KSEG1ADDR(0x0f0000c6)
+ #define SOFTRST	0x0010
+
+static inline void software_reset(void)
+{
+	uint16_t val;
+
+	switch (current_cpu_data.cputype) {
+	case CPU_VR4122:
+	case CPU_VR4131:
+	case CPU_VR4133:
+		val = readw(PMUCNT2REG);
+		val |= SOFTRST;
+		writew(val, PMUCNT2REG);
+		break;
+	default:
+		break;
+	}
+}
+
+static void vr41xx_restart(char *command)
+{
+	local_irq_disable();
+	software_reset();
+	printk(KERN_NOTICE "\nYou can reset your system\n");
+	while (1) ;
+}
+
+static void vr41xx_halt(void)
+{
+	local_irq_disable();
+	printk(KERN_NOTICE "\nYou can turn off the power supply\n");
+	while (1) ;
+}
+
+static void vr41xx_power_off(void)
+{
+	local_irq_disable();
+	printk(KERN_NOTICE "\nYou can turn off the power supply\n");
+	while (1) ;
+}
+
+void __init vr41xx_pmu_init(void)
+{
+	_machine_restart = vr41xx_restart;
+	_machine_halt = vr41xx_halt;
+	_machine_power_off = vr41xx_power_off;
+}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/reset.c linux/arch/mips/vr41xx/common/reset.c
--- linux-orig/arch/mips/vr41xx/common/reset.c	Sun Dec 29 23:50:55 2002
+++ linux/arch/mips/vr41xx/common/reset.c	Thu Jan  1 09:00:00 1970
@@ -1,37 +0,0 @@
-/*
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * Copyright (C) 1997, 2001 Ralf Baechle
- * Copyright 2001 MontaVista Software Inc.
- * Author: jsun@mvista.com or jsun@junsun.net
- */
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <asm/io.h>
-#include <asm/cacheflush.h>
-#include <asm/processor.h>
-#include <asm/reboot.h>
-#include <asm/system.h>
-
-void vr41xx_restart(char *command)
-{
-	change_c0_status((ST0_BEV | ST0_ERL), (ST0_BEV | ST0_ERL));
-	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
-	flush_cache_all();
-	write_c0_wired(0);
-	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
-}
-
-void vr41xx_halt(void)
-{
-	printk(KERN_NOTICE "\n** You can safely turn off the power\n");
-	while (1);
-}
-
-void vr41xx_power_off(void)
-{
-	vr41xx_halt();
-}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c linux/arch/mips/vr41xx/ibm-workpad/setup.c
--- linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c	Fri Jan 23 21:19:39 2004
+++ linux/arch/mips/vr41xx/ibm-workpad/setup.c	Sat Jan 31 18:58:52 2004
@@ -1,17 +1,21 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/workpad/setup.c
+ *  setup.c, Setup for the IBM WorkPad z50.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the IBM WorkPad z50.
+ *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Copyright 2002 Yoichi Yuasa
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
 #include <linux/config.h>
 #include <linux/init.h>
@@ -20,7 +24,6 @@
 #include <linux/kdev_t.h>
 #include <linux/root_dev.h>
 
-#include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/vr41xx/workpad.h>
 
@@ -43,16 +46,14 @@
 	initrd_end = (unsigned long)&__rd_end;
 #endif
 
-	_machine_restart = vr41xx_restart;
-	_machine_halt = vr41xx_halt;
-	_machine_power_off = vr41xx_power_off;
-
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
 
 	vr41xx_bcu_init();
 
 	vr41xx_cmu_init();
+
+	vr41xx_pmu_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/setup.c	Fri Jan 23 21:19:39 2004
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Sat Jan 31 18:58:52 2004
@@ -38,7 +38,6 @@
 #include <linux/root_dev.h>
 
 #include <asm/pci_channel.h>
-#include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/vr41xx/eagle.h>
 
@@ -114,10 +113,6 @@
 	initrd_end = (unsigned long)&__rd_end;
 #endif
 
-	_machine_restart = vr41xx_restart;
-	_machine_halt = vr41xx_halt;
-	_machine_power_off = vr41xx_power_off;
-
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
 
@@ -126,6 +121,8 @@
 	vr41xx_bcu_init();
 
 	vr41xx_cmu_init();
+
+	vr41xx_pmu_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_dsiu_init();
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Fri Jan 23 21:19:39 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	Sat Jan 31 18:58:52 2004
@@ -1,24 +1,27 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/tanbac-tb0226/setup.c
+ *  setup.c, Setup for the TANBAC TB0226.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the TANBAC TB0226.
+ *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 
 #include <asm/pci_channel.h>
-#include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/vr41xx/tb0226.h>
 
@@ -89,16 +92,14 @@
 	initrd_end = (unsigned long)&__rd_end;
 #endif
 
-	_machine_restart = vr41xx_restart;
-	_machine_halt = vr41xx_halt;
-	_machine_power_off = vr41xx_power_off;
-
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
 
 	vr41xx_bcu_init();
 
 	vr41xx_cmu_init();
+
+	vr41xx_pmu_init();
 
 	vr41xx_siu_init(SIU_RS232C, 0);
 
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile linux/arch/mips/vr41xx/tanbac-tb0229/Makefile
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile	Sat Jun 14 00:32:27 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0229/Makefile	Sat Jan 31 18:58:52 2004
@@ -2,4 +2,6 @@
 # Makefile for the TANBAC TB0229(VR4131DIMM) specific parts of the kernel
 #
 
-obj-y			:= init.o reboot.o setup.o
+obj-y				:= init.o setup.o
+
+obj-$(CONFIG_TANBAC_TB0219)	+= reboot.o
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/reboot.c linux/arch/mips/vr41xx/tanbac-tb0229/reboot.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/reboot.c	Tue Nov 18 12:34:23 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0229/reboot.c	Sat Jan 31 18:58:52 2004
@@ -21,11 +21,7 @@
 
 void tanbac_tb0229_restart(char *command)
 {
-#ifdef CONFIG_TANBAC_TB0219
 	local_irq_disable();
 	tb0229_hard_reset();
 	while (1);
-#else
-	vr41xx_restart(command);
-#endif
 }
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c linux/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	Fri Jan 23 21:19:39 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	Sat Jan 31 18:58:52 2004
@@ -1,21 +1,24 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/tanbac-tb0229/setup.c
+ *  setup.c, Setup for the TANBAC TB0229 (VR4131DIMM)
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the TANBAC TB0229 (VR4131DIMM)
+ *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Copyright 2002,2003 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
+ *  Modified for TANBAC TB0229:
+ *  Copyright (C) 2003  Megasolution Inc.  <matsu@megasolution.jp>
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
 #include <linux/config.h>
 #include <linux/blkdev.h>
@@ -94,10 +97,6 @@
 	initrd_end = (unsigned long)&__rd_end;
 #endif
 
-	_machine_restart = tanbac_tb0229_restart;
-	_machine_halt = vr41xx_halt;
-	_machine_power_off = vr41xx_power_off;
-
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
 
@@ -105,11 +104,17 @@
 
 	vr41xx_cmu_init();
 
+	vr41xx_pmu_init();
+
 	vr41xx_siu_init(SIU_RS232C, 0);
 	vr41xx_dsiu_init();
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
+#endif
+
+#ifdef CONFIG_TANBAC_TB0219
+	_machine_restart = tanbac_tb0229_restart;
 #endif
 }
 
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c linux/arch/mips/vr41xx/victor-mpc30x/setup.c
--- linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c	Fri Jan 23 21:19:39 2004
+++ linux/arch/mips/vr41xx/victor-mpc30x/setup.c	Sat Jan 31 18:58:52 2004
@@ -1,17 +1,21 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/victor-mpc30x/setup.c
+ *  setup.c, Setup for the Victor MP-C303/304.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the Victor MP-C303/304.
+ *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Copyright 2002 Yoichi Yuasa
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
 #include <linux/config.h>
 #include <linux/init.h>
@@ -21,7 +25,6 @@
 #include <linux/root_dev.h>
 
 #include <asm/pci_channel.h>
-#include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/vr41xx/mpc30x.h>
 
@@ -92,16 +95,14 @@
 	initrd_end = (unsigned long)&__rd_end;
 #endif
 
-	_machine_restart = vr41xx_restart;
-	_machine_halt = vr41xx_halt;
-	_machine_power_off = vr41xx_power_off;
-
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
 
 	vr41xx_bcu_init();
 
 	vr41xx_cmu_init();
+
+	vr41xx_pmu_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/setup.c linux/arch/mips/vr41xx/zao-capcella/setup.c
--- linux-orig/arch/mips/vr41xx/zao-capcella/setup.c	Fri Jan 23 21:19:39 2004
+++ linux/arch/mips/vr41xx/zao-capcella/setup.c	Sat Jan 31 18:58:52 2004
@@ -1,17 +1,21 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/zao-capcella/setup.c
+ *  setup.c, Setup for the ZAO Networks Capcella.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the ZAO Networks Capcella.
+ *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Copyright 2002 Yoichi Yuasa
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
 #include <linux/config.h>
 #include <linux/init.h>
@@ -21,7 +25,6 @@
 #include <linux/root_dev.h>
 
 #include <asm/pci_channel.h>
-#include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/vr41xx/capcella.h>
 
@@ -92,16 +95,14 @@
 	initrd_end = (unsigned long)&__rd_end;
 #endif
 
-	_machine_restart = vr41xx_restart;
-	_machine_halt = vr41xx_halt;
-	_machine_power_off = vr41xx_power_off;
-
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
 
 	vr41xx_bcu_init();
 
 	vr41xx_cmu_init();
+
+	vr41xx_pmu_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux-orig/include/asm-mips/vr41xx/vr41xx.h	Thu Dec 18 01:02:28 2003
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Sat Jan 31 18:58:53 2004
@@ -134,6 +134,11 @@
 extern int vr41xx_cascade_irq(unsigned int irq, int (*get_irq_number)(int irq));
 
 /*
+ * Power Management Unit
+ */
+extern void vr41xx_pmu_init(void);
+
+/*
  * RTC
  */
 extern void vr41xx_set_rtclong1_cycle(uint32_t cycles);
@@ -226,9 +231,5 @@
  */
 extern void vr41xx_time_init(void);
 extern void vr41xx_timer_setup(struct irqaction *irq);
-
-extern void vr41xx_restart(char *command);
-extern void vr41xx_halt(void);
-extern void vr41xx_power_off(void);
 
 #endif /* __NEC_VR41XX_H */
