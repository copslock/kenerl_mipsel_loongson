Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 16:08:21 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:44837 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903766Ab1KUPHU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 16:07:20 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 9FC64140453;
        Mon, 21 Nov 2011 16:07:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Tl3SiyIPukxS; Mon, 21 Nov 2011 16:07:15 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 6DB7914020F;
        Mon, 21 Nov 2011 16:06:56 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Rene Bolldorf <xsecute@googlemail.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v4 3/7] MIPS: ath79: make ath724x_pcibios_init visible for external code
Date:   Mon, 21 Nov 2011 16:06:35 +0100
Message-Id: <1321887999-14546-4-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321887999-14546-1-git-send-email-juhosg@openwrt.org>
References: <1321887999-14546-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17385

Signed-off-by: René Bolldorf <xsecute@googlemail.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v4: - add a sob tag
v3: - no changes
v2: - fix a typo in my e-mail address
---
 arch/mips/include/asm/mach-ath79/pci.h |   20 ++++++++++++++++++++
 arch/mips/pci/pci-ath724x.c            |    3 ++-
 2 files changed, 22 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-ath79/pci.h

diff --git a/arch/mips/include/asm/mach-ath79/pci.h b/arch/mips/include/asm/mach-ath79/pci.h
new file mode 100644
index 0000000..7ef8a49
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
+static inline int ath724x_pcibios_init(void) { return 0 };
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
