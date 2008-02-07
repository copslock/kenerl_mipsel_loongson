Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2008 13:45:54 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:50494 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037335AbYBGNpV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Feb 2008 13:45:21 +0000
Received: by mo.po.2iij.net (mo31) id m17DjIV9000651; Thu, 7 Feb 2008 22:45:18 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox301) id m17DjGwW020650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 7 Feb 2008 22:45:17 +0900
Date:	Thu, 7 Feb 2008 22:39:45 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][3/5][MIPS] fix LASAT_CASCADE_IRQ
Message-Id: <20080207223945.32f20b2d.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080207222717.7d58f50a.yoichi_yuasa@tripeaks.co.jp>
References: <20080207222601.def26d7d.yoichi_yuasa@tripeaks.co.jp>
	<20080207222717.7d58f50a.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18189
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
