Received:  by oss.sgi.com id <S42210AbQG0EzI>;
	Wed, 26 Jul 2000 21:55:08 -0700
Received: from rno-dsl0b-218.gbis.net ([216.82.145.218]:51472 "EHLO
        ozymandias.foobazco.org") by oss.sgi.com with ESMTP
	id <S42223AbQG0Eyl>; Wed, 26 Jul 2000 21:54:41 -0700
Received: (from wesolows@localhost)
	by ozymandias.foobazco.org (8.9.3/8.9.3) id VAA18408
	for linux-mips@oss.sgi.com; Wed, 26 Jul 2000 21:54:16 -0700
Date:   Wed, 26 Jul 2000 21:54:16 -0700
From:   Keith M Wesolowski <wesolows@foobazco.org>
To:     linux-mips@oss.sgi.com
Subject: sgi prom console
Message-ID: <20000726215416.A18398@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

This patch gets the sgi prom console outputting again, and eliminates
the "cannot open initial console" error. Unfortunately, all output
from userland goes to the serial port, not the the prom console.
Looking at the code, this isn't at all surprising; the prom console
pretends to be 4,64, ttyS0. It's quite beyond me how the prom console
could ever have worked for userland.

Index: drivers/char/mem.c
===================================================================
RCS file: /cvs/linux/drivers/char/mem.c,v
retrieving revision 1.35
diff -u -r1.35 mem.c
--- drivers/char/mem.c	2000/06/25 01:20:03	1.35
+++ drivers/char/mem.c	2000/07/27 04:48:33
@@ -49,6 +49,9 @@
 #ifdef CONFIG_PROM_CONSOLE
 extern void prom_con_init(void);
 #endif
+#ifdef CONFIG_SGI_PROM_CONSOLE
+extern void sgi_prom_console_init(void);
+#endif
 #ifdef CONFIG_MDA_CONSOLE
 extern void mda_console_init(void);
 #endif
@@ -632,6 +635,9 @@
 #endif
 #if defined (CONFIG_PROM_CONSOLE)
 	prom_con_init();
+#endif
+#if defined (CONFIG_SGI_PROM_CONSOLE)
+	sgi_prom_console_init();
 #endif
 #if defined (CONFIG_MDA_CONSOLE)
 	mda_console_init();


-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows/
(( Project Foobazco Coordinator and Network Administrator )) aiieeeeeeee!
"The list of people so amazingly stupid they can't even tie their shoes?"
"Yeah, you know, /etc/passwd."
