Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jul 2009 03:17:23 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:20227 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492933AbZGOBRQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 15 Jul 2009 03:17:16 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a5d2e0e0001>; Tue, 14 Jul 2009 21:17:02 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 14 Jul 2009 18:16:55 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 14 Jul 2009 18:16:54 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n6F1GqQk018425;
	Tue, 14 Jul 2009 18:16:52 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n6F1GoWG018423;
	Tue, 14 Jul 2009 18:16:50 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon PCIe: Make hardware and software bus numbers match.
Date:	Tue, 14 Jul 2009 18:16:50 -0700
Message-Id: <1247620610-18399-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 15 Jul 2009 01:16:54.0942 (UTC) FILETIME=[F0ECC3E0:01CA04E9]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Some SiliconImage PCIe SATA controlers are not detected when the bus
numbers differ.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/pci/pcie-octeon.c |   31 +++++++++++++++++--------------
 1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index 7526224..6aa5c54 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -1040,19 +1040,29 @@ static inline int octeon_pcie_read_config(int pcie_port, struct pci_bus *bus,
 	int bus_number = bus->number;
 
 	/*
-	 * We need to force the bus number to be zero on the root
-	 * bus. Linux numbers the 2nd root bus to start after all
-	 * buses on root 0.
+	 * For the top level bus make sure our hardware bus number
+	 * matches the software one.
 	 */
-	if (bus->parent == NULL)
-		bus_number = 0;
+	if (bus->parent == NULL) {
+		union cvmx_pciercx_cfg006 pciercx_cfg006;
+		pciercx_cfg006.u32 = cvmx_pcie_cfgx_read(pcie_port,
+			CVMX_PCIERCX_CFG006(pcie_port));
+		if (pciercx_cfg006.s.pbnum != bus_number) {
+			pciercx_cfg006.s.pbnum = bus_number;
+			pciercx_cfg006.s.sbnum = bus_number;
+			pciercx_cfg006.s.subbnum = bus_number;
+			cvmx_pcie_cfgx_write(pcie_port,
+				CVMX_PCIERCX_CFG006(pcie_port),
+				pciercx_cfg006.u32);
+		}
+	}
 
 	/*
 	 * PCIe only has a single device connected to Octeon. It is
 	 * always device ID 0. Don't bother doing reads for other
 	 * device IDs on the first segment.
 	 */
-	if ((bus_number == 0) && (devfn >> 3 != 0))
+	if ((bus->parent == NULL) && (devfn >> 3 != 0))
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 
 	/*
@@ -1070,7 +1080,7 @@ static inline int octeon_pcie_read_config(int pcie_port, struct pci_bus *bus,
 		 * bridge only respondes to device ID 0, function
 		 * 0-1
 		 */
-		if ((bus_number == 0) && (devfn >= 2))
+		if ((bus->parent == NULL) && (devfn >= 2))
 			return PCIBIOS_FUNC_NOT_SUPPORTED;
 		/*
 		 * The PCI-X slots are device ID 2,3. Choose one of
@@ -1167,13 +1177,6 @@ static inline int octeon_pcie_write_config(int pcie_port, struct pci_bus *bus,
 					   int size, u32 val)
 {
 	int bus_number = bus->number;
-	/*
-	 * We need to force the bus number to be zero on the root
-	 * bus. Linux numbers the 2nd root bus to start after all
-	 * busses on root 0.
-	 */
-	if (bus->parent == NULL)
-		bus_number = 0;
 
 	switch (size) {
 	case 4:
-- 
1.6.0.6
