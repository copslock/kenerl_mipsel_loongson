Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:27:13 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:35425 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041364AbcFIVUnjSuDE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:20:43 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB7NY-0005Zn-47; Thu, 09 Jun 2016 21:20:40 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB7NV-0006NA-E5; Thu, 09 Jun 2016 14:20:37 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Alban Bedel <albeu@free.fr>, Felix Fietkau <nbd@nbd.name>,
        sergei.shtylyov@cogentembedded.com, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 197/206] MIPS: ath79: fix regression in PCI window initialization
Date:   Thu,  9 Jun 2016 14:16:46 -0700
Message-Id: <1465507015-23052-198-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465507015-23052-1-git-send-email-kamal@canonical.com>
References: <1465507015-23052-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Felix Fietkau <nbd@nbd.name>

commit 9184dc8ffa56844352b3b9860e562ec4ee41176f upstream.

ath79_ddr_pci_win_base has the type void __iomem *, so register offsets
need to be a multiple of 4.

Cc: Alban Bedel <albeu@free.fr>
Fixes: 24b0e3e84fbf ("MIPS: ath79: Improve the DDR controller interface")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Cc: sergei.shtylyov@cogentembedded.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13258/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/ath79/common.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
index 3cedd1f..8ae4067 100644
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
+	__raw_writel(AR71XX_PCI_WIN7_OFFS, ath79_ddr_pci_win_base + 0x1c);
 }
 EXPORT_SYMBOL_GPL(ath79_ddr_set_pci_windows);
 
-- 
2.7.4
