Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2009 12:32:12 +0000 (GMT)
Received: from mow300.po.2iij.NET ([210.128.50.200]:54730 "EHLO
	mow.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S21366146AbZAYMbx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Jan 2009 12:31:53 +0000
Received: by mow.po.2iij.net (mow300) id n0PCVo0b002664; Sun, 25 Jan 2009 21:31:50 +0900
Received: from delta (133.6.30.125.dy.iij4u.or.jp [125.30.6.133])
	by mbox.po.2iij.net (po-mbox301) id n0PCVjLw016789
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Jan 2009 21:31:45 +0900
Date:	Sun, 25 Jan 2009 21:25:11 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] Cobalt: add select PCI
Message-Id: <20090125212511.b64bc630.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

PCI bus is always required for Cobalt ID.

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
