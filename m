Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:21:15 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:57515 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903764Ab2BWQUN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:20:13 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
Subject: [PATCH V2 14/14] MIPS: lantiq: add vr9 support
Date:   Thu, 23 Feb 2012 17:03:13 +0100
Message-Id: <1330012993-13510-14-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

VR9 is a VDSL SoC made by Lantiq. It is very similar to the AR9.
This patch adds the clkdev init code and SoC detection for the VR9.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
---
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    3 +
 arch/mips/lantiq/xway/clk.c                        |   83 ++++++++++++++++++++
 arch/mips/lantiq/xway/prom.c                       |    6 ++
 arch/mips/lantiq/xway/sysctrl.c                    |   12 +++-
 4 files changed, 103 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 2208a9db..efd238b 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -21,6 +21,9 @@
 #define SOC_ID_ARX188		0x16C
 #define SOC_ID_ARX168		0x16D
 #define SOC_ID_ARX182		0x16F
+#define SOC_ID_VRX288		0x1C0 /* VRX288 v1.1 */
+#define SOC_ID_VRX268		0x1C2 /* VRX268 v1.1 */
+#define SOC_ID_GRX288		0x1C9 /* GRX288 v1.1 */
 
 /* SoC Types */
 #define SOC_TYPE_DANUBE		0x01
diff --git a/arch/mips/lantiq/xway/clk.c b/arch/mips/lantiq/xway/clk.c
index f3b50fc..3635c9f 100644
--- a/arch/mips/lantiq/xway/clk.c
+++ b/arch/mips/lantiq/xway/clk.c
@@ -225,3 +225,86 @@ unsigned long ltq_danube_fpi_hz(void)
 		return ddr_clock >> 1;
 	return ddr_clock;
 }
+
+unsigned long ltq_vr9_cpu_hz(void)
+{
+	unsigned int cpu_sel;
+	unsigned long clk;
+
+	cpu_sel = (ltq_cgu_r32(LTQ_CGU_SYS_VR9) >> 4) & 0xf;
+
+	switch (cpu_sel) {
+	case 0:
+		clk = CLOCK_600M;
+		break;
+	case 1:
+		clk = CLOCK_500M;
+		break;
+	case 2:
+		clk = CLOCK_393M;
+		break;
+	case 3:
+		clk = CLOCK_333M;
+		break;
+	case 5:
+	case 6:
+		clk = CLOCK_196_608M;
+		break;
+	case 7:
+		clk = CLOCK_167M;
+		break;
+	case 4:
+	case 8:
+	case 9:
+		clk = CLOCK_125M;
+		break;
+	default:
+		clk = 0;
+		break;
+	}
+
+	return clk;
+}
+
+unsigned long ltq_vr9_fpi_hz(void)
+{
+	unsigned int ocp_sel, cpu_clk;
+	unsigned long clk;
+
+	cpu_clk = ltq_vr9_cpu_hz();
+	ocp_sel = ltq_cgu_r32(LTQ_CGU_SYS_VR9) & 0x3;
+
+	switch (ocp_sel) {
+	case 0:
+		/* OCP ratio 1 */
+		clk = cpu_clk;
+		break;
+	case 2:
+		/* OCP ratio 2 */
+		clk = cpu_clk / 2;
+		break;
+	case 3:
+		/* OCP ratio 2.5 */
+		clk = (cpu_clk * 2) / 5;
+		break;
+	case 4:
+		/* OCP ratio 3 */
+		clk = cpu_clk / 3;
+		break;
+	default:
+		clk = 0;
+		break;
+	}
+
+	return clk;
+}
+
+unsigned long ltq_vr9_io_region_clock(void)
+{
+	return ltq_vr9_fpi_hz();
+}
+
+unsigned long ltq_vr9_fpi_bus_clock(int fpi)
+{
+	return ltq_vr9_fpi_hz();
+}
diff --git a/arch/mips/lantiq/xway/prom.c b/arch/mips/lantiq/xway/prom.c
index 0929acb..b6f56b7 100644
--- a/arch/mips/lantiq/xway/prom.c
+++ b/arch/mips/lantiq/xway/prom.c
@@ -60,6 +60,12 @@ void __init ltq_soc_detect(struct ltq_soc_info *i)
 #endif
 		break;
 
+	case SOC_ID_VRX268:
+	case SOC_ID_VRX288:
+		i->name = SOC_VR9;
+		i->type = SOC_TYPE_VR9;
+		break;
+
 	default:
 		unreachable();
 		break;
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 22d076e..ccf9223 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -147,7 +147,8 @@ void __init ltq_soc_init(void)
 	clkdev_add_pmu("ltq_dma", NULL, 0, PMU_DMA);
 	clkdev_add_pmu("ltq_stp", NULL, 0, PMU_STP);
 	clkdev_add_pmu("ltq_spi", NULL, 0, PMU_SPI);
-	clkdev_add_pmu("ltq_etop", NULL, 0, PMU_PPE);
+	if (!ltq_is_vr9())
+		clkdev_add_pmu("ltq_etop", NULL, 0, PMU_PPE);
 	if (ltq_is_ase()) {
 		if (ltq_cgu_r32(LTQ_CGU_SYS) & (1 << 5))
 			clkdev_add_static(CLOCK_266M, CLOCK_133M, CLOCK_133M);
@@ -155,6 +156,15 @@ void __init ltq_soc_init(void)
 			clkdev_add_static(CLOCK_133M, CLOCK_133M, CLOCK_133M);
 		clkdev_add_cgu("ltq_etop", "ephycgu", CGU_EPHY),
 		clkdev_add_pmu("ltq_etop", "ephy", 0, PMU_EPHY);
+	} else if (ltq_is_vr9()) {
+		clkdev_add_static(ltq_vr9_cpu_hz(), ltq_vr9_fpi_hz(),
+					ltq_vr9_io_region_clock());
+		clkdev_add_pmu("ltq_pcie", "phy", 1, PMU1_PCIE_PHY);
+		clkdev_add_pmu("ltq_pcie", "bus", 0, PMU_PCIE_CLK);
+		clkdev_add_pmu("ltq_pcie", "msi", 1, PMU1_PCIE_MSI);
+		clkdev_add_pmu("ltq_pcie", "pdi", 1, PMU1_PCIE_PDI);
+		clkdev_add_pmu("ltq_pcie", "ctl", 1, PMU1_PCIE_CTL);
+		clkdev_add_pmu("ltq_pcie", "ahb", 0, PMU_AHBM | PMU_AHBS);
 	} else {
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
 					ltq_danube_io_region_clock());
-- 
1.7.7.1
