Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 04:57:08 +0100 (CET)
Received: from mail-ob0-f201.google.com ([209.85.214.201]:47358 "EHLO
        mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007206AbbBYD4RdCrqX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 04:56:17 +0100
Received: by mail-ob0-f201.google.com with SMTP id wo20so455389obc.0
        for <linux-mips@linux-mips.org>; Tue, 24 Feb 2015 19:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EW79AifVHrHkP2nMlguaCKwBp8zKgigzGBdMlJAY3e4=;
        b=KTq1CCsilxyT0PK2KPT9yxVjLVk45Yampvo8IsNFvG8wWgAPqCezuaDiU457g0DGu7
         HXVXiNSUnkCEPuZqDyci2QAk9KtHYWqET5e111YRuwPsOvR97dtIeqMGqcCkLd4235cw
         day1ZJM5yB7MITPkA/hnCow/OCjixUyUScYDFZyyCAF06GJ9M5llZnNhIvShPU0UYdQW
         saUMcaxuQe/KlmSciRLQ4y4BcxQyr7HXVvOBdtUh8DjVgA+G7wBkqObLqdjDxu7c4owZ
         Zs2R4VzTHGjw8QdRG26x0a7DuLRB1elvXJIoJpYBRVIJl1l9oxvbzgEKdWgEjQyskYJg
         t9TA==
X-Gm-Message-State: ALoCoQnUZRCC1S5TnfYmhjXg21XFWIJ3YLkg1OBoRJhj4D5lcX0oYeNXjv2LTquvPWQ234T3Fjsb
X-Received: by 10.182.210.227 with SMTP id mx3mr1330599obc.27.1424836572051;
        Tue, 24 Feb 2015 19:56:12 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id 3si1459555yhe.0.2015.02.24.19.56.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2015 19:56:12 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id huzMWDQb.1; Tue, 24 Feb 2015 19:56:11 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id D5271221173; Tue, 24 Feb 2015 19:56:10 -0800 (PST)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 2/7] clk: Add basic infrastructure for Pistachio clocks
Date:   Tue, 24 Feb 2015 19:56:02 -0800
Message-Id: <1424836567-7252-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
References: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Add helpers for registering clocks and clock providers on Pistachio.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clk/Makefile           |   1 +
 drivers/clk/pistachio/Makefile |   1 +
 drivers/clk/pistachio/clk.c    | 140 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/pistachio/clk.h    | 124 ++++++++++++++++++++++++++++++++++++
 4 files changed, 266 insertions(+)
 create mode 100644 drivers/clk/pistachio/Makefile
 create mode 100644 drivers/clk/pistachio/clk.c
 create mode 100644 drivers/clk/pistachio/clk.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d478ceb..e43ff53 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_ARCH_MMP)			+= mmp/
 endif
 obj-$(CONFIG_PLAT_ORION)		+= mvebu/
 obj-$(CONFIG_ARCH_MXS)			+= mxs/
+obj-$(CONFIG_MACH_PISTACHIO)		+= pistachio/
 obj-$(CONFIG_COMMON_CLK_PXA)		+= pxa/
 obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
diff --git a/drivers/clk/pistachio/Makefile b/drivers/clk/pistachio/Makefile
new file mode 100644
index 0000000..fc216ad
--- /dev/null
+++ b/drivers/clk/pistachio/Makefile
@@ -0,0 +1 @@
+obj-y	+= clk.o
diff --git a/drivers/clk/pistachio/clk.c b/drivers/clk/pistachio/clk.c
new file mode 100644
index 0000000..85faa83
--- /dev/null
+++ b/drivers/clk/pistachio/clk.c
@@ -0,0 +1,140 @@
+/*
+ * Copyright (C) 2014 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+struct pistachio_clk_provider *
+pistachio_clk_alloc_provider(struct device_node *node, unsigned int num_clks)
+{
+	struct pistachio_clk_provider *p;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return p;
+
+	p->clk_data.clks = kcalloc(num_clks, sizeof(struct clk *), GFP_KERNEL);
+	if (!p->clk_data.clks)
+		goto free_provider;
+	p->clk_data.clk_num = num_clks;
+	p->node = node;
+	p->base = of_iomap(node, 0);
+	if (!p->base) {
+		pr_err("Failed to map clock provider registers\n");
+		goto free_clks;
+	}
+
+	return p;
+
+free_clks:
+	kfree(p->clk_data.clks);
+free_provider:
+	kfree(p);
+	return NULL;
+}
+
+void pistachio_clk_register_provider(struct pistachio_clk_provider *p)
+{
+	unsigned int i;
+
+	for (i = 0; i < p->clk_data.clk_num; i++) {
+		if (IS_ERR(p->clk_data.clks[i]))
+			pr_warn("Failed to register clock %d: %ld\n", i,
+				PTR_ERR(p->clk_data.clks[i]));
+	}
+
+	of_clk_add_provider(p->node, of_clk_src_onecell_get, &p->clk_data);
+}
+
+void pistachio_clk_register_gate(struct pistachio_clk_provider *p,
+				 struct pistachio_gate *gate,
+				 unsigned int num)
+{
+	struct clk *clk;
+	unsigned int i;
+
+	for (i = 0; i < num; i++) {
+		clk = clk_register_gate(NULL, gate[i].name, gate[i].parent,
+					CLK_SET_RATE_PARENT,
+					p->base + gate[i].reg, gate[i].shift,
+					0, NULL);
+		p->clk_data.clks[gate[i].id] = clk;
+	}
+}
+
+void pistachio_clk_register_mux(struct pistachio_clk_provider *p,
+				struct pistachio_mux *mux,
+				unsigned int num)
+{
+	struct clk *clk;
+	unsigned int i;
+
+	for (i = 0; i < num; i++) {
+		clk = clk_register_mux(NULL, mux[i].name, mux[i].parents,
+				       mux[i].num_parents,
+				       CLK_SET_RATE_NO_REPARENT,
+				       p->base + mux[i].reg, mux[i].shift,
+				       get_count_order(mux[i].num_parents),
+				       0, NULL);
+		p->clk_data.clks[mux[i].id] = clk;
+	}
+}
+
+void pistachio_clk_register_div(struct pistachio_clk_provider *p,
+				struct pistachio_div *div,
+				unsigned int num)
+{
+	struct clk *clk;
+	unsigned int i;
+
+	for (i = 0; i < num; i++) {
+		clk = clk_register_divider(NULL, div[i].name, div[i].parent,
+					   0, p->base + div[i].reg, 0,
+					   div[i].width, div[i].div_flags,
+					   NULL);
+		p->clk_data.clks[div[i].id] = clk;
+	}
+}
+
+void pistachio_clk_register_fixed_factor(struct pistachio_clk_provider *p,
+					 struct pistachio_fixed_factor *ff,
+					 unsigned int num)
+{
+	struct clk *clk;
+	unsigned int i;
+
+	for (i = 0; i < num; i++) {
+		clk = clk_register_fixed_factor(NULL, ff[i].name, ff[i].parent,
+						0, 1, ff[i].div);
+		p->clk_data.clks[ff[i].id] = clk;
+	}
+}
+
+void pistachio_clk_force_enable(struct pistachio_clk_provider *p,
+				unsigned int *clk_ids, unsigned int num)
+{
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < num; i++) {
+		struct clk *clk = p->clk_data.clks[clk_ids[i]];
+
+		if (IS_ERR(clk))
+			continue;
+
+		err = clk_prepare_enable(clk);
+		if (err)
+			pr_err("Failed to enable clock %s: %d\n",
+			       __clk_get_name(clk), err);
+	}
+}
diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
new file mode 100644
index 0000000..e735107
--- /dev/null
+++ b/drivers/clk/pistachio/clk.h
@@ -0,0 +1,124 @@
+/*
+ * Copyright (C) 2014 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#ifndef __PISTACHIO_CLK_H
+#define __PISTACHIO_CLK_H
+
+#include <linux/clk-provider.h>
+
+struct pistachio_gate {
+	unsigned int id;
+	unsigned long reg;
+	unsigned int shift;
+	const char *name;
+	const char *parent;
+};
+
+#define GATE(_id, _name, _pname, _reg, _shift)	\
+	{					\
+		.id	= _id,			\
+		.reg	= _reg,			\
+		.shift	= _shift,		\
+		.name	= _name,		\
+		.parent = _pname,		\
+	}
+
+struct pistachio_mux {
+	unsigned int id;
+	unsigned long reg;
+	unsigned int shift;
+	unsigned int num_parents;
+	const char *name;
+	const char **parents;
+};
+
+#define PNAME(x) static const char *x[] __initconst
+
+#define MUX(_id, _name, _pnames, _reg, _shift)			\
+	{							\
+		.id		= _id,				\
+		.reg		= _reg,				\
+		.shift		= _shift,			\
+		.name		= _name,			\
+		.parents	= _pnames,			\
+		.num_parents	= ARRAY_SIZE(_pnames)		\
+	}
+
+
+struct pistachio_div {
+	unsigned int id;
+	unsigned long reg;
+	unsigned int width;
+	unsigned int div_flags;
+	const char *name;
+	const char *parent;
+};
+
+#define DIV(_id, _name, _pname, _reg, _width)			\
+	{							\
+		.id		= _id,				\
+		.reg		= _reg,				\
+		.width		= _width,			\
+		.div_flags	= 0,				\
+		.name		= _name,			\
+		.parent		= _pname,			\
+	}
+
+#define DIV_F(_id, _name, _pname, _reg, _width, _div_flags)	\
+	{							\
+		.id		= _id,				\
+		.reg		= _reg,				\
+		.width		= _width,			\
+		.div_flags	= _div_flags,			\
+		.name		= _name,			\
+		.parent		= _pname,			\
+	}
+
+struct pistachio_fixed_factor {
+	unsigned int id;
+	unsigned int div;
+	const char *name;
+	const char *parent;
+};
+
+#define FIXED_FACTOR(_id, _name, _pname, _div)			\
+	{							\
+		.id		= _id,				\
+		.div		= _div,				\
+		.name		= _name,			\
+		.parent		= _pname,			\
+	}
+
+struct pistachio_clk_provider {
+	struct device_node *node;
+	void __iomem *base;
+	struct clk_onecell_data clk_data;
+};
+
+extern struct pistachio_clk_provider *
+pistachio_clk_alloc_provider(struct device_node *node, unsigned int num_clks);
+extern void pistachio_clk_register_provider(struct pistachio_clk_provider *p);
+
+extern void pistachio_clk_register_gate(struct pistachio_clk_provider *p,
+					struct pistachio_gate *gate,
+					unsigned int num);
+extern void pistachio_clk_register_mux(struct pistachio_clk_provider *p,
+				       struct pistachio_mux *mux,
+				       unsigned int num);
+extern void pistachio_clk_register_div(struct pistachio_clk_provider *p,
+				       struct pistachio_div *div,
+				       unsigned int num);
+extern void
+pistachio_clk_register_fixed_factor(struct pistachio_clk_provider *p,
+				    struct pistachio_fixed_factor *ff,
+				    unsigned int num);
+
+extern void pistachio_clk_force_enable(struct pistachio_clk_provider *p,
+				       unsigned int *clk_ids, unsigned int num);
+
+#endif
-- 
2.2.0.rc0.207.ga3a616c
