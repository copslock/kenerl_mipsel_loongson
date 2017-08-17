Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 20:26:46 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:34409
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994887AbdHQS0UvXSr7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 20:26:20 +0200
Received: by mail-pg0-x242.google.com with SMTP id y192so11081080pgd.1;
        Thu, 17 Aug 2017 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+iwvSxf9G1cvbaDm4L8roKIsTufeLM/UH/73g6pVJWk=;
        b=R95YzTPdPRc37hyUb+O+ejWhhUrXwFHXreeCbSzzS6BSQVt+zVHJyBETSuOAzqKBjH
         nKEIINxVOuzQVAiaCbqcAZ4RHqB2Llg1AEsLSnpW2FzoP6j1qu7Nner9cZszXrz7hEH0
         4R4L7X+b/7HCQOJWuDsdw2wqmhX34tcxz3RQuVsJusdMizAyJZDqE78cUjKEYO1utOX8
         d6wppK4VaaL0pzGjvZCHel6Hm0P9Uv9sIGmBJm0OMg2c+m9yiZ18MYddsHwdO6mDqi4k
         MXzhmrN99CaEN/2lr9doIeKeI87hc606Xx856iPNCEA2FT7qEQHFzWleBSGjECnj/No1
         mWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+iwvSxf9G1cvbaDm4L8roKIsTufeLM/UH/73g6pVJWk=;
        b=NPpJMbNHjC5TsQ4wzReaFa9B9j5ggbNtxB3/c7bDvDHnSC0yZsoTQJ2Rmamb15Guft
         8Q6rKPsr3f7E0xACtrnEjaAibiR7FMtKxjAPrXnOU+aGBpzSeKGGxlfdAgYYQTrLDQVT
         QE4bKcOZnDRottumHO4q0uei0bIbBN60vluPq65I3XpjlEZSKg63sCTDKiccapBPKjey
         VuMs59vWGTqxiQwpFeVb6gnepU1mZAIabN6diK36Uf7HDEZ8PwaCURxjjnFHRM6RzVwn
         lQ9DNCiqGT/yO8HITn3i4/1kv1CGszHbQJTbqah7qjIyroY4bQIYFPQN2j/VJntV92OY
         8rQg==
X-Gm-Message-State: AHYfb5gMolqO94c9Sf/wgafR5/AgnHqdMxm982bbd15Vlhfi3eeAJju1
        Z5aDYBMmZyb3UQ==
X-Received: by 10.99.111.134 with SMTP id k128mr5810454pgc.431.1502994374702;
        Thu, 17 Aug 2017 11:26:14 -0700 (PDT)
Received: from linux.local ([42.109.133.212])
        by smtp.gmail.com with ESMTPSA id a86sm8882565pfe.181.2017.08.17.11.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 11:26:13 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, mturquette@baylibre.com,
        sboyd@codeaurora.org, davem@davemloft.net, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH 2/6] crypto: jz4780-rng: Make ingenic CGU driver use syscon
Date:   Thu, 17 Aug 2017 23:55:16 +0530
Message-Id: <20170817182520.20102-3-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
References: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59630
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

Ingenic PRNG registers are a part of the same hardware block as clock
and power stuff. It is handled by CGU driver. Ingenic M200 SoC has power
related registers that are after the PRNG registers. So instead of
shortening the register range use syscon interface to expose regmap.
This regmap is used by the PRNG driver.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 arch/mips/boot/dts/ingenic/jz4740.dtsi | 14 +++++++----
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 14 +++++++----
 drivers/clk/ingenic/cgu.c              | 46 +++++++++++++++++++++-------------
 drivers/clk/ingenic/cgu.h              |  9 +++++--
 drivers/clk/ingenic/jz4740-cgu.c       | 30 +++++++++++-----------
 drivers/clk/ingenic/jz4780-cgu.c       | 10 ++++----
 6 files changed, 73 insertions(+), 50 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 2ca7ce7..ada5e67 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -34,14 +34,18 @@
 		clock-frequency = <32768>;
 	};
 
-	cgu: jz4740-cgu@10000000 {
-		compatible = "ingenic,jz4740-cgu";
+	cgu_registers {
+		compatible = "simple-mfd", "syscon";
 		reg = <0x10000000 0x100>;
 
-		clocks = <&ext>, <&rtc>;
-		clock-names = "ext", "rtc";
+		cgu: jz4780-cgu@10000000 {
+			compatible = "ingenic,jz4740-cgu";
 
-		#clock-cells = <1>;
+			clocks = <&ext>, <&rtc>;
+			clock-names = "ext", "rtc";
+
+			#clock-cells = <1>;
+		};
 	};
 
 	rtc_dev: rtc@10003000 {
diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 4853ef6..1301694 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -34,14 +34,18 @@
 		clock-frequency = <32768>;
 	};
 
-	cgu: jz4780-cgu@10000000 {
-		compatible = "ingenic,jz4780-cgu";
+	cgu_registers {
+		compatible = "simple-mfd", "syscon";
 		reg = <0x10000000 0x100>;
 
-		clocks = <&ext>, <&rtc>;
-		clock-names = "ext", "rtc";
+		cgu: jz4780-cgu@10000000 {
+			compatible = "ingenic,jz4780-cgu";
 
-		#clock-cells = <1>;
+			clocks = <&ext>, <&rtc>;
+			clock-names = "ext", "rtc";
+
+			#clock-cells = <1>;
+		};
 	};
 
 	pinctrl: pin-controller@10010000 {
diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index e8248f9..2f12c7c 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -29,6 +29,18 @@
 
 #define MHZ (1000 * 1000)
 
+unsigned int cgu_readl(struct ingenic_cgu *cgu, unsigned int reg)
+{
+	unsigned int val = 0;
+	regmap_read(cgu->regmap, reg, &val);
+	return val;
+}
+
+int cgu_writel(struct ingenic_cgu *cgu, unsigned int val, unsigned int reg)
+{
+	return regmap_write(cgu->regmap, reg, val);
+}
+
 /**
  * ingenic_cgu_gate_get() - get the value of clock gate register bit
  * @cgu: reference to the CGU whose registers should be read
@@ -43,7 +55,7 @@ static inline bool
 ingenic_cgu_gate_get(struct ingenic_cgu *cgu,
 		     const struct ingenic_cgu_gate_info *info)
 {
-	return readl(cgu->base + info->reg) & BIT(info->bit);
+	return cgu_readl(cgu, info->reg) & BIT(info->bit);
 }
 
 /**
@@ -60,14 +72,14 @@ static inline void
 ingenic_cgu_gate_set(struct ingenic_cgu *cgu,
 		     const struct ingenic_cgu_gate_info *info, bool val)
 {
-	u32 clkgr = readl(cgu->base + info->reg);
+	u32 clkgr = cgu_readl(cgu, info->reg);
 
 	if (val)
 		clkgr |= BIT(info->bit);
 	else
 		clkgr &= ~BIT(info->bit);
 
-	writel(clkgr, cgu->base + info->reg);
+	cgu_writel(cgu, clkgr, info->reg);
 }
 
 /*
@@ -91,7 +103,7 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	pll_info = &clk_info->pll;
 
 	spin_lock_irqsave(&cgu->lock, flags);
-	ctl = readl(cgu->base + pll_info->reg);
+	ctl = cgu_readl(cgu, pll_info->reg);
 	spin_unlock_irqrestore(&cgu->lock, flags);
 
 	m = (ctl >> pll_info->m_shift) & GENMASK(pll_info->m_bits - 1, 0);
@@ -190,7 +202,7 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
 			clk_info->name, req_rate, rate);
 
 	spin_lock_irqsave(&cgu->lock, flags);
-	ctl = readl(cgu->base + pll_info->reg);
+	ctl = cgu_readl(cgu, pll_info->reg);
 
 	ctl &= ~(GENMASK(pll_info->m_bits - 1, 0) << pll_info->m_shift);
 	ctl |= (m - pll_info->m_offset) << pll_info->m_shift;
@@ -204,11 +216,11 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
 	ctl &= ~BIT(pll_info->bypass_bit);
 	ctl |= BIT(pll_info->enable_bit);
 
-	writel(ctl, cgu->base + pll_info->reg);
+	cgu_writel(cgu, ctl, pll_info->reg);
 
 	/* wait for the PLL to stabilise */
 	for (i = 0; i < timeout; i++) {
-		ctl = readl(cgu->base + pll_info->reg);
+		ctl = cgu_readl(cgu, pll_info->reg);
 		if (ctl & BIT(pll_info->stable_bit))
 			break;
 		mdelay(1);
@@ -243,7 +255,7 @@ static u8 ingenic_clk_get_parent(struct clk_hw *hw)
 	clk_info = &cgu->clock_info[ingenic_clk->idx];
 
 	if (clk_info->type & CGU_CLK_MUX) {
-		reg = readl(cgu->base + clk_info->mux.reg);
+		reg = cgu_readl(cgu, clk_info->mux.reg);
 		hw_idx = (reg >> clk_info->mux.shift) &
 			 GENMASK(clk_info->mux.bits - 1, 0);
 
@@ -297,10 +309,10 @@ static int ingenic_clk_set_parent(struct clk_hw *hw, u8 idx)
 		spin_lock_irqsave(&cgu->lock, flags);
 
 		/* write the register */
-		reg = readl(cgu->base + clk_info->mux.reg);
+		reg = cgu_readl(cgu, clk_info->mux.reg);
 		reg &= ~mask;
 		reg |= hw_idx << clk_info->mux.shift;
-		writel(reg, cgu->base + clk_info->mux.reg);
+		cgu_writel(cgu, reg, clk_info->mux.reg);
 
 		spin_unlock_irqrestore(&cgu->lock, flags);
 		return 0;
@@ -321,7 +333,7 @@ ingenic_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	clk_info = &cgu->clock_info[ingenic_clk->idx];
 
 	if (clk_info->type & CGU_CLK_DIV) {
-		div_reg = readl(cgu->base + clk_info->div.reg);
+		div_reg = cgu_readl(cgu, clk_info->div.reg);
 		div = (div_reg >> clk_info->div.shift) &
 		      GENMASK(clk_info->div.bits - 1, 0);
 		div += 1;
@@ -399,7 +411,7 @@ ingenic_clk_set_rate(struct clk_hw *hw, unsigned long req_rate,
 			return -EINVAL;
 
 		spin_lock_irqsave(&cgu->lock, flags);
-		reg = readl(cgu->base + clk_info->div.reg);
+		reg = cgu_readl(cgu, clk_info->div.reg);
 
 		/* update the divide */
 		mask = GENMASK(clk_info->div.bits - 1, 0);
@@ -415,12 +427,12 @@ ingenic_clk_set_rate(struct clk_hw *hw, unsigned long req_rate,
 			reg |= BIT(clk_info->div.ce_bit);
 
 		/* update the hardware */
-		writel(reg, cgu->base + clk_info->div.reg);
+		cgu_writel(cgu, reg, clk_info->div.reg);
 
 		/* wait for the change to take effect */
 		if (clk_info->div.busy_bit != -1) {
 			for (i = 0; i < timeout; i++) {
-				reg = readl(cgu->base + clk_info->div.reg);
+				reg = cgu_readl(cgu, clk_info->div.reg);
 				if (!(reg & BIT(clk_info->div.busy_bit)))
 					break;
 				mdelay(1);
@@ -661,11 +673,9 @@ ingenic_cgu_new(const struct ingenic_cgu_clk_info *clock_info,
 	if (!cgu)
 		goto err_out;
 
-	cgu->base = of_iomap(np, 0);
-	if (!cgu->base) {
-		pr_err("%s: failed to map CGU registers\n", __func__);
+	cgu->regmap = syscon_node_to_regmap(np->parent);
+	if (cgu->regmap == NULL)
 		goto err_out_free;
-	}
 
 	cgu->np = np;
 	cgu->clock_info = clock_info;
diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index 09700b2..86fd5b0 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -19,7 +19,9 @@
 #define __DRIVERS_CLK_INGENIC_CGU_H__
 
 #include <linux/bitops.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
 
 /**
@@ -171,14 +173,14 @@ struct ingenic_cgu_clk_info {
 /**
  * struct ingenic_cgu - data about the CGU
  * @np: the device tree node that caused the CGU to be probed
- * @base: the ioremap'ed base address of the CGU registers
+ * @regmap: the regmap object used to access the CGU registers
  * @clock_info: an array containing information about implemented clocks
  * @clocks: used to provide clocks to DT, allows lookup of struct clk*
  * @lock: lock to be held whilst manipulating CGU registers
  */
 struct ingenic_cgu {
 	struct device_node *np;
-	void __iomem *base;
+	struct regmap *regmap;
 
 	const struct ingenic_cgu_clk_info *clock_info;
 	struct clk_onecell_data clocks;
@@ -186,6 +188,9 @@ struct ingenic_cgu {
 	spinlock_t lock;
 };
 
+unsigned int cgu_readl(struct ingenic_cgu *cgu, unsigned int reg);
+int cgu_writel(struct ingenic_cgu *cgu, unsigned int val, unsigned int reg);
+
 /**
  * struct ingenic_clk - private data for a clock
  * @hw: see Documentation/clk.txt
diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index 510fe7e..3003afb 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -232,7 +232,7 @@ CLK_OF_DECLARE(jz4740_cgu, "ingenic,jz4740-cgu", jz4740_cgu_init);
 
 void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode)
 {
-	uint32_t lcr = readl(cgu->base + CGU_REG_LCR);
+	uint32_t lcr = cgu_readl(cgu, CGU_REG_LCR);
 
 	switch (mode) {
 	case JZ4740_WAIT_MODE_IDLE:
@@ -244,24 +244,24 @@ void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode)
 		break;
 	}
 
-	writel(lcr, cgu->base + CGU_REG_LCR);
+	cgu_writel(cgu, lcr, CGU_REG_LCR);
 }
 
 void jz4740_clock_udc_disable_auto_suspend(void)
 {
-	uint32_t clkgr = readl(cgu->base + CGU_REG_CLKGR);
+	uint32_t clkgr = cgu_readl(cgu, CGU_REG_CLKGR);
 
 	clkgr &= ~CLKGR_UDC;
-	writel(clkgr, cgu->base + CGU_REG_CLKGR);
+	cgu_writel(cgu, clkgr, CGU_REG_CLKGR);
 }
 EXPORT_SYMBOL_GPL(jz4740_clock_udc_disable_auto_suspend);
 
 void jz4740_clock_udc_enable_auto_suspend(void)
 {
-	uint32_t clkgr = readl(cgu->base + CGU_REG_CLKGR);
+	uint32_t clkgr = cgu_readl(cgu, CGU_REG_CLKGR);
 
 	clkgr |= CLKGR_UDC;
-	writel(clkgr, cgu->base + CGU_REG_CLKGR);
+	cgu_writel(cgu, clkgr, CGU_REG_CLKGR);
 }
 EXPORT_SYMBOL_GPL(jz4740_clock_udc_enable_auto_suspend);
 
@@ -273,31 +273,31 @@ void jz4740_clock_suspend(void)
 {
 	uint32_t clkgr, cppcr;
 
-	clkgr = readl(cgu->base + CGU_REG_CLKGR);
+	clkgr = cgu_readl(cgu, CGU_REG_CLKGR);
 	clkgr |= JZ_CLOCK_GATE_TCU | JZ_CLOCK_GATE_DMAC | JZ_CLOCK_GATE_UART0;
-	writel(clkgr, cgu->base + CGU_REG_CLKGR);
+	cgu_writel(cgu, clkgr, CGU_REG_CLKGR);
 
-	cppcr = readl(cgu->base + CGU_REG_CPPCR);
+	cppcr = cgu_readl(cgu, CGU_REG_CPPCR);
 	cppcr &= ~BIT(jz4740_cgu_clocks[JZ4740_CLK_PLL].pll.enable_bit);
-	writel(cppcr, cgu->base + CGU_REG_CPPCR);
+	cgu_writel(cgu, cppcr, CGU_REG_CPPCR);
 }
 
 void jz4740_clock_resume(void)
 {
 	uint32_t clkgr, cppcr, stable;
 
-	cppcr = readl(cgu->base + CGU_REG_CPPCR);
+	cppcr = cgu_readl(cgu, CGU_REG_CPPCR);
 	cppcr |= BIT(jz4740_cgu_clocks[JZ4740_CLK_PLL].pll.enable_bit);
-	writel(cppcr, cgu->base + CGU_REG_CPPCR);
+	cgu_writel(cgu, cppcr, CGU_REG_CPPCR);
 
 	stable = BIT(jz4740_cgu_clocks[JZ4740_CLK_PLL].pll.stable_bit);
 	do {
-		cppcr = readl(cgu->base + CGU_REG_CPPCR);
+		cppcr = cgu_readl(cgu, CGU_REG_CPPCR);
 	} while (!(cppcr & stable));
 
-	clkgr = readl(cgu->base + CGU_REG_CLKGR);
+	clkgr = cgu_readl(cgu, CGU_REG_CLKGR);
 	clkgr &= ~JZ_CLOCK_GATE_TCU;
 	clkgr &= ~JZ_CLOCK_GATE_DMAC;
 	clkgr &= ~JZ_CLOCK_GATE_UART0;
-	writel(clkgr, cgu->base + CGU_REG_CLKGR);
+	cgu_writel(cgu, clkgr, CGU_REG_CLKGR);
 }
diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index b35d6d9..8f83433 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -113,11 +113,11 @@ static int jz4780_otg_phy_set_parent(struct clk_hw *hw, u8 idx)
 
 	spin_lock_irqsave(&cgu->lock, flags);
 
-	usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
+	usbpcr1 = cgu_readl(cgu, CGU_REG_USBPCR1);
 	usbpcr1 &= ~USBPCR1_REFCLKSEL_MASK;
 	/* we only use CLKCORE */
 	usbpcr1 |= USBPCR1_REFCLKSEL_CORE;
-	writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
+	cgu_writel(cgu, usbpcr1, CGU_REG_USBPCR1);
 
 	spin_unlock_irqrestore(&cgu->lock, flags);
 	return 0;
@@ -129,7 +129,7 @@ static unsigned long jz4780_otg_phy_recalc_rate(struct clk_hw *hw,
 	u32 usbpcr1;
 	unsigned refclk_div;
 
-	usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
+	usbpcr1 = cgu_readl(cgu, CGU_REG_USBPCR1);
 	refclk_div = usbpcr1 & USBPCR1_REFCLKDIV_MASK;
 
 	switch (refclk_div) {
@@ -194,10 +194,10 @@ static int jz4780_otg_phy_set_rate(struct clk_hw *hw, unsigned long req_rate,
 
 	spin_lock_irqsave(&cgu->lock, flags);
 
-	usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
+	usbpcr1 = cgu_readl(cgu, CGU_REG_USBPCR1);
 	usbpcr1 &= ~USBPCR1_REFCLKDIV_MASK;
 	usbpcr1 |= div_bits;
-	writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
+	cgu_writel(cgu, usbpcr1, CGU_REG_USBPCR1);
 
 	spin_unlock_irqrestore(&cgu->lock, flags);
 	return 0;
-- 
2.10.0
