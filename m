Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:57:58 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:16515 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225230AbTC0Czz>;
	Thu, 27 Mar 2003 02:55:55 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 1511546A59; Thu, 27 Mar 2003 03:54:29 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: sgiserial 6/7: Remove declare only stuff
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:54:29 +0100
Message-ID: <m21y0tecyi.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

This defines are not used in the driver at all.

 build/drivers/sgi/char/sgiserial.c |    8 --------
 1 files changed, 8 deletions(-)

diff -puN build/drivers/sgi/char/sgiserial.c~sgiserial_removing_unused_stuff build/drivers/sgi/char/sgiserial.c
--- 24/build/drivers/sgi/char/sgiserial.c~sgiserial_removing_unused_stuff	2003-03-24 02:15:37.000000000 +0100
+++ 24-quintela/build/drivers/sgi/char/sgiserial.c	2003-03-24 02:16:42.000000000 +0100
@@ -108,15 +108,7 @@ static int serial_refcount;
 /* number of characters left in xmit buffer before we ask for more */
 #define WAKEUP_CHARS 256
 
-/* Debugging... DEBUG_INTR is bad to use when one of the zs
- * lines is your console ;(
- */
-#undef SERIAL_DEBUG_INTR
 #undef SERIAL_DEBUG_OPEN
-#undef SERIAL_DEBUG_FLOW
-
-#define RS_STROBE_TIME 10
-#define RS_ISR_PASS_LIMIT 256
 
 static void change_speed(struct sgi_serial *info);
 

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
