Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jun 2010 07:11:06 +0200 (CEST)
Received: from smtp-out-037.synserver.de ([212.40.180.37]:1030 "HELO
        smtp-out-036.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S1491965Ab0FSFJY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jun 2010 07:09:24 +0200
Received: (qmail 13802 invoked by uid 0); 19 Jun 2010 05:09:24 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 13414
Received: from d024024.adsl.hansenet.de (HELO localhost.localdomain) [80.171.24.24]
  by 217.119.54.77 with SMTP; 19 Jun 2010 05:09:23 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 04/26] MIPS: JZ4740: Add timer support
Date:   Sat, 19 Jun 2010 07:08:09 +0200
Message-Id: <1276924111-11158-5-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1276924111-11158-1-git-send-email-lars@metafoo.de>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
X-archive-position: 27178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13360

This patch adds support for the timer/counter unit on a JZ4740 SoC.
This code is used as a common base for the JZ4740 clocksource/clockevent
implementation and PWM support.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/include/asm/mach-jz4740/timer.h |   22 +++++
 arch/mips/jz4740/timer.c                  |   48 ++++++++++
 arch/mips/jz4740/timer.h                  |  136 +++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-jz4740/timer.h
 create mode 100644 arch/mips/jz4740/timer.c
 create mode 100644 arch/mips/jz4740/timer.h

diff --git a/arch/mips/include/asm/mach-jz4740/timer.h b/arch/mips/include/asm/mach-jz4740/timer.h
new file mode 100644
index 0000000..9baa03c
--- /dev/null
+++ b/arch/mips/include/asm/mach-jz4740/timer.h
@@ -0,0 +1,22 @@
+/*
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  JZ4740 platform timer support
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#ifndef __ASM_MACH_JZ4740_TIMER
+#define __ASM_MACH_JZ4740_TIMER
+
+void jz4740_timer_enable_watchdog(void);
+void jz4740_timer_disable_watchdog(void);
+
+#endif
diff --git a/arch/mips/jz4740/timer.c b/arch/mips/jz4740/timer.c
new file mode 100644
index 0000000..b2c0151
--- /dev/null
+++ b/arch/mips/jz4740/timer.c
@@ -0,0 +1,48 @@
+/*
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  JZ4740 platform timer support
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "timer.h"
+
+#include <asm/mach-jz4740/base.h>
+
+void __iomem *jz4740_timer_base;
+
+void jz4740_timer_enable_watchdog(void)
+{
+	writel(BIT(16), jz4740_timer_base + JZ_REG_TIMER_STOP_CLEAR);
+}
+
+void jz4740_timer_disable_watchdog(void)
+{
+	writel(BIT(16), jz4740_timer_base + JZ_REG_TIMER_STOP_SET);
+}
+
+void __init jz4740_timer_init(void)
+{
+	jz4740_timer_base = ioremap(JZ4740_TCU_BASE_ADDR, 0x100);
+
+	if (!jz4740_timer_base)
+		panic("Failed to ioremap timer registers");
+
+	/* Disable all timer clocks except for those used as system timers */
+	writel(0x000100fc, jz4740_timer_base + JZ_REG_TIMER_STOP_SET);
+
+	/* Timer irqs are unmasked by default, mask them */
+	writel(0x00ff00ff, jz4740_timer_base + JZ_REG_TIMER_MASK_SET);
+}
diff --git a/arch/mips/jz4740/timer.h b/arch/mips/jz4740/timer.h
new file mode 100644
index 0000000..fca3994
--- /dev/null
+++ b/arch/mips/jz4740/timer.h
@@ -0,0 +1,136 @@
+/*
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *  JZ4740 platform timer support
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#ifndef __MIPS_JZ4740_TIMER_H__
+#define __MIPS_JZ4740_TIMER_H__
+
+#include <linux/module.h>
+#include <linux/io.h>
+
+#define JZ_REG_TIMER_STOP		0x0C
+#define JZ_REG_TIMER_STOP_SET		0x1C
+#define JZ_REG_TIMER_STOP_CLEAR		0x2C
+#define JZ_REG_TIMER_ENABLE		0x00
+#define JZ_REG_TIMER_ENABLE_SET		0x04
+#define JZ_REG_TIMER_ENABLE_CLEAR	0x08
+#define JZ_REG_TIMER_FLAG		0x10
+#define JZ_REG_TIMER_FLAG_SET		0x14
+#define JZ_REG_TIMER_FLAG_CLEAR		0x18
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
+extern void __iomem *jz4740_timer_base;
+void __init jz4740_timer_init(void);
+
+static inline void jz4740_timer_stop(unsigned int timer)
+{
+	writel(BIT(timer), jz4740_timer_base + JZ_REG_TIMER_STOP_SET);
+}
+
+static inline void jz4740_timer_start(unsigned int timer)
+{
+	writel(BIT(timer), jz4740_timer_base + JZ_REG_TIMER_STOP_CLEAR);
+}
+
+static inline bool jz4740_timer_is_enabled(unsigned int timer)
+{
+	return readb(jz4740_timer_base + JZ_REG_TIMER_ENABLE) & BIT(timer);
+}
+
+static inline void jz4740_timer_enable(unsigned int timer)
+{
+	writeb(BIT(timer), jz4740_timer_base + JZ_REG_TIMER_ENABLE_SET);
+}
+
+static inline void jz4740_timer_disable(unsigned int timer)
+{
+	writeb(BIT(timer), jz4740_timer_base + JZ_REG_TIMER_ENABLE_CLEAR);
+}
+
+
+static inline void jz4740_timer_set_period(unsigned int timer, uint16_t period)
+{
+	writew(period, jz4740_timer_base + JZ_REG_TIMER_DFR(timer));
+}
+
+static inline void jz4740_timer_set_duty(unsigned int timer, uint16_t duty)
+{
+	writew(duty, jz4740_timer_base + JZ_REG_TIMER_DHR(timer));
+}
+
+static inline void jz4740_timer_set_count(unsigned int timer, uint16_t count)
+{
+	writew(count, jz4740_timer_base + JZ_REG_TIMER_CNT(timer));
+}
+
+static inline uint16_t jz4740_timer_get_count(unsigned int timer)
+{
+	return readw(jz4740_timer_base + JZ_REG_TIMER_CNT(timer));
+}
+
+static inline void jz4740_timer_ack_full(unsigned int timer)
+{
+	writel(JZ_TIMER_IRQ_FULL(timer), jz4740_timer_base + JZ_REG_TIMER_FLAG_CLEAR);
+}
+
+static inline void jz4740_timer_irq_full_enable(unsigned int timer)
+{
+	writel(JZ_TIMER_IRQ_FULL(timer), jz4740_timer_base + JZ_REG_TIMER_FLAG_CLEAR);
+	writel(JZ_TIMER_IRQ_FULL(timer), jz4740_timer_base + JZ_REG_TIMER_MASK_CLEAR);
+}
+
+static inline void jz4740_timer_irq_full_disable(unsigned int timer)
+{
+	writel(JZ_TIMER_IRQ_FULL(timer), jz4740_timer_base + JZ_REG_TIMER_MASK_SET);
+}
+
+static inline void jz4740_timer_set_ctrl(unsigned int timer, uint16_t ctrl)
+{
+	writew(ctrl, jz4740_timer_base + JZ_REG_TIMER_CTRL(timer));
+}
+
+static inline uint16_t jz4740_timer_get_ctrl(unsigned int timer)
+{
+	return readw(jz4740_timer_base + JZ_REG_TIMER_CTRL(timer));
+}
+
+#endif
-- 
1.5.6.5
