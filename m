Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 19:40:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5673 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992682AbcH3Rg0JefC0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 19:36:26 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id ADA428086F970;
        Tue, 30 Aug 2016 18:36:05 +0100 (IST)
Received: from localhost (10.100.200.118) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 30 Aug
 2016 18:36:08 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 25/26] clk: boston: Add a driver for MIPS Boston board clocks
Date:   Tue, 30 Aug 2016 18:29:28 +0100
Message-ID: <20160830172929.16948-26-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160830172929.16948-1-paul.burton@imgtec.com>
References: <20160830172929.16948-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.118]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54866
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

Changes in v2:
- Support BOSTON_CLK_INPUT.
- Register clocks with clk_register_fixed_rate during boot, removing need for clk_ops.
- s/uint32_t/u32/.
- Move driver to a vendor directory.

 drivers/clk/Kconfig             |   1 +
 drivers/clk/Makefile            |   1 +
 drivers/clk/imgtec/Kconfig      |  10 ++++
 drivers/clk/imgtec/Makefile     |   1 +
 drivers/clk/imgtec/clk-boston.c | 101 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 114 insertions(+)
 create mode 100644 drivers/clk/imgtec/Kconfig
 create mode 100644 drivers/clk/imgtec/Makefile
 create mode 100644 drivers/clk/imgtec/clk-boston.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e2d9bd7..a6c7e03 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -210,6 +210,7 @@ config COMMON_CLK_OXNAS
 
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
+source "drivers/clk/imgtec/Kconfig"
 source "drivers/clk/meson/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/qcom/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 3b6f9cf..8c4c425 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -60,6 +60,7 @@ obj-y					+= bcm/
 obj-$(CONFIG_ARCH_BERLIN)		+= berlin/
 obj-$(CONFIG_H8300)			+= h8300/
 obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
+obj-y					+= imgtec/
 obj-$(CONFIG_ARCH_MXC)			+= imx/
 obj-$(CONFIG_MACH_INGENIC)		+= ingenic/
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
diff --git a/drivers/clk/imgtec/Kconfig b/drivers/clk/imgtec/Kconfig
new file mode 100644
index 0000000..c2ea745
--- /dev/null
+++ b/drivers/clk/imgtec/Kconfig
@@ -0,0 +1,10 @@
+config COMMON_CLK_BOSTON
+	bool "Clock driver for MIPS Boston boards"
+	depends on MIPS || COMPILE_TEST
+	depends on OF
+	select MFD_SYSCON
+	---help---
+	  Enable this to support the system & CPU clocks on the MIPS Boston
+	  development board from Imagination Technologies. These are simple
+	  fixed rate clocks whose rate is determined by reading a platform
+	  provided register.
diff --git a/drivers/clk/imgtec/Makefile b/drivers/clk/imgtec/Makefile
new file mode 100644
index 0000000..ac779b8
--- /dev/null
+++ b/drivers/clk/imgtec/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_COMMON_CLK_BOSTON)		+= clk-boston.o
diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
new file mode 100644
index 0000000..14795b8
--- /dev/null
+++ b/drivers/clk/imgtec/clk-boston.c
@@ -0,0 +1,101 @@
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
+#define BOSTON_PLAT_MMCMDIV		0x30
+# define BOSTON_PLAT_MMCMDIV_CLK0DIV	(0xff << 0)
+# define BOSTON_PLAT_MMCMDIV_INPUT	(0xff << 8)
+# define BOSTON_PLAT_MMCMDIV_MUL	(0xff << 16)
+# define BOSTON_PLAT_MMCMDIV_CLK1DIV	(0xff << 24)
+
+#define BOSTON_CLK_COUNT 3
+
+struct clk_boston_state {
+	struct clk *clks[BOSTON_CLK_COUNT];
+	struct clk_onecell_data onecell_data;
+};
+
+static u32 ext_field(u32 val, u32 mask)
+{
+	return (val & mask) >> (ffs(mask) - 1);
+}
+
+static void __init clk_boston_setup(struct device_node *np)
+{
+	unsigned long in_freq, cpu_freq, sys_freq;
+	uint mmcmdiv, mul, cpu_div, sys_div;
+	struct clk_boston_state *state;
+	struct regmap *regmap;
+	struct clk *clk;
+	int err;
+
+	regmap = syscon_regmap_lookup_by_phandle(np, "regmap");
+	if (IS_ERR(regmap)) {
+		pr_err("failed to find regmap\n");
+		return;
+	}
+
+	err = regmap_read(regmap, BOSTON_PLAT_MMCMDIV, &mmcmdiv);
+	if (err) {
+		pr_err("failed to read mmcm_div register: %d\n", err);
+		return;
+	}
+
+	in_freq = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_INPUT) * 1000000;
+	mul = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_MUL);
+
+	sys_div = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_CLK0DIV);
+	sys_freq = mult_frac(in_freq, mul, sys_div);
+
+	cpu_div = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_CLK1DIV);
+	cpu_freq = mult_frac(in_freq, mul, cpu_div);
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return;
+
+	clk = clk_register_fixed_rate(NULL, "input", NULL, 0, in_freq);
+	if (IS_ERR(clk)) {
+		pr_err("failed to register input clock: %ld\n", PTR_ERR(clk));
+		return;
+	}
+	state->clks[BOSTON_CLK_INPUT] = clk;
+
+	clk = clk_register_fixed_rate(NULL, "sys", "input", 0, sys_freq);
+	if (IS_ERR(clk)) {
+		pr_err("failed to register sys clock: %ld\n", PTR_ERR(clk));
+		return;
+	}
+	state->clks[BOSTON_CLK_SYS] = clk;
+
+	clk = clk_register_fixed_rate(NULL, "cpu", "input", 0, cpu_freq);
+	if (IS_ERR(clk)) {
+		pr_err("failed to register cpu clock: %ld\n", PTR_ERR(clk));
+		return;
+	}
+	state->clks[BOSTON_CLK_CPU] = clk;
+
+	state->onecell_data.clks = state->clks;
+	state->onecell_data.clk_num = BOSTON_CLK_COUNT;
+
+	err = of_clk_add_provider(np, of_clk_src_onecell_get,
+				  &state->onecell_data);
+	if (err)
+		pr_err("failed to add DT provider: %d\n", err);
+}
+CLK_OF_DECLARE(clk_boston, "img,boston-clock", clk_boston_setup);
-- 
2.9.3
