Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:38:11 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37599 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011801AbbJ1WhzB07-O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:37:55 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id 1746A10002A;
        Wed, 28 Oct 2015 23:37:54 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH 01/15] MIPS: lantiq: add locking for PMU register and check status afterwards
Date:   Wed, 28 Oct 2015 23:37:30 +0100
Message-Id: <1446071865-21936-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49743
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

The PMU register are accesses in a non atomic way and they could be
accesses by different threads simultaneously, which could cause
problems this patch adds locking around the PMU registers. In
addition it is now also waited till the PMU is actually deactivated.

Signed-off-by: Hauke Mehrtens <hauke.mehrtens@lantiq.com>
---
 arch/mips/lantiq/xway/sysctrl.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 2b15491..9965731 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -85,15 +85,19 @@ void __iomem *ltq_ebu_membase;
 static u32 ifccr = CGU_IFCCR;
 static u32 pcicr = CGU_PCICR;
 
+static DEFINE_SPINLOCK(g_pmu_lock);
+
 /* legacy function kept alive to ease clkdev transition */
 void ltq_pmu_enable(unsigned int module)
 {
-	int err = 1000000;
+	int retry = 1000000;
 
+	spin_lock(&g_pmu_lock);
 	pmu_w32(pmu_r32(PMU_PWDCR) & ~module, PMU_PWDCR);
-	do {} while (--err && (pmu_r32(PMU_PWDSR) & module));
+	do {} while (--retry && (pmu_r32(PMU_PWDSR) & module));
+	spin_unlock(&g_pmu_lock);
 
-	if (!err)
+	if (!retry)
 		panic("activating PMU module failed!");
 }
 EXPORT_SYMBOL(ltq_pmu_enable);
@@ -101,7 +105,15 @@ EXPORT_SYMBOL(ltq_pmu_enable);
 /* legacy function kept alive to ease clkdev transition */
 void ltq_pmu_disable(unsigned int module)
 {
+	int retry = 1000000;
+
+	spin_lock(&g_pmu_lock);
 	pmu_w32(pmu_r32(PMU_PWDCR) | module, PMU_PWDCR);
+	do {} while (--retry && (!(pmu_r32(PMU_PWDSR) & module)));
+	spin_unlock(&g_pmu_lock);
+
+	if (!retry)
+		pr_warn("deactivating PMU module failed!");
 }
 EXPORT_SYMBOL(ltq_pmu_disable);
 
@@ -123,9 +135,11 @@ static int pmu_enable(struct clk *clk)
 {
 	int retry = 1000000;
 
+	spin_lock(&g_pmu_lock);
 	pmu_w32(pmu_r32(PWDCR(clk->module)) & ~clk->bits,
 		PWDCR(clk->module));
 	do {} while (--retry && (pmu_r32(PWDSR(clk->module)) & clk->bits));
+	spin_unlock(&g_pmu_lock);
 
 	if (!retry)
 		panic("activating PMU module failed!");
@@ -136,8 +150,15 @@ static int pmu_enable(struct clk *clk)
 /* disable a clock gate */
 static void pmu_disable(struct clk *clk)
 {
-	pmu_w32(pmu_r32(PWDCR(clk->module)) | clk->bits,
-		PWDCR(clk->module));
+	int retry = 1000000;
+
+	spin_lock(&g_pmu_lock);
+	pmu_w32(pmu_r32(PWDCR(clk->module)) | clk->bits, PWDCR(clk->module));
+	do {} while (--retry && (!(pmu_r32(PWDSR(clk->module)) & clk->bits)));
+	spin_unlock(&g_pmu_lock);
+
+	if (!retry)
+		pr_warn("deactivating PMU module failed!");
 }
 
 /* the pci enable helper */
-- 
2.6.1
