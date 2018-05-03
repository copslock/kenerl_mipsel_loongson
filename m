Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 May 2018 04:55:15 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:39910
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992336AbeECCyyqCOQD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 May 2018 04:54:54 +0200
Received: by mail-pg0-x242.google.com with SMTP id e1-v6so700774pga.6
        for <linux-mips@linux-mips.org>; Wed, 02 May 2018 19:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=cQ+5/kQaK3QLhGVNWvUfqX3223qL2I21JjAReG4Mla4=;
        b=CVsErqug8+kFr7l9LLXwmmBLKfqJSoMHVPNxWsw7U3N9PJxfnG0Hepx8GBOmNtGrS4
         co6o8DSuTYk+2XPp1Zf53misJIo1C7xPiU2zYuRNCD171U8z++G+hPweQuKl4YgVfmAx
         9MecpES//iABv+o5zvl8/E5nC1vYLbyCpDTQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=cQ+5/kQaK3QLhGVNWvUfqX3223qL2I21JjAReG4Mla4=;
        b=tSzdH1dTgEHMR71kW9TXulqlbgyyxxIC7h5INTCcT5E17i9GPdMAX7jy36sgit2vou
         sWN0ZKOXJFm/0x3ljqv1JhUVyY3rDTcvDaT6hQXwsT8EkUaUAiwg2ey7E8T7JaUKE3TJ
         2v2tGilVNN/FNViie3azrMJui2scRBE4fOvNWPsC0DQXfXVQrJkkPyJHwmPuwVwArfiD
         OG7wGpMUX49nul3038vnhoeTwLdyktqrJuNGi5TXDC372D481/0/vKHlavrq9yq7claO
         dHReh0Ta4NJABhbppUXDtxWDqdjMw9NEmhcQO3KV7ZUGfput/oTotgrm0SHpVrxAXQc2
         e2TQ==
X-Gm-Message-State: ALQs6tCLISdgNnGH4sjaDNdkiKGSsbWG7qTwVJ6TSfH1vcK921n7Z1Ll
        dZBrXpLz83WlPPw3fh9w+cKeZA==
X-Google-Smtp-Source: AB8JxZq/wwbIpC0ucRSbEUPpkUbK00xI6UmJLWQVwijksudA7qlvNLCM7+Bum19syZ0FhFGIjcuGvQ==
X-Received: by 2002:a17:902:6b04:: with SMTP id o4-v6mr3351603plk.101.1525316088625;
        Wed, 02 May 2018 19:54:48 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s189-v6sm21236971pgc.39.2018.05.02.19.54.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 May 2018 19:54:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     macro@linux-mips.org, ralf@linux-mips.org, jhogan@kernel.org,
        chenhc@lemote.com
Cc:     kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, arnd@arndb.de,
        broonie@kernel.org, paul.burton@mips.com, heiko@sntech.de,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        baolin.wang@linaro.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: Convert update_persistent_clock() to update_persistent_clock64()
Date:   Thu,  3 May 2018 10:53:18 +0800
Message-Id: <e8ddeeea84626e43dcac4f0731992cbad932ce7a.1525262725.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525262725.git.baolin.wang@linaro.org>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525262725.git.baolin.wang@linaro.org>
In-Reply-To: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525262725.git.baolin.wang@linaro.org>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525262725.git.baolin.wang@linaro.org>
Return-Path: <baolin.wang@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63853
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

This patch also changes rtc_mips_set_time()/rtc_mips_set_mmss() interfaces
to use time64_t, which is y2038 safe.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/mips/dec/time.c                   |    2 +-
 arch/mips/include/asm/time.h           |    4 ++--
 arch/mips/kernel/time.c                |    6 +++---
 arch/mips/lasat/ds1603.c               |    4 ++--
 arch/mips/lasat/sysctl.c               |    6 +++---
 arch/mips/sibyte/swarm/rtc_m41t81.c    |    4 ++--
 arch/mips/sibyte/swarm/rtc_xicor1241.c |    4 ++--
 arch/mips/sibyte/swarm/setup.c         |    6 +++---
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
index 9e992cf..c2d6ec8 100644
--- a/arch/mips/dec/time.c
+++ b/arch/mips/dec/time.c
@@ -65,7 +65,7 @@ void read_persistent_clock64(struct timespec64 *ts)
  * jump to the next second precisely 500 ms later.  Check the Dallas
  * DS1287 data sheet for details.
  */
-int rtc_mips_set_mmss(unsigned long nowtime)
+int rtc_mips_set_mmss(time64_t nowtime)
 {
 	int retval = 0;
 	int real_seconds, real_minutes, cmos_minutes;
diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 17d4cd2..c4e2a1a 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -27,8 +27,8 @@
  *	rtc_mips_set_mmss - similar to rtc_set_time, but only min and sec need
  *			to be set.  Used by RTC sync-up.
  */
-extern int rtc_mips_set_time(unsigned long);
-extern int rtc_mips_set_mmss(unsigned long);
+extern int rtc_mips_set_time(time64_t);
+extern int rtc_mips_set_mmss(time64_t);
 
 /*
  * board specific routines required by time_init().
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index a6ebc81..01ba5ab 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -34,17 +34,17 @@
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
-int __weak rtc_mips_set_time(unsigned long sec)
+int __weak rtc_mips_set_time(time64_t sec)
 {
 	return -ENODEV;
 }
 
-int __weak rtc_mips_set_mmss(unsigned long nowtime)
+int __weak rtc_mips_set_mmss(time64_t nowtime)
 {
 	return rtc_mips_set_time(nowtime);
 }
 
-int update_persistent_clock(struct timespec now)
+int update_persistent_clock64(struct timespec64 now)
 {
 	return rtc_mips_set_mmss(now.tv_sec);
 }
diff --git a/arch/mips/lasat/ds1603.c b/arch/mips/lasat/ds1603.c
index d75c887..580cf3a 100644
--- a/arch/mips/lasat/ds1603.c
+++ b/arch/mips/lasat/ds1603.c
@@ -98,7 +98,7 @@ static void rtc_write_byte(unsigned int byte)
 	}
 }
 
-static void rtc_write_word(unsigned long word)
+static void rtc_write_word(time64_t word)
 {
 	int i;
 
@@ -152,7 +152,7 @@ void read_persistent_clock64(struct timespec64 *ts)
 	ts->tv_nsec = 0;
 }
 
-int rtc_mips_set_mmss(unsigned long time)
+int rtc_mips_set_mmss(time64_t time)
 {
 	unsigned long flags;
 
diff --git a/arch/mips/lasat/sysctl.c b/arch/mips/lasat/sysctl.c
index 6f74224..4264107 100644
--- a/arch/mips/lasat/sysctl.c
+++ b/arch/mips/lasat/sysctl.c
@@ -53,7 +53,7 @@ int proc_dolasatstring(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_DS1603
-static int rtctmp;
+static time64_t rtctmp;
 
 /* proc function to read/write RealTime Clock */
 int proc_dolasatrtc(struct ctl_table *table, int write,
@@ -69,7 +69,7 @@ int proc_dolasatrtc(struct ctl_table *table, int write,
 		if (rtctmp < 0)
 			rtctmp = 0;
 	}
-	r = proc_dointvec(table, write, buffer, lenp, ppos);
+	r = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 	if (r)
 		return r;
 
@@ -224,7 +224,7 @@ int proc_lasat_prid(struct ctl_table *table, int write,
 	{
 		.procname	= "rtc",
 		.data		= &rtctmp,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(time64_t),
 		.mode		= 0644,
 		.proc_handler	= proc_dolasatrtc,
 	},
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
index 7073940..f356ecd 100644
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
@@ -109,7 +109,7 @@ void read_persistent_clock64(struct timespec64 *ts)
 	ts->tv_nsec = 0;
 }
 
-int rtc_mips_set_time(unsigned long sec)
+int rtc_mips_set_time(time64_t sec)
 {
 	switch (swarm_rtc_type) {
 	case RTC_XICOR:
-- 
1.7.9.5
