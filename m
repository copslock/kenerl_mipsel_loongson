Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 18:55:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58185 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992319AbcIAQvycBrS2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 18:51:54 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 367A0F5768BE2;
        Thu,  1 Sep 2016 17:51:35 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 17:51:38 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
CC:     <soren.brinkmann@xilinx.com>, <Zubair.Kakakhel@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <michal.simek@xilinx.com>, <netdev@vger.kernel.org>
Subject: [Patch v4 09/12] net: ethernet: xilinx: Generate random mac if none found
Date:   Thu, 1 Sep 2016 17:51:02 +0100
Message-ID: <1472748665-47774-10-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

At the moment, if the emaclite device doesn't find a mac address
from any source, it simply uses 0x0 with a warning printed.

Instead of using a 0x0 mac address, use a randomly generated one.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V3 -> V4
Curly braces after if check for correct styling

V2 -> V3
No change

V1 -> V2
New patch
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 3cee84a..efc8d2e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1131,11 +1131,13 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 	lp->rx_ping_pong = get_bool(ofdev, "xlnx,rx-ping-pong");
 	mac_address = of_get_mac_address(ofdev->dev.of_node);
 
-	if (mac_address)
+	if (mac_address) {
 		/* Set the MAC address. */
 		memcpy(ndev->dev_addr, mac_address, ETH_ALEN);
-	else
-		dev_warn(dev, "No MAC address found\n");
+	} else {
+		dev_warn(dev, "No MAC address found. Generating Random one\n");
+		eth_hw_addr_random(ndev);
+	}
 
 	/* Clear the Tx CSR's in case this is a restart */
 	__raw_writel(0, lp->base_addr + XEL_TSR_OFFSET);
-- 
1.9.1
