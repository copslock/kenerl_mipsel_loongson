Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 14:57:04 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:55611 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021594AbXJKN44 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Oct 2007 14:56:56 +0100
Received: by mo.po.2iij.net (mo31) id l9BDurwX031963; Thu, 11 Oct 2007 22:56:53 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox301) id l9BDulea030735
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Oct 2007 22:56:48 +0900
Date:	Thu, 11 Oct 2007 22:56:47 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] add select I8253 to MIPS Atlas
Message-Id: <20071011225647.1ac5ed27.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.0 (GTK+ 2.10.11; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add "select I8253" to MIPS Atlas

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-10-11 01:18:44.178964500 +0900
+++ mips/arch/mips/Kconfig	2007-10-11 09:52:57.598382750 +0900
@@ -173,6 +173,7 @@ config MIPS_ATLAS
 	select SYS_HAS_EARLY_PRINTK
 	select IRQ_CPU
 	select HW_HAS_PCI
+	select I8253
 	select MIPS_BOARDS_GEN
 	select MIPS_BONITO64
 	select PCI_GT64XXX_PCI0
