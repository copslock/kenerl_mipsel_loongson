Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2012 08:57:33 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55370 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903413Ab2GVG42 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jul 2012 08:56:28 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 3/5] MIPS: lantiq: make use of new PCI clock helper
Date:   Sun, 22 Jul 2012 08:55:59 +0200
Message-Id: <1342940161-1421-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1342940161-1421-1-git-send-email-blogic@openwrt.org>
References: <1342940161-1421-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Make use of the new helper function that allows us to set the PCI clock delay
inside the PCI driver.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/pci/pci-lantiq.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 075d87a..dae4349 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -98,7 +98,7 @@ static inline u32 ltq_calc_bar11mask(void)
 static int __devinit ltq_pci_startup(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	const __be32 *req_mask, *bus_clk;
+	const __be32 *req_mask, *bus_clk, *delay;
 	u32 temp_buffer;
 
 	/* get our clocks */
@@ -127,6 +127,11 @@ static int __devinit ltq_pci_startup(struct platform_device *pdev)
 	else
 		clk_disable(clk_external);
 
+	/* pci ckl delay is a 6 bit value */
+	delay = of_get_property(node, "lantiq,delay", NULL);
+	if (delay)
+		ltq_pci_set_delay(*delay);
+
 	/* setup reset gpio used by pci */
 	reset_gpio = of_get_named_gpio(node, "gpio-reset", 0);
 	if (gpio_is_valid(reset_gpio))
-- 
1.7.9.1
