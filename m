Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 14:51:20 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:25373 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038549AbYFPNvO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jun 2008 14:51:14 +0100
Received: by mo.po.2iij.net (mo30) id m5GDp99d022566; Mon, 16 Jun 2008 22:51:09 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox304) id m5GDp8WQ012032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 16 Jun 2008 22:51:08 +0900
Date:	Mon, 16 Jun 2008 22:51:08 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] add initialize vr41xx PCI io_map_base
Message-Id: <20080616225108.b2d3789d.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add initialize vr41xx PCI io_map_base

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/pci/pci-vr41xx.c linux/arch/mips/pci/pci-vr41xx.c
--- linux-orig/arch/mips/pci/pci-vr41xx.c	2008-06-16 12:32:30.875464524 +0900
+++ linux/arch/mips/pci/pci-vr41xx.c	2008-06-16 15:26:52.520088759 +0900
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2001-2003 MontaVista Software Inc.
  *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2004-2005  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2004-2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *  Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -300,6 +300,18 @@ static int __init vr41xx_pciu_init(void)
 		ioport_resource.end = IO_PORT_RESOURCE_END;
 	}
 
+	if (setup->master_io) {
+		void __iomem *io_map_base;
+		struct resource *res = vr41xx_pci_controller.io_resource;
+		master = setup->master_io;
+		io_map_base = ioremap(master->bus_base_address,
+				      res->end - res->start + 1);
+		if (!io_map_base)
+			return -EBUSY;
+
+		vr41xx_pci_controller.io_map_base = (unsigned long)io_map_base;
+	}
+
 	register_pci_controller(&vr41xx_pci_controller);
 
 	return 0;
