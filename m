Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2016 12:09:22 +0200 (CEST)
Received: from caladan.dune.hu ([78.24.191.180]:48264 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27035420AbcFHKJVJ8m2f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jun 2016 12:09:21 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 8D9B6B8009F;
        Wed,  8 Jun 2016 12:09:20 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-007-040.088.073.pools.vodafone-ip.de [88.73.7.40])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 46144B80063;
        Wed,  8 Jun 2016 12:09:11 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Florian Fainelli <florian@openwrt.org>,
        Simon Arlott <simon@fire.lp0.eu>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH] serial/bcm63xx_uart: use correct alias naming
Date:   Wed,  8 Jun 2016 12:08:43 +0200
Message-Id: <1465380523-7385-1-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.1.4
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53902
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

The bcm63xx_uart driver uses the of alias for determing its id. Recent
changes in dts files changed the expected 'uartX' to the recommended
'serialX', breaking serial output. Fix this by checking for a 'serialX'
alias as well.

Fixes: e3b992d028f8 ("MIPS: BMIPS: Improve BCM6328 device tree")
Fixes: 2d52ee82b475 ("MIPS: BMIPS: Improve BCM6368 device tree")
Fixes: 7537d273e2f3 ("MIPS: BMIPS: Add device tree example for BCM6358")
Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---

Based on 4.7-rc2, which is the current head of tty-next.

 drivers/tty/serial/bcm63xx_uart.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index c28e5c24..5108fab 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -813,8 +813,12 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int ret;
 
-	if (pdev->dev.of_node)
-		pdev->id = of_alias_get_id(pdev->dev.of_node, "uart");
+	if (pdev->dev.of_node) {
+		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
+
+		if (pdev->id < 0)
+			pdev->id = of_alias_get_id(pdev->dev.of_node, "uart");
+	}
 
 	if (pdev->id < 0 || pdev->id >= BCM63XX_NR_UARTS)
 		return -EINVAL;
-- 
2.1.4
