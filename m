Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 21:09:54 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:52940 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493110Ab0AaUId (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 Jan 2010 21:08:33 +0100
Received: from list by lo.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1Nbg5t-0006It-PN
        for linux-mips@linux-mips.org; Sun, 31 Jan 2010 21:08:29 +0100
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2010 21:08:29 +0100
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2010 21:08:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alexander Clouter <alex@digriz.org.uk>
Subject: [PATCH 1/3] MIPS: AR7 whitespace hacking
Date:   Sun, 31 Jan 2010 19:38:19 +0000
Message-ID: <bq2h37-ch6.ln1@chipmunk.wormnet.eu>
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
X-archive-position: 25795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

MIPS: AR7 whitespace hacking

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/mips/ar7/gpio.c     |    6 +-
 arch/mips/ar7/memory.c   |    3 +-
 arch/mips/ar7/platform.c |  587 ++++++++++++++++++++++++----------------------
 arch/mips/ar7/prom.c     |   49 ++--
 arch/mips/ar7/setup.c    |   15 +-
 5 files changed, 343 insertions(+), 317 deletions(-)

diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
index 0e9f4e1..c32fbb5 100644
--- a/arch/mips/ar7/gpio.c
+++ b/arch/mips/ar7/gpio.c
@@ -24,8 +24,8 @@
 #include <asm/mach-ar7/gpio.h>
 
 struct ar7_gpio_chip {
-	void __iomem	*regs;
-	struct gpio_chip chip;
+	void __iomem		*regs;
+	struct gpio_chip	chip;
 };
 
 static int ar7_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
@@ -77,7 +77,7 @@ static int ar7_gpio_direction_output(struct gpio_chip *chip,
 
 static struct ar7_gpio_chip ar7_gpio_chip = {
 	.chip = {
-		.label		= "ar7-gpio",
+		.label			= "ar7-gpio",
 		.direction_input	= ar7_gpio_direction_input,
 		.direction_output	= ar7_gpio_direction_output,
 		.set			= ar7_gpio_set_value,
diff --git a/arch/mips/ar7/memory.c b/arch/mips/ar7/memory.c
index 696c723..28abfee 100644
--- a/arch/mips/ar7/memory.c
+++ b/arch/mips/ar7/memory.c
@@ -62,8 +62,7 @@ void __init prom_meminit(void)
 	unsigned long pages;
 
 	pages = memsize() >> PAGE_SHIFT;
-	add_memory_region(PHYS_OFFSET, pages << PAGE_SHIFT,
-			  BOOT_MEM_RAM);
+	add_memory_region(PHYS_OFFSET, pages << PAGE_SHIFT, BOOT_MEM_RAM);
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index c591f69..76a358e 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -42,39 +42,42 @@
 #include <asm/mach-ar7/gpio.h>
 #include <asm/mach-ar7/prom.h>
 
+/*****************************************************************************
+ * VLYNQ Bus
+ ****************************************************************************/
 struct plat_vlynq_data {
 	struct plat_vlynq_ops ops;
 	int gpio_bit;
 	int reset_bit;
 };
 
-
 static int vlynq_on(struct vlynq_device *dev)
 {
-	int result;
+	int ret;
 	struct plat_vlynq_data *pdata = dev->dev.platform_data;
 
-	result = gpio_request(pdata->gpio_bit, "vlynq");
-	if (result)
+	ret = gpio_request(pdata->gpio_bit, "vlynq");
+	if (ret)
 		goto out;
 
 	ar7_device_reset(pdata->reset_bit);
 
-	result = ar7_gpio_disable(pdata->gpio_bit);
-	if (result)
+	ret = ar7_gpio_disable(pdata->gpio_bit);
+	if (ret)
 		goto out_enabled;
 
-	result = ar7_gpio_enable(pdata->gpio_bit);
-	if (result)
+	ret = ar7_gpio_enable(pdata->gpio_bit);
+	if (ret)
 		goto out_enabled;
 
-	result = gpio_direction_output(pdata->gpio_bit, 0);
-	if (result)
+	ret = gpio_direction_output(pdata->gpio_bit, 0);
+	if (ret)
 		goto out_gpio_enabled;
 
 	msleep(50);
 
 	gpio_set_value(pdata->gpio_bit, 1);
+
 	msleep(50);
 
 	return 0;
@@ -85,320 +88,384 @@ out_enabled:
 	ar7_device_disable(pdata->reset_bit);
 	gpio_free(pdata->gpio_bit);
 out:
-	return result;
+	return ret;
 }
 
 static void vlynq_off(struct vlynq_device *dev)
 {
 	struct plat_vlynq_data *pdata = dev->dev.platform_data;
+
 	ar7_gpio_disable(pdata->gpio_bit);
 	gpio_free(pdata->gpio_bit);
 	ar7_device_disable(pdata->reset_bit);
 }
 
-static struct resource physmap_flash_resource = {
-	.name = "mem",
-	.flags = IORESOURCE_MEM,
-	.start = 0x10000000,
-	.end = 0x107fffff,
-};
-
-static struct resource cpmac_low_res[] = {
+static struct resource vlynq_low_res[] = {
 	{
-		.name = "regs",
-		.flags = IORESOURCE_MEM,
-		.start = AR7_REGS_MAC0,
-		.end = AR7_REGS_MAC0 + 0x7ff,
+		.name	= "regs",
+		.flags	= IORESOURCE_MEM,
+		.start	= AR7_REGS_VLYNQ0,
+		.end	= AR7_REGS_VLYNQ0 + 0xff,
 	},
 	{
-		.name = "irq",
-		.flags = IORESOURCE_IRQ,
-		.start = 27,
-		.end = 27,
+		.name	= "irq",
+		.flags	= IORESOURCE_IRQ,
+		.start	= 29,
+		.end	= 29,
 	},
-};
-
-static struct resource cpmac_high_res[] = {
 	{
-		.name = "regs",
-		.flags = IORESOURCE_MEM,
-		.start = AR7_REGS_MAC1,
-		.end = AR7_REGS_MAC1 + 0x7ff,
+		.name	= "mem",
+		.flags	= IORESOURCE_MEM,
+		.start	= 0x04000000,
+		.end	= 0x04ffffff,
 	},
 	{
-		.name = "irq",
-		.flags = IORESOURCE_IRQ,
-		.start = 41,
-		.end = 41,
+		.name	= "devirq",
+		.flags	= IORESOURCE_IRQ,
+		.start	= 80,
+		.end	= 111,
 	},
 };
 
-static struct resource vlynq_low_res[] = {
+static struct resource vlynq_high_res[] = {
 	{
-		.name = "regs",
-		.flags = IORESOURCE_MEM,
-		.start = AR7_REGS_VLYNQ0,
-		.end = AR7_REGS_VLYNQ0 + 0xff,
+		.name	= "regs",
+		.flags	= IORESOURCE_MEM,
+		.start	= AR7_REGS_VLYNQ1,
+		.end	= AR7_REGS_VLYNQ1 + 0xff,
 	},
 	{
-		.name = "irq",
-		.flags = IORESOURCE_IRQ,
-		.start = 29,
-		.end = 29,
+		.name	= "irq",
+		.flags	= IORESOURCE_IRQ,
+		.start	= 33,
+		.end	= 33,
 	},
 	{
-		.name = "mem",
-		.flags = IORESOURCE_MEM,
-		.start = 0x04000000,
-		.end = 0x04ffffff,
+		.name	= "mem",
+		.flags	= IORESOURCE_MEM,
+		.start	= 0x0c000000,
+		.end	= 0x0cffffff,
 	},
 	{
-		.name = "devirq",
-		.flags = IORESOURCE_IRQ,
-		.start = 80,
-		.end = 111,
+		.name	= "devirq",
+		.flags	= IORESOURCE_IRQ,
+		.start	= 112,
+		.end	= 143,
 	},
 };
 
-static struct resource vlynq_high_res[] = {
-	{
-		.name = "regs",
-		.flags = IORESOURCE_MEM,
-		.start = AR7_REGS_VLYNQ1,
-		.end = AR7_REGS_VLYNQ1 + 0xff,
+static struct plat_vlynq_data vlynq_low_data = {
+	.ops = {
+		.on	= vlynq_on,
+		.off	= vlynq_off,
 	},
-	{
-		.name = "irq",
-		.flags = IORESOURCE_IRQ,
-		.start = 33,
-		.end = 33,
+	.reset_bit	= 20,
+	.gpio_bit	= 18,
+};
+
+static struct plat_vlynq_data vlynq_high_data = {
+	.ops = {
+		.on	= vlynq_on,
+		.off	= vlynq_off,
 	},
-	{
-		.name = "mem",
-		.flags = IORESOURCE_MEM,
-		.start = 0x0c000000,
-		.end = 0x0cffffff,
+	.reset_bit	= 26,
+	.gpio_bit	= 19,
+};
+
+static struct platform_device vlynq_low = {
+	.id		= 0,
+	.name		= "vlynq",
+	.dev = {
+		.platform_data	= &vlynq_low_data,
 	},
-	{
-		.name = "devirq",
-		.flags = IORESOURCE_IRQ,
-		.start = 112,
-		.end = 143,
+	.resource	= vlynq_low_res,
+	.num_resources	= ARRAY_SIZE(vlynq_low_res),
+};
+
+static struct platform_device vlynq_high = {
+	.id		= 1,
+	.name		= "vlynq",
+	.dev = {
+		.platform_data	= &vlynq_high_data,
 	},
+	.resource	= vlynq_high_res,
+	.num_resources	= ARRAY_SIZE(vlynq_high_res),
 };
 
-static struct resource usb_res[] = {
-	{
-		.name = "regs",
-		.flags = IORESOURCE_MEM,
-		.start = AR7_REGS_USB,
-		.end = AR7_REGS_USB + 0xff,
+/*****************************************************************************
+ * Flash
+ ****************************************************************************/
+static struct resource physmap_flash_resource = {
+	.name	= "mem",
+	.flags	= IORESOURCE_MEM,
+	.start	= 0x10000000,
+	.end	= 0x107fffff,
+};
+
+static struct physmap_flash_data physmap_flash_data = {
+	.width	= 2,
+};
+
+static struct platform_device physmap_flash = {
+	.name		= "physmap-flash",
+	.dev = {
+		.platform_data	= &physmap_flash_data,
 	},
+	.resource	= &physmap_flash_resource,
+	.num_resources	= 1,
+};
+
+/*****************************************************************************
+ * Ethernet
+ ****************************************************************************/
+static struct resource cpmac_low_res[] = {
 	{
-		.name = "irq",
-		.flags = IORESOURCE_IRQ,
-		.start = 32,
-		.end = 32,
+		.name	= "regs",
+		.flags	= IORESOURCE_MEM,
+		.start	= AR7_REGS_MAC0,
+		.end	= AR7_REGS_MAC0 + 0x7ff,
 	},
 	{
-		.name = "mem",
-		.flags = IORESOURCE_MEM,
-		.start = 0x03400000,
-		.end = 0x034001fff,
+		.name	= "irq",
+		.flags	= IORESOURCE_IRQ,
+		.start	= 27,
+		.end 	= 27,
 	},
 };
 
-static struct physmap_flash_data physmap_flash_data = {
-	.width = 2,
+static struct resource cpmac_high_res[] = {
+	{
+		.name	= "regs",
+		.flags	= IORESOURCE_MEM,
+		.start	= AR7_REGS_MAC1,
+		.end	= AR7_REGS_MAC1 + 0x7ff,
+	},
+	{
+		.name	= "irq",
+		.flags	= IORESOURCE_IRQ,
+		.start	= 41,
+		.end	= 41,
+	},
 };
 
 static struct fixed_phy_status fixed_phy_status __initdata = {
-	.link = 1,
-	.speed = 100,
-	.duplex = 1,
+	.link		= 1,
+	.speed		= 100,
+	.duplex		= 1,
 };
 
 static struct plat_cpmac_data cpmac_low_data = {
-	.reset_bit = 17,
-	.power_bit = 20,
-	.phy_mask = 0x80000000,
+	.reset_bit	= 17,
+	.power_bit	= 20,
+	.phy_mask	= 0x80000000,
 };
 
 static struct plat_cpmac_data cpmac_high_data = {
-	.reset_bit = 21,
-	.power_bit = 22,
-	.phy_mask = 0x7fffffff,
-};
-
-static struct plat_vlynq_data vlynq_low_data = {
-	.ops.on = vlynq_on,
-	.ops.off = vlynq_off,
-	.reset_bit = 20,
-	.gpio_bit = 18,
-};
-
-static struct plat_vlynq_data vlynq_high_data = {
-	.ops.on = vlynq_on,
-	.ops.off = vlynq_off,
-	.reset_bit = 16,
-	.gpio_bit = 19,
-};
-
-static struct platform_device physmap_flash = {
-	.id = 0,
-	.name = "physmap-flash",
-	.dev.platform_data = &physmap_flash_data,
-	.resource = &physmap_flash_resource,
-	.num_resources = 1,
+	.reset_bit	= 21,
+	.power_bit	= 22,
+	.phy_mask	= 0x7fffffff,
 };
 
 static u64 cpmac_dma_mask = DMA_BIT_MASK(32);
+
 static struct platform_device cpmac_low = {
-	.id = 0,
-	.name = "cpmac",
+	.id		= 0,
+	.name		= "cpmac",
 	.dev = {
-		.dma_mask = &cpmac_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data = &cpmac_low_data,
+		.dma_mask		= &cpmac_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &cpmac_low_data,
 	},
-	.resource = cpmac_low_res,
-	.num_resources = ARRAY_SIZE(cpmac_low_res),
+	.resource	= cpmac_low_res,
+	.num_resources	= ARRAY_SIZE(cpmac_low_res),
 };
 
 static struct platform_device cpmac_high = {
-	.id = 1,
-	.name = "cpmac",
+	.id		= 1,
+	.name		= "cpmac",
 	.dev = {
-		.dma_mask = &cpmac_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.platform_data = &cpmac_high_data,
+		.dma_mask		= &cpmac_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &cpmac_high_data,
 	},
-	.resource = cpmac_high_res,
-	.num_resources = ARRAY_SIZE(cpmac_high_res),
+	.resource	= cpmac_high_res,
+	.num_resources	= ARRAY_SIZE(cpmac_high_res),
 };
 
-static struct platform_device vlynq_low = {
-	.id = 0,
-	.name = "vlynq",
-	.dev.platform_data = &vlynq_low_data,
-	.resource = vlynq_low_res,
-	.num_resources = ARRAY_SIZE(vlynq_low_res),
-};
+static inline unsigned char char2hex(char h)
+{
+	switch (h) {
+	case '0': case '1': case '2': case '3': case '4':
+	case '5': case '6': case '7': case '8': case '9':
+		return h - '0';
+	case 'A': case 'B': case 'C': case 'D': case 'E': case 'F':
+		return h - 'A' + 10;
+	case 'a': case 'b': case 'c': case 'd': case 'e': case 'f':
+		return h - 'a' + 10;
+	default:
+		return 0;
+	}
+}
 
-static struct platform_device vlynq_high = {
-	.id = 1,
-	.name = "vlynq",
-	.dev.platform_data = &vlynq_high_data,
-	.resource = vlynq_high_res,
-	.num_resources = ARRAY_SIZE(vlynq_high_res),
+static void cpmac_get_mac(int instance, unsigned char *dev_addr)
+{
+	int i;
+	char name[5], default_mac[ETH_ALEN], *mac;
+
+	mac = NULL;
+	sprintf(name, "mac%c", 'a' + instance);
+	mac = prom_getenv(name);
+	if (!mac) {
+		sprintf(name, "mac%c", 'a');
+		mac = prom_getenv(name);
+	}
+	if (!mac) {
+		random_ether_addr(default_mac);
+		mac = default_mac;
+	}
+	for (i = 0; i < 6; i++)
+		dev_addr[i] = (char2hex(mac[i * 3]) << 4) +
+			char2hex(mac[i * 3 + 1]);
+}
+
+/*****************************************************************************
+ * USB
+ ****************************************************************************/
+static struct resource usb_res[] = {
+	{
+		.name	= "regs",
+		.flags	= IORESOURCE_MEM,
+		.start	= AR7_REGS_USB,
+		.end	= AR7_REGS_USB + 0xff,
+	},
+	{
+		.name	= "irq",
+		.flags	= IORESOURCE_IRQ,
+		.start	= 32,
+		.end	= 32,
+	},
+	{
+		.name	= "mem",
+		.flags	= IORESOURCE_MEM,
+		.start	= 0x03400000,
+		.end	= 0x034001fff,
+	},
 };
 
+static struct platform_device ar7_udc = {
+	.name		= "ar7_udc",
+	.resource	= usb_res,
+	.num_resources	= ARRAY_SIZE(usb_res),
+};
 
+/*****************************************************************************
+ * LEDs
+ ****************************************************************************/
 static struct gpio_led default_leds[] = {
 	{
-		.name = "status",
-		.gpio = 8,
-		.active_low = 1,
+		.name			= "status",
+		.gpio			= 8,
+		.active_low		= 1,
 	},
 };
 
 static struct gpio_led dsl502t_leds[] = {
 	{
-		.name = "status",
-		.gpio = 9,
-		.active_low = 1,
+		.name			= "status",
+		.gpio			= 9,
+		.active_low		= 1,
 	},
 	{
-		.name = "ethernet",
-		.gpio = 7,
-		.active_low = 1,
+		.name			= "ethernet",
+		.gpio			= 7,
+		.active_low		= 1,
 	},
 	{
-		.name = "usb",
-		.gpio = 12,
-		.active_low = 1,
+		.name			= "usb",
+		.gpio			= 12,
+		.active_low		= 1,
 	},
 };
 
 static struct gpio_led dg834g_leds[] = {
 	{
-		.name = "ppp",
-		.gpio = 6,
-		.active_low = 1,
+		.name			= "ppp",
+		.gpio			= 6,
+		.active_low		= 1,
 	},
 	{
-		.name = "status",
-		.gpio = 7,
-		.active_low = 1,
+		.name			= "status",
+		.gpio			= 7,
+		.active_low		= 1,
 	},
 	{
-		.name = "adsl",
-		.gpio = 8,
-		.active_low = 1,
+		.name			= "adsl",
+		.gpio			= 8,
+		.active_low		= 1,
 	},
 	{
-		.name = "wifi",
-		.gpio = 12,
-		.active_low = 1,
+		.name			= "wifi",
+		.gpio			= 12,
+		.active_low		= 1,
 	},
 	{
-		.name = "power",
-		.gpio = 14,
-		.active_low = 1,
-		.default_trigger = "default-on",
+		.name			= "power",
+		.gpio			= 14,
+		.active_low		= 1,
+		.default_trigger	= "default-on",
 	},
 };
 
 static struct gpio_led fb_sl_leds[] = {
 	{
-		.name = "1",
-		.gpio = 7,
+		.name			= "1",
+		.gpio			= 7,
 	},
 	{
-		.name = "2",
-		.gpio = 13,
-		.active_low = 1,
+		.name			= "2",
+		.gpio			= 13,
+		.active_low		= 1,
 	},
 	{
-		.name = "3",
-		.gpio = 10,
-		.active_low = 1,
+		.name			= "3",
+		.gpio			= 10,
+		.active_low		= 1,
 	},
 	{
-		.name = "4",
-		.gpio = 12,
-		.active_low = 1,
+		.name			= "4",
+		.gpio			= 12,
+		.active_low		= 1,
 	},
 	{
-		.name = "5",
-		.gpio = 9,
-		.active_low = 1,
+		.name			= "5",
+		.gpio			= 9,
+		.active_low		= 1,
 	},
 };
 
 static struct gpio_led fb_fon_leds[] = {
 	{
-		.name = "1",
-		.gpio = 8,
+		.name			= "1",
+		.gpio			= 8,
 	},
 	{
-		.name = "2",
-		.gpio = 3,
-		.active_low = 1,
+		.name			= "2",
+		.gpio			= 3,
+		.active_low		= 1,
 	},
 	{
-		.name = "3",
-		.gpio = 5,
+		.name			= "3",
+		.gpio			= 5,
 	},
 	{
-		.name = "4",
-		.gpio = 4,
-		.active_low = 1,
+		.name			= "4",
+		.gpio			= 4,
+		.active_low		= 1,
 	},
 	{
-		.name = "5",
-		.gpio = 11,
-		.active_low = 1,
+		.name			= "5",
+		.gpio			= 11,
+		.active_low		= 1,
 	},
 };
 
@@ -406,69 +473,11 @@ static struct gpio_led_platform_data ar7_led_data;
 
 static struct platform_device ar7_gpio_leds = {
 	.name = "leds-gpio",
-	.id = -1,
 	.dev = {
 		.platform_data = &ar7_led_data,
 	}
 };
 
-static struct platform_device ar7_udc = {
-	.id = -1,
-	.name = "ar7_udc",
-	.resource = usb_res,
-	.num_resources = ARRAY_SIZE(usb_res),
-};
-
-static struct resource ar7_wdt_res = {
-	.name = "regs",
-	.start = -1, /* Filled at runtime */
-	.end = -1, /* Filled at runtime */
-	.flags = IORESOURCE_MEM,
-};
-
-static struct platform_device ar7_wdt = {
-	.id = -1,
-	.name  = "ar7_wdt",
-	.resource = &ar7_wdt_res,
-	.num_resources = 1,
-};
-
-static inline unsigned char char2hex(char h)
-{
-	switch (h) {
-	case '0': case '1': case '2': case '3': case '4':
-	case '5': case '6': case '7': case '8': case '9':
-		return h - '0';
-	case 'A': case 'B': case 'C': case 'D': case 'E': case 'F':
-		return h - 'A' + 10;
-	case 'a': case 'b': case 'c': case 'd': case 'e': case 'f':
-		return h - 'a' + 10;
-	default:
-		return 0;
-	}
-}
-
-static void cpmac_get_mac(int instance, unsigned char *dev_addr)
-{
-	int i;
-	char name[5], default_mac[ETH_ALEN], *mac;
-
-	mac = NULL;
-	sprintf(name, "mac%c", 'a' + instance);
-	mac = prom_getenv(name);
-	if (!mac) {
-		sprintf(name, "mac%c", 'a');
-		mac = prom_getenv(name);
-	}
-	if (!mac) {
-		random_ether_addr(default_mac);
-		mac = default_mac;
-	}
-	for (i = 0; i < 6; i++)
-		dev_addr[i] = (char2hex(mac[i * 3]) << 4) +
-			char2hex(mac[i * 3 + 1]);
-}
-
 static void __init detect_leds(void)
 {
 	char *prid, *usb_prod;
@@ -501,6 +510,25 @@ static void __init detect_leds(void)
 	}
 }
 
+/*****************************************************************************
+ * Watchdog
+ ****************************************************************************/
+static struct resource ar7_wdt_res = {
+	.name		= "regs",
+	.flags		= IORESOURCE_MEM,
+	.start		= -1,	/* Filled at runtime */
+	.end		= -1,	/* Filled at runtime */
+};
+
+static struct platform_device ar7_wdt = {
+	.name		= "ar7_wdt",
+	.resource	= &ar7_wdt_res,
+	.num_resources	= 1,
+};
+
+/*****************************************************************************
+ * Init
+ ****************************************************************************/
 static int __init ar7_register_devices(void)
 {
 	u16 chip_id;
@@ -516,29 +544,28 @@ static int __init ar7_register_devices(void)
 	if (IS_ERR(bus_clk))
 		panic("unable to get bus clk\n");
 
-	uart_port[0].type = PORT_16550A;
-	uart_port[0].line = 0;
-	uart_port[0].irq = AR7_IRQ_UART0;
-	uart_port[0].uartclk = clk_get_rate(bus_clk) / 2;
-	uart_port[0].iotype = UPIO_MEM32;
-	uart_port[0].mapbase = AR7_REGS_UART0;
-	uart_port[0].membase = ioremap(uart_port[0].mapbase, 256);
-	uart_port[0].regshift = 2;
+	uart_port[0].type	= PORT_16550A;
+	uart_port[0].line	= 0;
+	uart_port[0].irq	= AR7_IRQ_UART0;
+	uart_port[0].uartclk	= clk_get_rate(bus_clk) / 2;
+	uart_port[0].iotype	= UPIO_MEM32;
+	uart_port[0].mapbase	= AR7_REGS_UART0;
+	uart_port[0].membase	= ioremap(uart_port[0].mapbase, 256);
+	uart_port[0].regshift	= 2;
 	res = early_serial_setup(&uart_port[0]);
 	if (res)
 		return res;
 
-
 	/* Only TNETD73xx have a second serial port */
 	if (ar7_has_second_uart()) {
-		uart_port[1].type = PORT_16550A;
-		uart_port[1].line = 1;
-		uart_port[1].irq = AR7_IRQ_UART1;
-		uart_port[1].uartclk = clk_get_rate(bus_clk) / 2;
-		uart_port[1].iotype = UPIO_MEM32;
-		uart_port[1].mapbase = UR8_REGS_UART1;
-		uart_port[1].membase = ioremap(uart_port[1].mapbase, 256);
-		uart_port[1].regshift = 2;
+		uart_port[1].type	= PORT_16550A;
+		uart_port[1].line	= 1;
+		uart_port[1].irq	= AR7_IRQ_UART1;
+		uart_port[1].uartclk	= clk_get_rate(bus_clk) / 2;
+		uart_port[1].iotype	= UPIO_MEM32;
+		uart_port[1].mapbase	= UR8_REGS_UART1;
+		uart_port[1].membase 	= ioremap(uart_port[1].mapbase, 256);
+		uart_port[1].regshift	= 2;
 		res = early_serial_setup(&uart_port[1]);
 		if (res)
 			return res;
diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index c1fdd36..19701e0 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -32,8 +32,8 @@
 #define MAX_ENTRY 80
 
 struct env_var {
-	char *name;
-	char *value;
+	char	*name;
+	char	*value;
 };
 
 static struct env_var adam2_env[MAX_ENTRY];
@@ -41,6 +41,7 @@ static struct env_var adam2_env[MAX_ENTRY];
 char *prom_getenv(const char *name)
 {
 	int i;
+
 	for (i = 0; (i < MAX_ENTRY) && adam2_env[i].name; i++)
 		if (!strcmp(name, adam2_env[i].name))
 			return adam2_env[i].value;
@@ -76,38 +77,38 @@ static void  __init ar7_init_cmdline(int argc, char *argv[])
 }
 
 struct psbl_rec {
-	u32 psbl_size;
-	u32 env_base;
-	u32 env_size;
-	u32 ffs_base;
-	u32 ffs_size;
+	u32	psbl_size;
+	u32	env_base;
+	u32	env_size;
+	u32	ffs_base;
+	u32	ffs_size;
 };
 
 static __initdata char psp_env_version[] = "TIENV0.8";
 
 struct psp_env_chunk {
-	u8 num;
-	u8 ctrl;
-	u16 csum;
-	u8 len;
-	char data[11];
+	u8	num;
+	u8	ctrl;
+	u16	csum;
+	u8	len;
+	char	data[11];
 } __attribute__ ((packed));
 
 struct psp_var_map_entry {
-	u8 num;
-	char *value;
+	u8	num;
+	char	*value;
 };
 
 static struct psp_var_map_entry psp_var_map[] = {
-	{ 1, "cpufrequency" },
-	{ 2, "memsize" },
-	{ 3, "flashsize" },
-	{ 4, "modetty0" },
-	{ 5, "modetty1" },
-	{ 8, "maca" },
-	{ 9, "macb" },
-	{ 28, "sysfrequency" },
-	{ 38, "mipsfrequency" },
+	{  1,	"cpufrequency" },
+	{  2,	"memsize" },
+	{  3,	"flashsize" },
+	{  4,	"modetty0" },
+	{  5,	"modetty1" },
+	{  8,	"maca" },
+	{  9,	"macb" },
+	{ 28,	"sysfrequency" },
+	{ 38,	"mipsfrequency" },
 };
 
 /*
@@ -154,6 +155,7 @@ static char * __init lookup_psp_var_map(u8 num)
 static void __init add_adam2_var(char *name, char *value)
 {
 	int i;
+
 	for (i = 0; i < MAX_ENTRY; i++) {
 		if (!adam2_env[i].name) {
 			adam2_env[i].name = name;
@@ -279,4 +281,3 @@ int prom_putchar(char c)
 	serial_out(UART_TX, c);
 	return 1;
 }
-
diff --git a/arch/mips/ar7/setup.c b/arch/mips/ar7/setup.c
index 39f6b5b..3a801d2 100644
--- a/arch/mips/ar7/setup.c
+++ b/arch/mips/ar7/setup.c
@@ -26,8 +26,8 @@
 
 static void ar7_machine_restart(char *command)
 {
-	u32 *softres_reg = ioremap(AR7_REGS_RESET +
-					  AR7_RESET_SOFTWARE, 1);
+	u32 *softres_reg = ioremap(AR7_REGS_RESET + AR7_RESET_SOFTWARE, 1);
+
 	writel(1, softres_reg);
 }
 
@@ -41,6 +41,7 @@ static void ar7_machine_power_off(void)
 {
 	u32 *power_reg = (u32 *)ioremap(AR7_REGS_POWER, 1);
 	u32 power_state = readl(power_reg) | (3 << 30);
+
 	writel(power_state, power_reg);
 	ar7_machine_halt();
 }
@@ -49,14 +50,14 @@ const char *get_system_type(void)
 {
 	u16 chip_id = ar7_chip_id();
 	switch (chip_id) {
-	case AR7_CHIP_7300:
-		return "TI AR7 (TNETD7300)";
 	case AR7_CHIP_7100:
 		return "TI AR7 (TNETD7100)";
 	case AR7_CHIP_7200:
 		return "TI AR7 (TNETD7200)";
+	case AR7_CHIP_7300:
+		return "TI AR7 (TNETD7300)";
 	default:
-		return "TI AR7 (Unknown)";
+		return "TI AR7 (unknown)";
 	}
 }
 
@@ -70,7 +71,6 @@ console_initcall(ar7_init_console);
  * Initializes basic routines and structures pointers, memory size (as
  * given by the bios and saves the command line.
  */
-
 void __init plat_mem_setup(void)
 {
 	unsigned long io_base;
@@ -88,6 +88,5 @@ void __init plat_mem_setup(void)
 	prom_meminit();
 
 	printk(KERN_INFO "%s, ID: 0x%04x, Revision: 0x%02x\n",
-					get_system_type(),
-		ar7_chip_id(), ar7_chip_rev());
+			get_system_type(), ar7_chip_id(), ar7_chip_rev());
 }
-- 
1.6.6
