Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2004 07:21:14 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:34002 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225331AbUBFHVN>;
	Fri, 6 Feb 2004 07:21:13 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id QAA16188;
	Fri, 6 Feb 2004 16:21:09 +0900 (JST)
Received: 4UMDO01 id i167L9j28130; Fri, 6 Feb 2004 16:21:09 +0900 (JST)
Received: 4UMRO00 id i167L8N00830; Fri, 6 Feb 2004 16:21:08 +0900 (JST)
	from rally.montavista.co.jp (sonicwall.montavista.co.jp [202.232.97.131]) (authenticated)
Date: Fri, 6 Feb 2004 16:21:09 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2.4] Merged vr41xx_pci_ops into vr41xx.h
Message-Id: <20040206162109.3a9e6bad.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I made a patch for vr41xx PCI.
"vr41xx_pci_ops" which has more than one were merged into vr41xx.h.

Please apply this patch to v2.4.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/nec-eagle/setup.c linux/arch/mips/vr41xx/nec-eagle/setup.c
--- linux-orig/arch/mips/vr41xx/nec-eagle/setup.c	2004-02-06 11:21:47.000000000 +0900
+++ linux/arch/mips/vr41xx/nec-eagle/setup.c	2004-02-06 15:51:03.000000000 +0900
@@ -70,8 +70,6 @@
 	IORESOURCE_MEM
 };
 
-extern struct pci_ops vr41xx_pci_ops;
-
 struct pci_channel mips_pci_channels[] = {
 	{&vr41xx_pci_ops, &vr41xx_pci_io_resource, &vr41xx_pci_mem_resource, 0, 256},
 	{NULL, NULL, NULL, 0, 0}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c linux/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	2004-02-06 11:21:47.000000000 +0900
+++ linux/arch/mips/vr41xx/tanbac-tb0226/setup.c	2004-02-06 15:51:03.000000000 +0900
@@ -38,8 +38,6 @@
 	IORESOURCE_MEM
 };
 
-extern struct pci_ops vr41xx_pci_ops;
-
 struct pci_channel mips_pci_channels[] = {
 	{&vr41xx_pci_ops, &vr41xx_pci_io_resource, &vr41xx_pci_mem_resource, 0, 256},
 	{NULL, NULL, NULL, 0, 0}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c linux/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- linux-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	2004-02-06 11:21:47.000000000 +0900
+++ linux/arch/mips/vr41xx/tanbac-tb0229/setup.c	2004-02-06 15:51:03.000000000 +0900
@@ -43,8 +43,6 @@
 	.flags	= IORESOURCE_MEM,
 };
 
-extern struct pci_ops vr41xx_pci_ops;
-
 struct pci_channel mips_pci_channels[] = {
 	{	.pci_ops	= &vr41xx_pci_ops,
 		.io_resource	= &vr41xx_pci_io_resource,
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c linux/arch/mips/vr41xx/victor-mpc30x/setup.c
--- linux-orig/arch/mips/vr41xx/victor-mpc30x/setup.c	2004-02-06 11:21:47.000000000 +0900
+++ linux/arch/mips/vr41xx/victor-mpc30x/setup.c	2004-02-06 15:51:03.000000000 +0900
@@ -39,8 +39,6 @@
 	IORESOURCE_MEM
 };
 
-extern struct pci_ops vr41xx_pci_ops;
-
 struct pci_channel mips_pci_channels[] = {
 	{&vr41xx_pci_ops, &vr41xx_pci_io_resource, &vr41xx_pci_mem_resource, 0, 256},
 	{NULL, NULL, NULL, 0, 0}
diff -urN -X dontdiff linux-orig/arch/mips/vr41xx/zao-capcella/setup.c linux/arch/mips/vr41xx/zao-capcella/setup.c
--- linux-orig/arch/mips/vr41xx/zao-capcella/setup.c	2004-02-06 11:21:47.000000000 +0900
+++ linux/arch/mips/vr41xx/zao-capcella/setup.c	2004-02-06 15:51:03.000000000 +0900
@@ -39,8 +39,6 @@
 	IORESOURCE_MEM
 };
 
-extern struct pci_ops vr41xx_pci_ops;
-
 struct pci_channel mips_pci_channels[] = {
 	{&vr41xx_pci_ops, &vr41xx_pci_io_resource, &vr41xx_pci_mem_resource, 0, 256},
 	{NULL, NULL, NULL, 0, 0}
diff -urN -X dontdiff linux-orig/include/asm-mips/vr41xx/vr41xx.h linux/include/asm-mips/vr41xx/vr41xx.h
--- linux-orig/include/asm-mips/vr41xx/vr41xx.h	2003-12-16 05:27:37.000000000 +0900
+++ linux/include/asm-mips/vr41xx/vr41xx.h	2004-02-06 15:51:03.000000000 +0900
@@ -221,6 +221,8 @@
 
 extern void vr41xx_pciu_init(struct vr41xx_pci_address_map *map);
 
+extern struct pci_ops vr41xx_pci_ops;
+
 /*
  * MISC
  */
