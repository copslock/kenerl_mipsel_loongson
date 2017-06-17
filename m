Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jun 2017 22:54:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6193 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994913AbdFQUyaA047F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Jun 2017 22:54:30 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 907169EF331F8;
        Sat, 17 Jun 2017 21:54:18 +0100 (IST)
Received: from localhost (10.20.78.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 17 Jun
 2017 21:54:22 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH v5 2/4] clk: boston: Add a driver for MIPS Boston board clocks
Date:   Sat, 17 Jun 2017 13:52:47 -0700
Message-ID: <20170617205249.1391-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170617205249.1391-1-paul.burton@imgtec.com>
References: <20170617205249.1391-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.78.225]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58594
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
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org
Cc: linux-mips@linux-mips.org

---

Changes in v5:
- Use struct clk_hw rather than struct clk.
- Comment on reasoning for use of CLK_OF_DECLARE.
- Drop depends on OF from Kconfig.
- Define pr_fmt to get clearer error messages.

Changes in v4:
- Adjust to expect the parent node to be the syscon.
- Update MAINTAINERS entry.

Changes in v3: None

Changes in v2:
- Support BOSTON_CLK_INPUT.
- Register clocks with clk_register_fixed_rate during boot, removing need for clk_ops.
- s/uint32_t/u32/.
- Move driver to a vendor directory.

 MAINTAINERS                     |   1 +
 drivers/clk/Kconfig             |   1 +
 drivers/clk/Makefile            |   1 +
 drivers/clk/imgtec/Kconfig      |   9 ++++
 drivers/clk/imgtec/Makefile     |   1 +
 drivers/clk/imgtec/clk-boston.c | 103 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 116 insertions(+)
 create mode 100644 drivers/clk/imgtec/Kconfig
 create mode 100644 drivers/clk/imgtec/Makefile
 create mode 100644 drivers/clk/imgtec/clk-boston.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a341862f5d6..2749877a4574 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8503,6 +8503,7 @@ M:	Paul Burton <paul.burton@imgtec.com>
 L:	linux-mips@linux-mips.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/img,boston-clock.txt
+F:	drivers/clk/imgtec/clk-boston.c
 F:	include/dt-bindings/clock/boston-clock.h
 
 MIROSOUND PCM20 FM RADIO RECEIVER DRIVER
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 36cfea38135f..251a22139e73 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -219,6 +219,7 @@ config COMMON_CLK_VC5
 
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
+source "drivers/clk/imgtec/Kconfig"
 source "drivers/clk/mediatek/Kconfig"
 source "drivers/clk/meson/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index c19983afcb81..a4a7c5df8b93 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -59,6 +59,7 @@ obj-y					+= bcm/
 obj-$(CONFIG_ARCH_BERLIN)		+= berlin/
 obj-$(CONFIG_H8300)			+= h8300/
 obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
+obj-y					+= imgtec/
 obj-$(CONFIG_ARCH_MXC)			+= imx/
 obj-$(CONFIG_MACH_INGENIC)		+= ingenic/
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
diff --git a/drivers/clk/imgtec/Kconfig b/drivers/clk/imgtec/Kconfig
new file mode 100644
index 000000000000..f6dcb748e9c4
--- /dev/null
+++ b/drivers/clk/imgtec/Kconfig
@@ -0,0 +1,9 @@
+config COMMON_CLK_BOSTON
+	bool "Clock driver for MIPS Boston boards"
+	depends on MIPS || COMPILE_TEST
+	select MFD_SYSCON
+	---help---
+	  Enable this to support the system & CPU clocks on the MIPS Boston
+	  development board from Imagination Technologies. These are simple
+	  fixed rate clocks whose rate is determined by reading a platform
+	  provided register.
diff --git a/drivers/clk/imgtec/Makefile b/drivers/clk/imgtec/Makefile
new file mode 100644
index 000000000000..ac779b8c22f2
--- /dev/null
+++ b/drivers/clk/imgtec/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_COMMON_CLK_BOSTON)		+= clk-boston.o
diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
new file mode 100644
index 000000000000..f18f10351785
--- /dev/null
+++ b/drivers/clk/imgtec/clk-boston.c
@@ -0,0 +1,103 @@
+/*
+ * Copyright (C) 2016-2017 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#define pr_fmt(fmt) "clk-boston: " fmt
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
+static u32 ext_field(u32 val, u32 mask)
+{
+	return (val & mask) >> (ffs(mask) - 1);
+}
+
+static void __init clk_boston_setup(struct device_node *np)
+{
+	unsigned long in_freq, cpu_freq, sys_freq;
+	uint mmcmdiv, mul, cpu_div, sys_div;
+	struct clk_hw_onecell_data *onecell;
+	struct regmap *regmap;
+	struct clk_hw *hw;
+	int err;
+
+	regmap = syscon_node_to_regmap(np->parent);
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
+	onecell = kzalloc(sizeof(*onecell) +
+			  (BOSTON_CLK_COUNT * sizeof(struct clk_hw *)),
+			  GFP_KERNEL);
+	if (!onecell)
+		return;
+
+	onecell->num = BOSTON_CLK_COUNT;
+
+	hw = clk_hw_register_fixed_rate(NULL, "input", NULL, 0, in_freq);
+	if (IS_ERR(hw)) {
+		pr_err("failed to register input clock: %ld\n", PTR_ERR(hw));
+		return;
+	}
+	onecell->hws[BOSTON_CLK_INPUT] = hw;
+
+	hw = clk_hw_register_fixed_rate(NULL, "sys", "input", 0, sys_freq);
+	if (IS_ERR(hw)) {
+		pr_err("failed to register sys clock: %ld\n", PTR_ERR(hw));
+		return;
+	}
+	onecell->hws[BOSTON_CLK_SYS] = hw;
+
+	hw = clk_hw_register_fixed_rate(NULL, "cpu", "input", 0, cpu_freq);
+	if (IS_ERR(hw)) {
+		pr_err("failed to register cpu clock: %ld\n", PTR_ERR(hw));
+		return;
+	}
+	onecell->hws[BOSTON_CLK_CPU] = hw;
+
+	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, onecell);
+	if (err)
+		pr_err("failed to add DT provider: %d\n", err);
+}
+
+/*
+ * Use CLK_OF_DECLARE so that this driver is probed early enough to provide the
+ * CPU frequency for use with the GIC or cop0 counters/timers.
+ */
+CLK_OF_DECLARE(clk_boston, "img,boston-clock", clk_boston_setup);
-- 
2.13.1
