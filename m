Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 00:53:40 +0200 (CEST)
Received: from mout.gmx.net ([212.227.17.22]:64642 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835046Ab3EUWxi4N460 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 May 2013 00:53:38 +0200
Received: from mailout-de.gmx.net ([10.1.76.10]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MQbrP-1V3qGO2Bgb-00U1ol for
 <linux-mips@linux-mips.org>; Wed, 22 May 2013 00:53:33 +0200
Received: (qmail invoked by alias); 21 May 2013 22:53:33 -0000
Received: from dslb-084-056-038-041.pools.arcor-ip.net (EHLO localhost.localdomain) [84.56.38.41]
  by mail.gmx.net (mp010) with SMTP; 22 May 2013 00:53:33 +0200
X-Authenticated: #12255092
X-Provags-ID: V01U2FsdGVkX19LCMdicJ1L7POR8x1rlIsb+qTxaW6FvGvyl4Zwy/
        Zix4lujvmsvIVz
From:   Peter Huewe <peterhuewe@gmx.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org (open list:IOC3 ETHERNET DRIVER),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 12/19] net/ethernet/sgi/ioc3-eth: Use module_pci_driver to register driver
Date:   Wed, 22 May 2013 00:58:07 +0200
Message-Id: <1369177096-19674-12-git-send-email-peterhuewe@gmx.de>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1369176146-19383-1-git-send-email-peterhuewe@gmx.de>
References: <1369176146-19383-1-git-send-email-peterhuewe@gmx.de>
X-Y-GMX-Trusted: 0
Return-Path: <peterhuewe@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterhuewe@gmx.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Removing some boilerplate by using module_pci_driver instead of calling
register and unregister in the otherwise empty init/exit functions.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 7ed08c3..ffa7843 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -1398,16 +1398,6 @@ static struct pci_driver ioc3_driver = {
 	.remove		= ioc3_remove_one,
 };
 
-static int __init ioc3_init_module(void)
-{
-	return pci_register_driver(&ioc3_driver);
-}
-
-static void __exit ioc3_cleanup_module(void)
-{
-	pci_unregister_driver(&ioc3_driver);
-}
-
 static int ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	unsigned long data;
@@ -1677,9 +1667,7 @@ static void ioc3_set_multicast_list(struct net_device *dev)
 	netif_wake_queue(dev);			/* Let us get going again. */
 }
 
+module_pci_driver(ioc3_driver);
 MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
 MODULE_DESCRIPTION("SGI IOC3 Ethernet driver");
 MODULE_LICENSE("GPL");
-
-module_init(ioc3_init_module);
-module_exit(ioc3_cleanup_module);
-- 
1.8.1.5
