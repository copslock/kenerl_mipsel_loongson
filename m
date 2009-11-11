Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 07:53:29 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:62066 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492004AbZKKGxB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 07:53:01 +0100
Received: by pwi15 with SMTP id 15so534935pwi.24
        for <multiple recipients>; Tue, 10 Nov 2009 22:52:54 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=9dTFplfaF4zmG7br+57NPto4BwRVtyY2/APesczQ2+4=;
        b=rSuXilvJw7YZv34aXlZd+6F0BM5Nft8+z8ddeECP8BlIxfrIZPBbh5W0LB/3w3nev7
         vcGFlEdlbtTiK4/8NKAUYeVCmjSd4erT97mwQnjWfW5ZbstO7ccUI0YX74yKSxKH/nVN
         z6AXIZsvk4XLy5xPHRmi3cJrl63+JBmjZULzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Gwl4zp7SWYunUI1heFko3b5Tc6yepTQOMjyCi2rawLdSPHko7Z9HMy0Vu2WwvxH7iX
         aurNeZHktlUQgwsmZZdTu9iUzlmbdc1DmQLYfJEnXbqxf2coTOS8KDf0bGTYBjS/1PBI
         pX4B8GNbxpgqUuxA1bW0JDb0CTXVTbqAL8XfI=
Received: by 10.114.163.31 with SMTP id l31mr2425412wae.67.1257922374572;
        Tue, 10 Nov 2009 22:52:54 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm819777pzk.2.2009.11.10.22.52.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 22:52:54 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 1/2] [loongson] 2f: add suspend support framework
Date:	Wed, 11 Nov 2009 14:52:36 +0800
Message-Id: <1368943cd7de052a825f8b23ec730b8546278d1e.1257922151.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1257920162.git.wuzhangjin@gmail.com>
References: <cover.1257920162.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257922151.git.wuzhangjin@gmail.com>
References: <cover.1257922151.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch add basic suspend support for loongson2f family machines,
loongson2f have a specific feature: when we set it's frequency to ZERO,
it will go into a wait mode, and then can be waked up by the external
interrupt. so, if we setup suitable interrupts before putting it into
wait mode, we will be able wake it up whenever we want via sending the
relative interrupts to it.

These interrupts are board-specific, Yeeloong2F use the keyboard
interrupt and SCI interrupt, but LingLoong and Fuloong2F use the
interrupts connected to the processors directly. and BTW: some old
LingLoong and FuLoong2F have no such interrupts connected, so, there is
no way to wake them up from suspend mode. and therefore, please do not
enable the kernel support for them.

The board-specific support will be added in the coming patches.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/Kconfig         |    5 +
 arch/mips/loongson/common/Makefile |    6 ++
 arch/mips/loongson/common/pm.c     |  157 ++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/common/pm.c

diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index a214127..029360f 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -61,3 +61,8 @@ endchoice
 
 config CS5536
 	bool
+
+config LOONGSON_SUSPEND
+	bool
+	default y
+	depends on CPU_SUPPORT_CPUFREQ && SUSPEND
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index a82527f..a21724d 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -16,3 +16,9 @@ obj-$(CONFIG_SERIAL_8250) += serial.o
 # space
 #
 obj-$(CONFIG_CS5536) += cs5536/
+
+#
+# Suspend Support
+#
+
+obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
diff --git a/arch/mips/loongson/common/pm.c b/arch/mips/loongson/common/pm.c
new file mode 100644
index 0000000..4e5c56e
--- /dev/null
+++ b/arch/mips/loongson/common/pm.c
@@ -0,0 +1,157 @@
+/*
+ * loongson-specific suspend support
+ *
+ *  Copyright (C) 2009 Lemote Inc.
+ *  Author: Wu Zhangjin <wuzj@lemote.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/suspend.h>
+#include <linux/interrupt.h>
+#include <linux/pm.h>
+
+#include <asm/i8259.h>
+#include <asm/mipsregs.h>
+
+#include <loongson.h>
+
+static unsigned int __maybe_unused cached_master_mask;	/* i8259A */
+static unsigned int __maybe_unused cached_slave_mask;
+static unsigned int __maybe_unused cached_bonito_irq_mask; /* bonito */
+
+void arch_suspend_disable_irqs(void)
+{
+	/* disable all mips events */
+	local_irq_disable();
+#ifdef CONFIG_I8259
+	/* disable all events of i8259A */
+	cached_slave_mask = inb(PIC_SLAVE_IMR);
+	cached_master_mask = inb(PIC_MASTER_IMR);
+
+	outb(0xff, PIC_SLAVE_IMR);
+	inb(PIC_SLAVE_IMR);
+	outb(0xff, PIC_MASTER_IMR);
+	inb(PIC_MASTER_IMR);
+#endif
+	/* disable all events of bonito */
+	cached_bonito_irq_mask = LOONGSON_INTEN;
+	LOONGSON_INTENCLR = 0xffff;
+	(void)LOONGSON_INTENCLR;
+}
+
+void arch_suspend_enable_irqs(void)
+{
+	/* enable all mips events */
+	local_irq_enable();
+#ifdef CONFIG_I8259
+	/* only enable the cached events of i8259A */
+	outb(cached_slave_mask, PIC_SLAVE_IMR);
+	outb(cached_master_mask, PIC_MASTER_IMR);
+#endif
+	/* enable all cached events of bonito */
+	LOONGSON_INTENSET = cached_bonito_irq_mask;
+	(void)LOONGSON_INTENSET;
+}
+
+/* setup the board-specific events for waking up loongson from wait mode */
+void __weak setup_wakeup_events(void)
+{
+}
+
+/* check wakeup events */
+int __weak wakeup_loongson(void)
+{
+	return 1;
+}
+
+/* if the events are really what we want to wakeup cpu, wake up it, otherwise,
+ * we Put CPU into wait mode again.
+ */
+static void wait_for_wakeup_events(void)
+{
+	while (!wakeup_loongson())
+		LOONGSON_CHIPCFG0 &= ~0x7;
+}
+
+/* stop all perf counters by default
+ *   $24 is the control register of loongson perf counter
+ */
+static inline void stop_perf_counters(void)
+{
+	__write_64bit_c0_register($24, 0, 0);
+}
+
+
+static void loongson_suspend_enter(void)
+{
+	static unsigned int cached_cpu_freq;
+
+	/* setup wakeup events via enabling the IRQs */
+	setup_wakeup_events();
+
+	/* stop all perf counters */
+	stop_perf_counters();
+
+	cached_cpu_freq = LOONGSON_CHIPCFG0;
+
+	/* Put CPU into wait mode */
+	LOONGSON_CHIPCFG0 &= ~0x7;
+
+	/* wait for the given events to wakeup cpu from wait mode */
+	wait_for_wakeup_events();
+
+	LOONGSON_CHIPCFG0 = cached_cpu_freq;
+	mmiowb();
+}
+
+void __weak mach_suspend(void)
+{
+}
+
+void __weak mach_resume(void)
+{
+}
+
+static int loongson_pm_enter(suspend_state_t state)
+{
+	/* mach specific suspend */
+	mach_suspend();
+
+	/* processor specific suspend */
+	loongson_suspend_enter();
+
+	/* mach specific resume */
+	mach_resume();
+
+	return 0;
+}
+
+static int loongson_pm_valid_state(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_ON:
+	case PM_SUSPEND_STANDBY:
+	case PM_SUSPEND_MEM:
+		return 1;
+
+	default:
+		return 0;
+	}
+}
+
+static struct platform_suspend_ops loongson_pm_ops = {
+	.valid	= loongson_pm_valid_state,
+	.enter	= loongson_pm_enter,
+};
+
+static int __init loongson_pm_init(void)
+{
+	suspend_set_ops(&loongson_pm_ops);
+
+	return 0;
+}
+arch_initcall(loongson_pm_init);
-- 
1.6.2.1
