Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2004 02:40:28 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:22535
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224989AbUKUCkX>; Sun, 21 Nov 2004 02:40:23 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CVheI-0004cU-00; Sun, 21 Nov 2004 03:40:22 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CVheG-0004ia-00; Sun, 21 Nov 2004 03:40:20 +0100
Date: Sun, 21 Nov 2004 03:40:20 +0100
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] Fix ip22 console init
Message-ID: <20041121024020.GJ20986@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hello All,

this patch fixes the serial console init for ip22. Currently the
console gets registered twice, with the funny effect of an endless
which continuosly prints the first line of the printk buffer.


Thiemo


Index: drivers/serial/ip22zilog.c
===================================================================
RCS file: /home/cvs/linux/drivers/serial/ip22zilog.c,v
retrieving revision 1.15
diff -u -p -r1.15 ip22zilog.c
--- drivers/serial/ip22zilog.c	28 Sep 2004 19:22:07 -0000	1.15
+++ drivers/serial/ip22zilog.c	20 Nov 2004 16:46:58 -0000
@@ -1100,28 +1100,19 @@ static struct console ip22zilog_console 
 	.index	=	-1,
 	.data	=	&ip22zilog_reg,
 };
-#define IP22ZILOG_CONSOLE	(&ip22zilog_console)
-
-static int __init ip22zilog_console_init(void)
-{
-	register_console(&ip22zilog_console);
-	return 0;
-}
-#else /* CONFIG_SERIAL_IP22_ZILOG_CONSOLE */
-#define IP22ZILOG_CONSOLE		(NULL)
-#define ip22zilog_console_init()	do { } while (0)
-#endif
+#endif /* CONFIG_SERIAL_IP22_ZILOG_CONSOLE */
 
 static struct uart_driver ip22zilog_reg = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "serial",
-	.devfs_name	= "tty/",
+	.devfs_name	= "tts/",
 	.dev_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= 64,
 	.nr		= NUM_CHANNELS,
-	.cons		= IP22ZILOG_CONSOLE,
-
+#ifdef CONFIG_SERIAL_IP22_ZILOG_CONSOLE
+	.cons		= &ip22zilog_console,
+#endif
 };
 
 static void __init ip22zilog_prepare(void)
@@ -1254,7 +1245,6 @@ static int __init ip22zilog_init(void)
 	/* IP22 Zilog setup is hard coded, no probing to do.  */
 	ip22zilog_alloc_tables();
 	ip22zilog_ports_init();
-	ip22zilog_console_init();
 
 	return 0;
 }
