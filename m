Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 21:29:08 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:35888 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491108Ab1FTT1M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 21:27:12 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 48242140223;
        Mon, 20 Jun 2011 21:27:07 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id B6AAF140209;
        Mon, 20 Jun 2011 21:27:06 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 04/13] MIPS: ath79: add AR933X specific clock init
Date:   Mon, 20 Jun 2011 21:26:04 +0200
Message-Id: <1308597973-6037-5-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A13179E1DC8 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16495

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/clock.c                        |   55 ++++++++++++++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   22 +++++++++
 arch/mips/include/asm/mach-ath79/ath79.h       |    6 +++
 3 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 680bde9..54d0eb4 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -110,6 +110,59 @@ static void __init ar913x_clocks_init(void)
 	ath79_uart_clk.rate = ath79_ahb_clk.rate;
 }
 
+static void __init ar933x_clocks_init(void)
+{
+	u32 clock_ctrl;
+	u32 cpu_config;
+	u32 freq;
+	u32 t;
+
+	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
+	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
+		ath79_ref_clk.rate = (40 * 1000 * 1000);
+	else
+		ath79_ref_clk.rate = (25 * 1000 * 1000);
+
+	clock_ctrl = ath79_pll_rr(AR933X_PLL_CLOCK_CTRL_REG);
+	if (clock_ctrl & AR933X_PLL_CLOCK_CTRL_BYPASS) {
+		ath79_cpu_clk.rate = ath79_ref_clk.rate;
+		ath79_ahb_clk.rate = ath79_ref_clk.rate;
+		ath79_ddr_clk.rate = ath79_ref_clk.rate;
+	} else {
+		cpu_config = ath79_pll_rr(AR933X_PLL_CPU_CONFIG_REG);
+
+		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
+		    AR933X_PLL_CPU_CONFIG_REFDIV_MASK;
+		freq = ath79_ref_clk.rate / t;
+
+		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_NINT_SHIFT) &
+		    AR933X_PLL_CPU_CONFIG_NINT_MASK;
+		freq *= t;
+
+		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
+		    AR933X_PLL_CPU_CONFIG_OUTDIV_MASK;
+		if (t == 0)
+			t = 1;
+
+		freq >>= t;
+
+		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_CPU_DIV_SHIFT) &
+		     AR933X_PLL_CLOCK_CTRL_CPU_DIV_MASK) + 1;
+		ath79_cpu_clk.rate = freq / t;
+
+		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_DDR_DIV_SHIFT) &
+		      AR933X_PLL_CLOCK_CTRL_DDR_DIV_MASK) + 1;
+		ath79_ddr_clk.rate = freq / t;
+
+		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_AHB_DIV_SHIFT) &
+		     AR933X_PLL_CLOCK_CTRL_AHB_DIV_MASK) + 1;
+		ath79_ahb_clk.rate = freq / t;
+	}
+
+	ath79_wdt_clk.rate = ath79_ref_clk.rate;
+	ath79_uart_clk.rate = ath79_ref_clk.rate;
+}
+
 void __init ath79_clocks_init(void)
 {
 	if (soc_is_ar71xx())
@@ -118,6 +171,8 @@ void __init ath79_clocks_init(void)
 		ar724x_clocks_init();
 	else if (soc_is_ar913x())
 		ar913x_clocks_init();
+	else if (soc_is_ar933x())
+		ar933x_clocks_init();
 	else
 		BUG();
 
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 90223f2..418b739 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -123,6 +123,24 @@
 #define AR913X_AHB_DIV_SHIFT		19
 #define AR913X_AHB_DIV_MASK		0x1
 
+#define AR933X_PLL_CPU_CONFIG_REG	0x00
+#define AR933X_PLL_CLOCK_CTRL_REG	0x08
+
+#define AR933X_PLL_CPU_CONFIG_NINT_SHIFT	10
+#define AR933X_PLL_CPU_CONFIG_NINT_MASK		0x3f
+#define AR933X_PLL_CPU_CONFIG_REFDIV_SHIFT	16
+#define AR933X_PLL_CPU_CONFIG_REFDIV_MASK	0x1f
+#define AR933X_PLL_CPU_CONFIG_OUTDIV_SHIFT	23
+#define AR933X_PLL_CPU_CONFIG_OUTDIV_MASK	0x7
+
+#define AR933X_PLL_CLOCK_CTRL_BYPASS		BIT(2)
+#define AR933X_PLL_CLOCK_CTRL_CPU_DIV_SHIFT	5
+#define AR933X_PLL_CLOCK_CTRL_CPU_DIV_MASK	0x3
+#define AR933X_PLL_CLOCK_CTRL_DDR_DIV_SHIFT	10
+#define AR933X_PLL_CLOCK_CTRL_DDR_DIV_MASK	0x3
+#define AR933X_PLL_CLOCK_CTRL_AHB_DIV_SHIFT	15
+#define AR933X_PLL_CLOCK_CTRL_AHB_DIV_MASK	0x7
+
 /*
  * USB_CONFIG block
  */
@@ -155,6 +173,8 @@
 
 #define AR724X_RESET_REG_RESET_MODULE		0x1c
 
+#define AR933X_RESET_REG_BOOTSTRAP		0xac
+
 #define MISC_INT_ETHSW			BIT(12)
 #define MISC_INT_TIMER4			BIT(10)
 #define MISC_INT_TIMER3			BIT(9)
@@ -204,6 +224,8 @@
 #define AR913X_RESET_USB_HOST		BIT(5)
 #define AR913X_RESET_USB_PHY		BIT(4)
 
+#define AR933X_BOOTSTRAP_REF_CLK_40	BIT(0)
+
 #define REV_ID_MAJOR_MASK		0xfff0
 #define REV_ID_MAJOR_AR71XX		0x00a0
 #define REV_ID_MAJOR_AR913X		0x00b0
diff --git a/arch/mips/include/asm/mach-ath79/ath79.h b/arch/mips/include/asm/mach-ath79/ath79.h
index 2dfc94c..407c935 100644
--- a/arch/mips/include/asm/mach-ath79/ath79.h
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -68,6 +68,12 @@ static inline int soc_is_ar913x(void)
 		ath79_soc == ATH79_SOC_AR9132);
 }
 
+static inline int soc_is_ar933x(void)
+{
+	return (ath79_soc == ATH79_SOC_AR9330 ||
+		ath79_soc == ATH79_SOC_AR9331);
+}
+
 extern void __iomem *ath79_ddr_base;
 extern void __iomem *ath79_pll_base;
 extern void __iomem *ath79_reset_base;
-- 
1.7.2.1
