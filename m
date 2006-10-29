Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Oct 2006 14:44:56 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:64041 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037775AbWJ2Ooy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Oct 2006 14:44:54 +0000
Received: by mo.po.2iij.net (mo31) id k9TEiojY068669; Sun, 29 Oct 2006 23:44:50 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox33) id k9TEimJp018894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 29 Oct 2006 23:44:49 +0900 (JST)
Date:	Sun, 29 Oct 2006 23:37:40 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove an unused variable about Au1000
Message-Id: <20061029233740.21a93cbb.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed an unused variable about Au1000.

arch/mips/au1000/common/time.c: In function `mips_timer_interrupt':
arch/mips/au1000/common/time.c:82: warning: unused variable `count'

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/common/time.c mips/arch/mips/au1000/common/time.c
--- mips-orig/arch/mips/au1000/common/time.c	2006-10-24 11:07:06.417642500 +0900
+++ mips/arch/mips/au1000/common/time.c	2006-10-24 11:51:54.583538000 +0900
@@ -79,7 +79,6 @@ unsigned long wtimer;
 void mips_timer_interrupt(void)
 {
 	int irq = 63;
-	unsigned long count;
 
 	irq_enter();
 	kstat_this_cpu.irqs[irq]++;
