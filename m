Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jan 2013 10:57:43 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:42358 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833245Ab3ASJ5Fe4ITg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Jan 2013 10:57:05 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 3/5] MIPS: lantiq: add GPHY clock gate bits
Date:   Sat, 19 Jan 2013 10:54:25 +0100
Message-Id: <1358589267-11514-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358589267-11514-1-git-send-email-blogic@openwrt.org>
References: <1358589267-11514-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35497
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

Explicitly enable the clock gate of the internal GPHYs found on xrx200.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/reset.c   |    9 +++++++++
 arch/mips/lantiq/xway/sysctrl.c |    1 +
 2 files changed, 10 insertions(+)

diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 544dbb7..1fa0f17 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -78,10 +78,19 @@ static struct ltq_xrx200_gphy_reset {
 /* reset and boot a gphy. these phys only exist on xrx200 SoC */
 int xrx200_gphy_boot(struct device *dev, unsigned int id, dma_addr_t dev_addr)
 {
+	struct clk *clk;
+
 	if (!of_device_is_compatible(ltq_rcu_np, "lantiq,rcu-xrx200")) {
 		dev_err(dev, "this SoC has no GPHY\n");
 		return -EINVAL;
 	}
+
+	clk = clk_get_sys("1f203000.rcu", "gphy");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	clk_enable(clk);
+
 	if (id > 1) {
 		dev_err(dev, "%u is an invalid gphy id\n", id);
 		return -EINVAL;
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 3390fcd..c24924f 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -376,6 +376,7 @@ void __init ltq_soc_init(void)
 				PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM |
 				PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |
 				PMU_PPE_QSB | PMU_PPE_TOP);
+		clkdev_add_pmu("1f203000.rcu", "gphy", 0, PMU_GPHY);
 	} else if (of_machine_is_compatible("lantiq,ar9")) {
 		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
 				ltq_ar9_fpi_hz(), CLOCK_250M);
-- 
1.7.10.4
