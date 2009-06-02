Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 15:17:21 +0100 (WEST)
Received: from mow301.po.2iij.net ([210.128.50.232]:58787 "EHLO
	mow.po.2iij.net" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022066AbZFBORP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2009 15:17:15 +0100
Received: by mow.po.2iij.net (mow301) id n52EHCna000941; Tue, 2 Jun 2009 23:17:12 +0900
Received: from fulvia (199.9.30.125.dy.iij4u.or.jp [125.30.9.199])
	by mbox.po.2iij.net (po-mbox303) id n52EH7gQ031140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Jun 2009 23:17:08 +0900
Date:	Tue, 2 Jun 2009 23:17:07 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] PCI bus is always required for Cobalt ID
Message-Id: <20090602231707.7bf24ee2.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


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
