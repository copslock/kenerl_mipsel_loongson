Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 13:27:21 +0000 (GMT)
Received: from mo30.po.2iij.net ([210.128.50.53]:55324 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20044398AbXARN1Q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2007 13:27:16 +0000
Received: by mo.po.2iij.net (mo30) id l0IDRDJi099608; Thu, 18 Jan 2007 22:27:13 +0900 (JST)
Received: from localhost.localdomain (69.25.30.125.dy.iij4u.or.jp [125.30.25.69])
	by mbox.po.2iij.net (mbox33) id l0IDRCPg025887
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Jan 2007 22:27:12 +0900 (JST)
Date:	Thu, 18 Jan 2007 22:27:11 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] update vr41xx IRQ numers
Message-Id: <20070118222711.4e6e4e8b.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has updated vr41xx IRQ numbers using definitions.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/common/irq.c mips/arch/mips/vr41xx/common/irq.c
--- mips-orig/arch/mips/vr41xx/common/irq.c	2006-12-02 22:54:49.989496500 +0900
+++ mips/arch/mips/vr41xx/common/irq.c	2006-12-01 23:53:55.826752500 +0900
@@ -1,7 +1,7 @@
 /*
  *  Interrupt handing routines for NEC VR4100 series.
  *
- *  Copyright (C) 2005  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2005-2006  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -89,22 +89,22 @@ asmlinkage void plat_irq_dispatch(void)
 	unsigned int pending = read_c0_cause() & read_c0_status() & ST0_IM;
 
 	if (pending & CAUSEF_IP7)
-		do_IRQ(7);
+		do_IRQ(TIMER_IRQ);
 	else if (pending & 0x7800) {
 		if (pending & CAUSEF_IP3)
-			irq_dispatch(3);
+			irq_dispatch(INT1_IRQ);
 		else if (pending & CAUSEF_IP4)
-			irq_dispatch(4);
+			irq_dispatch(INT2_IRQ);
 		else if (pending & CAUSEF_IP5)
-			irq_dispatch(5);
+			irq_dispatch(INT3_IRQ);
 		else if (pending & CAUSEF_IP6)
-			irq_dispatch(6);
+			irq_dispatch(INT4_IRQ);
 	} else if (pending & CAUSEF_IP2)
-		irq_dispatch(2);
+		irq_dispatch(INT0_IRQ);
 	else if (pending & CAUSEF_IP0)
-		do_IRQ(0);
+		do_IRQ(MIPS_SOFTINT0_IRQ);
 	else if (pending & CAUSEF_IP1)
-		do_IRQ(1);
+		do_IRQ(MIPS_SOFTINT1_IRQ);
 	else
 		spurious_interrupt();
 }
