Received:  by oss.sgi.com id <S553762AbQLQSHC>;
	Sun, 17 Dec 2000 10:07:02 -0800
Received: from hermes.research.kpn.com ([139.63.192.8]:50949 "EHLO
        hermes.research.kpn.com") by oss.sgi.com with ESMTP
	id <S553757AbQLQSGf>; Sun, 17 Dec 2000 10:06:35 -0800
Received: from l04.research.kpn.com (l04.research.kpn.com [139.63.192.204])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01JXTL7SASYY00170B@research.kpn.com> for
 linux-mips@oss.sgi.com; Sun, 17 Dec 2000 19:06:32 +0100
Received: from kpn.com (aodi2.research.kpn.com [139.63.167.2])
 by l04.research.kpn.com with SMTP
 (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id Y9TYGPKK; Sun, 17 Dec 2000 19:06:25 +0100
Date:   Sun, 17 Dec 2000 19:06:18 +0100
From:   Karel van Houten <K.H.C.vanHouten@kpn.com>
Subject: Kernel patch to make DECStation serial devfs aware.
To:     MIPS Linux list <linux-mips@oss.sgi.com>,
        "MIPS Linux list (FNET)" <linux-mips@fnet.fr>
Message-id: <3A3D009A.CC605186@kpn.com>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.10 i686)
Content-type: multipart/mixed; boundary="------------B556931F0E1CCED6BE2E1F56"
X-Accept-Language: en
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------B556931F0E1CCED6BE2E1F56
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all,

I've attached a small patch to the DECStation serial drivers (zs.c and
dz.c)
in order to make them devfs aware. 

Would you please test this patch, and report any resulting problems?

-- 
Karel van Houten
----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer.
--------------B556931F0E1CCED6BE2E1F56
Content-Type: text/plain; charset=us-ascii;
 name="dec-devfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dec-devfs.patch"

--- drivers/tc/zs.c.orig	Sun Dec 17 15:59:21 2000
+++ drivers/tc/zs.c	Sun Dec 17 12:30:07 2000
@@ -18,6 +18,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/version.h>
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -1720,7 +1721,11 @@
 
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
+#if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
+	serial_driver.name = "tts/%d";
+#else
 	serial_driver.name = "ttyS";
+#endif
 	serial_driver.major = TTY_MAJOR;
 	serial_driver.minor_start = 64;
 	serial_driver.num = zs_channels_found;
@@ -1730,7 +1735,7 @@
 
 	serial_driver.init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
-	serial_driver.flags = TTY_DRIVER_REAL_RAW;
+	serial_driver.flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
 	serial_driver.refcount = &serial_refcount;
 	serial_driver.table = serial_table;
 	serial_driver.termios = serial_termios;
@@ -1758,7 +1763,11 @@
 	 * major number and the subtype code.
 	 */
 	callout_driver = serial_driver;
+#if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
+	callout_driver.name = "cua/%d";
+#else
 	callout_driver.name = "cua";
+#endif
 	callout_driver.major = TTYAUX_MAJOR;
 	callout_driver.subtype = SERIAL_TYPE_CALLOUT;
 
@@ -1820,6 +1829,11 @@
 		printk("ttyS%02d at 0x%08x (irq = %d)", info->line, 
 		       info->port, info->irq);
 		printk(" is a Z85C30 SCC\n");
+		tty_register_devfs(&serial_driver, 0,
+				   serial_driver.minor_start + info->line);
+		tty_register_devfs(&callout_driver, 0,
+				   callout_driver.minor_start + info->line);
+
 	}
 
 	restore_flags(flags);
--- drivers/char/dz.c.orig	Sun Dec 17 15:59:36 2000
+++ drivers/char/dz.c	Sun Dec 17 16:59:57 2000
@@ -21,9 +21,9 @@
 
 #define DEBUG_DZ 1
 
+#include <linux/version.h>
 #ifdef MODULE
 #include <linux/module.h>
-#include <linux/version.h>
 #else
 #define MOD_INC_USE_COUNT
 #define MOD_DEC_USE_COUNT
@@ -1290,7 +1290,7 @@
 
 int __init dz_init(void)
 {
-  int i, flags;
+  int i, flags, tmp;
   struct dz_serial *info;
 
   /* Setup base handler, and timer table. */
@@ -1300,7 +1300,11 @@
 
   memset(&serial_driver, 0, sizeof(struct tty_driver));
   serial_driver.magic = TTY_DRIVER_MAGIC;
+#if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
   serial_driver.name = "ttyS";
+#else
+  serial_driver.name = "tts/%d";
+#endif
   serial_driver.major = TTY_MAJOR;
   serial_driver.minor_start = 64;
   serial_driver.num = DZ_NB_PORT;
@@ -1309,7 +1313,7 @@
   serial_driver.init_termios = tty_std_termios;
 
   serial_driver.init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
-  serial_driver.flags = TTY_DRIVER_REAL_RAW;
+  serial_driver.flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
   serial_driver.refcount = &serial_refcount;
   serial_driver.table = serial_table;
   serial_driver.termios = serial_termios;
@@ -1336,7 +1340,11 @@
    * major number and the subtype code.
    */
   callout_driver = serial_driver;
+#if (LINUX_VERSION_CODE > 0x2032D && defined(CONFIG_DEVFS_FS))
   callout_driver.name = "cua";
+#else
+  callout_driver.name = "cua/%d";
+#endif
   callout_driver.major = TTYAUX_MAJOR;
   callout_driver.subtype = SERIAL_TYPE_CALLOUT;
 
@@ -1380,6 +1388,11 @@
       return 0;
 
     printk("ttyS%02d at 0x%08x (irq = %d)\n", info->line, info->port, SERIAL);
+
+    tty_register_devfs(&serial_driver, 0,
+			serial_driver.minor_start + info->line);
+    tty_register_devfs(&callout_driver, 0,
+			callout_driver.minor_start + info->line);
   }
 
   /* reset the chip */

--------------B556931F0E1CCED6BE2E1F56--
