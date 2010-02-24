Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 21:38:55 +0100 (CET)
Received: from g1t0026.austin.hp.com ([15.216.28.33]:44651 "EHLO
        g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492474Ab0BXUiu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2010 21:38:50 +0100
Received: from g1t0039.austin.hp.com (g1t0039.austin.hp.com [16.236.32.45])
        by g1t0026.austin.hp.com (Postfix) with ESMTP id EAEB0C1AA;
        Wed, 24 Feb 2010 20:38:42 +0000 (UTC)
Received: from ldl (ldl.fc.hp.com [15.11.146.30])
        by g1t0039.austin.hp.com (Postfix) with ESMTP id 83157340DE;
        Wed, 24 Feb 2010 20:38:42 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
        by ldl (Postfix) with ESMTP id 49B47CF0097;
        Wed, 24 Feb 2010 13:38:42 -0700 (MST)
Received: from ldl ([127.0.0.1])
        by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QLC9rmIsCbRu; Wed, 24 Feb 2010 13:38:42 -0700 (MST)
Received: from tigger.helgaas (lart.fc.hp.com [15.11.146.31])
        by ldl (Postfix) with ESMTP id 301A5CF0095;
        Wed, 24 Feb 2010 13:38:42 -0700 (MST)
From:   Bjorn Helgaas <bjorn.helgaas@hp.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Subject: RFC: [MIPS] BCM1480/BCM1480HT remove io_offset
Date:   Wed, 24 Feb 2010 13:38:41 -0700
User-Agent: KMail/1.9.10
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201002241338.41501.bjorn.helgaas@hp.com>
Return-Path: <bjorn.helgaas@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

BCM1480 and BCM1480HT currently offset the Linux ioport space from the
PCI ioport addresses, e.g., for BCM1480, device I/O resources from the CPU
perspective are in the range [io 0x2c000000-0x2dffffff] (these would appear
in /proc/ioports) and are converted by the PCI controller to the PCI range
[io 0x0-0x1fffff].
    
It should be simpler to remove this io_offset and adjust the controller's
io_map_base correspondingly.  For BCM1480, this would change this:
    
    [CPU io 0x2c000000-0x2dffffff] -> [PCI io 0x0-0x1ffffff]
    bcm1480_controller.io_offset = 0x2c000000
    bcm1480_controller.io_map_base = 0 (physical)
    mips_io_port_base = 0 (physical)
    
to this:
    
    [CPU io 0x0-0x1ffffff] -> [PCI io 0x0-0x1ffffff]
    bcm1480_controller.io_offset = 0
    bcm1480_controller.io_map_base = 0x2c000000 (physical)
    mips_io_port_base = 0x2c000000 (physical)
    
Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff --git a/arch/mips/pci/pci-bcm1480.c b/arch/mips/pci/pci-bcm1480.c
index 6f5e24c..74585cb 100644
--- a/arch/mips/pci/pci-bcm1480.c
+++ b/arch/mips/pci/pci-bcm1480.c
@@ -185,8 +185,8 @@ static struct resource bcm1480_mem_resource = {
 
 static struct resource bcm1480_io_resource = {
 	.name	= "BCM1480 PCI I/O",
-	.start	= A_BCM1480_PHYS_PCI_IO_MATCH_BYTES,
-	.end	= A_BCM1480_PHYS_PCI_IO_MATCH_BYTES + 0x1ffffffUL,
+	.start	= 0,
+	.end	= 0x1ffffffUL,
 	.flags	= IORESOURCE_IO,
 };
 
@@ -194,7 +194,6 @@ struct pci_controller bcm1480_controller = {
 	.pci_ops	= &bcm1480_pci_ops,
 	.mem_resource	= &bcm1480_mem_resource,
 	.io_resource	= &bcm1480_io_resource,
-	.io_offset      = A_BCM1480_PHYS_PCI_IO_MATCH_BYTES,
 };
 
 
@@ -251,7 +250,6 @@ static int __init bcm1480_pcibios_init(void)
 
 	bcm1480_controller.io_map_base = (unsigned long)
 		ioremap(A_BCM1480_PHYS_PCI_IO_MATCH_BYTES, 65536);
-	bcm1480_controller.io_map_base -= bcm1480_controller.io_offset;
 	set_io_port_base(bcm1480_controller.io_map_base);
 
 	register_pci_controller(&bcm1480_controller);
diff --git a/arch/mips/pci/pci-bcm1480ht.c b/arch/mips/pci/pci-bcm1480ht.c
index 50cc6e9..0fd0222 100644
--- a/arch/mips/pci/pci-bcm1480ht.c
+++ b/arch/mips/pci/pci-bcm1480ht.c
@@ -180,8 +180,8 @@ static struct resource bcm1480ht_mem_resource = {
 
 static struct resource bcm1480ht_io_resource = {
 	.name	= "BCM1480 HT I/O",
-	.start	= A_BCM1480_PHYS_HT_IO_MATCH_BYTES,
-	.end	= A_BCM1480_PHYS_HT_IO_MATCH_BYTES + 0x01ffffffUL,
+	.start	= 0,
+	.end	= 0x01ffffffUL,
 	.flags	= IORESOURCE_IO,
 };
 
@@ -191,7 +191,6 @@ struct pci_controller bcm1480ht_controller = {
 	.io_resource	= &bcm1480ht_io_resource,
 	.index		= 1,
 	.get_busno	= bcm1480ht_pcibios_get_busno,
-	.io_offset      = A_BCM1480_PHYS_HT_IO_MATCH_BYTES,
 };
 
 static int __init bcm1480ht_pcibios_init(void)
@@ -206,7 +205,6 @@ static int __init bcm1480ht_pcibios_init(void)
 			4 * 1024 * 1024);
 	bcm1480ht_controller.io_map_base = (unsigned long)
 		ioremap(A_BCM1480_PHYS_HT_IO_MATCH_BYTES, 65536);
-	bcm1480ht_controller.io_map_base -= bcm1480ht_controller.io_offset;
 
 	register_pci_controller(&bcm1480ht_controller);
 
