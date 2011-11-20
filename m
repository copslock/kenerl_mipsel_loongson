Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Nov 2011 22:40:37 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:41492 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903616Ab1KTVjb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Nov 2011 22:39:31 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 7BF5B140469;
        Sun, 20 Nov 2011 22:39:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dbHz8waktawE; Sun, 20 Nov 2011 22:39:25 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 4E8FF140460;
        Sun, 20 Nov 2011 22:39:25 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Rene Bolldorf <xsecute@googlemail.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: =?UTF-8?q?=5BPATCH=20v3=203/7=5D=20MIPS=3A=20ath79=3A=20make=20ath724x=5Fpcibios=5Finit=20visible=20for=20external=20code?=
Date:   Sun, 20 Nov 2011 22:39:07 +0100
Message-Id: <1321825151-16053-4-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321825151-16053-1-git-send-email-juhosg@openwrt.org>
References: <1321825151-16053-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16769

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
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
