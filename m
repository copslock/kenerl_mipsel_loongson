Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2012 08:56:35 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55366 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1902755Ab2GVG41 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2012 08:56:27 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/5] MIPS: lantiq: fix interface clock and PCI control register offset
Date:   Sun, 22 Jul 2012 08:55:57 +0200
Message-Id: <1342940161-1421-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 33949
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

The XRX200 based SoC have a different register offset for the interface clock
and PCI control registers. This patch detects the SoC and sets the register
offset at runtime. This make PCI work on the VR9 SoC.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/sysctrl.c |   49 ++++++++++++++++++++++----------------
 1 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 83780f7..befbb76 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -20,10 +20,12 @@
 
 /* clock control register */
 #define CGU_IFCCR	0x0018
+#define CGU_IFCCR_VR9	0x0024
 /* system clock register */
 #define CGU_SYS		0x0010
 /* pci control register */
 #define CGU_PCICR	0x0034
+#define CGU_PCICR_VR9	0x0038
 /* ephy configuration register */
 #define CGU_EPHY	0x10
 /* power control register */
@@ -80,6 +82,9 @@ static void __iomem *pmu_membase;
 void __iomem *ltq_cgu_membase;
 void __iomem *ltq_ebu_membase;
 
+static u32 ifccr = CGU_IFCCR;
+static u32 pcicr = CGU_PCICR;
+
 /* legacy function kept alive to ease clkdev transition */
 void ltq_pmu_enable(unsigned int module)
 {
@@ -103,14 +108,14 @@ EXPORT_SYMBOL(ltq_pmu_disable);
 /* enable a hw clock */
 static int cgu_enable(struct clk *clk)
 {
-	ltq_cgu_w32(ltq_cgu_r32(CGU_IFCCR) | clk->bits, CGU_IFCCR);
+	ltq_cgu_w32(ltq_cgu_r32(ifccr) | clk->bits, ifccr);
 	return 0;
 }
 
 /* disable a hw clock */
 static void cgu_disable(struct clk *clk)
 {
-	ltq_cgu_w32(ltq_cgu_r32(CGU_IFCCR) & ~clk->bits, CGU_IFCCR);
+	ltq_cgu_w32(ltq_cgu_r32(ifccr) & ~clk->bits, ifccr);
 }
 
 /* enable a clock gate */
@@ -138,22 +143,22 @@ static void pmu_disable(struct clk *clk)
 /* the pci enable helper */
 static int pci_enable(struct clk *clk)
 {
-	unsigned int ifccr = ltq_cgu_r32(CGU_IFCCR);
+	unsigned int val = ltq_cgu_r32(ifccr);
 	/* set bus clock speed */
 	if (of_machine_is_compatible("lantiq,ar9")) {
-		ifccr &= ~0x1f00000;
+		val &= ~0x1f00000;
 		if (clk->rate == CLOCK_33M)
-			ifccr |= 0xe00000;
+			val |= 0xe00000;
 		else
-			ifccr |= 0x700000; /* 62.5M */
+			val |= 0x700000; /* 62.5M */
 	} else {
-		ifccr &= ~0xf00000;
+		val &= ~0xf00000;
 		if (clk->rate == CLOCK_33M)
-			ifccr |= 0x800000;
+			val |= 0x800000;
 		else
-			ifccr |= 0x400000; /* 62.5M */
+			val |= 0x400000; /* 62.5M */
 	}
-	ltq_cgu_w32(ifccr, CGU_IFCCR);
+	ltq_cgu_w32(val, ifccr);
 	pmu_enable(clk);
 	return 0;
 }
@@ -161,18 +166,16 @@ static int pci_enable(struct clk *clk)
 /* enable the external clock as a source */
 static int pci_ext_enable(struct clk *clk)
 {
-	ltq_cgu_w32(ltq_cgu_r32(CGU_IFCCR) & ~(1 << 16),
-		CGU_IFCCR);
-	ltq_cgu_w32((1 << 30), CGU_PCICR);
+	ltq_cgu_w32(ltq_cgu_r32(ifccr) & ~(1 << 16), ifccr);
+	ltq_cgu_w32((1 << 30), pcicr);
 	return 0;
 }
 
 /* disable the external clock as a source */
 static void pci_ext_disable(struct clk *clk)
 {
-	ltq_cgu_w32(ltq_cgu_r32(CGU_IFCCR) | (1 << 16),
-		CGU_IFCCR);
-	ltq_cgu_w32((1 << 31) | (1 << 30), CGU_PCICR);
+	ltq_cgu_w32(ltq_cgu_r32(ifccr) | (1 << 16), ifccr);
+	ltq_cgu_w32((1 << 31) | (1 << 30), pcicr);
 }
 
 /* enable a clockout source */
@@ -184,11 +187,11 @@ static int clkout_enable(struct clk *clk)
 	for (i = 0; i < 4; i++) {
 		if (clk->rates[i] == clk->rate) {
 			int shift = 14 - (2 * clk->module);
-			unsigned int ifccr = ltq_cgu_r32(CGU_IFCCR);
+			unsigned int val = ltq_cgu_r32(ifccr);
 
-			ifccr &= ~(3 << shift);
-			ifccr |= i << shift;
-			ltq_cgu_w32(ifccr, CGU_IFCCR);
+			val &= ~(3 << shift);
+			val |= i << shift;
+			ltq_cgu_w32(val, ifccr);
 			return 0;
 		}
 	}
@@ -336,8 +339,12 @@ void __init ltq_soc_init(void)
 	clkdev_add_clkout();
 
 	/* add the soc dependent clocks */
-	if (!of_machine_is_compatible("lantiq,vr9"))
+	if (of_machine_is_compatible("lantiq,vr9")) {
+		ifccr = CGU_IFCCR_VR9;
+		pcicr = CGU_PCICR_VR9;
+	} else {
 		clkdev_add_pmu("1e180000.etop", NULL, 0, PMU_PPE);
+	}
 
 	if (!of_machine_is_compatible("lantiq,ase")) {
 		clkdev_add_pmu("1e100c00.serial", NULL, 0, PMU_ASC1);
-- 
1.7.9.1
