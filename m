Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Mar 2003 03:19:43 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:46882
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225229AbTCJDTn>; Mon, 10 Mar 2003 03:19:43 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 10 Mar 2003 03:19:41 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 00F62B46B; Mon, 10 Mar 2003 12:19:33 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id MAA62084; Mon, 10 Mar 2003 12:19:33 +0900 (JST)
Date: Mon, 10 Mar 2003 12:24:45 +0900 (JST)
Message-Id: <20030310.122445.112283172.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] kbd_controller_present (remove kbd-no.c)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 1674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I found that "kbd_controller_present" macro was introduced in 2.4.20
pc_keyb.c.  How about this patch?  kbd-no.c is not needed anymore.


diff -ur linux-mips-cvs/arch/mips/kernel/setup.c linux.new/arch/mips/kernel/setup.c
--- linux-mips-cvs/arch/mips/kernel/setup.c	Fri Feb 14 09:41:21 2003
+++ linux.new/arch/mips/kernel/setup.c	Mon Mar 10 12:04:34 2003
@@ -70,7 +70,6 @@
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
+++ linux.new/arch/mips/lib/Makefile	Mon Mar 10 12:03:26 2003
@@ -19,6 +19,6 @@
 
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy-no.o floppy-std.o
 obj-$(subst m,y,$(CONFIG_IDE))	+= ide-std.o ide-no.o	# needed for ide module
-obj-$(CONFIG_PC_KEYB)		+= kbd-std.o kbd-no.o
+obj-$(CONFIG_PC_KEYB)		+= kbd-std.o
 
 include $(TOPDIR)/Rules.make
diff -ur linux-mips-cvs/include/asm-mips/keyboard.h linux.new/include/asm-mips/keyboard.h
--- linux-mips-cvs/include/asm-mips/keyboard.h	Fri Jan  4 07:54:52 2002
+++ linux.new/include/asm-mips/keyboard.h	Mon Mar 10 12:03:44 2003
@@ -62,6 +62,7 @@
 };
 
 extern struct kbd_ops *kbd_ops;
+#define kbd_controller_present() (kbd_ops != 0)
 
 /* Do the actual calls via kbd_ops vector  */
 #define kbd_request_region() kbd_ops->kbd_request_region()
---

There are another good side effects.  With this patch, following error
messages (and some delay in boot sequence) go away.

> initialize_kbd: Keyboard failed self test
> keyboard: Timeout - AT keyboard not present?(ed)
> keyboard: Timeout - AT keyboard not present?(f4)

Currently these messages are displayed when CONFIG_PC_KEYB is enabled
and kbd_ops is no_kbd_ops.

---
Atsushi Nemoto
The old PGP key (ID B6D728B1) has been revoked.  New key ID is 2874D52F.
