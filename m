Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2PDHLk13595
	for linux-mips-outgoing; Mon, 25 Mar 2002 05:17:21 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2PDGHq13580
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 05:16:17 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA07290;
	Mon, 25 Mar 2002 14:05:47 +0100 (MET)
Date: Mon, 25 Mar 2002 14:05:46 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, Harald Koerfgen <hkoerfg@web.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux: LK201 hot-plug updates and associated zs.c fixes
Message-ID: <Pine.GSO.3.96.1020325131520.4605C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 Here is the long-promised LK201 update.  It allows booting without a
keyboard attached and plugging it and unplugging at any time.  Additional
status is provided upon a keyboard initialization -- a self-test result is
printed as well as the model name.  Since the new code requires serial
interrupts to be already initialized and enabled at the time the zs.c hook
is executed, a few minor changes were made to the zs.c driver.  There are
also a few obvious bug fixes. 

 A few receive errors may happen and be reported upon a keyboard being
plugged in during system's operation.  The reason is probably bouncing of
contacts and it appears harmless -- I plugged and unplugged my keyboards
many times and there was never a character loss in the initial
transmission from a keyboard to the host, thus the driver didn't get out
of sync.  I'm told both the LK201 keyboard and the VSXXX mouse are
designed for hot-plugging (the host side being as well, due to EIA-232
requirements), so there should be no electrical problems.

 The code was tested with an LK201-AA and an LK401-AG successfully. 

 The remaining to-do list:

1. Pass raw scancodes up, only doing a remap for the medium-raw mode
   (requires changes to the generic code).

2. Use handshaking for mode commands.

3. Add typematic rate and LED state restoration after a replug.

I'm going to address these issues gradually, probably in the order listed. 

 Please apply.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.18-20020323-lk201-23
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/drivers/tc/lk201.c linux-mips-2.4.18-20020323/drivers/tc/lk201.c
--- linux-mips-2.4.18-20020323.macro/drivers/tc/lk201.c	Sat Mar 23 04:58:18 2002
+++ linux-mips-2.4.18-20020323/drivers/tc/lk201.c	Sun Mar 24 21:12:46 2002
@@ -5,7 +5,7 @@
  * for more details.
  *
  * Copyright (C) 1999-2002 Harald Koerfgen <hkoerfg@web.de>
- * Copyright (C) 2001 Maciej W. Rozycki <macro@ds2.pg.gda.pl>
+ * Copyright (C) 2001, 2002  Maciej W. Rozycki <macro@ds2.pg.gda.pl>
  */
 
 #include <linux/config.h>
@@ -21,7 +21,6 @@
 #include <linux/vt_kern.h>
 
 #include <asm/keyboard.h>
-#include <asm/wbflush.h>
 #include <asm/dec/tc.h>
 #include <asm/dec/machtype.h>
 
@@ -48,19 +47,18 @@ static void __init lk201_info(struct dec
 static void lk201_kbd_rx_char(unsigned char, unsigned char);
 
 struct zs_hook lk201_kbdhook = {
-	init_channel:   lk201_init,
-	init_info:      lk201_info,
-	rx_char:        NULL,
-	poll_rx_char:   NULL,
-	poll_tx_char:   NULL,
-	cflags:         B4800 | CS8 | CSTOPB | CLOCAL
+	init_channel:	lk201_init,
+	init_info:	lk201_info,
+	rx_char:	NULL,
+	poll_rx_char:	NULL,
+	poll_tx_char:	NULL,
+	cflags:		B4800 | CS8 | CSTOPB | CLOCAL
 };
 
 /*
  * This is used during keyboard initialisation
  */
 static unsigned char lk201_reset_string[] = {
-	LK_CMD_LEDS_ON, LK_PARAM_LED_MASK(0xf),	/* show we are resetting */
 	LK_CMD_SET_DEFAULTS,
 	LK_CMD_MODE(LK_MODE_RPT_DOWN, 1),
 	LK_CMD_MODE(LK_MODE_RPT_DOWN, 2),
@@ -76,28 +74,85 @@ static unsigned char lk201_reset_string[
 	LK_CMD_MODE(LK_MODE_RPT_DOWN, 12),
 	LK_CMD_MODE(LK_MODE_DOWN, 13),
 	LK_CMD_MODE(LK_MODE_RPT_DOWN, 14),
-	LK_CMD_ENB_RPT,
 	LK_CMD_DIS_KEYCLK,
-	LK_CMD_RESUME,
 	LK_CMD_ENB_BELL, LK_PARAM_VOLUME(4),
-	LK_CMD_LEDS_OFF, LK_PARAM_LED_MASK(0xf)
 };
 
 static struct dec_serial* lk201kbd_info;
 
-static int __init lk201_reset(struct dec_serial *info)
+static int lk201_send(struct dec_serial *info, unsigned char ch)
 {
-	int i;
+	if (info->hook->poll_tx_char(info, ch)) {
+		printk(KERN_ERR "lk201: transmit timeout\n");
+		return -EIO;
+	}
+	return 0;
+}
+
+static inline int lk201_get_id(struct dec_serial *info)
+{
+	return lk201_send(info, LK_CMD_REQ_ID);
+}
+
+static int lk201_reset(struct dec_serial *info)
+{
+	int i, r;
 
 	for (i = 0; i < sizeof(lk201_reset_string); i++) {
-		if (info->hook->poll_tx_char(info, lk201_reset_string[i]) < 0) {
-			return -EIO;
-		}
+		r = lk201_send(info, lk201_reset_string[i]);
+		if (r < 0)
+			return r;
 	}
-
 	return 0;
 }
 
+static void lk201_report(unsigned char id[6])
+{
+	char *report = "lk201: keyboard attached, ";
+
+	switch (id[2]) {
+	case LK_STAT_PWRUP_OK:
+		printk(KERN_INFO "%sself-test OK\n", report);
+		break;
+	case LK_STAT_PWRUP_KDOWN:
+		/* The keyboard will resend the power-up ID
+		   after all keys are released, so we don't
+		   bother handling the error specially.  Still
+		   there may be a short-circuit inside.
+		 */
+		printk(KERN_ERR "%skey down (stuck?), code: 0x%02x\n",
+		       report, id[3]);
+		break;
+	case LK_STAT_PWRUP_ERROR:
+		printk(KERN_ERR "%sself-test failure\n", report);
+		break;
+	default:
+		printk(KERN_ERR "%sunknown error: 0x%02x\n",
+		       report, id[2]);
+	}
+}
+
+static void lk201_id(unsigned char id[6])
+{
+	/*
+	 * Report whether there is an LK201 or an LK401
+	 * The LK401 has ALT keys...
+	 */
+	switch (id[4]) {
+	case 1:
+		printk(KERN_INFO "lk201: LK201 detected\n");
+		break;
+	case 2:
+		printk(KERN_INFO "lk201: LK401 detected\n");
+		break;
+	default:
+		printk(KERN_WARNING
+		       "lk201: unknown keyboard detected, ID %d\n", id[4]);
+		printk(KERN_WARNING "lk201: ... please report to "
+		       "<linux-mips@oss.sgi.com>\n");
+	}
+}
+
 #define DEFAULT_KEYB_REP_DELAY	(250/5)	/* [5ms] */
 #define DEFAULT_KEYB_REP_RATE	30	/* [cps] */
 
@@ -233,118 +288,111 @@ char kbd_unexpected_up(unsigned char key
 
 static void lk201_kbd_rx_char(unsigned char ch, unsigned char stat)
 {
+	static unsigned char id[6];
+	static int id_i;
+
 	static int shift_state = 0;
 	static int prev_scancode;
 	unsigned char c = scancodeRemap[ch];
 
-	if (!stat || stat == 4) {
-		switch (ch) {
-		case LK_STAT_RESUME_ERR:
-		case LK_STAT_ERROR:
-		case LK_STAT_INHIBIT_ACK:
-		case LK_STAT_TEST_ACK:
-		case LK_STAT_MODE_KEYDOWN:
-		case LK_STAT_MODE_ACK:
-			break;
-		case LK_KEY_LOCK:
-			shift_state ^= LK_LOCK;
-			handle_scancode(c, shift_state && LK_LOCK ? 1 : 0);
-			break;
-		case LK_KEY_SHIFT:
-			shift_state ^= LK_SHIFT;
-			handle_scancode(c, shift_state && LK_SHIFT ? 1 : 0);
-			break;
-		case LK_KEY_CTRL:
-			shift_state ^= LK_CTRL;
-			handle_scancode(c, shift_state && LK_CTRL ? 1 : 0);
-			break;
-		case LK_KEY_COMP:
-			shift_state ^= LK_COMP;
-			handle_scancode(c, shift_state && LK_COMP ? 1 : 0);
-			break;
-		case LK_KEY_RELEASE:
-			if (shift_state & LK_SHIFT)
-				handle_scancode(scancodeRemap[LK_KEY_SHIFT], 0);
-			if (shift_state & LK_CTRL)
-				handle_scancode(scancodeRemap[LK_KEY_CTRL], 0);
-			if (shift_state & LK_COMP)
-				handle_scancode(scancodeRemap[LK_KEY_COMP], 0);
-			if (shift_state & LK_LOCK)
-				handle_scancode(scancodeRemap[LK_KEY_LOCK], 0);
-			shift_state = 0;
-			break;
-		case LK_KEY_REPEAT:
-			handle_scancode(prev_scancode, 1);
-			break;
-		default:
-			prev_scancode = c;
-			handle_scancode(c, 1);
-			break;
-		}
-	} else
-		printk("Error reading LKx01 keyboard: 0x%02x\n", stat);
-	tasklet_schedule(&keyboard_tasklet);
-}
-
-static void __init lk201_info(struct dec_serial *info)
-{
-}
-
-static int __init lk201_init(struct dec_serial *info)
-{
-	int ch, id = 0;
-
-	printk("DECstation LK keyboard driver v0.04... ");
-
-
-	if (lk201_reset(info) < 0) {
-		printk("reset failed!\n");
-		return -ENODEV;
+	if (stat && stat != 4) {
+		printk(KERN_ERR "lk201: keyboard receive error: 0x%02x\n",
+		       stat);
+		return;
 	}
 
-	mdelay(10);
-
-	/*
-	 * Detect whether there is an LK201 or an LK401
-	 * The LK401 has ALT keys...
-	 */
-	if (info->hook->poll_tx_char(info, LK_CMD_REQ_ID) < 0) {
-		printk("tx request ID timeout!\n");
-		return -ENODEV;
+	/* Assume this is a power-up ID. */
+	if (ch == LK_STAT_PWRUP_ID && !id_i) {
+		id[id_i++] = ch;
+		return;
 	}
 
-	mdelay(10);
-
-	while ((ch = info->hook->poll_rx_char(info)) > 0)
-		id = ch;
-
-	if (ch < 0) {
-		printk("rx request ID timeout!\n");
-		return -ENODEV;
+	/* Handle the power-up sequence. */
+	if (id_i) {
+		id[id_i++] = ch;
+		if (id_i == 4) {
+			/* OK, the power-up concluded. */
+			lk201_report(id);
+			if (id[2] == LK_STAT_PWRUP_OK)
+				lk201_get_id(lk201kbd_info);
+			else {
+				id_i = 0;
+				printk(KERN_ERR "lk201: keyboard power-up "
+				       "error, skipping initialization\n");
+			}
+		} else if (id_i == 6) {
+			/* We got the ID; report it and start an operation. */
+			id_i = 0;
+			lk201_id(id);
+			lk201_reset(lk201kbd_info);
+		}
+		return;
 	}
 
-	switch (id) {
-	case 1:
-		printk("LK201 detected\n");
+	/* Everything else is a scancode/status response. */
+	id_i = 0;
+	switch (ch) {
+	case LK_STAT_RESUME_ERR:
+	case LK_STAT_ERROR:
+	case LK_STAT_INHIBIT_ACK:
+	case LK_STAT_TEST_ACK:
+	case LK_STAT_MODE_KEYDOWN:
+	case LK_STAT_MODE_ACK:
 		break;
-	case 2:
-		printk("LK401 detected\n");
+	case LK_KEY_LOCK:
+		shift_state ^= LK_LOCK;
+		handle_scancode(c, shift_state && LK_LOCK ? 1 : 0);
+		break;
+	case LK_KEY_SHIFT:
+		shift_state ^= LK_SHIFT;
+		handle_scancode(c, shift_state && LK_SHIFT ? 1 : 0);
+		break;
+	case LK_KEY_CTRL:
+		shift_state ^= LK_CTRL;
+		handle_scancode(c, shift_state && LK_CTRL ? 1 : 0);
+		break;
+	case LK_KEY_COMP:
+		shift_state ^= LK_COMP;
+		handle_scancode(c, shift_state && LK_COMP ? 1 : 0);
+		break;
+	case LK_KEY_RELEASE:
+		if (shift_state & LK_SHIFT)
+			handle_scancode(scancodeRemap[LK_KEY_SHIFT], 0);
+		if (shift_state & LK_CTRL)
+			handle_scancode(scancodeRemap[LK_KEY_CTRL], 0);
+		if (shift_state & LK_COMP)
+			handle_scancode(scancodeRemap[LK_KEY_COMP], 0);
+		if (shift_state & LK_LOCK)
+			handle_scancode(scancodeRemap[LK_KEY_LOCK], 0);
+		shift_state = 0;
+		break;
+	case LK_KEY_REPEAT:
+		handle_scancode(prev_scancode, 1);
 		break;
 	default:
-		printk("unknown keyboard, ID %d,\n", id);
-		printk("... please report to <linux-mips@oss.sgi.com>\n");
+		prev_scancode = c;
+		handle_scancode(c, 1);
 		break;
 	}
+	tasklet_schedule(&keyboard_tasklet);
+}
 
-	/*
-	 * now we're ready
-	 */
-	info->hook->rx_char = lk201_kbd_rx_char;
+static void __init lk201_info(struct dec_serial *info)
+{
+}
 
+static int __init lk201_init(struct dec_serial *info)
+{
+	/* First install handlers. */
 	lk201kbd_info = info;
 	kbd_rate = lk201kbd_rate;
 	kd_mksound = lk201kd_mksound;
 
+	info->hook->rx_char = lk201_kbd_rx_char;
+
+	/* Then just issue a reset -- the handlers will do the rest. */
+	lk201_send(info, LK_CMD_POWER_UP);
+
 	return 0;
 }
 
@@ -353,26 +401,29 @@ void __init kbd_init_hw(void)
 	extern int register_zs_hook(unsigned int, struct zs_hook *);
 	extern int unregister_zs_hook(unsigned int);
 
+	/* Maxine uses LK501 at the Access.Bus. */
+	if (mips_machtype == MACH_DS5000_XX)
+		return;
+
+	printk(KERN_INFO "lk201: DECstation LK keyboard driver v0.05.\n");
+
 	if (TURBOCHANNEL) {
-		if (mips_machtype != MACH_DS5000_XX) {
-			/*
-			 * This is not a MAXINE, so:
-			 *
-			 * kbd_init_hw() is being called before
-			 * rs_init() so just register the kbd hook
-			 * and let zs_init do the rest :-)
-			 */
-			if (mips_machtype == MACH_DS5000_200)
-				printk("LK201 Support for DS5000/200 not yet ready ...\n");
-			else
-				if(!register_zs_hook(KEYB_LINE, &lk201_kbdhook))
-					unregister_zs_hook(KEYB_LINE);
-		}
+		/*
+		 * kbd_init_hw() is being called before
+		 * rs_init() so just register the kbd hook
+		 * and let zs_init do the rest :-)
+		 */
+		if (mips_machtype == MACH_DS5000_200)
+			printk(KERN_ERR "lk201: support for DS5000/200 "
+			       "not yet ready.\n");
+		else
+			if(!register_zs_hook(KEYB_LINE, &lk201_kbdhook))
+				unregister_zs_hook(KEYB_LINE);
 	} else {
 		/*
 		 * TODO: modify dz.c to allow similar hooks
 		 * for LK201 handling on DS2100, DS3100, and DS5000/200
 		 */
-		printk("LK201 Support for DS3100 not yet ready ...\n");
+		printk(KERN_ERR "lk201: support for DS3100 not yet ready.\n");
 	}
 }
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/drivers/tc/lk201.h linux-mips-2.4.18-20020323/drivers/tc/lk201.h
--- linux-mips-2.4.18-20020323.macro/drivers/tc/lk201.h	Wed Oct 31 05:26:17 2001
+++ linux-mips-2.4.18-20020323/drivers/tc/lk201.h	Sun Mar 24 14:31:12 2002
@@ -115,6 +115,7 @@
 					/* the keycode follows */
 #define LK_STAT_MODE_ACK	0xba	/* the mode command succeeded */
 
+#define LK_STAT_PWRUP_ID	0x01	/* the power-up response start mark */
 #define LK_STAT_PWRUP_OK	0x00	/* the power-up self test OK */
 #define LK_STAT_PWRUP_KDOWN	0x3d	/* a key was down during the test */
 #define LK_STAT_PWRUP_ERROR	0x3e	/* keyboard self test failure */
diff -up --recursive --new-file linux-mips-2.4.18-20020323.macro/drivers/tc/zs.c linux-mips-2.4.18-20020323/drivers/tc/zs.c
--- linux-mips-2.4.18-20020323.macro/drivers/tc/zs.c	Sat Mar 23 04:58:18 2002
+++ linux-mips-2.4.18-20020323/drivers/tc/zs.c	Sun Mar 24 20:51:10 2002
@@ -5,8 +5,8 @@
  * Derived from drivers/macintosh/macserial.c by Harald Koerfgen.
  *
  * DECstation changes
- * Copyright (C) 1998-2002 Harald Koerfgen
- * Copyright (C) 2000,2001 Maciej W. Rozycki <macro@ds2.pg.gda.pl>
+ * Copyright (C) 1998-2000 Harald Koerfgen
+ * Copyright (C) 2000, 2001, 2002  Maciej W. Rozycki <macro@ds2.pg.gda.pl>
  *
  * For the rest of the code the original Copyright applies:
  * Copyright (C) 1996 Paul Mackerras (Paul.Mackerras@cs.anu.edu.au)
@@ -409,7 +409,7 @@ static _INLINE_ void receive_chars(struc
 		stat = read_zsreg(info->zs_channel, R1);
 		ch = read_zsdata(info->zs_channel);
 
-		if (!tty && !info->hook && !info->hook->rx_char)
+		if (!tty && (!info->hook || !info->hook->rx_char))
 			continue;
 
 		if (tty_break) {
@@ -524,9 +524,9 @@ static _INLINE_ void status_handle(struc
 
 	if (info->zs_channel != info->zs_chan_a) {
 
-		/* FIXEM: Check for DCD transitions */
-		if (((stat ^ info->read_reg_zero) & DCD) != 0
-		    && info->tty && !C_CLOCAL(info->tty)) {
+		/* Check for DCD transitions */
+		if (info->tty && !C_CLOCAL(info->tty) &&
+		    ((stat ^ info->read_reg_zero) & DCD) != 0 ) {
 			if (stat & DCD) {
 				wake_up_interruptible(&info->open_wait);
 			} else if (!(info->flags & ZILOG_CALLOUT_ACTIVE)) {
@@ -1721,7 +1721,7 @@ int rs_open(struct tty_struct *tty, stru
 
 static void __init show_serial_version(void)
 {
-	printk("DECstation Z8530 serial driver version 0.06\n");
+	printk("DECstation Z8530 serial driver version 0.07\n");
 }
 
 /*  Initialize Z8530s zs_channels
@@ -1934,34 +1934,30 @@ int __init zs_init(void)
 	save_flags(flags); cli();
 
 	for (channel = 0; channel < zs_channels_found; ++channel) {
-		if (zs_soft[channel].hook &&
-		    zs_soft[channel].hook->init_channel)
-			(*zs_soft[channel].hook->init_channel)
-				(&zs_soft[channel]);
-
-		zs_soft[channel].clk_divisor = 16;
-		zs_soft[channel].zs_baud = get_zsbaud(&zs_soft[channel]);
-
 		if (request_irq(zs_parms->irq, rs_interrupt, SA_SHIRQ,
 				"SCC", &zs_soft[channel]))
 			printk(KERN_ERR "decserial: can't get irq %d\n",
 			       zs_parms->irq);
+
+		zs_soft[channel].clk_divisor = 16;
+		zs_soft[channel].zs_baud = get_zsbaud(&zs_soft[channel]);
 	}
 
-	for (info = zs_chain, i = 0; info; info = info->zs_next, i++)
-	{
-		if (info->hook && info->hook->init_info) {
-			(*info->hook->init_info)(info);
+	for (info = zs_chain, i = 0; info; info = info->zs_next, i++) {
+
+		/* Needed before interrupts are enabled. */
+		info->tty = 0;
+		info->x_char = 0;
+
+		if (info->hook && info->hook->init_info)
 			continue;
-		}
+
 		info->magic = SERIAL_MAGIC;
 		info->port = (int) info->zs_channel->control;
 		info->line = i;
-		info->tty = 0;
 		info->custom_divisor = 16;
 		info->close_delay = 50;
 		info->closing_wait = 3000;
-		info->x_char = 0;
 		info->event = 0;
 		info->count = 0;
 		info->blocked_open = 0;
@@ -1983,6 +1979,18 @@ int __init zs_init(void)
 
 	restore_flags(flags);
 
+	for (channel = 0; channel < zs_channels_found; ++channel) {
+		if (zs_soft[channel].hook &&
+		    zs_soft[channel].hook->init_channel)
+			(*zs_soft[channel].hook->init_channel)
+				(&zs_soft[channel]);
+	}
+
+	for (info = zs_chain, i = 0; info; info = info->zs_next, i++) {
+		if (info->hook && info->hook->init_info)
+			(*info->hook->init_info)(info);
+	}
+
 	return 0;
 }
 
@@ -2013,21 +2021,13 @@ zs_poll_tx_char(struct dec_serial *info,
 	if(chan) {
 		int loops = 10000;
 
- 		RECOVERY_DELAY;
-               	wbflush();
-		RECOVERY_DELAY;
-
-		while (loops && !(*(chan->control) & Tx_BUF_EMP)) {
+		while (loops && !(read_zsreg(chan, 0) & Tx_BUF_EMP))
 			loops--;
-	        	RECOVERY_DELAY;
-		}
 
 		if (loops) {
-			*(chan->data) = ch;
-			wbflush();
-			RECOVERY_DELAY;
+			write_zsdata(chan, ch);
 			ret = 0;
-                } else
+		} else
 			ret = -EAGAIN;
 
 		return ret;
@@ -2044,9 +2044,8 @@ zs_poll_rx_char(struct dec_serial *info)
 	if(chan) {
                 int loops = 10000;
 
-                while(loops && ((read_zsreg(chan, 0) & Rx_CH_AV) == 0)) {
+		while (loops && !(read_zsreg(chan, 0) & Rx_CH_AV))
 			loops--;
-		}
 
                 if (loops)
                         ret = read_zsdata(chan);
@@ -2054,8 +2053,8 @@ zs_poll_rx_char(struct dec_serial *info)
                         ret = -EAGAIN;
 
 		return ret;
-        } else
-                return -ENODEV;
+	} else
+		return -ENODEV;
 }
 
 unsigned int register_zs_hook(unsigned int channel, struct zs_hook *hook)
