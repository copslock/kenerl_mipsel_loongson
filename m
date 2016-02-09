Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 09:14:45 +0100 (CET)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36644 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011382AbcBIIO3ulC95 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 09:14:29 +0100
Received: by mail-lf0-f68.google.com with SMTP id h198so5992966lfh.3
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 00:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cgg/3vdvn17GhgqQI6mNgjLiTsyj3nzs74jVfILJVI8=;
        b=jHSY+WSMbilFoOfTDGSSirNy2HIhPbGXuLgAtcIcErX0DgVxc9Cd3DvpfVC/enw4rY
         C94msuQDC0o3if8R2fuANAABSTSD29OF3M4bxwop4QH8n9OXwuUPKr7pV54sw7EDqqg2
         YFWEERl6chIm03Wfqy5BCkIS9kAPuqlE4lGfvcg3JqXACvQXCUOs9ZQpbBnxDmGXxa6n
         Gkzefbom9hut28pmvB1KZF0+lB+Zu/fXVw5nSWTCRuRfobu0iyO2nmV7ymE5EjgvtKi7
         Jt2RvSQW4OcS1hw/HBo8gqvXclJwolzsWAJZDioZr5VZdMnrKA7mPhaaEPQ+chLU+jiR
         aKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cgg/3vdvn17GhgqQI6mNgjLiTsyj3nzs74jVfILJVI8=;
        b=IFmvOIJ78R/Csz+/ilOY15H6b00id7s/kyezUU3mWsS665YjtRDHHcBCowtJeBVWk3
         pXcJWDP+EBtUlzvgga/F4ZVFx+yk0IQXXR9cpMsEENgty28LoDQevsbNASSZ+DY+7OOy
         Jxwchw0BLUHt0yIgvMugsYCjFmhsDtTP0oKIbUDeX+SD5LbMC5VZZPbQTiDyIpveHVO7
         2Uty8QoG9Udu3QY32EUAAxhuIFsGOn47inDf6DZf6LvDu2bDRsVzc4B7pN+TqZp06RKL
         GcjjIEeAxk3lems1Eir7JGEcJMeM7Txt8tWr+8KGmflG8j3E8yycqzlU08YbyiZITaD6
         +Z1A==
X-Gm-Message-State: AG10YORlaQJo/IFuRjvxjiDDUchtc9cLIyY8hY7nVagLJ7fe670BMqmzG8nXblj50QAlKw==
X-Received: by 10.25.135.132 with SMTP id j126mr13159136lfd.88.1455005664526;
        Tue, 09 Feb 2016 00:14:24 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id v140sm212726lfd.24.2016.02.09.00.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 00:14:23 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Marek Vasut <marex@denx.de>, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC v5 01/15] WIP: clk: add Atheros AR933X SoCs clock driver
Date:   Tue,  9 Feb 2016 11:13:47 +0300
Message-Id: <1455005641-7079-2-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51877
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

This driver can be easely upgraded for other Atheros
SoCs (e.g. AR724X/AR913X) support.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Alban Bedel <albeu@free.fr>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 drivers/clk/Makefile                  |   1 +
 drivers/clk/clk-ath79.c               | 354 ++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/ath79-clk.h |  22 +++
 3 files changed, 377 insertions(+)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index b038e36..d7ad50e 100644
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
index 0000000..e899d31
--- /dev/null
+++ b/drivers/clk/clk-ath79.c
@@ -0,0 +1,354 @@
+/*
+ * Clock driver for Atheros AR933X SoCs
+ *
+ * Copyright (C) 2016 Antony Pavlov <antonynpavlov@gmail.com>
+ *
+ * This driver is based on Ingenic CGU linux driver by Paul Burton
+ * and AR9331 barebox driver by Antony Pavlov.
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
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <dt-bindings/clock/ath79-clk.h>
+
+#include "asm/mach-ath79/ar71xx_regs.h"
+
+struct ath79_pll_info {
+	u32 div_shift;
+	u32 div_mask;
+};
+
+struct ath79_cblk;
+
+/**
+ * struct ath79_clk_info - information about a clock
+ * @name: name of the clock
+ * @type: a bitmask formed from ATH79_CLK_* values
+ * @parents: an index of parent of this clock
+ *           within the clock_info array, or -1
+ *           which correspond to no valid parent
+ * @pll: information valid if type includes ATH79_CLK_PLL
+ */
+struct ath79_clk_info {
+	const char *name;
+
+	enum {
+		ATH79_CLK_NONE		= 0,
+		ATH79_CLK_EXT		= 1,
+		ATH79_CLK_PLL		= 2,
+		ATH79_CLK_ALIAS		= 3,
+	} type;
+
+	struct ath79_cblk *cblk;
+	int parent;
+
+	struct ath79_pll_info pll;
+};
+
+struct ath79_cblk {
+	struct device_node *np;
+	void __iomem *base;
+
+	const struct ath79_clk_info *clock_info;
+	struct clk_onecell_data clocks;
+};
+
+/**
+ * struct ath79_clk - private data for a clock
+ * @hw: see Documentation/clk.txt
+ * @cblk: a pointer to the cblk data
+ * @idx: the index of this clock cblk->clock_info
+ * @pll: information valid if type includes ATH79_CLK_PLL
+ */
+struct ath79_clk {
+	struct clk_hw hw;
+	struct ath79_cblk *cblk;
+	unsigned idx;
+};
+
+#define to_ath79_clk(_hw) container_of(_hw, struct ath79_clk, hw)
+
+static const struct ath79_clk_info ar9331_clocks[] = {
+
+	/* External clock */
+	[ATH79_CLK_REF] = { "ref", ATH79_CLK_EXT },
+
+	[ATH79_CLK_CPU] = {
+		"cpu", ATH79_CLK_PLL,
+		.parent = ATH79_CLK_REF,
+		.pll = {
+			.div_shift = AR933X_PLL_CLOCK_CTRL_CPU_DIV_SHIFT,
+			.div_mask = AR933X_PLL_CLOCK_CTRL_CPU_DIV_MASK,
+		},
+	},
+
+	[ATH79_CLK_DDR] = {
+		"ddr", ATH79_CLK_PLL,
+		.parent = ATH79_CLK_REF,
+		.pll = {
+			.div_shift = AR933X_PLL_CLOCK_CTRL_DDR_DIV_SHIFT,
+			.div_mask = AR933X_PLL_CLOCK_CTRL_DDR_DIV_MASK,
+		},
+	},
+
+	[ATH79_CLK_AHB] = {
+		"ahb", ATH79_CLK_PLL,
+		.parent = ATH79_CLK_REF,
+		.pll = {
+			.div_shift = AR933X_PLL_CLOCK_CTRL_AHB_DIV_SHIFT,
+			.div_mask = AR933X_PLL_CLOCK_CTRL_AHB_DIV_MASK,
+		},
+	},
+
+	[ATH79_CLK_WDT] = {
+		"wdt", ATH79_CLK_ALIAS,
+		.parent = ATH79_CLK_AHB,
+	},
+
+	[ATH79_CLK_UART] = {
+		"uart", ATH79_CLK_ALIAS,
+		.parent = ATH79_CLK_REF,
+	},
+};
+
+struct ath79_cblk *
+ath79_cblk_new(const struct ath79_clk_info *clock_info,
+		unsigned num_clocks, struct device_node *np)
+{
+	struct ath79_cblk *cblk;
+
+	cblk = kzalloc(sizeof(*cblk), GFP_KERNEL);
+	if (!cblk)
+		goto err_out;
+
+	cblk->base = of_iomap(np, 0);
+	if (!cblk->base) {
+		pr_err("%s: failed to map clock block registers\n", __func__);
+		goto err_out_free;
+	}
+
+	cblk->np = np;
+	cblk->clock_info = clock_info;
+	cblk->clocks.clk_num = num_clocks;
+
+	return cblk;
+
+err_out_free:
+	kfree(cblk);
+
+err_out:
+	return NULL;
+}
+
+static unsigned long
+ath79_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct ath79_clk *ath79_clk = to_ath79_clk(hw);
+	struct ath79_cblk *cblk = ath79_clk->cblk;
+	const struct ath79_clk_info *clk_info = &cblk->clock_info[ath79_clk->idx];
+	const struct ath79_pll_info *pll_info;
+	unsigned long rate;
+	unsigned long freq;
+	u32 clock_ctrl;
+	u32 cpu_config;
+	u32 t;
+
+	BUG_ON(clk_info->type != ATH79_CLK_PLL);
+
+	clock_ctrl = __raw_readl(cblk->base + AR933X_PLL_CLOCK_CTRL_REG);
+
+	if (clock_ctrl & AR933X_PLL_CLOCK_CTRL_BYPASS) {
+		return parent_rate;
+	}
+
+	cpu_config = __raw_readl(cblk->base + AR933X_PLL_CPU_CONFIG_REG);
+
+	t = (cpu_config >> AR933X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
+	    AR933X_PLL_CPU_CONFIG_REFDIV_MASK;
+	freq = parent_rate / t;
+
+	t = (cpu_config >> AR933X_PLL_CPU_CONFIG_NINT_SHIFT) &
+	    AR933X_PLL_CPU_CONFIG_NINT_MASK;
+	freq *= t;
+
+	t = (cpu_config >> AR933X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
+	    AR933X_PLL_CPU_CONFIG_OUTDIV_MASK;
+	if (t == 0)
+		t = 1;
+
+	freq >>= t;
+
+	pll_info = &clk_info->pll;
+
+	t = ((clock_ctrl >> pll_info->div_shift) & pll_info->div_mask) + 1;
+	rate = freq / t;
+
+	return rate;
+}
+
+static const struct clk_ops ath79_pll_clk_ops = {
+	.recalc_rate = ath79_pll_recalc_rate,
+};
+
+static int ath79_register_clock(struct ath79_cblk *cblk, unsigned idx)
+{
+	const struct ath79_clk_info *clk_info = &cblk->clock_info[idx];
+	const struct ath79_clk_info *parent_clk_info;
+	struct clk_init_data clk_init;
+	struct ath79_clk *ath79_clk = NULL;
+	struct clk *clk;
+	int err = -EINVAL;
+
+	if (clk_info->type == ATH79_CLK_EXT) {
+		clk = of_clk_get_by_name(cblk->np, clk_info->name);
+		if (IS_ERR(clk)) {
+			pr_err("%s: no external clock '%s' provided\n",
+			       __func__, clk_info->name);
+			err = -ENODEV;
+			goto out;
+		}
+
+		err = clk_register_clkdev(clk, clk_info->name, NULL);
+		if (err) {
+			clk_put(clk);
+			goto out;
+		}
+
+		cblk->clocks.clks[idx] = clk;
+
+		return 0;
+	}
+
+	parent_clk_info = &cblk->clock_info[clk_info->parent];
+
+	if (clk_info->type == ATH79_CLK_ALIAS) {
+		clk = clk_register_fixed_factor(NULL, clk_info->name,
+						parent_clk_info->name, 0, 1, 1);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock '%s'\n", __func__,
+			       clk_info->name);
+			err = PTR_ERR(clk);
+			goto out;
+		}
+
+		cblk->clocks.clks[idx] = clk;
+
+		return 0;
+	}
+
+	if (!clk_info->type) {
+		pr_err("%s: no clock type specified for '%s'\n", __func__,
+		       clk_info->name);
+		goto out;
+	}
+
+	ath79_clk = kzalloc(sizeof(*ath79_clk), GFP_KERNEL);
+	if (!ath79_clk) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	ath79_clk->hw.init = &clk_init;
+	ath79_clk->cblk = cblk;
+	ath79_clk->idx = idx;
+
+	clk_init.name = clk_info->name;
+	clk_init.flags = 0;
+	clk_init.parent_names = &parent_clk_info->name;
+	clk_init.num_parents = 1;
+
+	if (clk_info->type == ATH79_CLK_PLL) {
+		clk_init.ops = &ath79_pll_clk_ops;
+	}
+
+	clk = clk_register(NULL, &ath79_clk->hw);
+	if (IS_ERR(clk)) {
+		pr_err("%s: failed to register clock '%s'\n", __func__,
+		       clk_info->name);
+		err = PTR_ERR(clk);
+		goto out;
+	}
+
+	err = clk_register_clkdev(clk, clk_info->name, NULL);
+	if (err)
+		goto out;
+
+	cblk->clocks.clks[idx] = clk;
+out:
+	if (err)
+		kfree(ath79_clk);
+
+	return err;
+}
+
+static int ath79_cblk_register_clocks(struct ath79_cblk *cblk)
+{
+	unsigned i;
+	int err;
+
+	cblk->clocks.clks = kcalloc(cblk->clocks.clk_num, sizeof(struct clk *),
+				   GFP_KERNEL);
+	if (!cblk->clocks.clks) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	for (i = 0; i < cblk->clocks.clk_num; i++) {
+		err = ath79_register_clock(cblk, i);
+		if (err)
+			goto err_out_unregister;
+	}
+
+	err = of_clk_add_provider(cblk->np, of_clk_src_onecell_get,
+				  &cblk->clocks);
+	if (err)
+		goto err_out_unregister;
+
+	return 0;
+
+err_out_unregister:
+	for (i = 0; i < cblk->clocks.clk_num; i++) {
+		if (!cblk->clocks.clks[i])
+			continue;
+		if (cblk->clock_info[i].type == ATH79_CLK_EXT)
+			clk_put(cblk->clocks.clks[i]);
+		else
+			clk_unregister(cblk->clocks.clks[i]);
+	}
+
+	kfree(cblk->clocks.clks);
+
+err_out:
+	return err;
+}
+
+static void __init ar9130_init(struct device_node *np)
+{
+	int retval;
+	struct ath79_cblk *cblk;
+
+	cblk = ath79_cblk_new(ar9331_clocks, ARRAY_SIZE(ar9331_clocks), np);
+	if (!cblk) {
+		pr_err("%s: failed to initialise clk block\n", __func__);
+		return;
+	}
+
+	retval = ath79_cblk_register_clocks(cblk);
+	if (retval)
+		pr_err("%s: failed to register clocks\n", __func__);
+}
+CLK_OF_DECLARE(ar933x_clk, "qca,ar9330-pll", ar9130_init);
diff --git a/include/dt-bindings/clock/ath79-clk.h b/include/dt-bindings/clock/ath79-clk.h
new file mode 100644
index 0000000..1c6fb04
--- /dev/null
+++ b/include/dt-bindings/clock/ath79-clk.h
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
+#ifndef __DT_BINDINGS_ATH79_CLK_H
+#define __DT_BINDINGS_ATH79_CLK_H
+
+#define ATH79_CLK_REF		0
+#define ATH79_CLK_CPU		1
+#define ATH79_CLK_DDR		2
+#define ATH79_CLK_AHB		3
+#define ATH79_CLK_WDT		4
+#define ATH79_CLK_UART		5
+
+#define ATH79_CLK_END		6
+
+#endif /* __DT_BINDINGS_ATH79_CLK_H */
-- 
2.7.0
