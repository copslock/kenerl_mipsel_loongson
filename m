Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Oct 2006 17:12:29 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:24553 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037578AbWJ0QM0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Oct 2006 17:12:26 +0100
Received: from localhost (p4163-ipad03funabasi.chiba.ocn.ne.jp [219.160.84.163])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 406F6B5E5; Sat, 28 Oct 2006 01:12:10 +0900 (JST)
Date:	Sat, 28 Oct 2006 01:14:37 +0900 (JST)
Message-Id: <20061028.011437.39154325.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] mips hpt cleanup: get rid of mips_hpt_init
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 13109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Currently nobody outside time.c require mips_hpt_init().  Remove it
and call c0_hpt_timer_init() directly if R4k counter was used for
timer interrupt.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 arch/mips/kernel/time.c             |   22 ++++++++--------------
 arch/mips/pmc-sierra/yosemite/smp.c |    2 --
 include/asm-mips/time.h             |    1 -
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 2c6d52b..111d1ba 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -88,12 +88,6 @@ static unsigned int null_hpt_read(void)
 	return 0;
 }
 
-static void __init null_hpt_init(void)
-{
-	/* nothing */
-}
-
-
 /*
  * Timer ack for an R4k-compatible timer of a known frequency.
  */
@@ -133,7 +127,6 @@ static void __init c0_hpt_timer_init(voi
 int (*mips_timer_state)(void);
 void (*mips_timer_ack)(void);
 unsigned int (*mips_hpt_read)(void);
-void (*mips_hpt_init)(void) __initdata = null_hpt_init;
 unsigned int mips_hpt_mask = 0xffffffff;
 
 /* last time when xtime and rtc are sync'ed up */
@@ -376,16 +369,20 @@ void __init time_init(void)
 
 			if (!mips_timer_state) {
 				/* No external timer interrupt -- use R4k.  */
-				mips_hpt_init = c0_hpt_timer_init;
 				mips_timer_ack = c0_timer_ack;
+				/* Calculate cache parameters.  */
+				cycles_per_jiffy =
+					(mips_hpt_frequency + HZ / 2) / HZ;
+				/*
+				 * This sets up the high precision
+				 * timer for the first interrupt.
+				 */
+				c0_hpt_timer_init();
 			}
 		}
 		if (!mips_hpt_frequency)
 			mips_hpt_frequency = calibrate_hpt();
 
-		/* Calculate cache parameters.  */
-		cycles_per_jiffy = (mips_hpt_frequency + HZ / 2) / HZ;
-
 		/* Report the high precision timer rate for a reference.  */
 		printk("Using %u.%03u MHz high precision timer.\n",
 		       ((mips_hpt_frequency + 500) / 1000) / 1000,
@@ -396,9 +393,6 @@ void __init time_init(void)
 		/* No timer interrupt ack (e.g. i8254).  */
 		mips_timer_ack = null_timer_ack;
 
-	/* This sets up the high precision timer for the first interrupt.  */
-	mips_hpt_init();
-
 	/*
 	 * Call board specific timer interrupt setup.
 	 *
diff --git a/arch/mips/pmc-sierra/yosemite/smp.c b/arch/mips/pmc-sierra/yosemite/smp.c
index 3cc0436..305491e 100644
--- a/arch/mips/pmc-sierra/yosemite/smp.c
+++ b/arch/mips/pmc-sierra/yosemite/smp.c
@@ -99,8 +99,6 @@ void prom_cpus_done(void)
  */
 void prom_init_secondary(void)
 {
-	mips_hpt_init();
-
 	set_c0_status(ST0_CO | ST0_IE | ST0_IM);
 }
 
diff --git a/include/asm-mips/time.h b/include/asm-mips/time.h
index 625acd3..b58665e 100644
--- a/include/asm-mips/time.h
+++ b/include/asm-mips/time.h
@@ -48,7 +48,6 @@ extern void (*mips_timer_ack)(void);
  * If mips_hpt_read is NULL, an R4k-compatible timer setup is attempted.
  */
 extern unsigned int (*mips_hpt_read)(void);
-extern void (*mips_hpt_init)(void);
 extern unsigned int mips_hpt_mask;
 
 /*
