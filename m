Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 16:27:20 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:8222 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038867AbWJMP1O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Oct 2006 16:27:14 +0100
Received: by mo.po.2iij.net (mo32) id k9DFRBOx041290; Sat, 14 Oct 2006 00:27:11 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox32) id k9DFR8uP026663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 14 Oct 2006 00:27:08 +0900 (JST)
Date:	Sat, 14 Oct 2006 00:27:07 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] remove #include <linux/config.h>
Message-Id: <20061014002707.0adb2f40.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch has removed "#include <linux/config.h>" from your tree.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/char/au1000_gpio.c mips/drivers/char/au1000_gpio.c
--- mips-orig/drivers/char/au1000_gpio.c	2006-10-13 15:02:59.902458250 +0900
+++ mips/drivers/char/au1000_gpio.c	2006-10-13 15:07:54.443447000 +0900
@@ -31,7 +31,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/char/sb1250_duart.c mips/drivers/char/sb1250_duart.c
--- mips-orig/drivers/char/sb1250_duart.c	2006-10-13 15:03:00.022405750 +0900
+++ mips/drivers/char/sb1250_duart.c	2006-10-13 15:07:16.553079000 +0900
@@ -21,7 +21,6 @@
  * running in asynchronous mode.  Also, support for doing a serial console
  * on one of those ports 
  */
-#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/serial.h>
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/net/gt64240eth.h mips/drivers/net/gt64240eth.h
--- mips-orig/drivers/net/gt64240eth.h	2006-10-13 15:03:00.898022500 +0900
+++ mips/drivers/net/gt64240eth.h	2006-10-13 15:08:10.372442500 +0900
@@ -32,7 +32,6 @@
 #ifndef _GT64240ETH_H
 #define _GT64240ETH_H
 
-#include <linux/config.h>
 #include <asm/gt64240.h>
 
 #define ETHERNET_PORTS_DIFFERENCE_OFFSETS	0x400
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/net/titan_ge.c mips/drivers/net/titan_ge.c
--- mips-orig/drivers/net/titan_ge.c	2006-10-13 15:03:01.061950750 +0900
+++ mips/drivers/net/titan_ge.c	2006-10-13 15:07:16.553079000 +0900
@@ -46,7 +46,6 @@
  * -> Fast routing for IP forwarding
  */
 
-#include <linux/config.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/net/titan_ge.h mips/drivers/net/titan_ge.h
--- mips-orig/drivers/net/titan_ge.h	2006-10-13 15:03:01.061950750 +0900
+++ mips/drivers/net/titan_ge.h	2006-10-13 15:07:16.553079000 +0900
@@ -1,10 +1,8 @@
 #ifndef _TITAN_GE_H_
 #define _TITAN_GE_H_
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/config.h>
 #include <linux/spinlock.h>
 #include <asm/byteorder.h>
 
diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/serial/ip3106_uart.c mips/drivers/serial/ip3106_uart.c
--- mips-orig/drivers/serial/ip3106_uart.c	2006-10-13 15:03:01.809623500 +0900
+++ mips/drivers/serial/ip3106_uart.c	2006-10-13 15:08:39.998294000 +0900
@@ -16,8 +16,6 @@
  *
  */
 
-#include <linux/config.h>
-
 #if defined(CONFIG_SERIAL_IP3106_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
 #endif
