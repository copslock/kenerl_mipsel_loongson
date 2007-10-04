Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 22:09:24 +0100 (BST)
Received: from host191-212-dynamic.8-87-r.retail.telecomitalia.it ([87.8.212.191]:35799
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20026575AbXJDVJQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 22:09:16 +0100
Received: from giuseppe by eppesuigoccas.homedns.org with local (Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IdXwW-0004Ja-08; Thu, 04 Oct 2007 23:09:12 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] mips/ip32: enable PCI bridges
Cc:	linux-mips@linux-mips.org
Message-Id: <E1IdXwW-0004Ja-08@eppesuigoccas.homedns.org>
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Date:	Thu, 04 Oct 2007 23:09:12 +0200
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Fixes MACE PCI addressing adding the bus number parameter.
Remove check of the used slot since every slot should be valid.
Converted mkaddr from #define to inline function.

Signed-off-by: Giuseppe Sacco <eppesuig@debian.org>
---

Hi Ralf and linux-mips list,
I managed to create a second patch, still against current 
.6.23-rc9 git tree, for supporting PCI bridges on SGI ip32 machines.
It include your suggestion on moving from #define to inline.

Bye,
Giuseppe

diff --git a/arch/mips/pci/ops-mace.c b/arch/mips/pci/ops-mace.c
index 8008e31..2025f1f 100644
--- a/arch/mips/pci/ops-mace.c
+++ b/arch/mips/pci/ops-mace.c
@@ -29,22 +29,20 @@
  * 4  N/C
  */
 
-#define chkslot(_bus,_devfn)					\
-do {							        \
-	if ((_bus)->number > 0 || PCI_SLOT (_devfn) < 1	\
-	    || PCI_SLOT (_devfn) > 3)			        \
-		return PCIBIOS_DEVICE_NOT_FOUND;		\
-} while (0)
+static inline int mkaddr(struct pci_bus *bus, unsigned int devfn,
+	unsigned int reg)
+{
+	return ((bus->number & 0xff) << 16) |
+		(devfn & 0xff) << 8) |
+		(reg & 0xfc);
+}
 
-#define mkaddr(_devfn, _reg) \
-((((_devfn) & 0xffUL) << 8) | ((_reg) & 0xfcUL))
 
 static int
 mace_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 		     int reg, int size, u32 *val)
 {
-	chkslot(bus, devfn);
-	mace->pci.config_addr = mkaddr(devfn, reg);
+	mace->pci.config_addr = mkaddr(bus, devfn, reg);
 	switch (size) {
 	case 1:
 		*val = mace->pci.config_data.b[(reg & 3) ^ 3];
@@ -66,8 +64,7 @@ static int
 mace_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 		      int reg, int size, u32 val)
 {
-	chkslot(bus, devfn);
-	mace->pci.config_addr = mkaddr(devfn, reg);
+	mace->pci.config_addr = mkaddr(bus, devfn, reg);
 	switch (size) {
 	case 1:
 		mace->pci.config_data.b[(reg & 3) ^ 3] = val;
