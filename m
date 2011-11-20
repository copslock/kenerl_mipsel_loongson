Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Nov 2011 22:41:56 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:41551 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903665Ab1KTVjg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Nov 2011 22:39:36 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 2489B140463;
        Sun, 20 Nov 2011 22:39:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Scu2MhoZ4eUQ; Sun, 20 Nov 2011 22:39:26 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 7BF7E14039D;
        Sun, 20 Nov 2011 22:39:25 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Rene Bolldorf <xsecute@googlemail.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v3 4/7] MIPS: ath79: add a common PCI registration function
Date:   Sun, 20 Nov 2011 22:39:08 +0100
Message-Id: <1321825151-16053-5-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321825151-16053-1-git-send-email-juhosg@openwrt.org>
References: <1321825151-16053-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16772

The current code unconditionally registers the AR724X
specific PCI controller, even if the kernel is running
on a different SoC.

Add a common function for PCI controller registration,
and only register the AR724X PCI controller if the kernel
is running on an AR724X SoC.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v3: - fix compile error if CONFIG_PCI is not defined
    - add __init annotation to ath79_register_pci

v2: - no changes
---
 arch/mips/ath79/mach-ubnt-xm.c |    1 +
 arch/mips/ath79/pci.c          |   14 ++++++++++++++
 arch/mips/ath79/pci.h          |    6 ++++++
 arch/mips/pci/pci-ath724x.c    |    2 --
 4 files changed, 21 insertions(+), 2 deletions(-)

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
index 4957428..342363b 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -9,6 +9,8 @@
  */
 
 #include <linux/pci.h>
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/pci.h>
 #include "pci.h"
 
 static struct ath724x_pci_data *pci_data;
@@ -44,3 +46,15 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 
 	return PCIBIOS_SUCCESSFUL;
 }
+
+int __init ath79_register_pci(void)
+{
+	int ret;
+
+	if (soc_is_ar724x())
+		ret = ath724x_pcibios_init();
+	else
+		ret = -ENODEV;
+
+	return ret;
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
