Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:41:04 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37634 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011836AbbJ1Wh7GP7YO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:37:59 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id A8DBF100034;
        Wed, 28 Oct 2015 23:37:58 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH 11/15] MIPS: lantiq: add clock for mei driver
Date:   Wed, 28 Oct 2015 23:37:40 +0100
Message-Id: <1446071865-21936-12-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49753
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
index 55e694e..2140a2b 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -491,6 +491,7 @@ void __init ltq_soc_init(void)
 		clkdev_add_cgu("1e180000.etop", "ephycgu", CGU_EPHY);
 		clkdev_add_pmu("1e180000.etop", "ephy", 1, 0, PMU_EPHY);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_ASE_SDIO);
+		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
 	} else if (of_machine_is_compatible("lantiq,grx390")) {
 		clkdev_add_static(ltq_grx390_cpu_hz(), ltq_grx390_fpi_hz(),
 				  ltq_grx390_fpi_hz(), ltq_grx390_pp32_hz());
@@ -512,6 +513,8 @@ void __init ltq_soc_init(void)
 			       PMU_PPE_DP | PMU_PPE_TC);
 		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
 		clkdev_add_pmu("1f203000.rcu", "gphy", 1, 0, PMU_GPHY);
+		clkdev_add_pmu("1e116000.mei", "afe", 1, 2, PMU_ANALOG_DSL_AFE);
+		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
 	} else if (of_machine_is_compatible("lantiq,vr9")) {
 		clkdev_add_static(ltq_vr9_cpu_hz(), ltq_vr9_fpi_hz(),
 				ltq_vr9_fpi_hz(), ltq_vr9_pp32_hz());
@@ -533,6 +536,7 @@ void __init ltq_soc_init(void)
 				PMU_PPE_QSB | PMU_PPE_TOP);
 		clkdev_add_pmu("1f203000.rcu", "gphy", 1, 0, PMU_GPHY);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
+		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
 	} else if (of_machine_is_compatible("lantiq,ar9")) {
 		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
 				ltq_ar9_fpi_hz(), CLOCK_250M);
@@ -542,11 +546,13 @@ void __init ltq_soc_init(void)
 		clkdev_add_pmu("1e106000.usb", "phy", 1, 0, PMU_USB1_P);
 		clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
+		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
 	} else {
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
 				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
 		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
 		clkdev_add_pmu("1e101000.usb", "phy", 1, 0, PMU_USB0_P);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
+		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
 	}
 }
-- 
2.6.1
