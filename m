Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 11:56:48 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:40550 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903783Ab1KPK4Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 11:56:16 +0100
Received: by bkat2 with SMTP id t2so446295bka.36
        for <multiple recipients>; Wed, 16 Nov 2011 02:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tKQl2+Wi233nse5cn5yvDjGzau2nVPj6SNaLuDwt1Pw=;
        b=NM6EuU0mLYCcRaKAGTBnHYt6vfNeqFBTAerta6QYt2ZOpFKXMuG4+lxHFvSYyfLYcg
         twChY3Ssc3AJbTsyyL4m4eBfJLvpp3urNEdCVmQKIon/0XjhbsP9Je1ezlNyvRCpptNF
         ZzfE3Cn57s+0v1FxYz8euF+5xrTNURCpUuC/w=
Received: by 10.204.14.208 with SMTP id h16mr28096602bka.2.1321440971389;
        Wed, 16 Nov 2011 02:56:11 -0800 (PST)
Received: from localhost.localdomain (dslb-178-003-254-091.pools.arcor-ip.net. [178.3.254.91])
        by mx.google.com with ESMTPS id z7sm38609961bka.1.2011.11.16.02.56.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 02:56:10 -0800 (PST)
From:   Rene Bolldorf <xsecute@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Rene Bolldorf <xsecute@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=201/2=5D=20Initial=20PCI=20support=20for=20Atheros=20724x=20SoCs=2E?=
Date:   Wed, 16 Nov 2011 11:55:39 +0100
Message-Id: <1321440940-20246-2-git-send-email-xsecute@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1321440940-20246-1-git-send-email-xsecute@googlemail.com>
References: <1321440940-20246-1-git-send-email-xsecute@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13290

Signed-off-by: Rene Bolldorf <xsecute@googlemail.com>
---
 arch/mips/pci/Makefile      |    1 +
 arch/mips/pci/ops-ath724x.c |  109 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/pci/pci-ath724x.c |   45 ++++++++++++++++++
 3 files changed, 155 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/pci/ops-ath724x.c
 create mode 100644 arch/mips/pci/pci-ath724x.c

diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index bb82cbd..5180b38 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
 obj-$(CONFIG_BCM63XX)		+= pci-bcm63xx.o fixup-bcm63xx.o \
 					ops-bcm63xx.o
 obj-$(CONFIG_MIPS_ALCHEMY)	+= pci-alchemy.o
+obj-$(CONFIG_SOC_AR724X)	+= ops-ath724x.o pci-ath724x.o
 
 #
 # These are still pretty much in the old state, watch, go blind.
diff --git a/arch/mips/pci/ops-ath724x.c b/arch/mips/pci/ops-ath724x.c
new file mode 100644
index 0000000..bd3cf15
--- /dev/null
+++ b/arch/mips/pci/ops-ath724x.c
@@ -0,0 +1,109 @@
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
+
+#define reg_read(_phys)		(*(volatile unsigned int *) KSEG1ADDR(_phys))
+#define reg_write(_phys, _val)	((*(volatile unsigned int *) KSEG1ADDR(_phys)) = (_val))
+
+#define ATH724X_PCI_DEV_BASE	0x14000000
+
+static DEFINE_SPINLOCK(ath724x_pci_lock);
+
+static int ath724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
+			    int size, uint32_t *value)
+{
+	unsigned long flags, addr, tval, mask;
+
+	if(devfn)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if(where & (size - 1))
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
+static int ath724x_pci_write(struct pci_bus *bus,  unsigned int devfn, int where,
+			     int size, uint32_t value)
+{
+	unsigned long flags, tval, addr, mask;
+
+	if(devfn)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if(where & (size - 1))
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
+		reg_write(addr,tval);
+	break;
+	case 2:
+		addr = (ATH724X_PCI_DEV_BASE + where) & ~3;
+		mask = 0xffff0000 >> ((where % 4)*8);
+		tval = reg_read(addr);
+		tval = tval & ~mask;
+		tval |= (value << ((4 - (where % 4))*8)) & mask;
+		reg_write(addr,tval);
+	break;
+	case 4:
+		reg_write((ATH724X_PCI_DEV_BASE + where),value);
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
+struct pci_ops ath724x_pci_ops = {
+	.read	= ath724x_pci_read,
+	.write	= ath724x_pci_write,
+};
diff --git a/arch/mips/pci/pci-ath724x.c b/arch/mips/pci/pci-ath724x.c
new file mode 100644
index 0000000..6c6c483
--- /dev/null
+++ b/arch/mips/pci/pci-ath724x.c
@@ -0,0 +1,45 @@
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
+
+#define ATH724X_PCI_MEM_BASE    0x10000000
+#define ATH724X_PCI_MEM_SIZE    0x08000000
+
+static struct resource ath724x_io_resource = {
+	.name	= "PCI IO space",
+	.start	= 0,
+	.end	= 0,
+	.flags	= IORESOURCE_IO,
+};
+
+static struct resource ath724x_mem_resource = {
+	.name	= "PCI memory space",
+	.start	= ATH724X_PCI_MEM_BASE,
+	.end	= ATH724X_PCI_MEM_BASE + ATH724X_PCI_MEM_SIZE - 1,
+	.flags	= IORESOURCE_MEM,
+};
+
+extern struct pci_ops ath724x_pci_ops;
+
+static struct pci_controller ath724x_pci_controller = {
+	.pci_ops	= &ath724x_pci_ops,
+	.mem_resource	= &ath724x_mem_resource,
+	.io_resource	= &ath724x_io_resource,
+};
+
+static int __init ath724x_pcibios_init(void)
+{
+	register_pci_controller(&ath724x_pci_controller);
+
+	return 0;
+}
+
+arch_initcall(ath724x_pcibios_init);
-- 
1.7.7.1
