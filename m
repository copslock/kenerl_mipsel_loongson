Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2015 22:51:14 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:50507 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013666AbbLJVvMjGjUJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Dec 2015 22:51:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=XoLKrrSmmoz3cmRtDv+SZS8mwMmzr5ElxQgjpfIM+B0=;
        b=Tbc4G1troGVnvupg4QvoEhb5CWtQ/TSh1Qd2IWHIgqn1sMBR917noSqi82EnYStf1TR4GCZ1IFZ31TJWqpUHeg96ZuXdAVq45RFxKXsFBxqs8nFTP2woFBsiKFbq2wzgPZE21Aw/rGHa5y6VkxtD4FnS11PxYNJaA4T4B9V350bJsKW6M38W+vs2TPvq/miOZVL9xLv03sD7jIbY9IBtYkucqOCWvwXcMfqot0RYT6+rU3ohrYFQ8swxurAuPNXtNhAefsKMT4N80A8W/qPbK48uT+5miH01TqmvqOGX+6mGLnQebgWWlE22Vh7Fn2+hn/e/LSo32g4BFkGlmx1iSA==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:60777 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a7978-0000kx-ST (Exim); Thu, 10 Dec 2015 21:51:04 +0000
Subject: [PATCH linux-next (v2) 2/2] clk: bcm6345: Add BCM6345 gated clock
 support
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <5669F361.60405@simon.arlott.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jonas Gorski <jogo@openwrt.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <5669F3C3.3090207@simon.arlott.org.uk>
Date:   Thu, 10 Dec 2015 21:50:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <5669F361.60405@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50534
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

The BCM6345 contains clocks gated with a register. Clocks are indexed
by bits in the register and are active high. Most MIPS-based BCM63xx
SoCs have a clock gating set of registers, but some have clock gate bits
interleaved with other status bits and configurable clocks in the same
register.

Enabled by default for BMIPS_GENERIC.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
v2: Resend, no changes.

v1: Renamed from BCM63xx to BCM6345.

 MAINTAINERS                   |   1 +
 drivers/clk/bcm/Kconfig       |   9 ++
 drivers/clk/bcm/Makefile      |   1 +
 drivers/clk/bcm/clk-bcm6345.c | 191 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 202 insertions(+)
 create mode 100644 drivers/clk/bcm/clk-bcm6345.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ac17b0..9b54ddc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2389,6 +2389,7 @@ F:	arch/mips/bmips/*
 F:	arch/mips/include/asm/mach-bmips/*
 F:	arch/mips/kernel/*bmips*
 F:	arch/mips/boot/dts/brcm/bcm*.dts*
+F:	drivers/clk/bcm/clk-bcm6345*
 F:	drivers/irqchip/irq-bcm63*
 F:	drivers/irqchip/irq-bcm7*
 F:	drivers/irqchip/irq-brcmstb*
diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
index f287845..043353a 100644
--- a/drivers/clk/bcm/Kconfig
+++ b/drivers/clk/bcm/Kconfig
@@ -8,6 +8,15 @@ config CLK_BCM_63XX
 	  Enable common clock framework support for Broadcom BCM63xx DSL SoCs
 	  based on the ARM architecture
 
+config CLK_BCM_6345
+	bool "Broadcom BCM6345 clock support"
+	depends on BMIPS_GENERIC || COMPILE_TEST
+	depends on COMMON_CLK
+	default BMIPS_GENERIC
+	help
+	  Enable common clock framework support for Broadcom BCM6345 DSL SoCs
+	  based on the MIPS architecture
+
 config CLK_BCM_KONA
 	bool "Broadcom Kona CCU clock support"
 	depends on ARCH_BCM_MOBILE || COMPILE_TEST
diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
index 247c267..e2bac43 100644
--- a/drivers/clk/bcm/Makefile
+++ b/drivers/clk/bcm/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_CLK_BCM_63XX)	+= clk-bcm63xx.o
+obj-$(CONFIG_CLK_BCM_6345)	+= clk-bcm6345.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-kona.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-kona-setup.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm281xx.o
diff --git a/drivers/clk/bcm/clk-bcm6345.c b/drivers/clk/bcm/clk-bcm6345.c
new file mode 100644
index 0000000..88a1e7e
--- /dev/null
+++ b/drivers/clk/bcm/clk-bcm6345.c
@@ -0,0 +1,191 @@
+/*
+ * Copyright 2015 Simon Arlott
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Derived from clk-gate.c:
+ * Copyright (C) 2010-2011 Canonical Ltd <jeremy.kerr@canonical.com>
+ * Copyright (C) 2011-2012 Mike Turquette, Linaro Ltd <mturquette@linaro.org>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
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
+struct clk_bcm6345 {
+	struct clk_hw hw;
+	struct regmap *map;
+	u32 offset;
+	u32 mask;
+};
+
+#define to_clk_bcm6345(_hw) container_of(_hw, struct clk_bcm6345, hw)
+
+static int clk_bcm6345_enable(struct clk_hw *hw)
+{
+	struct clk_bcm6345 *gate = to_clk_bcm6345(hw);
+
+	return regmap_write_bits(gate->map, gate->offset,
+					gate->mask, gate->mask);
+}
+
+static void clk_bcm6345_disable(struct clk_hw *hw)
+{
+	struct clk_bcm6345 *gate = to_clk_bcm6345(hw);
+
+	regmap_write_bits(gate->map, gate->offset,
+					gate->mask, 0);
+}
+
+static int clk_bcm6345_is_enabled(struct clk_hw *hw)
+{
+	struct clk_bcm6345 *gate = to_clk_bcm6345(hw);
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
+const struct clk_ops clk_bcm6345_ops = {
+	.enable = clk_bcm6345_enable,
+	.disable = clk_bcm6345_disable,
+	.is_enabled = clk_bcm6345_is_enabled,
+};
+
+static struct clk * __init of_bcm6345_clk_register(const char *parent_name,
+	const char *clk_name, struct regmap *map, u32 offset, u32 mask)
+{
+	struct clk_bcm6345 *gate;
+	struct clk_init_data init;
+	struct clk *ret;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = clk_name;
+	init.ops = &clk_bcm6345_ops;
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
+static void __init of_bcm6345_clk_setup(struct device_node *node)
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
+		clk_data->clks[bit] = of_bcm6345_clk_register(parent_name,
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
+CLK_OF_DECLARE(bcm6345_clk, "brcm,bcm6345-gate-clk", of_bcm6345_clk_setup);
-- 
2.1.4

-- 
Simon Arlott
