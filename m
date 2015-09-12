Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2015 18:08:18 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:52883 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008088AbbILQIQ4Tjnq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Sep 2015 18:08:16 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 6297E28C12F;
        Sat, 12 Sep 2015 18:06:39 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-016-160.088.073.pools.vodafone-ip.de [88.73.16.160])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 9E16328C11A;
        Sat, 12 Sep 2015 18:06:19 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-spi@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Mark Brown <broonie@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, florian@openwrt.org
Subject: [PATCH V2 1/6] spi/bcm63xx: remove unused rx_tail variable
Date:   Sat, 12 Sep 2015 18:06:58 +0200
Message-Id: <1442074023-29840-2-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
References: <1442074023-29840-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Fixes the following warning:
drivers/spi/spi-bcm63xx.c:125:5: warning: unused variable 'rx_tail' [-Wunused-variable]
  u8 rx_tail;
     ^

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 drivers/spi/spi-bcm63xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index e73e2b05..2b908db 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -122,7 +122,6 @@ static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *first,
 	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
 	u16 msg_ctl;
 	u16 cmd;
-	u8 rx_tail;
 	unsigned int i, timeout = 0, prepend_len = 0, len = 0;
 	struct spi_transfer *t = first;
 	bool do_rx = false;
-- 
2.1.4
