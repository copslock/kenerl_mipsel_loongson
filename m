Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 13:03:47 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:48281 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824790Ab3AaMCKp176u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jan 2013 13:02:10 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V3 05/10] MIPS: ralink: adds clkdev code
Date:   Thu, 31 Jan 2013 12:59:16 +0100
Message-Id: <1359633561-4980-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1359633561-4980-1-git-send-email-blogic@openwrt.org>
References: <1359633561-4980-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

These SoCs have a limited number of fixed rate clocks. Add support for the
clk and clkdev api.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/clk.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 arch/mips/ralink/clk.c

diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
new file mode 100644
index 0000000..8dfa22f
--- /dev/null
+++ b/arch/mips/ralink/clk.c
@@ -0,0 +1,72 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clkdev.h>
+#include <linux/clk.h>
+
+#include <asm/time.h>
+
+#include "common.h"
+
+struct clk {
+	struct clk_lookup cl;
+	unsigned long rate;
+};
+
+void ralink_clk_add(const char *dev, unsigned long rate)
+{
+	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
+
+	if (!clk)
+		panic("failed to add clock\n");
+
+	clk->cl.dev_id = dev;
+	clk->cl.clk = clk;
+
+	clk->rate = rate;
+
+	clkdev_add(&clk->cl);
+}
+
+/*
+ * Linux clock API
+ */
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+}
+EXPORT_SYMBOL_GPL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+EXPORT_SYMBOL_GPL(clk_get_rate);
+
+void __init plat_time_init(void)
+{
+	struct clk *clk;
+
+	ralink_of_remap();
+
+	ralink_clk_init();
+	clk = clk_get_sys("cpu", NULL);
+	if (IS_ERR(clk))
+		panic("unable to get CPU clock, err=%ld", PTR_ERR(clk));
+	pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
+	mips_hpt_frequency = clk_get_rate(clk) / 2;
+	clk_put(clk);
+}
-- 
1.7.10.4
