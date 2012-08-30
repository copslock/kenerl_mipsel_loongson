Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2012 10:52:05 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:54383 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903259Ab2H3IwB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Aug 2012 10:52:01 +0200
Received: by pbbrq8 with SMTP id rq8so2878856pbb.36
        for <linux-mips@linux-mips.org>; Thu, 30 Aug 2012 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=XoTx2xBtiNHUp+OmifcqaCYIaaAkMIV6CrLNuTDss+4=;
        b=YnvmGvnJT8vMI/WIMwjzTG1hozm4mBinPoAFSp3nxOEZUH3+CLuTPZqYf1iBU71iTp
         f8b6nWeyGX1WWnQpSQ6FoNsIftSAMPdw4AY0OmzcfZOdMdOy2iTFy55dyVF+oR7cILf6
         hQ+GqJi/K6zqsDNcZVi1xYB3zETcBqmDtYBmAvkrnzu9Y4+iqa6RpHroWRG1CwzQhlZL
         hJw7RHlA2xWG18+pHU7Euk02vmOM7CgT/C7r6BojJWron/0VfFkN7SxXtooCa72vf+/Q
         lGJAJC0sxEX8tjpjn/rKntw/NpZpo1f83eqmsqa2EsF2/w5SpMGIeg7p1QyE/cUNeTxZ
         2GGA==
Received: by 10.68.228.98 with SMTP id sh2mr10525911pbc.95.1346316713352;
        Thu, 30 Aug 2012 01:51:53 -0700 (PDT)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id qp6sm1201091pbc.55.2012.08.30.01.51.45
        (version=SSLv3 cipher=OTHER);
        Thu, 30 Aug 2012 01:51:50 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Turquette <mturquette@linaro.org>,
        Russell King <linux@arm.linux.org.uk>
Cc:     linux-mips@linux-mips.org, Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH v3] clk: add Loongson1B clock support
Date:   Thu, 30 Aug 2012 16:51:34 +0800
Message-Id: <1346316694-5270-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
X-archive-position: 34380
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This adds clock support to Loongson1B SoC using the common clock
infrastructure.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/clk/Makefile   |    1 +
 drivers/clk/clk-ls1x.c |  111 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/clk-ls1x.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5869ea3..018ec57 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_ARCH_SOCFPGA)	+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
 obj-$(CONFIG_ARCH_U300)		+= clk-u300.o
 obj-$(CONFIG_ARCH_INTEGRATOR)	+= versatile/
+obj-$(CONFIG_MACH_LOONGSON1)	+= clk-ls1x.o
 
 # Chip specific
 obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
new file mode 100644
index 0000000..f20b750
--- /dev/null
+++ b/drivers/clk/clk-ls1x.c
@@ -0,0 +1,111 @@
+/*
+ * Copyright (c) 2012 Zhang, Keguang <keguang.zhang@gmail.com>
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
+#define OSC	33
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
+					     unsigned long parent_rate)
+{
+	u32 pll, rate;
+
+	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
+	rate = ((12 + (pll & 0x3f)) * 1000000) +
+		((((pll >> 8) & 0x3ff) * 1000000) >> 10);
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
+static struct clk * __init clk_register_pll(struct device *dev,
+	 const char *name, const char *parent_name, unsigned long flags)
+{
+	struct clk_hw *hw;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* allocate the divider */
+	hw = kzalloc(sizeof(struct clk_hw), GFP_KERNEL);
+	if (!hw) {
+		pr_err("%s: could not allocate clk_hw\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
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
+void __init ls1x_clk_init(void)
+{
+	struct clk *clk;
+
+	clk = clk_register_pll(NULL, "pll_clk", NULL, CLK_IS_ROOT);
+	clk_prepare_enable(clk);
+
+	clk = clk_register_divider(NULL, "cpu_clk", "pll_clk",
+			CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_CPU_SHIFT,
+			DIV_CPU_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
+	clk_prepare_enable(clk);
+	clk_register_clkdev(clk, "cpu", NULL);
+
+	clk = clk_register_divider(NULL, "dc_clk", "pll_clk",
+			CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
+			DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
+	clk_prepare_enable(clk);
+	clk_register_clkdev(clk, "dc", NULL);
+
+	clk = clk_register_divider(NULL, "ahb_clk", "pll_clk",
+			CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
+			DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
+	clk_prepare_enable(clk);
+	clk_register_clkdev(clk, "ahb", NULL);
+	clk_register_clkdev(clk, "stmmaceth", NULL);
+
+	clk = clk_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1, 2);
+	clk_prepare_enable(clk);
+	clk_register_clkdev(clk, "apb", NULL);
+	clk_register_clkdev(clk, "serial8250", NULL);
+}
-- 
1.7.1
