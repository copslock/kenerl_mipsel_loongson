Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:49:15 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:33813 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825698Ab2JWRsAeLx04 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:48:00 +0200
Received: by mail-la0-f49.google.com with SMTP id z14so2431916lag.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sIBUmOe+lSN2n37V0e1aTdnku7fnj+9bQ1vi1qDJm+8=;
        b=Wp0QaScxG+PS+21ia3CVm0EQ+gQdUGuygZL1MR3PT2S38z5EDVW8ssDIm5pgV0VGvO
         5w6tABzqu8x/oKhFYC2Jy08FeecknS2l01o8D7jmAByVE9Vor6grsJNKKzpbAvU1XYFQ
         EpbgOKO6Tysh6cppUEtanADXtNn+hDNSFGN2CyPvx6WGbHOj2IqEZfDqbxT+qrATTkRA
         vRk52CgIkzMTGrkfKwbAAJkOqvAPABBkJyjwSEQlRhmd94g1jptOAg2wN90FVGvvff6M
         vDQF+IQqpRJt8zqeT7Uwt0frt9PXZik7zJ4Nw4GNvOCdZJBaCH1YBVm4mEAgutYQiJEl
         hASA==
Received: by 10.112.102.195 with SMTP id fq3mr5318991lbb.46.1351014480063;
        Tue, 23 Oct 2012 10:48:00 -0700 (PDT)
Received: from lazar.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by mx.google.com with ESMTPS id m6sm4260284lbh.10.2012.10.23.10.47.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 10:47:59 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC 06/13] MIPS: JZ4750D: Add system reset support
Date:   Tue, 23 Oct 2012 21:43:54 +0400
Message-Id: <1351014241-3207-7-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-archive-position: 34754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add support for poweroff/reboot on a JZ4750D SoC.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/jz4750d/reset.c |   79 +++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/jz4750d/reset.h |    6 ++++
 2 files changed, 85 insertions(+)
 create mode 100644 arch/mips/jz4750d/reset.c
 create mode 100644 arch/mips/jz4750d/reset.h

diff --git a/arch/mips/jz4750d/reset.c b/arch/mips/jz4750d/reset.c
new file mode 100644
index 0000000..eb8441c
--- /dev/null
+++ b/arch/mips/jz4750d/reset.c
@@ -0,0 +1,79 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D reset routines
+ *
+ *  based on JZ4740 reset routines
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/pm.h>
+
+#include <asm/reboot.h>
+
+#include <asm/mach-jz4750d/base.h>
+#include <asm/mach-jz4750d/timer.h>
+
+static void jz4750d_halt(void)
+{
+	while (1) {
+		__asm__(".set push;\n"
+			".set mips3;\n"
+			"wait;\n"
+			".set pop;\n"
+		);
+	}
+}
+
+#define JZ_REG_WDT_DATA 0x00
+#define JZ_REG_WDT_COUNTER_ENABLE 0x04
+#define JZ_REG_WDT_COUNTER 0x08
+#define JZ_REG_WDT_CTRL 0x0c
+
+static void jz4750d_restart(char *command)
+{
+	void __iomem *wdt_base = ioremap(JZ4750D_WDT_BASE_ADDR, 0x0f);
+
+	jz4750d_timer_enable_watchdog();
+
+	writeb(0, wdt_base + JZ_REG_WDT_COUNTER_ENABLE);
+
+	writew(0, wdt_base + JZ_REG_WDT_COUNTER);
+	writew(0, wdt_base + JZ_REG_WDT_DATA);
+	writew(BIT(2), wdt_base + JZ_REG_WDT_CTRL);
+
+	writeb(1, wdt_base + JZ_REG_WDT_COUNTER_ENABLE);
+	jz4750d_halt();
+}
+
+#define JZ_REG_RTC_CTRL		0x00
+#define JZ_REG_RTC_HIBERNATE	0x20
+
+#define JZ_RTC_CTRL_WRDY	BIT(7)
+
+static void jz4750d_power_off(void)
+{
+	void __iomem *rtc_base = ioremap(JZ4750D_RTC_BASE_ADDR, 0x24);
+	uint32_t ctrl;
+
+	do {
+		ctrl = readl(rtc_base + JZ_REG_RTC_CTRL);
+	} while (!(ctrl & JZ_RTC_CTRL_WRDY));
+
+	writel(1, rtc_base + JZ_REG_RTC_HIBERNATE);
+	jz4750d_halt();
+}
+
+void jz4750d_reset_init(void)
+{
+	_machine_restart = jz4750d_restart;
+	_machine_halt = jz4750d_halt;
+	pm_power_off = jz4750d_power_off;
+}
diff --git a/arch/mips/jz4750d/reset.h b/arch/mips/jz4750d/reset.h
new file mode 100644
index 0000000..e00d1e1
--- /dev/null
+++ b/arch/mips/jz4750d/reset.h
@@ -0,0 +1,6 @@
+#ifndef __MIPS_JZ4750D_RESET_H__
+#define __MIPS_JZ4750D_RESET_H__
+
+extern void jz4750d_reset_init(void);
+
+#endif
-- 
1.7.10.4
