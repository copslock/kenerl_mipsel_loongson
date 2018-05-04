Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2018 09:09:09 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:39603
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990427AbeEDHI7hrFY7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 May 2018 09:08:59 +0200
Received: by mail-pf0-x243.google.com with SMTP id a22so2631635pfn.6
        for <linux-mips@linux-mips.org>; Fri, 04 May 2018 00:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3aiI3kiE6HByxIoW7A57wa5Bds4Ky7Z3/xIJUax8Rdk=;
        b=GwLK/2F4O0Wk9YSlLxUTfk9gTskEk9t6ueGIG/HN4Zclv04W9DWfBJz7gjoJOEwZEZ
         IgDvpsPguqGqSTIaPS1qhkLsTr0pyyvDsvgLWKm8+NhZcD52iXxWr8VMgeojyYXgdW50
         B2lefU8L7Le8VOFHcH6Q/KkXw+vHQvVOybmgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3aiI3kiE6HByxIoW7A57wa5Bds4Ky7Z3/xIJUax8Rdk=;
        b=qNTUW4yzLm9WRyqZmkEmjn0Jx2RX/C2J1L/D7RkZuo7hmN2pKRIPbzaaKIRiHlrrLp
         TqG7DTskwoOB/CNL8TVPAyheDhCRlWNEesU6386J+8yxv9/lt3jJsRvvLNc9HzCOYNbM
         w+LXuT373TfNylxVslU04Bx85yBF71yMA8ZbfGgeilxB4jrDHMGocF4dMxvXLo/EnHnA
         LdTA7PBPhfr2mCf3aWdR46vK9qg26l2x8KJvQ8PUBXh/a7VSLBl6v+pHvTrvUE6FO2ft
         L0hQOIMJo6DEsQlWE5Vt35ocN6YOk0sFmfZ1Izo1DAdzcDW/HFxcEHb+8jiVxcqJ/EUJ
         pXlA==
X-Gm-Message-State: ALQs6tDgJstzLkArFQnbffxaslc+oBi9Og13l2+KZVUaqyGRd7VOS6yw
        XhJ9UZx+ACAvorjtnoN8PebP0w==
X-Google-Smtp-Source: AB8JxZrF1hLVhXKPACndQwm2/aQ85kkTaIP/LYhutjG7PVXYs6Mon5ZKVBxWSRUx6PKeCOBGQvmNVw==
X-Received: by 10.98.86.16 with SMTP id k16mr25714784pfb.19.1525417732943;
        Fri, 04 May 2018 00:08:52 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u188sm25718148pfb.84.2018.05.04.00.08.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 May 2018 00:08:52 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     macro@linux-mips.org, ralf@linux-mips.org, jhogan@kernel.org,
        chenhc@lemote.com
Cc:     kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, arnd@arndb.de,
        broonie@kernel.org, paul.burton@mips.com, heiko@sntech.de,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        baolin.wang@linaro.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] MIPS: Convert read_persistent_clock() to read_persistent_clock64()
Date:   Fri,  4 May 2018 15:07:47 +0800
Message-Id: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525417306.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <baolin.wang@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63861
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
converts read_persistent_clock() to read_persistent_clock64() using
struct timespec64, as well as converting mktime() to mktime64().

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
 - No updates.
---
 arch/mips/dec/time.c                   |    4 ++--
 arch/mips/include/asm/mc146818-time.h  |    4 ++--
 arch/mips/lasat/ds1603.c               |    2 +-
 arch/mips/loongson64/common/time.c     |    2 +-
 arch/mips/mti-malta/malta-time.c       |    2 +-
 arch/mips/sibyte/swarm/rtc_m41t81.c    |    4 ++--
 arch/mips/sibyte/swarm/rtc_xicor1241.c |    4 ++--
 arch/mips/sibyte/swarm/setup.c         |   10 +++++-----
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
index a2a150e..9e992cf 100644
--- a/arch/mips/dec/time.c
+++ b/arch/mips/dec/time.c
@@ -19,7 +19,7 @@
 #include <asm/dec/ioasic.h>
 #include <asm/dec/machtype.h>
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	unsigned int year, mon, day, hour, min, sec, real_year;
 	unsigned long flags;
@@ -54,7 +54,7 @@ void read_persistent_clock(struct timespec *ts)
 
 	year += real_year - 72 + 2000;
 
-	ts->tv_sec = mktime(year, mon, day, hour, min, sec);
+	ts->tv_sec = mktime64(year, mon, day, hour, min, sec);
 	ts->tv_nsec = 0;
 }
 
diff --git a/arch/mips/include/asm/mc146818-time.h b/arch/mips/include/asm/mc146818-time.h
index 9e1ad26..cbf5cec 100644
--- a/arch/mips/include/asm/mc146818-time.h
+++ b/arch/mips/include/asm/mc146818-time.h
@@ -86,7 +86,7 @@ static inline int mc146818_set_rtc_mmss(unsigned long nowtime)
 	return retval;
 }
 
-static inline unsigned long mc146818_get_cmos_time(void)
+static inline time64_t mc146818_get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
 	unsigned long flags;
@@ -113,7 +113,7 @@ static inline unsigned long mc146818_get_cmos_time(void)
 	spin_unlock_irqrestore(&rtc_lock, flags);
 	year = mc146818_decode_year(year);
 
-	return mktime(year, mon, day, hour, min, sec);
+	return mktime64(year, mon, day, hour, min, sec);
 }
 
 #endif /* __ASM_MC146818_TIME_H */
diff --git a/arch/mips/lasat/ds1603.c b/arch/mips/lasat/ds1603.c
index 8bd5cf8..d75c887 100644
--- a/arch/mips/lasat/ds1603.c
+++ b/arch/mips/lasat/ds1603.c
@@ -136,7 +136,7 @@ static void rtc_end_op(void)
 	lasat_ndelay(1000);
 }
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	unsigned long word;
 	unsigned long flags;
diff --git a/arch/mips/loongson64/common/time.c b/arch/mips/loongson64/common/time.c
index e1a5382a..0ba53c5 100644
--- a/arch/mips/loongson64/common/time.c
+++ b/arch/mips/loongson64/common/time.c
@@ -29,7 +29,7 @@ void __init plat_time_init(void)
 #endif
 }
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	ts->tv_sec = mc146818_get_cmos_time();
 	ts->tv_nsec = 0;
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 66c8667..d22b7ed 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -134,7 +134,7 @@ static void __init estimate_frequencies(void)
 	}
 }
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	ts->tv_sec = mc146818_get_cmos_time();
 	ts->tv_nsec = 0;
diff --git a/arch/mips/sibyte/swarm/rtc_m41t81.c b/arch/mips/sibyte/swarm/rtc_m41t81.c
index e624664..aa27a22 100644
--- a/arch/mips/sibyte/swarm/rtc_m41t81.c
+++ b/arch/mips/sibyte/swarm/rtc_m41t81.c
@@ -188,7 +188,7 @@ int m41t81_set_time(unsigned long t)
 	return 0;
 }
 
-unsigned long m41t81_get_time(void)
+time64_t m41t81_get_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
 	unsigned long flags;
@@ -218,7 +218,7 @@ unsigned long m41t81_get_time(void)
 
 	year += 2000;
 
-	return mktime(year, mon, day, hour, min, sec);
+	return mktime64(year, mon, day, hour, min, sec);
 }
 
 int m41t81_probe(void)
diff --git a/arch/mips/sibyte/swarm/rtc_xicor1241.c b/arch/mips/sibyte/swarm/rtc_xicor1241.c
index 50a82c4..a2121c1 100644
--- a/arch/mips/sibyte/swarm/rtc_xicor1241.c
+++ b/arch/mips/sibyte/swarm/rtc_xicor1241.c
@@ -168,7 +168,7 @@ int xicor_set_time(unsigned long t)
 	return 0;
 }
 
-unsigned long xicor_get_time(void)
+time64_t xicor_get_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec, y2k;
 	unsigned long flags;
@@ -201,7 +201,7 @@ unsigned long xicor_get_time(void)
 
 	year += (y2k * 100);
 
-	return mktime(year, mon, day, hour, min, sec);
+	return mktime64(year, mon, day, hour, min, sec);
 }
 
 int xicor_probe(void)
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 494fb0a..7073940 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -58,11 +58,11 @@
 
 extern int xicor_probe(void);
 extern int xicor_set_time(unsigned long);
-extern unsigned long xicor_get_time(void);
+extern time64_t xicor_get_time(void);
 
 extern int m41t81_probe(void);
 extern int m41t81_set_time(unsigned long);
-extern unsigned long m41t81_get_time(void);
+extern time64_t m41t81_get_time(void);
 
 const char *get_system_type(void)
 {
@@ -87,9 +87,9 @@ enum swarm_rtc_type {
 
 enum swarm_rtc_type swarm_rtc_type;
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
-	unsigned long sec;
+	time64_t sec;
 
 	switch (swarm_rtc_type) {
 	case RTC_XICOR:
@@ -102,7 +102,7 @@ void read_persistent_clock(struct timespec *ts)
 
 	case RTC_NONE:
 	default:
-		sec = mktime(2000, 1, 1, 0, 0, 0);
+		sec = mktime64(2000, 1, 1, 0, 0, 0);
 		break;
 	}
 	ts->tv_sec = sec;
-- 
1.7.9.5
