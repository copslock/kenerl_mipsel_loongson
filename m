Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 May 2016 13:32:32 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:47264 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028976AbcEOLcOkFz90 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 15 May 2016 13:32:14 +0200
Received: by nf.lan (Postfix, from userid 501)
        id E3BC41405CAEA; Sun, 15 May 2016 13:32:10 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-mips@linux-mips.org
Cc:     albeu@free.fr
Subject: [PATCH 1/2] MIPS: ath79: make ath79_ddr_ctrl_init() compatible for newer SoCs
Date:   Sun, 15 May 2016 13:32:09 +0200
Message-Id: <1463311930-40536-1-git-send-email-nbd@nbd.name>
X-Mailer: git-send-email 2.2.2
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53452
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

AR913x, AR724x and AR933x are the only SoCs where the
ath79_ddr_wb_flush_base starts at 0x7c, all newer SoCs use 0x9c
Invert the logic to make the code compatible with AR95xx

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/mips/ath79/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
index 3cedd1f..84d4502 100644
--- a/arch/mips/ath79/common.c
+++ b/arch/mips/ath79/common.c
@@ -46,12 +46,12 @@ void ath79_ddr_ctrl_init(void)
 {
 	ath79_ddr_base = ioremap_nocache(AR71XX_DDR_CTRL_BASE,
 					 AR71XX_DDR_CTRL_SIZE);
-	if (soc_is_ar71xx() || soc_is_ar934x()) {
-		ath79_ddr_wb_flush_base = ath79_ddr_base + 0x9c;
-		ath79_ddr_pci_win_base = ath79_ddr_base + 0x7c;
-	} else {
+	if (soc_is_ar913x() || soc_is_ar724x() || soc_is_ar933x()) {
 		ath79_ddr_wb_flush_base = ath79_ddr_base + 0x7c;
 		ath79_ddr_pci_win_base = 0;
+	} else {
+		ath79_ddr_wb_flush_base = ath79_ddr_base + 0x9c;
+		ath79_ddr_pci_win_base = ath79_ddr_base + 0x7c;
 	}
 }
 EXPORT_SYMBOL_GPL(ath79_ddr_ctrl_init);
-- 
2.2.2
