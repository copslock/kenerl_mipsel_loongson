Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2004 10:31:37 +0000 (GMT)
Received: from mail.baslerweb.com ([IPv6:::ffff:145.253.187.130]:38759 "EHLO
	mail.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225245AbUKDKbc>; Thu, 4 Nov 2004 10:31:32 +0000
Received: (from mail@localhost)
	by mail.baslerweb.com (8.12.10/8.12.10) id iA4AUjUc003659
	for <linux-mips@linux-mips.org>; Thu, 4 Nov 2004 11:30:45 +0100
Received: from unknown by gateway id /var/KryptoWall/smtpp/kwWlIwvP; Thu Nov 04 11:30:32 2004
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id WHM6N9CA; Thu, 4 Nov 2004 11:31:18 +0100
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org
Subject: [PATCH] The compiler's revenge
Date: Thu, 4 Nov 2004 11:35:31 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Message-Id: <200411041135.31503.thomas.koeller@baslerweb.com>
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

... for lying to it is to produce code that does unexpected things.

In include/asm-mips/io.h, mips_io_port_base is declared to be const,
but can actually be modified using set_io_port_base(). The compiler
believes the const declaration and uses the uninitialized value if
an in(b|w|l) or out(b|w|l) is used right after set_io_port_base().


Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>



--- linux-mips-cvs/include/asm-mips/io.h	2004-10-25 11:16:42.000000000 +0200
+++ linux-mips-basler/include/asm-mips/io.h	2004-11-04 10:40:57.796646368 +0100
@@ -67,10 +67,9 @@
  * instruction, so the lower 16 bits must be zero.  Should be true on
  * on any sane architecture; generic code does not use this assumption.
  */
-extern const unsigned long mips_io_port_base;
+extern unsigned long mips_io_port_base;
 
-#define set_io_port_base(base)	\
-	do { * (unsigned long *) &mips_io_port_base = (base); } while (0)
+#define set_io_port_base(base) mips_io_port_base = (base)
 
 /*
  * Thanks to James van Artsdalen for a better timing-fix than
--- linux-mips-cvs/arch/mips/kernel/setup.c	2004-07-14 16:21:29.000000000 +0200
+++ linux-mips-basler/arch/mips/kernel/setup.c	2004-11-04 10:39:45.359658464 +0100
@@ -78,7 +78,7 @@
  * mips_io_port_base is the begin of the address space to which x86 style
  * I/O ports are mapped.
  */
-const unsigned long mips_io_port_base = -1;
+unsigned long mips_io_port_base = -1;
 EXPORT_SYMBOL(mips_io_port_base);
 
 /*

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
