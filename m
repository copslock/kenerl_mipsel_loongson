Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 16:53:27 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:37356 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226033AbUEZPvh>;
	Wed, 26 May 2004 16:51:37 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA02340;
	Thu, 27 May 2004 00:51:31 +0900 (JST)
Received: 4UMDO01 id i4QFpVu09006; Thu, 27 May 2004 00:51:31 +0900 (JST)
Received: 4UMRO00 id i4QFpUV28772; Thu, 27 May 2004 00:51:30 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 27 May 2004 00:51:28 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][7/14] vr41xx: update fixup-mpc30x.c
Message-Id: <20040527005128.020b08a9.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

fixup-mpc30x.c was updated.

Please apply to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/pci/Makefile linux/arch/mips/pci/Makefile
--- linux-orig/arch/mips/pci/Makefile	Thu Apr 22 01:32:19 2004
+++ linux/arch/mips/pci/Makefile	Thu Apr 22 01:43:03 2004
@@ -48,6 +48,6 @@
 obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
 obj-$(CONFIG_TOSHIBA_JMR3927)	+= fixup-jmr3927.o pci-jmr3927.o
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o ops-tx4927.o
-obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-capcella.o
+obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_MACH_VR41XX)	+= pci-vr41xx.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
diff -urN -X dontdiff linux-orig/arch/mips/pci/fixup-mpc30x.c linux/arch/mips/pci/fixup-mpc30x.c
--- linux-orig/arch/mips/pci/fixup-mpc30x.c	Thu Jan  1 09:00:00 1970
+++ linux/arch/mips/pci/fixup-mpc30x.c	Thu Apr 22 01:43:03 2004
@@ -0,0 +1,48 @@
+/*
+ *  fixup-mpc30x.c, The Victor MP-C303/304 specific PCI fixups.
+ *
+ *  Copyright (C) 2002,2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
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
+#include <asm/vr41xx/mpc30x.h>
+#include <asm/vr41xx/vrc4173.h>
+
+static const int internal_func_irqs[] __initdata = {
+	VRC4173_CASCADE_IRQ,
+	VRC4173_AC97_IRQ,
+	VRC4173_USB_IRQ,
+};
+
+static char irq_tab_mpc30x[] __initdata = {
+ [12] = VRC4173_PCMCIA1_IRQ,
+ [13] = VRC4173_PCMCIA2_IRQ,
+ [29] = MQ200_IRQ,
+};
+
+int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	if (slot == 30)
+		return internal_func_irqs[PCI_FUNC(dev->devfn)];
+
+	return irq_tab_mpc30x[slot];
+}
+
+struct pci_fixup pcibios_fixups[] __initdata = {
+	{	.pass = 0,	},
+};
diff -urN -X dontdiff linux-orig/arch/mips/pci/fixup-victor-mpc30x.c linux/arch/mips/pci/fixup-victor-mpc30x.c
--- linux-orig/arch/mips/pci/fixup-victor-mpc30x.c	Thu Nov 13 10:53:37 2003
+++ linux/arch/mips/pci/fixup-victor-mpc30x.c	Thu Jan  1 09:00:00 1970
@@ -1,48 +0,0 @@
-/*
- * FILE NAME
- *	arch/mips/vr41xx/victor-mpc30x/pci_fixup.c
- *
- * BRIEF MODULE DESCRIPTION
- *	The Victor MP-C303/304 specific PCI fixups.
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
-#include <linux/pci.h>
-
-#include <asm/vr41xx/vrc4173.h>
-#include <asm/vr41xx/mpc30x.h>
-
-/*
- * Shortcuts
- */
-#define PCMCIA1	VRC4173_PCMCIA1_IRQ
-#define PCMCIA2	VRC4173_PCMCIA2_IRQ
-#define MQ	MQ200_IRQ
-
-static const int internal_func_irqs[8] __initdata = {
-	VRC4173_CASCADE_IRQ,
-	VRC4173_AC97_IRQ,
-	VRC4173_USB_IRQ,
-	
-};
-
-static char irq_tab_mpc30x[][5] __initdata = {
- [12] = { PCMCIA1, PCMCIA1, 0, 0 },
- [13] = { PCMCIA2, PCMCIA2, 0, 0 },
- [29] = {      MQ,      MQ, 0, 0 },		/* mediaQ MQ-200 */
-};
-
-int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
-{
-	if (slot == 30)
-		return internal_func_irqs[PCI_FUNC(dev->devfn)];
-
-	return irq_tab_mpc30x[slot][pin];
-}
