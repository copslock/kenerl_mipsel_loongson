Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 00:47:05 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:54260 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225209AbTDIXrE>;
	Thu, 10 Apr 2003 00:47:04 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h39Nl2N06385;
	Wed, 9 Apr 2003 16:47:02 -0700
Date: Wed, 9 Apr 2003 16:47:02 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] pciatuo setup P2P bridge properly
Message-ID: <20030409164702.G32396@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This patches solves two problems:

1) if there are no devices behind P2P bridge, the xxx_base and xxx_limit
will be set to the same address, which willd decode 4Kb for MEM space
or 16 bytes for IO space at at that address.  This address will overlap
with the next pci device resources assigned right after the P2P bridge.

Simply adding 1 byte would leave proper cushion.

2) Sometimes P2P bridge controller may need resources.  (Don't ask me why)
We were ignoring this before.

Jun

--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030409.pciauto-setup-bridge-properly.patch"

diff -Nru link/arch/mips/kernel/pci_auto.c.orig link/arch/mips/kernel/pci_auto.c
--- link/arch/mips/kernel/pci_auto.c.orig	Wed Apr  9 16:17:02 2003
+++ link/arch/mips/kernel/pci_auto.c	Wed Apr  9 16:28:09 2003
@@ -260,6 +260,14 @@
 {
 	u32 temp;
 
+	/* 
+	 * [jsun] we always bump up baselines a little, so that if there
+	 * nothing behind P2P bridge, we don't wind up overlapping IO/MEM
+	 * spaces.
+	 */
+	pciauto_lower_memspc += 1;
+	pciauto_lower_iospc += 1;
+
 	/* Configure bus number registers */
 	early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
 				PCI_SUBORDINATE_BUS, sub_bus);
@@ -419,6 +427,8 @@
 		if ((pci_class >> 16) == PCI_CLASS_BRIDGE_PCI) {
 			DBG("        Bridge: primary=%.2x, secondary=%.2x\n",
 				current_bus, sub_bus + 1);
+			pciauto_setup_bars(hose, top_bus, current_bus, 
+					pci_devfn, PCI_BASE_ADDRESS_1);
 			pciauto_prescan_setup_bridge(hose, top_bus, current_bus,
 						     pci_devfn, sub_bus);
 			DBG("Scanning sub bus %.2x, I/O 0x%.8x, Mem 0x%.8x\n",

--4ZLFUWh1odzi/v6L--
