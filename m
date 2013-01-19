Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jan 2013 10:58:00 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:42362 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833246Ab3ASJ5GDszt3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Jan 2013 10:57:06 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH 4/5] MIPS: lantiq: improve pci reset gpio handling
Date:   Sat, 19 Jan 2013 10:54:26 +0100
Message-Id: <1358589267-11514-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358589267-11514-1-git-send-email-blogic@openwrt.org>
References: <1358589267-11514-1-git-send-email-blogic@openwrt.org>
X-archive-position: 35498
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

We need to make sure that the reset gpio is available and also set a sane
default state.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/pci/pci-lantiq.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 9568178..f32664b 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -129,8 +129,16 @@ static int ltq_pci_startup(struct platform_device *pdev)
 
 	/* setup reset gpio used by pci */
 	reset_gpio = of_get_named_gpio(node, "gpio-reset", 0);
-	if (gpio_is_valid(reset_gpio))
-		devm_gpio_request(&pdev->dev, reset_gpio, "pci-reset");
+	if (gpio_is_valid(reset_gpio)) {
+		int ret = devm_gpio_request(&pdev->dev,
+						reset_gpio, "pci-reset");
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to request gpio %d\n", reset_gpio);
+			return ret;
+		}
+		gpio_direction_output(reset_gpio, 1);
+	}
 
 	/* enable auto-switching between PCI and EBU */
 	ltq_pci_w32(0xa, PCI_CR_CLK_CTRL);
-- 
1.7.10.4
