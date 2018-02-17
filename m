Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 21:16:35 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:50109 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994654AbeBQUOS5aaOG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 21:14:18 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 17 Feb 2018 20:14:13 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Sat, 17 Feb 2018
 12:09:35 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     <netdev@vger.kernel.org>
CC:     Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH v5 05/14] net: pch_gbe: Always reset PHY along with MAC
Date:   Sat, 17 Feb 2018 12:10:28 -0800
Message-ID: <20180217201037.3006-6-paul.burton@mips.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180217201037.3006-1-paul.burton@mips.com>
References: <20180217201037.3006-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1518898453-298553-13206-66004-1
X-BESS-VER: 2018.2-r1802152108
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
X-archive-position: 62589
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

On the MIPS Boston development board, the EG20T MAC does not report
receiving the RX clock from the (RGMII) RTL8211E PHY unless the PHY is
reset at the same time as the MAC. Since the pch_gbe driver resets the
MAC a number of times - twice during probe, and when taking down the
network interface - we need to reset the PHY at all the same times. Do
that from pch_gbe_mac_reset_hw which is used to reset the MAC in all
cases.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 11e8ced4a0f4..90e795d5cc1c 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -380,10 +380,13 @@ static void pch_gbe_mac_reset_hw(struct pch_gbe_hw *hw)
 {
 	/* Read the MAC address. and store to the private data */
 	pch_gbe_mac_read_mac_addr(hw);
+	pch_gbe_phy_set_reset(hw, 1);
 	iowrite32(PCH_GBE_ALL_RST, &hw->reg->RESET);
 #ifdef PCH_GBE_MAC_IFOP_RGMII
 	iowrite32(PCH_GBE_MODE_GMII_ETHER, &hw->reg->MODE);
 #endif
+	pch_gbe_phy_set_reset(hw, 0);
+	usleep_range(1250, 1500);
 	pch_gbe_wait_clr_bit(&hw->reg->RESET, PCH_GBE_ALL_RST);
 	/* Setup the receive addresses */
 	pch_gbe_mac_mar_set(hw, hw->mac.addr, 0);
-- 
2.16.1
