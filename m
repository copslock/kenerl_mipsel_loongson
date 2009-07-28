Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jul 2009 23:00:54 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:43845 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493678AbZG1VAY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Jul 2009 23:00:24 +0200
Received: by ewy12 with SMTP id 12so62437ewy.0
        for <multiple recipients>; Tue, 28 Jul 2009 14:00:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=e3FdX05NDD7eE/22063Uk/XKrY7pv4sSpDHVR3YMouk=;
        b=B55NDSwubssQl+SLIQyCRtoA3RFzRmSEejpAN83V+9Ub4Z6SE743rd/cbRMxzTWs1y
         IIsSR00a5MeRt56UrTi5F7lfVlzRY3OERw3JUy5RDOZeOduyddDN6Is8XH7S9V+3lIVP
         LVRUazuNSmg7d4LFfPO2iNlTWtD+4jfXUpiK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=DHV7/CP0MXyKIgrzAJcRHNX2lIl8bOz7EcF1519qua0zAVZtZFGlsOC36mEI3oYAnh
         qRvqlp53FqqwoiXlU6gOGtz6pcth9bEi4tqVwNQ1fBqNhABnDDvfcXpMhJB99Mid1M/J
         9nXWwdt9i1f9KiSsYyYD96DhNGg/KlBQ//mms=
Received: by 10.210.92.8 with SMTP id p8mr3463176ebb.15.1248814818743;
        Tue, 28 Jul 2009 14:00:18 -0700 (PDT)
Received: from ?192.168.254.2? (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 24sm573321eyx.23.2009.07.28.14.00.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 14:00:18 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Tue, 28 Jul 2009 23:00:13 +0200
Subject: [PATCH 1/4] alchemy: register au1000_eth as a platform driver part one
MIME-Version: 1.0
X-UID:	1033
X-Length: 4149
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907282300.14118.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This is the first patch which registers au1000_eth as a platform
driver. Note that the second MAC (only on non-Au1100 SoC) is
dynamically registered if the interface is enabled in sys_pinfunc.
which also custom boards like Meshcube. PHY information is passed
to the driver in a follow-up patch.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 117f99f..acc1ae2 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -331,6 +331,61 @@ static struct platform_device pbdb_smbus_device = {
 };
 #endif
 
+/* All Alchemy board have at least one Ethernet MAC */
+#define MAC_RES(_base, _enable, _irq)			\
+	{						\
+		.start	= CPHYSADDR(_base),		\
+		.end	= CPHYSADDR(_base + 0xffff),	\
+		.flags	= IORESOURCE_MEM,		\
+	},						\
+	{						\
+		.start	= CPHYSADDR(_enable),		\
+		.end	= CPHYSADDR(_enable + 0x4),	\
+		.flags	= IORESOURCE_MEM,		\
+	},						\
+	{						\
+		.start	= _irq,				\
+		.end	= _irq,				\
+		.flags	= IORESOURCE_IRQ		\
+	}
+
+static struct resource au1xxx_eth0_resources[] = {
+#if defined(CONFIG_SOC_AU1000)
+	MAC_RES(AU1000_ETH0_BASE, AU1000_MAC0_ENABLE, AU1000_MAC0_DMA_INT),
+#elif defined(CONFIG_SOC_AU1100)
+	MAC_RES(AU1100_ETH0_BASE, AU1100_MAC0_ENABLE, AU1100_MAC0_DMA_INT),
+#elif defined(CONFIG_SOC_AU1550)
+	MAC_RES(AU1550_ETH0_BASE, AU1550_MAC0_ENABLE, AU1550_MAC0_DMA_INT),
+#elif defined(CONFIG_SOC_AU1500)
+	MAC_RES(AU1500_ETH0_BASE, AU1500_MAC0_ENABLE, AU1500_MAC0_DMA_INT),
+#endif
+};
+static struct resource au1xxx_eth1_resources[] = {
+#if defined(CONFIG_SOC_AU1000)
+	MAC_RES(AU1000_ETH1_BASE, AU1000_MAC1_ENABLE, AU1000_MAC1_DMA_INT),
+#elif defined(CONFIG_SOC_AU1550)
+	MAC_RES(AU1550_ETH1_BASE, AU1550_MAC1_ENABLE, AU1550_MAC1_DMA_INT),
+#elif defined(CONFIG_SOC_AU1500)
+	MAC_RES(AU1500_ETH1_BASE, AU1500_MAC1_ENABLE, AU1500_MAC1_DMA_INT),
+#endif
+};
+
+static struct platform_device au1xxx_eth0_device = {
+	.name		= "au1000-eth",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(au1xxx_eth0_resources),
+	.resource	= au1xxx_eth0_resources,
+};
+
+#ifndef CONFIG_SOC_AU1100
+static struct platform_device au1xxx_eth1_device = {
+	.name		= "au1000-eth",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(au1xxx_eth1_resources),
+	.resource	= au1xxx_eth1_resources,
+};
+#endif
+
 static struct platform_device *au1xxx_platform_devices[] __initdata = {
 	&au1xx0_uart_device,
 	&au1xxx_usb_ohci_device,
@@ -351,17 +406,25 @@ static struct platform_device *au1xxx_platform_devices[] __initdata = {
 #ifdef SMBUS_PSC_BASE
 	&pbdb_smbus_device,
 #endif
+	&au1xxx_eth0_device,
 };
 
 static int __init au1xxx_platform_init(void)
 {
 	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
-	int i;
+	int i, ni;
 
 	/* Fill up uartclk. */
 	for (i = 0; au1x00_uart_data[i].flags; i++)
 		au1x00_uart_data[i].uartclk = uartclk;
 
+	/* Register second MAC if enabled in pinfunc */
+#ifndef CONFIG_SOC_AU1100
+        ni = (int)((au_readl(SYS_PINFUNC) & (u32)(SYS_PF_NI2)) >> 4);
+        if (!(ni + 1))
+		platform_device_register(&au1xxx_eth1_device);
+#endif
+
 	return platform_add_devices(au1xxx_platform_devices,
 				    ARRAY_SIZE(au1xxx_platform_devices));
 }
