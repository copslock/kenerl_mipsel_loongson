Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 10:29:18 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:15404 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024319AbXIUJ2c (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 10:28:32 +0100
Received: by mo.po.2iij.net (mo30) id l8L9RFp5092575; Fri, 21 Sep 2007 18:27:15 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id l8L9REUE018530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Sep 2007 18:27:14 +0900
Message-Id: <200709210927.l8L9REUE018530@po-mbox300.hop.2iij.net>
Date:	Fri, 21 Sep 2007 18:24:50 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, Richard Purdie <rpurdie@rpsys.net>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH take2][4/5] led: add Cobalt Qube series front LED support to
 platform register
References: <20070921182026.f2adbd6a.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add Cobalt Qube series front LED support to platform register.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/led.c mips/arch/mips/cobalt/led.c
--- mips-orig/arch/mips/cobalt/led.c	2007-09-21 13:05:53.812412000 +0900
+++ mips/arch/mips/cobalt/led.c	2007-09-21 13:20:02.105427000 +0900
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
 
-	pdev = platform_device_alloc("cobalt-raq-leds", -1);
+	if (cobalt_board_id == COBALT_BRD_ID_QUBE1 ||
+	    cobalt_board_id == COBALT_BRD_ID_QUBE2)
+		pdev = platform_device_alloc("cobalt-qube-leds", -1);
+	else
+		pdev = platform_device_alloc("cobalt-raq-leds", -1);
 
 	if (!pdev)
 		return -ENOMEM;
