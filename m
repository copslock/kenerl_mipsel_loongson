Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2006 10:25:47 +0000 (GMT)
Received: from serv07.server-center.de ([83.220.153.152]:37861 "EHLO
	serv07.server-center.de") by ftp.linux-mips.org with ESMTP
	id S28642015AbWLUKZm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Dec 2006 10:25:42 +0000
Received: (qmail 3782 invoked from network); 21 Dec 2006 11:24:33 +0100
Received: by simscan 1.1.0 ppid: 3507, pid: 3562, t: 8.0854s
         scanners: regex: 1.1.0 clamav: 0.88.2/m:39/d:1600 spam: 3.1.0
Received: from unknown (HELO mycable-alex.mycable.de) (www518317@87.139.57.5)
  by serv07.server-center.de with ESMTPA; 21 Dec 2006 11:24:25 +0100
Received: from ab by mycable-alex.mycable.de with local (Exim 4.50)
	id 1GxL71-00039O-H4; Thu, 21 Dec 2006 11:25:19 +0100
Date:	Thu, 21 Dec 2006 11:25:19 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix PCI-memory access on Alchemy Au15x0
Message-ID: <20061221102519.GA11796@mycable-alex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From:	Alexander Bigga <ab@mycable.de>
Return-Path: <ab@mycable.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ab@mycable.de
Precedence: bulk
X-list: linux-mips

Hello,


the PCI support on Alchemy Au1500 and Au1550 based platforms is actually broken in
the current mips-kernel.

The problem was introduced in 2.6.18.3 with the casting of some 36bit-defines
(PCI memory) in au1000.h to resource_size_t which may be u32 or u64 depending on
the experimental CONFIG_RESOURCES_64BIT.

With unset CONFIG_RESOURCES_64BIT, the pci-memory cannot be accessed because
the ioremap in arch/mips/au1000/common/pci.c already used the truncated
addresses.
With set CONFIG_RESOURCES_64BIT, things get even worse, because PCI-scan
aborts, due to resource conflict: request_resource() in arch/mips/pci/pci.c
fails because the maximum iomem-address is 0xffffffff (32bit) but the
pci-memory-start-address is 0x440000000 (36bit).

To get pci working again, I propose the following patch:

1. remove the resource_size_t-casting from au1000.h again
2. make the casting in arch/mips/au1000/common/pci.c (it's allowed and
necessary here. The 36bit-handling will be done in __fixup_bigphys_addr).

With this patch pci works again like in 2.6.18.2, the gcc-compile warnings
in pci.c are gone and it doesn't depend on CONFIG_EXPERIMENTAL.

Only advantages ;-) Nevertheless, I'm open for your comments or even better
solutions.


Best regards,


Alexander



Signed-off-by: Alexander Bigga <ab@mycable.de>

 arch/mips/au1000/common/pci.c         |    8 ++++----
 include/asm-mips/mach-au1x00/au1000.h |   12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.19.1/include/asm-mips/mach-au1x00/au1000.h	2006-12-12 00:38:26.000000000 +0100
+++ linux-2.6.19.1-dev/include/asm-mips/mach-au1x00/au1000.h	2006-12-21 09:58:15.000000000 +0100
@@ -1665,12 +1665,12 @@
  * addresses.  For PCI IO, it's simpler because we get to do the ioremap
  * ourselves and then adjust the device's resources.
  */
-#define Au1500_EXT_CFG            ((resource_size_t) 0x600000000ULL)
-#define Au1500_EXT_CFG_TYPE1      ((resource_size_t) 0x680000000ULL)
-#define Au1500_PCI_IO_START       ((resource_size_t) 0x500000000ULL)
-#define Au1500_PCI_IO_END         ((resource_size_t) 0x5000FFFFFULL)
-#define Au1500_PCI_MEM_START      ((resource_size_t) 0x440000000ULL)
-#define Au1500_PCI_MEM_END        ((resource_size_t) 0x44FFFFFFFULL)
+#define Au1500_EXT_CFG            0x600000000ULL
+#define Au1500_EXT_CFG_TYPE1      0x680000000ULL
+#define Au1500_PCI_IO_START       0x500000000ULL
+#define Au1500_PCI_IO_END         0x5000FFFFFULL
+#define Au1500_PCI_MEM_START      0x440000000ULL
+#define Au1500_PCI_MEM_END        0x44FFFFFFFULL
 
 #define PCI_IO_START    (Au1500_PCI_IO_START + 0x1000)
 #define PCI_IO_END      (Au1500_PCI_IO_END)
--- linux-2.6.19.1//arch/mips/au1000/common/pci.c	2006-12-12 00:38:26.000000000 +0100
+++ linux-2.6.19.1-dev/arch/mips/au1000/common/pci.c	2006-12-20 20:22:55.000000000 +0100
@@ -39,15 +39,15 @@
 
 /* TBD */
 static struct resource pci_io_resource = {
-	.start	= PCI_IO_START,
-	.end	= PCI_IO_END,
+	.start	= (resource_size_t)PCI_IO_START,
+	.end	= (resource_size_t)PCI_IO_END,
 	.name	= "PCI IO space",
 	.flags	= IORESOURCE_IO
 };
 
 static struct resource pci_mem_resource = {
-	.start	= PCI_MEM_START,
-	.end	= PCI_MEM_END,
+	.start	= (resource_size_t)PCI_MEM_START,
+	.end	= (resource_size_t)PCI_MEM_END,
 	.name	= "PCI memory space",
 	.flags	= IORESOURCE_MEM
 };



-- 
Alexander Bigga      Tel: +49-4321-55956-25
mycable GmbH         Fax: +49-4321-55956-10
Gartenstrasse 10    
D-24534 Neumuenster  eMail: ab@mycable.de
