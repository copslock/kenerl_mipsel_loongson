Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2002 08:04:37 +0100 (CET)
Received: from r-bu.iij4u.or.jp ([210.130.0.89]:42223 "EHLO r-bu.iij4u.or.jp")
	by linux-mips.org with ESMTP id <S1122165AbSKHHEh>;
	Fri, 8 Nov 2002 08:04:37 +0100
Received: from pudding ([202.216.29.50])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id gA874Qq02298;
	Fri, 8 Nov 2002 16:04:27 +0900 (JST)
Date: Fri, 8 Nov 2002 16:01:09 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: [PATCH 2.5] PCI config read/write fixed for vr41xx
Message-Id: <20021108160109.38bbb072.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__8_Nov_2002_16:01:09_+0900_08359028"
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Fri__8_Nov_2002_16:01:09_+0900_08359028
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ralf,

I have fixed new PCI config read/write of vr41xx.
Please apply this patch.

Thanks,

Yoichi
--Multipart_Fri__8_Nov_2002_16:01:09_+0900_08359028
Content-Type: text/plain;
 name="vr41xx-021108.diff"
Content-Disposition: attachment;
 filename="vr41xx-021108.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/vr41xx/common/pciu.c linux/arch/mips/vr41xx/common/pciu.c
--- linux.orig/arch/mips/vr41xx/common/pciu.c	Mon Jul 15 08:47:57 2002
+++ linux/arch/mips/vr41xx/common/pciu.c	Fri Nov  8 14:39:56 2002
@@ -53,32 +53,28 @@
 
 extern unsigned long vr41xx_vtclock;
 
-static inline int vr41xx_pci_config_access(struct pci_dev *dev, int where)
+static inline int vr41xx_pci_config_access(unsigned char bus,  unsigned int devfn, int where)
 {
-	unsigned char bus = dev->bus->number;
-	unsigned int dev_fn = dev->devfn;
-
 	if (bus == 0) {
 		/*
 		 * Type 0 configuration
 		 */
-		if (PCI_SLOT(dev_fn) < 11 || PCI_SLOT(dev_fn) > 31 || where > 255)
+		if (PCI_SLOT(devfn) < 11 || where > 255)
 			return -1;
 
-		writel((1UL << PCI_SLOT(dev_fn))|
-		       (PCI_FUNC(dev_fn) << 8)	|
+		writel((1UL << PCI_SLOT(devfn))	|
+		       (PCI_FUNC(devfn) << 8)	|
 		       (where & 0xfc),
 		       PCICONFAREG);
-	}
-	else {
+	} else {
 		/*
 		 * Type 1 configuration
 		 */
-		if (bus > 255 || PCI_SLOT(dev_fn) > 31 || where > 255)
+		if (where > 255)
 			return -1;
 
 		writel((bus << 16)	|
-		       (dev_fn << 8)	|
+		       (devfn << 8)	|
 		       (where & 0xfc)	|
 		       1UL,
 		       PCICONFAREG);
@@ -87,110 +83,69 @@
 	return 0;
 }
 
-static int vr41xx_pci_read_config_byte(struct pci_dev *dev, int where, u8 *val)
-{
-	u32 data;
-
-	*val = 0xff;
-	if (vr41xx_pci_config_access(dev, where) < 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	data = readl(PCICONFDREG);
-	*val = (u8)(data >> ((where & 3) << 3));
-
-	return PCIBIOS_SUCCESSFUL;
-
-}
-
-static int vr41xx_pci_read_config_word(struct pci_dev *dev, int where, u16 *val)
+static int vr41xx_pci_config_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
 {
 	u32 data;
 
-	*val = 0xffff;
-	if (where & 1)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (vr41xx_pci_config_access(dev, where) < 0)
+	*val = 0xffffffffUL;
+	if (vr41xx_pci_config_access(bus->number, devfn, where) < 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	data = readl(PCICONFDREG);
-	*val = (u16)(data >> ((where & 2) << 3));
-
-	return PCIBIOS_SUCCESSFUL;
-}
 
-static int vr41xx_pci_read_config_dword(struct pci_dev *dev, int where, u32 *val)
-{
-	*val = 0xffffffff;
-	if (where & 3)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (vr41xx_pci_config_access(dev, where) < 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	*val = readl(PCICONFDREG);
+	switch (size) {
+	case 1:
+		*val = (data >> ((where & 3) << 3)) & 0xffUL;
+		break;
+	case 2:
+		*val = (data >> ((where & 2) << 3)) & 0xffffUL;
+		break;
+	case 4:
+		*val = data;
+		break;
+	default:
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int vr41xx_pci_write_config_byte(struct pci_dev *dev, int where, u8 val)
+static int vr41xx_pci_config_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
 {
 	u32 data;
 	int shift;
 
-	if (vr41xx_pci_config_access(dev, where) < 0)
+	if (vr41xx_pci_config_access(bus->number, devfn, where) < 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	data = readl(PCICONFDREG);
-	shift = (where & 3) << 3;
-	data &= ~(0xff << shift);
-	data |= (((u32)val) << shift);
 
-	writel(data, PCICONFDREG);
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int vr41xx_pci_write_config_word(struct pci_dev *dev, int where, u16 val)
-{
-	u32 data;
-	int shift;
-
-	if (where & 1)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (vr41xx_pci_config_access(dev, where) < 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	switch (size) {
+	case 1:
+		shift = (where & 3) << 3;
+		data &= ~(0xff << shift);
+		data |= ((val & 0xff) << shift);
+		break;
+	case 2:
+		shift = (where & 2) << 3;
+		data &= ~(0xffff << shift);
+		data |= ((val & 0xffff) << shift);
+		break;
+	case 4:
+		data = val;
+		break;
+	default:
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
 
-	data = readl(PCICONFDREG);
-	shift = (where & 2) << 3;
-	data &= ~(0xffff << shift);
-	data |= (((u32)val) << shift);
 	writel(data, PCICONFDREG);
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int vr41xx_pci_write_config_dword(struct pci_dev *dev, int where, u32 val)
-{
-	if (where & 3)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (vr41xx_pci_config_access(dev, where) < 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	writel(val, PCICONFDREG);
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
 struct pci_ops vr41xx_pci_ops = {
-	vr41xx_pci_read_config_byte,
-	vr41xx_pci_read_config_word,
-	vr41xx_pci_read_config_dword,
-	vr41xx_pci_write_config_byte,
-	vr41xx_pci_write_config_word,
-	vr41xx_pci_write_config_dword
+	.read	= vr41xx_pci_config_read,
+	.write	= vr41xx_pci_config_write,
 };
 
 void __init vr41xx_pciu_init(struct vr41xx_pci_address_map *map)

--Multipart_Fri__8_Nov_2002_16:01:09_+0900_08359028--
