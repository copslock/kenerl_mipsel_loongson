Received:  by oss.sgi.com id <S305278AbQDBMMY>;
	Sun, 2 Apr 2000 05:12:24 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:23344 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305164AbQDBMMR>; Sun, 2 Apr 2000 05:12:17 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id FAA02888; Sun, 2 Apr 2000 05:16:00 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA85279
	for linux-list;
	Sun, 2 Apr 2000 01:28:27 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA39585
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 2 Apr 2000 01:28:26 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA08337
	for <linux@cthulhu.engr.sgi.com>; Sun, 2 Apr 2000 01:23:45 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 4BE907D9; Sun,  2 Apr 2000 11:15:01 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id E4CD88FC3; Sun,  2 Apr 2000 11:04:47 +0200 (CEST)
Date:   Sun, 2 Apr 2000 11:04:47 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: promcon - first fix attempt ...
Message-ID: <20000402110447.A9189@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
this is a patch which at least gives me some bootup messages on the prom
console ...

The naming scheme for the "prom console" as a serial device ("ttySN") isnt
that good afaik as the setup for the serial console and prom console
could get mixed up - right ?

I dont think calling "sgi_prom_console_init" from arch_setup is correct
but where should this be placed better ?


Index: drivers/char/Makefile
===================================================================
RCS file: /cvs/linux/drivers/char/Makefile,v
retrieving revision 1.32
diff -u -r1.32 Makefile
--- drivers/char/Makefile	2000/03/12 23:15:37	1.32
+++ drivers/char/Makefile	2000/04/02 09:11:46
@@ -80,6 +80,10 @@
   SERIAL   =
 endif
 
+ifeq ($(CONFIG_SGI_IP22),y)
+  SERIAL   =
+endif
+
 ifeq ($(CONFIG_BAGET_MIPS),y)
   KEYBD    =
   SERIAL   =
Index: arch/mips/sgi/kernel/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi/kernel/setup.c,v
retrieving revision 1.30
diff -u -r1.30 setup.c
--- arch/mips/sgi/kernel/setup.c	2000/03/26 23:45:03	1.30
+++ arch/mips/sgi/kernel/setup.c	2000/04/02 09:11:47
@@ -30,18 +30,21 @@
 #ifdef CONFIG_REMOTE_DEBUG
 extern void rs_kgdb_hook(int);
 extern void breakpoint(void);
+static int remote_debug = 0;
 #endif
 
-#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_PROM_CONSOLE)
+#if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_SGI_PROM_CONSOLE)
 extern void console_setup(char *);
 #endif
 
+#if defined(CONFIG_SGI_PROM_CONSOLE)
+extern void sgi_prom_console_init(void );
+#endif
+
 extern struct rtc_ops indy_rtc_ops;
 void indy_reboot_setup(void);
 void sgi_volume_set(unsigned char);
 
-static int remote_debug = 0;
-
 #define sgi_kh ((struct hpc_keyb *) (KSEG1 + 0x1fbd9800 + 64))
 
 #define KBD_STAT_IBF		0x02	/* Keyboard input buffer full */
@@ -197,9 +200,10 @@
 #endif
 
 #ifdef CONFIG_SGI_PROM_CONSOLE
-	console_setup("ttyS0", NULL);
+	sgi_prom_console_init();
+	console_setup("ttyS0");
 #endif
-  
+
 	sgi_volume_set(simple_strtoul(ArcGetEnvironmentVariable("volume"), NULL, 10));
 
 #ifdef CONFIG_VT
Index: arch/mips/sgi/kernel/promcon.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi/kernel/promcon.c,v
retrieving revision 1.2
diff -u -r1.2 promcon.c
--- arch/mips/sgi/kernel/promcon.c	1999/10/09 00:00:59	1.2
+++ arch/mips/sgi/kernel/promcon.c	2000/04/02 09:11:47
@@ -66,8 +66,8 @@
  *    Register console.
  */
 
-long __init sgi_prom_console_init(long kmem_start, long kmem_end)
+long __init sgi_prom_console_init(void )
 {
     register_console(&sercons);
-    return kmem_start;
+    prom_printf("sgi_prom_console_init called\n");
 }



-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
