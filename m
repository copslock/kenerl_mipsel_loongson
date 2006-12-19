Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Dec 2006 17:15:18 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:45506 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28577424AbWLSRPN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Dec 2006 17:15:13 +0000
Received: from localhost (p7053-ipad211funabasi.chiba.ocn.ne.jp [58.91.163.53])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BCFCABA9E; Wed, 20 Dec 2006 02:15:08 +0900 (JST)
Date:	Wed, 20 Dec 2006 02:15:08 +0900 (JST)
Message-Id: <20061220.021508.97296486.anemo@mba.ocn.ne.jp>
To:	danieljlaird@hotmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: 2.6.19 timer API changes
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <7949125.post@talk.nabble.com>
References: <20061219.233410.25911550.anemo@mba.ocn.ne.jp>
	<20061220.000113.59033093.anemo@mba.ocn.ne.jp>
	<7949125.post@talk.nabble.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 19 Dec 2006 07:34:54 -0800 (PST), Daniel Laird <danieljlaird@hotmail.com> wrote:
> I am just digging out the mips core user manual...  
> However I have tried this change you suggested, it still takes a long time
> to get past the calibrate delay function (~10seconds).
> However after this it seems to run at full speed where as before it used to
> run very slow.
> So an improvement, I think this does mean the new time.c has broken 8550
> support hopefully I can find otu what the core does so it can be fixed.

Hm, then it seems writing to COMPARE does not clear COUNT.

How about this?  You should still fix pnx8550_hpt_read() anyway, but I
suppose gettimeofday() on PNX8550 was broken long time.


Subject: [MIPS] Use custom timer_ack and clocksource_mips.read for PNX8550

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 11aab6d..8aa544f 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -94,10 +94,8 @@ static void c0_timer_ack(void)
 {
 	unsigned int count;
 
-#ifndef CONFIG_SOC_PNX8550	/* pnx8550 resets to zero */
 	/* Ack this timer interrupt and set the next one.  */
 	expirelo += cycles_per_jiffy;
-#endif
 	write_c0_compare(expirelo);
 
 	/* Check to see if we have missed any timer interrupts.  */
diff --git a/arch/mips/philips/pnx8550/common/time.c b/arch/mips/philips/pnx8550/common/time.c
index 65c440e..e86905a 100644
--- a/arch/mips/philips/pnx8550/common/time.c
+++ b/arch/mips/philips/pnx8550/common/time.c
@@ -33,7 +33,18 @@ #include <asm/debug.h>
 #include <int.h>
 #include <cm.h>
 
-extern unsigned int mips_hpt_frequency;
+static unsigned long cycles_per_jiffy __read_mostly;
+
+static void pnx8550_timer_ack(void)
+{
+	write_c0_compare(cycles_per_jiffy);
+}
+
+static cycle_t pnx8550_hpt_read(void)
+{
+	/* FIXME: we should use timer2 or timer3 as freerun counter */
+	return read_c0_count();
+}
 
 /*
  * pnx8550_time_init() - it does the following things:
@@ -68,6 +79,11 @@ void pnx8550_time_init(void)
 	 * HZ timer interrupts per second.
 	 */
 	mips_hpt_frequency = 27UL * ((1000000UL * n)/(m * pow2p));
+	cycles_per_jiffy = (mips_hpt_frequency + HZ / 2) / HZ;
+	clocksource_mips.read = pnx8550_hpt_read;
+	mips_timer_ack = pnx8550_timer_ack;
+	write_c0_count(0);
+	write_c0_compare(cycles_per_jiffy);
 }
 
 void __init plat_timer_setup(struct irqaction *irq)
