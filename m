Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2003 08:50:06 +0000 (GMT)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:1292 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225194AbTCUIuD>;
	Fri, 21 Mar 2003 08:50:03 +0000
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP id 39AEBB5A1
	for <linux-mips@linux-mips.org>; Fri, 21 Mar 2003 09:49:55 +0100 (CET)
Message-ID: <3E7AD36E.26E2EA94@ekner.info>
Date: Fri, 21 Mar 2003 09:55:10 +0100
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Patches for all four au1000 setup.c files
Content-Type: multipart/mixed;
 boundary="------------B90FDD20FDEC016885A15C78"
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------B90FDD20FDEC016885A15C78
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

the patches below for all four au1000 setup.c files removes the wbflush() routine, as this is no longer necessary
(handled by the generic code now, which does a sync). This also means that it is not necessary to say yes to
CONFIG_CPU_ADVANCED and override the CPU_HAS_WB setting, as the generic MIPS32 code will do just fine.

The patch for the db1x00 setup.c file also fixes a bug which prevented VRA from being used with Audio Codecs
which support it.

/Hartvig



--------------B90FDD20FDEC016885A15C78
Content-Type: text/plain; charset=us-ascii;
 name="setup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setup.patch"

Index: db1x00/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/db1x00/Attic/setup.c,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 setup.c
--- db1x00/setup.c	7 Jan 2003 10:41:30 -0000	1.1.2.3
+++ db1x00/setup.c	21 Mar 2003 08:44:49 -0000
@@ -61,7 +61,6 @@
 extern struct ide_ops *ide_ops;
 #endif
 
-void (*__wbflush) (void);
 extern struct rtc_ops no_rtc_ops;
 extern char * __init prom_getcmdline(void);
 extern void au1000_restart(char *);
@@ -76,11 +75,6 @@
 
 void __init bus_error_init(void) { /* nothing */ }
 
-void au1x00_wbflush(void)
-{
-	__asm__ volatile ("sync");
-}
-
 void __init au1x00_setup(void)
 {
 	char *argptr;
@@ -109,14 +103,13 @@
     }
 #endif
 
-#if defined(CONFIG_SOUND_AU1000) && !defined(CONFIG_CPU_AU1000)
+#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_CPU_AU1000)
 	// au1000 does not support vra, au1500 and au1100 do
-    strcat(argptr, " au1000_audio=vra");
-    argptr = prom_getcmdline();
+	strcat(argptr, " au1000_audio=vra");
+	argptr = prom_getcmdline();
 #endif
 
 	rtc_ops = &no_rtc_ops;
-	__wbflush = au1x00_wbflush;
 	_machine_restart = au1000_restart;
 	_machine_halt = au1000_halt;
 	_machine_power_off = au1000_power_off;
Index: pb1000/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/pb1000/setup.c,v
retrieving revision 1.8.2.8
diff -u -r1.8.2.8 setup.c
--- pb1000/setup.c	11 Dec 2002 06:12:29 -0000	1.8.2.8
+++ pb1000/setup.c	21 Mar 2003 08:44:50 -0000
@@ -67,7 +67,6 @@
 extern struct ide_ops *ide_ops;
 #endif
 
-void (*__wbflush) (void);
 extern struct rtc_ops no_rtc_ops;
 extern char * __init prom_getcmdline(void);
 extern void au1000_restart(char *);
@@ -78,11 +77,6 @@
 
 void __init bus_error_init(void) { /* nothing */ }
 
-void au1000_wbflush(void)
-{
-	__asm__ volatile ("sync");
-}
-
 void __init au1x00_setup(void)
 {
 	char *argptr;
@@ -103,7 +97,6 @@
 #endif
 
 	rtc_ops = &no_rtc_ops;
-        __wbflush = au1000_wbflush;
 	_machine_restart = au1000_restart;
 	_machine_halt = au1000_halt;
 	_machine_power_off = au1000_power_off;
Index: pb1100/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/pb1100/setup.c,v
retrieving revision 1.1.2.6
diff -u -r1.1.2.6 setup.c
--- pb1100/setup.c	31 Dec 2002 05:00:22 -0000	1.1.2.6
+++ pb1100/setup.c	21 Mar 2003 08:44:50 -0000
@@ -71,7 +71,6 @@
 extern struct rtc_ops pb1500_rtc_ops;
 #endif
 
-void (*__wbflush) (void);
 extern char * __init prom_getcmdline(void);
 extern void au1000_restart(char *);
 extern void au1000_halt(void);
@@ -82,11 +81,6 @@
 
 void __init bus_error_init(void) { /* nothing */ }
 
-void au1100_wbflush(void)
-{
-	__asm__ volatile ("sync");
-}
-
 void __init au1x00_setup(void)
 {
 	char *argptr;
@@ -112,7 +106,6 @@
 	argptr = prom_getcmdline();
 #endif
 
-        __wbflush = au1100_wbflush;
 	_machine_restart = au1000_restart;
 	_machine_halt = au1000_halt;
 	_machine_power_off = au1000_power_off;
Index: pb1500/setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/pb1500/setup.c,v
retrieving revision 1.1.2.10
diff -u -r1.1.2.10 setup.c
--- pb1500/setup.c	29 Dec 2002 10:30:35 -0000	1.1.2.10
+++ pb1500/setup.c	21 Mar 2003 08:44:50 -0000
@@ -43,7 +43,6 @@
 #include <asm/mipsregs.h>
 #include <asm/reboot.h>
 #include <asm/pgtable.h>
-#include <asm/wbflush.h>
 #include <asm/au1000.h>
 #include <asm/pb1500.h>
 
@@ -72,7 +71,6 @@
 extern struct rtc_ops pb1500_rtc_ops;
 #endif
 
-void (*__wbflush) (void);
 extern char * __init prom_getcmdline(void);
 extern void au1000_restart(char *);
 extern void au1000_halt(void);
@@ -87,11 +85,6 @@
 
 void __init bus_error_init(void) { /* nothing */ }
 
-void au1500_wbflush(void)
-{
-	__asm__ volatile ("sync");
-}
-
 void __init au1x00_setup(void)
 {
 	char *argptr;
@@ -117,7 +110,6 @@
 	argptr = prom_getcmdline();
 #endif
 
-        __wbflush = au1500_wbflush;
 	_machine_restart = au1000_restart;
 	_machine_halt = au1000_halt;
 	_machine_power_off = au1000_power_off;

--------------B90FDD20FDEC016885A15C78--
