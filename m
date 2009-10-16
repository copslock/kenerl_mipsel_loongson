Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 13:39:18 +0200 (CEST)
Received: from mail-px0-f189.google.com ([209.85.216.189]:52845 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493586AbZJPLiy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 13:38:54 +0200
Received: by pxi27 with SMTP id 27so1714309pxi.22
        for <multiple recipients>; Fri, 16 Oct 2009 04:38:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=LKuNv63B6rZRnwct3EHL1GnJNROzEApfj17qjRgqNXs=;
        b=Xcas/QR6NCVo9t1zjpIj4uyKC7y1GABuR9rGgf6Bp2HTCn8t2oFBsFUD9Kx7sStNYw
         BrpDMWFoS1w3UIaME5KH2G/3Uz6dIUe3rLkGyD9d4blZqLXT2DR0SVXMwW4pomNNZ33F
         EiveYQfo+qq9jvIhfz0r4tMexpaYFJSycYG2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l5OqEuSVTMOGc41aw3SsEhD/4PTGv4fav4JaJIQ2FfkCHLq5XkN1ejX2+3KMVhASfw
         mGqRHp8BqUbtVa8Cl1U6LfU/MrHsESIwRzKHEq0ipGDyL5jM83FehJjVz4vTKoagZJ7Z
         5KbmbIFZoKMj1+i5imIP3nzWhvTvxE3+7+4Uo=
Received: by 10.114.29.14 with SMTP id c14mr1472061wac.111.1255693125721;
        Fri, 16 Oct 2009 04:38:45 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm810497pzk.11.2009.10.16.04.38.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Oct 2009 04:38:44 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@elte.hu>,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 2/2] tracing: add high precision version of trace_clock_local() for MIPS
Date:	Fri, 16 Oct 2009 19:38:25 +0800
Message-Id: <3c1635bdc0297252f619e2e50dc4b56f48446b0e.1255692619.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <4205779ae74d7c4144ee6cbf4e3f15f833646356.1255692619.git.wuzhangjin@gmail.com>
References: <4205779ae74d7c4144ee6cbf4e3f15f833646356.1255692619.git.wuzhangjin@gmail.com>
In-Reply-To: <4205779ae74d7c4144ee6cbf4e3f15f833646356.1255692619.git.wuzhangjin@gmail.com>
References: <4205779ae74d7c4144ee6cbf4e3f15f833646356.1255692619.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

By default, trace_clock_local() call the sched_clock() to get timestamp,
in x86, there is a tsc(64bit) based sched_clock(), but in MIPS, the
sched_clock() is jiffies based, which can not give enough
precision(about 10ms with 1000 HZ). so, we need to implement a higher
precision version for MIPS.

in MIPS, there is a tsc like clock counter. based on it, we can
implement a new trace_clock_local(), but because the clock counter is
only 32bit long, we need to handle rollover for it.  fortunately, there
a high-level abstraction(cyclecounter) of this action implemented in
include/linux/clocksource.h, which helps to handle the details behind,
we just use it!

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/Makefile      |    6 +++
 arch/mips/kernel/trace_clock.c |   67 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/kernel/trace_clock.c

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 8e26e9c..f228868 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -8,6 +8,10 @@ obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   ptrace.o reset.o setup.o signal.o syscall.o \
 		   time.o topology.o traps.o unaligned.o watch.o
 
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_trace_clock.o = -pg
+endif
+
 obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
 obj-$(CONFIG_CEVT_R4K_LIB)	+= cevt-r4k.o
 obj-$(CONFIG_MIPS_MT_SMTC)	+= cevt-smtc.o
@@ -24,6 +28,8 @@ obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
 
+obj-$(CONFIG_FTRACE)		+= trace_clock.o
+
 obj-$(CONFIG_CPU_LOONGSON2)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS32)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS64)	+= r4k_fpu.o r4k_switch.o
diff --git a/arch/mips/kernel/trace_clock.c b/arch/mips/kernel/trace_clock.c
new file mode 100644
index 0000000..435cd56
--- /dev/null
+++ b/arch/mips/kernel/trace_clock.c
@@ -0,0 +1,67 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive for
+ * more details.
+ *
+ * Copyright (C) 2009 Lemote Inc. & DSLab, Lanzhou University, China
+ * Author: Wu Zhangjin <wuzj@lemote.com>
+ */
+
+#include <linux/clocksource.h>
+#include <linux/sched.h>
+
+#include <asm/time.h>
+
+/*
+ * MIPS clock counter based timecounter.
+ */
+
+struct timecounter mips_tc;
+
+/*
+ * trace_clock_local(): the simplest and least coherent tracing clock.
+ *
+ * Useful for tracing that does not cross to other CPUs nor
+ * does it go through idle events.
+ */
+u64 trace_clock_local(void)
+{
+	unsigned long flags;
+	u64 clock;
+
+	raw_local_irq_save(flags);
+
+	preempt_disable_notrace();
+
+	clock = timecounter_read(&mips_tc);
+
+	preempt_enable_no_resched_notrace();
+
+	raw_local_irq_restore(flags);
+
+	return clock;
+}
+
+static cycle_t mips_cc_read(const struct cyclecounter *cc)
+{
+	return read_c0_count();
+}
+
+static struct cyclecounter mips_cc = {
+	.read = mips_cc_read,
+	.mask = CLOCKSOURCE_MASK(32),
+	.shift = 32,
+};
+
+static int __init mips_timecounter_init(void)
+{
+	uint64_t mips_freq = mips_hpt_frequency;
+
+	mips_cc.mult = div_sc((unsigned long)mips_freq, NSEC_PER_SEC, 32);
+
+	timecounter_init(&mips_tc, &mips_cc, sched_clock());
+
+	return 0;
+}
+
+arch_initcall(mips_timecounter_init);
-- 
1.6.2.1
