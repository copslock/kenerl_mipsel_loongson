Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2004 15:27:17 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:23792 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225343AbUBJP1P>;
	Tue, 10 Feb 2004 15:27:15 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA17425;
	Wed, 11 Feb 2004 00:27:11 +0900 (JST)
Received: 4UMDO00 id i1AFRAP08783; Wed, 11 Feb 2004 00:27:10 +0900 (JST)
Received: 4UMRO01 id i1AFR8d14236; Wed, 11 Feb 2004 00:27:09 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Wed, 11 Feb 2004 00:27:06 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.4] Changed machine_restart/halt/power_off for vr41xx
Message-Id: <20040211002706.69faafb4.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made the patch for machine_restart/halt/power_off for vr41xx.
This patch updates these functions.
The same patch is already apply to v2.6.

I am going to add power management to pmu.c.

Please apply this patch to v2.4.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/casio-e55/setup.c linux/arch/mips/vr41xx/casio-e55/setup.c
--- linux-orig/arch/mips/vr41xx/casio-e55/setup.c	Tue Feb 10 23:22:07 2004
+++ linux/arch/mips/vr41xx/casio-e55/setup.c	Wed Feb 11 00:10:22 2004
@@ -1,25 +1,28 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/casio-e55/setup.c
+ *  setup.c, Setup for the CASIO CASSIOPEIA E-11/15/55/65.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the CASIO CASSIOPEIA E-11/15/55/65.
+ *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
-#include <linux/init.h>
 #include <linux/console.h>
 #include <linux/ide.h>
+#include <linux/init.h>
 #include <linux/ioport.h>
 
-#include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/vr41xx/e55.h>
 
@@ -31,10 +34,6 @@
 	iomem_resource.start = IO_MEM_RESOURCE_START;
 	iomem_resource.end = IO_MEM_RESOURCE_END;
 
-	_machine_restart = vr41xx_restart;
-	_machine_halt = vr41xx_halt;
-	_machine_power_off = vr41xx_power_off;
-
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
 
@@ -47,8 +46,8 @@
 #endif
 
 	vr41xx_bcu_init();
-
 	vr41xx_cmu_init();
+	vr41xx_pmu_init();
 
 #ifdef CONFIG_SERIAL
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/Makefile linux/arch/mips/vr41xx/common/Makefile
--- linux-orig/arch/mips/vr41xx/common/Makefile	Fri Jan 16 01:19:00 2004
+++ linux/arch/mips/vr41xx/common/Makefile	Tue Feb 10 23:45:45 2004
@@ -12,7 +12,7 @@
 
 O_TARGET := vr41xx.o
 
-obj-y := bcu.o cmu.o giu.o icu.o int-handler.o ksyms.o reset.o rtc.o
+obj-y := bcu.o cmu.o giu.o icu.o int-handler.o ksyms.o pmu.o rtc.o
 
 export-objs := ksyms.o vrc4171.o vrc4173.o
 
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/pmu.c linux/arch/mips/vr41xx/common/pmu.c
--- linux-orig/arch/mips/vr41xx/common/pmu.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/common/pmu.c	Tue Feb 10 23:45:45 2004
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
--- linux-orig/arch/mips/vr41xx/common/reset.c	Mon Dec  2 09:24:51 2002
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
-#include <asm/pgtable.h>
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
--- linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c	Tue Feb 10 23:22:07 2004
+++ linux/arch/mips/vr41xx/ibm-workpad/setup.c	Wed Feb 11 00:10:12 2004
@@ -1,25 +1,28 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/workpad/setup.c
+ *  setup.c, Setup for the IBM WorkPad z50.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the IBM WorkPad z50.
+ *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
-#include <linux/init.h>
 #include <linux/console.h>
 #include <linux/ide.h>
+#include <linux/init.h>
 #include <linux/ioport.h>
 
-#include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/vr41xx/workpad.h>
 
@@ -31,10 +34,6 @@
 	iomem_resource.start = IO_MEM_RESOURCE_START;
 	iomem_resource.end = IO_MEM_RESOURCE_END;
 
-	_machine_restart = vr41xx_restart;
-	_machine_halt = vr41xx_halt;
-	_machine_power_off = vr41xx_power_off;
-
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
 
@@ -47,8 +46,8 @@
 #endif
 
 	vr41xx_bcu_init();
-
 	vr41xx_cmu_init();
+	vr41xx_pmu_init();
 
 #ifdef CONFIG_SERIAL
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/setup.c	Sat Feb  7 10:32:18 2004
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Wed Feb 11 00:10:33 2004
@@ -1,34 +1,14 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/nec-eagle/setup.c
+ * arch/mips/vr41xx/nec-eagle/setup.c
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the NEC Eagle/Hawk board.
+ * Setup for the NEC Eagle/Hawk board.
  *
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
+ * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com>
  *
- * Copyright 2001,2002 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
+ * 2001-2004 (c) MontaVista, Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  */
 /*
  * Changes:
@@ -40,13 +20,12 @@
  *  - New creation, NEC Eagle is supported.
  */
 #include <linux/config.h>
-#include <linux/init.h>
 #include <linux/console.h>
 #include <linux/ide.h>
+#include <linux/init.h>
 #include <linux/ioport.h>
 
 #include <asm/pci_channel.h>
-#include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/vr41xx/eagle.h>
 
@@ -108,10 +87,6 @@
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
 
-	_machine_restart = vr41xx_restart;
-	_machine_halt = vr41xx_halt;
-	_machine_power_off = vr41xx_power_off;
-
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
 
@@ -126,8 +101,8 @@
 #endif
 
 	vr41xx_bcu_init();
-
 	vr41xx_cmu_init();
+	vr41xx_pmu_init();
 
 #ifdef CONFIG_SERIAL
 	vr41xx_dsiu_init();
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Tue Feb 10 23:22:07 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	Wed Feb 11 00:09:40 2004
@@ -1,25 +1,28 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/tanbac-tb0226/setup.c
+ *  setup.c, Setup for the TANBAC TB0226.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the TANBAC TB0226.
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
 #include <linux/config.h>
-#include <linux/init.h>
 #include <linux/console.h>
+#include <linux/init.h>
 #include <linux/ioport.h>
 
 #include <asm/pci_channel.h>
-#include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/vr41xx/tb0226.h>
 
@@ -76,10 +79,6 @@
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
 
-	_machine_restart = vr41xx_restart;
-	_machine_halt = vr41xx_halt;
-	_machine_power_off = vr41xx_power_off;
-
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
 
@@ -88,8 +87,8 @@
 #endif
 
 	vr41xx_bcu_init();
-
 	vr41xx_cmu_init();
+	vr41xx_pmu_init();
 
 #ifdef CONFIG_SERIAL
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile linux/arch/mips/vr41xx/tanbac-tb0229/Makefile
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile	Thu May 22 06:36:53 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0229/Makefile	Tue Feb 10 23:45:45 2004
@@ -12,8 +12,9 @@
 
 all: tb0229.o
 
-obj-y	:= init.o setup.o reboot.o
+obj-y	:= init.o setup.o
 
-obj-$(CONFIG_PCI)	+= pci_fixup.o
+obj-$(CONFIG_PCI)		+= pci_fixup.o
+obj-$(CONFIG_TANBAC_TB0219)	+= reboot.o
 
 include $(TOPDIR)/Rules.make
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/reboot.c linux/arch/mips/vr41xx/tanbac-tb0229/reboot.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/reboot.c	Thu May 22 06:36:53 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0229/reboot.c	Tue Feb 10 23:45:45 2004
@@ -16,15 +16,11 @@
 #include <asm/io.h>
 #include <asm/vr41xx/tb0229.h>
 
-#define tb0229_hard_reset()	writew(0, TB0219_RESET_REGS)
+#define tb0219_hard_reset()	writew(0, TB0219_RESET_REGS)
 
-void tanbac_tb0229_restart(char *command)
+void tanbac_tb0219_restart(char *command)
 {
-#ifdef CONFIG_TANBAC_TB0219
 	local_irq_disable();
-	tb0229_hard_reset();
+	tb0219_hard_reset();
 	while (1);
-#else
-	vr41xx_restart(command);
-#endif
 }
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c linux/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	Tue Feb 10 23:22:07 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	Wed Feb 11 00:11:06 2004
@@ -1,24 +1,26 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/tanbac-tb0229/setup.c
+ *  setup.c, Setup for the TANBAC TB0229 (VR4131DIMM)
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the TANBAC TB0229 (VR4131DIMM)
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
 #include <linux/config.h>
-#include <linux/blk.h>
 #include <linux/console.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
@@ -89,10 +91,6 @@
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
 
-	_machine_restart = tanbac_tb0229_restart;
-	_machine_halt = vr41xx_halt;
-	_machine_power_off = vr41xx_power_off;
-
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
 
@@ -101,8 +99,8 @@
 #endif
 
 	vr41xx_bcu_init();
-
 	vr41xx_cmu_init();
+	vr41xx_pmu_init();
 
 #ifdef CONFIG_SERIAL
 	vr41xx_siu_init(SIU_RS232C, 0);
@@ -112,5 +110,8 @@
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
 #endif
-}
 
+#ifdef CONFIG_TANBAC_TB0219
+	_machine_restart = tanbac_tb0219_restart;
+#endif
+}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c linux/arch/mips/vr41xx/victor-mpc30x/setup.c
--- linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c	Tue Feb 10 23:22:07 2004
+++ linux/arch/mips/vr41xx/victor-mpc30x/setup.c	Wed Feb 11 00:13:25 2004
@@ -1,26 +1,29 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/victor-mpc30x/setup.c
+ *  setup.c, Setup for the Victor MP-C303/304.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the Victor MP-C303/304.
+ *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
-#include <linux/init.h>
 #include <linux/console.h>
 #include <linux/ide.h>
+#include <linux/init.h>
 #include <linux/ioport.h>
 
 #include <asm/pci_channel.h>
-#include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/vr41xx/mpc30x.h>
 
@@ -77,10 +80,6 @@
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
 
-	_machine_restart = vr41xx_restart;
-	_machine_halt = vr41xx_halt;
-	_machine_power_off = vr41xx_power_off;
-
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
 
@@ -93,8 +92,8 @@
 #endif
 
 	vr41xx_bcu_init();
-
 	vr41xx_cmu_init();
+	vr41xx_pmu_init();
 
 #ifdef CONFIG_SERIAL
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/setup.c linux/arch/mips/vr41xx/zao-capcella/setup.c
--- linux-orig/arch/mips/vr41xx/zao-capcella/setup.c	Tue Feb 10 23:22:07 2004
+++ linux/arch/mips/vr41xx/zao-capcella/setup.c	Wed Feb 11 00:15:24 2004
@@ -1,26 +1,29 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/zao-capcella/setup.c
+ *  setup.c, Setup for the ZAO Networks Capcella.
  *
- * BRIEF MODULE DESCRIPTION
- *	Setup for the ZAO Networks Capcella.
+ *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
-#include <linux/init.h>
 #include <linux/console.h>
 #include <linux/ide.h>
+#include <linux/init.h>
 #include <linux/ioport.h>
 
 #include <asm/pci_channel.h>
-#include <asm/reboot.h>
 #include <asm/time.h>
 #include <asm/vr41xx/capcella.h>
 
@@ -77,10 +80,6 @@
 	iomem_resource.start = IO_MEM1_RESOURCE_START;
 	iomem_resource.end = IO_MEM2_RESOURCE_END;
 
-	_machine_restart = vr41xx_restart;
-	_machine_halt = vr41xx_halt;
-	_machine_power_off = vr41xx_power_off;
-
 	board_time_init = vr41xx_time_init;
 	board_timer_setup = vr41xx_timer_setup;
 
@@ -93,8 +92,8 @@
 #endif
 
 	vr41xx_bcu_init();
-
 	vr41xx_cmu_init();
+	vr41xx_pmu_init();
 
 #ifdef CONFIG_SERIAL
 	vr41xx_siu_init(SIU_RS232C, 0);
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/tb0229.h linux/include/asm-mips/vr41xx/tb0229.h
--- linux-orig/include/asm-mips/vr41xx/tb0229.h	Thu May 22 06:36:53 2003
+++ linux/include/asm-mips/vr41xx/tb0229.h	Tue Feb 10 23:45:46 2004
@@ -68,6 +68,6 @@
 
 #define TB0219_RESET_REGS		KSEG1ADDR(0x0a00000e)
 
-extern void tanbac_tb0229_restart(char *command);
+extern void tanbac_tb0219_restart(char *command);
 
 #endif /* __TANBAC_TB0229_H */
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux-orig/include/asm-mips/vr41xx/vr41xx.h	Tue Feb 10 22:33:56 2004
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Tue Feb 10 23:45:46 2004
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
@@ -228,10 +233,6 @@
  */
 extern void vr41xx_time_init(void);
 extern void vr41xx_timer_setup(struct irqaction *irq);
-
-extern void vr41xx_restart(char *command);
-extern void vr41xx_halt(void);
-extern void vr41xx_power_off(void);
 
 #if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE)
 extern struct ide_ops vr41xx_ide_ops;
