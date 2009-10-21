Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 16:35:53 +0200 (CEST)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:52047 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492303AbZJUOfZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 16:35:25 +0200
Received: by fxm25 with SMTP id 25so8067331fxm.0
        for <multiple recipients>; Wed, 21 Oct 2009 07:35:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=xHNoUVL7jtuVw5VH1oK05eQwhoXWhhpyxOfnqPDCLL4=;
        b=kOtXcOsnQvM0jD6Q75Ty3G47yS6jTuPXQrOChqDV4ZgwyCdeGM6ojOeBScXCtc0TYQ
         OvtaAtj7arJknxWEVxBtqxwfwUV9NcLEq0L5cGCQM5syKvN5vF+/Qb70s6eIh1KhOPkV
         dAGzaFYxjHSvbji+PaKGiFzG7Er07Z2lMf2qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DHzV1z8BckRGw0AGQ0Godq8BgXFW2cnYMe9neI+RiooiJ+ZnxMvC5Ckz/15Ty9/gsj
         ntna6EsFz0DAkBPC0v9zY7nCRQ3EQTHEAOfQdpNPR5UsMnTDD6D2nySkFAVPxn4XxrqR
         aQtIYXJlDTMgXu9cZ2rKNk75FSdahmO3hups0=
Received: by 10.204.156.18 with SMTP id u18mr1198522bkw.102.1256135719910;
        Wed, 21 Oct 2009 07:35:19 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 1sm303459fkt.11.2009.10.21.07.35.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 07:35:19 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -v4 2/9] MIPS: add mips_timecounter_read() to get high precision timestamp
Date:	Wed, 21 Oct 2009 22:34:56 +0800
Message-Id: <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256135456.git.wuzhangjin@gmail.com>
References: <cover.1256135456.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch implement a mips_timecounter_read(), which can be used to get
high precision timestamp without extra lock.

It is based on the clock counter register and the
timecounter/cyclecounter abstraction layer of kernel.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/time.h |   19 +++++++++++++++++++
 arch/mips/kernel/csrc-r4k.c  |   41 +++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/time.c      |    2 ++
 3 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index df6a430..b8af7fa 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -73,8 +73,18 @@ static inline int mips_clockevent_init(void)
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
@@ -84,6 +94,15 @@ static inline int init_mips_clocksource(void)
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
