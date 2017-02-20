Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2017 10:31:07 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:131:30e2::2]:56152 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993892AbdBTJ3rkPX14 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Feb 2017 10:29:47 +0100
From:   John Crispin <john@phrozen.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH 3/3] arch: mips: pci: make use of the BIT() macro inside the mt7620 driver
Date:   Mon, 20 Feb 2017 10:29:44 +0100
Message-Id: <1487582984-40143-4-git-send-email-john@phrozen.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1487582984-40143-1-git-send-email-john@phrozen.org>
References: <1487582984-40143-1-git-send-email-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

There are a few defines that manully shift a bit. Change these to using
the BIT() macro.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/pci/pci-mt7620.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
index 902fa61..68fd019 100644
--- a/arch/mips/pci/pci-mt7620.c
+++ b/arch/mips/pci/pci-mt7620.c
@@ -35,11 +35,11 @@
 #define PPLL_CFG1			0x9c
 
 #define PPLL_DRV			0xa0
-#define PDRV_SW_SET			(1<<31)
-#define LC_CKDRVPD			(1<<19)
-#define LC_CKDRVOHZ			(1<<18)
-#define LC_CKDRVHZ			(1<<17)
-#define LC_CKTEST			(1<<16)
+#define PDRV_SW_SET			BIT(31)
+#define LC_CKDRVPD			BIT(19)
+#define LC_CKDRVOHZ			BIT(18)
+#define LC_CKDRVHZ			BIT(17)
+#define LC_CKTEST			BIT(16)
 
 /* PCI Bridge registers */
 #define RALINK_PCI_PCICFG_ADDR		0x00
@@ -65,7 +65,7 @@
 #define PCIEPHY0_CFG			0x90
 
 #define RALINK_PCIEPHY_P0_CTL_OFFSET	0x7498
-#define RALINK_PCIE0_CLK_EN		(1 << 26)
+#define RALINK_PCIE0_CLK_EN		BIT(26)
 
 #define BUSY				0x80000000
 #define WAITRETRY_MAX			10
-- 
1.7.10.4
