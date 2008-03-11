Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Mar 2008 23:06:08 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:53012 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28578449AbYCKXGF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Mar 2008 23:06:05 +0000
Received: by mo.po.2iij.net (mo31) id m2BN62YP096078; Wed, 12 Mar 2008 08:06:02 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id m2BN5uFm019082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Mar 2008 08:05:56 +0900
Date:	Wed, 12 Mar 2008 08:05:10 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6.25][MIPS] fix LASAT_CASCADE_IRQ number
Message-Id: <20080312080510.6aef9a0d.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

The patch has fixed LASAT_CASCADE_IRQ number.

This is 2.6.25 stuff.

Yoichi

Fix LASAT_CASCADE_IRQ number.

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
