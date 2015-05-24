Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 17:30:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29221 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006783AbbEXPaFwtANN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 17:30:05 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 48DF39636C055;
        Sun, 24 May 2015 16:29:59 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 24 May 2015 16:27:56 +0100
Received: from localhost (192.168.159.140) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 24 May
 2015 16:27:49 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mike Turquette <mturquette@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <linux-clk@vger.kernel.org>,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 29/37] MIPS, clk: move jz4740 clock suspend, resume functions to jz4740-cgu
Date:   Sun, 24 May 2015 16:11:39 +0100
Message-ID: <1432480307-23789-30-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
In-Reply-To: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
References: <1432480307-23789-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.140]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The jz4740-cgu driver already has access to the CGU, so it makes sense
to move the few remaining accesses to the CGU from arch/mips/jz4740
there too. Move the jz4740_clock_{suspend,resume} functions there for
such consistency. The arch/mips/jz4740/clock.c file now contains nothing
more of use & so is removed.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org
Cc: linux-mips@linux-mips.org
---

Changes in v5: None
Changes in v4: None
Changes in v3:
- Rebase.

Changes in v2: None

 arch/mips/include/asm/mach-jz4740/clock.h |  2 -
 arch/mips/jz4740/Makefile                 |  2 +-
 arch/mips/jz4740/clock.c                  | 95 -------------------------------
 arch/mips/jz4740/time.c                   |  1 -
 drivers/clk/ingenic/jz4740-cgu.c          | 37 ++++++++++++
 5 files changed, 38 insertions(+), 99 deletions(-)
 delete mode 100644 arch/mips/jz4740/clock.c

diff --git a/arch/mips/include/asm/mach-jz4740/clock.h b/arch/mips/include/asm/mach-jz4740/clock.h
index 01d8468..16659cd 100644
--- a/arch/mips/include/asm/mach-jz4740/clock.h
+++ b/arch/mips/include/asm/mach-jz4740/clock.h
@@ -20,8 +20,6 @@ enum jz4740_wait_mode {
 	JZ4740_WAIT_MODE_SLEEP,
 };
 
-int jz4740_clock_init(void);
-
 void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode);
 
 void jz4740_clock_udc_enable_auto_suspend(void);
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index fdb12efc..7636432 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -5,7 +5,7 @@
 # Object file lists.
 
 obj-y += prom.o time.o reset.o setup.o \
-	gpio.o clock.o platform.o timer.o serial.o
+	gpio.o platform.o timer.o serial.o
 
 # board specific support
 
diff --git a/arch/mips/jz4740/clock.c b/arch/mips/jz4740/clock.c
deleted file mode 100644
index 2a10829..0000000
--- a/arch/mips/jz4740/clock.c
+++ /dev/null
@@ -1,95 +0,0 @@
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 SoC clock support
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General	 Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/spinlock.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/list.h>
-#include <linux/err.h>
-
-#include <asm/mach-jz4740/clock.h>
-#include <asm/mach-jz4740/base.h>
-
-#include "clock.h"
-
-#define JZ_REG_CLOCK_PLL	0x10
-#define JZ_REG_CLOCK_GATE	0x20
-
-#define JZ_CLOCK_GATE_UART0	BIT(0)
-#define JZ_CLOCK_GATE_TCU	BIT(1)
-#define JZ_CLOCK_GATE_DMAC	BIT(12)
-
-#define JZ_CLOCK_PLL_STABLE		BIT(10)
-#define JZ_CLOCK_PLL_ENABLED		BIT(8)
-
-static void __iomem *jz_clock_base;
-
-static uint32_t jz_clk_reg_read(int reg)
-{
-	return readl(jz_clock_base + reg);
-}
-
-static void jz_clk_reg_set_bits(int reg, uint32_t mask)
-{
-	uint32_t val;
-
-	val = readl(jz_clock_base + reg);
-	val |= mask;
-	writel(val, jz_clock_base + reg);
-}
-
-static void jz_clk_reg_clear_bits(int reg, uint32_t mask)
-{
-	uint32_t val;
-
-	val = readl(jz_clock_base + reg);
-	val &= ~mask;
-	writel(val, jz_clock_base + reg);
-}
-
-void jz4740_clock_suspend(void)
-{
-	jz_clk_reg_set_bits(JZ_REG_CLOCK_GATE,
-		JZ_CLOCK_GATE_TCU | JZ_CLOCK_GATE_DMAC | JZ_CLOCK_GATE_UART0);
-
-	jz_clk_reg_clear_bits(JZ_REG_CLOCK_PLL, JZ_CLOCK_PLL_ENABLED);
-}
-
-void jz4740_clock_resume(void)
-{
-	uint32_t pll;
-
-	jz_clk_reg_set_bits(JZ_REG_CLOCK_PLL, JZ_CLOCK_PLL_ENABLED);
-
-	do {
-		pll = jz_clk_reg_read(JZ_REG_CLOCK_PLL);
-	} while (!(pll & JZ_CLOCK_PLL_STABLE));
-
-	jz_clk_reg_clear_bits(JZ_REG_CLOCK_GATE,
-		JZ_CLOCK_GATE_TCU | JZ_CLOCK_GATE_DMAC | JZ_CLOCK_GATE_UART0);
-}
-
-int jz4740_clock_init(void)
-{
-	jz_clock_base = ioremap(JZ4740_CPM_BASE_ADDR, 0x100);
-	if (!jz_clock_base)
-		return -EBUSY;
-
-	return 0;
-}
diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index be9b0a3..9172553 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -120,7 +120,6 @@ void __init plat_time_init(void)
 	struct clk *ext_clk;
 
 	of_clk_init(NULL);
-	jz4740_clock_init();
 	jz4740_timer_init();
 
 	ext_clk = clk_get(NULL, "ext");
diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index 0e692ed..305a26c2 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -264,3 +264,40 @@ void jz4740_clock_udc_enable_auto_suspend(void)
 	writel(clkgr, cgu->base + CGU_REG_CLKGR);
 }
 EXPORT_SYMBOL_GPL(jz4740_clock_udc_enable_auto_suspend);
+
+#define JZ_CLOCK_GATE_UART0	BIT(0)
+#define JZ_CLOCK_GATE_TCU	BIT(1)
+#define JZ_CLOCK_GATE_DMAC	BIT(12)
+
+void jz4740_clock_suspend(void)
+{
+	uint32_t clkgr, cppcr;
+
+	clkgr = readl(cgu->base + CGU_REG_CLKGR);
+	clkgr |= JZ_CLOCK_GATE_TCU | JZ_CLOCK_GATE_DMAC | JZ_CLOCK_GATE_UART0;
+	writel(clkgr, cgu->base + CGU_REG_CLKGR);
+
+	cppcr = readl(cgu->base + CGU_REG_CPPCR);
+	cppcr &= ~BIT(jz4740_cgu_clocks[JZ4740_CLK_PLL].pll.enable_bit);
+	writel(cppcr, cgu->base + CGU_REG_CPPCR);
+}
+
+void jz4740_clock_resume(void)
+{
+	uint32_t clkgr, cppcr, stable;
+
+	cppcr = readl(cgu->base + CGU_REG_CPPCR);
+	cppcr |= BIT(jz4740_cgu_clocks[JZ4740_CLK_PLL].pll.enable_bit);
+	writel(cppcr, cgu->base + CGU_REG_CPPCR);
+
+	stable = BIT(jz4740_cgu_clocks[JZ4740_CLK_PLL].pll.stable_bit);
+	do {
+		cppcr = readl(cgu->base + CGU_REG_CPPCR);
+	} while (!(cppcr & stable));
+
+	clkgr = readl(cgu->base + CGU_REG_CLKGR);
+	clkgr &= ~JZ_CLOCK_GATE_TCU;
+	clkgr &= ~JZ_CLOCK_GATE_DMAC;
+	clkgr &= ~JZ_CLOCK_GATE_UART0;
+	writel(clkgr, cgu->base + CGU_REG_CLKGR);
+}
-- 
2.4.1
