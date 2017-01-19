Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 14:20:20 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:131:30e2::2]:42571 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993014AbdASNUMsGRlO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Jan 2017 14:20:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name; s=20160729;
        h=Message-Id:Date:Subject:Cc:To:From; bh=R77K+yEagKUOimRfKnmkbWH0LS2zEviz/Rvc2cGcef8=;
        b=VS6LCPttwkGPjRRX3fy7PhZtn2Paan3DkssoDSzDARgWTpRnhwbLBKfNe+BC6JHsdNlKG8A0JtjB47lallJfcCXlpq/z65eZ0PO4TBA2/xOpqzaBdX+Yah8ge2qxQr0lrfGxoggqC2dntgHPJrBIviesVEN3ehkon/OmJv3Ts08=;
Received: by nf-4.local (Postfix, from userid 501)
        id 4D051185F7CB6; Thu, 19 Jan 2017 14:20:09 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, john@phrozen.org, hauke.mehrtens@lantiq.com
Subject: [PATCH] MIPS: Lantiq: Keep ethernet enabled during boot
Date:   Thu, 19 Jan 2017 14:20:09 +0100
Message-Id: <20170119132009.55709-1-nbd@nbd.name>
X-Mailer: git-send-email 2.11.0
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@nbd.name
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

Disabling ethernet during reboot (only to enable it again when the
ethernet driver attaches) can put the chip into a faulty state where it
corrupts the header of all incoming packets.

This happens if packets arrive during the time window where the core is
disabled, and it can be easily reproduced by rebooting while sending a
flood ping to the broadcast address.

Cc: john@phrozen.org
Cc: hauke.mehrtens@lantiq.com
Cc: stable@vger.kernel.org
Fixes: 95135bfa7ead ("MIPS: Lantiq: Deactivate most of the devices by default")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/mips/lantiq/xway/sysctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 236193b5210b..9a61671c00a7 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -545,7 +545,7 @@ void __init ltq_soc_init(void)
 		clkdev_add_pmu("1a800000.pcie", "msi", 1, 1, PMU1_PCIE2_MSI);
 		clkdev_add_pmu("1a800000.pcie", "pdi", 1, 1, PMU1_PCIE2_PDI);
 		clkdev_add_pmu("1a800000.pcie", "ctl", 1, 1, PMU1_PCIE2_CTL);
-		clkdev_add_pmu("1e108000.eth", NULL, 1, 0, PMU_SWITCH | PMU_PPE_DP);
+		clkdev_add_pmu("1e108000.eth", NULL, 0, 0, PMU_SWITCH | PMU_PPE_DP);
 		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 	} else if (of_machine_is_compatible("lantiq,ar10")) {
@@ -553,7 +553,7 @@ void __init ltq_soc_init(void)
 				  ltq_ar10_fpi_hz(), ltq_ar10_pp32_hz());
 		clkdev_add_pmu("1e101000.usb", "ctl", 1, 0, PMU_USB0);
 		clkdev_add_pmu("1e106000.usb", "ctl", 1, 0, PMU_USB1);
-		clkdev_add_pmu("1e108000.eth", NULL, 1, 0, PMU_SWITCH |
+		clkdev_add_pmu("1e108000.eth", NULL, 0, 0, PMU_SWITCH |
 			       PMU_PPE_DP | PMU_PPE_TC);
 		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
 		clkdev_add_pmu("1f203000.rcu", "gphy", 1, 0, PMU_GPHY);
@@ -575,11 +575,11 @@ void __init ltq_soc_init(void)
 		clkdev_add_pmu(NULL, "ahb", 1, 0, PMU_AHBM | PMU_AHBS);
 
 		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
-		clkdev_add_pmu("1e108000.eth", NULL, 1, 0,
+		clkdev_add_pmu("1e108000.eth", NULL, 0, 0,
 				PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM |
 				PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |
 				PMU_PPE_QSB | PMU_PPE_TOP);
-		clkdev_add_pmu("1f203000.rcu", "gphy", 1, 0, PMU_GPHY);
+		clkdev_add_pmu("1f203000.rcu", "gphy", 0, 0, PMU_GPHY);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
-- 
2.11.0
