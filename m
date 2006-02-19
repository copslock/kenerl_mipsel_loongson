Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2006 23:51:08 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:43533 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133725AbWBSXu7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Feb 2006 23:50:59 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 0BAE964D3D; Sun, 19 Feb 2006 23:57:52 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id EFD0D8D5D; Sun, 19 Feb 2006 23:57:44 +0000 (GMT)
Date:	Sun, 19 Feb 2006 23:57:44 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: char/decserial.c changes
Message-ID: <20060219235744.GA17052@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Maciej,

The following change is in the linux-mips but not the mainline tree.
Can you please review it and send it upstream if you haven't done so
yet.  Thanks


--- linux-2.6.16-rc4/drivers/char/decserial.c	2006-02-19 20:08:39.000000000 +0000
+++ mips-2.6.16-rc4/drivers/char/decserial.c	2006-02-19 20:15:04.000000000 +0000
@@ -14,87 +14,85 @@
  *      device. Added support for PROM console in drivers/char/tty_io.c
  *      instead. Although it may work to enable more than one 
  *      console device I strongly recommend to use only one.
+ *
+ *	Copyright (C) 2004  Maciej W. Rozycki
  */
 
 #include <linux/config.h>
+#include <linux/errno.h>
 #include <linux/init.h>
-#include <asm/dec/machtype.h>
-
-#ifdef CONFIG_ZS
-extern int zs_init(void);
-#endif
 
-#ifdef CONFIG_DZ
-extern int dz_init(void);
-#endif
+#include <asm/dec/machtype.h>
+#include <asm/dec/serial.h>
 
-#ifdef CONFIG_SERIAL_CONSOLE
+extern int register_zs_hook(unsigned int channel,
+			    struct dec_serial_hook *hook);
+extern int unregister_zs_hook(unsigned int channel);
 
+int register_dec_serial_hook(unsigned int channel,
+			     struct dec_serial_hook *hook)
+{
 #ifdef CONFIG_ZS
-extern void zs_serial_console_init(void);
-#endif
-
-#ifdef CONFIG_DZ
-extern void dz_serial_console_init(void);
+	if (IOASIC)
+		return register_zs_hook(channel, hook);
 #endif
+	return 0;
+}
 
+int unregister_dec_serial_hook(unsigned int channel)
+{
+#ifdef CONFIG_ZS
+	if (IOASIC)
+		return unregister_zs_hook(channel);
 #endif
+	return 0;
+}
 
-/* rs_init - starts up the serial interface -
-   handle normal case of starting up the serial interface */
 
-#ifdef CONFIG_SERIAL
+extern int zs_init(void);
+extern int dz_init(void);
 
+/*
+ * rs_init - starts up the serial interface -
+ * handle normal case of starting up the serial interface
+ */
 int __init rs_init(void)
 {
-
-#if defined(CONFIG_ZS) && defined(CONFIG_DZ)
-    if (IOASIC)
-	return zs_init();
-    else
-	return dz_init();
-#else
-
 #ifdef CONFIG_ZS
-    return zs_init();
+	if (IOASIC)
+		return zs_init();
 #endif
-
 #ifdef CONFIG_DZ
-    return dz_init();
-#endif
-
+	if (!IOASIC)
+		return dz_init();
 #endif
+	return -ENXIO;
 }
 
 __initcall(rs_init);
 
-#endif
 
-#ifdef CONFIG_SERIAL_CONSOLE
+#ifdef CONFIG_SERIAL_DEC_CONSOLE
+
+extern void zs_serial_console_init(void);
+extern void dz_serial_console_init(void);
 
-/* serial_console_init handles the special case of starting
- *   up the console on the serial port
+/*
+ * dec_serial_console_init handles the special case of starting
+ * up the console on the serial port
  */
-static int __init decserial_console_init(void)
+static int __init dec_serial_console_init(void)
 {
-#if defined(CONFIG_ZS) && defined(CONFIG_DZ)
-    if (IOASIC)
-	zs_serial_console_init();
-    else
-	dz_serial_console_init();
-#else
-
 #ifdef CONFIG_ZS
-    zs_serial_console_init();
+	if (IOASIC)
+		zs_serial_console_init();
 #endif
-
 #ifdef CONFIG_DZ
-    dz_serial_console_init();
-#endif
-
+	if (!IOASIC)
+		dz_serial_console_init();
 #endif
     return 0;
 }
-console_initcall(decserial_console_init);
+console_initcall(dec_serial_console_init);
 
 #endif

-- 
Martin Michlmayr
http://www.cyrius.com/
