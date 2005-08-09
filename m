Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2005 16:08:23 +0100 (BST)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:44799 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225201AbVHIPIE>;
	Tue, 9 Aug 2005 16:08:04 +0100
Received: MO(mo00)id j79FBviA026943; Wed, 10 Aug 2005 00:11:57 +0900 (JST)
Received: MDO(mdo00) id j79FBvf8027045; Wed, 10 Aug 2005 00:11:57 +0900 (JST)
Received: from stratos (h009.p499.iij4u.or.jp [210.149.243.9])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j79FBu33007428
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Wed, 10 Aug 2005 00:11:56 +0900 (JST)
Date:	Wed, 10 Aug 2005 00:11:55 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6][2/2] vr41xx: update GIU function call for TB0226
Message-Id: <20050810001155.1d65f9e8.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated vr41xx GIU function call for TB0226.
Please apply this patch.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-tb0226.c a/arch/mips/pci/fixup-tb0226.c
--- a-orig/arch/mips/pci/fixup-tb0226.c	2004-11-01 01:07:33.000000000 +0900
+++ a/arch/mips/pci/fixup-tb0226.c	2005-08-10 00:00:20.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  *  fixup-tb0226.c, The TANBAC TB0226 specific PCI fixups.
  *
- *  Copyright (C) 2002-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 
+#include <asm/vr41xx/giu.h>
 #include <asm/vr41xx/tb0226.h>
 
 int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
@@ -29,42 +30,42 @@
 	switch (slot) {
 	case 12:
 		vr41xx_set_irq_trigger(GD82559_1_PIN,
-				       TRIGGER_LEVEL,
-				       SIGNAL_THROUGH);
-		vr41xx_set_irq_level(GD82559_1_PIN, LEVEL_LOW);
+				       IRQ_TRIGGER_LEVEL,
+				       IRQ_SIGNAL_THROUGH);
+		vr41xx_set_irq_level(GD82559_1_PIN, IRQ_LEVEL_LOW);
 		irq = GD82559_1_IRQ;
 		break;
 	case 13:
 		vr41xx_set_irq_trigger(GD82559_2_PIN,
-				       TRIGGER_LEVEL,
-				       SIGNAL_THROUGH);
-		vr41xx_set_irq_level(GD82559_2_PIN, LEVEL_LOW);
+				       IRQ_TRIGGER_LEVEL,
+				       IRQ_SIGNAL_THROUGH);
+		vr41xx_set_irq_level(GD82559_2_PIN, IRQ_LEVEL_LOW);
 		irq = GD82559_2_IRQ;
 		break;
 	case 14:
 		switch (pin) {
 		case 1:
 			vr41xx_set_irq_trigger(UPD720100_INTA_PIN,
-					       TRIGGER_LEVEL,
-					       SIGNAL_THROUGH);
+					       IRQ_TRIGGER_LEVEL,
+					       IRQ_SIGNAL_THROUGH);
 			vr41xx_set_irq_level(UPD720100_INTA_PIN,
-					     LEVEL_LOW);
+					     IRQ_LEVEL_LOW);
 			irq = UPD720100_INTA_IRQ;
 			break;
 		case 2:
 			vr41xx_set_irq_trigger(UPD720100_INTB_PIN,
-					       TRIGGER_LEVEL,
-					       SIGNAL_THROUGH);
+					       IRQ_TRIGGER_LEVEL,
+					       IRQ_SIGNAL_THROUGH);
 			vr41xx_set_irq_level(UPD720100_INTB_PIN,
-					     LEVEL_LOW);
+					     IRQ_LEVEL_LOW);
 			irq = UPD720100_INTB_IRQ;
 			break;
 		case 3:
 			vr41xx_set_irq_trigger(UPD720100_INTC_PIN,
-					       TRIGGER_LEVEL,
-					       SIGNAL_THROUGH);
+					       IRQ_TRIGGER_LEVEL,
+					       IRQ_SIGNAL_THROUGH);
 			vr41xx_set_irq_level(UPD720100_INTC_PIN,
-					     LEVEL_LOW);
+					     IRQ_LEVEL_LOW);
 			irq = UPD720100_INTC_IRQ;
 			break;
 		default:
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/Kconfig a/arch/mips/vr41xx/Kconfig
--- a-orig/arch/mips/vr41xx/Kconfig	2005-08-10 00:00:09.000000000 +0900
+++ a/arch/mips/vr41xx/Kconfig	2005-08-10 00:00:20.000000000 +0900
@@ -58,6 +58,7 @@
 	depends on TANBAC_TB022X
 	select PCI
 	select PCI_VR41XX
+	select GPIO_VR41XX
 	help
 	  The TANBAC TB0226 (Mbase) is a MIPS-based platform manufactured by
 	  TANBAC.  Please refer to <http://www.tanbac.co.jp/> about Mbase.
