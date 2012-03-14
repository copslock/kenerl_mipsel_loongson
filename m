Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:44:36 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34510 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903742Ab2CNJkc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:40:32 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 38FDB23C00E3;
        Wed, 14 Mar 2012 10:09:32 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, juhosg@openwrt.org
Subject: [PATCH v2 11/13] MIPS: ath79: add PCI_AR724X Kconfig symbol
Date:   Wed, 14 Mar 2012 11:45:29 +0100
Message-Id: <1331721931-4334-12-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331721931-4334-1-git-send-email-juhosg@openwrt.org>
References: <1331721931-4334-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The AR724X specific PCI code can be used for the
AR934X SoCs, however it can be selected only if
SOC_AR724X is set.

Introduce a new Kconfig symbol in order to be able
to use the code for AR934X as well.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
---
v2: - update due to changes in a previous patch

 arch/mips/ath79/Kconfig                |    4 ++++
 arch/mips/include/asm/mach-ath79/pci.h |    2 +-
 arch/mips/pci/Makefile                 |    2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 5fa3d7b..123cc37 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -59,6 +59,7 @@ config SOC_AR724X
 	select USB_ARCH_HAS_EHCI
 	select USB_ARCH_HAS_OHCI
 	select HW_HAS_PCI
+	select PCI_AR724X if PCI
 	def_bool n
 
 config SOC_AR913X
@@ -73,6 +74,9 @@ config SOC_AR934X
 	select USB_ARCH_HAS_EHCI
 	def_bool n
 
+config PCI_AR724X
+	def_bool n
+
 config ATH79_DEV_GPIO_BUTTONS
 	def_bool n
 
diff --git a/arch/mips/include/asm/mach-ath79/pci.h b/arch/mips/include/asm/mach-ath79/pci.h
index 4f2222d..7868f7f 100644
--- a/arch/mips/include/asm/mach-ath79/pci.h
+++ b/arch/mips/include/asm/mach-ath79/pci.h
@@ -19,7 +19,7 @@ int ar71xx_pcibios_init(void);
 static inline int ar71xx_pcibios_init(void) { return 0; }
 #endif
 
-#if defined(CONFIG_PCI) && defined(CONFIG_SOC_AR724X)
+#if defined(CONFIG_PCI_AR724X)
 int ar724x_pcibios_init(int irq);
 #else
 static inline int ar724x_pcibios_init(int irq) { return 0; }
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index b1c0a1c..43c5138 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_BCM63XX)		+= pci-bcm63xx.o fixup-bcm63xx.o \
 					ops-bcm63xx.o
 obj-$(CONFIG_MIPS_ALCHEMY)	+= pci-alchemy.o
 obj-$(CONFIG_SOC_AR71XX)	+= pci-ar71xx.o
-obj-$(CONFIG_SOC_AR724X)	+= pci-ar724x.o
+obj-$(CONFIG_PCI_AR724X)	+= pci-ar724x.o
 
 #
 # These are still pretty much in the old state, watch, go blind.
-- 
1.7.2.1
