Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jan 2007 14:53:32 +0000 (GMT)
Received: from mo30.po.2iij.net ([210.128.50.53]:53056 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20041256AbXAKOx1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Jan 2007 14:53:27 +0000
Received: by mo.po.2iij.net (mo30) id l0BErO4j079771; Thu, 11 Jan 2007 23:53:24 +0900 (JST)
Received: from localhost.localdomain (45.28.30.125.dy.iij4u.or.jp [125.30.28.45])
	by mbox.po.2iij.net (mbox32) id l0BErIBb004005
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Jan 2007 23:53:19 +0900 (JST)
Date:	Thu, 11 Jan 2007 23:53:18 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] [MIPS] vr41xx: add MACINT controls
Message-Id: <20070111235318.49bf0820.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has added MACINT controls.
They are necessary for VR4133 ethernet driver.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/common/icu.c mips/arch/mips/vr41xx/common/icu.c
--- mips-orig/arch/mips/vr41xx/common/icu.c	2007-01-11 22:49:53.309677500 +0900
+++ mips/arch/mips/vr41xx/common/icu.c	2007-01-11 23:25:24.954897000 +0900
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2001-2002  MontaVista Software Inc.
  *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2003-2005  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2003-2006  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -68,6 +68,7 @@ static unsigned char sysint2_assign[16] 
 #define MPIUINTREG	0x0e
 #define MAIUINTREG	0x10
 #define MKIUINTREG	0x12
+#define MMACINTREG	0x12
 #define MGIUINTLREG	0x14
 #define MDSIUINTREG	0x16
 #define NMIREG		0x18
@@ -241,6 +242,30 @@ void vr41xx_disable_kiuint(uint16_t mask
 
 EXPORT_SYMBOL(vr41xx_disable_kiuint);
 
+void vr41xx_enable_macint(uint16_t mask)
+{
+	struct irq_desc *desc = irq_desc + ETHERNET_IRQ;
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	icu1_set(MMACINTREG, mask);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+EXPORT_SYMBOL(vr41xx_enable_macint);
+
+void vr41xx_disable_macint(uint16_t mask)
+{
+	struct irq_desc *desc = irq_desc + ETHERNET_IRQ;
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	icu1_clear(MMACINTREG, mask);
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+EXPORT_SYMBOL(vr41xx_disable_macint);
+
 void vr41xx_enable_dsiuint(uint16_t mask)
 {
 	struct irq_desc *desc = irq_desc + DSIU_IRQ;
