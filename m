Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 21:17:50 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:59028 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994658AbeBQUOYoenpG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 21:14:24 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 17 Feb 2018 20:14:20 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Sat, 17 Feb 2018
 12:09:38 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     <netdev@vger.kernel.org>
CC:     Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH v5 08/14] net: pch_gbe: Fold pch_gbe_setup_[rt]ctl into pch_gbe_configure_[rt]x
Date:   Sat, 17 Feb 2018 12:10:31 -0800
Message-ID: <20180217201037.3006-9-paul.burton@mips.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180217201037.3006-1-paul.burton@mips.com>
References: <20180217201037.3006-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1518898460-452059-7117-95682-1
X-BESS-VER: 2018.2.1-r1802152107
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190134
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62592
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

The pch_gbe driver splits configuration of the receive path between
pch_gbe_setup_rctl() & pch_gbe_configure_rx(), which are always called
together and in that order. The split between the two functions seems
somewhat arbitrary, as both are configuring registers for the receive
path. Fold pch_gbe_setup_rctl() into pch_gbe_configure_rx() such that
callers only need to call one function to configure the receive path
registers.

Similarly configuration of transmit path registers is split between
pch_gbe_setup_tctl() & pch_gbe_configure_tx(), and we fold the former
into the latter in the same way.

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

 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   | 52 ++++++----------------
 1 file changed, 13 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 60e91c0fc98b..2d6980603ee4 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -831,39 +831,26 @@ static void pch_gbe_irq_enable(struct pch_gbe_adapter *adapter)
 		   ioread32(&hw->reg->INT_EN));
 }
 
-
-
 /**
- * pch_gbe_setup_tctl - configure the Transmit control registers
+ * pch_gbe_configure_tx - Configure Transmit Unit after Reset
  * @adapter:  Board private structure
  */
-static void pch_gbe_setup_tctl(struct pch_gbe_adapter *adapter)
+static void pch_gbe_configure_tx(struct pch_gbe_adapter *adapter)
 {
 	struct pch_gbe_hw *hw = &adapter->hw;
-	u32 tx_mode, tcpip;
+	u32 tdba, tdlen, dctrl, tx_mode, tcpip;
 
 	tx_mode = PCH_GBE_TM_LONG_PKT |
 		PCH_GBE_TM_ST_AND_FD |
 		PCH_GBE_TM_SHORT_PKT |
 		PCH_GBE_TM_TH_TX_STRT_8 |
-		PCH_GBE_TM_TH_ALM_EMP_4 | PCH_GBE_TM_TH_ALM_FULL_8;
-
+		PCH_GBE_TM_TH_ALM_EMP_4 |
+		PCH_GBE_TM_TH_ALM_FULL_8;
 	iowrite32(tx_mode, &hw->reg->TX_MODE);
 
 	tcpip = ioread32(&hw->reg->TCPIP_ACC);
 	tcpip |= PCH_GBE_TX_TCPIPACC_EN;
 	iowrite32(tcpip, &hw->reg->TCPIP_ACC);
-	return;
-}
-
-/**
- * pch_gbe_configure_tx - Configure Transmit Unit after Reset
- * @adapter:  Board private structure
- */
-static void pch_gbe_configure_tx(struct pch_gbe_adapter *adapter)
-{
-	struct pch_gbe_hw *hw = &adapter->hw;
-	u32 tdba, tdlen, dctrl;
 
 	netdev_dbg(adapter->netdev, "dma addr = 0x%08llx  size = 0x%08x\n",
 		   (unsigned long long)adapter->tx_ring->dma,
@@ -883,35 +870,25 @@ static void pch_gbe_configure_tx(struct pch_gbe_adapter *adapter)
 }
 
 /**
- * pch_gbe_setup_rctl - Configure the receive control registers
+ * pch_gbe_configure_rx - Configure Receive Unit after Reset
  * @adapter:  Board private structure
  */
-static void pch_gbe_setup_rctl(struct pch_gbe_adapter *adapter)
+static void pch_gbe_configure_rx(struct pch_gbe_adapter *adapter)
 {
 	struct pch_gbe_hw *hw = &adapter->hw;
-	u32 rx_mode, tcpip;
-
-	rx_mode = PCH_GBE_ADD_FIL_EN | PCH_GBE_MLT_FIL_EN |
-	PCH_GBE_RH_ALM_EMP_4 | PCH_GBE_RH_ALM_FULL_4 | PCH_GBE_RH_RD_TRG_8;
+	u32 rdba, rdlen, rxdma, rx_mode, tcpip;
 
+	rx_mode = PCH_GBE_ADD_FIL_EN |
+		  PCH_GBE_MLT_FIL_EN |
+		  PCH_GBE_RH_ALM_EMP_4 |
+		  PCH_GBE_RH_ALM_FULL_4 |
+		  PCH_GBE_RH_RD_TRG_8;
 	iowrite32(rx_mode, &hw->reg->RX_MODE);
 
 	tcpip = ioread32(&hw->reg->TCPIP_ACC);
-
 	tcpip |= PCH_GBE_RX_TCPIPACC_OFF;
 	tcpip &= ~PCH_GBE_RX_TCPIPACC_EN;
 	iowrite32(tcpip, &hw->reg->TCPIP_ACC);
-	return;
-}
-
-/**
- * pch_gbe_configure_rx - Configure Receive Unit after Reset
- * @adapter:  Board private structure
- */
-static void pch_gbe_configure_rx(struct pch_gbe_adapter *adapter)
-{
-	struct pch_gbe_hw *hw = &adapter->hw;
-	u32 rdba, rdlen, rxdma;
 
 	netdev_dbg(adapter->netdev, "dma adr = 0x%08llx  size = 0x%08x\n",
 		   (unsigned long long)adapter->rx_ring->dma,
@@ -1954,9 +1931,7 @@ int pch_gbe_up(struct pch_gbe_adapter *adapter)
 	/* hardware has been reset, we need to reload some things */
 	pch_gbe_set_multi(netdev);
 
-	pch_gbe_setup_tctl(adapter);
 	pch_gbe_configure_tx(adapter);
-	pch_gbe_setup_rctl(adapter);
 	pch_gbe_configure_rx(adapter);
 
 	err = pch_gbe_request_irq(adapter);
@@ -2486,7 +2461,6 @@ static int __pch_gbe_suspend(struct pci_dev *pdev)
 		pch_gbe_down(adapter);
 	if (wufc) {
 		pch_gbe_set_multi(netdev);
-		pch_gbe_setup_rctl(adapter);
 		pch_gbe_configure_rx(adapter);
 		pch_gbe_set_rgmii_ctrl(adapter, hw->mac.link_speed,
 					hw->mac.link_duplex);
-- 
2.16.1
