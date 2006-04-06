Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2006 03:56:33 +0100 (BST)
Received: from mo00.po.2iij.net ([210.130.202.204]:13775 "EHLO
	mo00.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S8133514AbWDFC4Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Apr 2006 03:56:24 +0100
Received: NPO MO00 id k3637dRZ004392; Thu, 6 Apr 2006 12:07:39 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (NPO-MR/mbox02) id k3637bv7025230
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Thu, 6 Apr 2006 12:07:38 +0900 (JST)
Date:	Thu, 6 Apr 2006 12:07:37 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: [PATCH] vr41xx: fix plat_irq_dispatch()
Message-Id: <20060406120737.689accd3.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: tripeaks.co.jp
Envelope-Id: tripeaks.co.jp
X-archive-position: 11043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed the wrong conversion of plat_irq_dispatch() for vr41xx.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>


diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/vr41xx/common/irq.c mips/arch/mips/vr41xx/common/irq.c
--- mips-orig/arch/mips/vr41xx/common/irq.c	2006-04-06 11:26:29.216597750 +0900
+++ mips/arch/mips/vr41xx/common/irq.c	2006-04-06 11:57:42.581675750 +0900
@@ -91,23 +91,16 @@ asmlinkage void plat_irq_dispatch(struct
 	if (pending & CAUSEF_IP7)
 		do_IRQ(7, regs);
 	else if (pending & 0x7800) {
-		if (pending & CAUSEF_IP3) {
+		if (pending & CAUSEF_IP3)
 			irq_dispatch(3, regs);
-			return;
-		} else if (pending & CAUSEF_IP4) {
+		else if (pending & CAUSEF_IP4)
 			irq_dispatch(4, regs);
-			return;
-		} else if (pending & CAUSEF_IP5) {
+		else if (pending & CAUSEF_IP5)
 			irq_dispatch(5, regs);
-			return;
-		} else if (pending & CAUSEF_IP6) {
+		else if (pending & CAUSEF_IP6)
 			irq_dispatch(6, regs);
-			return;
-		}
-	}
-
-	if (pending & CAUSEF_IP2)
-		do_IRQ(2, regs);
+	} else if (pending & CAUSEF_IP2)
+		irq_dispatch(2, regs);
 	else if (pending & CAUSEF_IP0)
 		do_IRQ(0, regs);
 	else if (pending & CAUSEF_IP1)
