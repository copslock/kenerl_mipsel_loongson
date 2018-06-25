Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2018 19:18:53 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:58000 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993001AbeFYRQDo0vZw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jun 2018 19:16:03 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Mathias Kresin <dev@kresin.me>
Subject: [PATCH 09/25] MIPS: ath79: get PCIe controller out of reset
Date:   Mon, 25 Jun 2018 19:15:33 +0200
Message-Id: <20180625171549.4618-10-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180625171549.4618-1-john@phrozen.org>
References: <20180625171549.4618-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

From: Mathias Kresin <dev@kresin.me>

The ar724x pci driver expects the PCIe controller to be brought out of
reset by the bootloader.

At least the AVM Fritz 300E bootloader doesn't take care of releasing
the different PCIe controller related resets which causes an endless
hang as soon as either the PCIE Reset register (0x180f0018) or the PCI
Application Control register (0x180f0000) is read from.

Do the full "PCIE Root Complex Initialization Sequence" if the PCIe
host controller is still in reset during probing.

The QCA u-boot sleeps 10ms after the PCIE Application Control bit is
set to ready. It has been shown that 10ms might not be enough time if
PCIe should be used right after setting the bit. During my tests it
took up to 20ms till the link was up. Giving the link up to 100ms
should work for all cases.

Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 arch/mips/pci/pci-ar724x.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 1e23c8d587bd..64b58cc48a91 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -12,14 +12,18 @@
 #include <linux/irq.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
 
+#define AR724X_PCI_REG_APP		0x00
 #define AR724X_PCI_REG_RESET		0x18
 #define AR724X_PCI_REG_INT_STATUS	0x4c
 #define AR724X_PCI_REG_INT_MASK		0x50
 
+#define AR724X_PCI_APP_LTSSM_ENABLE	BIT(0)
+
 #define AR724X_PCI_RESET_LINK_UP	BIT(0)
 
 #define AR724X_PCI_INT_DEV0		BIT(14)
@@ -325,6 +329,37 @@ static void ar724x_pci_irq_init(struct ar724x_pci_controller *apc,
 					 apc);
 }
 
+static void ar724x_pci_hw_init(struct ar724x_pci_controller *apc)
+{
+	u32 ppl, app;
+	int wait = 0;
+
+	/* deassert PCIe host controller and PCIe PHY reset */
+	ath79_device_reset_clear(AR724X_RESET_PCIE);
+	ath79_device_reset_clear(AR724X_RESET_PCIE_PHY);
+
+	/* remove the reset of the PCIE PLL */
+	ppl = ath79_pll_rr(AR724X_PLL_REG_PCIE_CONFIG);
+	ppl &= ~AR724X_PLL_REG_PCIE_CONFIG_PPL_RESET;
+	ath79_pll_wr(AR724X_PLL_REG_PCIE_CONFIG, ppl);
+
+	/* deassert bypass for the PCIE PLL */
+	ppl = ath79_pll_rr(AR724X_PLL_REG_PCIE_CONFIG);
+	ppl &= ~AR724X_PLL_REG_PCIE_CONFIG_PPL_BYPASS;
+	ath79_pll_wr(AR724X_PLL_REG_PCIE_CONFIG, ppl);
+
+	/* set PCIE Application Control to ready */
+	app = __raw_readl(apc->ctrl_base + AR724X_PCI_REG_APP);
+	app |= AR724X_PCI_APP_LTSSM_ENABLE;
+	__raw_writel(app, apc->ctrl_base + AR724X_PCI_REG_APP);
+
+	/* wait up to 100ms for PHY link up */
+	do {
+		mdelay(10);
+		wait++;
+	} while (wait < 10 && !ar724x_pci_check_link(apc));
+}
+
 static int ar724x_pci_probe(struct platform_device *pdev)
 {
 	struct ar724x_pci_controller *apc;
@@ -383,6 +418,13 @@ static int ar724x_pci_probe(struct platform_device *pdev)
 	apc->pci_controller.io_resource = &apc->io_res;
 	apc->pci_controller.mem_resource = &apc->mem_res;
 
+	/*
+	 * Do the full PCIE Root Complex Initialization Sequence if the PCIe
+	 * host controller is in reset.
+	 */
+	if (ath79_reset_rr(AR724X_RESET_REG_RESET_MODULE) & AR724X_RESET_PCIE)
+		ar724x_pci_hw_init(apc);
+
 	apc->link_up = ar724x_pci_check_link(apc);
 	if (!apc->link_up)
 		dev_warn(&pdev->dev, "PCIe link is down\n");
-- 
2.11.0
