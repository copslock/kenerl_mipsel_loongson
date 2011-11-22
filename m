Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 00:19:36 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:47777 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903849Ab1KVXPE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2011 00:15:04 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id CBE04140584;
        Wed, 23 Nov 2011 00:14:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0LXIhztCBJ+O; Wed, 23 Nov 2011 00:14:58 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id AC1F114057B;
        Wed, 23 Nov 2011 00:14:53 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        =?UTF-8?q?Ren=C3=A9=20Bolldorf?= <xsecute@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 09/12] MIPS: ath79: allow to use SoC specific PCI IRQ maps
Date:   Wed, 23 Nov 2011 00:14:27 +0100
Message-Id: <1322003670-8797-10-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19244

The PCI controllers in the AR71XX and in the
AR724X SoCs are different, and both of them
uses different IRQ wiring.

The patch modifies the 'pcibios_map_irq' function
in order to allow to use different IRQ maps for
the different SoCs. The patch also adds a function,
which lets the board setup code to override the
default IRQ map.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/pci.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++---
 arch/mips/ath79/pci.h |    9 ++++++
 2 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index 2b4c730..365a8b6 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -8,6 +8,7 @@
  *  by the Free Software Foundation.
  */
 
+#include <linux/init.h>
 #include <linux/pci.h>
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/irq.h>
@@ -15,9 +16,35 @@
 #include "pci.h"
 
 static int (*ath79_pci_plat_dev_init)(struct pci_dev *dev);
+static const struct ath79_pci_irq *ath79_pci_irq_map __initdata;
+static unsigned ath79_pci_nr_irqs __initdata;
 static struct ar724x_pci_data *pci_data;
 static int pci_data_size;
 
+static const struct ath79_pci_irq ar71xx_pci_irq_map[] __initconst = {
+	{
+		.slot	= 17,
+		.pin	= 1,
+		.irq	= ATH79_PCI_IRQ(0),
+	}, {
+		.slot	= 18,
+		.pin	= 1,
+		.irq	= ATH79_PCI_IRQ(1),
+	}, {
+		.slot	= 19,
+		.pin	= 1,
+		.irq	= ATH79_PCI_IRQ(2),
+	}
+};
+
+static const struct ath79_pci_irq ar724x_pci_irq_map[] __initconst = {
+	{
+		.slot	= 0,
+		.pin	= 1,
+		.irq	= ATH79_PCI_IRQ(0),
+	}
+};
+
 void ar724x_pci_add_data(struct ar724x_pci_data *data, int size)
 {
 	pci_data	= data;
@@ -26,13 +53,40 @@ void ar724x_pci_add_data(struct ar724x_pci_data *data, int size)
 
 int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
 {
-	unsigned int devfn = dev->devfn;
 	int irq = -1;
+	int i;
+
+	if (ath79_pci_nr_irqs == 0 ||
+	    ath79_pci_irq_map == NULL) {
+		if (soc_is_ar71xx()) {
+			ath79_pci_irq_map = ar71xx_pci_irq_map;
+			ath79_pci_nr_irqs = ARRAY_SIZE(ar71xx_pci_irq_map);
+		} else if (soc_is_ar724x()) {
+			ath79_pci_irq_map = ar724x_pci_irq_map;
+			ath79_pci_nr_irqs = ARRAY_SIZE(ar724x_pci_irq_map);
+		} else {
+			pr_crit("pci %s: invalid irq map\n",
+				pci_name((struct pci_dev *) dev));
+			return irq;
+		}
+	}
+
+	for (i = 0; i < ath79_pci_nr_irqs; i++) {
+		const struct ath79_pci_irq *entry;
 
-	if (devfn > pci_data_size - 1)
-		return irq;
+		entry = &ath79_pci_irq_map[i];
+		if (entry->slot == slot && entry->pin == pin) {
+			irq = entry->irq;
+			break;
+		}
+	}
 
-	irq = pci_data[devfn].irq;
+	if (irq < 0)
+		pr_crit("pci %s: no irq found for pin %u\n",
+			pci_name((struct pci_dev *) dev), pin);
+	else
+		pr_info("pci %s: using irq %d for pin %u\n",
+			pci_name((struct pci_dev *) dev), irq, pin);
 
 	return irq;
 }
@@ -45,6 +99,13 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
+void __init ath79_pci_set_irq_map(unsigned nr_irqs,
+				  const struct ath79_pci_irq *map)
+{
+	ath79_pci_nr_irqs = nr_irqs;
+	ath79_pci_irq_map = map;
+}
+
 void __init ath79_pci_set_plat_dev_init(int (*func)(struct pci_dev *dev))
 {
 	ath79_pci_plat_dev_init = func;
@@ -52,6 +113,9 @@ void __init ath79_pci_set_plat_dev_init(int (*func)(struct pci_dev *dev))
 
 int __init ath79_register_pci(void)
 {
+	if (soc_is_ar71xx())
+		return ar71xx_pcibios_init();
+
 	if (soc_is_ar724x())
 		return ar724x_pcibios_init(ATH79_CPU_IRQ_IP2);
 
diff --git a/arch/mips/ath79/pci.h b/arch/mips/ath79/pci.h
index de30e15..a5c4e58 100644
--- a/arch/mips/ath79/pci.h
+++ b/arch/mips/ath79/pci.h
@@ -15,13 +15,22 @@ struct ar724x_pci_data {
 	int irq;
 };
 
+struct ath79_pci_irq {
+	u8	slot;
+	u8	pin;
+	int	irq;
+};
+
 void ar724x_pci_add_data(struct ar724x_pci_data *data, int size);
 
 #ifdef CONFIG_PCI
+void ath79_pci_set_irq_map(unsigned nr_irqs, const struct ath79_pci_irq *map);
 void ath79_pci_set_plat_dev_init(int (*func)(struct pci_dev *dev));
 int ath79_register_pci(void);
 #else
 static inline void
+ath79_pci_set_irq_map(unsigned nr_irqs, const struct ath79_pci_irq *map) {}
+static inline void
 ath79_pci_set_plat_dev_init(int (*func)(struct pci_dev *)) {}
 static inline int ath79_register_pci(void) { return 0; }
 #endif
-- 
1.7.2.1
