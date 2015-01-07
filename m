Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 12:24:49 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:25072 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010456AbbAGLVf6eypB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 12:21:35 +0100
X-IronPort-AV: E=Sophos;i="5.07,714,1413270000"; 
   d="scan'208";a="54169611"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw3-out.broadcom.com with ESMTP; 07 Jan 2015 03:36:06 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 7 Jan 2015 03:21:34 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Wed, 7 Jan 2015 03:21:49 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 45F7740FE8;    Wed,  7 Jan 2015 03:20:47 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 12/17] MIPS: Netlogic: Update function to read DRAM BARs
Date:   Wed, 7 Jan 2015 16:58:33 +0530
Message-ID: <1420630118-17198-13-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Change name of xlp_get_dram_map to nlm_get_dram_map to be consistent
with the rest of the functions in the file. Pass the the size of the
array 'dram_map' to the function, and ensure that it does not write
past the end of the array.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h |  2 +-
 arch/mips/netlogic/xlp/nlm_hal.c             | 12 +++++++-----
 arch/mips/netlogic/xlp/setup.c               |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index a862b93..c0b2a80 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -89,7 +89,7 @@ void xlp_wakeup_secondary_cpus(void);
 
 void xlp_mmu_init(void);
 void nlm_hal_init(void);
-int xlp_get_dram_map(int n, uint64_t *dram_map);
+int nlm_get_dram_map(int node, uint64_t *dram_map, int nentries);
 
 struct pci_dev;
 int xlp_socdev_to_node(const struct pci_dev *dev);
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index b80d893..c6c31e3 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -449,19 +449,21 @@ unsigned int nlm_get_cpu_frequency(void)
 
 /*
  * Fills upto 8 pairs of entries containing the DRAM map of a node
- * if n < 0, get dram map for all nodes
+ * if node < 0, get dram map for all nodes
  */
-int xlp_get_dram_map(int n, uint64_t *dram_map)
+int nlm_get_dram_map(int node, uint64_t *dram_map, int nentries)
 {
 	uint64_t bridgebase, base, lim;
 	uint32_t val;
 	unsigned int barreg, limreg, xlatreg;
-	int i, node, rv;
+	int i, n, rv;
 
 	/* Look only at mapping on Node 0, we don't handle crazy configs */
 	bridgebase = nlm_get_bridge_regbase(0);
 	rv = 0;
 	for (i = 0; i < 8; i++) {
+		if (rv + 1 >= nentries)
+			break;
 		if (cpu_is_xlp9xx()) {
 			barreg = BRIDGE_9XX_DRAM_BAR(i);
 			limreg = BRIDGE_9XX_DRAM_LIMIT(i);
@@ -471,10 +473,10 @@ int xlp_get_dram_map(int n, uint64_t *dram_map)
 			limreg = BRIDGE_DRAM_LIMIT(i);
 			xlatreg = BRIDGE_DRAM_NODE_TRANSLN(i);
 		}
-		if (n >= 0) {
+		if (node >= 0) {
 			/* node specified, get node mapping of BAR */
 			val = nlm_read_bridge_reg(bridgebase, xlatreg);
-			node = (val >> 1) & 0x3;
+			n = (val >> 1) & 0x3;
 			if (n != node)
 				continue;
 		}
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 27113a1..f743fd9 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -81,7 +81,7 @@ static void __init xlp_init_mem_from_bars(void)
 	uint64_t map[16];
 	int i, n;
 
-	n = xlp_get_dram_map(-1, map);	/* -1: info for all nodes */
+	n = nlm_get_dram_map(-1, map, ARRAY_SIZE(map));	/* -1 : all nodes */
 	for (i = 0; i < n; i += 2) {
 		/* exclude 0x1000_0000-0x2000_0000, u-boot device */
 		if (map[i] <= 0x10000000 && map[i+1] > 0x10000000)
-- 
1.9.1
