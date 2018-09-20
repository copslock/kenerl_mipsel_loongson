Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 14:49:32 +0200 (CEST)
Received: from szxga04-in.huawei.com ([45.249.212.190]:2182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994651AbeITMs2TE6Op (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Sep 2018 14:48:28 +0200
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1621C7A851765;
        Thu, 20 Sep 2018 20:48:20 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Thu, 20 Sep 2018
 20:48:11 +0800
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
Subject: [PATCH net-next 06/22] net: wiznet: fix return type of ndo_start_xmit function
Date:   Thu, 20 Sep 2018 20:32:50 +0800
Message-ID: <20180920123306.14772-7-yuehaibing@huawei.com>
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
X-archive-position: 66436
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
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/wiznet/w5100.c | 2 +-
 drivers/net/ethernet/wiznet/w5300.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index 2bdfb39..d8ba512 100644
--- a/drivers/net/ethernet/wiznet/w5100.c
+++ b/drivers/net/ethernet/wiznet/w5100.c
@@ -835,7 +835,7 @@ static void w5100_tx_work(struct work_struct *work)
 	w5100_tx_skb(priv->ndev, skb);
 }
 
-static int w5100_start_tx(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t w5100_start_tx(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct w5100_priv *priv = netdev_priv(ndev);
 
diff --git a/drivers/net/ethernet/wiznet/w5300.c b/drivers/net/ethernet/wiznet/w5300.c
index 56ae573..80fdbff 100644
--- a/drivers/net/ethernet/wiznet/w5300.c
+++ b/drivers/net/ethernet/wiznet/w5300.c
@@ -365,7 +365,7 @@ static void w5300_tx_timeout(struct net_device *ndev)
 	netif_wake_queue(ndev);
 }
 
-static int w5300_start_tx(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t w5300_start_tx(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct w5300_priv *priv = netdev_priv(ndev);
 
-- 
1.8.3.1
