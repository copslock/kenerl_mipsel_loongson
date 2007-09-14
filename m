Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2007 09:26:34 +0100 (BST)
Received: from p549F7FC7.dip.t-dialin.net ([84.159.127.199]:38071 "EHLO
	p549F7FC7.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20021604AbXINIZz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Sep 2007 09:25:55 +0100
Received: from mo31.po.2iij.NET ([210.128.50.54]:14886 "EHLO mo31.po.2iij.net")
	by lappi.linux-mips.net with ESMTP id S1097027AbXINISM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2007 10:18:12 +0200
Received: by mo.po.2iij.net (mo31) id l8E8FZi2052248; Fri, 14 Sep 2007 17:15:35 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox303) id l8E8FY71030615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Sep 2007 17:15:35 +0900
Message-Id: <200709140815.l8E8FY71030615@po-mbox303.hop.2iij.net>
Date:	Fri, 14 Sep 2007 17:14:53 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][9/9][MIPS] move Cobalt reset port definition
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Move Cobalt reset port definition to arch/mips/cobalt/reset.c.
It's only used in arch/mips/cobalt/reset.c.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/reset.c mips/arch/mips/cobalt/reset.c
--- mips-orig/arch/mips/cobalt/reset.c	2007-09-14 17:00:18.019985750 +0900
+++ mips/arch/mips/cobalt/reset.c	2007-09-14 17:02:41.430175000 +0900
@@ -13,9 +13,11 @@
 #include <linux/kernel.h>
 #include <linux/leds.h>
 
+#include <asm/io.h>
 #include <asm/processor.h>
 
-#include <cobalt.h>
+#define COBALT_RESET_PORT	((void __iomem *)CKSEG1ADDR(0x1c000000))
+#define COBALT_RESET		0x0f
 
 DEFINE_LED_TRIGGER(power_off_led_trigger);
 
@@ -39,7 +41,7 @@ void cobalt_machine_halt(void)
 
 void cobalt_machine_restart(char *command)
 {
-	COBALT_LED_PORT = COBALT_LED_RESET;
+	writeb(COBALT_RESET, COBALT_RESET_PORT);
 
 	/* we should never get here */
 	cobalt_machine_halt();
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/cobalt.h mips/include/asm-mips/mach-cobalt/cobalt.h
--- mips-orig/include/asm-mips/mach-cobalt/cobalt.h	2007-09-14 17:00:31.066027750 +0900
+++ mips/include/asm-mips/mach-cobalt/cobalt.h	2007-09-14 17:03:35.809573500 +0900
@@ -1,5 +1,5 @@
 /*
- * Lowlevel hardware stuff for the MIPS based Cobalt microservers.
+ * The Cobalt board ID information.
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -12,9 +12,6 @@
 #ifndef __ASM_COBALT_H
 #define __ASM_COBALT_H
 
-/*
- * The Cobalt board ID information.
- */
 extern int cobalt_board_id;
 
 #define COBALT_BRD_ID_QUBE1    0x3
@@ -22,11 +19,4 @@ extern int cobalt_board_id;
 #define COBALT_BRD_ID_QUBE2    0x5
 #define COBALT_BRD_ID_RAQ2     0x6
 
-#define COBALT_LED_PORT		(*(volatile unsigned char *) CKSEG1ADDR(0x1c000000))
-# define COBALT_LED_BAR_LEFT	(1 << 0)	/* Qube */
-# define COBALT_LED_BAR_RIGHT	(1 << 1)	/* Qube */
-# define COBALT_LED_WEB		(1 << 2)	/* RaQ */
-# define COBALT_LED_POWER_OFF	(1 << 3)	/* RaQ */
-# define COBALT_LED_RESET	0x0f
-
 #endif /* __ASM_COBALT_H */
