Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:56:37 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:14467 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225225AbTC0CzQ>;
	Thu, 27 Mar 2003 02:55:16 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id 6B3BA46A59; Thu, 27 Mar 2003 03:53:50 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: sgiserial 2/7 s/__INLINE__/inline/
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:53:50 +0100
Message-ID: <m28yv1eczl.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

s/_INLINE_/inline/


 build/drivers/sgi/char/sgiserial.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff -puN build/drivers/sgi/char/sgiserial.c~sgiserial__INLINE_ build/drivers/sgi/char/sgiserial.c
--- 24/build/drivers/sgi/char/sgiserial.c~sgiserial__INLINE_	2003-03-25 22:38:06.000000000 +0100
+++ 24-quintela/build/drivers/sgi/char/sgiserial.c	2003-03-25 22:39:04.000000000 +0100
@@ -118,8 +118,6 @@ static int serial_refcount;
 #define RS_STROBE_TIME 10
 #define RS_ISR_PASS_LIMIT 256
 
-#define _INLINE_ inline
-
 static void change_speed(struct sgi_serial *info);
 
 static struct tty_struct *serial_table[NUM_CHANNELS];
@@ -387,7 +385,7 @@ static inline void rs_recv_clear(struct 
  * This routine is used by the interrupt handler to schedule
  * processing in the software interrupt portion of the driver.
  */
-static _INLINE_ void rs_sched_event(struct sgi_serial *info,
+static inline void rs_sched_event(struct sgi_serial *info,
 				    int event)
 {
 	info->event |= 1 << event;
@@ -399,7 +397,7 @@ static _INLINE_ void rs_sched_event(stru
 extern void set_async_breakpoint(unsigned int epc);
 #endif
 
-static _INLINE_ void receive_chars(struct sgi_serial *info, struct pt_regs *regs)
+static inline void receive_chars(struct sgi_serial *info, struct pt_regs *regs)
 {
 	struct tty_struct *tty = info->tty;
 	volatile unsigned char junk;
@@ -460,7 +458,7 @@ clear_and_exit:
 	return;
 }
 
-static _INLINE_ void transmit_chars(struct sgi_serial *info)
+static inline void transmit_chars(struct sgi_serial *info)
 {
 	volatile unsigned char junk;
 
@@ -518,7 +516,7 @@ clear_and_return:
 	return;
 }
 
-static _INLINE_ void status_handle(struct sgi_serial *info)
+static inline void status_handle(struct sgi_serial *info)
 {
 	volatile unsigned char junk;
 	unsigned char status;

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
