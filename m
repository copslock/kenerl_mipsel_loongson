Received:  by oss.sgi.com id <S305186AbQERPix>;
	Thu, 18 May 2000 15:38:53 +0000
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:30012 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305160AbQERPit>; Thu, 18 May 2000 15:38:49 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id IAA03105; Thu, 18 May 2000 08:43:21 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id IAA37688; Thu, 18 May 2000 08:38:17 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA91895
	for linux-list;
	Thu, 18 May 2000 08:24:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA85742
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 18 May 2000 08:24:51 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA03088
	for <linux@cthulhu.engr.sgi.com>; Thu, 18 May 2000 08:24:49 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6BC9A7F4; Thu, 18 May 2000 17:24:52 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id E568D8FA7; Thu, 18 May 2000 17:24:45 +0200 (CEST)
Date:   Thu, 18 May 2000 17:24:45 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: [PATCH] sgi serial console - last fixes - ok to commit ?
Message-ID: <20000518172445.A29326@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
any one suggestions for this patch - Ok to commit ?

---------------------------------------------------------------
diff -u -r1.32 setup.c
--- arch/mips/sgi/kernel/setup.c	2000/04/06 20:26:58	1.32
+++ arch/mips/sgi/kernel/setup.c	2000/05/18 15:17:29
@@ -229,5 +213,5 @@
 #ifdef CONFIG_VIDEO_VINO
 	init_vino();
 #endif
+
 }
-__initcall(rs_init);
diff -u -r1.34 tty_io.c
--- drivers/char/tty_io.c	2000/05/12 21:06:16	1.34
+++ drivers/char/tty_io.c	2000/05/18 15:17:34
@@ -2196,7 +2196,7 @@
 #ifdef CONFIG_SERIAL_CONSOLE
 #ifdef CONFIG_8xx
 	console_8xx_init();
-#elif defined(CONFIG_SERIAL) 	
+#elif defined(CONFIG_SERIAL) || defined(CONFIG_SGI_SERIAL)
 	serial_console_init();
 #endif /* CONFIG_8xx */
 #if defined(CONFIG_MVME162_SCC) || defined(CONFIG_BVME6000_SCC) || defined(CONFIG_MVME147_SCC)
diff -u -r1.23 sgiserial.c
--- drivers/sgi/char/sgiserial.c	2000/01/27 01:05:35	1.23
+++ drivers/sgi/char/sgiserial.c	2000/05/18 15:17:47
@@ -2251,3 +2251,4 @@
 {
 	register_console(&sgi_console_driver);
 }
+__initcall(rs_init);

---------------------------------------------------------------


Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
