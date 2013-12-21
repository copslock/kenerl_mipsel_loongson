Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Dec 2013 12:12:00 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:23520 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821114Ab3LULKytIhG0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Dec 2013 12:10:54 +0100
X-IronPort-AV: E=Sophos;i="4.95,527,1384329600"; 
   d="scan'208";a="4638688"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw1-out.broadcom.com with ESMTP; 21 Dec 2013 03:16:59 -0800
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Sat, 21 Dec 2013 03:10:51 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.1.438.0; Sat, 21 Dec 2013 03:10:51 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 ED259246A3;    Sat, 21 Dec 2013 03:10:50 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 05/18] MIPS: Netlogic: Add macro for node present
Date:   Sat, 21 Dec 2013 16:52:17 +0530
Message-ID: <1387624950-31297-6-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
References: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38776
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

Add macro nlm_node_present() that can be used to check if a node is present
in a multi-chip configuration. This can be used even when NUMA is not enabled.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/mach-netlogic/multi-node.h |    2 ++
 arch/mips/pci/pci-xlp.c                          |    6 ++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mach-netlogic/multi-node.h b/arch/mips/include/asm/mach-netlogic/multi-node.h
index b3d91e0..beeb36b 100644
--- a/arch/mips/include/asm/mach-netlogic/multi-node.h
+++ b/arch/mips/include/asm/mach-netlogic/multi-node.h
@@ -63,6 +63,8 @@ struct nlm_soc_info {
 
 extern struct nlm_soc_info nlm_nodes[NLM_NR_NODES];
 #define nlm_get_node(i)		(&nlm_nodes[i])
+#define nlm_node_present(n)	((n) >= 0 && (n) < NLM_NR_NODES && \
+					nlm_get_node(n)->coremask != 0)
 #ifdef CONFIG_CPU_XLR
 #define nlm_current_node()	(&nlm_nodes[0])
 #else
diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
index 222d804..da7a37a 100644
--- a/arch/mips/pci/pci-xlp.c
+++ b/arch/mips/pci/pci-xlp.c
@@ -235,7 +235,6 @@ static inline void xlp_config_pci_bswap(int node, int link) {}
 
 static int __init pcibios_init(void)
 {
-	struct nlm_soc_info *nodep;
 	uint64_t pciebase;
 	int link, n;
 	u32 reg;
@@ -249,9 +248,8 @@ static int __init pcibios_init(void)
 	ioport_resource.end   = ~0;
 
 	for (n = 0; n < NLM_NR_NODES; n++) {
-		nodep = nlm_get_node(n);
-		if (!nodep->coremask)
-			continue;	/* node does not exist */
+		if (!nlm_node_present(n))
+			continue;
 
 		for (link = 0; link < PCIE_NLINKS; link++) {
 			pciebase = nlm_get_pcie_base(n, link);
-- 
1.7.9.5
