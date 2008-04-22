Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2008 20:29:37 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:63574 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20045096AbYDVT3e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Apr 2008 20:29:34 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 8E9088815; Wed, 23 Apr 2008 00:29:32 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: Alchemy: kill unused PCI_IRQ_TABLE_LOOKUP macro
Date:	Tue, 22 Apr 2008 23:28:57 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804222328.57098.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18995
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
 include/asm-mips/mach-au1x00/au1000.h |   14 --------------
 1 files changed, 14 deletions(-)

Index: linux-2.6/include/asm-mips/mach-au1x00/au1000.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1000.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1000.h
@@ -1685,20 +1685,6 @@ enum soc_au1200_ints {
 #define IOMEM_RESOURCE_START  0x10000000
 #define IOMEM_RESOURCE_END    0xffffffff
 
-  /*
-   * Borrowed from the PPC arch:
-   * The following macro is used to lookup irqs in a standard table
-   * format for those PPC systems that do not already have PCI
-   * interrupts properly routed.
-   */
-  /* FIXME - double check this from asm-ppc/pci-bridge.h */
-#define PCI_IRQ_TABLE_LOOKUP                            \
-  ({ long _ctl_ = -1;                                 \
-      if (idsel >= min_idsel && idsel <= max_idsel && pin <= irqs_per_slot)    \
-	       _ctl_ = pci_irq_table[idsel - min_idsel][pin-1];               \
-		      _ctl_; })
-
-
 #else /* Au1000 and Au1100 and Au1200 */
 
 /* don't allow any legacy ports probing */
