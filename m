Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:41:19 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37637 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011837AbbJ1Wh736XNO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:37:59 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id 11C9C100035;
        Wed, 28 Oct 2015 23:37:59 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH 12/15] MIPS: lantiq: add 1e103100.deu clock
Date:   Wed, 28 Oct 2015 23:37:41 +0100
Message-Id: <1446071865-21936-13-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49754
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
 arch/mips/lantiq/xway/sysctrl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 2140a2b..e791cf8 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -106,6 +106,7 @@ static u32 pmu_clk_cr_b[] = {
 #define PMU_ASC1	BIT(17)
 #define PMU_PPE_QSB	BIT(18)
 #define PMU_PPE_SLL01	BIT(19)
+#define PMU_DEU		BIT(20)
 #define PMU_PPE_TC	BIT(21)
 #define PMU_PPE_EMA	BIT(22)
 #define PMU_PPE_DPLUM	BIT(23)
@@ -504,6 +505,7 @@ void __init ltq_soc_init(void)
 		clkdev_add_pmu("1a800000.pcie", "ctl", 1, 1, PMU1_PCIE2_CTL);
 		clkdev_add_pmu("1e108000.eth", NULL, 1, 0, PMU_SWITCH | PMU_PPE_DP);
 		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
+		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 	} else if (of_machine_is_compatible("lantiq,ar10")) {
 		clkdev_add_static(ltq_ar10_cpu_hz(), ltq_ar10_fpi_hz(),
 				  ltq_ar10_fpi_hz(), ltq_ar10_pp32_hz());
@@ -513,6 +515,7 @@ void __init ltq_soc_init(void)
 			       PMU_PPE_DP | PMU_PPE_TC);
 		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
 		clkdev_add_pmu("1f203000.rcu", "gphy", 1, 0, PMU_GPHY);
+		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 		clkdev_add_pmu("1e116000.mei", "afe", 1, 2, PMU_ANALOG_DSL_AFE);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
 	} else if (of_machine_is_compatible("lantiq,vr9")) {
@@ -536,6 +539,7 @@ void __init ltq_soc_init(void)
 				PMU_PPE_QSB | PMU_PPE_TOP);
 		clkdev_add_pmu("1f203000.rcu", "gphy", 1, 0, PMU_GPHY);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
+		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
 	} else if (of_machine_is_compatible("lantiq,ar9")) {
 		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
@@ -546,6 +550,7 @@ void __init ltq_soc_init(void)
 		clkdev_add_pmu("1e106000.usb", "phy", 1, 0, PMU_USB1_P);
 		clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
+		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
 	} else {
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
@@ -553,6 +558,7 @@ void __init ltq_soc_init(void)
 		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
 		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
+		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
 	}
 }
-- 
2.6.1
