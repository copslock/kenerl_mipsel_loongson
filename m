Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Feb 2013 13:46:09 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:45836 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827475Ab3BBMqI260bt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Feb 2013 13:46:08 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 558FA25D27C;
        Sat,  2 Feb 2013 13:46:03 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fOikWnNzS1bT; Sat,  2 Feb 2013 13:46:03 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id AE10B25D03A;
        Sat,  2 Feb 2013 13:46:02 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: =?UTF-8?q?=5BPATCH=205/5=5D=20MIPS=3A=20ath79=3A=20remove=20unused=20ar7=7B1x=2C24=7Dx=5Fpcibios=5Finit=20functions?=
Date:   Sat,  2 Feb 2013 13:45:57 +0100
Message-Id: <1359809157-23430-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1359808846-23083-1-git-send-email-juhosg@openwrt.org>
References: <1359808846-23083-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 35684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The functions are unused now, so remove them.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/pci.c                  |    1 -
 arch/mips/include/asm/mach-ath79/pci.h |   28 ----------------------------
 arch/mips/pci/pci-ar71xx.c             |   26 --------------------------
 arch/mips/pci/pci-ar724x.c             |   32 --------------------------------
 4 files changed, 87 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-ath79/pci.h

diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index 81ef579..c94bcec 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -19,7 +19,6 @@
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/irq.h>
-#include <asm/mach-ath79/pci.h>
 #include "pci.h"
 
 static int (*ath79_pci_plat_dev_init)(struct pci_dev *dev);
diff --git a/arch/mips/include/asm/mach-ath79/pci.h b/arch/mips/include/asm/mach-ath79/pci.h
deleted file mode 100644
index 7868f7f..0000000
--- a/arch/mips/include/asm/mach-ath79/pci.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *  Atheros AR71XX/AR724X PCI support
- *
- *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
- *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#ifndef __ASM_MACH_ATH79_PCI_H
-#define __ASM_MACH_ATH79_PCI_H
-
-#if defined(CONFIG_PCI) && defined(CONFIG_SOC_AR71XX)
-int ar71xx_pcibios_init(void);
-#else
-static inline int ar71xx_pcibios_init(void) { return 0; }
-#endif
-
-#if defined(CONFIG_PCI_AR724X)
-int ar724x_pcibios_init(int irq);
-#else
-static inline int ar724x_pcibios_init(int irq) { return 0; }
-#endif
-
-#endif /* __ASM_MACH_ATH79_PCI_H */
diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index 35ee234..69e0bb4 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -23,7 +23,6 @@
 
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include <asm/mach-ath79/ath79.h>
-#include <asm/mach-ath79/pci.h>
 
 #define AR71XX_PCI_REG_CRP_AD_CBE	0x00
 #define AR71XX_PCI_REG_CRP_WRDATA	0x04
@@ -335,31 +334,6 @@ static void ar71xx_pci_reset(void)
 	mdelay(100);
 }
 
-__init int ar71xx_pcibios_init(void)
-{
-	u32 t;
-
-	ar71xx_pcicfg_base = ioremap(AR71XX_PCI_CFG_BASE, AR71XX_PCI_CFG_SIZE);
-	if (ar71xx_pcicfg_base == NULL)
-		return -ENOMEM;
-
-	ar71xx_pci_reset();
-
-	/* setup COMMAND register */
-	t = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE
-	  | PCI_COMMAND_PARITY | PCI_COMMAND_SERR | PCI_COMMAND_FAST_BACK;
-	ar71xx_pci_local_write(PCI_COMMAND, 4, t);
-
-	/* clear bus errors */
-	ar71xx_pci_check_error(1);
-
-	ar71xx_pci_irq_init(ATH79_CPU_IRQ_IP2);
-
-	register_pci_controller(&ar71xx_pci_controller);
-
-	return 0;
-}
-
 static int ar71xx_pci_probe(struct platform_device *pdev)
 {
 	struct resource *res;
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index b3f9d09..8f008d9 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -15,7 +15,6 @@
 #include <linux/platform_device.h>
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
-#include <asm/mach-ath79/pci.h>
 
 #define AR724X_PCI_REG_RESET		0x18
 #define AR724X_PCI_REG_INT_STATUS	0x4c
@@ -276,37 +275,6 @@ static void ar724x_pci_irq_init(int irq)
 	irq_set_chained_handler(irq, ar724x_pci_irq_handler);
 }
 
-int ar724x_pcibios_init(int irq)
-{
-	int ret;
-
-	ret = -ENOMEM;
-
-	ar724x_pci_devcfg_base = ioremap(AR724X_PCI_CFG_BASE,
-					 AR724X_PCI_CFG_SIZE);
-	if (ar724x_pci_devcfg_base == NULL)
-		goto err;
-
-	ar724x_pci_ctrl_base = ioremap(AR724X_PCI_CTRL_BASE,
-				       AR724X_PCI_CTRL_SIZE);
-	if (ar724x_pci_ctrl_base == NULL)
-		goto err_unmap_devcfg;
-
-	ar724x_pci_link_up = ar724x_pci_check_link();
-	if (!ar724x_pci_link_up)
-		pr_warn("ar724x: PCIe link is down\n");
-
-	ar724x_pci_irq_init(irq);
-	register_pci_controller(&ar724x_pci_controller);
-
-	return PCIBIOS_SUCCESSFUL;
-
-err_unmap_devcfg:
-	iounmap(ar724x_pci_devcfg_base);
-err:
-	return ret;
-}
-
 static int ar724x_pci_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-- 
1.7.10
