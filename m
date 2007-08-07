Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 15:32:21 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:56603 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022150AbXHGOcT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2007 15:32:19 +0100
Received: by mo.po.2iij.net (mo30) id l77EWGnf050858; Tue, 7 Aug 2007 23:32:16 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox301) id l77EWEOE028418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Aug 2007 23:32:14 +0900
Date:	Tue, 7 Aug 2007 23:32:13 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove remaining Ocelot support
Message-Id: <20070807233213.245e1875.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove remaining Ocelot support

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-08-05 16:55:28.106004500 +0900
+++ mips/arch/mips/Kconfig	2007-08-05 16:54:46.527406000 +0900
@@ -806,20 +806,6 @@ config EMMA2RH
 config SERIAL_RM9000
 	bool
 
-#
-# Unfortunately not all GT64120 systems run the chip at the same clock.
-# As the user for the clock rate and try to minimize the available options.
-#
-choice
-	prompt "Galileo Chip Clock"
-	depends on MOMENCO_OCELOT
-	default SYSCLK_100 if MOMENCO_OCELOT
-
-config SYSCLK_100
-	bool "100" if MOMENCO_OCELOT
-
-endchoice
-
 config ARC32
 	bool
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-ocelot/mach-gt64120.h mips/include/asm-mips/mach-ocelot/mach-gt64120.h
--- mips-orig/include/asm-mips/mach-ocelot/mach-gt64120.h	2007-08-05 16:49:44.376522750 +0900
+++ mips/include/asm-mips/mach-ocelot/mach-gt64120.h	1970-01-01 09:00:00.000000000 +0900
@@ -1,30 +0,0 @@
-/*
- * Copyright 2001 MontaVista Software Inc.
- * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#ifndef _ASM_GT64120_MOMENCO_OCELOT_GT64120_DEP_H
-#define _ASM_GT64120_MOMENCO_OCELOT_GT64120_DEP_H
-
-/*
- * PCI address allocation
- */
-#define GT_PCI_MEM_BASE	(0x22000000UL)
-#define GT_PCI_MEM_SIZE	GT_DEF_PCI0_MEM0_SIZE
-#define GT_PCI_IO_BASE	(0x20000000UL)
-#define GT_PCI_IO_SIZE	GT_DEF_PCI0_IO_SIZE
-
-extern unsigned long gt64120_base;
-
-#define GT64120_BASE	(gt64120_base)
-
-/*
- * GT timer irq
- */
-#define	GT_TIMER		6
-
-#endif  /* _ASM_GT64120_MOMENCO_OCELOT_GT64120_DEP_H */
