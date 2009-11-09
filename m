Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 16:32:25 +0100 (CET)
Received: from fg-out-1718.google.com ([72.14.220.158]:56003 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493023AbZKIPb7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 16:31:59 +0100
Received: by fg-out-1718.google.com with SMTP id e12so688929fga.6
        for <multiple recipients>; Mon, 09 Nov 2009 07:31:56 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=VLgmSQV3Ep7Z2RD1kDDtoRoufjj/lwxOXiZVVUVE9qk=;
        b=OxN/CJnzBKmatKUM9LQajWF5p8Pn9Nd5n0oC4rpgIrcSeEJEs9ikreiIw3sFY1f5OX
         fP0aUdQn25TEt4Ws+BpCPICWc27o3UP9KU8tGtF4JGh2WJjo2fToJCN+B8pv6jqt6o6k
         799ZvOAQUESK59+tMPuCV+mQ6TUVZWPcme/DE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KCOe2k9/sr5sGBGa3qbKNqRfh6Q/0yKbRJik1wVVAJCas9CtLwpMbuD6w2t36RwsHr
         h1yWILEXx4Z6pmNCqpmxHNL1Hb3+oLoCNIHyMaIp4b/TDpvwtX4e6qk8IW7/YXE2Z37v
         8Qs6XNaL1J2CVW+2bkgPZyYSVcvWZ5JxTpM5Q=
Received: by 10.216.90.135 with SMTP id e7mr2487703wef.34.1257780716396;
        Mon, 09 Nov 2009 07:31:56 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id g9sm9033556gvc.25.2009.11.09.07.31.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 07:31:55 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	zhangfx@lemote.com, zhouqg@gmail.com,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>
Subject: [PATCH v7 02/17] tracing: add mips_timecounter_read() for MIPS
Date:	Mon,  9 Nov 2009 23:31:19 +0800
Message-Id: <b99c08397d9ff92ac5a72bda9131df41b702fc71.1257779502.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257779502.git.wuzhangjin@gmail.com>
References: <cover.1257779502.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24774
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
