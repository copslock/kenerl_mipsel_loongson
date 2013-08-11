Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Aug 2013 11:18:11 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:4006 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823569Ab3HKJNfRIh6G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Aug 2013 11:13:35 +0200
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 11 Aug 2013 02:07:01 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 11 Aug 2013 02:13:09 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 11 Aug 2013 02:13:09 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id D6805F2D73; Sun, 11
 Aug 2013 02:13:08 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 01/10] MIPS: Netlogic: Read memory from DRAM BARs
Date:   Sun, 11 Aug 2013 14:43:51 +0530
Message-ID: <1376212440-21038-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
References: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E198BBF1R079371326-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37517
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

Read the memory from the Bridge DRAM BARs if it is not passed in
from the device tree. This will allow us to remove memory configuration
from built in device trees.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/bridge.h |    4 +++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h    |    3 ++
 arch/mips/netlogic/xlp/nlm_hal.c                |   35 +++++++++++++++++++++++
 arch/mips/netlogic/xlp/setup.c                  |   23 +++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
index 790f0f1..4e8eacb 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
@@ -88,6 +88,7 @@
 #define BRIDGE_DRAM_LIMIT6		0x22
 #define BRIDGE_DRAM_LIMIT7		0x23
 
+#define BRIDGE_DRAM_NODE_TRANSLN(i)	(0x24 + (i))
 #define BRIDGE_DRAM_NODE_TRANSLN0	0x24
 #define BRIDGE_DRAM_NODE_TRANSLN1	0x25
 #define BRIDGE_DRAM_NODE_TRANSLN2	0x26
@@ -96,6 +97,8 @@
 #define BRIDGE_DRAM_NODE_TRANSLN5	0x29
 #define BRIDGE_DRAM_NODE_TRANSLN6	0x2a
 #define BRIDGE_DRAM_NODE_TRANSLN7	0x2b
+
+#define BRIDGE_DRAM_CHNL_TRANSLN(i)	(0x2c + (i))
 #define BRIDGE_DRAM_CHNL_TRANSLN0	0x2c
 #define BRIDGE_DRAM_CHNL_TRANSLN1	0x2d
 #define BRIDGE_DRAM_CHNL_TRANSLN2	0x2e
@@ -104,6 +107,7 @@
 #define BRIDGE_DRAM_CHNL_TRANSLN5	0x31
 #define BRIDGE_DRAM_CHNL_TRANSLN6	0x32
 #define BRIDGE_DRAM_CHNL_TRANSLN7	0x33
+
 #define BRIDGE_PCIEMEM_BASE0		0x34
 #define BRIDGE_PCIEMEM_BASE1		0x35
 #define BRIDGE_PCIEMEM_BASE2		0x36
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index f4ea0f7..d59cdd6 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -59,6 +59,9 @@ void xlp_wakeup_secondary_cpus(void);
 
 void xlp_mmu_init(void);
 void nlm_hal_init(void);
+int xlp_get_dram_map(int n, uint64_t *dram_map);
+
+/* Device tree related */
 void *xlp_dt_init(void *fdtp);
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 87560e4..6f2c210 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -44,6 +44,7 @@
 #include <asm/netlogic/haldefs.h>
 #include <asm/netlogic/xlp-hal/iomap.h>
 #include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/bridge.h>
 #include <asm/netlogic/xlp-hal/pic.h>
 #include <asm/netlogic/xlp-hal/sys.h>
 
@@ -142,3 +143,37 @@ unsigned int nlm_get_cpu_frequency(void)
 {
 	return nlm_get_core_frequency(0, 0);
 }
+
+/*
+ * Fills upto 8 pairs of entries containing the DRAM map of a node
+ * if n < 0, get dram map for all nodes
+ */
+int xlp_get_dram_map(int n, uint64_t *dram_map)
+{
+	uint64_t bridgebase, base, lim;
+	uint32_t val;
+	int i, node, rv;
+
+	/* Look only at mapping on Node 0, we don't handle crazy configs */
+	bridgebase = nlm_get_bridge_regbase(0);
+	rv = 0;
+	for (i = 0; i < 8; i++) {
+		val = nlm_read_bridge_reg(bridgebase,
+					BRIDGE_DRAM_NODE_TRANSLN(i));
+		node = (val >> 1) & 0x3;
+		if (n >= 0 && n != node)
+			continue;
+		val = nlm_read_bridge_reg(bridgebase, BRIDGE_DRAM_BAR(i));
+		val = (val >>  12) & 0xfffff;
+		base = (uint64_t) val << 20;
+		val = nlm_read_bridge_reg(bridgebase, BRIDGE_DRAM_LIMIT(i));
+		val = (val >>  12) & 0xfffff;
+		if (val == 0)   /* BAR not used */
+			continue;
+		lim = ((uint64_t)val + 1) << 20;
+		dram_map[rv] = base;
+		dram_map[rv + 1] = lim;
+		rv += 2;
+	}
+	return rv;
+}
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 7b638f7..0c6e300 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -73,6 +73,23 @@ static void nlm_fixup_mem(void)
 	}
 }
 
+static void __int xlp_init_mem_from_bars(void)
+{
+	uint64_t map[16];
+	int i, n;
+
+	n = xlp_get_dram_map(-1, map);	/* -1: info for all nodes */
+	for (i = 0; i < n; i += 2) {
+		/* exclude 0x1000_0000-0x2000_0000, u-boot device */
+		if (map[i] <= 0x10000000 && map[i+1] > 0x10000000)
+			map[i+1] = 0x10000000;
+		if (map[i] > 0x10000000 && map[i] < 0x20000000)
+			map[i] = 0x20000000;
+
+		add_memory_region(map[i], map[i+1] - map[i], BOOT_MEM_RAM);
+	}
+}
+
 void __init plat_mem_setup(void)
 {
 	panic_timeout	= 5;
@@ -82,6 +99,12 @@ void __init plat_mem_setup(void)
 
 	/* memory and bootargs from DT */
 	early_init_devtree(initial_boot_params);
+
+	if (boot_mem_map.nr_map == 0) {
+		pr_info("Using DRAM BARs for memory map.\n");
+		xlp_init_mem_from_bars();
+	}
+	/* Calculate and setup wired entries for mapped kernel */
 	nlm_fixup_mem();
 }
 
-- 
1.7.9.5
