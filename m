Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Dec 2007 17:28:39 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:63823 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20024935AbXLJR2b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Dec 2007 17:28:31 +0000
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id D2B408816; Mon, 10 Dec 2007 22:28:29 +0400 (SAMT)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH] Alchemy: fix PCI resource conflict (take 2)
Date:	Mon, 10 Dec 2007 20:28:51 +0300
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200712102028.51448.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

... by getting the PCI resources back into the 32-bit range -- there's no need
therefore for CONFIG_RESOURCES_64BIT either. This makes Alchemy PCI work again
while currently the kernel skips the bus scan.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
 arch/mips/au1000/Kconfig              |    9 ---------
 arch/mips/au1000/common/pci.c         |    8 ++++----
 include/asm-mips/mach-au1x00/au1000.h |    9 +++++----
 3 files changed, 9 insertions(+), 17 deletions(-)

Index: linux-2.6/arch/mips/au1000/Kconfig
===================================================================
--- linux-2.6.orig/arch/mips/au1000/Kconfig
+++ linux-2.6/arch/mips/au1000/Kconfig
@@ -7,7 +7,6 @@ config MIPS_MTX1
 	bool "4G Systems MTX-1 board"
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
 	select SOC_AU1500
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
@@ -22,7 +21,6 @@ config MIPS_DB1000
 	select SOC_AU1000
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_DB1100
@@ -44,7 +42,6 @@ config MIPS_DB1500
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select MIPS_DISABLE_OBSOLETE_IDE
-	select RESOURCES_64BIT if PCI
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
@@ -54,7 +51,6 @@ config MIPS_DB1550
 	select HW_HAS_PCI
 	select DMA_NONCOHERENT
 	select MIPS_DISABLE_OBSOLETE_IDE
-	select RESOURCES_64BIT if PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_MIRAGE
@@ -68,7 +64,6 @@ config MIPS_PB1000
 	select SOC_AU1000
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
@@ -77,7 +72,6 @@ config MIPS_PB1100
 	select SOC_AU1100
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
 	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
@@ -86,7 +80,6 @@ config MIPS_PB1200
 	select SOC_AU1200
 	select DMA_NONCOHERENT
 	select MIPS_DISABLE_OBSOLETE_IDE
-	select RESOURCES_64BIT if PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_PB1500
@@ -94,7 +87,6 @@ config MIPS_PB1500
 	select SOC_AU1500
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
-	select RESOURCES_64BIT if PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_PB1550
@@ -103,7 +95,6 @@ config MIPS_PB1550
 	select DMA_NONCOHERENT
 	select HW_HAS_PCI
 	select MIPS_DISABLE_OBSOLETE_IDE
-	select RESOURCES_64BIT if PCI
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 
 config MIPS_XXS1500
Index: linux-2.6/arch/mips/au1000/common/pci.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/pci.c
+++ linux-2.6/arch/mips/au1000/common/pci.c
@@ -39,15 +39,15 @@
 
 /* TBD */
 static struct resource pci_io_resource = {
-	.start	= (resource_size_t)PCI_IO_START,
-	.end	= (resource_size_t)PCI_IO_END,
+	.start	= PCI_IO_START,
+	.end	= PCI_IO_END,
 	.name	= "PCI IO space",
 	.flags	= IORESOURCE_IO
 };
 
 static struct resource pci_mem_resource = {
-	.start	= (resource_size_t)PCI_MEM_START,
-	.end	= (resource_size_t)PCI_MEM_END,
+	.start	= PCI_MEM_START,
+	.end	= PCI_MEM_END,
 	.name	= "PCI memory space",
 	.flags	= IORESOURCE_MEM
 };
Index: linux-2.6/include/asm-mips/mach-au1x00/au1000.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1000.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1000.h
@@ -1680,10 +1680,11 @@ enum soc_au1200_ints {
 #define Au1500_PCI_MEM_START      0x440000000ULL
 #define Au1500_PCI_MEM_END        0x44FFFFFFFULL
 
-#define PCI_IO_START    (Au1500_PCI_IO_START + 0x1000)
-#define PCI_IO_END      (Au1500_PCI_IO_END)
-#define PCI_MEM_START   (Au1500_PCI_MEM_START)
-#define PCI_MEM_END     (Au1500_PCI_MEM_END)
+#define PCI_IO_START	0x00001000
+#define PCI_IO_END	0x000FFFFF
+#define PCI_MEM_START	0x40000000
+#define PCI_MEM_END	0x4FFFFFFF
+
 #define PCI_FIRST_DEVFN (0<<3)
 #define PCI_LAST_DEVFN  (19<<3)
 
