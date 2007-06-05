Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2007 11:45:46 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:18450 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021841AbXFEKpo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Jun 2007 11:45:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 10898E1CA8;
	Tue,  5 Jun 2007 12:45:05 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hI1TMtaqXzhs; Tue,  5 Jun 2007 12:45:04 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 35E67E1C6F;
	Tue,  5 Jun 2007 12:45:03 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l55AjAMY028600;
	Tue, 5 Jun 2007 12:45:10 +0200
Date:	Tue, 5 Jun 2007 11:45:07 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] DECstation: Optimised early printk()
Message-ID: <Pine.LNX.4.64N.0706051128210.15653@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3360/Tue Jun  5 06:32:46 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

 This is an optimised implementation of early printk() for the DECstation.  
After the recent conversion to a MIPS-specific generic routine using a 
character-by-character output the performance dropped significantly.  
This change reverts to the previous speed -- even at 9600 bps of the 
serial console the difference is visible with a naked eye; I presume for a 
framebuffer it is even worse (it may depend on exactly which one is used 
though).

 Additionally the change includes a fix for a problem that the old 
implementation had -- the format used would not actually limit the length 
of the string output.  This new implementation uses a local buffer to deal 
with it -- even with this additional copying it is much faster than the 
generic function.

 Plus this driver is registered much earlier than the generic one, 
allowing one to see critical messages, such as one about an incorrect CPU 
setting used, that are produced beforehand. :-)

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Hi,

 As a side note, the SYS_HAS_EARLY_PRINTK option could probably be called 
SYS_HAS_GENERIC_EARLY_PRINTK or something...

 Note this patch depends on "patch-mips-2.6.21-20070502-dec-no_ioport-0"; 
please let me know if you want them to be applied in the other order.

 Please apply,

  Maciej

patch-mips-2.6.21-20070502-dec-prom-console-3
diff -up --recursive --new-file linux-mips-2.6.21-20070502.macro/arch/mips/Kconfig linux-mips-2.6.21-20070502/arch/mips/Kconfig
--- linux-mips-2.6.21-20070502.macro/arch/mips/Kconfig	2007-05-27 22:19:35.000000000 +0000
+++ linux-mips-2.6.21-20070502/arch/mips/Kconfig	2007-06-04 22:59:11.000000000 +0000
@@ -178,7 +178,6 @@ config MACH_DECSTATION
 	select BOOT_ELF32
 	select DMA_NONCOHERENT
 	select NO_IOPORT
-	select SYS_HAS_EARLY_PRINTK
 	select IRQ_CPU
 	select SYS_HAS_CPU_R3000
 	select SYS_HAS_CPU_R4X00
diff -up --recursive --new-file linux-mips-2.6.21-20070502.macro/arch/mips/dec/prom/console.c linux-mips-2.6.21-20070502/arch/mips/dec/prom/console.c
--- linux-mips-2.6.21-20070502.macro/arch/mips/dec/prom/console.c	2007-05-02 04:55:33.000000000 +0000
+++ linux-mips-2.6.21-20070502/arch/mips/dec/prom/console.c	2007-06-04 22:38:34.000000000 +0000
@@ -3,7 +3,7 @@
  *
  *	DECstation PROM-based early console support.
  *
- *	Copyright (C) 2004  Maciej W. Rozycki
+ *	Copyright (C) 2004, 2007  Maciej W. Rozycki
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -13,15 +13,35 @@
 #include <linux/console.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 
 #include <asm/dec/prom.h>
 
-void prom_putchar(char c)
+static void __init prom_console_write(struct console *con, const char *s,
+				      unsigned int c)
 {
-	char s[2];
+	char buf[81];
+	unsigned int chunk = sizeof(buf) - 1;
 
-	s[0] = c;
-	s[1] = '\0';
+	while (c > 0) {
+		if (chunk > c)
+			chunk = c;
+		memcpy(buf, s, chunk);
+		buf[chunk] = '\0';
+		prom_printf("%s", buf);
+		s += chunk;
+		c -= chunk;
+	}
+}
+
+static struct console promcons __initdata = {
+	.name	= "prom",
+	.write	= prom_console_write,
+	.flags	= CON_BOOT | CON_PRINTBUFFER,
+	.index	= -1,
+};
 
-	prom_printf( s);
+void __init register_prom_console(void)
+{
+	register_console(&promcons);
 }
diff -up --recursive --new-file linux-mips-2.6.21-20070502.macro/arch/mips/dec/prom/init.c linux-mips-2.6.21-20070502/arch/mips/dec/prom/init.c
--- linux-mips-2.6.21-20070502.macro/arch/mips/dec/prom/init.c	2007-05-02 04:55:33.000000000 +0000
+++ linux-mips-2.6.21-20070502/arch/mips/dec/prom/init.c	2007-06-04 22:42:39.000000000 +0000
@@ -103,6 +103,9 @@ void __init prom_init(void)
 	if (prom_is_rex(magic))
 		rex_clear_cache();
 
+	/* Register the early console.  */
+	register_prom_console();
+
 	/* Were we compiled with the right CPU option? */
 #if defined(CONFIG_CPU_R3000)
 	if ((current_cpu_data.cputype == CPU_R4000SC) ||
