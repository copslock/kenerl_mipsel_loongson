Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 00:37:55 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:65265 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225209AbTDIXhy>;
	Thu, 10 Apr 2003 00:37:54 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h39Nbqb06351;
	Wed, 9 Apr 2003 16:37:52 -0700
Date: Wed, 9 Apr 2003 16:37:52 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] suport cardbus bridge in pciauto
Message-ID: <20030409163752.E32396@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


This adds support for cardbus bridge in pciauto resource assignment.
Patch created by Yuasa-san and Alice.  Modified by me.

Jun

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="030409.pciauto-cardbus-support.patch"

diff -Nru link/arch/mips/kernel/pci_auto.c.orig link/arch/mips/kernel/pci_auto.c
--- link/arch/mips/kernel/pci_auto.c.orig	Mon Aug  5 16:53:33 2002
+++ link/arch/mips/kernel/pci_auto.c	Wed Apr  9 16:17:02 2003
@@ -3,7 +3,7 @@
  *
  * Author: Matt Porter <mporter@mvista.com>
  *
- * Copyright 2000, 2001 MontaVista Software Inc.
+ * Copyright 2000, 2001, 2002, 2003 MontaVista Software Inc.
  * Copyright 2001 Bradley D. LaRonde <brad@ltc.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -29,6 +29,9 @@
  * - Align io and memory base properly before and after bridge setup.
  * - Don't fall through to pci_setup_bars for bridge.
  * - Reformat the debug output to look more like lspci's output.
+ *
+ * 2003-04-09 Youchi Yuasa, Alice Hennessy, Jun Sun
+ * - Add cardbus bridge support, mostly copied from PPC
  */
 
 #include <linux/kernel.h>
@@ -99,7 +102,8 @@
 pciauto_setup_bars(struct pci_channel *hose,
 		   int top_bus,
 		   int current_bus,
-		   int pci_devfn)
+		   int pci_devfn,
+		   int bar_limit)
 {
 	u32 bar_response, bar_size, bar_value;
 	u32 bar, addr_mask, bar_nr = 0;
@@ -107,7 +111,7 @@
 	u32 * lower_limit;
 	int found_mem64 = 0;
 
-	for (bar = PCI_BASE_ADDRESS_0; bar <= PCI_BASE_ADDRESS_5; bar+=4) {
+	for (bar = PCI_BASE_ADDRESS_0; bar <= bar_limit; bar+=4) {
 		/* Tickle the BAR and get the response */
 		early_write_config_dword(hose, top_bus,
 					 current_bus,
@@ -282,6 +286,88 @@
 		| PCI_COMMAND_MASTER);
 }
 
+void __init
+pciauto_prescan_setup_cardbus_bridge(struct pci_channel *hose,
+                            int top_bus,
+                            int current_bus,
+                            int pci_devfn,
+                            int sub_bus)
+{
+       /* Configure bus number registers */
+       early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
+                               PCI_PRIMARY_BUS, current_bus);
+       early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
+                               PCI_SECONDARY_BUS, sub_bus + 1);
+       early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
+                               PCI_SUBORDINATE_BUS, 0xff);
+
+       /* Align memory and I/O to 4KB and 4 byte boundaries. */
+       pciauto_lower_memspc = (pciauto_lower_memspc + (0x1000 - 1))
+               & ~(0x1000 - 1);
+       pciauto_lower_iospc = (pciauto_lower_iospc + (0x4 - 1))
+               & ~(0x4 - 1);
+
+       early_write_config_dword(hose, top_bus, current_bus, pci_devfn,
+               PCI_CB_MEMORY_BASE_0, pciauto_lower_memspc);
+       early_write_config_dword(hose, top_bus, current_bus, pci_devfn,
+               PCI_CB_IO_BASE_0, pciauto_lower_iospc);  
+}
+
+void __init
+pciauto_postscan_setup_cardbus_bridge(struct pci_channel *hose,
+                             int top_bus,
+                             int current_bus,
+                             int pci_devfn,
+                             int sub_bus)
+{
+	u32 temp;
+
+	/*
+	 * Configure subordinate bus number.  The PCI subsystem
+	 * bus scan will renumber buses (reserving three additional
+	 * for this PCI<->CardBus bridge for the case where a CardBus
+	 * adapter contains a P2P or CB2CB bridge.
+	 */
+
+       early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
+                               PCI_SUBORDINATE_BUS, sub_bus);
+
+	/*
+	 * Reserve an additional 4MB for mem space and 16KB for
+	 * I/O space.  This should cover any additional space
+	 * requirement of unusual CardBus devices with 
+	 * additional bridges that can consume more address space.
+	 * 
+	 * Although pcmcia-cs currently will reprogram bridge
+	 * windows, the goal is to add an option to leave them
+	 * alone and use the bridge window ranges as the regions
+	 * that are searched for free resources upon hot-insertion
+	 * of a device.  This will allow a PCI<->CardBus bridge
+	 * configured by this routine to happily live behind a
+	 * P2P bridge in a system.
+	 */
+	pciauto_upper_memspc += 0x00400000;
+	pciauto_upper_iospc += 0x00004000;
+
+	/* Align memory and I/O to 4KB and 4 byte boundaries. */
+	pciauto_lower_memspc = (pciauto_lower_memspc + (0x1000 - 1))
+				& ~(0x1000 - 1);
+	pciauto_lower_iospc = (pciauto_lower_iospc + (0x4 - 1))
+				& ~(0x4 - 1);
+	/* Set up memory and I/O filter limits, assume 32-bit I/O space */
+	early_write_config_dword(hose, top_bus, current_bus, pci_devfn,
+			PCI_CB_MEMORY_LIMIT_0, pciauto_lower_memspc - 1); 
+	early_write_config_dword(hose, top_bus, current_bus, pci_devfn,
+			PCI_CB_IO_LIMIT_0, pciauto_lower_iospc - 1);
+       
+	/* Enable memory and I/O accesses, enable bus master */
+	early_read_config_dword(hose, top_bus, current_bus, pci_devfn,
+			PCI_COMMAND, &temp);
+	early_write_config_dword(hose, top_bus, current_bus, pci_devfn,
+		PCI_COMMAND, temp | PCI_COMMAND_IO | PCI_COMMAND_MEMORY
+		| PCI_COMMAND_MASTER);
+}
+
 #define      PCIAUTO_IDE_MODE_MASK           0x05
 
 int __init
@@ -343,6 +429,24 @@
 			pciauto_postscan_setup_bridge(hose, top_bus, current_bus,
 						      pci_devfn, sub_bus);
 			continue;
+                } else if ((pci_class >> 16) == PCI_CLASS_BRIDGE_CARDBUS) {
+                        DBG("  CARDBUS  Bridge: primary=%.2x, secondary=%.2x\n",
+                                current_bus, sub_bus + 1);
+                        DBG("PCI Autoconfig: Found CardBus bridge, device %d function %d\n", PCI_SLOT(pci_devfn), PCI_FUNC(pci_devfn));
+                        /* Place CardBus Socket/ExCA registers */
+                        pciauto_setup_bars(hose, top_bus, current_bus, pci_devfn, PCI_BASE_ADDRESS_0);
+ 
+                        pciauto_prescan_setup_cardbus_bridge(hose, top_bus, 
+                                        current_bus, pci_devfn, sub_bus);
+ 
+                        DBG("Scanning sub bus %.2x, I/O 0x%.8x, Mem 0x%.8x\n",
+                                sub_bus + 1,
+                                pciauto_lower_iospc, pciauto_lower_memspc);
+			sub_bus = pciauto_bus_scan(hose, top_bus, sub_bus+1);
+			DBG("Back to bus %.2x, sub_bus is %x\n", current_bus, sub_bus);
+			pciauto_postscan_setup_cardbus_bridge(hose, top_bus, 
+                                        current_bus, pci_devfn, sub_bus);
+                        continue;
 		} else if ((pci_class >> 16) == PCI_CLASS_STORAGE_IDE) {
 
 			unsigned char prg_iface;
@@ -369,7 +473,7 @@
 					PCI_LATENCY_TIMER, 0x80);
 
 		/* Allocate PCI I/O and/or memory space */
-		pciauto_setup_bars(hose, top_bus, current_bus, pci_devfn);
+		pciauto_setup_bars(hose, top_bus, current_bus, pci_devfn, PCI_BASE_ADDRESS_5);
 	}
 	return sub_bus;
 }

--r5Pyd7+fXNt84Ff3--
