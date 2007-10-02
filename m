Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 15:24:03 +0100 (BST)
Received: from mo31.po.2iij.NET ([210.128.50.54]:62991 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024272AbXJBOXz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 15:23:55 +0100
Received: by mo.po.2iij.net (mo31) id l92EMb5d098181; Tue, 2 Oct 2007 23:22:37 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox303) id l92EMam7007234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Oct 2007 23:22:36 +0900
Date:	Tue, 2 Oct 2007 23:17:38 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][3/4] move Cobalt reset port definition to
 arch/mips/cobalt/reset.c
Message-Id: <20071002231738.78779515.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20071002231317.0fbaf7bb.yoichi_yuasa@tripeaks.co.jp>
References: <20071002225441.63d935eb.yoichi_yuasa@tripeaks.co.jp>
	<20071002231317.0fbaf7bb.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.0 (GTK+ 2.10.11; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16791
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
--- mips-orig/arch/mips/cobalt/reset.c	2007-09-30 21:09:22.860275250 +0900
+++ mips/arch/mips/cobalt/reset.c	2007-09-30 21:13:17.078913000 +0900
@@ -9,11 +9,15 @@
  * Copyright (C) 2001 by Liam Davies (ldavies@agile.tv)
  */
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/jiffies.h>
 #include <linux/leds.h>
 
 #include <cobalt.h>
 
+#define RESET_PORT	((void __iomem *)CKSEG1ADDR(0x1c000000))
+#define RESET		0x0f
+
 DEFINE_LED_TRIGGER(power_off_led_trigger);
 
 static int __init ledtrig_power_off_init(void)
@@ -43,7 +47,7 @@ void cobalt_machine_halt(void)
 		last ^= diff;
 
 		if((diff & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)) && !(~last & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)))
-			COBALT_LED_PORT = COBALT_LED_RESET;
+			writeb(RESET, RESET_PORT);
 
 		for (mark = jiffies; jiffies - mark < HZ;)
 			;
@@ -52,7 +56,7 @@ void cobalt_machine_halt(void)
 
 void cobalt_machine_restart(char *command)
 {
-	COBALT_LED_PORT = COBALT_LED_RESET;
+	writeb(RESET, RESET_PORT);
 
 	/* we should never get here */
 	cobalt_machine_halt();
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/cobalt.h mips/include/asm-mips/mach-cobalt/cobalt.h
--- mips-orig/include/asm-mips/mach-cobalt/cobalt.h	2007-09-30 21:10:04.230860750 +0900
+++ mips/include/asm-mips/mach-cobalt/cobalt.h	2007-09-30 21:11:01.626447750 +0900
@@ -22,13 +22,6 @@ extern int cobalt_board_id;
 #define COBALT_BRD_ID_QUBE2    0x5
 #define COBALT_BRD_ID_RAQ2     0x6
 
-#define COBALT_LED_PORT		(*(volatile unsigned char *) CKSEG1ADDR(0x1c000000))
-# define COBALT_LED_BAR_LEFT	(1 << 0)	/* Qube */
-# define COBALT_LED_BAR_RIGHT	(1 << 1)	/* Qube */
-# define COBALT_LED_WEB		(1 << 2)	/* RaQ */
-# define COBALT_LED_POWER_OFF	(1 << 3)	/* RaQ */
-# define COBALT_LED_RESET	0x0f
-
 #define COBALT_KEY_PORT		((~*(volatile unsigned int *) CKSEG1ADDR(0x1d000000) >> 24) & COBALT_KEY_MASK)
 # define COBALT_KEY_CLEAR	(1 << 1)
 # define COBALT_KEY_LEFT	(1 << 2)
