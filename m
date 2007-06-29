Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2007 14:35:34 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:34287 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023169AbXF2Nf1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Jun 2007 14:35:27 +0100
Received: from localhost (p7072-ipad34funabasi.chiba.ocn.ne.jp [124.85.64.72])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 064F9B789; Fri, 29 Jun 2007 22:34:07 +0900 (JST)
Date:	Fri, 29 Jun 2007 22:34:53 +0900 (JST)
Message-Id: <20070629.223453.106262827.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, sshtylyov@ru.mvista.com, mlachwani@mvista.com,
	jeff@garzik.org
Subject: [PATCH] tc35815: Load MAC address via platform_device
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

TX49XX SoCs include PCI NIC (TC35815 compatible) connected via its
internal PCI bus, but the NIC's PROM interface is not connected to
SEEPROM.  So we must provide its ethernet address by another way.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
A platform side of this patch is:
"[PATCH] rbtx4938: Fix secondary PCIC and glue internal NICs"

 drivers/net/tc35815.c |   50 ++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
index 463d600..75655ad 100644
--- a/drivers/net/tc35815.c
+++ b/drivers/net/tc35815.c
@@ -23,9 +23,9 @@
  */
 
 #ifdef TC35815_NAPI
-#define DRV_VERSION	"1.35-NAPI"
+#define DRV_VERSION	"1.36-NAPI"
 #else
-#define DRV_VERSION	"1.35"
+#define DRV_VERSION	"1.36"
 #endif
 static const char *version = "tc35815.c:v" DRV_VERSION "\n";
 #define MODNAME			"tc35815"
@@ -49,6 +49,7 @@ static const char *version = "tc35815.c:v" DRV_VERSION "\n";
 #include <linux/pci.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
+#include <linux/platform_device.h>
 #include <asm/io.h>
 #include <asm/byteorder.h>
 
@@ -597,13 +598,46 @@ static int tc_mdio_read(struct net_device *dev, int phy_id, int location);
 static void tc_mdio_write(struct net_device *dev, int phy_id, int location,
 			  int val);
 
-static void __devinit tc35815_init_dev_addr (struct net_device *dev)
+#ifdef CONFIG_CPU_TX49XX
+/*
+ * Find a platform_device providing a MAC address.  The platform code
+ * should provide a "tc35815-mac" device with a MAC address in its
+ * platform_data.
+ */
+static int __devinit tc35815_mac_match(struct device *dev, void *data)
+{
+	struct platform_device *plat_dev = to_platform_device(dev);
+	struct pci_dev *pci_dev = data;
+	unsigned int id = (pci_dev->bus->number << 8) | pci_dev->devfn;
+	return !strcmp(plat_dev->name, "tc35815-mac") && plat_dev->id == id;
+}
+
+static int __devinit tc35815_read_plat_dev_addr(struct net_device *dev)
+{
+	struct tc35815_local *lp = dev->priv;
+	struct device *pd = bus_find_device(&platform_bus_type, NULL,
+					    lp->pci_dev, tc35815_mac_match);
+	if (pd) {
+		if (pd->platform_data)
+			memcpy(dev->dev_addr, pd->platform_data, ETH_ALEN);
+		put_device(pd);
+		return is_valid_ether_addr(dev->dev_addr) ? 0 : -ENODEV;
+	}
+	return -ENODEV;
+}
+#else
+static int __devinit tc35815_read_plat_dev_addr(struct device *dev)
+{
+	return -ENODEV;
+}
+#endif
+
+static int __devinit tc35815_init_dev_addr (struct net_device *dev)
 {
 	struct tc35815_regs __iomem *tr =
 		(struct tc35815_regs __iomem *)dev->base_addr;
 	int i;
 
-	/* dev_addr will be overwritten on NETDEV_REGISTER event */
 	while (tc_readl(&tr->PROM_Ctl) & PROM_Busy)
 		;
 	for (i = 0; i < 6; i += 2) {
@@ -615,6 +649,9 @@ static void __devinit tc35815_init_dev_addr (struct net_device *dev)
 		dev->dev_addr[i] = data & 0xff;
 		dev->dev_addr[i+1] = data >> 8;
 	}
+	if (!is_valid_ether_addr(dev->dev_addr))
+		return tc35815_read_plat_dev_addr(dev);
+	return 0;
 }
 
 static int __devinit tc35815_init_one (struct pci_dev *pdev,
@@ -724,7 +761,10 @@ static int __devinit tc35815_init_one (struct pci_dev *pdev,
 	tc35815_chip_reset(dev);
 
 	/* Retrieve the ethernet address. */
-	tc35815_init_dev_addr(dev);
+	if (tc35815_init_dev_addr(dev)) {
+		dev_warn(&pdev->dev, "not valid ether addr\n");
+		random_ether_addr(dev->dev_addr);
+	}
 
 	rc = register_netdev (dev);
 	if (rc)
