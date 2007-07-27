Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2007 09:26:55 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:56131 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022040AbXG0I0x (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Jul 2007 09:26:53 +0100
Received: by mo.po.2iij.net (mo31) id l6R8PXmG094781; Fri, 27 Jul 2007 17:25:33 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox303) id l6R8PUtA018224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 27 Jul 2007 17:25:31 +0900
Date:	Fri, 27 Jul 2007 15:20:24 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][1/2][MIPS] fix RBTX49x7 board name
Message-Id: <20070727152024.0758f2f7.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Fix RBTX49x7 board name

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-07-27 13:53:02.871141250 +0900
+++ mips/arch/mips/Kconfig	2007-07-27 14:08:16.682243750 +0900
@@ -595,7 +595,7 @@ config TOSHIBA_JMR3927
 	select GENERIC_HARDIRQS_NO__DO_IRQ
 
 config TOSHIBA_RBTX4927
-	bool "Toshiba TBTX49[23]7 board"
+	bool "Toshiba RBTX49[23]7 board"
 	select DMA_NONCOHERENT
 	select HAS_TXX9_SERIAL
 	select HW_HAS_PCI
