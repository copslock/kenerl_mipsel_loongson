Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:40:11 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37624 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011828AbbJ1Wh5wJPmO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:37:57 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id 65A98100032;
        Wed, 28 Oct 2015 23:37:57 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH 08/15] MIPS: lantiq: add pmu bits for ar10 and grx390
Date:   Wed, 28 Oct 2015 23:37:37 +0100
Message-Id: <1446071865-21936-9-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

Signed-off-by: Hauke Mehrtens <hauke.mehrtens@lantiq.com>
---
 arch/mips/lantiq/xway/sysctrl.c | 57 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 6942fef..55e694e 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -109,6 +109,7 @@ static u32 pmu_clk_cr_b[] = {
 #define PMU_PPE_TC	BIT(21)
 #define PMU_PPE_EMA	BIT(22)
 #define PMU_PPE_DPLUM	BIT(23)
+#define PMU_PPE_DP	BIT(23)
 #define PMU_PPE_DPLUS	BIT(24)
 #define PMU_USB1_P	BIT(26)
 #define PMU_USB1	BIT(27)
@@ -117,10 +118,27 @@ static u32 pmu_clk_cr_b[] = {
 #define PMU_GPHY	BIT(30)
 #define PMU_PCIE_CLK	BIT(31)
 
-#define PMU1_PCIE_PHY	BIT(0)
+#define PMU1_PCIE_PHY	BIT(0)	/* vr9-specific,moved in ar10/grx390 */
 #define PMU1_PCIE_CTL	BIT(1)
 #define PMU1_PCIE_PDI	BIT(4)
 #define PMU1_PCIE_MSI	BIT(5)
+#define PMU1_CKE	BIT(6)
+#define PMU1_PCIE1_CTL	BIT(17)
+#define PMU1_PCIE1_PDI	BIT(20)
+#define PMU1_PCIE1_MSI	BIT(21)
+#define PMU1_PCIE2_CTL	BIT(25)
+#define PMU1_PCIE2_PDI	BIT(26)
+#define PMU1_PCIE2_MSI	BIT(27)
+
+#define PMU_ANALOG_USB0_P	BIT(0)
+#define PMU_ANALOG_USB1_P	BIT(1)
+#define PMU_ANALOG_PCIE0_P	BIT(8)
+#define PMU_ANALOG_PCIE1_P	BIT(9)
+#define PMU_ANALOG_PCIE2_P	BIT(10)
+#define PMU_ANALOG_DSL_AFE	BIT(16)
+#define PMU_ANALOG_DCDC_2V5	BIT(17)
+#define PMU_ANALOG_DCDC_1VX	BIT(18)
+#define PMU_ANALOG_DCDC_1V0	BIT(19)
 
 #define pmu_w32(x, y)	ltq_w32((x), pmu_membase + (y))
 #define pmu_r32(x)	ltq_r32(pmu_membase + (x))
@@ -444,6 +462,22 @@ void __init ltq_soc_init(void)
 		clkdev_add_pci();
 	}
 
+	if (of_machine_is_compatible("lantiq,grx390") ||
+	    of_machine_is_compatible("lantiq,ar10")) {
+		clkdev_add_pmu("1e101000.usb", "phy", 1, 2, PMU_ANALOG_USB0_P);
+		clkdev_add_pmu("1e106000.usb", "phy", 1, 2, PMU_ANALOG_USB1_P);
+		/* rc 0 */
+		clkdev_add_pmu("1d900000.pcie", "phy", 1, 2, PMU_ANALOG_PCIE0_P);
+		clkdev_add_pmu("1d900000.pcie", "msi", 1, 1, PMU1_PCIE_MSI);
+		clkdev_add_pmu("1d900000.pcie", "pdi", 1, 1, PMU1_PCIE_PDI);
+		clkdev_add_pmu("1d900000.pcie", "ctl", 1, 1, PMU1_PCIE_CTL);
+		/* rc 1 */
+		clkdev_add_pmu("19000000.pcie", "phy", 1, 2, PMU_ANALOG_PCIE1_P);
+		clkdev_add_pmu("19000000.pcie", "msi", 1, 1, PMU1_PCIE1_MSI);
+		clkdev_add_pmu("19000000.pcie", "pdi", 1, 1, PMU1_PCIE1_PDI);
+		clkdev_add_pmu("19000000.pcie", "ctl", 1, 1, PMU1_PCIE1_CTL);
+	}
+
 	if (of_machine_is_compatible("lantiq,ase")) {
 		if (ltq_cgu_r32(CGU_SYS) & (1 << 5))
 			clkdev_add_static(CLOCK_266M, CLOCK_133M,
@@ -457,6 +491,27 @@ void __init ltq_soc_init(void)
 		clkdev_add_cgu("1e180000.etop", "ephycgu", CGU_EPHY);
 		clkdev_add_pmu("1e180000.etop", "ephy", 1, 0, PMU_EPHY);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_ASE_SDIO);
+	} else if (of_machine_is_compatible("lantiq,grx390")) {
+		clkdev_add_static(ltq_grx390_cpu_hz(), ltq_grx390_fpi_hz(),
+				  ltq_grx390_fpi_hz(), ltq_grx390_pp32_hz());
+		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1);
+		/* rc 2 */
+		clkdev_add_pmu("1a800000.pcie", "phy", 1, 2, PMU_ANALOG_PCIE2_P);
+		clkdev_add_pmu("1a800000.pcie", "msi", 1, 1, PMU1_PCIE2_MSI);
+		clkdev_add_pmu("1a800000.pcie", "pdi", 1, 1, PMU1_PCIE2_PDI);
+		clkdev_add_pmu("1a800000.pcie", "ctl", 1, 1, PMU1_PCIE2_CTL);
+		clkdev_add_pmu("1e108000.eth", NULL, 1, 0, PMU_SWITCH | PMU_PPE_DP);
+		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
+	} else if (of_machine_is_compatible("lantiq,ar10")) {
+		clkdev_add_static(ltq_ar10_cpu_hz(), ltq_ar10_fpi_hz(),
+				  ltq_ar10_fpi_hz(), ltq_ar10_pp32_hz());
+		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1);
+		clkdev_add_pmu("1e108000.eth", NULL, 1, 0, PMU_SWITCH |
+			       PMU_PPE_DP | PMU_PPE_TC);
+		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
+		clkdev_add_pmu("1f203000.rcu", "gphy", 1, 0, PMU_GPHY);
 	} else if (of_machine_is_compatible("lantiq,vr9")) {
 		clkdev_add_static(ltq_vr9_cpu_hz(), ltq_vr9_fpi_hz(),
 				ltq_vr9_fpi_hz(), ltq_vr9_pp32_hz());
-- 
2.6.1
