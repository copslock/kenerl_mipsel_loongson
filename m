Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Feb 2005 14:58:04 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:15745 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225756AbVBTO5s>; Sun, 20 Feb 2005 14:57:48 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1D2sWo-0006wK-00
	for <linux-mips@linux-mips.org>; Sun, 20 Feb 2005 14:57:46 +0000
Date:	Sun, 20 Feb 2005 14:57:46 +0000
To:	linux-mips@linux-mips.org
Subject: [PATCH 2.6] Cobalt fixes [3 of 6]
Message-ID: <20050220145746.GC26582@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From:	Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Fix Cobalt LCD driver for 2.6.

P.

--- linux-cvs/drivers/char/lcd.c	2005-01-25 04:28:12.000000000 +0000
+++ linux-wip/drivers/char/lcd.c	2005-02-20 13:48:22.000000000 +0000
@@ -575,8 +575,8 @@ static inline int button_pressed(void)
 
 static int lcd_waiters = 0;
 
-static long lcd_read(struct inode *inode, struct file *file, char *buf,
-		     unsigned long count)
+static ssize_t lcd_read(struct file *file, char *buf,
+		     size_t count, loff_t *ofs)
 {
 	long buttons_now;
 
--- linux-cvs/drivers/char/lcd.h	2005-01-13 14:05:52.000000000 +0000
+++ linux-wip/drivers/char/lcd.h	2005-02-20 13:48:22.000000000 +0000
@@ -22,7 +22,7 @@ static int timeout(volatile unsigned lon
 #define MAX_IDLE_TIME 120
 
 struct lcd_display {
-        unsigned long buttons;
+        unsigned buttons;
         int size1;
         int size2;
         unsigned char line1[LCD_CHARS_PER_LINE];
