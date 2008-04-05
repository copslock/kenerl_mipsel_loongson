Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Apr 2008 21:00:49 +0200 (CEST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:65411 "EHLO
	buildserver.ru.mvista.com") by lappi.linux-mips.net with ESMTP
	id S533222AbYDETAo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 5 Apr 2008 21:00:44 +0200
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id A73DA8810; Sun,  6 Apr 2008 01:00:33 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH] Pb1000: bury the remnants of the PCI code
Date:	Sat, 5 Apr 2008 22:59:29 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804052259.29959.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

PCI support for the Pb1000 board was ectomized by Pete Popov four years ago.
Unfortunately,  the header file  wasn't cleansed, so the remnants still get
in the way of the kernel build (due to macro redefinitions).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
See the commit 709c5032ee77a340e56441f922d76f0b9bd28ed0 in the Linux/MIPS tree
for the original Pete's patch

 include/asm-mips/mach-pb1x00/pb1000.h |   83 ----------------------------------
 1 files changed, 83 deletions(-)

Index: linux-2.6/include/asm-mips/mach-pb1x00/pb1000.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-pb1x00/pb1000.h
+++ linux-2.6/include/asm-mips/mach-pb1x00/pb1000.h
@@ -86,87 +86,4 @@
 /* VPP/VCC */
 #define SET_VCC_VPP(VCC, VPP, SLOT)\
 	((((VCC)<<2) | ((VPP)<<0)) << ((SLOT)*8))
-
-
-/* PCI PB1000 specific defines */
-/* The reason these defines are here instead of au1000.h is because
- * the Au1000 does not have a PCI bus controller so the PCI implementation
- * on the some of the older Pb1000 boards was very board specific.
- */
-#define PCI_CONFIG_BASE   0xBA020000 /* the only external slot */
-
-#define SDRAM_DEVID       0xBA010000
-#define SDRAM_CMD         0xBA010004
-#define SDRAM_CLASS       0xBA010008
-#define SDRAM_MISC        0xBA01000C
-#define SDRAM_MBAR        0xBA010010
-
-#define PCI_IO_DATA_PORT  0xBA800000
-
-#define PCI_IO_ADDR       0xBE00001C
-#define PCI_INT_ACK       0xBBC00000
-#define PCI_IO_READ       0xBBC00020
-#define PCI_IO_WRITE      0xBBC00030
-
-#define PCI_BRIDGE_CONFIG 0xBE000018
-
-#define PCI_IO_START      0x10000000
-#define PCI_IO_END        0x1000ffff
-#define PCI_MEM_START     0x18000000
-#define PCI_MEM_END       0x18ffffff
-
-#define PCI_FIRST_DEVFN   0
-#define PCI_LAST_DEVFN    1
-
-static inline u8 au_pci_io_readb(u32 addr)
-{
-	writel(addr, PCI_IO_ADDR);
-	writel((readl(PCI_BRIDGE_CONFIG) & 0xffffcfff) | (1<<12), PCI_BRIDGE_CONFIG);
-	return (readl(PCI_IO_DATA_PORT) & 0xff);
-}
-
-static inline u16 au_pci_io_readw(u32 addr)
-{
-	writel(addr, PCI_IO_ADDR);
-	writel((readl(PCI_BRIDGE_CONFIG) & 0xffffcfff) | (1<<13), PCI_BRIDGE_CONFIG);
-	return (readl(PCI_IO_DATA_PORT) & 0xffff);
-}
-
-static inline u32 au_pci_io_readl(u32 addr)
-{
-	writel(addr, PCI_IO_ADDR);
-	writel((readl(PCI_BRIDGE_CONFIG) & 0xffffcfff), PCI_BRIDGE_CONFIG);
-	return readl(PCI_IO_DATA_PORT);
-}
-
-static inline void au_pci_io_writeb(u8 val, u32 addr)
-{
-	writel(addr, PCI_IO_ADDR);
-	writel((readl(PCI_BRIDGE_CONFIG) & 0xffffcfff) | (1<<12), PCI_BRIDGE_CONFIG);
-	writel(val, PCI_IO_DATA_PORT);
-}
-
-static inline void au_pci_io_writew(u16 val, u32 addr)
-{
-	writel(addr, PCI_IO_ADDR);
-	writel((readl(PCI_BRIDGE_CONFIG) & 0xffffcfff) | (1<<13), PCI_BRIDGE_CONFIG);
-	writel(val, PCI_IO_DATA_PORT);
-}
-
-static inline void au_pci_io_writel(u32 val, u32 addr)
-{
-	writel(addr, PCI_IO_ADDR);
-	writel(readl(PCI_BRIDGE_CONFIG) & 0xffffcfff, PCI_BRIDGE_CONFIG);
-	writel(val, PCI_IO_DATA_PORT);
-}
-
-static inline void set_sdram_extbyte(void)
-{
-	writel(readl(PCI_BRIDGE_CONFIG) & 0xffffff00, PCI_BRIDGE_CONFIG);
-}
-
-static inline void set_slot_extbyte(void)
-{
-	writel((readl(PCI_BRIDGE_CONFIG) & 0xffffbf00) | 0x18, PCI_BRIDGE_CONFIG);
-}
 #endif /* __ASM_PB1000_H */
