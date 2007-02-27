Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2007 16:44:10 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:43971 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039009AbXB0Qnk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Feb 2007 16:43:40 +0000
Received: from localhost (p6238-ipad203funabasi.chiba.ocn.ne.jp [222.146.85.238])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DD737B80A; Wed, 28 Feb 2007 01:42:19 +0900 (JST)
Date:	Wed, 28 Feb 2007 01:42:19 +0900 (JST)
Message-Id: <20070228.014219.97296484.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] jmr3927: build fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/pci/fixup-jmr3927.c b/arch/mips/pci/fixup-jmr3927.c
index f869608..6e72d21 100644
--- a/arch/mips/pci/fixup-jmr3927.c
+++ b/arch/mips/pci/fixup-jmr3927.c
@@ -38,6 +38,10 @@ int __init pcibios_map_irq(struct pci_de
 {
 	unsigned char irq = pin;
 
+	/* SMSC SLC90E66 IDE uses irq 14, 15 (default) */
+	if (dev->vendor == PCI_VENDOR_ID_EFAR &&
+	    dev->device == PCI_DEVICE_ID_EFAR_SLC90E66_1)
+		return irq;
 	/* IRQ rotation (PICMG) */
 	irq--;			/* 0-3 */
 	if (dev->bus->parent == NULL &&
@@ -93,13 +97,3 @@ int pcibios_plat_dev_init(struct pci_dev
 {
 	return 0;
 }
-
-int __init pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
-{
-	/* SMSC SLC90E66 IDE uses irq 14, 15 (default) */
-	if (!(dev->vendor == PCI_VENDOR_ID_EFAR &&
-	      dev->device == PCI_DEVICE_ID_EFAR_SLC90E66_1))
-		return pci_get_irq(dev, pin);
-
-	dev->irq = irq;
-}
