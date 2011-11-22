Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 00:18:21 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:47770 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903846Ab1KVXPD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2011 00:15:03 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 6A20E14057F;
        Wed, 23 Nov 2011 00:14:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1kQTTxvvsZq4; Wed, 23 Nov 2011 00:14:57 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 7F2DA14057D;
        Wed, 23 Nov 2011 00:14:53 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        =?UTF-8?q?Ren=C3=A9=20Bolldorf?= <xsecute@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 08/12] MIPS: ath79: add support for the PCI host controller of the AR71XX SoCs
Date:   Wed, 23 Nov 2011 00:14:26 +0100
Message-Id: <1322003670-8797-9-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19237

The Atheros AR71XX SoCs have a built-in PCI Host Controller.
This patch adds a driver for that, and modifies the relevant
files in order to allow to register the PCI controller from
board specific setup.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/mips/ath79/Kconfig                |    1 +
 arch/mips/include/asm/mach-ath79/pci.h |    6 ++++++
 arch/mips/pci/Makefile                 |    1 +
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index e0fae8f..bc6edad 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -52,6 +52,7 @@ endmenu
 config SOC_AR71XX
 	select USB_ARCH_HAS_EHCI
 	select USB_ARCH_HAS_OHCI
+	select HW_HAS_PCI
 	def_bool n
 
 config SOC_AR724X
diff --git a/arch/mips/include/asm/mach-ath79/pci.h b/arch/mips/include/asm/mach-ath79/pci.h
index a659e40..a3d0655 100644
--- a/arch/mips/include/asm/mach-ath79/pci.h
+++ b/arch/mips/include/asm/mach-ath79/pci.h
@@ -11,6 +11,12 @@
 #ifndef __ASM_MACH_ATH79_PCI_H
 #define __ASM_MACH_ATH79_PCI_H
 
+#if defined(CONFIG_PCI) && defined(CONFIG_SOC_AR71XX)
+int ar71xx_pcibios_init(void);
+#else
+static inline int ar71xx_pcibios_init(void) { return 0 };
+#endif
+
 #if defined(CONFIG_PCI) && defined(CONFIG_SOC_AR724X)
 int ar724x_pcibios_init(int irq);
 #else
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 172277c..b1c0a1c 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
 obj-$(CONFIG_BCM63XX)		+= pci-bcm63xx.o fixup-bcm63xx.o \
 					ops-bcm63xx.o
 obj-$(CONFIG_MIPS_ALCHEMY)	+= pci-alchemy.o
+obj-$(CONFIG_SOC_AR71XX)	+= pci-ar71xx.o
 obj-$(CONFIG_SOC_AR724X)	+= pci-ar724x.o
 
 #
-- 
1.7.2.1
