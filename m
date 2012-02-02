Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2012 15:39:55 +0100 (CET)
Received: from smtpgw1.netlogicmicro.com ([12.203.210.53]:46747 "EHLO
        smtpgw1.netlogicmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904108Ab2BBOjN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2012 15:39:13 +0100
Received: from pps.filterd (smtpgw1 [127.0.0.1])
        by smtpgw1.netlogicmicro.com (8.14.5/8.14.5) with SMTP id q12EaoPq002226;
        Thu, 2 Feb 2012 06:39:07 -0800
Received: from hqcas02.netlogicmicro.com (hqcas02.netlogicmicro.com [10.65.50.15])
        by smtpgw1.netlogicmicro.com with ESMTP id 12hfu7nyfh-1
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 02 Feb 2012 06:39:07 -0800
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Jayachandran C <jayachandranc@netlogicmicro.com>
Subject: [PATCH 02/11] MIPS: Netlogic: platform changes for XLS USB.
Date:   Thu, 2 Feb 2012 20:12:56 +0530
Message-ID: <0d464a65285476cd74024a5fae81f8f302df1bb0.1328189941.git.jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1328189941.git.jayachandranc@netlogicmicro.com>
References: <cover.1328189941.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.7.0.77]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.6.7361,1.0.211,0.0.0000
 definitions=2012-01-28_02:2012-01-27,2012-01-28,1970-01-01 signatures=0
X-archive-position: 32385
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
 2 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c4c1312..baabbe5 100644
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
1.7.5.4
