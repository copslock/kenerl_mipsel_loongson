Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g69KokRw032350
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 9 Jul 2002 13:50:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g69Kok5l032349
	for linux-mips-outgoing; Tue, 9 Jul 2002 13:50:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g69KoZRw032336;
	Tue, 9 Jul 2002 13:50:35 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g69KssC06793;
	Tue, 9 Jul 2002 22:54:54 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g69KstTF009646;
	Tue, 9 Jul 2002 22:54:55 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17S20d-00065i-00; Tue, 09 Jul 2002 22:54:55 +0200
Date: Tue, 9 Jul 2002 22:54:55 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [PATCH] setup reboot handlers for ip27 and ip32
Message-ID: <Pine.LNX.4.21.0207092250280.23381-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

	This is a patch setup the reboot handlers for the ip27 and ip32
machines.

Please apply,
Vivien.

diff -Naur linux/arch/mips64/sgi-ip27/ip27-setup.c linux.patch/arch/mips64/sgi-ip27/ip27-setup.c
--- linux/arch/mips64/sgi-ip27/ip27-setup.c	Wed Jan  2 22:56:41 2002
+++ linux.patch/arch/mips64/sgi-ip27/ip27-setup.c	Wed Jan  2 23:14:19 2002
@@ -276,6 +276,7 @@
 
 extern void ip27_setup_console(void);
 extern void ip27_time_init(void);
+extern void ip27_reboot_setup(void);
 
 void __init ip27_setup(void)
 {
@@ -283,6 +284,7 @@
 	hubreg_t p, e;
 
 	ip27_setup_console();
+	ip27_reboot_setup();
 
 	num_bridges = 0;
 	/*
diff -Naur linux/arch/mips64/sgi-ip32/ip32-setup.c linux.patch/arch/mips64/sgi-ip32/ip32-setup.c
--- linux/arch/mips64/sgi-ip32/ip32-setup.c	Wed Jan  2 22:56:41 2002
+++ linux.patch/arch/mips64/sgi-ip32/ip32-setup.c	Wed Jan  2 23:14:21 2002
@@ -58,6 +58,7 @@
 #endif
 
 extern void ip32_time_init(void);
+extern void ip32_reboot_setup(void);
 
 void __init bus_error_init(void)
 {
@@ -92,6 +93,7 @@
 #ifdef CONFIG_VT
 	conswitchp = &dummy_con;
 #endif
+	ip32_reboot_setup();
 
 	rtc_ops = &ip32_rtc_ops;
 	board_time_init = ip32_time_init;
