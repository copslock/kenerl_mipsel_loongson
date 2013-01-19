Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jan 2013 10:57:26 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:42356 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833244Ab3ASJ5FED6m1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Jan 2013 10:57:05 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/5] MIPS: lantiq: adds static clock for PP32
Date:   Sat, 19 Jan 2013 10:54:24 +0100
Message-Id: <1358589267-11514-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358589267-11514-1-git-send-email-blogic@openwrt.org>
References: <1358589267-11514-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35496
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The Lantiq DSL SoCs have an internal networking processor. Add code to read
the static clock rate.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mach-lantiq/lantiq.h |    1 +
 arch/mips/lantiq/clk.c                     |   12 ++++++--
 arch/mips/lantiq/clk.h                     |    7 ++++-
 arch/mips/lantiq/falcon/sysctrl.c          |    4 +--
 arch/mips/lantiq/xway/clk.c                |   43 ++++++++++++++++++++++++++++
 arch/mips/lantiq/xway/sysctrl.c            |   12 ++++----
 6 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
index 5e8a6e9..76be7a0 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
@@ -41,6 +41,7 @@ extern void clk_deactivate(struct clk *clk);
 extern struct clk *clk_get_cpu(void);
 extern struct clk *clk_get_fpi(void);
 extern struct clk *clk_get_io(void);
+extern struct clk *clk_get_ppe(void);
 
 /* find out what bootsource we have */
 extern unsigned char ltq_boot_select(void);
diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index ce2f129..d903560 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -26,13 +26,15 @@
 #include "prom.h"
 
 /* lantiq socs have 3 static clocks */
-static struct clk cpu_clk_generic[3];
+static struct clk cpu_clk_generic[4];
 
-void clkdev_add_static(unsigned long cpu, unsigned long fpi, unsigned long io)
+void clkdev_add_static(unsigned long cpu, unsigned long fpi,
+			unsigned long io, unsigned long ppe)
 {
 	cpu_clk_generic[0].rate = cpu;
 	cpu_clk_generic[1].rate = fpi;
 	cpu_clk_generic[2].rate = io;
+	cpu_clk_generic[3].rate = ppe;
 }
 
 struct clk *clk_get_cpu(void)
@@ -51,6 +53,12 @@ struct clk *clk_get_io(void)
 	return &cpu_clk_generic[2];
 }
 
+struct clk *clk_get_ppe(void)
+{
+	return &cpu_clk_generic[3];
+}
+EXPORT_SYMBOL_GPL(clk_get_ppe);
+
 static inline int clk_good(struct clk *clk)
 {
 	return clk && !IS_ERR(clk);
diff --git a/arch/mips/lantiq/clk.h b/arch/mips/lantiq/clk.h
index fa67060..77e4bdb 100644
--- a/arch/mips/lantiq/clk.h
+++ b/arch/mips/lantiq/clk.h
@@ -27,12 +27,15 @@
 #define CLOCK_167M	166666667
 #define CLOCK_196_608M	196608000
 #define CLOCK_200M	200000000
+#define CLOCK_222M	222000000
+#define CLOCK_240M	240000000
 #define CLOCK_250M	250000000
 #define CLOCK_266M	266666666
 #define CLOCK_300M	300000000
 #define CLOCK_333M	333333333
 #define CLOCK_393M	393215332
 #define CLOCK_400M	400000000
+#define CLOCK_450M	450000000
 #define CLOCK_500M	500000000
 #define CLOCK_600M	600000000
 
@@ -64,15 +67,17 @@ struct clk {
 };
 
 extern void clkdev_add_static(unsigned long cpu, unsigned long fpi,
-				unsigned long io);
+				unsigned long io, unsigned long ppe);
 
 extern unsigned long ltq_danube_cpu_hz(void);
 extern unsigned long ltq_danube_fpi_hz(void);
+extern unsigned long ltq_danube_pp32_hz(void);
 
 extern unsigned long ltq_ar9_cpu_hz(void);
 extern unsigned long ltq_ar9_fpi_hz(void);
 
 extern unsigned long ltq_vr9_cpu_hz(void);
 extern unsigned long ltq_vr9_fpi_hz(void);
+extern unsigned long ltq_vr9_pp32_hz(void);
 
 #endif
diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index 2d4ced3..ff4894a 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -241,9 +241,9 @@ void __init ltq_soc_init(void)
 
 	/* get our 3 static rates for cpu, fpi and io clocks */
 	if (ltq_sys1_r32(SYS1_CPU0CC) & CPU0CC_CPUDIV)
-		clkdev_add_static(CLOCK_200M, CLOCK_100M, CLOCK_200M);
+		clkdev_add_static(CLOCK_200M, CLOCK_100M, CLOCK_200M, 0);
 	else
-		clkdev_add_static(CLOCK_400M, CLOCK_100M, CLOCK_200M);
+		clkdev_add_static(CLOCK_400M, CLOCK_100M, CLOCK_200M, 0);
 
 	/* add our clock domains */
 	clkdev_add_sys("1d810000.gpio", SYSCTL_SYSETH, ACTS_P0);
diff --git a/arch/mips/lantiq/xway/clk.c b/arch/mips/lantiq/xway/clk.c
index 9aa17f7..1ab576d 100644
--- a/arch/mips/lantiq/xway/clk.c
+++ b/arch/mips/lantiq/xway/clk.c
@@ -53,6 +53,29 @@ unsigned long ltq_danube_cpu_hz(void)
 	}
 }
 
+unsigned long ltq_danube_pp32_hz(void)
+{
+	unsigned int clksys = (ltq_cgu_r32(CGU_SYS) >> 7) & 3;
+	unsigned long clk;
+
+	switch (clksys) {
+	case 1:
+		clk = CLOCK_240M;
+		break;
+	case 2:
+		clk = CLOCK_222M;
+		break;
+	case 3:
+		clk = CLOCK_133M;
+		break;
+	default:
+		clk = CLOCK_266M;
+		break;
+	}
+
+	return clk;
+}
+
 unsigned long ltq_ar9_sys_hz(void)
 {
 	if (((ltq_cgu_r32(CGU_SYS) >> 3) & 0x3) == 0x2)
@@ -149,3 +172,23 @@ unsigned long ltq_vr9_fpi_hz(void)
 
 	return clk;
 }
+
+unsigned long ltq_vr9_pp32_hz(void)
+{
+	unsigned int clksys = (ltq_cgu_r32(CGU_SYS) >> 16) & 3;
+	unsigned long clk;
+
+	switch (clksys) {
+	case 1:
+		clk = CLOCK_450M;
+		break;
+	case 2:
+		clk = CLOCK_300M;
+		break;
+	default:
+		clk = CLOCK_500M;
+		break;
+	}
+
+	return clk;
+}
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 1aaa726..3390fcd 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -356,14 +356,16 @@ void __init ltq_soc_init(void)
 
 	if (of_machine_is_compatible("lantiq,ase")) {
 		if (ltq_cgu_r32(CGU_SYS) & (1 << 5))
-			clkdev_add_static(CLOCK_266M, CLOCK_133M, CLOCK_133M);
+			clkdev_add_static(CLOCK_266M, CLOCK_133M,
+						CLOCK_133M, CLOCK_266M);
 		else
-			clkdev_add_static(CLOCK_133M, CLOCK_133M, CLOCK_133M);
+			clkdev_add_static(CLOCK_133M, CLOCK_133M,
+						CLOCK_133M, CLOCK_133M);
 		clkdev_add_cgu("1e180000.etop", "ephycgu", CGU_EPHY),
 		clkdev_add_pmu("1e180000.etop", "ephy", 0, PMU_EPHY);
 	} else if (of_machine_is_compatible("lantiq,vr9")) {
 		clkdev_add_static(ltq_vr9_cpu_hz(), ltq_vr9_fpi_hz(),
-				ltq_vr9_fpi_hz());
+				ltq_vr9_fpi_hz(), ltq_vr9_pp32_hz());
 		clkdev_add_pmu("1d900000.pcie", "phy", 1, PMU1_PCIE_PHY);
 		clkdev_add_pmu("1d900000.pcie", "bus", 0, PMU_PCIE_CLK);
 		clkdev_add_pmu("1d900000.pcie", "msi", 1, PMU1_PCIE_MSI);
@@ -376,10 +378,10 @@ void __init ltq_soc_init(void)
 				PMU_PPE_QSB | PMU_PPE_TOP);
 	} else if (of_machine_is_compatible("lantiq,ar9")) {
 		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
-				ltq_ar9_fpi_hz());
+				ltq_ar9_fpi_hz(), CLOCK_250M);
 		clkdev_add_pmu("1e180000.etop", "switch", 0, PMU_SWITCH);
 	} else {
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
-				ltq_danube_fpi_hz());
+				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
 	}
 }
-- 
1.7.10.4
