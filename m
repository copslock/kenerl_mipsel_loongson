Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jul 2009 23:01:19 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:57695 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493683AbZG1VAo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Jul 2009 23:00:44 +0200
Received: by mail-ew0-f216.google.com with SMTP id 12so62414ewy.0
        for <multiple recipients>; Tue, 28 Jul 2009 14:00:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xWXwrYmMy37ZmLCWtE6Y7iFgVBGJ5D/i1L+qAq2iAho=;
        b=eTfYdqf+d8NaxcK8AqYRSqweaEcLfq237T9fO9CCRnknuJ2W28IIzLNlpA1Mude4FW
         CTQVy/UxL0qXlOAG8FePLla59RXqJRLBbFPPLOK8PQSARB8oH3oDc4A7UJxGHN5Soj1h
         UB4vBW+bxOgU0casDWKwk36fHHYDvjy/cPPks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=dtXaY65rmxAOGFHkxjP/V5y5wEDS7atyi0S/X43K9pmqiI6SlbiH8w2mhVc/+hWi3P
         piYdZmsRkVGbXBfzEbCdMf6uINCOmY5wMpOzhTMYiaHIfQwz+Q68aBS7dhKY54gyCxp5
         esQz4rgO3ZIKH1wBRlHAbMPn0/JfVH7nP0pgM=
Received: by 10.211.179.6 with SMTP id g6mr10579713ebp.32.1248814840183;
        Tue, 28 Jul 2009 14:00:40 -0700 (PDT)
Received: from ?192.168.254.2? (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 5sm217108eyh.7.2009.07.28.14.00.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 14:00:39 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Tue, 28 Jul 2009 23:00:29 +0200
Subject: [PATCH 3/4] alchemy: pass PHY informations to au1000_eth
MIME-Version: 1.0
X-UID:	1034
X-Length: 3701
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907282300.29648.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch completes the au1000_eth platform device
conversion by passing PHY informations to the au1000_eth
driver. In order not to break boards, we maintain the
Bosporus specific configuration. Tested on Meshcube.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index acc1ae2..63686ab 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -19,6 +19,7 @@
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
+#include <asm/mach-au1x00/au1xxx_eth.h>
 
 #define PORT(_base, _irq)				\
 	{						\
@@ -370,14 +371,20 @@ static struct resource au1xxx_eth1_resources[] = {
 #endif
 };
 
+static struct au1000_eth_platform_data au1xxx_eth0_platform_data = {
+	.phy1_search_mac0 = 1,
+};
+
 static struct platform_device au1xxx_eth0_device = {
 	.name		= "au1000-eth",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(au1xxx_eth0_resources),
 	.resource	= au1xxx_eth0_resources,
+	.dev.platform_data = &au1xxx_eth0_platform_data,
 };
 
 #ifndef CONFIG_SOC_AU1100
+/* We do not pass a platform_data structure to MAC1 to assume defaults */
 static struct platform_device au1xxx_eth1_device = {
 	.name		= "au1000-eth",
 	.id		= 1,
@@ -418,6 +425,20 @@ static int __init au1xxx_platform_init(void)
 	for (i = 0; au1x00_uart_data[i].flags; i++)
 		au1x00_uart_data[i].uartclk = uartclk;
 
+#ifdef CONFIG_MIPS_BOSPORUS
+	/*
+	 * Micrel/Kendin 5 port switch attached to MAC0,
+	 * MAC0 is associated with PHY address 5 (== WAN port)
+	 * MAC1 is not associated with any PHY, since it's connected directly
+	 * to the switch.
+	 * no interrupts are used
+	 */
+	au1xxx_eth0_platform_data.phy1_search_mac0 = 0;
+	au1xxx_eth0_platform_data.phy_static_config = 1;
+	au1xxx_eth0_platform_data.phy_addr = 5;
+	au1xxx_eth0_platform_data.phy_busid = 0;
+#endif
+
 	/* Register second MAC if enabled in pinfunc */
 #ifndef CONFIG_SOC_AU1100
         ni = (int)((au_readl(SYS_PINFUNC) & (u32)(SYS_PF_NI2)) >> 4);
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h b/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h
new file mode 100644
index 0000000..9937621
--- /dev/null
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h
@@ -0,0 +1,15 @@
+#ifndef __AU1X00_ETH_PDATA_H
+#define __AU1X00_ETH_PDATA_H
+
+/* Platform specific PHY configuration passed to the MAC driver */
+struct au1000_eth_platform_data {
+	int phy_static_config;
+	int phy_search_highest_addr;
+	int phy1_search_mac0;
+	int phy_addr;
+	int phy_busid;
+	int phy_irq;
+};
+
+#endif /* __AU1X00_ETH_PDATA_H */
+
