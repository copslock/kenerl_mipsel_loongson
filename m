Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2004 16:52:33 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:31980 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226034AbUEZPvT>;
	Wed, 26 May 2004 16:51:19 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA02271;
	Thu, 27 May 2004 00:51:16 +0900 (JST)
Received: 4UMDO01 id i4QFpGu08976; Thu, 27 May 2004 00:51:16 +0900 (JST)
Received: 4UMRO00 id i4QFpEV28744; Thu, 27 May 2004 00:51:14 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 27 May 2004 00:51:12 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][5/14] vr41xx: update fixup-capcella.c
Message-Id: <20040527005112.7dc0ae6c.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

fixup-capcella.c was updated.

Please apply to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/pci/Makefile linux/arch/mips/pci/Makefile
--- linux-orig/arch/mips/pci/Makefile	Thu Apr 22 01:13:41 2004
+++ linux/arch/mips/pci/Makefile	Thu Apr 22 01:13:55 2004
@@ -50,4 +50,4 @@
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o ops-tx4927.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-capcella.o
 obj-$(CONFIG_MACH_VR41XX)	+= pci-vr41xx.o
-obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-victor-mpc30x.o
+obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
diff -urN -X dontdiff linux-orig/arch/mips/pci/fixup-capcella.c linux/arch/mips/pci/fixup-capcella.c
--- linux-orig/arch/mips/pci/fixup-capcella.c	Thu Nov 13 10:53:36 2003
+++ linux/arch/mips/pci/fixup-capcella.c	Thu Apr 22 01:13:55 2004
@@ -1,17 +1,21 @@
 /*
- * FILE NAME
- *	arch/mips/vr41xx/zao-capcella/pci_fixup.c
+ *  fixup-cappcela.c, The ZAO Networks Capcella specific PCI fixups.
  *
- * BRIEF MODULE DESCRIPTION
- *	The ZAO Networks Capcella specific PCI fixups.
+ *  Copyright (C) 2002,2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
- * Copyright 2002 Yoichi Yuasa
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
@@ -38,3 +42,7 @@
 {
 	return irq_tab_capcella[slot][pin];
 }
+
+struct pci_fixup pcibios_fixups[] __initdata = {
+	{	.pass = 0,	},
+};
