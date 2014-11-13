Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 22:38:02 +0100 (CET)
Received: from mail-bn1on0074.outbound.protection.outlook.com ([157.56.110.74]:18415
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013642AbaKMVhti8JjM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Nov 2014 22:37:49 +0100
Received: from BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141) by
 BN1PR07MB885.namprd07.prod.outlook.com (10.242.212.16) with Microsoft SMTP
 Server (TLS) id 15.1.16.15; Thu, 13 Nov 2014 21:37:42 +0000
Received: from localhost.localdomain (2.165.41.20) by
 BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141) with Microsoft SMTP
 Server (TLS) id 15.1.16.15; Thu, 13 Nov 2014 21:37:39 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: [PATCH 1/3] USB: host: Remove ehci-octeon and ohci-octeon drivers
Date:   Thu, 13 Nov 2014 22:36:28 +0100
Message-ID: <1415914590-31647-2-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2.165.41.20]
X-ClientProxiedBy: AM2PR03CA0029.eurprd03.prod.outlook.com (25.160.207.39) To
 BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141)
X-Microsoft-Antispam: UriScan:;UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB389;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB389;
X-Forefront-PRVS: 0394259C80
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(6009001)(22564002)(189002)(199003)(120916001)(110136001)(15202345003)(4396001)(97736003)(76176999)(33646002)(102836001)(87286001)(50466002)(88136002)(122386002)(2171001)(87976001)(50226001)(19580395003)(89996001)(15395725005)(104166001)(50986999)(19580405001)(47776003)(92726001)(92566001)(64706001)(86362001)(93916002)(575784001)(48376002)(95666004)(42186005)(40100003)(106356001)(66066001)(21056001)(101416001)(20776003)(62966003)(229853001)(15975445006)(77096003)(77156002)(36756003)(107046002)(31966008)(46102003)(105586002)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR07MB389;H:localhost.localdomain;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB389;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BN1PR07MB885;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

From: Alan Stern <stern@rowland.harvard.edu>

From: Alan Stern <stern@rowland.harvard.edu>

Remove special-purpose octeon drivers and instead use ehci-platform
and ohci-platform as suggested with
http://marc.info/?l=linux-mips&m=140139694721623&w=2

[andreas.herrmann:
	fixed compile error]

Cc: David Daney <david.daney@cavium.com>
Cc: Alex Smith <alex.smith@imgtec.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-platform.c |  274 ++++++++++++++++++++++++++++-
 arch/mips/configs/cavium_octeon_defconfig |    3 +
 drivers/usb/host/Kconfig                  |   18 +-
 drivers/usb/host/Makefile                 |    1 -
 drivers/usb/host/ehci-hcd.c               |    5 -
 drivers/usb/host/ehci-octeon.c            |  188 --------------------
 drivers/usb/host/octeon2-common.c         |  200 ---------------------
 drivers/usb/host/ohci-hcd.c               |    5 -
 drivers/usb/host/ohci-octeon.c            |  202 ---------------------
 9 files changed, 285 insertions(+), 611 deletions(-)
 delete mode 100644 drivers/usb/host/ehci-octeon.c
 delete mode 100644 drivers/usb/host/octeon2-common.c
 delete mode 100644 drivers/usb/host/ohci-octeon.c

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 6df0f4d..b67ddf0 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -7,22 +7,27 @@
  * Copyright (C) 2008 Wind River Systems
  */
 
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/i2c.h>
 #include <linux/usb.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <linux/usb/ehci_pdriver.h>
+#include <linux/usb/ohci_pdriver.h>
 
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-rnm-defs.h>
 #include <asm/octeon/cvmx-helper.h>
 #include <asm/octeon/cvmx-helper-board.h>
+#include <asm/octeon/cvmx-uctlx-defs.h>
 
 /* Octeon Random Number Generator.  */
 static int __init octeon_rng_device_init(void)
@@ -68,6 +73,229 @@ device_initcall(octeon_rng_device_init);
 
 #ifdef CONFIG_USB
 
+static DEFINE_MUTEX(octeon2_usb_clocks_mutex);
+
+static int octeon2_usb_clock_start_cnt;
+
+static void octeon2_usb_clocks_start(void)
+{
+	u64 div;
+	union cvmx_uctlx_if_ena if_ena;
+	union cvmx_uctlx_clk_rst_ctl clk_rst_ctl;
+	union cvmx_uctlx_uphy_ctl_status uphy_ctl_status;
+	union cvmx_uctlx_uphy_portx_ctl_status port_ctl_status;
+	int i;
+	unsigned long io_clk_64_to_ns;
+
+
+	mutex_lock(&octeon2_usb_clocks_mutex);
+
+	octeon2_usb_clock_start_cnt++;
+	if (octeon2_usb_clock_start_cnt != 1)
+		goto exit;
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
+
+	/*
+	 * If the UCTL looks like it has already been started, skip
+	 * the initialization, otherwise bus errors are obtained.
+	 */
+	if (clk_rst_ctl.s.hrst)
+		goto end_clock;
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
+end_clock:
+	/* Now we can set some other registers.  */
+
+	for (i = 0; i <= 1; i++) {
+		port_ctl_status.u64 =
+			cvmx_read_csr(CVMX_UCTLX_UPHY_PORTX_CTL_STATUS(i, 0));
+		/* Set txvreftune to 15 to obtain compliant 'eye' diagram. */
+		port_ctl_status.s.txvreftune = 15;
+		port_ctl_status.s.txrisetune = 1;
+		port_ctl_status.s.txpreemphasistune = 1;
+		cvmx_write_csr(CVMX_UCTLX_UPHY_PORTX_CTL_STATUS(i, 0),
+			       port_ctl_status.u64);
+	}
+
+	/* Set uSOF cycle period to 60,000 bits. */
+	cvmx_write_csr(CVMX_UCTLX_EHCI_FLA(0), 0x20ull);
+exit:
+	mutex_unlock(&octeon2_usb_clocks_mutex);
+}
+
+static void octeon2_usb_clocks_stop(void)
+{
+	mutex_lock(&octeon2_usb_clocks_mutex);
+	octeon2_usb_clock_start_cnt--;
+	mutex_unlock(&octeon2_usb_clocks_mutex);
+}
+
+static int octeon_ehci_power_on(struct platform_device *pdev)
+{
+	octeon2_usb_clocks_start();
+	return 0;
+}
+
+static void octeon_ehci_power_off(struct platform_device *pdev)
+{
+	octeon2_usb_clocks_stop();
+}
+
+static struct usb_ehci_pdata octeon_ehci_pdata = {
+	/* Octeon EHCI matches CPU endianness. */
+#ifdef __BIG_ENDIAN
+	.big_endian_mmio	= 1,
+#endif
+	.power_on	= octeon_ehci_power_on,
+	.power_off	= octeon_ehci_power_off,
+};
+
+static void __init octeon_ehci_hw_start(void)
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
+
+	octeon2_usb_clocks_stop();
+}
+
+static u64 octeon_ehci_dma_mask = DMA_BIT_MASK(64);
+
 static int __init octeon_ehci_device_init(void)
 {
 	struct platform_device *pd;
@@ -88,7 +316,7 @@ static int __init octeon_ehci_device_init(void)
 	if (octeon_is_simulation() || usb_disabled())
 		return 0; /* No USB in the simulator. */
 
-	pd = platform_device_alloc("octeon-ehci", 0);
+	pd = platform_device_alloc("ehci-platform", 0);
 	if (!pd) {
 		ret = -ENOMEM;
 		goto out;
@@ -105,6 +333,10 @@ static int __init octeon_ehci_device_init(void)
 	if (ret)
 		goto fail;
 
+	pd->dev.dma_mask = &octeon_ehci_dma_mask;
+	pd->dev.platform_data = &octeon_ehci_pdata;
+	octeon_ehci_hw_start();
+
 	ret = platform_device_add(pd);
 	if (ret)
 		goto fail;
@@ -117,6 +349,41 @@ out:
 }
 device_initcall(octeon_ehci_device_init);
 
+static int octeon_ohci_power_on(struct platform_device *pdev)
+{
+	octeon2_usb_clocks_start();
+	return 0;
+}
+
+static void octeon_ohci_power_off(struct platform_device *pdev)
+{
+	octeon2_usb_clocks_stop();
+}
+
+static struct usb_ohci_pdata octeon_ohci_pdata = {
+	/* Octeon OHCI matches CPU endianness. */
+#ifdef __BIG_ENDIAN
+	.big_endian_mmio	= 1,
+#endif
+	.power_on	= octeon_ohci_power_on,
+	.power_off	= octeon_ohci_power_off,
+};
+
+static void __init octeon_ohci_hw_start(void)
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
+	octeon2_usb_clocks_stop();
+}
+
 static int __init octeon_ohci_device_init(void)
 {
 	struct platform_device *pd;
@@ -137,7 +404,7 @@ static int __init octeon_ohci_device_init(void)
 	if (octeon_is_simulation() || usb_disabled())
 		return 0; /* No USB in the simulator. */
 
-	pd = platform_device_alloc("octeon-ohci", 0);
+	pd = platform_device_alloc("ohci-platform", 0);
 	if (!pd) {
 		ret = -ENOMEM;
 		goto out;
@@ -154,6 +421,9 @@ static int __init octeon_ohci_device_init(void)
 	if (ret)
 		goto fail;
 
+	pd->dev.platform_data = &octeon_ohci_pdata;
+	octeon_ohci_hw_start();
+
 	ret = platform_device_add(pd);
 	if (ret)
 		goto fail;
diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index b2476a1..e57058d 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -120,6 +120,9 @@ CONFIG_SPI_OCTEON=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 # CONFIG_USB_SUPPORT is not set
+CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
+CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_STAGING=y
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index a3ca137..fafc628 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -292,11 +292,15 @@ config USB_EHCI_HCD_PLATFORM
 	  If unsure, say N.
 
 config USB_OCTEON_EHCI
-	bool "Octeon on-chip EHCI support"
+	bool "Octeon on-chip EHCI support (DEPRECATED)"
 	depends on CAVIUM_OCTEON_SOC
 	default n
 	select USB_EHCI_BIG_ENDIAN_MMIO
+	select USB_EHCI_HCD_PLATFORM
 	help
+	  This option is deprecated now and the driver was removed, use
+	  USB_EHCI_HCD_PLATFORM instead.
+
 	  Enable support for the Octeon II SOC's on-chip EHCI
 	  controller.  It is needed for high-speed (480Mbit/sec)
 	  USB 2.0 device support.  All CN6XXX based chips with USB are
@@ -575,12 +579,16 @@ config USB_OHCI_HCD_PLATFORM
 	  If unsure, say N.
 
 config USB_OCTEON_OHCI
-	bool "Octeon on-chip OHCI support"
+	bool "Octeon on-chip OHCI support (DEPRECATED)"
 	depends on CAVIUM_OCTEON_SOC
 	default USB_OCTEON_EHCI
 	select USB_OHCI_BIG_ENDIAN_MMIO
 	select USB_OHCI_LITTLE_ENDIAN
+	select USB_OHCI_HCD_PLATFORM
 	help
+	  This option is deprecated now and the driver was removed, use
+	  USB_OHCI_HCD_PLATFORM instead.
+
 	  Enable support for the Octeon II SOC's on-chip OHCI
 	  controller.  It is needed for low-speed USB 1.0 device
 	  support.  All CN6XXX based chips with USB are supported.
@@ -754,12 +762,6 @@ config USB_IMX21_HCD
          To compile this driver as a module, choose M here: the
          module will be called "imx21-hcd".
 
-
-
-config USB_OCTEON2_COMMON
-	bool
-	default y if USB_OCTEON_EHCI || USB_OCTEON_OHCI
-
 config USB_HCD_BCMA
 	tristate "BCMA usb host driver"
 	depends on BCMA
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 348c243..d6216a4 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -73,7 +73,6 @@ obj-$(CONFIG_USB_ISP1760_HCD)	+= isp1760.o
 obj-$(CONFIG_USB_HWA_HCD)	+= hwa-hc.o
 obj-$(CONFIG_USB_IMX21_HCD)	+= imx21-hcd.o
 obj-$(CONFIG_USB_FSL_MPH_DR_OF)	+= fsl-mph-dr-of.o
-obj-$(CONFIG_USB_OCTEON2_COMMON) += octeon2-common.o
 obj-$(CONFIG_USB_HCD_BCMA)	+= bcma-hcd.o
 obj-$(CONFIG_USB_HCD_SSB)	+= ssb-hcd.o
 obj-$(CONFIG_USB_FUSBH200_HCD)	+= fusbh200-hcd.o
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 15feaf9..5ea27a0 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1268,11 +1268,6 @@ MODULE_LICENSE ("GPL");
 #define XILINX_OF_PLATFORM_DRIVER	ehci_hcd_xilinx_of_driver
 #endif
 
-#ifdef CONFIG_USB_OCTEON_EHCI
-#include "ehci-octeon.c"
-#define PLATFORM_DRIVER		ehci_octeon_driver
-#endif
-
 #ifdef CONFIG_TILE_USB
 #include "ehci-tilegx.c"
 #define	PLATFORM_DRIVER		ehci_hcd_tilegx_driver
diff --git a/drivers/usb/host/ehci-octeon.c b/drivers/usb/host/ehci-octeon.c
deleted file mode 100644
index 9051439..0000000
--- a/drivers/usb/host/ehci-octeon.c
+++ /dev/null
@@ -1,188 +0,0 @@
-/*
- * EHCI HCD glue for Cavium Octeon II SOCs.
- *
- * Loosely based on ehci-au1xxx.c
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2010 Cavium Networks
- *
- */
-
-#include <linux/platform_device.h>
-
-#include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-uctlx-defs.h>
-
-#define OCTEON_EHCI_HCD_NAME "octeon-ehci"
-
-/* Common clock init code.  */
-void octeon2_usb_clocks_start(void);
-void octeon2_usb_clocks_stop(void);
-
-static void ehci_octeon_start(void)
-{
-	union cvmx_uctlx_ehci_ctl ehci_ctl;
-
-	octeon2_usb_clocks_start();
-
-	ehci_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_EHCI_CTL(0));
-	/* Use 64-bit addressing. */
-	ehci_ctl.s.ehci_64b_addr_en = 1;
-	ehci_ctl.s.l2c_addr_msb = 0;
-	ehci_ctl.s.l2c_buff_emod = 1; /* Byte swapped. */
-	ehci_ctl.s.l2c_desc_emod = 1; /* Byte swapped. */
-	cvmx_write_csr(CVMX_UCTLX_EHCI_CTL(0), ehci_ctl.u64);
-}
-
-static void ehci_octeon_stop(void)
-{
-	octeon2_usb_clocks_stop();
-}
-
-static const struct hc_driver ehci_octeon_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "Octeon EHCI",
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
-	 */
-	.reset			= ehci_setup,
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
-static u64 ehci_octeon_dma_mask = DMA_BIT_MASK(64);
-
-static int ehci_octeon_drv_probe(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd;
-	struct ehci_hcd *ehci;
-	struct resource *res_mem;
-	int irq;
-	int ret;
-
-	if (usb_disabled())
-		return -ENODEV;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "No irq assigned\n");
-		return -ENODEV;
-	}
-
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res_mem == NULL) {
-		dev_err(&pdev->dev, "No register space assigned\n");
-		return -ENODEV;
-	}
-
-	/*
-	 * We can DMA from anywhere. But the descriptors must be in
-	 * the lower 4GB.
-	 */
-	pdev->dev.dma_mask = &ehci_octeon_dma_mask;
-	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
-	hcd = usb_create_hcd(&ehci_octeon_hc_driver, &pdev->dev, "octeon");
-	if (!hcd)
-		return -ENOMEM;
-
-	hcd->rsrc_start = res_mem->start;
-	hcd->rsrc_len = resource_size(res_mem);
-
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res_mem);
-	if (IS_ERR(hcd->regs)) {
-		ret = PTR_ERR(hcd->regs);
-		goto err1;
-	}
-
-	ehci_octeon_start();
-
-	ehci = hcd_to_ehci(hcd);
-
-	/* Octeon EHCI matches CPU endianness. */
-#ifdef __BIG_ENDIAN
-	ehci->big_endian_mmio = 1;
-#endif
-
-	ehci->caps = hcd->regs;
-
-	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
-	if (ret) {
-		dev_dbg(&pdev->dev, "failed to add hcd with err %d\n", ret);
-		goto err2;
-	}
-	device_wakeup_enable(hcd->self.controller);
-
-	platform_set_drvdata(pdev, hcd);
-
-	return 0;
-err2:
-	ehci_octeon_stop();
-
-err1:
-	usb_put_hcd(hcd);
-	return ret;
-}
-
-static int ehci_octeon_drv_remove(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-
-	usb_remove_hcd(hcd);
-
-	ehci_octeon_stop();
-	usb_put_hcd(hcd);
-
-	return 0;
-}
-
-static struct platform_driver ehci_octeon_driver = {
-	.probe		= ehci_octeon_drv_probe,
-	.remove		= ehci_octeon_drv_remove,
-	.shutdown	= usb_hcd_platform_shutdown,
-	.driver = {
-		.name	= OCTEON_EHCI_HCD_NAME,
-		.owner	= THIS_MODULE,
-	}
-};
-
-MODULE_ALIAS("platform:" OCTEON_EHCI_HCD_NAME);
diff --git a/drivers/usb/host/octeon2-common.c b/drivers/usb/host/octeon2-common.c
deleted file mode 100644
index d9df423..0000000
--- a/drivers/usb/host/octeon2-common.c
+++ /dev/null
@@ -1,200 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2010, 2011 Cavium Networks
- */
-
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/delay.h>
-
-#include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-uctlx-defs.h>
-
-static DEFINE_MUTEX(octeon2_usb_clocks_mutex);
-
-static int octeon2_usb_clock_start_cnt;
-
-void octeon2_usb_clocks_start(void)
-{
-	u64 div;
-	union cvmx_uctlx_if_ena if_ena;
-	union cvmx_uctlx_clk_rst_ctl clk_rst_ctl;
-	union cvmx_uctlx_uphy_ctl_status uphy_ctl_status;
-	union cvmx_uctlx_uphy_portx_ctl_status port_ctl_status;
-	int i;
-	unsigned long io_clk_64_to_ns;
-
-
-	mutex_lock(&octeon2_usb_clocks_mutex);
-
-	octeon2_usb_clock_start_cnt++;
-	if (octeon2_usb_clock_start_cnt != 1)
-		goto exit;
-
-	io_clk_64_to_ns = 64000000000ull / octeon_get_io_clock_rate();
-
-	/*
-	 * Step 1: Wait for voltages stable.  That surely happened
-	 * before starting the kernel.
-	 *
-	 * Step 2: Enable  SCLK of UCTL by writing UCTL0_IF_ENA[EN] = 1
-	 */
-	if_ena.u64 = 0;
-	if_ena.s.en = 1;
-	cvmx_write_csr(CVMX_UCTLX_IF_ENA(0), if_ena.u64);
-
-	/* Step 3: Configure the reference clock, PHY, and HCLK */
-	clk_rst_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_CLK_RST_CTL(0));
-
-	/*
-	 * If the UCTL looks like it has already been started, skip
-	 * the initialization, otherwise bus errors are obtained.
-	 */
-	if (clk_rst_ctl.s.hrst)
-		goto end_clock;
-	/* 3a */
-	clk_rst_ctl.s.p_por = 1;
-	clk_rst_ctl.s.hrst = 0;
-	clk_rst_ctl.s.p_prst = 0;
-	clk_rst_ctl.s.h_clkdiv_rst = 0;
-	clk_rst_ctl.s.o_clkdiv_rst = 0;
-	clk_rst_ctl.s.h_clkdiv_en = 0;
-	clk_rst_ctl.s.o_clkdiv_en = 0;
-	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
-
-	/* 3b */
-	/* 12MHz crystal. */
-	clk_rst_ctl.s.p_refclk_sel = 0;
-	clk_rst_ctl.s.p_refclk_div = 0;
-	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
-
-	/* 3c */
-	div = octeon_get_io_clock_rate() / 130000000ull;
-
-	switch (div) {
-	case 0:
-		div = 1;
-		break;
-	case 1:
-	case 2:
-	case 3:
-	case 4:
-		break;
-	case 5:
-		div = 4;
-		break;
-	case 6:
-	case 7:
-		div = 6;
-		break;
-	case 8:
-	case 9:
-	case 10:
-	case 11:
-		div = 8;
-		break;
-	default:
-		div = 12;
-		break;
-	}
-	clk_rst_ctl.s.h_div = div;
-	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
-	/* Read it back, */
-	clk_rst_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_CLK_RST_CTL(0));
-	clk_rst_ctl.s.h_clkdiv_en = 1;
-	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
-	/* 3d */
-	clk_rst_ctl.s.h_clkdiv_rst = 1;
-	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
-
-	/* 3e: delay 64 io clocks */
-	ndelay(io_clk_64_to_ns);
-
-	/*
-	 * Step 4: Program the power-on reset field in the UCTL
-	 * clock-reset-control register.
-	 */
-	clk_rst_ctl.s.p_por = 0;
-	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
-
-	/* Step 5:    Wait 1 ms for the PHY clock to start. */
-	mdelay(1);
-
-	/*
-	 * Step 6: Program the reset input from automatic test
-	 * equipment field in the UPHY CSR
-	 */
-	uphy_ctl_status.u64 = cvmx_read_csr(CVMX_UCTLX_UPHY_CTL_STATUS(0));
-	uphy_ctl_status.s.ate_reset = 1;
-	cvmx_write_csr(CVMX_UCTLX_UPHY_CTL_STATUS(0), uphy_ctl_status.u64);
-
-	/* Step 7: Wait for at least 10ns. */
-	ndelay(10);
-
-	/* Step 8: Clear the ATE_RESET field in the UPHY CSR. */
-	uphy_ctl_status.s.ate_reset = 0;
-	cvmx_write_csr(CVMX_UCTLX_UPHY_CTL_STATUS(0), uphy_ctl_status.u64);
-
-	/*
-	 * Step 9: Wait for at least 20ns for UPHY to output PHY clock
-	 * signals and OHCI_CLK48
-	 */
-	ndelay(20);
-
-	/* Step 10: Configure the OHCI_CLK48 and OHCI_CLK12 clocks. */
-	/* 10a */
-	clk_rst_ctl.s.o_clkdiv_rst = 1;
-	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
-
-	/* 10b */
-	clk_rst_ctl.s.o_clkdiv_en = 1;
-	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
-
-	/* 10c */
-	ndelay(io_clk_64_to_ns);
-
-	/*
-	 * Step 11: Program the PHY reset field:
-	 * UCTL0_CLK_RST_CTL[P_PRST] = 1
-	 */
-	clk_rst_ctl.s.p_prst = 1;
-	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
-
-	/* Step 12: Wait 1 uS. */
-	udelay(1);
-
-	/* Step 13: Program the HRESET_N field: UCTL0_CLK_RST_CTL[HRST] = 1 */
-	clk_rst_ctl.s.hrst = 1;
-	cvmx_write_csr(CVMX_UCTLX_CLK_RST_CTL(0), clk_rst_ctl.u64);
-
-end_clock:
-	/* Now we can set some other registers.  */
-
-	for (i = 0; i <= 1; i++) {
-		port_ctl_status.u64 =
-			cvmx_read_csr(CVMX_UCTLX_UPHY_PORTX_CTL_STATUS(i, 0));
-		/* Set txvreftune to 15 to obtain compliant 'eye' diagram. */
-		port_ctl_status.s.txvreftune = 15;
-		port_ctl_status.s.txrisetune = 1;
-		port_ctl_status.s.txpreemphasistune = 1;
-		cvmx_write_csr(CVMX_UCTLX_UPHY_PORTX_CTL_STATUS(i, 0),
-			       port_ctl_status.u64);
-	}
-
-	/* Set uSOF cycle period to 60,000 bits. */
-	cvmx_write_csr(CVMX_UCTLX_EHCI_FLA(0), 0x20ull);
-exit:
-	mutex_unlock(&octeon2_usb_clocks_mutex);
-}
-EXPORT_SYMBOL(octeon2_usb_clocks_start);
-
-void octeon2_usb_clocks_stop(void)
-{
-	mutex_lock(&octeon2_usb_clocks_mutex);
-	octeon2_usb_clock_start_cnt--;
-	mutex_unlock(&octeon2_usb_clocks_mutex);
-}
-EXPORT_SYMBOL(octeon2_usb_clocks_stop);
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index d664eda..1dab9df 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1249,11 +1249,6 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER	ohci_hcd_jz4740_driver
 #endif
 
-#ifdef CONFIG_USB_OCTEON_OHCI
-#include "ohci-octeon.c"
-#define PLATFORM_DRIVER		ohci_octeon_driver
-#endif
-
 #ifdef CONFIG_TILE_USB
 #include "ohci-tilegx.c"
 #define PLATFORM_DRIVER		ohci_hcd_tilegx_driver
diff --git a/drivers/usb/host/ohci-octeon.c b/drivers/usb/host/ohci-octeon.c
deleted file mode 100644
index 15af895..0000000
--- a/drivers/usb/host/ohci-octeon.c
+++ /dev/null
@@ -1,202 +0,0 @@
-/*
- * EHCI HCD glue for Cavium Octeon II SOCs.
- *
- * Loosely based on ehci-au1xxx.c
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2010 Cavium Networks
- *
- */
-
-#include <linux/platform_device.h>
-
-#include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-uctlx-defs.h>
-
-#define OCTEON_OHCI_HCD_NAME "octeon-ohci"
-
-/* Common clock init code.  */
-void octeon2_usb_clocks_start(void);
-void octeon2_usb_clocks_stop(void);
-
-static void ohci_octeon_hw_start(void)
-{
-	union cvmx_uctlx_ohci_ctl ohci_ctl;
-
-	octeon2_usb_clocks_start();
-
-	ohci_ctl.u64 = cvmx_read_csr(CVMX_UCTLX_OHCI_CTL(0));
-	ohci_ctl.s.l2c_addr_msb = 0;
-	ohci_ctl.s.l2c_buff_emod = 1; /* Byte swapped. */
-	ohci_ctl.s.l2c_desc_emod = 1; /* Byte swapped. */
-	cvmx_write_csr(CVMX_UCTLX_OHCI_CTL(0), ohci_ctl.u64);
-
-}
-
-static void ohci_octeon_hw_stop(void)
-{
-	/* Undo ohci_octeon_start() */
-	octeon2_usb_clocks_stop();
-}
-
-static int ohci_octeon_start(struct usb_hcd *hcd)
-{
-	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
-	int ret;
-
-	ret = ohci_init(ohci);
-
-	if (ret < 0)
-		return ret;
-
-	ret = ohci_run(ohci);
-
-	if (ret < 0) {
-		ohci_err(ohci, "can't start %s", hcd->self.bus_name);
-		ohci_stop(hcd);
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct hc_driver ohci_octeon_hc_driver = {
-	.description		= hcd_name,
-	.product_desc		= "Octeon OHCI",
-	.hcd_priv_size		= sizeof(struct ohci_hcd),
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
-	.start =		ohci_octeon_start,
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
-	.hub_control =		ohci_hub_control,
-
-	.start_port_reset =	ohci_start_port_reset,
-};
-
-static int ohci_octeon_drv_probe(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd;
-	struct ohci_hcd *ohci;
-	void *reg_base;
-	struct resource *res_mem;
-	int irq;
-	int ret;
-
-	if (usb_disabled())
-		return -ENODEV;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "No irq assigned\n");
-		return -ENODEV;
-	}
-
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res_mem == NULL) {
-		dev_err(&pdev->dev, "No register space assigned\n");
-		return -ENODEV;
-	}
-
-	/* Ohci is a 32-bit device. */
-	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
-	hcd = usb_create_hcd(&ohci_octeon_hc_driver, &pdev->dev, "octeon");
-	if (!hcd)
-		return -ENOMEM;
-
-	hcd->rsrc_start = res_mem->start;
-	hcd->rsrc_len = resource_size(res_mem);
-
-	reg_base = devm_ioremap_resource(&pdev->dev, res_mem);
-	if (IS_ERR(reg_base)) {
-		ret = PTR_ERR(reg_base);
-		goto err1;
-	}
-
-	ohci_octeon_hw_start();
-
-	hcd->regs = reg_base;
-
-	ohci = hcd_to_ohci(hcd);
-
-	/* Octeon OHCI matches CPU endianness. */
-#ifdef __BIG_ENDIAN
-	ohci->flags |= OHCI_QUIRK_BE_MMIO;
-#endif
-
-	ohci_hcd_init(ohci);
-
-	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
-	if (ret) {
-		dev_dbg(&pdev->dev, "failed to add hcd with err %d\n", ret);
-		goto err2;
-	}
-
-	device_wakeup_enable(hcd->self.controller);
-
-	platform_set_drvdata(pdev, hcd);
-
-	return 0;
-
-err2:
-	ohci_octeon_hw_stop();
-
-err1:
-	usb_put_hcd(hcd);
-	return ret;
-}
-
-static int ohci_octeon_drv_remove(struct platform_device *pdev)
-{
-	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-
-	usb_remove_hcd(hcd);
-
-	ohci_octeon_hw_stop();
-	usb_put_hcd(hcd);
-
-	return 0;
-}
-
-static struct platform_driver ohci_octeon_driver = {
-	.probe		= ohci_octeon_drv_probe,
-	.remove		= ohci_octeon_drv_remove,
-	.shutdown	= usb_hcd_platform_shutdown,
-	.driver = {
-		.name	= OCTEON_OHCI_HCD_NAME,
-		.owner	= THIS_MODULE,
-	}
-};
-
-MODULE_ALIAS("platform:" OCTEON_OHCI_HCD_NAME);
-- 
1.7.9.5
