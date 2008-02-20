Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Feb 2008 14:12:02 +0000 (GMT)
Received: from mo32.po.2iij.net ([210.128.50.17]:45074 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20030254AbYBTOMA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Feb 2008 14:12:00 +0000
Received: by mo.po.2iij.net (mo32) id m1KEBuHX029787; Wed, 20 Feb 2008 23:11:56 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox304) id m1KEBsq4030889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 20 Feb 2008 23:11:54 +0900
Date:	Wed, 20 Feb 2008 23:11:53 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix LASAT_CASCADE_IRQ
Message-Id: <20080220231153.77d7723a.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Fixed LASAT_CASCADE_IRQ

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-lasat/irq.h mips/include/asm-mips/mach-lasat/irq.h
--- mips-orig/include/asm-mips/mach-lasat/irq.h	2008-01-13 16:43:14.160048268 +0900
+++ mips/include/asm-mips/mach-lasat/irq.h	2008-01-14 21:27:55.180821709 +0900
@@ -1,7 +1,7 @@
 #ifndef _ASM_MACH_LASAT_IRQ_H
 #define _ASM_MACH_LASAT_IRQ_H
 
-#define LASAT_CASCADE_IRQ	(MIPS_CPU_IRQ_BASE + 0)
+#define LASAT_CASCADE_IRQ	(MIPS_CPU_IRQ_BASE + 2)
 
 #define LASAT_IRQ_BASE		8
 #define LASAT_IRQ_END		23
