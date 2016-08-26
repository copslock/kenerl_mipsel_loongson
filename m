Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 17:48:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40796 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992722AbcHZPobTi9VI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 17:44:31 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 264AA51570123;
        Fri, 26 Aug 2016 16:44:11 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 16:44:14 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH 25/26] clk: boston: Add a driver for MIPS Boston board clocks
Date:   Fri, 26 Aug 2016 16:37:24 +0100
Message-ID: <20160826153725.11629-26-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826153725.11629-1-paul.burton@imgtec.com>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54809
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

Add a driver for the clocks provided by the MIPS Boston board from
Imagination Technologies. 2 clocks are provided - the system clock & the
CPU clock - and each is a simple fixed rate clock whose frequency can be
determined by reading a register provided by the board.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/clk/Kconfig      |   9 ++++
 drivers/clk/Makefile     |   1 +
 drivers/clk/clk-boston.c | 131 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/clk/clk-boston.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e2d9bd7..2680343 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -208,6 +208,15 @@ config COMMON_CLK_OXNAS
 	---help---
 	  Support for the OXNAS SoC Family clocks.
 
+config COMMON_CLK_BOSTON
+	bool "Clock driver for MIPS Boston boards"
+	select MFD_SYSCON
+	---help---
+	  Enable this to support the system & CPU clocks on the MIPS Boston
+	  development board from Imagination Technologies. These are simple
+	  fixed rate clocks whose rate is determined by reading a platform
+	  provided register.
+
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/meson/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 3b6f9cf..3b78e515 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -20,6 +20,7 @@ endif
 obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
 obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
+obj-$(CONFIG_COMMON_CLK_BOSTON)		+= clk-boston.o
 obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
 obj-$(CONFIG_COMMON_CLK_CDCE925)	+= clk-cdce925.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
diff --git a/drivers/clk/clk-boston.c b/drivers/clk/clk-boston.c
new file mode 100644
index 0000000..4fa3fad
--- /dev/null
+++ b/drivers/clk/clk-boston.c
@@ -0,0 +1,131 @@
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/mfd/syscon.h>
+
+#include <dt-bindings/clock/boston-clock.h>
+
+#define BOSTON_CLK_COUNT 2
+
+struct clk_boston {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	unsigned int id;
+};
+
+struct clk_boston_state {
+	struct clk *clk[BOSTON_CLK_COUNT];
+	struct clk_boston clk_boston[BOSTON_CLK_COUNT];
+	struct clk_onecell_data onecell_data[BOSTON_CLK_COUNT];
+};
+
+static const char *clk_names[BOSTON_CLK_COUNT] = {
+	[BOSTON_CLK_SYS] = "sys",
+	[BOSTON_CLK_CPU] = "cpu",
+};
+
+#define BOSTON_PLAT_MMCMDIV		0x30
+# define BOSTON_PLAT_MMCMDIV_CLK0DIV	(0xff << 0)
+# define BOSTON_PLAT_MMCMDIV_INPUT	(0xff << 8)
+# define BOSTON_PLAT_MMCMDIV_MUL	(0xff << 16)
+# define BOSTON_PLAT_MMCMDIV_CLK1DIV	(0xff << 24)
+
+static struct clk_boston *to_clk_boston(struct clk_hw *hw)
+{
+	return container_of(hw, struct clk_boston, hw);
+}
+
+static uint32_t ext_field(uint32_t val, uint32_t mask)
+{
+	return (val & mask) >> (ffs(mask) - 1);
+}
+
+static unsigned long clk_boston_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct clk_boston *state = to_clk_boston(hw);
+	uint32_t in_rate, mul, div;
+	uint mmcmdiv;
+	int err;
+
+	err = regmap_read(state->regmap, BOSTON_PLAT_MMCMDIV, &mmcmdiv);
+	if (err)
+		return 0;
+
+	in_rate = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_INPUT);
+	mul = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_MUL);
+
+	switch (state->id) {
+	case BOSTON_CLK_SYS:
+		div = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_CLK0DIV);
+		break;
+	case BOSTON_CLK_CPU:
+		div = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_CLK1DIV);
+		break;
+	default:
+		return 0;
+	}
+
+	return (in_rate * mul * 1000000) / div;
+}
+
+static const struct clk_ops clk_boston_ops = {
+	.recalc_rate = clk_boston_recalc_rate,
+};
+
+static void __init clk_boston_setup(struct device_node *np)
+{
+	struct clk_boston_state *state;
+	struct clk_init_data init;
+	struct regmap *regmap;
+	int i, err;
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return;
+
+	regmap = syscon_regmap_lookup_by_phandle(np, "regmap");
+	if (IS_ERR(regmap)) {
+		pr_err("failed to find regmap\n");
+		return;
+	}
+
+	for (i = 0; i < BOSTON_CLK_COUNT; i++) {
+		memset(&init, 0, sizeof(init));
+		init.flags = CLK_IS_BASIC;
+		init.name = clk_names[i];
+		init.ops = &clk_boston_ops;
+
+		state->clk_boston[i].hw.init = &init;
+		state->clk_boston[i].id = i;
+		state->clk_boston[i].regmap = regmap;
+
+		state->clk[i] = clk_register(NULL, &state->clk_boston[i].hw);
+		if (IS_ERR(state->clk[i])) {
+			pr_err("failed to register clock: %ld\n",
+			       PTR_ERR(state->clk[i]));
+			return;
+		}
+	}
+
+	state->onecell_data->clks = state->clk;
+	state->onecell_data->clk_num = BOSTON_CLK_COUNT;
+
+	err = of_clk_add_provider(np, of_clk_src_onecell_get,
+				  state->onecell_data);
+	if (err)
+		pr_err("failed to add DT provider: %d\n", err);
+}
+CLK_OF_DECLARE(clk_boston, "img,boston-clock", clk_boston_setup);
-- 
2.9.3
