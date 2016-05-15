Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 May 2016 13:32:16 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:47262 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028975AbcEOLcOiH-U0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 15 May 2016 13:32:14 +0200
Received: by nf.lan (Postfix, from userid 501)
        id F07261405CAF2; Sun, 15 May 2016 13:32:10 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-mips@linux-mips.org
Cc:     albeu@free.fr
Subject: [PATCH 2/2] MIPS: ath79: fix regression in PCI window initialization
Date:   Sun, 15 May 2016 13:32:10 +0200
Message-Id: <1463311930-40536-2-git-send-email-nbd@nbd.name>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1463311930-40536-1-git-send-email-nbd@nbd.name>
References: <1463311930-40536-1-git-send-email-nbd@nbd.name>
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53451
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

ath79_ddr_pci_win_base has the type void __iomem *, so register offsets
need to be a multiple of 4.

Cc: Alban Bedel <albeu@free.fr>
Fixes: 24b0e3e84fbf ("MIPS: ath79: Improve the DDR controller interface")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/mips/ath79/common.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
index 84d4502..5e26fd8 100644
--- a/arch/mips/ath79/common.c
+++ b/arch/mips/ath79/common.c
@@ -76,14 +76,14 @@ void ath79_ddr_set_pci_windows(void)
 {
 	BUG_ON(!ath79_ddr_pci_win_base);
 
-	__raw_writel(AR71XX_PCI_WIN0_OFFS, ath79_ddr_pci_win_base + 0);
-	__raw_writel(AR71XX_PCI_WIN1_OFFS, ath79_ddr_pci_win_base + 1);
-	__raw_writel(AR71XX_PCI_WIN2_OFFS, ath79_ddr_pci_win_base + 2);
-	__raw_writel(AR71XX_PCI_WIN3_OFFS, ath79_ddr_pci_win_base + 3);
-	__raw_writel(AR71XX_PCI_WIN4_OFFS, ath79_ddr_pci_win_base + 4);
-	__raw_writel(AR71XX_PCI_WIN5_OFFS, ath79_ddr_pci_win_base + 5);
-	__raw_writel(AR71XX_PCI_WIN6_OFFS, ath79_ddr_pci_win_base + 6);
-	__raw_writel(AR71XX_PCI_WIN7_OFFS, ath79_ddr_pci_win_base + 7);
+	__raw_writel(AR71XX_PCI_WIN0_OFFS, ath79_ddr_pci_win_base + 0x0);
+	__raw_writel(AR71XX_PCI_WIN1_OFFS, ath79_ddr_pci_win_base + 0x4);
+	__raw_writel(AR71XX_PCI_WIN2_OFFS, ath79_ddr_pci_win_base + 0x8);
+	__raw_writel(AR71XX_PCI_WIN3_OFFS, ath79_ddr_pci_win_base + 0xc);
+	__raw_writel(AR71XX_PCI_WIN4_OFFS, ath79_ddr_pci_win_base + 0x10);
+	__raw_writel(AR71XX_PCI_WIN5_OFFS, ath79_ddr_pci_win_base + 0x14);
+	__raw_writel(AR71XX_PCI_WIN6_OFFS, ath79_ddr_pci_win_base + 0x18);
+	__raw_writel(AR71XX_PCI_WIN7_OFFS, ath79_ddr_pci_win_base + 0x20);
 }
 EXPORT_SYMBOL_GPL(ath79_ddr_set_pci_windows);
 
-- 
2.2.2
