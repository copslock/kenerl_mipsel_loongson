Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Apr 2004 17:40:51 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:18677 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225998AbUDZQks>;
	Mon, 26 Apr 2004 17:40:48 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id BAA01979;
	Tue, 27 Apr 2004 01:40:44 +0900 (JST)
Received: 4UMDO01 id i3QGehT17592; Tue, 27 Apr 2004 01:40:44 +0900 (JST)
Received: 4UMRO00 id i3QGeg800211; Tue, 27 Apr 2004 01:40:42 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Tue, 27 Apr 2004 01:40:39 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Fixes serial setup fot vr41xx
Message-Id: <20040427014039.102fdb50.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

This patch fixes the serial setup for vr41xx.
Please apply this patch to CVS.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/casio-e55/setup.c linux/arch/mips/vr41xx/casio-e55/setup.c
--- linux-orig/arch/mips/vr41xx/casio-e55/setup.c	Thu Feb 26 00:23:50 2004
+++ linux/arch/mips/vr41xx/casio-e55/setup.c	Tue Apr 27 00:58:07 2004
@@ -35,7 +35,8 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 
 #ifdef CONFIG_SERIAL_8250
-	vr41xx_siu_init(SIU_RS232C, 0);
+	vr41xx_siu_init();
+	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
 #endif
 
 	return 0;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/icu.c linux/arch/mips/vr41xx/common/icu.c
--- linux-orig/arch/mips/vr41xx/common/icu.c	Tue Jan 13 08:21:05 2004
+++ linux/arch/mips/vr41xx/common/icu.c	Mon Apr 26 23:56:42 2004
@@ -1,34 +1,23 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/common/icu.c
+ *  icu.c, Interrupt Control Unit routines for the NEC VR4100 series.
  *
- * BRIEF MODULE DESCRIPTION
- *	Interrupt Control Unit routines for the NEC VR4100 series.
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
+ *  Copyright (C) 2001-2002  MontaVista Software Inc.
+ *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
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
  */
 /*
  * Changes:
@@ -80,6 +69,8 @@
 #define GIUINTLREG	0x08
 #define MSYSINT1REG	0x0c
 #define MGIUINTLREG	0x14
+#define MDSIUINTREG	0x16
+ #define INTDSIU	0x0800
 #define NMIREG		0x18
 #define SOFTREG		0x1a
 #define INTASSIGN2	0x1c
@@ -144,6 +135,18 @@
 	write_icu2(res, offset);
 
 	return res;
+}
+
+/*=======================================================================*/
+
+void vr41xx_enable_dsiuint(void)
+{
+	set_icu1(MDSIUINTREG, INTDSIU);
+}
+
+void vr41xx_disable_dsiuint(void)
+{
+	clear_icu1(MDSIUINTREG, INTDSIU);
 }
 
 /*=======================================================================*/
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/serial.c linux/arch/mips/vr41xx/common/serial.c
--- linux-orig/arch/mips/vr41xx/common/serial.c	Thu Feb 26 00:23:50 2004
+++ linux/arch/mips/vr41xx/common/serial.c	Tue Apr 27 01:19:04 2004
@@ -40,14 +40,8 @@
 #include <asm/io.h>
 #include <asm/vr41xx/vr41xx.h>
 
-/* VR4111 and VR4121 SIU Registers */
-#define SIURB_TYPE1		KSEG1ADDR(0x0c000000)
 #define SIUIRSEL_TYPE1		KSEG1ADDR(0x0c000008)
-
-/* VR4122, VR4131 and VR4133 SIU Registers */
-#define SIURB_TYPE2		KSEG1ADDR(0x0f000800)
 #define SIUIRSEL_TYPE2		KSEG1ADDR(0x0f000808)
-
  #define USE_RS232C		0x00
  #define USE_IRDA		0x01
  #define SIU_USES_IRDA		0x00
@@ -58,21 +52,24 @@
  #define TMICTX			0x10
  #define TMICMODE		0x20
 
-#define SIU_BASE_BAUD		1152000
+#define SIU_BASE_TYPE1		0x0c000000UL	/* VR4111 and VR4121 */
+#define SIU_BASE_TYPE2		0x0f000800UL	/* VR4122, VR4131 and VR4133 */
+#define SIU_SIZE		0xcUL
 
-/* VR4122 and VR4131 DSIU Registers */
-#define DSIURB			KSEG1ADDR(0x0f000820)
+#define SIU_BASE_BAUD		1152000
 
-#define MDSIUINTREG		KSEG1ADDR(0x0f000096)
- #define INTDSIU		0x0800
+/* VR4122, VR4131 and VR4133 DSIU Registers */
+#define DSIU_BASE		0x0f000820UL
+#define DSIU_SIZE		0x8UL
 
 #define DSIU_BASE_BAUD		1152000
 
 int vr41xx_serial_ports = 0;
 
-void vr41xx_siu_ifselect(int interface, int module)
+void vr41xx_select_siu_interface(siu_interface_t interface,
+                                 irda_module_t module)
 {
-	u16 val = USE_RS232C;	/* Select RS-232C */
+	uint16_t val = USE_RS232C;	/* Select RS-232C */
 
 	/* Select IrDA */
 	if (interface == SIU_IRDA) {
@@ -86,6 +83,9 @@
 		case IRDA_HP:
 			val = IRDA_MODULE_HP;
 			break;
+		default:
+			printk(KERN_ERR "SIU: unknown IrDA module\n");
+			return;
 		}
 		val |= USE_IRDA | SIU_USES_IRDA;
 	}
@@ -101,45 +101,47 @@
 		writew(val, SIUIRSEL_TYPE2);
 		break;
 	default:
-		printk(KERN_INFO "Unexpected CPU of NEC VR4100 series\n");
+		printk(KERN_ERR "SIU: unsupported CPU of NEC VR4100 series\n");
 		break;
 	}
 }
 
-void __init vr41xx_siu_init(int interface, int module)
+void __init vr41xx_siu_init(void)
 {
 	struct uart_port port;
 
-	vr41xx_siu_ifselect(interface, module);
-
 	memset(&port, 0, sizeof(port));
 
 	port.line = vr41xx_serial_ports;
-	port.uartclk = SIU_BASE_BAUD;
+	port.uartclk = SIU_BASE_BAUD * 16;
 	port.irq = SIU_IRQ;
-	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
+	port.flags = UPF_RESOURCES | UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
-		port.membase = (char *)SIURB_TYPE1;
+		port.mapbase = SIU_BASE_TYPE1;
 		break;
 	case CPU_VR4122:
 	case CPU_VR4131:
 	case CPU_VR4133:
-		port.membase = (char *)SIURB_TYPE2;
+		port.mapbase = SIU_BASE_TYPE2;
 		break;
 	default:
-		panic("Unexpected CPU of NEC VR4100 series");
-		break;
+		printk(KERN_ERR "SIU: unsupported CPU of NEC VR4100 series\n");
+		return;
 	}
 	port.regshift = 0;
 	port.iotype = UPIO_MEM;
-	if (early_serial_setup(&port) != 0)
-		printk(KERN_ERR "SIU setup failed!\n");
-
-	vr41xx_supply_clock(SIU_CLOCK);
+	port.membase = ioremap(port.mapbase, SIU_SIZE);
+	if (port.membase != NULL) {
+		if (early_serial_setup(&port) == 0) {
+			vr41xx_supply_clock(SIU_CLOCK);
+			vr41xx_serial_ports++;
+			return;
+		}
+	}
 
-	vr41xx_serial_ports++;
+	printk(KERN_ERR "SIU: setup failed!\n");
 }
 
 void __init vr41xx_dsiu_init(void)
@@ -148,24 +150,29 @@
 
 	if (current_cpu_data.cputype != CPU_VR4122 &&
 	    current_cpu_data.cputype != CPU_VR4131 &&
-	    current_cpu_data.cputype != CPU_VR4133)
+	    current_cpu_data.cputype != CPU_VR4133) {
+		printk(KERN_ERR "DSIU: unsupported CPU of NEC VR4100 series\n");
 		return;
+	}
 
 	memset(&port, 0, sizeof(port));
 
 	port.line = vr41xx_serial_ports;
-	port.uartclk = DSIU_BASE_BAUD;
+	port.uartclk = DSIU_BASE_BAUD * 16;
 	port.irq = DSIU_IRQ;
-	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
-	port.membase = (char *)DSIURB;
+	port.flags = UPF_RESOURCES | UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
+	port.mapbase = DSIU_BASE;
 	port.regshift = 0;
 	port.iotype = UPIO_MEM;
-	if (early_serial_setup(&port) != 0)
-		printk(KERN_ERR "DSIU setup failed!\n");
-
-	vr41xx_supply_clock(DSIU_CLOCK);
-
-	writew(INTDSIU, MDSIUINTREG);
+	port.membase = ioremap(port.mapbase, DSIU_SIZE);
+	if (port.membase != NULL) {
+		if (early_serial_setup(&port) == 0) {
+			vr41xx_supply_clock(DSIU_CLOCK);
+			vr41xx_enable_dsiuint();
+			vr41xx_serial_ports++;
+			return;
+		}
+	}
 
-	vr41xx_serial_ports++;
+	printk(KERN_ERR "DSIU: setup failed!\n");
 }
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c linux/arch/mips/vr41xx/ibm-workpad/setup.c
--- linux-orig/arch/mips/vr41xx/ibm-workpad/setup.c	Thu Feb 26 00:23:50 2004
+++ linux/arch/mips/vr41xx/ibm-workpad/setup.c	Tue Apr 27 00:59:15 2004
@@ -35,7 +35,8 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 
 #ifdef CONFIG_SERIAL_8250
-	vr41xx_siu_init(SIU_RS232C, 0);
+	vr41xx_siu_init();
+	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
 #endif
 
 	return 0;
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/setup.c	Thu Feb 26 07:05:00 2004
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	Tue Apr 27 01:00:14 2004
@@ -80,8 +80,10 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 
 #ifdef CONFIG_SERIAL_8250
+	vr41xx_siu_init();
+	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
+
 	vr41xx_dsiu_init();
-	vr41xx_siu_init(SIU_RS232C, 0);
 #endif
 
 #ifdef CONFIG_PCI
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	Thu Feb 26 00:23:50 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	Tue Apr 27 01:01:10 2004
@@ -83,7 +83,10 @@
 	ioport_resource.start = IO_PORT_RESOURCE_START;
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 
-	vr41xx_siu_init(SIU_RS232C, 0);
+#ifdef CONFIG_SERIAL_8250
+	vr41xx_siu_init();
+	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
+#endif
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c linux/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	Thu Feb 26 00:23:50 2004
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	Tue Apr 27 01:02:03 2004
@@ -87,8 +87,12 @@
 	ioport_resource.start = IO_PORT_RESOURCE_START;
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 
-	vr41xx_siu_init(SIU_RS232C, 0);
+#ifdef CONFIG_SERIAL_8250
+	vr41xx_siu_init();
+	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
+
 	vr41xx_dsiu_init();
+#endif
 
 #ifdef CONFIG_PCI
 	vr41xx_pciu_init(&pci_address_map);
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c linux/arch/mips/vr41xx/victor-mpc30x/setup.c
--- linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c	Thu Feb 26 00:23:50 2004
+++ linux/arch/mips/vr41xx/victor-mpc30x/setup.c	Tue Apr 27 01:03:24 2004
@@ -84,7 +84,8 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 
 #ifdef CONFIG_SERIAL_8250
-	vr41xx_siu_init(SIU_RS232C, 0);
+	vr41xx_siu_init();
+	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
 #endif
 
 #ifdef CONFIG_PCI
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/setup.c linux/arch/mips/vr41xx/zao-capcella/setup.c
--- linux-orig/arch/mips/vr41xx/zao-capcella/setup.c	Thu Feb 26 00:23:50 2004
+++ linux/arch/mips/vr41xx/zao-capcella/setup.c	Tue Apr 27 01:02:50 2004
@@ -84,7 +84,9 @@
 	ioport_resource.end = IO_PORT_RESOURCE_END;
 
 #ifdef CONFIG_SERIAL_8250
-	vr41xx_siu_init(SIU_RS232C, 0);
+	vr41xx_siu_init();
+	vr41xx_select_siu_interface(SIU_RS232C, IRDA_NONE);
+
 	vr41xx_dsiu_init();
 #endif
 
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux-orig/include/asm-mips/vr41xx/vr41xx.h	Thu Feb 26 07:05:01 2004
+++ linux/include/asm-mips/vr41xx/vr41xx.h	Tue Apr 27 00:56:17 2004
@@ -136,6 +136,9 @@
 extern int vr41xx_set_intassign(unsigned int irq, unsigned char intassign);
 extern int vr41xx_cascade_irq(unsigned int irq, int (*get_irq_number)(int irq));
 
+extern void vr41xx_enable_dsiuint(void);
+extern void vr41xx_disable_dsiuint(void);
+
 /*
  * Power Management Unit
  */
@@ -189,22 +192,25 @@
 /*
  * Serial Interface Unit
  */
-extern void vr41xx_siu_init(int interface, int module);
-extern void vr41xx_siu_ifselect(int interface, int module);
+extern void vr41xx_siu_init(void);
 extern int vr41xx_serial_ports;
 
 /* SIU interfaces */
-enum {
+typedef enum {
 	SIU_RS232C,
 	SIU_IRDA
-};
+} siu_interface_t;
 
 /* IrDA interfaces */
-enum {
-	IRDA_SHARP = 1,
+typedef enum {
+	IRDA_NONE,
+	IRDA_SHARP,
 	IRDA_TEMIC,
 	IRDA_HP
-};
+} irda_module_t;
+
+extern void vr41xx_select_siu_interface(siu_interface_t interface,
+                                        irda_module_t module);
 
 /*
  * Debug Serial Interface Unit
