Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 16:56:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11596 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025958AbbDUO4TKRkq2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2015 16:56:19 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 806F2968874BB;
        Tue, 21 Apr 2015 15:56:10 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 21 Apr 2015 15:56:13 +0100
Received: from localhost (192.168.159.67) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 21 Apr
 2015 15:56:12 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v3 30/37] clk: ingenic: add JZ4780 CGU support
Date:   Tue, 21 Apr 2015 15:46:57 +0100
Message-ID: <1429627624-30525-31-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
References: <1429627624-30525-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.67]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Add support for the clocks provided by the CGU in the Ingenic JZ4780
SoC, making use of the SoC-agnostic CGU code to do the heavy lifting.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Co-authored-by: Paul Cercueil <paul@crapouillou.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Turquette <mturquette@linaro.org>
---
Changes in v3:
  - Rebase.

Changes in v2:
  - Remove FSF address per checkpatch (ZubairLK).
---
 drivers/clk/ingenic/Makefile     |   1 +
 drivers/clk/ingenic/jz4780-cgu.c | 732 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 733 insertions(+)
 create mode 100644 drivers/clk/ingenic/jz4780-cgu.c

diff --git a/drivers/clk/ingenic/Makefile b/drivers/clk/ingenic/Makefile
index e6db7da..cd47b06 100644
--- a/drivers/clk/ingenic/Makefile
+++ b/drivers/clk/ingenic/Makefile
@@ -1,2 +1,3 @@
 obj-y				+= cgu.o
 obj-$(CONFIG_MACH_JZ4740)	+= jz4740-cgu.o
+obj-$(CONFIG_MACH_JZ4780)	+= jz4780-cgu.o
diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
new file mode 100644
index 0000000..d8862ea
--- /dev/null
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -0,0 +1,732 @@
+/*
+ * Ingenic JZ4780 SoC CGU driver
+ *
+ * Copyright (c) 2013-2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
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
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <dt-bindings/clock/jz4780-cgu.h>
+#include "cgu.h"
+
+/* CGU register offsets */
+#define CGU_REG_CLOCKCONTROL	0x00
+#define CGU_REG_PLLCONTROL	0x0c
+#define CGU_REG_APLL		0x10
+#define CGU_REG_MPLL		0x14
+#define CGU_REG_EPLL		0x18
+#define CGU_REG_VPLL		0x1c
+#define CGU_REG_CLKGR0		0x20
+#define CGU_REG_OPCR		0x24
+#define CGU_REG_CLKGR1		0x28
+#define CGU_REG_DDRCDR		0x2c
+#define CGU_REG_VPUCDR		0x30
+#define CGU_REG_USBPCR		0x3c
+#define CGU_REG_USBRDT		0x40
+#define CGU_REG_USBVBFIL	0x44
+#define CGU_REG_USBPCR1		0x48
+#define CGU_REG_LP0CDR		0x54
+#define CGU_REG_I2SCDR		0x60
+#define CGU_REG_LP1CDR		0x64
+#define CGU_REG_MSC0CDR		0x68
+#define CGU_REG_UHCCDR		0x6c
+#define CGU_REG_SSICDR		0x74
+#define CGU_REG_CIMCDR		0x7c
+#define CGU_REG_PCMCDR		0x84
+#define CGU_REG_GPUCDR		0x88
+#define CGU_REG_HDMICDR		0x8c
+#define CGU_REG_MSC1CDR		0xa4
+#define CGU_REG_MSC2CDR		0xa8
+#define CGU_REG_BCHCDR		0xac
+#define CGU_REG_CLOCKSTATUS	0xd4
+
+/* bits within the OPCR register */
+#define OPCR_SPENDN0		(1 << 7)
+#define OPCR_SPENDN1		(1 << 6)
+
+/* bits within the USBPCR register */
+#define USBPCR_USB_MODE		BIT(31)
+#define USBPCR_IDPULLUP_MASK	(0x3 << 28)
+#define USBPCR_COMMONONN	BIT(25)
+#define USBPCR_VBUSVLDEXT	BIT(24)
+#define USBPCR_VBUSVLDEXTSEL	BIT(23)
+#define USBPCR_POR		BIT(22)
+#define USBPCR_OTG_DISABLE	BIT(20)
+#define USBPCR_COMPDISTUNE_MASK	(0x7 << 17)
+#define USBPCR_OTGTUNE_MASK	(0x7 << 14)
+#define USBPCR_SQRXTUNE_MASK	(0x7 << 11)
+#define USBPCR_TXFSLSTUNE_MASK	(0xf << 7)
+#define USBPCR_TXPREEMPHTUNE	BIT(6)
+#define USBPCR_TXHSXVTUNE_MASK	(0x3 << 4)
+#define USBPCR_TXVREFTUNE_MASK	0xf
+
+/* bits within the USBPCR1 register */
+#define USBPCR1_REFCLKSEL_SHIFT	26
+#define USBPCR1_REFCLKSEL_MASK	(0x3 << USBPCR1_REFCLKSEL_SHIFT)
+#define USBPCR1_REFCLKSEL_CORE	(0x2 << USBPCR1_REFCLKSEL_SHIFT)
+#define USBPCR1_REFCLKDIV_SHIFT	24
+#define USBPCR1_REFCLKDIV_MASK	(0x3 << USBPCR1_REFCLKDIV_SHIFT)
+#define USBPCR1_REFCLKDIV_19_2	(0x3 << USBPCR1_REFCLKDIV_SHIFT)
+#define USBPCR1_REFCLKDIV_48	(0x2 << USBPCR1_REFCLKDIV_SHIFT)
+#define USBPCR1_REFCLKDIV_24	(0x1 << USBPCR1_REFCLKDIV_SHIFT)
+#define USBPCR1_REFCLKDIV_12	(0x0 << USBPCR1_REFCLKDIV_SHIFT)
+#define USBPCR1_USB_SEL		BIT(28)
+#define USBPCR1_WORD_IF0	BIT(19)
+#define USBPCR1_WORD_IF1	BIT(18)
+
+/* bits within the USBRDT register */
+#define USBRDT_VBFIL_LD_EN	BIT(25)
+#define USBRDT_USBRDT_MASK	0x7fffff
+
+/* bits within the USBVBFIL register */
+#define USBVBFIL_IDDIGFIL_SHIFT	16
+#define USBVBFIL_IDDIGFIL_MASK	(0xffff << USBVBFIL_IDDIGFIL_SHIFT)
+#define USBVBFIL_USBVBFIL_MASK	(0xffff)
+
+static struct ingenic_cgu *cgu;
+
+static u8 jz4780_otg_phy_get_parent(struct clk_hw *hw)
+{
+	/* we only use CLKCORE, revisit if that ever changes */
+	return 0;
+}
+
+static int jz4780_otg_phy_set_parent(struct clk_hw *hw, u8 idx)
+{
+	unsigned long flags;
+	u32 usbpcr1;
+
+	if (idx > 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&cgu->power_lock, flags);
+
+	usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
+	usbpcr1 &= ~USBPCR1_REFCLKSEL_MASK;
+	/* we only use CLKCORE */
+	usbpcr1 |= USBPCR1_REFCLKSEL_CORE;
+	writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
+
+	spin_unlock_irqrestore(&cgu->power_lock, flags);
+	return 0;
+}
+
+static unsigned long jz4780_otg_phy_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	u32 usbpcr1;
+	unsigned refclk_div;
+
+	usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
+	refclk_div = usbpcr1 & USBPCR1_REFCLKDIV_MASK;
+
+	switch (refclk_div) {
+	case USBPCR1_REFCLKDIV_12:
+		return 12000000;
+
+	case USBPCR1_REFCLKDIV_24:
+		return 24000000;
+
+	case USBPCR1_REFCLKDIV_48:
+		return 48000000;
+
+	case USBPCR1_REFCLKDIV_19_2:
+		return 19200000;
+	}
+
+	BUG();
+	return parent_rate;
+}
+
+static long jz4780_otg_phy_round_rate(struct clk_hw *hw, unsigned long req_rate,
+				      unsigned long *parent_rate)
+{
+	if (req_rate < 15600000)
+		return 12000000;
+
+	if (req_rate < 21600000)
+		return 19200000;
+
+	if (req_rate < 36000000)
+		return 24000000;
+
+	return 48000000;
+}
+
+static int jz4780_otg_phy_set_rate(struct clk_hw *hw, unsigned long req_rate,
+				   unsigned long parent_rate)
+{
+	unsigned long flags;
+	u32 usbpcr1, div_bits;
+
+	switch (req_rate) {
+	case 12000000:
+		div_bits = USBPCR1_REFCLKDIV_12;
+		break;
+
+	case 19200000:
+		div_bits = USBPCR1_REFCLKDIV_19_2;
+		break;
+
+	case 24000000:
+		div_bits = USBPCR1_REFCLKDIV_24;
+		break;
+
+	case 48000000:
+		div_bits = USBPCR1_REFCLKDIV_48;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&cgu->power_lock, flags);
+
+	usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
+	usbpcr1 &= ~USBPCR1_REFCLKDIV_MASK;
+	usbpcr1 |= div_bits;
+	writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
+
+	spin_unlock_irqrestore(&cgu->power_lock, flags);
+	return 0;
+}
+
+struct clk_ops jz4780_otg_phy_ops = {
+	.get_parent = jz4780_otg_phy_get_parent,
+	.set_parent = jz4780_otg_phy_set_parent,
+
+	.recalc_rate = jz4780_otg_phy_recalc_rate,
+	.round_rate = jz4780_otg_phy_round_rate,
+	.set_rate = jz4780_otg_phy_set_rate,
+};
+
+static const s8 pll_od_encoding[16] = {
+	0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
+	0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf,
+};
+
+static const struct ingenic_cgu_clk_info jz4780_cgu_clocks[] = {
+
+	/* External clocks */
+
+	[JZ4780_CLK_EXCLK] = { "ext", CGU_CLK_EXT },
+	[JZ4780_CLK_RTCLK] = { "rtc", CGU_CLK_EXT },
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
+	[JZ4780_CLK_APLL] = {
+		"apll", CGU_CLK_PLL,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.pll = DEF_PLL(APLL),
+	},
+
+	[JZ4780_CLK_MPLL] = {
+		"mpll", CGU_CLK_PLL,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.pll = DEF_PLL(MPLL),
+	},
+
+	[JZ4780_CLK_EPLL] = {
+		"epll", CGU_CLK_PLL,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.pll = DEF_PLL(EPLL),
+	},
+
+	[JZ4780_CLK_VPLL] = {
+		"vpll", CGU_CLK_PLL,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.pll = DEF_PLL(VPLL),
+	},
+
+#undef DEF_PLL
+
+	/* Custom (SoC-specific) OTG PHY */
+
+	[JZ4780_CLK_OTGPHY] = {
+		"otg_phy", CGU_CLK_CUSTOM,
+		.parents = { -1, -1, JZ4780_CLK_EXCLK, -1 },
+		.custom = { &jz4780_otg_phy_ops },
+	},
+
+	/* Muxes & dividers */
+
+	[JZ4780_CLK_SCLKA] = {
+		"sclk_a", CGU_CLK_MUX,
+		.parents = { -1, JZ4780_CLK_APLL, JZ4780_CLK_EXCLK,
+			     JZ4780_CLK_RTCLK },
+		.mux = { CGU_REG_CLOCKCONTROL, 30, 2 },
+	},
+
+	[JZ4780_CLK_CPUMUX] = {
+		"cpumux", CGU_CLK_MUX,
+		.parents = { -1, JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL,
+			     JZ4780_CLK_EPLL },
+		.mux = { CGU_REG_CLOCKCONTROL, 28, 2 },
+	},
+
+	[JZ4780_CLK_CPU] = {
+		"cpu", CGU_CLK_DIV,
+		.parents = { JZ4780_CLK_CPUMUX, -1 },
+		.div = { CGU_REG_CLOCKCONTROL, 0, 4, 22, -1, -1 },
+	},
+
+	[JZ4780_CLK_L2CACHE] = {
+		"l2cache", CGU_CLK_DIV,
+		.parents = { JZ4780_CLK_CPUMUX, -1 },
+		.div = { CGU_REG_CLOCKCONTROL, 4, 4, -1, -1, -1 },
+	},
+
+	[JZ4780_CLK_AHB0] = {
+		"ahb0", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { -1, JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL,
+			     JZ4780_CLK_EPLL },
+		.mux = { CGU_REG_CLOCKCONTROL, 26, 2 },
+		.div = { CGU_REG_CLOCKCONTROL, 8, 4, 21, -1, -1 },
+	},
+
+	[JZ4780_CLK_AHB2PMUX] = {
+		"ahb2_apb_mux", CGU_CLK_MUX,
+		.parents = { -1, JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL,
+			     JZ4780_CLK_RTCLK },
+		.mux = { CGU_REG_CLOCKCONTROL, 24, 2 },
+	},
+
+	[JZ4780_CLK_AHB2] = {
+		"ahb2", CGU_CLK_DIV,
+		.parents = { JZ4780_CLK_AHB2PMUX, -1 },
+		.div = { CGU_REG_CLOCKCONTROL, 12, 4, 20, -1, -1 },
+	},
+
+	[JZ4780_CLK_PCLK] = {
+		"pclk", CGU_CLK_DIV,
+		.parents = { JZ4780_CLK_AHB2PMUX, -1 },
+		.div = { CGU_REG_CLOCKCONTROL, 16, 4, 20, -1, -1 },
+	},
+
+	[JZ4780_CLK_DDR] = {
+		"ddr", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { -1, JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL, -1 },
+		.mux = { CGU_REG_DDRCDR, 30, 2 },
+		.div = { CGU_REG_DDRCDR, 0, 4, 29, 28, 27 },
+	},
+
+	[JZ4780_CLK_VPU] = {
+		"vpu", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL,
+			     JZ4780_CLK_EPLL, -1 },
+		.mux = { CGU_REG_VPUCDR, 30, 2 },
+		.div = { CGU_REG_VPUCDR, 0, 4, 29, 28, 27 },
+		.gate = { CGU_REG_CLKGR1, 2 },
+	},
+
+	[JZ4780_CLK_I2SPLL] = {
+		"i2s_pll", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_EPLL, -1 },
+		.mux = { CGU_REG_I2SCDR, 30, 1 },
+		.div = { CGU_REG_I2SCDR, 0, 8, 29, 28, 27 },
+	},
+
+	[JZ4780_CLK_I2S] = {
+		"i2s", CGU_CLK_MUX,
+		.parents = { JZ4780_CLK_EXCLK, JZ4780_CLK_I2SPLL, -1 },
+		.mux = { CGU_REG_I2SCDR, 31, 1 },
+	},
+
+	[JZ4780_CLK_LCD0PIXCLK] = {
+		"lcd0pixclk", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL,
+			     JZ4780_CLK_VPLL, -1 },
+		.mux = { CGU_REG_LP0CDR, 30, 2 },
+		.div = { CGU_REG_LP0CDR, 0, 8, 28, 27, 26 },
+	},
+
+	[JZ4780_CLK_LCD1PIXCLK] = {
+		"lcd1pixclk", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL,
+			     JZ4780_CLK_VPLL, -1 },
+		.mux = { CGU_REG_LP1CDR, 30, 2 },
+		.div = { CGU_REG_LP1CDR, 0, 8, 28, 27, 26 },
+	},
+
+	[JZ4780_CLK_MSCMUX] = {
+		"msc_mux", CGU_CLK_MUX,
+		.parents = { -1, JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL, -1 },
+		.mux = { CGU_REG_MSC0CDR, 30, 2 },
+	},
+
+	[JZ4780_CLK_MSC0] = {
+		"msc0", CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_MSCMUX, -1 },
+		.div = { CGU_REG_MSC0CDR, 0, 8, 29, 28, 27 },
+		.gate = { CGU_REG_CLKGR0, 3 },
+	},
+
+	[JZ4780_CLK_MSC1] = {
+		"msc1", CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_MSCMUX, -1 },
+		.div = { CGU_REG_MSC1CDR, 0, 8, 29, 28, 27 },
+		.gate = { CGU_REG_CLKGR0, 11 },
+	},
+
+	[JZ4780_CLK_MSC2] = {
+		"msc2", CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_MSCMUX, -1 },
+		.div = { CGU_REG_MSC2CDR, 0, 8, 29, 28, 27 },
+		.gate = { CGU_REG_CLKGR0, 12 },
+	},
+
+	[JZ4780_CLK_UHC] = {
+		"uhc", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL,
+			     JZ4780_CLK_EPLL, JZ4780_CLK_OTGPHY },
+		.mux = { CGU_REG_UHCCDR, 30, 2 },
+		.div = { CGU_REG_UHCCDR, 0, 8, 29, 28, 27 },
+		.gate = { CGU_REG_CLKGR0, 24 },
+	},
+
+	[JZ4780_CLK_SSIPLL] = {
+		"ssi_pll", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL, -1 },
+		.mux = { CGU_REG_SSICDR, 30, 1 },
+		.div = { CGU_REG_SSICDR, 0, 8, 29, 28, 27 },
+	},
+
+	[JZ4780_CLK_SSI] = {
+		"ssi", CGU_CLK_MUX,
+		.parents = { JZ4780_CLK_EXCLK, JZ4780_CLK_SSIPLL, -1 },
+		.mux = { CGU_REG_SSICDR, 31, 1 },
+	},
+
+	[JZ4780_CLK_CIMMCLK] = {
+		"cim_mclk", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL, -1 },
+		.mux = { CGU_REG_CIMCDR, 31, 1 },
+		.div = { CGU_REG_CIMCDR, 0, 8, 30, 29, 28 },
+	},
+
+	[JZ4780_CLK_PCMPLL] = {
+		"pcm_pll", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL,
+			     JZ4780_CLK_EPLL, JZ4780_CLK_VPLL },
+		.mux = { CGU_REG_PCMCDR, 29, 2 },
+		.div = { CGU_REG_PCMCDR, 0, 8, 28, 27, 26 },
+	},
+
+	[JZ4780_CLK_PCM] = {
+		"pcm", CGU_CLK_MUX | CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, JZ4780_CLK_PCMPLL, -1 },
+		.mux = { CGU_REG_PCMCDR, 31, 1 },
+		.gate = { CGU_REG_CLKGR1, 3 },
+	},
+
+	[JZ4780_CLK_GPU] = {
+		"gpu", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { -1, JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL,
+			     JZ4780_CLK_EPLL },
+		.mux = { CGU_REG_GPUCDR, 30, 2 },
+		.div = { CGU_REG_GPUCDR, 0, 4, 29, 28, 27 },
+		.gate = { CGU_REG_CLKGR1, 4 },
+	},
+
+	[JZ4780_CLK_HDMI] = {
+		"hdmi", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL,
+			     JZ4780_CLK_VPLL, -1 },
+		.mux = { CGU_REG_HDMICDR, 30, 2 },
+		.div = { CGU_REG_HDMICDR, 0, 8, 29, 28, 26 },
+		.gate = { CGU_REG_CLKGR1, 9 },
+	},
+
+	[JZ4780_CLK_BCH] = {
+		"bch", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { -1, JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL,
+			     JZ4780_CLK_EPLL },
+		.mux = { CGU_REG_BCHCDR, 30, 2 },
+		.div = { CGU_REG_BCHCDR, 0, 4, 29, 28, 27 },
+		.gate = { CGU_REG_CLKGR0, 1 },
+	},
+
+	/* Gate-only clocks */
+
+	[JZ4780_CLK_NEMC] = {
+		"nemc", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_AHB2, -1 },
+		.gate = { CGU_REG_CLKGR0, 0 },
+	},
+
+	[JZ4780_CLK_OTG0] = {
+		"otg0", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 2 },
+	},
+
+	[JZ4780_CLK_SSI0] = {
+		"ssi0", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_SSI, -1 },
+		.gate = { CGU_REG_CLKGR0, 4 },
+	},
+
+	[JZ4780_CLK_SMB0] = {
+		"smb0", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_PCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 5 },
+	},
+
+	[JZ4780_CLK_SMB1] = {
+		"smb1", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_PCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 6 },
+	},
+
+	[JZ4780_CLK_SCC] = {
+		"scc", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 7 },
+	},
+
+	[JZ4780_CLK_AIC] = {
+		"aic", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 8 },
+	},
+
+	[JZ4780_CLK_TSSI0] = {
+		"tssi0", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 9 },
+	},
+
+	[JZ4780_CLK_OWI] = {
+		"owi", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 10 },
+	},
+
+	[JZ4780_CLK_KBC] = {
+		"kbc", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 13 },
+	},
+
+	[JZ4780_CLK_SADC] = {
+		"sadc", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 14 },
+	},
+
+	[JZ4780_CLK_UART0] = {
+		"uart0", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 15 },
+	},
+
+	[JZ4780_CLK_UART1] = {
+		"uart1", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 16 },
+	},
+
+	[JZ4780_CLK_UART2] = {
+		"uart2", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 17 },
+	},
+
+	[JZ4780_CLK_UART3] = {
+		"uart3", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 18 },
+	},
+
+	[JZ4780_CLK_SSI1] = {
+		"ssi1", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_SSI, -1 },
+		.gate = { CGU_REG_CLKGR0, 19 },
+	},
+
+	[JZ4780_CLK_SSI2] = {
+		"ssi2", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_SSI, -1 },
+		.gate = { CGU_REG_CLKGR0, 20 },
+	},
+
+	[JZ4780_CLK_PDMA] = {
+		"pdma", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 21 },
+	},
+
+	[JZ4780_CLK_GPS] = {
+		"gps", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 22 },
+	},
+
+	[JZ4780_CLK_MAC] = {
+		"mac", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 23 },
+	},
+
+	[JZ4780_CLK_SMB2] = {
+		"smb2", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_PCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 24 },
+	},
+
+	[JZ4780_CLK_CIM] = {
+		"cim", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 26 },
+	},
+
+	[JZ4780_CLK_LCD] = {
+		"lcd", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 28 },
+	},
+
+	[JZ4780_CLK_TVE] = {
+		"tve", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_LCD, -1 },
+		.gate = { CGU_REG_CLKGR0, 27 },
+	},
+
+	[JZ4780_CLK_IPU] = {
+		"ipu", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR0, 29 },
+	},
+
+	[JZ4780_CLK_DDR0] = {
+		"ddr0", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_DDR, -1 },
+		.gate = { CGU_REG_CLKGR0, 30 },
+	},
+
+	[JZ4780_CLK_DDR1] = {
+		"ddr1", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_DDR, -1 },
+		.gate = { CGU_REG_CLKGR0, 31 },
+	},
+
+	[JZ4780_CLK_SMB3] = {
+		"smb3", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_PCLK, -1 },
+		.gate = { CGU_REG_CLKGR1, 0 },
+	},
+
+	[JZ4780_CLK_TSSI1] = {
+		"tssi1", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR1, 1 },
+	},
+
+	[JZ4780_CLK_COMPRESS] = {
+		"compress", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR1, 5 },
+	},
+
+	[JZ4780_CLK_AIC1] = {
+		"aic1", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR1, 6 },
+	},
+
+	[JZ4780_CLK_GPVLC] = {
+		"gpvlc", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR1, 7 },
+	},
+
+	[JZ4780_CLK_OTG1] = {
+		"otg1", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR1, 8 },
+	},
+
+	[JZ4780_CLK_UART4] = {
+		"uart4", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR1, 10 },
+	},
+
+	[JZ4780_CLK_AHBMON] = {
+		"ahb_mon", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR1, 11 },
+	},
+
+	[JZ4780_CLK_SMB4] = {
+		"smb4", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_PCLK, -1 },
+		.gate = { CGU_REG_CLKGR1, 12 },
+	},
+
+	[JZ4780_CLK_DES] = {
+		"des", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR1, 13 },
+	},
+
+	[JZ4780_CLK_X2D] = {
+		"x2d", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_EXCLK, -1 },
+		.gate = { CGU_REG_CLKGR1, 14 },
+	},
+
+	[JZ4780_CLK_CORE1] = {
+		"core1", CGU_CLK_GATE,
+		.parents = { JZ4780_CLK_CPU, -1 },
+		.gate = { CGU_REG_CLKGR1, 15 },
+	},
+
+};
+
+static void __init jz4780_cgu_init(struct device_node *np)
+{
+	int retval;
+
+	cgu = ingenic_cgu_new(jz4780_cgu_clocks,
+			      ARRAY_SIZE(jz4780_cgu_clocks), np);
+	if (!cgu)
+		pr_err("%s: failed to initialise CGU\n", __func__);
+
+	retval = ingenic_cgu_register_clocks(cgu);
+	if (retval)
+		pr_err("%s: failed to register CGU Clocks\n", __func__);
+
+	clk_set_parent(cgu->clocks.clks[JZ4780_CLK_UHC],
+		       cgu->clocks.clks[JZ4780_CLK_MPLL]);
+}
+CLK_OF_DECLARE(jz4780_cgu, "ingenic,jz4780-cgu", jz4780_cgu_init);
-- 
2.3.5
