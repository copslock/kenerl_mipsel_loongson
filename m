Return-Path: <SRS0=U4pd=SB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A172AC43381
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 12:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C682184D
	for <linux-mips@archiver.kernel.org>; Sat, 30 Mar 2019 12:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUwfST6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfC3MeI (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:34:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36426 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730698AbfC3MeI (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 30 Mar 2019 08:34:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id ck15so1072187plb.3;
        Sat, 30 Mar 2019 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isu5VQ34+sdjdJ+Eph/J4EP5uPnHlo+onoUCNRiEn+M=;
        b=EUwfST6EOS2I/8L/meeGkw9mRJOPzqpGnbyvX7r324QvL8DMcqmubox4dF8UbB0vd7
         qPKJtqoXwh/wvN1aTUlVuUSTOfYojB3v5Q3kSwTMMpSgkXx5aiKGb8kS3HvTpLLfR+9F
         452pWT9Hdvgd7pji00Y0pf8Kh7FvtAIytqAUlRQDm+ePvbTgmUHA1IaS7lzTKNbhElea
         Akjrye247/un2JW2cCvwyjBuqmdWaxShAASzpsnkZNymtAgfxnhEvIoFv7lZf4kGEhb0
         h+GZbpT7k4xow++pgWe55sA5BzuDaKEZ6UbQAzcembTZwCWw5SmztU6wmETXL4ztey+Z
         8dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isu5VQ34+sdjdJ+Eph/J4EP5uPnHlo+onoUCNRiEn+M=;
        b=C0s2ldu6NwMsyxjqNK02OW+uYDnRtmSAZplGbCixDOjsFVZcqtJLd8/JKKPog8IErK
         j3WcnXGouRUKmAhNm5HUfB9fwbOVQjmT3P3FlS2hqhWK/mlJ5Hp2zOX4jrrqJ4tsxzwT
         kUdNfQGjSkf2/Fdxj++34unfLe6dh4UTzZlI4l8uhBdx9RBfUJnMaNsJXYKdmY1rh++j
         jn0jhMJHrDvv5Oshd7wHPnlu6/+Kb/gT4BOdX4dNpAMr3v+UxcOSq4qbi6HJSDs6XFyr
         XxxZyL81sRLqo3OODHYSm/2Cpq5Tc+7RsC26J4vE1NbaisDE236jCMVu9+Zzqq2VicQG
         jaiw==
X-Gm-Message-State: APjAAAV9JDTpXDRCuLc+OtlL+Ecy0Ztc6vTapfCXsIPgt+6hU3TXt+ye
        HT9y6rxlzhOL4uhV8jvkc/A=
X-Google-Smtp-Source: APXvYqxtZSi0bjs2mY82SiGhV5xJGL4VnX/6GJXss1T9K2XlmOU8qs0uklR2aSosJ7feh83ismOqjw==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr53647780ply.41.1553949247675;
        Sat, 30 Mar 2019 05:34:07 -0700 (PDT)
Received: from localhost.localdomain ([2409:251:20c0:100:fe80:8e59:9ae1:e028])
        by smtp.gmail.com with ESMTPSA id m23sm7864309pfa.117.2019.03.30.05.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 05:34:07 -0700 (PDT)
From:   NOGUCHI Hiroshi <drvlabo@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        NOGUCHI Hiroshi <drvlabo@gmail.com>
Subject: [RFC 1/5] mips: ralink: add rt2880-clock driver
Date:   Sat, 30 Mar 2019 21:33:13 +0900
Message-Id: <20190330123317.16821-2-drvlabo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190330123317.16821-1-drvlabo@gmail.com>
References: <20190330123317.16821-1-drvlabo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This patch adds SoC peripheral clock gating driver.
The driver loads gating clock table from of_device_id.data in individual SoC sources.

Signed-off-by: NOGUCHI Hiroshi <drvlabo@gmail.com>
---
 arch/mips/ralink/rt2880-clk_internal.h |  21 ++++
 arch/mips/ralink/rt2880-clock.c        | 134 +++++++++++++++++++++++++
 2 files changed, 155 insertions(+)
 create mode 100644 arch/mips/ralink/rt2880-clk_internal.h
 create mode 100644 arch/mips/ralink/rt2880-clock.c

diff --git a/arch/mips/ralink/rt2880-clk_internal.h b/arch/mips/ralink/rt2880-clk_internal.h
new file mode 100644
index 000000000000..9d5dded16a80
--- /dev/null
+++ b/arch/mips/ralink/rt2880-clk_internal.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 NOGUCHI Hiroshi <drvlabo@gmail.com>
+ */
+
+#ifndef __RT2880_CLOCK_INTERNAL_H
+
+
+#define GATE_CLK_NUM	(32)
+
+struct gate_clk_desc {
+	const char *name;
+	const char *parent_name;
+};
+
+extern const struct of_device_id __initconst of_match_rt2880_clk[];
+
+
+#endif
+
+
diff --git a/arch/mips/ralink/rt2880-clock.c b/arch/mips/ralink/rt2880-clock.c
new file mode 100644
index 000000000000..46cc067225ab
--- /dev/null
+++ b/arch/mips/ralink/rt2880-clock.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 NOGUCHI Hiroshi <drvlabo@gmail.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/bug.h>
+
+#include "rt2880-clk_internal.h"
+
+
+/* clock configuration 1 */
+#define	SYSC_REG_CLKCFG1	0x30
+
+struct rt2880_gate {
+	struct clk_hw	hw;
+	u8	shift;
+};
+
+#define	to_rt2880_gate(_hw)	container_of(_hw, struct rt2880_gate, hw)
+
+static struct clk_onecell_data	clk_data;
+static struct clk *clks[GATE_CLK_NUM];
+
+static struct regmap *syscon_regmap;
+
+static int rt2880_gate_enable(struct clk_hw *hw)
+{
+	struct rt2880_gate *clk_gate = to_rt2880_gate(hw);
+	u32 val = 0x01UL << clk_gate->shift;
+
+	regmap_update_bits(syscon_regmap, SYSC_REG_CLKCFG1, val, val);
+
+	return 0;
+}
+
+static void rt2880_gate_disable(struct clk_hw *hw)
+{
+	struct rt2880_gate *clk_gate = to_rt2880_gate(hw);
+	u32 val = 0x01UL << clk_gate->shift;
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
+	return (!!(rdval & (0x01UL << clk_gate->shift)));
+}
+
+static const struct clk_ops rt2880_gate_ops = {
+	.enable = rt2880_gate_enable,
+	.disable = rt2880_gate_disable,
+	.is_enabled = rt2880_gate_is_enabled,
+};
+
+static struct clk * __init
+rt2880_register_gate(const char *name, const char *parent_name, u8 shift)
+{
+	struct rt2880_gate	*clk_gate;
+	struct clk		*clk;
+	struct clk_init_data	init;
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
+	clk = clk_register(NULL, &clk_gate->hw);
+	if (IS_ERR(clk))
+		kfree(clk_gate);
+
+	return clk;
+}
+
+static void __init rt2880_clkctrl_init_dt(struct device_node *np)
+{
+	struct clk *clk;
+	int i;
+	const struct of_device_id *match;
+	struct gate_clk_desc *clk_tbl;
+
+	match = of_match_node(of_match_rt2880_clk, np);
+	if (!match) {
+		pr_info("rt2880-clock: could not get compatible node");
+		return;
+	}
+	clk_tbl = (struct gate_clk_desc *)match->data;
+
+	syscon_regmap = syscon_regmap_lookup_by_phandle(np, "ralink,sysctl");
+	if (IS_ERR(syscon_regmap)) {
+		pr_info("rt2880-clock: could not get syscon regmap");
+		return;
+	}
+
+	clk_data.clk_num = GATE_CLK_NUM;
+	clk_data.clks = clks;
+
+	for (i = 0; i < GATE_CLK_NUM; i++) {
+		if (clk_tbl[i].name) {
+			clk = rt2880_register_gate(
+				clk_tbl[i].name, clk_tbl[i].parent_name, i);
+			if (IS_ERR_OR_NULL(clk))
+				panic("rt2880-clock : could not register gate clock");
+			clk_data.clks[i] = clk;
+		}
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+}
+CLK_OF_DECLARE(rt2880, "ralink,rt2880-clock", rt2880_clkctrl_init_dt);
-- 
2.20.1

