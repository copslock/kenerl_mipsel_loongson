Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 04:54:55 +0200 (CEST)
Received: from SMTPBG252.QQ.COM ([183.60.52.105]:43659 "EHLO smtpbg252.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992143AbdFPCxY31C6Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Jun 2017 04:53:24 +0200
X-QQ-mid: bizesmtp5t1497581570tab0m4sn8
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 16 Jun 2017 10:52:48 +0800 (CST)
X-QQ-SSF: 01100000002000F0FI91B00B0000000
X-QQ-FEAT: qcfIqVEPZ8mxzxMk5R1/Om7I6oVtnmTz4vjDQKZiIoSlQqfAd+eJ6VJ4m/gjA
        MJbfKVPQjJ6Mcev58J0X2bjFHbT37xZel0F0Kd/SS3Ep6bWqgJp2G/qwStd4h9Z+kT/7SFG
        rk2qZDSlCbh5wBWR7fMQzg1OoyfoQklUa2u3lekXWRi4tUFishQWNHoD9mLqZfTMWQK3Y+t
        SHaUH4M/CSqOx54VCd77DWSlTIAGF8dFpkkQk1LE4ftDalG9vCd8tKOhM4Bf7Jm4UWI96pW
        5zc7UNpx1KRO3GNUXrpwj3y/R2hilL/Wuvu/iA5GZKQ0yPvbI7YbHbXKg=
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>,
        =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6?= <Yeking@Red54.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Binbin Zhou <zhoubb@lemote.com>,
        HuaCai Chen <chenhc@lemote.com>
Subject: [PATCH v7 7/8] clk: Loongson: Add Loongson-1A clock support
Date:   Fri, 16 Jun 2017 10:52:52 +0800
Message-Id: <1497581573-17258-8-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1497581573-17258-1-git-send-email-zhoubb@lemote.com>
References: <1497581573-17258-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

This patch adds clock support to Loongson-1A SoC.

Unfortunately, The Loongson-1A's PLL register is written only,
so we just set it with a fixed value.

Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: HuaCai Chen <chenhc@lemote.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org
---
 arch/mips/include/asm/mach-loongson32/regs-clk.h | 30 +++++++++-
 drivers/clk/loongson1/Makefile                   |  1 +
 drivers/clk/loongson1/clk-loongson1a.c           | 75 ++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/loongson1/clk-loongson1a.c

diff --git a/arch/mips/include/asm/mach-loongson32/regs-clk.h b/arch/mips/include/asm/mach-loongson32/regs-clk.h
index e5e8f11..d8278a4 100644
--- a/arch/mips/include/asm/mach-loongson32/regs-clk.h
+++ b/arch/mips/include/asm/mach-loongson32/regs-clk.h
@@ -18,7 +18,35 @@
 #define LS1X_CLK_PLL_FREQ		LS1X_CLK_REG(0x0)
 #define LS1X_CLK_PLL_DIV		LS1X_CLK_REG(0x4)
 
-#if defined(CONFIG_LOONGSON1_LS1B)
+#if defined(CONFIG_LOONGSON1_LS1A)
+/* write only */
+#define CORE_PLL_CFG		0x1fe78030
+#define CPU_MUL			GENMASK(2, 0)
+#define CPU_CFG_EN		BIT(3)
+#define DDR_MUL			GENMASK(6, 4)
+#define DDR_CFG_EN		BIT(7)
+#define CPU_CFG_W_EN		BIT(11)
+#define DDR_CFG_W_EN		BIT(15)
+
+#define VGA_PLL_CFG		0x1fd00410
+#define VGA_M			GENMASK(7, 0)
+#define VGA_N			GENMASK(11, 8)
+#define VGA_OD			GENMASK(13, 12)
+#define VGA_FRAC		GENMASK(31, 14)
+
+#define LCD_PLL_CFG		0x1fd00410
+#define LCD_M			GENMASK(7, 0)
+#define LCD_N			GENMASK(11, 8)
+#define LCD_OD			GENMASK(13, 12)
+#define LCD_FRAC		GENMASK(31, 14)
+
+#define GPU_PLL_CFG		0x1fd00414
+#define GPU_M			GENMASK(7, 0)
+#define GPU_N			GENMASK(11, 8)
+#define GPU_OD			GENMASK(13, 12)
+#define GPU_FRAC		GENMASK(31, 14)
+
+#elif defined(CONFIG_LOONGSON1_LS1B)
 /* Clock PLL Divisor Register Bits */
 #define DIV_DC_EN			BIT(31)
 #define DIV_DC_RST			BIT(30)
diff --git a/drivers/clk/loongson1/Makefile b/drivers/clk/loongson1/Makefile
index b7f6a16..da7b2dd 100644
--- a/drivers/clk/loongson1/Makefile
+++ b/drivers/clk/loongson1/Makefile
@@ -1,3 +1,4 @@
 obj-y				+= clk.o
+obj-$(CONFIG_LOONGSON1_LS1A)	+= clk-loongson1a.o
 obj-$(CONFIG_LOONGSON1_LS1B)	+= clk-loongson1b.o
 obj-$(CONFIG_LOONGSON1_LS1C)	+= clk-loongson1c.o
diff --git a/drivers/clk/loongson1/clk-loongson1a.c b/drivers/clk/loongson1/clk-loongson1a.c
new file mode 100644
index 0000000..263a82c
--- /dev/null
+++ b/drivers/clk/loongson1/clk-loongson1a.c
@@ -0,0 +1,75 @@
+/*
+ * Copyright (c) 2012-2016 Binbin Zhou <zhoubb@lemote.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/err.h>
+
+#include <loongson1.h>
+#include "clk.h"
+
+#define OSC		(33 * 1000000)
+#define DIV_APB		2
+
+static DEFINE_SPINLOCK(_lock);
+
+static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	/* Workaround, loongson-1A pll register is written only */
+	return OSC * 8;
+}
+
+static const struct clk_ops ls1x_pll_clk_ops = {
+	.recalc_rate = ls1x_pll_recalc_rate,
+};
+
+void __init ls1x_clk_init(void)
+{
+	struct clk_hw *hw;
+
+	hw = clk_hw_register_fixed_rate(NULL, "osc_clk", NULL, 0, OSC);
+	clk_hw_register_clkdev(hw, "osc_clk", NULL);
+
+	/* clock from 33 MHz OSC clk */
+	hw = clk_hw_register_pll(NULL, "pll_clk", "osc_clk",
+				&ls1x_pll_clk_ops, 0);
+	clk_hw_register_clkdev(hw, "pll_clk", NULL);
+
+	/* cpu clk */
+	hw = clk_hw_register_fixed_factor(NULL, "cpu_clk", "pll_clk",
+					0, 1, 1);
+	clk_hw_register_clkdev(hw, "cpu_clk", NULL);
+
+	/* dc clk */
+	hw = clk_hw_register_fixed_factor(NULL, "ddr_clk", "pll_clk",
+					0, 1, 1);
+	clk_hw_register_clkdev(hw, "ddr_clk", NULL);
+
+	/* ahb clk */
+	hw = clk_hw_register_fixed_factor(NULL, "ahb_clk", "pll_clk",
+					0, 1, 2);
+	clk_hw_register_clkdev(hw, "ahb_clk", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-dma", NULL);
+	clk_hw_register_clkdev(hw, "stmmaceth", NULL);
+
+	/* clock derived from AHB clk */
+	/* APB clk is always half of the AHB clk */
+	hw = clk_hw_register_fixed_factor(NULL, "apb_clk", "ahb_clk",
+					0, 1, DIV_APB);
+	clk_hw_register_clkdev(hw, "apb_clk", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-ac97", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-i2c", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-nand", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-pwmtimer", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-spi", NULL);
+	clk_hw_register_clkdev(hw, "ls1x-wdt", NULL);
+	clk_hw_register_clkdev(hw, "serial8250", NULL);
+}
-- 
2.9.3
