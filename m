Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2013 21:28:50 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:53265 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827529Ab3BGU20Qx3oA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Feb 2013 21:28:26 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id C3B2025E1F1;
        Thu,  7 Feb 2013 21:28:19 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r8f-74oaVapo; Thu,  7 Feb 2013 21:28:19 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 85E2225E1FE;
        Thu,  7 Feb 2013 21:28:19 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 2/3] MIPS: pci-ar71xx: remove static PCI IO/MEM resources
Date:   Thu,  7 Feb 2013 21:28:15 +0100
Message-Id: <1360268896-13434-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1360268896-13434-1-git-send-email-juhosg@openwrt.org>
References: <1360268896-13434-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35722
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

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/pci.c      |   12 +++++++++++-
 arch/mips/pci/pci-ar71xx.c |   40 ++++++++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index 942e3f9..ea8aa10 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -117,7 +117,7 @@ static struct platform_device *
 ath79_register_pci_ar71xx(void)
 {
 	struct platform_device *pdev;
-	struct resource res[2];
+	struct resource res[4];
 
 	memset(res, 0, sizeof(res));
 
@@ -130,6 +130,16 @@ ath79_register_pci_ar71xx(void)
 	res[1].start = ATH79_CPU_IRQ_IP2;
 	res[1].end = ATH79_CPU_IRQ_IP2;
 
+	res[2].name = "io_base";
+	res[2].flags = IORESOURCE_IO;
+	res[2].start = 0;
+	res[2].end = 0;
+
+	res[3].name = "mem_base";
+	res[3].flags = IORESOURCE_MEM;
+	res[3].start = AR71XX_PCI_MEM_BASE;
+	res[3].end = AR71XX_PCI_MEM_BASE + AR71XX_PCI_MEM_SIZE - 1;
+
 	pdev = platform_device_register_simple("ar71xx-pci", -1,
 					       res, ARRAY_SIZE(res));
 	return pdev;
diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index 44dc5bf..e48dddb 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -53,6 +53,8 @@ struct ar71xx_pci_controller {
 	spinlock_t lock;
 	int irq;
 	struct pci_controller pci_ctrl;
+	struct resource io_res;
+	struct resource mem_res;
 };
 
 /* Byte lane enable bits */
@@ -234,20 +236,6 @@ static struct pci_ops ar71xx_pci_ops = {
 	.write	= ar71xx_pci_write_config,
 };
 
-static struct resource ar71xx_pci_io_resource = {
-	.name		= "PCI IO space",
-	.start		= 0,
-	.end		= 0,
-	.flags		= IORESOURCE_IO,
-};
-
-static struct resource ar71xx_pci_mem_resource = {
-	.name		= "PCI memory space",
-	.start		= AR71XX_PCI_MEM_BASE,
-	.end		= AR71XX_PCI_MEM_BASE + AR71XX_PCI_MEM_SIZE - 1,
-	.flags		= IORESOURCE_MEM
-};
-
 static void ar71xx_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	void __iomem *base = ath79_reset_base;
@@ -370,6 +358,26 @@ static int ar71xx_pci_probe(struct platform_device *pdev)
 	if (apc->irq < 0)
 		return -EINVAL;
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_IO, "io_base");
+	if (!res)
+		return -EINVAL;
+
+	apc->io_res.parent = res;
+	apc->io_res.name = "PCI IO space";
+	apc->io_res.start = res->start;
+	apc->io_res.end = res->end;
+	apc->io_res.flags = IORESOURCE_IO;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mem_base");
+	if (!res)
+		return -EINVAL;
+
+	apc->mem_res.parent = res;
+	apc->mem_res.name = "PCI memory space";
+	apc->mem_res.start = res->start;
+	apc->mem_res.end = res->end;
+	apc->mem_res.flags = IORESOURCE_MEM;
+
 	ar71xx_pci_reset();
 
 	/* setup COMMAND register */
@@ -383,8 +391,8 @@ static int ar71xx_pci_probe(struct platform_device *pdev)
 	ar71xx_pci_irq_init(apc);
 
 	apc->pci_ctrl.pci_ops = &ar71xx_pci_ops;
-	apc->pci_ctrl.mem_resource = &ar71xx_pci_mem_resource;
-	apc->pci_ctrl.io_resource = &ar71xx_pci_io_resource;
+	apc->pci_ctrl.mem_resource = &apc->mem_res;
+	apc->pci_ctrl.io_resource = &apc->io_res;
 
 	register_pci_controller(&apc->pci_ctrl);
 
-- 
1.7.10
