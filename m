Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2018 09:09:23 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:43149
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990467AbeEDHJE0HN97 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 May 2018 09:09:04 +0200
Received: by mail-pf0-x244.google.com with SMTP id j20so2418835pff.10
        for <linux-mips@linux-mips.org>; Fri, 04 May 2018 00:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=e981n/FGMj7TdTdC/R2AWYgYOllNRbvv1lrXRNvnQG0=;
        b=dy5r82i4ND4RIJimH/Ma5mGyznMZnwcNZgrg6ly/vaC+GXQhLtYyqAvoUUqod2+oqi
         oRQPfjEmmELAPqVTsaAFgNIgBk3vE/7g8gQ5sp4ZctMnu/xtxG1u6QyZSI5G9WS2Mu0Q
         262jm78rCU8f8oldmrj8gBBTHhwW6rImQpfp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=e981n/FGMj7TdTdC/R2AWYgYOllNRbvv1lrXRNvnQG0=;
        b=DET5IC9I4bKPaAH+Q/z1LCa3H/+50m45xgO7Eo/fqq7p/56eBgkglOtrmxw6xBTB/V
         LVstwIDKTOM+TS9f9Sarf1RfZI+lNqrNmfnCitLNuxIPU9w/NSJYVN+lFSqw6TlLFRXP
         +Rh2etnvTQbwApMWVYtwcEh9jnDeQ22Pm7VmTiaWeJLrkya2Bqci1uDwDG+iXHjqK5D3
         Id5SXobc6UqnHnhAQWUn0v9zXHGExVLmKHWZfEeQFib373IysNFzlx7Xa8XLEZ/Ef4rQ
         MCmLEtb/P9/rmFV05bGsehzFyL/UuQdl/e6RuxFWn5RSPbu01eOJAA732Bl4GlJeOdMe
         A92Q==
X-Gm-Message-State: ALQs6tCh14+nT0OkHHlkzvONGKP4+Vxf7AcMyRRxnsdDbzMURTsbv+I3
        gppspHdLxj7RsJa9HG3NMCxuZA==
X-Google-Smtp-Source: AB8JxZqAuC/wyvODYqCkaBwoFZ7x1iw2zrVhqxoaYHan+BzRyUlpNHL/KoMaH20rUcmCMkzDz+echA==
X-Received: by 2002:a17:902:b788:: with SMTP id e8-v6mr27016005pls.263.1525417738266;
        Fri, 04 May 2018 00:08:58 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u188sm25718148pfb.84.2018.05.04.00.08.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 May 2018 00:08:57 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     macro@linux-mips.org, ralf@linux-mips.org, jhogan@kernel.org,
        chenhc@lemote.com
Cc:     kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, arnd@arndb.de,
        broonie@kernel.org, paul.burton@mips.com, heiko@sntech.de,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        baolin.wang@linaro.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] MIPS: Convert update_persistent_clock() to update_persistent_clock64()
Date:   Fri,  4 May 2018 15:07:48 +0800
Message-Id: <2d0bcca30f61036e413ba01c686ce6506f187462.1525417306.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525417306.git.baolin.wang@linaro.org>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525417306.git.baolin.wang@linaro.org>
In-Reply-To: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525417306.git.baolin.wang@linaro.org>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525417306.git.baolin.wang@linaro.org>
Return-Path: <baolin.wang@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baolin.wang@linaro.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Since struct timespec is not y2038 safe on 32bit machines, this patch
converts update_persistent_clock() to update_persistent_clock64() using
struct timespec64.

The rtc_mips_set_time() and rtc_mips_set_mmss() interfaces were using
'unsigned long' type that is not y2038 safe on 32bit machines, moreover
there is only one platform implementing rtc_mips_set_time() and two
platforms implementing rtc_mips_set_mmss(), so we can just make them each
implement update_persistent_clock64() directly, to get that helper out
of the common mips code by removing rtc_mips_set_time() and
rtc_mips_set_mmss() interfaces.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
 - Remove rtc_mips_set_time() and rtc_mips_set_mmss() interfaces.
---
 arch/mips/dec/time.c                   |    5 +++--
 arch/mips/include/asm/time.h           |    9 ---------
 arch/mips/kernel/time.c                |   15 ---------------
 arch/mips/lasat/ds1603.c               |    5 +++--
 arch/mips/lasat/sysctl.c               |    8 ++++++--
 arch/mips/sibyte/swarm/rtc_m41t81.c    |    4 ++--
 arch/mips/sibyte/swarm/rtc_xicor1241.c |    4 ++--
 arch/mips/sibyte/swarm/setup.c         |    8 +++++---
 8 files changed, 21 insertions(+), 37 deletions(-)

diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
index 9e992cf..934db6f 100644
--- a/arch/mips/dec/time.c
+++ b/arch/mips/dec/time.c
@@ -59,14 +59,15 @@ void read_persistent_clock64(struct timespec64 *ts)
 }
 
 /*
- * In order to set the CMOS clock precisely, rtc_mips_set_mmss has to
+ * In order to set the CMOS clock precisely, update_persistent_clock64 has to
  * be called 500 ms after the second nowtime has started, because when
  * nowtime is written into the registers of the CMOS clock, it will
  * jump to the next second precisely 500 ms later.  Check the Dallas
  * DS1287 data sheet for details.
  */
-int rtc_mips_set_mmss(unsigned long nowtime)
+int update_persistent_clock64(struct timespec64 now)
 {
+	time64_t nowtime = now.tv_sec;
 	int retval = 0;
 	int real_seconds, real_minutes, cmos_minutes;
 	unsigned char save_control, save_freq_select;
diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 17d4cd2..b85ec64 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -22,15 +22,6 @@
 extern spinlock_t rtc_lock;
 
 /*
- * RTC ops.  By default, they point to weak no-op RTC functions.
- *	rtc_mips_set_time - reverse the above translation and set time to RTC.
- *	rtc_mips_set_mmss - similar to rtc_set_time, but only min and sec need
- *			to be set.  Used by RTC sync-up.
- */
-extern int rtc_mips_set_time(unsigned long);
-extern int rtc_mips_set_mmss(unsigned long);
-
-/*
  * board specific routines required by time_init().
  */
 extern void plat_time_init(void);
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index a6ebc81..bfe02de 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -34,21 +34,6 @@
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
-int __weak rtc_mips_set_time(unsigned long sec)
-{
-	return -ENODEV;
-}
-
-int __weak rtc_mips_set_mmss(unsigned long nowtime)
-{
-	return rtc_mips_set_time(nowtime);
-}
-
-int update_persistent_clock(struct timespec now)
-{
-	return rtc_mips_set_mmss(now.tv_sec);
-}
-
 static int null_perf_irq(void)
 {
 	return 0;
diff --git a/arch/mips/lasat/ds1603.c b/arch/mips/lasat/ds1603.c
index d75c887..061815e 100644
--- a/arch/mips/lasat/ds1603.c
+++ b/arch/mips/lasat/ds1603.c
@@ -98,7 +98,7 @@ static void rtc_write_byte(unsigned int byte)
 	}
 }
 
-static void rtc_write_word(unsigned long word)
+static void rtc_write_word(time64_t word)
 {
 	int i;
 
@@ -152,8 +152,9 @@ void read_persistent_clock64(struct timespec64 *ts)
 	ts->tv_nsec = 0;
 }
 
-int rtc_mips_set_mmss(unsigned long time)
+int update_persistent_clock64(struct timespec64 now)
 {
+	time64_t time = now.tv_sec;
 	unsigned long flags;
 
 	spin_lock_irqsave(&rtc_lock, flags);
diff --git a/arch/mips/lasat/sysctl.c b/arch/mips/lasat/sysctl.c
index 6f74224..76f7b62 100644
--- a/arch/mips/lasat/sysctl.c
+++ b/arch/mips/lasat/sysctl.c
@@ -73,8 +73,12 @@ int proc_dolasatrtc(struct ctl_table *table, int write,
 	if (r)
 		return r;
 
-	if (write)
-		rtc_mips_set_mmss(rtctmp);
+	if (write) {
+		ts.tv_sec = rtctmp;
+		ts.tv_nsec = 0;
+
+		update_persistent_clock64(ts);
+	}
 
 	return 0;
 }
diff --git a/arch/mips/sibyte/swarm/rtc_m41t81.c b/arch/mips/sibyte/swarm/rtc_m41t81.c
index aa27a22..4ac8ccd 100644
--- a/arch/mips/sibyte/swarm/rtc_m41t81.c
+++ b/arch/mips/sibyte/swarm/rtc_m41t81.c
@@ -141,13 +141,13 @@ static int m41t81_write(uint8_t addr, int b)
 	return 0;
 }
 
-int m41t81_set_time(unsigned long t)
+int m41t81_set_time(time64_t t)
 {
 	struct rtc_time tm;
 	unsigned long flags;
 
 	/* Note we don't care about the century */
-	rtc_time_to_tm(t, &tm);
+	rtc_time64_to_tm(t, &tm);
 
 	/*
 	 * Note the write order matters as it ensures the correctness.
diff --git a/arch/mips/sibyte/swarm/rtc_xicor1241.c b/arch/mips/sibyte/swarm/rtc_xicor1241.c
index a2121c1..2dcaaa7 100644
--- a/arch/mips/sibyte/swarm/rtc_xicor1241.c
+++ b/arch/mips/sibyte/swarm/rtc_xicor1241.c
@@ -109,13 +109,13 @@ static int xicor_write(uint8_t addr, int b)
 	}
 }
 
-int xicor_set_time(unsigned long t)
+int xicor_set_time(time64_t t)
 {
 	struct rtc_time tm;
 	int tmp;
 	unsigned long flags;
 
-	rtc_time_to_tm(t, &tm);
+	rtc_time64_to_tm(t, &tm);
 	tm.tm_year += 1900;
 
 	spin_lock_irqsave(&rtc_lock, flags);
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 7073940..152ca71 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -57,11 +57,11 @@
 #endif
 
 extern int xicor_probe(void);
-extern int xicor_set_time(unsigned long);
+extern int xicor_set_time(time64_t);
 extern time64_t xicor_get_time(void);
 
 extern int m41t81_probe(void);
-extern int m41t81_set_time(unsigned long);
+extern int m41t81_set_time(time64_t);
 extern time64_t m41t81_get_time(void);
 
 const char *get_system_type(void)
@@ -109,8 +109,10 @@ void read_persistent_clock64(struct timespec64 *ts)
 	ts->tv_nsec = 0;
 }
 
-int rtc_mips_set_time(unsigned long sec)
+int update_persistent_clock64(struct timespec64 now)
 {
+	time64_t sec = now.tv_sec;
+
 	switch (swarm_rtc_type) {
 	case RTC_XICOR:
 		return xicor_set_time(sec);
-- 
1.7.9.5
