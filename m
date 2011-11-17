Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 15:03:49 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:47513 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904038Ab1KQODZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 15:03:25 +0100
Received: by bkat2 with SMTP id t2so2580123bka.36
        for <multiple recipients>; Thu, 17 Nov 2011 06:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4aAzBc5so4jDfWm6sQ30g847pKQWajrf4Y4aC+wNEcI=;
        b=elbR0L1yrAQ0s3st1Wg90DutKNXWPT1ug0lB/EJaxlRF0qHXHHqkeZaMkl842o5MYG
         cF59HLjuXE0naDXh4onxHkH2qQIWQhSVipjqpystK86nQVGE6phDnCkSeBrAjfNsWLEB
         BRORfPgSgiZGe8I/Bc6bcFyvAriDbaYka+QfE=
Received: by 10.205.120.2 with SMTP id fw2mr25392422bkc.10.1321538599676;
        Thu, 17 Nov 2011 06:03:19 -0800 (PST)
Received: from localhost.localdomain (dslb-178-003-254-091.pools.arcor-ip.net. [178.3.254.91])
        by mx.google.com with ESMTPS id x14sm41318988bkf.10.2011.11.17.06.03.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 06:03:18 -0800 (PST)
From:   Rene Bolldorf <xsecute@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Rene Bolldorf <xsecute@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=201/2=5D=20Initial=20PCI=20support=20for=20Atheros=20724x=20SoCs=2E=20=28v2=29?=
Date:   Thu, 17 Nov 2011 15:02:56 +0100
Message-Id: <1321538577-548-2-git-send-email-xsecute@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1321538577-548-1-git-send-email-xsecute@googlemail.com>
References: <CAEWqx59k97AMU6hH0NCC2TMEY2mu8d5ytxO68oEsa=7uvLBA4A@mail.gmail.com>
 <1321538577-548-1-git-send-email-xsecute@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14477

Signed-off-by: Rene Bolldorf <xsecute@googlemail.com>
---
 arch/mips/include/asm/mach-ath79/pci-ath724x.h |   21 +++
 arch/mips/pci/Makefile                         |    1 +
 arch/mips/pci/pci-ath724x.c                    |  174 ++++++++++++++++++++++++
 3 files changed, 196 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-ath79/pci-ath724x.h
 create mode 100644 arch/mips/pci/pci-ath724x.c

diff --git a/arch/mips/include/asm/mach-ath79/pci-ath724x.h b/arch/mips/include/asm/mach-ath79/pci-ath724x.h
new file mode 100644
index 0000000..454885f
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/pci-ath724x.h
@@ -0,0 +1,21 @@
+/*
+ *  Atheros 724x PCI support
+ *
+ *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef __ASM_MACH_ATH79_PCI_ATH724X_H
+#define __ASM_MACH_ATH79_PCI_ATH724X_H
+
+struct ath724x_pci_data {
+	int irq;
+	void *pdata;
+};
+
+void ath724x_pci_add_data(struct ath724x_pci_data *data, int size);
+
+#endif /* __ASM_MACH_ATH79_PCI_ATH724X_H */
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index bb82cbd..19cfe04 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
 obj-$(CONFIG_BCM63XX)		+= pci-bcm63xx.o fixup-bcm63xx.o \
 					ops-bcm63xx.o
 obj-$(CONFIG_MIPS_ALCHEMY)	+= pci-alchemy.o
+obj-$(CONFIG_SOC_AR724X)	+= pci-ath724x.o
 
 #
 # These are still pretty much in the old state, watch, go blind.
diff --git a/arch/mips/pci/pci-ath724x.c b/arch/mips/pci/pci-ath724x.c
new file mode 100644
index 0000000..9f30e5d
--- /dev/null
+++ b/arch/mips/pci/pci-ath724x.c
@@ -0,0 +1,174 @@
+/*
+ *  Atheros 724x PCI support
+ *
+ *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/pci.h>
+#include <asm/mach-ath79/pci-ath724x.h>
+
+#define reg_read(_phys)		(*(unsigned int *) KSEG1ADDR(_phys))
+#define reg_write(_phys, _val)	((*(unsigned int *) KSEG1ADDR(_phys)) = (_val))
+
+#define ATH724X_PCI_DEV_BASE	0x14000000
+#define ATH724X_PCI_MEM_BASE	0x10000000
+#define ATH724X_PCI_MEM_SIZE	0x08000000
+
+static DEFINE_SPINLOCK(ath724x_pci_lock);
+static struct ath724x_pci_data *pci_data;
+static int pci_data_size;
+
+static int ath724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
+			    int size, uint32_t *value)
+{
+	unsigned long flags, addr, tval, mask;
+
+	if (devfn)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (where & (size - 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	spin_lock_irqsave(&ath724x_pci_lock, flags);
+
+	switch (size) {
+	case 1:
+		addr = where & ~3;
+		mask = 0xff000000 >> ((where % 4) * 8);
+		tval = reg_read(ATH724X_PCI_DEV_BASE + addr);
+		tval = tval & ~mask;
+		*value = (tval >> ((4 - (where % 4))*8));
+	break;
+	case 2:
+		addr = where & ~3;
+		mask = 0xffff0000 >> ((where % 4)*8);
+		tval = reg_read(ATH724X_PCI_DEV_BASE + addr);
+		tval = tval & ~mask;
+		*value = (tval >> ((4 - (where % 4))*8));
+	break;
+	case 4:
+		*value = reg_read(ATH724X_PCI_DEV_BASE + where);
+	break;
+	default:
+		spin_unlock_irqrestore(&ath724x_pci_lock, flags);
+
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	spin_unlock_irqrestore(&ath724x_pci_lock, flags);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int ath724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
+			     int size, uint32_t value)
+{
+	unsigned long flags, tval, addr, mask;
+
+	if (devfn)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (where & (size - 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	spin_lock_irqsave(&ath724x_pci_lock, flags);
+
+	switch (size) {
+	case 1:
+		addr = (ATH724X_PCI_DEV_BASE + where) & ~3;
+		mask = 0xff000000 >> ((where % 4)*8);
+		tval = reg_read(addr);
+		tval = tval & ~mask;
+		tval |= (value << ((4 - (where % 4))*8)) & mask;
+		reg_write(addr, tval);
+	break;
+	case 2:
+		addr = (ATH724X_PCI_DEV_BASE + where) & ~3;
+		mask = 0xffff0000 >> ((where % 4)*8);
+		tval = reg_read(addr);
+		tval = tval & ~mask;
+		tval |= (value << ((4 - (where % 4))*8)) & mask;
+		reg_write(addr, tval);
+	break;
+	case 4:
+		reg_write((ATH724X_PCI_DEV_BASE + where), value);
+	break;
+	default:
+		spin_unlock_irqrestore(&ath724x_pci_lock, flags);
+
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	spin_unlock_irqrestore(&ath724x_pci_lock, flags);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops ath724x_pci_ops = {
+	.read	= ath724x_pci_read,
+	.write	= ath724x_pci_write,
+};
+
+static struct resource ath724x_io_resource = {
+	.name   = "PCI IO space",
+	.start  = 0,
+	.end    = 0,
+	.flags  = IORESOURCE_IO,
+};
+
+static struct resource ath724x_mem_resource = {
+	.name   = "PCI memory space",
+	.start  = ATH724X_PCI_MEM_BASE,
+	.end    = ATH724X_PCI_MEM_BASE + ATH724X_PCI_MEM_SIZE - 1,
+	.flags  = IORESOURCE_MEM,
+};
+
+static struct pci_controller ath724x_pci_controller = {
+	.pci_ops        = &ath724x_pci_ops,
+	.io_resource    = &ath724x_io_resource,
+	.mem_resource	= &ath724x_mem_resource,
+};
+
+void ath724x_pci_add_data(struct ath724x_pci_data *data, int size)
+{
+	pci_data	= data;
+	pci_data_size	= size;
+}
+
+int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
+{
+	unsigned int devfn = dev->devfn;
+	int irq = -1;
+
+	if (devfn > pci_data_size - 1)
+		return irq;
+
+	irq = pci_data[devfn].irq;
+
+	return irq;
+}
+
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	unsigned int devfn = dev->devfn;
+
+	if (devfn > pci_data_size - 1)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	dev->dev.platform_data = pci_data[devfn].pdata;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int __init ath724x_pcibios_init(void)
+{
+	register_pci_controller(&ath724x_pci_controller);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+arch_initcall(ath724x_pcibios_init);
-- 
1.7.7.1
