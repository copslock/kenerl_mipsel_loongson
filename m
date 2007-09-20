Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 15:14:28 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:53555 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022036AbXITOM6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2007 15:12:58 +0100
Received: by mo.po.2iij.net (mo30) id l8KEBeLM025008; Thu, 20 Sep 2007 23:11:40 +0900 (JST)
Received: from localhost.localdomain (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox302) id l8KEBZsi010917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Sep 2007 23:11:35 +0900
Date:	Thu, 20 Sep 2007 23:08:41 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, Richard Purdie <rpurdie@rpsys.net>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][5/6] led: add Cobalt Qube series front LED support to
 platform register
Message-Id: <20070920230841.5e4b0a05.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070920230656.640886f5.yoichi_yuasa@tripeaks.co.jp>
References: <20070920230204.0ad15513.yoichi_yuasa@tripeaks.co.jp>
	<20070920230322.6600dd83.yoichi_yuasa@tripeaks.co.jp>
	<20070920230513.1dbb1d6d.yoichi_yuasa@tripeaks.co.jp>
	<20070920230656.640886f5.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add Cobalt Qube series front LED support to platform register.

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
