Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 12:53:14 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:20772 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20026790AbXKAMwp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2007 12:52:45 +0000
Received: by mo.po.2iij.net (mo31) id lA1CpQqH060965; Thu, 1 Nov 2007 21:51:26 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox302) id lA1CpN13031798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 1 Nov 2007 21:51:24 +0900
Date:	Thu, 1 Nov 2007 21:51:23 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix Cobalt IRQ comment
Message-Id: <20071101215123.5e65eee6.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Fixed Cobalt IRQ comment.
Cobalt kernel uses CP0 counter now.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/irq.h mips/include/asm-mips/mach-cobalt/irq.h
--- mips-orig/include/asm-mips/mach-cobalt/irq.h	2007-10-27 17:13:58.239256750 +0900
+++ mips/include/asm-mips/mach-cobalt/irq.h	2007-10-27 17:17:45.905485000 +0900
@@ -35,7 +35,7 @@
  *	4 - ethernet
  *	5 - 16550 UART
  *	6 - cascade i8259
- *	7 - CP0 counter (unused)
+ *	7 - CP0 counter
  */
 #define MIPS_CPU_IRQ_BASE		16
 
@@ -48,7 +48,6 @@
 #define SCSI_IRQ			(MIPS_CPU_IRQ_BASE + 5)
 #define I8259_CASCADE_IRQ		(MIPS_CPU_IRQ_BASE + 6)
 
-
 #define GT641XX_IRQ_BASE		24
 
 #include <asm/irq_gt641xx.h>
