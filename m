Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2013 11:59:57 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:37445 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816288Ab3BCK74YQYH2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Feb 2013 11:59:56 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 2082625D3E0;
        Sun,  3 Feb 2013 11:59:51 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id avSQjbKzCxy1; Sun,  3 Feb 2013 11:59:51 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 41C7425C680;
        Sun,  3 Feb 2013 11:59:50 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 3/4] MIPS: pci-ar724x: remove static PCI IO/MEM resources
Date:   Sun,  3 Feb 2013 11:59:45 +0100
Message-Id: <1359889185-15779-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1359889120-15699-1-git-send-email-juhosg@openwrt.org>
References: <1359889120-15699-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35691
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

Static resources become impractical when multiple
PCI controllers are present. Move the resources
into the platform device registration code and
change the probe routine to get those from there
platform device's resources.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/pci.c      |   21 ++++++++++++++++++++-
 arch/mips/pci/pci-ar724x.c |   40 ++++++++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index d90e071..45d1112 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -139,10 +139,13 @@ static struct platform_device *
 ath79_register_pci_ar724x(int id,
 			  unsigned long cfg_base,
 			  unsigned long ctrl_base,
+			  unsigned long mem_base,
+			  unsigned long mem_size,
+			  unsigned long io_base,
 			  int irq)
 {
 	struct platform_device *pdev;
-	struct resource res[3];
+	struct resource res[5];
 
 	memset(res, 0, sizeof(res));
 
@@ -160,6 +163,16 @@ ath79_register_pci_ar724x(int id,
 	res[2].start = irq;
 	res[2].end = irq;
 
+	res[3].name = "mem_base";
+	res[3].flags = IORESOURCE_MEM;
+	res[3].start = mem_base;
+	res[3].end = mem_base + mem_size - 1;
+
+	res[4].name = "io_base";
+	res[4].flags = IORESOURCE_IO;
+	res[4].start = io_base;
+	res[4].end = io_base;
+
 	pdev = platform_device_register_simple("ar724x-pci", id,
 					       res, ARRAY_SIZE(res));
 	return pdev;
@@ -175,6 +188,9 @@ int __init ath79_register_pci(void)
 		pdev = ath79_register_pci_ar724x(-1,
 						 AR724X_PCI_CFG_BASE,
 						 AR724X_PCI_CTRL_BASE,
+						 AR724X_PCI_MEM_BASE,
+						 AR724X_PCI_MEM_SIZE,
+						 0,
 						 ATH79_CPU_IRQ_IP2);
 	} else if (soc_is_ar9342() ||
 		   soc_is_ar9344()) {
@@ -187,6 +203,9 @@ int __init ath79_register_pci(void)
 		pdev = ath79_register_pci_ar724x(-1,
 						 AR724X_PCI_CFG_BASE,
 						 AR724X_PCI_CTRL_BASE,
+						 AR724X_PCI_MEM_BASE,
+						 AR724X_PCI_MEM_SIZE,
+						 0,
 						 ATH79_IP2_IRQ(0));
 	} else {
 		/* No PCI support */
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 93ab877..d0d707d 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -42,6 +42,8 @@ struct ar724x_pci_controller {
 	spinlock_t lock;
 
 	struct pci_controller pci_controller;
+	struct resource io_res;
+	struct resource mem_res;
 };
 
 static inline bool ar724x_pci_check_link(struct ar724x_pci_controller *apc)
@@ -190,20 +192,6 @@ static struct pci_ops ar724x_pci_ops = {
 	.write	= ar724x_pci_write,
 };
 
-static struct resource ar724x_io_resource = {
-	.name   = "PCI IO space",
-	.start  = 0,
-	.end    = 0,
-	.flags  = IORESOURCE_IO,
-};
-
-static struct resource ar724x_mem_resource = {
-	.name   = "PCI memory space",
-	.start  = AR724X_PCI_MEM_BASE,
-	.end    = AR724X_PCI_MEM_BASE + AR724X_PCI_MEM_SIZE - 1,
-	.flags  = IORESOURCE_MEM,
-};
-
 static void ar724x_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	struct ar724x_pci_controller *apc;
@@ -331,9 +319,29 @@ static int ar724x_pci_probe(struct platform_device *pdev)
 
 	spin_lock_init(&apc->lock);
 
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
 	apc->pci_controller.pci_ops = &ar724x_pci_ops;
-	apc->pci_controller.io_resource = &ar724x_io_resource;
-	apc->pci_controller.mem_resource = &ar724x_mem_resource;
+	apc->pci_controller.io_resource = &apc->io_res;
+	apc->pci_controller.mem_resource = &apc->mem_res;
 
 	apc->link_up = ar724x_pci_check_link(apc);
 	if (!apc->link_up)
-- 
1.7.10
