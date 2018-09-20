Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 14:51:00 +0200 (CEST)
Received: from szxga05-in.huawei.com ([45.249.212.191]:2241 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994663AbeITMspaOQdp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Sep 2018 14:48:45 +0200
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0DD5578E09167;
        Thu, 20 Sep 2018 20:48:34 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Thu, 20 Sep 2018
 20:48:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <dmitry.tarnyagin@lockless.no>,
        <wg@grandegger.com>, <mkl@pengutronix.de>,
        <michal.simek@xilinx.com>, <hsweeten@visionengravers.com>,
        <madalin.bucur@nxp.com>, <pantelis.antoniou@gmail.com>,
        <claudiu.manoil@nxp.com>, <leoyang.li@nxp.com>,
        <linux@armlinux.org.uk>, <sammy@sammy.net>, <ralf@linux-mips.org>,
        <nico@fluxnic.net>, <steve.glendinning@shawell.net>,
        <f.fainelli@gmail.com>, <grygorii.strashko@ti.com>,
        <w-kwok2@ti.com>, <m-karicheri2@ti.com>, <t.sailer@alumni.ethz.ch>,
        <jreuter@yaina.de>, <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <wei.liu2@citrix.com>, <paul.durrant@citrix.com>,
        <arvid.brodin@alten.se>, <pshelar@ovn.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-mips@linux-mips.org>,
        <linux-omap@vger.kernel.org>, <linux-hams@vger.kernel.org>,
        <devel@linuxdriverproject.org>, <linux-usb@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <dev@openvswitch.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next 11/22] net: faraday: fix return type of ndo_start_xmit function
Date:   Thu, 20 Sep 2018 20:32:55 +0800
Message-ID: <20180920123306.14772-12-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Return-Path: <yuehaibing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuehaibing@huawei.com
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

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 4 ++--
 drivers/net/ethernet/faraday/ftmac100.c  | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index d8ead7e..4d67322 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -712,8 +712,8 @@ static bool ftgmac100_prep_tx_csum(struct sk_buff *skb, u32 *csum_vlan)
 	return skb_checksum_help(skb) == 0;
 }
 
-static int ftgmac100_hard_start_xmit(struct sk_buff *skb,
-				     struct net_device *netdev)
+static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
+					     struct net_device *netdev)
 {
 	struct ftgmac100 *priv = netdev_priv(netdev);
 	struct ftgmac100_txdes *txdes, *first;
diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
index a1197d3..570caeb 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -634,8 +634,8 @@ static void ftmac100_tx_complete(struct ftmac100 *priv)
 		;
 }
 
-static int ftmac100_xmit(struct ftmac100 *priv, struct sk_buff *skb,
-			 dma_addr_t map)
+static netdev_tx_t ftmac100_xmit(struct ftmac100 *priv, struct sk_buff *skb,
+				 dma_addr_t map)
 {
 	struct net_device *netdev = priv->netdev;
 	struct ftmac100_txdes *txdes;
@@ -1016,7 +1016,8 @@ static int ftmac100_stop(struct net_device *netdev)
 	return 0;
 }
 
-static int ftmac100_hard_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t
+ftmac100_hard_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct ftmac100 *priv = netdev_priv(netdev);
 	dma_addr_t map;
-- 
1.8.3.1
