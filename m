Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 15:55:32 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:52792 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133775AbWFTOzX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2006 15:55:23 +0100
Received: by mo.po.2iij.net (mo31) id k5KEtLdV016324; Tue, 20 Jun 2006 23:55:21 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox32) id k5KEtJV2039635
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 20 Jun 2006 23:55:19 +0900 (JST)
Date:	Tue, 20 Jun 2006 23:55:17 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] remove first timer interrupt setup in wrppmc_timer_setup()
Message-Id: <20060620235517.504d31a1.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

This patch removes first timer interrupt setup in wrppmc_timer_setup().
The first timer interrupt setup already includes in time_init().

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/gt64120/wrppmc/time.c mips/arch/mips/gt64120/wrppmc/time.c
--- mips-orig/arch/mips/gt64120/wrppmc/time.c	2006-06-20 21:17:36.853537000 +0900
+++ mips/arch/mips/gt64120/wrppmc/time.c	2006-06-20 23:29:16.157391500 +0900
@@ -31,10 +31,6 @@ void __init wrppmc_timer_setup(struct ir
 {
 	/* Install ISR for timer interrupt */
 	setup_irq(WRPPMC_MIPS_TIMER_IRQ, irq);
-
-	/* to generate the first timer interrupt */
-	write_c0_compare(mips_hpt_frequency/HZ);
-	write_c0_count(0);
 }
 
 /*
