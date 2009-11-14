Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Nov 2009 07:34:39 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:52839 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492129AbZKNGeO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 14 Nov 2009 07:34:14 +0100
Received: by pwi15 with SMTP id 15so2474684pwi.24
        for <multiple recipients>; Fri, 13 Nov 2009 22:34:07 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=VLgmSQV3Ep7Z2RD1kDDtoRoufjj/lwxOXiZVVUVE9qk=;
        b=LxYfctbMKNMncG9eockDSbxqSDh8pIrVrJs4T8ZdJA55tbwU7K6gUuwoF3SXhFmMy/
         P6Y4u8k28vI8BXaIi/i5d8mpeeC1f7oka+tAOvLIkQ0ZEPzy5gMj6g3SUtUTNNsvqcCH
         Mwuvfk4RElNAlLSNHe1Kp7atrXzgPDj+7pKRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ORucq7CV3oUldzN97JC9OIar8oLRAaZztWHSuPw8P3xwK3sdrU+hmXxV43mxfhXwCR
         CnKTVUrTM+TkkHiMuJLuu+euPZySxgsepCCR+q/CqG3slUuYcsBet2Yeyzu670sWiYSM
         bD0nMzNlhzLuCTR3yzl6rUeI4KoYsGI/+/67k=
Received: by 10.115.113.4 with SMTP id q4mr2478964wam.54.1258180447861;
        Fri, 13 Nov 2009 22:34:07 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm2668108pzk.5.2009.11.13.22.33.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 22:34:07 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>,
	"Maciej W . Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	zhangfx@lemote.com, zhouqg@gmail.com
Subject: [PATCH v8 02/16] tracing: add mips_timecounter_read() for MIPS
Date:	Sat, 14 Nov 2009 14:33:17 +0800
Message-Id: <b99c08397d9ff92ac5a72bda9131df41b702fc71.1258177321.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1258177321.git.wuzhangjin@gmail.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1258177321.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258177321.git.wuzhangjin@gmail.com>
References: <cover.1258177321.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch add a new function: mips_timecounter_read() to get high
precision timestamp without extra lock.

It is based on the clock counter register and the
timecounter/cyclecounter abstraction layer of kernel.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/time.h |   20 ++++++++++++++++++++
 arch/mips/kernel/csrc-r4k.c  |   41 +++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/time.c      |    2 ++
 3 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index df6a430..3fcc481 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -15,6 +15,7 @@
 #define _ASM_TIME_H
 
 #include <linux/rtc.h>
+#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
@@ -73,8 +74,18 @@ static inline int mips_clockevent_init(void)
  */
 #ifdef CONFIG_CSRC_R4K_LIB
 extern int init_r4k_clocksource(void);
+extern int init_r4k_timecounter(void);
+extern u64 r4k_timecounter_read(void);
 #endif
 
+static inline u64 mips_timecounter_read(void)
+{
+#ifdef CONFIG_CSRC_R4K
+	return r4k_timecounter_read();
+#else
+	return sched_clock();
+#endif
+}
 static inline int init_mips_clocksource(void)
 {
 #ifdef CONFIG_CSRC_R4K
@@ -84,6 +95,15 @@ static inline int init_mips_clocksource(void)
 #endif
 }
 
+static inline int init_mips_timecounter(void)
+{
+#ifdef CONFIG_CSRC_R4K
+	return init_r4k_timecounter();
+#else
+	return 0;
+#endif
+}
+
 extern void clocksource_set_clock(struct clocksource *cs, unsigned int clock);
 extern void clockevent_set_clock(struct clock_event_device *cd,
 		unsigned int clock);
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index e95a3cd..4e7705f 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -7,6 +7,7 @@
  */
 #include <linux/clocksource.h>
 #include <linux/init.h>
+#include <linux/sched.h>
 
 #include <asm/time.h>
 
@@ -36,3 +37,43 @@ int __init init_r4k_clocksource(void)
 
 	return 0;
 }
+
+static struct timecounter r4k_tc = {
+	.cc = NULL,
+};
+
+static cycle_t r4k_cc_read(const struct cyclecounter *cc)
+{
+	return read_c0_count();
+}
+
+static struct cyclecounter r4k_cc = {
+	.read = r4k_cc_read,
+	.mask = CLOCKSOURCE_MASK(32),
+	.shift = 32,
+};
+
+int __init init_r4k_timecounter(void)
+{
+	if (!cpu_has_counter || !mips_hpt_frequency)
+		return -ENXIO;
+
+	r4k_cc.mult = div_sc((unsigned long)mips_hpt_frequency, NSEC_PER_SEC,
+			32);
+
+	timecounter_init(&r4k_tc, &r4k_cc, sched_clock());
+
+	return 0;
+}
+
+u64 r4k_timecounter_read(void)
+{
+	u64 clock;
+
+	if (r4k_tc.cc != NULL)
+		clock = timecounter_read(&r4k_tc);
+	else
+		clock = sched_clock();
+
+	return clock;
+}
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 1f467d5..e38cca1 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -156,4 +156,6 @@ void __init time_init(void)
 
 	if (!mips_clockevent_init() || !cpu_has_mfc0_count_bug())
 		init_mips_clocksource();
+	if (!cpu_has_mfc0_count_bug())
+		init_mips_timecounter();
 }
-- 
1.6.2.1
