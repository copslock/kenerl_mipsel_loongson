Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jan 2016 23:35:00 +0100 (CET)
Received: from mail-lf0-f47.google.com ([209.85.215.47]:32877 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010265AbcAUWemI3DkN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jan 2016 23:34:42 +0100
Received: by mail-lf0-f47.google.com with SMTP id m198so36169626lfm.0
        for <linux-mips@linux-mips.org>; Thu, 21 Jan 2016 14:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hjbQc9DjaSJO2W9q64ngPIUd8DbvQBeqPuOxQQPNhks=;
        b=HttrppNSyqUuyv4xMauET/KkciQsBE87hO8WaMvk9ExjihpKPIB2aYlZqYz8DEbYsT
         XTn+jyPLfk1k0RieAA7BnPj96Z4GMQ82VXpKZ6pPG8JqkXinlo1NRN19hSJCp8AQ7f6e
         XylRj+FWVLefSQSLkRYBlFvqwQKXldwiIreDiQXcqrIEs/+jWBnlEzUrra5M9PhsNNj0
         u+ZCRKJZZ4BL8R4fB+ZPu0dtGG98R/HB6opgJBAgh+MCGGyBhxGvyLLk6+gKgPVQCtjb
         fKzrfd7E9wa2dnhD27pBqEr54KxKCALKcwAfi1pqCqU+fUVjzS1/I3z4shVYXDNMkbxs
         e3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hjbQc9DjaSJO2W9q64ngPIUd8DbvQBeqPuOxQQPNhks=;
        b=cmmiQVaKM8ssHQ5+0ezSdMf0RJz8qVT6DBDvwQ4GHNnDL9hT5e1RZ48RXj0b0ChJGE
         OT+coPE922YYM9HkuCiWQLJ1Luysv9Fpnw94p5liFL+QKXq1P6vjjnSzXJTRAW8hNVkF
         XNYh4LLX7tYHYGxdIdPqM583h+HEJiGF1VgLhfL1Rku6g4bogJ5tAgqy3yvQBfM0XpOs
         I8z9KqdRt+jqOzMhK07DEcFROSMHgTsBprt79o1phpnY1E95FlcvKDctEDjO6lTErp10
         ig5N3DORuV62j4U96t9UtB9+HZNVHXkfSqD5aR4VOZQwQuC1vPEu7Q9D9SVKFgUVbKMv
         B3Jg==
X-Gm-Message-State: ALoCoQlfw7Prx8GE8gO/eOVHiOX1c3Hpty9wrxTUPBqNVbYluGYeL3vrlbXWMat5vLeHHuffq1Qo1wFvW2sZMU48oIXYGBi0cw==
X-Received: by 10.25.26.68 with SMTP id a65mr16554516lfa.24.1453415676793;
        Thu, 21 Jan 2016 14:34:36 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id j130sm319217lfe.23.2016.01.21.14.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 14:34:36 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC v2 1/7] WIP: clk: add AR9331 SoC clock driver
Date:   Fri, 22 Jan 2016 01:34:18 +0300
Message-Id: <1453415664-20307-2-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
References: <1453415664-20307-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51284
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

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 drivers/clk/Makefile                   |   1 +
 drivers/clk/clk-ath79.c                | 137 +++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/ar933x-clk.h |  22 ++++++
 3 files changed, 160 insertions(+)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 820714c..5101763 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -18,6 +18,7 @@ endif
 # hardware specific clock types
 # please keep this section sorted lexicographically by file/directory path name
 obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
+obj-$(CONFIG_ATH79)			+= clk-ath79.o
 obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
 obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
diff --git a/drivers/clk/clk-ath79.c b/drivers/clk/clk-ath79.c
new file mode 100644
index 0000000..1126840
--- /dev/null
+++ b/drivers/clk/clk-ath79.c
@@ -0,0 +1,137 @@
+/*
+ * Clock driver for Atheros AR933x SoCs.
+ *
+ * Copyright (C) 2016 Antony Pavlov <antonynpavlov@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/delay.h>
+#include <linux/math64.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include "clk.h"
+
+#include <dt-bindings/clock/ar933x-clk.h>
+
+#include "asm/mach-ath79/ar71xx_regs.h"
+#include "asm/mach-ath79/ath79.h"
+
+#define MHZ (1000 * 1000)
+
+static struct clk *ar933x_clks[AR933X_CLK_END];
+
+static struct clk_onecell_data clk_data;
+
+static struct clk *__init ath79_add_sys_clkdev(
+	const char *id, unsigned long rate)
+{
+	struct clk *clk;
+	int err;
+
+	clk = clk_register_fixed_rate(NULL, id, NULL, CLK_IS_ROOT, rate);
+	if (!clk)
+		panic("failed to allocate %s clock structure", id);
+
+	err = clk_register_clkdev(clk, id, NULL);
+	if (err)
+		panic("unable to register %s clock device", id);
+
+	return clk;
+}
+
+static void __init ar933x_clk_init(struct device_node *np)
+{
+	struct clk *ref_clk;
+	unsigned long of_ref_rate;
+	unsigned long ref_rate;
+	unsigned long cpu_rate;
+	unsigned long ddr_rate;
+	unsigned long ahb_rate;
+	u32 clock_ctrl;
+	u32 cpu_config;
+	u32 freq;
+	u32 t;
+
+	ref_clk = of_clk_get(np, 0);
+	if (IS_ERR(ref_clk)) {
+		pr_err("%s: of_clk_get failed\n", np->full_name);
+		return;
+	}
+
+	of_ref_rate = clk_get_rate(ref_clk);
+
+	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
+	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
+		ref_rate = 40 * MHZ;
+	else
+		ref_rate = 25 * MHZ;
+
+	if (ref_rate != of_ref_rate) {
+		pr_err("ref_rate != of_ref_rate\n");
+		ref_rate = of_ref_rate;
+	}
+
+	clock_ctrl = ath79_pll_rr(AR933X_PLL_CLOCK_CTRL_REG);
+	if (clock_ctrl & AR933X_PLL_CLOCK_CTRL_BYPASS) {
+		cpu_rate = ref_rate;
+		ahb_rate = ref_rate;
+		ddr_rate = ref_rate;
+	} else {
+		cpu_config = ath79_pll_rr(AR933X_PLL_CPU_CONFIG_REG);
+
+		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
+		    AR933X_PLL_CPU_CONFIG_REFDIV_MASK;
+		freq = ref_rate / t;
+
+		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_NINT_SHIFT) &
+		    AR933X_PLL_CPU_CONFIG_NINT_MASK;
+		freq *= t;
+
+		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
+		    AR933X_PLL_CPU_CONFIG_OUTDIV_MASK;
+		if (t == 0)
+			t = 1;
+
+		freq >>= t;
+
+		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_CPU_DIV_SHIFT) &
+		     AR933X_PLL_CLOCK_CTRL_CPU_DIV_MASK) + 1;
+		cpu_rate = freq / t;
+
+		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_DDR_DIV_SHIFT) &
+		      AR933X_PLL_CLOCK_CTRL_DDR_DIV_MASK) + 1;
+		ddr_rate = freq / t;
+
+		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_AHB_DIV_SHIFT) &
+		     AR933X_PLL_CLOCK_CTRL_AHB_DIV_MASK) + 1;
+		ahb_rate = freq / t;
+	}
+
+	ar933x_clks[AR933X_CLK_REF] = ath79_add_sys_clkdev("ref", ref_rate);
+	ar933x_clks[AR933X_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
+	ar933x_clks[AR933X_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
+	ar933x_clks[AR933X_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
+	ar933x_clks[AR933X_CLK_WDT] = ath79_add_sys_clkdev("wdt", ahb_rate);
+	ar933x_clks[AR933X_CLK_UART] = ath79_add_sys_clkdev("uart", ref_rate);
+
+	clk_data.clks = ar933x_clks;
+	clk_data.clk_num = AR933X_CLK_END;
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+}
+CLK_OF_DECLARE(ar933x_clk, "qca,ar9330-pll", ar933x_clk_init);
diff --git a/include/dt-bindings/clock/ar933x-clk.h b/include/dt-bindings/clock/ar933x-clk.h
new file mode 100644
index 0000000..ed9e5d5
--- /dev/null
+++ b/include/dt-bindings/clock/ar933x-clk.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2014, 2016 Antony Pavlov <antonynpavlov@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __DT_BINDINGS_AR933X_CLK_H
+#define __DT_BINDINGS_AR933X_CLK_H
+
+#define AR933X_CLK_REF		0
+#define AR933X_CLK_CPU		1
+#define AR933X_CLK_DDR		2
+#define AR933X_CLK_AHB		3
+#define AR933X_CLK_WDT		4
+#define AR933X_CLK_UART		5
+
+#define AR933X_CLK_END		6
+
+#endif /* __DT_BINDINGS_AR933X_CLK_H */
-- 
2.6.2
