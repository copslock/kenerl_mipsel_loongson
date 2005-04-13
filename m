Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2005 14:32:13 +0100 (BST)
Received: from idmailgate1.unizh.ch ([IPv6:::ffff:130.60.68.105]:39468 "EHLO
	idmailgate1.unizh.ch") by linux-mips.org with ESMTP
	id <S8225808AbVDMNb5>; Wed, 13 Apr 2005 14:31:57 +0100
Received: from localhost ([130.60.169.171])
	by idmailgate1.unizh.ch (8.13.1/8.13.1/SuSE Linux 0.7) with ESMTP id j3DDVsLw008833;
	Wed, 13 Apr 2005 15:31:54 +0200
Date:	Wed, 13 Apr 2005 15:31:52 +0200
From:	Tobias Klauser <tklauser@nuerscht.ch>
To:	kernel-janitors@lists.osdl.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] net/ioc3-eth: Use the DMA_{32,64}BIT_MASK constants
Message-ID: <20050413133147.GA9864@argon.tklauser.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 0x3A445520
X-OS:	GNU/Linux
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Return-Path: <tklauser@access.unizh.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tklauser@nuerscht.ch
Precedence: bulk
X-list: linux-mips

Use the DMA_{32,64}BIT_MASK constants from dma-mapping.h when calling
pci_set_dma_mask() or pci_set_consistent_dma_mask()
This patch includes dma-mapping.h explicitly because patches caused
errors on some architectures otherwise.
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>

diff -urpN linux-2.6.12-rc2-mm3/drivers/net/ioc3-eth.c linux-2.6.12-rc2-mm3-tk/drivers/net/ioc3-eth.c
--- linux-2.6.12-rc2-mm3/drivers/net/ioc3-eth.c	2005-04-12 16:56:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3-tk/drivers/net/ioc3-eth.c	2005-04-12 17:28:55.470878176 +0200
@@ -38,6 +38,7 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <linux/crc32.h>
 #include <linux/mii.h>
 #include <linux/in.h>
@@ -1193,17 +1194,17 @@ static int ioc3_probe(struct pci_dev *pd
 	int err, pci_using_dac;
 
 	/* Configure DMA attributes. */
-	err = pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
+	err = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
 	if (!err) {
 		pci_using_dac = 1;
-		err = pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL);
+		err = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
 		if (err < 0) {
 			printk(KERN_ERR "%s: Unable to obtain 64 bit DMA "
 			       "for consistent allocations\n", pci_name(pdev));
 			goto out;
 		}
 	} else {
-		err = pci_set_dma_mask(pdev, 0xffffffffULL);
+		err = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (err) {
 			printk(KERN_ERR "%s: No usable DMA configuration, "
 			       "aborting.\n", pci_name(pdev));
