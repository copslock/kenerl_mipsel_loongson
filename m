Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Feb 2013 13:41:20 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:45752 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816511Ab3BBMlSoSUbN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Feb 2013 13:41:18 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 0FD9225D27A;
        Sat,  2 Feb 2013 13:41:13 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zj6n4NGWraOw; Sat,  2 Feb 2013 13:41:12 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id B919B25D03A;
        Sat,  2 Feb 2013 13:41:07 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 1/5] MIPS: pci-ar724x: convert into a platform driver
Date:   Sat,  2 Feb 2013 13:40:42 +0100
Message-Id: <1359808846-23083-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35680
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

The patch converts the pci-ar724x driver into a
platform driver. This makes it possible to register
the PCI controller as a plain platform device.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Note:

In order to make the patch simple, the registration
of the corresponding platform device, and the removal
of the ar724x_pcibios_init function is implemented in
subsequent patches.
---
 arch/mips/pci/pci-ar724x.c |   57 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index c11c75b..e7aca88b 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -11,6 +11,8 @@
 
 #include <linux/irq.h>
 #include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include <asm/mach-ath79/pci.h>
@@ -262,7 +264,7 @@ static struct irq_chip ar724x_pci_irq_chip = {
 	.irq_mask_ack	= ar724x_pci_irq_mask,
 };
 
-static void __init ar724x_pci_irq_init(int irq)
+static void ar724x_pci_irq_init(int irq)
 {
 	void __iomem *base;
 	int i;
@@ -282,7 +284,7 @@ static void __init ar724x_pci_irq_init(int irq)
 	irq_set_chained_handler(irq, ar724x_pci_irq_handler);
 }
 
-int __init ar724x_pcibios_init(int irq)
+int ar724x_pcibios_init(int irq)
 {
 	int ret;
 
@@ -312,3 +314,54 @@ err_unmap_devcfg:
 err:
 	return ret;
 }
+
+static int ar724x_pci_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int irq;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl_base");
+	if (!res)
+		return -EINVAL;
+
+	ar724x_pci_ctrl_base = devm_request_and_ioremap(&pdev->dev, res);
+	if (ar724x_pci_ctrl_base == NULL)
+		return -EBUSY;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg_base");
+	if (!res)
+		return -EINVAL;
+
+	ar724x_pci_devcfg_base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!ar724x_pci_devcfg_base)
+		return -EBUSY;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -EINVAL;
+
+	ar724x_pci_link_up = ar724x_pci_check_link();
+	if (!ar724x_pci_link_up)
+		dev_warn(&pdev->dev, "PCIe link is down\n");
+
+	ar724x_pci_irq_init(irq);
+
+	register_pci_controller(&ar724x_pci_controller);
+
+	return 0;
+}
+
+static struct platform_driver ar724x_pci_driver = {
+	.probe = ar724x_pci_probe,
+	.driver = {
+		.name = "ar724x-pci",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init ar724x_pci_init(void)
+{
+	return platform_driver_register(&ar724x_pci_driver);
+}
+
+postcore_initcall(ar724x_pci_init);
-- 
1.7.10
