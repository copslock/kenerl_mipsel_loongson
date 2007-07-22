Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2007 05:08:15 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:1080 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021902AbXGVEIN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Jul 2007 05:08:13 +0100
Received: by mo.po.2iij.net (mo30) id l6M46tLq004808; Sun, 22 Jul 2007 13:06:55 +0900 (JST)
Received: from localhost.localdomain (231.26.30.125.dy.iij4u.or.jp [125.30.26.231])
	by mbox.po.2iij.net (po-mbox301) id l6M46oKi012905
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 22 Jul 2007 13:06:50 +0900
Date:	Sun, 22 Jul 2007 13:06:49 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] remove unneeded reset function for jazz
Message-Id: <20070722130649.439bf4c2.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips


remove unneeded reset function for jazz

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/jazz/reset.c generic/arch/mips/jazz/reset.c
--- generic-orig/arch/mips/jazz/reset.c	2007-07-21 21:55:08.089094250 +0900
+++ generic/arch/mips/jazz/reset.c	2007-07-21 22:22:10.724855500 +0900
@@ -6,10 +6,6 @@
  */
 #include <linux/jiffies.h>
 #include <asm/jazz.h>
-#include <asm/io.h>
-#include <asm/system.h>
-#include <asm/reboot.h>
-#include <asm/delay.h>
 
 #define KBD_STAT_IBF		0x02	/* Keyboard input buffer full */
 
@@ -58,12 +54,3 @@ void jazz_machine_restart(char *command)
 		jazz_write_output (0x00);
 	}
 }
-
-void jazz_machine_halt(void)
-{
-}
-
-void jazz_machine_power_off(void)
-{
-	/* Jazz machines don't have a software power switch */
-}
diff -pruN -X generic/Documentation/dontdiff generic-orig/arch/mips/jazz/setup.c generic/arch/mips/jazz/setup.c
--- generic-orig/arch/mips/jazz/setup.c	2007-07-21 21:55:08.101095000 +0900
+++ generic/arch/mips/jazz/setup.c	2007-07-21 22:20:20.045938500 +0900
@@ -34,8 +34,6 @@
 extern asmlinkage void jazz_handle_int(void);
 
 extern void jazz_machine_restart(char *command);
-extern void jazz_machine_halt(void);
-extern void jazz_machine_power_off(void);
 
 void __init plat_timer_setup(struct irqaction *irq)
 {
@@ -95,8 +93,6 @@ void __init plat_mem_setup(void)
 	/* The RTC is outside the port address space */
 
 	_machine_restart = jazz_machine_restart;
-	_machine_halt = jazz_machine_halt;
-	pm_power_off = jazz_machine_power_off;
 
 	screen_info = (struct screen_info) {
 		0, 0,		/* orig-x, orig-y */
