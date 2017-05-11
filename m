Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2017 08:19:10 +0200 (CEST)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:36354
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993423AbdEKGShsKpzK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 May 2017 08:18:37 +0200
Received: by mail-wm0-x241.google.com with SMTP id u65so4425333wmu.3
        for <linux-mips@linux-mips.org>; Wed, 10 May 2017 23:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sQkayJC+BIWc3JOzw6sJfNyRh1YNaA9FFPB6hKt6PhI=;
        b=zklg1m/R//mNwtqxEwiLcAv4RD+s0wgTOIXJ0kde79TXuLIO36NxDNoJQLVo4oJTRE
         KN2tVcUKgQChcYk7SYxt/JAWNpClJVhvXYBhteWcCFVQZYtuke896Pxs6bCw8OvFAZQh
         BIajNxEES2ARzX8zWVyGGrNUO+xqsPOO25PV2r/O7huZHfv1YfZ1QhPWswlIB5KSRD/U
         Zn4ytJ5zVM6nOCbor1B/9psxGATAP2tAB9zZm4zWOc8FazHzPY0iMynt9AT33uunG76E
         tmCBk+TKIqD/wczuZ+1wTY8Irq1g2fQ91utCLut96uVZoDDQ3hBx0Ka3LQfFF6UDDx6/
         5eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sQkayJC+BIWc3JOzw6sJfNyRh1YNaA9FFPB6hKt6PhI=;
        b=R5cPUbCvN/deC5aTiF8gNq20vb6/Jr7Wr+uanGTm5jk/0fn4bbIMCsDWNB9q5q4EuI
         nFtsSL3SkstQRzDJoUfeapeoQE+Sj5EqUa1HRKaHywhGvRMYkisBGQBkkDETpNCPcnyO
         RWv8RjCf/4dt37fdiiRJEcr648izep4G3HMYPYx1WtKizBGYi+I2taC+UOzG5wyYWB7F
         p3+4SfCCaHAqaQd8+Mx/n9tQ3AQQ0CJV6me2DwLjn1Gur6CGx0aH7g+EkO3dXtMlQPLD
         8ww0YYAchBKd8nKgbcv/tbjjvp5cEjS+s3LMoe8PUQN5eKGnrAX9H38m3dhBComVSDII
         +NAw==
X-Gm-Message-State: AODbwcChxfeMPFQNh09mLgcpqv50wyvl1jX//HvDVBf+aNG7A5h4oGHG
        qup908WBhPtUnQ==
X-Received: by 10.28.206.70 with SMTP id e67mr5397344wmg.37.1494483512443;
        Wed, 10 May 2017 23:18:32 -0700 (PDT)
Received: from desktop.wvd.kresin.me (p4FC0AE18.dip0.t-ipconnect.de. [79.192.174.24])
        by smtp.gmail.com with ESMTPSA id w68sm432052wrb.49.2017.05.10.23.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 May 2017 23:18:32 -0700 (PDT)
From:   Mathias Kresin <dev@kresin.me>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 2/2] MIPS: pci-ar724x: get PCIe controller out of reset
Date:   Thu, 11 May 2017 08:18:25 +0200
Message-Id: <1494483505-18609-2-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1494483505-18609-1-git-send-email-dev@kresin.me>
References: <1494483505-18609-1-git-send-email-dev@kresin.me>
Return-Path: <dev@kresin.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev@kresin.me
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

The ar724x pci driver expects the PCIe controller to be brought out of
reset by the bootloader.

At least the AVM Fritz 300E bootloader doesn't take care of releasing
the different PCIe controller related resets, which causes an endless
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
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |  3 ++
 arch/mips/pci/pci-ar724x.c                     | 42 ++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index d99ca86..c83d8cc 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -169,6 +169,9 @@
 #define AR724X_PLL_REG_CPU_CONFIG	0x00
 #define AR724X_PLL_REG_PCIE_CONFIG	0x10
 
+#define AR724X_PLL_REG_PCIE_CONFIG_PPL_BYPASS	BIT(16)
+#define AR724X_PLL_REG_PCIE_CONFIG_PPL_RESET	BIT(25)
+
 #define AR724X_PLL_FB_SHIFT		0
 #define AR724X_PLL_FB_MASK		0x3ff
 #define AR724X_PLL_REF_DIV_SHIFT	10
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 1e23c8d..39c54b3 100644
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
 
+#define AR724X_PCI_REG_APP		0x0
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
+	/* release PCIe host controller and PCIe PHY reset */
+	ath79_device_reset_clear(AR724X_RESET_PCIE);
+	ath79_device_reset_clear(AR724X_RESET_PCIE_PHY);
+
+	/* remove the reset of the PCIE PLL */
+	ppl = ath79_pll_rr(AR724X_PLL_REG_PCIE_CONFIG);
+	ppl &= ~AR724X_PLL_REG_PCIE_CONFIG_PPL_RESET;
+	ath79_pll_wr(AR724X_PLL_REG_PCIE_CONFIG, ppl);
+
+	/* release bypass for the PCIE PLL */
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
2.7.4
