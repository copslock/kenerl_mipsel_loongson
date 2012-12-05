Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2012 18:48:46 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:37821 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831678Ab2LERsH3eEHx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Dec 2012 18:48:07 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 066718F72;
        Wed,  5 Dec 2012 18:48:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id amzgzd3hZ3J5; Wed,  5 Dec 2012 18:47:51 +0100 (CET)
Received: from hauke-desktop.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 39B948F66;
        Wed,  5 Dec 2012 18:46:30 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com, wim@iguana.be
Cc:     linux-wireless@vger.kernel.org, linux-watchdog@vger.kernel.org,
        castet.matthieu@free.fr, biblbroks@sezampro.rs, m@bues.ch,
        zajec5@gmail.com, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 06/11] ssb: get alp clock from devices with PMU
Date:   Wed,  5 Dec 2012 18:46:03 +0100
Message-Id: <1354729568-19993-7-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1354729568-19993-1-git-send-email-hauke@hauke-m.de>
References: <1354729568-19993-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35190
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
Return-Path: <linux-mips-bounce@linux-mips.org>

If there is a PMU in the device, get the alp clock from that part and
do not assume 20000000.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/ssb/driver_chipcommon.c     |   15 +++++++++------
 drivers/ssb/driver_chipcommon_pmu.c |   27 +++++++++++++++++++++++++++
 drivers/ssb/ssb_private.h           |    1 +
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/ssb/driver_chipcommon.c b/drivers/ssb/driver_chipcommon.c
index e9d2ca1..603b630 100644
--- a/drivers/ssb/driver_chipcommon.c
+++ b/drivers/ssb/driver_chipcommon.c
@@ -280,6 +280,14 @@ static void calc_fast_powerup_delay(struct ssb_chipcommon *cc)
 	cc->fast_pwrup_delay = tmp;
 }
 
+static u32 ssb_chipco_alp_clock(struct ssb_chipcommon *cc)
+{
+	if (cc->capabilities & SSB_CHIPCO_CAP_PMU)
+		return ssb_pmu_get_alp_clock(cc);
+
+	return 20000000;
+}
+
 void ssb_chipcommon_init(struct ssb_chipcommon *cc)
 {
 	if (!cc->dev)
@@ -473,12 +481,7 @@ int ssb_chipco_serial_init(struct ssb_chipcommon *cc,
 				       chipco_read32(cc, SSB_CHIPCO_CORECTL)
 				       | SSB_CHIPCO_CORECTL_UARTCLK0);
 		} else if ((ccrev >= 11) && (ccrev != 15)) {
-			/* Fixed ALP clock */
-			baud_base = 20000000;
-			if (cc->capabilities & SSB_CHIPCO_CAP_PMU) {
-				/* FIXME: baud_base is different for devices with a PMU */
-				SSB_WARN_ON(1);
-			}
+			baud_base = ssb_chipco_alp_clock(cc);
 			div = 1;
 			if (ccrev >= 21) {
 				/* Turn off UART clock before switching clocksource. */
diff --git a/drivers/ssb/driver_chipcommon_pmu.c b/drivers/ssb/driver_chipcommon_pmu.c
index d7d5804..a43415a 100644
--- a/drivers/ssb/driver_chipcommon_pmu.c
+++ b/drivers/ssb/driver_chipcommon_pmu.c
@@ -618,6 +618,33 @@ void ssb_pmu_set_ldo_paref(struct ssb_chipcommon *cc, bool on)
 EXPORT_SYMBOL(ssb_pmu_set_ldo_voltage);
 EXPORT_SYMBOL(ssb_pmu_set_ldo_paref);
 
+static u32 ssb_pmu_get_alp_clock_clk0(struct ssb_chipcommon *cc)
+{
+	u32 crystalfreq;
+	const struct pmu0_plltab_entry *e = NULL;
+
+	crystalfreq = chipco_read32(cc, SSB_CHIPCO_PMU_CTL) &
+		      SSB_CHIPCO_PMU_CTL_XTALFREQ >> SSB_CHIPCO_PMU_CTL_XTALFREQ_SHIFT;
+	e = pmu0_plltab_find_entry(crystalfreq);
+	BUG_ON(!e);
+	return e->freq * 1000;
+}
+
+u32 ssb_pmu_get_alp_clock(struct ssb_chipcommon *cc)
+{
+	struct ssb_bus *bus = cc->dev->bus;
+
+	switch (bus->chip_id) {
+	case 0x5354:
+		ssb_pmu_get_alp_clock_clk0(cc);
+	default:
+		ssb_printk(KERN_ERR PFX
+			   "ERROR: PMU alp clock unknown for device %04X\n",
+			   bus->chip_id);
+		return 0;
+	}
+}
+
 u32 ssb_pmu_get_cpu_clock(struct ssb_chipcommon *cc)
 {
 	struct ssb_bus *bus = cc->dev->bus;
diff --git a/drivers/ssb/ssb_private.h b/drivers/ssb/ssb_private.h
index a305550..98b2915 100644
--- a/drivers/ssb/ssb_private.h
+++ b/drivers/ssb/ssb_private.h
@@ -210,5 +210,6 @@ static inline void b43_pci_ssb_bridge_exit(void)
 /* driver_chipcommon_pmu.c */
 extern u32 ssb_pmu_get_cpu_clock(struct ssb_chipcommon *cc);
 extern u32 ssb_pmu_get_controlclock(struct ssb_chipcommon *cc);
+extern u32 ssb_pmu_get_alp_clock(struct ssb_chipcommon *cc);
 
 #endif /* LINUX_SSB_PRIVATE_H_ */
-- 
1.7.10.4
