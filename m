Received:  by oss.sgi.com id <S554138AbRA0IyW>;
	Sat, 27 Jan 2001 00:54:22 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:10494 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S554135AbRA0IyF>;
	Sat, 27 Jan 2001 00:54:05 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id JAA00612;
	Sat, 27 Jan 2001 09:54:11 +0100 (MET)
Date:   Sat, 27 Jan 2001 09:54:10 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Z8530, LK201 fixes
Message-ID: <Pine.GSO.3.96.1010127090657.29150F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

 After recent Z8530 and LK201 changes for the DECstation, modem lines do
not work anymore.  Also my keyboard timeouts on init, which results in a
hang. 

 I've been working on these issues during a few past days and following is
the result.  The list of changes:

- The LK201 driver may now be compiled with CONFIG_MAGIC_SYSRQ enabled (it
would not link before).  It doesn't support SysRq, though, as I haven't
decided how to do it, yet.  For LK443/444 we might do this
straightforward, but I'm not sure about others (<Compose> + <F13> is one
of options).

- The LK201 driver does not hang on a timeout upon init -- if one happens,
the driver breaks initialization.  I'm thinking on a hot plug support, but
that's not high-priority.

- There is some code to encourage people with unknown keyboard IDs to
report them here -- it would be nice to be able to identify LK421, LK443
and LK444 to map certain keys automatically for modifier keys and <Scroll
Lock> handling, for example. 

- Placeholders for scancodes existing on LK421, LK443 and LK444 has been
added.  I've yet to decide which codes to use -- I need to review
carefully the whole code path that is executed for scancode handling.

- The keyboard init timeout has been fixed -- Z8530 hooks need to be
installed earlier.

- Asynchronous speeds of 57600 and 115200 has been added.  They work very
nicely. 8-}

- DTR changes has been removed from rs_throttle/rs_unthrottle -- we don't
want to hang up on an overrun, do we? 

- Handling of modem lines as wired for the DECstation has been fixed. 
Some clown wired RTS and DTR incorrectly, limiting their functionality
somewhat -- the Z8530 is able to drive RTS synchronously, for example, but
this is broken for the DECstation.  I understand DEC needed a few
additional GPIO lines to wire synchronous RS232, but they could have wired
port B correctly and use spare lines of port A for GPIO instead, couldn't
they? 

 Harald, I'm afraid the last change breaks CONFIG_BAGET_MIPS.  I have no
idea how to share two configurations of drivers/tc/zs.c sanely with this
driver.  Until we have a unified Z8530 driver the only solution is to add
a bunch of ugly #ifdefs, I believe.

 I hope the patch is fine to apply.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.0-test12-20010110-lk201-41
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/drivers/tc/lk201-remap.c linux-mips-2.4.0-test12-20010110/drivers/tc/lk201-remap.c
--- linux-mips-2.4.0-test12-20010110.macro/drivers/tc/lk201-remap.c	Sat Dec 30 15:55:57 2000
+++ linux-mips-2.4.0-test12-20010110/drivers/tc/lk201-remap.c	Fri Jan 26 20:50:39 2001
@@ -3,7 +3,7 @@
  * 
  * 17.05.99 Michael Engel (engel@unix-ag.org)
  *
- * DEC keyboard generate keycodes in the range 0x56 - 0xfb
+ * DEC US keyboards generate keycodes in the range 0x55 - 0xfb
  *
  * This conflicts with Linux scancode conventions which define 
  * 0x00-0x7f as "normal" and 0x80-0xff as "shifted" scancodes, so we
@@ -15,6 +15,28 @@
  * lk501*map[] arrays which define scancode -> Linux code mapping
  *
  * Oh man is this horrible ;-)
+ *
+ * Scancodes with dual labels exist for keyboards as follows:
+ *
+ * code:  left label          / right label
+ *
+ * 0x73:  LKx01, LK421        / LK443, LK444
+ * 0x74:  LKx01, LK421        / LK443, LK444
+ * 0x7c:  LKx01, LK421        / LK443, LK444
+ * 0x8a:  LKx01, LK421        / LK443, LK444
+ * 0x8b:  LKx01, LK421        / LK443, LK444
+ * 0x8c:  LKx01, LK421        / LK443, LK444
+ * 0x8d:  LKx01, LK421        / LK443, LK444
+ * 0x8e:  LKx01, LK421        / LK443, LK444
+ * 0x8f:  LKx01, LK421        / LK443, LK444
+ * 0x9c:  LKx01, LK421        / LK443, LK444
+ * 0xa1:  LKx01, LK421        / LK443, LK444
+ * 0xa2:  LKx01, LK421        / LK443, LK444
+ * 0xa3:  LKx01, LK421        / LK443, LK444
+ * 0xa4:  LKx01, LK421        / LK443, LK444
+ * 0xad:         LK421        / LK443, LK444
+ * 0xc9:  LKx01, LK421, LK443 /        LK444
+ * 0xf7:  LKx01,        LK443 /        LK444
  */
 
 unsigned char scancodeRemap[256] = {
@@ -60,35 +82,35 @@ unsigned char scancodeRemap[256] = {
 /* 4c */ 0,		0,		0,		0,
 /* ----- 								*/
 /* 50 */ 0,		0,		0,		0,
-/* ----- 	 			F1,		F2, 		*/
+/* ----- 	 	ESC		F1		F2 		*/
 /* 54 */ 0,		0,		0x01,  		0x02,
-/* ----- F3,		F4,		F5,				*/
+/* ----- F3		F4		F5				*/
 /* 58 */ 0x03,  	0x04,		0x05,		0,
 /* ----- 								*/
 /* 5c */ 0,		0,		0,		0,
 /* ----- 								*/
 /* 60 */ 0,		0,		0,		0,
-/* ----- F6,		F7,		F8,		F9,		*/
+/* ----- F6		F7		F8		F9		*/
 /* 64 */ 0x06,		0x07,		0x08,		0x09, 
-/* ----- F10,								*/
+/* ----- F10								*/
 /* 68 */ 0x0a,		0,		0,		0,
 /* ----- 								*/
 /* 6c */ 0,		0,		0,		0,
-/* ----- 		F11,   		F12,		F13,		*/
+/* ----- 		F11   		F12		F13/PRNT SCRN	*/
 /* 70 */ 0,		0x0b,  		0x0c,		0x0d,
-/* ----- F14								*/
+/* ----- F14/SCRL LCK							*/
 /* 74 */ 0x0e,		0,		0,		0,
 /* ----- 								*/
 /* 78 */ 0,		0,		0,		0,
-/* ----- HELP		DO						*/
+/* ----- HELP/PAUSE	DO						*/
 /* 7c */ 0x0f,		0x10,		0,		0,
 /* ----- F17		F18		F19		F20		*/
 /* 80 */ 0x11,		0x12,		0x13,		0x14,
 /* ----- 								*/
 /* 84 */ 0,		0,		0,		0,
-/* ----- 								*/
+/* ----- 				FIND/INSERT	INSERT/HOME	*/
 /* 88 */ 0,		0,		0x23,		0x24,
-/* ----- REMOVE		SELECT		PREVIOUS	NEXT		*/
+/* ----- REMOVE/PG UP	SELECT/DELETE	PREVIOUS/END	NEXT/PG DN	*/
 /* 8c */ 0x25,		0x38,		0x39,		0x3a,
 /* ----- 				KP 0				*/
 /* 90 */ 0,		0,		0x6b,		0,
@@ -96,17 +118,17 @@ unsigned char scancodeRemap[256] = {
 /* 94 */ 0x6c,		0x65,		0x62,		0x63,
 /* ----- KP 3		KP 4		KP 5		KP 6		*/
 /* 98 */ 0x64,		0x4e,		0x4f,		0x50,
-/* ----- KP ,		KP 7		KP 8		KP 9		*/
+/* ----- KP ,/KP +	KP 7		KP 8		KP 9		*/
 /* 9c */ 0x51,		0x3b,		0x3c,		0x3d,
-/* ----- KP -		KP F1		KP F2		KP F3		*/
+/* ----- KP -		KP F1/NUM LCK	KP F2/KP /	KP F3/KP *	*/
 /* a0 */ 0x3e,		0x26,		0x27,		0x28,
-/* ----- KP F4						LEFT		*/
+/* ----- KP F4/KP -					LEFT		*/
 /* a4 */ 0x29,		0,		0,		0x5f,
 /* ----- RIGHT		DOWN		UP		SHIFT Rt	*/
 /* a8 */ 0x61,		0x60, 		0x4d,		0x5e,
-/* ----- 				SHIFT		CONTROL		*/
+/* ----- ALT		COMP Rt/CTRL Rt	SHIFT		CONTROL		*/
 /* ac */ 0,		0,		0x52,		0x3f,
-/* ----- CAPS		ALT						*/
+/* ----- CAPS		COMPOSE		ALT Rt				*/
 /* b0 */ 0x40,		0x67,		0,		0,
 /* ----- 								*/
 /* b4 */ 0,		0,		0,		0,
@@ -118,7 +140,7 @@ unsigned char scancodeRemap[256] = {
 /* c0 */ 0x16,		0x2b,		0x41,		0x54,
 /* ----- 		2		w		s		*/
 /* c4 */ 0,		0x17,		0x2c,		0x42,
-/* ----- x		<				3		*/
+/* ----- x		</\\				3		*/
 /* c8 */ 0x55,		0x53,		0,		0x18,
 /* ----- e		d		c				*/
 /* cc */ 0x2d,		0x43,		0x56,		0,
@@ -134,13 +156,13 @@ unsigned char scancodeRemap[256] = {
 /* e0 */ 0x1c,		0x31,		0x47,		0x5a,
 /* ----- 		8		i		k		*/
 /* e4 */ 0,		0x1d,		0x32,		0x48,
-/* ----- ,				9		o	*/
+/* ----- ,				9		o		*/
 /* e8 */ 0x5b,		0,		0x1e,		0x33,
 /* ----- l		.				0		*/
 /* ec */ 0x49,		0x5c,		0,		0x1f,
 /* ----- p				;		/		*/
 /* f0 */ 0x34,		0,		0x4a,		0x5d,
-/* ----- 		=		]		\\		*/
+/* ----- 		=		]		\\/\'		*/
 /* f4 */ 0,		0x21,		0x36,		0x4c,
 /* ----- 		-		[		\'		*/
 /* f8 */ 0,		0x20,		0x35,		0x4b,
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/drivers/tc/lk201.c linux-mips-2.4.0-test12-20010110/drivers/tc/lk201.c
--- linux-mips-2.4.0-test12-20010110.macro/drivers/tc/lk201.c	Sat Dec 30 15:55:57 2000
+++ linux-mips-2.4.0-test12-20010110/drivers/tc/lk201.c	Fri Jan 26 21:31:36 2001
@@ -18,9 +18,20 @@
 #include "zs.h"
 #include "lk201.h"
 
+/* Simple translation table for the SysRq keys */
+
+#ifdef CONFIG_MAGIC_SYSRQ
+/*
+ * Actually no translation at all, at least until we figure out
+ * how to define SysRq for LK201 and friends. --macro
+ */
+unsigned char lk201_sysrq_xlate[128];
+unsigned char *kbd_sysrq_xlate = lk201_sysrq_xlate;
+#endif
+
 #define KEYB_LINE	3
 
-static void __init lk201_init(struct dec_serial *);
+static int __init lk201_init(struct dec_serial *);
 static void __init lk201_info(struct dec_serial *);
 static void lk201_kbd_rx_char(unsigned char, unsigned char);
 
@@ -60,13 +71,16 @@ static unsigned char lk201_reset_string[
 	LK_CMD_LEDS_OFF, LK_PARAM_LED_MASK(0xf)
 };
 
-static void __init lk201_reset(struct dec_serial *info)
+static int __init lk201_reset(struct dec_serial *info)
 {
 	int i;
 
 	for (i = 0; i < sizeof(lk201_reset_string); i++)
-		if(info->hook->poll_tx_char(info, lk201_reset_string[i]))
+		if (info->hook->poll_tx_char(info, lk201_reset_string[i])) {
 			printk(__FUNCTION__" transmit timeout\n");
+			return -EIO;
+		}
+	return 0;
 }
 
 void kbd_leds(unsigned char leds)
@@ -149,21 +163,24 @@ static void __init lk201_info(struct dec
 {
 }
 
-static void __init lk201_init(struct dec_serial *info)
+static int __init lk201_init(struct dec_serial *info)
 {
-	unsigned int ch, id;
+	unsigned int ch, id = 0;
+	int result;
 
 	printk("DECstation LK keyboard driver v0.04... ");
 
-	lk201_reset(info);
-	udelay(10000);
+	result = lk201_reset(info);
+	if (result)
+		return result;
+	mdelay(10);
 
 	/*
-	 * Detect wether there is an LK201 or an LK401
+	 * Detect whether there is an LK201 or an LK401
 	 * The LK401 has ALT keys...
 	 */
 	info->hook->poll_tx_char(info, LK_CMD_REQ_ID);
-	while((ch = info->hook->poll_rx_char(info)) > 0)
+	while ((ch = info->hook->poll_rx_char(info)) > 0)
 		id = ch;
 
 	switch (id) {
@@ -174,13 +191,16 @@ static void __init lk201_init(struct dec
 		printk("LK401 detected\n");
 		break;
 	default:
-		printk("unkown keyboard, ID %d\n", id);
+		printk("unknown keyboard, ID %d,\n", id);
+		printk("... please report to <linux-mips@oss.sgi.com>\n");
 	}
 
 	/*
 	 * now we're ready
 	 */
 	info->hook->rx_char = lk201_kbd_rx_char;
+
+	return 0;
 }
 
 void __init kbd_init_hw(void)
@@ -206,7 +226,7 @@ void __init kbd_init_hw(void)
 	} else {
 		/*
 		 * TODO: modify dz.c to allow similar hooks
-		 * for LK201 handling on DS2100, Ds3100, and DS5000/200
+		 * for LK201 handling on DS2100, DS3100, and DS5000/200
 		 */
 		printk("LK201 Support for DS3100 not yet ready ...\n");
 	}
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/drivers/tc/zs.c linux-mips-2.4.0-test12-20010110/drivers/tc/zs.c
--- linux-mips-2.4.0-test12-20010110.macro/drivers/tc/zs.c	Sun Dec 31 05:26:37 2000
+++ linux-mips-2.4.0-test12-20010110/drivers/tc/zs.c	Fri Jan 26 21:09:56 2001
@@ -1,17 +1,42 @@
 /*
- * decserial.c: Serial port driver for IOASIC DECsatations.
+ * decserial.c: Serial port driver for IOASIC DECstations.
  *
  * Derived from drivers/sbus/char/sunserial.c by Paul Mackerras.
  * Derived from drivers/macintosh/macserial.c by Harald Koerfgen.
  *
  * DECstation changes
  * Copyright (C) 1998-2000 Harald Koerfgen (Harald.Koerfgen@home.ivm.de)
- * Copyright (C) 2000 Maciej W. Rozycki <macro@ds2.pg.gda.pl>
+ * Copyright (C) 2000,2001 Maciej W. Rozycki <macro@ds2.pg.gda.pl>
  *
  * For the rest of the code the original Copyright applies:
  * Copyright (C) 1996 Paul Mackerras (Paul.Mackerras@cs.anu.edu.au)
  * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
  *
+ *
+ * Note: for IOASIC systems the wiring is as follows:
+ *
+ * mouse/keyboard:
+ * DIN-7 MJ-4  signal        SCC
+ * 2     1     TxD       <-  A.TxD
+ * 3     4     RxD       ->  A.RxD
+ *
+ * EIA-232/EIA-423:
+ * DB-25 MMJ-6 signal        SCC
+ * 2     2     TxD       <-  B.TxD
+ * 3     5     RxD       ->  B.RxD
+ * 4           RTS       <- ~A.RTS
+ * 5           CTS       -> ~B.CTS
+ * 6     6     DSR       -> ~A.SYNC
+ * 8           CD        -> ~B.DCD
+ * 12          DSRS(DCE) -> ~A.CTS  (*)
+ * 15          TxC       ->  B.TxC
+ * 17          RxC       ->  B.RxC
+ * 20    1     DTR       <- ~A.DTR
+ * 22          RI        -> ~A.DCD
+ * 23          DSRS(DTE) <- ~B.RTS
+ *
+ * (*) EIA-232 defines the signal at this pin to be SCD, while DSRS(DCE)
+ *     is shared with DSRS(DTE) at pin 23.
  */
 
 #include <linux/config.h>
@@ -63,7 +88,6 @@ unsigned long system_base;
 
 #include "zs.h"
 
-
 /*
  * It would be nice to dynamically allocate everything that
  * depends on NUM_SERIAL, so we could support any number of
@@ -237,7 +261,7 @@ static inline int serial_paranoia_check(
  */
 static int baud_table[] = {
 	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
-	9600, 19200, 38400, 57600, 0, 0 };
+	9600, 19200, 38400, 57600, 115200, 0 };
 
 /* 
  * Reading and writing Z8530 registers.
@@ -309,18 +333,21 @@ static inline void load_zsregs(struct de
 }
 
 /* Sets or clears DTR/RTS on the requested line */
-static inline void zs_rtsdtr(struct dec_serial *info, int set)
+static inline void zs_rtsdtr(struct dec_serial *info, int which, int set)
 {
         unsigned long flags;
 
-        save_flags(flags); cli();
-        if(set) {
-                info->zs_channel->curregs[5] |= (RTS | DTR);
-        } else {
-                info->zs_channel->curregs[5] &= ~(RTS | DTR);
+
+	save_flags(flags); cli();
+	if (info->zs_channel != info->zs_chan_a) {
+		if (set) {
+			info->zs_chan_a->curregs[5] |= (which & (RTS | DTR));
+		} else {
+			info->zs_chan_a->curregs[5] &= ~(which & (RTS | DTR));
+		}
+		write_zsreg(info->zs_chan_a, 5, info->zs_chan_a->curregs[5]);
 	}
-	write_zsreg(info->zs_channel, 5, info->zs_channel->curregs[5]);
-        restore_flags(flags);
+	restore_flags(flags);
 }
 
 /* Utility routines for the Zilog */
@@ -493,34 +520,31 @@ static _INLINE_ void status_handle(struc
 		tty_break = 1;
 	}
 
-	/* FIXEM: Check for DCD transitions */
-	if (((stat ^ info->read_reg_zero) & DCD) != 0
-	    && info->tty && !C_CLOCAL(info->tty)) {
-		if (stat & DCD) {
-			wake_up_interruptible(&info->open_wait);
-		} else if (!(info->flags & ZILOG_CALLOUT_ACTIVE)) {
-			tty_hangup(info->tty);
+	if (info->zs_channel != info->zs_chan_a) {
+
+		/* FIXEM: Check for DCD transitions */
+		if (((stat ^ info->read_reg_zero) & DCD) != 0
+		    && info->tty && !C_CLOCAL(info->tty)) {
+			if (stat & DCD) {
+				wake_up_interruptible(&info->open_wait);
+			} else if (!(info->flags & ZILOG_CALLOUT_ACTIVE)) {
+				tty_hangup(info->tty);
+			}
 		}
-	}
 
-	/* Check for CTS transitions */
-	if (info->tty && C_CRTSCTS(info->tty)) {
-		/*
-		 * For some reason, on the Power Macintosh,
-		 * it seems that the CTS bit is 1 when CTS is
-		 * *negated* and 0 when it is asserted.
-		 * The DCD bit doesn't seem to be inverted
-		 * like this.
-		 */
-		if ((stat & CTS) != 0) {
-			if (info->tx_stopped) {
-				info->tx_stopped = 0;
-				if (!info->tx_active)
-					transmit_chars(info);
+		/* Check for CTS transitions */
+		if (info->tty && C_CRTSCTS(info->tty)) {
+			if ((stat & CTS) != 0) {
+				if (info->tx_stopped) {
+					info->tx_stopped = 0;
+					if (!info->tx_active)
+						transmit_chars(info);
+				}
+			} else {
+				info->tx_stopped = 1;
 			}
-		} else {
-			info->tx_stopped = 1;
 		}
+
 	}
 
 	/* Clear status condition... */
@@ -708,7 +732,7 @@ int zs_startup(struct dec_serial * info)
 	/*
 	 * Turn on RTS and DTR.
 	 */
-	zs_rtsdtr(info, 1);
+	zs_rtsdtr(info, RTS | DTR, 1);
 
 	/*
 	 * Finally, enable sequencing and interrupts
@@ -779,7 +803,7 @@ static void shutdown(struct dec_serial *
 	info->zs_channel->curregs[5] &= ~TxENAB;
 	write_zsreg(info->zs_channel, 5, info->zs_channel->curregs[5]);
 	if (!info->tty || C_HUPCL(info->tty)) {
-		zs_rtsdtr(info, 0);
+		zs_rtsdtr(info, RTS | DTR, 0);
 	}
 
 	if (info->tty)
@@ -801,27 +825,39 @@ static void change_speed(struct dec_seri
 	unsigned long flags;
 
 	if (!info->hook) {
-	if (!info->tty || !info->tty->termios)
-		return;
-	cflag = info->tty->termios->c_cflag;
+		if (!info->tty || !info->tty->termios)
+			return;
+		cflag = info->tty->termios->c_cflag;
 		if (!info->port)
-		return;
+			return;
 	} else {
 		cflag = info->hook->cflags;
 	}
+
 	i = cflag & CBAUD;
+	if (i & CBAUDEX) {
+		i &= ~CBAUDEX;
+		if (i < 1 || i > 2) {
+			if (!info->hook)
+				info->tty->termios->c_cflag &= ~CBAUDEX;
+			else
+				info->hook->cflags &= ~CBAUDEX;
+		} else
+			i += 15;
+	}
+
 	save_flags(flags); cli();
 	info->zs_baud = baud_table[i];
 	info->clk_divisor = 16;
-        if (info->zs_baud) {
+	if (info->zs_baud) {
 		info->zs_channel->curregs[4] = X16CLK;
 		brg = BPS_TO_BRG(info->zs_baud, zs_parms->clock/info->clk_divisor);
 		info->zs_channel->curregs[12] = (brg & 255);
 		info->zs_channel->curregs[13] = ((brg >> 8) & 255);
-		zs_rtsdtr(info, 1); 
+		zs_rtsdtr(info, DTR, 1); 
 	} else {
-                zs_rtsdtr(info, 0);
-                return;
+		zs_rtsdtr(info, RTS | DTR, 0);
+		return;
 	}
 
 	/* byte size and parity */
@@ -875,7 +911,7 @@ static void change_speed(struct dec_seri
 		info->zs_channel->curregs[15] &= ~DCDIE;
 	if (cflag & CRTSCTS) {
 		info->zs_channel->curregs[15] |= CTSIE;
-		if ((read_zsreg(info->zs_channel, 0) & CTS) != 0)
+		if ((read_zsreg(info->zs_channel, 0) & CTS) == 0)
 			info->tx_stopped = 1;
 	} else {
 		info->zs_channel->curregs[15] &= ~CTSIE;
@@ -1020,7 +1056,7 @@ static void rs_throttle(struct tty_struc
 	}
 
 	if (C_CRTSCTS(tty)) {
-		zs_rtsdtr(info, 0);
+		zs_rtsdtr(info, RTS, 0);
 	}
 }
 
@@ -1052,7 +1088,7 @@ static void rs_unthrottle(struct tty_str
 	}
 
 	if (C_CRTSCTS(tty)) {
-		zs_rtsdtr(info, 1);
+		zs_rtsdtr(info, RTS, 1);
 	}
 }
 
@@ -1150,18 +1186,25 @@ static int get_lsr_info(struct dec_seria
 
 static int get_modem_info(struct dec_serial *info, unsigned int *value)
 {
-	unsigned char control, status;
+	unsigned char control, status_a, status_b;
 	unsigned int result;
 
-	cli();
-	control = info->zs_channel->curregs[5];
-	status = read_zsreg(info->zs_channel, 0);
-	sti();
-	result =  ((control & RTS) ? TIOCM_RTS: 0)
-		| ((control & DTR) ? TIOCM_DTR: 0)
-		| ((status  & DCD) ? TIOCM_CAR: 0)
-		| ((status  & CTS) ? 0: TIOCM_CTS);
-	put_user(result,value);
+	if (info->zs_channel == info->zs_chan_a)
+		result = 0;
+	else {
+		cli();
+		control = info->zs_chan_a->curregs[5];
+		status_a = read_zsreg(info->zs_chan_a, 0);
+		status_b = read_zsreg(info->zs_channel, 0);
+		sti();
+		result =  ((control  & RTS) ? TIOCM_RTS: 0)
+			| ((control  & DTR) ? TIOCM_DTR: 0)
+			| ((status_b & DCD) ? TIOCM_CAR: 0)
+			| ((status_a & DCD) ? TIOCM_RNG: 0)
+			| ((status_a & SYNC_HUNT) ? TIOCM_DSR: 0)
+			| ((status_b & CTS) ? TIOCM_CTS: 0);
+	}
+	put_user(result, value);
 	return 0;
 }
 
@@ -1174,25 +1217,29 @@ static int set_modem_info(struct dec_ser
 	error = verify_area(VERIFY_READ, value, sizeof(int));
 	if (error)
 		return error;
+
+	if (info->zs_channel == info->zs_chan_a)
+		return 0;
+
 	get_user(arg, value);
 	bits = (arg & TIOCM_RTS? RTS: 0) + (arg & TIOCM_DTR? DTR: 0);
 	cli();
 	switch (cmd) {
 	case TIOCMBIS:
-		info->zs_channel->curregs[5] |= bits;
+		info->zs_chan_a->curregs[5] |= bits;
 		break;
 	case TIOCMBIC:
-		info->zs_channel->curregs[5] &= ~bits;
+		info->zs_chan_a->curregs[5] &= ~bits;
 		break;
 	case TIOCMSET:
-		info->zs_channel->curregs[5] = 
-			(info->zs_channel->curregs[5] & ~(DTR | RTS)) | bits;
+		info->zs_chan_a->curregs[5] = 
+			(info->zs_chan_a->curregs[5] & ~(DTR | RTS)) | bits;
 		break;
 	default:
 		sti();
 		return -EINVAL;
 	}
-	write_zsreg(info->zs_channel, 5, info->zs_channel->curregs[5]);
+	write_zsreg(info->zs_chan_a, 5, info->zs_chan_a->curregs[5]);
 	sti();
 	return 0;
 }
@@ -1538,7 +1585,7 @@ static int block_til_ready(struct tty_st
 		cli();
 		if (!(info->flags & ZILOG_CALLOUT_ACTIVE) &&
 		    (tty->termios->c_cflag & CBAUD))
-			zs_rtsdtr(info, 1);
+			zs_rtsdtr(info, RTS | DTR, 1);
 		sti();
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
@@ -1794,9 +1841,9 @@ static void __init probe_sccs(void)
 /*	save_and_cli(flags);
 	for (n = 0; n < zs_channels_found; n++) {
 		if (((int)zs_channels[n].control & 0xf) == 1) {
-			write_zsreg(zs_soft[channel].zs_chan_a, R9, FHWRES);
-			udelay(10000);
-			write_zsreg(zs_soft[channel].zs_chan_a, R9, 0);
+			write_zsreg(zs_soft[n].zs_chan_a, R9, FHWRES);
+			mdelay(10);
+			write_zsreg(zs_soft[n].zs_chan_a, R9, 0);
 		}
 		load_zsregs(zs_soft[n].zs_channel, zs_soft[n].zs_channel->curregs);
 	} 
@@ -1887,7 +1934,8 @@ int __init zs_init(void)
 	for (channel = 0; channel < zs_channels_found; ++channel) {
 		if (zs_soft[channel].hook &&
 		    zs_soft[channel].hook->init_channel)
-			(*zs_soft[channel].hook->init_channel)(&zs_soft[channel]);
+			(*zs_soft[channel].hook->init_channel)
+				(&zs_soft[channel]);
 
 		zs_soft[channel].clk_divisor = 16;
 		zs_soft[channel].zs_baud = get_zsbaud(&zs_soft[channel]);
@@ -1917,7 +1965,7 @@ int __init zs_init(void)
 		info->blocked_open = 0;
 		info->tqueue.routine = do_softint;
 		info->tqueue.data = info;
-		info->callout_termios =callout_driver.init_termios;
+		info->callout_termios = callout_driver.init_termios;
 		info->normal_termios = serial_driver.init_termios;
 		init_waitqueue_head(&info->open_wait);
 		init_waitqueue_head(&info->close_wait);
@@ -2016,23 +2064,24 @@ unsigned int register_zs_hook(unsigned i
 {
 	struct dec_serial *info = &zs_soft[channel];
 
-        if (info->hook) {
-                printk(__FUNCTION__": line %d has already a hook registered\n", channel);
+	if (info->hook) {
+		printk(__FUNCTION__": line %d has already a hook registered\n", channel);
+
+		return 0;
+	} else {
+		info->hook = hook;
 
-                return 0;
-        } else {
 		if (zs_chain == 0)
 			probe_sccs();
 
 		if (!(info->flags & ZILOG_INITIALIZED))
 			zs_startup(info);
 
-                hook->poll_rx_char = zs_poll_rx_char;
-                hook->poll_tx_char = zs_poll_tx_char;
-                info->hook = hook;
+		hook->poll_rx_char = zs_poll_rx_char;
+		hook->poll_tx_char = zs_poll_tx_char;
 
-                return 1;
-        }
+		return 1;
+	}
 }
 
 unsigned int unregister_zs_hook(unsigned int channel)
@@ -2184,7 +2233,7 @@ static int __init serial_console_setup(s
 	/*
 	 * Turn on RTS and DTR.
 	 */
-	zs_rtsdtr(info, 1);
+	zs_rtsdtr(info, RTS | DTR, 1);
 
 	/*
 	 * Finally, enable sequencing
@@ -2285,8 +2334,9 @@ void kgdb_interruptible(int yes)
 	write_zsreg(chan, 9, nine);
 }
 
-static void kgdbhook_init_channel(struct dec_serial* info) 
+static int kgdbhook_init_channel(struct dec_serial* info) 
 {
+	return 0;
 }
 
 static void kgdbhook_init_info(struct dec_serial* info)
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/drivers/tc/zs.h linux-mips-2.4.0-test12-20010110/drivers/tc/zs.h
--- linux-mips-2.4.0-test12-20010110.macro/drivers/tc/zs.h	Sun Dec 31 05:26:37 2000
+++ linux-mips-2.4.0-test12-20010110/drivers/tc/zs.h	Thu Jan 25 22:53:26 2001
@@ -92,7 +92,7 @@ struct dec_zschannel {
 struct dec_serial;
 
 struct zs_hook {
-	void (*init_channel)(struct dec_serial* info);
+	int (*init_channel)(struct dec_serial* info);
 	void (*init_info)(struct dec_serial* info);
 	void (*rx_char)(unsigned char ch, unsigned char stat);
 	int  (*poll_rx_char)(struct dec_serial* info);
diff -up --recursive --new-file linux-mips-2.4.0-test12-20010110.macro/include/asm-mips/keyboard.h linux-mips-2.4.0-test12-20010110/include/asm-mips/keyboard.h
--- linux-mips-2.4.0-test12-20010110.macro/include/asm-mips/keyboard.h	Tue Jan 16 09:55:31 2001
+++ linux-mips-2.4.0-test12-20010110/include/asm-mips/keyboard.h	Tue Jan 16 23:52:46 2001
@@ -47,6 +47,7 @@ extern int kbd_translate(unsigned char s
 extern char kbd_unexpected_up(unsigned char keycode);
 extern void kbd_leds(unsigned char leds);
 extern void kbd_init_hw(void);
+extern unsigned char *kbd_sysrq_xlate;
 
 #endif
 
