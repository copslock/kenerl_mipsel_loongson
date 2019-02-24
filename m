Return-Path: <SRS0=K/c0=Q7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA152C43381
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 10:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D46720663
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 10:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="TT9Ce/wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfBXKFi (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 24 Feb 2019 05:05:38 -0500
Received: from [115.28.160.31] ([115.28.160.31]:45314 "EHLO
        mailbox.box.xen0n.name" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1728096AbfBXKFi (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Sun, 24 Feb 2019 05:05:38 -0500
Received: from localhost.localdomain (unknown [116.236.177.50])
        by mailbox.box.xen0n.name (Postfix) with ESMTPA id 76E226017E;
        Sun, 24 Feb 2019 17:37:01 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xen0n.name; s=mail;
        t=1551001021; bh=msSp0LfJ6wJ67dlsuBXzNV/fVDXV5rY9BbgcS8nDE60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TT9Ce/wbNp4nkOC/uibuqc+2Rx9iSzPxRkpDIPRur5HBaYg7WMfKKfCkvmQZK2pjv
         czoOATZ5QJFIdan12hrtX6tzUfFJ/Zf7S1agvYsdzSII2ORaNAhR4mgZ4B/xgvyLsV
         TNlJtIS+pxiNsHxAqT0sj1gOvTP3Dty0+U77TzSU=
From:   kernel@xen0n.name
To:     linux-mips@vger.kernel.org
Cc:     Wang Xuerui <wangxuerui@qiniu.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [RFC PATCH 1/2] MIPS: Loongson: add extcc clocksource
Date:   Sun, 24 Feb 2019 17:36:34 +0800
Message-Id: <20190224093635.1242-2-kernel@xen0n.name>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190224093635.1242-1-kernel@xen0n.name>
References: <20190224093635.1242-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Wang Xuerui <wangxuerui@qiniu.com>

The ExtCC (external counter) is a Loongson GS464E-specific hardware
register that ticks every internal bus cycle.  Hence, the counter is
shared among cores of the same package and can be considered constant
frequency.  The frequency is same as maximum frequency on all Loongson
chips I have access to, and the resolution is very good.

A previous iteration of the feature directly ripped x86 arch code, thus
unsuitable for mainlining.  This time though it's implemented with the
generic clocksource framework for simplicity, but without HPET-assisted
calibration as in x86.  Instead, the ExtCC frequency is directly taken
from firmware.

Blindly trusting firmware-provided values indeed can lead to clock
drifts, of course, but according to own observation on a 3A3000 board
the drift is somewhat acceptable.  For example, during a certain test
run, the firmware advertised 1400.020 MHz, which was refined to
1400.027 MHz by the old ported calibration code.

The current code is tested on a single-socket Loongson 3A3000 board for
slightly over a week, while the old code incorporating essentially the
same logic was deployed for well over 2 years. Stability is perfect and
responsiveness improved greatly, according to cyclictest.

The cyclictest benchmark figures are to be filled later.

Signed-off-by: Wang Xuerui <wangxuerui@qiniu.com>
Tested-by: Wang Xuerui <wangxuerui@qiniu.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mach-loongson64/extcc.h | 26 +++++++++
 arch/mips/loongson64/Kconfig                  | 13 +++++
 arch/mips/loongson64/common/Makefile          |  5 ++
 arch/mips/loongson64/common/extcc.c           | 55 +++++++++++++++++++
 arch/mips/loongson64/common/time.c            |  7 +++
 5 files changed, 106 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-loongson64/extcc.h
 create mode 100644 arch/mips/loongson64/common/extcc.c

diff --git a/arch/mips/include/asm/mach-loongson64/extcc.h b/arch/mips/include/asm/mach-loongson64/extcc.h
new file mode 100644
index 000000000000..9e70f195441e
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson64/extcc.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MACH_LOONGSON64_EXTCC_H
+#define __ASM_MACH_LOONGSON64_EXTCC_H
+
+extern void extcc_clocksource_init(void);
+
+// TODO: is the sync really needed on GS464E? Or if this is really the case,
+// is a weakly-ordered version of this suitable for coarser granularity,
+// just like in x86?
+static __always_inline u64 __extcc_read_ordered(void)
+{
+	u64 result;
+
+	__asm__ __volatile__(
+		".set	push\n\t"
+		".set	arch=mips32r2\n\t"
+		".set	noreorder\n\t"
+		"sync\n\t"
+		"rdhwr	%0, $30\n\t"
+		".set	pop\n"
+		: "=r"(result));
+
+	return result;
+}
+
+#endif /* __ASM_MACH_LOONGSON64_EXTCC_H */
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index 4c14a11525f4..a7213a25a6ab 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -123,6 +123,19 @@ config RS780_HPET
 
 	  If unsure, say Yes.
 
+config LOONGSON_EXTCC_CLKSRC
+	bool "GS464E external counter clocksource"
+	depends on LOONGSON3_ENHANCEMENT && GENERIC_SCHED_CLOCK
+	help
+	  This option enables the external counter found on GS464E chips to
+	  be used as clocksource.
+
+	  The external counter is an internal cycle counter independent of
+	  processor cores, and provides very good (nanosecond-scale) time
+	  resolution.
+
+	  If unsure, say Yes.
+
 config LOONGSON_UART_BASE
 	bool
 	default y
diff --git a/arch/mips/loongson64/common/Makefile b/arch/mips/loongson64/common/Makefile
index 684624f61f5a..5416c794123f 100644
--- a/arch/mips/loongson64/common/Makefile
+++ b/arch/mips/loongson64/common/Makefile
@@ -25,3 +25,8 @@ obj-$(CONFIG_CS5536) += cs5536/
 #
 
 obj-$(CONFIG_SUSPEND) += pm.o
+
+#
+# ExtCC clocksource support
+#
+obj-$(CONFIG_LOONGSON_EXTCC_CLKSRC) += extcc.o
diff --git a/arch/mips/loongson64/common/extcc.c b/arch/mips/loongson64/common/extcc.c
new file mode 100644
index 000000000000..702cb389856a
--- /dev/null
+++ b/arch/mips/loongson64/common/extcc.c
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/sched_clock.h>
+
+#include <loongson.h>
+#include <extcc.h>
+
+static u64 notrace extcc_read(struct clocksource *cs)
+{
+	return __extcc_read_ordered();
+}
+
+static u64 notrace extcc_sched_clock(void)
+{
+	return __extcc_read_ordered();
+}
+
+static struct clocksource extcc_clocksource = {
+	.name		= "extcc",
+	.read		= extcc_read,
+	.mask		= CLOCKSOURCE_MASK(64),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_VALID_FOR_HRES,
+	/* TODO later */
+	.archdata	= { .vdso_clock_mode = VDSO_CLOCK_NONE },
+};
+
+void __init extcc_clocksource_init(void)
+{
+	/* trust the firmware-provided frequency */
+	u32 extcc_frequency = cpu_clock_freq;
+	int ret;
+
+	if (extcc_frequency == 0) {
+		pr_err("Frequency not specified\n");
+		return;
+	}
+
+	/*
+	 * As for the rating, 200+ is good while 300+ is desirable.
+	 * Use 1GHz as bar for "desirable"; most Loongson processors with support
+	 * for ExtCC already satisfy this.
+	 */
+	extcc_clocksource.rating = 200 + extcc_frequency / 10000000;
+
+	ret = clocksource_register_hz(&extcc_clocksource, extcc_frequency);
+	if (ret < 0)
+		pr_warn("Unable to register clocksource\n");
+
+	/* mark extcc as sched clock */
+	sched_clock_register(extcc_sched_clock, 64, extcc_frequency);
+}
+
diff --git a/arch/mips/loongson64/common/time.c b/arch/mips/loongson64/common/time.c
index 0ba53c55ff33..afacc50b7501 100644
--- a/arch/mips/loongson64/common/time.c
+++ b/arch/mips/loongson64/common/time.c
@@ -16,6 +16,9 @@
 
 #include <loongson.h>
 #include <cs5536/cs5536_mfgpt.h>
+#ifdef CONFIG_LOONGSON_EXTCC_CLKSRC
+#include <extcc.h>
+#endif
 
 void __init plat_time_init(void)
 {
@@ -27,6 +30,10 @@ void __init plat_time_init(void)
 #else
 	setup_mfgpt0_timer();
 #endif
+
+#ifdef CONFIG_LOONGSON_EXTCC_CLKSRC
+	extcc_clocksource_init();
+#endif
 }
 
 void read_persistent_clock64(struct timespec64 *ts)
-- 
2.20.1

