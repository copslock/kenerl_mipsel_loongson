Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:32:56 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:42645 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903722Ab2CNJat (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:30:49 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id F00E223C00DA;
        Wed, 14 Mar 2012 10:00:08 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org
Subject: [PATCH v3 06/12] MIPS: ath79: get rid of some ifdefs in mach-ubnt-xm.c
Date:   Wed, 14 Mar 2012 11:36:08 +0100
Message-Id: <1331721374-4144-7-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
References: <1331721374-4144-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Remove a superfluous ifdef around an include. Also
reorganize the board setup code a bit, so another
ifdef can be removed.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v3: - no changes
v2: - no changes

 arch/mips/ath79/mach-ubnt-xm.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
index 0d95b67..1e6b986 100644
--- a/arch/mips/ath79/mach-ubnt-xm.c
+++ b/arch/mips/ath79/mach-ubnt-xm.c
@@ -12,10 +12,7 @@
 
 #include <linux/init.h>
 #include <linux/pci.h>
-
-#ifdef CONFIG_PCI
 #include <linux/ath9k_platform.h>
-#endif /* CONFIG_PCI */
 
 #include <asm/mach-ath79/irq.h>
 
@@ -91,6 +88,17 @@ static struct ar724x_pci_data ubnt_xm_pci_data[] = {
 		.pdata	= &ubnt_xm_eeprom_data,
 	},
 };
+
+static void __init ubnt_xm_pci_init(void)
+{
+	memcpy(ubnt_xm_eeprom_data.eeprom_data, UBNT_XM_EEPROM_ADDR,
+	       sizeof(ubnt_xm_eeprom_data.eeprom_data));
+
+	ar724x_pci_add_data(ubnt_xm_pci_data, ARRAY_SIZE(ubnt_xm_pci_data));
+	ath79_register_pci();
+}
+#else
+static inline void ubnt_xm_pci_init(void) {}
 #endif /* CONFIG_PCI */
 
 static void __init ubnt_xm_init(void)
@@ -105,14 +113,7 @@ static void __init ubnt_xm_init(void)
 	ath79_register_spi(&ubnt_xm_spi_data, ubnt_xm_spi_info,
 			   ARRAY_SIZE(ubnt_xm_spi_info));
 
-#ifdef CONFIG_PCI
-	memcpy(ubnt_xm_eeprom_data.eeprom_data, UBNT_XM_EEPROM_ADDR,
-	       sizeof(ubnt_xm_eeprom_data.eeprom_data));
-
-	ar724x_pci_add_data(ubnt_xm_pci_data, ARRAY_SIZE(ubnt_xm_pci_data));
-#endif /* CONFIG_PCI */
-
-	ath79_register_pci();
+	ubnt_xm_pci_init();
 }
 
 MIPS_MACHINE(ATH79_MACH_UBNT_XM,
-- 
1.7.2.1
