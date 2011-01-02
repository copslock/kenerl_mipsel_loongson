Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jan 2011 08:25:04 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:36634 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491106Ab1ABHYy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Jan 2011 08:24:54 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p027N1ea000094;
        Sat, 1 Jan 2011 23:23:01 -0800 (PST)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Sat, 1 Jan 2011 23:23:01 -0800
Received: from yow-pgortmak-d1.corp.ad.wrs.com ([128.224.146.65]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Sat, 1 Jan 2011 23:23:01 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     stable@kernel.org, linux-kernel@vger.kernel.org
Cc:     stable-review@kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        linux-mips@linux-mips.org, Martin Michlmayr <tbm@cyrius.com>,
        Aurelien Jarno <aurelien@aurel32.net>, 584784@bugs.debian.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [34-longterm 156/260] MIPS: Set io_map_base for several PCI bridges lacking it
Date:   Sun,  2 Jan 2011 02:17:32 -0500
Message-Id: <1293952756-15010-157-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.7.3.3
In-Reply-To: <1293952756-15010-1-git-send-email-paul.gortmaker@windriver.com>
References: <1293952756-15010-1-git-send-email-paul.gortmaker@windriver.com>
X-OriginalArrivalTime: 02 Jan 2011 07:23:01.0681 (UTC) FILETIME=[E3892210:01CBAA4D]
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips

From: Ben Hutchings <ben@decadent.org.uk>

commit 8faf2e6c201d95b780cd3b4674b7a55ede6dcbbb upstream.

Several MIPS platforms don't set pci_controller::io_map_base for their
PCI bridges.  This results in a panic in pci_iomap().  (The panic is
conditional on CONFIG_PCI_DOMAINS, but that is now enabled for all PCI
MIPS systems.)

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-mips@linux-mips.org
Cc: Martin Michlmayr <tbm@cyrius.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: 584784@bugs.debian.org
Patchwork: https://patchwork.linux-mips.org/patch/1377/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/mti-malta/malta-pci.c      |    2 ++
 arch/mips/nxp/pnx8550/common/pci.c   |    1 +
 arch/mips/nxp/pnx8550/common/setup.c |    2 +-
 arch/mips/pci/ops-pmcmsp.c           |    1 +
 arch/mips/pci/pci-yosemite.c         |    1 +
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
 
diff --git a/arch/mips/nxp/pnx8550/common/pci.c b/arch/mips/nxp/pnx8550/common/pci.c
index eee4f3d..98e86dd 100644
--- a/arch/mips/nxp/pnx8550/common/pci.c
+++ b/arch/mips/nxp/pnx8550/common/pci.c
@@ -44,6 +44,7 @@ extern struct pci_ops pnx8550_pci_ops;
 
 static struct pci_controller pnx8550_controller = {
 	.pci_ops	= &pnx8550_pci_ops,
+	.io_map_base	= PNX8550_PORT_BASE,
 	.io_resource	= &pci_io_resource,
 	.mem_resource	= &pci_mem_resource,
 };
diff --git a/arch/mips/nxp/pnx8550/common/setup.c b/arch/mips/nxp/pnx8550/common/setup.c
index 2aed50f..64246c9 100644
--- a/arch/mips/nxp/pnx8550/common/setup.c
+++ b/arch/mips/nxp/pnx8550/common/setup.c
@@ -113,7 +113,7 @@ void __init plat_mem_setup(void)
 	PNX8550_GLB2_ENAB_INTA_O = 0;
 
 	/* IO/MEM resources. */
-	set_io_port_base(KSEG1);
+	set_io_port_base(PNX8550_PORT_BASE);
 	ioport_resource.start = 0;
 	ioport_resource.end = ~0;
 	iomem_resource.start = 0;
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
-- 
1.7.3.3
