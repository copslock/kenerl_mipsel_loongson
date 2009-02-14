Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Feb 2009 08:09:37 +0000 (GMT)
Received: from mow300.po.2iij.NET ([210.128.50.200]:4278 "EHLO mow.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S21364923AbZBNIJe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 14 Feb 2009 08:09:34 +0000
Received: by mow.po.2iij.net (mow300) id n1E89TtY017558; Sat, 14 Feb 2009 17:09:29 +0900
Received: from delta (133.6.30.125.dy.iij4u.or.jp [125.30.6.133])
	by mbox.po.2iij.net (po-mbox303) id n1E89QGA019880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 14 Feb 2009 17:09:26 +0900
Date:	Sat, 14 Feb 2009 17:09:26 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove "support for" from Cavium system type
Message-Id: <20090214170926.d750aaaf.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-orig/arch/mips/Kconfig	2009-02-14 16:56:19.274686578 +0900
+++ linux/arch/mips/Kconfig	2009-02-14 16:57:14.474681145 +0900
@@ -596,7 +596,7 @@ config WR_PPMC
 	  board, which is based on GT64120 bridge chip.
 
 config CAVIUM_OCTEON_SIMULATOR
-	bool "Support for the Cavium Networks Octeon Simulator"
+	bool "Cavium Networks Octeon Simulator"
 	select CEVT_R4K
 	select 64BIT_PHYS_ADDR
 	select DMA_COHERENT
@@ -610,7 +610,7 @@ config CAVIUM_OCTEON_SIMULATOR
 	  hardware.
 
 config CAVIUM_OCTEON_REFERENCE_BOARD
-	bool "Support for the Cavium Networks Octeon reference board"
+	bool "Cavium Networks Octeon reference board"
 	select CEVT_R4K
 	select 64BIT_PHYS_ADDR
 	select DMA_COHERENT
