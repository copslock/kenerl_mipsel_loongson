Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 22:41:41 +0000 (GMT)
Received: from xyzzy.farnsworth.org ([65.39.95.219]:28684 "HELO farnsworth.org")
	by ftp.linux-mips.org with SMTP id S20039427AbXB1Wlg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2007 22:41:36 +0000
Received: (qmail 8725 invoked by uid 1000); 28 Feb 2007 15:40:31 -0700
From:	"Dale Farnsworth" <dale@farnsworth.org>
Date:	Wed, 28 Feb 2007 15:40:31 -0700
To:	Jeff Garzik <jgarzik@pobox.com>
Cc:	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/2] mv643xx_eth: move mac_addr inside of mv643xx_eth_platform_data
Message-ID: <20070228224031.GA8233@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <dale@farnsworth.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dale@farnsworth.org
Precedence: bulk
X-list: linux-mips

The information contained within platform_data should be self-contained.
Replace the pointer to a MAC address with the actual MAC address in
struct mv643xx_eth_platform_data.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: b/drivers/net/mv643xx_eth.c
===================================================================
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -1380,7 +1380,9 @@ static int mv643xx_eth_probe(struct plat
 
 	pd = pdev->dev.platform_data;
 	if (pd) {
-		if (pd->mac_addr)
+		static u8 zero_mac_addr[6] = { 0 };
+
+		if (memcmp(pd->mac_addr, zero_mac_addr, 6) != 0)
 			memcpy(dev->dev_addr, pd->mac_addr, 6);
 
 		if (pd->phy_addr || pd->force_phy_addr)
Index: b/include/linux/mv643xx.h
===================================================================
--- a/include/linux/mv643xx.h
+++ b/include/linux/mv643xx.h
@@ -1289,7 +1289,6 @@ struct mv64xxx_i2c_pdata {
 #define MV643XX_ETH_NAME	"mv643xx_eth"
 
 struct mv643xx_eth_platform_data {
-	char		*mac_addr;	/* pointer to mac address */
 	u16		force_phy_addr;	/* force override if phy_addr == 0 */
 	u16		phy_addr;
 
@@ -1304,6 +1303,7 @@ struct mv643xx_eth_platform_data {
 	u32		tx_sram_size;
 	u32		rx_sram_addr;
 	u32		rx_sram_size;
+	u8		mac_addr[6];	/* mac address if non-zero*/
 };
 
 #endif /* __ASM_MV643XX_H */
Index: b/arch/mips/momentum/jaguar_atx/platform.c
===================================================================
--- a/arch/mips/momentum/jaguar_atx/platform.c
+++ b/arch/mips/momentum/jaguar_atx/platform.c
@@ -47,11 +47,7 @@ static struct resource mv64x60_eth0_reso
 	},
 };
 
-static char eth0_mac_addr[ETH_ALEN];
-
 static struct mv643xx_eth_platform_data eth0_pd = {
-	.mac_addr	= eth0_mac_addr,
-
 	.tx_sram_addr	= MV_SRAM_BASE_ETH0,
 	.tx_sram_size	= MV_SRAM_TXRING_SIZE,
 	.tx_queue_size	= MV_SRAM_TXRING_SIZE / 16,
@@ -80,11 +76,7 @@ static struct resource mv64x60_eth1_reso
 	},
 };
 
-static char eth1_mac_addr[ETH_ALEN];
-
 static struct mv643xx_eth_platform_data eth1_pd = {
-	.mac_addr	= eth1_mac_addr,
-
 	.tx_sram_addr	= MV_SRAM_BASE_ETH1,
 	.tx_sram_size	= MV_SRAM_TXRING_SIZE,
 	.tx_queue_size	= MV_SRAM_TXRING_SIZE / 16,
@@ -113,11 +105,7 @@ static struct resource mv64x60_eth2_reso
 	},
 };
 
-static char eth2_mac_addr[ETH_ALEN];
-
-static struct mv643xx_eth_platform_data eth2_pd = {
-	.mac_addr	= eth2_mac_addr,
-};
+static struct mv643xx_eth_platform_data eth2_pd;
 
 static struct platform_device eth2_device = {
 	.name		= MV643XX_ETH_NAME,
@@ -200,9 +188,9 @@ static int __init mv643xx_eth_add_pds(vo
 	int ret;
 
 	get_mac(mac);
-	eth_mac_add(eth0_mac_addr, mac, 0);
-	eth_mac_add(eth1_mac_addr, mac, 1);
-	eth_mac_add(eth2_mac_addr, mac, 2);
+	eth_mac_add(eth0_pd.mac_addr, mac, 0);
+	eth_mac_add(eth1_pd.mac_addr, mac, 1);
+	eth_mac_add(eth2_pd.mac_addr, mac, 2);
 	ret = platform_add_devices(mv643xx_eth_pd_devs,
 			ARRAY_SIZE(mv643xx_eth_pd_devs));
 
Index: b/arch/mips/momentum/ocelot_3/platform.c
===================================================================
--- a/arch/mips/momentum/ocelot_3/platform.c
+++ b/arch/mips/momentum/ocelot_3/platform.c
@@ -47,11 +47,7 @@ static struct resource mv64x60_eth0_reso
 	},
 };
 
-static char eth0_mac_addr[ETH_ALEN];
-
 static struct mv643xx_eth_platform_data eth0_pd = {
-	.mac_addr	= eth0_mac_addr,
-
 	.tx_sram_addr	= MV_SRAM_BASE_ETH0,
 	.tx_sram_size	= MV_SRAM_TXRING_SIZE,
 	.tx_queue_size	= MV_SRAM_TXRING_SIZE / 16,
@@ -80,11 +76,7 @@ static struct resource mv64x60_eth1_reso
 	},
 };
 
-static char eth1_mac_addr[ETH_ALEN];
-
 static struct mv643xx_eth_platform_data eth1_pd = {
-	.mac_addr	= eth1_mac_addr,
-
 	.tx_sram_addr	= MV_SRAM_BASE_ETH1,
 	.tx_sram_size	= MV_SRAM_TXRING_SIZE,
 	.tx_queue_size	= MV_SRAM_TXRING_SIZE / 16,
@@ -113,11 +105,7 @@ static struct resource mv64x60_eth2_reso
 	},
 };
 
-static char eth2_mac_addr[ETH_ALEN];
-
-static struct mv643xx_eth_platform_data eth2_pd = {
-	.mac_addr	= eth2_mac_addr,
-};
+static struct mv643xx_eth_platform_data eth2_pd;
 
 static struct platform_device eth2_device = {
 	.name		= MV643XX_ETH_NAME,
@@ -200,9 +188,9 @@ static int __init mv643xx_eth_add_pds(vo
 	int ret;
 
 	get_mac(mac);
-	eth_mac_add(eth0_mac_addr, mac, 0);
-	eth_mac_add(eth1_mac_addr, mac, 1);
-	eth_mac_add(eth2_mac_addr, mac, 2);
+	eth_mac_add(eth0_pd.mac_addr, mac, 0);
+	eth_mac_add(eth1_pd.mac_addr, mac, 1);
+	eth_mac_add(eth2_pd.mac_addr, mac, 2);
 	ret = platform_add_devices(mv643xx_eth_pd_devs,
 			ARRAY_SIZE(mv643xx_eth_pd_devs));
 
Index: b/arch/mips/momentum/ocelot_c/platform.c
===================================================================
--- a/arch/mips/momentum/ocelot_c/platform.c
+++ b/arch/mips/momentum/ocelot_c/platform.c
@@ -46,11 +46,7 @@ static struct resource mv64x60_eth0_reso
 	},
 };
 
-static char eth0_mac_addr[ETH_ALEN];
-
 static struct mv643xx_eth_platform_data eth0_pd = {
-	.mac_addr	= eth0_mac_addr,
-
 	.tx_sram_addr	= MV_SRAM_BASE_ETH0,
 	.tx_sram_size	= MV_SRAM_TXRING_SIZE,
 	.tx_queue_size	= MV_SRAM_TXRING_SIZE / 16,
@@ -79,11 +75,7 @@ static struct resource mv64x60_eth1_reso
 	},
 };
 
-static char eth1_mac_addr[ETH_ALEN];
-
 static struct mv643xx_eth_platform_data eth1_pd = {
-	.mac_addr	= eth1_mac_addr,
-
 	.tx_sram_addr	= MV_SRAM_BASE_ETH1,
 	.tx_sram_size	= MV_SRAM_TXRING_SIZE,
 	.tx_queue_size	= MV_SRAM_TXRING_SIZE / 16,
@@ -174,8 +166,8 @@ static int __init mv643xx_eth_add_pds(vo
 	int ret;
 
 	get_mac(mac);
-	eth_mac_add(eth0_mac_addr, mac, 0);
-	eth_mac_add(eth1_mac_addr, mac, 1);
+	eth_mac_add(eth0_pd.mac_addr, mac, 0);
+	eth_mac_add(eth1_pd.mac_addr, mac, 1);
 	ret = platform_add_devices(mv643xx_eth_pd_devs,
 			ARRAY_SIZE(mv643xx_eth_pd_devs));
 
