Return-Path: <SRS0=nWPK=SH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FE3C4360F
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 00:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6651217D7
	for <linux-mips@archiver.kernel.org>; Fri,  5 Apr 2019 00:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMZpMJVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfDEACK (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:02:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38542 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDEACK (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 4 Apr 2019 20:02:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so2045293pgl.5;
        Thu, 04 Apr 2019 17:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=acjszkUTtdCJzeFJdRHfB9/4duD7Pjag8db3gXGi3vM=;
        b=YMZpMJVL/3MdPfH0hkTB0eF0oIbr+gDcP/JBjfpdCU3XitoD6mYJYw0JkwV3fE94Q8
         7Gf0DBZo2mHoGoqTuUrxEqVRcva3hvfFw59FzgqA6WG98+boboLEOJKWw1Hgn4jmTuxm
         R/Jwu/efdyCtBUWnS+azhSQ6bn7i99LhJHPdNzmMkFC+/lEylFiYbNy85rE/HlT7ZOL3
         lMIBbZMtBYqkBSNU0y/xMG+moW3TO5PA1BwHY66xAbuLKadA7AW6bVZTSmbtWop/hc1U
         L8JldtxJ1S2H1+SLqYp/+fsGZPCvuXkYoPAk0ziBOywlsFC/ITYnnrpUbOn7vqw+QDFd
         e7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=acjszkUTtdCJzeFJdRHfB9/4duD7Pjag8db3gXGi3vM=;
        b=LHO/JfDL7Ug0lGWj9SwmV/Veere5h36DSoe/lsnU/L5Eiap66N+q+8xjeZiJLPTn82
         VnywXGabRMuv9/b8MOrb/ZUzPvaRPbFTA3dtMLcka9uVYACpnugmg+Q/LKFgCSwgTfqV
         5LYdFTcSIDl+H/DLyhoRhZq495xw6/keOtKIPuAhaldGqWMPNIVffAqRm4ex01HYxlw7
         R/kWDFyo3OuYTORlkQ55VBfiHLuTvSY/r2s6X5adhZxilnG/r21ZEkMFwAosfjdtGaX0
         B7ywxjJE3XvUFIH7NOOxqxEKVhn7GOpihs1gUt44ULJmniaJ5eEyS1zKPffJDrzQ66sp
         bK9A==
X-Gm-Message-State: APjAAAUOfeYHS/6N259gnFLwFDzeu8BcyrKm6KZOStVcDxiufowZBzOo
        dm2F5pqc4Neh8kEQS5TYePc=
X-Google-Smtp-Source: APXvYqx1iaXLZPUt5ptofDgqRMSxRJoZOvifJ5ihC4q+WLqO5lStRSNJxpG4M1RpuulboTPNJQXYrg==
X-Received: by 2002:a63:4a5f:: with SMTP id j31mr8743579pgl.369.1554422529248;
        Thu, 04 Apr 2019 17:02:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:251:20c0:100:fe80:8e59:9ae1:e028])
        by smtp.gmail.com with ESMTPSA id p26sm43755664pfa.49.2019.04.04.17.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 17:02:08 -0700 (PDT)
From:   NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: [RFC v2 1/5] clk: mips: ralink: add Ralink MIPS gating clock driver
Date:   Fri,  5 Apr 2019 09:01:25 +0900
Message-Id: <20190405000129.19331-2-drvlabo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405000129.19331-1-drvlabo@gmail.com>
References: <20190405000129.19331-1-drvlabo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This patch adds clock gating driver for Ralink/Mediatek MIPS Socs.

Signed-off-by: NOGUCHI Hiroshi <drvlabo@gmail.com>
---
 drivers/clk/Kconfig      |   6 ++
 drivers/clk/Makefile     |   1 +
 drivers/clk/clk-rt2880.c | 199 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 drivers/clk/clk-rt2880.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index f96c7f39ab7e..dbfdf1bcdc6c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -290,6 +290,12 @@ config COMMON_CLK_BD718XX
 	  This driver supports ROHM BD71837 and ROHM BD71847
 	  PMICs clock gates.
 
+config COMMON_CLK_RT2880
+	bool "Clock driver for Mediatek/Ralink MIPS SoC Family"
+	depends on COMMON_CLK && OF
+	help
+	  This driver support Mediatek/Ralink MIPS SoCs' clock gates.
+
 config COMMON_CLK_FIXED_MMIO
 	bool "Clock driver for Memory Mapped Fixed values"
 	depends on COMMON_CLK && OF
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 1db133652f0c..b1c24b99e848 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
 obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
 obj-$(CONFIG_CLK_QORIQ)			+= clk-qoriq.o
 obj-$(CONFIG_COMMON_CLK_RK808)		+= clk-rk808.o
+obj-$(CONFIG_COMMON_CLK_RT2880)		+= clk-rt2880.o
 obj-$(CONFIG_COMMON_CLK_HI655X)		+= clk-hi655x.o
 obj-$(CONFIG_COMMON_CLK_S2MPS11)	+= clk-s2mps11.o
 obj-$(CONFIG_COMMON_CLK_SCMI)           += clk-scmi.o
diff --git a/drivers/clk/clk-rt2880.c b/drivers/clk/clk-rt2880.c
new file mode 100644
index 000000000000..bcdb4c1486d3
--- /dev/null
+++ b/drivers/clk/clk-rt2880.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 NOGUCHI Hiroshi <drvlabo@gmail.com>
+ */
+
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/platform_device.h>
+
+
+/* clock configuration 1 */
+#define	SYSC_REG_CLKCFG1	0x30
+
+#define GATE_CLK_NUM	32
+
+struct rt2880_gate {
+	struct clk_hw	hw;
+	u8	shift;
+};
+
+#define	to_rt2880_gate(_hw)	container_of(_hw, struct rt2880_gate, hw)
+
+static struct clk_hw_onecell_data *clk_data;
+static struct regmap *syscon_regmap;
+
+static int rt2880_gate_enable(struct clk_hw *hw)
+{
+	struct rt2880_gate *clk_gate = to_rt2880_gate(hw);
+	u32 val = BIT(clk_gate->shift);
+
+	return regmap_update_bits(syscon_regmap, SYSC_REG_CLKCFG1, val, val);
+}
+
+static void rt2880_gate_disable(struct clk_hw *hw)
+{
+	struct rt2880_gate *clk_gate = to_rt2880_gate(hw);
+	u32 val = BIT(clk_gate->shift);
+
+	regmap_update_bits(syscon_regmap, SYSC_REG_CLKCFG1, val, 0);
+}
+
+static int rt2880_gate_is_enabled(struct clk_hw *hw)
+{
+	struct rt2880_gate *clk_gate = to_rt2880_gate(hw);
+	unsigned int rdval;
+
+	if (regmap_read(syscon_regmap, SYSC_REG_CLKCFG1, &rdval))
+		return 0;
+
+	return rdval & BIT(clk_gate->shift);
+}
+
+static const struct clk_ops rt2880_gate_ops = {
+	.enable = rt2880_gate_enable,
+	.disable = rt2880_gate_disable,
+	.is_enabled = rt2880_gate_is_enabled,
+};
+
+static struct clk_hw * __init
+rt2880_register_gate(const char *name, const char *parent_name, u8 shift)
+{
+	struct rt2880_gate	*clk_gate;
+	struct clk_init_data	init;
+	int err;
+	const char *_parent_names[1] = { parent_name };
+
+	clk_gate = kzalloc(sizeof(*clk_gate), GFP_KERNEL);
+	if (!clk_gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &rt2880_gate_ops;
+	init.flags = 0;
+	init.parent_names = parent_name ? _parent_names : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
+	clk_gate->hw.init = &init;
+	clk_gate->shift = shift;
+
+	err = clk_hw_register(NULL, &clk_gate->hw);
+	if (err) {
+		kfree(clk_gate);
+		return ERR_PTR(err);
+	}
+
+	return &clk_gate->hw;
+}
+
+static struct clk_hw *
+rt2880_clk_hw_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct clk_hw_onecell_data *hw_data = data;
+	unsigned int idx = clkspec->args[0];
+	int i;
+
+	if (idx >= GATE_CLK_NUM)
+		goto err;
+
+	for (i = 0; i < hw_data->num; i++)
+		if (idx == to_rt2880_gate(hw_data->hws[i])->shift)
+			break;
+	if (i >= hw_data->num)
+		goto err;
+
+	return hw_data->hws[i];
+
+err:
+	pr_err("%s: invalid index %u\n", __func__, idx);
+	return ERR_PTR(-EINVAL);
+}
+
+static int __init _rt2880_clkctrl_init_dt(struct device_node *np)
+{
+	struct clk_hw *clk_hw;
+	const char *name;
+	const char *parent_name;
+	u32 val;
+	int cnt;
+	int num;
+	int i;
+	int idx;
+
+	syscon_regmap = syscon_regmap_lookup_by_phandle(np, "ralink,sysctl");
+	if (IS_ERR(syscon_regmap)) {
+		pr_err("rt2880-clock: could not get syscon regmap.\n");
+		return PTR_ERR(syscon_regmap);
+	}
+
+	cnt = of_property_count_u32_elems(np, "clock-indices");
+	if (cnt < 0) {
+		pr_err("rt2880-clock: clock-indices property is invalid.\n");
+		return cnt;
+	}
+
+	num = 0;
+	for (i = 0; i < cnt; i++) {
+		if (of_property_read_u32_index(np, "clock-indices", i, &val))
+			break;
+		if (val < GATE_CLK_NUM)
+			num++;
+	}
+	if ((num <= 0) || (num > GATE_CLK_NUM)) {
+		pr_err("rt2880-clock: clock-indices property is invalid.\n");
+		return -EINVAL;
+	}
+
+	clk_data = kzalloc(struct_size(clk_data, hws, num), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+	clk_data->num = num;
+
+	idx = 0;
+	for (i = 0; (i < cnt) && (idx < num); i++) {
+		if (of_property_read_u32_index(np, "clock-indices", i, &val))
+			break;
+		if ((int)val >= GATE_CLK_NUM)
+			continue;
+
+		if (of_property_read_string_index(np, "clock-output-names",
+				i, &name))
+			break;
+
+		parent_name = of_clk_get_parent_name(np, i);
+
+		clk_hw = rt2880_register_gate(name, parent_name, val);
+		if (IS_ERR_OR_NULL(clk_hw)) {
+			pr_err("rt2880-clock: could not register clock for %s\n",
+				name);
+			continue;
+		}
+		clk_data->hws[idx] = clk_hw;
+		idx++;
+	}
+
+	of_clk_add_hw_provider(np, rt2880_clk_hw_get, clk_data);
+
+	return 0;
+}
+
+static int rt2880_clkctrl_probe(struct platform_device *pdev)
+{
+	return _rt2880_clkctrl_init_dt(pdev->dev.of_node);
+}
+
+static const struct of_device_id rt2880_clkctrl_ids[] = {
+	{ .compatible = "ralink,rt2880-clock" },
+	{ }
+};
+
+static struct platform_driver rt2880_clkctrl_driver = {
+	.probe = rt2880_clkctrl_probe,
+	.driver = {
+		.name = "rt2880-clock",
+		.of_match_table = rt2880_clkctrl_ids,
+	},
+};
+builtin_platform_driver(rt2880_clkctrl_driver);
-- 
2.20.1

