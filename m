Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Dec 2003 10:53:43 +0000 (GMT)
Received: from frigate.technologeek.org ([IPv6:::ffff:62.4.21.148]:56451 "EHLO
	frigate.technologeek.org") by linux-mips.org with ESMTP
	id <S8225203AbTLVKxk>; Mon, 22 Dec 2003 10:53:40 +0000
Received: by frigate.technologeek.org (Postfix, from userid 1000)
	id 6011F1C8EEA0; Mon, 22 Dec 2003 11:53:41 +0100 (CET)
To: linux-mips@linux-mips.org
Subject: [PATCH 2.6] make drivers/char/vt.c compile without
 CONFIG_VT_CONSOLE
From: Julien BLACHE <jb@jblache.org>
Date: Mon, 22 Dec 2003 11:53:40 +0100
Message-ID: <874qvtgm2z.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-Path: <jb@jblache.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jb@jblache.org
Precedence: bulk
X-list: linux-mips

--=-=-=

Hi,

In drivers/char/vt.c, console_driver is defined inside an #ifdef
CONFIG_VT_CONSOLE, which makes it impossible to build a 2.6 kernel
without CONFIG_VT_CONSOLE.

I think this wasn't intended, so the attached patch moves the
declaration of console_driver above the #ifdef. There may be a more
appropriate place, so put it elsewhere if you feel like it :)

JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org>                                  GPG KeyID 0xF5D65169


--=-=-=
Content-Disposition: attachment; filename=vt.c.diff
Content-Description: drivers/char/vt.c patch to build without CONFIG_VT_CONSOLE

Index: vt.c
===================================================================
RCS file: /home/cvs/linux/drivers/char/vt.c,v
retrieving revision 1.55
diff -u -r1.55 vt.c
--- vt.c	19 Oct 2003 00:50:09 -0000	1.55
+++ vt.c	22 Dec 2003 10:47:19 -0000
@@ -2086,6 +2086,8 @@
 	schedule_console_callback();
 }
 
+struct tty_driver *console_driver;
+
 #ifdef CONFIG_VT_CONSOLE
 
 /*
@@ -2184,8 +2186,6 @@
 quit:
 	clear_bit(0, &printing);
 }
-
-struct tty_driver *console_driver;
 
 static struct tty_driver *vt_console_device(struct console *c, int *index)
 {

--=-=-=--
