Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 18:09:08 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:42528 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025623AbZFARIY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 18:08:24 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 42DFE112408B; Mon,  1 Jun 2009 19:08:15 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH] bcm63xx: use napi_complete instead of __napi_complete
Date:	Mon,  1 Jun 2009 19:08:08 +0200
Message-Id: <1243876095-8987-3-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1243876095-8987-1-git-send-email-mbizon@freebox.fr>
References: <1243876095-8987-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

We're not disabling IRQ, so we must call the irq safe flavour of
napi_complete.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/net/bcm63xx_enet.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/bcm63xx_enet.c b/drivers/net/bcm63xx_enet.c
index a91f909..20e08ef 100644
--- a/drivers/net/bcm63xx_enet.c
+++ b/drivers/net/bcm63xx_enet.c
@@ -450,7 +450,7 @@ static int bcm_enet_poll(struct napi_struct *napi, int budget)
 
 	/* no more packet in rx/tx queue, remove device from poll
 	 * queue */
-	__napi_complete(napi);
+	napi_complete(napi);
 
 	/* restore rx/tx interrupt */
 	enet_dma_writel(priv, ENETDMA_IR_PKTDONE_MASK,
-- 
1.6.0.4
