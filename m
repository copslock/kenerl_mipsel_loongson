Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:38:28 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37602 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011807AbbJ1Whz2i2HO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:37:55 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id F148810002B;
        Wed, 28 Oct 2015 23:37:54 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH 02/15] MIPS: lantiq: add support for setting PMU register on AR10 and GRX390
Date:   Wed, 28 Oct 2015 23:37:31 +0100
Message-Id: <1446071865-21936-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49744
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

This adds support for setting the PMU register on the AR10 and GRX390.

Signed-off-by: Hauke Mehrtens <hauke.mehrtens@lantiq.com>
---
 arch/mips/lantiq/xway/sysctrl.c | 84 +++++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 11 deletions(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 9965731..71b6c1e 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -9,6 +9,7 @@
 #include <linux/ioport.h>
 #include <linux/export.h>
 #include <linux/clkdev.h>
+#include <linux/spinlock.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
@@ -18,16 +19,18 @@
 #include "../clk.h"
 #include "../prom.h"
 
-/* clock control register */
+/* clock control register for legacy */
 #define CGU_IFCCR	0x0018
 #define CGU_IFCCR_VR9	0x0024
-/* system clock register */
+/* system clock register for legacy */
 #define CGU_SYS		0x0010
 /* pci control register */
 #define CGU_PCICR	0x0034
 #define CGU_PCICR_VR9	0x0038
 /* ephy configuration register */
 #define CGU_EPHY	0x10
+
+/* Legacy PMU register for ar9, ase, danube */
 /* power control register */
 #define PMU_PWDCR	0x1C
 /* power status register */
@@ -41,6 +44,47 @@
 /* power status register */
 #define PWDSR(x) ((x) ? (PMU_PWDSR1) : (PMU_PWDSR))
 
+
+/* PMU register for ar10 and grx390 */
+
+/* First register set */
+#define PMU_CLK_SR	0x20 /* status */
+#define PMU_CLK_CR_A	0x24 /* Enable */
+#define PMU_CLK_CR_B	0x28 /* Disable */
+/* Second register set */
+#define PMU_CLK_SR1	0x30 /* status */
+#define PMU_CLK_CR1_A	0x34 /* Enable */
+#define PMU_CLK_CR1_B	0x38 /* Disable */
+/* Third register set */
+#define PMU_ANA_SR	0x40 /* status */
+#define PMU_ANA_CR_A	0x44 /* Enable */
+#define PMU_ANA_CR_B	0x48 /* Disable */
+
+/* Status */
+static u32 pmu_clk_sr[] = {
+	PMU_CLK_SR,
+	PMU_CLK_SR1,
+	PMU_ANA_SR,
+};
+
+/* Enable */
+static u32 pmu_clk_cr_a[] = {
+	PMU_CLK_CR_A,
+	PMU_CLK_CR1_A,
+	PMU_ANA_CR_A,
+};
+
+/* Disable */
+static u32 pmu_clk_cr_b[] = {
+	PMU_CLK_CR_B,
+	PMU_CLK_CR1_B,
+	PMU_ANA_CR_B,
+};
+
+#define PWDCR_EN_XRX(x)		(pmu_clk_cr_a[(x)])
+#define PWDCR_DIS_XRX(x)	(pmu_clk_cr_b[(x)])
+#define PWDSR_XRX(x)		(pmu_clk_sr[(x)])
+
 /* clock gates that we can en/disable */
 #define PMU_USB0_P	BIT(0)
 #define PMU_PCI		BIT(4)
@@ -135,11 +179,20 @@ static int pmu_enable(struct clk *clk)
 {
 	int retry = 1000000;
 
-	spin_lock(&g_pmu_lock);
-	pmu_w32(pmu_r32(PWDCR(clk->module)) & ~clk->bits,
-		PWDCR(clk->module));
-	do {} while (--retry && (pmu_r32(PWDSR(clk->module)) & clk->bits));
-	spin_unlock(&g_pmu_lock);
+	if (of_machine_is_compatible("lantiq,ar10")
+	    || of_machine_is_compatible("lantiq,grx390")) {
+		pmu_w32(clk->bits, PWDCR_EN_XRX(clk->module));
+		do {} while (--retry &&
+			     (!(pmu_r32(PWDSR_XRX(clk->module)) & clk->bits)));
+
+	} else {
+		spin_lock(&g_pmu_lock);
+		pmu_w32(pmu_r32(PWDCR(clk->module)) & ~clk->bits,
+				PWDCR(clk->module));
+		do {} while (--retry &&
+			     (pmu_r32(PWDSR(clk->module)) & clk->bits));
+		spin_unlock(&g_pmu_lock);
+	}
 
 	if (!retry)
 		panic("activating PMU module failed!");
@@ -152,10 +205,19 @@ static void pmu_disable(struct clk *clk)
 {
 	int retry = 1000000;
 
-	spin_lock(&g_pmu_lock);
-	pmu_w32(pmu_r32(PWDCR(clk->module)) | clk->bits, PWDCR(clk->module));
-	do {} while (--retry && (!(pmu_r32(PWDSR(clk->module)) & clk->bits)));
-	spin_unlock(&g_pmu_lock);
+	if (of_machine_is_compatible("lantiq,ar10")
+	    || of_machine_is_compatible("lantiq,grx390")) {
+		pmu_w32(clk->bits, PWDCR_DIS_XRX(clk->module));
+		do {} while (--retry &&
+			     (pmu_r32(PWDSR_XRX(clk->module)) & clk->bits));
+	} else {
+		spin_lock(&g_pmu_lock);
+		pmu_w32(pmu_r32(PWDCR(clk->module)) | clk->bits,
+				PWDCR(clk->module));
+		do {} while (--retry &&
+			     (!(pmu_r32(PWDSR(clk->module)) & clk->bits)));
+		spin_unlock(&g_pmu_lock);
+	}
 
 	if (!retry)
 		pr_warn("deactivating PMU module failed!");
-- 
2.6.1
