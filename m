Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 16:12:11 +0100 (BST)
Received: from [210.128.50.54] ([210.128.50.54]:18969 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S22301418AbYJXPLo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2008 16:11:44 +0100
Received: by mo.po.2iij.net (mo31) id m9OFBcTj011865; Sat, 25 Oct 2008 00:11:38 +0900 (JST)
Received: from delta (187.24.30.125.dy.iij4u.or.jp [125.30.24.187])
	by mbox.po.2iij.net (po-mbox304) id m9OFBXP0025177
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Oct 2008 00:11:33 +0900
Date:	Sat, 25 Oct 2008 00:11:33 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] Cobalt: add select PCI
Message-Id: <20081025001133.6aa25158.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

PCI bus is always necessary for Cobalt ID.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-orig/arch/mips/Kconfig	2008-10-19 22:36:34.973823677 +0900
+++ linux/arch/mips/Kconfig	2008-10-19 22:33:58.440903373 +0900
@@ -72,6 +72,7 @@ config MIPS_COBALT
 	select IRQ_CPU
 	select IRQ_GT641XX
 	select PCI_GT64XXX_PCI0
+	select PCI
 	select SYS_HAS_CPU_NEVADA
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
