Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 21:54:32 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:56896 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008007AbbK3UybI3hDw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2015 21:54:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=yTFobUbISIEI3Jp5X/Gl0J3vQgFmR62iMMnVCsDe6fQ=;
        b=HgX9036ME1SNVAoCyAOGLEDPmugdX1FpDDOYjggMC1mjacYa0FlWGS6kRJ6WqVuWgRYjwd1ao9fq6BxpGHT5NN0/H5EecPLM7NTnZQDlLxTeUzDP5dq2Mm0+fLVBf4ZJR1e48ANuD5XCkR/geZyjQ12ojdsuTxhqdcczbJlymjtvNCPvJqgSVqNj3fYU/6EYDhR/V1dR0Iy4cdrnPKiJz5ldXZjWI2pR5rJLWL3qOI2OeSruJ0NM2dSbf+r3cHpwI1msKr35lHAnByiOt6Z6jB59K37S6j7D3d8PG6Ow4tUe1bIyrNvOyYSHTKUBwyh5DkBODeww+IvtJtb0TkgBVQ==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:43539 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a3VSr-0001sC-HO (Exim); Mon, 30 Nov 2015 20:54:25 +0000
Subject: [PATCH 2/2] clk: bcm63xx: Add BCM63xx gated clock support
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <565CB727.7030209@simon.arlott.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <565CB780.3010206@simon.arlott.org.uk>
Date:   Mon, 30 Nov 2015 20:54:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <565CB727.7030209@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

The BCM63xx contains clocks gated with a register. Clocks are indexed
by bits in the register and are active high. Clock gate bits are
interleaved with other status bits and configurable clocks in the same
register.

Enabled by default for BMIPS_GENERIC.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 MAINTAINERS                   |   1 +
 drivers/clk/bcm/Kconfig       |   8 ++
 drivers/clk/bcm/Makefile      |   1 +
 drivers/clk/bcm/clk-bcm63xx.c | 187 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 197 insertions(+)
 create mode 100644 drivers/clk/bcm/clk-bcm63xx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 29e0589..07613dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2373,6 +2373,7 @@ F:	arch/mips/bmips/*
 F:	arch/mips/include/asm/mach-bmips/*
 F:	arch/mips/kernel/*bmips*
 F:	arch/mips/boot/dts/brcm/bcm*.dts*
+F:	drivers/clk/bcm/clk-bcm63*
 F:	drivers/irqchip/irq-bcm63*
 F:	drivers/irqchip/irq-bcm7*
 F:	drivers/irqchip/irq-brcmstb*
diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
index 85260fb..b9c5464 100644
--- a/drivers/clk/bcm/Kconfig
+++ b/drivers/clk/bcm/Kconfig
@@ -14,3 +14,11 @@ config COMMON_CLK_IPROC
 	help
 	  Enable common clock framework support for Broadcom SoCs
 	  based on the iProc architecture
+
+config CLK_BCM63XX
+	bool "Broadcom BCM63xx clock support"
+	depends on BMIPS_GENERIC
+	depends on COMMON_CLK
+	default y
+	help
+	  Enable clock framework support for Broadcom 63xx SoCs
diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
index 3fc9506..4f5f8ce 100644
--- a/drivers/clk/bcm/Makefile
+++ b/drivers/clk/bcm/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-ns2.o
 obj-$(CONFIG_ARCH_BCM_CYGNUS)	+= clk-cygnus.o
 obj-$(CONFIG_ARCH_BCM_NSP)	+= clk-nsp.o
 obj-$(CONFIG_ARCH_BCM_5301X)	+= clk-nsp.o
+obj-$(CONFIG_CLK_BCM63XX)	+= clk-bcm63xx.o
diff --git a/drivers/clk/bcm/clk-bcm63xx.c b/drivers/clk/bcm/clk-bcm63xx.c
new file mode 100644
index 0000000..0e8cc06
--- /dev/null
+++ b/drivers/clk/bcm/clk-bcm63xx.c
@@ -0,0 +1,187 @@
+/*
+ * Copyright 2015 Simon Arlott
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Based on clk-gate.c:
+ * Copyright (C) 2010-2011 Canonical Ltd <jeremy.kerr@canonical.com>
+ * Copyright (C) 2011-2012 Mike Turquette, Linaro Ltd <mturquette@linaro.org>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+#include <linux/resource.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+/**
+ * DOC: Basic clock which uses a bit in a regmap to gate and ungate the output
+ *
+ * Traits of this clock:
+ * prepare - clk_(un)prepare only ensures parent is (un)prepared
+ * enable - clk_enable and clk_disable are functional & control gating
+ * rate - inherits rate from parent.  No clk_set_rate support
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+struct clk_bcm63xx {
+	struct clk_hw hw;
+	struct regmap *map;
+	u32 offset;
+	u32 mask;
+};
+
+#define to_clk_bcm63xx(_hw) container_of(_hw, struct clk_bcm63xx, hw)
+
+static int clk_bcm63xx_enable(struct clk_hw *hw)
+{
+	struct clk_bcm63xx *gate = to_clk_bcm63xx(hw);
+
+	return regmap_write_bits(gate->map, gate->offset,
+					gate->mask, gate->mask);
+}
+
+static void clk_bcm63xx_disable(struct clk_hw *hw)
+{
+	struct clk_bcm63xx *gate = to_clk_bcm63xx(hw);
+
+	regmap_write_bits(gate->map, gate->offset,
+					gate->mask, 0);
+}
+
+static int clk_bcm63xx_is_enabled(struct clk_hw *hw)
+{
+	struct clk_bcm63xx *gate = to_clk_bcm63xx(hw);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(gate->map, gate->offset, &val);
+	if (ret)
+		return ret;
+
+	val &= gate->mask;
+
+	return val ? 1 : 0;
+}
+
+const struct clk_ops clk_bcm63xx_ops = {
+	.enable = clk_bcm63xx_enable,
+	.disable = clk_bcm63xx_disable,
+	.is_enabled = clk_bcm63xx_is_enabled,
+};
+
+static struct clk * __init of_bcm63xx_clk_register(const char *parent_name,
+	const char *clk_name, struct regmap *map, u32 offset, u32 mask)
+{
+	struct clk_bcm63xx *gate;
+	struct clk_init_data init;
+	struct clk *ret;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = clk_name;
+	init.ops = &clk_bcm63xx_ops;
+	init.flags = CLK_IS_BASIC;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+	gate->hw.init = &init;
+	gate->map = map;
+	gate->offset = offset;
+	gate->mask = mask;
+
+	ret = clk_register(NULL, &gate->hw);
+	if (IS_ERR(ret))
+		kfree(gate);
+
+	return ret;
+}
+
+static void __init of_bcm63xx_clk_setup(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	const char *parent_name = NULL;
+	struct regmap *map;
+	u32 offset;
+	unsigned int clocks = 0;
+	int i;
+
+	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return;
+
+	clk_data->clk_num = 32;
+	clk_data->clks = kmalloc_array(clk_data->clk_num,
+		sizeof(*clk_data->clks), GFP_KERNEL);
+
+	for (i = 0; i < clk_data->clk_num; i++)
+		clk_data->clks[i] = ERR_PTR(-ENODEV);
+
+	if (of_clk_get_parent_count(node) > 0)
+		parent_name = of_clk_get_parent_name(node, 0);
+
+	map = syscon_regmap_lookup_by_phandle(node, "regmap");
+	if (IS_ERR(map)) {
+		pr_err("%s: regmap lookup error %ld\n",
+			node->full_name, PTR_ERR(map));
+		goto out;
+	}
+
+	if (of_property_read_u32(node, "offset", &offset)) {
+		pr_err("%s: offset not specified\n", node->full_name);
+		goto out;
+	}
+
+	/* clks[] is sparse, indexed by bit, maximum clocks checked using i */
+	for (i = 0; i < clk_data->clk_num; i++) {
+		u32 bit;
+		const char *clk_name;
+
+		if (of_property_read_u32_index(node, "clock-indices",
+				i, &bit))
+			goto out;
+
+		if (of_property_read_string_index(node, "clock-output-names",
+				i, &clk_name))
+			goto out;
+
+		if (bit >= clk_data->clk_num) {
+			pr_err("%s: clock bit %u out of range\n",
+				node->full_name, bit);
+			continue;
+		}
+
+		if (!IS_ERR(clk_data->clks[bit])) {
+			pr_err("%s: clock bit %u already exists\n",
+				node->full_name, bit);
+			continue;
+		}
+
+		clk_data->clks[bit] = of_bcm63xx_clk_register(parent_name,
+					clk_name, map, offset, BIT(bit));
+		if (!IS_ERR(clk_data->clks[bit]))
+			clocks++;
+	}
+
+out:
+	if (clocks) {
+		of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+		pr_info("%s: registered %u clocks\n", node->name, clocks);
+	} else {
+		kfree(clk_data->clks);
+		kfree(clk_data);
+	}
+}
+
+CLK_OF_DECLARE(bcm63xx_clk, "brcm,bcm63xx-gate-clk", of_bcm63xx_clk_setup);
-- 
2.1.4

-- 
Simon Arlott
