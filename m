Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 00:18:46 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:47771 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903847Ab1KVXPE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2011 00:15:04 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id E8D1914057D;
        Wed, 23 Nov 2011 00:14:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jKrrBPGIJ+ZI; Wed, 23 Nov 2011 00:14:58 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id D78B4140587;
        Wed, 23 Nov 2011 00:14:53 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        =?UTF-8?q?Ren=C3=A9=20Bolldorf?= <xsecute@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 10/12] MIPS: ath79: remove ar724x_pci_add_data function
Date:   Wed, 23 Nov 2011 00:14:28 +0100
Message-Id: <1322003670-8797-11-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19239

The variables set by this function are not used anymore.
Remove the function and the relevant variables as well.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/mach-ubnt-xm.c |    7 -------
 arch/mips/ath79/pci.c          |    8 --------
 arch/mips/ath79/pci.h          |    6 ------
 3 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
index ca47ba5..4a3c606 100644
--- a/arch/mips/ath79/mach-ubnt-xm.c
+++ b/arch/mips/ath79/mach-ubnt-xm.c
@@ -82,12 +82,6 @@ static struct ath79_spi_platform_data ubnt_xm_spi_data = {
 #ifdef CONFIG_PCI
 static struct ath9k_platform_data ubnt_xm_eeprom_data;
 
-static struct ar724x_pci_data ubnt_xm_pci_data[] = {
-	{
-		.irq	= ATH79_PCI_IRQ(0),
-	},
-};
-
 static int ubnt_xm_pci_plat_dev_init(struct pci_dev *dev)
 {
 	switch (PCI_SLOT(dev->devfn)) {
@@ -104,7 +98,6 @@ static void __init ubnt_xm_pci_init(void)
 	memcpy(ubnt_xm_eeprom_data.eeprom_data, UBNT_XM_EEPROM_ADDR,
 	       sizeof(ubnt_xm_eeprom_data.eeprom_data));
 
-	ar724x_pci_add_data(ubnt_xm_pci_data, ARRAY_SIZE(ubnt_xm_pci_data));
 	ath79_pci_set_plat_dev_init(ubnt_xm_pci_plat_dev_init);
 	ath79_register_pci();
 }
diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index 365a8b6..253a382 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -18,8 +18,6 @@
 static int (*ath79_pci_plat_dev_init)(struct pci_dev *dev);
 static const struct ath79_pci_irq *ath79_pci_irq_map __initdata;
 static unsigned ath79_pci_nr_irqs __initdata;
-static struct ar724x_pci_data *pci_data;
-static int pci_data_size;
 
 static const struct ath79_pci_irq ar71xx_pci_irq_map[] __initconst = {
 	{
@@ -45,12 +43,6 @@ static const struct ath79_pci_irq ar724x_pci_irq_map[] __initconst = {
 	}
 };
 
-void ar724x_pci_add_data(struct ar724x_pci_data *data, int size)
-{
-	pci_data	= data;
-	pci_data_size	= size;
-}
-
 int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
 {
 	int irq = -1;
diff --git a/arch/mips/ath79/pci.h b/arch/mips/ath79/pci.h
index a5c4e58..5ebed21 100644
--- a/arch/mips/ath79/pci.h
+++ b/arch/mips/ath79/pci.h
@@ -11,18 +11,12 @@
 #ifndef _ATH79_PCI_H
 #define _ATH79_PCI_H
 
-struct ar724x_pci_data {
-	int irq;
-};
-
 struct ath79_pci_irq {
 	u8	slot;
 	u8	pin;
 	int	irq;
 };
 
-void ar724x_pci_add_data(struct ar724x_pci_data *data, int size);
-
 #ifdef CONFIG_PCI
 void ath79_pci_set_irq_map(unsigned nr_irqs, const struct ath79_pci_irq *map);
 void ath79_pci_set_plat_dev_init(int (*func)(struct pci_dev *dev));
-- 
1.7.2.1
