Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7MN9h808476
	for linux-mips-outgoing; Wed, 22 Aug 2001 16:09:43 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7MN9ed08473
	for <linux-mips@oss.sgi.com>; Wed, 22 Aug 2001 16:09:40 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7MNE8A12739;
	Wed, 22 Aug 2001 16:14:08 -0700
Message-ID: <3B843A46.6F39300F@mvista.com>
Date: Wed, 22 Aug 2001 16:03:34 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mips@oss.sgi.com
Subject: [PATCH] set the number of serial ports
Content-Type: multipart/mixed;
 boundary="------------6CB43A7A0B4E1479BE594809"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------6CB43A7A0B4E1479BE594809
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Who is maintaining serial.c file?  I sent this email to Ted Tso a while back
and did not get any replies.  Here is another try.

Jun
--------------6CB43A7A0B4E1479BE594809
Content-Type: text/plain; charset=us-ascii;
 name="num_serial_ports.2.4.0108xx.010822.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="num_serial_ports.2.4.0108xx.010822.patch"


This attempts to solve two problmes:

1. reserves rs_table size even without any SERIAL_PORT_DFNS.  This
   is necessary for machines that must detect serial ports at run-time.
   It is also a better way to use early_serial_setup() to set up serial
   ports, especially serial.h is *really* getting crowded for RISC arches.

2. When CONFIG_SERIAL_MANY_PORTS is defined, we will 64 rs_table entries
   (under MIPS and other arches).  We can save up to 11K with some
   more reasonable CONFIG_NUM_SERIAL_PORTS value.

Jun
08/22/2001

diff -Nru linux/drivers/char/Config.in.orig linux/drivers/char/Config.in
--- linux/drivers/char/Config.in.orig	Tue Jun 12 17:29:21 2001
+++ linux/drivers/char/Config.in	Wed Aug 22 15:28:54 2001
@@ -11,6 +11,7 @@
 tristate 'Standard/generic (8250/16550 and compatible UARTs) serial support' CONFIG_SERIAL
 if [ "$CONFIG_SERIAL" = "y" ]; then
    bool '  Support for console on serial port' CONFIG_SERIAL_CONSOLE
+   int '   Number of serial ports (0 for system default)' CONFIG_SERIAL_NUM_PORTS  0
    if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
       tristate '   Atomwide serial port support' CONFIG_ATOMWIDE_SERIAL
       tristate '   Dual serial port support' CONFIG_DUALSP_SERIAL
diff -Nru linux/drivers/char/serial.c.orig linux/drivers/char/serial.c
--- linux/drivers/char/serial.c.orig	Tue Jun 26 17:23:10 2001
+++ linux/drivers/char/serial.c	Wed Aug 22 15:48:46 2001
@@ -321,6 +321,14 @@
 MODULE_PARM_DESC(force_rsa, "Force I/O ports for RSA");
 #endif /* CONFIG_SERIAL_RSA  */
 
+/* 
+ * [jsun] We horner the CONFIG_SERIAL_NUM_PORTS variable
+ */
+#if (CONFIG_SERIAL_NUM_PORTS != 0)
+#undef RS_TABLE_SIZE
+#define RS_TABLE_SIZE	CONFIG_SERIAL_NUM_PORTS
+#endif
+
 static struct serial_state rs_table[RS_TABLE_SIZE] = {
 	SERIAL_PORT_DFNS	/* Defined in serial.h */
 };

--------------6CB43A7A0B4E1479BE594809--
