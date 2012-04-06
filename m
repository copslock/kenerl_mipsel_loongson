Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Apr 2012 22:08:12 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:35279 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904078Ab2DFUIF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Apr 2012 22:08:05 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SGFRt-0004Bl-W1; Fri, 06 Apr 2012 15:07:57 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [v2,4/5] MIPS: Malta PCI changes for PCI 2.1 compatibility and conflicts.
Date:   Fri,  6 Apr 2012 15:07:49 -0500
Message-Id: <1333742869-17373-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
X-archive-position: 32874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Turns on PCI 2.1 compatibility for the Malta platform for the
PIIX4 controller. Change start address to avoid conflicts with
the ACPI and SMB devices.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/mti-malta/malta-pci.c   |    5 +++--
 arch/mips/mti-malta/malta-setup.c |   14 ++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mti-malta/malta-pci.c b/arch/mips/mti-malta/malta-pci.c
index bf80921..afeb619 100644
--- a/arch/mips/mti-malta/malta-pci.c
+++ b/arch/mips/mti-malta/malta-pci.c
@@ -241,8 +241,9 @@ void __init mips_pcibios_init(void)
 		return;
 	}
 
-	if (controller->io_resource->start < 0x00001000UL)	/* FIXME */
-		controller->io_resource->start = 0x00001000UL;
+	/* Change start address to avoid conflicts with ACPI and SMB devices */
+	if (controller->io_resource->start < 0x00002000UL)	/* FIXME */
+		controller->io_resource->start = 0x00002000UL;
 
 	iomem_resource.end &= 0xfffffffffULL;			/* 64 GB */
 	ioport_resource.end = controller->io_resource->end;
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index b7f37d4..b45b343 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -222,3 +222,17 @@ void __init plat_mem_setup(void)
 	board_be_init = malta_be_init;
 	board_be_handler = malta_be_handler;
 }
+
+/* Enable PCI 2.1 compatibility in PIIX4. */
+static void __init quirk_dlcsetup(struct pci_dev *dev)
+{
+	u8 dlc;
+
+	/* Enable passive releases and delayed transactions. */
+	(void) pci_read_config_byte(dev, 0x82, &dlc);
+	dlc |= 7;
+	(void) pci_write_config_byte(dev, 0x82, dlc);
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0,
+			quirk_dlcsetup);
-- 
1.7.9.6
