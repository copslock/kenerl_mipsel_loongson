Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 18:46:28 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:62104 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868731Ab3JGQpj4nFiN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Oct 2013 18:45:39 +0200
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     <james.hogan@imgtec.com>, <paul.burton@imgtec.com>,
        <Steven.Hill@imgtec.com>, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH v2 1/2] MIPS: Get rid of hard-coded values for Malta PIIX4 fixups
Date:   Mon, 7 Oct 2013 09:45:04 -0700
Message-ID: <1381164305-28500-2-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1381164305-28500-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1381164305-28500-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.136.61]
X-SEF-Processed: 7_3_0_01192__2013_10_07_17_45_28
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Make the code more readable by using defines.

Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/include/asm/mips-boards/piix4.h |   23 ++++++++++++++++++
 arch/mips/pci/fixup-malta.c               |   36 ++++++++++++++++++----------
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/mips-boards/piix4.h b/arch/mips/include/asm/mips-boards/piix4.h
index a02596c..06d4831 100644
--- a/arch/mips/include/asm/mips-boards/piix4.h
+++ b/arch/mips/include/asm/mips-boards/piix4.h
@@ -1,6 +1,7 @@
 /*
  * Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2013 Imagination Technologies Ltd.
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
@@ -20,6 +21,28 @@
 #ifndef __ASM_MIPS_BOARDS_PIIX4_H
 #define __ASM_MIPS_BOARDS_PIIX4_H
 
+/* PIRQX Route Control */
+#define PIIX4_FUNC0_PIRQRC			0x60
+#define   PIIX4_FUNC0_PIRQRC_IRQ_ROUTING_DISABLE	(1 << 7)
+#define   PIIX4_FUNC0_PIRQRC_IRQ_ROUTING_MASK		0xf
+#define   PIIX4_FUNC0_PIRQRC_IRQ_ROUTING_MAX		16
+/* Top Of Memory */
+#define PIIX4_FUNC0_TOM				0x69
+#define   PIIX4_FUNC0_TOM_TOP_OF_MEMORY_MASK		0xf0
+/* Deterministic Latency Control */
+#define PIIX4_FUNC0_DLC				0x82
+#define   PIIX4_FUNC0_DLC_USBPR_EN			(1 << 2)
+#define   PIIX4_FUNC0_DLC_PASSIVE_RELEASE_EN		(1 << 1)
+#define   PIIX4_FUNC0_DLC_DELAYED_TRANSACTION_EN	(1 << 0)
+
+/* IDE Timing */
+#define PIIX4_FUNC1_IDETIM_PRIMARY_LO		0x40
+#define PIIX4_FUNC1_IDETIM_PRIMARY_HI		0x41
+#define   PIIX4_FUNC1_IDETIM_PRIMARY_HI_IDE_DECODE_EN	(1 << 7)
+#define PIIX4_FUNC1_IDETIM_SECONDARY_LO		0x42
+#define PIIX4_FUNC1_IDETIM_SECONDARY_HI		0x43
+#define   PIIX4_FUNC1_IDETIM_SECONDARY_HI_IDE_DECODE_EN	(1 << 7)
+
 /************************************************************************
  *  IO register offsets
  ************************************************************************/
diff --git a/arch/mips/pci/fixup-malta.c b/arch/mips/pci/fixup-malta.c
index 07ada7f..df36e23 100644
--- a/arch/mips/pci/fixup-malta.c
+++ b/arch/mips/pci/fixup-malta.c
@@ -1,5 +1,6 @@
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <asm/mips-boards/piix4.h>
 
 /* PCI interrupt pins */
 #define PCIA		1
@@ -53,7 +54,8 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 static void malta_piix_func0_fixup(struct pci_dev *pdev)
 {
 	unsigned char reg_val;
-	static int piixirqmap[16] = {  /* PIIX PIRQC[A:D] irq mappings */
+	/* PIIX PIRQC[A:D] irq mappings */
+	static int piixirqmap[PIIX4_FUNC0_PIRQRC_IRQ_ROUTING_MAX] = {
 		0,  0,	0,  3,
 		4,  5,	6,  7,
 		0,  9, 10, 11,
@@ -63,11 +65,12 @@ static void malta_piix_func0_fixup(struct pci_dev *pdev)
 
 	/* Interrogate PIIX4 to get PCI IRQ mapping */
 	for (i = 0; i <= 3; i++) {
-		pci_read_config_byte(pdev, 0x60+i, &reg_val);
-		if (reg_val & 0x80)
+		pci_read_config_byte(pdev, PIIX4_FUNC0_PIRQRC+i, &reg_val);
+		if (reg_val & PIIX4_FUNC0_PIRQRC_IRQ_ROUTING_DISABLE)
 			pci_irq[PCIA+i] = 0;	/* Disabled */
 		else
-			pci_irq[PCIA+i] = piixirqmap[reg_val & 15];
+			pci_irq[PCIA+i] = piixirqmap[reg_val &
+				PIIX4_FUNC0_PIRQRC_IRQ_ROUTING_MASK];
 	}
 
 	/* Done by YAMON 2.00 onwards */
@@ -76,8 +79,9 @@ static void malta_piix_func0_fixup(struct pci_dev *pdev)
 		 * Set top of main memory accessible by ISA or DMA
 		 * devices to 16 Mb.
 		 */
-		pci_read_config_byte(pdev, 0x69, &reg_val);
-		pci_write_config_byte(pdev, 0x69, reg_val | 0xf0);
+		pci_read_config_byte(pdev, PIIX4_FUNC0_TOM, &reg_val);
+		pci_write_config_byte(pdev, PIIX4_FUNC0_TOM, reg_val |
+				PIIX4_FUNC0_TOM_TOP_OF_MEMORY_MASK);
 	}
 }
 
@@ -93,10 +97,14 @@ static void malta_piix_func1_fixup(struct pci_dev *pdev)
 		/*
 		 * IDE Decode enable.
 		 */
-		pci_read_config_byte(pdev, 0x41, &reg_val);
-		pci_write_config_byte(pdev, 0x41, reg_val|0x80);
-		pci_read_config_byte(pdev, 0x43, &reg_val);
-		pci_write_config_byte(pdev, 0x43, reg_val|0x80);
+		pci_read_config_byte(pdev, PIIX4_FUNC1_IDETIM_PRIMARY_HI,
+			&reg_val);
+		pci_write_config_byte(pdev, PIIX4_FUNC1_IDETIM_PRIMARY_HI,
+			reg_val|PIIX4_FUNC1_IDETIM_PRIMARY_HI_IDE_DECODE_EN);
+		pci_read_config_byte(pdev, PIIX4_FUNC1_IDETIM_SECONDARY_HI,
+			&reg_val);
+		pci_write_config_byte(pdev, PIIX4_FUNC1_IDETIM_SECONDARY_HI,
+			reg_val|PIIX4_FUNC1_IDETIM_SECONDARY_HI_IDE_DECODE_EN);
 	}
 }
 
@@ -108,10 +116,12 @@ static void quirk_dlcsetup(struct pci_dev *dev)
 {
 	u8 odlc, ndlc;
 
-	(void) pci_read_config_byte(dev, 0x82, &odlc);
+	(void) pci_read_config_byte(dev, PIIX4_FUNC0_DLC, &odlc);
 	/* Enable passive releases and delayed transaction */
-	ndlc = odlc | 7;
-	(void) pci_write_config_byte(dev, 0x82, ndlc);
+	ndlc = odlc | PIIX4_FUNC0_DLC_USBPR_EN |
+		      PIIX4_FUNC0_DLC_PASSIVE_RELEASE_EN |
+		      PIIX4_FUNC0_DLC_DELAYED_TRANSACTION_EN;
+	(void) pci_write_config_byte(dev, PIIX4_FUNC0_DLC, ndlc);
 }
 
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0,
-- 
1.7.1
