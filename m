Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2004 14:36:19 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:21975 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225073AbUBXOgQ>;
	Tue, 24 Feb 2004 14:36:16 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id XAA23173;
	Tue, 24 Feb 2004 23:36:09 +0900 (JST)
Received: 4UMDO00 id i1OEa8v08621; Tue, 24 Feb 2004 23:36:08 +0900 (JST)
Received: 4UMRO01 id i1OEa7G14658; Tue, 24 Feb 2004 23:36:07 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date:	Tue, 24 Feb 2004 23:36:06 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] VR41xx patches for v2.6
Message-Id: <20040224233606.2e2f2467.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I made a patch that summarizes the same code for vr41xx to one file.
In order to apply this patch, it is necessary to apply the patches sent before.

I already sent the following patches to you.

1. [PATCH][2.6] Update NEC VRC4171 PCMCIA driver

This patch adds NEC VRC4171 PCMCIA contoller support to v2.6.
http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v26/00-vrc4171_pccard-v26.diff

2. [PATCH][2.6] Changed clock functions for vr41xx

This patch changes a clock function for a power management.
http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v26/01-cmu-v26.diff

3. [PATCH][2.6] Moved timer setup to common part for vr41xx

This patch get together setup of dispersed timer to one place.
http://www.hh.iij4u.or.jp/~yuasa/linux-vr/v26/02-rtc-v26.diff

Please apply these patches to v2.6.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/casio-e55/Makefile linux/arch/mips/vr41xx/casio-e55/Makefile
--- linux-orig/arch/mips/vr41xx/casio-e55/Makefile	Wed Jul 30 22:36:55 2003
+++ linux/arch/mips/vr41xx/casio-e55/Makefile	Sat Feb 21 17:38:18 2004
@@ -2,4 +2,4 @@
 # Makefile for the CASIO CASSIOPEIA E-55/65 specific parts of the kernel
 #
 
-obj-y			+= init.o setup.o
+obj-y			+= setup.o
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/casio-e55/init.c linux/arch/mips/vr41xx/casio-e55/init.c
--- linux-orig/arch/mips/vr41xx/casio-e55/init.c	Thu Jan 29 23:17:19 2004
+++ linux/arch/mips/vr41xx/casio-e55/init.c	Thu Jan  1 09:00:00 1970
@@ -1,49 +0,0 @@
-/*
- * FILE NAME
- *	arch/mips/vr41xx/casio-e55/init.c
- *
- * BRIEF MODULE DESCRIPTION
- *	Initialisation code for the CASIO CASSIOPEIA E-55/65.
- *
- * Copyright 2002 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
-
-const char *get_system_type(void)
-{
-	return "CASIO CASSIOPEIA E-11/15/55/65";
-}
-
-void __init prom_init(void)
-{
-	int argc = fw_arg0;
-	char **argv = (char **) fw_arg1;
-	int i;
-
-	/*
-	 * collect args and prepare cmd_line
-	 */
-	for (i = 1; i < argc; i++) {
-		strcat(arcs_cmdline, argv[i]);
-		if (i < (argc - 1))
-			strcat(arcs_cmdline, " ");
-	}
-
-	mips_machgroup = MACH_GROUP_NEC_VR41XX;
-	mips_machtype = MACH_CASIO_E55;
-}
-
-unsigned long __init prom_free_prom_memory(void)
-{
-	return 0;
-}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/casio-e55/setup.c linux/arch/mips/vr41xx/casio-e55/setup.c
--- linux-orig/arch/mips/vr41xx/casio-e55/setup.c	Sat Feb 21 17:37:17 2004
+++ linux/arch/mips/vr41xx/casio-e55/setup.c	Sat Feb 21 23:27:24 2004
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the CASIO CASSIOPEIA E-11/15/55/65.
  *
- *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -18,44 +18,27 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/config.h>
-#include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/major.h>
-#include <linux/kdev_t.h>
-#include <linux/root_dev.h>
 
+#include <asm/io.h>
 #include <asm/vr41xx/e55.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
+const char *get_system_type(void)
+{
+	return "CASIO CASSIOPEIA E-11/15/55/65";
+}
 
-static void __init casio_e55_setup(void)
+static int casio_e55_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
 	ioport_resource.end = IO_PORT_RESOURCE_END;
-	iomem_resource.start = IO_MEM_RESOURCE_START;
-	iomem_resource.end = IO_MEM_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = Root_RAM0;
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
-
-	vr41xx_bcu_init();
-
-	vr41xx_cmu_init();
-
-	vr41xx_pmu_init();
-
-	vr41xx_rtc_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
 #endif
+
+	return 0;
 }
 
 early_initcall(casio_e55_setup);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/Makefile linux/arch/mips/vr41xx/common/Makefile
--- linux-orig/arch/mips/vr41xx/common/Makefile	Sun Feb  1 21:41:34 2004
+++ linux/arch/mips/vr41xx/common/Makefile	Sat Feb 21 17:38:18 2004
@@ -2,7 +2,7 @@
 # Makefile for common code of the NEC VR4100 series.
 #
 
-obj-y				+= bcu.o cmu.o giu.o icu.o int-handler.o ksyms.o pmu.o rtc.o
+obj-y				+= bcu.o cmu.o giu.o icu.o init.o int-handler.o ksyms.o pmu.o rtc.o
 obj-$(CONFIG_SERIAL_8250)	+= serial.o
 obj-$(CONFIG_VRC4171)		+= vrc4171.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/init.c linux/arch/mips/vr41xx/common/init.c
--- linux-orig/arch/mips/vr41xx/common/init.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/vr41xx/common/init.c	Sat Feb 21 18:05:40 2004
@@ -0,0 +1,58 @@
+/*
+ *  init.c, Common initialization routines for NEC VR4100 series.
+ *
+ *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
+#include <linux/ioport.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+#include <asm/vr41xx/vr41xx.h>
+
+extern void vr41xx_bcu_init(void);
+extern void vr41xx_cmu_init(void);
+extern void vr41xx_pmu_init(void);
+extern void vr41xx_rtc_init(void);
+
+void __init prom_init(void)
+{
+	int argc, i;
+	char **argv;
+
+	argc = fw_arg0;
+	argv = (char **)fw_arg1;
+
+	for (i = 1; i < argc; i++) {
+		strcat(arcs_cmdline, argv[i]);
+		if (i < (argc - 1))
+			strcat(arcs_cmdline, " ");
+	}
+
+	iomem_resource.start = IO_MEM_RESOURCE_START;
+	iomem_resource.end = IO_MEM_RESOURCE_END;
+
+	vr41xx_bcu_init();
+	vr41xx_cmu_init();
+	vr41xx_pmu_init();
+	vr41xx_rtc_init();
+}
+
+unsigned long __init prom_free_prom_memory (void)
+{
+	return 0UL;
+}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/ibm-workpad/Makefile linux/arch/mips/vr41xx/ibm-workpad/Makefile
--- linux-orig/arch/mips/vr41xx/ibm-workpad/Makefile	Wed Jul 30 22:36:55 2003
+++ linux/arch/mips/vr41xx/ibm-workpad/Makefile	Sat Feb 21 17:38:18 2004
@@ -2,4 +2,4 @@
 # Makefile for the IBM WorkPad z50 specific parts of the kernel
 #
 
-obj-y			+= init.o setup.o
+obj-y			+= setup.o
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/ibm-workpad/init.c linux/arch/mips/vr41xx/ibm-workpad/init.c
--- linux-orig/arch/mips/vr41xx/ibm-workpad/init.c	Thu Jan 29 23:17:19 2004
+++ linux/arch/mips/vr41xx/ibm-workpad/init.c	Thu Jan  1 09:00:00 1970
@@ -1,49 +0,0 @@
-/*
- * FILE NAME
- *	arch/mips/vr41xx/ibm-workpad/init.c
- *
- * BRIEF MODULE DESCRIPTION
- *	Initialisation code for the IBM WorkPad z50.
- *
- * Copyright 2002 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
-
-const char *get_system_type(void)
-{
-	return "IBM WorkPad z50";
-}
-
-void __init prom_init(void)
-{
-	int argc = fw_arg0;
-	char **argv = (char **) fw_arg1;
-	int i;
-
-	/*
-	 * collect args and prepare cmd_line
-	 */
-	for (i = 1; i < argc; i++) {
-		strcat(arcs_cmdline, argv[i]);
-		if (i < (argc - 1))
-			strcat(arcs_cmdline, " ");
-	}
-
-	mips_machgroup = MACH_GROUP_NEC_VR41XX;
-	mips_machtype = MACH_IBM_WORKPAD;
-}
-
-unsigned long __init prom_free_prom_memory(void)
-{
-	return 0;
-}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c linux/arch/mips/vr41xx/ibm-workpad/setup.c
--- linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c	Sat Feb 21 17:37:18 2004
+++ linux/arch/mips/vr41xx/ibm-workpad/setup.c	Sat Feb 21 23:34:32 2004
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the IBM WorkPad z50.
  *
- *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -18,44 +18,27 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/config.h>
-#include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/major.h>
-#include <linux/kdev_t.h>
-#include <linux/root_dev.h>
 
+#include <asm/io.h>
 #include <asm/vr41xx/workpad.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
+const char *get_system_type(void)
+{
+	return "IBM WorkPad z50";
+}
 
-static void __init ibm_workpad_setup(void)
+static int ibm_workpad_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
 	ioport_resource.end = IO_PORT_RESOURCE_END;
-	iomem_resource.start = IO_MEM_RESOURCE_START;
-	iomem_resource.end = IO_MEM_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = Root_RAM0;
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
-
-	vr41xx_bcu_init();
-
-	vr41xx_cmu_init();
-
-	vr41xx_pmu_init();
-
-	vr41xx_rtc_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
 #endif
+
+	return 0;
 }
 
 early_initcall(ibm_workpad_setup);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/Makefile linux/arch/mips/vr41xx/nec-eagle/Makefile
--- linux-orig/arch/mips/vr41xx/nec-eagle/Makefile	Wed Jul 30 22:36:55 2003
+++ linux/arch/mips/vr41xx/nec-eagle/Makefile	Sat Feb 21 17:38:18 2004
@@ -7,4 +7,4 @@
 # Copyright 2001,2002 MontaVista Software Inc.
 #
 
-obj-y			+= init.o irq.o setup.o
+obj-y			+= irq.o setup.o
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/init.c linux/arch/mips/vr41xx/nec-eagle/init.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/init.c	Thu Jan 29 23:17:22 2004
+++ linux/arch/mips/vr41xx/nec-eagle/init.c	Thu Jan  1 09:00:00 1970
@@ -1,74 +0,0 @@
-/*
- * FILE NAME
- *	arch/mips/vr41xx/nec-eagle/init.c
- *
- * BRIEF MODULE DESCRIPTION
- *	Initialisation code for the NEC Eagle/Hawk board.
- *
- * Author: Yoichi Yuasa
- *         yyuasa@mvista.com or source@mvista.com
- *
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
- */
-/*
- * Changes:
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - Added support for NEC Hawk.
- *
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC Eagle is supported.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
-
-const char *get_system_type(void)
-{
-	return "NEC Eagle/Hawk";
-}
-
-void __init prom_init(void)
-{
-	int argc = fw_arg0;
-	char **argv = (char **) fw_arg1;
-	int i;
-
-	/*
-	 * collect args and prepare cmd_line
-	 */
-	for (i = 1; i < argc; i++) {
-		strcat(arcs_cmdline, argv[i]);
-		if (i < (argc - 1))
-			strcat(arcs_cmdline, " ");
-	}
-
-	mips_machgroup = MACH_GROUP_NEC_VR41XX;
-	mips_machtype = MACH_NEC_EAGLE;
-}
-
-unsigned long __init prom_free_prom_memory(void)
-{
-	return 0;
-}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/setup.c	Sat Feb 21 17:37:18 2004
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Sat Feb 21 23:35:30 2004
@@ -11,20 +11,12 @@
  * or implied.
  */
 #include <linux/config.h>
-#include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/major.h>
-#include <linux/kdev_t.h>
-#include <linux/root_dev.h>
 
+#include <asm/io.h>
 #include <asm/pci_channel.h>
 #include <asm/vr41xx/eagle.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 extern void eagle_irq_init(void);
 
 #ifdef CONFIG_PCI
@@ -78,29 +70,18 @@
 };
 #endif
 
+const char *get_system_type(void)
+{
+	return "NEC SDB-VR4122/VR4131(Eagle/Hawk)";
+}
+
 static int nec_eagle_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
 	ioport_resource.end = IO_PORT_RESOURCE_END;
-	iomem_resource.start = IO_MEM1_RESOURCE_START;
-	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = Root_RAM0;
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
 
 	board_irq_init = eagle_irq_init;
-
-	vr41xx_bcu_init();
-
-	vr41xx_cmu_init();
-
-	vr41xx_pmu_init();
-
-	vr41xx_rtc_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_dsiu_init();
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/Makefile linux/arch/mips/vr41xx/tanbac-tb0226/Makefile
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/Makefile	Sat Jun 14 00:32:27 2003
+++ linux/arch/mips/vr41xx/tanbac-tb0226/Makefile	Sat Feb 21 17:38:18 2004
@@ -2,4 +2,4 @@
 # Makefile for the TANBAC TB0226 specific parts of the kernel
 #
 
-obj-y			+= init.o setup.o
+obj-y			+= setup.o
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/init.c linux/arch/mips/vr41xx/tanbac-tb0226/init.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/init.c	Thu Jan 29 23:17:22 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0226/init.c	Thu Jan  1 09:00:00 1970
@@ -1,53 +0,0 @@
-/*
- * FILE NAME
- *	arch/mips/vr41xx/tanbac-tb0226/init.c
- *
- * BRIEF MODULE DESCRIPTION
- *	Initialisation code for the TANBAC TB0226.
- *
- * Copyright 2002,2003 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/smp.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
-#include <asm/cpu.h>
-#include <asm/mipsregs.h>
-#include <asm/vr41xx/vr41xx.h>
-
-const char *get_system_type(void)
-{
-	return "TANBAC TB0226";
-}
-
-void __init prom_init(void)
-{
-	int argc = fw_arg0;
-	char **argv = (char **) fw_arg1;
-	int i;
-
-	/*
-	 * collect args and prepare cmd_line
-	 */
-	for (i = 1; i < argc; i++) {
-		strcat(arcs_cmdline, argv[i]);
-		if (i < (argc - 1))
-			strcat(arcs_cmdline, " ");
-	}
-
-	mips_machgroup = MACH_GROUP_NEC_VR41XX;
-	mips_machtype = MACH_TANBAC_TB0226;
-}
-
-unsigned long __init prom_free_prom_memory(void)
-{
-	return 0;
-}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Sat Feb 21 17:37:18 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	Sat Feb 21 23:35:53 2004
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the TANBAC TB0226.
  *
- *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -18,17 +18,12 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/config.h>
-#include <linux/init.h>
 #include <linux/ioport.h>
 
+#include <asm/io.h>
 #include <asm/pci_channel.h>
 #include <asm/vr41xx/tb0226.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 #ifdef CONFIG_PCI
 static struct resource vr41xx_pci_io_resource = {
 	.name	= "PCI I/O space",
@@ -77,33 +72,24 @@
 };
 #endif
 
-void __init tanbac_tb0226_setup(void)
+const char *get_system_type(void)
+{
+	return "TANBAC TB0226";
+}
+
+static int tanbac_tb0226_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
 	ioport_resource.end = IO_PORT_RESOURCE_END;
-	iomem_resource.start = IO_MEM1_RESOURCE_START;
-	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
-
-	vr41xx_bcu_init();
-
-	vr41xx_cmu_init();
-
-	vr41xx_pmu_init();
-
-	vr41xx_rtc_init();
 
 	vr41xx_siu_init(SIU_RS232C, 0);
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
 #endif
+
+	return 0;
 }
 
 early_initcall(tanbac_tb0226_setup);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile linux/arch/mips/vr41xx/tanbac-tb0229/Makefile
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile	Sun Feb  1 21:41:34 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0229/Makefile	Sat Feb 21 17:38:18 2004
@@ -2,6 +2,6 @@
 # Makefile for the TANBAC TB0229(VR4131DIMM) specific parts of the kernel
 #
 
-obj-y				:= init.o setup.o
+obj-y				:= setup.o
 
 obj-$(CONFIG_TANBAC_TB0219)	+= reboot.o
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/init.c linux/arch/mips/vr41xx/tanbac-tb0229/init.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/init.c	Thu Jan 29 23:17:22 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0229/init.c	Thu Jan  1 09:00:00 1970
@@ -1,58 +0,0 @@
-/*
- * FILE NAME
- *	arch/mips/vr41xx/tanbac-tb0229/init.c
- *
- * BRIEF MODULE DESCRIPTION
- *	Initialisation code for the TANBAC TB0229(VR4131DIMM)
- *
- * Copyright 2002,2003 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
- *
- * Modified for TANBAC TB0229:
- * Copyright 2003 Megasolution Inc.
- *                matsu@megasolution.jp
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/smp.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
-#include <asm/cpu.h>
-#include <asm/mipsregs.h>
-#include <asm/vr41xx/vr41xx.h>
-
-const char *get_system_type(void)
-{
-	return "TANBAC TB0229";
-}
-
-void __init prom_init(void)
-{
-	int argc = fw_arg0;
-	char **argv = (char **) fw_arg1;
-	int i;
-
-	/*
-	 * collect args and prepare cmd_line
-	 */
-	for (i = 1; i < argc; i++) {
-		strcat(arcs_cmdline, argv[i]);
-		if (i < (argc - 1))
-			strcat(arcs_cmdline, " ");
-	}
-
-	mips_machgroup = MACH_GROUP_NEC_VR41XX;
-	mips_machtype = MACH_TANBAC_TB0229;
-}
-
-unsigned long __init prom_free_prom_memory(void)
-{
-	return 0;
-}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c linux/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	Sat Feb 21 17:37:18 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	Sat Feb 21 23:36:13 2004
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the TANBAC TB0229 (VR4131DIMM)
  *
- *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  Modified for TANBAC TB0229:
  *  Copyright (C) 2003  Megasolution Inc.  <matsu@megasolution.jp>
@@ -21,19 +21,13 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/config.h>
-#include <linux/blkdev.h>
-#include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/root_dev.h>
 
+#include <asm/io.h>
 #include <asm/pci_channel.h>
 #include <asm/reboot.h>
 #include <asm/vr41xx/tb0229.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern void * __rd_start, * __rd_end;
-#endif
-
 #ifdef CONFIG_PCI
 static struct resource vr41xx_pci_io_resource = {
 	.name	= "PCI I/O space",
@@ -82,27 +76,16 @@
 };
 #endif
 
-static void __init tanbac_tb0229_setup(void)
+const char *get_system_type(void)
+{
+	return "TANBAC TB0229";
+}
+
+static int tanbac_tb0229_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
 	ioport_resource.end = IO_PORT_RESOURCE_END;
-	iomem_resource.start = IO_MEM1_RESOURCE_START;
-	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
-
-	vr41xx_bcu_init();
-
-	vr41xx_cmu_init();
-
-	vr41xx_pmu_init();
-
-	vr41xx_rtc_init();
 
 	vr41xx_siu_init(SIU_RS232C, 0);
 	vr41xx_dsiu_init();
@@ -114,6 +97,8 @@
 #ifdef CONFIG_TANBAC_TB0219
 	_machine_restart = tanbac_tb0229_restart;
 #endif
+
+	return 0;
 }
 
 early_initcall(tanbac_tb0229_setup);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/victor-mpc30x/Makefile linux/arch/mips/vr41xx/victor-mpc30x/Makefile
--- linux-orig/arch/mips/vr41xx/victor-mpc30x/Makefile	Wed Jul 30 22:36:55 2003
+++ linux/arch/mips/vr41xx/victor-mpc30x/Makefile	Sat Feb 21 17:38:18 2004
@@ -2,4 +2,4 @@
 # Makefile for the Victor MP-C303/304 specific parts of the kernel
 #
 
-obj-y			+= init.o setup.o
+obj-y			+= setup.o
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/victor-mpc30x/init.c linux/arch/mips/vr41xx/victor-mpc30x/init.c
--- linux-orig/arch/mips/vr41xx/victor-mpc30x/init.c	Thu Jan 29 23:17:23 2004
+++ linux/arch/mips/vr41xx/victor-mpc30x/init.c	Thu Jan  1 09:00:00 1970
@@ -1,54 +0,0 @@
-/*
- * FILE NAME
- *	arch/mips/vr41xx/victor-mpc30x/init.c
- *
- * BRIEF MODULE DESCRIPTION
- *	Initialisation code for the Victor MP-C303/304.
- *
- * Copyright 2002 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
-#include <asm/cpu.h>
-#include <asm/mipsregs.h>
-#include <asm/vr41xx/vr41xx.h>
-
-const char *get_system_type(void)
-{
-	return "Victor MP-C303/304";
-}
-
-void __init prom_init(void)
-{
-	int argc = fw_arg0;
-	char **argv = (char **) fw_arg1;
-	int i;
-
-	/*
-	 * collect args and prepare cmd_line
-	 */
-	for (i = 1; i < argc; i++) {
-		strcat(arcs_cmdline, argv[i]);
-		if (i < (argc - 1))
-			strcat(arcs_cmdline, " ");
-	}
-
-	mips_machgroup = MACH_GROUP_NEC_VR41XX;
-	mips_machtype = MACH_VICTOR_MPC30X;
-
-	add_memory_region(0, 32 << 20, BOOT_MEM_RAM);
-}
-
-unsigned long __init prom_free_prom_memory(void)
-{
-	return 0;
-}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c linux/arch/mips/vr41xx/victor-mpc30x/setup.c
--- linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c	Sat Feb 21 17:37:18 2004
+++ linux/arch/mips/vr41xx/victor-mpc30x/setup.c	Sat Feb 21 23:36:44 2004
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the Victor MP-C303/304.
  *
- *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -18,20 +18,12 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/config.h>
-#include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/major.h>
-#include <linux/kdev_t.h>
-#include <linux/root_dev.h>
 
+#include <asm/io.h>
 #include <asm/pci_channel.h>
 #include <asm/vr41xx/mpc30x.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 #ifdef CONFIG_PCI
 static struct resource vr41xx_pci_io_resource = {
 	"PCI I/O space",
@@ -80,27 +72,16 @@
 };
 #endif
 
-static void __init victor_mpc30x_setup(void)
+const char *get_system_type(void)
+{
+	return "Victor MP-C303/304";
+}
+
+static int victor_mpc30x_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
 	ioport_resource.end = IO_PORT_RESOURCE_END;
-	iomem_resource.start = IO_MEM1_RESOURCE_START;
-	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = Root_RAM0;
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
-
-	vr41xx_bcu_init();
-
-	vr41xx_cmu_init();
-
-	vr41xx_pmu_init();
-
-	vr41xx_rtc_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
@@ -109,6 +90,8 @@
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
 #endif
+
+	return 0;
 }
 
 early_initcall(victor_mpc30x_setup);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/Makefile linux/arch/mips/vr41xx/zao-capcella/Makefile
--- linux-orig/arch/mips/vr41xx/zao-capcella/Makefile	Wed Jul 30 22:36:55 2003
+++ linux/arch/mips/vr41xx/zao-capcella/Makefile	Sat Feb 21 17:38:18 2004
@@ -2,4 +2,4 @@
 # Makefile for the ZAO Networks Capcella  specific parts of the kernel
 #
 
-obj-y			+= init.o setup.o
+obj-y			+= setup.o
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/init.c linux/arch/mips/vr41xx/zao-capcella/init.c
--- linux-orig/arch/mips/vr41xx/zao-capcella/init.c	Thu Jan 29 23:17:23 2004
+++ linux/arch/mips/vr41xx/zao-capcella/init.c	Thu Jan  1 09:00:00 1970
@@ -1,53 +0,0 @@
-/*
- * FILE NAME
- *	arch/mips/vr41xx/zao-capcella/init.c
- *
- * BRIEF MODULE DESCRIPTION
- *	Initialisation code for the ZAO Networks Capcella.
- *
- * Copyright 2002 Yoichi Yuasa
- *                yuasa@hh.iij4u.or.jp
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/smp.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
-#include <asm/cpu.h>
-#include <asm/mipsregs.h>
-#include <asm/vr41xx/vr41xx.h>
-
-const char *get_system_type(void)
-{
-	return "ZAO Networks Capcella";
-}
-
-void __init prom_init(int argc, char **argv, unsigned long magic, int *prom_vec)
-{
-	int argc = fw_arg0;
-	char **argv = (char **) fw_arg1;
-	int i;
-
-	/*
-	 * collect args and prepare cmd_line
-	 */
-	for (i = 1; i < argc; i++) {
-		strcat(arcs_cmdline, argv[i]);
-		if (i < (argc - 1))
-			strcat(arcs_cmdline, " ");
-	}
-
-	mips_machgroup = MACH_GROUP_NEC_VR41XX;
-	mips_machtype = MACH_ZAO_CAPCELLA;
-}
-
-unsigned long __init prom_free_prom_memory(void)
-{
-	return 0;
-}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/setup.c linux/arch/mips/vr41xx/zao-capcella/setup.c
--- linux-orig/arch/mips/vr41xx/zao-capcella/setup.c	Sat Feb 21 17:37:18 2004
+++ linux/arch/mips/vr41xx/zao-capcella/setup.c	Sat Feb 21 23:37:17 2004
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the ZAO Networks Capcella.
  *
- *  Copyright (C) 2002-2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -18,20 +18,12 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/config.h>
-#include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/major.h>
-#include <linux/kdev_t.h>
-#include <linux/root_dev.h>
 
+#include <asm/io.h>
 #include <asm/pci_channel.h>
 #include <asm/vr41xx/capcella.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
-extern unsigned long initrd_start, initrd_end;
-extern void * __rd_start, * __rd_end;
-#endif
-
 #ifdef CONFIG_PCI
 static struct resource vr41xx_pci_io_resource = {
 	"PCI I/O space",
@@ -80,27 +72,16 @@
 };
 #endif
 
-static void __init zao_capcella_setup(void)
+const char *get_system_type(void)
+{
+	return "ZAO Networks Capcella";
+}
+
+static int zao_capcella_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
 	ioport_resource.end = IO_PORT_RESOURCE_END;
-	iomem_resource.start = IO_MEM1_RESOURCE_START;
-	iomem_resource.end = IO_MEM2_RESOURCE_END;
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	ROOT_DEV = Root_RAM0;
-	initrd_start = (unsigned long)&__rd_start;
-	initrd_end = (unsigned long)&__rd_end;
-#endif
-
-	vr41xx_bcu_init();
-
-	vr41xx_cmu_init();
-
-	vr41xx_pmu_init();
-
-	vr41xx_rtc_init();
 
 #ifdef CONFIG_SERIAL_8250
 	vr41xx_siu_init(SIU_RS232C, 0);
@@ -110,6 +91,8 @@
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
 #endif
+
+	return 0;
 }
 
 early_initcall(zao_capcella_setup);
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/e55.h linux/include/asm-mips/vr41xx/e55.h
--- linux-orig/include/asm-mips/vr41xx/e55.h	Fri Oct  4 01:57:50 2002
+++ linux/include/asm-mips/vr41xx/e55.h	Sat Feb 21 23:25:47 2004
@@ -1,17 +1,21 @@
 /*
- * FILE NAME
- *	include/asm-mips/vr41xx/e55.h
+ *  e55.h, Include file for CASIO CASSIOPEIA E-10/15/55/65.
  *
- * BRIEF MODULE DESCRIPTION
- *	Include file for CASIO CASSIOPEIA E-10/15/55/65.
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
 #ifndef __CASIO_E55_H
 #define __CASIO_E55_H
@@ -25,13 +29,15 @@
 #define VR41XX_ISA_MEM_BASE		0x10000000
 #define VR41XX_ISA_MEM_SIZE		0x04000000
 
-#define VR41XX_ISA_IO_BASE		0x14000000
-#define VR41XX_ISA_IO_SIZE		0x04000000
+/* VR41XX_ISA_IO_BASE includes offset from real base. */
+#define VR41XX_ISA_IO_BASE		0x1400c000
+#define VR41XX_ISA_IO_SIZE		0x03ff4000
+
+#define ISA_BUS_IO_BASE			0
+#define ISA_BUS_IO_SIZE			VR41XX_ISA_IO_SIZE
 
 #define IO_PORT_BASE			KSEG1ADDR(VR41XX_ISA_IO_BASE)
-#define IO_PORT_RESOURCE_START		0
-#define IO_PORT_RESOURCE_END		VR41XX_ISA_IO_SIZE
-#define IO_MEM_RESOURCE_START		VR41XX_ISA_MEM_BASE
-#define IO_MEM_RESOURCE_END		(VR41XX_ISA_MEM_BASE + VR41XX_ISA_MEM_SIZE)
+#define IO_PORT_RESOURCE_START		ISA_BUS_IO_BASE
+#define IO_PORT_RESOURCE_END		(ISA_BUS_IO_BASE + ISA_BUS_IO_SIZE - 1)
 
 #endif /* __CASIO_E55_H */
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux-orig/include/asm-mips/vr41xx/vr41xx.h	Sat Feb 21 17:37:18 2004
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Sat Feb 21 17:54:56 2004
@@ -43,17 +43,20 @@
 #define PRID_VR4133		0x00000c84
 
 /*
+ * Memory resource
+ */
+#define IO_MEM_RESOURCE_START	0UL
+#define IO_MEM_RESOURCE_END	0x1fffffffUL
+
+/*
  * Bus Control Uint
  */
-extern void vr41xx_bcu_init(void);
 extern unsigned long vr41xx_get_vtclock_frequency(void);
 extern unsigned long vr41xx_get_tclock_frequency(void);
 
 /*
  * Clock Mask Unit
  */
-extern void vr41xx_cmu_init(void);
-
 typedef enum {
 	PIU_CLOCK,
 	SIU_CLOCK,
@@ -137,7 +140,6 @@
 /*
  * Power Management Unit
  */
-extern void vr41xx_pmu_init(void);
 
 /*
  * RTC
@@ -150,8 +152,6 @@
 
 extern void vr41xx_set_tclock_cycle(uint32_t cycles);
 extern uint32_t vr41xx_read_tclock_counter(void);
-
-extern void vr41xx_rtc_init(void);
 
 /*
  * General-Purpose I/O Unit
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/workpad.h linux/include/asm-mips/vr41xx/workpad.h
--- linux-orig/include/asm-mips/vr41xx/workpad.h	Wed Jul 30 22:36:56 2003
+++ linux/include/asm-mips/vr41xx/workpad.h	Sat Feb 21 20:50:35 2004
@@ -1,17 +1,21 @@
 /*
- * FILE NAME
- *	include/asm-mips/vr41xx/workpad.h
+ *  workpad.h, Include file for IBM WorkPad z50.
  *
- * BRIEF MODULE DESCRIPTION
- *	Include file for IBM WorkPad z50.
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
 #ifndef __IBM_WORKPAD_H
 #define __IBM_WORKPAD_H
@@ -29,10 +33,11 @@
 #define VR41XX_ISA_IO_BASE		0x15000000
 #define VR41XX_ISA_IO_SIZE		0x03000000
 
+#define ISA_BUS_IO_BASE			0
+#define ISA_BUS_IO_SIZE			VR41XX_ISA_IO_SIZE
+
 #define IO_PORT_BASE			KSEG1ADDR(VR41XX_ISA_IO_BASE)
-#define IO_PORT_RESOURCE_START		0
-#define IO_PORT_RESOURCE_END		VR41XX_ISA_IO_SIZE
-#define IO_MEM_RESOURCE_START		VR41XX_ISA_MEM_BASE
-#define IO_MEM_RESOURCE_END		(VR41XX_ISA_MEM_BASE + VR41XX_ISA_MEM_SIZE)
+#define IO_PORT_RESOURCE_START		ISA_BUS_IO_BASE
+#define IO_PORT_RESOURCE_END		(ISA_BUS_IO_BASE + ISA_BUS_IO_SIZE - 1)
 
 #endif /* __IBM_WORKPAD_H */
