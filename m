Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB738qG09898
	for linux-mips-outgoing; Thu, 6 Dec 2001 19:08:52 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB738go09895;
	Thu, 6 Dec 2001 19:08:42 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fB728xB29424;
	Thu, 6 Dec 2001 18:08:59 -0800
Message-ID: <3C1024A2.F3603F6A@mvista.com>
Date: Thu, 06 Dec 2001 18:08:34 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips-kernel@lists.sourceforge.net, linux-mips@oss.sgi.com,
   ralf@oss.sgi.com
Subject: [PATCH] pci_auto handles better when no IO/MEM behind P2P bridge
Content-Type: multipart/mixed;
 boundary="------------DCA2F6226E833725CC283805"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------DCA2F6226E833725CC283805
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Any objections?

Jun
--------------DCA2F6226E833725CC283805
Content-Type: text/plain; charset=us-ascii;
 name="pci-auto-p2p-bridge-noiomem.011205.011206.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-auto-p2p-bridge-noiomem.011205.011206.patch"

diff -Nru test/arch/mips/kernel/pci_auto.c.orig test/arch/mips/kernel/pci_auto.c
--- test/arch/mips/kernel/pci_auto.c.orig	Mon Nov 26 18:22:58 2001
+++ test/arch/mips/kernel/pci_auto.c	Thu Dec  6 18:05:04 2001
@@ -252,9 +252,28 @@
 			      int top_bus,
 			      int current_bus,
 			      int pci_devfn,
-			      int sub_bus)
+			      int sub_bus,
+			      u32 prescan_pciauto_lower_iospc,
+			      u32 prescan_pciauto_lower_memspc)
 {
 	u32 temp;
+	u32 flag;
+
+	/* 
+	 * [jsun] we cannot simply just write post scan value.
+	 * If there is nothing behind P2P bridge, we need to 
+	 * turn off the IO/MEM addr decoding at all. 
+	 * The spec recommands to write higher BASE value than the LIMIT
+	 * value.  I think it works just fine if we disable appropriate
+	 * bits in COMMAND register.
+	 */
+	flag = PCI_COMMAND_MASTER;
+	if (prescan_pciauto_lower_memspc != pciauto_lower_memspc) {
+		flag |= PCI_COMMAND_MEMORY;
+	}
+	if (prescan_pciauto_lower_iospc != pciauto_lower_iospc) {
+		flag |= PCI_COMMAND_IO;
+	}
 
 	/* Configure bus number registers */
 	early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
@@ -278,8 +297,7 @@
 	early_read_config_dword(hose, top_bus, current_bus, pci_devfn,
 		PCI_COMMAND, &temp);
 	early_write_config_dword(hose, top_bus, current_bus, pci_devfn,
-		PCI_COMMAND, temp | PCI_COMMAND_IO | PCI_COMMAND_MEMORY
-		| PCI_COMMAND_MASTER);
+		PCI_COMMAND, temp | flag);
 }
 
 #define      PCIAUTO_IDE_MODE_MASK           0x05
@@ -331,6 +349,9 @@
 		DBG("\n");
 
 		if ((pci_class >> 16) == PCI_CLASS_BRIDGE_PCI) {
+			u32 prescan_pciauto_lower_iospc;
+			u32 prescan_pciauto_lower_memspc;
+
 			DBG("        Bridge: primary=%.2x, secondary=%.2x\n",
 				current_bus, sub_bus + 1);
 			pciauto_prescan_setup_bridge(hose, top_bus, current_bus,
@@ -338,10 +359,16 @@
 			DBG("Scanning sub bus %.2x, I/O 0x%.8x, Mem 0x%.8x\n",
 				sub_bus + 1,
 				pciauto_lower_iospc, pciauto_lower_memspc);
+
+			prescan_pciauto_lower_iospc = pciauto_lower_iospc;
+			prescan_pciauto_lower_memspc = pciauto_lower_memspc;
+
 			sub_bus = pciauto_bus_scan(hose, top_bus, sub_bus+1);
 			DBG("Back to bus %.2x\n", current_bus);
 			pciauto_postscan_setup_bridge(hose, top_bus, current_bus,
-						      pci_devfn, sub_bus);
+						      pci_devfn, sub_bus,
+						      prescan_pciauto_lower_iospc,
+						      prescan_pciauto_lower_memspc);
 			continue;
 		} else if ((pci_class >> 16) == PCI_CLASS_STORAGE_IDE) {
 

--------------DCA2F6226E833725CC283805--
