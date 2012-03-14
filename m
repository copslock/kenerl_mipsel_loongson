Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:33:53 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:42668 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903713Ab2CNJa4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:30:56 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 3600A23C00DD;
        Wed, 14 Mar 2012 10:00:09 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org
Subject: [PATCH v3 07/12] MIPS: ath79: allow to use board specific pci_plat_dev_init functions
Date:   Wed, 14 Mar 2012 11:36:09 +0100
Message-Id: <1331721374-4144-8-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
References: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Th current implementation causes NULL pointer dereference
if 'pci_data' is not set:

pci 0000:00:00.0: BAR 0: assigned [mem 0x10000000-0x1000ffff 64bit]
pci 0000:00:00.0: BAR 0: set to [mem 0x10000000-0x1000ffff 64bit] (PCI
address [0x10000000-0x1000ffff])
CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 802daca0, ra == 802e78a4
Oops[#1]:
Cpu 0
$ 0   : 00000000 80420000 00000000 00000000
$ 4   : 00000000 00000000 00000001 00000001
$ 8   : 00000001 0000032c 81c54700 00000001
$12   : 0000032d 0000000f 00000000 ffffffff
$16   : 81c14c00 00000001 802dac74 80195f98
$20   : 802ea050 00000000 00000000 00000000
$24   : 00000003 800617f0
$28   : 81c20000 81c21e70 00000000 802e78a4
Hi    : 00000000
Lo    : 4190ab00
epc   : 802daca0 0x802daca0
    Not tainted
ra    : 802e78a4 0x802e78a4
Status: 1000c003    KERNEL EXL IE
Cause : 00800008
BadVA : 00000000
PrId  : 00019374 (MIPS 24Kc)
Modules linked in:
Process swapper (pid: 1, threadinfo=81c20000, task=81c18000, tls=00000000)
Stack : 00000000 8027d5d8 802e8ae0 00000000 01000000 802e8b5c 81c50600 00000000
        802ff290 00000000 80420000 802ea0bc 00000000 00000000 80420000 802ff290
        80420000 80060930 33390000 00000000 00002308 80140a80 00000028 802d0000
        00000000 800ba024 802ff004 802ff0c8 802ff290 00000000 00000000 00000000
        00000000 802d897c 01234567 7f827068 00000000 0045f798 00460000 00000000

This can be avoided by calling the 'ar724x_pci_add_data'
function from the board specific setup code. However it
makes no sense to use that function for every board,
especially when the board does not needs to set the
platform_data field of any PCI device.

The patch allows the board setup code to specify a board
specific function if that is required.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v3: - no changes
v2: - no changes

The pci_irq_map function can throw another NULL pointer
dereference, that will be fixed in a subsequent patch.

 arch/mips/ath79/mach-ubnt-xm.c |   13 ++++++++++++-
 arch/mips/ath79/pci.c          |   14 ++++++++------
 arch/mips/ath79/pci.h          |    4 +++-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
index 1e6b986..ca47ba5 100644
--- a/arch/mips/ath79/mach-ubnt-xm.c
+++ b/arch/mips/ath79/mach-ubnt-xm.c
@@ -85,16 +85,27 @@ static struct ath9k_platform_data ubnt_xm_eeprom_data;
 static struct ar724x_pci_data ubnt_xm_pci_data[] = {
 	{
 		.irq	= ATH79_PCI_IRQ(0),
-		.pdata	= &ubnt_xm_eeprom_data,
 	},
 };
 
+static int ubnt_xm_pci_plat_dev_init(struct pci_dev *dev)
+{
+	switch (PCI_SLOT(dev->devfn)) {
+	case 0:
+		dev->dev.platform_data = &ubnt_xm_eeprom_data;
+		break;
+	}
+
+	return 0;
+}
+
 static void __init ubnt_xm_pci_init(void)
 {
 	memcpy(ubnt_xm_eeprom_data.eeprom_data, UBNT_XM_EEPROM_ADDR,
 	       sizeof(ubnt_xm_eeprom_data.eeprom_data));
 
 	ar724x_pci_add_data(ubnt_xm_pci_data, ARRAY_SIZE(ubnt_xm_pci_data));
+	ath79_pci_set_plat_dev_init(ubnt_xm_pci_plat_dev_init);
 	ath79_register_pci();
 }
 #else
diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index 14f981c2..2b4c730 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -14,6 +14,7 @@
 #include <asm/mach-ath79/pci.h>
 #include "pci.h"
 
+static int (*ath79_pci_plat_dev_init)(struct pci_dev *dev);
 static struct ar724x_pci_data *pci_data;
 static int pci_data_size;
 
@@ -38,14 +39,15 @@ int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
 
 int pcibios_plat_dev_init(struct pci_dev *dev)
 {
-	unsigned int devfn = dev->devfn;
-
-	if (devfn > pci_data_size - 1)
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (ath79_pci_plat_dev_init)
+		return ath79_pci_plat_dev_init(dev);
 
-	dev->dev.platform_data = pci_data[devfn].pdata;
+	return 0;
+}
 
-	return PCIBIOS_SUCCESSFUL;
+void __init ath79_pci_set_plat_dev_init(int (*func)(struct pci_dev *dev))
+{
+	ath79_pci_plat_dev_init = func;
 }
 
 int __init ath79_register_pci(void)
diff --git a/arch/mips/ath79/pci.h b/arch/mips/ath79/pci.h
index e0601c4..de30e15 100644
--- a/arch/mips/ath79/pci.h
+++ b/arch/mips/ath79/pci.h
@@ -13,14 +13,16 @@
 
 struct ar724x_pci_data {
 	int irq;
-	void *pdata;
 };
 
 void ar724x_pci_add_data(struct ar724x_pci_data *data, int size);
 
 #ifdef CONFIG_PCI
+void ath79_pci_set_plat_dev_init(int (*func)(struct pci_dev *dev));
 int ath79_register_pci(void);
 #else
+static inline void
+ath79_pci_set_plat_dev_init(int (*func)(struct pci_dev *)) {}
 static inline int ath79_register_pci(void) { return 0; }
 #endif
 
-- 
1.7.2.1
