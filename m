Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2003 02:10:43 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:6406
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224821AbTFKBKk>; Wed, 11 Jun 2003 02:10:40 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 11 Jun 2003 01:10:39 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h5B1ATiY005172;
	Wed, 11 Jun 2003 10:10:30 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Wed, 11 Jun 2003 10:11:20 +0900 (JST)
Message-Id: <20030611.101120.74755822.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Deleting kbd-no.c (Re: CVS Update@-mips.org: linux)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030610124313Z8224827-1272+2433@linux-mips.org>
References: <20030610124313Z8224827-1272+2433@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 10 Jun 2003 13:43:09 +0100, ralf@linux-mips.org said:
ralf> Removed files:
ralf> 	arch/mips/lib  : kbd-no.c kbd-std.c 
ralf> 	arch/mips64/lib: kbd-no.c kbd-std.c 

ralf> Log message:
ralf> 	Delete unused source files.

If we implement kbd_controller_present() macro, kbd-no.c is not needed
in 2.4 kernel too.


Here is a patch.  I posted same patch three month ago but new one
includes mips64 changes.

diff -ur linux-mips-cvs/arch/mips/kernel/setup.c linux.new/arch/mips/kernel/setup.c
--- linux-mips-cvs/arch/mips/kernel/setup.c	Thu May  8 10:28:23 2003
+++ linux.new/arch/mips/kernel/setup.c	Wed Jun 11 09:46:59 2003
@@ -68,7 +68,6 @@
 struct rtc_ops *rtc_ops;
 
 #ifdef CONFIG_PC_KEYB
-extern struct kbd_ops no_kbd_ops;
 struct kbd_ops *kbd_ops;
 #endif
 
@@ -505,10 +504,6 @@
 	ide_ops = &no_ide_ops;
 #endif
 
-#ifdef CONFIG_PC_KEYB
-	kbd_ops = &no_kbd_ops;
-#endif
-
 	rtc_ops = &no_rtc_ops;
 
 	switch(mips_machgroup)
diff -ur linux-mips-cvs/arch/mips/lib/Makefile linux.new/arch/mips/lib/Makefile
--- linux-mips-cvs/arch/mips/lib/Makefile	Fri Feb 14 09:41:21 2003
+++ linux.new/arch/mips/lib/Makefile	Wed Jun 11 09:47:35 2003
@@ -19,6 +19,6 @@
 
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy-no.o floppy-std.o
 obj-$(subst m,y,$(CONFIG_IDE))	+= ide-std.o ide-no.o	# needed for ide module
-obj-$(CONFIG_PC_KEYB)		+= kbd-std.o kbd-no.o
+obj-$(CONFIG_PC_KEYB)		+= kbd-std.o
 
 include $(TOPDIR)/Rules.make
diff -ur linux-mips-cvs/arch/mips64/kernel/setup.c linux.new/arch/mips64/kernel/setup.c
--- linux-mips-cvs/arch/mips64/kernel/setup.c	Thu May  8 10:28:23 2003
+++ linux.new/arch/mips64/kernel/setup.c	Wed Jun 11 09:46:23 2003
@@ -68,7 +68,6 @@
 extern struct rtc_ops no_rtc_ops;
 struct rtc_ops *rtc_ops;
 
-extern struct kbd_ops no_kbd_ops;
 struct kbd_ops *kbd_ops;
 
 /*
diff -ur linux-mips-cvs/arch/mips64/lib/Makefile linux.new/arch/mips64/lib/Makefile
--- linux-mips-cvs/arch/mips64/lib/Makefile	Fri Feb 14 09:41:26 2003
+++ linux.new/arch/mips64/lib/Makefile	Wed Jun 11 09:48:17 2003
@@ -12,6 +12,6 @@
 
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy-no.o floppy-std.o
 obj-$(subst m,y,$(CONFIG_IDE))	+= ide-std.o ide-no.o	# needed for ide module
-obj-$(CONFIG_PC_KEYB)		+= kbd-std.o kbd-no.o
+obj-$(CONFIG_PC_KEYB)		+= kbd-std.o
 
 include $(TOPDIR)/Rules.make
diff -ur linux-mips-cvs/include/asm-mips/keyboard.h linux.new/include/asm-mips/keyboard.h
--- linux-mips-cvs/include/asm-mips/keyboard.h	Fri Jan  4 07:54:52 2002
+++ linux.new/include/asm-mips/keyboard.h	Wed Jun 11 09:43:13 2003
@@ -62,6 +62,7 @@
 };
 
 extern struct kbd_ops *kbd_ops;
+#define kbd_controller_present() (kbd_ops != 0)
 
 /* Do the actual calls via kbd_ops vector  */
 #define kbd_request_region() kbd_ops->kbd_request_region()
diff -ur linux-mips-cvs/include/asm-mips64/keyboard.h linux.new/include/asm-mips64/keyboard.h
--- linux-mips-cvs/include/asm-mips64/keyboard.h	Fri Jan  4 07:54:52 2002
+++ linux.new/include/asm-mips64/keyboard.h	Wed Jun 11 09:43:29 2003
@@ -62,6 +62,7 @@
 };
 
 extern struct kbd_ops *kbd_ops;
+#define kbd_controller_present() (kbd_ops != 0)
 
 /* Do the actual calls via kbd_ops vector  */
 #define kbd_request_region() kbd_ops->kbd_request_region()
---
Atsushi Nemoto
