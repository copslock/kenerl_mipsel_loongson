Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 12:30:55 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:46408 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20026775AbXKAMaq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2007 12:30:46 +0000
Received: by mo.po.2iij.net (mo31) id lA1CUgdq048730; Thu, 1 Nov 2007 21:30:42 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox305) id lA1CUb5E020131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 1 Nov 2007 21:30:37 +0900
Date:	Thu, 1 Nov 2007 21:30:36 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] bcm47xx: remove unneeded clear_c0_status()
Message-Id: <20071101213036.c383957f.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove unneeded clear_c0_status().
irq_cpu routines take care of it.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/bcm47xx/irq.c mips/arch/mips/bcm47xx/irq.c
--- mips-orig/arch/mips/bcm47xx/irq.c	2007-10-26 23:35:58.630600250 +0900
+++ mips/arch/mips/bcm47xx/irq.c	2007-10-26 23:40:22.587096500 +0900
@@ -33,8 +33,6 @@ void plat_irq_dispatch(void)
 
 	cause = read_c0_cause() & read_c0_status() & CAUSEF_IP;
 
-	clear_c0_status(cause);
-
 	if (cause & CAUSEF_IP7)
 		do_IRQ(7);
 	if (cause & CAUSEF_IP2)
