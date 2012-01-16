Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2012 17:46:43 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:56230 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903629Ab2APQoZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Jan 2012 17:44:25 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 15/17] NET: MIPS: lantiq: return value of request_irq was not handled gracefully
Date:   Mon, 16 Jan 2012 17:43:43 +0100
Message-Id: <1326732224-21336-6-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1326732224-21336-1-git-send-email-blogic@openwrt.org>
References: <1326732224-21336-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The return values of request_irq() were not checked leading to the following
error message.

drivers/net/ethernet/lantiq_etop.c: In function 'ltq_etop_hw_init':
drivers/net/ethernet/lantiq_etop.c:368:15: warning: ignoring return value of 'request_irq', declared with attribute warn_unused_result
drivers/net/ethernet/lantiq_etop.c:377:15: warning: ignoring return value of 'request_irq', declared with attribute warn_unused_result

Signed-off-by: John Crispin <blogic@openwrt.org>
Acked-by: David S. Miller <davem@davemloft.net>
---
Changes in V2
* really handle all return codes and not just the last

 drivers/net/ethernet/lantiq_etop.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 643faf9..02fd7cf 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -312,6 +312,7 @@ ltq_etop_hw_init(struct net_device *dev)
 {
 	struct ltq_etop_priv *priv = netdev_priv(dev);
 	unsigned int mii_mode = priv->pldata->mii_mode;
+	int err = 0;
 	int i;
 
 	ltq_pmu_enable(PMU_PPE);
@@ -356,7 +357,7 @@ ltq_etop_hw_init(struct net_device *dev)
 
 	ltq_dma_init_port(DMA_PORT_ETOP);
 
-	for (i = 0; i < MAX_DMA_CHAN; i++) {
+	for (i = 0; i < MAX_DMA_CHAN && !err; i++) {
 		int irq = LTQ_DMA_ETOP + i;
 		struct ltq_etop_chan *ch = &priv->ch[i];
 
@@ -364,21 +365,25 @@ ltq_etop_hw_init(struct net_device *dev)
 
 		if (IS_TX(i)) {
 			ltq_dma_alloc_tx(&ch->dma);
-			request_irq(irq, ltq_etop_dma_irq, IRQF_DISABLED,
+			err = request_irq(irq, ltq_etop_dma_irq, 0,
 				"etop_tx", priv);
 		} else if (IS_RX(i)) {
 			ltq_dma_alloc_rx(&ch->dma);
 			for (ch->dma.desc = 0; ch->dma.desc < LTQ_DESC_NUM;
 					ch->dma.desc++)
-				if (ltq_etop_alloc_skb(ch))
-					return -ENOMEM;
+				if (ltq_etop_alloc_skb(ch)) {
+					err = -ENOMEM;
+					goto err_out;
+				}
 			ch->dma.desc = 0;
-			request_irq(irq, ltq_etop_dma_irq, IRQF_DISABLED,
+			err = request_irq(irq, ltq_etop_dma_irq, 0,
 				"etop_rx", priv);
 		}
-		ch->dma.irq = irq;
+		if (!err)
+			ch->dma.irq = irq;
 	}
-	return 0;
+err_out:
+	return err;
 }
 
 static void
-- 
1.7.7.1
