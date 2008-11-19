Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2008 13:45:22 +0000 (GMT)
Received: from mo30.po.2iij.NET ([210.128.50.53]:35383 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S23769872AbYKSNpQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2008 13:45:16 +0000
Received: by mo.po.2iij.net (mo30) id mAJDj8jZ031315; Wed, 19 Nov 2008 22:45:08 +0900 (JST)
Received: from delta (187.24.30.125.dy.iij4u.or.jp [125.30.24.187])
	by mbox.po.2iij.net (po-mbox305) id mAJDj4Zi012453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Nov 2008 22:45:04 +0900
Date:	Wed, 19 Nov 2008 22:45:04 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][RESEND][MIPS] fix Cobalt config
Message-Id: <20081119224504.7d9548fb.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

PCI bus is always required for Cobalt server.
Cobalt ID requires CONFIG_PCI.

This patch adds "select PCI" to config MIPS_COBLAT.

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
