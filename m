Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2005 16:03:22 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:49915 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133803AbVKBQDC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Nov 2005 16:03:02 +0000
Received: from localhost (p4242-ipad211funabasi.chiba.ocn.ne.jp [58.91.160.242])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D0701891E; Thu,  3 Nov 2005 01:03:41 +0900 (JST)
Date:	Thu, 03 Nov 2005 01:02:40 +0900 (JST)
Message-Id: <20051103.010240.41630907.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] remove mips_rtc_lock
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
X-archive-position: 9404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The mips_rtc_lock is no longer needed because RTC operations should be
protected already by other mechanism. (rtc_lock, local_irq_save, etc.)

Also, locking whole rtc_get_time/rtc_set_time should be avoided while
some RTC routines might take very long time (a few seconds).

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/rtc.h b/include/asm-mips/rtc.h
--- a/include/asm-mips/rtc.h
+++ b/include/asm-mips/rtc.h
@@ -14,7 +14,6 @@
 
 #ifdef __KERNEL__
 
-#include <linux/spinlock.h>
 #include <linux/rtc.h>
 #include <asm/time.h>
 
@@ -29,17 +28,13 @@
 #define RTC_24H 0x02            /* 24 hour mode - else hours bit 7 means pm */
 #define RTC_DST_EN 0x01         /* auto switch DST - works f. USA only */
 
-static DEFINE_SPINLOCK(mips_rtc_lock);
-
 static inline unsigned int get_rtc_time(struct rtc_time *time)
 {
 	unsigned long nowtime;
 
-	spin_lock(&mips_rtc_lock);
 	nowtime = rtc_get_time();
 	to_tm(nowtime, time);
 	time->tm_year -= 1900;
-	spin_unlock(&mips_rtc_lock);
 
 	return RTC_24H;
 }
@@ -49,12 +44,10 @@ static inline int set_rtc_time(struct rt
 	unsigned long nowtime;
 	int ret;
 
-	spin_lock(&mips_rtc_lock);
 	nowtime = mktime(time->tm_year+1900, time->tm_mon+1,
 			time->tm_mday, time->tm_hour, time->tm_min,
 			time->tm_sec);
 	ret = rtc_set_time(nowtime);
-	spin_unlock(&mips_rtc_lock);
 
 	return ret;
 }
