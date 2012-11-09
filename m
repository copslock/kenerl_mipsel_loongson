Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2012 19:38:24 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:42435 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826541Ab2KISh3Z33yi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Nov 2012 19:37:29 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 4/6] MIPS: lantiq: adds xrx200 ethernet clock definition
Date:   Fri,  9 Nov 2012 19:36:21 +0100
Message-Id: <1352486183-22576-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1352486183-22576-1-git-send-email-blogic@openwrt.org>
References: <1352486183-22576-1-git-send-email-blogic@openwrt.org>
X-archive-position: 34925
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

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/sysctrl.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 2917b56..3925e66 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -370,6 +370,10 @@ void __init ltq_soc_init(void)
 		clkdev_add_pmu("1d900000.pcie", "pdi", 1, PMU1_PCIE_PDI);
 		clkdev_add_pmu("1d900000.pcie", "ctl", 1, PMU1_PCIE_CTL);
 		clkdev_add_pmu("1d900000.pcie", "ahb", 0, PMU_AHBM | PMU_AHBS);
+		clkdev_add_pmu("1e108000.eth", NULL, 0,
+				PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM |
+				PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |
+				PMU_PPE_QSB | PMU_PPE_TOP);
 	} else if (of_machine_is_compatible("lantiq,ar9")) {
 		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
 				ltq_ar9_fpi_hz());
-- 
1.7.10.4
