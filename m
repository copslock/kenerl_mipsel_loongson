Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2002 20:26:10 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:51894 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1121743AbSKGT0J>; Thu, 7 Nov 2002 20:26:09 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA15700;
	Thu, 7 Nov 2002 20:26:20 +0100 (MET)
Date: Thu, 7 Nov 2002 20:26:19 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>,
	Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
Subject: Re: make xmenuconfig is broken
In-Reply-To: <Pine.GSO.3.96.1021030135048.1859E-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.3.96.1021107201241.5894L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 30 Oct 2002, Maciej W. Rozycki wrote:

> On Tue, 29 Oct 2002, Jun Sun wrote:
> 
> > My limited xconfig knowledge seems to tell me that moving to the generic
> > config file is the only way to make it work.  If you know a better way to fix
> > this, I will be happy to see it.
[...]
>  The problem is CONFIG_SERIAL having different meanings for the MIPS port. 
> It causes annoyance with dynamic parsers (like `make config') and I'm not
> surprised it breaks the xconfig static parser. 

 I renamed the guilty options and also I decided moving DECstation serial
port configuration to drivers/char is the way to go.  As a side effect you
now may build both the dz11/z8530 drivers and the i8250 one (as an advance
towards a generic kernel).

 Here is a patch for 2.4.  Does it fix things for you?  And is it
acceptable for the others?  Specifically, I mean putting the questions
under CONFIG_SERIAL_NONSTANDARD (the name is unfortunate, but that's
heritage from the old days and is going to vainsh in 2.6 anyway). 

 If no objections arise, I'll check the patch in soon, probably tomorrow.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.20-pre6-20021017-dec-serial-1
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021017.macro/Documentation/Configure.help linux-mips-2.4.20-pre6-20021017/Documentation/Configure.help
--- linux-mips-2.4.20-pre6-20021017.macro/Documentation/Configure.help	2002-10-03 02:56:16.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021017/Documentation/Configure.help	2002-11-05 21:01:48.000000000 +0000
@@ -2148,6 +2148,27 @@ SGI PROM Console Support
 CONFIG_SGI_PROM_CONSOLE
   Say Y here to set up the boot console on serial port 0.
 
+DECstation serial support
+CONFIG_SERIAL_DEC
+  This selects whether you want to be asked about drivers for
+  DECstation serial ports.
+
+  Note that the answer to this question won't directly affect the
+  kernel: saying N will just cause the configurator to skip all
+  the questions about DECstation serial ports.
+
+  If unsure, say Y.
+
+Support for console on a DECstation serial port
+CONFIG_SERIAL_DEC_CONSOLE
+  If you say Y here, it will be possible to use a serial port as the
+  system console (the system console is the device which receives all
+  kernel messages and warnings and which allows logins in single user
+  mode).  Note that the firmware uses ttyS0 as the serial console on
+  the Maxine and ttyS2 on the others.
+
+  If unsure, say Y.
+
 DZ11 Serial Support
 CONFIG_DZ
   DZ11-family serial controllers for VAXstations, including the
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021017.macro/arch/mips/config-shared.in linux-mips-2.4.20-pre6-20021017/arch/mips/config-shared.in
--- linux-mips-2.4.20-pre6-20021017.macro/arch/mips/config-shared.in	2002-10-07 02:56:25.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021017/arch/mips/config-shared.in	2002-10-30 23:31:32.000000000 +0000
@@ -764,19 +764,6 @@ source drivers/char/Config.in
 
 #source drivers/misc/Config.in
 
-if [ "$CONFIG_DECSTATION" = "y" ]; then
-   mainmenu_option next_comment
-   comment 'DECStation Character devices'
-
-   tristate 'Standard/generic (dumb) serial support' CONFIG_SERIAL
-   dep_bool '  DZ11 Serial Support' CONFIG_DZ $CONFIG_SERIAL
-   dep_bool '  Z85C30 Serial Support' CONFIG_ZS $CONFIG_SERIAL $CONFIG_TC
-   dep_bool '  Support for console on serial port' CONFIG_SERIAL_CONSOLE $CONFIG_SERIAL
-#   dep_bool 'MAXINE Access.Bus mouse (VSXXX-BB/GB) support' CONFIG_DTOP_MOUSE $CONFIG_ACCESSBUS
-   bool 'Enhanced Real Time Clock Support' CONFIG_RTC
-   endmenu
-fi
-
 if [ "$CONFIG_SGI_IP22" = "y" ]; then
    mainmenu_option next_comment
    comment 'SGI Character devices'
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021017.macro/drivers/char/Config.in linux-mips-2.4.20-pre6-20021017/drivers/char/Config.in
--- linux-mips-2.4.20-pre6-20021017.macro/drivers/char/Config.in	2002-10-08 02:56:56.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021017/drivers/char/Config.in	2002-11-05 20:54:55.000000000 +0000
@@ -104,7 +104,14 @@ if [ "$CONFIG_SERIAL_NONSTANDARD" = "y" 
          fi
       fi
    fi
+   if [ "$CONFIG_DECSTATION" = "y" ]; then
+      bool '  DECstation serial support' CONFIG_SERIAL_DEC
+      dep_bool '    Support for console on a DECstation serial port' CONFIG_SERIAL_DEC_CONSOLE $CONFIG_SERIAL_DEC
+      dep_bool '    DZ11 serial support' CONFIG_DZ $CONFIG_SERIAL_DEC
+      dep_bool '    Z85C30 serial support' CONFIG_ZS $CONFIG_SERIAL_DEC $CONFIG_TC
+   fi
 fi
+
 if [ "$CONFIG_EXPERIMENTAL" = "y" -a "$CONFIG_ZORRO" = "y" ]; then
    tristate 'Commodore A2232 serial support (EXPERIMENTAL)' CONFIG_A2232
 fi
@@ -161,6 +168,9 @@ if [ "$CONFIG_BUSMOUSE" != "n" ]; then
    if [ "$CONFIG_ADB" = "y" -a "$CONFIG_ADB_KEYBOARD" = "y" ]; then
       dep_tristate '  Apple Desktop Bus mouse support (old driver)' CONFIG_ADBMOUSE $CONFIG_BUSMOUSE
    fi
+#   if [ "$CONFIG_DECSTATION" = "y" ]; then
+#      dep_bool '  MAXINE Access.Bus mouse (VSXXX-BB/GB) support' CONFIG_DTOP_MOUSE $CONFIG_ACCESSBUS
+#   fi
 fi
 
 tristate 'Mouse Support (not serial and bus mice)' CONFIG_MOUSE
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021017.macro/drivers/char/Makefile linux-mips-2.4.20-pre6-20021017/drivers/char/Makefile
--- linux-mips-2.4.20-pre6-20021017.macro/drivers/char/Makefile	2002-09-12 03:09:53.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021017/drivers/char/Makefile	2002-11-05 20:37:50.000000000 +0000
@@ -126,7 +126,6 @@ endif
 ifeq ($(CONFIG_DECSTATION),y)
   KEYMAP   =
   KEYBD    =
-  SERIAL   = decserial.o
 endif
 
 ifeq ($(CONFIG_BAGET_MIPS),y)
@@ -158,6 +157,7 @@ obj-$(CONFIG_SERIAL_21285) += serial_212
 obj-$(CONFIG_SERIAL_SA1100) += serial_sa1100.o
 obj-$(CONFIG_SERIAL_AMBA) += serial_amba.o
 obj-$(CONFIG_TS_AU1000_ADS7846) += au1000_ts.o
+obj-$(CONFIG_SERIAL_DEC) += decserial.o
 
 ifndef CONFIG_SUN_KEYBOARD
   obj-$(CONFIG_VT) += keyboard.o $(KEYMAP) $(KEYBD)
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021017.macro/drivers/char/decserial.c linux-mips-2.4.20-pre6-20021017/drivers/char/decserial.c
--- linux-mips-2.4.20-pre6-20021017.macro/drivers/char/decserial.c	2001-07-17 19:49:00.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021017/drivers/char/decserial.c	2002-11-05 20:31:26.000000000 +0000
@@ -28,7 +28,7 @@ extern int zs_init(void);
 extern int dz_init(void);
 #endif
 
-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_DEC_CONSOLE
 
 #ifdef CONFIG_ZS
 extern void zs_serial_console_init(void);
@@ -43,7 +43,7 @@ extern void dz_serial_console_init(void)
 /* rs_init - starts up the serial interface -
    handle normal case of starting up the serial interface */
 
-#ifdef CONFIG_SERIAL
+#ifdef CONFIG_SERIAL_DEC
 
 int __init rs_init(void)
 {
@@ -70,12 +70,12 @@ __initcall(rs_init);
 
 #endif
 
-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_DEC_CONSOLE
 
-/* serial_console_init handles the special case of starting
+/* dec_serial_console_init handles the special case of starting
  *   up the console on the serial port
  */
-void __init serial_console_init(void)
+void __init dec_serial_console_init(void)
 {
 #if defined(CONFIG_ZS) && defined(CONFIG_DZ)
     if (IOASIC)
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021017.macro/drivers/char/dz.c linux-mips-2.4.20-pre6-20021017/drivers/char/dz.c
--- linux-mips-2.4.20-pre6-20021017.macro/drivers/char/dz.c	2002-10-02 02:56:52.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021017/drivers/char/dz.c	2002-11-05 20:32:23.000000000 +0000
@@ -1411,7 +1411,7 @@ int __init dz_init(void)
 	}
 
 	/* reset the chip */
-#ifndef CONFIG_SERIAL_CONSOLE
+#ifndef CONFIG_SERIAL_DEC_CONSOLE
 	dz_out(info, DZ_CSR, DZ_CLR);
 	while ((tmp = dz_in(info, DZ_CSR)) & DZ_CLR);
 	iob();
@@ -1433,7 +1433,7 @@ int __init dz_init(void)
 	return 0;
 }
 
-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_DEC_CONSOLE
 static void dz_console_put_char(unsigned char ch)
 {
 	unsigned long flags;
@@ -1587,6 +1587,6 @@ void __init dz_serial_console_init(void)
 	register_console(&dz_sercons);
 }
 
-#endif /* CONFIG_SERIAL_CONSOLE */
+#endif /* CONFIG_SERIAL_DEC_CONSOLE */
 
 MODULE_LICENSE("GPL");
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021017.macro/drivers/char/tty_io.c linux-mips-2.4.20-pre6-20021017/drivers/char/tty_io.c
--- linux-mips-2.4.20-pre6-20021017.macro/drivers/char/tty_io.c	2002-09-16 02:58:19.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021017/drivers/char/tty_io.c	2002-11-05 20:30:00.000000000 +0000
@@ -2240,6 +2240,9 @@ void __init console_init(void)
 	sci_console_init();
 #endif
 #endif
+#ifdef CONFIG_SERIAL_DEC_CONSOLE
+	dec_serial_console_init();
+#endif
 #ifdef CONFIG_TN3270_CONSOLE
 	tub3270_con_init();
 #endif
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20021017.macro/drivers/tc/zs.c linux-mips-2.4.20-pre6-20021017/drivers/tc/zs.c
--- linux-mips-2.4.20-pre6-20021017.macro/drivers/tc/zs.c	2002-08-06 02:58:08.000000000 +0000
+++ linux-mips-2.4.20-pre6-20021017/drivers/tc/zs.c	2002-11-05 20:39:27.000000000 +0000
@@ -56,7 +56,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_DEC_CONSOLE
 #include <linux/console.h>
 #endif
 
@@ -157,10 +157,10 @@ struct dec_serial *zs_chain;	/* list of 
 
 struct tty_struct zs_ttys[NUM_CHANNELS];
 
-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_DEC_CONSOLE
 static struct console sercons;
 #endif
-#if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) \
+#if defined(CONFIG_SERIAL_DEC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) \
     && !defined(MODULE)
 static unsigned long break_pressed; /* break, really ... */
 #endif
@@ -416,7 +416,7 @@ static _INLINE_ void receive_chars(struc
 
 		if (tty_break) {
 			tty_break = 0;
-#if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && !defined(MODULE)
+#if defined(CONFIG_SERIAL_DEC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && !defined(MODULE)
 			if (info->line == sercons.index) {
 				if (!break_pressed) {
 					break_pressed = jiffies;
@@ -442,7 +442,7 @@ static _INLINE_ void receive_chars(struc
 				write_zsreg(info->zs_channel, R0, ERR_RES);
 		}
 
-#if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && !defined(MODULE)
+#if defined(CONFIG_SERIAL_DEC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && !defined(MODULE)
 		if (break_pressed && info->line == sercons.index) {
 			if (ch != 0 &&
 			    time_before(jiffies, break_pressed + HZ*5)) {
@@ -473,7 +473,7 @@ static _INLINE_ void receive_chars(struc
 
 		*tty->flip.flag_buf_ptr++ = flag;
 		*tty->flip.char_buf_ptr++ = ch;
-#if defined(CONFIG_SERIAL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && !defined(MODULE)
+#if defined(CONFIG_SERIAL_DEC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && !defined(MODULE)
 	ignore_char:
 #endif
 	}
@@ -1701,7 +1701,7 @@ int rs_open(struct tty_struct *tty, stru
 			*tty->termios = info->callout_termios;
 		change_speed(info);
 	}
-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_DEC_CONSOLE
 	if (sercons.cflag && sercons.index == line) {
 		tty->termios->c_cflag = sercons.cflag;
 		sercons.cflag = 0;
@@ -1801,7 +1801,7 @@ static void __init probe_sccs(void)
 			zs_channels[n_channels].data =
 				zs_channels[n_channels].control + 4;
 
-#ifndef CONFIG_SERIAL_CONSOLE
+#ifndef CONFIG_SERIAL_DEC_CONSOLE
 			/*
 			 * We're called early and memory managment isn't up, yet.
 			 * Thus check_region would fail.
@@ -2111,7 +2111,7 @@ unsigned int unregister_zs_hook(unsigned
  * Serial console driver
  * ------------------------------------------------------------
  */
-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_DEC_CONSOLE
 
 
 /*
@@ -2279,7 +2279,7 @@ void __init zs_serial_console_init(void)
 {
 	register_console(&sercons);
 }
-#endif /* ifdef CONFIG_SERIAL_CONSOLE */
+#endif /* ifdef CONFIG_SERIAL_DEC_CONSOLE */
 
 #ifdef CONFIG_KGDB
 struct dec_zschannel *zs_kgdbchan;
