Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2016 09:55:28 +0200 (CEST)
Received: from smtpout.microchip.com ([198.175.253.82]:57974 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27028494AbcEMHy5TJkP0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2016 09:54:57 +0200
Received: from mx.microchip.com (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.181.6; Fri, 13 May 2016
 00:54:48 -0700
Received: by mx.microchip.com (sSMTP sendmail emulation); Fri, 13 May 2016
 13:23:04 +0530
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-clk@vger.kernel.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v11 2/3] clk: microchip: Add Microchip PIC32 clock driver.
Date:   Fri, 13 May 2016 13:22:40 +0530
Message-ID: <1463125961-10706-3-git-send-email-purna.mandal@microchip.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1463125961-10706-1-git-send-email-purna.mandal@microchip.com>
References: <1463125961-10706-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: purna.mandal@microchip.com
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

This clock driver implements PIC32 specific clock-tree. clock-tree
entities can only be configured through device-tree file (OF).

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>


---
Note: Please pull this complete series through the MIPS tree.

Changes in v11:
- split clock-init-data from clock-driver-data.
- calculate iobase from reg offset and regbase.
- use readl_poll_timeout() wherever required.
- drop explicit typecast where implicit is sufficient.
- drop forward declaration of 'clk_hw' in clk-core.h.
- force enable critical clocks to avoid gate.

Changes in v10:
- drop early clock init of CLK_OF_DECLARE way.
- complete clock registration as platform_driver.

Changes in v9:
- split clock registration in two parts, cpu clock (& required
  parents) as part of CLK_OF_DECLARE and remaining as part of
  platform_driver.

Changes in v8:
- Remove .round_rate from clk_ops
- Fix rework bug "of_clk_src_onecell_get: invalid clock index 20"

Changes in v7:
- Reworked PIC32 clock driver based on review.
- PIC32 clock driver now separate core functionality from platform
  specific clock-submodule binding/hierarchy.
- moved PIC32 driver under clk/microchip/
- core clk functionality now in clk/microchip/clk-core.c
- driver now doesn't use device-tree for clock submodules.
- platform now statically defines clock submodule data-structures
  and bind them accordingly.

Changes in v6:
- sort linux includes and asm includes.
- use BIT() wherever applicable
- drop 'microchip,ignore-unused' usage, handling in favor of critical
  clock
- drop 'fixed divider' handling for periph clock
- drop use of 'debug_init()' clk operation callback for register dump
- drop clk_lock(), clk_unlock() spinlock wrapper
- drop unimplemented pic32_devcon_syslock() macro
- use readl()/writel() instead of clk_readl()/clk_writel()
- drop redundant spinlock, unlock calls in sosc_clk_enable()/disable()
- use CLK_SET_RATE_GATE, _SET_PARENT_GATE for refo-clocks
- use kcalloc() instead of kmalloc() wherever applicable
- use of_io_request_and_map() in soc_clock_init()
- drop use of pbclk(/roclk)_endisable() inline function
- use readl_poll_timeout_atomic() for wait_for_bit() type loop
- drop cpu_relax() after clk gating
- promote u8, u16 to u32 wherever applicable
- fix sosc clock status polling
- drop memory alloc from pic32_of_clk_get_parent_indices() instead
  callers  will supply buffer to hold output parent indices
- reword comments about spll_clk_set_rate() pre-conditions
- drop use of CLK_BASIC wherever applicable
- reword comments in sclk_set_parent()

Changes in v3:
- Replace __clk_debug with pr_debug
- Add of_clk_parent_fill usage in PIC32 clock driver

Changes in v2:
- Remove unused PIC32 MPLL support.
- Remove support for initializing default parent/rate for REFOSC
  clocks.

 drivers/clk/Kconfig                   |    3 +
 drivers/clk/Makefile                  |    1 +
 drivers/clk/microchip/Makefile        |    2 +
 drivers/clk/microchip/clk-core.c      | 1031 +++++++++++++++++++++++++++++++++
 drivers/clk/microchip/clk-core.h      |   84 +++
 drivers/clk/microchip/clk-pic32mzda.c |  275 +++++++++
 6 files changed, 1396 insertions(+)
 create mode 100644 drivers/clk/microchip/Makefile
 create mode 100644 drivers/clk/microchip/clk-core.c
 create mode 100644 drivers/clk/microchip/clk-core.h
 create mode 100644 drivers/clk/microchip/clk-pic32mzda.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 16f7d33..f189d17 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -197,6 +197,9 @@ config COMMON_CLK_PXA
 	---help---
 	  Support for the Marvell PXA SoC.
 
+config COMMON_CLK_PIC32
+	def_bool COMMON_CLK && MACH_PIC32
+
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 46869d6..18e64bb 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_ARCH_MXC)			+= imx/
 obj-$(CONFIG_MACH_INGENIC)		+= ingenic/
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
 obj-$(CONFIG_ARCH_MEDIATEK)		+= mediatek/
+obj-$(CONFIG_MACH_PIC32)		+= microchip/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+= mmp/
 endif
diff --git a/drivers/clk/microchip/Makefile b/drivers/clk/microchip/Makefile
new file mode 100644
index 0000000..2152f41
--- /dev/null
+++ b/drivers/clk/microchip/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_COMMON_CLK_PIC32) += clk-core.o
+obj-$(CONFIG_PIC32MZDA) += clk-pic32mzda.o
diff --git a/drivers/clk/microchip/clk-core.c b/drivers/clk/microchip/clk-core.c
new file mode 100644
index 0000000..ca85cea
--- /dev/null
+++ b/drivers/clk/microchip/clk-core.c
@@ -0,0 +1,1031 @@
+/*
+ * Purna Chandra Mandal,<purna.mandal@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ * This program is free software; you can distribute it and/or modify it
+ * under the terms of the GNU General Public License (Version 2) as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ */
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <asm/mach-pic32/pic32.h>
+#include <asm/traps.h>
+
+#include "clk-core.h"
+
+/* OSCCON Reg fields */
+#define OSC_CUR_MASK		0x07
+#define OSC_CUR_SHIFT		12
+#define OSC_NEW_MASK		0x07
+#define OSC_NEW_SHIFT		8
+#define OSC_SWEN		BIT(0)
+
+/* SPLLCON Reg fields */
+#define PLL_RANGE_MASK		0x07
+#define PLL_RANGE_SHIFT		0
+#define PLL_ICLK_MASK		0x01
+#define PLL_ICLK_SHIFT		7
+#define PLL_IDIV_MASK		0x07
+#define PLL_IDIV_SHIFT		8
+#define PLL_ODIV_MASK		0x07
+#define PLL_ODIV_SHIFT		24
+#define PLL_MULT_MASK		0x7F
+#define PLL_MULT_SHIFT		16
+#define PLL_MULT_MAX		128
+#define PLL_ODIV_MIN		1
+#define PLL_ODIV_MAX		5
+
+/* Peripheral Bus Clock Reg Fields */
+#define PB_DIV_MASK		0x7f
+#define PB_DIV_SHIFT		0
+#define PB_DIV_READY		BIT(11)
+#define PB_DIV_ENABLE		BIT(15)
+#define PB_DIV_MAX		128
+#define PB_DIV_MIN		0
+
+/* Reference Oscillator Control Reg fields */
+#define REFO_SEL_MASK		0x0f
+#define REFO_SEL_SHIFT		0
+#define REFO_ACTIVE		BIT(8)
+#define REFO_DIVSW_EN		BIT(9)
+#define REFO_OE			BIT(12)
+#define REFO_ON			BIT(15)
+#define REFO_DIV_SHIFT		16
+#define REFO_DIV_MASK		0x7fff
+
+/* Reference Oscillator Trim Register Fields */
+#define REFO_TRIM_REG		0x10
+#define REFO_TRIM_MASK		0x1ff
+#define REFO_TRIM_SHIFT		23
+#define REFO_TRIM_MAX		511
+
+/* Mux Slew Control Register fields */
+#define SLEW_BUSY		BIT(0)
+#define SLEW_DOWNEN		BIT(1)
+#define SLEW_UPEN		BIT(2)
+#define SLEW_DIV		0x07
+#define SLEW_DIV_SHIFT		8
+#define SLEW_SYSDIV		0x0f
+#define SLEW_SYSDIV_SHIFT	20
+
+/* Clock Poll Timeout */
+#define LOCK_TIMEOUT_US         USEC_PER_MSEC
+
+/* SoC specific clock needed during SPLL clock rate switch */
+static struct clk_hw *pic32_sclk_hw;
+
+/* add instruction pipeline delay while CPU clock is in-transition. */
+#define cpu_nop5()			\
+do {					\
+	__asm__ __volatile__("nop");	\
+	__asm__ __volatile__("nop");	\
+	__asm__ __volatile__("nop");	\
+	__asm__ __volatile__("nop");	\
+	__asm__ __volatile__("nop");	\
+} while (0)
+
+/* Perpheral bus clocks */
+struct pic32_periph_clk {
+	struct clk_hw hw;
+	void __iomem *ctrl_reg;
+	struct pic32_clk_common *core;
+};
+
+#define clkhw_to_pbclk(_hw)	container_of(_hw, struct pic32_periph_clk, hw)
+
+static int pbclk_is_enabled(struct clk_hw *hw)
+{
+	struct pic32_periph_clk *pb = clkhw_to_pbclk(hw);
+
+	return readl(pb->ctrl_reg) & PB_DIV_ENABLE;
+}
+
+static int pbclk_enable(struct clk_hw *hw)
+{
+	struct pic32_periph_clk *pb = clkhw_to_pbclk(hw);
+
+	writel(PB_DIV_ENABLE, PIC32_SET(pb->ctrl_reg));
+	return 0;
+}
+
+static void pbclk_disable(struct clk_hw *hw)
+{
+	struct pic32_periph_clk *pb = clkhw_to_pbclk(hw);
+
+	writel(PB_DIV_ENABLE, PIC32_CLR(pb->ctrl_reg));
+}
+
+static unsigned long calc_best_divided_rate(unsigned long rate,
+					    unsigned long parent_rate,
+					    u32 divider_max,
+					    u32 divider_min)
+{
+	unsigned long divided_rate, divided_rate_down, best_rate;
+	unsigned long div, div_up;
+
+	/* eq. clk_rate = parent_rate / divider.
+	 *
+	 * Find best divider to produce closest of target divided rate.
+	 */
+	div = parent_rate / rate;
+	div = clamp_val(div, divider_min, divider_max);
+	div_up = clamp_val(div + 1, divider_min, divider_max);
+
+	divided_rate = parent_rate / div;
+	divided_rate_down = parent_rate / div_up;
+	if (abs(rate - divided_rate_down) < abs(rate - divided_rate))
+		best_rate = divided_rate_down;
+	else
+		best_rate = divided_rate;
+
+	return best_rate;
+}
+
+static inline u32 pbclk_read_pbdiv(struct pic32_periph_clk *pb)
+{
+	return ((readl(pb->ctrl_reg) >> PB_DIV_SHIFT) & PB_DIV_MASK) + 1;
+}
+
+static unsigned long pbclk_recalc_rate(struct clk_hw *hw,
+				       unsigned long parent_rate)
+{
+	struct pic32_periph_clk *pb = clkhw_to_pbclk(hw);
+
+	return parent_rate / pbclk_read_pbdiv(pb);
+}
+
+static long pbclk_round_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long *parent_rate)
+{
+	return calc_best_divided_rate(rate, *parent_rate,
+				      PB_DIV_MAX, PB_DIV_MIN);
+}
+
+static int pbclk_set_rate(struct clk_hw *hw, unsigned long rate,
+			  unsigned long parent_rate)
+{
+	struct pic32_periph_clk *pb = clkhw_to_pbclk(hw);
+	unsigned long flags;
+	u32 v, div;
+	int err;
+
+	/* check & wait for DIV_READY */
+	err = readl_poll_timeout(pb->ctrl_reg, v, v & PB_DIV_READY,
+				 1, LOCK_TIMEOUT_US);
+	if (err)
+		return err;
+
+	/* calculate clkdiv and best rate */
+	div = DIV_ROUND_CLOSEST(parent_rate, rate);
+
+	spin_lock_irqsave(&pb->core->reg_lock, flags);
+
+	/* apply new div */
+	v = readl(pb->ctrl_reg);
+	v &= ~PB_DIV_MASK;
+	v |= (div - 1);
+
+	pic32_syskey_unlock();
+
+	writel(v, pb->ctrl_reg);
+
+	spin_unlock_irqrestore(&pb->core->reg_lock, flags);
+
+	/* wait again, for pbdivready */
+	err = readl_poll_timeout_atomic(pb->ctrl_reg, v, v & PB_DIV_READY,
+					1, LOCK_TIMEOUT_US);
+	if (err)
+		return err;
+
+	/* confirm that new div is applied correctly */
+	return (pbclk_read_pbdiv(pb) == div) ? 0 : -EBUSY;
+}
+
+const struct clk_ops pic32_pbclk_ops = {
+	.enable		= pbclk_enable,
+	.disable	= pbclk_disable,
+	.is_enabled	= pbclk_is_enabled,
+	.recalc_rate	= pbclk_recalc_rate,
+	.round_rate	= pbclk_round_rate,
+	.set_rate	= pbclk_set_rate,
+};
+
+struct clk *pic32_periph_clk_register(const struct pic32_periph_clk_data *desc,
+				      struct pic32_clk_common *core)
+{
+	struct pic32_periph_clk *pbclk;
+	struct clk *clk;
+
+	pbclk = devm_kzalloc(core->dev, sizeof(*pbclk), GFP_KERNEL);
+	if (!pbclk)
+		return ERR_PTR(-ENOMEM);
+
+	pbclk->hw.init = &desc->init_data;
+	pbclk->core = core;
+	pbclk->ctrl_reg = desc->ctrl_reg + core->iobase;
+
+	clk = devm_clk_register(core->dev, &pbclk->hw);
+	if (IS_ERR(clk)) {
+		dev_err(core->dev, "%s: clk_register() failed\n", __func__);
+		devm_kfree(core->dev, pbclk);
+	}
+
+	return clk;
+}
+
+/* Reference oscillator operations */
+struct pic32_ref_osc {
+	struct clk_hw hw;
+	void __iomem *ctrl_reg;
+	const u32 *parent_map;
+	struct pic32_clk_common *core;
+};
+
+#define clkhw_to_refosc(_hw)	container_of(_hw, struct pic32_ref_osc, hw)
+
+static int roclk_is_enabled(struct clk_hw *hw)
+{
+	struct pic32_ref_osc *refo = clkhw_to_refosc(hw);
+
+	return readl(refo->ctrl_reg) & REFO_ON;
+}
+
+static int roclk_enable(struct clk_hw *hw)
+{
+	struct pic32_ref_osc *refo = clkhw_to_refosc(hw);
+
+	writel(REFO_ON | REFO_OE, PIC32_SET(refo->ctrl_reg));
+	return 0;
+}
+
+static void roclk_disable(struct clk_hw *hw)
+{
+	struct pic32_ref_osc *refo = clkhw_to_refosc(hw);
+
+	writel(REFO_ON | REFO_OE, PIC32_CLR(refo->ctrl_reg));
+}
+
+static void roclk_init(struct clk_hw *hw)
+{
+	/* initialize clock in disabled state */
+	roclk_disable(hw);
+}
+
+static u8 roclk_get_parent(struct clk_hw *hw)
+{
+	struct pic32_ref_osc *refo = clkhw_to_refosc(hw);
+	u32 v, i;
+
+	v = (readl(refo->ctrl_reg) >> REFO_SEL_SHIFT) & REFO_SEL_MASK;
+
+	if (!refo->parent_map)
+		return v;
+
+	for (i = 0; i < clk_hw_get_num_parents(hw); i++)
+		if (refo->parent_map[i] == v)
+			return i;
+
+	return -EINVAL;
+}
+
+static unsigned long roclk_calc_rate(unsigned long parent_rate,
+				     u32 rodiv, u32 rotrim)
+{
+	u64 rate64;
+
+	/* fout = fin / [2 * {div + (trim / 512)}]
+	 *	= fin * 512 / [1024 * div + 2 * trim]
+	 *	= fin * 256 / (512 * div + trim)
+	 *	= (fin << 8) / ((div << 9) + trim)
+	 */
+	if (rotrim) {
+		rodiv = (rodiv << 9) + rotrim;
+		rate64 = parent_rate;
+		rate64 <<= 8;
+		do_div(rate64, rodiv);
+	} else if (rodiv) {
+		rate64 = parent_rate / (rodiv << 1);
+	} else {
+		rate64 = parent_rate;
+	}
+	return rate64;
+}
+
+static void roclk_calc_div_trim(unsigned long rate,
+				unsigned long parent_rate,
+				u32 *rodiv_p, u32 *rotrim_p)
+{
+	u32 div, rotrim, rodiv;
+	u64 frac;
+
+	/* Find integer approximation of floating-point arithmetic.
+	 *      fout = fin / [2 * {rodiv + (rotrim / 512)}] ... (1)
+	 * i.e. fout = fin / 2 * DIV
+	 *      whereas DIV = rodiv + (rotrim / 512)
+	 *
+	 * Since kernel does not perform floating-point arithmatic so
+	 * (rotrim/512) will be zero. And DIV & rodiv will result same.
+	 *
+	 * ie. fout = (fin * 256) / [(512 * rodiv) + rotrim]  ... from (1)
+	 * ie. rotrim = ((fin * 256) / fout) - (512 * DIV)
+	 */
+	if (parent_rate <= rate) {
+		div = 0;
+		frac = 0;
+		rodiv = 0;
+		rotrim = 0;
+	} else {
+		div = parent_rate / (rate << 1);
+		frac = parent_rate;
+		frac <<= 8;
+		do_div(frac, rate);
+		frac -= (u64)(div << 9);
+
+		rodiv = (div > REFO_DIV_MASK) ? REFO_DIV_MASK : div;
+		rotrim = (frac >= REFO_TRIM_MAX) ? REFO_TRIM_MAX : frac;
+	}
+
+	if (rodiv_p)
+		*rodiv_p = rodiv;
+
+	if (rotrim_p)
+		*rotrim_p = rotrim;
+}
+
+static unsigned long roclk_recalc_rate(struct clk_hw *hw,
+				       unsigned long parent_rate)
+{
+	struct pic32_ref_osc *refo = clkhw_to_refosc(hw);
+	u32 v, rodiv, rotrim;
+
+	/* get rodiv */
+	v = readl(refo->ctrl_reg);
+	rodiv = (v >> REFO_DIV_SHIFT) & REFO_DIV_MASK;
+
+	/* get trim */
+	v = readl(refo->ctrl_reg + REFO_TRIM_REG);
+	rotrim = (v >> REFO_TRIM_SHIFT) & REFO_TRIM_MASK;
+
+	return roclk_calc_rate(parent_rate, rodiv, rotrim);
+}
+
+static long roclk_round_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long *parent_rate)
+{
+	u32 rotrim, rodiv;
+
+	/* calculate dividers for new rate */
+	roclk_calc_div_trim(rate, *parent_rate, &rodiv, &rotrim);
+
+	/* caclulate new rate (rounding) based on new rodiv & rotrim */
+	return roclk_calc_rate(*parent_rate, rodiv, rotrim);
+}
+
+static int roclk_determine_rate(struct clk_hw *hw,
+				struct clk_rate_request *req)
+{
+	struct clk_hw *parent_clk, *best_parent_clk = NULL;
+	unsigned int i, delta, best_delta = -1;
+	unsigned long parent_rate, best_parent_rate = 0;
+	unsigned long best = 0, nearest_rate;
+
+	/* find a parent which can generate nearest clkrate >= rate */
+	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
+		/* get parent */
+		parent_clk = clk_hw_get_parent_by_index(hw, i);
+		if (!parent_clk)
+			continue;
+
+		/* skip if parent runs slower than target rate */
+		parent_rate = clk_hw_get_rate(parent_clk);
+		if (req->rate > parent_rate)
+			continue;
+
+		nearest_rate = roclk_round_rate(hw, req->rate, &parent_rate);
+		delta = abs(nearest_rate - req->rate);
+		if ((nearest_rate >= req->rate) && (delta < best_delta)) {
+			best_parent_clk = parent_clk;
+			best_parent_rate = parent_rate;
+			best = nearest_rate;
+			best_delta = delta;
+
+			if (delta == 0)
+				break;
+		}
+	}
+
+	/* if no match found, retain old rate */
+	if (!best_parent_clk) {
+		pr_err("%s:%s, no parent found for rate %lu.\n",
+		       __func__, clk_hw_get_name(hw), req->rate);
+		return clk_hw_get_rate(hw);
+	}
+
+	pr_debug("%s,rate %lu, best_parent(%s, %lu), best %lu, delta %d\n",
+		 clk_hw_get_name(hw), req->rate,
+		 clk_hw_get_name(best_parent_clk), best_parent_rate,
+		 best, best_delta);
+
+	if (req->best_parent_rate)
+		req->best_parent_rate = best_parent_rate;
+
+	if (req->best_parent_hw)
+		req->best_parent_hw = best_parent_clk;
+
+	return best;
+}
+
+static int roclk_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct pic32_ref_osc *refo = clkhw_to_refosc(hw);
+	unsigned long flags;
+	u32 v;
+	int err;
+
+	if (refo->parent_map)
+		index = refo->parent_map[index];
+
+	/* wait until ACTIVE bit is zero or timeout */
+	err = readl_poll_timeout(refo->ctrl_reg, v, !(v & REFO_ACTIVE),
+				 1, LOCK_TIMEOUT_US);
+	if (err) {
+		pr_err("%s: poll failed, clk active\n", clk_hw_get_name(hw));
+		return err;
+	}
+
+	spin_lock_irqsave(&refo->core->reg_lock, flags);
+
+	pic32_syskey_unlock();
+
+	/* calculate & apply new */
+	v = readl(refo->ctrl_reg);
+	v &= ~(REFO_SEL_MASK << REFO_SEL_SHIFT);
+	v |= index << REFO_SEL_SHIFT;
+
+	writel(v, refo->ctrl_reg);
+
+	spin_unlock_irqrestore(&refo->core->reg_lock, flags);
+
+	return 0;
+}
+
+static int roclk_set_rate_and_parent(struct clk_hw *hw,
+				     unsigned long rate,
+				     unsigned long parent_rate,
+				     u8 index)
+{
+	struct pic32_ref_osc *refo = clkhw_to_refosc(hw);
+	unsigned long flags;
+	u32 trim, rodiv, v;
+	int err;
+
+	/* calculate new rodiv & rotrim for new rate */
+	roclk_calc_div_trim(rate, parent_rate, &rodiv, &trim);
+
+	pr_debug("parent_rate = %lu, rate = %lu, div = %d, trim = %d\n",
+		 parent_rate, rate, rodiv, trim);
+
+	/* wait till source change is active */
+	err = readl_poll_timeout(refo->ctrl_reg, v,
+				 !(v & (REFO_ACTIVE | REFO_DIVSW_EN)),
+				 1, LOCK_TIMEOUT_US);
+	if (err) {
+		pr_err("%s: poll timedout, clock is still active\n", __func__);
+		return err;
+	}
+
+	spin_lock_irqsave(&refo->core->reg_lock, flags);
+	v = readl(refo->ctrl_reg);
+
+	pic32_syskey_unlock();
+
+	/* apply parent, if required */
+	if (refo->parent_map)
+		index = refo->parent_map[index];
+
+	v &= ~(REFO_SEL_MASK << REFO_SEL_SHIFT);
+	v |= index << REFO_SEL_SHIFT;
+
+	/* apply RODIV */
+	v &= ~(REFO_DIV_MASK << REFO_DIV_SHIFT);
+	v |= rodiv << REFO_DIV_SHIFT;
+	writel(v, refo->ctrl_reg);
+
+	/* apply ROTRIM */
+	v = readl(refo->ctrl_reg + REFO_TRIM_REG);
+	v &= ~(REFO_TRIM_MASK << REFO_TRIM_SHIFT);
+	v |= trim << REFO_TRIM_SHIFT;
+	writel(v, refo->ctrl_reg + REFO_TRIM_REG);
+
+	/* enable & activate divider switching */
+	writel(REFO_ON | REFO_DIVSW_EN, PIC32_SET(refo->ctrl_reg));
+
+	/* wait till divswen is in-progress */
+	err = readl_poll_timeout_atomic(refo->ctrl_reg, v, !(v & REFO_DIVSW_EN),
+					1, LOCK_TIMEOUT_US);
+	/* leave the clk gated as it was */
+	writel(REFO_ON, PIC32_CLR(refo->ctrl_reg));
+
+	spin_unlock_irqrestore(&refo->core->reg_lock, flags);
+
+	return err;
+}
+
+static int roclk_set_rate(struct clk_hw *hw, unsigned long rate,
+			  unsigned long parent_rate)
+{
+	u8 index = roclk_get_parent(hw);
+
+	return roclk_set_rate_and_parent(hw, rate, parent_rate, index);
+}
+
+const struct clk_ops pic32_roclk_ops = {
+	.enable			= roclk_enable,
+	.disable		= roclk_disable,
+	.is_enabled		= roclk_is_enabled,
+	.get_parent		= roclk_get_parent,
+	.set_parent		= roclk_set_parent,
+	.determine_rate		= roclk_determine_rate,
+	.recalc_rate		= roclk_recalc_rate,
+	.set_rate_and_parent	= roclk_set_rate_and_parent,
+	.set_rate		= roclk_set_rate,
+	.init			= roclk_init,
+};
+
+struct clk *pic32_refo_clk_register(const struct pic32_ref_osc_data *data,
+				    struct pic32_clk_common *core)
+{
+	struct pic32_ref_osc *refo;
+	struct clk *clk;
+
+	refo = devm_kzalloc(core->dev, sizeof(*refo), GFP_KERNEL);
+	if (!refo)
+		return ERR_PTR(-ENOMEM);
+
+	refo->core = core;
+	refo->hw.init = &data->init_data;
+	refo->ctrl_reg = data->ctrl_reg + core->iobase;
+	refo->parent_map = data->parent_map;
+
+	clk = devm_clk_register(core->dev, &refo->hw);
+	if (IS_ERR(clk))
+		dev_err(core->dev, "%s: clk_register() failed\n", __func__);
+
+	return clk;
+}
+
+struct pic32_sys_pll {
+	struct clk_hw hw;
+	void __iomem *ctrl_reg;
+	void __iomem *status_reg;
+	u32 lock_mask;
+	u32 idiv; /* PLL iclk divider, treated fixed */
+	struct pic32_clk_common *core;
+};
+
+#define clkhw_to_spll(_hw)	container_of(_hw, struct pic32_sys_pll, hw)
+
+static inline u32 spll_odiv_to_divider(u32 odiv)
+{
+	odiv = clamp_val(odiv, PLL_ODIV_MIN, PLL_ODIV_MAX);
+
+	return 1 << odiv;
+}
+
+static unsigned long spll_calc_mult_div(struct pic32_sys_pll *pll,
+					unsigned long rate,
+					unsigned long parent_rate,
+					u32 *mult_p, u32 *odiv_p)
+{
+	u32 mul, div, best_mul = 1, best_div = 1;
+	unsigned long new_rate, best_rate = rate;
+	unsigned int best_delta = -1, delta, match_found = 0;
+	u64 rate64;
+
+	parent_rate /= pll->idiv;
+
+	for (mul = 1; mul <= PLL_MULT_MAX; mul++) {
+		for (div = PLL_ODIV_MIN; div <= PLL_ODIV_MAX; div++) {
+			rate64 = parent_rate;
+			rate64 *= mul;
+			do_div(rate64, 1 << div);
+			new_rate = rate64;
+			delta = abs(rate - new_rate);
+			if ((new_rate >= rate) && (delta < best_delta)) {
+				best_delta = delta;
+				best_rate = new_rate;
+				best_mul = mul;
+				best_div = div;
+				match_found = 1;
+			}
+		}
+	}
+
+	if (!match_found) {
+		pr_warn("spll: no match found\n");
+		return 0;
+	}
+
+	pr_debug("rate %lu, par_rate %lu/mult %u, div %u, best_rate %lu\n",
+		 rate, parent_rate, best_mul, best_div, best_rate);
+
+	if (mult_p)
+		*mult_p = best_mul - 1;
+
+	if (odiv_p)
+		*odiv_p = best_div;
+
+	return best_rate;
+}
+
+static unsigned long spll_clk_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct pic32_sys_pll *pll = clkhw_to_spll(hw);
+	unsigned long pll_in_rate;
+	u32 mult, odiv, div, v;
+	u64 rate64;
+
+	v = readl(pll->ctrl_reg);
+	odiv = ((v >> PLL_ODIV_SHIFT) & PLL_ODIV_MASK);
+	mult = ((v >> PLL_MULT_SHIFT) & PLL_MULT_MASK) + 1;
+	div = spll_odiv_to_divider(odiv);
+
+	/* pll_in_rate = parent_rate / idiv
+	 * pll_out_rate = pll_in_rate * mult / div;
+	 */
+	pll_in_rate = parent_rate / pll->idiv;
+	rate64 = pll_in_rate;
+	rate64 *= mult;
+	do_div(rate64, div);
+
+	return rate64;
+}
+
+static long spll_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate)
+{
+	struct pic32_sys_pll *pll = clkhw_to_spll(hw);
+
+	return spll_calc_mult_div(pll, rate, *parent_rate, NULL, NULL);
+}
+
+static int spll_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct pic32_sys_pll *pll = clkhw_to_spll(hw);
+	unsigned long ret, flags;
+	u32 mult, odiv, v;
+	int err;
+
+	ret = spll_calc_mult_div(pll, rate, parent_rate, &mult, &odiv);
+	if (!ret)
+		return -EINVAL;
+
+	/*
+	 * We can't change SPLL counters when it is in-active use
+	 * by SYSCLK. So check before applying new counters/rate.
+	 */
+
+	/* Is spll_clk active parent of sys_clk ? */
+	if (unlikely(clk_hw_get_parent(pic32_sclk_hw) == hw)) {
+		pr_err("%s: failed, clk in-use\n", __func__);
+		return -EBUSY;
+	}
+
+	spin_lock_irqsave(&pll->core->reg_lock, flags);
+
+	/* apply new multiplier & divisor */
+	v = readl(pll->ctrl_reg);
+	v &= ~(PLL_MULT_MASK << PLL_MULT_SHIFT);
+	v &= ~(PLL_ODIV_MASK << PLL_ODIV_SHIFT);
+	v |= (mult << PLL_MULT_SHIFT) | (odiv << PLL_ODIV_SHIFT);
+
+	/* sys unlock before write */
+	pic32_syskey_unlock();
+
+	writel(v, pll->ctrl_reg);
+	cpu_relax();
+
+	/* insert few nops (5-stage) to ensure CPU does not hang */
+	cpu_nop5();
+	cpu_nop5();
+
+	/* Wait until PLL is locked (maximum 100 usecs). */
+	err = readl_poll_timeout_atomic(pll->status_reg, v,
+					v & pll->lock_mask, 1, 100);
+	spin_unlock_irqrestore(&pll->core->reg_lock, flags);
+
+	return err;
+}
+
+/* SPLL clock operation */
+const struct clk_ops pic32_spll_ops = {
+	.recalc_rate	= spll_clk_recalc_rate,
+	.round_rate	= spll_clk_round_rate,
+	.set_rate	= spll_clk_set_rate,
+};
+
+struct clk *pic32_spll_clk_register(const struct pic32_sys_pll_data *data,
+				    struct pic32_clk_common *core)
+{
+	struct pic32_sys_pll *spll;
+	struct clk *clk;
+
+	spll = devm_kzalloc(core->dev, sizeof(*spll), GFP_KERNEL);
+	if (!spll)
+		return ERR_PTR(-ENOMEM);
+
+	spll->core = core;
+	spll->hw.init = &data->init_data;
+	spll->ctrl_reg = data->ctrl_reg + core->iobase;
+	spll->status_reg = data->status_reg + core->iobase;
+	spll->lock_mask = data->lock_mask;
+
+	/* cache PLL idiv; PLL driver uses it as constant.*/
+	spll->idiv = (readl(spll->ctrl_reg) >> PLL_IDIV_SHIFT) & PLL_IDIV_MASK;
+	spll->idiv += 1;
+
+	clk = devm_clk_register(core->dev, &spll->hw);
+	if (IS_ERR(clk))
+		dev_err(core->dev, "sys_pll: clk_register() failed\n");
+
+	return clk;
+}
+
+/* System mux clock(aka SCLK) */
+
+struct pic32_sys_clk {
+	struct clk_hw hw;
+	void __iomem *mux_reg;
+	void __iomem *slew_reg;
+	u32 slew_div;
+	const u32 *parent_map;
+	struct pic32_clk_common *core;
+};
+
+#define clkhw_to_sys_clk(_hw)	container_of(_hw, struct pic32_sys_clk, hw)
+
+static unsigned long sclk_get_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct pic32_sys_clk *sclk = clkhw_to_sys_clk(hw);
+	u32 div;
+
+	div = (readl(sclk->slew_reg) >> SLEW_SYSDIV_SHIFT) & SLEW_SYSDIV;
+	div += 1; /* sys-div to divider */
+
+	return parent_rate / div;
+}
+
+static long sclk_round_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long *parent_rate)
+{
+	return calc_best_divided_rate(rate, *parent_rate, SLEW_SYSDIV, 1);
+}
+
+static int sclk_set_rate(struct clk_hw *hw,
+			 unsigned long rate, unsigned long parent_rate)
+{
+	struct pic32_sys_clk *sclk = clkhw_to_sys_clk(hw);
+	unsigned long flags;
+	u32 v, div;
+	int err;
+
+	div = parent_rate / rate;
+
+	spin_lock_irqsave(&sclk->core->reg_lock, flags);
+
+	/* apply new div */
+	v = readl(sclk->slew_reg);
+	v &= ~(SLEW_SYSDIV << SLEW_SYSDIV_SHIFT);
+	v |= (div - 1) << SLEW_SYSDIV_SHIFT;
+
+	pic32_syskey_unlock();
+
+	writel(v, sclk->slew_reg);
+
+	/* wait until BUSY is cleared */
+	err = readl_poll_timeout_atomic(sclk->slew_reg, v,
+					!(v & SLEW_BUSY), 1, LOCK_TIMEOUT_US);
+
+	spin_unlock_irqrestore(&sclk->core->reg_lock, flags);
+
+	return err;
+}
+
+static u8 sclk_get_parent(struct clk_hw *hw)
+{
+	struct pic32_sys_clk *sclk = clkhw_to_sys_clk(hw);
+	u32 i, v;
+
+	v = (readl(sclk->mux_reg) >> OSC_CUR_SHIFT) & OSC_CUR_MASK;
+
+	if (!sclk->parent_map)
+		return v;
+
+	for (i = 0; i < clk_hw_get_num_parents(hw); i++)
+		if (sclk->parent_map[i] == v)
+			return i;
+	return -EINVAL;
+}
+
+static int sclk_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct pic32_sys_clk *sclk = clkhw_to_sys_clk(hw);
+	unsigned long flags;
+	u32 nosc, cosc, v;
+	int err;
+
+	spin_lock_irqsave(&sclk->core->reg_lock, flags);
+
+	/* find new_osc */
+	nosc = sclk->parent_map ? sclk->parent_map[index] : index;
+
+	/* set new parent */
+	v = readl(sclk->mux_reg);
+	v &= ~(OSC_NEW_MASK << OSC_NEW_SHIFT);
+	v |= nosc << OSC_NEW_SHIFT;
+
+	pic32_syskey_unlock();
+
+	writel(v, sclk->mux_reg);
+
+	/* initate switch */
+	writel(OSC_SWEN, PIC32_SET(sclk->mux_reg));
+	cpu_relax();
+
+	/* add nop to flush pipeline (as cpu_clk is in-flux) */
+	cpu_nop5();
+
+	/* wait for SWEN bit to clear */
+	err = readl_poll_timeout_atomic(sclk->slew_reg, v,
+					!(v & OSC_SWEN), 1, LOCK_TIMEOUT_US);
+
+	spin_unlock_irqrestore(&sclk->core->reg_lock, flags);
+
+	/*
+	 * SCLK clock-switching logic might reject a clock switching request
+	 * if pre-requisites (like new clk_src not present or unstable) are
+	 * not met.
+	 * So confirm before claiming success.
+	 */
+	cosc = (readl(sclk->mux_reg) >> OSC_CUR_SHIFT) & OSC_CUR_MASK;
+	if (cosc != nosc) {
+		pr_err("%s: err, failed to set_parent() to %d, current %d\n",
+		       clk_hw_get_name(hw), nosc, cosc);
+		err = -EBUSY;
+	}
+
+	return err;
+}
+
+static void sclk_init(struct clk_hw *hw)
+{
+	struct pic32_sys_clk *sclk = clkhw_to_sys_clk(hw);
+	unsigned long flags;
+	u32 v;
+
+	/* Maintain reference to this clk, required in spll_clk_set_rate() */
+	pic32_sclk_hw = hw;
+
+	/* apply slew divider on both up and down scaling */
+	if (sclk->slew_div) {
+		spin_lock_irqsave(&sclk->core->reg_lock, flags);
+		v = readl(sclk->slew_reg);
+		v &= ~(SLEW_DIV << SLEW_DIV_SHIFT);
+		v |= sclk->slew_div << SLEW_DIV_SHIFT;
+		v |= SLEW_DOWNEN | SLEW_UPEN;
+		writel(v, sclk->slew_reg);
+		spin_unlock_irqrestore(&sclk->core->reg_lock, flags);
+	}
+}
+
+/* sclk with post-divider */
+const struct clk_ops pic32_sclk_ops = {
+	.get_parent	= sclk_get_parent,
+	.set_parent	= sclk_set_parent,
+	.round_rate	= sclk_round_rate,
+	.set_rate	= sclk_set_rate,
+	.recalc_rate	= sclk_get_rate,
+	.init		= sclk_init,
+	.determine_rate = __clk_mux_determine_rate,
+};
+
+/* sclk with no slew and no post-divider */
+const struct clk_ops pic32_sclk_no_div_ops = {
+	.get_parent	= sclk_get_parent,
+	.set_parent	= sclk_set_parent,
+	.init		= sclk_init,
+	.determine_rate = __clk_mux_determine_rate,
+};
+
+struct clk *pic32_sys_clk_register(const struct pic32_sys_clk_data *data,
+				   struct pic32_clk_common *core)
+{
+	struct pic32_sys_clk *sclk;
+	struct clk *clk;
+
+	sclk = devm_kzalloc(core->dev, sizeof(*sclk), GFP_KERNEL);
+	if (!sclk)
+		return ERR_PTR(-ENOMEM);
+
+	sclk->core = core;
+	sclk->hw.init = &data->init_data;
+	sclk->mux_reg = data->mux_reg + core->iobase;
+	sclk->slew_reg = data->slew_reg + core->iobase;
+	sclk->slew_div = data->slew_div;
+	sclk->parent_map = data->parent_map;
+
+	clk = devm_clk_register(core->dev, &sclk->hw);
+	if (IS_ERR(clk))
+		dev_err(core->dev, "%s: clk register failed\n", __func__);
+
+	return clk;
+}
+
+/* secondary oscillator */
+struct pic32_sec_osc {
+	struct clk_hw hw;
+	void __iomem *enable_reg;
+	void __iomem *status_reg;
+	u32 enable_mask;
+	u32 status_mask;
+	unsigned long fixed_rate;
+	struct pic32_clk_common *core;
+};
+
+#define clkhw_to_sosc(_hw)	container_of(_hw, struct pic32_sec_osc, hw)
+static int sosc_clk_enable(struct clk_hw *hw)
+{
+	struct pic32_sec_osc *sosc = clkhw_to_sosc(hw);
+	u32 v;
+
+	/* enable SOSC */
+	pic32_syskey_unlock();
+	writel(sosc->enable_mask, PIC32_SET(sosc->enable_reg));
+
+	/* wait till warm-up period expires or ready-status is updated */
+	return readl_poll_timeout_atomic(sosc->status_reg, v,
+					 v & sosc->status_mask, 1, 100);
+}
+
+static void sosc_clk_disable(struct clk_hw *hw)
+{
+	struct pic32_sec_osc *sosc = clkhw_to_sosc(hw);
+
+	pic32_syskey_unlock();
+	writel(sosc->enable_mask, PIC32_CLR(sosc->enable_reg));
+}
+
+static int sosc_clk_is_enabled(struct clk_hw *hw)
+{
+	struct pic32_sec_osc *sosc = clkhw_to_sosc(hw);
+	u32 enabled, ready;
+
+	/* check enabled and ready status */
+	enabled = readl(sosc->enable_reg) & sosc->enable_mask;
+	ready = readl(sosc->status_reg) & sosc->status_mask;
+
+	return enabled && ready;
+}
+
+static unsigned long sosc_clk_calc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	return clkhw_to_sosc(hw)->fixed_rate;
+}
+
+const struct clk_ops pic32_sosc_ops = {
+	.enable = sosc_clk_enable,
+	.disable = sosc_clk_disable,
+	.is_enabled = sosc_clk_is_enabled,
+	.recalc_rate = sosc_clk_calc_rate,
+};
+
+struct clk *pic32_sosc_clk_register(const struct pic32_sec_osc_data *data,
+				    struct pic32_clk_common *core)
+{
+	struct pic32_sec_osc *sosc;
+
+	sosc = devm_kzalloc(core->dev, sizeof(*sosc), GFP_KERNEL);
+	if (!sosc)
+		return ERR_PTR(-ENOMEM);
+
+	sosc->core = core;
+	sosc->hw.init = &data->init_data;
+	sosc->fixed_rate = data->fixed_rate;
+	sosc->enable_mask = data->enable_mask;
+	sosc->status_mask = data->status_mask;
+	sosc->enable_reg = data->enable_reg + core->iobase;
+	sosc->status_reg = data->status_reg + core->iobase;
+
+	return devm_clk_register(core->dev, &sosc->hw);
+}
diff --git a/drivers/clk/microchip/clk-core.h b/drivers/clk/microchip/clk-core.h
new file mode 100644
index 0000000..8566642
--- /dev/null
+++ b/drivers/clk/microchip/clk-core.h
@@ -0,0 +1,84 @@
+/*
+ * Purna Chandra Mandal,<purna.mandal@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ * This program is free software; you can distribute it and/or modify it
+ * under the terms of the GNU General Public License (Version 2) as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ */
+#ifndef __MICROCHIP_CLK_PIC32_H_
+#define __MICROCHIP_CLK_PIC32_H_
+
+#include <linux/clk-provider.h>
+
+/* PIC32 clock data */
+struct pic32_clk_common {
+	struct device *dev;
+	void __iomem *iobase;
+	spinlock_t reg_lock; /* clock lock */
+};
+
+/* System PLL clock */
+struct pic32_sys_pll_data {
+	struct clk_init_data init_data;
+	const u32 ctrl_reg;
+	const u32 status_reg;
+	const u32 lock_mask;
+};
+
+/* System clock */
+struct pic32_sys_clk_data {
+	struct clk_init_data init_data;
+	const u32 mux_reg;
+	const u32 slew_reg;
+	const u32 *parent_map;
+	const u32 slew_div;
+};
+
+/* Reference Oscillator clock */
+struct pic32_ref_osc_data {
+	struct clk_init_data init_data;
+	const u32 ctrl_reg;
+	const u32 *parent_map;
+};
+
+/* Peripheral Bus clock */
+struct pic32_periph_clk_data {
+	struct clk_init_data init_data;
+	const u32 ctrl_reg;
+};
+
+/* External Secondary Oscillator clock  */
+struct pic32_sec_osc_data {
+	struct clk_init_data init_data;
+	const u32 enable_reg;
+	const u32 status_reg;
+	const u32 enable_mask;
+	const u32 status_mask;
+	const unsigned long fixed_rate;
+};
+
+extern const struct clk_ops pic32_pbclk_ops;
+extern const struct clk_ops pic32_sclk_ops;
+extern const struct clk_ops pic32_sclk_no_div_ops;
+extern const struct clk_ops pic32_spll_ops;
+extern const struct clk_ops pic32_roclk_ops;
+extern const struct clk_ops pic32_sosc_ops;
+
+struct clk *pic32_periph_clk_register(const struct pic32_periph_clk_data *data,
+				      struct pic32_clk_common *core);
+struct clk *pic32_refo_clk_register(const struct pic32_ref_osc_data *data,
+				    struct pic32_clk_common *core);
+struct clk *pic32_sys_clk_register(const struct pic32_sys_clk_data *data,
+				   struct pic32_clk_common *core);
+struct clk *pic32_spll_clk_register(const struct pic32_sys_pll_data *data,
+				    struct pic32_clk_common *core);
+struct clk *pic32_sosc_clk_register(const struct pic32_sec_osc_data *data,
+				    struct pic32_clk_common *core);
+
+#endif /* __MICROCHIP_CLK_PIC32_H_*/
diff --git a/drivers/clk/microchip/clk-pic32mzda.c b/drivers/clk/microchip/clk-pic32mzda.c
new file mode 100644
index 0000000..020a29a
--- /dev/null
+++ b/drivers/clk/microchip/clk-pic32mzda.c
@@ -0,0 +1,275 @@
+/*
+ * Purna Chandra Mandal,<purna.mandal@microchip.com>
+ * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
+ *
+ * This program is free software; you can distribute it and/or modify it
+ * under the terms of the GNU General Public License (Version 2) as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ */
+#include <dt-bindings/clock/microchip,pic32-clock.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <asm/traps.h>
+
+#include "clk-core.h"
+
+/* FRC Postscaler */
+#define OSC_FRCDIV_MASK		0x07
+#define OSC_FRCDIV_SHIFT	24
+
+/* SPLL fields */
+#define PLL_ICLK_MASK		0x01
+#define PLL_ICLK_SHIFT		7
+
+#define DECLARE_PERIPHERAL_CLOCK(__clk_name, __reg, __flags)	\
+	{							\
+		.ctrl_reg = (__reg),				\
+		.init_data = {					\
+			.name = (__clk_name),			\
+			.parent_names = (const char *[]) {	\
+				"sys_clk"			\
+			},					\
+			.num_parents = 1,			\
+			.ops = &pic32_pbclk_ops,		\
+			.flags = (__flags),			\
+		},						\
+	}
+
+#define DECLARE_REFO_CLOCK(__clkid, __reg)				\
+	{								\
+		.ctrl_reg = (__reg),					\
+		.init_data = {						\
+			.name = "refo" #__clkid "_clk",			\
+			.parent_names = (const char *[]) {		\
+				"sys_clk", "pb1_clk", "posc_clk",	\
+				"frc_clk", "lprc_clk", "sosc_clk",	\
+				"sys_pll", "refi" #__clkid "_clk",	\
+				"bfrc_clk",				\
+			},						\
+			.num_parents = 9,				\
+			.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE,\
+			.ops = &pic32_roclk_ops,			\
+		},							\
+		.parent_map = (const u32[]) {				\
+			0, 1, 2, 3, 4, 5, 7, 8, 9			\
+		},							\
+	}
+
+static const struct pic32_ref_osc_data ref_clks[] = {
+	DECLARE_REFO_CLOCK(1, 0x80),
+	DECLARE_REFO_CLOCK(2, 0xa0),
+	DECLARE_REFO_CLOCK(3, 0xc0),
+	DECLARE_REFO_CLOCK(4, 0xe0),
+	DECLARE_REFO_CLOCK(5, 0x100),
+};
+
+static const struct pic32_periph_clk_data periph_clocks[] = {
+	DECLARE_PERIPHERAL_CLOCK("pb1_clk", 0x140, 0),
+	DECLARE_PERIPHERAL_CLOCK("pb2_clk", 0x150, CLK_IGNORE_UNUSED),
+	DECLARE_PERIPHERAL_CLOCK("pb3_clk", 0x160, 0),
+	DECLARE_PERIPHERAL_CLOCK("pb4_clk", 0x170, 0),
+	DECLARE_PERIPHERAL_CLOCK("pb5_clk", 0x180, 0),
+	DECLARE_PERIPHERAL_CLOCK("pb6_clk", 0x190, 0),
+	DECLARE_PERIPHERAL_CLOCK("cpu_clk", 0x1a0, CLK_IGNORE_UNUSED),
+};
+
+static const struct pic32_sys_clk_data sys_mux_clk = {
+	.slew_reg = 0x1c0,
+	.slew_div = 2, /* step of div_4 -> div_2 -> no_div */
+	.init_data = {
+		.name = "sys_clk",
+		.parent_names = (const char *[]) {
+			"frcdiv_clk", "sys_pll", "posc_clk",
+			"sosc_clk", "lprc_clk", "frcdiv_clk",
+		},
+		.num_parents = 6,
+		.ops = &pic32_sclk_ops,
+	},
+	.parent_map = (const u32[]) {
+		0, 1, 2, 4, 5, 7,
+	},
+};
+
+static const struct pic32_sys_pll_data sys_pll = {
+	.ctrl_reg = 0x020,
+	.status_reg = 0x1d0,
+	.lock_mask = BIT(7),
+	.init_data = {
+		.name = "sys_pll",
+		.parent_names = (const char *[]) {
+			"spll_mux_clk"
+		},
+		.num_parents = 1,
+		.ops = &pic32_spll_ops,
+	},
+};
+
+static const struct pic32_sec_osc_data sosc_clk = {
+	.status_reg = 0x1d0,
+	.enable_mask = BIT(1),
+	.status_mask = BIT(4),
+	.init_data = {
+		.name = "sosc_clk",
+		.parent_names = NULL,
+		.ops = &pic32_sosc_ops,
+	},
+};
+
+static int pic32mzda_critical_clks[] = {
+	PB2CLK, PB7CLK
+};
+
+/* PIC32MZDA clock data */
+struct pic32mzda_clk_data {
+	struct clk *clks[MAXCLKS];
+	struct pic32_clk_common core;
+	struct clk_onecell_data onecell_data;
+	struct notifier_block failsafe_notifier;
+};
+
+static int pic32_fscm_nmi(struct notifier_block *nb,
+			  unsigned long action, void *data)
+{
+	struct pic32mzda_clk_data *cd;
+
+	cd  = container_of(nb, struct pic32mzda_clk_data, failsafe_notifier);
+
+	/* SYSCLK is now running from BFRCCLK. Report clock failure. */
+	if (readl(cd->core.iobase) & BIT(2))
+		pr_alert("pic32-clk: FSCM detected clk failure.\n");
+
+	/* TODO: detect reason of failure and recover accordingly */
+
+	return NOTIFY_OK;
+}
+
+static int pic32mzda_clk_probe(struct platform_device *pdev)
+{
+	const char *const pll_mux_parents[] = {"posc_clk", "frc_clk"};
+	struct device_node *np = pdev->dev.of_node;
+	struct pic32mzda_clk_data *cd;
+	struct pic32_clk_common *core;
+	struct clk *pll_mux_clk, *clk;
+	struct clk **clks;
+	int nr_clks, i, ret;
+
+	cd = devm_kzalloc(&pdev->dev, sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+
+	core = &cd->core;
+	core->iobase = of_io_request_and_map(np, 0, of_node_full_name(np));
+	if (IS_ERR(core->iobase)) {
+		dev_err(&pdev->dev, "pic32-clk: failed to map registers\n");
+		return PTR_ERR(core->iobase);
+	}
+
+	spin_lock_init(&core->reg_lock);
+	core->dev = &pdev->dev;
+	clks = &cd->clks[0];
+
+	/* register fixed rate clocks */
+	clks[POSCCLK] = clk_register_fixed_rate(&pdev->dev, "posc_clk", NULL,
+						CLK_IS_ROOT, 24000000);
+	clks[FRCCLK] =  clk_register_fixed_rate(&pdev->dev, "frc_clk", NULL,
+						CLK_IS_ROOT, 8000000);
+	clks[BFRCCLK] = clk_register_fixed_rate(&pdev->dev, "bfrc_clk", NULL,
+						CLK_IS_ROOT, 8000000);
+	clks[LPRCCLK] = clk_register_fixed_rate(&pdev->dev, "lprc_clk", NULL,
+						CLK_IS_ROOT, 32000);
+	clks[UPLLCLK] = clk_register_fixed_rate(&pdev->dev, "usbphy_clk", NULL,
+						CLK_IS_ROOT, 24000000);
+	/* fixed rate (optional) clock */
+	if (of_find_property(np, "microchip,pic32mzda-sosc", NULL)) {
+		pr_info("pic32-clk: dt requests SOSC.\n");
+		clks[SOSCCLK] = pic32_sosc_clk_register(&sosc_clk, core);
+	}
+	/* divider clock */
+	clks[FRCDIVCLK] = clk_register_divider(&pdev->dev, "frcdiv_clk",
+					       "frc_clk", 0,
+					       core->iobase,
+					       OSC_FRCDIV_SHIFT,
+					       OSC_FRCDIV_MASK,
+					       CLK_DIVIDER_POWER_OF_TWO,
+					       &core->reg_lock);
+	/* PLL ICLK mux */
+	pll_mux_clk = clk_register_mux(&pdev->dev, "spll_mux_clk",
+				       pll_mux_parents, 2, 0,
+				       core->iobase + 0x020,
+				       PLL_ICLK_SHIFT, 1, 0, &core->reg_lock);
+	if (IS_ERR(pll_mux_clk))
+		pr_err("spll_mux_clk: clk register failed\n");
+
+	/* PLL */
+	clks[PLLCLK] = pic32_spll_clk_register(&sys_pll, core);
+	/* SYSTEM clock */
+	clks[SCLK] = pic32_sys_clk_register(&sys_mux_clk, core);
+	/* Peripheral bus clocks */
+	for (nr_clks = PB1CLK, i = 0; nr_clks <= PB7CLK; i++, nr_clks++)
+		clks[nr_clks] = pic32_periph_clk_register(&periph_clocks[i],
+							  core);
+	/* Reference oscillator clock */
+	for (nr_clks = REF1CLK, i = 0; nr_clks <= REF5CLK; i++, nr_clks++)
+		clks[nr_clks] = pic32_refo_clk_register(&ref_clks[i], core);
+
+	/* register clkdev */
+	for (i = 0; i < MAXCLKS; i++) {
+		if (IS_ERR(clks[i]))
+			continue;
+		clk_register_clkdev(clks[i], NULL, __clk_get_name(clks[i]));
+	}
+
+	/* register clock provider */
+	cd->onecell_data.clks = clks;
+	cd->onecell_data.clk_num = MAXCLKS;
+	ret = of_clk_add_provider(np, of_clk_src_onecell_get,
+				  &cd->onecell_data);
+	if (ret)
+		return ret;
+
+	/* force enable critical clocks */
+	for (i = 0; i < ARRAY_SIZE(pic32mzda_critical_clks); i++) {
+		clk = clks[pic32mzda_critical_clks[i]];
+		if (clk_prepare_enable(clk))
+			dev_err(&pdev->dev, "clk_prepare_enable(%s) failed\n",
+				__clk_get_name(clk));
+	}
+
+	/* register NMI for failsafe clock monitor */
+	cd->failsafe_notifier.notifier_call = pic32_fscm_nmi;
+	return register_nmi_notifier(&cd->failsafe_notifier);
+}
+
+static const struct of_device_id pic32mzda_clk_match_table[] = {
+	{ .compatible = "microchip,pic32mzda-clk", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pic32mzda_clk_match_table);
+
+static struct platform_driver pic32mzda_clk_driver = {
+	.probe		= pic32mzda_clk_probe,
+	.driver		= {
+		.name	= "clk-pic32mzda",
+		.of_match_table = pic32mzda_clk_match_table,
+	},
+};
+
+static int __init microchip_pic32mzda_clk_init(void)
+{
+	return platform_driver_register(&pic32mzda_clk_driver);
+}
+core_initcall(microchip_pic32mzda_clk_init);
+
+MODULE_DESCRIPTION("Microchip PIC32MZDA Clock Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:clk-pic32mzda");
-- 
1.8.3.1
