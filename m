Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2006 20:55:15 +0200 (CEST)
Received: from sorrow.cyrius.com ([65.19.161.204]:59916 "HELO
	sorrow.cyrius.com") by ftp.linux-mips.org with SMTP
	id S8133657AbWEKSzE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 May 2006 20:55:04 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 53B9A64D55; Thu, 11 May 2006 18:54:56 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 1FD3F66F5B; Thu, 11 May 2006 20:54:46 +0200 (CEST)
Date:	Thu, 11 May 2006 20:54:46 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Karel van Houten <Karel@vhouten.xs4all.nl>,
	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: 2.6 for DECstation, d-i
Message-ID: <20060511185446.GB7234@deprecation.cyrius.com>
References: <44635C0D.7040901@vhouten.xs4all.nl> <20060511173350.GM7827@deprecation.cyrius.com> <Pine.LNX.4.64N.0605111853500.20004@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0605111853500.20004@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Maciej W. Rozycki <macro@linux-mips.org> [2006-05-11 19:14]:
> > Zilog Z8530 support for DECstation hasn't been ported to 2.6 yet.
> 
>  Well, not exactly ported, but hacked up enough it worked the last time I 
> tried, but you have to disable the virtual terminal (CONFIG_VT) as it is 

Yeah, but the problem is that ZS is not a config option anymore.  I
hacked up something to see if the driver works but I guess there's a
nicer solution.


--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -51,6 +51,8 @@ obj-$(CONFIG_VIOCONS)		+= viocons.o
 obj-$(CONFIG_VIOTAPE)		+= viotape.o
 obj-$(CONFIG_HVCS)		+= hvcs.o
 obj-$(CONFIG_SGI_MBCS)		+= mbcs.o
+obj-$(CONFIG_SERIAL_DZ)		+= decserial.o
+obj-$(CONFIG_SERIAL_ZS)		+= decserial.o
 
 obj-$(CONFIG_PRINTER)		+= lp.o
 obj-$(CONFIG_TIPAR)		+= tipar.o
diff --git a/drivers/char/decserial.c b/drivers/char/decserial.c
index aa14409..9a320c3 100644
--- a/drivers/char/decserial.c
+++ b/drivers/char/decserial.c
@@ -28,7 +28,7 @@ extern int zs_init(void);
 extern int dz_init(void);
 #endif
 
-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
 
 #ifdef CONFIG_ZS
 extern void zs_serial_console_init(void);
@@ -43,7 +43,7 @@ extern void dz_serial_console_init(void)
 /* rs_init - starts up the serial interface -
    handle normal case of starting up the serial interface */
 
-#ifdef CONFIG_SERIAL
+#ifdef CONFIG_SERIAL_CORE
 
 int __init rs_init(void)
 {
@@ -70,7 +70,7 @@ __initcall(rs_init);
 
 #endif
 
-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
 
 /* serial_console_init handles the special case of starting
  *   up the console on the serial port
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 7d22dc0..b16b99f 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -398,6 +398,27 @@ config SERIAL_DZ_CONSOLE
 
 	  If unsure, say Y.
 
+config SERIAL_ZS
+	bool "DECstation Zilog Z8530 support"
+	depends on MACH_DECSTATION && TC
+	select SERIAL_CORE
+	help
+	  Zilog Z8530 serial controllers on DECstation machines using the
+	  TurboChannel bus.
+
+config SERIAL_ZS_CONSOLE
+	bool "Support console on DECstation Zilog Z8530"
+	depends on SERIAL_ZS=y
+	select SERIAL_CORE_CONSOLE
+	help
+	  If you say Y here, it will be possible to use a serial port as the
+	  system console (the system console is the device which receives all
+	  kernel messages and warnings and which allows logins in single user
+	  mode).  Note that the firmware uses ttyS0 as the serial console on
+	  the Maxine and ttyS2 on the others.
+
+	  If unsure, say Y.
+
 config SERIAL_21285
 	tristate "DC21285 serial port support"
 	depends on ARM && FOOTBRIDGE
diff --git a/drivers/serial/ip22zilog.c b/drivers/serial/ip22zilog.c
diff --git a/drivers/tc/Makefile b/drivers/tc/Makefile
index 83b5bd7..885d82f 100644
--- a/drivers/tc/Makefile
+++ b/drivers/tc/Makefile
@@ -5,7 +5,7 @@
 # Object file lists.
 
 obj-$(CONFIG_TC) += tc.o
-obj-$(CONFIG_ZS) += zs.o
+obj-$(CONFIG_SERIAL_ZS) += zs.o
 obj-$(CONFIG_VT) += lk201.o lk201-map.o lk201-remap.o
 
 $(obj)/lk201-map.o: $(obj)/lk201-map.c
diff --git a/drivers/tc/zs.c b/drivers/tc/zs.c
index 2dffa8e..960f552 100644
--- a/drivers/tc/zs.c
+++ b/drivers/tc/zs.c
@@ -56,7 +56,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/spinlock.h>
-#ifdef CONFIG_SERIAL_DEC_CONSOLE
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
 #include <linux/console.h>
 #endif
 
@@ -137,10 +137,10 @@ struct dec_serial *zs_chain;	/* list of 
 
 struct tty_struct zs_ttys[NUM_CHANNELS];
 
-#ifdef CONFIG_SERIAL_DEC_CONSOLE
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
 static struct console sercons;
 #endif
-#if defined(CONFIG_SERIAL_DEC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && \
+#if defined(CONFIG_SERIAL_CORE_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && \
    !defined(MODULE)
 static unsigned long break_pressed; /* break, really ... */
 #endif
@@ -383,7 +383,7 @@ static void receive_chars(struct dec_ser
 				write_zsreg(info->zs_channel, R0, ERR_RES);
 		}
 
-#if defined(CONFIG_SERIAL_DEC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && \
+#if defined(CONFIG_SERIAL_CORE_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && \
    !defined(MODULE)
 		if (break_pressed && info->line == sercons.index) {
 			/* Ignore the null char got when BREAK is removed.  */
@@ -446,7 +446,7 @@ static void status_handle(struct dec_ser
 	stat = read_zsreg(info->zs_channel, R0);
 
 	if ((stat & BRK_ABRT) && !(info->read_reg_zero & BRK_ABRT)) {
-#if defined(CONFIG_SERIAL_DEC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && \
+#if defined(CONFIG_SERIAL_CORE_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ) && \
    !defined(MODULE)
 		if (info->line == sercons.index) {
 			if (!break_pressed)
@@ -1560,7 +1560,7 @@ static int rs_open(struct tty_struct *tt
 		return retval;
 	}
 
-#ifdef CONFIG_SERIAL_DEC_CONSOLE
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
 	if (sercons.cflag && sercons.index == line) {
 		tty->termios->c_cflag = sercons.cflag;
 		sercons.cflag = 0;
@@ -1643,7 +1643,7 @@ static void __init probe_sccs(void)
 			zs_channels[n_channels].data =
 				zs_channels[n_channels].control + 4;
 
-#ifndef CONFIG_SERIAL_DEC_CONSOLE
+#ifndef CONFIG_SERIAL_CORE_CONSOLE
 			/*
 			 * We're called early and memory managment isn't up, yet.
 			 * Thus request_region would fail.
@@ -1894,7 +1894,7 @@ int unregister_zs_hook(unsigned int chan
  * Serial console driver
  * ------------------------------------------------------------
  */
-#ifdef CONFIG_SERIAL_DEC_CONSOLE
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
 
 
 /*
@@ -2090,7 +2090,7 @@ void __init zs_serial_console_init(void)
 {
 	register_console(&sercons);
 }
-#endif /* ifdef CONFIG_SERIAL_DEC_CONSOLE */
+#endif /* ifdef CONFIG_SERIAL_CORE_CONSOLE */
 
 #ifdef CONFIG_KGDB
 struct dec_zschannel *zs_kgdbchan;

-- 
Martin Michlmayr
http://www.cyrius.com/
