Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Feb 2013 13:41:37 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:45756 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827471Ab3BBMl2cbTAb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Feb 2013 13:41:28 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 6A4FD25D27A;
        Sat,  2 Feb 2013 13:41:23 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MuFi7mqAVhSe; Sat,  2 Feb 2013 13:41:23 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 6B8C025D03A;
        Sat,  2 Feb 2013 13:41:13 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 2/5] MIPS: pci-ar71xx: convert into a platform driver
Date:   Sat,  2 Feb 2013 13:40:43 +0100
Message-Id: <1359808846-23083-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1359808846-23083-1-git-send-email-juhosg@openwrt.org>
References: <1359808846-23083-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35681
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

The patch converts the pci-ar71xx driver into a
platform driver. This makes it possible to register
the PCI controller as a plain platform device.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Note:

In order to make the patch simple, the registration
of the corresponding platform device, and the removal
of the ar71xx_pcibios_init function is implemented in
subsequent patches.
---
 arch/mips/pci/pci-ar71xx.c |   60 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index 6eaa4f2..0d8412f 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -18,6 +18,8 @@
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include <asm/mach-ath79/ath79.h>
@@ -309,7 +311,7 @@ static struct irq_chip ar71xx_pci_irq_chip = {
 	.irq_mask_ack	= ar71xx_pci_irq_mask,
 };
 
-static __init void ar71xx_pci_irq_init(void)
+static void ar71xx_pci_irq_init(int irq)
 {
 	void __iomem *base = ath79_reset_base;
 	int i;
@@ -324,10 +326,10 @@ static __init void ar71xx_pci_irq_init(void)
 		irq_set_chip_and_handler(i, &ar71xx_pci_irq_chip,
 					 handle_level_irq);
 
-	irq_set_chained_handler(ATH79_CPU_IRQ_IP2, ar71xx_pci_irq_handler);
+	irq_set_chained_handler(irq, ar71xx_pci_irq_handler);
 }
 
-static __init void ar71xx_pci_reset(void)
+static void ar71xx_pci_reset(void)
 {
 	void __iomem *ddr_base = ath79_ddr_base;
 
@@ -367,9 +369,59 @@ __init int ar71xx_pcibios_init(void)
 	/* clear bus errors */
 	ar71xx_pci_check_error(1);
 
-	ar71xx_pci_irq_init();
+	ar71xx_pci_irq_init(ATH79_CPU_IRQ_IP2);
 
 	register_pci_controller(&ar71xx_pci_controller);
 
 	return 0;
 }
+
+static int ar71xx_pci_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int irq;
+	u32 t;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg_base");
+	if (!res)
+		return -EINVAL;
+
+	ar71xx_pcicfg_base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!ar71xx_pcicfg_base)
+		return -ENOMEM;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -EINVAL;
+
+	ar71xx_pci_reset();
+
+	/* setup COMMAND register */
+	t = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE
+	  | PCI_COMMAND_PARITY | PCI_COMMAND_SERR | PCI_COMMAND_FAST_BACK;
+	ar71xx_pci_local_write(PCI_COMMAND, 4, t);
+
+	/* clear bus errors */
+	ar71xx_pci_check_error(1);
+
+	ar71xx_pci_irq_init(irq);
+
+	register_pci_controller(&ar71xx_pci_controller);
+
+	return 0;
+}
+
+static struct platform_driver ar71xx_pci_driver = {
+	.probe = ar71xx_pci_probe,
+	.driver = {
+		.name = "ar71xx-pci",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init ar71xx_pci_init(void)
+{
+	return platform_driver_register(&ar71xx_pci_driver);
+}
+
+postcore_initcall(ar71xx_pci_init);
-- 
1.7.10
