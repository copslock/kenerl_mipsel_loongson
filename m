Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:35:20 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36890 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903687Ab2BQKdU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:33:20 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 5/6] MIPS: lantiq: convert pci to managed gpio
Date:   Fri, 17 Feb 2012 11:32:50 +0100
Message-Id: <1329474771-20874-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1329474771-20874-1-git-send-email-blogic@openwrt.org>
References: <1329474771-20874-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

ltq_gpio_request() now uses devres to manage the gpios. We need to pass a
struct device pointer to make it work.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/pci/pci-lantiq.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 3bf42c8..47b5d8e 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -150,24 +150,26 @@ static u32 ltq_calc_bar11mask(void)
 	return bar11mask;
 }
 
-static void ltq_pci_setup_gpio(int gpio)
+static void ltq_pci_setup_gpio(struct device *dev)
 {
+	struct ltq_pci_data *conf = (struct ltq_pci_data *) dev->platform_data;
 	int i;
 	for (i = 0; i < ARRAY_SIZE(ltq_pci_gpio_map); i++) {
-		if (gpio & (1 << i)) {
-			ltq_gpio_request(ltq_pci_gpio_map[i].pin,
+		if (conf->gpio & (1 << i)) {
+			ltq_gpio_request(dev, ltq_pci_gpio_map[i].pin,
 				ltq_pci_gpio_map[i].mux,
 				ltq_pci_gpio_map[i].dir,
 				ltq_pci_gpio_map[i].name);
 		}
 	}
-	ltq_gpio_request(21, 0, 1, "pci-reset");
-	ltq_pci_req_mask = (gpio >> PCI_REQ_SHIFT) & PCI_REQ_MASK;
+	ltq_gpio_request(dev, 21, 0, 1, "pci-reset");
+	ltq_pci_req_mask = (conf->gpio >> PCI_REQ_SHIFT) & PCI_REQ_MASK;
 }
 
-static int __devinit ltq_pci_startup(struct ltq_pci_data *conf)
+static int __devinit ltq_pci_startup(struct device *dev)
 {
 	u32 temp_buffer;
+	struct ltq_pci_data *conf = (struct ltq_pci_data *) dev->platform_data;
 
 	/* set clock to 33Mhz */
 	if (ltq_is_ar9()) {
@@ -190,7 +192,7 @@ static int __devinit ltq_pci_startup(struct ltq_pci_data *conf)
 	}
 
 	/* setup pci clock and gpis used by pci */
-	ltq_pci_setup_gpio(conf->gpio);
+	ltq_pci_setup_gpio(dev);
 
 	/* enable auto-switching between PCI and EBU */
 	ltq_pci_w32(0xa, PCI_CR_CLK_CTRL);
@@ -275,7 +277,7 @@ static int __devinit ltq_pci_probe(struct platform_device *pdev)
 		ioremap_nocache(LTQ_PCI_CFG_BASE, LTQ_PCI_CFG_BASE);
 	ltq_pci_controller.io_map_base =
 		(unsigned long)ioremap(LTQ_PCI_IO_BASE, LTQ_PCI_IO_SIZE - 1);
-	ltq_pci_startup(ltq_pci_data);
+	ltq_pci_startup(&pdev->dev);
 	register_pci_controller(&ltq_pci_controller);
 
 	return 0;
-- 
1.7.7.1
