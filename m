Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Feb 2013 13:45:16 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:45817 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827471Ab3BBMo5Rre8Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Feb 2013 13:44:57 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 2554325D27E;
        Sat,  2 Feb 2013 13:44:52 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rulRCVM7WJyn; Sat,  2 Feb 2013 13:44:52 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 6483425D27A;
        Sat,  2 Feb 2013 13:44:51 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 4/5] MIPS: ath79: register platform devices for the PCI controllers
Date:   Sat,  2 Feb 2013 13:44:24 +0100
Message-Id: <1359809064-23253-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1359809064-23253-1-git-send-email-juhosg@openwrt.org>
References: <1359808846-23083-1-git-send-email-juhosg@openwrt.org>
 <1359809064-23253-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35683
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

The pci-ar71xx and pci-ar724x drivers were converted
into platform drivers. Register the corresponding
platform devices for the PCI controllers instead
of using the ar7{1x,24}x_pcibios_init functions.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/pci.c |   87 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index ca83abd..81ef579 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -14,6 +14,8 @@
 
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/resource.h>
+#include <linux/platform_device.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/irq.h>
@@ -110,21 +112,88 @@ void __init ath79_pci_set_plat_dev_init(int (*func)(struct pci_dev *dev))
 	ath79_pci_plat_dev_init = func;
 }
 
-int __init ath79_register_pci(void)
+static struct platform_device *
+ath79_register_pci_ar71xx(void)
+{
+	struct platform_device *pdev;
+	struct resource res[2];
+
+	memset(res, 0, sizeof(res));
+
+	res[0].name = "cfg_base";
+	res[0].flags = IORESOURCE_MEM;
+	res[0].start = AR71XX_PCI_CFG_BASE;
+	res[0].end = AR71XX_PCI_CFG_BASE + AR71XX_PCI_CFG_SIZE - 1;
+
+	res[1].flags = IORESOURCE_IRQ;
+	res[1].start = ATH79_CPU_IRQ_IP2;
+	res[1].end = ATH79_CPU_IRQ_IP2;
+
+	pdev = platform_device_register_simple("ar71xx-pci", -1,
+					       res, ARRAY_SIZE(res));
+	return pdev;
+}
+
+static struct platform_device *
+ath79_register_pci_ar724x(int id,
+			  unsigned long cfg_base,
+			  unsigned long ctrl_base,
+			  int irq)
 {
-	if (soc_is_ar71xx())
-		return ar71xx_pcibios_init();
+	struct platform_device *pdev;
+	struct resource res[3];
 
-	if (soc_is_ar724x())
-		return ar724x_pcibios_init(ATH79_CPU_IRQ_IP2);
+	memset(res, 0, sizeof(res));
 
-	if (soc_is_ar9342() || soc_is_ar9344()) {
+	res[0].name = "cfg_base";
+	res[0].flags = IORESOURCE_MEM;
+	res[0].start = cfg_base;
+	res[0].end = cfg_base + AR724X_PCI_CFG_SIZE - 1;
+
+	res[1].name = "ctrl_base";
+	res[1].flags = IORESOURCE_MEM;
+	res[1].start = ctrl_base;
+	res[1].end = ctrl_base + AR724X_PCI_CTRL_SIZE - 1;
+
+	res[2].flags = IORESOURCE_IRQ;
+	res[2].start = irq;
+	res[2].end = irq;
+
+	pdev = platform_device_register_simple("ar724x-pci", id,
+					       res, ARRAY_SIZE(res));
+	return pdev;
+}
+
+int __init ath79_register_pci(void)
+{
+	struct platform_device *pdev = NULL;
+
+	if (soc_is_ar71xx()) {
+		pdev = ath79_register_pci_ar71xx();
+	} else if (soc_is_ar724x()) {
+		pdev = ath79_register_pci_ar724x(-1,
+						 AR724X_PCI_CFG_BASE,
+						 AR724X_PCI_CTRL_BASE,
+						 ATH79_CPU_IRQ_IP2);
+	} else if (soc_is_ar9342() ||
+		   soc_is_ar9344()) {
 		u32 bootstrap;
 
 		bootstrap = ath79_reset_rr(AR934X_RESET_REG_BOOTSTRAP);
-		if (bootstrap & AR934X_BOOTSTRAP_PCIE_RC)
-			return ar724x_pcibios_init(ATH79_IP2_IRQ(0));
+		if ((bootstrap & AR934X_BOOTSTRAP_PCIE_RC) == 0)
+			return -ENODEV;
+
+		pdev = ath79_register_pci_ar724x(-1,
+						 AR724X_PCI_CFG_BASE,
+						 AR724X_PCI_CTRL_BASE,
+						 ATH79_IP2_IRQ(0));
+	} else {
+		/* No PCI support */
+		return -ENODEV;
 	}
 
-	return -ENODEV;
+	if (!pdev)
+		pr_err("unable to register PCI controller device\n");
+
+	return pdev ? 0 : -ENODEV;
 }
-- 
1.7.10
