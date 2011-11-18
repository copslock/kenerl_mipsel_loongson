Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 16:25:12 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:36022 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904122Ab1KRPWd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 16:22:33 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 43B1B1404EE;
        Fri, 18 Nov 2011 16:22:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qpWlb-vUebXy; Fri, 18 Nov 2011 16:22:24 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 712C2140502;
        Fri, 18 Nov 2011 16:22:23 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Rene Bolldorf <xsecute@googlemail.com>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 6/7] MIPS: ath79: replace ath724x to ar724x
Date:   Fri, 18 Nov 2011 16:21:59 +0100
Message-Id: <1321629720-29035-6-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321629720-29035-1-git-send-email-juhosg@openwrt.org>
References: <1321629720-29035-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15537

Replace the 'ath724x' to 'ar724x' in function, variable and
structure names to reflect the name of the real SoC.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/mach-ubnt-xm.c         |    4 +-
 arch/mips/ath79/pci.c                  |    6 ++--
 arch/mips/ath79/pci.h                  |   10 +++---
 arch/mips/include/asm/mach-ath79/pci.h |    4 +-
 arch/mips/pci/pci-ar724x.c             |   62 ++++++++++++++++----------------
 5 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
index 1d44cc2..2147b3a 100644
--- a/arch/mips/ath79/mach-ubnt-xm.c
+++ b/arch/mips/ath79/mach-ubnt-xm.c
@@ -84,7 +84,7 @@ static struct ath79_spi_platform_data ubnt_xm_spi_data = {
 #ifdef CONFIG_PCI
 static struct ath9k_platform_data ubnt_xm_eeprom_data;
 
-static struct ath724x_pci_data ubnt_xm_pci_data[] = {
+static struct ar724x_pci_data ubnt_xm_pci_data[] = {
 	{
 		.irq	= UBNT_XM_PCI_IRQ,
 		.pdata	= &ubnt_xm_eeprom_data,
@@ -108,7 +108,7 @@ static void __init ubnt_xm_init(void)
 	memcpy(ubnt_xm_eeprom_data.eeprom_data, UBNT_XM_EEPROM_ADDR,
 	       sizeof(ubnt_xm_eeprom_data.eeprom_data));
 
-	ath724x_pci_add_data(ubnt_xm_pci_data, ARRAY_SIZE(ubnt_xm_pci_data));
+	ar724x_pci_add_data(ubnt_xm_pci_data, ARRAY_SIZE(ubnt_xm_pci_data));
 #endif /* CONFIG_PCI */
 
 	ath79_register_pci();
diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index a2dae75..9970e18 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -13,10 +13,10 @@
 #include <asm/mach-ath79/pci.h>
 #include "pci.h"
 
-static struct ath724x_pci_data *pci_data;
+static struct ar724x_pci_data *pci_data;
 static int pci_data_size;
 
-void ath724x_pci_add_data(struct ath724x_pci_data *data, int size)
+void ar724x_pci_add_data(struct ar724x_pci_data *data, int size)
 {
 	pci_data	= data;
 	pci_data_size	= size;
@@ -52,7 +52,7 @@ int ath79_register_pci(void)
 	int ret;
 
 	if (soc_is_ar724x())
-		ret = ath724x_pcibios_init();
+		ret = ar724x_pcibios_init();
 	else
 		ret = -ENODEV;
 
diff --git a/arch/mips/ath79/pci.h b/arch/mips/ath79/pci.h
index 4653ca8..34349bc 100644
--- a/arch/mips/ath79/pci.h
+++ b/arch/mips/ath79/pci.h
@@ -8,15 +8,15 @@
  *  by the Free Software Foundation.
  */
 
-#ifndef __ASM_MACH_ATH79_PCI_ATH724X_H
-#define __ASM_MACH_ATH79_PCI_ATH724X_H
+#ifndef _ATH79_PCI_H
+#define _ATH79_PCI_H
 
-struct ath724x_pci_data {
+struct ar724x_pci_data {
 	int irq;
 	void *pdata;
 };
 
-void ath724x_pci_add_data(struct ath724x_pci_data *data, int size);
+void ar724x_pci_add_data(struct ar724x_pci_data *data, int size);
 
 #ifdef CONFIG_PCI
 int ath79_register_pci(void);
@@ -24,4 +24,4 @@ int ath79_register_pci(void);
 static inline int ath79_register_pci(void) {};
 #endif
 
-#endif /* __ASM_MACH_ATH79_PCI_ATH724X_H */
+#endif /* _ATH79_PCI_H */
diff --git a/arch/mips/include/asm/mach-ath79/pci.h b/arch/mips/include/asm/mach-ath79/pci.h
index 7ef8a49..0aaf41f 100644
--- a/arch/mips/include/asm/mach-ath79/pci.h
+++ b/arch/mips/include/asm/mach-ath79/pci.h
@@ -12,9 +12,9 @@
 #define __ASM_MACH_ATH79_PCI_H
 
 #if defined(CONFIG_PCI) && defined(CONFIG_SOC_AR724X)
-int ath724x_pcibios_init(void);
+int ar724x_pcibios_init(void);
 #else
-static inline int ath724x_pcibios_init(void) { return 0 };
+static inline int ar724x_pcibios_init(void) { return 0 };
 #endif
 
 #endif /* __ASM_MACH_ATH79_PCI_H */
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index ebefc16..772d12c 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -14,13 +14,13 @@
 #define reg_read(_phys)		(*(unsigned int *) KSEG1ADDR(_phys))
 #define reg_write(_phys, _val)	((*(unsigned int *) KSEG1ADDR(_phys)) = (_val))
 
-#define ATH724X_PCI_DEV_BASE	0x14000000
-#define ATH724X_PCI_MEM_BASE	0x10000000
-#define ATH724X_PCI_MEM_SIZE	0x08000000
+#define AR724X_PCI_DEV_BASE	0x14000000
+#define AR724X_PCI_MEM_BASE	0x10000000
+#define AR724X_PCI_MEM_SIZE	0x08000000
 
-static DEFINE_SPINLOCK(ath724x_pci_lock);
+static DEFINE_SPINLOCK(ar724x_pci_lock);
 
-static int ath724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
+static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 			    int size, uint32_t *value)
 {
 	unsigned long flags, addr, tval, mask;
@@ -31,38 +31,38 @@ static int ath724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 	if (where & (size - 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	spin_lock_irqsave(&ath724x_pci_lock, flags);
+	spin_lock_irqsave(&ar724x_pci_lock, flags);
 
 	switch (size) {
 	case 1:
 		addr = where & ~3;
 		mask = 0xff000000 >> ((where % 4) * 8);
-		tval = reg_read(ATH724X_PCI_DEV_BASE + addr);
+		tval = reg_read(AR724X_PCI_DEV_BASE + addr);
 		tval = tval & ~mask;
 		*value = (tval >> ((4 - (where % 4))*8));
 		break;
 	case 2:
 		addr = where & ~3;
 		mask = 0xffff0000 >> ((where % 4)*8);
-		tval = reg_read(ATH724X_PCI_DEV_BASE + addr);
+		tval = reg_read(AR724X_PCI_DEV_BASE + addr);
 		tval = tval & ~mask;
 		*value = (tval >> ((4 - (where % 4))*8));
 		break;
 	case 4:
-		*value = reg_read(ATH724X_PCI_DEV_BASE + where);
+		*value = reg_read(AR724X_PCI_DEV_BASE + where);
 		break;
 	default:
-		spin_unlock_irqrestore(&ath724x_pci_lock, flags);
+		spin_unlock_irqrestore(&ar724x_pci_lock, flags);
 
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
-	spin_unlock_irqrestore(&ath724x_pci_lock, flags);
+	spin_unlock_irqrestore(&ar724x_pci_lock, flags);
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int ath724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
+static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 			     int size, uint32_t value)
 {
 	unsigned long flags, tval, addr, mask;
@@ -73,11 +73,11 @@ static int ath724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 	if (where & (size - 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	spin_lock_irqsave(&ath724x_pci_lock, flags);
+	spin_lock_irqsave(&ar724x_pci_lock, flags);
 
 	switch (size) {
 	case 1:
-		addr = (ATH724X_PCI_DEV_BASE + where) & ~3;
+		addr = (AR724X_PCI_DEV_BASE + where) & ~3;
 		mask = 0xff000000 >> ((where % 4)*8);
 		tval = reg_read(addr);
 		tval = tval & ~mask;
@@ -85,7 +85,7 @@ static int ath724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 		reg_write(addr, tval);
 		break;
 	case 2:
-		addr = (ATH724X_PCI_DEV_BASE + where) & ~3;
+		addr = (AR724X_PCI_DEV_BASE + where) & ~3;
 		mask = 0xffff0000 >> ((where % 4)*8);
 		tval = reg_read(addr);
 		tval = tval & ~mask;
@@ -93,47 +93,47 @@ static int ath724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 		reg_write(addr, tval);
 		break;
 	case 4:
-		reg_write((ATH724X_PCI_DEV_BASE + where), value);
+		reg_write((AR724X_PCI_DEV_BASE + where), value);
 		break;
 	default:
-		spin_unlock_irqrestore(&ath724x_pci_lock, flags);
+		spin_unlock_irqrestore(&ar724x_pci_lock, flags);
 
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
-	spin_unlock_irqrestore(&ath724x_pci_lock, flags);
+	spin_unlock_irqrestore(&ar724x_pci_lock, flags);
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static struct pci_ops ath724x_pci_ops = {
-	.read	= ath724x_pci_read,
-	.write	= ath724x_pci_write,
+static struct pci_ops ar724x_pci_ops = {
+	.read	= ar724x_pci_read,
+	.write	= ar724x_pci_write,
 };
 
-static struct resource ath724x_io_resource = {
+static struct resource ar724x_io_resource = {
 	.name   = "PCI IO space",
 	.start  = 0,
 	.end    = 0,
 	.flags  = IORESOURCE_IO,
 };
 
-static struct resource ath724x_mem_resource = {
+static struct resource ar724x_mem_resource = {
 	.name   = "PCI memory space",
-	.start  = ATH724X_PCI_MEM_BASE,
-	.end    = ATH724X_PCI_MEM_BASE + ATH724X_PCI_MEM_SIZE - 1,
+	.start  = AR724X_PCI_MEM_BASE,
+	.end    = AR724X_PCI_MEM_BASE + AR724X_PCI_MEM_SIZE - 1,
 	.flags  = IORESOURCE_MEM,
 };
 
-static struct pci_controller ath724x_pci_controller = {
-	.pci_ops        = &ath724x_pci_ops,
-	.io_resource    = &ath724x_io_resource,
-	.mem_resource	= &ath724x_mem_resource,
+static struct pci_controller ar724x_pci_controller = {
+	.pci_ops        = &ar724x_pci_ops,
+	.io_resource    = &ar724x_io_resource,
+	.mem_resource	= &ar724x_mem_resource,
 };
 
-int __init ath724x_pcibios_init(void)
+int __init ar724x_pcibios_init(void)
 {
-	register_pci_controller(&ath724x_pci_controller);
+	register_pci_controller(&ar724x_pci_controller);
 
 	return PCIBIOS_SUCCESSFUL;
 }
-- 
1.7.2.1
