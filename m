Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jul 2005 05:02:30 +0100 (BST)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:1533 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224895AbVG3ECO>;
	Sat, 30 Jul 2005 05:02:14 +0100
Received: MO(mo00)id j6U452tC016141; Sat, 30 Jul 2005 13:05:02 +0900 (JST)
Received: MDO(mdo01) id j6U451vK014910; Sat, 30 Jul 2005 13:05:01 +0900 (JST)
Received: from stratos (h009.p499.iij4u.or.jp [210.149.243.9])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j6U450WD023875
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Sat, 30 Jul 2005 13:05:01 +0900 (JST)
Date:	Sat, 30 Jul 2005 13:04:52 +0900
From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] vr41xx: remove obsolete GIU function call
Message-Id: <20050730130452.1b064d36.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed obsolete GIU function call for vr41xx.
Please apply this patch.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-tb0219.c a/arch/mips/pci/fixup-tb0219.c
--- a-orig/arch/mips/pci/fixup-tb0219.c	2004-11-01 01:07:33.000000000 +0900
+++ a/arch/mips/pci/fixup-tb0219.c	2005-07-30 12:15:08.000000000 +0900
@@ -2,7 +2,7 @@
  *  fixup-tb0219.c, The TANBAC TB0219 specific PCI fixups.
  *
  *  Copyright (C) 2003  Megasolution Inc. <matsu@megasolution.jp>
- *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -29,27 +29,12 @@
 
 	switch (slot) {
 	case 12:
-		vr41xx_set_irq_trigger(TB0219_PCI_SLOT1_PIN,
-				       TRIGGER_LEVEL,
-				       SIGNAL_THROUGH);
-		vr41xx_set_irq_level(TB0219_PCI_SLOT1_PIN,
-				     LEVEL_LOW);
 		irq = TB0219_PCI_SLOT1_IRQ;
 		break;
 	case 13:
-		vr41xx_set_irq_trigger(TB0219_PCI_SLOT2_PIN,
-				       TRIGGER_LEVEL,
-				       SIGNAL_THROUGH);
-		vr41xx_set_irq_level(TB0219_PCI_SLOT2_PIN,
-				     LEVEL_LOW);
 		irq = TB0219_PCI_SLOT2_IRQ;
 		break;
 	case 14:
-		vr41xx_set_irq_trigger(TB0219_PCI_SLOT3_PIN,
-				       TRIGGER_LEVEL,
-				       SIGNAL_THROUGH);
-		vr41xx_set_irq_level(TB0219_PCI_SLOT3_PIN,
-				     LEVEL_LOW);
 		irq = TB0219_PCI_SLOT3_IRQ;
 		break;
 	default:
