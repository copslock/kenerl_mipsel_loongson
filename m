Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 17:15:36 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:40176 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022465AbXGLQPe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2007 17:15:34 +0100
Received: from localhost (p7217-ipad201funabasi.chiba.ocn.ne.jp [222.146.70.217])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0457BB570; Fri, 13 Jul 2007 01:15:31 +0900 (JST)
Date:	Fri, 13 Jul 2007 01:16:25 +0900 (JST)
Message-Id: <20070713.011625.37531838.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix gcc warning in arch/mips/pci/pci.c
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Now pcibios_map_irq() takes a const pointer.  Cast it to adapt
pci_fixup_irqs().

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 67e01fd..ecfb144 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -160,7 +160,8 @@ static int __init pcibios_init(void)
 
 	if (!pci_probe_only)
 		pci_assign_unassigned_resources();
-	pci_fixup_irqs(common_swizzle, pcibios_map_irq);
+	pci_fixup_irqs(common_swizzle,
+		       (int (*)(struct pci_dev *, u8, u8))pcibios_map_irq);
 
 	if ((dev = pci_get_class(PCI_CLASS_BRIDGE_EISA << 8, NULL)) != NULL ||
 	    (dev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL)) != NULL) {
