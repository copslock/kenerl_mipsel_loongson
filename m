Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA118280; Tue, 12 Aug 1997 11:25:19 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA21938 for linux-list; Tue, 12 Aug 1997 11:23:57 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA21884 for <linux@cthulhu.engr.sgi.com>; Tue, 12 Aug 1997 11:23:51 -0700
Received: from pingwin.icm.edu.pl (pingwin.icm.edu.pl [148.81.209.13]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA22057
	for <linux@cthulhu.engr.sgi.com>; Tue, 12 Aug 1997 11:23:02 -0700
	env-from (jwr@pingwin.icm.edu.pl)
Received: by pingwin.icm.edu.pl id <173720-17317>; Tue, 12 Aug 1997 20:22:35 +0200
To: linux@cthulhu.engr.sgi.com
Subject: Precompiled kernel available ?
X-Operating-System: Linux 2.0.30 #1 Fri Apr 11 18:34:11 EDT 1997
X-No-Archive: yes
Mime-Version: 1.0 (generated by tm-edit 7.106)
Content-Type: text/plain; charset=US-ASCII
From: Jan Rychter <jwr@icm.edu.pl>
Date: 	12 Aug 1997 20:22:25 +0200
Message-ID: <wsnen7zuuqm.fsf@pingwin.icm.edu.pl>
X-Mailer: Gnus v5.4.64/XEmacs 19.15
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I'm having trouble cross-compiling the linux-970723 test release. Apart
from a few minor nits (make depend problem, etc.), this got me stopped:

mips-linuxgcc -D__KERNEL__ -I/home/jwr/linux-970723/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r8000 -mips2 -pipe -c int-handler.S -o int-handler.o
int-handler.S: Assembler messages:
int-handler.S:64: Error: .previous without corresponding .section; ignored
int-handler.S:70: Error: .previous without corresponding .section; ignored
int-handler.S:73: Error: .previous without corresponding .section; ignored
int-handler.S:172: Error: .previous without corresponding .section; ignored
int-handler.S:250: Error: .previous without corresponding .section; ignored
int-handler.S:270: Error: .previous without corresponding .section; ignored
int-handler.S:271: Error: .previous without corresponding .section; ignored
int-handler.S:294: Error: .previous without corresponding .section; ignored
make[1]: *** [int-handler.o] Error 1
make[1]: Leaving directory `/home/jwr/linux-970723/arch/mips/jazz'
make: *** [linuxsubdirs] Error 2


So, any hope for a ready-to-run-barely-bootable-but-binary thing on ftp
somewhere ? I was kinda expecting this from mr. David "SPARC precompiled
kernels for people" Miller :-)


thanks,
--J.
PS: I've set up a mirror on ftp://sunsite.icm.edu.pl/pub/Linux/sgi/
(mirrors ftp://ftp.linux.sgi.com/pub/ nightly)

BTW, isn't this a typo ?

--- sni.h-original      Sat Jun 14 19:38:41 1997
+++ sni.h       Sat Jun 14 19:38:45 1997
@@ -15,7 +15,7 @@
 /*
  * ASIC PCI registers for little endian configuration.
  */
-#ifndef __MIPSEL__
+#ifdef __MIPSEL__
 #error "Fix me for big endian"
 #endif
 #define PCIMT_UCONF            0xbfff0000
