Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2006 01:31:57 +0100 (BST)
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:486 "EHLO
	mail8.fw-bc.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133827AbWDEAaH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Apr 2006 01:30:07 +0100
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id k350fB7s023767;
	Wed, 5 Apr 2006 00:41:11 GMT
Received: from [192.168.1.10] ([43.134.85.105])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k350fBtp008827;
	Wed, 5 Apr 2006 00:41:11 GMT
Message-ID: <44331227.8020903@am.sony.com>
Date:	Tue, 04 Apr 2006 17:41:11 -0700
From:	Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ralf@linux-mips.org, anemo@mba.ocn.ne.jp
CC:	linux-mips@linux-mips.org
Subject: [PATCH 2/4] fix rbtx4927 ne2000
Content-Type: multipart/mixed;
 boundary="------------050703020500010808000305"
Return-Path: <geoffrey.levand@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoffrey.levand@am.sony.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050703020500010808000305
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




--------------050703020500010808000305
Content-Type: text/x-patch;
 name="fix-rbtx4927-ne2000.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-rbtx4927-ne2000.patch"

fix-rbtx4927-ne2000.patch:

This patch fixes the ne2000 driver to work on rbtx4927 and rbtx4937
boards.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>


Index: linux-2.6.16.1/drivers/net/ne.c
===================================================================
--- linux-2.6.16.1.orig/drivers/net/ne.c	2006-03-23 10:55:43.000000000 -0800
+++ linux-2.6.16.1/drivers/net/ne.c	2006-03-23 14:04:59.000000000 -0800
@@ -53,9 +53,17 @@
 
 #include <asm/system.h>
 #include <asm/io.h>
-
-#if defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
-#include <asm/tx4938/rbtx4938.h>
+#if defined(CONFIG_TOSHIBA_RBTX4938)
+# include <asm/tx4938/rbtx4938.h>
+# define RBTX49_BASE 0x07f20280
+# define RBTX49_IRQ RBTX4938_RTL_8019_IRQ
+#elif defined(CONFIG_TOSHIBA_RBTX4927)
+# include <asm/tx4927/toshiba_rbtx4927.h>
+# define RBTX49_BASE RBTX4927_RTL_8019_BASE
+# define RBTX49_IRQ RBTX4927_RTL_8019_IRQ
+#else
+# define RBTX49_BASE 0
+# define RBTX49_IRQ 0
 #endif
 
 #include "8390.h"
@@ -115,9 +123,7 @@
     {"E-LAN100", "E-LAN200", {0x00, 0x00, 0x5d}}, /* Broken ne1000 clones */
     {"PCM-4823", "PCM-4823", {0x00, 0xc0, 0x6c}}, /* Broken Advantech MoBo */
     {"REALTEK", "RTL8019", {0x00, 0x00, 0xe8}}, /* no-name with Realtek chip */
-#if defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
     {"RBHMA4X00-RTL8019", "RBHMA4X00/RTL8019", {0x00, 0x60, 0x0a}},  /* Toshiba built-in */
-#endif
     {"LCS-8834", "LCS-8836", {0x04, 0x04, 0x37}}, /* ShinyNet (SET) */
     {NULL,}
 };
@@ -233,10 +239,11 @@
 	sprintf(dev->name, "eth%d", unit);
 	netdev_boot_setup_check(dev);
 
-#ifdef CONFIG_TOSHIBA_RBTX4938
-	dev->base_addr = 0x07f20280;
-	dev->irq = RBTX4938_RTL_8019_IRQ;
-#endif
+	if (RBTX49_BASE) {
+		dev->base_addr = RBTX49_BASE;
+		dev->irq = RBTX49_IRQ;
+	}
+	
 	err = do_ne_probe(dev);
 	if (err)
 		goto out;



--------------050703020500010808000305--
