Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2006 18:52:41 +0200 (CEST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:62863 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8134009AbWEVQwc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 May 2006 18:52:32 +0200
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FiDaG-0000RC-78
	for linux-mips@linux-mips.org; Mon, 22 May 2006 18:48:44 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FiDe8-0004FM-EQ
	for linux-mips@linux-mips.org; Mon, 22 May 2006 18:52:44 +0200
Date:	Mon, 22 May 2006 18:52:44 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060522165244.GA16223@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] au1x00 serial real interrupt
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

Here my patch to enable real interrupts management for the au1x00
CPUs.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-au1x00-serial-real-interrupt

diff --git a/include/asm-mips/serial.h b/include/asm-mips/serial.h
index 7b23664..0197062 100644
--- a/include/asm-mips/serial.h
+++ b/include/asm-mips/serial.h
@@ -11,6 +11,14 @@
 
 #include <linux/config.h>
 
+#ifdef CONFIG_SOC_AU1X00
+/*
+ * We have to redefine "is_real_interrupt()" for Au1x00 CPUs...
+ */
+#undef is_real_interrupt
+#define is_real_interrupt(irq)	((irq) != ~0)
+#endif
+
 /*
  * This assumes you have a 1.8432 MHz clock for your UART.
  *

--liOOAslEiF7prFVr--
