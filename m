Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 17:07:52 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:61196 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493238AbZKIQGs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 17:06:48 +0100
Received: by mail-ew0-f216.google.com with SMTP id 12so3402282ewy.0
        for <multiple recipients>; Mon, 09 Nov 2009 08:06:48 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=ci/hg6oN+jaDeKzC0j6I+8D0+on4ENCY3J7ys48zEgk=;
        b=oLWWCNpJses1ZDrw8l3P5gtZxTkGfVTNpj/qLP2Ndjz0Me5noZ36IOBD0i/0hMJ126
         niiBCCju3+OkWx5uuROO+n2xXDk8Kad+tXJYbM9540n13YRc1ihC+FXWBRItSOWk6g43
         8i0vnMgc0QIOfBj9JJIDZm9ZTPxs5WaLcllC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fXdZwRNRLZ0AB8ly+ZKvQ241fF3/+IGIcUrF0I4e85jrHYdlp4RLC6s2b4BJI4AIHC
         ah8oEDtgbXNbQoSX+DuVBIPPvCZ4BYuruTUi6OhlqPbKsKal65PobcsFSUMf5oTIUmkm
         ec+hAVFAZmYXWNwOkvQPMC0f3WorNl/mYdcVI=
Received: by 10.216.85.194 with SMTP id u44mr2511505wee.65.1257782807251;
        Mon, 09 Nov 2009 08:06:47 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id p37sm9150866gvf.24.2009.11.09.08.06.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 08:06:46 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, Wu Zhangjin <wuzhangjin@gmail.com>,
	linux-mips@linux-mips.org
Subject: [PATCH v2 4/7] [loongson] lemote-2f: add pci support
Date:	Tue, 10 Nov 2009 00:06:13 +0800
Message-Id: <791c33dbd40b62f7341a545390db70731b85ce22.1257781987.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <969a9b991c745c3ff7ee1c47ac240499af629f27.1257781987.git.wuzhangjin@gmail.com>
References: <3154ef478a3a08f808e3a4b9c9cab9f4e263a8a2.1257781987.git.wuzhangjin@gmail.com>
 <4c3b69663760b00d39e09c3682a55ee7cf4b84c7.1257781987.git.wuzhangjin@gmail.com>
 <969a9b991c745c3ff7ee1c47ac240499af629f27.1257781987.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257781987.git.wuzhangjin@gmail.com>
References: <cover.1257781987.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Most of the pci support between fuloong2e and lemote loongson2f family
machines are the same, except the cs5536 support.

This patch renames ops-fuloong2e.c to ops-loongson2.c and then append
the cs5536 support to share most of the source code among loongson
machines.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/pci/Makefile         |    3 +-
 arch/mips/pci/fixup-lemote2f.c |  162 +++++++++++++++++++++++++++++++
 arch/mips/pci/ops-fuloong2e.c  |  154 -----------------------------
 arch/mips/pci/ops-loongson2.c  |  208 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 372 insertions(+), 155 deletions(-)
 create mode 100644 arch/mips/pci/fixup-lemote2f.c
 delete mode 100644 arch/mips/pci/ops-fuloong2e.c
 create mode 100644 arch/mips/pci/ops-loongson2.c

diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 0610c86..c9a0dc1 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -28,7 +28,8 @@ obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
 obj-$(CONFIG_SOC_AU1500)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_AU1550)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_PNX8550)	+= fixup-pnx8550.o ops-pnx8550.o
-obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-fuloong2e.o
+obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-loongson2.o
+obj-$(CONFIG_LEMOTE_MACH2F)	+= fixup-lemote2f.o ops-loongson2.o
 obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/fixup-lemote2f.c b/arch/mips/pci/fixup-lemote2f.c
new file mode 100644
index 0000000..e7c2b4d
--- /dev/null
+++ b/arch/mips/pci/fixup-lemote2f.c
@@ -0,0 +1,162 @@
+/*
+ * Copyright (C) 2008 Lemote Technology
+ * Copyright (C) 2004 ICT CAS
+ * Author: Li xiaoyu, lixy@ict.ac.cn
+ *
+ * Copyright (C) 2007 Lemote, Inc.
+ * Author: Fuxin Zhang, zhangfx@lemote.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <loongson.h>
+#include <cs5536/cs5536.h>
+#include <cs5536/cs5536_pci.h>
+
+/* PCI interrupt pins
+ *
+ * These should not be changed, or you should consider loongson2f interrupt
+ * register and your pci card dispatch
+ */
+
+#define PCIA		4
+#define PCIB		5
+#define PCIC		6
+#define PCID		7
+
+/* all the pci device has the PCIA pin, check the datasheet. */
+static char irq_tab[][5] __initdata = {
+	/*      INTA    INTB    INTC    INTD */
+	{0, 0, 0, 0, 0},	/*  11: Unused */
+	{0, 0, 0, 0, 0},	/*  12: Unused */
+	{0, 0, 0, 0, 0},	/*  13: Unused */
+	{0, 0, 0, 0, 0},	/*  14: Unused */
+	{0, 0, 0, 0, 0},	/*  15: Unused */
+	{0, 0, 0, 0, 0},	/*  16: Unused */
+	{0, PCIA, 0, 0, 0},	/*  17: RTL8110-0 */
+	{0, PCIB, 0, 0, 0},	/*  18: RTL8110-1 */
+	{0, PCIC, 0, 0, 0},	/*  19: SiI3114 */
+	{0, PCID, 0, 0, 0},	/*  20: 3-ports nec usb */
+	{0, PCIA, PCIB, PCIC, PCID},	/*  21: PCI-SLOT */
+	{0, 0, 0, 0, 0},	/*  22: Unused */
+	{0, 0, 0, 0, 0},	/*  23: Unused */
+	{0, 0, 0, 0, 0},	/*  24: Unused */
+	{0, 0, 0, 0, 0},	/*  25: Unused */
+	{0, 0, 0, 0, 0},	/*  26: Unused */
+	{0, 0, 0, 0, 0},	/*  27: Unused */
+};
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int virq;
+
+	if ((PCI_SLOT(dev->devfn) != PCI_IDSEL_CS5536)
+	    && (PCI_SLOT(dev->devfn) < 32)) {
+		virq = irq_tab[slot][pin];
+		printk(KERN_INFO "slot: %d, pin: %d, irq: %d\n", slot, pin,
+		       virq + LOONGSON_IRQ_BASE);
+		if (virq != 0)
+			return LOONGSON_IRQ_BASE + virq;
+		else
+			return 0;
+	} else if (PCI_SLOT(dev->devfn) == PCI_IDSEL_CS5536) {	/*  cs5536 */
+		switch (PCI_FUNC(dev->devfn)) {
+		case 2:
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
+					      CS5536_IDE_INTR);
+			return CS5536_IDE_INTR;	/*  for IDE */
+		case 3:
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
+					      CS5536_ACC_INTR);
+			return CS5536_ACC_INTR;	/*  for AUDIO */
+		case 4:	/*  for OHCI */
+		case 5:	/*  for EHCI */
+		case 6:	/*  for UDC */
+		case 7:	/*  for OTG */
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
+					      CS5536_USB_INTR);
+			return CS5536_USB_INTR;
+		}
+		return dev->irq;
+	} else {
+		printk(KERN_INFO " strange pci slot number.\n");
+		return 0;
+	}
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+/* CS5536 SPEC. fixup */
+static void __init loongson_cs5536_isa_fixup(struct pci_dev *pdev)
+{
+	/* the uart1 and uart2 interrupt in PIC is enabled as default */
+	pci_write_config_dword(pdev, PCI_UART1_INT_REG, 1);
+	pci_write_config_dword(pdev, PCI_UART2_INT_REG, 1);
+}
+
+static void __init loongson_cs5536_ide_fixup(struct pci_dev *pdev)
+{
+	/* setting the mutex pin as IDE function */
+	pci_write_config_dword(pdev, PCI_IDE_CFG_REG,
+			       CS5536_IDE_FLASH_SIGNATURE);
+}
+
+static void __init loongson_cs5536_acc_fixup(struct pci_dev *pdev)
+{
+	u8 val;
+
+	/* enable the AUDIO interrupt in PIC  */
+	pci_write_config_dword(pdev, PCI_ACC_INT_REG, 1);
+
+	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xc0);
+}
+
+static void __init loongson_cs5536_ohci_fixup(struct pci_dev *pdev)
+{
+	/* enable the OHCI interrupt in PIC */
+	/* THE OHCI, EHCI, UDC, OTG are shared with interrupt in PIC */
+	pci_write_config_dword(pdev, PCI_OHCI_INT_REG, 1);
+}
+
+static void __init loongson_cs5536_ehci_fixup(struct pci_dev *pdev)
+{
+	u32 hi, lo;
+
+	/* Serial short detect enable */
+	_rdmsr(USB_MSR_REG(USB_CONFIG), &hi, &lo);
+	_wrmsr(USB_MSR_REG(USB_CONFIG), (1 << 1) | (1 << 2) | (1 << 3), lo);
+
+	/* setting the USB2.0 micro frame length */
+	pci_write_config_dword(pdev, PCI_EHCI_FLADJ_REG, 0x2000);
+}
+
+static void __init loongson_nec_fixup(struct pci_dev *pdev)
+{
+	unsigned int val;
+
+	pci_read_config_dword(pdev, 0xe0, &val);
+	/* Only 2 port be used */
+	pci_write_config_dword(pdev, 0xe0, (val & ~3) | 0x2);
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA,
+			 loongson_cs5536_isa_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_OHC,
+			 loongson_cs5536_ohci_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_EHC,
+			 loongson_cs5536_ehci_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO,
+			 loongson_cs5536_acc_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_IDE,
+			 loongson_cs5536_ide_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
+			 loongson_nec_fixup);
diff --git a/arch/mips/pci/ops-fuloong2e.c b/arch/mips/pci/ops-fuloong2e.c
deleted file mode 100644
index 171f65c..0000000
--- a/arch/mips/pci/ops-fuloong2e.c
+++ /dev/null
@@ -1,154 +0,0 @@
-/*
- * fuloong2e specific PCI support.
- *
- * Copyright (C) 1999, 2000, 2004  MIPS Technologies, Inc.
- *	All rights reserved.
- *	Authors: Carsten Langgaard <carstenl@mips.com>
- *		 Maciej W. Rozycki <macro@mips.com>
- *
- * Copyright (C) 2009 Lemote Inc.
- * Author: Wu Zhangjin <wuzj@lemote.com>
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- */
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-
-#include <loongson.h>
-
-#define PCI_ACCESS_READ  0
-#define PCI_ACCESS_WRITE 1
-
-#define CFG_SPACE_REG(offset) \
-	(void *)CKSEG1ADDR(LOONGSON_PCICFG_BASE | (offset))
-#define ID_SEL_BEGIN 11
-#define MAX_DEV_NUM (31 - ID_SEL_BEGIN)
-
-
-static int loongson_pcibios_config_access(unsigned char access_type,
-				      struct pci_bus *bus,
-				      unsigned int devfn, int where,
-				      u32 *data)
-{
-	u32 busnum = bus->number;
-	u32 addr, type;
-	u32 dummy;
-	void *addrp;
-	int device = PCI_SLOT(devfn);
-	int function = PCI_FUNC(devfn);
-	int reg = where & ~3;
-
-	if (busnum == 0) {
-		/* Type 0 configuration for onboard PCI bus */
-		if (device > MAX_DEV_NUM)
-			return -1;
-
-		addr = (1 << (device + ID_SEL_BEGIN)) | (function << 8) | reg;
-		type = 0;
-	} else {
-		/* Type 1 configuration for offboard PCI bus */
-		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
-		type = 0x10000;
-	}
-
-	/* Clear aborts */
-	LOONGSON_PCICMD |= LOONGSON_PCICMD_MABORT_CLR | \
-				LOONGSON_PCICMD_MTABORT_CLR;
-
-	LOONGSON_PCIMAP_CFG = (addr >> 16) | type;
-
-	/* Flush Bonito register block */
-	dummy = LOONGSON_PCIMAP_CFG;
-	mmiowb();
-
-	addrp = CFG_SPACE_REG(addr & 0xffff);
-	if (access_type == PCI_ACCESS_WRITE)
-		writel(cpu_to_le32(*data), addrp);
-	else
-		*data = le32_to_cpu(readl(addrp));
-
-	/* Detect Master/Target abort */
-	if (LOONGSON_PCICMD & (LOONGSON_PCICMD_MABORT_CLR |
-			     LOONGSON_PCICMD_MTABORT_CLR)) {
-		/* Error occurred */
-
-		/* Clear bits */
-		LOONGSON_PCICMD |= (LOONGSON_PCICMD_MABORT_CLR |
-				  LOONGSON_PCICMD_MTABORT_CLR);
-
-		return -1;
-	}
-
-	return 0;
-
-}
-
-
-/*
- * We can't address 8 and 16 bit words directly.  Instead we have to
- * read/write a 32bit word and mask/modify the data we actually want.
- */
-static int loongson_pcibios_read(struct pci_bus *bus, unsigned int devfn,
-			     int where, int size, u32 *val)
-{
-	u32 data = 0;
-
-	if ((size == 2) && (where & 1))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	else if ((size == 4) && (where & 3))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (loongson_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where,
-				       &data))
-		return -1;
-
-	if (size == 1)
-		*val = (data >> ((where & 3) << 3)) & 0xff;
-	else if (size == 2)
-		*val = (data >> ((where & 3) << 3)) & 0xffff;
-	else
-		*val = data;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int loongson_pcibios_write(struct pci_bus *bus, unsigned int devfn,
-			      int where, int size, u32 val)
-{
-	u32 data = 0;
-
-	if ((size == 2) && (where & 1))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	else if ((size == 4) && (where & 3))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (size == 4)
-		data = val;
-	else {
-		if (loongson_pcibios_config_access(PCI_ACCESS_READ, bus, devfn,
-					where, &data))
-			return -1;
-
-		if (size == 1)
-			data = (data & ~(0xff << ((where & 3) << 3))) |
-				(val << ((where & 3) << 3));
-		else if (size == 2)
-			data = (data & ~(0xffff << ((where & 3) << 3))) |
-				(val << ((where & 3) << 3));
-	}
-
-	if (loongson_pcibios_config_access(PCI_ACCESS_WRITE, bus, devfn, where,
-				       &data))
-		return -1;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-struct pci_ops loongson_pci_ops = {
-	.read = loongson_pcibios_read,
-	.write = loongson_pcibios_write
-};
diff --git a/arch/mips/pci/ops-loongson2.c b/arch/mips/pci/ops-loongson2.c
new file mode 100644
index 0000000..aa5d3da
--- /dev/null
+++ b/arch/mips/pci/ops-loongson2.c
@@ -0,0 +1,208 @@
+/*
+ * fuloong2e specific PCI support.
+ *
+ * Copyright (C) 1999, 2000, 2004  MIPS Technologies, Inc.
+ *	All rights reserved.
+ *	Authors: Carsten Langgaard <carstenl@mips.com>
+ *		 Maciej W. Rozycki <macro@mips.com>
+ *
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin <wuzj@lemote.com>
+ *
+ *  This program is free software; you can distribute it and/or modify it
+ *  under the terms of the GNU General Public License (Version 2) as
+ *  published by the Free Software Foundation.
+ */
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <loongson.h>
+
+#ifdef CONFIG_CS5536
+#include <cs5536/cs5536_pci.h>
+#include <cs5536/cs5536.h>
+#endif
+
+#define PCI_ACCESS_READ  0
+#define PCI_ACCESS_WRITE 1
+
+#define CFG_SPACE_REG(offset) \
+	(void *)CKSEG1ADDR(LOONGSON_PCICFG_BASE | (offset))
+#define ID_SEL_BEGIN 11
+#define MAX_DEV_NUM (31 - ID_SEL_BEGIN)
+
+
+static int loongson_pcibios_config_access(unsigned char access_type,
+				      struct pci_bus *bus,
+				      unsigned int devfn, int where,
+				      u32 *data)
+{
+	u32 busnum = bus->number;
+	u32 addr, type;
+	u32 dummy;
+	void *addrp;
+	int device = PCI_SLOT(devfn);
+	int function = PCI_FUNC(devfn);
+	int reg = where & ~3;
+
+	if (busnum == 0) {
+		/* board-specific part,currently,only fuloong2f,yeeloong2f
+		 * use CS5536, fuloong2e use via686b, gdium has no
+		 * south bridge
+		 */
+#ifdef CONFIG_CS5536
+		/* cs5536_pci_conf_read4/write4() will call _rdmsr/_wrmsr() to
+		 * access the regsters PCI_MSR_ADDR, PCI_MSR_DATA_LO,
+		 * PCI_MSR_DATA_HI, which is bigger than PCI_MSR_CTRL, so, it
+		 * will not go this branch, but the others. so, no calling dead
+		 * loop here.
+		 */
+		if ((PCI_IDSEL_CS5536 == device) && (reg < PCI_MSR_CTRL)) {
+			switch (access_type) {
+			case PCI_ACCESS_READ:
+				*data = cs5536_pci_conf_read4(function, reg);
+				break;
+			case PCI_ACCESS_WRITE:
+				cs5536_pci_conf_write4(function, reg, *data);
+				break;
+			}
+			return 0;
+		}
+#endif
+		/* Type 0 configuration for onboard PCI bus */
+		if (device > MAX_DEV_NUM)
+			return -1;
+
+		addr = (1 << (device + ID_SEL_BEGIN)) | (function << 8) | reg;
+		type = 0;
+	} else {
+		/* Type 1 configuration for offboard PCI bus */
+		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
+		type = 0x10000;
+	}
+
+	/* Clear aborts */
+	LOONGSON_PCICMD |= LOONGSON_PCICMD_MABORT_CLR | \
+				LOONGSON_PCICMD_MTABORT_CLR;
+
+	LOONGSON_PCIMAP_CFG = (addr >> 16) | type;
+
+	/* Flush Bonito register block */
+	dummy = LOONGSON_PCIMAP_CFG;
+	mmiowb();
+
+	addrp = CFG_SPACE_REG(addr & 0xffff);
+	if (access_type == PCI_ACCESS_WRITE)
+		writel(cpu_to_le32(*data), addrp);
+	else
+		*data = le32_to_cpu(readl(addrp));
+
+	/* Detect Master/Target abort */
+	if (LOONGSON_PCICMD & (LOONGSON_PCICMD_MABORT_CLR |
+			     LOONGSON_PCICMD_MTABORT_CLR)) {
+		/* Error occurred */
+
+		/* Clear bits */
+		LOONGSON_PCICMD |= (LOONGSON_PCICMD_MABORT_CLR |
+				  LOONGSON_PCICMD_MTABORT_CLR);
+
+		return -1;
+	}
+
+	return 0;
+
+}
+
+
+/*
+ * We can't address 8 and 16 bit words directly.  Instead we have to
+ * read/write a 32bit word and mask/modify the data we actually want.
+ */
+static int loongson_pcibios_read(struct pci_bus *bus, unsigned int devfn,
+			     int where, int size, u32 *val)
+{
+	u32 data = 0;
+
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (loongson_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where,
+				       &data))
+		return -1;
+
+	if (size == 1)
+		*val = (data >> ((where & 3) << 3)) & 0xff;
+	else if (size == 2)
+		*val = (data >> ((where & 3) << 3)) & 0xffff;
+	else
+		*val = data;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int loongson_pcibios_write(struct pci_bus *bus, unsigned int devfn,
+			      int where, int size, u32 val)
+{
+	u32 data = 0;
+
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (size == 4)
+		data = val;
+	else {
+		if (loongson_pcibios_config_access(PCI_ACCESS_READ, bus, devfn,
+					where, &data))
+			return -1;
+
+		if (size == 1)
+			data = (data & ~(0xff << ((where & 3) << 3))) |
+				(val << ((where & 3) << 3));
+		else if (size == 2)
+			data = (data & ~(0xffff << ((where & 3) << 3))) |
+				(val << ((where & 3) << 3));
+	}
+
+	if (loongson_pcibios_config_access(PCI_ACCESS_WRITE, bus, devfn, where,
+				       &data))
+		return -1;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+struct pci_ops loongson_pci_ops = {
+	.read = loongson_pcibios_read,
+	.write = loongson_pcibios_write
+};
+
+#ifdef CONFIG_CS5536
+void _rdmsr(u32 msr, u32 *hi, u32 *lo)
+{
+	struct pci_bus bus = {
+		.number = PCI_BUS_CS5536
+	};
+	u32 devfn = PCI_DEVFN(PCI_IDSEL_CS5536, 0);
+	loongson_pcibios_write(&bus, devfn, PCI_MSR_ADDR, 4, msr);
+	loongson_pcibios_read(&bus, devfn, PCI_MSR_DATA_LO, 4, lo);
+	loongson_pcibios_read(&bus, devfn, PCI_MSR_DATA_HI, 4, hi);
+}
+EXPORT_SYMBOL(_rdmsr);
+
+void _wrmsr(u32 msr, u32 hi, u32 lo)
+{
+	struct pci_bus bus = {
+		.number = PCI_BUS_CS5536
+	};
+	u32 devfn = PCI_DEVFN(PCI_IDSEL_CS5536, 0);
+	loongson_pcibios_write(&bus, devfn, PCI_MSR_ADDR, 4, msr);
+	loongson_pcibios_write(&bus, devfn, PCI_MSR_DATA_LO, 4, lo);
+	loongson_pcibios_write(&bus, devfn, PCI_MSR_DATA_HI, 4, hi);
+}
+EXPORT_SYMBOL(_wrmsr);
+#endif
-- 
1.6.2.1
