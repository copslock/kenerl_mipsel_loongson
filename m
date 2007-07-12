Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 17:26:03 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:50934 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022507AbXGLQ0B (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2007 17:26:01 +0100
Received: from localhost (p7217-ipad201funabasi.chiba.ocn.ne.jp [222.146.70.217])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9D881B617; Fri, 13 Jul 2007 01:25:57 +0900 (JST)
Date:	Fri, 13 Jul 2007 01:26:52 +0900 (JST)
Message-Id: <20070713.012652.130851739.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Fix a sparse warning in arch/mips/pci/pci.c
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
X-archive-position: 15740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Fixes this warning:

arch/mips/pci/pci.c:284:18: warning: symbol 'dev' shadows an earlier one
arch/mips/pci/pci.c:272:17: originally declared here

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 67e01fd..25e4959 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -281,7 +281,7 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 	}
 
 	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-		struct pci_dev *dev = pci_dev_b(ln);
+		dev = pci_dev_b(ln);
 
 		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
 			pcibios_fixup_device_resources(dev, bus);
