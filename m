Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9TFoID20907
	for linux-mips-outgoing; Mon, 29 Oct 2001 07:50:18 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9TFnf020852
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 07:49:42 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA10688;
	Mon, 29 Oct 2001 16:47:50 +0100 (MET)
Date: Mon, 29 Oct 2001 16:47:50 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, Harald Koerfgen <hkoerfg@web.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] 2.4.10: DEC LK201 keyboard updates
Message-ID: <Pine.GSO.3.96.1011029162156.3407E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 The lk201.c driver doesn't compile due to a duplicate kbd_rate()
definition.  The following patch fixes it by defining a private
lk201kbd_rate() function like other keyboard drivers do.

 While I was at it I decided to update the driver a bit.  I've added LED
handling (the "Lock" and "Hold Screen" LEDs for now), a console beep
handler and a typematic rate selector.  I've applied a few minor fixes to
the existing code.  Finally I've corrected and updated macros and
documentation bits in lk201.h. 

 The changes look sane and testing shows they are working.  The typematic
rate selector doesn't seem to have any effect, but it might be a
measurement error -- I don't have a real vt device and I do all the
testing with its output directed to a serial console.  If anyone can
verify it has an effect on his system, it would be great.  It doesn't harm
anyway.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.10-20011026-lk201-7
diff -up --recursive --new-file linux-mips-2.4.10-20011026.macro/drivers/tc/lk201.c linux-mips-2.4.10-20011026/drivers/tc/lk201.c
--- linux-mips-2.4.10-20011026.macro/drivers/tc/lk201.c	Thu Oct 18 04:27:14 2001
+++ linux-mips-2.4.10-20011026/drivers/tc/lk201.c	Mon Oct 29 03:08:15 2001
@@ -4,15 +4,20 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * Copyright (C) 2001 Maciej W. Rozycki <macro@ds2.pg.gda.pl>
  */
+
 #include <linux/config.h>
 
 #include <linux/errno.h>
+#include <linux/sched.h>
 #include <linux/tty.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/kbd_ll.h>
+#include <linux/kbd_kern.h>
+#include <linux/vt_kern.h>
 
 #include <asm/keyboard.h>
 #include <asm/wbflush.h>
@@ -77,6 +82,8 @@ static unsigned char lk201_reset_string[
 	LK_CMD_LEDS_OFF, LK_PARAM_LED_MASK(0xf)
 };
 
+static struct dec_serial* lk201kbd_info;
+
 static int __init lk201_reset(struct dec_serial *info)
 {
 	int i;
@@ -89,16 +96,115 @@ static int __init lk201_reset(struct dec
 	return 0;
 }
 
-int kbd_rate(struct kbd_repeat *rep)
+#define DEFAULT_KEYB_REP_DELAY	(250/5)	/* [5ms] */
+#define DEFAULT_KEYB_REP_RATE	30	/* [cps] */
+
+static struct kbd_repeat kbdrate = {
+	DEFAULT_KEYB_REP_DELAY,
+	DEFAULT_KEYB_REP_RATE
+};
+
+static void parse_kbd_rate(struct kbd_repeat *r)
 {
-       return 0;
+	if (r->delay <= 0)
+		r->delay = kbdrate.delay;
+	if (r->rate <= 0)
+		r->rate = kbdrate.rate;
+
+	if (r->delay < 5)
+		r->delay = 5;
+	if (r->delay > 630)
+		r->delay = 630;
+	if (r->rate < 12)
+		r->rate = 12;
+	if (r->rate > 127)
+		r->rate = 127;
+	if (r->rate == 125)
+		r->rate = 124;
 }
 
+static int write_kbd_rate(struct kbd_repeat *rep)
+{
+	struct dec_serial* info = lk201kbd_info;
+	int delay, rate;
+	int i;
 
+	delay = rep->delay / 5;
+	rate = rep->rate;
+	for (i = 0; i < 4; i++) {
+		if (info->hook->poll_tx_char(info, LK_CMD_RPT_RATE(i)))
+			return 1;
+		if (info->hook->poll_tx_char(info, LK_PARAM_DELAY(delay)))
+			return 1;
+		if (info->hook->poll_tx_char(info, LK_PARAM_RATE(rate)))
+			return 1;
+	}
+	return 0;
+}
+
+static int lk201kbd_rate(struct kbd_repeat *rep)
+{
+	if (rep == NULL)
+		return -EINVAL;
+
+	parse_kbd_rate(rep);
+
+	if (write_kbd_rate(rep)) {
+		memcpy(rep, &kbdrate, sizeof(struct kbd_repeat));
+		return -EIO;
+	}
+
+	memcpy(&kbdrate, rep, sizeof(struct kbd_repeat));
+
+	return 0;
+}
+
+static void lk201kd_mksound(unsigned int hz, unsigned int ticks)
+{
+	struct dec_serial* info = lk201kbd_info;
+
+	if (!ticks)
+		return;
+
+	/*
+	 * Can't set frequency and we "approximate"
+	 * duration by volume. ;-)
+	 */
+	ticks /= HZ / 32;
+	if (ticks > 7)
+		ticks = 7;
+	ticks = 7 - ticks;
+
+	if (info->hook->poll_tx_char(info, LK_CMD_ENB_BELL))
+		return;
+	if (info->hook->poll_tx_char(info, LK_PARAM_VOLUME(ticks)))
+		return;
+	if (info->hook->poll_tx_char(info, LK_CMD_BELL))
+		return;
+}
 
 void kbd_leds(unsigned char leds)
 {
-	return;
+	struct dec_serial* info = lk201kbd_info;
+	unsigned char l = 0;
+
+	if (!info)		/* FIXME */
+		return;
+
+	/* FIXME -- Only Hold and Lock LEDs for now. --macro */
+	if (leds & LED_SCR)
+		l |= LK_LED_HOLD;
+	if (leds & LED_CAP)
+		l |= LK_LED_LOCK;
+
+	if (info->hook->poll_tx_char(info, LK_CMD_LEDS_ON))
+		return;
+	if (info->hook->poll_tx_char(info, LK_PARAM_LED_MASK(l)))
+		return;
+	if (info->hook->poll_tx_char(info, LK_CMD_LEDS_OFF))
+		return;
+	if (info->hook->poll_tx_char(info, LK_PARAM_LED_MASK(~l)))
+		return;
 }
 
 int kbd_setkeycode(unsigned int scancode, unsigned int keycode)
@@ -131,7 +237,12 @@ static void lk201_kbd_rx_char(unsigned c
 
 	if (!stat || stat == 4) {
 		switch (ch) {
-		case LK_KEY_ACK:
+		case LK_STAT_RESUME_ERR:
+		case LK_STAT_ERROR:
+		case LK_STAT_INHIBIT_ACK:
+		case LK_STAT_TEST_ACK:
+		case LK_STAT_MODE_KEYDOWN:
+		case LK_STAT_MODE_ACK:
 			break;
 		case LK_KEY_LOCK:
 			shift_state ^= LK_LOCK;
@@ -170,6 +281,7 @@ static void lk201_kbd_rx_char(unsigned c
 		}
 	} else
 		printk("Error reading LKx01 keyboard: 0x%02x\n", stat);
+	tasklet_schedule(&keyboard_tasklet);
 }
 
 static void __init lk201_info(struct dec_serial *info)
@@ -213,6 +325,10 @@ static int __init lk201_init(struct dec_
 	 */
 	info->hook->rx_char = lk201_kbd_rx_char;
 
+	lk201kbd_info = info;
+	kbd_rate = lk201kbd_rate;
+	kd_mksound = lk201kd_mksound;
+
 	return 0;
 }
 
@@ -244,7 +360,3 @@ void __init kbd_init_hw(void)
 		printk("LK201 Support for DS3100 not yet ready ...\n");
 	}
 }
-
-
-
-
diff -up --recursive --new-file linux-mips-2.4.10-20011026.macro/drivers/tc/lk201.h linux-mips-2.4.10-20011026/drivers/tc/lk201.h
--- linux-mips-2.4.10-20011026.macro/drivers/tc/lk201.h	Sat Dec 30 15:55:57 2000
+++ linux-mips-2.4.10-20011026/drivers/tc/lk201.h	Mon Oct 29 03:14:21 2001
@@ -2,52 +2,121 @@
  *	Commands to the keyboard processor
  */
 
-#define	LK_PARAM		0x80	/* start/end parameter list */
+#define LK_PARAM		0x80	/* start/end parameter list */
 
-#define	LK_CMD_RESUME		0x8b
-#define	LK_CMD_INHIBIT		0xb9
-#define	LK_CMD_LEDS_ON		0x13	/* 1 param: led bitmask */
-#define	LK_CMD_LEDS_OFF		0x11	/* 1 param: led bitmask */
-#define	LK_CMD_DIS_KEYCLK	0x99
-#define	LK_CMD_ENB_KEYCLK	0x1b	/* 1 param: volume */
-#define	LK_CMD_DIS_CTLCLK	0xb9
-#define	LK_CMD_ENB_CTLCLK	0xbb
-#define	LK_CMD_SOUND_CLK	0x9f
-#define	LK_CMD_DIS_BELL		0xa1
-#define	LK_CMD_ENB_BELL		0x23	/* 1 param: volume */
-#define	LK_CMD_BELL		0xa7
-#define	LK_CMD_TMP_NORPT	0xc1
-#define	LK_CMD_ENB_RPT		0xe3
-#define	LK_CMD_DIS_RPT		0xe1
-#define	LK_CMD_RPT_TO_DOWN	0xd9
-#define	LK_CMD_REQ_ID		0xab
-#define	LK_CMD_POWER_UP		0xfd
-#define	LK_CMD_TEST_MODE	0xcb
-#define	LK_CMD_SET_DEFAULTS	0xd3
+#define LK_CMD_RESUME		0x8b	/* resume transmission to the host */
+#define LK_CMD_INHIBIT		0x89	/* stop transmission to the host */
+#define LK_CMD_LEDS_ON		0x13	/* light LEDs */
+					/* 1st param: led bitmask */
+#define LK_CMD_LEDS_OFF		0x11	/* turn off LEDs */
+					/* 1st param: led bitmask */
+#define LK_CMD_DIS_KEYCLK	0x99	/* disable the keyclick */
+#define LK_CMD_ENB_KEYCLK	0x1b	/* enable the keyclick */
+					/* 1st param: volume */
+#define LK_CMD_DIS_CTLCLK	0xb9	/* disable the Ctrl keyclick */
+#define LK_CMD_ENB_CTLCLK	0xbb	/* enable the Ctrl keyclick */
+#define LK_CMD_SOUND_CLK	0x9f	/* emit a keyclick */
+#define LK_CMD_DIS_BELL		0xa1	/* disable the bell */
+#define LK_CMD_ENB_BELL		0x23	/* enable the bell */
+					/* 1st param: volume */
+#define LK_CMD_BELL		0xa7	/* emit a bell */
+#define LK_CMD_TMP_NORPT	0xc1	/* disable typematic */
+					/* for the currently pressed key */
+#define LK_CMD_ENB_RPT		0xe3	/* enable typematic */
+					/* for RPT_DOWN groups */
+#define LK_CMD_DIS_RPT		0xe1	/* disable typematic */
+					/* for RPT_DOWN groups */
+#define LK_CMD_RPT_TO_DOWN	0xd9	/* set RPT_DOWN groups to DOWN */
+#define LK_CMD_REQ_ID		0xab	/* request the keyboard ID */
+#define LK_CMD_POWER_UP		0xfd	/* init power-up sequence */
+#define LK_CMD_TEST_MODE	0xcb	/* enter the factory test mode */
+#define LK_CMD_TEST_EXIT	0x80	/* exit the factory test mode */
+#define LK_CMD_SET_DEFAULTS	0xd3	/* set power-up defaults */
+
+#define LK_CMD_MODE(m,div)	(LK_PARAM|(((div)&0xf)<<3)|m)
+					/* select the repeat mode */
+					/* for the selected key group */
+#define LK_CMD_MODE_AR(m,div)	((((div)&0xf)<<3)|m)
+					/* select the repeat mode */
+					/* and the repeat register */
+					/* for the selected key group */
+					/* 1st param: register number */
+#define LK_CMD_RPT_RATE(r)	(0x04|((((r)&0x3)<<1)))
+					/* set the delay and repeat rate */
+					/* for the selected repeat register */
+					/* 1st param: initial delay */
+					/* 2nd param: repeat rate */
 
 /* there are 4 leds, represent them in the low 4 bits of a byte */
-#define	LK_PARAM_LED_MASK(ledbmap)	(LK_PARAM|(ledbmap))
+#define LK_PARAM_LED_MASK(ledbmap)	(LK_PARAM|((ledbmap)&0xf))
+#define LK_LED_WAIT		0x1	/* Wait LED */
+#define LK_LED_COMP		0x2	/* Compose LED */
+#define LK_LED_LOCK		0x4	/* Lock LED */
+#define LK_LED_HOLD		0x8	/* Hold Screen LED */
 
 /* max volume is 0, lowest is 0x7 */
-#define	LK_PARAM_VOLUME(v)		(LK_PARAM|((v)&0x7))
+#define LK_PARAM_VOLUME(v)		(LK_PARAM|((v)&0x7))
 
-/* mode set command(s) details */
-#define	LK_MODE_DOWN		0x0
-#define	LK_MODE_RPT_DOWN	0x2
-#define	LK_MODE_DOWN_UP		0x6
-#define	LK_CMD_MODE(m,div)	(LK_PARAM|(div<<3)|m)
+/* mode set command details, div is a key group number */
+#define LK_MODE_DOWN		0x0	/* make only */
+#define LK_MODE_RPT_DOWN	0x2	/* make and typematic */
+#define LK_MODE_DOWN_UP		0x6	/* make and release */
+
+/* there are 4 repeat registers */
+#define LK_PARAM_AR(r)		(LK_PARAM|((v)&0x3))
+
+/*
+ * Mappings between key groups and keycodes are as follows:
+ *
+ *  1: 0xbf - 0xfb -- alphanumeric,
+ *  2: 0x92 - 0xa4 -- numeric keypad,
+ *  3: 0xbc        -- Backspace,
+ *  4: 0xbd - 0xbe -- Tab, Return,
+ *  5: 0xb0 - 0xb1 -- Lock, Compose Character,
+ *  6: 0xae - 0xaf -- Ctrl, Shift,
+ *  7: 0xa7 - 0xa8 -- Left Arrow, Right Arrow,
+ *  8: 0xa9 - 0xab -- Up Arrow, Down Arrow, Right Shift,
+ *  9: 0x8a - 0x8f -- editor keypad,
+ * 10: 0x56 - 0x5a -- F1 - F5,
+ * 11: 0x64 - 0x68 -- F6 - F10,
+ * 12: 0x71 - 0x74 -- F11 - F14,
+ * 13: 0x7c - 0x7d -- Help, Do,
+ * 14: 0x80 - 0x83 -- F17 - F20.
+ *
+ * Others, i.e. 0x55, 0xac, 0xad, 0xb2, are undiscovered.
+ */
+
+/* delay is 5 - 630 ms; 0x00 and 0x7f are reserved */
+#define LK_PARAM_DELAY(t)	((t)&0x7f)
+
+/* rate is 12 - 127 Hz; 0x00 - 0x0b and 0x7d (power-up!) are reserved */
+#define LK_PARAM_RATE(r)	(LK_PARAM|((r)&0x7f))
 
 #define LK_SHIFT 1<<0
 #define LK_CTRL 1<<1
 #define LK_LOCK 1<<2
 #define LK_COMP 1<<3
 
-#define LK_KEY_SHIFT 174
-#define LK_KEY_CTRL 175
-#define LK_KEY_LOCK 176
-#define LK_KEY_COMP 177
-#define LK_KEY_RELEASE 179
-#define LK_KEY_REPEAT 180
-#define LK_KEY_ACK 186
+#define LK_KEY_SHIFT		0xae
+#define LK_KEY_CTRL		0xaf
+#define LK_KEY_LOCK		0xb0
+#define LK_KEY_COMP		0xb1
+
+#define LK_KEY_RELEASE		0xb3	/* all keys released */
+#define LK_KEY_REPEAT		0xb4	/* repeat the last key */
+
+/* status responses */
+#define LK_STAT_RESUME_ERR	0xb5	/* keystrokes lost while inhibited */
+#define LK_STAT_ERROR		0xb6	/* an invalid command received */
+#define LK_STAT_INHIBIT_ACK	0xb7	/* transmission inhibited */
+#define LK_STAT_TEST_ACK	0xb8	/* the factory test mode entered */
+#define LK_STAT_MODE_KEYDOWN	0xb9	/* a key is down on a change */
+					/* to the DOWN_UP mode; */
+					/* the keycode follows */
+#define LK_STAT_MODE_ACK	0xba	/* the mode command succeeded */
+
+#define LK_STAT_PWRUP_OK	0x00	/* the power-up self test OK */
+#define LK_STAT_PWRUP_KDOWN	0x3d	/* a key was down during the test */
+#define LK_STAT_PWRUP_ERROR	0x3e	/* keyboard self test failure */
 
-extern unsigned char scancodeRemap[256];
\ No newline at end of file
+extern unsigned char scancodeRemap[256];
