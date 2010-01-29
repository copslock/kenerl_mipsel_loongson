Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 18:35:47 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:61986 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492732Ab0A2Rfn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2010 18:35:43 +0100
Received: by vws3 with SMTP id 3so588104vws.36
        for <multiple recipients>; Fri, 29 Jan 2010 09:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=dBSFFlcp1llpzSpM86yAXebnVYoAcMyumeZY09+h7iU=;
        b=cP+uj5xbLRZj6KxcePZS6WSuUSpzvVPmLekHOCXsxNzuNpZ1g/tEoRyQOnslHpTeul
         CvDJrK+n1KGv64R5oyNU/5ggeTqK3BiGKYjKYDr9Vk5dfywZHDxoKIsVqAuvrGEFS6XO
         27bTPUwGCftyZ2m8fq+Hg2JfoytItyRlEb6CI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qTrMRlWTeu3Ot2vBL8hvnJXPDbOFF5P5zFwahjsE2CZdoM2NJe4in0oNsf7nJTKG70
         /XDaV5UJGaEtlFmF8x7b75OZd9jfrGBX+NFkCBwp9wjpoEwLIrePeY0t8rjQAMrYg+iW
         Ly8CRfEF31GCYon1H30uWptNE2JjHuUnfO2Lg=
Received: by 10.220.127.66 with SMTP id f2mr1019111vcs.82.1264786536005;
        Fri, 29 Jan 2010 09:35:36 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 39sm29377208vws.14.2010.01.29.09.35.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 09:35:34 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v7] MIPS: Add a high resolution sched_clock() via cnt32_to_63().
Date:   Sat, 30 Jan 2010 01:29:24 +0800
Message-Id: <9e0764ee4c351d9c6417988f15f2c57eb0708eb0.1264786077.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
X-archive-position: 25740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19015

From: Wu Zhangjin <wuzhangjin@gmail.com>

(
 v6 -> v7:

 O Make it depends on !CPU_FREQ and CPU_HAS_FIXED_C0_COUNT

 This sched_clock() is only available with the processor has fixed cp0
 MIPS count register or even has dynamic cp0 MIPS count register but
 with CPU_FREQ disabled.

 NOTE: If your processor has fixed c0 count, please select
 CPU_HAS_FIXED_C0_COUNT for it and send a related patch to Ralf.

 v5 -> v6:

 o hard-codes the cycle2ns_scale_factor as 8 for 30(cs->shift) is too
 big. With 30, the return value of sched_clock() will also overflow quickly.
 o moves the sched_clock() back into csrc-r4k.c as David and Sergei
 recommended.
 o inits c0 count as zero for PRINTK_TIME=y.
 o drops the HR_SCHED_CLCOK option for the current sched_clock() is stable
 enough to replace the jiffies based one.
)

This patch adds a cnt32_to_63() and MIPS c0 count based sched_clock(),
which provides high resolution.

Without it, the Ftrace for MIPS will give useless timestamp information.

Because cnt32_to_63() needs to be called at least once per half period
to work properly, Differ from the old version, this v2 revision set up a
kernel timer to ensure the requirement of some MIPSs which have short c0
count period.

And also, we init the c0 count as ZERO(just as jiffies does) in
time_init() before plat_time_init(), without it, PRINTK_TIME=y will get
wrong timestamp information. (NOTE: some platforms have initiazlied c0
count as zero, but some not, this may introduce some duplication,
perhaps a new patch is needed to remove the initialized of c0 count in
the platforms later?)

This is originally from arch/arm/plat-orion/time.c

This revision works well for function graph tracer now, and also,
PRINTK_TIME=y will get normal timestamp informatin.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig           |   12 +++++++++
 arch/mips/kernel/csrc-r4k.c |   58 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/time.c     |    5 +++
 3 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8741671..1a76ab7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1933,6 +1933,18 @@ config NR_CPUS
 source "kernel/time/Kconfig"
 
 #
+# High Resolution sched_clock() support
+#
+
+config CPU_HAS_FIXED_C0_COUNT
+	bool
+
+config CPU_SUPPORTS_HR_SCHED_CLOCK
+	bool
+	depends on CPU_HAS_FIXED_C0_COUNT || !CPU_FREQ
+	default y
+
+#
 # Timer Interrupt Frequency Configuration
 #
 
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index e95a3cd..b5db0c8 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -6,10 +6,66 @@
  * Copyright (C) 2007 by Ralf Baechle
  */
 #include <linux/clocksource.h>
+#include <linux/cnt32_to_63.h>
 #include <linux/init.h>
+#include <linux/timer.h>
 
 #include <asm/time.h>
 
+#ifdef CONFIG_CPU_SUPPORTS_HR_SCHED_CLOCK
+/*
+ * MIPS sched_clock implementation.
+ *
+ * Because the hardware timer period is quite short and because cnt32_to_63()
+ * needs to be called at least once per half period to work properly, a kernel
+ * timer is set up to ensure this requirement is always met.
+ *
+ * Please refer to include/linux/cnt32_to_63.h and arch/arm/plat-orion/time.c
+ */
+#define CLOCK2NS_SCALE_FACTOR 8
+
+static unsigned long clock2ns_scale __read_mostly;
+
+unsigned long long notrace sched_clock(void)
+{
+	unsigned long long v = cnt32_to_63(read_c0_count());
+	return (v * clock2ns_scale) >> CLOCK2NS_SCALE_FACTOR;
+}
+
+static struct timer_list cnt32_to_63_keepwarm_timer;
+
+static void cnt32_to_63_keepwarm(unsigned long data)
+{
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+	sched_clock();
+}
+#endif
+
+static inline void setup_hres_sched_clock(unsigned long clock)
+{
+#ifdef CONFIG_CPU_SUPPORTS_HR_SCHED_CLOCK
+	unsigned long long v;
+	unsigned long data;
+
+	v = NSEC_PER_SEC;
+	v <<= CLOCK2NS_SCALE_FACTOR;
+	v += clock/2;
+	do_div(v, clock);
+	/*
+	 * We want an even value to automatically clear the top bit
+	 * returned by cnt32_to_63() without an additional run time
+	 * instruction. So if the LSB is 1 then round it up.
+	 */
+	if (v & 1)
+		v++;
+	clock2ns_scale = v;
+
+	data = 0x80000000UL / clock * HZ;
+	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, data);
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+#endif
+}
+
 static cycle_t c0_hpt_read(struct clocksource *cs)
 {
 	return read_c0_count();
@@ -27,6 +83,8 @@ int __init init_r4k_clocksource(void)
 	if (!cpu_has_counter || !mips_hpt_frequency)
 		return -ENXIO;
 
+	setup_hres_sched_clock(mips_hpt_frequency);
+
 	/* Calculate a somewhat reasonable rating value */
 	clocksource_mips.rating = 200 + mips_hpt_frequency / 10000000;
 
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index fb74974..86cf18a 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -119,6 +119,11 @@ static __init int cpu_has_mfc0_count_bug(void)
 
 void __init time_init(void)
 {
+#ifdef CONFIG_CPU_SUPPORTS_HR_SCHED_CLOCK
+	if (!mips_clockevent_init() || !cpu_has_mfc0_count_bug())
+		write_c0_count(0);
+#endif
+
 	plat_time_init();
 
 	if (!mips_clockevent_init() || !cpu_has_mfc0_count_bug())
-- 
1.6.6
