Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 May 2011 10:45:52 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:37163 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491143Ab1EHImh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 May 2011 10:42:37 +0200
Received: by wyb28 with SMTP id 28so4138997wyb.36
        for <linux-mips@linux-mips.org>; Sun, 08 May 2011 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=aCPdHc/HEA8rxEDCbC7wzZOZf0G6iAQfFegRmvr9J5w=;
        b=ipyCrpVIpM7qXdXiWNOMJOxpgFKaFh7/KGizyGdsFtFNms0J5PljTiQLQ+l9EglyE7
         /hIk30sJv1ToPOFeaScB2Zu/ueSlRs/Zh+QX61KH4sbQ/RkKDA2GLkrFhaPUX78u+Cpz
         OsI5K+3L0qtN97XVDoa5nWmOLbYcqOCwAsEv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gLj51AN3AT9CmKR1jE+7xhXUijDp+4dS37v3m8UzJXiEfGtxIkL1lcwSk67WkvImCo
         PypL1JQBlLj66d1fsJwXdogHlPOoNwxKSgElWYqEGeqv2md8y3OKYOI3cSugLKTxMey8
         s/XUQ2w2KDGDwqTs7tSc/5bShZQpqUs2imUPA=
Received: by 10.227.205.202 with SMTP id fr10mr5706224wbb.60.1304844152460;
        Sun, 08 May 2011 01:42:32 -0700 (PDT)
Received: from localhost.localdomain (178-191-5-255.adsl.highway.telekom.at [178.191.5.255])
        by mx.google.com with ESMTPS id z9sm3022884wbx.34.2011.05.08.01.42.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 01:42:32 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Florian Fainelli <florian@openwrt.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 7/9] MIPS: Alchemy: rewrite ethernet platform setup
Date:   Sun,  8 May 2011 10:42:18 +0200
Message-Id: <1304844140-3259-8-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.rc3
In-Reply-To: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
References: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Rewrite ethernet setup to use runtime cpu detection, and also
clean up the ethernet base address mess as far as possible.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/platform.c        |  151 +++++++++++++++++++---------
 arch/mips/include/asm/mach-au1x00/au1000.h |   63 ++++--------
 2 files changed, 123 insertions(+), 91 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 36489fb..541fff2 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -13,9 +13,10 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
-#include <linux/init.h>
+#include <linux/slab.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
@@ -372,15 +373,16 @@ static struct platform_device pbdb_smbus_device = {
 #endif
 
 /* Macro to help defining the Ethernet MAC resources */
+#define MAC_RES_COUNT	3	/* MAC regs base, MAC enable reg, MAC INT */
 #define MAC_RES(_base, _enable, _irq)			\
 	{						\
-		.start	= CPHYSADDR(_base),		\
-		.end	= CPHYSADDR(_base + 0xffff),	\
+		.start	= _base,			\
+		.end	= _base + 0xffff,		\
 		.flags	= IORESOURCE_MEM,		\
 	},						\
 	{						\
-		.start	= CPHYSADDR(_enable),		\
-		.end	= CPHYSADDR(_enable + 0x3),	\
+		.start	= _enable,			\
+		.end	= _enable + 0x3,		\
 		.flags	= IORESOURCE_MEM,		\
 	},						\
 	{						\
@@ -389,19 +391,29 @@ static struct platform_device pbdb_smbus_device = {
 		.flags	= IORESOURCE_IRQ		\
 	}
 
-static struct resource au1xxx_eth0_resources[] = {
-#if defined(CONFIG_SOC_AU1000)
-	MAC_RES(AU1000_ETH0_BASE, AU1000_MAC0_ENABLE, AU1000_MAC0_DMA_INT),
-#elif defined(CONFIG_SOC_AU1100)
-	MAC_RES(AU1100_ETH0_BASE, AU1100_MAC0_ENABLE, AU1100_MAC0_DMA_INT),
-#elif defined(CONFIG_SOC_AU1550)
-	MAC_RES(AU1550_ETH0_BASE, AU1550_MAC0_ENABLE, AU1550_MAC0_DMA_INT),
-#elif defined(CONFIG_SOC_AU1500)
-	MAC_RES(AU1500_ETH0_BASE, AU1500_MAC0_ENABLE, AU1500_MAC0_DMA_INT),
-#endif
+static struct resource au1xxx_eth0_resources[][MAC_RES_COUNT] __initdata = {
+	[ALCHEMY_CPU_AU1000] = {
+		MAC_RES(AU1000_MAC0_PHYS_ADDR,
+			AU1000_MACEN_PHYS_ADDR,
+			AU1000_MAC0_DMA_INT)
+	},
+	[ALCHEMY_CPU_AU1500] = {
+		MAC_RES(AU1500_MAC0_PHYS_ADDR,
+			AU1500_MACEN_PHYS_ADDR,
+			AU1500_MAC0_DMA_INT)
+	},
+	[ALCHEMY_CPU_AU1100] = {
+		MAC_RES(AU1000_MAC0_PHYS_ADDR,
+			AU1000_MACEN_PHYS_ADDR,
+			AU1100_MAC0_DMA_INT)
+	},
+	[ALCHEMY_CPU_AU1550] = {
+		MAC_RES(AU1000_MAC0_PHYS_ADDR,
+			AU1000_MACEN_PHYS_ADDR,
+			AU1550_MAC0_DMA_INT)
+	},
 };
 
-
 static struct au1000_eth_platform_data au1xxx_eth0_platform_data = {
 	.phy1_search_mac0 = 1,
 };
@@ -409,20 +421,26 @@ static struct au1000_eth_platform_data au1xxx_eth0_platform_data = {
 static struct platform_device au1xxx_eth0_device = {
 	.name		= "au1000-eth",
 	.id		= 0,
-	.num_resources	= ARRAY_SIZE(au1xxx_eth0_resources),
-	.resource	= au1xxx_eth0_resources,
+	.num_resources	= MAC_RES_COUNT,
 	.dev.platform_data = &au1xxx_eth0_platform_data,
 };
 
-#ifndef CONFIG_SOC_AU1100
-static struct resource au1xxx_eth1_resources[] = {
-#if defined(CONFIG_SOC_AU1000)
-	MAC_RES(AU1000_ETH1_BASE, AU1000_MAC1_ENABLE, AU1000_MAC1_DMA_INT),
-#elif defined(CONFIG_SOC_AU1550)
-	MAC_RES(AU1550_ETH1_BASE, AU1550_MAC1_ENABLE, AU1550_MAC1_DMA_INT),
-#elif defined(CONFIG_SOC_AU1500)
-	MAC_RES(AU1500_ETH1_BASE, AU1500_MAC1_ENABLE, AU1500_MAC1_DMA_INT),
-#endif
+static struct resource au1xxx_eth1_resources[][MAC_RES_COUNT] __initdata = {
+	[ALCHEMY_CPU_AU1000] = {
+		MAC_RES(AU1000_MAC1_PHYS_ADDR,
+			AU1000_MACEN_PHYS_ADDR + 4,
+			AU1000_MAC1_DMA_INT)
+	},
+	[ALCHEMY_CPU_AU1500] = {
+		MAC_RES(AU1500_MAC1_PHYS_ADDR,
+			AU1500_MACEN_PHYS_ADDR + 4,
+			AU1500_MAC1_DMA_INT)
+	},
+	[ALCHEMY_CPU_AU1550] = {
+		MAC_RES(AU1000_MAC1_PHYS_ADDR,
+			AU1000_MACEN_PHYS_ADDR + 4,
+			AU1550_MAC1_DMA_INT)
+	},
 };
 
 static struct au1000_eth_platform_data au1xxx_eth1_platform_data = {
@@ -432,11 +450,9 @@ static struct au1000_eth_platform_data au1xxx_eth1_platform_data = {
 static struct platform_device au1xxx_eth1_device = {
 	.name		= "au1000-eth",
 	.id		= 1,
-	.num_resources	= ARRAY_SIZE(au1xxx_eth1_resources),
-	.resource	= au1xxx_eth1_resources,
+	.num_resources	= MAC_RES_COUNT,
 	.dev.platform_data = &au1xxx_eth1_platform_data,
 };
-#endif
 
 void __init au1xxx_override_eth_cfg(unsigned int port,
 			struct au1000_eth_platform_data *eth_data)
@@ -447,11 +463,62 @@ void __init au1xxx_override_eth_cfg(unsigned int port,
 	if (port == 0)
 		memcpy(&au1xxx_eth0_platform_data, eth_data,
 			sizeof(struct au1000_eth_platform_data));
-#ifndef CONFIG_SOC_AU1100
 	else
 		memcpy(&au1xxx_eth1_platform_data, eth_data,
 			sizeof(struct au1000_eth_platform_data));
-#endif
+}
+
+static void __init alchemy_setup_macs(int ctype)
+{
+	int ret, i;
+	unsigned char ethaddr[6];
+	struct resource *macres;
+
+	/* Handle 1st MAC */
+	if (alchemy_get_macs(ctype) < 1)
+		return;
+
+	macres = kmalloc(sizeof(struct resource) * MAC_RES_COUNT, GFP_KERNEL);
+	if (!macres) {
+		printk(KERN_INFO "Alchemy: no memory for MAC0 resources\n");
+		return;
+	}
+	memcpy(macres, au1xxx_eth0_resources[ctype],
+	       sizeof(struct resource) * MAC_RES_COUNT);
+	au1xxx_eth0_device.resource = macres;
+
+	i = prom_get_ethernet_addr(ethaddr);
+	if (!i && !is_valid_ether_addr(au1xxx_eth0_platform_data.mac))
+		memcpy(au1xxx_eth0_platform_data.mac, ethaddr, 6);
+
+	ret = platform_device_register(&au1xxx_eth0_device);
+	if (!ret)
+		printk(KERN_INFO "Alchemy: failed to register MAC0\n");
+
+
+	/* Handle 2nd MAC */
+	if (alchemy_get_macs(ctype) < 2)
+		return;
+
+	macres = kmalloc(sizeof(struct resource) * MAC_RES_COUNT, GFP_KERNEL);
+	if (!macres) {
+		printk(KERN_INFO "Alchemy: no memory for MAC1 resources\n");
+		return;
+	}
+	memcpy(macres, au1xxx_eth1_resources[ctype],
+	       sizeof(struct resource) * MAC_RES_COUNT);
+	au1xxx_eth1_device.resource = macres;
+
+	ethaddr[5] += 1;	/* next addr for 2nd MAC */
+	if (!i && !is_valid_ether_addr(au1xxx_eth1_platform_data.mac))
+		memcpy(au1xxx_eth1_platform_data.mac, ethaddr, 6);
+
+	/* Register second MAC if enabled in pinfunc */
+	if (!(au_readl(SYS_PINFUNC) & (u32)SYS_PF_NI2)) {
+		ret = platform_device_register(&au1xxx_eth1_device);
+		if (ret)
+			printk(KERN_INFO "Alchemy: failed to register MAC1\n");
+	}
 }
 
 static struct platform_device *au1xxx_platform_devices[] __initdata = {
@@ -472,33 +539,17 @@ static struct platform_device *au1xxx_platform_devices[] __initdata = {
 #ifdef SMBUS_PSC_BASE
 	&pbdb_smbus_device,
 #endif
-	&au1xxx_eth0_device,
 };
 
 static int __init au1xxx_platform_init(void)
 {
-	int err, i, ctype = alchemy_get_cputype();
-	unsigned char ethaddr[6];
+	int err, ctype = alchemy_get_cputype();
 
 	alchemy_setup_uarts(ctype);
-
-	/* use firmware-provided mac addr if available and necessary */
-	i = prom_get_ethernet_addr(ethaddr);
-	if (!i && !is_valid_ether_addr(au1xxx_eth0_platform_data.mac))
-		memcpy(au1xxx_eth0_platform_data.mac, ethaddr, 6);
+	alchemy_setup_macs(ctype);
 
 	err = platform_add_devices(au1xxx_platform_devices,
 				   ARRAY_SIZE(au1xxx_platform_devices));
-#ifndef CONFIG_SOC_AU1100
-	ethaddr[5] += 1;	/* next addr for 2nd MAC */
-	if (!i && !is_valid_ether_addr(au1xxx_eth1_platform_data.mac))
-		memcpy(au1xxx_eth1_platform_data.mac, ethaddr, 6);
-
-	/* Register second MAC if enabled in pinfunc */
-	if (!err && !(au_readl(SYS_PINFUNC) & (u32)SYS_PF_NI2))
-		err = platform_device_register(&au1xxx_eth1_device);
-#endif
-
 	return err;
 }
 
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index c4ffb20..415d287 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -219,6 +219,20 @@ static inline void alchemy_uart_putchar(u32 uart_phys, u8 c)
 	wmb();
 }
 
+/* return number of ethernet MACs on a given cputype */
+static inline int alchemy_get_macs(int type)
+{
+	switch (type) {
+	case ALCHEMY_CPU_AU1000:
+	case ALCHEMY_CPU_AU1500:
+	case ALCHEMY_CPU_AU1550:
+		return 2;
+	case ALCHEMY_CPU_AU1100:
+		return 1;
+	}
+	return 0;
+}
+
 /* arch/mips/au1000/common/clocks.c */
 extern void set_au1x00_speed(unsigned int new_freq);
 extern unsigned int get_au1x00_speed(void);
@@ -673,6 +687,12 @@ enum soc_au1200_ints {
  */
 
 #define AU1000_IC0_PHYS_ADDR		0x10400000 /* 01234 */
+#define AU1000_MAC0_PHYS_ADDR		0x10500000 /* 023 */
+#define AU1000_MAC1_PHYS_ADDR		0x10510000 /* 023 */
+#define AU1000_MACEN_PHYS_ADDR		0x10520000 /* 023 */
+#define AU1500_MAC0_PHYS_ADDR		0x11500000 /* 1 */
+#define AU1500_MAC1_PHYS_ADDR		0x11510000 /* 1 */
+#define AU1500_MACEN_PHYS_ADDR		0x11520000 /* 1 */
 #define AU1000_UART0_PHYS_ADDR		0x11100000 /* 01234 */
 #define AU1000_UART1_PHYS_ADDR		0x11200000 /* 0234 */
 #define AU1000_UART2_PHYS_ADDR		0x11300000 /* 0 */
@@ -680,6 +700,8 @@ enum soc_au1200_ints {
 #define AU1000_IC1_PHYS_ADDR		0x11800000 /* 01234 */
 #define AU1550_DBDMA_PHYS_ADDR		0x14002000 /* 34 */
 #define AU1550_DBDMA_CONF_PHYS_ADDR	0x14003000 /* 34 */
+#define AU1000_MACDMA0_PHYS_ADDR	0x14004000 /* 0123 */
+#define AU1000_MACDMA1_PHYS_ADDR	0x14004200 /* 0123 */
 
 
 #ifdef CONFIG_SOC_AU1000
@@ -697,11 +719,6 @@ enum soc_au1200_ints {
 #define	USBH_PHYS_ADDR		0x10100000
 #define	USBD_PHYS_ADDR		0x10200000
 #define	IRDA_PHYS_ADDR		0x10300000
-#define	MAC0_PHYS_ADDR		0x10500000
-#define	MAC1_PHYS_ADDR		0x10510000
-#define	MACEN_PHYS_ADDR		0x10520000
-#define	MACDMA0_PHYS_ADDR	0x14004000
-#define	MACDMA1_PHYS_ADDR	0x14004200
 #define	I2S_PHYS_ADDR		0x11000000
 #define	SSI0_PHYS_ADDR		0x11600000
 #define	SSI1_PHYS_ADDR		0x11680000
@@ -728,11 +745,6 @@ enum soc_au1200_ints {
 #define	USBH_PHYS_ADDR		0x10100000
 #define	USBD_PHYS_ADDR		0x10200000
 #define PCI_PHYS_ADDR		0x14005000
-#define	MAC0_PHYS_ADDR		0x11500000
-#define	MAC1_PHYS_ADDR		0x11510000
-#define	MACEN_PHYS_ADDR		0x11520000
-#define	MACDMA0_PHYS_ADDR	0x14004000
-#define	MACDMA1_PHYS_ADDR	0x14004200
 #define	I2S_PHYS_ADDR		0x11000000
 #define GPIO2_PHYS_ADDR		0x11700000
 #define	SYS_PHYS_ADDR		0x11900000
@@ -764,10 +776,6 @@ enum soc_au1200_ints {
 #define	USBH_PHYS_ADDR		0x10100000
 #define	USBD_PHYS_ADDR		0x10200000
 #define	IRDA_PHYS_ADDR		0x10300000
-#define	MAC0_PHYS_ADDR		0x10500000
-#define	MACEN_PHYS_ADDR		0x10520000
-#define	MACDMA0_PHYS_ADDR	0x14004000
-#define	MACDMA1_PHYS_ADDR	0x14004200
 #define	I2S_PHYS_ADDR		0x11000000
 #define	SSI0_PHYS_ADDR		0x11600000
 #define	SSI1_PHYS_ADDR		0x11680000
@@ -787,11 +795,6 @@ enum soc_au1200_ints {
 #define	USBH_PHYS_ADDR		0x14020000
 #define	USBD_PHYS_ADDR		0x10200000
 #define PCI_PHYS_ADDR		0x14005000
-#define	MAC0_PHYS_ADDR		0x10500000
-#define	MAC1_PHYS_ADDR		0x10510000
-#define	MACEN_PHYS_ADDR		0x10520000
-#define	MACDMA0_PHYS_ADDR	0x14004000
-#define	MACDMA1_PHYS_ADDR	0x14004200
 #define GPIO2_PHYS_ADDR		0x11700000
 #define	SYS_PHYS_ADDR		0x11900000
 #define PE_PHYS_ADDR		0x14008000
@@ -870,12 +873,6 @@ enum soc_au1200_ints {
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017FFFC
 #define FOR_PLATFORM_C_USB_HOST_INT AU1000_USB_HOST_INT
-
-#define AU1000_ETH0_BASE	0xB0500000
-#define AU1000_ETH1_BASE	0xB0510000
-#define AU1000_MAC0_ENABLE	0xB0520000
-#define AU1000_MAC1_ENABLE	0xB0520004
-#define NUM_ETH_INTERFACES 2
 #endif /* CONFIG_SOC_AU1000 */
 
 /* Au1500 */
@@ -887,12 +884,6 @@ enum soc_au1200_ints {
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017fffc
 #define FOR_PLATFORM_C_USB_HOST_INT AU1500_USB_HOST_INT
-
-#define AU1500_ETH0_BASE	0xB1500000
-#define AU1500_ETH1_BASE	0xB1510000
-#define AU1500_MAC0_ENABLE	0xB1520000
-#define AU1500_MAC1_ENABLE	0xB1520004
-#define NUM_ETH_INTERFACES 2
 #endif /* CONFIG_SOC_AU1500 */
 
 /* Au1100 */
@@ -904,10 +895,6 @@ enum soc_au1200_ints {
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017FFFC
 #define FOR_PLATFORM_C_USB_HOST_INT AU1100_USB_HOST_INT
-
-#define AU1100_ETH0_BASE	0xB0500000
-#define AU1100_MAC0_ENABLE	0xB0520000
-#define NUM_ETH_INTERFACES 1
 #endif /* CONFIG_SOC_AU1100 */
 
 #ifdef CONFIG_SOC_AU1550
@@ -917,12 +904,6 @@ enum soc_au1200_ints {
 #define USB_OHCI_LEN		0x00060000
 #define USB_HOST_CONFIG 	0xB4027ffc
 #define FOR_PLATFORM_C_USB_HOST_INT AU1550_USB_HOST_INT
-
-#define AU1550_ETH0_BASE	0xB0500000
-#define AU1550_ETH1_BASE	0xB0510000
-#define AU1550_MAC0_ENABLE	0xB0520000
-#define AU1550_MAC1_ENABLE	0xB0520004
-#define NUM_ETH_INTERFACES 2
 #endif /* CONFIG_SOC_AU1550 */
 
 
-- 
1.7.5.rc3
