Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 14:53:43 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:59131 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225234AbUBCOxm>;
	Tue, 3 Feb 2004 14:53:42 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id XAA23076;
	Tue, 3 Feb 2004 23:53:39 +0900 (JST)
Received: 4UMDO01 id i13Ercr24365; Tue, 3 Feb 2004 23:53:38 +0900 (JST)
Received: 4UMRO01 id i13ErbC06684; Tue, 3 Feb 2004 23:53:38 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Tue, 3 Feb 2004 23:53:34 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.6] Fixed pci-vr41xx.c build
Message-Id: <20040203235334.004b35b6.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made a patch for fixing pci-vr41xx.c build.
Please apply this patch to v2.6.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/pci/pci-vr41xx.c linux/arch/mips/pci/pci-vr41xx.c
--- linux-orig/arch/mips/pci/pci-vr41xx.c	Fri Jun 13 23:19:56 2003
+++ linux/arch/mips/pci/pci-vr41xx.c	Tue Feb  3 23:00:27 2004
@@ -8,7 +8,7 @@
  * Author: Yoichi Yuasa
  *         yyuasa@mvista.com or source@mvista.com
  *
- * Copyright 2001,2002 MontaVista Software Inc.
+ * Copyright 2001-2003 MontaVista Software Inc.
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -49,9 +49,7 @@
 #include <asm/pci_channel.h>
 #include <asm/vr41xx/vr41xx.h>
 
-#include "pciu.h"
-
-extern unsigned long vr41xx_vtclock;
+#include "pci-vr41xx.h"
 
 static inline int vr41xx_pci_config_access(unsigned char bus,
 					   unsigned int devfn, int where)
@@ -150,6 +148,7 @@
 void __init vr41xx_pciu_init(struct vr41xx_pci_address_map *map)
 {
 	struct vr41xx_pci_address_space *s;
+	unsigned long vtclock;
 	u32 config;
 	int n;
 
@@ -169,11 +168,12 @@
 	udelay(1);
 
 	/* Select PCI clock */
-	if (vr41xx_vtclock < MAX_PCI_CLOCK)
+	vtclock = vr41xx_get_vtclock_frequency();
+	if (vtclock < MAX_PCI_CLOCK)
 		writel(EQUAL_VTCLOCK, PCICLKSELREG);
-	else if ((vr41xx_vtclock / 2) < MAX_PCI_CLOCK)
+	else if ((vtclock / 2) < MAX_PCI_CLOCK)
 		writel(HALF_VTCLOCK, PCICLKSELREG);
-	else if ((vr41xx_vtclock / 4) < MAX_PCI_CLOCK)
+	else if ((vtclock / 4) < MAX_PCI_CLOCK)
 		writel(QUARTER_VTCLOCK, PCICLKSELREG);
 	else
 		printk(KERN_INFO "Warning: PCI Clock is over 33MHz.\n");
