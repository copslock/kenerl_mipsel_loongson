Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Dec 2003 14:15:17 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:8184 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225371AbTLVOPP>;
	Mon, 22 Dec 2003 14:15:15 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id XAA19968;
	Mon, 22 Dec 2003 23:15:12 +0900 (JST)
Received: 4UMDO00 id hBMEFCX04495; Mon, 22 Dec 2003 23:15:12 +0900 (JST)
Received: 4UMRO00 id hBMEFC120188; Mon, 22 Dec 2003 23:15:12 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Mon, 22 Dec 2003 23:15:11 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] New NEC VRC4171's base  functions for VR4100 series
Message-Id: <20031222231511.4e189634.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made the patch for VRC4171's base functions.

This patch exists for HEAD of linux-mips.org CVS.
Please apply this patch.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-orig/arch/mips/Kconfig	2003-12-22 10:54:57.000000000 +0900
+++ linux/arch/mips/Kconfig	2003-12-22 12:48:46.000000000 +0900
@@ -739,6 +739,10 @@
 	depends on ZAO_CAPCELLA || VICTOR_MPC30X || SIBYTE_SB1xxx_SOC || NEC_EAGLE || NEC_OSPREY || DDB5477 || CASIO_E55 || TANBAC_TB0226 || TANBAC_TB0229
 	default y
 
+config VRC4171
+	tristate "NEC VRC4171 Support"
+	depends on IBM_WORKPAD
+
 config VRC4173
 	tristate "NEC VRC4173 Support"
 	depends on NEC_EAGLE || VICTOR_MPC30X
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/Makefile linux/arch/mips/vr41xx/common/Makefile
--- linux-orig/arch/mips/vr41xx/common/Makefile	2003-12-02 10:45:07.000000000 +0900
+++ linux/arch/mips/vr41xx/common/Makefile	2003-12-22 12:48:46.000000000 +0900
@@ -4,6 +4,7 @@
 
 obj-y				+= bcu.o cmu.o giu.o icu.o int-handler.o ksyms.o reset.o rtc.o
 obj-$(CONFIG_SERIAL_8250)	+= serial.o
+obj-$(CONFIG_VRC4171)		+= vrc4171.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/common/vrc4171.c linux/arch/mips/vr41xx/common/vrc4171.c
--- linux-orig/arch/mips/vr41xx/common/vrc4171.c	1970-01-01 09:00:00.000000000 +0900
+++ linux/arch/mips/vr41xx/common/vrc4171.c	2003-12-22 12:48:46.000000000 +0900
@@ -0,0 +1,106 @@
+/*
+ *  vrc4171.c, NEC VRC4171 base driver.
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
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include <asm/io.h>
+#include <asm/vr41xx/vrc4171.h>
+
+MODULE_DESCRIPTION("NEC VRC4171 base driver");
+MODULE_AUTHOR("Yoichi Yuasa <yuasa@hh.iij4u.or.jp>");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL_GPL(vrc4171_get_irq_status);
+EXPORT_SYMBOL_GPL(vrc4171_set_multifunction_pin);
+
+#define CONFIGURATION1		0x05fe
+ #define SLOTB_CONFIG		0xc000
+ #define SLOTB_NONE		0x0000
+ #define SLOTB_PCCARD		0x4000
+ #define SLOTB_CF		0x8000
+ #define SLOTB_FLASHROM		0xc000
+
+#define CONFIGURATION2		0x05fc
+#define INTERRUPT_STATUS	0x05fa
+#define PCS_CONTROL		0x05ee
+#define GPIO_DATA		PCS_CONTROL
+#define PCS0_UPPER_START	0x05ec
+#define PCS0_LOWER_START	0x05ea
+#define PCS0_UPPER_STOP		0x05e8
+#define PCS0_LOWER_STOP		0x05e6
+#define PCS1_UPPER_START	0x05e4
+#define PCS1_LOWER_START	0x05e2
+#define PCS1_UPPER_STOP		0x05de
+#define PCS1_LOWER_STOP		0x05dc
+
+#define VRC4171_REGS_BASE	PCS1_LOWER_STOP
+#define VRC4171_REGS_SIZE	0x24
+
+uint16_t vrc4171_get_irq_status(void)
+{
+	return inw(INTERRUPT_STATUS);
+}
+
+void vrc4171_set_multifunction_pin(int config)
+{
+	uint16_t config1;
+
+	config1 = inw(CONFIGURATION1);
+	config1 &= ~SLOTB_CONFIG;
+
+	switch (config) {
+	case SLOTB_IS_NONE:
+		config1 |= SLOTB_NONE;
+		break;
+	case SLOTB_IS_PCCARD:
+		config1 |= SLOTB_PCCARD;
+		break;
+	case SLOTB_IS_CF:
+		config1 |= SLOTB_CF;
+		break;
+	case SLOTB_IS_FLASHROM:
+		config1 |= SLOTB_FLASHROM;
+		break;
+	default:
+		break;
+	}
+
+	outw(config1, CONFIGURATION1);
+}
+
+static int __devinit vrc4171_init(void)
+{
+	if (request_region(VRC4171_REGS_BASE, VRC4171_REGS_SIZE, "NEC VRC4171") == NULL)
+		return -EBUSY;
+
+	printk(KERN_INFO "NEC VRC4171 base driver\n");
+
+	return 0;
+}
+
+static void __devexit vrc4171_exit(void)
+{
+	release_region(VRC4171_REGS_BASE, VRC4171_REGS_SIZE);
+}
+
+module_init(vrc4171_init);
+module_exit(vrc4171_exit);
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vrc4171.h linux/include/asm-mips/vr41xx/vrc4171.h
--- linux-orig/include/asm-mips/vr41xx/vrc4171.h	1970-01-01 09:00:00.000000000 +0900
+++ linux/include/asm-mips/vr41xx/vrc4171.h	2003-12-22 12:48:46.000000000 +0900
@@ -0,0 +1,43 @@
+/*
+ *  vrc4171.h, Include file for NEC VRC4171.
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
+#ifndef __NEC_VRC4171_H 
+#define __NEC_VRC4171_H 
+
+/*
+ * Configuration 1
+ */
+enum {
+	SLOTB_IS_NONE,       
+	SLOTB_IS_PCCARD,
+	SLOTB_IS_CF,
+	SLOTB_IS_FLASHROM
+};
+
+extern void vrc4171_set_multifunction_pin(int config);
+
+/*
+ * Interrupt Status Mask
+ */
+#define IRQ_A	0x02
+#define IRQ_B	0x04
+
+extern uint16_t vrc4171_get_irq_status(void);
+
+#endif /* __NEC_VRC4171_H */
