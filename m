Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2009 16:18:22 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:60449 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492480AbZJYPRh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2009 16:17:37 +0100
Received: by mail-pz0-f197.google.com with SMTP id 35so7469042pzk.22
        for <multiple recipients>; Sun, 25 Oct 2009 08:17:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=CpEwbr09ulxNTsCjACnigelBuW71Kqandv8iK09WYeo=;
        b=lCR+kib38YD4yW0fUQ44iBpssu7cYR8L4+Cgggf9SNbKp7fk0QkZt4uEEcYaQC3paM
         u+TuBOA8dwEAhaeXjLKArpZCkPpBTyfno+bDACzxb3f4bCzx8ec1H2Gc1rPDIi7CfeK2
         /04gjaZsbtiaikjm4S0MEr0SvaQH3lPMKtYpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F01QtEw2JuAZbXOn5TMg2w9Rh2USOv2hvI58tnFtR3ZnmxTBkO7eMxzTu1RdryBU8t
         vDDfYdR2goStXyOgXCxYoRmD1Uis8GptLlrgzIiL/ywlrfjVUq/cxqLZDo3ZkFAOr77B
         s9gQsUKZUXuad0tinr1h0JUsCUpzCZHj4K/4s=
Received: by 10.115.102.38 with SMTP id e38mr1401154wam.207.1256483856595;
        Sun, 25 Oct 2009 08:17:36 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1742515pxi.14.2009.10.25.08.17.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:17:35 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
Subject: [PATCH -v5 03/11] tracing: add MIPS specific trace_clock_local()
Date:	Sun, 25 Oct 2009 23:16:54 +0800
Message-Id: <3e0c2d7d8b8f196a8153beb41ea7f3cbf42b3d84.1256483735.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256482555.git.wuzhangjin@gmail.com>
 <028867b99ec532b84963a35e7d552becc783cafc.1256483735.git.wuzhangjin@gmail.com>
 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256483735.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch add the mips_timecounter_read() based high precision version
of trace_clock_local().

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/Makefile      |    6 ++++++
 arch/mips/kernel/trace_clock.c |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)
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
index 0000000..0fe85ea
--- /dev/null
+++ b/arch/mips/kernel/trace_clock.c
@@ -0,0 +1,33 @@
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
+	clock = mips_timecounter_read();
+
+	raw_local_irq_restore(flags);
+
+	return clock;
+}
-- 
1.6.2.1
