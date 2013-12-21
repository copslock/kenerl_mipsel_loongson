Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Dec 2013 12:15:12 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:1142 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867256Ab3LULLETknUU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Dec 2013 12:11:04 +0100
X-IronPort-AV: E=Sophos;i="4.95,527,1384329600"; 
   d="scan'208";a="4363734"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 21 Dec 2013 03:12:56 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Sat, 21 Dec 2013 03:11:02 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.1.438.0; Sat, 21 Dec 2013 03:11:02 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 A9F7D246A7;    Sat, 21 Dec 2013 03:11:01 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 13/18] MIPS: Netlogic: XLP9XX bridge and DRAM code
Date:   Sat, 21 Dec 2013 16:52:25 +0530
Message-ID: <1387624950-31297-14-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
References: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38786
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

Update bridge code. Add code to the XLP9XX registers for DRAM
size, limit and node when running on XLPXX

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/bridge.h |   69 +++++++++++------------
 arch/mips/netlogic/xlp/nlm_hal.c                |   26 ++++++---
 2 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
index 4e8eacb..3067f98 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
@@ -69,44 +69,9 @@
 #define BRIDGE_FLASH_LIMIT3		0x13
 
 #define BRIDGE_DRAM_BAR(i)		(0x14 + (i))
-#define BRIDGE_DRAM_BAR0		0x14
-#define BRIDGE_DRAM_BAR1		0x15
-#define BRIDGE_DRAM_BAR2		0x16
-#define BRIDGE_DRAM_BAR3		0x17
-#define BRIDGE_DRAM_BAR4		0x18
-#define BRIDGE_DRAM_BAR5		0x19
-#define BRIDGE_DRAM_BAR6		0x1a
-#define BRIDGE_DRAM_BAR7		0x1b
-
 #define BRIDGE_DRAM_LIMIT(i)		(0x1c + (i))
-#define BRIDGE_DRAM_LIMIT0		0x1c
-#define BRIDGE_DRAM_LIMIT1		0x1d
-#define BRIDGE_DRAM_LIMIT2		0x1e
-#define BRIDGE_DRAM_LIMIT3		0x1f
-#define BRIDGE_DRAM_LIMIT4		0x20
-#define BRIDGE_DRAM_LIMIT5		0x21
-#define BRIDGE_DRAM_LIMIT6		0x22
-#define BRIDGE_DRAM_LIMIT7		0x23
-
 #define BRIDGE_DRAM_NODE_TRANSLN(i)	(0x24 + (i))
-#define BRIDGE_DRAM_NODE_TRANSLN0	0x24
-#define BRIDGE_DRAM_NODE_TRANSLN1	0x25
-#define BRIDGE_DRAM_NODE_TRANSLN2	0x26
-#define BRIDGE_DRAM_NODE_TRANSLN3	0x27
-#define BRIDGE_DRAM_NODE_TRANSLN4	0x28
-#define BRIDGE_DRAM_NODE_TRANSLN5	0x29
-#define BRIDGE_DRAM_NODE_TRANSLN6	0x2a
-#define BRIDGE_DRAM_NODE_TRANSLN7	0x2b
-
 #define BRIDGE_DRAM_CHNL_TRANSLN(i)	(0x2c + (i))
-#define BRIDGE_DRAM_CHNL_TRANSLN0	0x2c
-#define BRIDGE_DRAM_CHNL_TRANSLN1	0x2d
-#define BRIDGE_DRAM_CHNL_TRANSLN2	0x2e
-#define BRIDGE_DRAM_CHNL_TRANSLN3	0x2f
-#define BRIDGE_DRAM_CHNL_TRANSLN4	0x30
-#define BRIDGE_DRAM_CHNL_TRANSLN5	0x31
-#define BRIDGE_DRAM_CHNL_TRANSLN6	0x32
-#define BRIDGE_DRAM_CHNL_TRANSLN7	0x33
 
 #define BRIDGE_PCIEMEM_BASE0		0x34
 #define BRIDGE_PCIEMEM_BASE1		0x35
@@ -178,12 +143,42 @@
 #define BRIDGE_GIO_WEIGHT		0x2cb
 #define BRIDGE_FLASH_WEIGHT		0x2cc
 
+/* FIXME verify */
+#define BRIDGE_9XX_FLASH_BAR(i)		(0x11 + (i))
+#define BRIDGE_9XX_FLASH_BAR_LIMIT(i)	(0x15 + (i))
+
+#define BRIDGE_9XX_DRAM_BAR(i)		(0x19 + (i))
+#define BRIDGE_9XX_DRAM_LIMIT(i)	(0x29 + (i))
+#define BRIDGE_9XX_DRAM_NODE_TRANSLN(i)	(0x39 + (i))
+#define BRIDGE_9XX_DRAM_CHNL_TRANSLN(i)	(0x49 + (i))
+
+#define BRIDGE_9XX_ADDRESS_ERROR0	0x9d
+#define BRIDGE_9XX_ADDRESS_ERROR1	0x9e
+#define BRIDGE_9XX_ADDRESS_ERROR2	0x9f
+
+#define BRIDGE_9XX_PCIEMEM_BASE0	0x59
+#define BRIDGE_9XX_PCIEMEM_BASE1	0x5a
+#define BRIDGE_9XX_PCIEMEM_BASE2	0x5b
+#define BRIDGE_9XX_PCIEMEM_BASE3	0x5c
+#define BRIDGE_9XX_PCIEMEM_LIMIT0	0x5d
+#define BRIDGE_9XX_PCIEMEM_LIMIT1	0x5e
+#define BRIDGE_9XX_PCIEMEM_LIMIT2	0x5f
+#define BRIDGE_9XX_PCIEMEM_LIMIT3	0x60
+#define BRIDGE_9XX_PCIEIO_BASE0		0x61
+#define BRIDGE_9XX_PCIEIO_BASE1		0x62
+#define BRIDGE_9XX_PCIEIO_BASE2		0x63
+#define BRIDGE_9XX_PCIEIO_BASE3		0x64
+#define BRIDGE_9XX_PCIEIO_LIMIT0	0x65
+#define BRIDGE_9XX_PCIEIO_LIMIT1	0x66
+#define BRIDGE_9XX_PCIEIO_LIMIT2	0x67
+#define BRIDGE_9XX_PCIEIO_LIMIT3	0x68
+
 #ifndef __ASSEMBLY__
 
 #define nlm_read_bridge_reg(b, r)	nlm_read_reg(b, r)
 #define nlm_write_bridge_reg(b, r, v)	nlm_write_reg(b, r, v)
-#define nlm_get_bridge_pcibase(node)	\
-			nlm_pcicfg_base(XLP_IO_BRIDGE_OFFSET(node))
+#define nlm_get_bridge_pcibase(node)	nlm_pcicfg_base(cpu_is_xlp9xx() ? \
+		XLP9XX_IO_BRIDGE_OFFSET(node) : XLP_IO_BRIDGE_OFFSET(node))
 #define nlm_get_bridge_regbase(node)	\
 			(nlm_get_bridge_pcibase(node) + XLP_IO_PCI_HDRSZ)
 
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 61f325d..efd64ac 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -314,21 +314,33 @@ int xlp_get_dram_map(int n, uint64_t *dram_map)
 {
 	uint64_t bridgebase, base, lim;
 	uint32_t val;
+	unsigned int barreg, limreg, xlatreg;
 	int i, node, rv;
 
 	/* Look only at mapping on Node 0, we don't handle crazy configs */
 	bridgebase = nlm_get_bridge_regbase(0);
 	rv = 0;
 	for (i = 0; i < 8; i++) {
-		val = nlm_read_bridge_reg(bridgebase,
-					BRIDGE_DRAM_NODE_TRANSLN(i));
-		node = (val >> 1) & 0x3;
-		if (n >= 0 && n != node)
-			continue;
-		val = nlm_read_bridge_reg(bridgebase, BRIDGE_DRAM_BAR(i));
+		if (cpu_is_xlp9xx()) {
+			barreg = BRIDGE_9XX_DRAM_BAR(i);
+			limreg = BRIDGE_9XX_DRAM_LIMIT(i);
+			xlatreg = BRIDGE_9XX_DRAM_NODE_TRANSLN(i);
+		} else {
+			barreg = BRIDGE_DRAM_BAR(i);
+			limreg = BRIDGE_DRAM_LIMIT(i);
+			xlatreg = BRIDGE_DRAM_NODE_TRANSLN(i);
+		}
+		if (n >= 0) {
+			/* node specified, get node mapping of BAR */
+			val = nlm_read_bridge_reg(bridgebase, xlatreg);
+			node = (val >> 1) & 0x3;
+			if (n != node)
+				continue;
+		}
+		val = nlm_read_bridge_reg(bridgebase, barreg);
 		val = (val >>  12) & 0xfffff;
 		base = (uint64_t) val << 20;
-		val = nlm_read_bridge_reg(bridgebase, BRIDGE_DRAM_LIMIT(i));
+		val = nlm_read_bridge_reg(bridgebase, limreg);
 		val = (val >>  12) & 0xfffff;
 		if (val == 0)   /* BAR not used */
 			continue;
-- 
1.7.9.5
