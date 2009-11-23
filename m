Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 02:26:06 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:60467 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493101AbZKWBZ7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2009 02:25:59 +0100
Received: by pwi15 with SMTP id 15so3259641pwi.24
        for <multiple recipients>; Sun, 22 Nov 2009 17:25:52 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=cwSuZd3cs5JYh5scR8zWNReDYCIzweFTu30+mgU8ueg=;
        b=k4ywH56Wq1m1F/x/U6J2h/32SSunXMo81p4+i7EZiSmyl+GYLX0WjiiaLIvoHJvtka
         lYn8ELstGHvYXJFXEiU783sxYFE5QkM9+zmbtjphi/XNu0itrvh9RMGJ7leGZjTga1Ww
         SzuezPNALwcEhFGlkLlCxM9fEuYUZ3usjqgpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=luUPIbOy1tq2Ekd44Tt0MhpBKw2AlT2bCpbsyuWEbg76lbIqeedpYe4dDlUMSGlV1K
         WPFh6WCWlqejNqnxIuNa7/fLhda+GOi8h9qh1/jx2M+fhxxH79Q4TLjZOHfXW2RNykdo
         EkWfdTUSKxtHk+0+xZfCis1EQ103M6iA+ABN0=
Received: by 10.114.215.5 with SMTP id n5mr7437259wag.151.1258939552630;
        Sun, 22 Nov 2009 17:25:52 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm711536pxi.7.2009.11.22.17.25.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 17:25:52 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Ingo Molnar <mingo@elte.hu>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v4] MIPS: Add a high resolution sched_clock() via cnt32_to_63().
Date:	Mon, 23 Nov 2009 09:22:04 +0800
Message-Id: <34211a03cdfc6f0bcadd94c939ae0237c99ef6e5.1258939222.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

(This v4 revision incorporates with the feedbacks from Sergei.)

This patch adds a cnt32_to_63() and MIPS c0 count based sched_clock(),
which provides high resolution. and also, one new kernel option
(HR_SCHED_CLOCK) is added to enable/disable this sched_clock().

Without it, the Ftrace for MIPS will give useless timestamp information.

Because cnt32_to_63() needs to be called at least once per half period
to work properly, Differ from the old version, this v2 revision set up a
kernel timer to ensure the requirement of some MIPSs which have short c0
count period.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig           |   18 +++++++++++++
 arch/mips/kernel/csrc-r4k.c |   57 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b342197..5ea55f5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1952,6 +1952,24 @@ config NR_CPUS
 source "kernel/time/Kconfig"
 
 #
+# High Resolution sched_clock() Configuration
+#
+
+config HR_SCHED_CLOCK
+	bool "High Resolution sched_clock()"
+	depends on CSRC_R4K
+	default n
+	help
+	  This option enables the MIPS c0 count based high resolution
+	  sched_clock().
+
+	  If you need a ns precision timestamp, you are recommended to enable
+	  this option. For example, If you are using the Ftrace subsystem to do
+	  real time tracing, this option is needed.
+
+	  If unsure, disable it.
+
+#
 # Timer Interrupt Frequency Configuration
 #
 
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index e95a3cd..7762c95 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -10,6 +10,61 @@
 
 #include <asm/time.h>
 
+#ifdef CONFIG_HR_SCHED_CLOCK
+#include <linux/cnt32_to_63.h>
+#include <linux/timer.h>
+
+/*
+ * MIPS sched_clock implementation.
+ *
+ * because cnt32_to_63() needs to be called at least once per half period to
+ * work properly, and some of the MIPS frequency is high, perhaps a kernel
+ * timer is needed to be set up to ensure this requirement is always met.
+ * Please refer to arch/arm/plat-orion/time.c and include/linux/cnt32_to_63.h
+ */
+static unsigned long __read_mostly tclk2ns_scale;
+static unsigned long __read_mostly tclk2ns_scale_factor;
+
+unsigned long long notrace sched_clock(void)
+{
+	unsigned long long v = cnt32_to_63(read_c0_count());
+	return (v * tclk2ns_scale) >> tclk2ns_scale_factor;
+}
+
+static struct timer_list cnt32_to_63_keepwarm_timer;
+
+static void cnt32_to_63_keepwarm(unsigned long data)
+{
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+	(void) sched_clock();
+}
+
+static void __init setup_sched_clock(struct clocksource *cs, unsigned long tclk)
+{
+	unsigned long long v;
+	unsigned long data;
+
+	v = cs->mult;
+	/*
+	 * We want an even value to automatically clear the top bit
+	 * returned by cnt32_to_63() without an additional run time
+	 * instruction. So if the LSB is 1 then round it up.
+	 */
+	if (v & 1)
+		v++;
+	tclk2ns_scale = v;
+	tclk2ns_scale_factor = cs->shift;
+
+	data = 0x80000000 / tclk * HZ;
+	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, data);
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+}
+#else	/* !CONFIG_HR_SCHED_CLOCK */
+static void __init setup_sched_clock(struct clocksource *cs, unsigned long tclk)
+{
+}
+#endif
+
 static cycle_t c0_hpt_read(struct clocksource *cs)
 {
 	return read_c0_count();
@@ -32,6 +87,8 @@ int __init init_r4k_clocksource(void)
 
 	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
 
+	setup_sched_clock(&clocksource_mips, mips_hpt_frequency);
+
 	clocksource_register(&clocksource_mips);
 
 	return 0;
-- 
1.6.2.1
