Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 May 2005 15:34:28 +0100 (BST)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:8941 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224982AbVEHOeJ>;
	Sun, 8 May 2005 15:34:09 +0100
Received: MO(mo01)id j48EXmeF013139; Sun, 8 May 2005 23:33:48 +0900 (JST)
Received: MDO(mdo01) id j48EXlOc028976; Sun, 8 May 2005 23:33:47 +0900 (JST)
Received: from stratos (h042.p502.iij4u.or.jp [210.149.246.42])
	by mbox.iij4u.or.jp (4U-MR/mbox00) id j48EXkgs021753
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Sun, 8 May 2005 23:33:46 +0900 (JST)
Date:	Sun, 8 May 2005 23:33:43 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: remove obsolete serial setup
Message-Id: <20050508233343.211ae78f.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch had removed obsolete serial setup for vr41xx.
New vr41xx serial driver is included in 2.6.12-rc3.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff b-orig/arch/mips/vr41xx/casio-e55/setup.c b/arch/mips/vr41xx/casio-e55/setup.c
--- b-orig/arch/mips/vr41xx/casio-e55/setup.c	Thu Apr 29 10:42:48 2004
+++ b/arch/mips/vr41xx/casio-e55/setup.c	Sat Apr 23 10:10:19 2005
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the CASIO CASSIOPEIA E-11/15/55/65.
  *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -17,7 +17,6 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/config.h>
 #include <linux/ioport.h>
 
 #include <asm/io.h>
@@ -33,11 +32,6 @@
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
 	ioport_resource.end = IO_PORT_RESOURCE_END;
-
-#ifdef CONFIG_SERIAL_8250
-	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
-	vr41xx_siu_init();
-#endif
 
 	return 0;
 }
diff -urN -X dontdiff b-orig/arch/mips/vr41xx/common/Makefile b/arch/mips/vr41xx/common/Makefile
--- b-orig/arch/mips/vr41xx/common/Makefile	Sat Apr 23 09:27:25 2005
+++ b/arch/mips/vr41xx/common/Makefile	Sat Apr 23 09:27:46 2005
@@ -4,7 +4,6 @@
 
 obj-y				+= bcu.o cmu.o icu.o init.o int-handler.o pmu.o
 obj-$(CONFIG_GPIO_VR41XX)	+= giu.o
-obj-$(CONFIG_SERIAL_8250)	+= serial.o
 obj-$(CONFIG_VRC4171)		+= vrc4171.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
 
diff -urN -X dontdiff b-orig/arch/mips/vr41xx/common/serial.c b/arch/mips/vr41xx/common/serial.c
--- b-orig/arch/mips/vr41xx/common/serial.c	Sat Jul 31 20:50:26 2004
+++ b/arch/mips/vr41xx/common/serial.c	Thu Jan  1 09:00:00 1970
@@ -1,178 +0,0 @@
-/*
- *  serial.c, Serial Interface Unit routines for NEC VR4100 series.
- *
- *  Copyright (C) 2002  MontaVista Software Inc.
- *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-/*
- * Changes:
- *  MontaVista Software Inc. <yyuasa@mvista.com> or <source@mvista.com>
- *  - New creation, NEC VR4122 and VR4131 are supported.
- *  - Added support for NEC VR4111 and VR4121.
- *
- *  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *  - Added support for NEC VR4133.
- */
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/tty.h>
-#include <linux/serial.h>
-#include <linux/serial_core.h>
-#include <linux/smp.h>
-
-#include <asm/addrspace.h>
-#include <asm/cpu.h>
-#include <asm/io.h>
-#include <asm/vr41xx/vr41xx.h>
-
-#define SIUIRSEL_TYPE1		KSEG1ADDR(0x0c000008)
-#define SIUIRSEL_TYPE2		KSEG1ADDR(0x0f000808)
- #define USE_RS232C		0x00
- #define USE_IRDA		0x01
- #define SIU_USES_IRDA		0x00
- #define FIR_USES_IRDA		0x02
- #define IRDA_MODULE_SHARP	0x00
- #define IRDA_MODULE_TEMIC	0x04
- #define IRDA_MODULE_HP		0x08
- #define TMICTX			0x10
- #define TMICMODE		0x20
-
-#define SIU_BASE_TYPE1		0x0c000000UL	/* VR4111 and VR4121 */
-#define SIU_BASE_TYPE2		0x0f000800UL	/* VR4122, VR4131 and VR4133 */
-#define SIU_SIZE		0x8UL
-
-#define SIU_BASE_BAUD		1152000
-
-/* VR4122, VR4131 and VR4133 DSIU Registers */
-#define DSIU_BASE		0x0f000820UL
-#define DSIU_SIZE		0x8UL
-
-#define DSIU_BASE_BAUD		1152000
-
-int vr41xx_serial_ports = 0;
-
-void vr41xx_select_siu_interface(siu_interface_t interface,
-                                 irda_module_t module)
-{
-	uint16_t val = USE_RS232C;	/* Select RS-232C */
-
-	/* Select IrDA */
-	if (interface == SIU_IRDA) {
-		switch (module) {
-		case IRDA_SHARP:
-			val = IRDA_MODULE_SHARP;
-			break;
-		case IRDA_TEMIC:
-			val = IRDA_MODULE_TEMIC;
-			break;
-		case IRDA_HP:
-			val = IRDA_MODULE_HP;
-			break;
-		default:
-			printk(KERN_ERR "SIU: unknown IrDA module\n");
-			return;
-		}
-		val |= USE_IRDA | SIU_USES_IRDA;
-	}
-
-	switch (current_cpu_data.cputype) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		writew(val, SIUIRSEL_TYPE1);
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		writew(val, SIUIRSEL_TYPE2);
-		break;
-	default:
-		printk(KERN_ERR "SIU: unsupported CPU of NEC VR4100 series\n");
-		break;
-	}
-}
-
-void __init vr41xx_siu_init(void)
-{
-	struct uart_port port;
-
-	memset(&port, 0, sizeof(port));
-
-	port.line = vr41xx_serial_ports;
-	port.uartclk = SIU_BASE_BAUD * 16;
-	port.irq = SIU_IRQ;
-	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
-	switch (current_cpu_data.cputype) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		port.mapbase = SIU_BASE_TYPE1;
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		port.mapbase = SIU_BASE_TYPE2;
-		break;
-	default:
-		printk(KERN_ERR "SIU: unsupported CPU of NEC VR4100 series\n");
-		return;
-	}
-	port.regshift = 0;
-	port.iotype = UPIO_MEM;
-	port.membase = ioremap(port.mapbase, SIU_SIZE);
-	if (port.membase != NULL) {
-		if (early_serial_setup(&port) == 0) {
-			vr41xx_supply_clock(SIU_CLOCK);
-			vr41xx_serial_ports++;
-			return;
-		}
-	}
-
-	printk(KERN_ERR "SIU: setup failed!\n");
-}
-
-void __init vr41xx_dsiu_init(void)
-{
-	struct uart_port port;
-
-	if (current_cpu_data.cputype != CPU_VR4122 &&
-	    current_cpu_data.cputype != CPU_VR4131 &&
-	    current_cpu_data.cputype != CPU_VR4133) {
-		printk(KERN_ERR "DSIU: unsupported CPU of NEC VR4100 series\n");
-		return;
-	}
-
-	memset(&port, 0, sizeof(port));
-
-	port.line = vr41xx_serial_ports;
-	port.uartclk = DSIU_BASE_BAUD * 16;
-	port.irq = DSIU_IRQ;
-	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
-	port.mapbase = DSIU_BASE;
-	port.regshift = 0;
-	port.iotype = UPIO_MEM;
-	port.membase = ioremap(port.mapbase, DSIU_SIZE);
-	if (port.membase != NULL) {
-		if (early_serial_setup(&port) == 0) {
-			vr41xx_supply_clock(DSIU_CLOCK);
-			vr41xx_enable_dsiuint(DSIUINT_ALL);
-			vr41xx_serial_ports++;
-			return;
-		}
-	}
-
-	printk(KERN_ERR "DSIU: setup failed!\n");
-}
diff -urN -X dontdiff b-orig/arch/mips/vr41xx/ibm-workpad/setup.c b/arch/mips/vr41xx/ibm-workpad/setup.c
--- b-orig/arch/mips/vr41xx/ibm-workpad/setup.c	Thu Apr 29 10:42:48 2004
+++ b/arch/mips/vr41xx/ibm-workpad/setup.c	Sat Apr 23 10:11:07 2005
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the IBM WorkPad z50.
  *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -17,7 +17,6 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/config.h>
 #include <linux/ioport.h>
 
 #include <asm/io.h>
@@ -33,11 +32,6 @@
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
 	ioport_resource.end = IO_PORT_RESOURCE_END;
-
-#ifdef CONFIG_SERIAL_8250
-	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
-	vr41xx_siu_init();
-#endif
 
 	return 0;
 }
diff -urN -X dontdiff b-orig/arch/mips/vr41xx/nec-cmbvr4133/setup.c b/arch/mips/vr41xx/nec-cmbvr4133/setup.c
--- b-orig/arch/mips/vr41xx/nec-cmbvr4133/setup.c	Wed Dec 15 23:08:18 2004
+++ b/arch/mips/vr41xx/nec-cmbvr4133/setup.c	Sat Apr 23 10:12:23 2005
@@ -55,15 +55,6 @@
 #define number_partitions (sizeof(cmbvr4133_mtd_parts)/sizeof(struct mtd_partition))
 #endif
 
-extern void (*late_time_init)(void);
-
-static void __init vr4133_serial_init(void)
-{
-	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
-	vr41xx_siu_init();
-	vr41xx_dsiu_init();
-}
-
 extern void i8259_init(void);
 
 static int __init nec_cmbvr4133_setup(void)
@@ -77,8 +68,6 @@
 
 	mips_machgroup = MACH_GROUP_NEC_VR41XX;
 	mips_machtype = MACH_NEC_CMBVR4133;
-
-	late_time_init = vr4133_serial_init;
 
 #ifdef CONFIG_PCI
 #ifdef CONFIG_ROCKHOPPER
diff -urN -X dontdiff b-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c b/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- b-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Thu May 27 08:14:29 2004
+++ b/arch/mips/vr41xx/tanbac-tb0226/setup.c	Sat Apr 23 10:13:27 2005
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the TANBAC TB0226.
  *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -17,23 +17,8 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/config.h>
-
-#include <asm/vr41xx/vr41xx.h>
 
 const char *get_system_type(void)
 {
 	return "TANBAC TB0226";
 }
-
-static int tanbac_tb0226_setup(void)
-{
-#ifdef CONFIG_SERIAL_8250
-	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
-	vr41xx_siu_init();
-#endif
-
-	return 0;
-}
-
-early_initcall(tanbac_tb0226_setup);
diff -urN -X dontdiff b-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c b/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- b-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	Thu May 27 08:14:29 2004
+++ b/arch/mips/vr41xx/tanbac-tb0229/setup.c	Sat Apr 23 10:14:05 2005
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the TANBAC TB0229 (VR4131DIMM)
  *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  Modified for TANBAC TB0229:
  *  Copyright (C) 2003  Megasolution Inc.  <matsu@megasolution.jp>
@@ -20,24 +20,8 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/config.h>
-
-#include <asm/vr41xx/vr41xx.h>
 
 const char *get_system_type(void)
 {
 	return "TANBAC TB0229";
 }
-
-static int tanbac_tb0229_setup(void)
-{
-#ifdef CONFIG_SERIAL_8250
-	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
-	vr41xx_siu_init();
-	vr41xx_dsiu_init();
-#endif
-
-	return 0;
-}
-
-early_initcall(tanbac_tb0229_setup);
diff -urN -X dontdiff b-orig/arch/mips/vr41xx/victor-mpc30x/setup.c b/arch/mips/vr41xx/victor-mpc30x/setup.c
--- b-orig/arch/mips/vr41xx/victor-mpc30x/setup.c	Thu May 27 08:14:29 2004
+++ b/arch/mips/vr41xx/victor-mpc30x/setup.c	Sat Apr 23 10:14:29 2005
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the Victor MP-C303/304.
  *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -17,23 +17,8 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/config.h>
-
-#include <asm/vr41xx/vr41xx.h>
 
 const char *get_system_type(void)
 {
 	return "Victor MP-C303/304";
 }
-
-static int victor_mpc30x_setup(void)
-{
-#ifdef CONFIG_SERIAL_8250
-	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
-	vr41xx_siu_init();
-#endif
-
-	return 0;
-}
-
-early_initcall(victor_mpc30x_setup);
diff -urN -X dontdiff b-orig/arch/mips/vr41xx/zao-capcella/setup.c b/arch/mips/vr41xx/zao-capcella/setup.c
--- b-orig/arch/mips/vr41xx/zao-capcella/setup.c	Thu May 27 08:14:29 2004
+++ b/arch/mips/vr41xx/zao-capcella/setup.c	Sat Apr 23 10:15:17 2005
@@ -1,7 +1,7 @@
 /*
  *  setup.c, Setup for the ZAO Networks Capcella.
  *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -17,24 +17,8 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/config.h>
-
-#include <asm/vr41xx/vr41xx.h>
 
 const char *get_system_type(void)
 {
 	return "ZAO Networks Capcella";
 }
-
-static int zao_capcella_setup(void)
-{
-#ifdef CONFIG_SERIAL_8250
-	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
-	vr41xx_siu_init();
-	vr41xx_dsiu_init();
-#endif
-
-	return 0;
-}
-
-early_initcall(zao_capcella_setup);
diff -urN -X dontdiff b-orig/include/asm-mips/vr41xx/vr41xx.h b/include/asm-mips/vr41xx/vr41xx.h
--- b-orig/include/asm-mips/vr41xx/vr41xx.h	Sat Apr 23 09:27:25 2005
+++ b/include/asm-mips/vr41xx/vr41xx.h	Sat Apr 23 10:15:50 2005
@@ -231,32 +231,4 @@
 	DATA_HIGH
 };
 
-/*
- * Serial Interface Unit
- */
-extern void vr41xx_siu_init(void);
-extern int vr41xx_serial_ports;
-
-/* SIU interfaces */
-typedef enum {
-	SIU_RS232C,
-	SIU_IRDA
-} siu_interface_t;
-
-/* IrDA interfaces */
-typedef enum {
-	IRDA_NONE,
-	IRDA_SHARP,
-	IRDA_TEMIC,
-	IRDA_HP
-} irda_module_t;
-
-extern void vr41xx_select_siu_interface(siu_interface_t interface,
-                                        irda_module_t module);
-
-/*
- * Debug Serial Interface Unit
- */
-extern void vr41xx_dsiu_init(void);
-
 #endif /* __NEC_VR41XX_H */
