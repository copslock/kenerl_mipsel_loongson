Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 19:34:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50998 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993876AbdFERdoYZ1MR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2017 19:33:44 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 7C9D9F8567F66;
        Mon,  5 Jun 2017 18:33:33 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 5 Jun 2017 18:33:37
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <netdev@vger.kernel.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Eric Dumazet <edumazet@google.com>,
        Jarod Wilson <jarod@redhat.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v4 5/7] net: pch_gbe: Always reset PHY along with MAC
Date:   Mon, 5 Jun 2017 10:31:34 -0700
Message-ID: <20170605173136.10795-6-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170605173136.10795-1-paul.burton@imgtec.com>
References: <20170602234042.22782-1-paul.burton@imgtec.com>
 <20170605173136.10795-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jarod Wilson <jarod@redhat.com>
Cc: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index b9d8504eb09c..c8554d3adf1c 100644
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
2.13.0
