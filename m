Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 16:21:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33344 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992471AbcHZOUbCz92n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 16:20:31 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B5E3340D05063;
        Fri, 26 Aug 2016 15:20:10 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 15:20:13 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH v2 07/19] usb: host: ehci-sead3: Remove SEAD-3 EHCI code
Date:   Fri, 26 Aug 2016 15:17:39 +0100
Message-ID: <20160826141751.13121-8-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826141751.13121-1-paul.burton@imgtec.com>
References: <20160826141751.13121-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The SEAD-3 board is now probing its EHCI controller using the generic
EHCI driver & its generic-ehci device tree binding. Remove the unused
SEAD-3 specific EHCI code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v2:
- New patch, removing SEAD-3 EHCI code instead of extending it

 drivers/usb/host/ehci-hcd.c   |   5 --
 drivers/usb/host/ehci-sead3.c | 185 ------------------------------------------
 2 files changed, 190 deletions(-)
 delete mode 100644 drivers/usb/host/ehci-sead3.c

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 1e5f529..0630648 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1308,11 +1308,6 @@ MODULE_LICENSE ("GPL");
 #define        PLATFORM_DRIVER         ehci_mv_driver
 #endif
 
-#ifdef CONFIG_MIPS_SEAD3
-#include "ehci-sead3.c"
-#define	PLATFORM_DRIVER		ehci_hcd_sead3_driver
-#endif
-
 static int __init ehci_hcd_init(void)
 {
 	int retval = 0;
diff --git a/drivers/usb/host/ehci-sead3.c b/drivers/usb/host/ehci-sead3.c
deleted file mode 100644
index 3d86cc2..0000000
--- a/drivers/usb/host/ehci-sead3.c
+++ /dev/null
@@ -1,185 +0,0 @@
-/*
- * MIPS CI13320A EHCI Host Controller driver
- * Based on "ehci-au1xxx.c" by K.Boge <karsten.boge@amd.com>
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
- * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- * for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/err.h>
-#include <linux/platform_device.h>
-
-static int ehci_sead3_setup(struct usb_hcd *hcd)
-{
-	int ret;
-	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
-
-	ehci->caps = hcd->regs + 0x100;
-
-#ifdef __BIG_ENDIAN
-	ehci->big_endian_mmio = 1;
-	ehci->big_endian_desc = 1;
-#endif
-
-	ret = ehci_setup(hcd);
-	if (ret)
-		return ret;
-
-	ehci->need_io_watchdog = 0;
-
-	/* Set burst length to 16 words. */
-	ehci_writel(ehci, 0x1010, &ehci->regs->reserved1[1]);
-
-	return ret;
-}
-
-const struct hc_driver ehci_sead3_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "SEAD-3 EHCI",
-	.hcd_priv_size		= sizeof(struct ehci_hcd),
-
-	/*
-	 * generic hardware linkage
-	 */
-	.irq			= ehci_irq,
-	.flags			= HCD_MEMORY | HCD_USB2 | HCD_BH,
-
-	/*
-	 * basic lifecycle operations
-	 *
-	 */
-	.reset			= ehci_sead3_setup,
-	.start			= ehci_run,
-	.stop			= ehci_stop,
-	.shutdown		= ehci_shutdown,
-
-	/*
-	 * managing i/o requests and associated device resources
-	 */
-	.urb_enqueue		= ehci_urb_enqueue,
-	.urb_dequeue		= ehci_urb_dequeue,
-	.endpoint_disable	= ehci_endpoint_disable,
-	.endpoint_reset		= ehci_endpoint_reset,
-
-	/*
-	 * scheduling support
-	 */
-	.get_frame_number	= ehci_get_frame,
-
-	/*
-	 * root hub support
-	 */
-	.hub_status_data	= ehci_hub_status_data,
-	.hub_control		= ehci_hub_control,
-	.bus_suspend		= ehci_bus_suspend,
-	.bus_resume		= ehci_bus_resume,
-	.relinquish_port	= ehci_relinquish_port,
-	.port_handed_over	= ehci_port_handed_over,
-
-	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
-};
-
-static int ehci_hcd_sead3_drv_probe(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd;
-	struct resource *res;
-	int ret;
-
-	if (usb_disabled())
-		return -ENODEV;
-
-	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
-		pr_debug("resource[1] is not IORESOURCE_IRQ");
-		return -ENOMEM;
-	}
-	hcd = usb_create_hcd(&ehci_sead3_hc_driver, &pdev->dev, "SEAD-3");
-	if (!hcd)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(hcd->regs)) {
-		ret = PTR_ERR(hcd->regs);
-		goto err1;
-	}
-	hcd->rsrc_start = res->start;
-	hcd->rsrc_len = resource_size(res);
-
-	/* Root hub has integrated TT. */
-	hcd->has_tt = 1;
-
-	ret = usb_add_hcd(hcd, pdev->resource[1].start,
-			  IRQF_SHARED);
-	if (ret == 0) {
-		platform_set_drvdata(pdev, hcd);
-		device_wakeup_enable(hcd->self.controller);
-		return ret;
-	}
-
-err1:
-	usb_put_hcd(hcd);
-	return ret;
-}
-
-static int ehci_hcd_sead3_drv_remove(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-
-	usb_remove_hcd(hcd);
-	usb_put_hcd(hcd);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int ehci_hcd_sead3_drv_suspend(struct device *dev)
-{
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
-	bool do_wakeup = device_may_wakeup(dev);
-
-	return ehci_suspend(hcd, do_wakeup);
-}
-
-static int ehci_hcd_sead3_drv_resume(struct device *dev)
-{
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
-
-	ehci_resume(hcd, false);
-	return 0;
-}
-
-static const struct dev_pm_ops sead3_ehci_pmops = {
-	.suspend	= ehci_hcd_sead3_drv_suspend,
-	.resume		= ehci_hcd_sead3_drv_resume,
-};
-
-#define SEAD3_EHCI_PMOPS (&sead3_ehci_pmops)
-
-#else
-#define SEAD3_EHCI_PMOPS NULL
-#endif
-
-static struct platform_driver ehci_hcd_sead3_driver = {
-	.probe		= ehci_hcd_sead3_drv_probe,
-	.remove		= ehci_hcd_sead3_drv_remove,
-	.shutdown	= usb_hcd_platform_shutdown,
-	.driver = {
-		.name	= "sead3-ehci",
-		.pm	= SEAD3_EHCI_PMOPS,
-	}
-};
-
-MODULE_ALIAS("platform:sead3-ehci");
-- 
2.9.3
