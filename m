Received:  by oss.sgi.com id <S305199AbQDBMMY>;
	Sun, 2 Apr 2000 05:12:24 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:21296 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305196AbQDBMMB>; Sun, 2 Apr 2000 05:12:01 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id FAA01397; Sun, 2 Apr 2000 05:15:43 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id XAA98063
	for linux-list;
	Sat, 1 Apr 2000 23:57:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA05239
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 Apr 2000 23:57:30 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id XAA16183
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 Apr 2000 23:52:50 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 5124D7D9; Sun,  2 Apr 2000 09:44:10 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id E9CB68FC3; Sun,  2 Apr 2000 09:33:54 +0200 (CEST)
Date:   Sun, 2 Apr 2000 09:33:54 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: arch/mips/sgi/kernel/setup.c patch
Message-ID: <20000402093354.D1368@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
a small sgi setup.c cleanup - It should be obvious - Althgough this
only get setup.c to compile again with PROM_CONSOLE as there are still 
more bugs

Index: setup.c
===================================================================
RCS file: /cvs/linux/arch/mips/sgi/kernel/setup.c,v
retrieving revision 1.30
diff -u -r1.30 setup.c
--- setup.c	2000/03/26 23:45:03	1.30
+++ setup.c	2000/04/02 07:42:00
@@ -30,6 +30,7 @@
 #ifdef CONFIG_REMOTE_DEBUG
 extern void rs_kgdb_hook(int);
 extern void breakpoint(void);
+static int remote_debug = 0;
 #endif
 
 #if defined(CONFIG_SERIAL_CONSOLE) || defined(CONFIG_PROM_CONSOLE)
@@ -40,8 +41,6 @@
 void indy_reboot_setup(void);
 void sgi_volume_set(unsigned char);
 
-static int remote_debug = 0;
-
 #define sgi_kh ((struct hpc_keyb *) (KSEG1 + 0x1fbd9800 + 64))
 
 #define KBD_STAT_IBF		0x02	/* Keyboard input buffer full */
@@ -197,9 +196,9 @@
 #endif
 
 #ifdef CONFIG_SGI_PROM_CONSOLE
-	console_setup("ttyS0", NULL);
+	console_setup("ttyS0");
 #endif
-  
+
 	sgi_volume_set(simple_strtoul(ArcGetEnvironmentVariable("volume"), NULL, 10));
 
 #ifdef CONFIG_VT


-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
