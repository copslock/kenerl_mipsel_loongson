Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Mar 2008 18:52:46 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:20422 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28646296AbYCHSwo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 8 Mar 2008 18:52:44 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JY49z-00022v-00; Sat, 08 Mar 2008 19:52:43 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id BA791E31BE; Sat,  8 Mar 2008 19:51:55 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] BCM1480: Init pci controller io_map_base
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20080308185155.BA791E31BE@solo.franken.de>
Date:	Sat,  8 Mar 2008 19:51:55 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

BCM1480: Init pci controller io_map_base

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/pci/pci-bcm1480.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci-bcm1480.c b/arch/mips/pci/pci-bcm1480.c
index 30ed361..ab68c43 100644
--- a/arch/mips/pci/pci-bcm1480.c
+++ b/arch/mips/pci/pci-bcm1480.c
@@ -249,8 +249,9 @@ static int __init bcm1480_pcibios_init(void)
 	 * XXX ehs: Should this happen in PCI Device mode?
 	 */
 
-	set_io_port_base((unsigned long)
-		ioremap(A_BCM1480_PHYS_PCI_IO_MATCH_BYTES, 65536));
+	bcm1480_controller.io_map_base = (unsigned long)
+		ioremap(A_BCM1480_PHYS_PCI_IO_MATCH_BYTES, 65536);
+	set_io_port_base(bcm1480_controller.io_map_base);
 	isa_slot_offset = (unsigned long)
 		ioremap(A_BCM1480_PHYS_PCI_MEM_MATCH_BYTES, 1024*1024);
 
