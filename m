Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2011 20:41:31 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:50880 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491126Ab1ETSlY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 May 2011 20:41:24 +0200
Received: by wyb28 with SMTP id 28so3735528wyb.36
        for <multiple recipients>; Fri, 20 May 2011 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=7siWViQdg2JqElN41VZKi0NWaC1dBhte3RLAESsLxM4=;
        b=gXbuFrwf/kXTmgwGk/maJpWBYS6AkxFnyIj2ge1eIuJ6/HZAvZVQFfJ5b5lX6UDujR
         kIc3PWCpt+TQbtR14XBTyLxlUH4bsipccPelNiWrdtyRPPTE8TSGuTrysVUgP9S003sR
         eLfGgCub4sHbRdc+tVeont5u7euDY1BRv71dY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Y9amRzQFj60MdFrMwIZFPr6gbJ6WH5w5KoBJhsb6n3Jx6VVJjv3D8B+i5T3iWIPxsS
         Oa0TGVwzFAdFUx3vC6KfDyweI5w7ra0aPnou7Hp6hBeZAbq372G8Mlr1RTinTto4JLUC
         oDbhFfcbCC2YJwm27L6XiSCckF5Z1+BMxIgWs=
Received: by 10.227.160.11 with SMTP id l11mr73520wbx.1.1305916877697;
        Fri, 20 May 2011 11:41:17 -0700 (PDT)
Received: from localhost.localdomain (188-22-156-242.adsl.highway.telekom.at [188.22.156.242])
        by mx.google.com with ESMTPS id h11sm2459595wbc.60.2011.05.20.11.41.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 May 2011 11:41:15 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH] net: au1000_eth: add MACDMA to platform resource info.
Date:   Fri, 20 May 2011 20:41:05 +0200
Message-Id: <1305916865-14038-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.rc3
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

This patch removes the last hardcoded base address from the au1000_eth
driver:  The base of the MACDMA unit was derived from the
platform device id; if someone registered the MACs in inverse order
both would not work.
Instead pass the base address of the DMA unit to the driver along with
the other platform resource information.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Applies on top of Linus' latest -git

 arch/mips/alchemy/common/platform.c |   30 +++++++++++++++------
 drivers/net/au1000_eth.c            |   48 ++++++++++++++++++++++++++--------
 drivers/net/au1000_eth.h            |    2 +-
 3 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 3b2c18b..7400c93 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -373,8 +373,8 @@ static struct platform_device pbdb_smbus_device = {
 #endif
 
 /* Macro to help defining the Ethernet MAC resources */
-#define MAC_RES_COUNT	3	/* MAC regs base, MAC enable reg, MAC INT */
-#define MAC_RES(_base, _enable, _irq)			\
+#define MAC_RES_COUNT	4	/* MAC regs, MAC en, MAC INT, MACDMA regs */
+#define MAC_RES(_base, _enable, _irq, _macdma)		\
 	{						\
 		.start	= _base,			\
 		.end	= _base + 0xffff,		\
@@ -389,28 +389,37 @@ static struct platform_device pbdb_smbus_device = {
 		.start	= _irq,				\
 		.end	= _irq,				\
 		.flags	= IORESOURCE_IRQ		\
+	},						\
+	{						\
+		.start	= _macdma,			\
+		.end	= _macdma + 0x1ff,		\
+		.flags	= IORESOURCE_MEM,		\
 	}
 
 static struct resource au1xxx_eth0_resources[][MAC_RES_COUNT] __initdata = {
 	[ALCHEMY_CPU_AU1000] = {
 		MAC_RES(AU1000_MAC0_PHYS_ADDR,
 			AU1000_MACEN_PHYS_ADDR,
-			AU1000_MAC0_DMA_INT)
+			AU1000_MAC0_DMA_INT,
+			AU1000_MACDMA0_PHYS_ADDR)
 	},
 	[ALCHEMY_CPU_AU1500] = {
 		MAC_RES(AU1500_MAC0_PHYS_ADDR,
 			AU1500_MACEN_PHYS_ADDR,
-			AU1500_MAC0_DMA_INT)
+			AU1500_MAC0_DMA_INT,
+			AU1000_MACDMA0_PHYS_ADDR)
 	},
 	[ALCHEMY_CPU_AU1100] = {
 		MAC_RES(AU1000_MAC0_PHYS_ADDR,
 			AU1000_MACEN_PHYS_ADDR,
-			AU1100_MAC0_DMA_INT)
+			AU1100_MAC0_DMA_INT,
+			AU1000_MACDMA0_PHYS_ADDR)
 	},
 	[ALCHEMY_CPU_AU1550] = {
 		MAC_RES(AU1000_MAC0_PHYS_ADDR,
 			AU1000_MACEN_PHYS_ADDR,
-			AU1550_MAC0_DMA_INT)
+			AU1550_MAC0_DMA_INT,
+			AU1000_MACDMA0_PHYS_ADDR)
 	},
 };
 
@@ -429,17 +438,20 @@ static struct resource au1xxx_eth1_resources[][MAC_RES_COUNT] __initdata = {
 	[ALCHEMY_CPU_AU1000] = {
 		MAC_RES(AU1000_MAC1_PHYS_ADDR,
 			AU1000_MACEN_PHYS_ADDR + 4,
-			AU1000_MAC1_DMA_INT)
+			AU1000_MAC1_DMA_INT,
+			AU1000_MACDMA1_PHYS_ADDR)
 	},
 	[ALCHEMY_CPU_AU1500] = {
 		MAC_RES(AU1500_MAC1_PHYS_ADDR,
 			AU1500_MACEN_PHYS_ADDR + 4,
-			AU1500_MAC1_DMA_INT)
+			AU1500_MAC1_DMA_INT,
+			AU1000_MACDMA1_PHYS_ADDR)
 	},
 	[ALCHEMY_CPU_AU1550] = {
 		MAC_RES(AU1000_MAC1_PHYS_ADDR,
 			AU1000_MACEN_PHYS_ADDR + 4,
-			AU1550_MAC1_DMA_INT)
+			AU1550_MAC1_DMA_INT,
+			AU1000_MACDMA1_PHYS_ADDR)
 	},
 };
 
diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
index b9debcf..520f7d3 100644
--- a/drivers/net/au1000_eth.c
+++ b/drivers/net/au1000_eth.c
@@ -541,19 +541,17 @@ static void au1000_reset_mac(struct net_device *dev)
  * these are not descriptors sitting in memory.
  */
 static void
-au1000_setup_hw_rings(struct au1000_private *aup, u32 rx_base, u32 tx_base)
+au1000_setup_hw_rings(struct au1000_private *aup, u32 *tx_base)
 {
 	int i;
 
 	for (i = 0; i < NUM_RX_DMA; i++) {
-		aup->rx_dma_ring[i] =
-			(struct rx_dma *)
-					(rx_base + sizeof(struct rx_dma)*i);
+		aup->rx_dma_ring[i] = (struct rx_dma *)
+			(tx_base + 0x100 + sizeof(struct rx_dma) * i);
 	}
 	for (i = 0; i < NUM_TX_DMA; i++) {
-		aup->tx_dma_ring[i] =
-			(struct tx_dma *)
-					(tx_base + sizeof(struct tx_dma)*i);
+		aup->tx_dma_ring[i] = (struct tx_dma *)
+			(tx_base + sizeof(struct tx_dma) * i);
 	}
 }
 
@@ -1026,7 +1024,7 @@ static int __devinit au1000_probe(struct platform_device *pdev)
 	struct net_device *dev = NULL;
 	struct db_dest *pDB, *pDBfree;
 	int irq, i, err = 0;
-	struct resource *base, *macen;
+	struct resource *base, *macen, *macdma;
 
 	base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!base) {
@@ -1049,6 +1047,13 @@ static int __devinit au1000_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	macdma = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	if (!macdma) {
+		dev_err(&pdev->dev, "failed to retrieve MACDMA registers\n");
+		err = -ENODEV;
+		goto out;
+	}
+
 	if (!request_mem_region(base->start, resource_size(base),
 							pdev->name)) {
 		dev_err(&pdev->dev, "failed to request memory region for base registers\n");
@@ -1063,6 +1068,13 @@ static int __devinit au1000_probe(struct platform_device *pdev)
 		goto err_request;
 	}
 
+	if (!request_mem_region(macdma->start, resource_size(macdma),
+							pdev->name)) {
+		dev_err(&pdev->dev, "failed to request MACDMA memory region\n");
+		err = -ENXIO;
+		goto err_macdma;
+	}
+
 	dev = alloc_etherdev(sizeof(struct au1000_private));
 	if (!dev) {
 		dev_err(&pdev->dev, "alloc_etherdev failed\n");
@@ -1109,10 +1121,14 @@ static int __devinit au1000_probe(struct platform_device *pdev)
 	}
 	aup->mac_id = pdev->id;
 
-	if (pdev->id == 0)
-		au1000_setup_hw_rings(aup, MAC0_RX_DMA_ADDR, MAC0_TX_DMA_ADDR);
-	else if (pdev->id == 1)
-		au1000_setup_hw_rings(aup, MAC1_RX_DMA_ADDR, MAC1_TX_DMA_ADDR);
+	aup->macdma = ioremap_nocache(macdma->start, resource_size(macdma));
+	if (!aup->macdma) {
+		dev_err(&pdev->dev, "failed to ioremap MACDMA registers\n");
+		err = -ENXIO;
+		goto err_remap3;
+	}
+
+	au1000_setup_hw_rings(aup, aup->macdma);
 
 	/* set a random MAC now in case platform_data doesn't provide one */
 	random_ether_addr(dev->dev_addr);
@@ -1252,6 +1268,8 @@ err_out:
 err_mdiobus_reg:
 	mdiobus_free(aup->mii_bus);
 err_mdiobus_alloc:
+	iounmap(aup->macdma);
+err_remap3:
 	iounmap(aup->enable);
 err_remap2:
 	iounmap(aup->mac);
@@ -1261,6 +1279,8 @@ err_remap1:
 err_vaddr:
 	free_netdev(dev);
 err_alloc:
+	release_mem_region(macdma->start, resource_size(macdma));
+err_macdma:
 	release_mem_region(macen->start, resource_size(macen));
 err_request:
 	release_mem_region(base->start, resource_size(base));
@@ -1293,9 +1313,13 @@ static int __devexit au1000_remove(struct platform_device *pdev)
 			(NUM_TX_BUFFS + NUM_RX_BUFFS),
 			(void *)aup->vaddr, aup->dma_addr);
 
+	iounmap(aup->macdma);
 	iounmap(aup->mac);
 	iounmap(aup->enable);
 
+	base = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	release_mem_region(base->start, resource_size(base));
+
 	base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(base->start, resource_size(base));
 
diff --git a/drivers/net/au1000_eth.h b/drivers/net/au1000_eth.h
index 6229c77..9f28037 100644
--- a/drivers/net/au1000_eth.h
+++ b/drivers/net/au1000_eth.h
@@ -124,7 +124,7 @@ struct au1000_private {
 	 */
 	struct mac_reg *mac;  /* mac registers                      */
 	u32 *enable;     /* address of MAC Enable Register     */
-
+	u32 *macdma;	/* base of MAC DMA port */
 	u32 vaddr;                /* virtual address of rx/tx buffers   */
 	dma_addr_t dma_addr;      /* dma address of rx/tx buffers       */
 
-- 
1.7.5.rc3
