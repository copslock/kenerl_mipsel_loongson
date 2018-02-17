Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 21:18:49 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:43455 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994661AbeBQUOcgYE2G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 21:14:32 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 17 Feb 2018 20:14:28 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Sat, 17 Feb 2018
 12:09:39 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     <netdev@vger.kernel.org>
CC:     Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH v5 09/14] net: pch_gbe: Use pch_gbe_disable_dma_rx() in pch_gbe_configure_rx()
Date:   Sat, 17 Feb 2018 12:10:32 -0800
Message-ID: <20180217201037.3006-10-paul.burton@mips.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180217201037.3006-1-paul.burton@mips.com>
References: <20180217201037.3006-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1518898460-452059-7117-95682-6
X-BESS-VER: 2018.2.1-r1802152107
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190134
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

The pch_gbe_configure_rx() function open-codes the equivalent of
pch_gbe_disable_dma_rx(). Remove the duplication by moving
pch_gbe_disable_dma_rx(), and pch_gbe_enable_dma_rx() for consistency,
to be defined earlier than pch_gbe_configure_rx() and have
pch_gbe_configure_rx() call pch_gbe_disable_dma_rx() rather than
duplicate its functionality.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org

---

Changes in v5:
- New patch.

Changes in v4: None
Changes in v3: None
Changes in v2: None

 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   | 48 ++++++++++------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 2d6980603ee4..b6cc4a34ed89 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -831,6 +831,26 @@ static void pch_gbe_irq_enable(struct pch_gbe_adapter *adapter)
 		   ioread32(&hw->reg->INT_EN));
 }
 
+static void pch_gbe_disable_dma_rx(struct pch_gbe_hw *hw)
+{
+	u32 rxdma;
+
+	/* Disable Receive DMA */
+	rxdma = ioread32(&hw->reg->DMA_CTRL);
+	rxdma &= ~PCH_GBE_RX_DMA_EN;
+	iowrite32(rxdma, &hw->reg->DMA_CTRL);
+}
+
+static void pch_gbe_enable_dma_rx(struct pch_gbe_hw *hw)
+{
+	u32 rxdma;
+
+	/* Enables Receive DMA */
+	rxdma = ioread32(&hw->reg->DMA_CTRL);
+	rxdma |= PCH_GBE_RX_DMA_EN;
+	iowrite32(rxdma, &hw->reg->DMA_CTRL);
+}
+
 /**
  * pch_gbe_configure_tx - Configure Transmit Unit after Reset
  * @adapter:  Board private structure
@@ -876,7 +896,7 @@ static void pch_gbe_configure_tx(struct pch_gbe_adapter *adapter)
 static void pch_gbe_configure_rx(struct pch_gbe_adapter *adapter)
 {
 	struct pch_gbe_hw *hw = &adapter->hw;
-	u32 rdba, rdlen, rxdma, rx_mode, tcpip;
+	u32 rdba, rdlen, rx_mode, tcpip;
 
 	rx_mode = PCH_GBE_ADD_FIL_EN |
 		  PCH_GBE_MLT_FIL_EN |
@@ -897,11 +917,7 @@ static void pch_gbe_configure_rx(struct pch_gbe_adapter *adapter)
 	pch_gbe_mac_force_mac_fc(hw);
 
 	pch_gbe_disable_mac_rx(hw);
-
-	/* Disables Receive DMA */
-	rxdma = ioread32(&hw->reg->DMA_CTRL);
-	rxdma &= ~PCH_GBE_RX_DMA_EN;
-	iowrite32(rxdma, &hw->reg->DMA_CTRL);
+	pch_gbe_disable_dma_rx(hw);
 
 	netdev_dbg(adapter->netdev,
 		   "MAC_RX_EN reg = 0x%08x  DMA_CTRL reg = 0x%08x\n",
@@ -1290,26 +1306,6 @@ void pch_gbe_update_stats(struct pch_gbe_adapter *adapter)
 	spin_unlock_irqrestore(&adapter->stats_lock, flags);
 }
 
-static void pch_gbe_disable_dma_rx(struct pch_gbe_hw *hw)
-{
-	u32 rxdma;
-
-	/* Disable Receive DMA */
-	rxdma = ioread32(&hw->reg->DMA_CTRL);
-	rxdma &= ~PCH_GBE_RX_DMA_EN;
-	iowrite32(rxdma, &hw->reg->DMA_CTRL);
-}
-
-static void pch_gbe_enable_dma_rx(struct pch_gbe_hw *hw)
-{
-	u32 rxdma;
-
-	/* Enables Receive DMA */
-	rxdma = ioread32(&hw->reg->DMA_CTRL);
-	rxdma |= PCH_GBE_RX_DMA_EN;
-	iowrite32(rxdma, &hw->reg->DMA_CTRL);
-}
-
 /**
  * pch_gbe_intr - Interrupt Handler
  * @irq:   Interrupt number
-- 
2.16.1
