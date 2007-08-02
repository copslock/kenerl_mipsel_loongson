Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 04:49:23 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:59664 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021408AbXHBDtT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2007 04:49:19 +0100
Received: by mo.po.2iij.net (mo31) id l723m1mt017268; Thu, 2 Aug 2007 12:48:02 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id l723m0jQ001528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 2 Aug 2007 12:48:00 +0900
Message-Id: <200708020348.l723m0jQ001528@po-mbox300.hop.2iij.net>
Date:	Thu, 2 Aug 2007 12:48:00 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix au1xxx_gpio_direction_* return value
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Fix au1xxx_gpio_direction_* return value.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/au1000/common/gpio.c mips/arch/mips/au1000/common/gpio.c
--- mips-orig/arch/mips/au1000/common/gpio.c	2007-08-02 10:49:14.849705000 +0900
+++ mips/arch/mips/au1000/common/gpio.c	2007-08-02 10:49:35.158974250 +0900
@@ -131,12 +131,12 @@ int au1xxx_gpio_direction_input(unsigned
 {
 	if (gpio >= AU1XXX_GPIO_BASE)
 #if defined(CONFIG_SOC_AU1000)
-		;
+		return -ENODEV;
 #else
 		return au1xxx_gpio2_direction_input(gpio);
 #endif
-	else
-		return au1xxx_gpio1_direction_input(gpio);
+
+	return au1xxx_gpio1_direction_input(gpio);
 }
 
 EXPORT_SYMBOL(au1xxx_gpio_direction_input);
@@ -145,12 +145,12 @@ int au1xxx_gpio_direction_output(unsigne
 {
 	if (gpio >= AU1XXX_GPIO_BASE)
 #if defined(CONFIG_SOC_AU1000)
-		;
+		return -ENODEV;
 #else
 		return au1xxx_gpio2_direction_output(gpio, value);
 #endif
-	else
-		return au1xxx_gpio1_direction_output(gpio, value);
+
+	return au1xxx_gpio1_direction_output(gpio, value);
 }
 
 EXPORT_SYMBOL(au1xxx_gpio_direction_output);
