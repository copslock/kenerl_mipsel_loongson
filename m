Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2015 11:50:24 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37376 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006567AbbKDKuWr9ktw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Nov 2015 11:50:22 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 48F70280351;
        Wed,  4 Nov 2015 11:48:31 +0100 (CET)
Received: from localhost.localdomain (p548C90D8.dip0.t-ipconnect.de [84.140.144.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed,  4 Nov 2015 11:48:31 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 1/9] arch: mips: ralink: add support for mt7688
Date:   Wed,  4 Nov 2015 11:50:06 +0100
Message-Id: <1446634214-11564-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49827
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

MT7688 is similar tot he MT7628 but has a different wifi radio.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-ralink/mt7620.h |    1 +
 arch/mips/ralink/mt7620.c                  |   35 +++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
index 1976fb8..590681a 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620.h
@@ -24,6 +24,7 @@ enum mt762x_soc_type {
 
 #define SYSC_REG_CHIP_NAME0		0x00
 #define SYSC_REG_CHIP_NAME1		0x04
+#define SYSC_REG_EFUSE_CFG		0x08
 #define SYSC_REG_CHIP_REV		0x0c
 #define SYSC_REG_SYSTEM_CONFIG0		0x10
 #define SYSC_REG_SYSTEM_CONFIG1		0x14
diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 2ea5ff6..4d1a033 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -40,6 +40,12 @@
 /* is this a MT7620 or a MT7628 */
 enum mt762x_soc_type mt762x_soc;
 
+/* EFUSE bits */
+#define EFUSE_MT7688		0x100000
+
+/* DRAM type bit */
+#define DRAM_TYPE_MT7628_MASK	0x1
+
 /* does the board have sdram or ddram */
 static int dram_type;
 
@@ -227,6 +233,12 @@ static struct rt2880_pmx_group mt7628an_pinmux_data[] = {
 	{ 0 }
 };
 
+static inline int is_mt76x8(void)
+{
+	return mt762x_soc == MT762X_SOC_MT7628AN ||
+	       mt762x_soc == MT762X_SOC_MT7688;
+}
+
 static __init u32
 mt7620_calc_rate(u32 ref_rate, u32 mul, u32 div)
 {
@@ -381,7 +393,7 @@ void __init ralink_clk_init(void)
 #define RINT(x)		((x) / 1000000)
 #define RFRAC(x)	(((x) / 1000) % 1000)
 
-	if (mt762x_soc == MT762X_SOC_MT7628AN) {
+	if (is_mt76x8()) {
 		if (xtal_rate == MHZ(40))
 			cpu_rate = MHZ(580);
 		else
@@ -511,8 +523,15 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 #endif
 		}
 	} else if (n0 == MT7620_CHIP_NAME0 && n1 == MT7628_CHIP_NAME1) {
-		mt762x_soc = MT762X_SOC_MT7628AN;
-		name = "MT7628AN";
+		u32 efuse = __raw_readl(sysc + SYSC_REG_EFUSE_CFG);
+
+		if (efuse & EFUSE_MT7688) {
+			mt762x_soc = MT762X_SOC_MT7688;
+			name = "MT7688";
+		} else {
+			mt762x_soc = MT762X_SOC_MT7628AN;
+			name = "MT7628AN";
+		}
 		soc_info->compatible = "ralink,mt7628an-soc";
 	} else {
 		panic("mt762x: unknown SoC, n0:%08x n1:%08x\n", n0, n1);
@@ -525,10 +544,14 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 		(rev & CHIP_REV_ECO_MASK));
 
 	cfg0 = __raw_readl(sysc + SYSC_REG_SYSTEM_CONFIG0);
-	dram_type = (cfg0 >> SYSCFG0_DRAM_TYPE_SHIFT) & SYSCFG0_DRAM_TYPE_MASK;
+	if (is_mt76x8())
+		dram_type = cfg0 & DRAM_TYPE_MT7628_MASK;
+	else
+		dram_type = (cfg0 >> SYSCFG0_DRAM_TYPE_SHIFT) &
+			    SYSCFG0_DRAM_TYPE_MASK;
 
 	soc_info->mem_base = MT7620_DRAM_BASE;
-	if (mt762x_soc == MT762X_SOC_MT7628AN)
+	if (is_mt76x8())
 		mt7628_dram_init(soc_info);
 	else
 		mt7620_dram_init(soc_info);
@@ -541,7 +564,7 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 	pr_info("Digital PMU set to %s control\n",
 		(pmu1 & DIG_SW_SEL) ? ("sw") : ("hw"));
 
-	if (mt762x_soc == MT762X_SOC_MT7628AN)
+	if (is_mt76x8())
 		rt2880_pinmux_data = mt7628an_pinmux_data;
 	else
 		rt2880_pinmux_data = mt7620a_pinmux_data;
-- 
1.7.10.4
