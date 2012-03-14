Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:26:05 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34873 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903709Ab2CNJXs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:23:48 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 47EB323C00C4;
        Wed, 14 Mar 2012 09:53:23 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org
Subject: [PATCH v5 4/7] MIPS: ath79: add a common PCI registration function
Date:   Wed, 14 Mar 2012 11:29:24 +0100
Message-Id: <1331720967-4049-5-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331720967-4049-1-git-send-email-juhosg@openwrt.org>
References: <1331720967-4049-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The current code unconditionally registers the AR724X
specific PCI controller, even if the kernel is running
on a different SoC.

Add a common function for PCI controller registration,
and only register the AR724X PCI controller if the kernel
is running on an AR724X SoC.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v5: - no changes
v4: - simplify ath79_register_pci function
v3: - fix compile error if CONFIG_PCI is not defined
    - add __init annotation to ath79_register_pci
v2: - no changes

 arch/mips/ath79/mach-ubnt-xm.c |    1 +
 arch/mips/ath79/pci.c          |   10 ++++++++++
 arch/mips/ath79/pci.h          |    6 ++++++
 arch/mips/pci/pci-ath724x.c    |    2 --
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
index a043500..edbc093 100644
--- a/arch/mips/ath79/mach-ubnt-xm.c
+++ b/arch/mips/ath79/mach-ubnt-xm.c
@@ -111,6 +111,7 @@ static void __init ubnt_xm_init(void)
 	ath724x_pci_add_data(ubnt_xm_pci_data, ARRAY_SIZE(ubnt_xm_pci_data));
 #endif /* CONFIG_PCI */
 
+	ath79_register_pci();
 }
 
 MIPS_MACHINE(ATH79_MACH_UBNT_XM,
diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index 4957428..855a69d 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -9,6 +9,8 @@
  */
 
 #include <linux/pci.h>
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/pci.h>
 #include "pci.h"
 
 static struct ath724x_pci_data *pci_data;
@@ -44,3 +46,11 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 
 	return PCIBIOS_SUCCESSFUL;
 }
+
+int __init ath79_register_pci(void)
+{
+	if (soc_is_ar724x())
+		return ath724x_pcibios_init();
+
+	return -ENODEV;
+}
diff --git a/arch/mips/ath79/pci.h b/arch/mips/ath79/pci.h
index 454885f..787fac2 100644
--- a/arch/mips/ath79/pci.h
+++ b/arch/mips/ath79/pci.h
@@ -18,4 +18,10 @@ struct ath724x_pci_data {
 
 void ath724x_pci_add_data(struct ath724x_pci_data *data, int size);
 
+#ifdef CONFIG_PCI
+int ath79_register_pci(void);
+#else
+static inline int ath79_register_pci(void) { return 0; }
+#endif
+
 #endif /* __ASM_MACH_ATH79_PCI_ATH724X_H */
diff --git a/arch/mips/pci/pci-ath724x.c b/arch/mips/pci/pci-ath724x.c
index be01b7f..ebefc16 100644
--- a/arch/mips/pci/pci-ath724x.c
+++ b/arch/mips/pci/pci-ath724x.c
@@ -137,5 +137,3 @@ int __init ath724x_pcibios_init(void)
 
 	return PCIBIOS_SUCCESSFUL;
 }
-
-arch_initcall(ath724x_pcibios_init);
-- 
1.7.2.1
