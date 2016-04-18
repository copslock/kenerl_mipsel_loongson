Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 20:59:55 +0200 (CEST)
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53191 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026939AbcDRS7Yrc08g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 20:59:24 +0200
Received: from starbug-2.treewalker.org (unknown [IPv6:2a01:670:6a22:7000::1])
        (Authenticated sender: relay@treewalker.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E54F1A80DC;
        Mon, 18 Apr 2016 20:59:23 +0200 (CEST)
Received: from hyperion.trinair2002 (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.treewalker.org (Postfix) with ESMTP id 72A194319F;
        Mon, 18 Apr 2016 20:59:23 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH 3/3] USB: ohci-jz4740: Remove obsolete driver
Date:   Mon, 18 Apr 2016 20:58:53 +0200
Message-Id: <1461005933-24876-3-git-send-email-maarten@treewalker.org>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1461005933-24876-1-git-send-email-maarten@treewalker.org>
References: <1461005933-24876-1-git-send-email-maarten@treewalker.org>
Return-Path: <maarten@treewalker.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
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

The ohci-platform driver can control the clock, while usb-nop-xceiv
as the PHY can control the vbus regulator. So this JZ4740-specific
glue is not needed anymore.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
---
 drivers/usb/host/ohci-hcd.c    |   5 -
 drivers/usb/host/ohci-jz4740.c | 245 -----------------------------------------
 2 files changed, 250 deletions(-)
 delete mode 100644 drivers/usb/host/ohci-jz4740.c

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 04dcedf..0449235 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1245,11 +1245,6 @@ MODULE_LICENSE ("GPL");
 #define TMIO_OHCI_DRIVER	ohci_hcd_tmio_driver
 #endif
 
-#ifdef CONFIG_MACH_JZ4740
-#include "ohci-jz4740.c"
-#define PLATFORM_DRIVER	ohci_hcd_jz4740_driver
-#endif
-
 #ifdef CONFIG_TILE_USB
 #include "ohci-tilegx.c"
 #define PLATFORM_DRIVER		ohci_hcd_tilegx_driver
diff --git a/drivers/usb/host/ohci-jz4740.c b/drivers/usb/host/ohci-jz4740.c
deleted file mode 100644
index 4db78f1..0000000
--- a/drivers/usb/host/ohci-jz4740.c
+++ /dev/null
@@ -1,245 +0,0 @@
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/regulator/consumer.h>
-
-struct jz4740_ohci_hcd {
-	struct ohci_hcd ohci_hcd;
-
-	struct regulator *vbus;
-	bool vbus_enabled;
-	struct clk *clk;
-};
-
-static inline struct jz4740_ohci_hcd *hcd_to_jz4740_hcd(struct usb_hcd *hcd)
-{
-	return (struct jz4740_ohci_hcd *)(hcd->hcd_priv);
-}
-
-static inline struct usb_hcd *jz4740_hcd_to_hcd(struct jz4740_ohci_hcd *jz4740_ohci)
-{
-	return container_of((void *)jz4740_ohci, struct usb_hcd, hcd_priv);
-}
-
-static int ohci_jz4740_start(struct usb_hcd *hcd)
-{
-	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
-	int	ret;
-
-	ret = ohci_init(ohci);
-	if (ret < 0)
-		return ret;
-
-	ohci->num_ports = 1;
-
-	ret = ohci_run(ohci);
-	if (ret < 0) {
-		dev_err(hcd->self.controller, "Can not start %s",
-			hcd->self.bus_name);
-		ohci_stop(hcd);
-		return ret;
-	}
-	return 0;
-}
-
-static int ohci_jz4740_set_vbus_power(struct jz4740_ohci_hcd *jz4740_ohci,
-	bool enabled)
-{
-	int ret = 0;
-
-	if (!jz4740_ohci->vbus)
-		return 0;
-
-	if (enabled && !jz4740_ohci->vbus_enabled) {
-		ret = regulator_enable(jz4740_ohci->vbus);
-		if (ret)
-			dev_err(jz4740_hcd_to_hcd(jz4740_ohci)->self.controller,
-				"Could not power vbus\n");
-	} else if (!enabled && jz4740_ohci->vbus_enabled) {
-		ret = regulator_disable(jz4740_ohci->vbus);
-	}
-
-	if (ret == 0)
-		jz4740_ohci->vbus_enabled = enabled;
-
-	return ret;
-}
-
-static int ohci_jz4740_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
-	u16 wIndex, char *buf, u16 wLength)
-{
-	struct jz4740_ohci_hcd *jz4740_ohci = hcd_to_jz4740_hcd(hcd);
-	int ret = 0;
-
-	switch (typeReq) {
-	case SetPortFeature:
-		if (wValue == USB_PORT_FEAT_POWER)
-			ret = ohci_jz4740_set_vbus_power(jz4740_ohci, true);
-		break;
-	case ClearPortFeature:
-		if (wValue == USB_PORT_FEAT_POWER)
-			ret = ohci_jz4740_set_vbus_power(jz4740_ohci, false);
-		break;
-	}
-
-	if (ret)
-		return ret;
-
-	return ohci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
-}
-
-
-static const struct hc_driver ohci_jz4740_hc_driver = {
-	.description =		hcd_name,
-	.product_desc =		"JZ4740 OHCI",
-	.hcd_priv_size =	sizeof(struct jz4740_ohci_hcd),
-
-	/*
-	 * generic hardware linkage
-	 */
-	.irq =			ohci_irq,
-	.flags =		HCD_USB11 | HCD_MEMORY,
-
-	/*
-	 * basic lifecycle operations
-	 */
-	.start =		ohci_jz4740_start,
-	.stop =			ohci_stop,
-	.shutdown =		ohci_shutdown,
-
-	/*
-	 * managing i/o requests and associated device resources
-	 */
-	.urb_enqueue =		ohci_urb_enqueue,
-	.urb_dequeue =		ohci_urb_dequeue,
-	.endpoint_disable =	ohci_endpoint_disable,
-
-	/*
-	 * scheduling support
-	 */
-	.get_frame_number =	ohci_get_frame,
-
-	/*
-	 * root hub support
-	 */
-	.hub_status_data =	ohci_hub_status_data,
-	.hub_control =		ohci_jz4740_hub_control,
-#ifdef	CONFIG_PM
-	.bus_suspend =		ohci_bus_suspend,
-	.bus_resume =		ohci_bus_resume,
-#endif
-	.start_port_reset =	ohci_start_port_reset,
-};
-
-
-static int jz4740_ohci_probe(struct platform_device *pdev)
-{
-	int ret;
-	struct usb_hcd *hcd;
-	struct jz4740_ohci_hcd *jz4740_ohci;
-	struct resource *res;
-	int irq;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get platform irq\n");
-		return irq;
-	}
-
-	hcd = usb_create_hcd(&ohci_jz4740_hc_driver, &pdev->dev, "jz4740");
-	if (!hcd) {
-		dev_err(&pdev->dev, "Failed to create hcd.\n");
-		return -ENOMEM;
-	}
-
-	jz4740_ohci = hcd_to_jz4740_hcd(hcd);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(hcd->regs)) {
-		ret = PTR_ERR(hcd->regs);
-		goto err_free;
-	}
-	hcd->rsrc_start = res->start;
-	hcd->rsrc_len = resource_size(res);
-
-	jz4740_ohci->clk = devm_clk_get(&pdev->dev, "uhc");
-	if (IS_ERR(jz4740_ohci->clk)) {
-		ret = PTR_ERR(jz4740_ohci->clk);
-		dev_err(&pdev->dev, "Failed to get clock: %d\n", ret);
-		goto err_free;
-	}
-
-	jz4740_ohci->vbus = devm_regulator_get(&pdev->dev, "vbus");
-	if (IS_ERR(jz4740_ohci->vbus))
-		jz4740_ohci->vbus = NULL;
-
-
-	clk_set_rate(jz4740_ohci->clk, 48000000);
-	clk_enable(jz4740_ohci->clk);
-	if (jz4740_ohci->vbus)
-		ohci_jz4740_set_vbus_power(jz4740_ohci, true);
-
-	platform_set_drvdata(pdev, hcd);
-
-	ohci_hcd_init(hcd_to_ohci(hcd));
-
-	ret = usb_add_hcd(hcd, irq, 0);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to add hcd: %d\n", ret);
-		goto err_disable;
-	}
-	device_wakeup_enable(hcd->self.controller);
-
-	return 0;
-
-err_disable:
-	if (jz4740_ohci->vbus)
-		regulator_disable(jz4740_ohci->vbus);
-	clk_disable(jz4740_ohci->clk);
-
-err_free:
-	usb_put_hcd(hcd);
-
-	return ret;
-}
-
-static int jz4740_ohci_remove(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-	struct jz4740_ohci_hcd *jz4740_ohci = hcd_to_jz4740_hcd(hcd);
-
-	usb_remove_hcd(hcd);
-
-	if (jz4740_ohci->vbus)
-		regulator_disable(jz4740_ohci->vbus);
-
-	clk_disable(jz4740_ohci->clk);
-
-	usb_put_hcd(hcd);
-
-	return 0;
-}
-
-static struct platform_driver ohci_hcd_jz4740_driver = {
-	.probe = jz4740_ohci_probe,
-	.remove = jz4740_ohci_remove,
-	.driver = {
-		.name = "jz4740-ohci",
-	},
-};
-
-MODULE_ALIAS("platform:jz4740-ohci");
-- 
2.6.6
