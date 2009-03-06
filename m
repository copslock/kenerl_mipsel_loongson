Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2009 16:22:27 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:35445 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S21366481AbZCFQUU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2009 16:20:20 +0000
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Mar 2009 08:20:09 -0800
Received: from localhost.localdomain (unknown [10.8.0.23])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id D70F6EE76AB;
	Fri,  6 Mar 2009 09:42:10 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Kevin Hickey <khickey@rmicorp.com>
Subject: [PATCH 06/10] Alchemy: Au1300 USB support
Date:	Fri,  6 Mar 2009 10:20:05 -0600
Message-Id: <7e632686ab9b29a94eefeb2e5dca8b091a956b95.1236354153.git.khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <394c116b9fa5bd1865ac21d11185f09e07bd2ab5.1236354153.git.khickey@rmicorp.com>
References: <>
 <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
 <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
 <0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
 <7afc5c84989c4bc0f94181397369f284f2bb6924.1236354153.git.khickey@rmicorp.com>
 <0946334bbaf9883076889fe060a362b72d31e6f4.1236354153.git.khickey@rmicorp.com>
 <394c116b9fa5bd1865ac21d11185f09e07bd2ab5.1236354153.git.khickey@rmicorp.com>
In-Reply-To: <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
References: <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
X-OriginalArrivalTime: 06 Mar 2009 16:20:09.0887 (UTC) FILETIME=[6B83DAF0:01C99E77]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

Adds support for USB 2.0 on the Au1300 SOC.

Signed-off-by: Kevin Hickey <khickey@rmicorp.com>
---
 drivers/usb/Kconfig            |    1 +
 drivers/usb/host/ehci-au13xx.c |  213 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/ehci-hcd.c    |    5 +
 3 files changed, 219 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/ehci-au13xx.c

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 83babb0..a50d053 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -55,6 +55,7 @@ config USB_ARCH_HAS_EHCI
 	boolean
 	default y if PPC_83xx
 	default y if SOC_AU1200
+	default y if SOC_AU13XX
 	default y if ARCH_IXP4XX
 	default PCI

diff --git a/drivers/usb/host/ehci-au13xx.c b/drivers/usb/host/ehci-au13xx.c
new file mode 100644
index 0000000..fe03667
--- /dev/null
+++ b/drivers/usb/host/ehci-au13xx.c
@@ -0,0 +1,213 @@
+/*
+ * Copyright 2008 RMI Corporation
+ * Author: Kevin Hickey <khickey@rmicorp.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *  Based on ehci-au1xxx.c.
+ */
+
+#include <linux/platform_device.h>
+#include <asm/mach-au1x00/au1000.h>
+
+
+extern int usb_disabled(void);
+
+static void au13xx_start_ehc(void)
+{
+	AU13XX_USB* au13xx_usb = (AU13XX_USB*)(KSEG1 | USB_BASE_PHYS_ADDR);
+	/*
+	 * Enable clocks.
+	 */
+	AU_SET_BITS_32(USB_DWC_CTRL3_EHC_CLKEN, &au13xx_usb->dwc_ctrl3);
+
+	/*
+	 * Take the host controller block out of reset
+	 */
+	AU_SET_BITS_32(USB_DWC_CTRL1_HSTRS, &au13xx_usb->dwc_ctrl1);
+
+	/*
+	 * Enable all of the PHYs
+	 */
+	AU_SET_BITS_32(USB_DWC_CTRL2_PHYRS | USB_DWC_CTRL2_PHY0RS | USB_DWC_CTRL2_PH1RS,
+		       &au13xx_usb->dwc_ctrl2);
+
+	/*
+	 * Enable interrupts
+	 */
+	AU_SET_BITS_32(USB_INTR_EHCI, &au13xx_usb->intr_enable);
+
+	/*
+	 * This bit enables coherent DMA.
+	 */
+	AU_SET_BITS_32(USB_SBUS_CTRL_SBCA, &au13xx_usb->sbus_ctrl);
+	asm("sync");
+}
+
+static void au13xx_stop_ehc(void)
+{
+	AU13XX_USB* au13xx_usb = (AU13XX_USB*)(KSEG1 | USB_BASE_PHYS_ADDR);
+	/*
+	 * Disable the EHCI interrupt
+	 */
+	AU_CLEAR_BITS_32(USB_INTR_EHCI, &au13xx_usb->intr_enable);
+
+	/*
+	 * Disable the clock to the EHCI block
+	 */
+	AU_CLEAR_BITS_32(USB_DWC_CTRL3_EHC_CLKEN, &au13xx_usb->dwc_ctrl3);
+
+	/*
+	 * Note: we're not disabling the PHY here because the OHCI and EHCI
+	 * drivers share a PHY and the OHCI driver may still be active.
+	 */
+}
+
+static const struct hc_driver ehci_au13xx_hc_driver = {
+	.description		= hcd_name,
+	.product_desc		= "Au13xx EHCI",
+	.hcd_priv_size		= sizeof(struct ehci_hcd),
+
+	/*
+	 * generic hardware linkage
+	 */
+	.irq			= ehci_irq,
+	.flags			= HCD_MEMORY | HCD_USB2,
+
+	/*
+	 * basic lifecycle operations
+	 */
+	.reset			= ehci_init,
+	.start			= ehci_run,
+	.stop			= ehci_stop,
+	.shutdown		= ehci_shutdown,
+
+	/*
+	 * managing i/o requests and associated device resources
+	 */
+	.urb_enqueue		= ehci_urb_enqueue,
+	.urb_dequeue		= ehci_urb_dequeue,
+	.endpoint_disable	= ehci_endpoint_disable,
+
+	/*
+	 * scheduling support
+	 */
+	.get_frame_number	= ehci_get_frame,
+
+	/*
+	 * root hub support
+	 */
+	.hub_status_data	= ehci_hub_status_data,
+	.hub_control		= ehci_hub_control,
+	.bus_suspend		= ehci_bus_suspend,
+	.bus_resume		= ehci_bus_resume,
+	.relinquish_port	= ehci_relinquish_port,
+	.port_handed_over	= ehci_port_handed_over,
+};
+
+static int ehci_hcd_au13xx_drv_probe(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+	struct ehci_hcd *ehci;
+	int ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
+		pr_debug("resource[1] is not IORESOURCE_IRQ");
+		return -ENOMEM;
+	}
+	hcd = usb_create_hcd(&ehci_au13xx_hc_driver, &pdev->dev,
+			     dev_name(&pdev->dev));
+
+	if (!hcd)
+		return -ENOMEM;
+
+	hcd->rsrc_start = pdev->resource[0].start;
+	hcd->rsrc_len = pdev->resource[0].end - pdev->resource[0].start + 1;
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
+		pr_debug("request_mem_region failed");
+		ret = -EBUSY;
+		goto err1;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		pr_debug("ioremap failed");
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	au13xx_start_ehc();
+
+	ehci = hcd_to_ehci(hcd);
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs + HC_LENGTH(readl(&ehci->caps->hc_capbase));
+	printk("ehci->regs = %p\n", ehci->regs);
+
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = readl(&ehci->caps->hcs_params);
+
+	ret = usb_add_hcd(hcd, pdev->resource[1].start,
+			  IRQF_DISABLED | IRQF_SHARED);
+	if (ret == 0) {
+		platform_set_drvdata(pdev, hcd);
+		return ret;
+	}
+
+	au13xx_stop_ehc();
+	iounmap(hcd->regs);
+err2:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err1:
+	usb_put_hcd(hcd);
+	return ret;
+}
+
+static int ehci_hcd_au13xx_drv_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+	au13xx_stop_ehc();
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver ehci_hcd_au13xx_driver = {
+	.probe		= ehci_hcd_au13xx_drv_probe,
+	.remove		= ehci_hcd_au13xx_drv_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.suspend	= NULL,
+	.resume		= NULL,
+	.driver = {
+		.name	= "au13xx-ehci",
+		.owner	= THIS_MODULE,
+	}
+};
+
+MODULE_ALIAS("platform:au13xx-ehci");
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index e551bb3..1e4ca7e 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1016,6 +1016,11 @@ MODULE_LICENSE ("GPL");
 #define	PLATFORM_DRIVER		ehci_hcd_au1xxx_driver
 #endif

+#ifdef CONFIG_SOC_AU13XX
+#include "ehci-au13xx.c"
+#define	PLATFORM_DRIVER		ehci_hcd_au13xx_driver
+#endif
+
 #ifdef CONFIG_PPC_PS3
 #include "ehci-ps3.c"
 #define	PS3_SYSTEM_BUS_DRIVER	ps3_ehci_driver
--
1.5.4.3
