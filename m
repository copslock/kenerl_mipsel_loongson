Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Aug 2005 14:47:49 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:2550 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225609AbVHENra>; Fri, 5 Aug 2005 14:47:30 +0100
Received: from localhost (p4173-ipad204funabasi.chiba.ocn.ne.jp [222.146.91.173])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 101B8859B; Fri,  5 Aug 2005 22:51:00 +0900 (JST)
Date:	Fri, 05 Aug 2005 22:58:05 +0900 (JST)
Message-Id: <20050805.225805.25908929.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: include/asm-mips/pci.h fix
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
X-archive-position: 8695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Currently pci_unmap_addr(), etc. are always defined as nop.  It should
be defined when pci_unmap_single is not a nop.  Here is a patch.

diff -ur linux-mips/include/asm-mips/pci.h linux/include/asm-mips/pci.h
--- linux-mips/include/asm-mips/pci.h	2005-07-26 22:14:07.000000000 +0900
+++ linux/include/asm-mips/pci.h	2005-08-05 22:33:14.000000000 +0900
@@ -94,7 +94,7 @@
  */
 extern unsigned int PCI_DMA_BUS_IS_PHYS;
 
-#ifdef CONFIG_MAPPED_DMA_IO
+#ifndef CONFIG_DMA_COHERENT
 
 /* pci_unmap_{single,page} is not a nop, thus... */
 #define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)	dma_addr_t ADDR_NAME;
@@ -104,7 +104,7 @@
 #define pci_unmap_len(PTR, LEN_NAME)		((PTR)->LEN_NAME)
 #define pci_unmap_len_set(PTR, LEN_NAME, VAL)	(((PTR)->LEN_NAME) = (VAL))
 
-#else /* CONFIG_MAPPED_DMA_IO  */
+#else /* CONFIG_DMA_COHERENT  */
 
 /* pci_unmap_{page,single} is a nop so... */
 #define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)
@@ -114,7 +114,7 @@
 #define pci_unmap_len(PTR, LEN_NAME)		(0)
 #define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
 
-#endif /* CONFIG_MAPPED_DMA_IO  */
+#endif /* CONFIG_DMA_COHERENT  */
 
 /* This is always fine. */
 #define pci_dac_dma_supported(pci_dev, mask)	(1)
