Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 23:17:33 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:54789 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3467599AbWBMXRW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 23:17:22 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 2D20C64D3D; Mon, 13 Feb 2006 23:23:39 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 161A38FB8; Mon, 13 Feb 2006 23:23:29 +0000 (GMT)
Date:	Mon, 13 Feb 2006 23:23:29 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: DECstation R3000 boot error
Message-ID: <20060213232329.GA8286@deprecation.cyrius.com>
References: <20060123225040.GA23576@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241059140.11021@blysk.ds.pg.gda.pl> <20060124122700.GA8527@deprecation.cyrius.com> <Pine.LNX.4.64N.0601241227290.11021@blysk.ds.pg.gda.pl> <20060124232117.GA4165@codecarver> <Pine.LNX.4.64N.0601251103020.7675@blysk.ds.pg.gda.pl> <20060203150232.GA25701@deprecation.cyrius.com> <Pine.LNX.4.64N.0602061021110.32080@blysk.ds.pg.gda.pl> <Pine.LNX.4.64N.0602130911260.17051@blysk.ds.pg.gda.pl> <20060213225927.GB4226@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060213225927.GB4226@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-02-13 22:59]:
> BTW, turning CONFIG_VT on leads to these compile errors:

OK, I got it down to:

  CC      drivers/tc/lk201.o
drivers/tc/lk201.c: In function ‘lk201_rx_char’:
drivers/tc/lk201.c:361: warning: implicit declaration of function ‘handle_scancode’
drivers/tc/lk201.c: In function ‘lk201_init’:
drivers/tc/lk201.c:405: error: invalid lvalue in assignment
drivers/tc/lk201.c:406: error: invalid lvalue in assignment
make[2]: *** [drivers/tc/lk201.o] Error 1

But this driver really needs to be ported to the new input interface.


--- a/drivers/tc/lk201.c~	2006-02-13 22:59:57.000000000 +0000
+++ b/drivers/tc/lk201.c	2006-02-13 23:21:54.000000000 +0000
@@ -16,11 +16,9 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/kbd_ll.h>
 #include <linux/kbd_kern.h>
 #include <linux/vt_kern.h>
 
-#include <asm/keyboard.h>
 #include <asm/dec/tc.h>
 #include <asm/dec/machtype.h>
 #include <asm/dec/serial.h>
@@ -186,28 +184,28 @@
 {
 	if (r->delay <= 0)
 		r->delay = kbdrate.delay;
-	if (r->rate <= 0)
-		r->rate = kbdrate.rate;
+	if (r->period <= 0)
+		r->period = kbdrate.period;
 
 	if (r->delay < 5)
 		r->delay = 5;
 	if (r->delay > 630)
 		r->delay = 630;
-	if (r->rate < 12)
-		r->rate = 12;
-	if (r->rate > 127)
-		r->rate = 127;
-	if (r->rate == 125)
-		r->rate = 124;
+	if (r->period < 12)
+		r->period = 12;
+	if (r->period > 127)
+		r->period = 127;
+	if (r->period == 125)
+		r->period = 124;
 }
 
 static int write_kbd_rate(struct kbd_repeat *rep)
 {
-	int delay, rate;
+	int delay, period;
 	int i;
 
 	delay = rep->delay / 5;
-	rate = rep->rate;
+	period = rep->period;
 	for (i = 0; i < 4; i++) {
 		if (lk201_hook.poll_tx_char(lk201_handle,
 					    LK_CMD_RPT_RATE(i)))
@@ -216,7 +214,7 @@
 					    LK_PARAM_DELAY(delay)))
 			return 1;
 		if (lk201_hook.poll_tx_char(lk201_handle,
-					    LK_PARAM_RATE(rate)))
+					    LK_PARAM_RATE(period)))
 			return 1;
 	}
 	return 0;


-- 
Martin Michlmayr
http://www.cyrius.com/
