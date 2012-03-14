Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:25:41 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34870 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903708Ab2CNJXr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:23:47 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 170F723C00C9;
        Wed, 14 Mar 2012 09:53:23 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, juhosg@openwrt.org,
        =?UTF-8?q?Ren=C3=A9=20Bolldorf?= <xsecute@googlemail.com>
Subject: [PATCH v5 3/7] MIPS: ath79: make ath724x_pcibios_init visible for external code
Date:   Wed, 14 Mar 2012 11:29:23 +0100
Message-Id: <1331720967-4049-4-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331720967-4049-1-git-send-email-juhosg@openwrt.org>
References: <1331720967-4049-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 32675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: René Bolldorf <xsecute@googlemail.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v5: - fix build error if PCI support is disabled
v4: - add a sob tag
v3: - no changes
v2: - fix a typo in my e-mail address

 arch/mips/include/asm/mach-ath79/pci.h |   20 ++++++++++++++++++++
 arch/mips/pci/pci-ath724x.c            |    3 ++-
 2 files changed, 22 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-ath79/pci.h

diff --git a/arch/mips/include/asm/mach-ath79/pci.h b/arch/mips/include/asm/mach-ath79/pci.h
new file mode 100644
index 0000000..e0c4b53
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/pci.h
@@ -0,0 +1,20 @@
+/*
+ *  Atheros 724x PCI support
+ *
+ *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef __ASM_MACH_ATH79_PCI_H
+#define __ASM_MACH_ATH79_PCI_H
+
+#if defined(CONFIG_PCI) && defined(CONFIG_SOC_AR724X)
+int ath724x_pcibios_init(void);
+#else
+static inline int ath724x_pcibios_init(void) { return 0; }
+#endif
+
+#endif /* __ASM_MACH_ATH79_PCI_H */
diff --git a/arch/mips/pci/pci-ath724x.c b/arch/mips/pci/pci-ath724x.c
index 1e810be..be01b7f 100644
--- a/arch/mips/pci/pci-ath724x.c
+++ b/arch/mips/pci/pci-ath724x.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/pci.h>
+#include <asm/mach-ath79/pci.h>
 
 #define reg_read(_phys)		(*(unsigned int *) KSEG1ADDR(_phys))
 #define reg_write(_phys, _val)	((*(unsigned int *) KSEG1ADDR(_phys)) = (_val))
@@ -130,7 +131,7 @@ static struct pci_controller ath724x_pci_controller = {
 	.mem_resource	= &ath724x_mem_resource,
 };
 
-static int __init ath724x_pcibios_init(void)
+int __init ath724x_pcibios_init(void)
 {
 	register_pci_controller(&ath724x_pci_controller);
 
-- 
1.7.2.1
