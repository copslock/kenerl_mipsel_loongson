Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 19:48:00 +0200 (CEST)
Received: from mail-la0-f49.google.com ([209.85.215.49]:33813 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825606Ab2JWRr7Bk92B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 19:47:59 +0200
Received: by mail-la0-f49.google.com with SMTP id z14so2431916lag.36
        for <multiple recipients>; Tue, 23 Oct 2012 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gr46yfeVEAZCNSF+HOAvALaY/U6igZKrBOG/JRkMCNM=;
        b=Ye4Oxc/ggCSYVjEYQsMkMIMwZjAdheyiljaAnEdZ1se3qaQgrt1FdhNj63h3dZR/jb
         LpFtaoxkJL1caservH/h6cDU/mRbm1qbJvNXzgFqg51LQSrYItzxhG6VNabn3WtdAxLY
         HV2pjVEjAV2eLUKMM5JXmmSv4AViZrhiPA7vONi5wZcwze5ZOOVwLEl+t6Uy608Hqi69
         bjpBeycvLxks5F+xodlncu+BwO1cewcbgt0UJbdHTS0RolN5WceAzuMvhdXytexhG9Vn
         5qpOLU5DkuW0SUccZ7aPoTlM2Fsmcc2P3ol265ek+LZJpfK1LFnJK1NxlLYxvtroU2Ul
         BA6A==
Received: by 10.152.47.79 with SMTP id b15mr11997346lan.57.1351014473076;
        Tue, 23 Oct 2012 10:47:53 -0700 (PDT)
Received: from lazar.cs.niisi.ras.ru (t109.niisi.ras.ru. [193.232.173.109])
        by mx.google.com with ESMTPS id m6sm4260284lbh.10.2012.10.23.10.47.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 10:47:52 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [RFC 02/13] MIPS: JZ4750D: Add clock API support
Date:   Tue, 23 Oct 2012 21:43:50 +0400
Message-Id: <1351014241-3207-3-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com>
X-archive-position: 34750
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add support for managing the clocks found on JZ4750D SoC through the
Linux clock API.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/jz4750d/clock-debugfs.c |  107 ++++++++
 arch/mips/jz4750d/clock.c         |  499 +++++++++++++++++++++++++++++++++++++
 arch/mips/jz4750d/clock.h         |   75 ++++++
 3 files changed, 681 insertions(+)
 create mode 100644 arch/mips/jz4750d/clock-debugfs.c
 create mode 100644 arch/mips/jz4750d/clock.c
 create mode 100644 arch/mips/jz4750d/clock.h

diff --git a/arch/mips/jz4750d/clock-debugfs.c b/arch/mips/jz4750d/clock-debugfs.c
new file mode 100644
index 0000000..0d8a506
--- /dev/null
+++ b/arch/mips/jz4750d/clock-debugfs.c
@@ -0,0 +1,107 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D SoC clock support debugfs entries
+ *
+ *  based on JZ4740 SoC clock support debugfs entries
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+
+#include "clock.h"
+
+static struct dentry *jz4750d_clock_debugfs;
+
+static int jz4750d_clock_debugfs_show_enabled(void *data, uint64_t *value)
+{
+	struct clk *clk = data;
+	*value = clk_is_enabled(clk);
+
+	return 0;
+}
+
+static int jz4750d_clock_debugfs_set_enabled(void *data, uint64_t value)
+{
+	struct clk *clk = data;
+
+	if (value)
+		return clk_enable(clk);
+	else
+		clk_disable(clk);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(jz4750d_clock_debugfs_ops_enabled,
+	jz4750d_clock_debugfs_show_enabled,
+	jz4750d_clock_debugfs_set_enabled,
+	"%llu\n");
+
+static int jz4750d_clock_debugfs_show_rate(void *data, uint64_t *value)
+{
+	struct clk *clk = data;
+	*value = clk_get_rate(clk);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(jz4750d_clock_debugfs_ops_rate,
+	jz4750d_clock_debugfs_show_rate,
+	NULL,
+	"%llu\n");
+
+void jz4750d_clock_debugfs_add_clk(struct clk *clk)
+{
+	if (!jz4750d_clock_debugfs)
+		return;
+
+	clk->debugfs_entry = debugfs_create_dir(clk->name, jz4750d_clock_debugfs);
+	debugfs_create_file("rate", S_IWUGO | S_IRUGO, clk->debugfs_entry, clk,
+				&jz4750d_clock_debugfs_ops_rate);
+	debugfs_create_file("enabled", S_IRUGO, clk->debugfs_entry, clk,
+				&jz4750d_clock_debugfs_ops_enabled);
+
+	if (clk->parent) {
+		char parent_path[100];
+		snprintf(parent_path, 100, "../%s", clk->parent->name);
+		clk->debugfs_parent_entry = debugfs_create_symlink("parent",
+						clk->debugfs_entry,
+						parent_path);
+	}
+}
+
+/* TODO: Locking */
+void jz4750d_clock_debugfs_update_parent(struct clk *clk)
+{
+	if (clk->debugfs_parent_entry)
+		debugfs_remove(clk->debugfs_parent_entry);
+
+	if (clk->parent) {
+		char parent_path[100];
+		snprintf(parent_path, 100, "../%s", clk->parent->name);
+		clk->debugfs_parent_entry = debugfs_create_symlink("parent",
+						clk->debugfs_entry,
+						parent_path);
+	} else {
+		clk->debugfs_parent_entry = NULL;
+	}
+}
+
+void jz4750d_clock_debugfs_init(void)
+{
+	jz4750d_clock_debugfs = debugfs_create_dir("jz4750d-clock", NULL);
+	if (IS_ERR(jz4750d_clock_debugfs))
+		jz4750d_clock_debugfs = NULL;
+}
diff --git a/arch/mips/jz4750d/clock.c b/arch/mips/jz4750d/clock.c
new file mode 100644
index 0000000..a542fd5
--- /dev/null
+++ b/arch/mips/jz4750d/clock.c
@@ -0,0 +1,499 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D SoC clock support
+ *
+ *  based on JZ4740 SoC clock support
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/err.h>
+
+#include <asm/mach-jz4750d/base.h>
+
+#include "clock.h"
+
+#define JZ_REG_CLOCK_CTRL	0x00
+#define JZ_REG_CLOCK_PLL	0x10
+#define JZ_REG_CLOCK_GATE	0x20
+
+#define JZ_CLOCK_CTRL_KO_ENABLE		BIT(30)
+#define JZ_CLOCK_CTRL_UDC_SRC_PLL	BIT(29)
+#define JZ_CLOCK_CTRL_UDIV_MASK		0x1f800000
+#define JZ_CLOCK_CTRL_CHANGE_ENABLE	BIT(22)
+#define JZ_CLOCK_CTRL_PLL_HALF		BIT(21)
+#define JZ_CLOCK_CTRL_MDIV_OFFSET	12
+#define JZ_CLOCK_CTRL_PDIV_OFFSET	 8
+#define JZ_CLOCK_CTRL_HDIV_OFFSET	 4
+#define JZ_CLOCK_CTRL_CDIV_OFFSET	 0
+
+#define JZ_CLOCK_GATE_UART0	BIT(0)
+#define JZ_CLOCK_GATE_RTC	BIT(2)
+#define JZ_CLOCK_GATE_UART1	BIT(14)
+
+#define JZ_CLOCK_PLL_BYPASS	BIT(9)
+
+static void __iomem *jz_clock_base;
+static spinlock_t jz_clock_lock;
+static LIST_HEAD(jz_clocks);
+
+struct main_clk {
+	struct clk clk;
+	uint32_t div_offset;
+};
+
+struct divided_clk {
+	struct clk clk;
+	uint32_t reg;
+	uint32_t mask;
+};
+
+struct static_clk {
+	struct clk clk;
+	unsigned long rate;
+};
+
+static uint32_t jz_clk_reg_read(int reg)
+{
+	return readl(jz_clock_base + reg);
+}
+
+static void jz_clk_reg_write_mask(int reg, uint32_t val, uint32_t mask)
+{
+	uint32_t val2;
+
+	spin_lock(&jz_clock_lock);
+	val2 = readl(jz_clock_base + reg);
+	val2 &= ~mask;
+	val2 |= val;
+	writel(val2, jz_clock_base + reg);
+	spin_unlock(&jz_clock_lock);
+}
+
+static void jz_clk_reg_set_bits(int reg, uint32_t mask)
+{
+	uint32_t val;
+
+	spin_lock(&jz_clock_lock);
+	val = readl(jz_clock_base + reg);
+	val |= mask;
+	writel(val, jz_clock_base + reg);
+	spin_unlock(&jz_clock_lock);
+}
+
+static void jz_clk_reg_clear_bits(int reg, uint32_t mask)
+{
+	uint32_t val;
+
+	spin_lock(&jz_clock_lock);
+	val = readl(jz_clock_base + reg);
+	val &= ~mask;
+	writel(val, jz_clock_base + reg);
+	spin_unlock(&jz_clock_lock);
+}
+
+static int jz_clk_enable_gating(struct clk *clk)
+{
+	if (clk->gate_bit == JZ4750D_CLK_NOT_GATED)
+		return -EINVAL;
+
+	jz_clk_reg_clear_bits(JZ_REG_CLOCK_GATE, clk->gate_bit);
+	return 0;
+}
+
+static int jz_clk_disable_gating(struct clk *clk)
+{
+	if (clk->gate_bit == JZ4750D_CLK_NOT_GATED)
+		return -EINVAL;
+
+	jz_clk_reg_set_bits(JZ_REG_CLOCK_GATE, clk->gate_bit);
+	return 0;
+}
+
+static int jz_clk_is_enabled_gating(struct clk *clk)
+{
+	if (clk->gate_bit == JZ4750D_CLK_NOT_GATED)
+		return 1;
+
+	return !(jz_clk_reg_read(JZ_REG_CLOCK_GATE) & clk->gate_bit);
+}
+
+static unsigned long jz_clk_static_get_rate(struct clk *clk)
+{
+	return ((struct static_clk *)clk)->rate;
+}
+
+static int jz_clk_ko_enable(struct clk *clk)
+{
+	jz_clk_reg_set_bits(JZ_REG_CLOCK_CTRL, JZ_CLOCK_CTRL_KO_ENABLE);
+	return 0;
+}
+
+static int jz_clk_ko_disable(struct clk *clk)
+{
+	jz_clk_reg_clear_bits(JZ_REG_CLOCK_CTRL, JZ_CLOCK_CTRL_KO_ENABLE);
+	return 0;
+}
+
+static int jz_clk_ko_is_enabled(struct clk *clk)
+{
+	return !!(jz_clk_reg_read(JZ_REG_CLOCK_CTRL) & JZ_CLOCK_CTRL_KO_ENABLE);
+}
+
+static const int pllno[] = {1, 2, 2, 4};
+
+static unsigned long jz_clk_pll_get_rate(struct clk *clk)
+{
+	uint32_t val;
+	int m;
+	int n;
+	int od;
+
+	val = jz_clk_reg_read(JZ_REG_CLOCK_PLL);
+
+	if (val & JZ_CLOCK_PLL_BYPASS)
+		return clk_get_rate(clk->parent);
+
+	m = ((val >> 23) & 0x1ff) + 2;
+	n = ((val >> 18) & 0x1f) + 2;
+	od = (val >> 16) & 0x3;
+
+	return ((clk_get_rate(clk->parent) / n) * m) / pllno[od];
+}
+
+static unsigned long jz_clk_pll_half_get_rate(struct clk *clk)
+{
+	uint32_t reg;
+
+	reg = jz_clk_reg_read(JZ_REG_CLOCK_CTRL);
+	if (reg & JZ_CLOCK_CTRL_PLL_HALF)
+		return jz_clk_pll_get_rate(clk->parent);
+	return jz_clk_pll_get_rate(clk->parent) >> 1;
+}
+
+static const int jz_clk_main_divs[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32};
+
+static unsigned long jz_clk_main_round_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long parent_rate = jz_clk_pll_get_rate(clk->parent);
+	int div;
+
+	div = parent_rate / rate;
+	if (div > 32)
+		return parent_rate / 32;
+	else if (div < 1)
+		return parent_rate;
+
+	div &= (0x3 << (ffs(div) - 1));
+
+	return parent_rate / div;
+}
+
+static unsigned long jz_clk_main_get_rate(struct clk *clk)
+{
+	struct main_clk *mclk = (struct main_clk *)clk;
+	uint32_t div;
+
+	div = jz_clk_reg_read(JZ_REG_CLOCK_CTRL);
+
+	div >>= mclk->div_offset;
+	div &= 0xf;
+
+	if (div >= ARRAY_SIZE(jz_clk_main_divs))
+		div = ARRAY_SIZE(jz_clk_main_divs) - 1;
+
+	return jz_clk_pll_get_rate(clk->parent) / jz_clk_main_divs[div];
+}
+
+static int jz_clk_main_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct main_clk *mclk = (struct main_clk *)clk;
+	int i;
+	int div;
+	unsigned long parent_rate = jz_clk_pll_get_rate(clk->parent);
+
+	rate = jz_clk_main_round_rate(clk, rate);
+
+	div = parent_rate / rate;
+
+	i = (ffs(div) - 1) << 1;
+	if (i > 0 && !(div & BIT(i-1)))
+		i -= 1;
+
+	jz_clk_reg_write_mask(JZ_REG_CLOCK_CTRL, i << mclk->div_offset,
+				0xf << mclk->div_offset);
+
+	return 0;
+}
+
+static struct clk_ops jz_clk_static_ops = {
+	.get_rate = jz_clk_static_get_rate,
+	.enable = jz_clk_enable_gating,
+	.disable = jz_clk_disable_gating,
+	.is_enabled = jz_clk_is_enabled_gating,
+};
+
+static struct static_clk jz_clk_ext = {
+	.clk = {
+		.name = "ext",
+		.gate_bit = JZ4750D_CLK_NOT_GATED,
+		.ops = &jz_clk_static_ops,
+	},
+};
+
+static struct clk_ops jz_clk_pll_ops = {
+	.get_rate = jz_clk_pll_get_rate,
+};
+
+static struct clk jz_clk_pll = {
+	.name = "pll",
+	.parent = &jz_clk_ext.clk,
+	.ops = &jz_clk_pll_ops,
+};
+
+static struct clk_ops jz_clk_pll_half_ops = {
+	.get_rate = jz_clk_pll_half_get_rate,
+};
+
+static struct clk jz_clk_pll_half = {
+	.name = "pll half",
+	.parent = &jz_clk_pll,
+	.ops = &jz_clk_pll_half_ops,
+};
+
+static const struct clk_ops jz_clk_main_ops = {
+	.get_rate = jz_clk_main_get_rate,
+	.set_rate = jz_clk_main_set_rate,
+	.round_rate = jz_clk_main_round_rate,
+};
+
+static struct main_clk jz_clk_cpu = {
+	.clk = {
+		.name = "cclk",
+		.parent = &jz_clk_pll,
+		.ops = &jz_clk_main_ops,
+	},
+	.div_offset = JZ_CLOCK_CTRL_CDIV_OFFSET,
+};
+
+static struct main_clk jz_clk_memory = {
+	.clk = {
+		.name = "mclk",
+		.parent = &jz_clk_pll,
+		.ops = &jz_clk_main_ops,
+	},
+	.div_offset = JZ_CLOCK_CTRL_MDIV_OFFSET,
+};
+
+static struct main_clk jz_clk_high_speed_peripheral = {
+	.clk = {
+		.name = "hclk",
+		.parent = &jz_clk_pll,
+		.ops = &jz_clk_main_ops,
+	},
+	.div_offset = JZ_CLOCK_CTRL_HDIV_OFFSET,
+};
+
+static struct main_clk jz_clk_low_speed_peripheral = {
+	.clk = {
+		.name = "pclk",
+		.parent = &jz_clk_pll,
+		.ops = &jz_clk_main_ops,
+	},
+	.div_offset = JZ_CLOCK_CTRL_PDIV_OFFSET,
+};
+
+static const struct clk_ops jz_clk_ko_ops = {
+	.enable = jz_clk_ko_enable,
+	.disable = jz_clk_ko_disable,
+	.is_enabled = jz_clk_ko_is_enabled,
+};
+
+static struct clk jz_clk_ko = {
+	.name = "cko",
+	.parent = &jz_clk_memory.clk,
+	.ops = &jz_clk_ko_ops,
+};
+
+static const struct clk_ops jz_clk_simple_ops = {
+	.enable = jz_clk_enable_gating,
+	.disable = jz_clk_disable_gating,
+	.is_enabled = jz_clk_is_enabled_gating,
+};
+
+static struct clk jz4750d_clock_simple_clks[] = {
+	[0] = {
+		.name = "uart0",
+		.parent = &jz_clk_ext.clk,
+		.gate_bit = JZ_CLOCK_GATE_UART0,
+		.ops = &jz_clk_simple_ops,
+	},
+	[1] = {
+		.name = "uart1",
+		.parent = &jz_clk_ext.clk,
+		.gate_bit = JZ_CLOCK_GATE_UART1,
+		.ops = &jz_clk_simple_ops,
+	},
+};
+
+static struct static_clk jz_clk_rtc = {
+	.clk = {
+		.name = "rtc",
+		.gate_bit = JZ_CLOCK_GATE_RTC,
+		.ops = &jz_clk_static_ops,
+	},
+	.rate = 32768,
+};
+
+int clk_enable(struct clk *clk)
+{
+	if (!clk->ops->enable)
+		return -EINVAL;
+
+	return clk->ops->enable(clk);
+}
+EXPORT_SYMBOL_GPL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+	if (clk->ops->disable)
+		clk->ops->disable(clk);
+}
+EXPORT_SYMBOL_GPL(clk_disable);
+
+int clk_is_enabled(struct clk *clk)
+{
+	if (clk->ops->is_enabled)
+		return clk->ops->is_enabled(clk);
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(clk_is_enabled);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	if (clk->ops->get_rate)
+		return clk->ops->get_rate(clk);
+	if (clk->parent)
+		return clk_get_rate(clk->parent);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(clk_get_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	if (!clk->ops->set_rate)
+		return -EINVAL;
+	return clk->ops->set_rate(clk, rate);
+}
+EXPORT_SYMBOL_GPL(clk_set_rate);
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	if (clk->ops->round_rate)
+		return clk->ops->round_rate(clk, rate);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(clk_round_rate);
+
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	int ret;
+	int enabled;
+
+	if (!clk->ops->set_parent)
+		return -EINVAL;
+
+	enabled = clk_is_enabled(clk);
+	if (enabled)
+		clk_disable(clk);
+	ret = clk->ops->set_parent(clk, parent);
+	if (enabled)
+		clk_enable(clk);
+
+	jz4750d_clock_debugfs_update_parent(clk);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_parent);
+
+struct clk *clk_get(struct device *dev, const char *name)
+{
+	struct clk *clk;
+
+	list_for_each_entry(clk, &jz_clocks, list) {
+		if (strcmp(clk->name, name) == 0)
+			return clk;
+	}
+	return ERR_PTR(-ENXIO);
+}
+EXPORT_SYMBOL_GPL(clk_get);
+
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL_GPL(clk_put);
+
+static inline void clk_add(struct clk *clk)
+{
+	list_add_tail(&clk->list, &jz_clocks);
+
+	jz4750d_clock_debugfs_add_clk(clk);
+}
+
+static void clk_register_clks(void)
+{
+	size_t i;
+
+	clk_add(&jz_clk_ext.clk);
+	clk_add(&jz_clk_pll);
+	clk_add(&jz_clk_pll_half);
+	clk_add(&jz_clk_cpu.clk);
+	clk_add(&jz_clk_high_speed_peripheral.clk);
+	clk_add(&jz_clk_low_speed_peripheral.clk);
+	clk_add(&jz_clk_ko);
+	clk_add(&jz_clk_rtc.clk);
+
+	for (i = 0; i < ARRAY_SIZE(jz4750d_clock_simple_clks); ++i)
+		clk_add(&jz4750d_clock_simple_clks[i]);
+}
+
+static int jz4750d_clock_init(void)
+{
+	uint32_t val;
+
+	jz_clock_base = ioremap(JZ4750D_CPM_BASE_ADDR, 0x100);
+	if (!jz_clock_base)
+		return -EBUSY;
+
+	spin_lock_init(&jz_clock_lock);
+
+	jz_clk_ext.rate = jz4750d_clock_bdata.ext_rate;
+	jz_clk_rtc.rate = jz4750d_clock_bdata.rtc_rate;
+
+	val = jz_clk_reg_read(JZ_REG_CLOCK_CTRL);
+
+	if (val & JZ_CLOCK_CTRL_UDC_SRC_PLL)
+		jz4750d_clock_simple_clks[0].parent = &jz_clk_pll_half;
+
+	jz4750d_clock_debugfs_init();
+
+	clk_register_clks();
+
+	return 0;
+}
+arch_initcall(jz4750d_clock_init);
diff --git a/arch/mips/jz4750d/clock.h b/arch/mips/jz4750d/clock.h
new file mode 100644
index 0000000..f809b51
--- /dev/null
+++ b/arch/mips/jz4750d/clock.h
@@ -0,0 +1,75 @@
+/*
+ *  Copyright (C) 2012, Antony Pavlov <antonynpavlov@gmail.com>
+ *  JZ4750D SoC clock support
+ *
+ *  based on JZ4740 SoC clock support
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef __MIPS_JZ4750D_CLOCK_H__
+#define __MIPS_JZ4750D_CLOCK_H__
+
+#include <linux/list.h>
+
+struct jz4750d_clock_board_data {
+	unsigned long ext_rate;
+	unsigned long rtc_rate;
+};
+
+extern struct jz4750d_clock_board_data jz4750d_clock_bdata;
+
+void jz4750d_clock_suspend(void);
+void jz4750d_clock_resume(void);
+
+struct clk;
+
+struct clk_ops {
+	unsigned long (*get_rate)(struct clk *clk);
+	unsigned long (*round_rate)(struct clk *clk, unsigned long rate);
+	int (*set_rate)(struct clk *clk, unsigned long rate);
+	int (*enable)(struct clk *clk);
+	int (*disable)(struct clk *clk);
+	int (*is_enabled)(struct clk *clk);
+
+	int (*set_parent)(struct clk *clk, struct clk *parent);
+
+};
+
+struct clk {
+	const char *name;
+	struct clk *parent;
+
+	uint32_t gate_bit;
+
+	const struct clk_ops *ops;
+
+	struct list_head list;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_entry;
+	struct dentry *debugfs_parent_entry;
+#endif
+
+};
+
+#define JZ4750D_CLK_NOT_GATED ((uint32_t)-1)
+
+int clk_is_enabled(struct clk *clk);
+
+#ifdef CONFIG_DEBUG_FS
+void jz4750d_clock_debugfs_init(void);
+void jz4750d_clock_debugfs_add_clk(struct clk *clk);
+void jz4750d_clock_debugfs_update_parent(struct clk *clk);
+#else
+static inline void jz4750d_clock_debugfs_init(void) {};
+static inline void jz4750d_clock_debugfs_add_clk(struct clk *clk) {};
+static inline void jz4750d_clock_debugfs_update_parent(struct clk *clk) {};
+#endif
+
+#endif
-- 
1.7.10.4
