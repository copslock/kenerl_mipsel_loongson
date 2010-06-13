Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jun 2010 23:23:14 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35886 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492114Ab0FMVXK convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Jun 2010 23:23:10 +0200
Received: from [192.168.4.185] (helo=localhost)
        by shadbolt.decadent.org.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <ben@decadent.org.uk>)
        id 1ONudx-0004C0-Fm; Sun, 13 Jun 2010 22:23:02 +0100
Received: from ben by localhost with local (Exim 4.71)
        (envelope-from <ben@decadent.org.uk>)
        id 1ONudv-0003IV-OP; Sun, 13 Jun 2010 22:22:59 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Martin Michlmayr <tbm@cyrius.com>,
        Aurelien Jarno <aurelien@aurel32.net>, 584784@bugs.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Sun, 13 Jun 2010 22:22:59 +0100
Message-ID: <1276464179.14011.218.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.1.2 
X-SA-Exim-Connect-IP: 192.168.4.185
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: [PATCH] mips: Set io_map_base for several PCI bridges lacking it
X-SA-Exim-Version: 4.2.1 (built Wed, 25 Jun 2008 17:14:11 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
X-archive-position: 27128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 9038

Several MIPS platforms don't set pci_controller::io_map_base for their
PCI bridges.  This results in a panic in pci_iomap().  (The panic is
conditional on CONFIG_PCI_DOMAINS, but that is now enabled for all PCI
MIPS systems.)

I have tested the change to Malta in qemu; the other platforms not at
all.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/mti-malta/malta-pci.c  |    2 ++
 arch/mips/pci/ops-pmcmsp.c       |    1 +
 arch/mips/pci/pci-yosemite.c     |    1 +
 arch/mips/pnx8550/common/pci.c   |    1 +
 arch/mips/pnx8550/common/setup.c |    2 +-
 5 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mti-malta/malta-pci.c b/arch/mips/mti-malta/malta-pci.c
index 2fbfa1a..bf80921 100644
--- a/arch/mips/mti-malta/malta-pci.c
+++ b/arch/mips/mti-malta/malta-pci.c
@@ -247,6 +247,8 @@ void __init mips_pcibios_init(void)
 	iomem_resource.end &= 0xfffffffffULL;			/* 64 GB */
 	ioport_resource.end = controller->io_resource->end;
 
+	controller->io_map_base = mips_io_port_base;
+
 	register_pci_controller(controller);
 }
 
diff --git a/arch/mips/pci/ops-pmcmsp.c b/arch/mips/pci/ops-pmcmsp.c
index 04b3147..b7c03d8 100644
--- a/arch/mips/pci/ops-pmcmsp.c
+++ b/arch/mips/pci/ops-pmcmsp.c
@@ -944,6 +944,7 @@ static struct pci_controller msp_pci_controller = {
 	.pci_ops	= &msp_pci_ops,
 	.mem_resource	= &pci_mem_resource,
 	.mem_offset	= 0,
+	.io_map_base	= MSP_PCI_IOSPACE_BASE,
 	.io_resource	= &pci_io_resource,
 	.io_offset	= 0
 };
diff --git a/arch/mips/pci/pci-yosemite.c b/arch/mips/pci/pci-yosemite.c
index 0357946..cf5e1a2 100644
--- a/arch/mips/pci/pci-yosemite.c
+++ b/arch/mips/pci/pci-yosemite.c
@@ -54,6 +54,7 @@ static int __init pmc_yosemite_setup(void)
 		panic(ioremap_failed);
 
 	set_io_port_base(io_v_base);
+	py_controller.io_map_base = io_v_base;
 	TITAN_WRITE(RM9000x2_OCD_LKM7, TITAN_READ(RM9000x2_OCD_LKM7) | 1);
 
 	ioport_resource.end = TITAN_IO_SIZE - 1;
diff --git a/arch/mips/pnx8550/common/pci.c b/arch/mips/pnx8550/common/pci.c
index eee4f3d..98e86dd 100644
--- a/arch/mips/pnx8550/common/pci.c
+++ b/arch/mips/pnx8550/common/pci.c
@@ -44,6 +44,7 @@ extern struct pci_ops pnx8550_pci_ops;
 
 static struct pci_controller pnx8550_controller = {
 	.pci_ops	= &pnx8550_pci_ops,
+	.io_map_base	= PNX8550_PORT_BASE,
 	.io_resource	= &pci_io_resource,
 	.mem_resource	= &pci_mem_resource,
 };
diff --git a/arch/mips/pnx8550/common/setup.c b/arch/mips/pnx8550/common/setup.c
index 2aed50f..64246c9 100644
--- a/arch/mips/pnx8550/common/setup.c
+++ b/arch/mips/pnx8550/common/setup.c
@@ -113,7 +113,7 @@ void __init plat_mem_setup(void)
 	PNX8550_GLB2_ENAB_INTA_O = 0;
 
 	/* IO/MEM resources. */
-	set_io_port_base(KSEG1);
+	set_io_port_base(PNX8550_PORT_BASE);
 	ioport_resource.start = 0;
 	ioport_resource.end = ~0;
 	iomem_resource.start = 0;
-- 
1.7.1
