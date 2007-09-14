Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2007 09:17:11 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:54344 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021580AbXINIPi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2007 09:15:38 +0100
Received: by mo.po.2iij.net (mo32) id l8E8FZLU037354; Fri, 14 Sep 2007 17:15:35 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id l8E8FXXs010307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Sep 2007 17:15:33 +0900
Message-Id: <200709140815.l8E8FXXs010307@po-mbox301.hop.2iij.net>
Date:	Fri, 14 Sep 2007 17:14:47 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][7/9][MIPS] add Cobalt Qube LED support
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add Cobalt Qube LED support.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/led.c mips/arch/mips/cobalt/led.c
--- mips-orig/arch/mips/cobalt/led.c	2007-09-12 13:48:40.740621250 +0900
+++ mips/arch/mips/cobalt/led.c	2007-09-12 13:47:59.474042250 +0900
@@ -22,6 +22,8 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 
+#include <cobalt.h>
+
 static struct resource cobalt_led_resource __initdata = {
 	.start	= 0x1c000000,
 	.end	= 0x1c000000,
@@ -33,7 +35,11 @@ static __init int cobalt_led_add(void)
 	struct platform_device *pdev;
 	int retval;
 
-	pdev = platform_device_alloc("Cobalt Raq LEDs", -1);
+	if (cobalt_board_id == COBALT_BRD_ID_QUBE1 ||
+	    cobalt_board_id == COBALT_BRD_ID_QUBE2)
+		pdev = platform_device_alloc("Cobalt Qube LEDs", -1);
+	else
+		pdev = platform_device_alloc("Cobalt Raq LEDs", -1);
 
 	if (!pdev)
 		return -ENOMEM;
