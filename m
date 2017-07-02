Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 00:46:34 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:36431 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994628AbdGBWl31RGua (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 00:41:29 +0200
Received: from hauke-desktop.lan (p20030086285C0200C8691593FAB84A84.dip0.t-ipconnect.de [IPv6:2003:86:285c:200:c869:1593:fab8:4a84])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 184971001EF;
        Mon,  3 Jul 2017 00:41:27 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v7 15/16] MIPS: lantiq: remove old USB PHY initialisation
Date:   Mon,  3 Jul 2017 00:40:50 +0200
Message-Id: <20170702224051.15109-16-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170702224051.15109-1-hauke@hauke-m.de>
References: <20170702224051.15109-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58977
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

This is now done in a PHY driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/xway/reset.c | 43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index be5fd29de523..04cd9a7c04a3 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -114,45 +114,6 @@ static void ltq_machine_power_off(void)
 	unreachable();
 }
 
-static void ltq_usb_init(void)
-{
-	/* Power for USB cores 1 & 2 */
-	ltq_pmu_enable(PMU_AHBM);
-	ltq_pmu_enable(PMU_USB0);
-	ltq_pmu_enable(PMU_USB1);
-
-	ltq_rcu_w32(ltq_rcu_r32(RCU_CFG1A) | BIT(0), RCU_CFG1A);
-	ltq_rcu_w32(ltq_rcu_r32(RCU_CFG1B) | BIT(0), RCU_CFG1B);
-
-	/* Enable USB PHY power for cores 1 & 2 */
-	ltq_pmu_enable(PMU_USB0_P);
-	ltq_pmu_enable(PMU_USB1_P);
-
-	/* Configure cores to host mode */
-	ltq_rcu_w32(ltq_rcu_r32(RCU_USB1CFG) & ~RCU_USBCFG_HDSEL_BIT,
-		RCU_USB1CFG);
-	ltq_rcu_w32(ltq_rcu_r32(RCU_USB2CFG) & ~RCU_USBCFG_HDSEL_BIT,
-		RCU_USB2CFG);
-
-	/* Select DMA endianness (Host-endian: big-endian) */
-	ltq_rcu_w32((ltq_rcu_r32(RCU_USB1CFG) & ~RCU_USBCFG_SLV_END_BIT)
-		| RCU_USBCFG_HOST_END_BIT, RCU_USB1CFG);
-	ltq_rcu_w32(ltq_rcu_r32((RCU_USB2CFG) & ~RCU_USBCFG_SLV_END_BIT)
-		| RCU_USBCFG_HOST_END_BIT, RCU_USB2CFG);
-
-	/* Hard reset USB state machines */
-	ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET) | USBRESET_BIT, RCU_USBRESET);
-	udelay(50 * 1000);
-	ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET) & ~USBRESET_BIT, RCU_USBRESET);
-
-	/* Soft reset USB state machines */
-	ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET2)
-		| USB1RESET_BIT | USB2RESET_BIT, RCU_USBRESET2);
-	udelay(50 * 1000);
-	ltq_rcu_w32(ltq_rcu_r32(RCU_USBRESET2)
-		& ~(USB1RESET_BIT | USB2RESET_BIT), RCU_USBRESET2);
-}
-
 static int __init mips_reboot_setup(void)
 {
 	struct resource res;
@@ -176,10 +137,6 @@ static int __init mips_reboot_setup(void)
 	if (!ltq_rcu_membase)
 		panic("Failed to remap core memory");
 
-	if (of_machine_is_compatible("lantiq,ar9") ||
-	    of_machine_is_compatible("lantiq,vr9"))
-		ltq_usb_init();
-
 	_machine_restart = ltq_machine_restart;
 	_machine_halt = ltq_machine_halt;
 	pm_power_off = ltq_machine_power_off;
-- 
2.11.0
