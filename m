Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2004 19:12:10 +0000 (GMT)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:10702 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225349AbUBYTMH>; Wed, 25 Feb 2004 19:12:07 +0000
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 5C2914B54A; Wed, 25 Feb 2004 20:11:57 +0100 (CET)
Date: Wed, 25 Feb 2004 20:11:57 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: [PATCH] VSXXX-AA mouse and LK[24]01 keyboard
Message-ID: <20040225191157.GD5838@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--brEuL7wsLY8+TuWz
Content-Type: multipart/mixed; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This is my current patchset adding in-kernel drivers (based on serio and
Input API).

I'm currently using the keyboard driver to write this email (with an
adaptor on my PeeCee). I've not yet build an adaptor for the mouse, but
it emits bytes off the generic PS2 mouse interface on a VAX so it can't
be all that wrong :)

While this is the first Input API driver for the VSXXX-AA mouse, there
already exists a LK driver. Please choose which one you like better.

Of course, comments are highly welcome!

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="DEC-Input.diff"
Content-Transfer-Encoding: quoted-printable

Index: include/linux/serio.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/ftp/pub/mirror/CVS/ftp.linux-mips.org/linux/include/linux/s=
erio.h,v
retrieving revision 1.14
diff -u -r1.14 serio.h
--- a/include/linux/serio.h	10 Jan 2004 04:59:57 -0000	1.14
+++ b/include/linux/serio.h	25 Feb 2004 19:02:19 -0000
@@ -117,6 +117,7 @@
 #define SERIO_MZ	0x05
 #define SERIO_MZP	0x06
 #define SERIO_MZPP	0x07
+#define SERIO_VSXXXAA	0x08
 #define SERIO_SUNKBD	0x10
 #define SERIO_WARRIOR	0x18
 #define SERIO_SPACEORB	0x19
@@ -134,6 +135,7 @@
 #define SERIO_HIL	0x25
 #define SERIO_SNES232	0x26
 #define SERIO_SEMTECH	0x27
+#define SERIO_LKKBD	0x28
=20
 #define SERIO_ID	0xff00UL
 #define SERIO_EXTRA	0xff0000UL
Index: drivers/input/keyboard/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/ftp/pub/mirror/CVS/ftp.linux-mips.org/linux/drivers/input/k=
eyboard/Makefile,v
retrieving revision 1.5
diff -u -r1.5 Makefile
--- a/drivers/input/keyboard/Makefile	5 Jun 2003 10:06:38 -0000	1.5
+++ b/drivers/input/keyboard/Makefile	25 Feb 2004 19:02:19 -0000
@@ -7,6 +7,7 @@
 obj-$(CONFIG_KEYBOARD_ATKBD)		+=3D atkbd.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+=3D maple_keyb.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+=3D sunkbd.o
+obj-$(CONFIG_KEYBOARD_LKKBD)		+=3D lkkbd.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+=3D xtkbd.o
 obj-$(CONFIG_KEYBOARD_AMIGA)		+=3D amikbd.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+=3D newtonkbd.o
Index: drivers/input/keyboard/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/ftp/pub/mirror/CVS/ftp.linux-mips.org/linux/drivers/input/k=
eyboard/Kconfig,v
retrieving revision 1.7
diff -u -r1.7 Kconfig
--- a/drivers/input/keyboard/Kconfig	9 Oct 2003 13:09:30 -0000	1.7
+++ b/drivers/input/keyboard/Kconfig	25 Feb 2004 19:02:19 -0000
@@ -40,6 +40,18 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called sunkbd.
=20
+config KEYBOARD_LKKBD
+	tristate "DECstation / VAXstation LK keyboard support"
+	depends on INPUT && INPUT_KEYBOARD
+	select SERIO
+	help
+	  Say Y here if you want to use a LK201 or LK401 style serial
+	  keyboard. This keyboard is also useable on PCs if you attach
+	  it with the inputattach program.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called lkkbd.
+
 config KEYBOARD_XTKBD
 	tristate "XT Keyboard support"
 	depends on INPUT && INPUT_KEYBOARD
Index: drivers/input/mouse/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/ftp/pub/mirror/CVS/ftp.linux-mips.org/linux/drivers/input/m=
ouse/Makefile,v
retrieving revision 1.6
diff -u -r1.6 Makefile
--- a/drivers/input/mouse/Makefile	23 Jun 2003 01:23:05 -0000	1.6
+++ b/drivers/input/mouse/Makefile	25 Feb 2004 19:02:19 -0000
@@ -13,5 +13,6 @@
 obj-$(CONFIG_MOUSE_PC9800)	+=3D 98busmouse.o
 obj-$(CONFIG_MOUSE_PS2)		+=3D psmouse.o
 obj-$(CONFIG_MOUSE_SERIAL)	+=3D sermouse.o
+obj-$(CONFIG_MOUSE_VSXXXAA)	+=3D vsxxxaa.o
=20
 psmouse-objs  :=3D psmouse-base.o logips2pp.o synaptics.o
Index: drivers/input/mouse/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/ftp/pub/mirror/CVS/ftp.linux-mips.org/linux/drivers/input/m=
ouse/Kconfig,v
retrieving revision 1.12
diff -u -r1.12 Kconfig
--- a/drivers/input/mouse/Kconfig	5 Feb 2004 02:40:00 -0000	1.12
+++ b/drivers/input/mouse/Kconfig	25 Feb 2004 19:02:19 -0000
@@ -117,6 +117,18 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called rpcmouse.
=20
+config MOUSE_VSXXXAA
+	tristate "DEC VSXXX-AA/GA mouse and tablet"
+	depends on INPUT && INPUT_MOUSE
+	select SERIO
+	help
+	  Say Y (or M) if you want to use a DEC VSXXX-AA (hockey
+	  puck) or a VSXXX-GA (rectangular) mouse. Theses mice are
+	  typically used on DECstations or VAXstations, but can also
+	  be used on any box capable of RS232 (with some adaptor
+	  described in the source file). This driver should, in theory,
+	  also work with the tablet DEC produced...
+
 config MOUSE_PC9800
 	tristate "NEC PC-9800 busmouse"
 	depends on X86_PC9800 && INPUT && INPUT_MOUSE && ISA
--- /dev/null	2004-02-01 01:00:40.000000000 +0100
+++ b/drivers/input/keyboard/lkkbd.c	2004-02-25 20:00:56.000000000 +0100
@@ -0,0 +1,532 @@
+/*
+ *  Copyright (C) 2004 by Jan-Benedict Glaw <jbglaw@lug-owl.de>
+ */
+
+/*
+ * LK keyboard driver for Linux, based on sunkbd.c (C) by Vojtech Pavlik
+ */
+
+/*
+ * DEC LK201 and LK401 keyboard driver for Linux (primary for DECstations
+ * and VAXstations, but can also be used on any standard RS232 with an
+ * adaptor).
+ *
+ * DISCLAUNER: This works for _me_. If you break anything by using the
+ * information given below, I will _not_ be lieable!
+ *
+ * RJ11 pinout:		To DB9:		Or DB25:
+ * 	1 - RxD <---->	Pin 3 (TxD) <->	Pin 2 (TxD)
+ * 	2 - GND <---->	Pin 5 (GND) <->	Pin 7 (GND)
+ * 	4 - TxD <---->	Pin 2 (RxD) <->	Pin 3 (RxD)
+ * 	3 - +12V (from HDD drive connector), DON'T connect to DB9 or DB25!!!
+ *
+ * Pin numbers for DB9 and DB25 are noted on the plug (quite small:). For
+ * RJ11, it's like this:
+ *
+ *      __=3D__	Hold the plug in front of you, cable downwards,
+ *     /___/|	nose is hidden behind the plug. Now, pin 1 is at
+ *    |1234||	the left side, pin 4 at the right and 2 and 3 are
+ *    |IIII||	in between, of course:)
+ *    |    ||
+ *    |____|/
+ *      ||	So the adaptor consists of three connected cables
+ *      ||	for data transmission (RxD and TxD) and signal ground.
+ *		Additionally, you have to get +12V from somewhere.
+ * Most easily, you'll get that from a floppy or HDD power connector.
+ * It's the yellow cable there (black is ground and red is +5V).
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or=20
+ * (at your option) any later version.
+ *=20
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *=20
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *=20
+ * Should you need to contact me, the author, you can do so either by
+ * email or by paper mail:
+ * Jan-Benedict Glaw, Lilienstra=DFe 16, 33790 H=F6rste (near Halle/Westf.=
),
+ * Germany.
+ */
+
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/workqueue.h>
+
+MODULE_AUTHOR ("Jan-Benedict Glaw <jblaw@lug-owl.de>");
+MODULE_DESCRIPTION ("LK keyboard driver");
+MODULE_LICENSE ("GPL");
+
+#undef LKKBD_DEBUG
+#ifdef LKKBD_DEBUG
+#define DBG(x...) printk (x)
+#else
+#define DBG(x...) do {} while (0)
+#endif
+
+static unsigned char lkkbd_keycode[256] =3D {
+	[0x56] =3D KEY_F1,
+	[0x57] =3D KEY_F2,
+	[0x58] =3D KEY_F3,
+	[0x59] =3D KEY_F4,
+	[0x5a] =3D KEY_F5,
+	[0x64] =3D KEY_F6,
+	[0x65] =3D KEY_F7,
+	[0x66] =3D KEY_F8,
+	[0x67] =3D KEY_F9,
+	[0x68] =3D KEY_F10,
+	[0x71] =3D KEY_F11,
+	[0x72] =3D KEY_F12,
+	[0x73] =3D KEY_F13,
+	[0x74] =3D KEY_F14,
+	[0x7c] =3D KEY_F15,
+	[0x7d] =3D KEY_F16,
+	[0x80] =3D KEY_F17,
+	[0x81] =3D KEY_F18,
+	[0x82] =3D KEY_F19,
+	[0x83] =3D KEY_F20,
+	[0x8a] =3D KEY_FIND,
+	[0x8b] =3D KEY_INSERT,
+	[0x8c] =3D KEY_DELETE,
+	[0x8d] =3D KEY_RESERVED, /* KEY_SELECT */
+	[0x8e] =3D KEY_PAGEUP,
+	[0x8f] =3D KEY_PAGEDOWN,
+	[0x92] =3D KEY_KP0,
+	[0x94] =3D KEY_KPDOT,
+	[0x95] =3D KEY_KPENTER,
+	[0x96] =3D KEY_KP1,
+	[0x97] =3D KEY_KP2,
+	[0x98] =3D KEY_KP3,
+	[0x99] =3D KEY_KP4,
+	[0x9a] =3D KEY_KP5,
+	[0x9b] =3D KEY_KP6,
+	[0x9c] =3D KEY_KPCOMMA,
+	[0x9d] =3D KEY_KP7,
+	[0x9e] =3D KEY_KP8,
+	[0x9f] =3D KEY_KP9,
+	[0xa0] =3D KEY_KPMINUS,
+	[0xa1] =3D KEY_RESERVED, /* KP_PF1 */
+	[0xa2] =3D KEY_RESERVED, /* KP_PF2 */
+	[0xa3] =3D KEY_RESERVED, /* KP_PF3 */
+	[0xa4] =3D KEY_RESERVED, /* KP_PF3 */
+	[0xa7] =3D KEY_LEFT,
+	[0xa8] =3D KEY_RIGHT,
+	[0xa9] =3D KEY_DOWN,
+	[0xaa] =3D KEY_UP,
+	[0xab] =3D KEY_RIGHTSHIFT,
+	[0xac] =3D KEY_LEFTALT,
+	[0xad] =3D KEY_COMPOSE, /* Right Compose, that is. */
+	[0xae] =3D KEY_LEFTSHIFT, /* Same as KEY_RIGHTSHIFT on LK201 */
+	[0xaf] =3D KEY_LEFTCTRL,
+	[0xb0] =3D KEY_CAPSLOCK,
+	[0xb1] =3D KEY_COMPOSE, /* Left Compose, that is. */
+	[0xb2] =3D KEY_RIGHTALT,
+	[0xbc] =3D KEY_BACKSPACE,
+	[0xbd] =3D KEY_ENTER,
+	[0xbe] =3D KEY_TAB,
+	[0xbf] =3D KEY_ESC,
+	[0xc0] =3D KEY_1,
+	[0xc1] =3D KEY_Q,
+	[0xc2] =3D KEY_A,
+	[0xc3] =3D KEY_Z,
+	[0xc5] =3D KEY_2,
+	[0xc6] =3D KEY_W,
+	[0xc7] =3D KEY_S,
+	[0xc8] =3D KEY_X,
+	[0xc9] =3D KEY_102ND,
+	[0xcb] =3D KEY_3,
+	[0xcc] =3D KEY_E,
+	[0xcd] =3D KEY_D,
+	[0xce] =3D KEY_C,
+	[0xd0] =3D KEY_4,
+	[0xd1] =3D KEY_R,
+	[0xd2] =3D KEY_F,
+	[0xd3] =3D KEY_V,
+	[0xd4] =3D KEY_SPACE,
+	[0xd6] =3D KEY_5,
+	[0xd7] =3D KEY_T,
+	[0xd8] =3D KEY_G,
+	[0xd9] =3D KEY_B,
+	[0xdb] =3D KEY_6,
+	[0xdc] =3D KEY_Y,
+	[0xdd] =3D KEY_H,
+	[0xde] =3D KEY_N,
+	[0xe0] =3D KEY_7,
+	[0xe1] =3D KEY_U,
+	[0xe2] =3D KEY_J,
+	[0xe3] =3D KEY_M,
+	[0xe5] =3D KEY_8,
+	[0xe6] =3D KEY_I,
+	[0xe7] =3D KEY_K,
+	[0xe8] =3D KEY_COMMA,
+	[0xea] =3D KEY_9,
+	[0xeb] =3D KEY_O,
+	[0xec] =3D KEY_L,
+	[0xed] =3D KEY_DOT,
+	[0xef] =3D KEY_0,
+	[0xf0] =3D KEY_P,
+	[0xf2] =3D KEY_SEMICOLON,
+	[0xf3] =3D KEY_SLASH,
+	[0xf5] =3D KEY_EQUAL,
+	[0xf6] =3D KEY_RIGHTBRACE,
+	[0xf7] =3D KEY_BACKSLASH,
+	[0xf9] =3D KEY_MINUS,
+	[0xfa] =3D KEY_LEFTBRACE,
+	[0xfb] =3D KEY_APOSTROPHE,
+};
+
+/* LED control */
+#define LK_LED_WAIT		0x81
+#define LK_LED_COMPOSE		0x82
+#define LK_LED_SHIFTLOCK	0x84
+#define LK_LED_SCROLLLOCK	0x88
+#define LK_CMD_LED_ON		0x13
+#define LK_CMD_LED_OFF		0x11
+
+/* Mode control */
+#define LK_MODE_DOWN		0x80
+#define LK_MODE_AUTODOWN	0x82
+#define LK_MODE_UPDOWN		0x86
+#define LK_CMD_SET_MODE(mode,div)	((mode) | ((div) << 3))
+
+/* Misc commands */
+#define LK_CMD_SOUND_BELL	0xa7
+#define LK_CMD_SET_DEFAULTS	0xd3
+#define LK_CMD_POWERCYCLE_RESET	0xfd
+#define LK_CMD_ENABLE_LK401	0xe9
+
+/* Misc responses from keyboard */
+#define LK_ALL_KEYS_UP		0xb3
+#define LK_METRONOME		0xb4
+#define LK_OUTPUT_ERROR		0xb5
+#define LK_INPUT_ERROR		0xb6
+#define LK_KBD_LOCKED		0xb7
+#define LK_KBD_TEST_MODE_ACK	0xb8
+#define LK_PREFIX_KEY_DOWN	0xb9
+#define LK_MODE_CHANGE_ACK	0xba
+#define LK_RESPONSE_RESERVED	0xbb
+
+#define CHECK_LED(LED, BITS) do {		\
+	if (test_bit (LED, lk->dev.led))	\
+		leds_on |=3D BITS;		\
+	else					\
+		leds_off |=3D BITS;		\
+	} while (0)
+
+/*
+ * Per-keyboard data
+ */
+struct lkkbd {
+	unsigned char keycode[256];
+	int ignore_bytes;
+	struct input_dev dev;
+	struct serio *serio;
+	struct work_struct tq;
+	char name[64];
+	char phys[32];
+	char type;
+};
+
+/*
+ * lkkbd_interrupt() is called by the low level driver when a character
+ * is received.
+ */
+static irqreturn_t
+lkkbd_interrupt (struct serio *serio, unsigned char data, unsigned int fla=
gs,
+		struct pt_regs *regs)
+{
+	struct lkkbd *lk =3D serio->private;
+	int i;
+
+	DBG (KERN_INFO "Got byte 0x%02x\n", data);
+
+	if (lk->ignore_bytes > 0) {
+		DBG (KERN_INFO "Ignoring a byte on %s\n",
+				lk->name);
+		lk->ignore_bytes--;
+		return IRQ_HANDLED;
+	}
+
+	switch (data) {
+		case LK_ALL_KEYS_UP:
+			input_regs (&lk->dev, regs);
+			for (i =3D 0; i < ARRAY_SIZE (lkkbd_keycode); i++)
+				if (lk->keycode[i] !=3D KEY_RESERVED)
+					input_report_key (&lk->dev, lk->keycode[i], 0);
+			input_sync (&lk->dev);
+			break;
+		case LK_METRONOME:
+			DBG (KERN_INFO "Got LK_METRONOME and don't "
+					"know how to handle...\n");
+			break;
+		case LK_OUTPUT_ERROR:
+			DBG (KERN_INFO "Got LK_OUTPUT_ERROR and don't "
+					"know how to handle...\n");
+			break;
+		case LK_INPUT_ERROR:
+			DBG (KERN_INFO "Got LK_INPUT_ERROR and don't "
+					"know how to handle...\n");
+			break;
+		case LK_KBD_LOCKED:
+			DBG (KERN_INFO "Got LK_KBD_LOCKED and don't "
+					"know how to handle...\n");
+			break;
+		case LK_KBD_TEST_MODE_ACK:
+			DBG (KERN_INFO "Got LK_KBD_TEST_MODE_ACK and don't "
+					"know how to handle...\n");
+			break;
+		case LK_PREFIX_KEY_DOWN:
+			DBG (KERN_INFO "Got LK_PREFIX_KEY_DOWN and don't "
+					"know how to handle...\n");
+			break;
+		case LK_MODE_CHANGE_ACK:
+			DBG (KERN_INFO "Got LK_MODE_CHANGE_ACK and ignored "
+					"it properly...\n");
+			break;
+		case LK_RESPONSE_RESERVED:
+			DBG (KERN_INFO "Got LK_RESPONSE_RESERVED and don't "
+					"know how to handle...\n");
+			break;
+		case 0x01:
+			DBG (KERN_INFO "Got 0x01, scheduling re-initialization\n");
+			lk->ignore_bytes =3D 3;
+			schedule_work (&lk->tq);
+			break;
+
+		default:
+			if (lk->keycode[data] !=3D KEY_RESERVED) {
+				input_regs (&lk->dev, regs);
+				if (!test_bit (lk->keycode[data], lk->dev.key))
+					input_report_key (&lk->dev, lk->keycode[data], 1);
+				else
+					input_report_key (&lk->dev, lk->keycode[data], 0);
+				input_sync (&lk->dev);
+                        } else
+                                printk (KERN_WARNING "%s: Unknown key with=
 "
+						"scancode %02x on %s.\n",
+						__FILE__, data, lk->name);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * lkkbd_event() handles events from the input module.
+ */
+static int
+lkkbd_event (struct input_dev *dev, unsigned int type, unsigned int code,
+		int value)
+{
+	struct lkkbd *lk =3D dev->private;
+	unsigned char leds_on =3D 0;
+	unsigned char leds_off =3D 0;
+
+	switch (type) {
+		case EV_LED:
+			CHECK_LED (LED_CAPSL, LK_LED_SHIFTLOCK);
+			CHECK_LED (LED_COMPOSE, LK_LED_COMPOSE);
+			CHECK_LED (LED_SCROLLL, LK_LED_SCROLLLOCK);
+			CHECK_LED (LED_SLEEP, LK_LED_WAIT);
+			if (leds_on !=3D 0) {
+				lk->serio->write (lk->serio, LK_CMD_LED_ON);
+				lk->serio->write (lk->serio, leds_on);
+			}
+			if (leds_off !=3D 0) {
+				lk->serio->write (lk->serio, LK_CMD_LED_OFF);
+				lk->serio->write (lk->serio, leds_off);
+			}
+			return 0;
+
+		case EV_SND:
+			switch (code) {
+				case SND_CLICK:
+					/*
+					 * Mostly, I don't know if I need
+					 * to once sound a key click or I'm
+					 * ment to enable it for all
+					 * upcoming key presses...
+					 */
+					printk (KERN_ERR "EV_SND/SND_CLICK: Don't know how to handle...\n");
+					return -1;
+=09
+				case SND_BELL:
+					if (value !=3D 0)
+						lk->serio->write (lk->serio, LK_CMD_SOUND_BELL);
+					return 0;
+			}
+			break;
+
+		default:
+			printk (KERN_ERR "%s(): Got unknown type %d, code %d, value %d\n",
+					__FUNCTION__, type, code, value);
+	}
+
+	return -1;
+}
+
+/*
+ * lkkbd_reinit() sets leds and beeps to a state the computer remembers th=
ey
+ * were in.
+ */
+static void
+lkkbd_reinit (void *data)
+{
+	struct lkkbd *lk =3D data;
+	int division;
+	unsigned char leds_on =3D 0;
+	unsigned char leds_off =3D 0;
+
+	/* Reset parameters */
+	lk->serio->write (lk->serio, LK_CMD_SET_DEFAULTS);
+
+	/* Set LEDs */
+	CHECK_LED (LED_CAPSL, LK_LED_SHIFTLOCK);
+	CHECK_LED (LED_COMPOSE, LK_LED_COMPOSE);
+	CHECK_LED (LED_SCROLLL, LK_LED_SCROLLLOCK);
+	CHECK_LED (LED_SLEEP, LK_LED_WAIT);
+	if (leds_on !=3D 0) {
+		lk->serio->write (lk->serio, LK_CMD_LED_ON);
+		lk->serio->write (lk->serio, leds_on);
+	}
+	if (leds_off !=3D 0) {
+		lk->serio->write (lk->serio, LK_CMD_LED_OFF);
+		lk->serio->write (lk->serio, leds_off);
+	}
+
+	/*
+	 * Try to activate extended LK401 mode. This command will
+	 * only work with a LK401 keyboard and grants access to
+	 * LAlt, RAlt, RCompose and RShift.
+	 */
+	lk->serio->write (lk->serio, LK_CMD_ENABLE_LK401);
+
+	/* Set all keys to UPDOWN mode */
+	for (division =3D 1; division <=3D 14; division++)
+		lk->serio->write (lk->serio, LK_CMD_SET_MODE (LK_MODE_UPDOWN,
+					division));
+
+#warning Need to set click / bell
+	/* Need to click? */
+#if 0
+	lk->serio->write (lk->serio, SUNKBD_CMD_NOCLICK - !!test_bit(SND_CLICK, s=
unkbd->dev.snd));
+	lk->serio->write (lk->serio, SUNKBD_CMD_BELLOFF - !!test_bit(SND_BELL, su=
nkbd->dev.snd));
+#endif
+}
+
+/*
+ * lkkbd_connect() probes for a LK keyboard and fills the necessary struct=
ures.
+ */
+static void
+lkkbd_connect (struct serio *serio, struct serio_dev *dev)
+{
+	struct lkkbd *lk;
+	int i;
+
+	if ((serio->type & SERIO_TYPE) !=3D SERIO_RS232)
+		return;
+	if (!(serio->type & SERIO_PROTO))
+		return;
+	if ((serio->type & SERIO_PROTO) && (serio->type & SERIO_PROTO) !=3D SERIO=
_LKKBD)
+		return;
+
+	if (!(lk =3D kmalloc (sizeof (struct lkkbd), GFP_KERNEL)))
+		return;
+	memset (lk, 0, sizeof (struct lkkbd));
+
+	init_input_dev (&lk->dev);
+
+	lk->dev.evbit[0] =3D BIT (EV_KEY) | BIT (EV_LED) | BIT (EV_SND) | BIT (EV=
_REP);
+	lk->dev.ledbit[0] =3D BIT (LED_CAPSL) | BIT (LED_COMPOSE) | BIT (LED_SCRO=
LLL) | BIT (LED_SLEEP);
+	lk->dev.sndbit[0] =3D BIT (SND_CLICK) | BIT (SND_BELL);
+
+	lk->serio =3D serio;
+
+	INIT_WORK (&lk->tq, lkkbd_reinit, lk);
+
+	lk->dev.keycode =3D lk->keycode;
+	lk->dev.keycodesize =3D sizeof (unsigned char);
+	lk->dev.keycodemax =3D ARRAY_SIZE (lkkbd_keycode);
+
+	lk->dev.event =3D lkkbd_event;
+	lk->dev.private =3D lk;
+
+	serio->private =3D lk;
+
+	if (serio_open (serio, dev)) {
+		kfree (lk);
+		return;
+	}
+
+	sprintf (lk->name, "LK keyboard");
+
+	memcpy (lk->keycode, lkkbd_keycode, sizeof (lk->keycode));
+	for (i =3D 0; i < ARRAY_SIZE (lkkbd_keycode); i++)
+		set_bit (lk->keycode[i], lk->dev.keybit);
+	clear_bit (0, lk->dev.keybit);
+
+	sprintf (lk->name, "%s/input0", serio->phys);
+
+	lk->dev.name =3D lk->name;
+	lk->dev.phys =3D lk->phys;
+	lk->dev.id.bustype =3D BUS_RS232;
+	lk->dev.id.vendor =3D SERIO_LKKBD;
+	lk->dev.id.product =3D 0;
+	lk->dev.id.version =3D 0x0100;
+
+	input_register_device (&lk->dev);
+
+	printk (KERN_INFO "input: %s on %s, initiating reset\n", lk->name, serio-=
>phys);
+	lk->serio->write (lk->serio, LK_CMD_POWERCYCLE_RESET);
+}
+
+/*
+ * lkkbd_disconnect() unregisters and closes behind us.
+ */
+static void
+lkkbd_disconnect (struct serio *serio)
+{
+	struct lkkbd *lk =3D serio->private;
+
+	input_unregister_device (&lk->dev);
+	serio_close (serio);
+	kfree (lk);
+}
+
+static struct serio_dev lkkbd_dev =3D {
+	.interrupt =3D lkkbd_interrupt,
+	.connect =3D lkkbd_connect,
+	.disconnect =3D lkkbd_disconnect,
+};
+
+/*
+ * The functions for insering/removing us as a module.
+ */
+int __init
+lkkbd_init (void)
+{
+	serio_register_device (&lkkbd_dev);
+	return 0;
+}
+
+void __exit
+lkkbd_exit (void)
+{
+	serio_unregister_device (&lkkbd_dev);
+}
+
+module_init (lkkbd_init);
+module_exit (lkkbd_exit);
+
--- /dev/null	2004-02-01 01:00:40.000000000 +0100
+++ b/drivers/input/mouse/vsxxxaa.c	2004-02-25 19:57:03.000000000 +0100
@@ -0,0 +1,550 @@
+/*
+ * DEC VSXXX-AA and VSXXX-GA mouse driver.
+ *
+ * Copyright (C) 2003-2004 by Jan-Benedict Glaw <jbglaw@lug-owl.de>
+ *
+ * The packet format was taken from a patch to GPM which is (C) 2001
+ * by	Karsten Merker <merker@linuxtag.org>
+ * and	Maciej W. Rozycki <macro@ds2.pg.gda.pl>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or=20
+ * (at your option) any later version.
+ *=20
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *=20
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+/*
+ * Building an adaptor to DB9 / DB25 RS232
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * DISCLAIMER: Use this description AT YOUR OWN RISK! I'll not pay for
+ * anything if you break your mouse, your computer or whatever!
+ *
+ * In theory, this mouse is a simple RS232 device. In practice, it has got
+ * a quite uncommon plug and the requirement to additionally get a power
+ * supply at +5V and -12V.
+ *
+ * If you look at the socket/jack (_not_ at the plug), we use this pin
+ * numbering:
+ *    _______
+ *   / 7 6 5 \
+ *  | 4 --- 3 |
+ *   \  2 1  /
+ *    -------
+ *=20
+ *	DEC socket	DB9	DB25	Note
+ *	1 (GND)		5	7	-
+ *	2 (RxD)		3	3	-
+ *	3 (TxD)		2	2	-
+ *	4 (-12V)	-	-	Somewhere from the PSU. At ATX, it's
+ *					the blue wire at pin 12 of the ATX
+ *					power connector. Please note that the
+ *					docs say this should be +12V! However,
+ *					I measured -12V...
+ *	5 (+5V)		-	-	PSU (red wire of ATX power connector
+ *					on pin 4, 6, 19 or 20) or HDD power
+ *					connector (also red wire)
+ *	6 (not conn.)	-	-	-
+ *	7 (dev. avail.)	-	-	The mouse shorts this one to pin 1.
+ *					This way, the host computer can detect
+ *					the mouse. To use it with the adaptor,
+ *					simply don't connect this pin.
+ *
+ * So to get a working adaptor, you need to connect the mouse with three
+ * wires to a RS232 port and two additional wires for +5V and -12V to the
+ * PSU.
+ *
+ * Flow specification for the link is 4800, 8o1.
+ */
+
+/*
+ * TODO list:
+ * - Automatically attach to a given serial port (no need for inputattach).
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/config.h>
+#include <linux/serio.h>
+#include <linux/init.h>
+
+MODULE_AUTHOR ("Jan-Benedict Glaw <jbglaw@lug-owl.de>");
+MODULE_DESCRIPTION ("Serial DEC VSXXX-AA/GA mouse / DEC tablet driver");
+MODULE_LICENSE ("GPL");
+
+#undef VSXXXAA_DEBUG
+#ifdef VSXXXAA_DEBUG
+#define DBG(x...) printk (x)
+#else
+#define DBG(x...) do {} while (0)
+#endif
+
+#define VSXXXAA_INTRO_MASK	0x80
+#define VSXXXAA_INTRO_HEAD	0x80
+#define IS_HDR_BYTE(x)		(((x) & VSXXXAA_INTRO_MASK)	\
+					=3D=3D VSXXXAA_INTRO_HEAD)
+
+#define VSXXXAA_PACKET_MASK	0xe0
+#define VSXXXAA_PACKET_REL	0x80
+#define VSXXXAA_PACKET_ABS	0xc0
+#define VSXXXAA_PACKET_POR	0xa0
+#define MATCH_PACKET_TYPE(data, type)	(((data) & VSXXXAA_PACKET_MASK) =3D=
=3D type)
+
+
+
+struct vsxxxaa {
+	struct input_dev dev;
+	struct serio *serio;
+#define BUFLEN 15 /* At least 5 is needed for a full tablet packet */
+	unsigned char buf[BUFLEN];
+	unsigned char count;
+	unsigned char version;
+	unsigned char country;
+	unsigned char type;
+	char phys[32];
+};
+
+static void
+vsxxxaa_drop_bytes (struct vsxxxaa *mouse, int num)
+{
+	if (num >=3D mouse->count)
+		mouse->count =3D 0;
+	else {
+		memmove (mouse->buf, mouse->buf + num - 1, BUFLEN - num);
+		mouse->count -=3D num;
+	}
+}
+
+static void
+vsxxxaa_queue_byte (struct vsxxxaa *mouse, unsigned char byte)
+{
+	if (mouse->count =3D=3D BUFLEN) {
+		printk (KERN_ERR "%s on %s: Dropping a byte of full buffer.\n",
+				mouse->dev.name, mouse->dev.phys);
+		vsxxxaa_drop_bytes (mouse, 1);
+	}
+
+	mouse->buf[mouse->count++] =3D byte;
+}
+
+static void
+vsxxxaa_report_mouse (struct vsxxxaa *mouse)
+{
+	char *devtype;
+
+	switch (mouse->type) {
+		case 0x02:	devtype =3D "DEC mouse"; break;
+		case 0x04:	devtype =3D "DEC tablet"; break;
+		default:	devtype =3D "unknown DEC device"; break;
+	}
+
+	printk (KERN_INFO "Found %s version 0x%x from country 0x%x "
+			"on port %s\n", devtype, mouse->version,
+			mouse->country, mouse->dev.phys);
+}
+
+/*
+ * Returns number of bytes to be dropped, 0 if packet is okay.
+ */
+static int
+vsxxxaa_check_packet (struct vsxxxaa *mouse, int packet_len)
+{
+	int i;
+
+	/* First byte must be a header byte */
+	if (!IS_HDR_BYTE (mouse->buf[0])) {
+		DBG ("vsck: len=3D%d, 1st=3D0x%02x\n", packet_len, mouse->buf[0]);
+		return 1;
+	}
+
+	/* Check all following bytes */
+	if (packet_len > 1) {
+		for (i =3D 1; i < packet_len; i++) {
+			if (IS_HDR_BYTE (mouse->buf[i])) {
+				printk (KERN_ERR "Need to drop %d bytes "
+						"of a broken packet.\n",
+						i - 1);
+				DBG (KERN_INFO "check: len=3D%d, b[%d]=3D0x%02x\n",
+						packet_len, i, mouse->buf[i]);
+				return i - 1;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static __inline__ int
+vsxxxaa_smells_like_packet (struct vsxxxaa *mouse, unsigned char type, siz=
e_t len)
+{
+	return (mouse->count >=3D len) && MATCH_PACKET_TYPE (mouse->buf[0], type);
+}
+
+static void
+vsxxxaa_handle_REL_packet (struct vsxxxaa *mouse, struct pt_regs *regs)
+{
+	struct input_dev *dev =3D &mouse->dev;
+	unsigned char *buf =3D mouse->buf;
+	int left, middle, right;
+	int dx, dy;
+
+	/*
+	 * Check for normal stream packets. This is three bytes,
+	 * with the first byte's 3 MSB set to 100.
+	 *
+	 * [0]:	1	0	0	SignX	SignY	Left	Middle	Right
+	 * [1]: 0	dx	dx	dx	dx	dx	dx	dx
+	 * [2]:	0	dy	dy	dy	dy	dy	dy	dy
+	 */
+
+	/*
+	 * Low 7 bit of byte 1 are abs(dx), bit 7 is
+	 * 0, bit 4 of byte 0 is direction.
+	 */
+	dx =3D buf[1] & 0x7f;
+	dx *=3D ((buf[0] >> 4) & 0x01)? -1: 1;
+
+	/*
+	 * Low 7 bit of byte 2 are abs(dy), bit 7 is
+	 * 0, bit 3 of byte 0 is direction.
+	 */
+	dy =3D buf[2] & 0x7f;
+	dy *=3D ((buf[0] >> 3) & 0x01)? -1: 1;
+
+	/*
+	 * Get button state. It's the low three bits
+	 * (for three buttons) of byte 0.
+	 */
+	left	=3D (buf[0] & 0x04)? 1: 0;
+	middle	=3D (buf[0] & 0x02)? 1: 0;
+	right	=3D (buf[0] & 0x01)? 1: 0;
+
+	vsxxxaa_drop_bytes (mouse, 3);
+
+	DBG (KERN_INFO "%s on %s: dx=3D%d, dy=3D%d, buttons=3D%s%s%s\n",
+			mouse->dev.name, mouse->dev.phys, dx, dy,
+			left? "L": "l", middle? "M": "m", right? "R": "r");
+
+	/*
+	 * Report what we've found so far...
+	 */
+	input_regs (dev, regs);
+	input_report_key (dev, BTN_LEFT, left);
+	input_report_key (dev, BTN_MIDDLE, middle);
+	input_report_key (dev, BTN_RIGHT, right);
+	input_report_rel (dev, REL_X, dx);
+	input_report_rel (dev, REL_Y, dy);
+	input_sync (dev);
+}
+
+static void
+vsxxxaa_handle_ABS_packet (struct vsxxxaa *mouse, struct pt_regs *regs)
+{
+	struct input_dev *dev =3D &mouse->dev;
+	unsigned char *buf =3D mouse->buf;
+	int left, middle, right, extra;
+	int x, y;
+
+	/*
+	 * Tablet position / button packet
+	 *
+	 * [0]:	1	1	0	B4	B3	B2	B1	Pr
+	 * [1]:	0	0	X5	X4	X3	X2	X1	X0
+	 * [2]:	0	0	X11	X10	X9	X8	X7	X6
+	 * [3]:	0	0	Y5	Y4	Y3	Y2	Y1	Y0
+	 * [4]:	0	0	Y11	Y10	Y9	Y8	Y7	Y6
+	 */
+
+	/*
+	 * Get X/Y position
+	 */
+	x =3D ((buf[2] & 0x3f) << 6) | (buf[1] & 0x3f);
+	y =3D ((buf[4] & 0x3f) << 6) | (buf[3] & 0x3f);
+
+	/*
+	 * Get button state. It's bits <4..1> of byte 0.
+	 */
+	left	=3D (buf[0] & 0x02)? 1: 0;
+	middle	=3D (buf[0] & 0x04)? 1: 0;
+	right	=3D (buf[0] & 0x08)? 1: 0;
+	extra	=3D (buf[0] & 0x10)? 1: 0;
+
+	vsxxxaa_drop_bytes (mouse, 5);
+
+	DBG (KERN_INFO "%s on %s: x=3D%d, y=3D%d, buttons=3D%s%s%s%s\n",
+			mouse->dev.name, mouse->dev.phys, x, y,
+			left? "L": "l", middle? "M": "m",
+			right? "R": "r", extra? "E": "e");
+
+	/*
+	 * Report what we've found so far...
+	 */
+	input_regs (dev, regs);
+	input_report_key (dev, BTN_LEFT, left);
+	input_report_key (dev, BTN_MIDDLE, middle);
+	input_report_key (dev, BTN_RIGHT, right);
+	input_report_key (dev, BTN_EXTRA, extra);
+	input_report_abs (dev, ABS_X, x);
+	input_report_abs (dev, ABS_Y, y);
+	input_sync (dev);
+}
+
+static void
+vsxxxaa_handle_POR_packet (struct vsxxxaa *mouse, struct pt_regs *regs)
+{
+	struct input_dev *dev =3D &mouse->dev;
+	unsigned char *buf =3D mouse->buf;
+	int left, middle, right;
+	unsigned char error;
+
+	/*
+	 * Check for Power-On-Reset packets. These are sent out
+	 * after plugging the mouse in, or when explicitely
+	 * requested by sending 'T'.
+	 *
+	 * [0]:	1	0	1	0	R3	R2	R1	R0
+	 * [1]:	0	M2	M1	M0	D3	D2	D1	D0
+	 * [2]:	0	E6	E5	E4	E3	E2	E1	E0
+	 * [3]:	0	0	0	0	0	Left	Middle	Right
+	 *
+	 * M: manufacturer location code
+	 * R: revision code
+	 * E: Error code. I'm not sure about these, but gpm's sources,
+	 *    which support this mouse, too, tell about them:
+	 *	E =3D [0x00 .. 0x1f]: no error, byte #3 is button state
+	 *	E =3D 0x3d: button error, byte #3 tells which one.
+	 *	E =3D <else>: other error
+	 * D: <0010> =3D=3D mouse, <0100> =3D=3D tablet
+	 *
+	 */
+
+	mouse->version =3D buf[0] & 0x0f;
+	mouse->country =3D (buf[1] >> 4) & 0x07;
+	mouse->type =3D buf[1] & 0x07;
+	error =3D buf[2] & 0x7f;
+
+	/*
+	 * Get button state. It's the low three bits
+	 * (for three buttons) of byte 0. Maybe even the bit <3>
+	 * has some meaning if a tablet is attached.
+	 */
+	left	=3D (buf[0] & 0x04)? 1: 0;
+	middle	=3D (buf[0] & 0x02)? 1: 0;
+	right	=3D (buf[0] & 0x01)? 1: 0;
+
+	vsxxxaa_drop_bytes (mouse, 4);
+	vsxxxaa_report_mouse (mouse);
+
+	if (error <=3D 0x1f) {
+		/* No error. Report buttons */
+		input_regs (dev, regs);
+		input_report_key (dev, BTN_LEFT, left);
+		input_report_key (dev, BTN_MIDDLE, middle);
+		input_report_key (dev, BTN_RIGHT, right);
+		input_sync (dev);
+	} else {
+		printk (KERN_ERR "Your %s on %s reports an undefined error, "
+				"please check it...\n", mouse->dev.name,
+				mouse->dev.phys);
+	}
+
+	/*
+	 * If the mouse was hot-plugged, we need to
+	 * force differential mode now...
+	 */
+	printk (KERN_NOTICE "%s on %s: Forceing standard packet format and "
+			"streaming mode\n", mouse->dev.name, mouse->dev.phys);
+	mouse->serio->write (mouse->serio, 'S');
+	mouse->serio->write (mouse->serio, 'R');
+}
+
+static void
+vsxxxaa_parse_buffer (struct vsxxxaa *mouse, struct pt_regs *regs)
+{
+	unsigned char *buf =3D mouse->buf;
+	int stray_bytes;
+
+	/*
+	 * Parse buffer to death...
+	 */
+	do {
+		/*
+		 * Out of sync? Throw away what we don't understand. Each
+		 * packet starts with a byte whose bit 7 is set. Unhandled
+		 * packets (ie. which we don't know about or simply b0rk3d
+		 * data...) will get shifted out of the buffer after some
+		 * activity on the mouse.
+		 */
+		while (mouse->count > 0 && !IS_HDR_BYTE(buf[0])) {
+			printk (KERN_ERR "%s on %s: Dropping a byte to regain "
+					"sync with mouse data stream...\n",
+					mouse->dev.name, mouse->dev.phys);
+			vsxxxaa_drop_bytes (mouse, 1);
+		}
+
+		/*
+		 * Check for packets we know about.
+		 */
+
+		if (vsxxxaa_smells_like_packet (mouse, VSXXXAA_PACKET_REL, 3)) {
+			/* Check for broken packet */
+			stray_bytes =3D vsxxxaa_check_packet (mouse, 3);
+			if (stray_bytes > 0) {
+				printk (KERN_ERR "Dropping %d bytes now...\n",
+						stray_bytes);
+				vsxxxaa_drop_bytes (mouse, stray_bytes);
+				continue;
+			}
+
+			vsxxxaa_handle_REL_packet (mouse, regs);
+			continue; /* More to parse? */
+		}
+
+		if (vsxxxaa_smells_like_packet (mouse, VSXXXAA_PACKET_ABS, 5)) {
+			/* Check for broken packet */
+			stray_bytes =3D vsxxxaa_check_packet (mouse, 5);
+			if (stray_bytes > 0) {
+				printk (KERN_ERR "Dropping %d bytes now...\n",
+						stray_bytes);
+				vsxxxaa_drop_bytes (mouse, stray_bytes);
+				continue;
+			}
+
+			vsxxxaa_handle_ABS_packet (mouse, regs);
+			continue; /* More to parse? */
+		}
+
+		if (vsxxxaa_smells_like_packet (mouse, VSXXXAA_PACKET_POR, 4)) {
+			/* Check for broken packet */
+			stray_bytes =3D vsxxxaa_check_packet (mouse, 4);
+			if (stray_bytes > 0) {
+				printk (KERN_ERR "Dropping %d bytes now...\n",
+						stray_bytes);
+				vsxxxaa_drop_bytes (mouse, stray_bytes);
+				continue;
+			}
+
+			vsxxxaa_handle_POR_packet (mouse, regs);
+			continue; /* More to parse? */
+		}
+
+		break; /* No REL, ABS or POR packet found */
+	} while (1);
+}
+
+static irqreturn_t
+vsxxxaa_interrupt (struct serio *serio, unsigned char data, unsigned int f=
lags,
+		struct pt_regs *regs)
+{
+	struct vsxxxaa *mouse =3D serio->private;
+
+	vsxxxaa_queue_byte (mouse, data);
+	vsxxxaa_parse_buffer (mouse, regs);
+
+	return IRQ_HANDLED;
+}
+
+static void
+vsxxxaa_disconnect (struct serio *serio)
+{
+	struct vsxxxaa *mouse =3D serio->private;
+
+	input_unregister_device (&mouse->dev);
+	serio_close (serio);
+	kfree (mouse);
+}
+
+static void
+vsxxxaa_connect (struct serio *serio, struct serio_dev *dev)
+{
+	struct vsxxxaa *mouse;
+
+	if ((serio->type & SERIO_TYPE) !=3D SERIO_RS232)
+		return;
+
+	if ((serio->type & SERIO_PROTO) !=3D SERIO_VSXXXAA)
+		return;
+
+	if (!(mouse =3D kmalloc (sizeof (struct vsxxxaa), GFP_KERNEL)))
+		return;
+
+	memset (mouse, 0, sizeof (struct vsxxxaa));
+
+	init_input_dev (&mouse->dev);
+	set_bit (EV_KEY, mouse->dev.evbit);		/* We have buttons */
+	set_bit (EV_REL, mouse->dev.evbit);		/* We can move */
+	set_bit (BTN_LEFT, mouse->dev.keybit);		/* We have 3 buttons */
+	set_bit (BTN_MIDDLE, mouse->dev.keybit);
+	set_bit (BTN_RIGHT, mouse->dev.keybit);
+	set_bit (BTN_EXTRA, mouse->dev.keybit);		/* ...and Tablet */
+	set_bit (REL_X, mouse->dev.relbit);		/* We can move in */
+	set_bit (REL_Y, mouse->dev.relbit);		/* two dimensions */
+	set_bit (ABS_X, mouse->dev.absbit);		/* DEC tablet support */
+	set_bit (ABS_Y, mouse->dev.absbit);
+
+	mouse->dev.absmin[ABS_X] =3D 0;
+	mouse->dev.absmax[ABS_X] =3D 1023;
+	mouse->dev.absmin[ABS_Y] =3D 0;
+	mouse->dev.absmax[ABS_Y] =3D 1023;
+
+	mouse->dev.private =3D mouse;
+	serio->private =3D mouse;
+
+	sprintf (mouse->phys, "%s/input0", serio->phys);
+	mouse->dev.phys =3D mouse->phys;
+	mouse->dev.name =3D "DEC VSXXX-AA/GA mouse or DEC tablet";
+	mouse->dev.id.bustype =3D BUS_RS232;
+	mouse->serio =3D serio;
+
+	if (serio_open (serio, dev)) {
+		kfree (mouse);
+		return;
+	}
+
+	/*
+	 * Request selftest and differential stream mode.
+	 */
+	mouse->serio->write (mouse->serio, 'T'); /* Test */
+	mouse->serio->write (mouse->serio, 'R'); /* Differential stream */
+
+	input_register_device (&mouse->dev);
+
+	printk (KERN_INFO "input: %s on %s\n", mouse->dev.name, serio->phys);
+}
+
+static struct serio_dev vsxxxaa_dev =3D {
+	.interrupt =3D	vsxxxaa_interrupt,
+	.connect =3D	vsxxxaa_connect,
+	.disconnect =3D	vsxxxaa_disconnect
+};
+
+int __init
+vsxxxaa_init (void)
+{
+	serio_register_device (&vsxxxaa_dev);
+	return 0;
+}
+
+void __exit
+vsxxxaa_exit (void)
+{
+	serio_unregister_device (&vsxxxaa_dev);
+}
+
+module_init (vsxxxaa_init);
+module_exit (vsxxxaa_exit);
+

--sgneBHv3152wZ8jf--

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPPN9Hb1edYOZ4bsRArjTAJ4/m2COtzrlR8++Q38AwxQ49h0s9gCggHP3
FuMvnGzjeUDfJUG849xp5VA=
=unrZ
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
