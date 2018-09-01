Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Sep 2018 13:46:45 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:38012 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992747AbeIALqVcIlId (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 1 Sep 2018 13:46:21 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 8C4C742744;
        Sat,  1 Sep 2018 13:46:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 3QHk4kPrWLK0; Sat,  1 Sep 2018 13:46:13 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 net-next 2/7] MIPS: lantiq: Do not enable IRQs in dma open
Date:   Sat,  1 Sep 2018 13:45:30 +0200
Message-Id: <20180901114535.9070-3-hauke@hauke-m.de>
In-Reply-To: <20180901114535.9070-1-hauke@hauke-m.de>
References: <20180901114535.9070-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65836
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

When a DMA channel is opened the IRQ should not get activated
automatically, this allows it to pull data out manually without the help
of interrupts. This is needed for a workaround in the vrx200 Ethernet
driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Paul Burton <paul.burton@mips.com>
---
 arch/mips/lantiq/xway/dma.c        | 1 -
 drivers/net/ethernet/lantiq_etop.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
index 664f2f7f55c1..982859f2b2a3 100644
--- a/arch/mips/lantiq/xway/dma.c
+++ b/arch/mips/lantiq/xway/dma.c
@@ -106,7 +106,6 @@ ltq_dma_open(struct ltq_dma_channel *ch)
 	spin_lock_irqsave(&ltq_dma_lock, flag);
 	ltq_dma_w32(ch->nr, LTQ_DMA_CS);
 	ltq_dma_w32_mask(0, DMA_CHAN_ON, LTQ_DMA_CCTRL);
-	ltq_dma_w32_mask(0, 1 << ch->nr, LTQ_DMA_IRNEN);
 	spin_unlock_irqrestore(&ltq_dma_lock, flag);
 }
 EXPORT_SYMBOL_GPL(ltq_dma_open);
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index e08301d833e2..379db19a303c 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -439,6 +439,7 @@ ltq_etop_open(struct net_device *dev)
 		if (!IS_TX(i) && (!IS_RX(i)))
 			continue;
 		ltq_dma_open(&ch->dma);
+		ltq_dma_enable_irq(&ch->dma);
 		napi_enable(&ch->napi);
 	}
 	phy_start(dev->phydev);
-- 
2.11.0
