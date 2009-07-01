Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 19:09:48 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
	(ralf@eddie.linux-mips.org)) by ftp.linux-mips.org id S1491872AbZGARHK
	for <"|/home/ecartis/ecartis -s linux-mips">;
	Wed, 1 Jul 2009 19:07:10 +0200
Message-Id: <20090701120939.926196204@linux-mips.org>
User-Agent: quilt/0.47-1
Date:	Wed, 01 Jul 2009 12:29:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-usb@vger.kernel.org
Cc:	Maxime Bizon <mbizon@freebox.fr>,
	Florian Fainelli <florian@openwrt.org>
Subject: [patch 08/12] MIPS: BCM63XX: Add USB EHCI support.
References: <20090701112926.825088732@linux-mips.org>
Content-Disposition: inline; filename=0008.patch
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-archive-position: 23574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

From:	Maxime Bizon <mbizon@freebox.fr>

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/bcm63xx/Kconfig                                 |    2 
 arch/mips/bcm63xx/Makefile                                |    1 
 arch/mips/bcm63xx/dev-usb-ehci.c                          |   50 ++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ehci.h |    6 
 drivers/usb/host/ehci-bcm63xx.c                           |  155 ++++++++++++++
 drivers/usb/host/ehci-hcd.c                               |    5 
 drivers/usb/host/ehci.h                                   |    5 
 7 files changed, 224 insertions(+)
 create mode 100644 arch/mips/bcm63xx/dev-usb-ehci.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ehci.h
 create mode 100644 drivers/usb/host/ehci-bcm63xx.c

--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -14,4 +14,6 @@ config BCM63XX_CPU_6358
 	select USB_ARCH_HAS_OHCI
 	select USB_OHCI_BIG_ENDIAN_DESC
 	select USB_OHCI_BIG_ENDIAN_MMIO
+	select USB_ARCH_HAS_EHCI
+	select USB_EHCI_BIG_ENDIAN_MMIO
 endmenu
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -2,6 +2,7 @@ obj-y		+= clk.o cpu.o cs.o gpio.o irq.o 
 obj-y		+= dev-uart.o
 obj-y		+= dev-pcmcia.o
 obj-y		+= dev-usb-ohci.o
+obj-y		+= dev-usb-ehci.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 EXTRA_CFLAGS += -Werror
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-usb-ehci.c
@@ -0,0 +1,50 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_dev_usb_ehci.h>
+
+static struct resource ehci_resources[] = {
+	{
+		.start		= -1, /* filled at runtime */
+		.end		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		.start		= -1, /* filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static u64 ehci_dmamask = ~(u32)0;
+
+static struct platform_device bcm63xx_ehci_device = {
+	.name		= "bcm63xx_ehci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ehci_resources),
+	.resource	= ehci_resources,
+	.dev		= {
+		.dma_mask		= &ehci_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+int __init bcm63xx_ehci_register(void)
+{
+	if (!BCMCPU_IS_6358())
+		return 0;
+
+	ehci_resources[0].start = bcm63xx_regset_address(RSET_EHCI0);
+	ehci_resources[0].end = ehci_resources[0].start;
+	ehci_resources[0].end += RSET_EHCI_SIZE - 1;
+	ehci_resources[1].start = bcm63xx_get_irq_number(IRQ_EHCI0);
+	return platform_device_register(&bcm63xx_ehci_device);
+}
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ehci.h
@@ -0,0 +1,6 @@
+#ifndef BCM63XX_DEV_USB_EHCI_H_
+#define BCM63XX_DEV_USB_EHCI_H_
+
+int bcm63xx_ehci_register(void);
+
+#endif /* BCM63XX_DEV_USB_EHCI_H_ */
--- /dev/null
+++ b/drivers/usb/host/ehci-bcm63xx.c
@@ -0,0 +1,155 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <bcm63xx_cpu.h>
+#include <bcm63xx_regs.h>
+#include <bcm63xx_io.h>
+
+static int ehci_bcm63xx_setup(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	int retval;
+
+	retval = ehci_halt(ehci);
+	if (retval)
+		return retval;
+
+	retval = ehci_init(hcd);
+	if (retval)
+		return retval;
+
+	hcd->has_tt = 1;
+	ehci_reset(ehci);
+	ehci_port_power(ehci, 0);
+
+	return retval;
+}
+
+
+static const struct hc_driver ehci_bcm63xx_hc_driver = {
+	.description =		hcd_name,
+	.product_desc =		"BCM63XX integrated EHCI controller",
+	.hcd_priv_size =	sizeof(struct ehci_hcd),
+
+	.irq =			ehci_irq,
+	.flags =		HCD_MEMORY | HCD_USB2,
+
+	.reset =		ehci_bcm63xx_setup,
+	.start =		ehci_run,
+	.stop =			ehci_stop,
+	.shutdown =		ehci_shutdown,
+
+	.urb_enqueue =		ehci_urb_enqueue,
+	.urb_dequeue =		ehci_urb_dequeue,
+	.endpoint_disable =	ehci_endpoint_disable,
+
+	.get_frame_number =	ehci_get_frame,
+
+	.hub_status_data =	ehci_hub_status_data,
+	.hub_control =		ehci_hub_control,
+	.bus_suspend =		ehci_bus_suspend,
+	.bus_resume =		ehci_bus_resume,
+	.relinquish_port =	ehci_relinquish_port,
+	.port_handed_over =	ehci_port_handed_over,
+};
+
+static int __devinit ehci_hcd_bcm63xx_drv_probe(struct platform_device *pdev)
+{
+	struct resource *res_mem;
+	struct usb_hcd *hcd;
+	struct ehci_hcd *ehci;
+	u32 reg;
+	int ret, irq;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(pdev, 0);;
+	if (!res_mem || irq < 0)
+		return -ENODEV;
+
+	reg = bcm_rset_readl(RSET_USBH_PRIV, USBH_PRIV_SWAP_REG);
+	reg &= ~USBH_PRIV_SWAP_EHCI_DATA_MASK;
+	reg |= USBH_PRIV_SWAP_EHCI_ENDN_MASK;
+	bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SWAP_REG);
+
+	/*
+	 * The magic value comes for the original vendor BSP and is
+	 * needed for USB to work. Datasheet does not help, so the
+	 * magic value is used as-is.
+	 */
+	bcm_rset_writel(RSET_USBH_PRIV, 0x1c0020, USBH_PRIV_TEST_REG);
+
+	hcd = usb_create_hcd(&ehci_bcm63xx_hc_driver, &pdev->dev, "bcm63xx");
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
+	ehci = hcd_to_ehci(hcd);
+	ehci->big_endian_mmio = 1;
+	ehci->big_endian_desc = 0;
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs +
+		HC_LENGTH(ehci_readl(ehci, &ehci->caps->hc_capbase));
+	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
+	ehci->sbrn = 0x20;
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
+static int __devexit ehci_hcd_bcm63xx_drv_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+
+	hcd = platform_get_drvdata(pdev);
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	usb_put_hcd(hcd);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static struct platform_driver ehci_hcd_bcm63xx_driver = {
+	.probe		= ehci_hcd_bcm63xx_drv_probe,
+	.remove		= __devexit_p(ehci_hcd_bcm63xx_drv_remove),
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver		= {
+		.name	= "bcm63xx_ehci",
+		.owner	= THIS_MODULE,
+	},
+};
+
+MODULE_ALIAS("platform:bcm63xx_ehci");
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1117,6 +1117,11 @@ MODULE_LICENSE ("GPL");
 #define	PLATFORM_DRIVER		ixp4xx_ehci_driver
 #endif
 
+#ifdef CONFIG_BCM63XX
+#include "ehci-bcm63xx.c"
+#define	PLATFORM_DRIVER		ehci_hcd_bcm63xx_driver
+#endif
+
 #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER) && \
     !defined(PS3_SYSTEM_BUS_DRIVER) && !defined(OF_PLATFORM_DRIVER)
 #error "missing bus glue for ehci-hcd"
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -598,6 +598,11 @@ ehci_port_speed(struct ehci_hcd *ehci, u
 #define writel_be(val, addr)	__raw_writel(val, (__force unsigned *)addr)
 #endif
 
+#if defined(CONFIG_MIPS) && defined(CONFIG_BCM63XX)
+#define readl_be(addr)		__raw_readl((__force unsigned *)addr)
+#define writel_be(val, addr)	__raw_writel(val, (__force unsigned *)addr)
+#endif
+
 static inline unsigned int ehci_readl(const struct ehci_hcd *ehci,
 		__u32 __iomem * regs)
 {
