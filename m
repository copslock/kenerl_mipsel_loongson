Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GIfuX17719
	for linux-mips-outgoing; Mon, 16 Jul 2001 11:41:56 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GIfpV17716
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 11:41:52 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA20939;
	Mon, 16 Jul 2001 20:43:23 +0200 (MET DST)
Date: Mon, 16 Jul 2001 20:43:23 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Harald Koerfgen <hkoerfg@web.de>, Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] 2.4.5: DECstation LK201 keyboard non-functional
Message-ID: <Pine.GSO.3.96.1010716195815.12988F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 Since 2.4.5 there is a problem with the LK201 driver.  The driver gets
never registered.  It happens because chr_dev_init() got converted to
__initcall() and is no longer invoked before rs_init() for the DECstation
(chr_dev_init() calls tty_init() which registers the LK201 hook via
kbd_init()).

 The following patch fixes the problem.  It makes the DECstation's object
file that provides rs_init() be included in the DRIVERS list as SERIAL. 
It is on the CORE_FILES list of Makefile targets now.  The patch looks
bigger than it really is -- apart from trivial Makefile changes, it's
merely an arch/mips/dec/serial.c to drivers/char/decserial.c rename.

 Note while putting a file away from an arch-specific tree into a generic
driver one might seem a bad move, it really is the right thing in this
case.  The point is the decserial.c device is not arch-specific at all,
i.e. no more than the 8250 serial.c device is.  DEC used the devices in a
number of their systems, including DECstations (onboard SCC and DZ11 and
TURBOchannel PMAC-A DZ11 devices), DEC 3000 Alpha systems (onboard SCC and
PMAC-A devices) and VAXstations (onboard DZ11 and PMAC-A devices).  Thus I
believe they should be treated as generic devices, especially as the VAX
and the DEC 3000 Alpha (to some extent) Linux ports are underway.

 Please apply the patch.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.5-20010704-decserial-0
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/arch/mips/dec/Makefile linux-mips-2.4.5-20010704/arch/mips/dec/Makefile
--- linux-mips-2.4.5-20010704.macro/arch/mips/dec/Makefile	Sat Jan 13 05:26:23 2001
+++ linux-mips-2.4.5-20010704/arch/mips/dec/Makefile	Mon Jul 16 01:05:06 2001
@@ -19,7 +19,6 @@ export-objs := wbflush.o
 obj-y	 := int-handler.o setup.o irq.o time.o reset.o rtc-dec.o wbflush.o
 
 obj-$(CONFIG_PROM_CONSOLE)	+= promcon.o
-obj-$(CONFIG_SERIAL)		+= serial.o
 
 int-handler.o:	int-handler.S
 
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/arch/mips/dec/serial.c linux-mips-2.4.5-20010704/arch/mips/dec/serial.c
--- linux-mips-2.4.5-20010704.macro/arch/mips/dec/serial.c	Wed Mar 29 04:27:14 2000
+++ linux-mips-2.4.5-20010704/arch/mips/dec/serial.c	Thu Jan  1 00:00:00 1970
@@ -1,98 +0,0 @@
-/*
- * sercons.c
- *      choose the right serial device at boot time
- *
- * triemer 6-SEP-1998
- *      sercons.c is designed to allow the three different kinds 
- *      of serial devices under the decstation world to co-exist
- *      in the same kernel.  The idea here is to abstract 
- *      the pieces of the drivers that are common to this file
- *      so that they do not clash at compile time and runtime.
- *
- * HK 16-SEP-1998 v0.002
- *      removed the PROM console as this is not a real serial
- *      device. Added support for PROM console in drivers/char/tty_io.c
- *      instead. Although it may work to enable more than one 
- *      console device I strongly recommend to use only one.
- */
-
-#include <linux/config.h>
-#include <linux/init.h>
-#include <asm/dec/machtype.h>
-
-#ifdef CONFIG_ZS
-extern int zs_init(void);
-#endif
-
-#ifdef CONFIG_DZ
-extern int dz_init(void);
-#endif
-
-#ifdef CONFIG_SERIAL_CONSOLE
-
-#ifdef CONFIG_ZS
-extern void zs_serial_console_init(void);
-#endif
-
-#ifdef CONFIG_DZ
-extern void dz_serial_console_init(void);
-#endif
-
-#endif
-
-/* rs_init - starts up the serial interface -
-   handle normal case of starting up the serial interface */
-
-#ifdef CONFIG_SERIAL
-
-int __init rs_init(void)
-{
-
-#if defined(CONFIG_ZS) && defined(CONFIG_DZ)
-    if (IOASIC)
-	return zs_init();
-    else
-	return dz_init();
-#else
-
-#ifdef CONFIG_ZS
-    return zs_init();
-#endif
-
-#ifdef CONFIG_DZ
-    return dz_init();
-#endif
-
-#endif
-}
-
-__initcall(rs_init);
-
-#endif
-
-#ifdef CONFIG_SERIAL_CONSOLE
-
-/* serial_console_init handles the special case of starting
- *   up the console on the serial port
- */
-void __init serial_console_init(void)
-{
-#if defined(CONFIG_ZS) && defined(CONFIG_DZ)
-    if (IOASIC)
-	zs_serial_console_init();
-    else
-	dz_serial_console_init();
-#else
-
-#ifdef CONFIG_ZS
-    zs_serial_console_init();
-#endif
-
-#ifdef CONFIG_DZ
-    dz_serial_console_init();
-#endif
-
-#endif
-}
-
-#endif
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/drivers/char/Makefile linux-mips-2.4.5-20010704/drivers/char/Makefile
--- linux-mips-2.4.5-20010704.macro/drivers/char/Makefile	Thu Jun 14 04:26:44 2001
+++ linux-mips-2.4.5-20010704/drivers/char/Makefile	Mon Jul 16 01:04:12 2001
@@ -103,7 +103,7 @@ endif
 ifeq ($(CONFIG_DECSTATION),y)
   KEYMAP   =
   KEYBD    =
-  SERIAL   =
+  SERIAL   = decserial.o
 endif
 
 ifeq ($(CONFIG_BAGET_MIPS),y)
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/drivers/char/decserial.c linux-mips-2.4.5-20010704/drivers/char/decserial.c
--- linux-mips-2.4.5-20010704.macro/drivers/char/decserial.c	Thu Jan  1 00:00:00 1970
+++ linux-mips-2.4.5-20010704/drivers/char/decserial.c	Wed Mar 29 04:27:14 2000
@@ -0,0 +1,98 @@
+/*
+ * sercons.c
+ *      choose the right serial device at boot time
+ *
+ * triemer 6-SEP-1998
+ *      sercons.c is designed to allow the three different kinds 
+ *      of serial devices under the decstation world to co-exist
+ *      in the same kernel.  The idea here is to abstract 
+ *      the pieces of the drivers that are common to this file
+ *      so that they do not clash at compile time and runtime.
+ *
+ * HK 16-SEP-1998 v0.002
+ *      removed the PROM console as this is not a real serial
+ *      device. Added support for PROM console in drivers/char/tty_io.c
+ *      instead. Although it may work to enable more than one 
+ *      console device I strongly recommend to use only one.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <asm/dec/machtype.h>
+
+#ifdef CONFIG_ZS
+extern int zs_init(void);
+#endif
+
+#ifdef CONFIG_DZ
+extern int dz_init(void);
+#endif
+
+#ifdef CONFIG_SERIAL_CONSOLE
+
+#ifdef CONFIG_ZS
+extern void zs_serial_console_init(void);
+#endif
+
+#ifdef CONFIG_DZ
+extern void dz_serial_console_init(void);
+#endif
+
+#endif
+
+/* rs_init - starts up the serial interface -
+   handle normal case of starting up the serial interface */
+
+#ifdef CONFIG_SERIAL
+
+int __init rs_init(void)
+{
+
+#if defined(CONFIG_ZS) && defined(CONFIG_DZ)
+    if (IOASIC)
+	return zs_init();
+    else
+	return dz_init();
+#else
+
+#ifdef CONFIG_ZS
+    return zs_init();
+#endif
+
+#ifdef CONFIG_DZ
+    return dz_init();
+#endif
+
+#endif
+}
+
+__initcall(rs_init);
+
+#endif
+
+#ifdef CONFIG_SERIAL_CONSOLE
+
+/* serial_console_init handles the special case of starting
+ *   up the console on the serial port
+ */
+void __init serial_console_init(void)
+{
+#if defined(CONFIG_ZS) && defined(CONFIG_DZ)
+    if (IOASIC)
+	zs_serial_console_init();
+    else
+	dz_serial_console_init();
+#else
+
+#ifdef CONFIG_ZS
+    zs_serial_console_init();
+#endif
+
+#ifdef CONFIG_DZ
+    dz_serial_console_init();
+#endif
+
+#endif
+}
+
+#endif
