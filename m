Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2010 14:31:04 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:60737 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491078Ab0GUMa7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jul 2010 14:30:59 +0200
Received: by bwz15 with SMTP id 15so146411bwz.36
        for <linux-mips@linux-mips.org>; Wed, 21 Jul 2010 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=0GVgZdgXGApRYbQPbWckglrw/N7SzrAcZTdgbOimO9o=;
        b=pbDE1pDdGuvZxHoyV45cA19WGXehu01J8S7Il+02VwYIspOfj0lNjwH9D3QlWe5Hfh
         hX1dULRehqd8zc2UA9DKf7nZnEFwVP7hmtCT5XAlEkBsUp7cgDKXdT+UBMazHCBUkfX7
         POUAu4zOuxIjqUCdDKLE+pw2AopYjPJdg7Fnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=cVlbPzoux1X8kULK5jEdf6oB31hTEh+nz/OlHvnRivLKPKIn/d9lxXeQJqwUW+BUOX
         PW958IJDWVetvePcRqrPXtQvxIe0zb7Q8Rr+DxI3k1kmfHQUOAJ7YLTy1iPykYfpkfVG
         MSjSx/TFKG8reNOfC187yLllkynRwWQ0t4Yyc=
Received: by 10.204.131.200 with SMTP id y8mr73874bks.107.1279715456932;
        Wed, 21 Jul 2010 05:30:56 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id y2sm29066342bkx.20.2010.07.21.05.30.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 05:30:54 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     netdev@vger.kernel.org, Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] au1000_eth: get ethernet address from platform_data
Date:   Wed, 21 Jul 2010 14:30:50 +0200
Message-Id: <1279715450-28762-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.1.1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

au1000_eth uses firmware calls to get a valid MAC address, and changes
it depending on platform device id.  This patch moves this logic out
of the driver into the platform device registration part, where boards
with supported chips can use whatever firmware interface they need;
the default implementation maintains compatibility with existing,
YAMON-based firmware.

Tested-by: Wolfgang Grandegger <wg@denx.de>
Acked-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
This patch depends on another patch to the MIPS tree to
apply cleanly, so I'd prefer if it went in through it as well.

 arch/mips/alchemy/common/platform.c            |   15 ++++++++++-
 arch/mips/include/asm/mach-au1x00/au1xxx_eth.h |    1 +
 drivers/net/au1000_eth.c                       |   31 +++++------------------
 3 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index f9e5622..e9c354f 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 #include <linux/init.h>
@@ -21,6 +22,8 @@
 #include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/mach-au1x00/au1xxx_eth.h>
 
+#include <prom.h>
+
 #define PORT(_base, _irq)					\
 	{							\
 		.mapbase	= _base,			\
@@ -436,17 +439,27 @@ static int __init au1xxx_platform_init(void)
 {
 	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
 	int err, i;
+	unsigned char ethaddr[6];
 
 	/* Fill up uartclk. */
 	for (i = 0; au1x00_uart_data[i].flags; i++)
 		au1x00_uart_data[i].uartclk = uartclk;
 
+	/* use firmware-provided mac addr if available and necessary */
+	i = prom_get_ethernet_addr(ethaddr);
+	if (!i && !is_valid_ether_addr(au1xxx_eth0_platform_data.mac))
+		memcpy(au1xxx_eth0_platform_data.mac, ethaddr, 6);
+
 	err = platform_add_devices(au1xxx_platform_devices,
 				   ARRAY_SIZE(au1xxx_platform_devices));
 #ifndef CONFIG_SOC_AU1100
+	ethaddr[5] += 1;	/* next addr for 2nd MAC */
+	if (!i && !is_valid_ether_addr(au1xxx_eth1_platform_data.mac))
+		memcpy(au1xxx_eth1_platform_data.mac, ethaddr, 6);
+
 	/* Register second MAC if enabled in pinfunc */
 	if (!err && !(au_readl(SYS_PINFUNC) & (u32)SYS_PF_NI2))
-		platform_device_register(&au1xxx_eth1_device);
+		err = platform_device_register(&au1xxx_eth1_device);
 #endif
 
 	return err;
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h b/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h
index bae9b75..49dc8d9 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_eth.h
@@ -9,6 +9,7 @@ struct au1000_eth_platform_data {
 	int phy_addr;
 	int phy_busid;
 	int phy_irq;
+	char mac[6];
 };
 
 void __init au1xxx_override_eth_cfg(unsigned port,
diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index ece6128..17e7e27 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -104,14 +104,6 @@ MODULE_VERSION(DRV_VERSION);
  * complete immediately.
  */
 
-/* These addresses are only used if yamon doesn't tell us what
- * the mac address is, and the mac address is not passed on the
- * command line.
- */
-static unsigned char au1000_mac_addr[6] __devinitdata = {
-	0x00, 0x50, 0xc2, 0x0c, 0x30, 0x00
-};
-
 struct au1000_private *au_macs[NUM_ETH_INTERFACES];
 
 /*
@@ -1002,7 +994,6 @@ static int __devinit au1000_probe(struct platform_device *pdev)
 	db_dest_t *pDB, *pDBfree;
 	int irq, i, err = 0;
 	struct resource *base, *macen;
-	char ethaddr[6];
 
 	base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!base) {
@@ -1079,24 +1070,13 @@ static int __devinit au1000_probe(struct platform_device *pdev)
 	}
 	aup->mac_id = pdev->id;
 
-	if (pdev->id == 0) {
-		if (prom_get_ethernet_addr(ethaddr) == 0)
-			memcpy(au1000_mac_addr, ethaddr, sizeof(au1000_mac_addr));
-		else {
-			netdev_info(dev, "No MAC address found\n");
-				/* Use the hard coded MAC addresses */
-		}
-
+	if (pdev->id == 0)
 		au1000_setup_hw_rings(aup, MAC0_RX_DMA_ADDR, MAC0_TX_DMA_ADDR);
-	} else if (pdev->id == 1)
+	else if (pdev->id == 1)
 		au1000_setup_hw_rings(aup, MAC1_RX_DMA_ADDR, MAC1_TX_DMA_ADDR);
 
-	/*
-	 * Assign to the Ethernet ports two consecutive MAC addresses
-	 * to match those that are printed on their stickers
-	 */
-	memcpy(dev->dev_addr, au1000_mac_addr, sizeof(au1000_mac_addr));
-	dev->dev_addr[5] += pdev->id;
+	/* set a random MAC now in case platform_data doesn't provide one */
+	random_ether_addr(dev->dev_addr);
 
 	*aup->enable = 0;
 	aup->mac_enabled = 0;
@@ -1106,6 +1086,9 @@ static int __devinit au1000_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev, "no platform_data passed, PHY search on MAC0\n");
 		aup->phy1_search_mac0 = 1;
 	} else {
+		if (is_valid_ether_addr(pd->mac))
+			memcpy(dev->dev_addr, pd->mac, 6);
+
 		aup->phy_static_config = pd->phy_static_config;
 		aup->phy_search_highest_addr = pd->phy_search_highest_addr;
 		aup->phy1_search_mac0 = pd->phy1_search_mac0;
-- 
1.7.1.1
