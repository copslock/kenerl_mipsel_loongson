Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 23:49:03 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6300 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491760Ab0JHVsJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 23:48:09 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4caf91b90000>; Fri, 08 Oct 2010 14:48:41 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 8 Oct 2010 14:48:16 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 8 Oct 2010 14:48:16 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o98Lm2OA023142;
        Fri, 8 Oct 2010 14:48:02 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o98Lm1XY023141;
        Fri, 8 Oct 2010 14:48:01 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org, gregkh@suse.de,
        dbrownell@users.sourceforge.net
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/3] usb: Add EHCI and OHCH glue for OCTEON II SOCs.
Date:   Fri,  8 Oct 2010 14:47:52 -0700
Message-Id: <1286574473-23098-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286574473-23098-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286574473-23098-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 08 Oct 2010 21:48:16.0307 (UTC) FILETIME=[8389E830:01CB6732]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The OCTEON II SOC has USB EHCI and OHCI controllers connected directly
to the internal I/O bus.  This patch adds the necessary 'glue' logic
to allow ehci-hcd and ohci-hcd drivers to work on OCTEON II.

The OCTEON normally runs big-endian, and the ehci/ohci internal
registers have host endianness, so we need to select
USB_EHCI_BIG_ENDIAN_MMIO.

The ehci and ohci blocks share a common clocking and PHY
infrastructure.  Initialization of the host controller and PHY clocks
is common between the two and is factored out into the
octeon2-common.c file.

Setting of USB_ARCH_HAS_OHCI and USB_ARCH_HAS_EHCI is done in
arch/mips/Kconfig in a following patch.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/usb/host/Kconfig          |   27 +++++-
 drivers/usb/host/Makefile         |    1 +
 drivers/usb/host/ehci-hcd.c       |    5 +
 drivers/usb/host/ehci-octeon.c    |  207 +++++++++++++++++++++++++++++++++++
 drivers/usb/host/octeon2-common.c |  185 ++++++++++++++++++++++++++++++++
 drivers/usb/host/ohci-hcd.c       |    5 +
 drivers/usb/host/ohci-octeon.c    |  214 +++++++++++++++++++++++++++++++++++++
 7 files changed, 643 insertions(+), 1 deletions(-)
 create mode 100644 drivers/usb/host/ehci-octeon.c
 create mode 100644 drivers/usb/host/octeon2-common.c
 create mode 100644 drivers/usb/host/ohci-octeon.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 2d926ce..a03d688 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -93,7 +93,7 @@ config USB_EHCI_TT_NEWSCHED
 
 config USB_EHCI_BIG_ENDIAN_MMIO
 	bool
-	depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX || ARCH_IXP4XX || XPS_USB_HCD_XILINX)
+	depends on USB_EHCI_HCD && (PPC_CELLEB || PPC_PS3 || 440EPX || ARCH_IXP4XX || XPS_USB_HCD_XILINX || CPU_CAVIUM_OCTEON)
 	default y
 
 config USB_EHCI_BIG_ENDIAN_DESC
@@ -428,3 +428,28 @@ config USB_IMX21_HCD
          To compile this driver as a module, choose M here: the
          module will be called "imx21-hcd".
 
+config USB_OCTEON_EHCI
+	bool "Octeon on-chip EHCI support"
+	depends on USB && USB_EHCI_HCD && CPU_CAVIUM_OCTEON
+	default n
+	select USB_EHCI_BIG_ENDIAN_MMIO
+	help
+	  Enable support for the Octeon II SOC's on-chip EHCI
+	  controller.  It is needed for high-speed (480Mbit/sec)
+	  USB 2.0 device support.  All CN6XXX based chips with USB are
+	  supported.
+
+config USB_OCTEON_OHCI
+	bool "Octeon on-chip OHCI support"
+	depends on USB && USB_OHCI_HCD && CPU_CAVIUM_OCTEON
+	default USB_OCTEON_EHCI
+	select USB_OHCI_BIG_ENDIAN_MMIO
+	select USB_OHCI_LITTLE_ENDIAN
+	help
+	  Enable support for the Octeon II SOC's on-chip OHCI
+	  controller.  It is needed for low-speed USB 1.0 device
+	  support.  All CN6XXX based chips with USB are supported.
+
+config USB_OCTEON2_COMMON
+	bool
+	default y if USB_OCTEON_EHCI || USB_OCTEON_OHCI
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index b6315aa..36099ce 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -33,4 +33,5 @@ obj-$(CONFIG_USB_R8A66597_HCD)	+= r8a66597-hcd.o
 obj-$(CONFIG_USB_ISP1760_HCD)	+= isp1760.o
 obj-$(CONFIG_USB_HWA_HCD)	+= hwa-hc.o
 obj-$(CONFIG_USB_IMX21_HCD)	+= imx21-hcd.o
+obj-$(CONFIG_USB_OCTEON2_COMMON) += octeon2-common.o
 
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 34a928d..158a520 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1197,6 +1197,11 @@ MODULE_LICENSE ("GPL");
 #define	PLATFORM_DRIVER		ehci_atmel_driver
 #endif
 
+#ifdef CONFIG_USB_OCTEON_EHCI
+#include "ehci-octeon.c"
+#define PLATFORM_DRIVER		ehci_octeon_driver
+#endif
+
 #if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER) && \
     !defined(PS3_SYSTEM_BUS_DRIVER) && !defined(OF_PLATFORM_DRIVER) && \
     !defined(XILINX_OF_PLATFORM_DRIVER)
diff --git a/drivers/usb/host/ehci-octeon.c b/drivers/usb/host/ehci-octeon.c
new file mode 100644
index 0000000..a31a031
--- /dev/null
+++ b/drivers/usb/host/ehci-octeon.c
@@ -0,0 +1,207 @@
+/*
+ * EHCI HCD glue for Cavium Octeon II SOCs.
+ *
+ * Loosely based on ehci-au1xxx.c
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010 Cavium Networks
+ *
+ */
+
+#include <linux/platform_device.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-uctlx-defs.h>
+
+#define OCTEON_EHCI_HCD_NAME "octeon-ehci"
+
+/* Common clock init code.  */
+void octeon2_usb_clocks_start(void);
+void octeon2_usb_clocks_stop(void);
+
+static void ehci_octeon_start(void)
+{
+	union cvmx_uctlx_ehci_ctl ehci_ctl;
+
+	octeon2_usb_clocks_start();
+
+	ehci_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_EHCI_CTL(0));
+	/* Use 64-bit addressing. */
+	ehci_ctl.s.ehci_64b_addr_en = 1;
+	ehci_ctl.s.l2c_addr_msb = 0;
+	ehci_ctl.s.l2c_buff_emod = 1; /* Byte swapped. */
+	ehci_ctl.s.l2c_desc_emod = 1; /* Byte swapped. */
+	cvmx_write_csr(CVMX_UCTLX_EHCI_CTL(0), ehci_ctl.u64);
+}
+
+static void ehci_octeon_stop(void)
+{
+	octeon2_usb_clocks_stop();
+}
+
+static const struct hc_driver ehci_octeon_hc_driver = {
+	.description		= hcd_name,
+	.product_desc		= "Octeon EHCI",
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
+	.endpoint_reset		= ehci_endpoint_reset,
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
+
+	.clear_tt_buffer_complete	= ehci_clear_tt_buffer_complete,
+};
+
+static u64 ehci_octeon_dma_mask = DMA_BIT_MASK(64);
+
+static int ehci_octeon_drv_probe(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+	struct ehci_hcd *ehci;
+	struct resource *res_mem;
+	int irq;
+	int ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "No irq assigned\n");
+		return -ENODEV;
+	}
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res_mem == NULL) {
+		dev_err(&pdev->dev, "No register space assigned\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * We can DMA from anywhere. But the descriptors must be in
+	 * the lower 4GB.
+	 */
+	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	pdev->dev.dma_mask = &ehci_octeon_dma_mask;
+
+	hcd = usb_create_hcd(&ehci_octeon_hc_driver, &pdev->dev, "octeon");
+	if (!hcd)
+		return -ENOMEM;
+
+	hcd->rsrc_start = res_mem->start;
+	hcd->rsrc_len = res_mem->end - res_mem->start + 1;
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len,
+				OCTEON_EHCI_HCD_NAME)) {
+		dev_err(&pdev->dev, "request_mem_region failed\n");
+		ret = -EBUSY;
+		goto err1;
+	}
+
+	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	ehci_octeon_start();
+
+	ehci = hcd_to_ehci(hcd);
+
+	/* Octeon EHCI matches CPU endianness. */
+#ifdef __BIG_ENDIAN
+	ehci->big_endian_mmio = 1;
+#endif
+
+	ehci->caps = hcd->regs;
+	ehci->regs = hcd->regs +
+		HC_LENGTH(ehci_readl(ehci, &ehci->caps->hc_capbase));
+	/* cache this readonly data; minimize chip reads */
+	ehci->hcs_params = ehci_readl(ehci, &ehci->caps->hcs_params);
+
+	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
+	if (ret) {
+		dev_dbg(&pdev->dev, "failed to add hcd with err %d\n", ret);
+		goto err3;
+	}
+
+	platform_set_drvdata(pdev, hcd);
+
+	/* root ports should always stay powered */
+	ehci_port_power(ehci, 1);
+
+	return 0;
+err3:
+	ehci_octeon_stop();
+
+	iounmap(hcd->regs);
+err2:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err1:
+	usb_put_hcd(hcd);
+	return ret;
+}
+
+static int ehci_octeon_drv_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	usb_remove_hcd(hcd);
+
+	ehci_octeon_stop();
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver ehci_octeon_driver = {
+	.probe		= ehci_octeon_drv_probe,
+	.remove		= ehci_octeon_drv_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver = {
+		.name	= OCTEON_EHCI_HCD_NAME,
+		.owner	= THIS_MODULE,
+	}
+};
+
+MODULE_ALIAS("platform:" OCTEON_EHCI_HCD_NAME);
diff --git a/drivers/usb/host/octeon2-common.c b/drivers/usb/host/octeon2-common.c
new file mode 100644
index 0000000..72d672c
--- /dev/null
+++ b/drivers/usb/host/octeon2-common.c
@@ -0,0 +1,185 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010 Cavium Networks
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+
+#include <asm/atomic.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-uctlx-defs.h>
+
+static atomic_t  octeon2_usb_clock_start_cnt = ATOMIC_INIT(0);
+
+void octeon2_usb_clocks_start(void)
+{
+	u64 div;
+	union cvmx_uctlx_if_ena if_ena;
+	union cvmx_uctlx_clk_rst_ctl clk_rst_ctl;
+	union cvmx_uctlx_uphy_ctl_status uphy_ctl_status;
+	union cvmx_uctlx_uphy_portx_ctl_status port_ctl_status;
+	int i;
+	unsigned long io_clk_64_to_ns;
+
+	if (atomic_inc_return(&octeon2_usb_clock_start_cnt) != 1)
+		return;
+
+	io_clk_64_to_ns = 64000000000ull / octeon_get_io_clock_rate();
+
+	/*
+	 * Step 1: Wait for voltages stable.  That surely happened
+	 * before starting the kernel.
+	 *
+	 * Step 2: Enable  SCLK of UCTL by writing UCTL0_IF_ENA[EN] = 1
+	 */
+	if_ena.u64 = 0;
+	if_ena.s.en = 1;
+	cvmx_write_csr(CVMX_UCTLX_IF_ENA(0), if_ena.u64);
+
+	/* Step 3: Configure the reference clock, PHY, and HCLK */
+	clk_rst_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_CLK_RST_CTL(0));
+	/* 3a */
+	clk_rst_ctl.s.p_por = 1;
+	clk_rst_ctl.s.hrst = 0;
+	clk_rst_ctl.s.p_prst = 0;
+	clk_rst_ctl.s.h_clkdiv_rst = 0;
+	clk_rst_ctl.s.o_clkdiv_rst = 0;
+	clk_rst_ctl.s.h_clkdiv_en = 0;
+	clk_rst_ctl.s.o_clkdiv_en = 0;
+	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
+
+	/* 3b */
+	/* 12MHz crystal. */
+	clk_rst_ctl.s.p_refclk_sel = 0;
+	clk_rst_ctl.s.p_refclk_div = 0;
+	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
+
+	/* 3c */
+	div = octeon_get_io_clock_rate() / 130000000ull;
+
+	switch (div) {
+	case 0:
+		div = 1;
+		break;
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+		break;
+	case 5:
+		div = 4;
+		break;
+	case 6:
+	case 7:
+		div = 6;
+		break;
+	case 8:
+	case 9:
+	case 10:
+	case 11:
+		div = 8;
+		break;
+	default:
+		div = 12;
+		break;
+	}
+	clk_rst_ctl.s.h_div = div;
+	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
+	/* Read it back, */
+	clk_rst_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_CLK_RST_CTL(0));
+	clk_rst_ctl.s.h_clkdiv_en = 1;
+	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
+	/* 3d */
+	clk_rst_ctl.s.h_clkdiv_rst = 1;
+	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
+
+	/* 3e: delay 64 io clocks */
+	ndelay(io_clk_64_to_ns);
+
+	/*
+	 * Step 4: Program the power-on reset field in the UCTL
+	 * clock-reset-control register.
+	 */
+	clk_rst_ctl.s.p_por = 0;
+	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
+
+	/* Step 5:    Wait 1 ms for the PHY clock to start. */
+	mdelay(1);
+
+	/*
+	 * Step 6: Program the reset input from automatic test
+	 * equipment field in the UPHY CSR
+	 */
+	uphy_ctl_status.u64 = cvmx_read_csr(CVMX_UCTLX_UPHY_CTL_STATUS(0));
+	uphy_ctl_status.s.ate_reset = 1;
+	cvmx_write_csr(CVMX_UCTLX_UPHY_CTL_STATUS(0), uphy_ctl_status.u64);
+
+	/* Step 7: Wait for at least 10ns. */
+	ndelay(10);
+
+	/* Step 8: Clear the ATE_RESET field in the UPHY CSR. */
+	uphy_ctl_status.s.ate_reset = 0;
+	cvmx_write_csr(CVMX_UCTLX_UPHY_CTL_STATUS(0), uphy_ctl_status.u64);
+
+	/*
+	 * Step 9: Wait for at least 20ns for UPHY to output PHY clock
+	 * signals and OHCI_CLK48
+	 */
+	ndelay(20);
+
+	/* Step 10: Configure the OHCI_CLK48 and OHCI_CLK12 clocks. */
+	/* 10a */
+	clk_rst_ctl.s.o_clkdiv_rst = 1;
+	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
+
+	/* 10b */
+	clk_rst_ctl.s.o_clkdiv_en = 1;
+	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
+
+	/* 10c */
+	ndelay(io_clk_64_to_ns);
+
+	/*
+	 * Step 11: Program the PHY reset field:
+	 * UCTL0_CLK_RST_CTL[P_PRST] = 1
+	 */
+	clk_rst_ctl.s.p_prst = 1;
+	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
+
+	/* Step 12: Wait 1 uS. */
+	udelay(1);
+
+	/* Step 13: Program the HRESET_N field: UCTL0_CLK_RST_CTL[HRST] = 1 */
+	clk_rst_ctl.s.hrst = 1;
+	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
+
+	/* Now we can set some other registers.  */
+
+	for (i = 0; i <= 1; i++) {
+		port_ctl_status.u64 =
+			cvmx_read_csr(CVMX_UCTLX_UPHY_PORTX_CTL_STATUS(i, 0));
+		/* Set txvreftune to 15 to obtain complient 'eye' diagram. */
+		port_ctl_status.s.txvreftune = 15;
+		cvmx_write_csr(CVMX_UCTLX_UPHY_PORTX_CTL_STATUS(i, 0),
+			       port_ctl_status.u64);
+	}
+}
+EXPORT_SYMBOL(octeon2_usb_clocks_start);
+
+void octeon2_usb_clocks_stop(void)
+{
+	union cvmx_uctlx_if_ena if_ena;
+
+	if (atomic_dec_return(&octeon2_usb_clock_start_cnt) != 0)
+		return;
+
+	if_ena.u64 = 0;
+	if_ena.s.en = 0;
+	cvmx_write_csr(CVMX_UCTLX_IF_ENA(0), if_ena.u64);
+}
+EXPORT_SYMBOL(octeon2_usb_clocks_stop);
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index c3b4ccc..dc3c675 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1100,6 +1100,11 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER	ohci_hcd_jz4740_driver
 #endif
 
+#ifdef CONFIG_USB_OCTEON_OHCI
+#include "ohci-octeon.c"
+#define PLATFORM_DRIVER		ohci_octeon_driver
+#endif
+
 #if	!defined(PCI_DRIVER) &&		\
 	!defined(PLATFORM_DRIVER) &&	\
 	!defined(OMAP1_PLATFORM_DRIVER) &&	\
diff --git a/drivers/usb/host/ohci-octeon.c b/drivers/usb/host/ohci-octeon.c
new file mode 100644
index 0000000..e4ddfaf
--- /dev/null
+++ b/drivers/usb/host/ohci-octeon.c
@@ -0,0 +1,214 @@
+/*
+ * EHCI HCD glue for Cavium Octeon II SOCs.
+ *
+ * Loosely based on ehci-au1xxx.c
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010 Cavium Networks
+ *
+ */
+
+#include <linux/platform_device.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-uctlx-defs.h>
+
+#define OCTEON_OHCI_HCD_NAME "octeon-ohci"
+
+/* Common clock init code.  */
+void octeon2_usb_clocks_start(void);
+void octeon2_usb_clocks_stop(void);
+
+static void ohci_octeon_hw_start(void)
+{
+	union cvmx_uctlx_ohci_ctl ohci_ctl;
+
+	octeon2_usb_clocks_start();
+
+	ohci_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_OHCI_CTL(0));
+	ohci_ctl.s.l2c_addr_msb = 0;
+	ohci_ctl.s.l2c_buff_emod = 1; /* Byte swapped. */
+	ohci_ctl.s.l2c_desc_emod = 1; /* Byte swapped. */
+	cvmx_write_csr(CVMX_UCTLX_OHCI_CTL(0), ohci_ctl.u64);
+
+}
+
+static void ohci_octeon_hw_stop(void)
+{
+	/* Undo ohci_octeon_start() */
+	octeon2_usb_clocks_stop();
+}
+
+static int __devinit ohci_octeon_start(struct usb_hcd *hcd)
+{
+	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	int ret;
+
+	ret = ohci_init(ohci);
+
+	if (ret < 0)
+		return ret;
+
+	ret = ohci_run(ohci);
+
+	if (ret < 0) {
+		ohci_err(ohci, "can't start %s", hcd->self.bus_name);
+		ohci_stop(hcd);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct hc_driver ohci_octeon_hc_driver = {
+	.description		= hcd_name,
+	.product_desc		= "Octeon OHCI",
+	.hcd_priv_size		= sizeof(struct ohci_hcd),
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
+	.start =		ohci_octeon_start,
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
+	.hub_control =		ohci_hub_control,
+
+	.start_port_reset =	ohci_start_port_reset,
+};
+
+static int ohci_octeon_drv_probe(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+	struct ohci_hcd *ohci;
+	void *reg_base;
+	struct resource *res_mem;
+	int irq;
+	int ret;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "No irq assigned\n");
+		return -ENODEV;
+	}
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res_mem == NULL) {
+		dev_err(&pdev->dev, "No register space assigned\n");
+		return -ENODEV;
+	}
+
+	/* Ohci is a 32-bit device. */
+	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+
+	hcd = usb_create_hcd(&ohci_octeon_hc_driver, &pdev->dev, "octeon");
+	if (!hcd)
+		return -ENOMEM;
+
+	hcd->rsrc_start = res_mem->start;
+	hcd->rsrc_len = res_mem->end - res_mem->start + 1;
+
+	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len,
+				OCTEON_OHCI_HCD_NAME)) {
+		dev_err(&pdev->dev, "request_mem_region failed\n");
+		ret = -EBUSY;
+		goto err1;
+	}
+
+	reg_base = ioremap(hcd->rsrc_start, hcd->rsrc_len);
+	if (!reg_base) {
+		dev_err(&pdev->dev, "ioremap failed\n");
+		ret = -ENOMEM;
+		goto err2;
+	}
+
+	ohci_octeon_hw_start();
+
+	hcd->regs = reg_base;
+
+	ohci = hcd_to_ohci(hcd);
+
+	/* Octeon OHCI matches CPU endianness. */
+#ifdef __BIG_ENDIAN
+	ohci->flags |= OHCI_QUIRK_BE_MMIO;
+#endif
+
+	ohci_hcd_init(ohci);
+
+	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
+	if (ret) {
+		dev_dbg(&pdev->dev, "failed to add hcd with err %d\n", ret);
+		goto err3;
+	}
+
+	platform_set_drvdata(pdev, hcd);
+
+	return 0;
+
+err3:
+	ohci_octeon_hw_stop();
+
+	iounmap(hcd->regs);
+err2:
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+err1:
+	usb_put_hcd(hcd);
+	return ret;
+}
+
+static int ohci_octeon_drv_remove(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	usb_remove_hcd(hcd);
+
+	ohci_octeon_hw_stop();
+	iounmap(hcd->regs);
+	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	usb_put_hcd(hcd);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver ohci_octeon_driver = {
+	.probe		= ohci_octeon_drv_probe,
+	.remove		= ohci_octeon_drv_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver = {
+		.name	= OCTEON_OHCI_HCD_NAME,
+		.owner	= THIS_MODULE,
+	}
+};
+
+MODULE_ALIAS("platform:" OCTEON_OHCI_HCD_NAME);
-- 
1.7.2.3
