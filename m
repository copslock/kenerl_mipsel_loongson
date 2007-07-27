Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2007 17:02:45 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:38882 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021370AbXG0QCm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Jul 2007 17:02:42 +0100
Received: from localhost (p5199-ipad205funabasi.chiba.ocn.ne.jp [222.146.100.199])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BC58EA76D; Sat, 28 Jul 2007 01:02:37 +0900 (JST)
Date:	Sat, 28 Jul 2007 01:03:41 +0900 (JST)
Message-Id: <20070728.010341.41199515.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] rbtx4938: fix some warnings
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
X-archive-position: 15913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This patch fixes:

linux/arch/mips/pci/fixup-tx4938.c:21:5: warning: symbol 'pci_get_irq' was not declared. Should it be static?
linux/arch/mips/pci/fixup-tx4938.c:76: warning: passing argument 1 of 'pci_get_irq' discards qualifiers from pointer target type

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/pci/fixup-tx4938.c b/arch/mips/pci/fixup-tx4938.c
index 2485f47..f2ba06e 100644
--- a/arch/mips/pci/fixup-tx4938.c
+++ b/arch/mips/pci/fixup-tx4938.c
@@ -18,7 +18,7 @@
 
 extern struct pci_controller tx4938_pci_controller[];
 
-int pci_get_irq(struct pci_dev *dev, int pin)
+static int pci_get_irq(const struct pci_dev *dev, int pin)
 {
 	int irq = pin;
 	u8 slot = PCI_SLOT(dev->devfn);
