Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 11:29:40 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:65105 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492535AbZKWK32 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2009 11:29:28 +0100
Received: by pzk35 with SMTP id 35so3897756pzk.22
        for <multiple recipients>; Mon, 23 Nov 2009 02:29:20 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fiQ9yCWBtSUKarLM8qxciXWE2Ux8+g0J+rssmjhgSA8=;
        b=hrDB09JTtSveMV6FukSu3Yz+WsiCSYp+PpFpQRKzBkSyzU+7fdchTjNZBX5HPW85ce
         u3e7lnLnzO/3JsPo7vqa97eLU3sHhkYYQ9pu3uMPZkDuh0f8xJM15GtHmIjo7mTY1mJw
         26P1XrsD26XV43eKQ27ThPLHY/dMzLsu+CXzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qTcBgosHua3N3vaZC56u4knD12YchfCTk8aym5YH3wPR/uWhAazu9+wIDU0O0ekfD1
         3ci48SkecPm6t8hRvYPzlw1jGMUMxScOoHwMk1M0oXFuZY4+cQwCfRW9niPT4jmxoNhJ
         l4iasnpuUv6Gmt1k33tygYjb6R4NjoIl6If6o=
Received: by 10.114.86.18 with SMTP id j18mr476491wab.39.1258972160328;
        Mon, 23 Nov 2009 02:29:20 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm2986980pzk.14.2009.11.23.02.29.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 02:29:19 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v5] MIPS: Add a high resolution sched_clock() via cnt32_to_63().
Date:	Mon, 23 Nov 2009 18:28:56 +0800
Message-Id: <39b95d02b37cd75d275b231c31abb00aefda9078.1258972025.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

(This v5 revision incorporates with the feedbacks from Ingo.)

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
 arch/mips/Kconfig                |   18 ++++++++++++
 arch/mips/include/asm/time.h     |   15 ++++++++++
 arch/mips/kernel/Makefile        |    1 +
 arch/mips/kernel/csrc-r4k-hres.c |   54 ++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/csrc-r4k.c      |    2 +
 5 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/kernel/csrc-r4k-hres.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index da5d7fd..b3b6334 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1953,6 +1953,24 @@ config NR_CPUS
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
+	  this option. For example, if you are using the Ftrace subsystem to do
+	  real time tracing, this option is needed.
+
+	  If unsure, disable it.
+
+#
 # Timer Interrupt Frequency Configuration
 #
 
diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index df6a430..a697f7d 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -84,6 +84,21 @@ static inline int init_mips_clocksource(void)
 #endif
 }
 
+/*
+ * Setup the high resolution sched_clock()
+ */
+#ifdef CONFIG_HR_SCHED_CLOCK
+extern void setup_r4k_sched_clock(struct clocksource cs, unsigned int clock);
+#endif
+
+static inline void setup_hres_sched_clock(struct clocksource cs,
+		unsigned int clock)
+{
+#ifdef CONFIG_HR_SCHED_CLOCK
+	setup_r4k_sched_clock(cs, clock);
+#endif
+}
+
 extern void clocksource_set_clock(struct clocksource *cs, unsigned int clock);
 extern void clockevent_set_clock(struct clock_event_device *cd,
 		unsigned int clock);
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 9326af5..a6e06c0 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_CSRC_BCM1480)	+= csrc-bcm1480.o
 obj-$(CONFIG_CSRC_IOASIC)	+= csrc-ioasic.o
 obj-$(CONFIG_CSRC_POWERTV)	+= csrc-powertv.o
 obj-$(CONFIG_CSRC_R4K_LIB)	+= csrc-r4k.o
+obj-$(CONFIG_HR_SCHED_CLOCK)	+= csrc-r4k-hres.o
 obj-$(CONFIG_CSRC_SB1250)	+= csrc-sb1250.o
 obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
 
diff --git a/arch/mips/kernel/csrc-r4k-hres.c b/arch/mips/kernel/csrc-r4k-hres.c
new file mode 100644
index 0000000..2fe8be7
--- /dev/null
+++ b/arch/mips/kernel/csrc-r4k-hres.c
@@ -0,0 +1,54 @@
+/*
+ * MIPS sched_clock implementation.
+ *
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin, wuzj@lemote.com
+ *
+ * because cnt32_to_63() needs to be called at least once per half period to
+ * work properly, and some of the MIPS frequency is high, perhaps a kernel
+ * timer is needed to be set up to ensure this requirement is always met.
+ * Please refer to arch/arm/plat-orion/time.c and include/linux/cnt32_to_63.h
+ */
+
+#include <linux/clocksource.h>
+#include <linux/cnt32_to_63.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+
+static unsigned long __read_mostly cycle2ns_scale;
+static unsigned long __read_mostly cycle2ns_scale_factor;
+
+unsigned long long notrace sched_clock(void)
+{
+	unsigned long long v = cnt32_to_63(read_c0_count());
+	return (v * cycle2ns_scale) >> cycle2ns_scale_factor;
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
+void setup_r4k_sched_clock(struct clocksource cs, unsigned int clock)
+{
+	unsigned long long v;
+	unsigned long data;
+
+	v = cs.mult;
+	/*
+	 * We want an even value to automatically clear the top bit
+	 * returned by cnt32_to_63() without an additional run time
+	 * instruction. So if the LSB is 1 then round it up.
+	 */
+	if (v & 1)
+		v++;
+	cycle2ns_scale = v;
+	cycle2ns_scale_factor = cs.shift;
+
+	data = 0x80000000 / clock * HZ;
+	setup_timer(&cnt32_to_63_keepwarm_timer, cnt32_to_63_keepwarm, data);
+	mod_timer(&cnt32_to_63_keepwarm_timer, round_jiffies(jiffies + data));
+}
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index e95a3cd..3bd89bb 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -32,6 +32,8 @@ int __init init_r4k_clocksource(void)
 
 	clocksource_set_clock(&clocksource_mips, mips_hpt_frequency);
 
+	setup_hres_sched_clock(clocksource_mips, mips_hpt_frequency);
+
 	clocksource_register(&clocksource_mips);
 
 	return 0;
-- 
1.6.2.1
