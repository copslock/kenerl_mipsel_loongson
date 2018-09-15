Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 14:09:40 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:58554 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992153AbeIOMJR2rUk2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 15 Sep 2018 14:09:17 +0200
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id C678341A35;
        Sat, 15 Sep 2018 14:09:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id UzqPRY1IUBEa; Sat, 15 Sep 2018 14:09:10 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH net-next 3/5] net: lantiq: lantiq_xrx200: Move clock prepare to probe function
Date:   Sat, 15 Sep 2018 14:08:47 +0200
Message-Id: <20180915120849.24630-4-hauke@hauke-m.de>
In-Reply-To: <20180915120849.24630-1-hauke@hauke-m.de>
References: <20180915120849.24630-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

The switch and the MAC are in one IP core and they use the same clock
signal from the clock generation unit.
Currently the clock architecture in the lantiq SoC code does not allow
to easily share the same clocks, this has to be fixed by switching to
the common clock framework.
As a workaround the clock of the switch and MAC should be activated when
the MAC gets probed and only disabled when the MAC gets removed. This
way it is ensured that the clock is always enabled when the switch or
MAC is used. The switch can not be used without the MAC.

This fixes a data bus error when rebooting the system and deactivating
the switch and mac and later accessing some registers in the cleanup
while the clocks are disabled.

Fixes: fe1a56420cf2 ("net: lantiq: Add Lantiq / Intel VRX200 Ethernet driver")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/net/ethernet/lantiq_xrx200.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_xrx200.c b/drivers/net/ethernet/lantiq_xrx200.c
index c8b6d908f0cc..14b20ce0dd43 100644
--- a/drivers/net/ethernet/lantiq_xrx200.c
+++ b/drivers/net/ethernet/lantiq_xrx200.c
@@ -115,12 +115,6 @@ static void xrx200_flush_dma(struct xrx200_chan *ch)
 static int xrx200_open(struct net_device *net_dev)
 {
 	struct xrx200_priv *priv = netdev_priv(net_dev);
-	int err;
-
-	/* enable clock gate */
-	err = clk_prepare_enable(priv->clk);
-	if (err)
-		return err;
 
 	napi_enable(&priv->chan_tx.napi);
 	ltq_dma_open(&priv->chan_tx.dma);
@@ -155,8 +149,6 @@ static int xrx200_close(struct net_device *net_dev)
 	napi_disable(&priv->chan_tx.napi);
 	ltq_dma_close(&priv->chan_tx.dma);
 
-	clk_disable_unprepare(priv->clk);
-
 	return 0;
 }
 
@@ -497,6 +489,11 @@ static int xrx200_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	/* enable clock gate */
+	err = clk_prepare_enable(priv->clk);
+	if (err)
+		goto err_uninit_dma;
+
 	/* set IPG to 12 */
 	xrx200_pmac_mask(priv, PMAC_RX_IPG_MASK, 0xb, PMAC_RX_IPG);
 
@@ -514,9 +511,12 @@ static int xrx200_probe(struct platform_device *pdev)
 
 	err = register_netdev(net_dev);
 	if (err)
-		goto err_uninit_dma;
+		goto err_unprepare_clk;
 	return err;
 
+err_unprepare_clk:
+	clk_disable_unprepare(priv->clk);
+
 err_uninit_dma:
 	xrx200_hw_cleanup(priv);
 
@@ -536,6 +536,9 @@ static int xrx200_remove(struct platform_device *pdev)
 	/* remove the actual device */
 	unregister_netdev(net_dev);
 
+	/* release the clock */
+	clk_disable_unprepare(priv->clk);
+
 	/* shut down hardware */
 	xrx200_hw_cleanup(priv);
 
-- 
2.11.0
