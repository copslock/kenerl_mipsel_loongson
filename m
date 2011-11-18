Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 19:05:13 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:39746 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904130Ab1KRSEp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 19:04:45 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 82A4F1402FB;
        Fri, 18 Nov 2011 19:04:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JqEwB3VgDl5V; Fri, 18 Nov 2011 19:04:34 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 2795B140312;
        Fri, 18 Nov 2011 19:04:34 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Rene Bolldorf <xsecute@googlemail.com>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v2 7/7] MIPS: ath79: use io-accessor macros in pci-ar724x.c
Date:   Fri, 18 Nov 2011 19:04:10 +0100
Message-Id: <1321639450-13571-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321639450-13571-1-git-send-email-juhosg@openwrt.org>
References: <1321639450-13571-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15756

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v2: remove 'ret' variable from ar724x_pcibios_init

  This is a replacement of the following patch:
  https://patchwork.linux-mips.org/patch/3045/

 arch/mips/pci/pci-ar724x.c |   38 ++++++++++++++++++++++++--------------
 1 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 772d12c..22f5e5b 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -11,19 +11,19 @@
 #include <linux/pci.h>
 #include <asm/mach-ath79/pci.h>
 
-#define reg_read(_phys)		(*(unsigned int *) KSEG1ADDR(_phys))
-#define reg_write(_phys, _val)	((*(unsigned int *) KSEG1ADDR(_phys)) = (_val))
-
-#define AR724X_PCI_DEV_BASE	0x14000000
+#define AR724X_PCI_CFG_BASE	0x14000000
+#define AR724X_PCI_CFG_SIZE	0x1000
 #define AR724X_PCI_MEM_BASE	0x10000000
 #define AR724X_PCI_MEM_SIZE	0x08000000
 
 static DEFINE_SPINLOCK(ar724x_pci_lock);
+static void __iomem *ar724x_pci_devcfg_base;
 
 static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 			    int size, uint32_t *value)
 {
 	unsigned long flags, addr, tval, mask;
+	void __iomem *base;
 
 	if (devfn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -31,25 +31,27 @@ static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 	if (where & (size - 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
+	base = ar724x_pci_devcfg_base;
+
 	spin_lock_irqsave(&ar724x_pci_lock, flags);
 
 	switch (size) {
 	case 1:
 		addr = where & ~3;
 		mask = 0xff000000 >> ((where % 4) * 8);
-		tval = reg_read(AR724X_PCI_DEV_BASE + addr);
+		tval = __raw_readl(base + addr);
 		tval = tval & ~mask;
 		*value = (tval >> ((4 - (where % 4))*8));
 		break;
 	case 2:
 		addr = where & ~3;
 		mask = 0xffff0000 >> ((where % 4)*8);
-		tval = reg_read(AR724X_PCI_DEV_BASE + addr);
+		tval = __raw_readl(base + addr);
 		tval = tval & ~mask;
 		*value = (tval >> ((4 - (where % 4))*8));
 		break;
 	case 4:
-		*value = reg_read(AR724X_PCI_DEV_BASE + where);
+		*value = __raw_readl(base + where);
 		break;
 	default:
 		spin_unlock_irqrestore(&ar724x_pci_lock, flags);
@@ -66,6 +68,7 @@ static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 			     int size, uint32_t value)
 {
 	unsigned long flags, tval, addr, mask;
+	void __iomem *base;
 
 	if (devfn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -73,27 +76,29 @@ static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 	if (where & (size - 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
+	base = ar724x_pci_devcfg_base;
+
 	spin_lock_irqsave(&ar724x_pci_lock, flags);
 
 	switch (size) {
 	case 1:
-		addr = (AR724X_PCI_DEV_BASE + where) & ~3;
+		addr = where & ~3;
 		mask = 0xff000000 >> ((where % 4)*8);
-		tval = reg_read(addr);
+		tval = __raw_readl(base + addr);
 		tval = tval & ~mask;
 		tval |= (value << ((4 - (where % 4))*8)) & mask;
-		reg_write(addr, tval);
+		__raw_writel(tval, base + addr);
 		break;
 	case 2:
-		addr = (AR724X_PCI_DEV_BASE + where) & ~3;
+		addr = where & ~3;
 		mask = 0xffff0000 >> ((where % 4)*8);
-		tval = reg_read(addr);
+		tval = __raw_readl(base + addr);
 		tval = tval & ~mask;
 		tval |= (value << ((4 - (where % 4))*8)) & mask;
-		reg_write(addr, tval);
+		__raw_writel(tval, base + addr);
 		break;
 	case 4:
-		reg_write((AR724X_PCI_DEV_BASE + where), value);
+		__raw_writel(value, (base + where));
 		break;
 	default:
 		spin_unlock_irqrestore(&ar724x_pci_lock, flags);
@@ -133,6 +138,11 @@ static struct pci_controller ar724x_pci_controller = {
 
 int __init ar724x_pcibios_init(void)
 {
+	ar724x_pci_devcfg_base = ioremap(AR724X_PCI_CFG_BASE,
+					 AR724X_PCI_CFG_SIZE);
+	if (ar724x_pci_devcfg_base == NULL)
+		return -ENOMEM;
+
 	register_pci_controller(&ar724x_pci_controller);
 
 	return PCIBIOS_SUCCESSFUL;
-- 
1.7.2.1
