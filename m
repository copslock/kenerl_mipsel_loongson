Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2002 02:48:10 +0100 (CET)
Received: from jeeves.momenco.com ([64.169.228.99]:20232 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1123920AbSKGBsK>; Thu, 7 Nov 2002 02:48:10 +0100
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id gA71m3N01252;
	Wed, 6 Nov 2002 17:48:03 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: "Linux-MIPS" <linux-mips@linux-mips.org>
Subject: PATCH: compile fixes for Ocelot-G for 2.5
Date: Wed, 6 Nov 2002 17:48:03 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAICECNCKAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001A_01C285BC.A78BD460"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_001A_01C285BC.A78BD460
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

This patch fixes the Ocelot-G code so that it will compile with 2.5 --
primarily, this is a result of the change in PCI configuration
functions.

Note that this is a 2.5-only patch....

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

------=_NextPart_000_001A_01C285BC.A78BD460
Content-Type: application/octet-stream;
	name="patch20021106b"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch20021106b"

Index: arch/mips/momentum/ocelot_g/pci-irq.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/momentum/ocelot_g/pci-irq.c,v=0A=
retrieving revision 1.3=0A=
diff -u -u -r1.3 pci-irq.c=0A=
--- arch/mips/momentum/ocelot_g/pci-irq.c	3 Sep 2002 16:13:11 -0000	1.3=0A=
+++ arch/mips/momentum/ocelot_g/pci-irq.c	7 Nov 2002 01:44:22 -0000=0A=
@@ -58,14 +58,17 @@=0A=
 		}=0A=
 =0A=
 		/* Assign an interrupt number for the device */=0A=
-		bus->ops->write_byte(devices, PCI_INTERRUPT_LINE, devices->irq);=0A=
+		bus->ops->write(current_bus, devices,=0A=
+			PCI_INTERRUPT_LINE, 1, devices->irq);=0A=
 =0A=
 		/* enable master for everything but the GT-64240 */=0A=
 		if (((current_bus->number !=3D 0) && (current_bus->number !=3D 1))=0A=
 				|| (PCI_SLOT(devices->devfn) !=3D 0)) {=0A=
-			bus->ops->read_word(devices, PCI_COMMAND, &cmd);=0A=
+			bus->ops->read(current_bus, devices,=0A=
+					PCI_COMMAND, 2, &cmd);=0A=
 			cmd |=3D PCI_COMMAND_MASTER;=0A=
-			bus->ops->write_word(devices, PCI_COMMAND, cmd);=0A=
+			bus->ops->write(current_bus, devices,=0A=
+					PCI_COMMAND, 2, cmd);=0A=
 		}=0A=
 	}=0A=
 }=0A=
Index: arch/mips/momentum/ocelot_g/pci.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/momentum/ocelot_g/pci.c,v=0A=
retrieving revision 1.6=0A=
diff -u -u -r1.6 pci.c=0A=
--- arch/mips/momentum/ocelot_g/pci.c	3 Nov 2002 21:44:38 -0000	1.6=0A=
+++ arch/mips/momentum/ocelot_g/pci.c	7 Nov 2002 01:44:22 -0000=0A=
@@ -49,19 +49,26 @@=0A=
 void gt64240_board_pcibios_fixup_bus(struct pci_bus* c);=0A=
 =0A=
 /*  Functions to implement "pci ops"  */=0A=
-static int galileo_pcibios_read_config_word(struct pci_dev *dev,=0A=
+static int galileo_pcibios_read_config_word(int bus, int devfn,=0A=
 					    int offset, u16 * val);=0A=
-static int galileo_pcibios_read_config_byte(struct pci_dev *dev,=0A=
+static int galileo_pcibios_read_config_byte(int bus, int devfn,=0A=
 					    int offset, u8 * val);=0A=
-static int galileo_pcibios_read_config_dword(struct pci_dev *dev,=0A=
+static int galileo_pcibios_read_config_dword(int bus, int devfn,=0A=
 					     int offset, u32 * val);=0A=
-static int galileo_pcibios_write_config_byte(struct pci_dev *dev,=0A=
+static int galileo_pcibios_write_config_byte(int bus, int devfn,=0A=
 					     int offset, u8 val);=0A=
-static int galileo_pcibios_write_config_word(struct pci_dev *dev,=0A=
+static int galileo_pcibios_write_config_word(int bus, int devfn,=0A=
 					     int offset, u16 val);=0A=
-static int galileo_pcibios_write_config_dword(struct pci_dev *dev,=0A=
+static int galileo_pcibios_write_config_dword(int bus, int devfn,=0A=
 					      int offset, u32 val);=0A=
+#if 0=0A=
 static void galileo_pcibios_set_master(struct pci_dev *dev);=0A=
+#endif=0A=
+=0A=
+static int pci_read(struct pci_bus *bus, unsigned int devfs, int where,=0A=
+						int size, u32* val);=0A=
+static int pci_write(struct pci_bus *bus, unsigned int devfs, int where,=0A=
+						int size, u32 val);=0A=
 =0A=
 /*=0A=
  *  General-purpose PCI functions.=0A=
@@ -111,16 +118,15 @@=0A=
  * PCIBIOS_BAD_REGISTER_NUMBER when accessing non aligned=0A=
  */=0A=
 =0A=
-static int galileo_pcibios_read_config_dword(struct pci_dev *device,=0A=
+static int galileo_pcibios_read_config_dword(int bus, int devfn,=0A=
 					      int offset, u32* val)=0A=
 {=0A=
-	int dev, bus, func;=0A=
+	int dev, func;=0A=
 	uint32_t address_reg, data_reg;=0A=
 	uint32_t address;=0A=
 =0A=
-	bus =3D device->bus->number;=0A=
-	dev =3D PCI_SLOT(device->devfn);=0A=
-	func =3D PCI_FUNC(device->devfn);=0A=
+	dev =3D PCI_SLOT(devfn);=0A=
+	func =3D PCI_FUNC(devfn);=0A=
 =0A=
 	/* verify the range */=0A=
 	if (pci_range_ck(bus, dev))=0A=
@@ -152,16 +158,15 @@=0A=
 }=0A=
 =0A=
 =0A=
-static int galileo_pcibios_read_config_word(struct pci_dev *device,=0A=
+static int galileo_pcibios_read_config_word(int bus, int devfn,=0A=
 					     int offset, u16* val)=0A=
 {=0A=
-	int dev, bus, func;=0A=
+	int dev, func;=0A=
 	uint32_t address_reg, data_reg;=0A=
 	uint32_t address;=0A=
 =0A=
-	bus =3D device->bus->number;=0A=
-	dev =3D PCI_SLOT(device->devfn);=0A=
-	func =3D PCI_FUNC(device->devfn);=0A=
+	dev =3D PCI_SLOT(devfn);=0A=
+	func =3D PCI_FUNC(devfn);=0A=
 =0A=
 	/* verify the range */=0A=
 	if (pci_range_ck(bus, dev))=0A=
@@ -192,16 +197,15 @@=0A=
 	return PCIBIOS_SUCCESSFUL;=0A=
 }=0A=
 =0A=
-static int galileo_pcibios_read_config_byte(struct pci_dev *device,=0A=
+static int galileo_pcibios_read_config_byte(int bus, int devfn,=0A=
 					     int offset, u8* val)=0A=
 {=0A=
-	int dev, bus, func;=0A=
+	int dev, func;=0A=
 	uint32_t address_reg, data_reg;=0A=
 	uint32_t address;=0A=
 =0A=
-	bus =3D device->bus->number;=0A=
-	dev =3D PCI_SLOT(device->devfn);=0A=
-	func =3D PCI_FUNC(device->devfn);=0A=
+	dev =3D PCI_SLOT(devfn);=0A=
+	func =3D PCI_FUNC(devfn);=0A=
 =0A=
 	/* verify the range */=0A=
 	if (pci_range_ck(bus, dev))=0A=
@@ -230,16 +234,15 @@=0A=
 	return PCIBIOS_SUCCESSFUL;=0A=
 }=0A=
 =0A=
-static int galileo_pcibios_write_config_dword(struct pci_dev *device,=0A=
+static int galileo_pcibios_write_config_dword(int bus, int devfn,=0A=
 					      int offset, u32 val)=0A=
 {=0A=
-	int dev, bus, func;=0A=
+	int dev, func;=0A=
 	uint32_t address_reg, data_reg;=0A=
 	uint32_t address;=0A=
 =0A=
-	bus =3D device->bus->number;=0A=
-	dev =3D PCI_SLOT(device->devfn);=0A=
-	func =3D PCI_FUNC(device->devfn);=0A=
+	dev =3D PCI_SLOT(devfn);=0A=
+	func =3D PCI_FUNC(devfn);=0A=
 =0A=
 	/* verify the range */=0A=
 	if (pci_range_ck(bus, dev))=0A=
@@ -269,16 +272,15 @@=0A=
 }=0A=
 =0A=
 =0A=
-static int galileo_pcibios_write_config_word(struct pci_dev *device,=0A=
+static int galileo_pcibios_write_config_word(int bus, int devfn,=0A=
 					     int offset, u16 val)=0A=
 {=0A=
-	int dev, bus, func;=0A=
+	int dev, func;=0A=
 	uint32_t address_reg, data_reg;=0A=
 	uint32_t address;=0A=
 =0A=
-	bus =3D device->bus->number;=0A=
-	dev =3D PCI_SLOT(device->devfn);=0A=
-	func =3D PCI_FUNC(device->devfn);=0A=
+	dev =3D PCI_SLOT(devfn);=0A=
+	func =3D PCI_FUNC(devfn);=0A=
 =0A=
 	/* verify the range */=0A=
 	if (pci_range_ck(bus, dev))=0A=
@@ -307,16 +309,15 @@=0A=
 	return PCIBIOS_SUCCESSFUL;=0A=
 }=0A=
 =0A=
-static int galileo_pcibios_write_config_byte(struct pci_dev *device,=0A=
+static int galileo_pcibios_write_config_byte(int bus, int devfn,=0A=
 					     int offset, u8 val)=0A=
 {=0A=
-	int dev, bus, func;=0A=
+	int dev, func;=0A=
 	uint32_t address_reg, data_reg;=0A=
 	uint32_t address;=0A=
 =0A=
-	bus =3D device->bus->number;=0A=
-	dev =3D PCI_SLOT(device->devfn);=0A=
-	func =3D PCI_FUNC(device->devfn);=0A=
+	dev =3D PCI_SLOT(devfn);=0A=
+	func =3D PCI_FUNC(devfn);=0A=
 =0A=
 	/* verify the range */=0A=
 	if (pci_range_ck(bus, dev))=0A=
@@ -345,6 +346,7 @@=0A=
 	return PCIBIOS_SUCCESSFUL;=0A=
 }=0A=
 =0A=
+#if 0=0A=
 static void galileo_pcibios_set_master(struct pci_dev *dev)=0A=
 {=0A=
 	u16 cmd;=0A=
@@ -353,6 +355,7 @@=0A=
 	cmd |=3D PCI_COMMAND_MASTER;=0A=
 	galileo_pcibios_write_config_word(dev, PCI_COMMAND, cmd);=0A=
 }=0A=
+#endif=0A=
 =0A=
 /*  Externally-expected functions.  Do not change function names  */=0A=
 =0A=
@@ -363,7 +366,7 @@=0A=
 	int idx;=0A=
 	struct resource *r;=0A=
 =0A=
-	galileo_pcibios_read_config_word(dev, PCI_COMMAND, &cmd);=0A=
+	pci_read(dev->bus, dev->devfn, PCI_COMMAND, 2, (u32*)&cmd);=0A=
 	old_cmd =3D cmd;=0A=
 	for (idx =3D 0; idx < 6; idx++) {=0A=
 		r =3D &dev->resource[idx];=0A=
@@ -379,7 +382,7 @@=0A=
 			cmd |=3D PCI_COMMAND_MEMORY;=0A=
 	}=0A=
 	if (cmd !=3D old_cmd) {=0A=
-		galileo_pcibios_write_config_word(dev, PCI_COMMAND, cmd);=0A=
+		pci_write(dev->bus, dev->devfn, PCI_COMMAND, 2, cmd);=0A=
 	}=0A=
 =0A=
 	/*=0A=
@@ -387,19 +390,17 @@=0A=
 	 * line size =3D 32 bytes / sizeof dword (4) =3D 8.=0A=
 	 * Latency timer must be > 8.  32 is random but appears to work.=0A=
 	 */=0A=
-	galileo_pcibios_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &tmp1);=0A=
+	pci_read(dev->bus, dev->devfn, PCI_CACHE_LINE_SIZE, 1, (u32*)&tmp1);=0A=
 	if (tmp1 !=3D 8) {=0A=
 		printk(KERN_WARNING "PCI setting cache line size to 8 from "=0A=
 		       "%d\n", tmp1);=0A=
-		galileo_pcibios_write_config_byte(dev, PCI_CACHE_LINE_SIZE,=0A=
-						  8);=0A=
+		pci_write(dev->bus, dev->devfn, PCI_CACHE_LINE_SIZE, 1, 8);=0A=
 	}=0A=
-	galileo_pcibios_read_config_byte(dev, PCI_LATENCY_TIMER, &tmp1);=0A=
+	pci_read(dev->bus, dev->devfn, PCI_LATENCY_TIMER, 1, (u32*)&tmp1);=0A=
 	if (tmp1 < 32) {=0A=
 		printk(KERN_WARNING "PCI setting latency timer to 32 from %d\n",=0A=
 		       tmp1);=0A=
-		galileo_pcibios_write_config_byte(dev, PCI_LATENCY_TIMER,=0A=
-						  32);=0A=
+		pci_write(dev->bus, dev->devfn, PCI_LATENCY_TIMER, 1, 32);=0A=
 	}=0A=
 =0A=
 	return 0;=0A=
@@ -413,12 +414,12 @@=0A=
 void pcibios_update_resource(struct pci_dev *dev, struct resource *root,=0A=
 			     struct resource *res, int resource)=0A=
 {=0A=
-	u32 new, check;=0A=
-	int reg;=0A=
-=0A=
 	return;=0A=
 =0A=
 #if 0=0A=
+	u32 new, check;=0A=
+	int reg;=0A=
+=0A=
 	new =3D res->start | (res->flags & PCI_REGION_FLAG_MASK);=0A=
 	if (resource < 6) {=0A=
 		reg =3D PCI_BASE_ADDRESS_0 + 4 * resource;=0A=
@@ -468,13 +469,43 @@=0A=
 }=0A=
 =0A=
 struct pci_ops galileo_pci_ops =3D {=0A=
-	galileo_pcibios_read_config_byte,=0A=
-	galileo_pcibios_read_config_word,=0A=
-	galileo_pcibios_read_config_dword,=0A=
-	galileo_pcibios_write_config_byte,=0A=
-	galileo_pcibios_write_config_word,=0A=
-	galileo_pcibios_write_config_dword=0A=
+	.read =3D pci_read,=0A=
+	.write =3D pci_write=0A=
 };=0A=
+=0A=
+static int pci_read(struct pci_bus *bus, unsigned int devfn, int where,=0A=
+						int size, u32* val)=0A=
+{=0A=
+	switch (size) {=0A=
+		case 1:=0A=
+			return galileo_pcibios_read_config_byte(bus->number,=0A=
+					devfn, where, (u8*) val);=0A=
+		case 2:=0A=
+			return galileo_pcibios_read_config_word(bus->number,=0A=
+					devfn, where, (u16*) val);=0A=
+		case 4:=0A=
+			return galileo_pcibios_read_config_dword(bus->number,=0A=
+					devfn, where, (u32*) val);=0A=
+	}=0A=
+	return PCIBIOS_FUNC_NOT_SUPPORTED;=0A=
+}=0A=
+=0A=
+static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,=0A=
+						int size, u32 val)=0A=
+{=0A=
+	switch (size) {=0A=
+		case 1:=0A=
+			return galileo_pcibios_write_config_byte(bus->number,=0A=
+					devfn, where, val);=0A=
+		case 2:=0A=
+			return galileo_pcibios_write_config_word(bus->number,=0A=
+					devfn, where, val);=0A=
+		case 4:=0A=
+			return galileo_pcibios_write_config_dword(bus->number,=0A=
+					devfn, where, val);=0A=
+	}=0A=
+	return PCIBIOS_FUNC_NOT_SUPPORTED;=0A=
+}=0A=
 =0A=
 struct pci_fixup pcibios_fixups[] =3D {=0A=
 	{0}=0A=
Index: arch/mips/momentum/ocelot_g/setup.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /home/cvs/linux/arch/mips/momentum/ocelot_g/setup.c,v=0A=
retrieving revision 1.4=0A=
diff -u -u -r1.4 setup.c=0A=
--- arch/mips/momentum/ocelot_g/setup.c	7 Nov 2002 00:02:47 -0000	1.4=0A=
+++ arch/mips/momentum/ocelot_g/setup.c	7 Nov 2002 01:44:23 -0000=0A=
@@ -86,7 +86,7 @@=0A=
 =0A=
 static char reset_reason;=0A=
 =0A=
-#define ENTRYLO(x) ((pte_val(mk_pte_phys((x) >> PAGE_SHIFT, =
PAGE_KERNEL_UNCACHED)) >> 6)|1)=0A=
+#define ENTRYLO(x) ((pte_val(pfn_pte((x) >> PAGE_SHIFT, =
PAGE_KERNEL_UNCACHED)) >> 6)|1)=0A=
 =0A=
 static void __init setup_l3cache(unsigned long size);=0A=
 =0A=

------=_NextPart_000_001A_01C285BC.A78BD460--
