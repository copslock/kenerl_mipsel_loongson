Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2009 15:49:41 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:36433 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492878AbZKUOte (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2009 15:49:34 +0100
Received: by pxi3 with SMTP id 3so3041614pxi.22
        for <multiple recipients>; Sat, 21 Nov 2009 06:49:26 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=5NuBQ0pkavGYMd+u51nRoHB2kSlWtu3jH9kAEcn/1S0=;
        b=ZCDhdG1fE84KXnKy6E031Fw5kt1M9U7gtZa6909Yl5XM+k0Gt62E96ZieadyigG58b
         OipIqp7iLWXT15I9/T7e856parzujPlqKf4JgxfWqiJoC5hma/exuLetqFzUIIqM8tno
         tzqpEjKr1Diu0Mt5e4x7JoTjSnNalrr8P8wBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=I64DaXIK+qkQ+GklP00SB7Es6kmgoriv45uQuSJwBgjMrI2tSI/KyYLKwmSeBI3xmV
         aGZ2jWPUyVuJM3V9+CVOYQ2W43jxB0EeWM2GFksuxkz7my/EIKkcsNuJRziQrSsoDXvx
         rLtSBJhFPQiWwOb59Y2aROX7GHgEVSks0g5iw=
Received: by 10.114.242.8 with SMTP id p8mr3887035wah.169.1258814966470;
        Sat, 21 Nov 2009 06:49:26 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1661186pzk.7.2009.11.21.06.49.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Nov 2009 06:49:25 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1] MIPS: Add a high precision sched_clock() via cnt32_to_63().
Date:	Sat, 21 Nov 2009 22:49:12 +0800
Message-Id: <0d92a3c45f7ffff2b0df815c4345d6e9a01cb00c.1258814214.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds a cnt32_to_63() and MIPS c0 count based sched_clock(),
which can provide high resolution. and also, two new kernel options are
added. the HR_SCHED_CLOCK is used to enable/disable this sched_clock(),
and the HT_SCHED_CLOCK_UPDATE is used to allow whether update the
sched_clock() automatically or not.

Without it, the Ftrace for MIPS will give useless timestamp information.

(Because cnt32_to_63() needs to be called at least once per half period
to work properly, Differ from the old version, this v1 revision set up a
kernel timer to ensure the requirement of some MIPSs which have short c0
count period.)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig           |   30 ++++++++++++++++++++++
 arch/mips/kernel/csrc-r4k.c |   58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b342197..6264f97 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1952,6 +1952,36 @@ config NR_CPUS
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
+	  If you need a ns precision timestamp, You are recommended to enable
+	  this option. For example, If you are using the Ftrace subsystem to do
+	  real time tracing, this option is needed.
+
+	  If unsure, disable it.
+
+config HR_SCHED_CLOCK_UPDATE
+	bool "Update sched_clock() automatically"
+	depends on HR_SCHED_CLOCK
+	default y
+	help
+	  Because Some of the MIPS c0 count period is quite short and because
+	  cnt32_to_63() needs to be called at least once per half period to
+	  work properly, a kernel timer is needed to set up to ensure this
+	  requirement is always met.
+
+	  If unusre, enable it.
+
+#
 # Timer Interrupt Frequency Configuration
 #
 
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index e95a3cd..5048989 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -6,10 +6,62 @@
  * Copyright (C) 2007 by Ralf Baechle
  */
 #include <linux/clocksource.h>
+#include <linux/cnt32_to_63.h>
+#include <linux/timer.h>
 #include <linux/init.h>
 
 #include <asm/time.h>
 
+/*
+ * MIPS' sched_clock implementation.
+ *
+ * because cnt32_to_63() needs to be called at least once per half period to
+ * work properly, and some of the MIPS' frequency is very low, perhaps a kernel
+ * timer is needed to be set up to ensure this requirement is always met.
+ * please refer to  arch/arm/plat-orion/time.c and include/linux/cnt32_to_63.h
+ */
+static unsigned long __maybe_unused tclk2ns_scale;
+static unsigned long __maybe_unused tclk2ns_scale_factor;
+
+unsigned long long notrace __maybe_unused sched_clock(void)
+{
+	unsigned long long v = cnt32_to_63(read_c0_count());
+	return (v * tclk2ns_scale) >> tclk2ns_scale_factor;
+}
+
+static void __init __maybe_unused setup_sched_clock(struct clocksource *cs)
+{
+	unsigned long long v;
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
+}
+
+static struct timer_list __maybe_unused cnt32_to_63_keepwarm_timer;
+
+static void __maybe_unused cnt32_to_63_keepwarm(unsigned long data)
+{
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+	(void) sched_clock();
+}
+
+static void __maybe_unused setup_sched_clock_update(unsigned long tclk)
+{
+	unsigned long data;
+
+	data = (0xffffffffUL / tclk / 2 - 2) * HZ;
+	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, data);
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+}
+
 static cycle_t c0_hpt_read(struct clocksource *cs)
 {
 	return read_c0_count();
@@ -32,7 +84,13 @@ int __init init_r4k_clocksource(void)
 
 	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
 
+#ifdef CONFIG_HR_SCHED_CLOCK
+	setup_sched_clock(&clocksource_mips);
+#endif
 	clocksource_register(&clocksource_mips);
 
+#ifdef CONFIG_HR_SCHED_CLOCK_UPDATE
+	setup_sched_clock_update(mips_hpt_frequency);
+#endif
 	return 0;
 }
-- 
1.6.2.1
