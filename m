Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jul 2004 14:16:24 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:9408 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225555AbUGANQU>; Thu, 1 Jul 2004 14:16:20 +0100
Received: from localhost (p6018-ipad28funabasi.chiba.ocn.ne.jp [220.107.205.18])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1DC986E7B; Thu,  1 Jul 2004 22:16:16 +0900 (JST)
Date: Thu, 01 Jul 2004 22:21:20 +0900 (JST)
Message-Id: <20040701.222120.41626500.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: 2.4 pci_dma_sync_sg fix
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

pci_dma_sync_sg in 2.4 tree seems broken.  pci_map_sg were fixed a
while ago.  Please fix pci_dma_sync_sg also.

Here is a patch.

Index: pci.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/pci.h,v
retrieving revision 1.24.2.16
diff -u -r1.24.2.16 pci.h
--- pci.h	17 Nov 2003 01:07:45 -0000	1.24.2.16
+++ pci.h	1 Jul 2004 13:10:48 -0000
@@ -270,20 +270,28 @@
  */
 static inline void pci_dma_sync_sg(struct pci_dev *hwdev,
 				   struct scatterlist *sg,
-				   int nelems, int direction)
+				   int nents, int direction)
 {
-#ifdef CONFIG_NONCOHERENT_IO
 	int i;
-#endif
 
 	if (direction == PCI_DMA_NONE)
 		out_of_line_bug();
 
-	/* Make sure that gcc doesn't leave the empty loop body.  */
-#ifdef CONFIG_NONCOHERENT_IO
-	for (i = 0; i < nelems; i++, sg++)
-		dma_cache_wback_inv((unsigned long)sg->address, sg->length);
-#endif
+	for (i = 0; i < nents; i++, sg++) {
+		if (sg->address && sg->page)
+			out_of_line_bug();
+		else if (!sg->address && !sg->page)
+			out_of_line_bug();
+
+		if (sg->address) {
+			dma_cache_wback_inv((unsigned long)sg->address,
+			                    sg->length);
+		} else {
+			dma_cache_wback_inv((unsigned long)
+				(page_address(sg->page) + sg->offset),
+				sg->length);
+		}
+	}
 }
 
 /*
---
Atsushi Nemoto
