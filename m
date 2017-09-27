Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2017 17:16:51 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:33532
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992214AbdI0PQJn1Jol (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2017 17:16:09 +0200
Received: by mail-pf0-x244.google.com with SMTP id h4so7054827pfk.0;
        Wed, 27 Sep 2017 08:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Bqg1Th4sQTNjs1lFaF2kgvRxMTuRMITAjpi88bfsXI=;
        b=d3GTXq9kPvTf01jCpf0qh37eWfLA9EFRDOKBf6LSU51QzJUDMlmQQD7ezEWvxoAV2/
         +MR8xtBbSkbKzqbTawXjakF4zjcXz7587eqGiIRkSNFskAWAOsuphtZSQXoaGOWYe1Jh
         Umg9Fjk6G5gLlhyUQcHmU73hBBffE+qWwq6V3DxrZiY1L4BHCjTEKE/qbtU4guB8M1bj
         sZj3ViXtABIh2d8Ea3Xi7SHs5cO8+94d9hpU5gJhsbT7uYQMe0pIthba/HqWYncyhheV
         6IwfynNOwKIcmTMnQhMWJqnv68SkIFM+Blb+5/UkmBj9lPOAe2Z/Cc2M32o6xzdlxLZc
         woIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Bqg1Th4sQTNjs1lFaF2kgvRxMTuRMITAjpi88bfsXI=;
        b=a6W726xxghIhjbcbtV1j8OUHgI5i6lFDpow1pK/vTvkl/bdrjAiCspTuPPUi49b3zS
         4045Y/i4BUlGAADmWcMOOw1ByxeQX4UeQwp+Wo1sHq/fFVjnQsPrTzmM0cSIx8bOUCQA
         26IFXSnhcnjls5Qlu2xBMyWqMcQQ8L/L511dDj6BGqCHaECUkRW9cDTsvsB+nCtDSxK8
         IRH4j1wLSV3rSZaYnc77u+Paz8MfuOw3+VzqUba6nCVTb7Qlkr4IUCoeyPVeMwn4bxnN
         cgZNtxezIXTJvG5a8EMFEZrPY3lWA3CECfGGkgE8YpIA/bl28BpibqDarj0j7jU1nQrb
         uRpA==
X-Gm-Message-State: AHPjjUiXinK3jxjOTFP6DWH87nLFIuoelDINcQMSn09aziQs0H9vwDUv
        n7udSGeAYhqS5ecsdgsdTnU=
X-Google-Smtp-Source: AOwi7QAW+29Z4NRl9OMMgU9GwazFmpCNJf+W446QyfYkdnmQGhqmbTprBevaKc+4oy41zypfPh8Nuw==
X-Received: by 10.84.132.34 with SMTP id 31mr1516342ple.225.1506525363459;
        Wed, 27 Sep 2017 08:16:03 -0700 (PDT)
Received: from linux.local ([42.109.141.25])
        by smtp.gmail.com with ESMTPSA id b65sm21289624pfj.97.2017.09.27.08.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 08:16:02 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, malat@debian.org, dom.peklo@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [RFC 2/4] clk: Add Ingenic X1000 CGU driver
Date:   Wed, 27 Sep 2017 20:45:25 +0530
Message-Id: <20170927151527.25570-3-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Add support for the clocks provided by CGU in Ingenic X1000 SoC.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 drivers/clk/ingenic/Makefile    |   1 +
 drivers/clk/ingenic/x1000-cgu.c | 203 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+)
 create mode 100644 drivers/clk/ingenic/x1000-cgu.c

diff --git a/drivers/clk/ingenic/Makefile b/drivers/clk/ingenic/Makefile
index cd47b06..89c665b 100644
--- a/drivers/clk/ingenic/Makefile
+++ b/drivers/clk/ingenic/Makefile
@@ -1,3 +1,4 @@
 obj-y				+= cgu.o
 obj-$(CONFIG_MACH_JZ4740)	+= jz4740-cgu.o
 obj-$(CONFIG_MACH_JZ4780)	+= jz4780-cgu.o
+obj-$(CONFIG_MACH_X1000)	+= x1000-cgu.o
diff --git a/drivers/clk/ingenic/x1000-cgu.c b/drivers/clk/ingenic/x1000-cgu.c
new file mode 100644
index 0000000..a228688
--- /dev/null
+++ b/drivers/clk/ingenic/x1000-cgu.c
@@ -0,0 +1,203 @@
+/*
+ * Ingenic X1000 SoC CGU driver
+ *
+ * Copyright (c) 2016 PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <dt-bindings/clock/x1000-cgu.h>
+#include "cgu.h"
+
+/* CGU register offsets */
+#define CGU_REG_CLOCKCONTROL	0x00
+#define CGU_REG_APLL		0x10
+#define CGU_REG_MPLL		0x14
+
+/* CLKGR0, OPCR are not defined in X1000, JZ4780 PM so assuming them to be correct */
+#define CGU_REG_CLKGR0		0x20
+#define CGU_REG_OPCR		0x24
+#define CGU_REG_CLKGR1		0x28
+#define CGU_REG_DDRCDR		0x2c
+
+/* bits within the OPCR register */
+#define OPCR_SPENDN0		(1 << 7)
+#define OPCR_SPENDN1		(1 << 6)
+
+static struct ingenic_cgu *cgu;
+
+static const s8 pll_od_encoding[16] = {
+	0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
+	0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf,
+};
+
+static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
+
+	/* External clocks */
+
+	[X1000_CLK_EXCLK] = { "ext", CGU_CLK_EXT },
+	[X1000_CLK_RTCLK] = { "rtc", CGU_CLK_EXT },
+
+	/* PLLs */
+
+#define DEF_PLL(name) { \
+	.reg = CGU_REG_ ## name, \
+	.m_shift = 19, \
+	.m_bits = 13, \
+	.m_offset = 1, \
+	.n_shift = 13, \
+	.n_bits = 6, \
+	.n_offset = 1, \
+	.od_shift = 9, \
+	.od_bits = 4, \
+	.od_max = 16, \
+	.od_encoding = pll_od_encoding, \
+	.stable_bit = 6, \
+	.bypass_bit = 1, \
+	.enable_bit = 0, \
+}
+
+	[X1000_CLK_APLL] = {
+		"apll", CGU_CLK_PLL,
+		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.pll = DEF_PLL(APLL),
+	},
+
+	[X1000_CLK_MPLL] = {
+		"mpll", CGU_CLK_PLL,
+		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.pll = DEF_PLL(MPLL),
+	},
+
+#undef DEF_PLL
+
+	/* Muxes & dividers */
+
+	[X1000_CLK_SCLKA] = {
+		"sclk_a", CGU_CLK_MUX,
+		.parents = { -1, X1000_CLK_APLL, X1000_CLK_EXCLK,
+			     X1000_CLK_RTCLK },
+		.mux = { CGU_REG_CLOCKCONTROL, 30, 2 },
+	},
+
+	[X1000_CLK_CPUMUX] = {
+		"cpumux", CGU_CLK_MUX,
+		.parents = { -1, X1000_CLK_SCLKA, X1000_CLK_MPLL,
+			     -1 },
+		.mux = { CGU_REG_CLOCKCONTROL, 28, 2 },
+	},
+
+	[X1000_CLK_CPU] = {
+		"cpu", CGU_CLK_DIV,
+		.parents = { X1000_CLK_CPUMUX, -1, -1, -1 },
+		.div = { CGU_REG_CLOCKCONTROL, 0, 1, 4, 22, -1, -1 },
+	},
+
+	[X1000_CLK_L2CACHE] = {
+		"l2cache", CGU_CLK_DIV,
+		.parents = { X1000_CLK_CPUMUX, -1, -1, -1 },
+		.div = { CGU_REG_CLOCKCONTROL, 4, 1, 4, -1, -1, -1 },
+	},
+
+	[X1000_CLK_AHB0] = {
+		"ahb0", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { -1, X1000_CLK_SCLKA, X1000_CLK_MPLL,
+			     -1 },
+		.mux = { CGU_REG_CLOCKCONTROL, 26, 2 },
+		.div = { CGU_REG_CLOCKCONTROL, 8, 1, 4, 21, -1, -1 },
+	},
+
+	[X1000_CLK_AHB2PMUX] = {
+		"ahb2_apb_mux", CGU_CLK_MUX,
+		.parents = { -1, X1000_CLK_SCLKA, X1000_CLK_MPLL,
+			     X1000_CLK_RTCLK },
+		.mux = { CGU_REG_CLOCKCONTROL, 24, 2 },
+	},
+
+	[X1000_CLK_AHB2] = {
+		"ahb2", CGU_CLK_DIV,
+		.parents = { X1000_CLK_AHB2PMUX, -1, -1, -1 },
+		.div = { CGU_REG_CLOCKCONTROL, 12, 1, 4, 20, -1, -1 },
+	},
+
+	[X1000_CLK_PCLK] = {
+		"pclk", CGU_CLK_DIV,
+		.parents = { X1000_CLK_AHB2PMUX, -1, -1, -1 },
+		.div = { CGU_REG_CLOCKCONTROL, 16, 1, 4, 20, -1, -1 },
+	},
+
+	[X1000_CLK_DDR] = {
+		"ddr", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { -1, X1000_CLK_SCLKA, X1000_CLK_MPLL, -1 },
+		.mux = { CGU_REG_DDRCDR, 30, 2 },
+		.div = { CGU_REG_DDRCDR, 0, 1, 4, 29, 28, 27 },
+	},
+
+	/* Gate-only clocks */
+
+	[X1000_CLK_UART0] = {
+		"uart0", CGU_CLK_GATE,
+		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR0, 15 },
+	},
+
+	[X1000_CLK_UART1] = {
+		"uart1", CGU_CLK_GATE,
+		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR0, 16 },
+	},
+
+	[X1000_CLK_UART2] = {
+		"uart2", CGU_CLK_GATE,
+		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR0, 17 },
+	},
+
+	[X1000_CLK_PDMA] = {
+		"pdma", CGU_CLK_GATE,
+		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR0, 21 },
+	},
+
+	[X1000_CLK_DDR0] = {
+		"ddr0", CGU_CLK_GATE,
+		.parents = { X1000_CLK_DDR, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR0, 30 },
+	},
+
+	[X1000_CLK_DDR1] = {
+		"ddr1", CGU_CLK_GATE,
+		.parents = { X1000_CLK_DDR, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR0, 31 },
+	},
+
+	[X1000_CLK_CORE1] = {
+		"core1", CGU_CLK_GATE,
+		.parents = { X1000_CLK_CPU, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR1, 15 },
+	},
+};
+
+static void __init x1000_cgu_init(struct device_node *np)
+{
+	int retval;
+
+	cgu = ingenic_cgu_new(x1000_cgu_clocks,
+			      ARRAY_SIZE(x1000_cgu_clocks), np);
+	if (!cgu) {
+		pr_err("%s: failed to initialise CGU\n", __func__);
+		return;
+	}
+
+	retval = ingenic_cgu_register_clocks(cgu);
+	if (retval) {
+		pr_err("%s: failed to register CGU Clocks\n", __func__);
+		return;
+	}
+}
+CLK_OF_DECLARE(x1000_cgu, "ingenic,x1000-cgu", x1000_cgu_init);
-- 
2.10.0
