Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2003 14:47:55 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:28670 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224861AbTEWNrw>;
	Fri, 23 May 2003 14:47:52 +0100
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h4NDlOLT005469;
	Fri, 23 May 2003 15:47:34 +0200 (MEST)
Date: Fri, 23 May 2003 15:47:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: [PATCH] Arrow keys on USB keyboards
Message-ID: <Pine.GSO.4.21.0305231545030.26586-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

	Hi Ralf,

This patch fixes the arrow keys (and all other keys that generate E0/E1
scancode prefixes on AT keyboards) by adding support for E0/E1 scancode
prefixes to the dummy keyboard driver if CONFIG_INPUT=y.

Rationale: When using the new input layer (i.e. with a USB keyboard or a custom
input device), the input layer relies on kbd_translate() in the low-level
keyboard driver to convert from AT-style scancodes to keycodes. If you don't
have a PS/2 keyboard interface and don't compile in the PS/2 keyboard driver,
you have to enable the dummy keyboard driver, which naively assumes that
keycodes and scancodes are interchangeable. This is correct if you do not have
a keyboard, but fails for prefixed scancodes if you do have a keyboard which
uses the new input layer.

--- linux-mips-2.4.x/drivers/char/dummy_keyb.c	Tue Apr  1 16:33:31 2003
+++ linux/drivers/char/dummy_keyb.c	Wed Apr 30 08:12:19 2003
@@ -23,9 +23,12 @@
  * CONFIG_VT.
  *
  */
+
+#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/input.h>
 
 void kbd_leds(unsigned char leds)
 {
@@ -41,6 +44,84 @@
 	return scancode;
 }
 
+#ifdef CONFIG_INPUT
+static unsigned char e0_keys[128] = {
+	0, 0, 0, KEY_KPCOMMA, 0, KEY_INTL3, 0, 0,		/* 0x00-0x07 */
+	0, 0, 0, 0, KEY_LANG1, KEY_LANG2, 0, 0,			/* 0x08-0x0f */
+	0, 0, 0, 0, 0, 0, 0, 0,					/* 0x10-0x17 */
+	0, 0, 0, 0, KEY_KPENTER, KEY_RIGHTCTRL, KEY_VOLUMEUP, 0,/* 0x18-0x1f */
+	0, 0, 0, 0, 0, KEY_VOLUMEDOWN, KEY_MUTE, 0,		/* 0x20-0x27 */
+	0, 0, 0, 0, 0, 0, 0, 0,					/* 0x28-0x2f */
+	0, 0, 0, 0, 0, KEY_KPSLASH, 0, KEY_SYSRQ,		/* 0x30-0x37 */
+	KEY_RIGHTALT, KEY_BRIGHTNESSUP, KEY_BRIGHTNESSDOWN, 
+		KEY_EJECTCD, 0, 0, 0, 0,			/* 0x38-0x3f */
+	0, 0, 0, 0, 0, 0, 0, KEY_HOME,				/* 0x40-0x47 */
+	KEY_UP, KEY_PAGEUP, 0, KEY_LEFT, 0, KEY_RIGHT, 0, KEY_END, /* 0x48-0x4f */
+	KEY_DOWN, KEY_PAGEDOWN, KEY_INSERT, KEY_DELETE, 0, 0, 0, 0, /* 0x50-0x57 */
+	0, 0, 0, KEY_LEFTMETA, KEY_RIGHTMETA, KEY_COMPOSE, KEY_POWER, 0, /* 0x58-0x5f */
+	0, 0, 0, 0, 0, 0, 0, 0,					/* 0x60-0x67 */
+	0, 0, 0, 0, 0, 0, 0, KEY_MACRO,				/* 0x68-0x6f */
+	0, 0, 0, 0, 0, 0, 0, 0,					/* 0x70-0x77 */
+	0, 0, 0, 0, 0, 0, 0, 0					/* 0x78-0x7f */
+};
+
+int kbd_translate(unsigned char scancode, unsigned char *keycode,
+	char raw_mode)
+{
+	/* This code was copied from char/pc_keyb.c and will be
+	 * superflous when the input layer is fully integrated.
+	 * We don't need the high_keys handling, so this part
+	 * has been removed.
+	 */
+	static int prev_scancode = 0;
+
+	/* special prefix scancodes.. */
+	if (scancode == 0xe0 || scancode == 0xe1) {
+		prev_scancode = scancode;
+		return 0;
+	}
+
+	scancode &= 0x7f;
+
+	if (prev_scancode) {
+		if (prev_scancode != 0xe0) {
+			if (prev_scancode == 0xe1 && scancode == 0x1d) {
+				prev_scancode = 0x100;
+				return 0;
+			} else if (prev_scancode == 0x100 && scancode == 0x45) {
+				*keycode = KEY_PAUSE;
+				prev_scancode = 0;
+			} else {
+				if (!raw_mode)
+					printk(KERN_INFO "keyboard: unknown e1 escape sequence\n");
+				prev_scancode = 0;
+				return 0;
+			}
+		} else {
+			prev_scancode = 0;
+			if (scancode == 0x2a || scancode == 0x36)
+				return 0;
+		}
+		if (e0_keys[scancode])
+			*keycode = e0_keys[scancode];
+		else {
+			if (!raw_mode)
+				printk(KERN_INFO "keyboard: unknown scancode e0 %02x\n",
+				       scancode);
+			return 0;
+		}
+	} else {
+		switch (scancode) {
+		case  91: scancode = KEY_LINEFEED; break;
+		case  92: scancode = KEY_KPEQUAL; break;
+		case 125: scancode = KEY_INTL1; break;
+		}
+		*keycode = scancode;
+	}
+	return 1;
+}
+
+#else
 int kbd_translate(unsigned char scancode, unsigned char *keycode,
 	char raw_mode)
 {
@@ -48,6 +129,7 @@
 
 	return 1;
 }
+#endif
 
 char kbd_unexpected_up(unsigned char keycode)
 {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
