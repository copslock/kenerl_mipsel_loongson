Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2007 23:25:43 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:35481 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022500AbXGVWZk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Jul 2007 23:25:40 +0100
Received: from lagash (88-106-245-10.dynamic.dsl.as9105.com [88.106.245.10])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id BA22CBBAF1;
	Sun, 22 Jul 2007 23:45:41 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1ICjFE-0004kB-Sh; Sun, 22 Jul 2007 22:45:40 +0100
Date:	Sun, 22 Jul 2007 22:45:40 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] bcm1480 pci build fix
Message-ID: <20070722214540.GA18207@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

The appended patch restores building the bcm1480 kernel. The brokenness
noted there is apparently not immediately fatal, as the resulting kernel
successfully drives a SATA RAID on PCI-X.

Presumably the sb1250 pcibios_map_irq is broken in the same way. 


Thiemo


Signed-Off-By: Thiemo Seufer <ths@networkno.de>

diff --git a/arch/mips/pci/pci-bcm1480.c b/arch/mips/pci/pci-bcm1480.c
index 2b4e30c..0193aad 100644
--- a/arch/mips/pci/pci-bcm1480.c
+++ b/arch/mips/pci/pci-bcm1480.c
@@ -76,7 +76,7 @@ static inline void WRITECFG32(u32 addr, u32 data)
 
 int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	This is b0rked.
+	/* XXX: This is b0rked. */
 	return dev->irq;
 }
 
diff --git a/arch/mips/pci/pci-sb1250.c b/arch/mips/pci/pci-sb1250.c
index c1ac649..7af499e 100644
--- a/arch/mips/pci/pci-sb1250.c
+++ b/arch/mips/pci/pci-sb1250.c
@@ -86,6 +86,7 @@ static inline void WRITECFG32(u32 addr, u32 data)
 
 int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
+	/* XXX: This is b0rked. */
 	return dev->irq;
 }
 
