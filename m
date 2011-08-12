Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 11:42:01 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:44389 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491206Ab1HLJj7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2011 11:39:59 +0200
Received: by fxd20 with SMTP id 20so2860493fxd.36
        for <multiple recipients>; Fri, 12 Aug 2011 02:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sQ2pP51/Enm7D3QUbn7lUslTBKKUSRzZ5ST+0872jNg=;
        b=mLFyMEosSTYKV0EnQRUG4xg1qp5e0YXHOOYHvqrn9dmiEwoTT+Ouxzlto63n3cSl7E
         c7qas12tiP/oDdYGk4JzZpP53j1wEHC1zsxpz4XbQ/CXI6shvMs4h4Dvoe6N8G6AkcNC
         pVDSHJ5Y95bpFJFJW91IS5Hz13Ms/BdcEusb0=
Received: by 10.223.161.80 with SMTP id q16mr965350fax.113.1313141994216;
        Fri, 12 Aug 2011 02:39:54 -0700 (PDT)
Received: from localhost.localdomain (178-191-11-228.adsl.highway.telekom.at [178.191.11.228])
        by mx.google.com with ESMTPS id s14sm467338fah.29.2011.08.12.02.39.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Aug 2011 02:39:53 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/8] MIPS: Alchemy: rewrite USB platform setup.
Date:   Fri, 12 Aug 2011 11:39:39 +0200
Message-Id: <1313141985-5830-3-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
References: <1313141985-5830-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9265

Use runtime CPU detection to setup all USB parts.
Remove the Au1200 OTG and UDC platform devices since there are no
drivers for them anyway.
Clean up the USB address mess in the au1000 header.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/platform.c        |  183 +++++++++++----------------
 arch/mips/include/asm/mach-au1x00/au1000.h |   55 ---------
 2 files changed, 75 insertions(+), 163 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 15d9b2f..910a3bd 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -111,34 +111,84 @@ static void __init alchemy_setup_uarts(int ctype)
 		printk(KERN_INFO "Alchemy: failed to register UARTs\n");
 }
 
-/* OHCI (USB full speed host controller) */
-static struct resource au1xxx_usb_ohci_resources[] = {
-	[0] = {
-		.start		= USB_OHCI_BASE,
-		.end		= USB_OHCI_BASE + USB_OHCI_LEN - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= FOR_PLATFORM_C_USB_HOST_INT,
-		.end		= FOR_PLATFORM_C_USB_HOST_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
 
-/* The dmamask must be set for OHCI to work */
-static u64 ohci_dmamask = DMA_BIT_MASK(32);
+/* The dmamask must be set for OHCI/EHCI to work */
+static u64 alchemy_ohci_dmamask = DMA_BIT_MASK(32);
+static u64 __maybe_unused alchemy_ehci_dmamask = DMA_BIT_MASK(32);
 
-static struct platform_device au1xxx_usb_ohci_device = {
-	.name		= "au1xxx-ohci",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &ohci_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(au1xxx_usb_ohci_resources),
-	.resource	= au1xxx_usb_ohci_resources,
+static unsigned long alchemy_ohci_data[][2] __initdata = {
+	[ALCHEMY_CPU_AU1000] = { AU1000_USB_OHCI_PHYS_ADDR, AU1000_USB_HOST_INT },
+	[ALCHEMY_CPU_AU1500] = { AU1000_USB_OHCI_PHYS_ADDR, AU1500_USB_HOST_INT },
+	[ALCHEMY_CPU_AU1100] = { AU1000_USB_OHCI_PHYS_ADDR, AU1100_USB_HOST_INT },
+	[ALCHEMY_CPU_AU1550] = { AU1550_USB_OHCI_PHYS_ADDR, AU1550_USB_HOST_INT },
+	[ALCHEMY_CPU_AU1200] = { AU1200_USB_OHCI_PHYS_ADDR, AU1200_USB_INT },
+};
+
+static unsigned long alchemy_ehci_data[][2] __initdata = {
+	[ALCHEMY_CPU_AU1200] = { AU1200_USB_EHCI_PHYS_ADDR, AU1200_USB_INT },
 };
 
+static int __init _new_usbres(struct resource **r, struct platform_device **d)
+{
+	*r = kzalloc(sizeof(struct resource) * 2, GFP_KERNEL);
+	if (!*r)
+		return -ENOMEM;
+	*d = kzalloc(sizeof(struct platform_device), GFP_KERNEL);
+	if (!*d) {
+		kfree(*r);
+		return -ENOMEM;
+	}
+
+	(*d)->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	(*d)->num_resources = 2;
+	(*d)->resource = *r;
+
+	return 0;
+}
+
+static void __init alchemy_setup_usb(int ctype)
+{
+	struct resource *res;
+	struct platform_device *pdev;
+
+	/* setup OHCI0.  Every variant has one */
+	if (_new_usbres(&res, &pdev))
+		return;
+
+	res[0].start = alchemy_ohci_data[ctype][0];
+	res[0].end = res[0].start + 0x100 - 1;
+	res[0].flags = IORESOURCE_MEM;
+	res[1].start = alchemy_ohci_data[ctype][1];
+	res[1].end = res[1].start;
+	res[1].flags = IORESOURCE_IRQ;
+	pdev->name = "au1xxx-ohci";
+	pdev->id = 0;
+	pdev->dev.dma_mask = &alchemy_ohci_dmamask;
+
+	if (platform_device_register(pdev))
+		printk(KERN_INFO "Alchemy USB: cannot add OHCI0\n");
+
+
+	/* setup EHCI0: Au1200 */
+	if (ctype == ALCHEMY_CPU_AU1200) {
+		if (_new_usbres(&res, &pdev))
+			return;
+
+		res[0].start = alchemy_ehci_data[ctype][0];
+		res[0].end = res[0].start + 0x100 - 1;
+		res[0].flags = IORESOURCE_MEM;
+		res[1].start = alchemy_ehci_data[ctype][1];
+		res[1].end = res[1].start;
+		res[1].flags = IORESOURCE_IRQ;
+		pdev->name = "au1xxx-ehci";
+		pdev->id = 0;
+		pdev->dev.dma_mask = &alchemy_ehci_dmamask;
+
+		if (platform_device_register(pdev))
+			printk(KERN_INFO "Alchemy USB: cannot add EHCI0\n");
+	}
+}
+
 /*** AU1100 LCD controller ***/
 
 #ifdef CONFIG_FB_AU1100
@@ -170,86 +220,6 @@ static struct platform_device au1100_lcd_device = {
 #endif
 
 #ifdef CONFIG_SOC_AU1200
-/* EHCI (USB high speed host controller) */
-static struct resource au1xxx_usb_ehci_resources[] = {
-	[0] = {
-		.start		= USB_EHCI_BASE,
-		.end		= USB_EHCI_BASE + USB_EHCI_LEN - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= AU1200_USB_INT,
-		.end		= AU1200_USB_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static u64 ehci_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device au1xxx_usb_ehci_device = {
-	.name		= "au1xxx-ehci",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &ehci_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(au1xxx_usb_ehci_resources),
-	.resource	= au1xxx_usb_ehci_resources,
-};
-
-/* Au1200 UDC (USB gadget controller) */
-static struct resource au1xxx_usb_gdt_resources[] = {
-	[0] = {
-		.start		= USB_UDC_BASE,
-		.end		= USB_UDC_BASE + USB_UDC_LEN - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= AU1200_USB_INT,
-		.end		= AU1200_USB_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static u64 udc_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device au1xxx_usb_gdt_device = {
-	.name		= "au1xxx-udc",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &udc_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(au1xxx_usb_gdt_resources),
-	.resource	= au1xxx_usb_gdt_resources,
-};
-
-/* Au1200 UOC (USB OTG controller) */
-static struct resource au1xxx_usb_otg_resources[] = {
-	[0] = {
-		.start		= USB_UOC_BASE,
-		.end		= USB_UOC_BASE + USB_UOC_LEN - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= AU1200_USB_INT,
-		.end		= AU1200_USB_INT,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static u64 uoc_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device au1xxx_usb_otg_device = {
-	.name		= "au1xxx-uoc",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &uoc_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(au1xxx_usb_otg_resources),
-	.resource	= au1xxx_usb_otg_resources,
-};
 
 static struct resource au1200_lcd_resources[] = {
 	[0] = {
@@ -534,14 +504,10 @@ static void __init alchemy_setup_macs(int ctype)
 }
 
 static struct platform_device *au1xxx_platform_devices[] __initdata = {
-	&au1xxx_usb_ohci_device,
 #ifdef CONFIG_FB_AU1100
 	&au1100_lcd_device,
 #endif
 #ifdef CONFIG_SOC_AU1200
-	&au1xxx_usb_ehci_device,
-	&au1xxx_usb_gdt_device,
-	&au1xxx_usb_otg_device,
 	&au1200_lcd_device,
 	&au1200_mmc0_device,
 #ifndef CONFIG_MIPS_DB1200
@@ -559,6 +525,7 @@ static int __init au1xxx_platform_init(void)
 
 	alchemy_setup_uarts(ctype);
 	alchemy_setup_macs(ctype);
+	alchemy_setup_usb(ctype);
 
 	err = platform_add_devices(au1xxx_platform_devices,
 				   ARRAY_SIZE(au1xxx_platform_devices));
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 73e0d79..86d39c3 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -833,56 +833,6 @@ enum soc_au1200_ints {
 #endif
 
 
-
-
-/* Au1000 */
-#ifdef CONFIG_SOC_AU1000
-
-#define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
-#define USB_HOST_CONFIG 	0xB017FFFC
-#define FOR_PLATFORM_C_USB_HOST_INT AU1000_USB_HOST_INT
-#endif /* CONFIG_SOC_AU1000 */
-
-/* Au1500 */
-#ifdef CONFIG_SOC_AU1500
-
-#define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
-#define USB_HOST_CONFIG 	0xB017fffc
-#define FOR_PLATFORM_C_USB_HOST_INT AU1500_USB_HOST_INT
-#endif /* CONFIG_SOC_AU1500 */
-
-/* Au1100 */
-#ifdef CONFIG_SOC_AU1100
-
-#define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
-#define USB_HOST_CONFIG 	0xB017FFFC
-#define FOR_PLATFORM_C_USB_HOST_INT AU1100_USB_HOST_INT
-#endif /* CONFIG_SOC_AU1100 */
-
-#ifdef CONFIG_SOC_AU1550
-
-#define USB_OHCI_BASE		0x14020000	/* phys addr for ioremap */
-#define USB_OHCI_LEN		0x00060000
-#define USB_HOST_CONFIG 	0xB4027ffc
-#define FOR_PLATFORM_C_USB_HOST_INT AU1550_USB_HOST_INT
-#endif /* CONFIG_SOC_AU1550 */
-
-
-#ifdef CONFIG_SOC_AU1200
-
-#define USB_UOC_BASE		0x14020020
-#define USB_UOC_LEN		0x20
-#define USB_OHCI_BASE		0x14020100
-#define USB_OHCI_LEN		0x100
-#define USB_EHCI_BASE		0x14020200
-#define USB_EHCI_LEN		0x100
-#define USB_UDC_BASE		0x14022000
-#define USB_UDC_LEN		0x2000
-
-#define FOR_PLATFORM_C_USB_HOST_INT AU1200_USB_INT
-
-#endif /* CONFIG_SOC_AU1200 */
-
 /* Programmable Counters 0 and 1 */
 #define SYS_BASE		0xB1900000
 #define SYS_COUNTER_CNTRL	(SYS_BASE + 0x14)
@@ -953,11 +903,6 @@ enum soc_au1200_ints {
 #  define I2S_CONTROL_D 	(1 << 1)
 #  define I2S_CONTROL_CE	(1 << 0)
 
-/* USB Host Controller */
-#ifndef USB_OHCI_LEN
-#define USB_OHCI_LEN		0x00100000
-#endif
-
 
 /* Ethernet Controllers  */
 
-- 
1.7.6
