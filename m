Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 16:53:00 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:35052 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226036AbUEZPv1>;
	Wed, 26 May 2004 16:51:27 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA02308;
	Thu, 27 May 2004 00:51:24 +0900 (JST)
Received: 4UMDO00 id i4QFpNQ29874; Thu, 27 May 2004 00:51:23 +0900 (JST)
Received: 4UMRO00 id i4QFpNV28756; Thu, 27 May 2004 00:51:23 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 27 May 2004 00:51:21 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][6/14] vr41xx: update fixup-tb0226.c
Message-Id: <20040527005121.5cfa0d93.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

fixup-tb0226.c was updated.

Please apply to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/pci/fixup-tb0226.c linux/arch/mips/pci/fixup-tb0226.c
--- linux-orig/arch/mips/pci/fixup-tb0226.c	Thu Nov 13 00:24:37 2003
+++ linux/arch/mips/pci/fixup-tb0226.c	Thu Apr 22 01:32:44 2004
@@ -1,78 +1,83 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/tanbac-tb0226/pci_fixup.c
+ *  fixup-tb0226.c, The TANBAC TB0226 specific PCI fixups.
  *
- * BRIEF MODULE DESCRIPTION
- *	The TANBAC TB0226 specific PCI fixups.
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
 #include <linux/init.h>
 #include <linux/pci.h>
 
 #include <asm/vr41xx/tb0226.h>
 
-void __init pcibios_fixup_irqs(void)
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
-	struct pci_dev *dev = NULL;
-	u8 slot, pin;
-
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		slot = PCI_SLOT(dev->devfn);
-		dev->irq = 0;
+	int irq = -1;
 
-		switch (slot) {
-		case 12:
-			vr41xx_set_irq_trigger(GD82559_1_PIN,
+	switch (slot) {
+	case 12:
+		vr41xx_set_irq_trigger(GD82559_1_PIN,
+				       TRIGGER_LEVEL,
+				       SIGNAL_THROUGH);
+		vr41xx_set_irq_level(GD82559_1_PIN, LEVEL_LOW);
+		irq = GD82559_1_IRQ;
+		break;
+	case 13:
+		vr41xx_set_irq_trigger(GD82559_2_PIN,
+				       TRIGGER_LEVEL,
+				       SIGNAL_THROUGH);
+		vr41xx_set_irq_level(GD82559_2_PIN, LEVEL_LOW);
+		irq = GD82559_2_IRQ;
+		break;
+	case 14:
+		switch (pin) {
+		case 1:
+			vr41xx_set_irq_trigger(UPD720100_INTA_PIN,
+					       TRIGGER_LEVEL,
+					       SIGNAL_THROUGH);
+			vr41xx_set_irq_level(UPD720100_INTA_PIN,
+					     LEVEL_LOW);
+			irq = UPD720100_INTA_IRQ;
+			break;
+		case 2:
+			vr41xx_set_irq_trigger(UPD720100_INTB_PIN,
 					       TRIGGER_LEVEL,
 					       SIGNAL_THROUGH);
-			vr41xx_set_irq_level(GD82559_1_PIN, LEVEL_LOW);
-			dev->irq = GD82559_1_IRQ;
+			vr41xx_set_irq_level(UPD720100_INTB_PIN,
+					     LEVEL_LOW);
+			irq = UPD720100_INTB_IRQ;
 			break;
-		case 13:
-			vr41xx_set_irq_trigger(GD82559_2_PIN,
+		case 3:
+			vr41xx_set_irq_trigger(UPD720100_INTC_PIN,
 					       TRIGGER_LEVEL,
 					       SIGNAL_THROUGH);
-			vr41xx_set_irq_level(GD82559_2_PIN, LEVEL_LOW);
-			dev->irq = GD82559_2_IRQ;
+			vr41xx_set_irq_level(UPD720100_INTC_PIN,
+					     LEVEL_LOW);
+			irq = UPD720100_INTC_IRQ;
 			break;
-		case 14:
-			pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-			switch (pin) {
-			case 1:
-				vr41xx_set_irq_trigger(UPD720100_INTA_PIN,
-						       TRIGGER_LEVEL,
-						       SIGNAL_THROUGH);
-				vr41xx_set_irq_level(UPD720100_INTA_PIN,
-						     LEVEL_LOW);
-				dev->irq = UPD720100_INTA_IRQ;
-				break;
-			case 2:
-				vr41xx_set_irq_trigger(UPD720100_INTB_PIN,
-						       TRIGGER_LEVEL,
-						       SIGNAL_THROUGH);
-				vr41xx_set_irq_level(UPD720100_INTB_PIN,
-						     LEVEL_LOW);
-				dev->irq = UPD720100_INTB_IRQ;
-				break;
-			case 3:
-				vr41xx_set_irq_trigger(UPD720100_INTC_PIN,
-						       TRIGGER_LEVEL,
-						       SIGNAL_THROUGH);
-				vr41xx_set_irq_level(UPD720100_INTC_PIN,
-						     LEVEL_LOW);
-				dev->irq = UPD720100_INTC_IRQ;
-				break;
-			}
+		default:
 			break;
 		}
-
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+		break;
+	default:
+		break;
 	}
+
+	return irq;
 }
+
+struct pci_fixup pcibios_fixups[] __initdata = {
+	{	.pass = 0,	},
+};
