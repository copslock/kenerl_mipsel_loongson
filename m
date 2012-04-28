Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2012 15:17:38 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1461 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903723Ab2D1NNJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Apr 2012 15:13:09 +0200
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 28 Apr 2012 06:13:01 -0700
X-Server-Uuid: 72204117-5C29-4314-8910-60DB108979CB
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Sat, 28 Apr 2012 06:12:07 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id E48279F9F5; Sat, 28
 Apr 2012 06:12:45 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Sat, 28 Apr 2012 06:12:45 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 08/12] MIPS: Netlogic: Platform changes for XLS USB
Date:   Sat, 28 Apr 2012 18:42:14 +0530
Message-ID: <1335618738-4679-9-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 638533573JG2109471-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add USB initialization code, setup resources and add USB platform
driver in mips/netlogic/xlr/platform.c.
Add USB support for XLR/XLS platform in Kconfig.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/Kconfig                 |    2 +
 arch/mips/netlogic/xlr/platform.c |   89 +++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ce30e2f..b3811dd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -780,6 +780,8 @@ config NLM_XLR_BOARD
 	select ZONE_DMA if 64BIT
 	select SYNC_R4K
 	select SYS_HAS_EARLY_PRINTK
+	select USB_ARCH_HAS_OHCI if USB_SUPPORT
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	help
 	  Support for systems based on Netlogic XLR and XLS processors.
 	  Say Y here if you have a XLR or XLS based board.
diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
index eab64b4..cb0ab63 100644
--- a/arch/mips/netlogic/xlr/platform.c
+++ b/arch/mips/netlogic/xlr/platform.c
@@ -97,3 +97,92 @@ static int __init nlm_uart_init(void)
 }
 
 arch_initcall(nlm_uart_init);
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
+static struct platform_device *xls_platform_devices[] = {
+	&xls_usb_ehci_device,
+	&xls_usb_ohci_device_0,
+	&xls_usb_ohci_device_1,
+};
+
+int xls_platform_usb_init(void)
+{
+	uint64_t usb_mmio, gpio_mmio;
+	unsigned long memres;
+	uint32_t val;
+
+	if (!nlm_chip_is_xls())
+		return 0;
+
+	gpio_mmio = nlm_mmio_base(NETLOGIC_IO_GPIO_OFFSET);
+	usb_mmio  = nlm_mmio_base(NETLOGIC_IO_USB_1_OFFSET);
+
+	/* Clear Rogue Phy INTs */
+	nlm_write_reg(usb_mmio, 49, 0x10000000);
+	/* Enable all interrupts */
+	nlm_write_reg(usb_mmio, 50, 0x1f000000);
+
+	/* Enable ports */
+	nlm_write_reg(usb_mmio,  1, 0x07000500);
+
+	val = nlm_read_reg(gpio_mmio, 21);
+	if (((val >> 22) & 0x01) == 0) {
+		pr_info("Detected USB Device mode - Not supported!\n");
+		nlm_write_reg(usb_mmio,  0, 0x01000000);
+		return 0;
+	}
+
+	pr_info("Detected USB Host mode - Adding XLS USB devices.\n");
+	/* Clear reset, host mode */
+	nlm_write_reg(usb_mmio,  0, 0x02000000);
+
+	/* Memory resource for various XLS usb ports */
+	usb_mmio = nlm_mmio_base(NETLOGIC_IO_USB_0_OFFSET);
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
-- 
1.7.9.5
