Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 11:36:07 +0100 (BST)
Received: from host191-212-dynamic.8-87-r.retail.telecomitalia.it ([87.8.212.191]:58349
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20024695AbXJDKf7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 11:35:59 +0100
Received: from giuseppe by eppesuigoccas.homedns.org with local (Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IdO0a-0000n7-Cg; Thu, 04 Oct 2007 12:32:44 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] enable PCI bridges in MIPS ip32
Cc:	linux-mips@linux-mips.org
Message-Id: <E1IdO0a-0000n7-Cg@eppesuigoccas.homedns.org>
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Date:	Thu, 04 Oct 2007 12:32:44 +0200
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips


Use bus numbering when addressing device with MACE chipset
in order to support PCI bridges.
Changes in chkslot() and mkaddr() #defines.

Signed-off-by: Giuseppe Sacco <eppesuig@debian.org>
---

Hi Ralf,
I managed to create a patch against current 2.6.23-rc9 git tree
for supporting PCI bridges on SGI ip32 machines.
This is my first kernel patch, so I am usure about the correct way
to send a patch. Please let me know if anything is wrong.

Bye,
Giuseppe

diff --git a/arch/mips/pci/ops-mace.c b/arch/mips/pci/ops-mace.c
index 8008e31..18a7159 100644
--- a/arch/mips/pci/ops-mace.c
+++ b/arch/mips/pci/ops-mace.c
@@ -31,20 +31,21 @@
 
 #define chkslot(_bus,_devfn)					\
 do {							        \
-	if ((_bus)->number > 0 || PCI_SLOT (_devfn) < 1	\
-	    || PCI_SLOT (_devfn) > 3)			        \
+	if ((_bus)->number > 1 ||                               \
+		((_bus)->number == 0 && (PCI_SLOT (_devfn) < 1  \
+	    	|| PCI_SLOT (_devfn) > 3)))		        \
 		return PCIBIOS_DEVICE_NOT_FOUND;		\
 } while (0)
 
-#define mkaddr(_devfn, _reg) \
-((((_devfn) & 0xffUL) << 8) | ((_reg) & 0xfcUL))
+#define mkaddr(_bus, _devfn, _reg) \
+((((_bus)->number & 0xffUL) << 16) | (((_devfn) & 0xffUL) << 8) | ((_reg) & 0xfcUL))
 
 static int
 mace_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 		     int reg, int size, u32 *val)
 {
 	chkslot(bus, devfn);
-	mace->pci.config_addr = mkaddr(devfn, reg);
+	mace->pci.config_addr = mkaddr(bus, devfn, reg);
 	switch (size) {
 	case 1:
 		*val = mace->pci.config_data.b[(reg & 3) ^ 3];
@@ -67,7 +68,7 @@ mace_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 		      int reg, int size, u32 val)
 {
 	chkslot(bus, devfn);
-	mace->pci.config_addr = mkaddr(devfn, reg);
+	mace->pci.config_addr = mkaddr(bus, devfn, reg);
 	switch (size) {
 	case 1:
 		mace->pci.config_data.b[(reg & 3) ^ 3] = val;
