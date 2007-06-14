Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 11:20:57 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:32579 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022751AbXFNKUl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 11:20:41 +0100
Received: by ug-out-1314.google.com with SMTP id m3so647570ugc
        for <linux-mips@linux-mips.org>; Thu, 14 Jun 2007 03:19:40 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=Wc26omsWJh32yY3Lj6Mji+GOfieHTmhlWzKV261sALs+5lNmknarOKaNiy9O0Lk3AqaxL+oPypDDtzkmXM0rs7atHajG1HLwmQ9M+snKbA3UNYQazReWWxqJA/wZpaA8LqQLpaM60TY4wAQq7umb1dztOWctZ9NVmFayb5pQV9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=eoMXWOqruUxa60OFEXyEPwH7hBXKHdP2SSW6nykubpt0hSBe3ObEcnWHuzPWQ3wU00tJxBq84Om9qCUr0vOv5pfZ+NIIxi1bHWHd5/M2FyKtJ1+OiPlzA0vVJn9lvSvS3Ogq3m6PWvuTWvtvwTy1XFFr5G1WSGAKEAVFtFqfa5I=
Received: by 10.67.103.16 with SMTP id f16mr1970272ugm.1181816380692;
        Thu, 14 Jun 2007 03:19:40 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id y37sm3882209iky.2007.06.14.03.19.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2007 03:19:40 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 3948123F76A; Thu, 14 Jun 2007 12:20:02 +0200 (CEST)
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/5] Use generic NTP code for all MIPS platforms
Date:	Thu, 14 Jun 2007 12:19:57 +0200
Message-Id: <11818164021503-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11818164011355-git-send-email-fbuihuu@gmail.com>
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Ralf Baechle <ralf@linux-mips.org>

---
 arch/mips/Kconfig               |    4 ++++
 arch/mips/kernel/time.c         |   24 ++++--------------------
 arch/mips/sgi-ip27/ip27-timer.c |   18 ------------------
 3 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index da253bc..7bcf38d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -723,6 +723,10 @@ config GENERIC_TIME
 	bool
 	default y
 
+config GENERIC_CMOS_UPDATE
+	bool
+	default y
+
 config SCHED_NO_NO_OMIT_FRAME_POINTER
 	bool
 	default y
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 7def1ff..376e127 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -66,6 +66,10 @@ unsigned long (*rtc_mips_get_time)(void) = null_rtc_get_time;
 int (*rtc_mips_set_time)(unsigned long) = null_rtc_set_time;
 int (*rtc_mips_set_mmss)(unsigned long);
 
+int update_persistent_clock(struct timespec now)
+{
+	return rtc_mips_set_mmss(now.tv_sec);
+}
 
 /* how many counter cycles in a jiffy */
 static unsigned long cycles_per_jiffy __read_mostly;
@@ -124,9 +128,6 @@ static void __init c0_hpt_timer_init(void)
 int (*mips_timer_state)(void);
 void (*mips_timer_ack)(void);
 
-/* last time when xtime and rtc are sync'ed up */
-static long last_rtc_update;
-
 /*
  * local_timer_interrupt() does profiling and process accounting
  * on a per-CPU basis.
@@ -158,23 +159,6 @@ irqreturn_t timer_interrupt(int irq, void *dev_id)
 	 */
 	do_timer(1);
 
-	/*
-	 * If we have an externally synchronized Linux clock, then update
-	 * CMOS clock accordingly every ~11 minutes. rtc_mips_set_time() has to be
-	 * called as close as possible to 500 ms before the new second starts.
-	 */
-	if (ntp_synced() &&
-	    xtime.tv_sec > last_rtc_update + 660 &&
-	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
-	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
-		if (rtc_mips_set_mmss(xtime.tv_sec) == 0) {
-			last_rtc_update = xtime.tv_sec;
-		} else {
-			/* do it again in 60 s */
-			last_rtc_update = xtime.tv_sec - 600;
-		}
-	}
-
 	write_sequnlock(&xtime_lock);
 
 	/*
diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 8c3c78c..3134616 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -40,7 +40,6 @@
 #define TICK_SIZE (tick_nsec / 1000)
 
 static unsigned long ct_cur[NR_CPUS];	/* What counter should be at next timer irq */
-static long last_rtc_update;		/* Last time the rtc clock got updated */
 
 #if 0
 static int set_rtc_mmss(unsigned long nowtime)
@@ -113,23 +112,6 @@ again:
 
 	update_process_times(user_mode(get_irq_regs()));
 
-	/*
-	 * If we have an externally synchronized Linux clock, then update
-	 * RTC clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
-	 * called as close as possible to when a second starts.
-	 */
-	if (ntp_synced() &&
-	    xtime.tv_sec > last_rtc_update + 660 &&
-	    (xtime.tv_nsec / 1000) >= 500000 - ((unsigned) TICK_SIZE) / 2 &&
-	    (xtime.tv_nsec / 1000) <= 500000 + ((unsigned) TICK_SIZE) / 2) {
-		if (rtc_mips_set_time(xtime.tv_sec) == 0) {
-			last_rtc_update = xtime.tv_sec;
-		} else {
-			last_rtc_update = xtime.tv_sec - 600;
-			/* do it again in 60 s */
-		}
-	}
-
 	write_sequnlock(&xtime_lock);
 	irq_exit();
 }
-- 
1.5.2.1
