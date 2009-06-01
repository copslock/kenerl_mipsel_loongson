Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 18:10:26 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:42551 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025630AbZFARIc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 18:08:32 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 79C0F1124092; Mon,  1 Jun 2009 19:08:15 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH] bcm63xx: use platform_get_irq in ehci-bcm63xx.c
Date:	Mon,  1 Jun 2009 19:08:14 +0200
Message-Id: <1243876095-8987-9-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1243876095-8987-1-git-send-email-mbizon@freebox.fr>
References: <1243876095-8987-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

As requested by USB maintainer, use platform_get_irq instead of
platform_get_resource.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/usb/host/ehci-bcm63xx.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ehci-bcm63xx.c b/drivers/usb/host/ehci-bcm63xx.c
index 2fef571..0aba0f9 100644
--- a/drivers/usb/host/ehci-bcm63xx.c
+++ b/drivers/usb/host/ehci-bcm63xx.c
@@ -62,15 +62,15 @@ static const struct hc_driver ehci_bcm63xx_hc_driver = {
 
 static int __devinit ehci_hcd_bcm63xx_drv_probe(struct platform_device *pdev)
 {
-	struct resource *res_mem, *res_irq;
+	struct resource *res_mem;
 	struct usb_hcd *hcd;
 	struct ehci_hcd *ehci;
 	u32 reg;
-	int ret;
+	int ret, irq;
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res_mem || !res_irq)
+	irq = platform_get_irq(pdev, 0);;
+	if (!res_mem || irq < 0)
 		return -ENODEV;
 
 	reg = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_SWAP_REG);
@@ -109,7 +109,7 @@ static int __devinit ehci_hcd_bcm63xx_drv_probe(struct platform_device *pdev)
 	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
 	ehci->sbrn = 0x20;
 
-	ret = usb_add_hcd(hcd, res_irq->start, IRQF_DISABLED);
+	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED);
 	if (ret)
 		goto out2;
 
-- 
1.6.0.4
