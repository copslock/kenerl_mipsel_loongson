Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 18:55:08 +0100 (CET)
Received: from sakura.staff.proxad.net ([213.228.1.107]:38434 "EHLO
        sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492441Ab0A3Ryo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2010 18:54:44 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 5CB46551083; Sat, 30 Jan 2010 18:54:44 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     David Brownell <dbrownell@users.sourceforge.net>,
        linux-usb@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 1/2] USB: add Broadcom 63xx integrated OHCI controller support.
Date:   Sat, 30 Jan 2010 18:54:30 +0100
Message-Id: <1264874071-28851-2-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1264874071-28851-1-git-send-email-mbizon@freebox.fr>
References: <1264874071-28851-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 25769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19487

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/usb/host/ohci-bcm63xx.c |  166 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/ohci-hcd.c     |    5 +
 drivers/usb/host/ohci.h         |    2 +-
 3 files changed, 172 insertions(+), 1 deletions(-)
 create mode 100644 drivers/usb/host/ohci-bcm63xx.c

diff --git a/drivers/usb/host/ohci-bcm63xx.c b/drivers/usb/host/ohci-bcm63xx.c
new file mode 100644
index 0000000..c9bccec
--- /dev/null
+++ b/drivers/usb/host/ohci-bcm63xx.c
@@ -0,0 +1,166 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_regs.h>
+#include <bcm63xx_io.h>
+
+static struct clk *usb_host_clock;
+
+static int __devinit ohci_bcm63xx_start(struct usb_hcd *hcd)
+{
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	int ret;
+
+        /*
+         * port 2 can be shared with USB slave, but all boards seem to
+         * have only one host port populated, so we can hardcode it
+         */
+	ohci->num_ports = 1;
+
+	ret = ohci_init(ohci);
+	if (ret < 0)
+		return ret;
+
+	ret = ohci_run(ohci);
+	if (ret < 0) {
+		err("can't start %s", hcd->self.bus_name);
+		ohci_stop(hcd);
+		return ret;
+	}
+	return 0;
+}
+
+static const struct hc_driver ohci_bcm63xx_hc_driver = {
+	.description =		hcd_name,
+	.product_desc =		"BCM63XX integrated OHCI controller",
+	.hcd_priv_size =	sizeof(struct ohci_hcd),
+
+	.irq =			ohci_irq,
+	.flags =		HCD_USB11 | HCD_MEMORY,
+	.start =		ohci_bcm63xx_start,
+	.stop =			ohci_stop,
+	.shutdown =		ohci_shutdown,
+	.urb_enqueue =		ohci_urb_enqueue,
+	.urb_dequeue =		ohci_urb_dequeue,
+	.endpoint_disable =	ohci_endpoint_disable,
+	.get_frame_number =	ohci_get_frame,
+	.hub_status_data =	ohci_hub_status_data,
+	.hub_control =		ohci_hub_control,
+	.start_port_reset =	ohci_start_port_reset,
+};
+
+static int __devinit ohci_hcd_bcm63xx_drv_probe(struct platform_device *pdev)
+{
+	struct resource *res_mem;
+	struct usb_hcd *hcd;
+	struct ohci_hcd *ohci;
+	u32 reg;
+	int ret, irq;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (!res_mem || irq < 0)
+		return -ENODEV;
+
+	if (BCMCPU_IS_6348()) {
+		struct clk *clk;
+		/* enable USB host clock */
+		clk = clk_get(&pdev->dev, "usbh");
+		if (IS_ERR(clk))
+			return -ENODEV;
+
+		clk_enable(clk);
+		usb_host_clock = clk;
+		bcm_rset_writel(RSET_OHCI_PRIV, 0, OHCI_PRIV_REG);
+
+	} else if (BCMCPU_IS_6358()) {
+		reg = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_SWAP_REG);
+		reg &= ~USBH_PRIV_SWAP_OHCI_ENDN_MASK;
+		reg |= USBH_PRIV_SWAP_OHCI_DATA_MASK;
+		bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SWAP_REG);
+		/*
+		 * The magic value comes for the original vendor BSP
+		 * and is needed for USB to work. Datasheet does not
+		 * help, so the magic value is used as-is.
+		 */
+		bcm_rset_writel(RSET_USBH_PRIV, 0x1c0020, USBH_PRIV_TEST_REG);
+	} else
+		return 0;
+
+	hcd = usb_create_hcd(&ohci_bcm63xx_hc_driver, &pdev->dev, "bcm63xx");
+	if (!hcd)
+		return -ENOMEM;
+	hcd->rsrc_start = res_mem->start;
+	hcd->rsrc_len = res_mem->end - res_mem->start + 1;
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		pr_debug("request_mem_region failed\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		pr_debug("ioremap failed\n");
+		ret = -EIO;
+		goto out1;
+	}
+
+	ohci = hcd_to_ohci(hcd);
+	ohci->flags |= OHCI_QUIRK_BE_MMIO | OHCI_QUIRK_BE_DESC |
+		OHCI_QUIRK_FRAME_NO;
+	ohci_hcd_init(ohci);
+
+	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED);
+	if (ret)
+		goto out2;
+
+	platform_set_drvdata(pdev, hcd);
+	return 0;
+
+out2:
+	iounmap(hcd->regs);
+out1:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+out:
+	usb_put_hcd(hcd);
+	return ret;
+}
+
+static int __devexit ohci_hcd_bcm63xx_drv_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+
+	hcd = platform_get_drvdata(pdev);
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	usb_put_hcd(hcd);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	if (usb_host_clock) {
+		clk_disable(usb_host_clock);
+		clk_put(usb_host_clock);
+	}
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static struct platform_driver ohci_hcd_bcm63xx_driver = {
+	.probe		= ohci_hcd_bcm63xx_drv_probe,
+	.remove		= __devexit_p(ohci_hcd_bcm63xx_drv_remove),
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver		= {
+		.name	= "bcm63xx_ohci",
+		.owner	= THIS_MODULE,
+	},
+};
+
+MODULE_ALIAS("platform:bcm63xx_ohci");
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 24eb747..1c82a60 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1051,6 +1051,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		usb_hcd_pnx4008_driver
 #endif
 
+#ifdef CONFIG_BCM63XX
+#include "ohci-bcm63xx.c"
+#define PLATFORM_DRIVER		ohci_hcd_bcm63xx_driver
+#endif
+
 #if defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
     defined(CONFIG_CPU_SUBTYPE_SH7763) || \
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index 5bf15fe..3c54d3e 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -655,7 +655,7 @@ static inline u32 hc32_to_cpup (const struct ohci_hcd *ohci, const __hc32 *x)
  * some big-endian SOC implementations.  Same thing happens with PSW access.
  */
 
-#ifdef CONFIG_PPC_MPC52xx
+#if defined(CONFIG_PPC_MPC52xx) || defined(CONFIG_BCM63XX)
 #define big_endian_frame_no_quirk(ohci)	(ohci->flags & OHCI_QUIRK_FRAME_NO)
 #else
 #define big_endian_frame_no_quirk(ohci)	0
-- 
1.6.3.3
