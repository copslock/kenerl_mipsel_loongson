Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 15:15:24 +0100 (WEST)
Received: from mow301.po.2iij.net ([210.128.50.232]:34629 "EHLO
	mow.po.2iij.net" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022066AbZFBOPS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2009 15:15:18 +0100
Received: by mow.po.2iij.net (mow301) id n52EFDqQ000453; Tue, 2 Jun 2009 23:15:13 +0900
Received: from fulvia (199.9.30.125.dy.iij4u.or.jp [125.30.9.199])
	by mbox.po.2iij.net (po-mbox303) id n52EFAP9030173
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Jun 2009 23:15:11 +0900
Date:	Tue, 2 Jun 2009 23:15:10 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove "Support for" from Cavium system type
Message-Id: <20090602231510.339c24a3.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-orig/arch/mips/Kconfig	2009-04-16 21:22:33.885188833 +0900
+++ linux/arch/mips/Kconfig	2009-04-16 21:13:04.881168129 +0900
@@ -593,7 +593,7 @@ config WR_PPMC
 	  board, which is based on GT64120 bridge chip.
 
 config CAVIUM_OCTEON_SIMULATOR
-	bool "Support for the Cavium Networks Octeon Simulator"
+	bool "Cavium Networks Octeon Simulator"
 	select CEVT_R4K
 	select 64BIT_PHYS_ADDR
 	select DMA_COHERENT
@@ -607,7 +607,7 @@ config CAVIUM_OCTEON_SIMULATOR
 	  hardware.
 
 config CAVIUM_OCTEON_REFERENCE_BOARD
-	bool "Support for the Cavium Networks Octeon reference board"
+	bool "Cavium Networks Octeon reference board"
 	select CEVT_R4K
 	select 64BIT_PHYS_ADDR
 	select DMA_COHERENT
