Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 16:23:01 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:36004 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904117Ab1KRPW2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 16:22:28 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 6840E140501;
        Fri, 18 Nov 2011 16:22:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nLPqkl3gavHr; Fri, 18 Nov 2011 16:22:22 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 481CF1404F7;
        Fri, 18 Nov 2011 16:22:22 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Rene Bolldorf <xsecute@googlemail.com>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>,
        Gabor Juhos <juhsog@openwrt.org>
Subject: =?UTF-8?q?=5BPATCH=203/7=5D=20MIPS=3A=20ath79=3A=20make=20ath724x=5Fpcibios=5Finit=20visible=20for=20external=20code?=
Date:   Fri, 18 Nov 2011 16:21:56 +0100
Message-Id: <1321629720-29035-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321629720-29035-1-git-send-email-juhosg@openwrt.org>
References: <1321629720-29035-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15529

Signed-off-by: Gabor Juhos <juhsog@openwrt.org>
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
