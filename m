Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2009 11:52:18 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:48447 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492655AbZK0KwP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Nov 2009 11:52:15 +0100
Received: by pzk35 with SMTP id 35so1070739pzk.22
        for <multiple recipients>; Fri, 27 Nov 2009 02:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+UuelNNMCjP+FJLDrPQprKVrrmzfLmeUrbhTkJGoIvY=;
        b=LElkfQRJWhfJKTjGMrjRhNO+qUF852LvjCx5zf/jIO6xl0IUXbKBtFVlayt3+9txBc
         sXMgHc/3OJ3hRpAKEk6BIs7PxsmZboA6LSJfZbCVXyxCPR4KW67uZQ0iNw5fSjktJbQj
         LHh+NzZ7xPnsgebqARTjmD3W31uwb9gFaLxg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=LnFuApEx4z0Ce2fPYPPJcaE3uhduQeFoodxU2Rzz0mGWuxc+V0KNQXcCCOpcyMDqef
         Drwcp/O5kQ1o8ZP9V9pVdpSdTyPRQkEmMPu39Wh+VuQH2n/0q3Ppscmg0R80Sod5Fpa4
         zJgUI7VfRWSudL1ImHbT/bMooe78PAHkW3xJ0=
Received: by 10.114.86.11 with SMTP id j11mr1746746wab.73.1259319126996;
        Fri, 27 Nov 2009 02:52:06 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm1116414pzk.4.2009.11.27.02.51.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 02:52:06 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        David Daney <david.s.daney@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v6] MIPS: Add a high resolution sched_clock() via cnt32_to_63().
Date:   Fri, 27 Nov 2009 18:51:50 +0800
Message-Id: <1259319110-16107-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

(The changes of this v6 revision from v5 revision:

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
 arch/mips/kernel/csrc-r4k.c |   54 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/time.c     |    3 ++
 2 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index e95a3cd..12755f2 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -6,10 +6,62 @@
  * Copyright (C) 2007 by Ralf Baechle
  */
 #include <linux/clocksource.h>
+#include <linux/cnt32_to_63.h>
 #include <linux/init.h>
+#include <linux/timer.h>
 
 #include <asm/time.h>
 
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
+static unsigned long clock2ns_scale;
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
+
+static void __init setup_hres_sched_clock(unsigned long clock)
+{
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
+}
+
 static cycle_t c0_hpt_read(struct clocksource *cs)
 {
 	return read_c0_count();
@@ -27,6 +79,8 @@ int __init init_r4k_clocksource(void)
 	if (!cpu_has_counter || !mips_hpt_frequency)
 		return -ENXIO;
 
+	setup_hres_sched_clock(mips_hpt_frequency);
+
 	/* Calculate a somewhat reasonable rating value */
 	clocksource_mips.rating = 200 + mips_hpt_frequency / 10000000;
 
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 1f467d5..4b5e93c 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -152,6 +152,9 @@ static __init int cpu_has_mfc0_count_bug(void)
 
 void __init time_init(void)
 {
+	if (!mips_clockevent_init() || !cpu_has_mfc0_count_bug())
+		write_c0_count(0);
+
 	plat_time_init();
 
 	if (!mips_clockevent_init() || !cpu_has_mfc0_count_bug())
-- 
1.6.2.1
