Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 15:26:51 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:15127 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133761AbWFTO0k (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2006 15:26:40 +0100
Received: by mo.po.2iij.net (mo30) id k5KEQcTa050445; Tue, 20 Jun 2006 23:26:38 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox30) id k5KEQVF7047931
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 20 Jun 2006 23:26:32 +0900 (JST)
Date:	Tue, 20 Jun 2006 23:26:30 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] remove set_c0_status(ST0_IM) form wrppmc's irq.c
Message-Id: <20060620232630.3f2bc491.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

mips_cpu_irq_init() does clear_c0_status(ST0_IM) first.
I think that set_c0_status(ST0_IM) isn't necessary.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/wrppmc/irq.c mips/arch/mips/gt64120/wrppmc/irq.c
--- mips-orig/arch/mips/gt64120/wrppmc/irq.c	2006-06-20 21:17:36.853537000 +0900
+++ mips/arch/mips/gt64120/wrppmc/irq.c	2006-06-20 21:36:41.949101000 +0900
@@ -62,9 +62,6 @@ void gt64120_init_pic(void)
 
 void __init arch_init_irq(void)
 {
-	/* enable all CPU interrupt bits. */
-	set_c0_status(ST0_IM);	/* IE bit is still 0 */
-
 	/* IRQ 0 - 7 are for MIPS common irq_cpu controller */
 	mips_cpu_irq_init(0);
 
