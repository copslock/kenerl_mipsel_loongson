Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 19:31:42 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:46136 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903779Ab1LWS0X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Dec 2011 19:26:23 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 8862D23C007C;
        Fri, 23 Dec 2011 19:26:21 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 13/16] MIPS: ath79: add PCI registration code for AR934X
Date:   Fri, 23 Dec 2011 19:25:39 +0100
Message-Id: <1324664742-3648-14-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
References: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19101

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
---
 arch/mips/ath79/Kconfig |    2 ++
 arch/mips/ath79/pci.c   |   13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 123cc37..ea28e89 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -72,6 +72,8 @@ config SOC_AR933X
 
 config SOC_AR934X
 	select USB_ARCH_HAS_EHCI
+	select HW_HAS_PCI
+	select PCI_AR724X if PCI
 	def_bool n
 
 config PCI_AR724X
diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index bc40070..ca83abd 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -14,6 +14,7 @@
 
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/irq.h>
 #include <asm/mach-ath79/pci.h>
@@ -57,7 +58,9 @@ int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
 		if (soc_is_ar71xx()) {
 			ath79_pci_irq_map = ar71xx_pci_irq_map;
 			ath79_pci_nr_irqs = ARRAY_SIZE(ar71xx_pci_irq_map);
-		} else if (soc_is_ar724x()) {
+		} else if (soc_is_ar724x() ||
+			   soc_is_ar9342() ||
+			   soc_is_ar9344()) {
 			ath79_pci_irq_map = ar724x_pci_irq_map;
 			ath79_pci_nr_irqs = ARRAY_SIZE(ar724x_pci_irq_map);
 		} else {
@@ -115,5 +118,13 @@ int __init ath79_register_pci(void)
 	if (soc_is_ar724x())
 		return ar724x_pcibios_init(ATH79_CPU_IRQ_IP2);
 
+	if (soc_is_ar9342() || soc_is_ar9344()) {
+		u32 bootstrap;
+
+		bootstrap = ath79_reset_rr(AR934X_RESET_REG_BOOTSTRAP);
+		if (bootstrap & AR934X_BOOTSTRAP_PCIE_RC)
+			return ar724x_pcibios_init(ATH79_IP2_IRQ(0));
+	}
+
 	return -ENODEV;
 }
-- 
1.7.2.1
