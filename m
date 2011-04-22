Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2011 18:56:27 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.49.93.86]:1341 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491106Ab1DVQzw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2011 18:55:52 +0200
X-TM-IMSS-Message-ID: <e42e213800016b7a@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id e42e213800016b7a ; Fri, 22 Apr 2011 09:55:35 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 22 Apr 2011 09:56:18 -0700
Date:   Fri, 22 Apr 2011 22:32:57 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH 7/8] USB support for XLS platforms.
Message-ID: <21ae06c6f50f7a770b62d61265e6f509f37d1762.1303487516.git.jayachandranc@netlogicmicro.com>
References: <cover.1303487516.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1303487516.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 22 Apr 2011 16:56:18.0368 (UTC) FILETIME=[32FF8C00:01CC010E]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

update ehci-hcd.c and ohci-hcd.c to add XLS hcds
add ehci/ohci devices to XLR/XLS platform driver
Kconfig update

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/Kconfig                        |    2 +
 arch/mips/include/asm/netlogic/xlr/xlr.h |   12 ++
 arch/mips/netlogic/xlr/platform.c        |   91 ++++++++++++++++
 drivers/usb/host/ehci-hcd.c              |    5 +
 drivers/usb/host/ehci-xls.c              |  170 ++++++++++++++++++++++++++++++
 drivers/usb/host/ohci-hcd.c              |    5 +
 drivers/usb/host/ohci-xls.c              |  160 ++++++++++++++++++++++++++++
 7 files changed, 445 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/ehci-xls.c
 create mode 100644 drivers/usb/host/ohci-xls.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5016caa..7fa4f01 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -759,6 +759,8 @@ config NLM_XLR_BOARD
 	select ZONE_DMA if 64BIT
 	select SYNC_R4K
 	select SYS_HAS_EARLY_PRINTK
+	select USB_ARCH_HAS_OHCI if USB_SUPPORT
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	help
 	  Support for systems based on Netlogic XLR and XLS processors.
 	  Say Y here if you have a XLR or XLS based board.
diff --git a/arch/mips/include/asm/netlogic/xlr/xlr.h b/arch/mips/include/asm/netlogic/xlr/xlr.h
index 454c236..1cffd21 100644
--- a/arch/mips/include/asm/netlogic/xlr/xlr.h
+++ b/arch/mips/include/asm/netlogic/xlr/xlr.h
@@ -51,4 +51,16 @@ void prom_pre_boot_secondary_cpus(void);
 extern struct plat_smp_ops nlm_smp_ops;
 extern unsigned long nlm_common_ebase;
 
+/*
+ *  XLR chip types
+ */
+ /* The XLS product line has chip versions 0x[48c]? */
+static inline unsigned int nlm_chip_is_xls(void)
+{
+	uint32_t prid = read_c0_prid();
+
+	return ((prid & 0xf000) == 0x8000 || (prid & 0xf000) == 0x4000 ||
+		(prid & 0xf000) == 0xc000);
+}
+
 #endif /* _ASM_NLM_XLR_H */
diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
index 609ec25..ac70144 100644
--- a/arch/mips/netlogic/xlr/platform.c
+++ b/arch/mips/netlogic/xlr/platform.c
@@ -96,3 +96,94 @@ static int __init nlm_uart_init(void)
 }
 
 arch_initcall(nlm_uart_init);
+
+/* Platform I2C devices */
+
+#ifdef CONFIG_USB
+/* Platform USB devices, only on XLS chips */
+static u64 xls_usb_dmamask = ~(u32)0;
+#define USB_PLATFORM_DEV(n, i, irq)					\
+	{								\
+		.name		= n,					\
+		.id		= i,					\
+		.num_resources	= 2,					\
+		.dev		= {					\
+			.dma_mask	= &xls_usb_dmamask,		\
+			.coherent_dma_mask = 0xffffffff,		\
+		},							\
+		.resource	= (struct resource[]) {			\
+			{						\
+				.flags = IORESOURCE_MEM,		\
+			},						\
+			{						\
+				.start	= irq,				\
+				.end	= irq,				\
+				.flags = IORESOURCE_IRQ,		\
+			},						\
+		},							\
+	}
+
+static struct platform_device xls_usb_ehci_device =
+			 USB_PLATFORM_DEV("ehci-xls", 0, PIC_USB_IRQ);
+static struct platform_device xls_usb_ohci_device_0 =
+			 USB_PLATFORM_DEV("ohci-xls-0", 1, PIC_USB_IRQ);
+static struct platform_device xls_usb_ohci_device_1 =
+			 USB_PLATFORM_DEV("ohci-xls-1", 2, PIC_USB_IRQ);
+
+static struct platform_device *xls_platform_devices[] __initdata = {
+	&xls_usb_ehci_device,
+	&xls_usb_ohci_device_0,
+	&xls_usb_ohci_device_1,
+};
+
+int xls_platform_usb_init(void)
+{
+	nlm_reg_t *usb_mmio, *gpio_mmio;
+	unsigned long memres;
+	uint32_t val;
+
+	if (!nlm_chip_is_xls())
+		return 0;
+
+	gpio_mmio = netlogic_io_mmio(NETLOGIC_IO_GPIO_OFFSET);
+	usb_mmio  = netlogic_io_mmio(NETLOGIC_IO_USB_1_OFFSET);
+
+	/* Clear Rogue Phy INTs */
+	netlogic_write_reg(usb_mmio, 49, 0x10000000);
+	/* Enable all interrupts */
+	netlogic_write_reg(usb_mmio, 50, 0x1f000000);
+
+	/* Enable ports */
+	netlogic_write_reg(usb_mmio,  1, 0x07000500);
+
+	val = netlogic_read_reg(gpio_mmio, 21);
+	if (((val >> 22) & 0x01) == 0) {
+		pr_info("Detected USB Device mode - Not supported!\n");
+		netlogic_write_reg(usb_mmio,  0, 0x01000000);
+		return 0;
+	}
+
+	pr_info("Detected USB Host mode - Adding XLS USB devices.\n");
+	/* Clear reset, host mode */
+	netlogic_write_reg(usb_mmio,  0, 0x02000000);
+
+	/* Memory resource for various XLS usb ports */
+	usb_mmio = netlogic_io_mmio(NETLOGIC_IO_USB_0_OFFSET);
+	memres = CPHYSADDR((unsigned long)usb_mmio);
+	xls_usb_ehci_device.resource[0].start = memres;
+	xls_usb_ehci_device.resource[0].end = memres + 0x400 - 1;
+
+	memres += 0x400;
+	xls_usb_ohci_device_0.resource[0].start = memres;
+	xls_usb_ohci_device_0.resource[0].end = memres + 0x400 - 1;
+
+	memres += 0x400;
+	xls_usb_ohci_device_1.resource[0].start = memres;
+	xls_usb_ohci_device_1.resource[0].end = memres + 0x400 - 1;
+
+	return platform_add_devices(xls_platform_devices,
+				ARRAY_SIZE(xls_platform_devices));
+}
+
+arch_initcall(xls_platform_usb_init);
+#endif
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 78561d1..fde78c9 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1265,6 +1265,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		tegra_ehci_driver
 #endif
 
+#ifdef CONFIG_NLM_XLR
+#include "ehci-xls.c"
+#define PLATFORM_DRIVER		ehci_xls_driver
+#endif
+
 #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER) && \
     !defined(PS3_SYSTEM_BUS_DRIVER) && !defined(OF_PLATFORM_DRIVER) && \
     !defined(XILINX_OF_PLATFORM_DRIVER)
diff --git a/drivers/usb/host/ehci-xls.c b/drivers/usb/host/ehci-xls.c
new file mode 100644
index 0000000..54467c6
--- /dev/null
+++ b/drivers/usb/host/ehci-xls.c
@@ -0,0 +1,170 @@
+/*
+ * OHCI HCD (Host Controller Driver) for USB.
+ *
+ * (C) Copyright 2011 Netlogic Microsystems Inc.
+ * (C) Copyright 1999 Roman Weissgaerber <weissg@vienna.at>
+ * (C) Copyright 2000-2002 David Brownell <dbrownell@users.sourceforge.net>
+ * (C) Copyright 2002 Hewlett-Packard Company
+ *
+ * Bus Glue for AMD Alchemy Au1xxx
+ *
+ * Written by Christopher Hoover <ch@hpl.hp.com>
+ * Based on fragments of previous driver by Rusell King et al.
+ *
+ * Modified for LH7A404 from ohci-sa1111.c
+ *  by Durgesh Pattamatta <pattamattad@sharpsec.com>
+ * Modified for AMD Alchemy Au1xxx
+ *  by Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This file is licenced under the GPL.
+ */
+
+#include <linux/platform_device.h>
+
+static int ehci_xls_setup(struct usb_hcd *hcd)
+{
+	int	retval;
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs +
+		HC_LENGTH(ehci_readl(ehci, &ehci->caps->hc_capbase));
+	dbg_hcs_params(ehci, "reset");
+	dbg_hcc_params(ehci, "reset");
+
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
+
+	retval = ehci_halt(ehci);
+	if (retval)
+		return retval;
+
+	/* data structure init */
+	retval = ehci_init(hcd);
+	if (retval)
+		return retval;
+
+	ehci_reset(ehci);
+
+	return retval;
+}
+
+int ehci_xls_probe_internal(const struct hc_driver *driver,
+	struct platform_device *pdev)
+{
+	struct usb_hcd  *hcd;
+	struct resource *res;
+	int retval, irq;
+
+	/* Get our IRQ from an earlier registered Platform Resource */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Found HC with no IRQ. Check %s setup!\n",
+				dev_name(&pdev->dev));
+		return -ENODEV;
+	}
+
+	/* Get our Memory Handle */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Error: MMIO Handle %s setup!\n",
+				dev_name(&pdev->dev));
+		return -ENODEV;
+	}
+	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
+	if (!hcd) {
+		retval = -ENOMEM;
+		goto err1;
+	}
+
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = res->end - res->start + 1;
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len,
+				driver->description)) {
+		dev_dbg(&pdev->dev, "controller already in use\n");
+		retval = -EBUSY;
+		goto err2;
+	}
+	hcd->regs = ioremap_nocache(hcd->rsrc_start, hcd->rsrc_len);
+
+	if (hcd->regs == NULL) {
+		dev_dbg(&pdev->dev, "error mapping memory\n");
+		retval = -EFAULT;
+		goto err3;
+	}
+
+	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (retval != 0)
+		goto err4;
+	return retval;
+
+err4:
+	iounmap(hcd->regs);
+err3:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err2:
+	usb_put_hcd(hcd);
+err1:
+	dev_err(&pdev->dev, "init %s fail, %d\n", dev_name(&pdev->dev),
+			retval);
+	return retval;
+}
+
+static struct hc_driver ehci_xls_hc_driver = {
+	.description	= hcd_name,
+	.product_desc	= "XLS EHCI Host Controller",
+	.hcd_priv_size	= sizeof(struct ehci_hcd),
+	.irq		= ehci_irq,
+	.flags		= HCD_USB2 | HCD_MEMORY,
+	.reset		= ehci_xls_setup,
+	.start		= ehci_run,
+	.stop		= ehci_stop,
+	.shutdown	= ehci_shutdown,
+
+	.urb_enqueue	= ehci_urb_enqueue,
+	.urb_dequeue	= ehci_urb_dequeue,
+	.endpoint_disable = ehci_endpoint_disable,
+	.endpoint_reset	= ehci_endpoint_reset,
+
+	.get_frame_number = ehci_get_frame,
+
+	.hub_status_data = ehci_hub_status_data,
+	.hub_control	= ehci_hub_control,
+	.bus_suspend	= ehci_bus_suspend,
+	.bus_resume	= ehci_bus_resume,
+	.relinquish_port = ehci_relinquish_port,
+	.port_handed_over = ehci_port_handed_over,
+
+	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
+};
+
+static int ehci_xls_probe(struct platform_device *pdev)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	return ehci_xls_probe_internal(&ehci_xls_hc_driver, pdev);
+}
+
+static int ehci_xls_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+	return 0;
+}
+
+MODULE_ALIAS("ehci-xls");
+
+static struct platform_driver ehci_xls_driver = {
+	.probe		= ehci_xls_probe,
+	.remove		= ehci_xls_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver		= {
+		.name = "ehci-xls",
+	},
+};
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index d557235..7b8c12b 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1105,6 +1105,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ohci_hcd_cns3xxx_driver
 #endif
 
+#ifdef CONFIG_NLM_XLR
+#include "ohci-xls.c"
+#define PLATFORM_DRIVER		ohci_xls_driver
+#endif
+
 #if	!defined(PCI_DRIVER) &&		\
 	!defined(PLATFORM_DRIVER) &&	\
 	!defined(OMAP1_PLATFORM_DRIVER) &&	\
diff --git a/drivers/usb/host/ohci-xls.c b/drivers/usb/host/ohci-xls.c
new file mode 100644
index 0000000..106d4f0
--- /dev/null
+++ b/drivers/usb/host/ohci-xls.c
@@ -0,0 +1,160 @@
+/*
+ * OHCI HCD (Host Controller Driver) for USB.
+ *
+ * (C) Copyright 2011 Netlogic Microsystems Inc.
+ * (C) Copyright 1999 Roman Weissgaerber <weissg@vienna.at>
+ * (C) Copyright 2000-2002 David Brownell <dbrownell@users.sourceforge.net>
+ * (C) Copyright 2002 Hewlett-Packard Company
+ *
+ * Bus Glue for AMD Alchemy Au1xxx
+ *
+ * Written by Christopher Hoover <ch@hpl.hp.com>
+ * Based on fragments of previous driver by Rusell King et al.
+ *
+ * Modified for LH7A404 from ohci-sa1111.c
+ *  by Durgesh Pattamatta <pattamattad@sharpsec.com>
+ * Modified for AMD Alchemy Au1xxx
+ *  by Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This file is licenced under the GPL.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/signal.h>
+
+static int ohci_xls_probe_internal(const struct hc_driver *driver,
+			struct platform_device *dev)
+{
+	struct resource *res;
+	struct usb_hcd *hcd;
+	int retval, irq;
+
+	/* Get our IRQ from an earlier registered Platform Resource */
+	irq = platform_get_irq(dev, 0);
+	if (irq < 0) {
+		dev_err(&dev->dev, "Found HC with no IRQ\n");
+		return -ENODEV;
+	}
+
+	/* Get our Memory Handle */
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&dev->dev, "MMIO Handle incorrect!\n");
+		return -ENODEV;
+	}
+
+	hcd = usb_create_hcd(driver, &dev->dev, "XLS");
+	if (!hcd) {
+		retval = -ENOMEM;
+		goto err1;
+	}
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = res->end - res->start + 1;
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len,
+			driver->description)) {
+		dev_dbg(&dev->dev, "Controller already in use\n");
+		retval = -EBUSY;
+		goto err2;
+	}
+
+	hcd->regs = ioremap_nocache(hcd->rsrc_start, hcd->rsrc_len);
+	if (hcd->regs == NULL) {
+		dev_dbg(&dev->dev, "error mapping memory\n");
+		retval = -EFAULT;
+		goto err3;
+	}
+
+	retval = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
+	if (retval != 0)
+		goto err4;
+	return retval;
+
+err4:
+	iounmap(hcd->regs);
+err3:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err2:
+	usb_put_hcd(hcd);
+err1:
+	dev_err(&dev->dev, "init fail, %d\n", retval);
+	return retval;
+}
+
+static int ohci_xls_reset(struct usb_hcd *hcd)
+{
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+
+	ohci_hcd_init(ohci);
+	return ohci_init(ohci);
+}
+
+static int __devinit ohci_xls_start(struct usb_hcd *hcd)
+{
+	struct ohci_hcd *ohci;
+	int ret;
+
+	ohci = hcd_to_ohci(hcd);
+	ret = ohci_run(ohci);
+	if (ret < 0) {
+		err("can't start %s", hcd->self.bus_name);
+		ohci_stop(hcd);
+		return ret;
+	}
+	return 0;
+}
+
+static struct hc_driver ohci_xls_hc_driver = {
+	.description	= hcd_name,
+	.product_desc	= "XLS OHCI Host Controller",
+	.hcd_priv_size	= sizeof(struct ohci_hcd),
+	.irq		= ohci_irq,
+	.flags		= HCD_MEMORY | HCD_USB11,
+	.reset		= ohci_xls_reset,
+	.start		= ohci_xls_start,
+	.stop		= ohci_stop,
+	.shutdown	= ohci_shutdown,
+	.urb_enqueue	= ohci_urb_enqueue,
+	.urb_dequeue	= ohci_urb_dequeue,
+	.endpoint_disable = ohci_endpoint_disable,
+	.get_frame_number = ohci_get_frame,
+	.hub_status_data = ohci_hub_status_data,
+	.hub_control	= ohci_hub_control,
+#ifdef CONFIG_PM
+	.bus_suspend	= ohci_bus_suspend,
+	.bus_resume	= ohci_bus_resume,
+#endif
+	.start_port_reset = ohci_start_port_reset,
+};
+
+static int ohci_xls_probe(struct platform_device *dev)
+{
+	int ret;
+
+	pr_debug("In ohci_xls_probe");
+	if (usb_disabled())
+		return -ENODEV;
+	ret = ohci_xls_probe_internal(&ohci_xls_hc_driver, dev);
+	return ret;
+}
+
+static int ohci_xls_remove(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+
+	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+	return 0;
+}
+
+static struct platform_driver ohci_xls_driver = {
+	.probe		= ohci_xls_probe,
+	.remove		= ohci_xls_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver		= {
+		.name	= "ohci-xls-0",
+		.owner	= THIS_MODULE,
+	},
+};
-- 
1.7.1


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
