Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 16:52:06 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:27116 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226031AbUEZPvK>;
	Wed, 26 May 2004 16:51:10 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA02200;
	Thu, 27 May 2004 00:51:07 +0900 (JST)
Received: 4UMDO01 id i4QFp6u08963; Thu, 27 May 2004 00:51:06 +0900 (JST)
Received: 4UMRO00 id i4QFp6V28728; Thu, 27 May 2004 00:51:06 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 27 May 2004 00:51:04 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][4/14] vr41xx: add fixup-tb0219.c
Message-Id: <20040527005104.40832d5f.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

fixup-tb0219.c was added.

Please apply to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/pci/Makefile linux/arch/mips/pci/Makefile
--- linux-orig/arch/mips/pci/Makefile	Thu Apr 22 00:48:10 2004
+++ linux/arch/mips/pci/Makefile	Thu Apr 22 00:49:05 2004
@@ -44,8 +44,8 @@
 obj-$(CONFIG_SGI_IP32)		+= fixup-ip32.o ops-mace.o pci-ip32.o
 obj-$(CONFIG_SIBYTE_SB1250)	+= pci-sb1250.o
 obj-$(CONFIG_SNI_RM200_PCI)	+= fixup-sni.o ops-sni.o
+obj-$(CONFIG_TANBAC_TB0219)	+= fixup-tb0219.o
 obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
-obj-$(CONFIG_TANBAC_TB0229)	+= fixup-tb0229.o
 obj-$(CONFIG_TOSHIBA_JMR3927)	+= fixup-jmr3927.o pci-jmr3927.o
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o ops-tx4927.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-capcella.o
diff -urN -X dontdiff linux-orig/arch/mips/pci/fixup-tb0219.c linux/arch/mips/pci/fixup-tb0219.c
--- linux-orig/arch/mips/pci/fixup-tb0219.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/pci/fixup-tb0219.c	Thu Apr 22 00:49:05 2004
@@ -0,0 +1,64 @@
+/*
+ *  fixup-tb0219.c, The TANBAC TB0219 specific PCI fixups.
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
+#include <linux/pci.h>
+
+#include <asm/vr41xx/tb0219.h>
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int irq = -1;
+
+	switch (slot) {
+	case 12:
+		vr41xx_set_irq_trigger(TB0219_PCI_SLOT1_PIN,
+				       TRIGGER_LEVEL,
+				       SIGNAL_THROUGH);
+		vr41xx_set_irq_level(TB0219_PCI_SLOT1_PIN,
+				     LEVEL_LOW);
+		irq = TB0219_PCI_SLOT1_IRQ;
+		break;
+	case 13:
+		vr41xx_set_irq_trigger(TB0219_PCI_SLOT2_PIN,
+				       TRIGGER_LEVEL,
+				       SIGNAL_THROUGH);
+		vr41xx_set_irq_level(TB0219_PCI_SLOT2_PIN,
+				     LEVEL_LOW);
+		irq = TB0219_PCI_SLOT2_IRQ;
+		break;
+	case 14:
+		vr41xx_set_irq_trigger(TB0219_PCI_SLOT3_PIN,
+				       TRIGGER_LEVEL,
+				       SIGNAL_THROUGH);
+		vr41xx_set_irq_level(TB0219_PCI_SLOT3_PIN,
+				     LEVEL_LOW);
+		irq = TB0219_PCI_SLOT3_IRQ;
+		break;
+	default:
+		break;
+	}
+
+	return irq;
+}
+
+struct pci_fixup pcibios_fixups[] __initdata = {
+	{	.pass = 0,	},
+};
diff -urN -X dontdiff linux-orig/arch/mips/pci/fixup-tb0229.c linux/arch/mips/pci/fixup-tb0229.c
--- linux-orig/arch/mips/pci/fixup-tb0229.c	Thu Nov 13 00:24:37 2003
+++ linux/arch/mips/pci/fixup-tb0229.c	Thu Jan  1 09:00:00 1970
@@ -1,64 +0,0 @@
-/*
- * FILE NAME
- *	arch/mips/vr41xx/tanbac-tb0229/pci_fixup.c
- *
- * BRIEF MODULE DESCRIPTION
- *	The TANBAC TB0229(VR4131DIMM) specific PCI fixups.
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
-#include <linux/init.h>
-#include <linux/pci.h>
-
-#include <asm/vr41xx/tb0229.h>
-
-void __init pcibios_fixup_irqs(void)
-{
-#ifdef CONFIG_TANBAC_TB0219
-	struct pci_dev *dev = NULL;
-	u8 slot;
-
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		slot = PCI_SLOT(dev->devfn);
-		dev->irq = 0;
-
-		switch (slot) {
-		case 12:
-			vr41xx_set_irq_trigger(TB0219_PCI_SLOT1_PIN,
-					       TRIGGER_LEVEL,
-					       SIGNAL_THROUGH);
-			vr41xx_set_irq_level(TB0219_PCI_SLOT1_PIN,
-					     LEVEL_LOW);
-			dev->irq = TB0219_PCI_SLOT1_IRQ;
-			break;
-		case 13:
-			vr41xx_set_irq_trigger(TB0219_PCI_SLOT2_PIN,
-					       TRIGGER_LEVEL,
-					       SIGNAL_THROUGH);
-			vr41xx_set_irq_level(TB0219_PCI_SLOT2_PIN,
-					     LEVEL_LOW);
-			dev->irq = TB0219_PCI_SLOT2_IRQ;
-			break;
-		case 14:
-			vr41xx_set_irq_trigger(TB0219_PCI_SLOT3_PIN,
-					       TRIGGER_LEVEL,
-					       SIGNAL_THROUGH);
-			vr41xx_set_irq_level(TB0219_PCI_SLOT3_PIN,
-					     LEVEL_LOW);
-			dev->irq = TB0219_PCI_SLOT3_IRQ;
-			break;
-		default:
-			break;
-		}
-
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
-	}
-#endif
-}
