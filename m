Received:  by oss.sgi.com id <S42192AbQHGQBa>;
	Mon, 7 Aug 2000 09:01:30 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:32184 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42183AbQHGQBG>;
	Mon, 7 Aug 2000 09:01:06 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA04813;
	Mon, 7 Aug 2000 17:56:52 +0200 (MET DST)
Date:   Mon, 7 Aug 2000 17:56:52 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@uni-koblenz.de>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
cc:     Craig P Prescott <prescott@phys.ufl.edu>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: BREAK and magic SysRq handling for Z8530
Message-ID: <Pine.GSO.3.96.1000807174812.3044E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

 It appears our current Z8530 driver lacks BREAK support.  It also has the
unfortunate side effect magic SysRq wouldn't work either, if we had it. 
Not anymore!  The following patch adds both features to our Z8530 driver. 
It also allows the magic SysRq hack to be compiled-in (i.e. no more
linking errors) even if no virtual terminal driver is build, which is
suitable for certain configurations, including mine.

 Comments are welcomed, as usually.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/drivers/char/keyboard.c linux-mips-2.4.0-test5-20000731/drivers/char/keyboard.c
--- linux-mips-2.4.0-test5-20000731.macro/drivers/char/keyboard.c	Thu Feb 24 05:26:36 2000
+++ linux-mips-2.4.0-test5-20000731/drivers/char/keyboard.c	Sun Aug  6 09:15:46 2000
@@ -158,7 +158,6 @@
 
 #ifdef CONFIG_MAGIC_SYSRQ
 static int sysrq_pressed;
-int sysrq_enabled = 1;
 #endif
 
 static struct pm_dev *pm_kbd = NULL;
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/drivers/char/serial.c linux-mips-2.4.0-test5-20000731/drivers/char/serial.c
--- linux-mips-2.4.0-test5-20000731.macro/drivers/char/serial.c	Mon Jul 24 04:26:06 2000
+++ linux-mips-2.4.0-test5-20000731/drivers/char/serial.c	Sun Aug  6 09:21:03 2000
@@ -597,7 +597,8 @@
 				printk("handling break....");
 #endif
 #if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && !defined(MODULE)
-				if (info->line == sercons.index) {
+				if (info->line == sercons.index
+				    && sysrq_enabled) {
 					if (!break_pressed) {
 						break_pressed = jiffies;
 						goto ignore_char;
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/drivers/char/sysrq.c linux-mips-2.4.0-test5-20000731/drivers/char/sysrq.c
--- linux-mips-2.4.0-test5-20000731.macro/drivers/char/sysrq.c	Tue Mar 28 04:26:29 2000
+++ linux-mips-2.4.0-test5-20000731/drivers/char/sysrq.c	Sun Aug  6 09:17:58 2000
@@ -33,6 +33,8 @@
 /* Machine specific power off function */
 void (*sysrq_power_off)(void) = NULL;
 
+int sysrq_enabled = 1;
+
 EXPORT_SYMBOL(sysrq_power_off);
 
 /* Send a signal to all user processes */
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/drivers/sbus/char/sunkbd.c linux-mips-2.4.0-test5-20000731/drivers/sbus/char/sunkbd.c
--- linux-mips-2.4.0-test5-20000731.macro/drivers/sbus/char/sunkbd.c	Sat Jul 15 04:26:34 2000
+++ linux-mips-2.4.0-test5-20000731/drivers/sbus/char/sunkbd.c	Sun Aug  6 09:16:21 2000
@@ -177,9 +177,6 @@
 static struct pt_regs * pt_regs;
 
 #ifdef CONFIG_MAGIC_SYSRQ
-#ifndef CONFIG_PCI
-int sysrq_enabled = 1;
-#endif
 unsigned char sun_sysrq_xlate[128] =
 	"\0\0\0\0\0\201\202\212\203\213\204\214\205\0\206\0"	/* 0x00 - 0x0f */
 	"\207\210\211\0\0\0\0\0\0\0\0\0\0\03312"		/* 0x10 - 0x1f */
diff -u --recursive --new-file linux-mips-2.4.0-test5-20000731.macro/drivers/tc/zs.c linux-mips-2.4.0-test5-20000731/drivers/tc/zs.c
--- linux-mips-2.4.0-test5-20000731.macro/drivers/tc/zs.c	Sat Jul  8 04:26:53 2000
+++ linux-mips-2.4.0-test5-20000731/drivers/tc/zs.c	Sun Aug  6 13:34:43 2000
@@ -6,6 +6,7 @@
  *
  * DECstation changes
  * Copyright (C) 1998 Harald Koerfgen (Harald.Koerfgen@home.ivm.de)
+ * Copyright (C) 2000 Maciej W. Rozycki (macro@ds2.pg.gda.pl)
  *
  * For the rest of the code the original Copyright applies:
  * Copyright (C) 1996 Paul Mackerras (Paul.Mackerras@cs.anu.edu.au)
@@ -50,6 +51,9 @@
 #ifdef CONFIG_KGDB
 #include <asm/kgdb.h>
 #endif
+#ifdef CONFIG_MAGIC_SYSRQ
+#include <linux/sysrq.h>
+#endif
 
 #include "zs.h"
 
@@ -75,6 +79,10 @@
 #ifdef CONFIG_SERIAL_CONSOLE
 static struct console sercons;
 #endif
+#if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) \
+    && !defined(MODULE)
+static unsigned long break_pressed; /* break, really ... */
+#endif
 
 #ifdef CONFIG_KGDB
 struct dec_zschannel *zs_kgdbchan;
@@ -302,6 +310,8 @@
  * -----------------------------------------------------------------------
  */
 
+static int tty_break;	/* Set whenever BREAK condition is detected.  */
+
 /*
  * This routine is used by the interrupt handler to schedule
  * processing in the software interrupt portion of the driver.
@@ -320,7 +330,7 @@
 	struct tty_struct *tty = info->tty;
 	unsigned char ch, stat, flag;
 
-	while ((read_zsreg(info->zs_channel, 0) & Rx_CH_AV) != 0) {
+	while ((read_zsreg(info->zs_channel, R0) & Rx_CH_AV) != 0) {
 
 		stat = read_zsreg(info->zs_channel, R1);
 		ch = read_zsdata(info->zs_channel);
@@ -330,13 +340,53 @@
 			if (ch == 0x03 || ch == '$')
 				breakpoint();
 			if (stat & (Rx_OVR|FRM_ERR|PAR_ERR))
-				write_zsreg(info->zs_channel, 0, ERR_RES);
+				write_zsreg(info->zs_channel, R0, ERR_RES);
 			return;
 		}
 #endif
 		if (!tty)
 			continue;
 
+		if (tty_break) {
+			tty_break = 0;
+#if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && !defined(MODULE)
+			if (info->line == sercons.index && sysrq_enabled) {
+				if (!break_pressed) {
+					break_pressed = jiffies;
+					goto ignore_char;
+				}
+				break_pressed = 0;
+			}
+#endif
+			flag = TTY_BREAK;
+			if (info->flags & ZILOG_SAK)
+				do_SAK(tty);
+		} else {
+			if (stat & Rx_OVR) {
+				flag = TTY_OVERRUN;
+			} else if (stat & FRM_ERR) {
+				flag = TTY_FRAME;
+			} else if (stat & PAR_ERR) {
+				flag = TTY_PARITY;
+			} else
+				flag = 0;
+			if (flag)
+				/* reset the error indication */
+				write_zsreg(info->zs_channel, R0, ERR_RES);
+		}
+
+#if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && !defined(MODULE)
+		if (break_pressed && info->line == sercons.index) {
+			if (ch != 0 &&
+			    time_before(jiffies, break_pressed + HZ*5)) {
+				handle_sysrq(ch, regs, NULL, NULL);
+				break_pressed = 0;
+				goto ignore_char;
+			}
+			break_pressed = 0;
+		}
+#endif
+
 		if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
 			static int flip_buf_ovf;
 			++flip_buf_ovf;
@@ -348,26 +398,17 @@
 			if (flip_max_cnt < tty->flip.count)
 				flip_max_cnt = tty->flip.count;
 		}
-		if (stat & Rx_OVR) {
-			flag = TTY_OVERRUN;
-		} else if (stat & FRM_ERR) {
-			flag = TTY_FRAME;
-		} else if (stat & PAR_ERR) {
-			flag = TTY_PARITY;
-		} else
-			flag = 0;
-		if (flag)
-			/* reset the error indication */
-			write_zsreg(info->zs_channel, 0, ERR_RES);
+
 		*tty->flip.flag_buf_ptr++ = flag;
 		*tty->flip.char_buf_ptr++ = ch;
+	ignore_char:
 	}
 	tty_flip_buffer_push(tty);
 }
 
 static void transmit_chars(struct dec_serial *info)
 {
-	if ((read_zsreg(info->zs_channel, 0) & Tx_BUF_EMP) == 0)
+	if ((read_zsreg(info->zs_channel, R0) & Tx_BUF_EMP) == 0)
 		return;
 	info->tx_active = 0;
 
@@ -380,7 +421,7 @@
 	}
 
 	if ((info->xmit_cnt <= 0) || info->tty->stopped || info->tx_stopped) {
-		write_zsreg(info->zs_channel, 0, RES_Tx_P);
+		write_zsreg(info->zs_channel, R0, RES_Tx_P);
 		return;
 	}
 	/* Send char */
@@ -395,15 +436,22 @@
 
 static _INLINE_ void status_handle(struct dec_serial *info)
 {
-	unsigned char status;
+	unsigned char stat;
 
 	/* Get status from Read Register 0 */
-	status = read_zsreg(info->zs_channel, 0);
+	stat = read_zsreg(info->zs_channel, R0);
+
+	if (stat & BRK_ABRT) {
+#ifdef SERIAL_DEBUG_INTR
+		printk("handling break....");
+#endif
+		tty_break = 1;
+	}
 
 	/* FIXEM: Check for DCD transitions */
-	if (((status ^ info->read_reg_zero) & DCD) != 0
+	if (((stat ^ info->read_reg_zero) & DCD) != 0
 	    && info->tty && !C_CLOCAL(info->tty)) {
-		if (status & DCD) {
+		if (stat & DCD) {
 			wake_up_interruptible(&info->open_wait);
 		} else if (!(info->flags & ZILOG_CALLOUT_ACTIVE)) {
 			if (info->tty)
@@ -420,7 +468,7 @@
 		 * The DCD bit doesn't seem to be inverted
 		 * like this.
 		 */
-		if ((status & CTS) != 0) {
+		if ((stat & CTS) != 0) {
 			if (info->tx_stopped) {
 				info->tx_stopped = 0;
 				if (!info->tx_active)
@@ -432,8 +480,8 @@
 	}
 
 	/* Clear status condition... */
-	write_zsreg(info->zs_channel, 0, RES_EXT_INT);
-	info->read_reg_zero = status;
+	write_zsreg(info->zs_channel, R0, RES_EXT_INT);
+	info->read_reg_zero = stat;
 }
 
 /*
@@ -459,7 +507,7 @@
 		shift = 0;	/* Channel B */
 
 	for (;;) {
-		zs_intreg = read_zsreg(info->zs_chan_a, 3) >> shift; 
+		zs_intreg = read_zsreg(info->zs_chan_a, R3) >> shift; 
 		if ((zs_intreg & CHAN_IRQMASK) == 0)
 			break;
 
