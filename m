Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 11:56:21 +0200 (CEST)
Received: from mail-qy0-f192.google.com ([209.85.221.192]:62054 "EHLO
        mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492254Ab0EDJzI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 11:55:08 +0200
Received: by mail-qy0-f192.google.com with SMTP id 30so5119599qyk.16
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 02:55:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.224.96.81 with SMTP id g17mr5037669qan.108.1272966907629; Tue, 
        04 May 2010 02:55:07 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Tue, 4 May 2010 02:55:07 -0700 (PDT)
Date:   Tue, 4 May 2010 17:55:07 +0800
Message-ID: <x2k180e2c241005040255j30f8a373g9240bd4fd5697216@mail.gmail.com>
Subject: [PATCH 3/12] add pci fixup for gdium
From:   yajin <yajinzhou@vm-kernel.org>
To:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com, apatard@mandriva.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <yajinzhou@vm-kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yajinzhou@vm-kernel.org
Precedence: bulk
X-list: linux-mips

Add the PCI fixup for gdium.

Signed-off-by: yajin <yajin@vm-kernel.org>
---
 arch/mips/pci/Makefile      |    1 +
 arch/mips/pci/fixup-gdium.c |   60 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/pci/fixup-gdium.c

diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index c9209ca..95be72f 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_SOC_AU1550)	+= fixup-au1000.o ops-au1000.o
 obj-$(CONFIG_SOC_PNX8550)	+= fixup-pnx8550.o ops-pnx8550.o
 obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-loongson2.o
 obj-$(CONFIG_LEMOTE_MACH2F)	+= fixup-lemote2f.o ops-loongson2.o
+obj-$(CONFIG_DEXXON_GDIUM)     += fixup-gdium.o ops-loongson2.o
 obj-$(CONFIG_MIPS_MALTA)	+= fixup-malta.o
 obj-$(CONFIG_PMC_MSP7120_GW)	+= fixup-pmcmsp.o ops-pmcmsp.o
 obj-$(CONFIG_PMC_MSP7120_EVAL)	+= fixup-pmcmsp.o ops-pmcmsp.o
diff --git a/arch/mips/pci/fixup-gdium.c b/arch/mips/pci/fixup-gdium.c
new file mode 100644
index 0000000..f692ada
--- /dev/null
+++ b/arch/mips/pci/fixup-gdium.c
@@ -0,0 +1,60 @@
+/*
+ * Copyright (C) 2010 yajin <yajin@vm-kernel.org>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/pci.h>
+
+/*
+ * http://www.pcidatabase.com
+ * GDIUM has different PCI mapping
+ *  slot 13 (0x1814/0x0301) -> RaLink rt2561 Wireless-G PCI
+ *  slog 14 (0x126f/0x0501) -> sm501
+ *  slot 15 (0x1033/0x0035) -> NEC Dual OHCI controllers
+ *                             plus Single EHCI controller
+ *  slot 16 (0x10ec/0x8139) -> Realtek 8139c
+ *  slot 17 (0x1033/0x00e0) -> NEC USB 2.0 Host Controller
+ *
+ */
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	switch (slot) {
+	case 13:
+		return LOONGSON_IRQ_BASE + ((pin - 1) & 3);
+	case 14:
+		return LOONGSON_IRQ_BASE + 4; /*36*/
+	case 15:
+		return LOONGSON_IRQ_BASE + 5; /*37*/
+	case 16:
+		return LOONGSON_IRQ_BASE + 7; /*39*/
+	case 17:
+		return LOONGSON_IRQ_BASE + 6; /*38*/
+	default:
+		printk(KERN_INFO " strange pci slot number %d "
+				"on gdium.\n", slot);
+		return 0;
+	}
+}
+
+/* Fixups for the NEC USB host controllers */
+static void __init gdium_usb_host_fixup(struct pci_dev *dev)
+{
+	unsigned int val;
+	pci_read_config_dword(dev, 0xe0, &val);
+	pci_write_config_dword(dev, 0xe0, (val & ~3) | 0x3);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
+				gdium_usb_host_fixup);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, 0x00e0,
+				gdium_usb_host_fixup);
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
-- 
1.5.6.5
