Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 May 2004 18:06:13 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:63176 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225548AbUE3RGA>;
	Sun, 30 May 2004 18:06:00 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id CAA03106;
	Mon, 31 May 2004 02:05:55 +0900 (JST)
Received: 4UMDO01 id i4UH5sR01446; Mon, 31 May 2004 02:05:55 +0900 (JST)
Received: 4UMRO00 id i4UH5qO24414; Mon, 31 May 2004 02:05:53 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Mon, 31 May 2004 02:05:51 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] fix 2 warning of MIPS PCI codes
Message-Id: <20040531020551.413ca901.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

The 2 warning of PCI was fixed by this patch.

drivers/pci/setup-res.c: In function `pci_update_resource':
drivers/pci/setup-res.c:43: warning: implicit declaration of function `pcibios_resource_to_bus'

arch/mips/pci/pci.c: In function `pcibios_fixup_device_resources':
arch/mips/pci/pci.c:234: warning: `offset' might be used uninitialized in this function

Please apply to v2.6 CVS tree.

Yoichi

diff -urN -X dontdiff linux-orig/arch/mips/pci/pci.c linux/arch/mips/pci/pci.c
--- linux-orig/arch/mips/pci/pci.c	Tue Jan 20 02:48:06 2004
+++ linux/arch/mips/pci/pci.c	Sun May 30 07:03:03 2004
@@ -231,7 +231,7 @@
 {
 	/* Update device resources.  */
 	struct pci_controller *hose = (struct pci_controller *)bus->sysdata;
-	unsigned long offset;
+	unsigned long offset = 0;
 	int i;
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
diff -urN -X dontdiff linux-orig/include/asm-mips/pci.h linux/include/asm-mips/pci.h
--- linux-orig/include/asm-mips/pci.h	Tue Apr 13 08:19:05 2004
+++ linux/include/asm-mips/pci.h	Sun May 30 11:56:01 2004
@@ -87,6 +87,9 @@
 extern void pci_dac_dma_sync_single_for_device(struct pci_dev *pdev,
 	dma64_addr_t dma_addr, size_t len, int direction);
 
+extern void pcibios_resource_to_bus(struct pci_dev *dev,
+	struct pci_bus_region *region, struct resource *res);
+
 #endif /* __KERNEL__ */
 
 /* implement the pci_ DMA API in terms of the generic device dma_ one */
