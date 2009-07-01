Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 19:09:27 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
	(ralf@eddie.linux-mips.org)) by ftp.linux-mips.org id S1491871AbZGARHK
	for <"|/home/ecartis/ecartis -s linux-mips">;
	Wed, 1 Jul 2009 19:07:10 +0200
Message-Id: <20090701120939.846432854@linux-mips.org>
User-Agent: quilt/0.47-1
Date:	Wed, 01 Jul 2009 12:29:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-usb@vger.kernel.org
Cc:	Maxime Bizon <mbizon@freebox.fr>,
	Florian Fainelli <florian@openwrt.org>
Subject: [patch 07/12] MIPS: BCM63XX: Add USB OHCI support.
References: <20090701112926.825088732@linux-mips.org>
Content-Disposition: inline; filename=0007.patch
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-archive-position: 23573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

From:	Maxime Bizon <mbizon@freebox.fr>

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/bcm63xx/Kconfig                                 |    6 
 arch/mips/bcm63xx/Makefile                                |    1 
 arch/mips/bcm63xx/dev-usb-ohci.c                          |   50 ++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ohci.h |    6 
 drivers/usb/host/ohci-bcm63xx.c                           |  164 ++++++++++++++
 drivers/usb/host/ohci-hcd.c                               |    5 
 drivers/usb/host/ohci.h                                   |    7 
 7 files changed, 238 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/bcm63xx/dev-usb-ohci.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ohci.h
 create mode 100644 drivers/usb/host/ohci-bcm63xx.c

--- a/arch/mips/bcm63xx/Kconfig
+++ b/arch/mips/bcm63xx/Kconfig
@@ -4,8 +4,14 @@ menu "CPU support"
 config BCM63XX_CPU_6348
 	bool "support 6348 CPU"
 	select HW_HAS_PCI
+	select USB_ARCH_HAS_OHCI
+	select USB_OHCI_BIG_ENDIAN_DESC
+	select USB_OHCI_BIG_ENDIAN_MMIO
 
 config BCM63XX_CPU_6358
 	bool "support 6358 CPU"
 	select HW_HAS_PCI
+	select USB_ARCH_HAS_OHCI
+	select USB_OHCI_BIG_ENDIAN_DESC
+	select USB_OHCI_BIG_ENDIAN_MMIO
 endmenu
--- a/arch/mips/bcm63xx/Makefile
+++ b/arch/mips/bcm63xx/Makefile
@@ -1,6 +1,7 @@
 obj-y		+= clk.o cpu.o cs.o gpio.o irq.o prom.o setup.o timer.o
 obj-y		+= dev-uart.o
 obj-y		+= dev-pcmcia.o
+obj-y		+= dev-usb-ohci.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 EXTRA_CFLAGS += -Werror
--- /dev/null
+++ b/arch/mips/bcm63xx/dev-usb-ohci.c
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
+#include <bcm63xx_dev_usb_ohci.h>
+
+static struct resource ohci_resources[] = {
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
+static u64 ohci_dmamask = ~(u32)0;
+
+static struct platform_device bcm63xx_ohci_device = {
+	.name		= "bcm63xx_ohci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ohci_resources),
+	.resource	= ohci_resources,
+	.dev		= {
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+int __init bcm63xx_ohci_register(void)
+{
+	if (!BCMCPU_IS_6348() && !BCMCPU_IS_6358())
+		return 0;
+
+	ohci_resources[0].start = bcm63xx_regset_address(RSET_OHCI0);
+	ohci_resources[0].end = ohci_resources[0].start;
+	ohci_resources[0].end += RSET_OHCI_SIZE - 1;
+	ohci_resources[1].start = bcm63xx_get_irq_number(IRQ_OHCI0);
+	return platform_device_register(&bcm63xx_ohci_device);
+}
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_usb_ohci.h
@@ -0,0 +1,6 @@
+#ifndef BCM63XX_DEV_USB_OHCI_H_
+#define BCM63XX_DEV_USB_OHCI_H_
+
+int bcm63xx_ohci_register(void);
+
+#endif /* BCM63XX_DEV_USB_OHCI_H_ */
--- /dev/null
+++ b/drivers/usb/host/ohci-bcm63xx.c
@@ -0,0 +1,164 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
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
+	ohci->num_ports = 1;
+
+	ret = ohci_init(ohci);
+	if (ret < 0)
+		return ret;
+
+	/* FIXME: autodetected port 2 is shared with USB slave */
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
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1047,6 +1047,11 @@ MODULE_LICENSE ("GPL");
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
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -536,6 +536,11 @@ static inline struct usb_hcd *ohci_to_hc
 #define big_endian_mmio(ohci)	0		/* only little endian */
 #endif
 
+#if defined(CONFIG_MIPS) && defined(CONFIG_BCM63XX)
+#define readl_be(addr)		__raw_readl((__force unsigned *)addr)
+#define writel_be(val, addr)	__raw_writel(val, (__force unsigned *)addr)
+#endif
+
 /*
  * Big-endian read/write functions are arch-specific.
  * Other arches can be added if/when they're needed.
@@ -646,7 +651,7 @@ static inline u32 hc32_to_cpup (const st
  * some big-endian SOC implementations.  Same thing happens with PSW access.
  */
 
-#ifdef CONFIG_PPC_MPC52xx
+#if defined(CONFIG_PPC_MPC52xx) || defined(CONFIG_BCM63XX)
 #define big_endian_frame_no_quirk(ohci)	(ohci->flags & OHCI_QUIRK_FRAME_NO)
 #else
 #define big_endian_frame_no_quirk(ohci)	0
