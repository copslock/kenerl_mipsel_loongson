Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Sep 2005 05:46:27 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:52515
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224789AbVIEEqJ>; Mon, 5 Sep 2005 05:46:09 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 5 Sep 2005 04:54:27 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id A56F91F5CF;
	Mon,  5 Sep 2005 13:54:23 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 980BF1EFA1;
	Mon,  5 Sep 2005 13:54:23 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j854sMoj013106;
	Mon, 5 Sep 2005 13:54:23 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 05 Sep 2005 13:54:22 +0900 (JST)
Message-Id: <20050905.135422.112260934.nemoto@toshiba-tops.co.jp>
To:	spodstavin@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: a patch for generic MIPS RTC
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1124355290.5441.45.camel@localhost.localdomain>
References: <1124355290.5441.45.camel@localhost.localdomain>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 18 Aug 2005 12:54:50 +0400, Sergey Podstavin <spodstavin@ru.mvista.com> said:
spodstavin> genrtc doesn't work as a module because functions for
spodstavin> module defined in wrong place. Most architectures define
spodstavin> these functions in <asm/rtc.h>, so make MIPS follow their
spodstavin> example.  It makes the generic MIPS RTC working as a
spodstavin> module for MIPS.

It seems this fix already checked in, but I have some comments.

1. There are unnecessary (and conflicting) prototype declarations.

2. Define static variable mips_rtc_lock in rtc.h is generally a bad
   idea.  There is already rtc_lock in arch/mips/kernel/time.h.

3. We should protect rtc_set_mmss() call during get_rtc_time or
   set_rtc_time (this is not your patch's fault).

How about this patch?  The rtc_lock could be manipulated in each
RTC-dependent routines, but I choose a simple way for now.

---
Atsushi Nemoto


diff -u linux-mips/include/asm-mips/rtc.h linux/include/asm-mips/rtc.h
--- linux-mips/include/asm-mips/rtc.h	2005-09-05 10:17:18.000000000 +0900
+++ linux/include/asm-mips/rtc.h	2005-09-05 13:32:51.000000000 +0900
@@ -29,23 +29,18 @@
 #define RTC_24H 0x02            /* 24 hour mode - else hours bit 7 means pm */
 #define RTC_DST_EN 0x01         /* auto switch DST - works f. USA only */
 
-unsigned int get_rtc_time(struct rtc_time *time);
-int set_rtc_time(struct rtc_time *time);
-unsigned int get_rtc_ss(void);
-int get_rtc_pll(struct rtc_pll_info *pll);
-int set_rtc_pll(struct rtc_pll_info *pll);
-
-static DEFINE_SPINLOCK(mips_rtc_lock);
+extern spinlock_t rtc_lock;	/* in kernel/time.c */
 
 static inline unsigned int get_rtc_time(struct rtc_time *time)
 {
 	unsigned long nowtime;
+	unsigned long flags;
 
-	spin_lock(&mips_rtc_lock);
+	spin_lock_irqsave(&rtc_lock, flags);
 	nowtime = rtc_get_time();
 	to_tm(nowtime, time);
 	time->tm_year -= 1900;
-	spin_unlock(&mips_rtc_lock);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return RTC_24H;
 }
@@ -53,14 +48,15 @@
 static inline int set_rtc_time(struct rtc_time *time)
 {
 	unsigned long nowtime;
+	unsigned long flags;
 	int ret;
 
-	spin_lock(&mips_rtc_lock);
+	spin_lock_irqsave(&rtc_lock, flags);
 	nowtime = mktime(time->tm_year+1900, time->tm_mon+1,
 			time->tm_mday, time->tm_hour, time->tm_min,
 			time->tm_sec);
 	ret = rtc_set_time(nowtime);
-	spin_unlock(&mips_rtc_lock);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return ret;
 }
diff -u linux-mips/arch/mips/kernel/time.c linux/arch/mips/kernel/time.c
--- linux-mips/arch/mips/kernel/time.c	2005-08-30 11:02:01.000000000 +0900
+++ linux/arch/mips/kernel/time.c	2005-09-05 13:36:05.000000000 +0900
@@ -453,12 +453,14 @@
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
+		spin_lock(&rtc_lock);
 		if (rtc_set_mmss(xtime.tv_sec) == 0) {
 			last_rtc_update = xtime.tv_sec;
 		} else {
 			/* do it again in 60 s */
 			last_rtc_update = xtime.tv_sec - 600;
 		}
+		spin_unlock(&rtc_lock);
 	}
 	write_sequnlock(&xtime_lock);
 
