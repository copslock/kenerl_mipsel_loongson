Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2007 14:57:08 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:28438 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022493AbXE1N5G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 May 2007 14:57:06 +0100
Received: by mo.po.2iij.net (mo30) id l4SDv3Bd054345; Mon, 28 May 2007 22:57:03 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox31) id l4SDuvnn050697
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 28 May 2007 22:56:58 +0900 (JST)
Date:	Mon, 28 May 2007 22:54:28 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][1/2] remove "support for" from system type entry
Message-Id: <20070528225428.016e473d.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed "Support for" from system type entry in arch/mips/Kconfig.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/Kconfig mips/arch/mips/Kconfig
--- mips-orig/arch/mips/Kconfig	2007-05-14 19:44:04.377505000 +0900
+++ mips/arch/mips/Kconfig	2007-05-14 19:44:42.419882500 +0900
@@ -317,7 +317,7 @@ config PNX8550_JBS
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config PNX8550_STB810
-	bool "Support for Philips PNX8550 based STB810 board"
+	bool "Philips PNX8550 based STB810 board"
 	select PNX8550
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
@@ -392,7 +392,7 @@ config QEMU
 	  can be found at http://www.linux-mips.org/wiki/Qemu.
 
 config MARKEINS
-	bool "Support for NEC EMMA2RH Mark-eins"
+	bool "NEC EMMA2RH Mark-eins"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select IRQ_CPU
