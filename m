Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jan 2008 22:49:14 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:21428 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20032773AbYAEWtE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 Jan 2008 22:49:04 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JBHp4-0004BX-00; Sat, 05 Jan 2008 23:48:58 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 78EDCC2EFB; Sat,  5 Jan 2008 23:48:42 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	netdev@vger.kernel.org, linux-mips@linux-mips.org
cc:	ralf@linux-mips.org, jgarzik@pobox.com
Subject: [PATCH] METH: fix MAC address handling
Message-Id: <20080105224842.78EDCC2EFB@solo.franken.de>
Date:	Sat,  5 Jan 2008 23:48:42 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

meth didn't set a valid mac address during probing, but later during
open. Newer kernel refuse to open device with 00:00:00:00:00:00 as
mac address -> dead ethernet. This patch sets the mac address in
the probe function and uses only the mac address from the netdevice
struct when setting up the hardware.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 drivers/net/meth.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/meth.c b/drivers/net/meth.c
index 0c89b02..cdaa8fc 100644
--- a/drivers/net/meth.c
+++ b/drivers/net/meth.c
@@ -95,11 +95,14 @@ static inline void load_eaddr(struct net_device *dev)
 {
 	int i;
 	DECLARE_MAC_BUF(mac);
+	u64 macaddr;
 
-	for (i = 0; i < 6; i++)
-		dev->dev_addr[i] = o2meth_eaddr[i];
 	DPRINTK("Loading MAC Address: %s\n", print_mac(mac, dev->dev_addr));
-	mace->eth.mac_addr = (*(unsigned long*)o2meth_eaddr) >> 16;
+	macaddr = 0;
+	for (i = 0; i < 6; i++)
+		macaddr |= dev->dev_addr[i] << ((5 - i) * 8);
+
+	mace->eth.mac_addr = macaddr;
 }
 
 /*
@@ -794,6 +797,7 @@ static int __init meth_probe(struct platform_device *pdev)
 #endif
 	dev->irq	     = MACE_ETHERNET_IRQ;
 	dev->base_addr	     = (unsigned long)&mace->eth;
+	memcpy(dev->dev_addr, o2meth_eaddr, 6);
 
 	priv = netdev_priv(dev);
 	spin_lock_init(&priv->meth_lock);
