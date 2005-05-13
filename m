Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2005 14:27:16 +0100 (BST)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:41207 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225748AbVEMN07>;
	Fri, 13 May 2005 14:26:59 +0100
Received: MO(mo01)id j4DDQuiG002344; Fri, 13 May 2005 22:26:56 +0900 (JST)
Received: MDO(mdo01) id j4DDQtUa027289; Fri, 13 May 2005 22:26:55 +0900 (JST)
Received: from stratos (h042.p502.iij4u.or.jp [210.149.246.42])
	by mbox.iij4u.or.jp (4U-MR/mbox00) id j4DDQsp1001952
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Fri, 13 May 2005 22:26:54 +0900 (JST)
Date:	Fri, 13 May 2005 22:26:53 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: remove old vrc4171 driver
Message-Id: <20050513222653.7828e1fd.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

This patch had removed old vrc4171 driver.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff b-orig/arch/mips/vr41xx/common/Makefile b/arch/mips/vr41xx/common/Makefile
--- b-orig/arch/mips/vr41xx/common/Makefile	Sat Apr 23 22:59:07 2005
+++ b/arch/mips/vr41xx/common/Makefile	Sat Apr 23 22:59:48 2005
@@ -4,7 +4,6 @@
 
 obj-y				+= bcu.o cmu.o icu.o init.o int-handler.o pmu.o
 obj-$(CONFIG_GPIO_VR41XX)	+= giu.o
-obj-$(CONFIG_VRC4171)		+= vrc4171.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -urN -X dontdiff b-orig/arch/mips/vr41xx/common/vrc4171.c b/arch/mips/vr41xx/common/vrc4171.c
--- b-orig/arch/mips/vr41xx/common/vrc4171.c	Thu Jan 15 20:28:50 2004
+++ b/arch/mips/vr41xx/common/vrc4171.c	Thu Jan  1 09:00:00 1970
@@ -1,106 +0,0 @@
-/*
- *  vrc4171.c, NEC VRC4171 base driver.
- *
- *  Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/module.h>
-#include <linux/types.h>
-
-#include <asm/io.h>
-#include <asm/vr41xx/vrc4171.h>
-
-MODULE_DESCRIPTION("NEC VRC4171 base driver");
-MODULE_AUTHOR("Yoichi Yuasa <yuasa@hh.iij4u.or.jp>");
-MODULE_LICENSE("GPL");
-
-EXPORT_SYMBOL_GPL(vrc4171_get_irq_status);
-EXPORT_SYMBOL_GPL(vrc4171_set_multifunction_pin);
-
-#define CONFIGURATION1		0x05fe
- #define SLOTB_CONFIG		0xc000
- #define SLOTB_NONE		0x0000
- #define SLOTB_PCCARD		0x4000
- #define SLOTB_CF		0x8000
- #define SLOTB_FLASHROM		0xc000
-
-#define CONFIGURATION2		0x05fc
-#define INTERRUPT_STATUS	0x05fa
-#define PCS_CONTROL		0x05ee
-#define GPIO_DATA		PCS_CONTROL
-#define PCS0_UPPER_START	0x05ec
-#define PCS0_LOWER_START	0x05ea
-#define PCS0_UPPER_STOP		0x05e8
-#define PCS0_LOWER_STOP		0x05e6
-#define PCS1_UPPER_START	0x05e4
-#define PCS1_LOWER_START	0x05e2
-#define PCS1_UPPER_STOP		0x05de
-#define PCS1_LOWER_STOP		0x05dc
-
-#define VRC4171_REGS_BASE	PCS1_LOWER_STOP
-#define VRC4171_REGS_SIZE	0x24
-
-uint16_t vrc4171_get_irq_status(void)
-{
-	return inw(INTERRUPT_STATUS);
-}
-
-void vrc4171_set_multifunction_pin(int config)
-{
-	uint16_t config1;
-
-	config1 = inw(CONFIGURATION1);
-	config1 &= ~SLOTB_CONFIG;
-
-	switch (config) {
-	case SLOTB_IS_NONE:
-		config1 |= SLOTB_NONE;
-		break;
-	case SLOTB_IS_PCCARD:
-		config1 |= SLOTB_PCCARD;
-		break;
-	case SLOTB_IS_CF:
-		config1 |= SLOTB_CF;
-		break;
-	case SLOTB_IS_FLASHROM:
-		config1 |= SLOTB_FLASHROM;
-		break;
-	default:
-		break;
-	}
-
-	outw(config1, CONFIGURATION1);
-}
-
-static int __devinit vrc4171_init(void)
-{
-	if (request_region(VRC4171_REGS_BASE, VRC4171_REGS_SIZE, "NEC VRC4171") == NULL)
-		return -EBUSY;
-
-	printk(KERN_INFO "NEC VRC4171 base driver\n");
-
-	return 0;
-}
-
-static void __devexit vrc4171_exit(void)
-{
-	release_region(VRC4171_REGS_BASE, VRC4171_REGS_SIZE);
-}
-
-module_init(vrc4171_init);
-module_exit(vrc4171_exit);
diff -urN -X dontdiff b-orig/include/asm-mips/vr41xx/vrc4171.h b/include/asm-mips/vr41xx/vrc4171.h
--- b-orig/include/asm-mips/vr41xx/vrc4171.h	Thu Jan 15 20:28:50 2004
+++ b/include/asm-mips/vr41xx/vrc4171.h	Thu Jan  1 09:00:00 1970
@@ -1,43 +0,0 @@
-/*
- *  vrc4171.h, Include file for NEC VRC4171.
- *
- *  Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
-#ifndef __NEC_VRC4171_H 
-#define __NEC_VRC4171_H 
-
-/*
- * Configuration 1
- */
-enum {
-	SLOTB_IS_NONE,       
-	SLOTB_IS_PCCARD,
-	SLOTB_IS_CF,
-	SLOTB_IS_FLASHROM
-};
-
-extern void vrc4171_set_multifunction_pin(int config);
-
-/*
- * Interrupt Status Mask
- */
-#define IRQ_A	0x02
-#define IRQ_B	0x04
-
-extern uint16_t vrc4171_get_irq_status(void);
-
-#endif /* __NEC_VRC4171_H */
