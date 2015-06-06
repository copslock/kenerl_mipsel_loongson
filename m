Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Jun 2015 01:52:58 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:51003 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007561AbbFFXw5G4yr0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 7 Jun 2015 01:52:57 +0200
Received: from hauke-desktop.fritz.box (p5DE94F25.dip0.t-ipconnect.de [93.233.79.37])
        by hauke-m.de (Postfix) with ESMTPSA id 8C37C20166;
        Sun,  7 Jun 2015 01:52:56 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     m@bues.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] ssb: fix handling of ssb_pmu_get_alp_clock()
Date:   Sun,  7 Jun 2015 01:52:51 +0200
Message-Id: <1433634771-23438-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.1.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47896
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

Dan Carpenter reported missing brackets which resulted in reading a
wrong crystalfreq value. I also noticed that the result of this
function is ignored.

Reported-By: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/ssb/driver_chipcommon_pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ssb/driver_chipcommon_pmu.c b/drivers/ssb/driver_chipcommon_pmu.c
index 0942841..c5352ea 100644
--- a/drivers/ssb/driver_chipcommon_pmu.c
+++ b/drivers/ssb/driver_chipcommon_pmu.c
@@ -621,8 +621,8 @@ static u32 ssb_pmu_get_alp_clock_clk0(struct ssb_chipcommon *cc)
 	u32 crystalfreq;
 	const struct pmu0_plltab_entry *e = NULL;
 
-	crystalfreq = chipco_read32(cc, SSB_CHIPCO_PMU_CTL) &
-		      SSB_CHIPCO_PMU_CTL_XTALFREQ >> SSB_CHIPCO_PMU_CTL_XTALFREQ_SHIFT;
+	crystalfreq = (chipco_read32(cc, SSB_CHIPCO_PMU_CTL) &
+		       SSB_CHIPCO_PMU_CTL_XTALFREQ)  >> SSB_CHIPCO_PMU_CTL_XTALFREQ_SHIFT;
 	e = pmu0_plltab_find_entry(crystalfreq);
 	BUG_ON(!e);
 	return e->freq * 1000;
@@ -634,7 +634,7 @@ u32 ssb_pmu_get_alp_clock(struct ssb_chipcommon *cc)
 
 	switch (bus->chip_id) {
 	case 0x5354:
-		ssb_pmu_get_alp_clock_clk0(cc);
+		return ssb_pmu_get_alp_clock_clk0(cc);
 	default:
 		ssb_err("ERROR: PMU alp clock unknown for device %04X\n",
 			bus->chip_id);
-- 
2.1.4
