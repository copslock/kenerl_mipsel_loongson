Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 21:17:19 +0200 (CEST)
Received: from smtp-out-182.synserver.de ([212.40.180.182]:1577 "HELO
        smtp-out-182.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492621Ab0FBTOG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 21:14:06 +0200
Received: (qmail 31776 invoked by uid 0); 2 Jun 2010 19:13:09 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 31322
Received: from port-91163.pppoe.wtnet.de (HELO localhost.localdomain) [84.46.68.144]
  by 217.119.54.81 with SMTP; 2 Jun 2010 19:13:08 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        David Brownell <dbrownell@users.sourceforge.net>,
        linux-usb@vger.kernel.org
Subject: [RFC][PATCH 19/26] USB: Add JZ4740 ohci support
Date:   Wed,  2 Jun 2010 21:12:25 +0200
Message-Id: <1275505950-17334-3-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1275505397-16758-1-git-send-email-lars@metafoo.de>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
X-archive-position: 27027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1637

This patch adds ohci glue code for JZ4740 SoCs ohci module.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/Kconfig            |    1 +
 drivers/usb/host/ohci-hcd.c    |    5 +
 drivers/usb/host/ohci-jz4740.c |  264 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/ohci-jz4740.c

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 6a58cb1..39a6bfd 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -46,6 +46,7 @@ config USB_ARCH_HAS_OHCI
 	default y if PPC_MPC52xx
 	# MIPS:
 	default y if SOC_AU1X00
+	default y if MACH_JZ4740
 	# SH:
 	default y if CPU_SUBTYPE_SH7720
 	default y if CPU_SUBTYPE_SH7721
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index fc57655..05b071c 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1095,6 +1095,11 @@ MODULE_LICENSE ("GPL");
 #define TMIO_OHCI_DRIVER	ohci_hcd_tmio_driver
 #endif
 
+#ifdef CONFIG_MACH_JZ4740
+#include "ohci-jz4740.c"
+#define PLATFORM_DRIVER	ohci_hcd_jz4740_driver
+#endif
+
 #if	!defined(PCI_DRIVER) &&		\
 	!defined(PLATFORM_DRIVER) &&	\
 	!defined(OMAP1_PLATFORM_DRIVER) &&	\
diff --git a/drivers/usb/host/ohci-jz4740.c b/drivers/usb/host/ohci-jz4740.c
new file mode 100644
index 0000000..0371b17
--- /dev/null
+++ b/drivers/usb/host/ohci-jz4740.c
@@ -0,0 +1,264 @@
+
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/regulator/consumer.h>
+
+struct jz4740_ohci_hcd {
+	struct ohci_hcd ohci_hcd;
+
+	struct regulator *vbus;
+	bool vbus_enabled;
+	struct clk *clk;
+};
+
+static inline struct jz4740_ohci_hcd *hcd_to_jz4740_hcd(struct usb_hcd *hcd)
+{
+	return (struct jz4740_ohci_hcd *)(hcd->hcd_priv);
+}
+
+static inline struct usb_hcd *jz4740_hcd_to_hcd(struct jz4740_ohci_hcd *jz4740_ohci)
+{
+	return container_of((void *)jz4740_ohci, struct usb_hcd, hcd_priv);
+}
+
+static int ohci_jz4740_start(struct usb_hcd *hcd)
+{
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	int	ret;
+
+	ret = ohci_init(ohci);
+	if (ret < 0)
+		return ret;
+
+	ohci->num_ports = 1;
+
+	ret = ohci_run(ohci);
+	if (ret < 0) {
+		dev_err(hcd->self.controller, "Can not start %s",
+			hcd->self.bus_name);
+		ohci_stop(hcd);
+		return ret;
+	}
+	return 0;
+}
+
+static int ohci_jz4740_set_vbus_power(struct jz4740_ohci_hcd *jz4740_ohci,
+	bool enabled)
+{
+	int ret = 0;
+
+	if (!jz4740_ohci->vbus)
+		return 0;
+
+	if (enabled && !jz4740_ohci->vbus_enabled) {
+		ret = regulator_enable(jz4740_ohci->vbus);
+		if (ret)
+			dev_err(jz4740_hcd_to_hcd(jz4740_ohci)->self.controller,
+				"Could not power vbus\n");
+	} else if (!enabled && jz4740_ohci->vbus_enabled) {
+		ret = regulator_disable(jz4740_ohci->vbus);
+	}
+
+	if (ret == 0)
+		jz4740_ohci->vbus_enabled = enabled;
+
+	return ret;
+}
+
+static int ohci_jz4740_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
+	u16 wIndex, char *buf, u16 wLength)
+{
+	struct jz4740_ohci_hcd *jz4740_ohci = hcd_to_jz4740_hcd(hcd);
+	int ret;
+
+	switch (typeReq) {
+	case SetHubFeature:
+		if (wValue == USB_PORT_FEAT_POWER)
+			ret = ohci_jz4740_set_vbus_power(jz4740_ohci, true);
+		break;
+	case ClearHubFeature:
+		if (wValue == USB_PORT_FEAT_POWER)
+			ret = ohci_jz4740_set_vbus_power(jz4740_ohci, false);
+		break;
+	}
+
+	if (ret)
+		return ret;
+
+	return ohci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
+}
+
+
+static const struct hc_driver ohci_jz4740_hc_driver = {
+	.description =		hcd_name,
+	.product_desc =		"JZ4740 OHCI",
+	.hcd_priv_size =	sizeof(struct jz4740_ohci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq =			ohci_irq,
+	.flags =		HCD_USB11 | HCD_MEMORY,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.start =		ohci_jz4740_start,
+	.stop =			ohci_stop,
+	.shutdown =		ohci_shutdown,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue =		ohci_urb_enqueue,
+	.urb_dequeue =		ohci_urb_dequeue,
+	.endpoint_disable =	ohci_endpoint_disable,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number =	ohci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data =	ohci_hub_status_data,
+	.hub_control =		ohci_jz4740_hub_control,
+#ifdef	CONFIG_PM
+	.bus_suspend =		ohci_bus_suspend,
+	.bus_resume =		ohci_bus_resume,
+#endif
+	.start_port_reset =	ohci_start_port_reset,
+};
+
+
+static __devinit int jz4740_ohci_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct usb_hcd *hcd;
+	struct jz4740_ohci_hcd *jz4740_ohci;
+	struct resource *res;
+	int irq;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get platform resource\n");
+		return -ENOENT;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get platform irq\n");
+		return irq;
+	}
+
+	hcd = usb_create_hcd(&ohci_jz4740_hc_driver, &pdev->dev, "jz4740");
+	if (!hcd) {
+		dev_err(&pdev->dev, "Failed to create hcd.\n");
+		return -ENOMEM;
+	}
+
+	jz4740_ohci = hcd_to_jz4740_hcd(hcd);
+
+	res = request_mem_region(res->start, resource_size(res), hcd_name);
+
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to request mem region.\n");
+		ret = -EBUSY;
+		goto err_free;
+	}
+
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = resource_size(res);
+	hcd->regs = ioremap(res->start, resource_size(res));
+
+	if (!hcd->regs) {
+		dev_err(&pdev->dev, "Failed to ioremap registers.\n");
+		ret = -EBUSY;
+		goto err_release_mem;
+	}
+
+	jz4740_ohci->clk = clk_get(&pdev->dev, "uhc");
+	if (IS_ERR(jz4740_ohci->clk)) {
+		ret = PTR_ERR(jz4740_ohci->clk);
+		dev_err(&pdev->dev, "Failed to get clock: %d\n", ret);
+		goto err_iounmap;
+	}
+
+	jz4740_ohci->vbus = regulator_get(&pdev->dev, "vbus");
+	if (IS_ERR(jz4740_ohci->vbus))
+		jz4740_ohci->vbus = NULL;
+
+
+	clk_set_rate(jz4740_ohci->clk, 48000000);
+	clk_enable(jz4740_ohci->clk);
+	if (jz4740_ohci->vbus)
+		ohci_jz4740_set_vbus_power(jz4740_ohci, true);
+
+	platform_set_drvdata(pdev, hcd);
+
+	ohci_hcd_init(hcd_to_ohci(hcd));
+
+	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to add hcd: %d\n", ret);
+		goto err_disable;
+	}
+
+	return 0;
+
+err_disable:
+	platform_set_drvdata(pdev, NULL);
+	if (jz4740_ohci->vbus) {
+		regulator_disable(jz4740_ohci->vbus);
+		regulator_put(jz4740_ohci->vbus);
+	}
+	clk_disable(jz4740_ohci->clk);
+
+	clk_put(jz4740_ohci->clk);
+err_iounmap:
+	iounmap(hcd->regs);
+err_release_mem:
+	release_mem_region(res->start, resource_size(res));
+err_free:
+	usb_put_hcd(hcd);
+
+	return ret;
+}
+
+static __devexit int jz4740_ohci_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct jz4740_ohci_hcd *jz4740_ohci = hcd_to_jz4740_hcd(hcd);
+
+	usb_remove_hcd(hcd);
+
+	platform_set_drvdata(pdev, NULL);
+
+	if (jz4740_ohci->vbus) {
+		regulator_disable(jz4740_ohci->vbus);
+		regulator_put(jz4740_ohci->vbus);
+	}
+
+	clk_disable(jz4740_ohci->clk);
+	clk_put(jz4740_ohci->clk);
+
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+
+	usb_put_hcd(hcd);
+
+	return 0;
+}
+
+static struct platform_driver ohci_hcd_jz4740_driver = {
+	.probe = jz4740_ohci_probe,
+	.remove = __devexit_p(jz4740_ohci_remove),
+	.driver = {
+		.name = "jz4740-ohci",
+		.owner = THIS_MODULE,
+	},
+};
+
+MODULE_ALIAS("platfrom:jz4740-ohci");
-- 
1.5.6.5
