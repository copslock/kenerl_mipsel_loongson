Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Mar 2012 21:10:32 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:42555 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903716Ab2CKUJP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Mar 2012 21:09:15 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 5CCA28F68;
        Sun, 11 Mar 2012 21:09:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HRm3Io+kIuLh; Sun, 11 Mar 2012 21:08:59 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 94C298F64;
        Sun, 11 Mar 2012 21:08:31 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/7] USB: Add driver for the bcma bus
Date:   Sun, 11 Mar 2012 21:08:22 +0100
Message-Id: <1331496505-18697-5-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1331496505-18697-1-git-send-email-hauke@hauke-m.de>
References: <1331496505-18697-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This adds a USB driver using the generic platform device driver for the
USB controller found on the Broadcom bcma bus. The bcma bus just
exposes one device which serves the OHCI and the EHCI controller at the
same time. This driver probes for this USB controller and creates and
registers two new platform devices which will be probed by the new
generic platform device driver. This makes it possible to use the EHCI
and the OCHI controller on the bcma bus at the same time.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/usb/host/Kconfig    |   12 ++
 drivers/usb/host/Makefile   |    1 +
 drivers/usb/host/bcma-hcd.c |  334 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 347 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/host/bcma-hcd.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 0edc445..598e6a0 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -633,3 +633,15 @@ config USB_PXA168_EHCI
 	help
 	  Enable support for Marvell PXA168 SoC's on-chip EHCI
 	  host controller
+
+config USB_HCD_BCMA
+	tristate "BCMA usb host driver"
+	depends on BCMA && EXPERIMENTAL
+	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
+	select USB_EHCI_HCD_PLATFORM if USB_EHCI_HCD
+	help
+	  Enbale support for the EHCI and OCHI host controller on an bcma bus.
+	  It converts the bcma driver into two platform device drivers
+	  for ehci and ohci.
+
+	  If unsure, say N.
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 7ca290f..f2c2846 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -37,3 +37,4 @@ obj-$(CONFIG_USB_IMX21_HCD)	+= imx21-hcd.o
 obj-$(CONFIG_USB_FSL_MPH_DR_OF)	+= fsl-mph-dr-of.o
 obj-$(CONFIG_USB_OCTEON2_COMMON) += octeon2-common.o
 obj-$(CONFIG_MIPS_ALCHEMY)	+= alchemy-common.o
+obj-$(CONFIG_USB_HCD_BCMA)	+= bcma-hcd.o
diff --git a/drivers/usb/host/bcma-hcd.c b/drivers/usb/host/bcma-hcd.c
new file mode 100644
index 0000000..8685e2e
--- /dev/null
+++ b/drivers/usb/host/bcma-hcd.c
@@ -0,0 +1,334 @@
+/*
+ * Broadcom specific Advanced Microcontroller Bus
+ * Broadcom USB-core driver (BCMA bus glue)
+ *
+ * Copyright 2011 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Based on ssb-ohci driver
+ * Copyright 2007 Michael Buesch <m@bues.ch>
+ *
+ * Derived from the OHCI-PCI driver
+ * Copyright 1999 Roman Weissgaerber
+ * Copyright 2000-2002 David Brownell
+ * Copyright 1999 Linus Torvalds
+ * Copyright 1999 Gregory P. Smith
+ *
+ * Derived from the USBcore related parts of Broadcom-SB
+ * Copyright 2005-2011 Broadcom Corporation
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+#include <linux/bcma/bcma.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
+
+MODULE_AUTHOR("Hauke Mehrtens");
+MODULE_DESCRIPTION("Common USB driver for BCMA Bus");
+MODULE_LICENSE("GPL");
+
+struct bcma_hcd_device {
+	struct platform_device *ehci_dev;
+	struct platform_device *ohci_dev;
+};
+
+/* Wait for bitmask in a register to get set or cleared.
+ * timeout is in units of ten-microseconds.
+ */
+static int bcma_wait_bits(struct bcma_device *dev, u16 reg, u32 bitmask,
+			  int timeout)
+{
+	int i;
+	u32 val;
+
+	for (i = 0; i < timeout; i++) {
+		val = bcma_read32(dev, reg);
+		if ((val & bitmask) == bitmask)
+			return 0;
+		udelay(10);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void __devinit bcma_hcd_4716wa(struct bcma_device *dev)
+{
+#ifdef CONFIG_BCMA_DRIVER_MIPS
+	/* Work around for 4716 failures. */
+	if (dev->bus->chipinfo.id == 0x4716) {
+		u32 tmp;
+
+		tmp = bcma_cpu_clock(&dev->bus->drv_mips);
+		if (tmp >= 480000000)
+			tmp = 0x1846b; /* set CDR to 0x11(fast) */
+		else if (tmp == 453000000)
+			tmp = 0x1046b; /* set CDR to 0x10(slow) */
+		else
+			tmp = 0;
+
+		/* Change Shim mdio control reg to fix host not acking at
+		 * high frequencies
+		 */
+		if (tmp) {
+			bcma_write32(dev, 0x524, 0x1); /* write sel to enable */
+			udelay(500);
+
+			bcma_write32(dev, 0x524, tmp);
+			udelay(500);
+			bcma_write32(dev, 0x524, 0x4ab);
+			udelay(500);
+			bcma_read32(dev, 0x528);
+			bcma_write32(dev, 0x528, 0x80000000);
+		}
+	}
+#endif /* CONFIG_BCMA_DRIVER_MIPS */
+}
+
+/* based on arch/mips/brcm-boards/bcm947xx/pcibios.c */
+static void __devinit bcma_hcd_init_chip(struct bcma_device *dev)
+{
+	u32 tmp;
+
+	/*
+	 * USB 2.0 special considerations:
+	 *
+	 * 1. Since the core supports both OHCI and EHCI functions, it must
+	 *    only be reset once.
+	 *
+	 * 2. In addition to the standard SI reset sequence, the Host Control
+	 *    Register must be programmed to bring the USB core and various
+	 *    phy components out of reset.
+	 */
+	if (!bcma_core_is_enabled(dev)) {
+		bcma_core_enable(dev, 0);
+		mdelay(10);
+		if (dev->id.rev >= 5) {
+			/* Enable Misc PLL */
+			tmp = bcma_read32(dev, 0x1e0);
+			tmp |= 0x100;
+			bcma_write32(dev, 0x1e0, tmp);
+			if (bcma_wait_bits(dev, 0x1e0, 1 << 24, 100))
+				printk(KERN_EMERG "Failed to enable misc PPL!\n");
+
+			/* Take out of resets */
+			bcma_write32(dev, 0x200, 0x4ff);
+			udelay(25);
+			bcma_write32(dev, 0x200, 0x6ff);
+			udelay(25);
+
+			/* Make sure digital and AFE are locked in USB PHY */
+			bcma_write32(dev, 0x524, 0x6b);
+			udelay(50);
+			tmp = bcma_read32(dev, 0x524);
+			udelay(50);
+			bcma_write32(dev, 0x524, 0xab);
+			udelay(50);
+			tmp = bcma_read32(dev, 0x524);
+			udelay(50);
+			bcma_write32(dev, 0x524, 0x2b);
+			udelay(50);
+			tmp = bcma_read32(dev, 0x524);
+			udelay(50);
+			bcma_write32(dev, 0x524, 0x10ab);
+			udelay(50);
+			tmp = bcma_read32(dev, 0x524);
+
+			if (bcma_wait_bits(dev, 0x528, 0xc000, 10000)) {
+				tmp = bcma_read32(dev, 0x528);
+				printk(KERN_EMERG
+				       "USB20H mdio_rddata 0x%08x\n", tmp);
+			}
+			bcma_write32(dev, 0x528, 0x80000000);
+			tmp = bcma_read32(dev, 0x314);
+			udelay(265);
+			bcma_write32(dev, 0x200, 0x7ff);
+			udelay(10);
+
+			/* Take USB and HSIC out of non-driving modes */
+			bcma_write32(dev, 0x510, 0);
+		} else {
+			bcma_write32(dev, 0x200, 0x7ff);
+
+			udelay(1);
+		}
+
+		bcma_hcd_4716wa(dev);
+	}
+}
+
+static const struct usb_ehci_pdata ehci_pdata = {
+};
+
+static const struct usb_ohci_pdata ohci_pdata = {
+};
+
+static struct platform_device * __devinit
+bcma_hcd_create_pdev(struct bcma_device *dev, bool ohci, u32 addr)
+{
+	struct platform_device *hci_dev;
+	struct resource hci_res[2];
+	int ret = -ENOMEM;
+
+	memset(hci_res, 0, sizeof(hci_res));
+
+	hci_res[0].start = addr;
+	hci_res[0].end = hci_res[0].start + 0x1000 - 1;
+	hci_res[0].flags = IORESOURCE_MEM;
+
+	hci_res[1].start = dev->irq;
+	hci_res[1].flags = IORESOURCE_IRQ;
+
+	hci_dev = platform_device_alloc(ohci ? "ohci-platform" :
+					"ehci-platform" , 0);
+	if (!hci_dev)
+		return NULL;
+
+	hci_dev->dev.parent = &dev->dev;
+	hci_dev->dev.dma_mask = &hci_dev->dev.coherent_dma_mask;
+
+	ret = platform_device_add_resources(hci_dev, hci_res,
+					    ARRAY_SIZE(hci_res));
+	if (ret)
+		goto err_alloc;
+	if (ohci)
+		ret = platform_device_add_data(hci_dev, &ohci_pdata,
+					       sizeof(ohci_pdata));
+	else
+		ret = platform_device_add_data(hci_dev, &ehci_pdata,
+					       sizeof(ehci_pdata));
+	if (ret)
+		goto err_alloc;
+	ret = platform_device_add(hci_dev);
+	if (ret)
+		goto err_alloc;
+
+	return hci_dev;
+
+err_alloc:
+	platform_device_put(hci_dev);
+	return ERR_PTR(ret);
+}
+
+static int __devinit bcma_hcd_probe(struct bcma_device *dev)
+{
+	int err;
+	u16 chipid_top;
+	u32 ohci_addr;
+	struct bcma_hcd_device *usb_dev;
+	struct bcma_chipinfo *chipinfo;
+
+	chipinfo = &dev->bus->chipinfo;
+	/* USBcores are only connected on embedded devices. */
+	chipid_top = (chipinfo->id & 0xFF00);
+	if (chipid_top != 0x4700 && chipid_top != 0x5300)
+		return -ENODEV;
+
+	/* TODO: Probably need checks here; is the core connected? */
+
+	if (dma_set_mask(dev->dma_dev, DMA_BIT_MASK(32)) ||
+	    dma_set_coherent_mask(dev->dma_dev, DMA_BIT_MASK(32)))
+		return -EOPNOTSUPP;
+
+	usb_dev = kzalloc(sizeof(struct bcma_hcd_device), GFP_KERNEL);
+	if (!usb_dev)
+		return -ENOMEM;
+
+	bcma_hcd_init_chip(dev);
+
+	/* In AI chips EHCI is addrspace 0, OHCI is 1 */
+	ohci_addr = dev->addr1;
+	if ((chipinfo->id == 0x5357 || chipinfo->id == 0x4749)
+	    && chipinfo->rev == 0)
+		ohci_addr = 0x18009000;
+
+	usb_dev->ohci_dev = bcma_hcd_create_pdev(dev, true, ohci_addr);
+	if (IS_ERR(usb_dev->ohci_dev)) {
+		err = PTR_ERR(usb_dev->ohci_dev);
+		goto err_free_usb_dev;
+	}
+
+	usb_dev->ehci_dev = bcma_hcd_create_pdev(dev, false, dev->addr);
+	if (IS_ERR(usb_dev->ehci_dev)) {
+		err = PTR_ERR(usb_dev->ehci_dev);
+		goto err_unregister_ohci_dev;
+	}
+
+	bcma_set_drvdata(dev, usb_dev);
+	return 0;
+
+err_unregister_ohci_dev:
+	platform_device_unregister(usb_dev->ohci_dev);
+err_free_usb_dev:
+	kfree(usb_dev);
+	return err;
+}
+
+static void __devexit bcma_hcd_remove(struct bcma_device *dev)
+{
+	struct bcma_hcd_device *usb_dev = bcma_get_drvdata(dev);
+	struct platform_device *ohci_dev = usb_dev->ohci_dev;
+	struct platform_device *ehci_dev = usb_dev->ehci_dev;
+
+	if (ohci_dev)
+		platform_device_unregister(ohci_dev);
+	if (ehci_dev)
+		platform_device_unregister(ehci_dev);
+
+	bcma_core_disable(dev, 0);
+}
+
+static void bcma_hcd_shutdown(struct bcma_device *dev)
+{
+	bcma_core_disable(dev, 0);
+}
+
+#ifdef CONFIG_PM
+
+static int bcma_hcd_suspend(struct bcma_device *dev, pm_message_t state)
+{
+	bcma_core_disable(dev, 0);
+
+	return 0;
+}
+
+static int bcma_hcd_resume(struct bcma_device *dev)
+{
+	bcma_core_enable(dev, 0);
+
+	return 0;
+}
+
+#else /* !CONFIG_PM */
+#define bcma_hcd_suspend	NULL
+#define bcma_hcd_resume	NULL
+#endif /* CONFIG_PM */
+
+static const struct bcma_device_id bcma_hcd_table[] __devinitconst = {
+	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_USB20_HOST, BCMA_ANY_REV, BCMA_ANY_CLASS),
+	BCMA_CORETABLE_END
+};
+MODULE_DEVICE_TABLE(bcma, bcma_hcd_table);
+
+static struct bcma_driver bcma_hcd_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= bcma_hcd_table,
+	.probe		= bcma_hcd_probe,
+	.remove		= __devexit_p(bcma_hcd_remove),
+	.shutdown	= bcma_hcd_shutdown,
+	.suspend	= bcma_hcd_suspend,
+	.resume		= bcma_hcd_resume,
+};
+
+static int __init bcma_hcd_init(void)
+{
+	return bcma_driver_register(&bcma_hcd_driver);
+}
+module_init(bcma_hcd_init);
+
+static void __exit bcma_hcd_exit(void)
+{
+	bcma_driver_unregister(&bcma_hcd_driver);
+}
+module_exit(bcma_hcd_exit);
-- 
1.7.5.4
