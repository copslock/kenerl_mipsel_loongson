Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Sep 2009 15:09:21 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.28.14.163]:57580 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492122AbZIDNJO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 Sep 2009 15:09:14 +0200
Received: from localhost.localdomain (p5218-ipad313funabasi.chiba.ocn.ne.jp [123.217.231.218])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1820E6918; Fri,  4 Sep 2009 22:09:05 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, davem@davemloft.net
Subject: [PATCH] txx9: Disable PM capability of TX493[89] internal ether
Date:	Fri,  4 Sep 2009 22:09:04 +0900
Message-Id: <1252069744-4553-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Some tc35815 variants (i.e. TX493[89] internal ether) report existance
of PM registers though they are not supported.  Disable PM features by
clearing pdev->pm_cap.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/pci.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 7b637a7..707cfa9 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -341,6 +341,15 @@ static void quirk_slc90e66_ide(struct pci_dev *dev)
 }
 #endif /* CONFIG_TOSHIBA_FPCIB0 */
 
+static void tc35815_fixup(struct pci_dev *dev)
+{
+	/* This device may have PM registers but not they are not suported. */
+	if (dev->pm_cap) {
+		dev_info(&dev->dev, "PM disabled\n");
+		dev->pm_cap = 0;
+	}
+}
+
 static void final_fixup(struct pci_dev *dev)
 {
 	unsigned char bist;
@@ -374,6 +383,10 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_1,
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_1,
 	quirk_slc90e66_ide);
 #endif
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA_2,
+			PCI_DEVICE_ID_TOSHIBA_TC35815_NWU, tc35815_fixup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA_2,
+			PCI_DEVICE_ID_TOSHIBA_TC35815_TX4939, tc35815_fixup);
 DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, final_fixup);
 DECLARE_PCI_FIXUP_RESUME(PCI_ANY_ID, PCI_ANY_ID, final_fixup);
 
-- 
1.5.6.5
