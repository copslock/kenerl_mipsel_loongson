Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:56:17 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:13955 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225222AbTC0CzJ>;
	Thu, 27 Mar 2003 02:55:09 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 4058546A59; Thu, 27 Mar 2003 03:53:43 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: sgiserial 1/7: flags are unsigned long
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:53:43 +0100
Message-ID: <m2adfheczs.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

flags should be long, not int.


 build/drivers/sgi/char/sgiserial.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -puN build/drivers/sgi/char/sgiserial.c~sgserial_flags build/drivers/sgi/char/sgiserial.c
--- 24/build/drivers/sgi/char/sgiserial.c~sgserial_flags	2003-03-22 01:37:45.000000000 +0100
+++ 24-quintela/build/drivers/sgi/char/sgiserial.c	2003-03-22 01:43:17.000000000 +0100
@@ -886,7 +886,8 @@ static void zs_cons_put_char(char ch)
 {
 	struct sgi_zschannel *chan = zs_conschan;
 	volatile unsigned char junk;
-	int flags, loops = 0;
+	unsigned long flags;
+	int loops = 0;
 
 	save_flags(flags); cli();
 	while(((junk = chan->control) & Tx_BUF_EMP)==0 && loops < 10000) {
@@ -911,7 +912,8 @@ static void rs_put_char(struct tty_struc
 	struct sgi_zschannel *chan =
 		((struct sgi_serial *)tty->driver_data)->zs_channel;
 	volatile unsigned char junk;
-	int flags, loops = 0;
+	unsigned long flags;
+	int loops = 0;
 
 	save_flags(flags); cli();
 	while(((junk = chan->control) & Tx_BUF_EMP)==0 && loops < 10000) {
@@ -1854,7 +1856,8 @@ volatile int test_done;
 /* rs_init inits the driver */
 int rs_init(void)
 {
-	int chip, channel, i, flags;
+	unsigned long flags;
+	int chip, channel, i;
 	struct sgi_serial *info;
 
 

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
