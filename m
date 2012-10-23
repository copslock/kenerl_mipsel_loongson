Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:50:32 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:63547 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825707Ab2JWRsEre31o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:48:04 +0200
Received: by mail-lb0-f177.google.com with SMTP id gi11so520872lbb.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hEJxWLf0GG4EQj/ZEGFluP71n2ATVaapEhUL3xqwBfM=;
        b=tbXUV2fNsQukPCUEcQhFcYAGR+0d8Ue/3ZrXNUSaNRNAqm3o9P8JUQtE01N7hmgM1Q
         VEk6dW2RXiFIetMxD8D4lvS4jtOh34qRr3tEA+rKyiPZ8E7sk6nVVu67Sa3JiOM4GD53
         Di6kWAIlnra9V+X3PvKAnCCu0Ew+sWKELwMxFIrxLwcQHHPg4TOUpjdpCXWfxwFk/FxA
         0Pz7cfKijGj75iakkPjhmuVHSFgBtd/2hnGN1+Hk6952sdOXWMIWEnAGMSZhNSOHy4T5
         JLQZaAmUWHLBft7g9syyzS2kNu+xwJaGb3DqCRt34q0ALkqaLi1mtYGjk5GsFULtz+9K
         SVUg==
Received: by 10.152.108.197 with SMTP id hm5mr12138126lab.45.1351014477252;
        Tue, 23 Oct 2012 10:47:57 -0700 (PDT)
Received: from lazar.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by mx.google.com with ESMTPS id m6sm4260284lbh.10.2012.10.23.10.47.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 10:47:55 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC 04/13] MIPS: JZ4750D: Add timer support
Date:   Tue, 23 Oct 2012 21:43:52 +0400
Message-Id: <1351014241-3207-5-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-archive-position: 34758
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

Add support for the timer/counter unit on a JZ4750D SoC. This code is used
as a common base for the JZ4750D clocksource/clockevent implementation and
PWM support.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/include/asm/mach-jz4750d/timer.h |   21 ++++
 arch/mips/jz4750d/timer.c                  |   49 ++++++++
 arch/mips/jz4750d/timer.h                  |  182 ++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-jz4750d/timer.h
 create mode 100644 arch/mips/jz4750d/timer.c
 create mode 100644 arch/mips/jz4750d/timer.h

diff --git a/arch/mips/include/asm/mach-jz4750d/timer.h b/arch/mips/include/asm/mach-jz4750d/timer.h
new file mode 100644
index 0000000..7a1ba46
--- /dev/null
+++ b/arch/mips/include/asm/mach-jz4750d/timer.h
@@ -0,0 +1,21 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D platform timer support
+ *
+ *  based on JZ4740 platform timer support
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef __ASM_MACH_JZ4750D_TIMER
+#define __ASM_MACH_JZ4750D_TIMER
+
+void jz4750d_timer_enable_watchdog(void);
+void jz4750d_timer_disable_watchdog(void);
+
+#endif
diff --git a/arch/mips/jz4750d/timer.c b/arch/mips/jz4750d/timer.c
new file mode 100644
index 0000000..85682b1
--- /dev/null
+++ b/arch/mips/jz4750d/timer.c
@@ -0,0 +1,49 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D platform timer support
+ *
+ *  based on JZ4740 platform timer support
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
+#include <linux/module.h>
+
+#include "timer.h"
+
+#include <asm/mach-jz4750d/base.h>
+
+void __iomem *jz4750d_timer_base;
+
+void jz4750d_timer_enable_watchdog(void)
+{
+	writel(BIT(16), jz4750d_timer_base + JZ_REG_TIMER_STOP_CLEAR);
+}
+EXPORT_SYMBOL_GPL(jz4750d_timer_enable_watchdog);
+
+void jz4750d_timer_disable_watchdog(void)
+{
+	writel(BIT(16), jz4750d_timer_base + JZ_REG_TIMER_STOP_SET);
+}
+EXPORT_SYMBOL_GPL(jz4750d_timer_disable_watchdog);
+
+void __init jz4750d_timer_init(void)
+{
+	jz4750d_timer_base = ioremap(JZ4750D_TCU_BASE_ADDR, 0x100);
+
+	if (!jz4750d_timer_base)
+		panic("Failed to ioremap timer registers");
+
+	/* Disable __ALL__ timer clocks */
+	writel(0x000180ff, jz4750d_timer_base + JZ_REG_TIMER_STOP_SET);
+
+	/* Timer irqs are unmasked by default, mask them __ALL__ */
+	writel(0x003f803f, jz4750d_timer_base + JZ_REG_TIMER_MASK_SET);
+}
diff --git a/arch/mips/jz4750d/timer.h b/arch/mips/jz4750d/timer.h
new file mode 100644
index 0000000..05e4752
--- /dev/null
+++ b/arch/mips/jz4750d/timer.h
@@ -0,0 +1,182 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D platform timer support
+ *
+ *  based on JZ4740 platform timer support
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef __MIPS_JZ4750D_TIMER_H__
+#define __MIPS_JZ4750D_TIMER_H__
+
+#include <linux/module.h>
+#include <linux/io.h>
+
+#define JZ_REG_TIMER_ENABLE		0x00
+#define JZ_REG_TIMER_ENABLE_SET		0x04
+#define JZ_REG_TIMER_ENABLE_CLEAR	0x08
+#define JZ_REG_TIMER_FLAG		0x10
+#define JZ_REG_TIMER_FLAG_SET		0x14
+#define JZ_REG_TIMER_FLAG_CLEAR		0x18
+#define JZ_REG_TIMER_STOP		0x0C
+#define JZ_REG_TIMER_STOP_SET		0x1C
+#define JZ_REG_TIMER_STOP_CLEAR		0x2C
+#define JZ_REG_TIMER_MASK		0x20
+#define JZ_REG_TIMER_MASK_SET		0x24
+#define JZ_REG_TIMER_MASK_CLEAR		0x28
+
+#define JZ_REG_TIMER_DFR(x) (((x) * 0x10) + 0x30)
+#define JZ_REG_TIMER_DHR(x) (((x) * 0x10) + 0x34)
+#define JZ_REG_TIMER_CNT(x) (((x) * 0x10) + 0x38)
+#define JZ_REG_TIMER_CTRL(x) (((x) * 0x10) + 0x3C)
+
+#define JZ_TIMER_IRQ_HALF(x) BIT((x) + 0x10)
+#define JZ_TIMER_IRQ_FULL(x) BIT(x)
+
+#define JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN	BIT(9)
+#define JZ_TIMER_CTRL_PWM_ACTIVE_LOW		BIT(8)
+#define JZ_TIMER_CTRL_PWM_ENABLE		BIT(7)
+#define JZ_TIMER_CTRL_PRESCALE_MASK		0x1c
+#define JZ_TIMER_CTRL_PRESCALE_OFFSET		0x3
+#define JZ_TIMER_CTRL_PRESCALE_1		(0 << 3)
+#define JZ_TIMER_CTRL_PRESCALE_4		(1 << 3)
+#define JZ_TIMER_CTRL_PRESCALE_16		(2 << 3)
+#define JZ_TIMER_CTRL_PRESCALE_64		(3 << 3)
+#define JZ_TIMER_CTRL_PRESCALE_256		(4 << 3)
+#define JZ_TIMER_CTRL_PRESCALE_1024		(5 << 3)
+
+#define JZ_TIMER_CTRL_PRESCALER(x) ((x) << JZ_TIMER_CTRL_PRESCALE_OFFSET)
+
+#define JZ_TIMER_CTRL_SRC_EXT		BIT(2)
+#define JZ_TIMER_CTRL_SRC_RTC		BIT(1)
+#define JZ_TIMER_CTRL_SRC_PCLK		BIT(0)
+
+extern void __iomem *jz4750d_timer_base;
+void __init jz4750d_timer_init(void);
+
+static inline void jz4750d_timer_stop(unsigned int timer)
+{
+	writel(BIT(timer), jz4750d_timer_base + JZ_REG_TIMER_STOP_SET);
+}
+
+static inline void jz4750d_timer_start(unsigned int timer)
+{
+	writel(BIT(timer), jz4750d_timer_base + JZ_REG_TIMER_STOP_CLEAR);
+}
+
+static inline bool jz4750d_timer_is_enabled(unsigned int timer)
+{
+	return readb(jz4750d_timer_base + JZ_REG_TIMER_ENABLE) & BIT(timer);
+}
+
+static inline void jz4750d_timer_enable(unsigned int timer)
+{
+	writeb(BIT(timer), jz4750d_timer_base + JZ_REG_TIMER_ENABLE_SET);
+}
+
+static inline void jz4750d_timer_disable(unsigned int timer)
+{
+	writeb(BIT(timer), jz4750d_timer_base + JZ_REG_TIMER_ENABLE_CLEAR);
+}
+
+static inline void jz4750d_timer_set_period(unsigned int timer, u16 period)
+{
+	writew(period, jz4750d_timer_base + JZ_REG_TIMER_DFR(timer));
+}
+
+static inline void jz4750d_timer_set_duty(unsigned int timer, u16 duty)
+{
+	writew(duty, jz4750d_timer_base + JZ_REG_TIMER_DHR(timer));
+}
+
+static inline void jz4750d_timer_set_count(unsigned int timer, u16 count)
+{
+	writew(count, jz4750d_timer_base + JZ_REG_TIMER_CNT(timer));
+}
+
+static inline u16 jz4750d_timer_get_count(unsigned int timer)
+{
+	return readw(jz4750d_timer_base + JZ_REG_TIMER_CNT(timer));
+}
+
+static inline void jz4750d_timer_ack_full(unsigned int timer)
+{
+	writel(JZ_TIMER_IRQ_FULL(timer),
+		jz4750d_timer_base + JZ_REG_TIMER_FLAG_CLEAR);
+}
+
+static inline void jz4750d_timer_irq_full_enable(unsigned int timer)
+{
+	writel(JZ_TIMER_IRQ_FULL(timer),
+		jz4750d_timer_base + JZ_REG_TIMER_FLAG_CLEAR);
+	writel(JZ_TIMER_IRQ_FULL(timer),
+		jz4750d_timer_base + JZ_REG_TIMER_MASK_CLEAR);
+}
+
+static inline void jz4750d_timer_irq_full_disable(unsigned int timer)
+{
+	writel(JZ_TIMER_IRQ_FULL(timer),
+		jz4750d_timer_base + JZ_REG_TIMER_MASK_SET);
+}
+
+static inline void jz4750d_timer_set_ctrl(unsigned int timer, u16 ctrl)
+{
+	writew(ctrl, jz4750d_timer_base + JZ_REG_TIMER_CTRL(timer));
+}
+
+static inline u16 jz4750d_timer_get_ctrl(unsigned int timer)
+{
+	return readw(jz4750d_timer_base + JZ_REG_TIMER_CTRL(timer));
+}
+
+#define JZ_REG_OSTIMER_DR		0xD0
+#define JZ_REG_OSTIMER_CNT		0xD8
+#define JZ_REG_OSTIMER_CTRL		0xDC
+
+#define JZ_OSTIMER_CTRL_PRESCALE_1		(0 << 3)
+#define JZ_OSTIMER_CTRL_PRESCALE_4		(1 << 3)
+#define JZ_OSTIMER_CTRL_PRESCALE_16		(2 << 3)
+#define JZ_OSTIMER_CTRL_PRESCALE_64		(3 << 3)
+#define JZ_OSTIMER_CTRL_PRESCALE_256		(4 << 3)
+#define JZ_OSTIMER_CTRL_PRESCALE_1024		(5 << 3)
+
+#define JZ_OSTIMER_CTRL_SRC_EXT		BIT(2)
+#define JZ_OSTIMER_CTRL_SRC_RTC		BIT(1)
+#define JZ_OSTIMER_CTRL_SRC_PCLK	BIT(0)
+
+#define JZ_TIMER_SCR_OSTSC		BIT(15)
+#define JZ_TIMER_ESR_OSTST		BIT(15)
+
+static inline void jz4750d_ostimer_set_ctrl(u16 ctrl)
+{
+	writew(ctrl, jz4750d_timer_base + JZ_REG_OSTIMER_CTRL);
+}
+
+static inline uint32_t jz4750d_ostimer_get_count(void)
+{
+	return readl(jz4750d_timer_base + JZ_REG_OSTIMER_CNT);
+}
+
+static inline void jz4750d_ostimer_start(void)
+{
+	writel(JZ_TIMER_SCR_OSTSC,
+		jz4750d_timer_base + JZ_REG_TIMER_STOP_CLEAR);
+}
+
+static inline void jz4750d_ostimer_enable(void)
+{
+	writel(JZ_TIMER_ESR_OSTST,
+		jz4750d_timer_base + JZ_REG_TIMER_ENABLE_SET);
+}
+
+static inline void jz4750d_ostimer_set_period(u32 period)
+{
+	writel(period, jz4750d_timer_base + JZ_REG_OSTIMER_DR);
+}
+#endif
-- 
1.7.10.4
