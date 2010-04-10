Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Apr 2010 08:58:28 +0200 (CEST)
Received: from mail-pz0-f186.google.com ([209.85.222.186]:46037 "EHLO
        mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491981Ab0DJG5i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Apr 2010 08:57:38 +0200
Received: by pzk16 with SMTP id 16so1923385pzk.22
        for <multiple recipients>; Fri, 09 Apr 2010 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=njKXGb5OKpfJfs6Ql5tFnWoJWijw7q+v+Q++a6twIRA=;
        b=p6rP88nkWbkKmd7Gye2iVWA3cBqDHaDoPLr7f8sdpH02zLd0iSna0Ooy/twvJ3F5B8
         QlChVQGK/aQpSaea0ICwvBPPFMwdAM8KcNv/Nw+8ra+wJgMKWIcsUxNtx1oXm+f44Obr
         Z+vV5B3OysJvUWqjSN84Gr5sOwXGbon0l/lic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=D+48ZE6RKzOZs9eP5xZrYkLkhbw6sknEPFnMMGXNDACEd3Gh2HszMT7yGFcvg/bxtq
         JhJP/7OzWnDEjLeOvK8mrjHUEgo9tFEpze/emPsSsZjOioSBSvdE02dpV9DUPUW+H7Pq
         KUjU6Vy31qXvvuZc/7bHnUdWcruL+HVmYP/os=
Received: by 10.115.84.22 with SMTP id m22mr1449759wal.201.1270882650510;
        Fri, 09 Apr 2010 23:57:30 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm1642896pzk.8.2010.04.09.23.57.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 23:57:29 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        =?UTF-8?q?Ralf=20R=C3=B6sch?= <roesch.ralf@web.de>,
        linux-mips@linux-mips.org
Subject: [PATCH v3 3/3] MIPS: r4k: Add a high resolution sched_clock()
Date:   Sat, 10 Apr 2010 14:49:59 +0800
Message-Id: <b6be9a36a486acd91159b4af3a4fb5c8e5f2a005.1270881177.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1270881177.git.wuzhangjin@gmail.com>
References: <cover.1270881177.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1270881177.git.wuzhangjin@gmail.com>
References: <cover.1270881177.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

(v10 -> v11:

 o uses 32bit instead of 64bit for mult and shift for the new
 mips_cyc2ns().

 o choose a smaller scaling factor: 8 to ensure it overflows slower.
 With 8, if the clock frequency is 400 MHz, it will overflow after 12509
 hours(about 521 days) which is enough for generic debugging(i.e. Ftrace).

 o annotate the cnt32_to_63_keepwarm() with notrace.

 v9 -> v10:

 o use the new interface mips_cyc2ns() instead of the old
 mips_sched_clock()
 o adds 32bit support via using a smaller shift to balance the overhead
 of 128bit arithmatic and the precision lost. please refer to the method
 used in X86 & ARM platforms, arch/x86/kernel/tsc.c,
 arch/arm/plat-orion/time.c.

 v8 -> v9:
 O Make it depends on 64BIT for the current mips_cyc2ns() only
 support 64bit currently.

 v7 -> v8:

 O Make it works with the exisiting clocksource_mips.mult,
 clocksource_mips.shift and copes with the 64bit calculation's overflow
 problem with the method introduced by David Daney in "MIPS: Octeon: Use
 non-overflowing arithmetic in sched_clock".

 To reduce the duplication, I have abstracted an inline
 mips_cyc2ns() function to arch/mips/include/asm/time.h from
 arch/mips/cavium-octeon/csrc-octeon.c.

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
 arch/mips/Kconfig           |   12 +++++++
 arch/mips/kernel/csrc-r4k.c |   76 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/time.c     |    5 +++
 3 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f2ead53..b302838 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1962,6 +1962,18 @@ config NR_CPUS
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
index e95a3cd..92870cb 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -6,7 +6,9 @@
  * Copyright (C) 2007 by Ralf Baechle
  */
 #include <linux/clocksource.h>
+#include <linux/cnt32_to_63.h>
 #include <linux/init.h>
+#include <linux/timer.h>
 
 #include <asm/time.h>
 
@@ -22,6 +24,78 @@ static struct clocksource clocksource_mips = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+#ifdef CONFIG_CPU_SUPPORTS_HR_SCHED_CLOCK
+/*
+ * MIPS sched_clock implementation.
+ *
+ * Because the hardware timer period is quite short and because cnt32_to_63()
+ * needs to be called at least once per half period to work properly, a kernel
+ * timer is set up to ensure this requirement is always met.
+ *
+ * Please refer to include/linux/cnt32_to_63.h, arch/arm/plat-orion/time.c and
+ * arch/mips/include/asm/time.h (mips_cyc2ns)
+ */
+
+#define CYC2NS_SHIFT 8
+static u32 mult __read_mostly;
+static u32 shift __read_mostly;
+
+unsigned long long notrace sched_clock(void)
+{
+	u64 cyc = cnt32_to_63(read_c0_count());
+
+#ifdef CONFIG_64BIT
+	/* For we have used 128bit arithmatic to cope with the overflow
+	 * problem, the method to clear the top bit with an event value doesn't
+	 * work now, therefore, clear it at run-time is needed.
+	 */
+	if (cyc & 0x8000000000000000)
+		cyc &= 0x7fffffffffffffff;
+#endif
+	return mips_cyc2ns(cyc, mult, shift);
+}
+
+static struct timer_list cnt32_to_63_keepwarm_timer;
+
+static void notrace cnt32_to_63_keepwarm(unsigned long data)
+{
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+	sched_clock();
+}
+#endif
+
+static inline void setup_hres_sched_clock(unsigned long clock)
+{
+#ifdef CONFIG_CPU_SUPPORTS_HR_SCHED_CLOCK
+	unsigned long data;
+
+#ifdef CONFIG_32BIT
+	unsigned long long v;
+
+	v = NSEC_PER_SEC;
+	v <<= CYC2NS_SHIFT;
+	v += clock/2;
+	do_div(v, clock);
+	mult = v;
+	shift = CYC2NS_SHIFT;
+	/*
+	 * We want an even value to automatically clear the top bit
+	 * returned by cnt32_to_63() without an additional run time
+	 * instruction. So if the LSB is 1 then round it up.
+	 */
+	if (mult & 1)
+		mult++;
+#else
+	mult = clocksource_mips.mult;
+	shift = clocksource_mips.shift;
+#endif
+
+	data = 0x80000000UL / clock * HZ;
+	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, data);
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+#endif
+}
+
 int __init init_r4k_clocksource(void)
 {
 	if (!cpu_has_counter || !mips_hpt_frequency)
@@ -32,6 +106,8 @@ int __init init_r4k_clocksource(void)
 
 	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
 
+	setup_hres_sched_clock(mips_hpt_frequency);
+
 	clocksource_register(&clocksource_mips);
 
 	return 0;
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
1.7.0.1
