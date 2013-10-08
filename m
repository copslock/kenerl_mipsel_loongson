Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 19:35:10 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:37947 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822674Ab3JHRfIABS0V (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 19:35:08 +0200
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     <Steven.Hill@imgtec.com>, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH v2] MIPS/Malta: Incorporate PIIX4 ACPI I/O region in PCI controller resources
Date:   Tue, 8 Oct 2013 10:33:53 -0700
Message-ID: <1381253633-599-1-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.136.61]
X-SEF-Processed: 7_3_0_01192__2013_10_08_18_35_01
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38274
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Boot log says:

pci 0000:00:0a.3: no compatible bridge window for [io  0x1000-0x103f]
pci 0000:00:0a.3: no compatible bridge window for [io  0x1100-0x110f]

The io resource starting point on Malta was modified by c5de50dada (MIPS:
Malta: Change start address to avoid conflicts.) to avoid conflicts with
ACPI and SMB devices. In fact, that was not needed (and now causing
southbridge ACPI missing) since 166c637075 (PCI: add pci_create_root_bus()
that accepts resource list) and 7c090e5bfa (mips/PCI: convert to
pci_scan_root_bus() for correct root bus resources) had already done the
correct fix.

This patch actually reverts the change made by c5de50dada. And with this
fix, log says:

pci 0000:00:0a.3: quirk: [io  0x1000-0x103f] claimed by PIIX4 ACPI
pci 0000:00:0a.3: quirk: [io  0x1100-0x110f] claimed by PIIX4 SMB

These things may not be used but as part of platform resources are better
off to be included.

Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
Changes:
v2 - v1:
o Add more information to the commit message.

 arch/mips/pci/pci-malta.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/pci/pci-malta.c b/arch/mips/pci/pci-malta.c
index 37134dd..f1a7389 100644
--- a/arch/mips/pci/pci-malta.c
+++ b/arch/mips/pci/pci-malta.c
@@ -241,9 +241,9 @@ void __init mips_pcibios_init(void)
 		return;
 	}
 
-	/* Change start address to avoid conflicts with ACPI and SMB devices */
-	if (controller->io_resource->start < 0x00002000UL)
-		controller->io_resource->start = 0x00002000UL;
+	/* PIIX4 ACPI starts at 0x1000 */
+	if (controller->io_resource->start < 0x00001000UL)
+		controller->io_resource->start = 0x00001000UL;
 
 	iomem_resource.end &= 0xfffffffffULL;			/* 64 GB */
 	ioport_resource.end = controller->io_resource->end;
-- 
1.7.1
