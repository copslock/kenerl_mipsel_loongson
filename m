Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 13:23:54 +0000 (GMT)
Received: from mo32.po.2iij.net ([210.128.50.17]:17946 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20032300AbXLLNXp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2007 13:23:45 +0000
Received: by mo.po.2iij.net (mo32) id lBCDNgdR006691; Wed, 12 Dec 2007 22:23:42 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox300) id lBCDNefa006383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Dec 2007 22:23:40 +0900
Date:	Wed, 12 Dec 2007 22:20:19 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][1/2][MIPS] remove unneeded button check for reset
Message-Id: <20071212222019.9ab7b2ed.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Removed unneeded button check for reset.
Because, the Cobalt has power switch.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/reset.c mips/arch/mips/cobalt/reset.c
--- mips-orig/arch/mips/cobalt/reset.c	2007-10-22 08:37:03.176567500 +0900
+++ mips/arch/mips/cobalt/reset.c	2007-10-22 09:28:23.004538000 +0900
@@ -10,7 +10,6 @@
  */
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/jiffies.h>
 #include <linux/leds.h>
 
 #include <cobalt.h>
@@ -29,29 +28,14 @@ device_initcall(ledtrig_power_off_init);
 
 void cobalt_machine_halt(void)
 {
-	int state, last, diff;
-	unsigned long mark;
-
 	/*
 	 * turn on power off LED on RaQ
-	 *
-	 * restart if ENTER and SELECT are pressed
 	 */
-
-	last = COBALT_KEY_PORT;
-
 	led_trigger_event(power_off_led_trigger, LED_FULL);
 
-	for (state = 0;;) {
-		diff = COBALT_KEY_PORT ^ last;
-		last ^= diff;
-
-		if((diff & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)) && !(~last & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)))
-			writeb(RESET, RESET_PORT);
-
-		for (mark = jiffies; jiffies - mark < HZ;)
-			;
-	}
+	local_irq_disable();
+	printk(KERN_INFO "You can switch the machine off now.\n");
+	while (1) ;
 }
 
 void cobalt_machine_restart(char *command)
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/cobalt.h mips/include/asm-mips/mach-cobalt/cobalt.h
--- mips-orig/include/asm-mips/mach-cobalt/cobalt.h	2007-10-22 08:40:46.866547250 +0900
+++ mips/include/asm-mips/mach-cobalt/cobalt.h	2007-10-22 09:27:42.101981750 +0900
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
@@ -22,14 +19,4 @@ extern int cobalt_board_id;
 #define COBALT_BRD_ID_QUBE2    0x5
 #define COBALT_BRD_ID_RAQ2     0x6
 
-#define COBALT_KEY_PORT		((~*(volatile unsigned int *) CKSEG1ADDR(0x1d000000) >> 24) & COBALT_KEY_MASK)
-# define COBALT_KEY_CLEAR	(1 << 1)
-# define COBALT_KEY_LEFT	(1 << 2)
-# define COBALT_KEY_UP		(1 << 3)
-# define COBALT_KEY_DOWN	(1 << 4)
-# define COBALT_KEY_RIGHT	(1 << 5)
-# define COBALT_KEY_ENTER	(1 << 6)
-# define COBALT_KEY_SELECT	(1 << 7)
-# define COBALT_KEY_MASK	0xfe
-
 #endif /* __ASM_COBALT_H */
