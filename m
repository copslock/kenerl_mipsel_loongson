Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:57:18 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:15491 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225228AbTC0Czo>;
	Thu, 27 Mar 2003 02:55:44 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id C6BD146A59; Thu, 27 Mar 2003 03:54:17 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: sgiserial 4/7: s/MIN/min/
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:54:17 +0100
Message-ID: <m24r5pecyu.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

use min() instead of local defined MIN().


 build/drivers/sgi/char/sgiserial.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff -puN build/drivers/sgi/char/sgiserial.c~sgiserial_MIN build/drivers/sgi/char/sgiserial.c
--- 24/build/drivers/sgi/char/sgiserial.c~sgiserial_MIN	2003-03-22 02:02:12.000000000 +0100
+++ 24-quintela/build/drivers/sgi/char/sgiserial.c	2003-03-22 02:02:53.000000000 +0100
@@ -124,10 +124,6 @@ static struct tty_struct *serial_table[N
 static struct termios *serial_termios[NUM_CHANNELS];
 static struct termios *serial_termios_locked[NUM_CHANNELS];
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 /*
  * tmp_buf is used as a temporary buffer by serial_write.  We need to
  * lock it in case the memcpy_fromfs blocks while swapping in a page,
@@ -985,7 +981,7 @@ static void rs_fair_output(void)
 		zs_cons_put_char(c);
 
 		save_flags(flags);  cli();
-		left = MIN(info->xmit_cnt, left-1);
+		left = min(info->xmit_cnt, left-1);
 	}
 
 	/* Last character is being transmitted now (hopefully). */
@@ -1014,7 +1010,7 @@ static int rs_write(struct tty_struct * 
 	save_flags(flags);
 	while (1) {
 		cli();
-		c = MIN(count, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+		c = min(count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 				   SERIAL_XMIT_SIZE - info->xmit_head));
 		if (c <= 0)
 			break;
@@ -1022,7 +1018,7 @@ static int rs_write(struct tty_struct * 
 		if (from_user) {
 			down(&tmp_buf_sem);
 			copy_from_user(tmp_buf, buf, c);
-			c = MIN(c, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+			c = min(c, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 				       SERIAL_XMIT_SIZE - info->xmit_head));
 			memcpy(info->xmit_buf + info->xmit_head, tmp_buf, c);
 			up(&tmp_buf_sem);

_

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
