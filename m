Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2007 06:09:19 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:56136 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021898AbXDPFJP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2007 06:09:15 +0100
Received: by mo.po.2iij.net (mo32) id l3G59BQe047736; Mon, 16 Apr 2007 14:09:11 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id l3G59A97089571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 16 Apr 2007 14:09:10 +0900 (JST)
Date:	Mon, 16 Apr 2007 14:09:10 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] remove double config entries in drivers/char/Kconfig
Message-Id: <20070416140910.47937dcf.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed double config entries in drivers/char/Kconfig.
This problem is only in linux-mips.org tree.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/char/Kconfig mips/drivers/char/Kconfig
--- mips-orig/drivers/char/Kconfig	2007-04-14 23:23:32.671598000 +0900
+++ mips/drivers/char/Kconfig	2007-04-15 00:35:22.059197250 +0900
@@ -396,41 +396,6 @@ config SERIAL_DEC
 	  kernel: saying N will just cause the configurator to skip all
 	  the questions about DECstation serial ports.
 
-	  If unsure, say Y.
-
-config SERIAL_DEC_CONSOLE
-	bool "Support for console on a DECstation serial port"
-	depends on SERIAL_DEC
-	default y
-	help
-	  If you say Y here, it will be possible to use a serial port as the
-	  system console (the system console is the device which receives all
-	  kernel messages and warnings and which allows logins in single user
-	  mode).  Note that the firmware uses ttyS0 as the serial console on
-	  the Maxine and ttyS2 on the others.
-
-	  If unsure, say Y.
-
-config ZS
-	bool "Z85C30 Serial Support"
-	depends on SERIAL_DEC
-	default y
-	help
-	  Documentation on the Zilog 85C350 serial communications controller
-	  is downloadable at <http://www.zilog.com/pdfs/serial/z85c30.pdf>.
-
-config SERIAL_DEC
-	bool "DECstation serial support"
-	depends on MACH_DECSTATION
-	default y
-	help
-	  This selects whether you want to be asked about drivers for
-	  DECstation serial ports.
-
-	  Note that the answer to this question won't directly affect the
-	  kernel: saying N will just cause the configurator to skip all
-	  the questions about DECstation serial ports.
-
 config SERIAL_DEC_CONSOLE
 	bool "Support for console on a DECstation serial port"
 	depends on SERIAL_DEC
