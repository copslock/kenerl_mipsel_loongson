Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 18:17:43 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:19934 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133444AbWAYSRZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 18:17:25 +0000
Received: (qmail 19561 invoked from network); 25 Jan 2006 18:21:45 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 25 Jan 2006 18:21:45 -0000
Message-ID: <43D7C279.70807@ru.mvista.com>
Date:	Wed, 25 Jan 2006 21:24:57 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
CC:	ralf@linux-mips.org
Subject: [PATCH] TX49x7: Fix timer register #define's
Content-Type: multipart/mixed;
 boundary="------------020302050802080405020302"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020302050802080405020302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

    Resending with signoffs (tend to forget about them).

    Fix the #define's for TX4927/37 timer reg's to match the datasheets (those
#define's don't seem to be used anywhere though...)

WBR, Sergei

Signed-off-by: Konstantin Baydarov <kbaidarov@mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@mvista.com>


--------------020302050802080405020302
Content-Type: text/plain;
 name="TX49x7-fix-timer-reg-defs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="TX49x7-fix-timer-reg-defs.patch"

diff --git a/include/asm-mips/tx4927/tx4927.h b/include/asm-mips/tx4927/tx4927.h
index 3bb7f00..de85bd2 100644
--- a/include/asm-mips/tx4927/tx4927.h
+++ b/include/asm-mips/tx4927/tx4927.h
@@ -2,7 +2,7 @@
  * Author: MontaVista Software, Inc.
  *         source@mvista.com
  *
- * Copyright 2001-2002 MontaVista Software Inc.
+ * Copyright 2001-2006 MontaVista Software Inc.
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -30,10 +30,10 @@
 #include <asm/tx4927/tx4927_mips.h>
 
 /*
- This register naming came from the intergrate cpu/controoler name TX4927
+ This register naming came from the integrated CPU/controller name TX4927
  followed by the device name from table 4.2.2 on page 4-3 and then followed
  by the register name from table 4.2.3 on pages 4-4 to 4-8.  The manaul
- used is "TMPR4927BT Preliminary Rev 0.1 20.Jul.2001".
+ used was "TMPR4927BT Preliminary Rev 0.1 20.Jul.2001".
  */
 
 #define TX4927_SIO_0_BASE
@@ -251,8 +251,8 @@
 
 /* TX4927 Timer 0 (32-bit registers) */
 #define TX4927_TMR0_BASE                0xf000
-#define TX4927_TMR0_TMTCR0              0xf004
-#define TX4927_TMR0_TMTISR0             0xf008
+#define TX4927_TMR0_TMTCR0              0xf000
+#define TX4927_TMR0_TMTISR0             0xf004
 #define TX4927_TMR0_TMCPRA0             0xf008
 #define TX4927_TMR0_TMCPRB0             0xf00c
 #define TX4927_TMR0_TMITMR0             0xf010
@@ -264,8 +264,8 @@
 
 /* TX4927 Timer 1 (32-bit registers) */
 #define TX4927_TMR1_BASE                0xf100
-#define TX4927_TMR1_TMTCR1              0xf104
-#define TX4927_TMR1_TMTISR1             0xf108
+#define TX4927_TMR1_TMTCR1              0xf100
+#define TX4927_TMR1_TMTISR1             0xf104
 #define TX4927_TMR1_TMCPRA1             0xf108
 #define TX4927_TMR1_TMCPRB1             0xf10c
 #define TX4927_TMR1_TMITMR1             0xf110
@@ -277,13 +277,12 @@
 
 /* TX4927 Timer 2 (32-bit registers) */
 #define TX4927_TMR2_BASE                0xf200
-#define TX4927_TMR2_TMTCR2              0xf104
-#define TX4927_TMR2_TMTISR2             0xf208
+#define TX4927_TMR2_TMTCR2              0xf200
+#define TX4927_TMR2_TMTISR2             0xf204
 #define TX4927_TMR2_TMCPRA2             0xf208
-#define TX4927_TMR2_TMCPRB2             0xf20c
 #define TX4927_TMR2_TMITMR2             0xf210
 #define TX4927_TMR2_TMCCDR2             0xf220
-#define TX4927_TMR2_TMPGMR2             0xf230
+#define TX4927_TMR2_TMWTMR2             0xf240
 #define TX4927_TMR2_TMTRR2              0xf2f0
 #define TX4927_TMR2_LIMIT               0xf2ff
 




--------------020302050802080405020302--
