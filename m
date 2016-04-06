Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 14:11:26 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35176 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026093AbcDFMLP2fqL4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 14:11:15 +0200
Received: by mail-pa0-f65.google.com with SMTP id zy2so3914778pac.2;
        Wed, 06 Apr 2016 05:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HfYsvOJ1il9RNxxPCGUgf/7klSfG2R5FY4OzrfWY3ho=;
        b=ulBQJ02lhHG1GfMdLUSSH0FiYIPReGR6oQN9Yn7YrKlht24v14UdlRzgLVnjJlHcOt
         hMddT4Kb7WRKCHigcDEq3VFQ7lO7GmjKm4cct+wNYJ7ZAMqyFReFOunY9C1L5KCUlaic
         BfvI1eJG5Enzeb3mYhxmjR5jhQiCkzsA7y71fwy2TLSDHcv8PiFjfE3LkWnkEOwHyIZo
         C7JCsLeGmLU3vt38FYzw/6ielQVQ9VdjlOJJ47qpm3821mCWmSWdq8SCQ9nRJGPkA3UX
         y8Cqhu2u0h+op+CDC44HDXCX0anh3QnqteC/1E0Zrhz9wYfSCv+0kqskRA3Hg5uGzKg1
         h5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HfYsvOJ1il9RNxxPCGUgf/7klSfG2R5FY4OzrfWY3ho=;
        b=aaiZQnTZs4jKiuAOLmXNK5RahzjVNDRGcySbncJw3YJKnkMwenVnvej6vCIxrHvDd1
         VgOTUXtl7NYuoJ4BoTJ9qoKGlANKbsW3yPcZJcf4XZVnLwDlkWqFS6WqTYu0FlVAuyw7
         M0fiX8W0Jwil2AOOLFSyyfc3RDRlHGgF9WuGxRgTSq38QoPMLpqxC31AXL90iyODwJM6
         c9mO6mOy2OhuO21goESeF4KTn7Dn0HKLEZ+iUSnaA1vuf95FZ40wjRMlDLcMYKnmERUE
         cBd9kz3VMD4Tz0eFiSQyWXoLTAT8erex360EMt0P/7LxOyza4B7bqICqZWasD+fwCd51
         3PmQ==
X-Gm-Message-State: AD7BkJJkBAC4xYF1xX9bwI1KFdBFE6iS6sjmIRdzctSH4p8LYUfqj2cAa9BjZG2ar6H9Iw==
X-Received: by 10.66.219.3 with SMTP id pk3mr70524281pac.106.1459944669449;
        Wed, 06 Apr 2016 05:11:09 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id 3sm4676177pfn.59.2016.04.06.05.11.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 05:11:08 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 1/7] clk: Loongson1: Update clocks of Loongson1B
Date:   Wed,  6 Apr 2016 20:09:31 +0800
Message-Id: <1459944577-6423-2-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1459944577-6423-1-git-send-email-keguang.zhang@gmail.com>
References: <1459944577-6423-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

- Rename the file to clk-loongson1.c
- Add AC97, DMA and NAND clock
- Update clock names
- Remove superfluous error messages

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/clk/Makefile        |   2 +-
 drivers/clk/clk-loongson1.c | 163 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-ls1x.c      | 162 -------------------------------------------
 3 files changed, 164 insertions(+), 163 deletions(-)
 create mode 100644 drivers/clk/clk-loongson1.c
 delete mode 100644 drivers/clk/clk-ls1x.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 46869d6..5845b2c 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+= clk-cs2000-cp.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
 obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
 obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
-obj-$(CONFIG_MACH_LOONGSON32)		+= clk-ls1x.o
+obj-$(CONFIG_MACH_LOONGSON32)		+= clk-loongson1.o
 obj-$(CONFIG_COMMON_CLK_MAX_GEN)	+= clk-max-gen.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
 obj-$(CONFIG_COMMON_CLK_MAX77802)	+= clk-max77802.o
diff --git a/drivers/clk/clk-loongson1.c b/drivers/clk/clk-loongson1.c
new file mode 100644
index 0000000..ce2135c
--- /dev/null
+++ b/drivers/clk/clk-loongson1.c
@@ -0,0 +1,163 @@
+/*
+ * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
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
+#include <linux/slab.h>
+#include <linux/err.h>
+
+#include <loongson1.h>
+
+#define OSC		(33 * 1000000)
+#define DIV_APB		2
+
+static DEFINE_SPINLOCK(_lock);
+
+static int ls1x_pll_clk_enable(struct clk_hw *hw)
+{
+	return 0;
+}
+
+static void ls1x_pll_clk_disable(struct clk_hw *hw)
+{
+}
+
+static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	u32 pll, rate;
+
+	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
+	rate = 12 + (pll & 0x3f) + (((pll >> 8) & 0x3ff) >> 10);
+	rate *= OSC;
+	rate >>= 1;
+
+	return rate;
+}
+
+static const struct clk_ops ls1x_pll_clk_ops = {
+	.enable = ls1x_pll_clk_enable,
+	.disable = ls1x_pll_clk_disable,
+	.recalc_rate = ls1x_pll_recalc_rate,
+};
+
+static struct clk *__init clk_register_pll(struct device *dev,
+					   const char *name,
+					   const char *parent_name,
+					   unsigned long flags)
+{
+	struct clk_hw *hw;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* allocate the divider */
+	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
+	if (!hw)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &ls1x_pll_clk_ops;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+	hw->init = &init;
+
+	/* register the clock */
+	clk = clk_register(dev, hw);
+
+	if (IS_ERR(clk))
+		kfree(hw);
+
+	return clk;
+}
+
+static const char *const cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
+static const char *const ahb_parents[] = { "ahb_clk_div", "osc_33m_clk", };
+static const char *const dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
+
+void __init ls1x_clk_init(void)
+{
+	struct clk *clk;
+
+	clk = clk_register_fixed_rate(NULL, "osc_33m_clk", NULL, CLK_IS_ROOT,
+				      OSC);
+	clk_register_clkdev(clk, "osc_33m_clk", NULL);
+
+	/* clock derived from 33 MHz OSC clk */
+	clk = clk_register_pll(NULL, "pll_clk", "osc_33m_clk", 0);
+	clk_register_clkdev(clk, "pll_clk", NULL);
+
+	/* clock derived from PLL clk */
+	/*                                 _____
+	 *         _______________________|     |
+	 * OSC ___/                       | MUX |___ CPU CLK
+	 *        \___ PLL ___ CPU DIV ___|     |
+	 *                                |_____|
+	 */
+	clk = clk_register_divider(NULL, "cpu_clk_div", "pll_clk",
+				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
+				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
+				   CLK_DIVIDER_ONE_BASED |
+				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
+	clk_register_clkdev(clk, "cpu_clk_div", NULL);
+	clk = clk_register_mux(NULL, "cpu_clk", cpu_parents,
+			       ARRAY_SIZE(cpu_parents),
+			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
+			       BYPASS_CPU_SHIFT, BYPASS_CPU_WIDTH, 0, &_lock);
+	clk_register_clkdev(clk, "cpu_clk", NULL);
+
+	/*                                 _____
+	 *         _______________________|     |
+	 * OSC ___/                       | MUX |___ DC  CLK
+	 *        \___ PLL ___ DC  DIV ___|     |
+	 *                                |_____|
+	 */
+	clk = clk_register_divider(NULL, "dc_clk_div", "pll_clk",
+				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
+				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
+	clk_register_clkdev(clk, "dc_clk_div", NULL);
+	clk = clk_register_mux(NULL, "dc_clk", dc_parents,
+			       ARRAY_SIZE(dc_parents),
+			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
+			       BYPASS_DC_SHIFT, BYPASS_DC_WIDTH, 0, &_lock);
+	clk_register_clkdev(clk, "dc_clk", NULL);
+
+	/*                                 _____
+	 *         _______________________|     |
+	 * OSC ___/                       | MUX |___ DDR CLK
+	 *        \___ PLL ___ DDR DIV ___|     |
+	 *                                |_____|
+	 */
+	clk = clk_register_divider(NULL, "ahb_clk_div", "pll_clk",
+				   0, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
+				   DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED,
+				   &_lock);
+	clk_register_clkdev(clk, "ahb_clk_div", NULL);
+	clk = clk_register_mux(NULL, "ahb_clk", ahb_parents,
+			       ARRAY_SIZE(ahb_parents),
+			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
+			       BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0, &_lock);
+	clk_register_clkdev(clk, "ahb_clk", NULL);
+	clk_register_clkdev(clk, "ls1x-dma", NULL);
+	clk_register_clkdev(clk, "stmmaceth", NULL);
+
+	/* clock derived from AHB clk */
+	/* APB clk is always half of the AHB clk */
+	clk = clk_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
+					DIV_APB);
+	clk_register_clkdev(clk, "apb_clk", NULL);
+	clk_register_clkdev(clk, "ls1x-ac97", NULL);
+	clk_register_clkdev(clk, "ls1x-i2c", NULL);
+	clk_register_clkdev(clk, "ls1x-nand", NULL);
+	clk_register_clkdev(clk, "ls1x-pwmtimer", NULL);
+	clk_register_clkdev(clk, "ls1x-spi", NULL);
+	clk_register_clkdev(clk, "ls1x-wdt", NULL);
+	clk_register_clkdev(clk, "serial8250", NULL);
+}
diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
deleted file mode 100644
index d4c6198..0000000
--- a/drivers/clk/clk-ls1x.c
+++ /dev/null
@@ -1,162 +0,0 @@
-/*
- * Copyright (c) 2012 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/clkdev.h>
-#include <linux/clk-provider.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-
-#include <loongson1.h>
-
-#define OSC		(33 * 1000000)
-#define DIV_APB		2
-
-static DEFINE_SPINLOCK(_lock);
-
-static int ls1x_pll_clk_enable(struct clk_hw *hw)
-{
-	return 0;
-}
-
-static void ls1x_pll_clk_disable(struct clk_hw *hw)
-{
-}
-
-static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
-					  unsigned long parent_rate)
-{
-	u32 pll, rate;
-
-	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
-	rate = 12 + (pll & 0x3f) + (((pll >> 8) & 0x3ff) >> 10);
-	rate *= OSC;
-	rate >>= 1;
-
-	return rate;
-}
-
-static const struct clk_ops ls1x_pll_clk_ops = {
-	.enable = ls1x_pll_clk_enable,
-	.disable = ls1x_pll_clk_disable,
-	.recalc_rate = ls1x_pll_recalc_rate,
-};
-
-static struct clk *__init clk_register_pll(struct device *dev,
-					   const char *name,
-					   const char *parent_name,
-					   unsigned long flags)
-{
-	struct clk_hw *hw;
-	struct clk *clk;
-	struct clk_init_data init;
-
-	/* allocate the divider */
-	hw = kzalloc(sizeof(struct clk_hw), GFP_KERNEL);
-	if (!hw) {
-		pr_err("%s: could not allocate clk_hw\n", __func__);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	init.name = name;
-	init.ops = &ls1x_pll_clk_ops;
-	init.flags = flags | CLK_IS_BASIC;
-	init.parent_names = (parent_name ? &parent_name : NULL);
-	init.num_parents = (parent_name ? 1 : 0);
-	hw->init = &init;
-
-	/* register the clock */
-	clk = clk_register(dev, hw);
-
-	if (IS_ERR(clk))
-		kfree(hw);
-
-	return clk;
-}
-
-static const char * const cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
-static const char * const ahb_parents[] = { "ahb_clk_div", "osc_33m_clk", };
-static const char * const dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
-
-void __init ls1x_clk_init(void)
-{
-	struct clk *clk;
-
-	clk = clk_register_fixed_rate(NULL, "osc_33m_clk", NULL, CLK_IS_ROOT,
-				      OSC);
-	clk_register_clkdev(clk, "osc_33m_clk", NULL);
-
-	/* clock derived from 33 MHz OSC clk */
-	clk = clk_register_pll(NULL, "pll_clk", "osc_33m_clk", 0);
-	clk_register_clkdev(clk, "pll_clk", NULL);
-
-	/* clock derived from PLL clk */
-	/*                                 _____
-	 *         _______________________|     |
-	 * OSC ___/                       | MUX |___ CPU CLK
-	 *        \___ PLL ___ CPU DIV ___|     |
-	 *                                |_____|
-	 */
-	clk = clk_register_divider(NULL, "cpu_clk_div", "pll_clk",
-				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
-				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
-				   CLK_DIVIDER_ONE_BASED |
-				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
-	clk_register_clkdev(clk, "cpu_clk_div", NULL);
-	clk = clk_register_mux(NULL, "cpu_clk", cpu_parents,
-			       ARRAY_SIZE(cpu_parents),
-			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
-			       BYPASS_CPU_SHIFT, BYPASS_CPU_WIDTH, 0, &_lock);
-	clk_register_clkdev(clk, "cpu_clk", NULL);
-
-	/*                                 _____
-	 *         _______________________|     |
-	 * OSC ___/                       | MUX |___ DC  CLK
-	 *        \___ PLL ___ DC  DIV ___|     |
-	 *                                |_____|
-	 */
-	clk = clk_register_divider(NULL, "dc_clk_div", "pll_clk",
-				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
-				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
-	clk_register_clkdev(clk, "dc_clk_div", NULL);
-	clk = clk_register_mux(NULL, "dc_clk", dc_parents,
-			       ARRAY_SIZE(dc_parents),
-			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
-			       BYPASS_DC_SHIFT, BYPASS_DC_WIDTH, 0, &_lock);
-	clk_register_clkdev(clk, "dc_clk", NULL);
-
-	/*                                 _____
-	 *         _______________________|     |
-	 * OSC ___/                       | MUX |___ DDR CLK
-	 *        \___ PLL ___ DDR DIV ___|     |
-	 *                                |_____|
-	 */
-	clk = clk_register_divider(NULL, "ahb_clk_div", "pll_clk",
-				   0, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
-				   DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED,
-				   &_lock);
-	clk_register_clkdev(clk, "ahb_clk_div", NULL);
-	clk = clk_register_mux(NULL, "ahb_clk", ahb_parents,
-			       ARRAY_SIZE(ahb_parents),
-			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
-			       BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0, &_lock);
-	clk_register_clkdev(clk, "ahb_clk", NULL);
-	clk_register_clkdev(clk, "stmmaceth", NULL);
-
-	/* clock derived from AHB clk */
-	/* APB clk is always half of the AHB clk */
-	clk = clk_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
-					DIV_APB);
-	clk_register_clkdev(clk, "apb_clk", NULL);
-	clk_register_clkdev(clk, "ls1x_i2c", NULL);
-	clk_register_clkdev(clk, "ls1x_pwmtimer", NULL);
-	clk_register_clkdev(clk, "ls1x_spi", NULL);
-	clk_register_clkdev(clk, "ls1x_wdt", NULL);
-	clk_register_clkdev(clk, "serial8250", NULL);
-}
-- 
1.9.1
