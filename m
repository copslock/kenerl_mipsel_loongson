Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2007 09:26:03 +0100 (BST)
Received: from p549F7FC7.dip.t-dialin.net ([84.159.127.199]:38071 "EHLO
	p549F7FC7.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20021580AbXINIZy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Sep 2007 09:25:54 +0100
Received: from mo31.po.2iij.NET ([210.128.50.54]:7718 "EHLO mo31.po.2iij.net")
	by lappi.linux-mips.net with ESMTP id S1097024AbXINISM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Sep 2007 10:18:12 +0200
Received: by mo.po.2iij.net (mo31) id l8E8FWwb052194; Fri, 14 Sep 2007 17:15:32 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox303) id l8E8FU7Y030369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Sep 2007 17:15:30 +0900
Message-Id: <200709140815.l8E8FU7Y030369@po-mbox303.hop.2iij.net>
Date:	Fri, 14 Sep 2007 17:14:25 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][2/9][MIPS] remove unneeded button check with halt
In-Reply-To: <20070914164228.333da5d9.yoichi_yuasa@tripeaks.co.jp>
References: <20070914164228.333da5d9.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Remove unneeded button check with halt.
Because, the Cobalt server has power switch.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/reset.c mips/arch/mips/cobalt/reset.c
--- mips-orig/arch/mips/cobalt/reset.c	2007-09-14 15:36:19.137080000 +0900
+++ mips/arch/mips/cobalt/reset.c	2007-09-14 16:04:37.923379250 +0900
@@ -8,40 +8,16 @@
  * Copyright (C) 1995, 1996, 1997 by Ralf Baechle
  * Copyright (C) 2001 by Liam Davies (ldavies@agile.tv)
  */
-#include <linux/jiffies.h>
-
-#include <asm/io.h>
-#include <asm/reboot.h>
+#include <linux/irqflags.h>
+#include <linux/kernel.h>
 
 #include <cobalt.h>
 
 void cobalt_machine_halt(void)
 {
-	int state, last, diff;
-	unsigned long mark;
-
-	/*
-	 * turn off bar on Qube, flash power off LED on RaQ (0.5Hz)
-	 *
-	 * restart if ENTER and SELECT are pressed
-	 */
-
-	last = COBALT_KEY_PORT;
-
-	for (state = 0;;) {
-
-		state ^= COBALT_LED_POWER_OFF;
-		COBALT_LED_PORT = state;
-
-		diff = COBALT_KEY_PORT ^ last;
-		last ^= diff;
-
-		if((diff & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)) && !(~last & (COBALT_KEY_ENTER | COBALT_KEY_SELECT)))
-			COBALT_LED_PORT = COBALT_LED_RESET;
-
-		for (mark = jiffies; jiffies - mark < HZ;)
-			;
-	}
+	local_irq_disable();
+	printk("You can switch the machine off now.\n");
+	while (1) ;
 }
 
 void cobalt_machine_restart(char *command)
diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/mach-cobalt/cobalt.h mips/include/asm-mips/mach-cobalt/cobalt.h
--- mips-orig/include/asm-mips/mach-cobalt/cobalt.h	2007-09-14 15:36:19.257087500 +0900
+++ mips/include/asm-mips/mach-cobalt/cobalt.h	2007-09-14 16:03:27.754994000 +0900
@@ -29,16 +29,6 @@ extern int cobalt_board_id;
 # define COBALT_LED_POWER_OFF	(1 << 3)	/* RaQ */
 # define COBALT_LED_RESET	0x0f
 
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
 #define COBALT_UART		((volatile unsigned char *) CKSEG1ADDR(0x1c800000))
 
 #endif /* __ASM_COBALT_H */
