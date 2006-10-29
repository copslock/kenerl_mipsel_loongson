Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Oct 2006 14:45:20 +0000 (GMT)
Received: from mo30.po.2iij.net ([210.128.50.53]:14094 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037803AbWJ2OpN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Oct 2006 14:45:13 +0000
Received: by mo.po.2iij.net (mo30) id k9TEjAqj024934; Sun, 29 Oct 2006 23:45:10 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox33) id k9TEj4CF018988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 29 Oct 2006 23:45:04 +0900 (JST)
Date:	Sun, 29 Oct 2006 23:37:55 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix return value of TXX9 SPI interrupt handler
Message-Id: <20061029233755.46d0f83d.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has fixed return value of TXX9 SPI interrupt handler.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c mips/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c
--- mips-orig/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c	2006-10-29 13:07:08.343277000 +0900
+++ mips/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c	2006-10-29 14:33:04.768167250 +0900
@@ -36,14 +36,18 @@ void __init txx9_spi_init(unsigned long 
 
 static DECLARE_WAIT_QUEUE_HEAD(txx9_spi_wait);
 
-static void txx9_spi_interrupt(int irq, void *dev_id)
+static irqreturn_t txx9_spi_interrupt(int irq, void *dev_id)
 {
 	/* disable rx intr */
 	tx4938_spiptr->cr0 &= ~TXx9_SPCR0_RBSIE;
 	wake_up(&txx9_spi_wait);
+
+	return IRQ_HANDLED;
 }
+
 static struct irqaction txx9_spi_action = {
-	txx9_spi_interrupt, 0, 0, "spi", NULL, NULL,
+	.handler	= txx9_spi_interrupt,
+	.name		= "spi",
 };
 
 void __init txx9_spi_irqinit(int irc_irq)
